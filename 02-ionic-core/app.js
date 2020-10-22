
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

