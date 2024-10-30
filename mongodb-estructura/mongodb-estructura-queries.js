use optica
// Exercici 1
// Genero colecció estàtica del detall dels productes. S'actualitza "manualment" però té l'avantatge que només s'executa el $lookup amb cada actualització.
db.clients.find(_id: "client-1");

// Exercici 2
// Genero una vista dinàmica que combina el detall de clients i proveidors.
// Cada cop que es consulta la vista, s'actualitza. Torna a fer els lookups necessaris.
const consulta = [
{
$lookup: {
from: "proveidors",
localField: "proveidors.id",
foreignField: "_id",
as: "detall_proveidors"
}
}
];
db.createView(
"DetallProveidors",
"ulleres",
consulta
)
db.DetallProveidors.find({_id: "ulleres-1"})
const consulta = [
{
$lookup: {
from: "clients",
localField: "compradors.id",
foreignField: "_id",
as: "detall_clients"
}
}
];
db.createView(
"DetallClients",
"ulleres",
consulta
)
db.DetallClients.find({"compradors.id": "client-1"});