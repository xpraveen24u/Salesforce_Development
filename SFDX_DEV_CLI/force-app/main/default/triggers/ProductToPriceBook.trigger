trigger ProductToPriceBook on Product2 (after insert,after update) //
{
    ProductToPriceBook_Handler.getmethod(trigger.new);
}