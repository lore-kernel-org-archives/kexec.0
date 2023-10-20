Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEDAC0032E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hu8oek3IJcUg+tQtM5mZZJ62455qIDSB6AZhZf191ec=; b=y9pri8u9MHISqu
	GLHlsTkiu9I5Vtdc8yoA0xMMPJozlLI5jy/uBdbvP9us9G8j9Vy77EW8cJopRwGYg3Tzzt1kPy8lp
	OlPGCBrYj+6cHIRY3ifEkcXZppK19niEEio5t5coz+YEgF8kEFPC5uYvrPdBgrPWStPwa9gTIOTIy
	mi98lvQ23iUu0sn2HxCraKnHdRMjdXXIORe0qU2zuotcZSV9IcEroh46E2RVcTZpWH8k0SXGzBcTl
	jFlxhxu0yRO05I+oGvgMiXhR0z0m8n6Ve2R9Xc28JSSFptJ7puB3sv829JzWM/sh4M7fXXNxmZJ5a
	LKjvGdmRMsdX5arjGryQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwyQ-0032nA-0P;
	Fri, 20 Oct 2023 21:24:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwyJ-0032dK-1U
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 21:24:00 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLEbwT015717;
	Fri, 20 Oct 2023 21:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CUokmqxKU3PfBeOPzyC3AKM7Mqq6SelGUPR1Cbl0Rmg=;
 b=qOQbfSHfYUHF5umyy21DCGrYc38aHtAEhCRukiE2Fh810nqRCfetAJh5OWnPYDdb5L4D
 E6QlncYtETn8GEIy8nYora/apjqtJAN1jIa9rY5Bt97/bmClQasSkszAg06jptNk4Clv
 DE/rvuLyEpJPeUARoNwr7GfiqfAe3e/RqdkCEPLTIT7Aiw+/XkTgQDOZBQ0MUzGqChc1
 40cHVpA5tFh3uXnYj625+/fc8rU7cA+uDWPQuQzBk/FnUnNnjupyXWXQcH71BxtoeYuH
 VqxhsBo1JyebUxBEBYK1jFyKQF7ePBR3yxXco8WCJV8TyEgnD836p3br2VQscvh2Fngh FA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tv19q8797-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 21:21:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KKFqST032119;
	Fri, 20 Oct 2023 21:16:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc35qd51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 21:16:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KLGoEV9896614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 21:16:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 134CA5804B;
	Fri, 20 Oct 2023 21:16:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC25458055;
	Fri, 20 Oct 2023 21:16:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Oct 2023 21:16:48 +0000 (GMT)
Message-ID: <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
Date: Fri, 20 Oct 2023 17:16:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
 <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qgBnFOqmL16kPZCF_vL_q8KHnykf5QUL
X-Proofpoint-GUID: qgBnFOqmL16kPZCF_vL_q8KHnykf5QUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=968 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_142355_640408_8BFDD7F5 
X-CRM114-Status: GOOD (  25.40  )
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

