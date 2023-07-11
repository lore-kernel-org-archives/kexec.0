Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEFAC001B0
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBW/HC2bU1yyyBJTKiR10Tfd75ecE8TtkjGKOd3AD80=; b=DYMWZoNxH8NgZf1Hwo9LjkhHEs
	C4Blhf4qW4c/H1FYH8UqSJ8/eTBkiMuE9fLmwAenWrw8lzWrEWor8wGTQ6cgOMYkWB3nSIvep3JM9
	nXI645Weyq63BZz+QBaM5q//SKsU0q1UaJGDseT6taTlo0rN0umOAdfOzIfpngCJdDupfvppmopOy
	UgWmRQ6elpXWNIjT6K97zPa9DxrTPMxs6H7enXZCr1ggOvO+xF1F3iaPvqhxpmfTISAFsRYXYXwhV
	OqMdWCxAeWZ23LkYI6xdrZ7272pUyyOT4s86+dIM56n9jYJrqC5l0/Xr8x55CprmuH0+Hxd+7lXQy
	Q8boTdHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJItO-00FjYH-02;
	Tue, 11 Jul 2023 19:19:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJItK-00FjXe-1w
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 19:19:20 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BJGxnu006315;
	Tue, 11 Jul 2023 19:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oXg14WD/aQZ2LgZSpBtJvS+fxAZFY2YkYYU24ba+58c=;
 b=BtpYL68CASY9S7794WGK2UFqOCi9Gj1YCUbQkFismNy8eGHs2SkLL5pgJIzehRtQBoPA
 sibxoiLxa43Ro1wjQvucc9x24xRdo6V9cL3lp7/c6xQU7T8USoeSBio/OsgCH43cA7qL
 BQ3nL6UTY2z9AxohLXCBYGFiYhz5u/knBsmZoR4NhOKNrvaXgV9gzkIWcVr7TOgRQTq+
 xbf2rNtv3QdJZBikBD6EtQUq446olTukxdVbEjJXncTWPvBdu2xH3QRlByggv0ltCbOd
 zmwCuX1uUXoPP7VNYz0w49pRqAB3Y0lq3J0chLkxwpMufup7Df0o5SkRHrNcsZgFNYVN Bw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rscx18ep7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jul 2023 19:19:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEFhLu011267;
	Tue, 11 Jul 2023 19:19:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mgdq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jul 2023 19:19:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BJJ1Ei59769300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jul 2023 19:19:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D3335805F;
	Tue, 11 Jul 2023 19:19:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD7558051;
	Tue, 11 Jul 2023 19:19:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Jul 2023 19:19:00 +0000 (GMT)
Message-ID: <4ccfe980-3c71-fa06-59e4-56c85d798224@linux.ibm.com>
Date: Tue, 11 Jul 2023 15:19:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/10] kexec: implement functions to map and unmap segment
 to kimage
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
 <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
 <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wmAJvMX1CPk8iauTbt6u4lwrYTXMyusH
X-Proofpoint-ORIG-GUID: wmAJvMX1CPk8iauTbt6u4lwrYTXMyusH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=921 clxscore=1011 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110172
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_121918_991849_1DC11772 
X-CRM114-Status: GOOD (  26.37  )
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

