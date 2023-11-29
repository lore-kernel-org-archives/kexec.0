Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD70C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vn1n64n9VzTb+Sb1TmnsoOttEAv0w2sRS/mP061zzFo=; b=uz02SsyjKCw3hK
	QxP2KM/xQRyvuT2EhgLSbRRhLACb2ywJyOLP3X9ineMPFsmC74tAXmLXJB069HW8FDLjqp7i5t0Th
	AZp76twel8WGXYJKEv4sMswQvyzRlOVqVvJ+67sJ0/Q3NHaM2WQ35+CnaIvC/KaqcoeysoIHBI3qQ
	f3WyaMX17tzqosLGgy62qg0joH6F0ZiaiTpBy/mUwupG7Zd68iLSXXi0jjTNQVZnfo68qfeiLkM6D
	YAmbmoDoPbUznSLp6nsIDIcmn7ZTy00ZuIdvlBGEqU5gey84buH1G0wt/QOEaw384nh6tCJioI57S
	hxqkcyCJwFuxoTo3PvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r89zC-006oj2-1t;
	Wed, 29 Nov 2023 02:07:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r89zA-006oid-0C
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 02:07:33 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT1oZug013562;
	Wed, 29 Nov 2023 02:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=q69/ySyS1Q13h0fb7iRkfeR2Gyxb8mm8SutU+U1NBCo=;
 b=ddCZ72ERO9u5xLUNZ0KgUPvbDS1AItd6s9DmTU0oNUx7yV4s7xh61XT5GLT1xAo7r/7h
 tZedPmFWZZ6ksx3UtGvMfDrNxbMtQmA7Ca/vn2cIBRPsZJCM+D/p1e12FxkH539meNgA
 +tzWNPpqNLz6NviQb2vMZ8QQQwH4MOfWadhiDzNSLFzUzRrUFdBLBBceD2vqNIRmfbS1
 6ygELXxh97z2qtL0cUczYkgEe9obT5FJndukAf3slKr6QUSiGJnb3tu1N99cx4IIsWcf
 8g+K29rjjtvEBjCCVC9RUzO593lxWPcoqszilfq7XCyjNFiPc8qegcZ8XNPkXsjeiOc2 xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unts31v2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT1pSVM015527;
	Wed, 29 Nov 2023 02:07:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unts31v2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT2590B004934;
	Wed, 29 Nov 2023 02:07:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk3yhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT276NL25363010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 02:07:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B262258045;
	Wed, 29 Nov 2023 02:07:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0636B58050;
	Wed, 29 Nov 2023 02:07:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.89.136])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Nov 2023 02:07:04 +0000 (GMT)
Message-ID: <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
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
Date: Tue, 28 Nov 2023 21:07:04 -0500
In-Reply-To: <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
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
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Oy_5AgL3qk6lrf4NBu9pEZ_-IEp22cBj
X-Proofpoint-ORIG-GUID: Y_lDUo6oEI5OG36TRnxNJxEgCg-F7XtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=986
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_180732_326560_75519C05 
X-CRM114-Status: GOOD (  52.27  )
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

