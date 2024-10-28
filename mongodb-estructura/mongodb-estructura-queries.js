use optica
// Exercici 1
// Genero colecció estàtica del detall dels productes. S'actualitza "manualment" però té l'avantatge que només s'executa el $lookup amb cada actualització.
db.clients.aggregate([
	{
		$lookup: {
			from: "ulleres",
			localField: "compres.id",
			foreignField: "_id",
			as: "detalls_productes"
		}
	},
	{$out: "VistaClientsProductes"}
])
db.VistaClientsProductes.find({}, {_id: 0, compres: 0, recomanat_per: 0, detalls_productes: {proveidors: 0, compradors: 0}})

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
},
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
"UlleresProveidorsClients",
"ulleres",
consulta
)
db.UlleresProveidorsClients.find({marca: "Rayban"}, {_id: 0, marca: 1, muntura: 1, proveidors: {nom: 1}, preu: 1, detall_clients: {nom: 1, telefon: 1, recomanat_per: 1, adreca: 1, data_registre: 1}, detall_proveidors: 1})