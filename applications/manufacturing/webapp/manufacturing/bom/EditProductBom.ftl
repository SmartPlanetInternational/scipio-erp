<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<@script>
function lookupBom() {
    document.searchbom.productId.value=document.editProductAssocForm.productId.value;
    document.searchbom.productAssocTypeId.value=document.editProductAssocForm.productAssocTypeId.options[document.editProductAssocForm.productAssocTypeId.selectedIndex].value;
    document.searchbom.submit();
}
</@script>

<#assign sectionTitle>${uiLabelMap.PageTitleEditProductBom}<#if product??> ${(product.internalName)!}</#if>&nbsp;[${uiLabelMap.CommonId}&nbsp;${productId!}]</#assign>
<#macro menuContent menuArgs={}>
  <@menu args=menuArgs>
  <#if product?has_content>
    <@menuitem type="link" href=makeOfbizUrl("BomSimulation?productId=${productId}&amp;bomType=${productAssocTypeId}") text="${uiLabelMap.ManufacturingBomSimulation}" class="+${styles.action_nav!}" />
  </#if>
  </@menu>
</#macro>
<@section title=sectionTitle menuContent=menuContent>
    
  <form name="searchform" action="<@ofbizUrl>UpdateProductBom</@ofbizUrl>#topform" method="post">
    <input type="hidden" name="UPDATE_MODE" value=""/>

    <@row>
        <@cell columns=6>
            <a name="topform"></a>
            <@field type="generic" label="${uiLabelMap.ManufacturingBomType}">
                <select name="productAssocTypeId" size="1">
                <#if productAssocTypeId?has_content>
                    <#assign curAssocType = delegator.findOne("ProductAssocType", Static["org.ofbiz.base.util.UtilMisc"].toMap("productAssocTypeId", productAssocTypeId), false)>
                    <#if curAssocType??>
                        <option selected="selected" value="${(curAssocType.productAssocTypeId)!}">${(curAssocType.get("description",locale))!}</option>
                        <option value="${(curAssocType.productAssocTypeId)!}"></option>
                    </#if>
                </#if>
                <#list assocTypes as assocType>
                    <option value="${(assocType.productAssocTypeId)!}">${(assocType.get("description",locale))!}</option>
                </#list>
                </select>
            </@field>
        </@cell>
        <@cell columns=6>
            <@field type="generic" label="${uiLabelMap.ProductProductId}">
              <@htmlTemplate.lookupField value="${productId!}" formName="searchform" name="productId" id="productId" fieldFormName="LookupProduct"/>
            </@field>
            <@field type="generic">
                <span><a href="javascript:document.searchform.submit();" class="${styles.link_run_sys!} ${styles.action_find!}">${uiLabelMap.ManufacturingShowBOMAssocs}</a></span>
            </@field>
        </@cell>
    </@row>
    <@row>
        <@cell columns=6 offset=6>
            <@field type="generic" label="${uiLabelMap.ManufacturingCopyToProductId}">
                <@htmlTemplate.lookupField formName="searchform" name="copyToProductId" id="copyToProductId" fieldFormName="LookupProduct"/>
            </@field>
            <@field type="generic">
                <span><a href="javascript:document.searchform.UPDATE_MODE.value='COPY';document.searchform.submit();" class="${styles.link_run_sys!} ${styles.action_copy!}">${uiLabelMap.ManufacturingCopyBOMAssocs}</a></span>
            </@field>
        </@cell>
    </@row>
  </form>
  
    <hr />
    
  <@row>
    <@cell>
    <form action="<@ofbizUrl>UpdateProductBom</@ofbizUrl>" method="post" name="editProductAssocForm">
    <#if !(productAssoc??)>
        <input type="hidden" name="UPDATE_MODE" value="CREATE"/>
    <#else>
        <#assign curProductAssocType = productAssoc.getRelatedOne("ProductAssocType", true)>
        <input type="hidden" name="UPDATE_MODE" value="UPDATE"/>
        <input type="hidden" name="productId" value="${productId!}"/>
        <input type="hidden" name="productIdTo" value="${productIdTo!}"/>
        <input type="hidden" name="productAssocTypeId" value="${productAssocTypeId!}"/>
        <input type="hidden" name="fromDate" value="${fromDate!}"/>
    </#if>
    

    <#if !(productAssoc??)>
          <@field type="generic" label="${uiLabelMap.ManufacturingBomType}">
              <select name="productAssocTypeId" size="1">
                <#if productAssocTypeId?has_content>
                    <#assign curAssocType = delegator.findOne("ProductAssocType", Static["org.ofbiz.base.util.UtilMisc"].toMap("productAssocTypeId", productAssocTypeId), false)>
                    <#if curAssocType??>
                        <option selected="selected" value="${(curAssocType.productAssocTypeId)!}">${(curAssocType.get("description",locale))!}</option>
                        <option value="${(curAssocType.productAssocTypeId)!}"></option>
                    </#if>
                </#if>
                <#list assocTypes as assocType>
                    <option value="${(assocType.productAssocTypeId)!}">${(assocType.get("description",locale))!}</option>
                </#list>
                </select>
          </@field>
          <@field type="generic" label="${uiLabelMap.ProductProductId}">
              <@htmlTemplate.lookupField value="${productId!}" formName="editProductAssocForm" name="productId" id="productId2" fieldFormName="LookupProduct"/>
          </@field>
          <@field type="generic" label="${uiLabelMap.ManufacturingProductIdTo}">
              <@htmlTemplate.lookupField value="${productIdTo!}" formName="editProductAssocForm" name="productIdTo" id="productIdTo" fieldFormName="LookupProduct"/>
          </@field>
          <@field type="generic" label="${uiLabelMap.CommonFromDate}">
              <@htmlTemplate.renderDateTimeField name="fromDate" event="" action="" className=""  title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="" size="25" maxlength="50" id="fromDate_1" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                <span class="tooltip">(${uiLabelMap.ManufacturingWillBeSetToNow})</span>
          </@field>
    <#else>
          <@field type="generic" label="${uiLabelMap.ProductProductId}">
              ${productId!}
          </@field>
          <@field type="generic" label="${uiLabelMap.ManufacturingProductIdTo}">
              ${productIdTo!}
          </@field>
          <@field type="generic" label="${uiLabelMap.ManufacturingBomType}">
              <#if curProductAssocType??>${(curProductAssocType.get("description",locale))!}<#else> ${productAssocTypeId!}</#if>
          </@field>
          <@field type="generic" label="${uiLabelMap.CommonFromDate}">
              ${fromDate?date?string.short!}
          </@field>
    </#if>
    
    <@field type="generic" label="${uiLabelMap.CommonThruDate}">
            <#if useValues> 
              <#assign value= productAssoc.thruDate!>
            <#else>
              <#assign value= request.getParameter("thruDate")!>
            </#if>
            <@htmlTemplate.renderDateTimeField value="${value!''}" name="thruDate" className="" event="" action=""  title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="30" maxlength="30" id="fromDate_2" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
    </@field>
    <@field type="input" label="${uiLabelMap.CommonSequenceNum}" name="sequenceNum" value=useValues?string("${(productAssoc.sequenceNum)!}", "${(request.getParameter('sequenceNum'))!}") size="5" maxlength="10"/>
    <@field type="input" label="${uiLabelMap.ManufacturingReason}" name="reason" value=useValues?string("${(productAssoc.reason)!}", "${(request.getParameter('reason'))!}") size="60" maxlength="255"/>
    <@field type="input" label="${uiLabelMap.ManufacturingInstruction}" name="instruction" value=useValues?string("${(productAssoc.instruction)!}", "${(request.getParameter('instruction'))!}") size="60" maxlength="255"/>
    <@field type="input" label="${uiLabelMap.ManufacturingQuantity}" name="quantity" value=useValues?string("${(productAssoc.quantity)!}", "${(request.getParameter('quantity'))!}") size="10" maxlength="15"/>
    <@field type="input" label="${uiLabelMap.ManufacturingScrapFactor}" name="scrapFactor" value=useValues?string("${(productAssoc.scrapFactor)!}", "${(request.getParameter('scrapFactor'))!}") size="10" maxlength="15"/>
    <@field type="generic" label="${uiLabelMap.ManufacturingFormula}">
        <select name="estimateCalcMethod">
            <option value="">&nbsp;</option>
            <#assign selectedFormula = "">
            <#if useValues>
                <#assign selectedFormula = (productAssoc.estimateCalcMethod)!>
            <#else>
                <#assign selectedFormula = (request.getParameter("estimateCalcMethod"))!>
            </#if>
            <#list formulae as formula>
                <option value="${formula.customMethodId}" <#if selectedFormula = formula.customMethodId>selected="selected"</#if>>${formula.get("description",locale)!}</option>
            </#list>
        </select>
    </@field>
    <@field type="generic" label="${uiLabelMap.ManufacturingRoutingTask}">
          <#if useValues>
            <#assign value = productAssoc.routingWorkEffortId!>
          <#else>
            <#assign value = request.getParameter("routingWorkEffortId")!>
          </#if>
          <#if value?has_content>
            <@htmlTemplate.lookupField value="${value}" formName="editProductAssocForm" name="routingWorkEffortId" id="routingWorkEffortId" fieldFormName="LookupRoutingTask"/>
          <#else>
            <@htmlTemplate.lookupField formName="editProductAssocForm" name="routingWorkEffortId" id="routingWorkEffortId" fieldFormName="LookupRoutingTask"/>
          </#if>
    </@field>
    <#if !(productAssoc??)>
      <@field type="submit" text="${uiLabelMap.CommonAdd}" class="${styles.link_run_sys!} ${styles.action_add!}" />
    <#else>
      <@field type="submit" text="${uiLabelMap.CommonEdit}" class="${styles.link_run_sys!} ${styles.action_update!}" />
    </#if>
    </form>
    </@cell>
  </@row>