T24gVHVlLCAyMDIzLTExLTI4IGF0IDIwOjA2IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFR1ZSwgTm92IDI4LCAyMDIzIGF0IDc6MDnigK9BTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIE1vbiwgMjAyMy0xMS0yNyBhdCAxNzoxNiAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMTI6MDjigK9QTSBN
aW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIDIw
MjMtMTEtMjIgYXQgMDk6MjIgLTA1MDAsIFBhdWwgTW9vcmUgd3JvdGU6Cj4gCj4gLi4uCj4gCj4g
PiA+IElmIHdlIGFyZSBnb2luZyB0byBoYXZlIGEgcmVjb3JkIGNvdW50LCBJIGltYWdpbmUgaXQg
d291bGQgYWxzbyBiZQo+ID4gPiBoZWxwZnVsIHRvIG1haW50YWluIGEgc2VjdXJpdHlmcyBmaWxl
IHdpdGggdGhlIHRvdGFsIHNpemUgKGluIGJ5dGVzKQo+ID4gPiBvZiB0aGUgaW4tbWVtb3J5IG1l
YXN1cmVtZW50IGxvZy4gIEluIGZhY3QsIEkgc3VzcGVjdCB0aGlzIHdpbGwKPiA+ID4gcHJvYmFi
bHkgYmUgbW9yZSB1c2VmdWwgZm9yIHRob3NlIHdobyB3aXNoIHRvIG1hbmFnZSB0aGUgc2l6ZSBv
ZiB0aGUKPiA+ID4gbWVhc3VyZW1lbnQgbG9nLgo+ID4KPiA+IEEgcnVubmluZyBudW1iZXIgb2Yg
Ynl0ZXMgbmVlZGVkIGZvciBjYXJyeWluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdAo+ID4gYWNyb3Nz
IGtleGVjIGFscmVhZHkgZXhpc3RzLiAgVGhpcyB2YWx1ZSB3b3VsZCBiZSBhZmZlY3RlZCB3aGVu
IHRoZQo+ID4gbWVhc3VyZW1lbnQgbGlzdCBpcyB0cmltbWVkLgo+IAo+IFRoZXJlIHdlIGdvLCBp
dCBzaG91bGQgYmUgdHJpdmlhbCB0byBleHBvcnQgdGhhdCBpbmZvcm1hdGlvbiB2aWEgc2VjdXJp
dHlmcy4KPiAKPiA+ID4gPiBEZWZpbmluZyBvdGhlciBJTUEgc2VjdXJpdHlmcyBmaWxlcyBsaWtl
Cj4gPiA+ID4gaG93IG1hbnkgdGltZXMgdGhlIG1lYXN1cmVtZW50IGxpc3QgaGFzIGJlZW4gdHJp
bW1lZCBtaWdodCBiZQo+ID4gPiA+IGJlbmVmaWNpYWwgYXMgd2VsbC4KPiA+ID4KPiA+ID4gSSBo
YXZlIG5vIG9iamVjdGlvbiB0byB0aGF0LiAgV291bGQgYSB0b3RhbCByZWNvcmQgY291bnQsIGku
ZS4gYSB2YWx1ZQo+ID4gPiB0aGF0IGRvZXNuJ3QgcmVzZXQgb24gYSBzbmFwc2hvdCBldmVudCwg
YmUgbW9yZSB1c2VmdWwgaGVyZT8KPiA+Cj4gPiA8c2VjdXJpdHlmcz4vaW1hL3J1bnRpbWVfbWVh
c3VyZW1lbnRzX2NvdW50IGFscmVhZHkgZXhwb3J0cyB0aGUgdG90YWwKPiA+IG51bWJlciBvZiBt
ZWFzdXJlbWVudCByZWNvcmRzLgo+IAo+IEkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzIHdvdWxkIHlv
dSB3YW50ICdydW50aW1lX21lYXN1cmVtZW50c19jb3VudCcgdG8KPiByZWZsZWN0IHRoZSBjdXJy
ZW50L3RyaW1tZWQgbG9nIHNpemUgb3Igd291bGQgeW91IHdhbnQgaXQgdG8gcmVmbGVjdAo+IGh0
aGUgbWVhc3VyZW1lbnRzIHNpbmNlIHRoZSBpbml0aWFsIGNvbGQgYm9vdD8gIFByZXN1bWFibHkg
d2Ugd291bGQKPiB3YW50IHRvIGFkZCBhbm90aGVyIHNlY3VyaXR5ZnMgZmlsZSB0byBoYW5kbGUg
dGhlIGNhc2Ugbm90IGNvdmVyZWQgYnkKPiAncnVudGltZV9tZWFzdXJlbWVudHNfY291bnQnLgoK
UmlnaHQuICA8c2VjdXJpdHlmcz4vaW1hL3J1bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50IGlzIGRl
ZmluZWQgYXMgdGhlCnRvdGFsIG51bWJlciBvZiBtZWFzdXJlbWVudHMgc2luY2UgYm9vdC4gIFdo
ZW4gdGhlIG1lYXN1cmVtZW50IGxpc3QgaXMKY2FycmllZCBhY3Jvc3Mga2V4ZWMsIGl0IGlzIHRo
ZSBudW1iZXIgb2YgbWVhc3VyZW1lbnRzIHNpbmNlIGNvbGQgYm9vdC4KCkEgbmV3IHNlY3VyaXR5
ZnMgZmlsZSBzaG91bGQgYmUgZGVmaW5lZCBmb3IgdGhlIGN1cnJlbnQgbnVtYmVyIG9mIGluCmtl
cm5lbCBtZW1vcnkgcmVjb3Jkcy4gIFVubGVzcyB0aGUgbWVhc3VyZW1lbnQgbGlzdCBoYXMgYmVl
biB0cmltbWVkLAp0aGlzIHNob3VsZCBiZSB0aGUgc2FtZSBhcyB0aGUgcnVudGltZV9tZWFzdXJl
bWVudHNfY291bnQuCgo+IAo+ID4gPiA+IEJlZm9yZSBkZWZpbmluZyBhIG5ldyBjcml0aWNhbC1k
YXRhIHJlY29yZCwgd2UgbmVlZCB0byBkZWNpZGUgd2hldGhlcgo+ID4gPiA+IGl0IGlzIHJlYWxs
eSBuZWNlc3Nhcnkgb3IgaWYgaXQgaXMgcmVkdW5kYW50LiAgSWYgd2UgZGVmaW5lIGEgbmV3Cj4g
PiA+ID4gImNyaXRpY2FsLWRhdGEiIHJlY29yZCwgY2FuIGl0IGJlIGRlZmluZWQgc3VjaCB0aGF0
IGl0IGRvZXNuJ3QgcmVxdWlyZQo+ID4gPiA+IHBhdXNpbmcgZXh0ZW5kaW5nIHRoZSBtZWFzdXJl
bWVudCBsaXN0PyAgRm9yIGV4YW1wbGUsIGEgbmV3IHNpbXBsZQo+ID4gPiA+IHZpc3VhbCBjcml0
aWNhbC1kYXRhIHJlY29yZCBjb3VsZCBjb250YWluIHRoZSBudW1iZXIgb2YgcmVjb3JkcyAoZS5n
Lgo+ID4gPiA+IDxzZWN1cml0eWZzPi9pbWEvcnVudGltZV9tZWFzdXJlbWVudHNfY291bnQpIHVw
IHRvIHRoYXQgcG9pbnQuCj4gPiA+Cj4gPiA+IFdoYXQgaWYgdGhlIHNuYXBzaG90X2FnZ3JlZ2F0
ZSB3YXMgYSBoYXNoIG9mIHRoZSBtZWFzdXJlbWVudCBsb2cKPiA+ID4gc3RhcnRpbmcgd2l0aCBl
aXRoZXIgdGhlIGJvb3RfYWdncmVnYXRlIG9yIHRoZSBsYXRlc3QKPiA+ID4gc25hcHNob3RfYWdn
cmVnYXRlIGFuZCBlbmRpbmcgb24gdGhlIHJlY29yZCBiZWZvcmUgdGhlIG5ldwo+ID4gPiBzbmFw
c2hvdF9hZ2dyZWdhdGU/ICBUaGUgcGVyZm9ybWFuY2UgaW1wYWN0IGF0IHNuYXBzaG90IHRpbWUg
c2hvdWxkIGJlCj4gPiA+IG1pbmltYWwgYXMgdGhlIGhhc2ggY2FuIGJlIGluY3JlbWVudGFsbHkg
dXBkYXRlZCBhcyBuZXcgcmVjb3JkcyBhcmUKPiA+ID4gYWRkZWQgdG8gdGhlIG1lYXN1cmVtZW50
IGxpc3QuICBXaGlsZSB0aGUgaGFzaCB3b3VsZG4ndCBjYXB0dXJlIHRoZQo+ID4gPiBUUE0gc3Rh
dGUsIGl0IHdvdWxkIGFsbG93IHNvbWUgY3J1ZGUgdmVyaWZpY2F0aW9uIHdoZW4gcmVhc3NlbWJs
aW5nCj4gPiA+IHRoZSBsb2cuICBJZiBvbmUgY291bGQgYmVhciB0aGUgY29zdCBvZiBhIFRQTSBz
aWduaW5nIG9wZXJhdGlvbiwgdGhlCj4gPiA+IGxvZyBkaWdlc3QgY291bGQgYmUgc2lnbmVkIGJ5
IHRoZSBUUE0uCj4gPgo+ID4gT3RoZXIgY3JpdGljYWwgZGF0YSBpcyBjYWxjdWxhdGVkLCBiZWZv
cmUgY2FsbGluZwo+ID4gaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgpLCB3aGljaCBhZGRzIHRo
ZSByZWNvcmQgdG8gdGhlIG1lYXN1cmVtZW50Cj4gPiBsaXN0IGFuZCBleHRlbmRzIHRoZSBUUE0g
UENSLgo+ID4KPiA+IFNpZ25pbmcgdGhlIGhhc2ggc2hvdWxkbid0IGJlIGFuIGlzc3VlIGlmIGl0
IGJlaGF2ZXMgbGlrZSBvdGhlcgo+ID4gY3JpdGljYWwgZGF0YS4KPiA+Cj4gPiBJbiBhZGRpdGlv
biB0byB0aGUgaGFzaCwgY29uc2lkZXIgaW5jbHVkaW5nIG90aGVyIGluZm9ybWF0aW9uIGluIHRo
ZQo+ID4gbmV3IGNyaXRpY2FsIGRhdGEgcmVjb3JkIChlLmcuIHRvdGFsIG51bWJlciBvZiBtZWFz
dXJlbWVudCByZWNvcmRzLCB0aGUKPiA+IG51bWJlciBvZiBtZWFzdXJlbWVudHMgaW5jbHVkZWQg
aW4gdGhlIGhhc2gsIHRoZSBudW1iZXIgb2YgdGltZXMgdGhlCj4gPiBtZWFzdXJlbWVudCBsaXN0
IHdhcyB0cmltbWVkLCBldGMpLgo+IAo+IEl0IHdvdWxkIGJlIG5pY2UgaWYgeW91IGNvdWxkIHBy
b3ZpZGUgYW4gZXhwbGljaXQgbGlzdCBvZiB3aGF0IHlvdQo+IHdvdWxkIHdhbnQgaGFzaGVkIGlu
dG8gYSBzbmFwc2hvdF9hZ2dyZWdhdGUgcmVjb3JkOyB0aGUgYWJvdmUgaXMKPiBjbG9zZSwgYnV0
IGl0IGlzIHN0aWxsIGEgbGl0dGxlIGhhbmQtd2F2eS4gIEknbSBqdXN0IHRyeWluZyB0byByZWR1
Y2UKPiB0aGUgYmFjay1uLWZvcnRoIDopCgpXaGF0IGlzIGJlaW5nIGRlZmluZWQgaGVyZSBpcyB0
aGUgZmlyc3QgSU1BIGNyaXRpY2FsLWRhdGEgcmVjb3JkLCB3aGljaApyZWFsbHkgcmVxdWlyZXMg
c29tZSB0aG91Z2h0LiAgRm9yIGVhc2Ugb2YgcmV2aWV3LCB0aGlzIG5ldyBjcml0aWNhbC0KZGF0
YSByZWNvcmQgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggc2V0IGZyb20gdHJpbW1pbmcgdGhl
Cm1lYXN1cmVtZW50IGxpc3QuCgpBcyBJJ20gc3VyZSB5b3UncmUgYXdhcmUsIFNFbGludXggZGVm
aW5lcyB0d28gY3JpdGljYWwtZGF0YSByZWNvcmRzLiAgCkZyb20gc2VjdXJpdHkvc2VsaW51eC9p
bWEuYzoKCiAgICAgICAgaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgic2VsaW51eCIsICJzZWxp
bnV4LXN0YXRlIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlX3N0ciwg
c3RybGVuKHN0YXRlX3N0ciksIGZhbHNlLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTlVMTCwgMCk7CgogICAgICAgIGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInNlbGludXgi
LCAic2VsaW51eC1wb2xpY3ktaGFzaCIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwb2xpY3ksIHBvbGljeV9sZW4sIHRydWUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBOVUxMLCAwKTsKCi0tIAp0aGFua3MsCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