CgpPbiA3LzExLzIzIDE0OjQxLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gQWRkaW5nIEVyaWMg
dG8gY2MuCj4gCj4gT24gNy83LzIzIDA1OjI4LCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pgo+Pgo+
PiBPbiA3LzMvMjMgMTc6NTcsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4+IEN1cnJlbnRseSwg
dGhlcmUncyBubyBtZWNoYW5pc20gdG8gbWFwIGFuZCB1bm1hcCBzZWdtZW50cyB0byB0aGUga2lt
YWdlCj4+PiBzdHJ1Y3R1cmUuwqAgVGhpcyBmdW5jdGlvbmFsaXR5IGlzIG5lZWRlZCB3aGVuIGRl
YWxpbmcgd2l0aCBtZW1vcnkgc2VnbWVudHMKPj4+IGluIHRoZSBjb250ZXh0IG9mIGEga2V4ZWMg
b3BlcmF0aW9uLgo+Pj4KPj4+IFRoZSBwYXRjaCBhZGRzIHR3byBuZXcgZnVuY3Rpb25zOiBraW1h
Z2VfbWFwX3NlZ21lbnQoKSBhbmQKPj4+IGtpbWFnZV91bm1hcF9zZWdtZW50KCkuCj4+Pgo+Pj4g
SW1wbGVtZW50IGtpbWFnZV9tYXBfc2VnbWVudCgpIHdoaWNoIHRha2VzIGEga2ltYWdlIHBvaW50
ZXIsIGFuIGFkZHJlc3MsCj4+PiBhbmQgYSBzaXplLsKgIEVuc3VyZXMgdGhhdCB0aGUgZW50aXJl
IHNlZ21lbnQgaXMgYmVpbmcgbWFwcGVkIGJ5IGNvbXBhcmluZwo+Pj4gdGhlIGdpdmVuIGFkZHJl
c3MgYW5kIHNpemUgdG8gZWFjaCBzZWdtZW50IGluIHRoZSBraW1hZ2UncyBzZWdtZW50IGFycmF5
Lgo+Pj4gQ29sbGVjdCB0aGUgc291cmNlIHBhZ2VzIHRoYXQgY29ycmVzcG9uZCB0byB0aGUgZ2l2
ZW4gYWRkcmVzcyByYW5nZSwKPj4+IGFsbG9jYXRlIGFuIGFycmF5IG9mIHBvaW50ZXJzIHRvIHRo
ZXNlIHBhZ2VzLCBhbmQgbWFwIHRoZW0gdG8gYSBjb250aWd1b3VzCj4+PiByYW5nZSBvZiB2aXJ0
dWFsIGFkZHJlc3Nlcy7CoCBJZiB0aGUgbWFwcGluZyBvcGVyYXRpb24gaXMgc3VjY2Vzc2Z1bCwg
dGhlCj4+PiBmdW5jdGlvbiByZXR1cm5zIHRoZSBzdGFydCBvZiB0aGlzIHJhbmdlLsKgIE90aGVy
d2lzZSwgaXQgZnJlZXMgdGhlIHBhZ2UKPj4+IHBvaW50ZXIgYXJyYXkgYW5kIHJldHVybnMgTlVM
TC4KPj4+Cj4+PiBJbXBsZW1lbnQga2ltYWdlX3VubWFwX3NlZ21lbnQoKSB0aGF0IHRha2VzIGEg
cG9pbnRlciB0byBhIHNlZ21lbnQgYnVmZmVyCj4+PiBhbmQgdW5tYXBzIGl0IHVzaW5nIHZ1bm1h
cCgpLgo+Pj4KPj4+IEZpbmFsbHksIG1vdmUgZm9yX2VhY2hfa2ltYWdlX2VudHJ5KCkgbWFjcm8g
dG8ga2V4ZWMuaC4KPj4+Cj4+PiBOb3RlOiBVc2Uga2ltYWdlX21hcF9zZWdtZW50KCkgYW5kIGtp
bWFnZV91bm1hcF9zZWdtZW50KCkgY2FyZWZ1bGx5IHRvCj4+PiBhdm9pZCBtZW1vcnkgbGVha3Mg
YW5kIGVuc3VyZSB0aGF0IGFsbCBtYXBwZWQgc2VnbWVudHMgYXJlIHByb3Blcmx5Cj4+PiB1bm1h
cHBlZCB3aGVuIHRoZXkncmUgbm8gbG9uZ2VyIG5lZWRlZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20+Cj4+Cj4+PiAr
Cj4+PiArwqDCoMKgIGkgPSAwOwo+Pj4gK8KgwqDCoCBmb3JfZWFjaF9raW1hZ2VfZW50cnkoaW1h
Z2UsIHB0ciwgZW50cnkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZW50cnkgJiBJTkRfREVT
VElOQVRJT04pCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXN0X3BhZ2VfYWRkciA9IGVu
dHJ5ICYgUEFHRV9NQVNLOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGVudHJ5ICYgSU5E
X1NPVVJDRSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRlc3RfcGFnZV9hZGRy
ID49IGFkZHIgJiYgZGVzdF9wYWdlX2FkZHIgPCBlYWRkcikgewo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcmNfcGFnZV9hZGRyID0gZW50cnkgJiBQQUdFX01BU0s7Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNyY19wYWdlc1tpKytdID0gcGh5c190b19w
YWdlKHNyY19wYWdlX2FkZHIpOwo+Pgo+PiBTaW5jZSBwaHlzX3RvX3BhZ2UgaXMgbm90IGRlZmlu
ZWQgb24gbWFueS9tb3N0IGFyY2hpdGVjdHVyZXMgSSBjaGFuZ2UgaXQgZm9yIHBwYzY0IGFuZCBo
YXZlIHN1Y2Nlc3NmdWxseSB1c2VkIHRoZSBmb2xsb3dpbmc6Cj4+Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjX3BhZ2Vz
W2krK10gPSB2aXJ0X3RvX3BhZ2UoX192YShzcmNfcGFnZV9hZGRyKSkKPj4KPj4KPj4gQWZ0ZXIg
c2V2ZXJhbCBrZXhlY3MgdGhlIGZvbGxvd2luZyBjaGVjayBzdGlsbCB3b3JrczoKPj4KPj4gIyBl
dm1jdGwgaW1hX21lYXN1cmVtZW50IC0taWdub3JlLXZpb2xhdGlvbnMgL3N5cy9rZXJuZWwvc2Vj
dXJpdHkvaW1hL2JpbmFyeV9ydW50aW1lX21lYXN1cmVtZW50cwo+PiBNYXRjaGVkIHBlciBUUE0g
YmFuayBjYWxjdWxhdGVkIGRpZ2VzdChzKS4KPj4KPj4KPj4gwqDCoCBTdGVmYW4KPiBUaGFuayB5
b3Ugc28gbXVjaCBTdGVmYW4gZm9yIHJldmlld2luZyB0aGlzIHNlcmllcywgYW5kIGNhdGNoaW5n
IHRoaXMKPiBpc3N1ZS7CoCBBcmUgeW91IHN1Z2dlc3RpbmcgSSBzaG91bGQgdXNlIHZpcnRfdG9f
cGFnZSBvbiBhbGwgYXJjaGl0ZWN0dXJlcwo+IHVuY29uZGl0aW9uYWxseSwgb3IgdXNlIGl0IG9u
bHkgd2hlbiBwaHlzX3RvX3BhZ2UgaXMgbm90IGF2YWlsYWJsZT8KCkkgd291bGQgdHJ5IHRvIHVz
ZWQgaXQgb24gYWxsIGFyY2hpdGVjdHVyZXMuCgogICAgU3RlZmFuCgo+IAo+IH5UdXNoYXIKPiAK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGtleGVj
IG1haWxpbmcgbGlzdAo+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
