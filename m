Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7CDC5320E
	for <kexec@archiver.kernel.org>; Tue, 20 Aug 2024 06:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m6c6rHN4Y5phqiXZeTJBlSDGNa9VTAxwrL9+trEF56s=; b=BRGFheDkMJzCxC
	cuOOVnxn6vlRYeGYmXKmxCwbpEejtFa9xfxliQt4IwOSkGqaZMquWkIVipLEPf4uLpOu35OQRsoKK
	PCfCt5A0wfN0shBfdy9Oo/pew1JpvWEWM0myqfizRZM83nZRHni8GK9W6LxQTNqIO2kvr8+5shYOX
	OwoExKgM/QvxMPN5pWLiuW42U/jgI0P+2VDwsMpko5gJDES5dPZs4y1GL3g+ERMDN7+w5CQqp1ADj
	geHROJs6yY76mNU3Qs20L34OxRd7WJtrVEMJ+5XGkzyFSBtuET4aPH/5dUKI53WxzZrC+n92xmCFd
	mfYE0KHKmP9+pIkGOtIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgIYM-0000000446b-2g6a;
	Tue, 20 Aug 2024 06:41:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgIY1-0000000441l-0QOm
	for kexec@lists.infradead.org;
	Tue, 20 Aug 2024 06:41:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JNRTTp011313;
	Tue, 20 Aug 2024 06:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=E
	YAWZyzQ0FYJZPEoFW49YgYvz17cDNcnXjq4cw3edVk=; b=XUBn7GHbQilsKaSHo
	DVEiY2XypahRzHGDjr8h1Mos4ntN6mgu81HisO8jP7Xsu+EfGmhcqEsrqg+zGa6R
	89rLazQ/FjF5+91vgKkFzOARyYXue0uh4oLVbhNF/jgGyH0nwRAhNMhOXoM3meAH
	3Jgwzi2l9109cq7eK3FE9NbD8Z724y27uxdSlGbSHcEWl6OLCqdtd33prueaLmqW
	IiOh9xSl3/OoMQbBDeZtkamGU4euhJ1bw6NRdUnZHtySaRZVZF50rDzU4jtX3wzG
	jRiDTLCOvCzxH4NDW1mVPifxGKd+RPnFD4vlpq0DqQjdZjpm4WoQ3gNSpj9LT75o
	gx7qA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04cka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:40:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6ejLl016167;
	Tue, 20 Aug 2024 06:40:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04ck7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:40:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K1xGKY018973;
	Tue, 20 Aug 2024 06:40:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376psn0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:40:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6ee2K56099110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:40:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427AD20043;
	Tue, 20 Aug 2024 06:40:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E1F420040;
	Tue, 20 Aug 2024 06:40:34 +0000 (GMT)
