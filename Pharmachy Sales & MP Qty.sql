SELECT top 20 t.productvariantId [PVID], 
	          pv.Name [Product], 
	          Count(t.productvariantId) [MPQTY]

FROM thingtransaction tss
JOIN thingevent te ON tss.id = te.thingtransactionid
JOIN thing t ON t.id = te.thingid
JOIN productvariant pv on pv.id = t.productvariantid
join warehouse w on w.Id=te.WarehouseId

WHERE t.CostPrice is not null
AND fromstate IN (44,45)
AND tostate IN (65536,268435456)
and pv.DistributionNetworkId = 2

Group by t.productvariantId, 
	     pv.Name 

Order by 3 desc



--========================================--
--Sales Report
--========================================--

Select top 20 pv.id [PVID],
	       pv.name [Product],
	       Count(*) [Sale Quantity],
	       Sum(tr.SalePrice) [Amount]

from ProductVariant pv
join ThingRequest tr on tr.ProductVariantId=pv.id
join thing t on t.id=tr.AssignedThingId
join Shipment s on s.id=tr.ShipmentId

where s.ReconciledOn is not null
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 2

group by pv.id,
		 pv.name

order by 3 desc