T24gMTAvMjAvMjMgMTY6MzksIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKCj4KPgo+IE9uIDEwLzEy
LzIzIDE3OjI3LCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pgo+PiBPbiAxMC81LzIzIDE0OjI2LCBU
dXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+PiBJTUEgY3VycmVudGx5IGFsbG9jYXRlcyBoYWxmIGEg
UEFHRV9TSVpFIGZvciB0aGUgZXh0cmEgZXZlbnRzIHRoYXQgCj4+PiB3b3VsZAo+Pj4gYmUgbWVh
c3VyZWQgYmV0d2VlbiBrZXhlYyAnbG9hZCcgYW5kICdleGVjdXRlJy7CoCBEZXBlbmRpbmcgb24g
dGhlIElNQQo+Pj4gcG9saWN5IGFuZCB0aGUgc3lzdGVtIHN0YXRlLCB0aGF0IG1lbW9yeSBtYXkg
bm90IGJlIHN1ZmZpY2llbnQgdG8gaG9sZAo+Pj4gdGhlIGV4dHJhIElNQSBldmVudHMgbWVhc3Vy
ZWQgYWZ0ZXIga2V4ZWMgJ2xvYWQnLsKgIFRoZSBtZW1vcnkKPj4+IHJlcXVpcmVtZW50cyB2YXJ5
IGZyb20gc3lzdGVtIHRvIHN5c3RlbSBhbmQgdGhleSBzaG91bGQgYmUgCj4+PiBjb25maWd1cmFi
bGUuCj4+Pgo+Pj4gRGVmaW5lIGEgS2NvbmZpZyBvcHRpb24sIElNQV9LRVhFQ19FWFRSQV9QQUdF
UywgdG8gY29uZmlndXJlIHRoZSBudW1iZXIKPj4+IG9mIGV4dHJhIHBhZ2VzIHRvIGJlIGFsbG9j
YXRlZCBmb3IgSU1BIG1lYXN1cmVtZW50cyBhZGRlZCBpbiB0aGUgd2luZG93Cj4+PiBmcm9tIGtl
eGVjICdsb2FkJyB0byBrZXhlYyAnZXhlY3V0ZScuCj4+Pgo+Pj4gVXBkYXRlIGltYV9hZGRfa2V4
ZWNfYnVmZmVyKCkgZnVuY3Rpb24gdG8gYWxsb2NhdGUgbWVtb3J5IGJhc2VkIG9uIHRoZQo+Pj4g
S2NvbmZpZyBvcHRpb24gdmFsdWUsIHJhdGhlciB0aGFuIHRoZSBjdXJyZW50bHkgaGFyZGNvZGVk
IG9uZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGk8dHVzaGFyc3VAbGlu
dXgubWljcm9zb2Z0LmNvbT4KPj4+IC0tLQo+Pj4gwqAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9L
Y29uZmlnwqDCoMKgwqAgfMKgIDkgKysrKysrKysrCj4+PiDCoCBzZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL2ltYV9rZXhlYy5jIHwgMTMgKysrKysrKystLS0tLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9z
ZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcgCj4+PiBiL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvS2NvbmZpZwo+Pj4gaW5kZXggNjBhNTExYzZiNTgzLi4xYjU1Y2QyYmNiMzYgMTAwNjQ0Cj4+
PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcKPj4+ICsrKyBiL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvS2NvbmZpZwo+Pj4gQEAgLTMzOCwzICszMzgsMTIgQEAgY29uZmlnIElN
QV9ESVNBQkxFX0hUQUJMRQo+Pj4gwqDCoMKgwqDCoCBkZWZhdWx0IG4KPj4+IMKgwqDCoMKgwqAg
aGVscAo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBUaGlzIG9wdGlvbiBkaXNhYmxlcyBodGFibGUgdG8g
YWxsb3cgbWVhc3VyZW1lbnQgb2YgCj4+PiBkdXBsaWNhdGUgcmVjb3Jkcy4KPj4+ICsKPj4+ICtj
b25maWcgSU1BX0tFWEVDX0VYVFJBX1BBR0VTCj4+PiArwqDCoMKgIGludAo+Pj4gK8KgwqDCoCBk
ZXBlbmRzIG9uIElNQSAmJiBJTUFfS0VYRUMKPj4+ICvCoMKgwqAgZGVmYXVsdCAxNgo+Pj4gK8Kg
wqDCoCBoZWxwCj4+PiArwqDCoMKgwqDCoCBJTUFfS0VYRUNfRVhUUkFfUEFHRVMgZGV0ZXJtaW5l
cyB0aGUgbnVtYmVyIG9mIGV4dHJhCj4+PiArwqDCoMKgwqDCoCBwYWdlcyB0byBiZSBhbGxvY2F0
ZWQgZm9yIElNQSBtZWFzdXJlbWVudHMgYWRkZWQgaW4gdGhlCj4+PiArwqDCoMKgwqDCoCB3aW5k
b3cgZnJvbSBrZXhlYyAnbG9hZCcgdG8ga2V4ZWMgJ2V4ZWN1dGUnLgo+Pgo+Pgo+PiBPbiBwcGM2
NCBhIHBhZ2UgaXMgNjRrYi4gSSB3b3VsZCBhc2sgZm9yIGFkZGl0aW9uYWwga2IgaGVyZS4KPj4K
Pj4KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuwqAgRG8geW91IG1lYW4gSSBzaG91bGQgbWFrZSB0
aGUgZGVmYXVsdCB2YWx1ZSBvZgo+IHRoZSBjb25maWcgSU1BX0tFWEVDX0VYVFJBX1BBR0VTIDY0
IG9yIHNvbWV0aGluZz8KCgpObywgd2hhdCBJIG1lYW4gaXMgeW91IHNob3VsZCBhc2sgdGhlIHVz
ZXIgZm9yIGhvdyBtYW55IGV4dHJhIGtpbG9ieXRlcyAKKGtiKSB0byBhbGxvY2F0ZSAtIG5vdCBh
c2sgZm9yIHBhZ2VzLgoKCiDCoMKgIFN0ZWZhbgoKPgo+IEluIGNvZGUsIEkgbXVsdGlwbHkgdGhl
IGNvbmZpZyB2YWx1ZSB3aXRoIFBBR0VfU0laRS7CoCBTbyBtb3JlIG1lbW9yeQo+IHdvdWxkIGJl
IGFsbG9jYXRlZCBvbiBwcGM2NCBmb3IgZ2l2ZW4gZGVmYXVsdCBjb25maWcgdmFsdWUuIENvdWxk
IHlvdQo+IHBsZWFzZSBjbGFyaWZ5IHdoYXQgY2hhbmdlIHlvdSBhcmUgc3VnZ2VzdGluZyBoZXJl
Pwo+Cj4KPiArwqDCoMKgwqDCoMKgwqAgYmluYXJ5X3J1bnRpbWVfc2l6ZSA9IGltYV9nZXRfYmlu
YXJ5X3J1bnRpbWVfc2l6ZSgpICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgaW1hX2tleGVjX2hkcikg
Kwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKENPTkZJR19JTUFfS0VYRUNfRVhUUkFfUEFHRVMgKgo+IFBBR0VfU0laRSk7Cj4K
PiB+VHVzaGFyCj4KPj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9r
ZXhlYy5jIAo+Pj4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jCj4+PiBpbmRl
eCAxM2ZiYmI5MDMxOWIuLjZjZDVmNDZhNzIwOCAxMDA2NDQKPj4+IC0tLSBhL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hX2tleGVjLmMKPj4+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX2tleGVjLmMKPj4+IEBAIC0xNTAsMTUgKzE1MCwxOCBAQCB2b2lkIGltYV9hZGRfa2V4ZWNf
YnVmZmVyKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+Pj4gwqDCoMKgwqDCoCBpbnQgcmV0Owo+Pj4g
wqDCoMKgwqDCoCAvKgo+Pj4gLcKgwqDCoMKgICogUmVzZXJ2ZSBhbiBleHRyYSBoYWxmIHBhZ2Ug
b2YgbWVtb3J5IGZvciBhZGRpdGlvbmFsIAo+Pj4gbWVhc3VyZW1lbnRzCj4+PiAtwqDCoMKgwqAg
KiBhZGRlZCBkdXJpbmcgdGhlIGtleGVjIGxvYWQuCj4+PiArwqDCoMKgwqAgKiBSZXNlcnZlIGV4
dHJhIG1lbW9yeSBmb3IgbWVhc3VyZW1lbnRzIGFkZGVkIGluIHRoZSB3aW5kb3cgZnJvbQo+Pj4g
K8KgwqDCoMKgICoga2V4ZWMgJ2xvYWQnIHRvIGtleGVjICdleGVjdXRlJy4KPj4+IMKgwqDCoMKg
wqDCoCAqLwo+Pj4gLcKgwqDCoCBiaW5hcnlfcnVudGltZV9zaXplID0gaW1hX2dldF9iaW5hcnlf
cnVudGltZV9zaXplKCk7Cj4+PiArwqDCoMKgIGJpbmFyeV9ydW50aW1lX3NpemUgPSBpbWFfZ2V0
X2JpbmFyeV9ydW50aW1lX3NpemUoKSArCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzaXplb2Yoc3RydWN0IGltYV9rZXhlY19oZHIpICsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChDT05GSUdfSU1BX0tFWEVDX0VYVFJBX1BBR0VTICogUEFH
RV9TSVpFKTsKPj4+ICsKPj4+IMKgwqDCoMKgwqAgaWYgKGJpbmFyeV9ydW50aW1lX3NpemUgPj0g
VUxPTkdfTUFYIC0gUEFHRV9TSVpFKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGtleGVjX3NlZ21l
bnRfc2l6ZSA9IFVMT05HX01BWDsKPj4+IMKgwqDCoMKgwqAgZWxzZQo+Pj4gLcKgwqDCoMKgwqDC
oMKgIGtleGVjX3NlZ21lbnRfc2l6ZSA9IEFMSUdOKGltYV9nZXRfYmluYXJ5X3J1bnRpbWVfc2l6
ZSgpICsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQ
QUdFX1NJWkUgLyAyLCBQQUdFX1NJWkUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGtleGVjX3NlZ21l
bnRfc2l6ZSA9IEFMSUdOKGJpbmFyeV9ydW50aW1lX3NpemUsIFBBR0VfU0laRSk7Cj4+PiArCj4+
PiDCoMKgwqDCoMKgIGlmICgoa2V4ZWNfc2VnbWVudF9zaXplID09IFVMT05HX01BWCkgfHwKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAoKGtleGVjX3NlZ21lbnRfc2l6ZSA+PiBQQUdFX1NISUZUKSA+
IHRvdGFscmFtX3BhZ2VzKCkgLyAKPj4+IDIpKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJf
ZXJyKCJCaW5hcnkgbWVhc3VyZW1lbnQgbGlzdCB0b28gbGFyZ2UuXG4iKTsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
