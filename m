Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE51DC43219
	for <kexec@archiver.kernel.org>; Fri, 11 Nov 2022 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=crPhpK07Gbv8e3e+ArP0rWXC2sMFtgbibifIBViuTS4=; b=I16bG7HkhUkx4I
	Pig/tpoZL6lFUdgTQTsG3ONbkshMJUJ9SM6XJqm6070ky5tzVCPT/YXbmAav8IxxHK6p62T9rpdQv
	9l/jQjtBp5rSjaF1PEfR5I7PvulC8nHSvSXk7gGh0C3cWD3VoRMbVQ8Dy7flQfBb17IqITZ42CIJk
	eF0KoHp78a5iQWbhl97IDmIResGmdYpib3ZUeWC+dTSCy8IgL0YKwGCv9KmCQFgQexE3n8AykKYvg
	+HopHD197Q5iDRwwqyINe1NJAxwbDEEYPW5IxIRRgTpuvwSeu71t+OEagCoFM/Mo0aIEIe3iFK16m
	itSyjhBIgHEV6eo4iGGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otStQ-00FWuw-PF; Fri, 11 Nov 2022 12:12:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otStN-00FWrl-Jc
	for kexec@lists.infradead.org; Fri, 11 Nov 2022 12:12:19 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABBdDBb033785;
	Fri, 11 Nov 2022 12:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5fxO2XXG1q6EgEfIA4PG3xVu5GvIdI6fwOZa3jvSFnc=;
 b=IU4iKNhqdmpAUJR059GJX0JdkNrQXK2Kb3UEl7baBEkidDTL4ZhZpfZdKktEDaLZs0sn
 lwpnoEnaiT5uCOk/G8tdkUTI8RtMPP/1vwnal6+2XulE+dtXIOa0TGbPTLUHvQja4sIH
 GlJVuSXiBsTSCneO9E+iQsBTDb3Hi/WQKsUH6buf3kRIPsbsOHK3al1bqMVmKi01A2gi
 exuziGvcOpivWzcjA6/Kuu2hiftk8OlgvcNJn+vK8gnA+GfGNYwyMJ3fv1i7BgIEef5z
 yIvxTU7T2CLJBsc1NtnQAtPzIz/J+k6hBJ5ID9jgDhmboMvxaNop6TMG7fij7QYQRDtc JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksnd512nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Nov 2022 12:12:09 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ABBetEM038546;
	Fri, 11 Nov 2022 12:12:09 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksnd512mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Nov 2022 12:12:09 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ABC6afx009588;
	Fri, 11 Nov 2022 12:12:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma05wdc.us.ibm.com with ESMTP id 3kngpmje7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Nov 2022 12:12:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ABCC5t926935552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Nov 2022 12:12:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3B658061;
	Fri, 11 Nov 2022 12:12:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F65B58059;
	Fri, 11 Nov 2022 12:12:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Nov 2022 12:12:05 +0000 (GMT)
