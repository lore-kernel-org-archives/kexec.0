Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180DFC49EA1
	for <kexec@archiver.kernel.org>; Fri,  9 Aug 2024 05:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilMMZzSDGlN2Kv7txAe3rdG65pKJ4+HGuyl15d645MQ=; b=lg9agDl3mi2ARPIh95mKmOWrtH
	0iwpTEs9AEIWFsTzxg3E3A3FijKCsrS1X+yF9oP0HlKJfy6fueCPkhKi9Z/oJXAVXfcfcLvS3IX85
	SEtNQ+IYRNN+wuTVCQkrAcCpBksLeyEshaQuzsLkpiGb6Aq0g+iAdhuW4unA8pQ6vhrR9W6oyKSf4
	hN+KUXq9DEsJwW/MaAuG01ouFW7bgv4KbgcuyUKaDSzAiK+thwJ+7HT0hSzR3Ja585Sk71n42qQi3
	/b1BDFOFISbY+npB1FQ0EVTgtX8b9j6yqOQU5FLTMyrS+D4gjbueuQhxXp+cWcTpypchKfuj5rzyn
	Cr7tgoPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scIIA-0000000AJ7n-0OWw;
	Fri, 09 Aug 2024 05:35:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scII7-0000000AJ76-04Dm
	for kexec@lists.infradead.org;
	Fri, 09 Aug 2024 05:35:56 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478Cb3I8005727;
	Fri, 9 Aug 2024 05:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	ZKL8Q9qcvjVY5MH9IXvnciiyhYMEMZN0/x4DWSJkYTU=; b=LGWMVFQ44cMhD1G6
	H8FirD6qcFLsFBZC3mdg1iP72C28Yqb4VEUo5FH+RnLDJRk6x2uywj1mkkAvyN0R
	wayXmEHdENljkC9LloEJSvrEYTWfoQN1VhjMShvnk/FXWrTPyn8f4YuHokPn5m3T
	oBc231Y3vl1szuMGxKx2O9sN/y1x/z+dJKlBc/nU3Qa7W13E1xqDiR9u/BFeQeJo
	W466GtrX8sCGw5vK2VeOaJe9z4PBnoBVQVx1il9oGhv8f4eVPXVQwUHJ0yguTGYw
	tcxhZ0nKsltNb0GF2NAm6Ny+OR3HMtQdSSLuwzSCl84UJVAHGfZEdF7Eg6ZUbZoY
	PxwwQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkca1a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:35:50 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4795Zn9J030019;
	Fri, 9 Aug 2024 05:35:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkca1a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:35:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4794DNjX006462;
	Fri, 9 Aug 2024 05:35:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mssc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:35:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4795Zjlq18219434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 05:35:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548BA20040;
	Fri,  9 Aug 2024 05:35:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D5A2004F;
	Fri,  9 Aug 2024 05:35:33 +0000 (GMT)
Received: from [9.43.4.15] (unknown [9.43.4.15])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 05:35:33 +0000 (GMT)
Message-ID: <ba0c218b-fb38-41a6-8339-265cc75466aa@linux.ibm.com>
Date: Fri, 9 Aug 2024 11:05:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Document/kexec: Generalize crash hotplug description
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: bhe@redhat.com, Hari Bathini <hbathini@linux.ibm.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
 <20240808132423.0f313ffe@meshulam.tesarici.cz>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240808132423.0f313ffe@meshulam.tesarici.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HBp7JP1jjSSjsCq5NunZcsWQeKbk0vI8
X-Proofpoint-ORIG-GUID: kU2XRt0kb8RKUAbJXblqXveslvhGz5mj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_02,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_223555_217290_F75878B1 
X-CRM114-Status: GOOD (  17.37  )
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

