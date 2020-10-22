const getCard = (isDevFest, title, postedDate, image, brief) => {
    return `<ion-card>
        <img src="${isDevFest ? 'https://devfest2018.gdgnantes.com' + image : image}" />
        <ion-card-header>
          <ion-card-subtitle>${postedDate.toDateString()}</ion-card-subtitle>
          <ion-card-title>${title}</ion-card-title>
        </ion-card-header>
        <ion-card-content>
          ${brief}
        </ion-card-content>
      </ion-card>`;
}

$.get( "https://devfest-nantes-2018-api.cleverapps.io/blog", function( data ) {
    data.forEach((post) => {
        addPostOnTheWall(post, true);
    })
    getPosts((err, posts) => {
        if (err) return console.error(err)
        posts.forEach((post) => {
            addPostOnTheWall(post, false);
        })
    })
});

const addPostOnTheWall = (post, isDevFest) => {
    $('#content').prepend(getCard(isDevFest, post.title, new Date(post.posted), post.image, post.brief))
}

$('#takePhoto').click(() => {
    let option = {
        allowEditing: false,
        webUseInput: true,
        quality: 70,
        resultType: "dataUrl",
        saveToGallery: false,
        source: "CAMERA",
        direction: "FRONT"
    }
    Capacitor.Plugins.Camera.getPhoto(option).then((done) => {
        presentModal({img: done.dataUrl});
    }).catch((error) => {
        console.error(error)
    })
})


customElements.define('modal-page', class extends HTMLElement {
    connectedCallback() {
        const modalElement = document.querySelector('ion-modal');
        this.innerHTML = `
<ion-header>
  <ion-toolbar>
    <ion-title>Création d'un article privé</ion-title>
    <ion-buttons slot="primary">
      <ion-button onClick="dismissModal()">
        <ion-icon slot="icon-only" name="close"></ion-icon>
      </ion-button>
    </ion-buttons>
  </ion-toolbar>
</ion-header>
<ion-content class="ion-padding">
    <img src="${modalElement.componentProps.img}" />
    <ion-input name="img" hidden value="${modalElement.componentProps.img}"></ion-input>
    <ion-item>
      <ion-input name="title" placeholder="Titre" required="true"></ion-input>
    </ion-item>
    <ion-item>
      <ion-label position="stacked">Description</ion-label>
      <ion-input name="brief"></ion-input>
    </ion-item>
  <ion-button expand="block" onClick="store()">Enregistrer</ion-button>
</ion-content>`;
    }
});

function presentModal(props) {
    // create the modal with the `modal-page` component
    const modalElement = document.createElement('ion-modal');
    modalElement.component = 'modal-page';
    modalElement.cssClass = 'my-custom-class';

    modalElement.componentProps = props;

    // present the modal
    document.body.appendChild(modalElement);
    return modalElement.present();
}

async function dismissModal() {
    let modal = document.querySelector('ion-modal');
    await modal.dismiss({
        'dismissed': true
    });
}

function store() {
    const post = {
        title: document.querySelector('ion-input[name="title"]').value,
        brief: document.querySelector('ion-input[name="brief"]').value,
        image: document.querySelector('ion-input[name="img"]').value,
        posted: new Date().getTime()
    }
    getPosts((err, posts) => {
        if (err) {return console.error(err)}
        posts.push(post)
        Capacitor.Plugins.Storage.set({
            key: 'posts',
            value: JSON.stringify(posts)
        }).then((done) => {
            addPostOnTheWall(post, false);
            dismissModal();
        }).catch((err) => {
            console.error(err)
        })
    });
}

function getPosts(cbk) {
    return Capacitor.Plugins.Storage.get({key: 'posts'}).then(({value}) => {
        if (!value) value = JSON.stringify([]);
        return cbk(null,JSON.parse(value));
    }).catch(cbk);
}
