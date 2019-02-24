import * as functions from 'firebase-functions';

const Amadeus = require('amadeus');
var amadeus = new Amadeus({
    clientId: 'PbF84xvmAkGEGJbYOHoBj4lHAQzjeU5K',
    clientSecret: 'ZWRmCAivSVUGwgH4'
});

export const inspirationSearch = functions.https.onRequest((request, response) => {
    console.log(amadeus.referenceData.urls.checkinLinks.get({ airlineCode: 'IB' }));
    response.send("Hello from Firebase!");
});