SGVsbG8gUGV0ciwKCk9uIDA4LzA4LzI0IDE2OjU0LCBQZXRyIFRlc2HFmcOtayB3cm90ZToKPiBI
aSBTb3VyYWJoLAo+Cj4gc29ycnkgZm9yIGxhdGUgcmVwbHksIHdhcyBvbiB2YWNhdGlvbiBhbmQg
dGhlbiBjYXRjaGluZyB1cC4uLgo+Cj4gT24gTW9uLCAgNSBBdWcgMjAyNCAxMDozODoyOSArMDUz
MAo+IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5AbGludXguaWJtLmNvbT4gd3JvdGU6Cj4KPj4g
Q29tbWl0IDc5MzY1MDI2Zjg2OSAoImNyYXNoOiBhZGQgYSBuZXcga2V4ZWMgZmxhZyBmb3IgaG90
cGx1ZyBzdXBwb3J0IikKPj4gZ2VuZXJhbGl6ZXMgdGhlIGNyYXNoIGhvdHBsdWcgc3VwcG9ydCB0
byBhbGxvdyBhcmNoaXRlY3R1cmVzIHRvIHVwZGF0ZQo+PiBtdWx0aXBsZSBrZXhlYyBzZWdtZW50
cyBvbiBDUFUvTWVtb3J5IGhvdHBsdWcgYW5kIG5vdCBqdXN0IGVsZmNvcmVoZHIuCj4+IFRoZXJl
Zm9yZSwgdXBkYXRlIHRoZSByZWxldmFudCBrZXJuZWwgZG9jdW1lbnRhdGlvbiB0byByZWZsZWN0
IHRoZSBzYW1lLgo+Pgo+PiBObyBmdW5jdGlvbmFsIGNoYW5nZS4KPj4KPj4gQ2M6IFBldHIgVGVz
YXJpayA8cGV0ckB0ZXNhcmljaS5jej4KPj4gQ2M6IEhhcmkgQmF0aGluaSA8aGJhdGhpbmlAbGlu
dXguaWJtLmNvbT4KPj4gQ2M6IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnCj4+IENjOiB4ODZAa2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBTb3VyYWJoIEphaW4g
PHNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+Pgo+PiBEaXNjdXNzaW9uIGFib3V0
IHRoZSBkb2N1bWVudGF0aW9uIHVwZGF0ZToKPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzY4ZDAzMjhkLTUzMWEtNGEyYi1hYjI2LWM5N2ZkOGExMmU4YkBsaW51eC5pYm0uY29tLwo+Pgo+
PiAtLS0KPj4gICAuLi4vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1tZW1vcnkgICAgICAgICAg
fCAgNiArKy0tCj4+ICAgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdSAg
ICAgIHwgIDYgKystLQo+PiAgIC4uLi9hZG1pbi1ndWlkZS9tbS9tZW1vcnktaG90cGx1Zy5yc3Qg
ICAgICAgICB8ICA1ICsrLS0KPj4gICBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2NwdV9ob3RwbHVn
LnJzdCAgICAgICAgfCAxMCArKysrLS0tCj4+ICAga2VybmVsL2NyYXNoX2NvcmUuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMjkgKysrKysrKysrKysrLS0tLS0tLQo+PiAgIDUgZmlsZXMg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtbWVtb3J5IGIvRG9j
dW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLW1lbW9yeQo+PiBpbmRleCBhOTVl
MGYxN2MzNWEuLjQyMWFjYzhlMmM2YiAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1kZXZpY2VzLW1lbW9yeQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90
ZXN0aW5nL3N5c2ZzLWRldmljZXMtbWVtb3J5Cj4+IEBAIC0xMTUsNiArMTE1LDYgQEAgV2hhdDoJ
CS9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L2NyYXNoX2hvdHBsdWcKPj4gICBEYXRlOgkJQXVn
IDIwMjMKPj4gICBDb250YWN0OglMaW51eCBrZXJuZWwgbWFpbGluZyBsaXN0IDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPgo+PiAgIERlc2NyaXB0aW9uOgo+PiAtCQkoUk8pIGluZGljYXRl
cyB3aGV0aGVyIG9yIG5vdCB0aGUga2VybmVsIGRpcmVjdGx5IHN1cHBvcnRzCj4+IC0JCW1vZGlm
eWluZyB0aGUgY3Jhc2ggZWxmY29yZWhkciBmb3IgbWVtb3J5IGhvdCB1bi9wbHVnIGFuZC9vcgo+
PiAtCQlvbi9vZmZsaW5lIGNoYW5nZXMuCj4+ICsJCShSTykgaW5kaWNhdGVzIHdoZXRoZXIgb3Ig
bm90IHRoZSBrZXJuZWwgdXBkYXRlIG9mIGtleGVjCj4+ICsJCXNlZ21lbnRzIG9uIG1lbW9yeSBo
b3QgdW4vcGx1ZyBhbmQvb3Igb24vb2ZmbGluZSBldmVudHMsCj4+ICsJCWF2b2lkaW5nIHRoZSBu
ZWVkIHRvIHJlbG9hZCBrZHVtcCBrZXJuZWwuCj4gVGhpcyBzZW50ZW5jZSBzb21laG93IGxhY2tz
IGEgdmVyYi4gTXkgc3VnZ2VzdGlvbjoKPgo+ICAgIChSTykgaW5kaWNhdGVzIHdoZXRoZXIgb3Ig
bm90IHRoZSBrZXJuZWwgdXBkYXRlcyByZWxldmFudCBrZXhlYwo+ICAgIHNlZ21lbnRzIG9uIG1l
bW9yeSBob3QgdW4vcGx1ZyBhbmQvb3Igb24vb2ZmbGluZSBldmVudHMsIGF2b2lkaW5nIHRoZQo+
ICAgIG5lZWQgdG8gcmVsb2FkIGtkdW1wIGtlcm5lbC4KCgpUaGFua3MgZm9yIHRoZSByZXZpZXcu
IEkgd2lsbCB1cGRhdGUgdGhlIGRvY3VtZW50IGFzIHN1Z2dlc3RlZC4KCgotIFNvdXJhYmggSmFp
bgoKPgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZp
Y2VzLXN5c3RlbS1jcHUgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMt
c3lzdGVtLWNwdQo+PiBpbmRleCAzMjU4NzMzODViNzEuLmY0YWRhMWNkMmY5NiAxMDA2NDQKPj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLXN5c3RlbS1jcHUK
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLXN5c3RlbS1j
cHUKPj4gQEAgLTcwMyw5ICs3MDMsOSBAQCBXaGF0OgkJL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUv
Y3Jhc2hfaG90cGx1Zwo+PiAgIERhdGU6CQlBdWcgMjAyMwo+PiAgIENvbnRhY3Q6CUxpbnV4IGtl
cm5lbCBtYWlsaW5nIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj4+ICAgRGVz
Y3JpcHRpb246Cj4+IC0JCShSTykgaW5kaWNhdGVzIHdoZXRoZXIgb3Igbm90IHRoZSBrZXJuZWwg
ZGlyZWN0bHkgc3VwcG9ydHMKPj4gLQkJbW9kaWZ5aW5nIHRoZSBjcmFzaCBlbGZjb3JlaGRyIGZv
ciBDUFUgaG90IHVuL3BsdWcgYW5kL29yCj4+IC0JCW9uL29mZmxpbmUgY2hhbmdlcy4KPj4gKwkJ
KFJPKSBpbmRpY2F0ZXMgd2hldGhlciBvciBub3QgdGhlIGtlcm5lbCB1cGRhdGUgb2Yga2V4ZWMK
Pj4gKwkJc2VnbWVudHMgb24gQ1BVIGhvdCB1bi9wbHVnIGFuZC9vciBvbi9vZmZsaW5lIGV2ZW50
cywKPj4gKwkJYXZvaWRpbmcgdGhlIG5lZWQgdG8gcmVsb2FkIGtkdW1wIGtlcm5lbC4KPiBTYW1l
IGFzIGFib3ZlLgo+Cj4gT3RoZXJ3aXNlIExHVE0uCj4KPiBQZXRyIFQKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
