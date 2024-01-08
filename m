Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD2C3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lFAUZsHOwSLc8MW27vjvsz5q/GQEswJk4ra0wP+YvfQ=; b=iQrzckwyotl2Tb
	ost6eenbwl9HIXKTZEoDmplh9R9y5w5B7w8vcW4Riq6VxyjQv8GobGf6B5dADk39rVBrgrh/UNldd
	nhYaW8Ac4gPHLaDUzwnpQv8Ay8kf/n0OJMqSJO5v4xarNo7qr07IaeBokILQx7/Ri9cBr3uPbnHfO
	Pkb36yxOxgSh8HVH6l6GwSnDi/5mQjqwf0l0bf5VEIe650QF6m351ZhrPCRNrJmFm/HmTu2L4yt04
	PwvCh+Ge2yGVEbvKivPV34/HT0qm2a+A87yzQUfp2BRvH6g4dhz+5I6arl2aRs49GttBFD/A8XT0x
	Qmk/zhTWnU04CY64AQJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMo7Q-004xi7-2O;
	Mon, 08 Jan 2024 11:48:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMo7N-004xhP-22
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 11:48:35 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408AdrtL024094;
	Mon, 8 Jan 2024 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PWMiGE+EAHOh+QuiJv8ydNKljFRfdXalJMkKSiG6J6M=;
 b=Ewk+LiKRtejfwMDcH1dvqotrfxKlMuv+Sg9CaUVOzRLRwzTuGnWKm6ucDIhVl7sX2tTv
 k3U82SNydWhJAQnxWntT6AqGgveHy5vlx3O9poh5T0bHc/54UigwyzKqjjQeSq41uffC
 T3nOCkSlJOebvu3mWA2kWP82dcIrdpiI/UgqMMrmj4V8u3J8eNi4344jenoKuNfVUwMl
 UO2H4GDFLe/VJf05hnRmEcryaRa7mpUHHP+1zn0Ko/puiw6S9zOVsU7QzOz1SzJTmWRi
 hIQ/br+P+D5y3B8n+U1f1y8ZWhqJHm+jZlVayfBKXrFnXs+SDCfix4ymYZsMDpUumxG3 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf6akyass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408Bgs9c025340;
	Mon, 8 Jan 2024 11:48:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf6akyasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4088gnjm022808;
	Mon, 8 Jan 2024 11:48:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjy7tbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408BmL0B39322166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 11:48:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2D5258056;
	Mon,  8 Jan 2024 11:48:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4305803F;
	Mon,  8 Jan 2024 11:48:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.78.221])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 11:48:20 +0000 (GMT)
Message-ID: <b915f194c9024233d9f6f6ccbf417c26600ee261.camel@linux.ibm.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen
 <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks
 <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Sush Shringarputale
 <sushring@linux.microsoft.com>
Date: Mon, 08 Jan 2024 06:48:20 -0500
In-Reply-To: <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
	 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
	 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
	 <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
	 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
	 <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
	 <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
	 <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
	 <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HtZ9x97zWyqS3cQqbPZB5mAODGIDKmdc
X-Proofpoint-GUID: usKHAPvhjvYxsA9_ocvpV0R_NQbsR9MA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=950 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_034833_885523_A9972A48 
X-CRM114-Status: GOOD (  61.34  )
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

