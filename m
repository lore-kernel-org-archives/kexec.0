Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3961C48BF6
	for <kexec@archiver.kernel.org>; Sat, 24 Feb 2024 04:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h4g19mbjD7OnUkw/DsufYDvGugidFG5Wxaoavl7YSFI=; b=LwE58862vd3cw+
	POhALYbYfMmGCQrNWKhJOSpbsmWCEVYY4hNW2diUfdpzdgvLcoB6p8lF7r6J9gotginaxc/kPI4yY
	nYDTL+j0z6kSOwh/f1Lc4VsLVyo+1j66cOJ1a4MhsySm6ELDRv1M5FWDiM3l5sqcQmb+BtHC2F+WT
	z/MjaHWR3BKG29+6a8zfVaj8oMRev7VTm8N65pleseWktds1cweZWBFiK2jy5UFQ0UDHKGG0e/j0J
	Bi4UMofVbCKCyfCrKEsaMVRGFOa04EcC6dG/nZoQKTMGWbqMG+C6wjIES+5KghYPxnbGGZFFe1r90
	ioFMWBYhulwqW1avW6Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdjkW-0000000C26D-3Y6B;
	Sat, 24 Feb 2024 04:34:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdjkS-0000000C25j-2vF5
	for kexec@lists.infradead.org;
	Sat, 24 Feb 2024 04:34:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41O2uKgL008772
	for <kexec@lists.infradead.org>; Sat, 24 Feb 2024 04:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=uMjc55Bj06Tjsgkyoe2Vf9+4vo8Mh/N00COfNIpy+g4=;
 b=Ptwdn8l+e7qvoeuwnYA2EQQDulwNLfYmCahLIvLTh3XG8MCAZOmeKwmB+BJh08Z/pDyM
 j9sQ+t+vzVq4TAexCxQhLtstjcqCm8u4tetVbl/vIuQed56fVeLd3b8C8IY8+U8e8g5M
 0TPIxUQVhDDCEBy/Afw5Bwe5+dpP/t9wOOgAmeEMG2nT5GSn5sh4oKPn0hYv4aMB1Vj6
 2h+lgLhBaHVEOMxDmTlrMLmf6eIHhwppZ1FyxvfdZ7pI2z6/AlNvBoKAP3VBwGoypWz+
 AEteuxww6AeFiaBVw6L+kNgro3U7C2ZNdg4kk3sEN4N1q8Mkasgj1ob+gL4Gmli9V+MQ Yg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf6w5ac45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Sat, 24 Feb 2024 04:34:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41O3IFmp013470
	for <kexec@lists.infradead.org>; Sat, 24 Feb 2024 04:34:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h12g8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Sat, 24 Feb 2024 04:34:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41O4YiOh20709988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 04:34:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC7F20086;
	Sat, 24 Feb 2024 04:34:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45B120085;
	Sat, 24 Feb 2024 04:34:42 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.8.94])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Feb 2024 04:34:42 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20240223190342.251365-1-adityag@linux.ibm.com>