</@section>

<#if productId?? && product??>
  <@section title="${uiLabelMap.ManufacturingProductComponents}">
    <a name="components"></a>
    <@table type="data-list" autoAltRows=true cellspacing="0"> <#-- orig: class="basic-table" -->
     <@thead>
      <@tr class="header-row">
        <@th>${uiLabelMap.ProductProductId}</@th>
        <@th>${uiLabelMap.ProductProductName}</@th>
        <@th>${uiLabelMap.CommonFromDate}</@th>
        <@th>${uiLabelMap.CommonThruDate}</@th>
        <@th>${uiLabelMap.CommonSequenceNum}</@th>
        <@th>${uiLabelMap.CommonQuantity}</@th>
        <@th>${uiLabelMap.ManufacturingScrapFactor}</@th>
        <@th>${uiLabelMap.ManufacturingFormula}</@th>
        <@th>${uiLabelMap.ManufacturingRoutingTask}</@th>
        <@th>&nbsp;</@th>
        <@th>&nbsp;</@th>
      </@tr>
    </@thead>
    <#list assocFromProducts! as assocFromProduct>
    <#assign listToProduct = assocFromProduct.getRelatedOne("AssocProduct", true)>
    <#assign curProductAssocType = assocFromProduct.getRelatedOne("ProductAssocType", true)>
      <@tr>
        <@td><a href="<@ofbizUrl>EditProductBom?productId=${(assocFromProduct.productIdTo)!}&amp;productAssocTypeId=${(assocFromProduct.productAssocTypeId)!}#components</@ofbizUrl>" class="${styles.link_nav_info_id!}">${(assocFromProduct.productIdTo)!}</a></@td>
        <@td><#if listToProduct??><a href="<@ofbizUrl>EditProductBom?productId=${(assocFromProduct.productIdTo)!}&amp;productAssocTypeId=${(assocFromProduct.productAssocTypeId)!}#components</@ofbizUrl>" class="${styles.link_nav_info_name!}">${(listToProduct.internalName)!}</a></#if>&nbsp;</@td>
        <#assign class><#if (assocFromProduct.getTimestamp("fromDate"))?? && nowDate.before(assocFromProduct.getTimestamp("fromDate"))>alert-elem</#if></#assign>
        <@td class=class>
        ${(assocFromProduct.fromDate)!}&nbsp;</@td>
        <#assign class><#if (assocFromProduct.getTimestamp("thruDate"))?? && nowDate.after(assocFromProduct.getTimestamp("thruDate"))>alert-elem</#if></#assign>
        <@td class=class>
        ${(assocFromProduct.thruDate)!}&nbsp;</@td>
        <@td>&nbsp;${(assocFromProduct.sequenceNum)!}</@td>
        <@td>&nbsp;${(assocFromProduct.quantity)!}</@td>
        <@td>&nbsp;${(assocFromProduct.scrapFactor)!}</@td>
        <@td>&nbsp;${(assocFromProduct.estimateCalcMethod)!}</@td>
        <@td>&nbsp;${(assocFromProduct.routingWorkEffortId)!}</@td>
        <@td>
        <a href="<@ofbizUrl>UpdateProductBom?UPDATE_MODE=DELETE&amp;productId=${productId}&amp;productIdTo=${(assocFromProduct.productIdTo)!}&amp;productAssocTypeId=${(assocFromProduct.productAssocTypeId)!}&amp;fromDate=${(assocFromProduct.fromDate)!}&amp;useValues=true</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_remove!}">${uiLabelMap.CommonDelete}</a>
        </@td>
        <@td>
        <a href="<@ofbizUrl>EditProductBom?productId=${productId}&amp;productIdTo=${(assocFromProduct.productIdTo)!}&amp;productAssocTypeId=${(assocFromProduct.productAssocTypeId)!}&amp;fromDate=${(assocFromProduct.fromDate)!}&amp;useValues=true</@ofbizUrl>" class="${styles.link_nav!} ${styles.action_update!}">${uiLabelMap.CommonEdit}</a>
        </@td>
      </@tr>
    </#list>
    </@table>
  </@section>
  <@section title="${uiLabelMap.ManufacturingProductComponentOf}">
    <#if assocToProducts?has_content>
    <@table type="data-list" autoAltRows=true cellspacing="0"> <#-- orig: class="basic-table" -->
      <@thead>
        <@tr class="header-row">
            <@th>${uiLabelMap.ProductProductId}</@th>
            <@th>${uiLabelMap.ProductProductName}</@th>
            <@th>${uiLabelMap.CommonFromDate}</@th>
            <@th>${uiLabelMap.CommonThruDate}</@th>
            <@th>${uiLabelMap.CommonQuantity}</@th>
            <@th>&nbsp;</@th>
        </@tr>
      </@thead>
      <@tbody>
        <#list assocToProducts! as assocToProduct>
        <#assign listToProduct = assocToProduct.getRelatedOne("MainProduct", true)>
        <#assign curProductAssocType = assocToProduct.getRelatedOne("ProductAssocType", true)>
        <@tr>
            <@td><a href="<@ofbizUrl>EditProductBom?productId=${(assocToProduct.productId)!}&amp;productAssocTypeId=${(assocToProduct.productAssocTypeId)!}#components</@ofbizUrl>" class="${styles.link_nav_info_id!}">${(assocToProduct.productId)!}</a></@td>