T24gU3VuLCAyMDI0LTAxLTA3IGF0IDIxOjU4IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFN1biwgSmFuIDcsIDIwMjQgYXQgNzo1OeKAr0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4Lmli
bS5jb20+IHdyb3RlOgo+ID4gT24gU2F0LCAyMDI0LTAxLTA2IGF0IDE4OjI3IC0wNTAwLCBQYXVs
IE1vb3JlIHdyb3RlOgo+ID4gPiBPbiBUdWUsIE5vdiAyOCwgMjAyMyBhdCA5OjA34oCvUE0gTWlt
aSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCAyMDIz
LTExLTI4IGF0IDIwOjA2IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+ID4gPiA+ID4gT24gVHVl
LCBOb3YgMjgsIDIwMjMgYXQgNzowOeKAr0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIDIwMjMtMTEtMjcgYXQgMTc6MTYgLTA1MDAs
IFBhdWwgTW9vcmUgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQg
MTI6MDjigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+IE9uIFdlZCwgMjAyMy0xMS0yMiBhdCAwOToyMiAtMDUwMCwgUGF1bCBNb29yZSB3
cm90ZToKPiA+ID4KPiA+ID4gLi4uCj4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBCZWZvcmUgZGVmaW5p
bmcgYSBuZXcgY3JpdGljYWwtZGF0YSByZWNvcmQsIHdlIG5lZWQgdG8gZGVjaWRlIHdoZXRoZXIK
PiA+ID4gPiA+ID4gPiA+IGl0IGlzIHJlYWxseSBuZWNlc3Nhcnkgb3IgaWYgaXQgaXMgcmVkdW5k
YW50LiAgSWYgd2UgZGVmaW5lIGEgbmV3Cj4gPiA+ID4gPiA+ID4gPiAiY3JpdGljYWwtZGF0YSIg
cmVjb3JkLCBjYW4gaXQgYmUgZGVmaW5lZCBzdWNoIHRoYXQgaXQgZG9lc24ndCByZXF1aXJlCj4g
PiA+ID4gPiA+ID4gPiBwYXVzaW5nIGV4dGVuZGluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdD8gIEZv
ciBleGFtcGxlLCBhIG5ldyBzaW1wbGUKPiA+ID4gPiA+ID4gPiA+IHZpc3VhbCBjcml0aWNhbC1k
YXRhIHJlY29yZCBjb3VsZCBjb250YWluIHRoZSBudW1iZXIgb2YgcmVjb3JkcyAoZS5nLgo+ID4g
PiA+ID4gPiA+ID4gPHNlY3VyaXR5ZnM+L2ltYS9ydW50aW1lX21lYXN1cmVtZW50c19jb3VudCkg
dXAgdG8gdGhhdCBwb2ludC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFdoYXQgaWYgdGhl
IHNuYXBzaG90X2FnZ3JlZ2F0ZSB3YXMgYSBoYXNoIG9mIHRoZSBtZWFzdXJlbWVudCBsb2cKPiA+
ID4gPiA+ID4gPiBzdGFydGluZyB3aXRoIGVpdGhlciB0aGUgYm9vdF9hZ2dyZWdhdGUgb3IgdGhl
IGxhdGVzdAo+ID4gPiA+ID4gPiA+IHNuYXBzaG90X2FnZ3JlZ2F0ZSBhbmQgZW5kaW5nIG9uIHRo
ZSByZWNvcmQgYmVmb3JlIHRoZSBuZXcKPiA+ID4gPiA+ID4gPiBzbmFwc2hvdF9hZ2dyZWdhdGU/
ICBUaGUgcGVyZm9ybWFuY2UgaW1wYWN0IGF0IHNuYXBzaG90IHRpbWUgc2hvdWxkIGJlCj4gPiA+
ID4gPiA+ID4gbWluaW1hbCBhcyB0aGUgaGFzaCBjYW4gYmUgaW5jcmVtZW50YWxseSB1cGRhdGVk
IGFzIG5ldyByZWNvcmRzIGFyZQo+ID4gPiA+ID4gPiA+IGFkZGVkIHRvIHRoZSBtZWFzdXJlbWVu
dCBsaXN0LiAgV2hpbGUgdGhlIGhhc2ggd291bGRuJ3QgY2FwdHVyZSB0aGUKPiA+ID4gPiA+ID4g
PiBUUE0gc3RhdGUsIGl0IHdvdWxkIGFsbG93IHNvbWUgY3J1ZGUgdmVyaWZpY2F0aW9uIHdoZW4g
cmVhc3NlbWJsaW5nCj4gPiA+ID4gPiA+ID4gdGhlIGxvZy4gIElmIG9uZSBjb3VsZCBiZWFyIHRo
ZSBjb3N0IG9mIGEgVFBNIHNpZ25pbmcgb3BlcmF0aW9uLCB0aGUKPiA+ID4gPiA+ID4gPiBsb2cg
ZGlnZXN0IGNvdWxkIGJlIHNpZ25lZCBieSB0aGUgVFBNLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBPdGhlciBjcml0aWNhbCBkYXRhIGlzIGNhbGN1bGF0ZWQsIGJlZm9yZSBjYWxsaW5nCj4gPiA+
ID4gPiA+IGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoKSwgd2hpY2ggYWRkcyB0aGUgcmVjb3Jk
IHRvIHRoZSBtZWFzdXJlbWVudAo+ID4gPiA+ID4gPiBsaXN0IGFuZCBleHRlbmRzIHRoZSBUUE0g
UENSLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWduaW5nIHRoZSBoYXNoIHNob3VsZG4ndCBi
ZSBhbiBpc3N1ZSBpZiBpdCBiZWhhdmVzIGxpa2Ugb3RoZXIKPiA+ID4gPiA+ID4gY3JpdGljYWwg
ZGF0YS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSW4gYWRkaXRpb24gdG8gdGhlIGhhc2gsIGNv
bnNpZGVyIGluY2x1ZGluZyBvdGhlciBpbmZvcm1hdGlvbiBpbiB0aGUKPiA+ID4gPiA+ID4gbmV3
IGNyaXRpY2FsIGRhdGEgcmVjb3JkIChlLmcuIHRvdGFsIG51bWJlciBvZiBtZWFzdXJlbWVudCBy
ZWNvcmRzLCB0aGUKPiA+ID4gPiA+ID4gbnVtYmVyIG9mIG1lYXN1cmVtZW50cyBpbmNsdWRlZCBp
biB0aGUgaGFzaCwgdGhlIG51bWJlciBvZiB0aW1lcyB0aGUKPiA+ID4gPiA+ID4gbWVhc3VyZW1l
bnQgbGlzdCB3YXMgdHJpbW1lZCwgZXRjKS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJdCB3b3VsZCBi
ZSBuaWNlIGlmIHlvdSBjb3VsZCBwcm92aWRlIGFuIGV4cGxpY2l0IGxpc3Qgb2Ygd2hhdCB5b3UK
PiA+ID4gPiA+IHdvdWxkIHdhbnQgaGFzaGVkIGludG8gYSBzbmFwc2hvdF9hZ2dyZWdhdGUgcmVj
b3JkOyB0aGUgYWJvdmUgaXMKPiA+ID4gPiA+IGNsb3NlLCBidXQgaXQgaXMgc3RpbGwgYSBsaXR0
bGUgaGFuZC13YXZ5LiAgSSdtIGp1c3QgdHJ5aW5nIHRvIHJlZHVjZQo+ID4gPiA+ID4gdGhlIGJh
Y2stbi1mb3J0aCA6KQo+ID4gPiA+Cj4gPiA+ID4gV2hhdCBpcyBiZWluZyBkZWZpbmVkIGhlcmUg
aXMgdGhlIGZpcnN0IElNQSBjcml0aWNhbC1kYXRhIHJlY29yZCwgd2hpY2gKPiA+ID4gPiByZWFs
bHkgcmVxdWlyZXMgc29tZSB0aG91Z2h0Lgo+ID4gPgo+ID4gPiBNeSB0aGlua2luZyBoYXMgYWx3
YXlzIGJlZW4gdGhhdCB0YWtpbmcgYSBoYXNoIG9mIHRoZSBjdXJyZW50Cj4gPiA+IG1lYXN1cmVt
ZW50IGxvZyB1cCB0byB0aGUgc25hcHNob3QgcG9pbnQgd291bGQgYmUgYSBuaWNlCj4gPiA+IHNu
YXBzaG90X2FnZ3JlZ2F0ZSBtZWFzdXJlbWVudCwgYnV0IEknbSBub3QgaGVhdmlseSBpbnZlc3Rl
ZCBpbiB0aGF0Lgo+ID4gPiBUbyBtZSBpdCBpcyBtb3JlIGltcG9ydGFudCB0aGF0IHdlIGZpbmQg
c29tZXRoaW5nIHdlIGNhbiBhbGwgYWdyZWUgb24sCj4gPiA+IHBlcmhhcHMgcmVsdWN0YW50bHks
IHNvIHdlIGNhbiBtb3ZlIGZvcndhcmQgd2l0aCBhIHNvbHV0aW9uLgo+ID4gPgo+ID4gPiA+IEZv
ciBlYXNlIG9mIHJldmlldywgdGhpcyBuZXcgY3JpdGljYWwtCj4gPiA+ID4gZGF0YSByZWNvcmQg
c2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggc2V0IGZyb20gdHJpbW1pbmcgdGhlCj4gPiA+ID4g
bWVhc3VyZW1lbnQgbGlzdC4KPiA+ID4KPiA+ID4gSSBzZWUgdGhlIHR3byBhcyBsaW5rZWQsIGJ1
dCBpZiB5b3UgcHJlZmVyIHRoZW0gYXMgc2VwYXJhdGUgdGhlbiBzbyBiZQo+ID4gPiBpdC4gIE9u
Y2UgYWdhaW4sIHRoZSBpbXBvcnRhbnQgcGFydCBpcyB0byBtb3ZlIGZvcndhcmQgd2l0aCBhCj4g
PiA+IHNvbHV0aW9uLCBJJ20gbm90IG92ZXJseSBib3RoZXJlZCBpZiBpdCBhcnJpdmVzIGluIG11
bHRpcGxlIHBpZWNlcwo+ID4gPiBpbnN0ZWFkIG9mIG9uZS4KPiA+Cj4gPiBUcmltbWluZyB0aGUg
SU1BIG1lYXN1cmVtZW50IGxpc3QgY291bGQgYmUgdXNlZCBpbiBjb25qdW5jdGlvbiB3aXRoIHRo
ZSBuZXcgSU1BCj4gPiBjcml0aWNhbCBkYXRhIHJlY29yZCBvciBpbmRlcGVuZGVudGx5LiAgQm90
aCBvcHRpb25zIHNob3VsZCBiZSBzdXBwb3J0ZWQuCj4gPgo+ID4gMS4gdHJpbSBOIG51bWJlciBv
ZiByZWNvcmRzIGZyb20gdGhlIGhlYWQgb2YgdGhlIGluIGtlcm5lbCBJTUEgbWVhc3VyZW1lbnQg
bGlzdAo+ID4gMi4gaW50ZXJtaXR0ZW50bHkgaW5jbHVkZSB0aGUgbmV3IElNQSBjcml0aWNhbCBk
YXRhIHJlY29yZCBiYXNlZCBvbiBzb21lIHRyaWdnZXIKPiA+IDMuIHRyaW0gdGhlIG1lYXN1cmVt
ZW50IGxpc3QgdXAgdG8gdGhlIChmaXJzdC9sYXN0L050aCkgSU1BIGNyaXRpY2FsIGRhdGEgcmVj
b3JkCj4gPgo+ID4gU2luY2UgdGhlIHR3byBmZWF0dXJlcyBjb3VsZCBiZSB1c2VkIGluZGVwZW5k
ZW50bHkgb2YgZWFjaCBvdGhlciwgdGhlcmUgaXMgbm8KPiA+IHJlYXNvbiB0byB1cHN0cmVhbSB0
aGVtIGFzIGEgc2luZ2xlIHBhdGNoIHNldC4gIEl0IGp1c3QgbWFrZXMgaXQgaGFyZGVyIHRvCj4g
PiByZXZpZXcuCj4gCj4gSSBkb24ndCBzZWUgbXVjaCBwb2ludCBpbiByZWNvcmRpbmcgYSBzbmFw
c2hvdCBhZ2dyZWdhdGUgaWYgeW91IGFyZW4ndAo+IGRvaW5nIGEgc25hcHNob3QsIGJ1dCBpdCdz
IG5vdCBoYXJtZnVsIGluIGFueSB3YXksIHNvIHN1cmUsIGdvIGZvciBpdC4KPiBMaWtlIEkgc2Fp
ZCBlYXJsaWVyLCBhcyBsb25nIGFzIHRoZSBmdW5jdGlvbmFsaXR5IGlzIHRoZXJlLCBJIGRvbid0
Cj4gdGhpbmsgYW55b25lIGNhcmVzIHRvbyBtdWNoIGhvdyBpdCBnZXRzIGludG8gdGhlIGtlcm5l
bCAoYWx0aG91Z2gKPiBUdXNoYXIgYW5kIFN1c2ggc2hvdWxkIGNvbW1lbnQgZnJvbSB0aGUgcGVy
c3BlY3RpdmUpLgoKUGF1bCwgdGhlcmUgYXJlIHR3byBmZWF0dXJlczogCi0gdHJpbW1pbmcgdGhl
IG1lYXN1cmVtZW50IGxpc3QKLSBkZWZpbmluZyBhbmQgaW5jbHVkaW5nIGFuIElNQSBjcml0aWNh
bCBkYXRhIHJlY29yZAoKVGhlIG9yaWdpbmFsIGRlc2lnbiBkb2MgY29tYmluZWQgdGhlc2UgdHdv
IGZlYXR1cmVzIG1ha2luZyB0aGVtIGFuICJhdG9taWMiCm9wZXJhdGlvbiBhbmQgcmVmZXJyZWQg
dG8gaXQgYXMgYSBzbmFwc2hvdC4gIEF0IHRoZSB0aW1lIHRoZSB0ZXJtICJzbmFwc2hvdCIgd2Fz
CmFuIGFwcHJvcHJpYXRlIHRlcm0gZm9yIHRoZSBJTUEgY3JpdGljYWwgcmVjb3JkLiAgTm93IG5v
dCBzbyBtdWNoLgoKVGhlc2UgYXJlIHR3byBzZXBhcmF0ZSwgaW5kZXBlbmRlbnQgZmVhdHVyZXMu
ICBUcmltbWluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdApzaG91bGQgbm90IGJlIGRlcGVuZGVudCBv
biB0aGUgSU1BIGNyaXRpY2FsIGRhdGEgcmVjb3JkLiAgVGhlIElNQSBjcml0aWNhbCBkYXRhCnJl
Y29yZCBzaG91bGQgbm90IGJlIGRlcGVuZGVudCBvbiB0cmltbWluZyB0aGUgbWVhc3VyZW1lbnQg
bGlzdC4gIFRyaW1taW5nIHRoZQptZWFzdXJlbWVudCBsaXN0IHVwIHRvIHRoZSAoZmlyc3QvbGFz
dC9OdGgpIGNyaXRpY2FsIGRhdGEgcmVjb3JkIHNob3VsZCBiZQpvcHRpb25hbC4KCj4gCj4gPiA+
ID4gQXMgSSdtIHN1cmUgeW91J3JlIGF3YXJlLCBTRWxpbnV4IGRlZmluZXMgdHdvIGNyaXRpY2Fs
LWRhdGEgcmVjb3Jkcy4KPiA+ID4gPiBGcm9tIHNlY3VyaXR5L3NlbGludXgvaW1hLmM6Cj4gPiA+
ID4KPiA+ID4gPiAgICAgICAgIGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInNlbGludXgiLCAi
c2VsaW51eC1zdGF0ZSIsCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0YXRlX3N0ciwgc3RybGVuKHN0YXRlX3N0ciksIGZhbHNlLAo+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCAwKTsKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAg
aW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgic2VsaW51eCIsICJzZWxpbnV4LXBvbGljeS1oYXNo
IiwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9saWN5LCBwb2xp
Y3lfbGVuLCB0cnVlLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBO
VUxMLCAwKTsKPiA+ID4KPiA+ID4gWWVwLCBidXQgdGhlcmUgaXMgZmFyIG1vcmUgdG8gdGhpcyB0
aGFuIFNFTGludXguCj4gPgo+ID4gT25seSBpZiB5b3UgY29uZmxhdGUgdGhlIHR3byBmZWF0dXJl
cy4KPiAKPiBJZiB0aGF0IGlzIGEgY2xldmVyIHJldG9ydCwgeW91J2xsIG5lZWQgdG8gZWxhYm9y
YXRlIGEgYml0IGFzIGl0Cj4gZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUuICBUaGUgSU1B
IG1lYXN1cmVtZW50IGxvZyBzbmFwc2hvdCBpcwo+IGluZGVwZW5kZW50IGZyb20gU0VMaW51eDsg
dGhlIG9ubHkgY29ubmVjdGlvbiBpcyB0aGF0IHllcywgSU1BIGRvZXMKPiBtZWFzdXJlIFNFTGlu
dXggInRoaW5ncyIgYnV0IHRoYXQgaXMgbm8gZGlmZmVyZW50IGZyb20gYW55IG90aGVyCj4gc3lz
dGVtIGF0dHJpYnV0ZSB0aGF0IGlzIG1lYXN1cmVkIGJ5IElNQS4KClRoZSBJTUEgY3JpdGljYWwg
ZGF0YSByZWNvcmQgc2hvdWxkIG5vdCBiZSB0aGF0IGRpZmZlcmVudCBvciBtb3JlIGRpZmZpY3Vs
dCwKdGhhbiB0aGUgU0VMaW51eCBjcml0aWNhbCBkYXRhIHJlY29yZC4gIE9ubHkgaWYgeW91IGNv
bmZsYXRlIHRoZSB0d28gZmVhdHVyZXMKYmVpbmcgZGlzY3Vzc2VkIC0gdHJpbW1pbmcgdGhlIElN
QSBtZWFzdXJlbWVudCBsaXN0IGFuZCB0aGUgSU1BIGNyaXRpY2FsIGRhdGEKcmVjb3JkIC0gZG9l
cyBpdCBiZWNvbWUgImZhciBtb3JlIi4KCi0tICAKTWltaSAgCgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
