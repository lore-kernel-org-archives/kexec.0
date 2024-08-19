Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B80C3DA4A
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 04:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OQRhAz5/lTXiuhNaPiCsH+pVvaUIpEJErvopRUs6Ke4=; b=niOhrLLJ5TsJfM
	+hJU8heM+dziiH2OKQBhYhAJBPVT24ZajdB+r2M/maKuKC3dIs4jzro9/DLvkUCHIMVznHvYZWhai
	mWkxZS2HIW5B7039HpTtv8lyLHAh9kaisyyLWm9PmVJJ73t2AAsMHDFIh15VuK5w4MTKYgSXfINSY
	jH3UPicRfjs4uLl/Ogx22eU/6j+LvzcpnW8xXJ1SVH5ITWhkBU4TMnWGaN0EdZ54CNZikyntMGeWU
	bK3dEryxxqyXUlU8fJuuWvSjbVU0AkWGOfa9UD8T33uDpTy8kigA/bfC5WWpqV8SIc6oZkrV4ENCQ
	b5gBG3obadXU4rnDUzyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sftoT-00000000J2g-3j1w;
	Mon, 19 Aug 2024 04:16:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sftoP-00000000J1Q-42YS
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 04:16:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J3X8T1023559;
	Mon, 19 Aug 2024 04:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=o
	2sTkt1iXiirRrY/2diJQwQvSmFwGnGarq5JCuO5sjM=; b=OxaHkZKCoiBJB6Phj
	FeTpU8GyzpzaFFgqj9RRmJuxbZjoP6q7caWDCHTTTB/szh35G8sIwRrP2GlcQtM0
	q2hVn1GIIsFLGxp37KH75bsSwmH0fQHnntbhFdU+kAmIrRwerRIEsdKJis8jscjO
	BAu0rxXaPz3qNM2Dh6Ud5vGmdCGG2NETbpEeBnYDvMz1dvmFvUtWr4OAJCEwesjQ
	76TJpyZ+x33FYKjn+FuC+VswvY/A4TOgD82MmsX/QoBGAvw30cjUfSLD3gg1ZaLK
	FbotKWKHTRU5K5TUc7Comvg6uf4k9obojC02woCzAXziibjaeS1tPXmjHZfJsEjv
	r5jxg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc5xvda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47J4G2wh022758;
	Mon, 19 Aug 2024 04:16:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc5xvd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J2pneU013107;
	Mon, 19 Aug 2024 04:16:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366tvq0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47J4FwAC27984422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 04:16:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030F120043;
	Mon, 19 Aug 2024 04:15:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2906420040;
	Mon, 19 Aug 2024 04:15:56 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 04:15:55 +0000 (GMT)
Message-ID: <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
Date: Mon, 19 Aug 2024 09:45:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dkC9HdUkU1ndMyUpgCEV6AyZ0aEUDBK7
X-Proofpoint-ORIG-GUID: 9BpC5g6i3iCIjSgQoI-_tfZlERenEVta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_01,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240818_211610_039519_308C69F3 
X-CRM114-Status: GOOD (  19.84  )
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