Received: from [9.43.1.80] (unknown [9.43.1.80])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:40:34 +0000 (GMT)
Message-ID: <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
Date: Tue, 20 Aug 2024 12:10:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MeARZ9ZfxA25mP6cIm7xMSv65SI-14Jd
X-Proofpoint-ORIG-GUID: 1fNEByVcExy7KUsVWapOtrVhkkRpMBj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_234053_171719_D2FDC0A2 
X-CRM114-Status: GOOD (  27.58  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDE5LzA4LzI0IDExOjQ1LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDA4LzE5LzI0IGF0IDA5OjQ1YW0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gSGVsbG8gTWljaGFl
bCBhbmQgQm9hcXVhbgo+Pgo+PiBPbiAwMS8wOC8yNCAxMjoyMSwgU291cmFiaCBKYWluIHdyb3Rl
Ogo+Pj4gSGVsbG8gTWljaGFlbCwKPj4+Cj4+PiBPbiAwMS8wOC8yNCAwODowNCwgTWljaGFlbCBF
bGxlcm1hbiB3cm90ZToKPj4+PiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4LmlibS5j
b20+IHdyaXRlczoKPj4+Pj4gVGhlIGZvbGxvd2luZyBlcnJvcnMgYXJlIG9ic2VydmVkIHdoZW4g
a2V4ZWMgaXMgZG9uZSB3aXRoIFNNVD1vZmYgb24KPj4+Pj4gcG93ZXJwYy4KPj4+Pj4KPj4+Pj4g
W8KgIDM1OC40NTgzODVdIFJlbW92aW5nIElCTSBQb3dlciA4NDIgY29tcHJlc3Npb24gZGV2aWNl
Cj4+Pj4+IFvCoCAzNzQuNzk1NzM0XSBrZXhlY19jb3JlOiBTdGFydGluZyBuZXcga2VybmVsCj4+
Pj4+IFvCoCAzNzQuNzk1NzQ4XSBrZXhlYzogV2FraW5nIG9mZmxpbmUgY3B1IDEuCj4+Pj4+IFvC
oCAzNzQuODc1Njk1XSBjcmFzaCBocDoga2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhk
ciBtYXkKPj4+Pj4gYmUgaW5hY2N1cmF0ZQo+Pj4+PiBbwqAgMzc0LjkzNTgzM10ga2V4ZWM6IFdh
a2luZyBvZmZsaW5lIGNwdSAyLgo+Pj4+PiBbwqAgMzc1LjAxNTY2NF0gY3Jhc2ggaHA6IGtleGVj
X3RyeWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5Cj4+Pj4+IGJlIGluYWNjdXJhdGUKPj4+
Pj4gc25pcC4uCj4+Pj4+IFvCoCAzNzUuNTE1ODIzXSBrZXhlYzogV2FraW5nIG9mZmxpbmUgY3B1
IDYuCj4+Pj4+IFvCoCAzNzUuNjM1NjY3XSBjcmFzaCBocDoga2V4ZWNfdHJ5bG9jaygpIGZhaWxl
ZCwgZWxmY29yZWhkciBtYXkKPj4+Pj4gYmUgaW5hY2N1cmF0ZQo+Pj4+PiBbwqAgMzc1LjY5NTgz
Nl0ga2V4ZWM6IFdha2luZyBvZmZsaW5lIGNwdSA3Lgo+Pj4+IEFyZSB0aGV5IGFjdHVhbGx5IGVy
cm9ycyB0aG91Z2g/IERvIHRoZXkgYmxvY2sgdGhlIGFjdHVhbCBrZXhlYyBmcm9tCj4+Pj4gaGFw
cGVuaW5nPyBPciBhcmUgdGhleSBqdXN0IHdhcm5pbmdzIGluIGRtZXNnPwo+Pj4gVGhlIGtleGVj
IGtlcm5lbCBib290cyBmaW5lLgo+Pj4KPj4+IFRoaXMgd2FybmluZyBhcHBlYXJzIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGUga2R1bXAga2VybmVsIGlzIGxvYWRlZC4KPj4+Cj4+PiBIb3dldmVy
LCB3aGVuIHRoZSBrZHVtcCBrZXJuZWwgaXMgbG9hZGVkLCB3ZSB3aWxsIG5vdCBiZSBhYmxlIHRv
IHVwZGF0ZQo+Pj4gdGhlIGtkdW1wIGltYWdlIChGRFQpLgo+Pj4gSSB0aGluayB0aGlzIHNob3Vs
ZCBiZSBmaW5lIGdpdmVuIHRoYXQga2V4ZWMgaXMgaW4gcHJvZ3Jlc3MuCj4+Pgo+Pj4gUGxlYXNl
IGxldCBtZSBrbm93IHlvdXIgb3Bpbmlvbi4KPj4+Cj4+Pj4gQmVjYXVzZSB0aGUgZml4IGxvb2tz
IGxpa2UgaXQgY291bGQgYmUgcmFjeS4KPj4+IEl0IHNlZW1zIGxpa2UgaXQgaXMgcmFjeSwgYnV0
IGdpdmVuIHRoYXQga2V4ZWMgdGFrZXMgdGhlIGxvY2sgZmlyc3QgYW5kCj4+PiB0aGVuCj4+PiBi
cmluZ3MgdGhlIENQVSB1cCwgd2hpY2ggdHJpZ2dlcnMgdGhlIGtkdW1wIGltYWdlLCB3aGljaCBh
bHdheXMgZmFpbHMgdG8KPj4+IHVwZGF0ZSB0aGUga2R1bXAgaW1hZ2UgYmVjYXVzZSBpdCBjb3Vs
ZCBub3QgdGFrZSB0aGUgc2FtZSBsb2NrLgo+Pj4KPj4+IE5vdGU6IHRoZSBrZXhlYyBsb2NrIGlz
IG5vdCByZWxlYXNlZCB1bmxlc3Mga2V4ZWMgYm9vdCBmYWlscy4KPj4gQW55IGNvbW1lbnRzIG9y
IHN1Z2dlc3Rpb25zIG9uIHRoaXMgZml4Pwo+IElzIHRoaXMgYSBsaXR0bGUgYmV0dGVyPwo+Cj4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4g
aW5kZXggNjNjZjg5MzkzYzZlLi4wMzU1ZmZiNzEyZjQgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2Ny
YXNoX2NvcmUuYwo+ICsrKyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPiBAQCAtNTA0LDcgKzUwNCw3
IEBAIGludCBjcmFzaF9jaGVja19ob3RwbHVnX3N1cHBvcnQodm9pZCkKPiAgIAo+ICAgCWNyYXNo
X2hvdHBsdWdfbG9jaygpOwo+ICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIHJlYWRpbmcgY3Jhc2gg
aW5mb3JtYXRpb24gKi8KPiAtCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4gKwlpZiAoIWtleGVj
X3RyeWxvY2soKSAmJiBrZXhlY19pbl9wcm9ncmVzcykgewo+ICAgCQlwcl9pbmZvKCJrZXhlY190
cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPiAgIAkJ
Y3Jhc2hfaG90cGx1Z191bmxvY2soKTsKPiAgIAkJcmV0dXJuIDA7Cj4gQEAgLTUzOSw3ICs1Mzks
NyBAQCBzdGF0aWMgdm9pZCBjcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCh1bnNpZ25lZCBpbnQg
aHBfYWN0aW9uLCB1bnNpZ25lZCBpbnQgY3B1LAo+ICAgCj4gICAJY3Jhc2hfaG90cGx1Z19sb2Nr
KCk7Cj4gICAJLyogT2J0YWluIGxvY2sgd2hpbGUgY2hhbmdpbmcgY3Jhc2ggaW5mb3JtYXRpb24g
Ki8KPiAtCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4gKwlpZiAoIWtleGVjX3RyeWxvY2soKSAm
JiBrZXhlY19pbl9wcm9ncmVzcykgewo+ICAgCQlwcl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFp
bGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPiAgIAkJY3Jhc2hfaG90cGx1
Z191bmxvY2soKTsKPiAgIAkJcmV0dXJuOwoKSWRlYWxseSwgd2hlbiBga2V4ZWNfaW5fcHJvZ3Jl
c3NgIGlzIFRydWUsIHRoZXJlIHNob3VsZCBiZSBubyB3YXkgdG8gCmFjcXVpcmUgdGhlIGtleGVj
IGxvY2suClRoZXJlZm9yZSwgY2FsbGluZyBga2V4ZWNfdHJ5bG9jaygpYCBiZWZvcmUgY2hlY2tp
bmcgYGtleGVjX2luX3Byb2dyZXNzYCAKaXMgbm90IGhlbHBmdWwuClRoZSBrZXJuZWwgd2lsbCBw
cmludCB0aGUgZXJyb3IgbWVzc2FnZSAia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgCmVsZmNvcmVo
ZHIgbWF5IGJlIGluYWNjdXJhdGUuIgpTbywgd2l0aCB0aGUgYWJvdmUgY2hhbmdlcywgdGhlIG9y
aWdpbmFsIHByb2JsZW0gcmVtYWlucyB1bnNvbHZlZC4KCkhvd2V2ZXIsIGFmdGVyIGNsb3NlbHkg
aW5zcGVjdGluZyB0aGUgCmBrZXJuZWwva2V4ZWNfY29yZS5jOmtlcm5lbF9rZXhlYygpYCBmdW5j
dGlvbiwgSSBkaXNjb3ZlcmVkCmFuIGV4Y2VwdGlvbmFsIGNhc2Ugd2hlcmUgbXkgcGF0Y2ggbmVl
ZHMgYW4gdXBkYXRlLiBUaGUgaXNzdWUgYXJpc2VzIAp3aGVuIHRoZSBzeXN0ZW0gcmV0dXJucwpm
cm9tIHRoZSBgbWFjaGluZV9rZXhlYygpYCBmdW5jdGlvbiwgd2hpY2ggaW5kaWNhdGVzIHRoYXQg
a2V4ZWMgaGFzIGZhaWxlZC4KCkluIHRoaXMgc2NlbmFyaW8sIHRoZSBrZXhlYyBsb2NrIGlzIHJl
bGVhc2VkLCBidXQgYGtleGVjX2luX3Byb2dyZXNzYCAKcmVtYWlucyBUcnVlLgoKSSBhbSB1bnN1
cmUgd2h5IGBrZXhlY19pbl9wcm9ncmVzc2AgaXMgTk9UIHNldCB0byBGYWxzZSB3aGVuIGtleGVj
IApmYWlscy4gV2FzIHRoaXMgYnkgZGVzaWduLApvciB3YXMgaXQgYW4gb3ZlcnNpZ2h0IGJlY2F1
c2UgcmV0dXJuaW5nIGZyb20gdGhlIGBtYWNoaW5lX2tleGVjKClgIApmdW5jdGlvbiBpcyBoaWdo
bHkgdW5saWtlbHk/CgpIZXJlIGlzIG15IHByb3Bvc2FsIHRvIGFkZHJlc3MgdGhlIG9yaWdpbmFs
IHByb2JsZW0gYWxvbmcgd2l0aCB0aGUgCmV4Y2VwdGlvbmFsIGNhc2UgSSBkZXNjcmliZWQKYWJv
dmUuCgpMZXQncyBpbXBsZW1lbnQgdHdvIHBhdGNoZXM6CgoxLiBBIHBhdGNoIHRoYXQgc2V0cyBg
a2V4ZWNfaW5fcHJvZ3Jlc3NgIHRvIEZhbHNlIGlmIHRoZSBzeXN0ZW0gcmV0dXJucyAKZnJvbSBg
bWFjaGluZV9rZXhlYygpYCBiZWZvcmUKIMKgwqAgdW5sb2NraW5nIHRoZSBrZXhlYyBsb2NrIGlu
IHRoZSBga2VybmVsX2tleGVjKClgIGZ1bmN0aW9uLgoKIMKgwqAgYGBgCiDCoMKgIGRpZmYgLS1n
aXQgYS9rZXJuZWwva2V4ZWNfY29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYwogwqDCoCBpbmRl
eCBjMGNhYTE0ODgwYzMuLmI0MTI3NzE4MzQ1NSAxMDA2NDQKIMKgwqAgLS0tIGEva2VybmVsL2tl
eGVjX2NvcmUuYwogwqDCoCArKysgYi9rZXJuZWwva2V4ZWNfY29yZS5jCiDCoMKgIEBAIC0xMDY5
LDYgKzEwNjksNyBAQCBpbnQga2VybmVsX2tleGVjKHZvaWQpCiDCoMKgICNlbmRpZgoKIMKgwqDC
oCBVbmxvY2s6CiDCoMKgICvCoMKgwqDCoMKgIGtleGVjX2luX3Byb2dyZXNzID0gZmFsc2U7CiDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBrZXhlY191bmxvY2soKTsKIMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBlcnJvcjsKIMKgwqDCoCBgYGAKCjIuIEEgcGF0Y2ggdG8gcmV0dXJuIGVhcmx5IGZy
b20gdGhlIGBjcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCgpYCAKZnVuY3Rpb24gaWYgYGtleGVj
X2luX3Byb2dyZXNzYCBpcwogwqDCoCBzZXQgdG8gVHJ1ZS4gVGhpcyBpcyBlc3NlbnRpYWxseSBt
eSBvcmlnaW5hbCBwYXRjaC4KClBsZWFzZSBzaGFyZSB5b3VyIGNvbW1lbnRzIG9uIHRoZSBuZXcg
YXBwcm9hY2guCgpUaGFuayB5b3UgZm9yIHJldmlldy4KCi0gU291cmFiaCBKYWluCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