Message-ID: <569c30f7-5dda-4ce2-e2c9-ce4041a74c8e@linux.ibm.com>
Date: Fri, 11 Nov 2022 07:12:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, Baoquan He <bhe@redhat.com>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <20221111022143.xvpi3pfwwrw4qda2@Rk>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221111022143.xvpi3pfwwrw4qda2@Rk>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7XaGLry-dChDSYeNDXy6AbCJBpJEBkVY
X-Proofpoint-GUID: TFAPSigYsZEZ_FQvINgy1j1zHKOjnma1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221111_041217_906519_943F5C1B 
X-CRM114-Status: GOOD (  24.07  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8xMC8yMiAyMToyMSwgQ29pYnkgWHUgd3JvdGU6Cj4gSGkgTWljaGFlbCwKPiAKPiBD
b3VsZCB0aGUgUG93ZXJQQyB0cmVlIHRha2UgdGhpcyBwYXRjaCBzZXQgd2hpY2ggcmVzb2x2ZXMg
YQo+IFBvd2VyVk0vS1ZNLXNwZWNpZmljIGlzc3VlPwoKTWljaGFlbCBoYXMgKHNob3duIG1lKSBh
biBhbHRlcm5hdGl2ZSBhcHByb2FjaCB0aGF0IHByb3RlY3RzIHRoZSBhbHJlYWR5IGFsbG9jYXRl
ZCBtZW1vcnkgdG8gY2FycnkgaXQgYWNyb3NzIHRoZSBrZXhlYy4gVGhpcyBzZWVtcyBsaWtlIGEg
Z29vZCBhbmQgcG90ZW50aWFsbHkgYmV0dGVyIGFsdGVybmF0aXZlLCBhbHNvIGZyb20gdGhlIHBl
cnNwZWN0aXZlIG9mIHRoZSBjaGFuZ2VzIG5lZWQsIHdoaWNoIGlzIGEgbG90IGxlc3MgLCBhbmQg
aXQncyBhbHJlYWR5IHVzZWQgZm9yIG90aGVyIHN0dWZmIGFzIHdlbGwuCgogICAgU3RlZmFuCgo+
IAo+IE9uIFRodSwgU2VwIDAxLCAyMDIyIGF0IDA1OjQ2OjA2UE0gLTA0MDAsIFN0ZWZhbiBCZXJn
ZXIgd3JvdGU6Cj4+IFRoZSBvZi10cmVlIHN1YnN5c3RlbSBkb2VzIG5vdCBjdXJyZW50bHkgcHJl
c2VydmUgdGhlIElCTSB2VFBNIDEuMiBhbmQKPj4gdlRQTSAyLjAgbWVhc3VyZW1lbnQgbG9ncyBh
Y3Jvc3MgYSBrZXhlYyBvbiBQb3dlclZNIGFuZCBQb3dlcktWTS4gVGhpcwo+PiBzZXJpZXMgZml4
ZXMgdGhpcyBmb3IgdGhlIGtleGVjX2ZpbGVfbG9hZCgpIHN5c2NhbGwgdXNpbmcgdGhlIGZsYXR0
ZW5lZAo+PiBkZXZpY2UgdHJlZSAoZmR0KSB0byBjYXJyeSB0aGUgVFBNIG1lYXN1cmVtZW50IGxv
ZydzIGJ1ZmZlciBhY3Jvc3Mga2V4ZWMuCj4+Cj4+IMKgIFN0ZWZhbgo+Pgo+PiB2ODoKPj4gLSBB
ZGRlZCBKYXJra28ncywgQ29pYnkncywgYW5kIFJvYidzIHRhZ3MKPj4gLSBSZWJhc2Ugb24gdjYu
MC1yYzMgdGhhdCBhYnNvcmJlZCAyIGFscmVhZHkgdXBzdHJlYW1lZCBwYXRjaGVzCj4+Cj4+IHY3
Ogo+PiAtIEFkZGVkIE5hZ2Vzd2FyYSdzIFRlc3RlZC1ieSB0YWdzCj4+IC0gQWRkZWQgYmFjayBv
cmlnaW5hbCBjb21tZW50IHRvIGlubGluZSBmdW5jdGlvbiBhbmQgcmVtb3ZlZCBKYXJra28ncyBS
LWIgdGFnCj4+Cj4+IHY2Ogo+PiAtIEFkZCBfX2luaXQgdG8gZ2V0X2tleGVjX2J1ZmZlciBhcyBz
dWdnZXN0ZWQgYnkgSm9uYXRoYW4KPj4gLSBGaXhlZCBpc3N1ZSBkZXRlY3RlZCBieSBrZXJuZWwg
dGVzdCByb2JvdAo+Pgo+PiB2NToKPj4gLSBSZWJhc2VkIG9uIDEgbW9yZSBwYXRjaCB0aGF0IHdv
dWxkIG90aGVyd2lzZSBjcmVhdGUgbWVyZ2UgY29uZmxpY3RzCj4+Cj4+IHY0Ogo+PiAtIFJlYmFz
ZWQgb24gMiBwYXRjaGVzIHRoYXQgd291bGQgb3RoZXJ3aXNlIGNyZWF0ZSBtZXJnZSBjb25mbGlj
dHM7Cj4+IMKgIHBvc3RpbmcgdGhlc2UgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyB3aXRoIHNldmVy
YWwgdGFncyByZW1vdmVkIHNvCj4+IMKgIGtyb2JvdCBjYW4gdGVzdCB0aGUgc2VyaWVzIGFscmVh
ZHkKPj4gLSBDaGFuZ2VzIHRvIGluZGl2aWR1YWwgcGF0Y2hlcyBkb2N1bWVudGVkIGluIHBhdGNo
IGRlc2NyaXBpdG9ucwo+Pgo+PiB2MzoKPj4gLSBNb3ZlZCBUUE0gT3BlbiBGaXJtd2FyZSByZWxh
dGVkIGZ1bmN0aW9uIHRvIGRyaXZlcnMvY2hhci90cG0vZXZlbnRsb2cvdHBtX29mLmMKPj4KPj4g
djI6Cj4+IC0gcmVhcnJhbmdlZCBwYXRjaGVzCj4+IC0gZml4ZWQgY29tcGlsYXRpb24gaXNzdWVz
IGZvciB4ODYKPj4KPj4gUGFsbWVyIERhYmJlbHQgKDEpOgo+PiDCoGRyaXZlcnM6IG9mOiBrZXhl
YyBpbWE6IFN1cHBvcnQgMzItYml0IHBsYXRmb3Jtcwo+Pgo+PiBTdGVmYW4gQmVyZ2VyICgzKToK
Pj4gwqB0cG06IG9mOiBNYWtlIG9mLXRyZWUgc3BlY2lmaWMgZnVuY3Rpb24gY29tbW9ubHkgYXZh
aWxhYmxlCj4+IMKgb2Y6IGtleGVjOiBSZWZhY3RvciBJTUEgYnVmZmVyIHJlbGF0ZWQgZnVuY3Rp
b25zIHRvIG1ha2UgdGhlbSByZXVzYWJsZQo+PiDCoHRwbS9rZXhlYzogRHVwbGljYXRlIFRQTSBt
ZWFzdXJlbWVudCBsb2cgaW4gb2YtdHJlZSBmb3Iga2V4ZWMKPj4KPj4gZHJpdmVycy9jaGFyL3Rw
bS9ldmVudGxvZy9vZi5jIHzCoCAzMSArLS0KPj4gZHJpdmVycy9vZi9rZXhlYy5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMzM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+
PiBpbmNsdWRlL2xpbnV4L2tleGVjLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4+IGlu
Y2x1ZGUvbGludXgvb2YuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICstCj4+IGlu
Y2x1ZGUvbGludXgvdHBtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzNiArKysrCj4+IGtl
cm5lbC9rZXhlY19maWxlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKwo+PiA2IGZp
bGVzIGNoYW5nZWQsIDM0NiBpbnNlcnRpb25zKCspLCA3OCBkZWxldGlvbnMoLSkKPj4KPj4KPj4g
YmFzZS1jb21taXQ6IGI5MGNiMTA1MzE5MDM1M2NjMzBmMGZlZjBlZjFmMzc4Y2NjMDYzYzUKPj4g
LS0gCj4+IDIuMzUuMQo+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