SGVsbG8gTWljaGFlbCBhbmQgQm9hcXVhbgoKT24gMDEvMDgvMjQgMTI6MjEsIFNvdXJhYmggSmFp
biB3cm90ZToKPiBIZWxsbyBNaWNoYWVsLAo+Cj4gT24gMDEvMDgvMjQgMDg6MDQsIE1pY2hhZWwg
RWxsZXJtYW4gd3JvdGU6Cj4+IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5AbGludXguaWJtLmNv
bT4gd3JpdGVzOgo+Pj4gVGhlIGZvbGxvd2luZyBlcnJvcnMgYXJlIG9ic2VydmVkIHdoZW4ga2V4
ZWMgaXMgZG9uZSB3aXRoIFNNVD1vZmYgb24KPj4+IHBvd2VycGMuCj4+Pgo+Pj4gW8KgIDM1OC40
NTgzODVdIFJlbW92aW5nIElCTSBQb3dlciA4NDIgY29tcHJlc3Npb24gZGV2aWNlCj4+PiBbwqAg
Mzc0Ljc5NTczNF0ga2V4ZWNfY29yZTogU3RhcnRpbmcgbmV3IGtlcm5lbAo+Pj4gW8KgIDM3NC43
OTU3NDhdIGtleGVjOiBXYWtpbmcgb2ZmbGluZSBjcHUgMS4KPj4+IFvCoCAzNzQuODc1Njk1XSBj
cmFzaCBocDoga2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgCj4+PiBp
bmFjY3VyYXRlCj4+PiBbwqAgMzc0LjkzNTgzM10ga2V4ZWM6IFdha2luZyBvZmZsaW5lIGNwdSAy
Lgo+Pj4gW8KgIDM3NS4wMTU2NjRdIGNyYXNoIGhwOiBrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBl
bGZjb3JlaGRyIG1heSBiZSAKPj4+IGluYWNjdXJhdGUKPj4+IHNuaXAuLgo+Pj4gW8KgIDM3NS41
MTU4MjNdIGtleGVjOiBXYWtpbmcgb2ZmbGluZSBjcHUgNi4KPj4+IFvCoCAzNzUuNjM1NjY3XSBj
cmFzaCBocDoga2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgCj4+PiBp
bmFjY3VyYXRlCj4+PiBbwqAgMzc1LjY5NTgzNl0ga2V4ZWM6IFdha2luZyBvZmZsaW5lIGNwdSA3
Lgo+PiBBcmUgdGhleSBhY3R1YWxseSBlcnJvcnMgdGhvdWdoPyBEbyB0aGV5IGJsb2NrIHRoZSBh
Y3R1YWwga2V4ZWMgZnJvbQo+PiBoYXBwZW5pbmc/IE9yIGFyZSB0aGV5IGp1c3Qgd2FybmluZ3Mg
aW4gZG1lc2c/Cj4KPiBUaGUga2V4ZWMga2VybmVsIGJvb3RzIGZpbmUuCj4KPiBUaGlzIHdhcm5p
bmcgYXBwZWFycyByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIGtkdW1wIGtlcm5lbCBpcyBsb2Fk
ZWQuCj4KPiBIb3dldmVyLCB3aGVuIHRoZSBrZHVtcCBrZXJuZWwgaXMgbG9hZGVkLCB3ZSB3aWxs
IG5vdCBiZSBhYmxlIHRvIAo+IHVwZGF0ZSB0aGUga2R1bXAgaW1hZ2UgKEZEVCkuCj4gSSB0aGlu
ayB0aGlzIHNob3VsZCBiZSBmaW5lIGdpdmVuIHRoYXQga2V4ZWMgaXMgaW4gcHJvZ3Jlc3MuCj4K
PiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLgo+Cj4+IEJlY2F1c2UgdGhlIGZpeCBs
b29rcyBsaWtlIGl0IGNvdWxkIGJlIHJhY3kuCj4KPiBJdCBzZWVtcyBsaWtlIGl0IGlzIHJhY3ks
IGJ1dCBnaXZlbiB0aGF0IGtleGVjIHRha2VzIHRoZSBsb2NrIGZpcnN0IAo+IGFuZCB0aGVuCj4g
YnJpbmdzIHRoZSBDUFUgdXAsIHdoaWNoIHRyaWdnZXJzIHRoZSBrZHVtcCBpbWFnZSwgd2hpY2gg
YWx3YXlzIGZhaWxzIHRvCj4gdXBkYXRlIHRoZSBrZHVtcCBpbWFnZSBiZWNhdXNlIGl0IGNvdWxk
IG5vdCB0YWtlIHRoZSBzYW1lIGxvY2suCj4KPiBOb3RlOiB0aGUga2V4ZWMgbG9jayBpcyBub3Qg
cmVsZWFzZWQgdW5sZXNzIGtleGVjIGJvb3QgZmFpbHMuCgpBbnkgY29tbWVudHMgb3Igc3VnZ2Vz
dGlvbnMgb24gdGhpcyBmaXg/CgpUaGFua3MsClNvdXJhYmggSmFpbgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