<#--                <@td><#if listToProduct??><a href="<@ofbizUrl>EditProduct?productId=${(assocToProduct.productId)!}</@ofbizUrl>" class="${styles.link_nav_info_name!}">${(listToProduct.internalName)!}</a></#if></@td> -->
            <@td><#if listToProduct??><a href="<@ofbizUrl>EditProductBom?productId=${(assocToProduct.productId)!}&amp;productAssocTypeId=${(assocToProduct.productAssocTypeId)!}#components</@ofbizUrl>" class="${styles.link_nav_info_name!}">${(listToProduct.internalName)!}</a></#if></@td>
            <@td>${(assocToProduct.getTimestamp("fromDate"))!}&nbsp;</@td>
            <@td>${(assocToProduct.getTimestamp("thruDate"))!}&nbsp;</@td>
            <@td>${(assocToProduct.quantity)!}&nbsp;</@td>
            <@td>
                <a href="<@ofbizUrl>UpdateProductBom?UPDATE_MODE=DELETE&amp;productId=${(assocToProduct.productId)!}&amp;productIdTo=${(assocToProduct.productIdTo)!}&amp;productAssocTypeId=${(assocToProduct.productAssocTypeId)!}&amp;fromDate=${Static["org.ofbiz.base.util.UtilFormatOut"].encodeQueryValue(assocToProduct.getTimestamp("fromDate").toString())}&amp;useValues=true</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_remove!}">
                ${uiLabelMap.CommonDelete}</a>
            </@td>
        </@tr>
        </#list>
      </@tbody>
    </@table>
      <p>${uiLabelMap.CommonNote}: <b class="alert-elem">${uiLabelMap.CommonRed}</b> ${uiLabelMap.ManufacturingNote1} <b class="${styles.text_color_alert!}">${uiLabelMap.CommonRed}</b>${uiLabelMap.ManufacturingNote2} <b class="${styles.text_color_alert!}">${uiLabelMap.CommonRed}</b>${uiLabelMap.ManufacturingNote3}<p>
    <#else>
      <@commonMsg type="result">${uiLabelMap.CommonNoRecordFound}.</@commonMsg>
    </#if>
  </@section>
</#if>