Date: Sat, 24 Feb 2024 10:04:31 +0530
Cc: kexec@lists.infradead.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Message-Id: <2B24294E-177F-4524-A19B-2BB8225FAD8B@linux.ibm.com>
References: <20240223190342.251365-1-adityag@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZX7Iv7-lwwTzIj_MoOryhsFadx6N0ngA
X-Proofpoint-GUID: ZX7Iv7-lwwTzIj_MoOryhsFadx6N0ngA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_203453_118125_D67AC7EA 
X-CRM114-Status: GOOD (  19.97  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIDI0LUZlYi0yMDI0LCBhdCAxMjozM+KAr0FNLCBBZGl0eWEgR3VwdGEgPGFkaXR5YWdA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4gCj4gQmVsb3cgZXJyb3Igd2FzIG5vdGljZWQgd2hlbiBy
dW5uaW5nIG1ha2VkdW1wZmlsZSBvbiBsaW51eC1uZXh0IGtlcm5lbAo+IGNyYXNoIChsaW51eC1u
ZXh0IHRhZyBuZXh0LTIwMjQwMTIxKToKPiAKPiAgICAuLi4KPiAgICBDaGVja2luZyBmb3IgbWVt
b3J5IGhvbGVzIDogWzEwMC4wICVdIHwgcmVhZHBhZ2VfZWxmOiBBdHRlbXB0IHRvIHJlYWQgbm9u
LWV4aXN0ZW50IHBhZ2UgYXQgMHhjMDAwMDAwMDAwMDAwLgo+ICAgIFsgMTcuNTUxNzE4XSBrZHVt
cC5zaFs0MDRdOiByZWFkbWVtOiB0eXBlX2FkZHI6IDAsIGFkZHI6YzAwYzAwMDAwMDAwMDAwMCwg
c2l6ZToxNjM4NAo+ICAgIFsgMTcuNTUxNzkzXSBrZHVtcC5zaFs0MDRdOiBfX2V4Y2x1ZGVfdW5u
ZWNlc3NhcnlfcGFnZXM6IENhbid0IHJlYWQgdGhlIGJ1ZmZlciBvZiBzdHJ1Y3QgcGFnZS4KPiAg
ICBbIDE3LjU1MTg2NF0ga2R1bXAuc2hbNDA0XTogY3JlYXRlXzJuZF9iaXRtYXA6IENhbid0IGV4
Y2x1ZGUgdW5uZWNlc3NhcnkgcGFnZXMuCj4gICAgWyAxNy41NjI2MzJdIGtkdW1wLnNoWzQwNF06
IFRoZSBrZXJuZWwgdmVyc2lvbiBpcyBub3Qgc3VwcG9ydGVkLgo+ICAgIFsgMTcuNTYyNzA4XSBr
ZHVtcC5zaFs0MDRdOiBUaGUgbWFrZWR1bXBmaWxlIG9wZXJhdGlvbiBtYXkgYmUgaW5jb21wbGV0
ZS4KPiAgICBbIDE3LjU2Mjc3M10ga2R1bXAuc2hbNDA0XTogbWFrZWR1bXBmaWxlIEZhaWxlZC4K
PiAgICBbIDE3LjU2NDMzNV0ga2R1bXBbNDA2XTogc2F2aW5nIHZtY29yZSBmYWlsZWQsIF9leGl0
Y29kZToxCj4gCj4gQWJvdmUgZXJyb3Igd2FzIGR1ZSB0byAndm1hcF9hcmVhX2xpc3QnIGFuZCAn
dm1saXN0JyBzeW1ib2xzIG1pc3NpbmcKPiBmcm9tIHRoZSB2bWNvcmUuCj4gCj4gJ3ZtYXBfYXJl
YV9saXN0JyB3YXMgcmVtb3ZlZCBpbiB0aGUgbGludXgga2VybmVsIHdpdGggYmVsb3cgY29tbWl0
Ogo+IAo+ICAgIGNvbW1pdCAzNzhlYjI0YTA2NThkZDkyMmIyOTUyNGUwY2UzNWM2YzQzZjU2Y2Jh
Cj4gICAgICAgICBtbS92bWFsbG9jOiByZW1vdmUgdm1hcF9hcmVhX2xpc3QKPiAKPiBTdWJzZXF1
ZW50bHkgdGhlIGNvbW1pdCBhbHNvIGludHJvZHVjZWQgJ1ZNQUxMT0NfU1RBUlQnIGluIHZtY29y
ZWluZm8gdG8KPiBnZXQgYmFzZSBhZGRyZXNzIG9mIHZtYWxsb2MgYXJlYSwgaW5zdGVhZCBvZiBk
ZXBlbmRpbmcgb24gJ3ZtYXBfYXJlYV9saXN0Jwo+IAo+IEhlbmNlIGlmICdWTUFMTE9DX1NUQVJU
JyBzeW1ib2wgaXMgdGhlcmUgaW4gdm1jb3JlaW5mbzoKPiAgMS4gU2V0IHZtYWxsb2Nfc3RhcnQg
YmFzZWQgb24gJ1ZNQUxMT0NfU1RBUlQnCj4gIDIuIERvbid0IGVycm9yIGlmIHZtYXBfYXJlYV9s
aXN0L3ZtbGlzdCBhcmUgbm90IGRlZmluZWQKPiAKPiBSZXBvcnRlZC1ieTogU2FjaGluIFNhbnQg
PHNhY2hpbnBAbGludXguaWJtLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR3VwdGEgPGFk
aXR5YWdAbGludXguaWJtLmNvbT4KPiAtLS0KClRoYW5rcyBBZGl0eWEgZm9yIHRoZSBmaXguIFdp
dGggdGhpcyBmaXggYXBwbGllZCBtYWtlZHVtcGZpbGUgaXMgYWJsZSB0bwpzYXZlIHZtY29yZSBk
dXJpbmcga2R1bXAuCgpUZXN0ZWQtYnk6IFNhY2hpbiBTYW50IDxzYWNoaW5wQGxpbnV4LmlibS5j
b20+CgotIFNhY2hpbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
