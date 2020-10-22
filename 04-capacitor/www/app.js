const getCard = (title, postedDate, image, brief) => {
    return `<ion-card>
        <img src="https://devfest2018.gdgnantes.com${image}" />
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
    data.forEach((post, i) => {
        $('#content').append(getCard(post.title, new Date(post.posted), post.image, post.brief))
    })
});

$('#takePhoto').click(() => {
    let option = {
        allowEditing: false,
        webUseInput: true,
        quality: 70,
        resultType: "uri",
        saveToGallery: false,
        source: "CAMERA",
        direction: "FRONT"
    }
    Capacitor.Plugins.Camera.getPhoto(option).then((done) => {
        console.log(done)
        presentModal({img: done.webPath});
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
<form>
    <img src="${modalElement.componentProps.img}" />
    <ion-input hidden value="${modalElement.componentProps.img}"></ion-input>
    <ion-item>
      <ion-input placeholder="Titre" required="true"></ion-input>
    </ion-item>
    <ion-item>
      <ion-label position="stacked">Description</ion-label>
      <ion-input></ion-input>
    </ion-item>
  <ion-button expand="block" type="submit">Enregistrer</ion-button>
</form>
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
