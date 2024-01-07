Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37907C47073
	for <kexec@archiver.kernel.org>; Sun,  7 Jan 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pG1xJJkE7yHz7gwmF/QZcuogVYRE3Hnh/c9BnkGgxE0=; b=meeeLVbGGOJHWV
	HqVMlgK05H7CxKBR+Lb8waBDgqcF5jWe8RrJLDZGJEzalTCxI2ETc7+UlkkJEGmo33Oiygd2Vtgqr
	BQdmwPFfCsIGceuYUdf3GPeCLs3OfI5MOYfKfYIIz+RSGNwUGBM7YCPz0FVFJ0QwKddKWGmiDWlHM
	4a1LeTT1rt5j68U46hPqPWRRkQgJ8U2LL5sGJT2hdf0n7/bfDGP8n3QeQS/90F4L/6DBCCUEi3vkm
	FapAq+Gj4huJFwks5/gLwQ5mkOqOGfZ1bq1cqNqkLonoVVVQ6UecREcaVfoY+U7e25kQInM5HqUmW
	mBQeRuQLFFl3VAvWfQNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMSkR-003334-0D;
	Sun, 07 Jan 2024 12:59:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMSkN-00332k-1i
	for kexec@lists.infradead.org;
	Sun, 07 Jan 2024 12:59:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4078O8b6019873;
	Sun, 7 Jan 2024 12:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gFKCfVd8WMaaYOR3I+/w/TLTL/xeZZvqBbvnWEWLMts=;
 b=HTRZny/F4DkN2jyWJA1xLNx4zb5oE9eXikJSvSM3HoAwnP0CANUJMtNo4IkPsI9imjNN
 XKWHY/no8KlKtjVy0nnuP/dXgAsFpUmI45WtBfir6b0bbj5KQKUAVqGIo2RFoAHVPd9B
 85sDczD1MvruVWzd2NyAiaK/IWjvTLb1DQjYKwCPk/EO5AqENNmnoDrw0qqmUcJ7tztR
 lXovCunWSarXb63QSlPQlyQjZEqm55Z0b5NSql5NEQpsaNOqsJzKRxHeE/HCa/J6y+F+
 putxcjEj9CWAbMTa8J3IQO/3iXXu3gIaerwRLhakQXZY5p/scSmEm9B+Rq2/DTKmzYLg tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf5xb2ghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 12:58:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 407Cspcg016197;
	Sun, 7 Jan 2024 12:58:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf5xb2ghe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 12:58:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4079fXYQ022916;
	Sun, 7 Jan 2024 12:58:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6n2f2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 12:58:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 407Cwv5127525840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jan 2024 12:58:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2092258052;
	Sun,  7 Jan 2024 12:58:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387A95805A;
	Sun,  7 Jan 2024 12:58:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.155.63])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jan 2024 12:58:56 +0000 (GMT)
Message-ID: <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
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
Date: Sun, 07 Jan 2024 07:58:55 -0500
In-Reply-To: <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
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
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HGYwzRELB86_3TyvN9BK5kks9MkoaPH4
X-Proofpoint-ORIG-GUID: mlqcBnZWcsCW3I-1kxp7viweboNw9usP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_07,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401070062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_045923_934194_857780E8 
X-CRM114-Status: GOOD (  47.88  )
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

T24gU2F0LCAyMDI0LTAxLTA2IGF0IDE4OjI3IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFR1ZSwgTm92IDI4LCAyMDIzIGF0IDk6MDfigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyMy0xMS0yOCBhdCAyMDowNiAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgNzowOeKAr0FNIE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgMjAy
My0xMS0yNyBhdCAxNzoxNiAtMDUwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiA+IE9uIE1v
biwgTm92IDI3LCAyMDIzIGF0IDEyOjA44oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJt
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwgMjAyMy0xMS0yMiBhdCAwOToyMiAtMDUw
MCwgUGF1bCBNb29yZSB3cm90ZToKPiAKPiAuLi4KPiAKPiA+ID4gPiA+ID4gQmVmb3JlIGRlZmlu
aW5nIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkLCB3ZSBuZWVkIHRvIGRlY2lkZSB3aGV0aGVy
Cj4gPiA+ID4gPiA+IGl0IGlzIHJlYWxseSBuZWNlc3Nhcnkgb3IgaWYgaXQgaXMgcmVkdW5kYW50
LiAgSWYgd2UgZGVmaW5lIGEgbmV3Cj4gPiA+ID4gPiA+ICJjcml0aWNhbC1kYXRhIiByZWNvcmQs
IGNhbiBpdCBiZSBkZWZpbmVkIHN1Y2ggdGhhdCBpdCBkb2Vzbid0IHJlcXVpcmUKPiA+ID4gPiA+
ID4gcGF1c2luZyBleHRlbmRpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3Q/ICBGb3IgZXhhbXBsZSwg
YSBuZXcgc2ltcGxlCj4gPiA+ID4gPiA+IHZpc3VhbCBjcml0aWNhbC1kYXRhIHJlY29yZCBjb3Vs
ZCBjb250YWluIHRoZSBudW1iZXIgb2YgcmVjb3JkcyAoZS5nLgo+ID4gPiA+ID4gPiA8c2VjdXJp
dHlmcz4vaW1hL3J1bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50KSB1cCB0byB0aGF0IHBvaW50Lgo+
ID4gPiA+ID4KPiA+ID4gPiA+IFdoYXQgaWYgdGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSB3YXMgYSBo
YXNoIG9mIHRoZSBtZWFzdXJlbWVudCBsb2cKPiA+ID4gPiA+IHN0YXJ0aW5nIHdpdGggZWl0aGVy
IHRoZSBib290X2FnZ3JlZ2F0ZSBvciB0aGUgbGF0ZXN0Cj4gPiA+ID4gPiBzbmFwc2hvdF9hZ2dy
ZWdhdGUgYW5kIGVuZGluZyBvbiB0aGUgcmVjb3JkIGJlZm9yZSB0aGUgbmV3Cj4gPiA+ID4gPiBz
bmFwc2hvdF9hZ2dyZWdhdGU/ICBUaGUgcGVyZm9ybWFuY2UgaW1wYWN0IGF0IHNuYXBzaG90IHRp
bWUgc2hvdWxkIGJlCj4gPiA+ID4gPiBtaW5pbWFsIGFzIHRoZSBoYXNoIGNhbiBiZSBpbmNyZW1l
bnRhbGx5IHVwZGF0ZWQgYXMgbmV3IHJlY29yZHMgYXJlCj4gPiA+ID4gPiBhZGRlZCB0byB0aGUg
bWVhc3VyZW1lbnQgbGlzdC4gIFdoaWxlIHRoZSBoYXNoIHdvdWxkbid0IGNhcHR1cmUgdGhlCj4g
PiA+ID4gPiBUUE0gc3RhdGUsIGl0IHdvdWxkIGFsbG93IHNvbWUgY3J1ZGUgdmVyaWZpY2F0aW9u
IHdoZW4gcmVhc3NlbWJsaW5nCj4gPiA+ID4gPiB0aGUgbG9nLiAgSWYgb25lIGNvdWxkIGJlYXIg
dGhlIGNvc3Qgb2YgYSBUUE0gc2lnbmluZyBvcGVyYXRpb24sIHRoZQo+ID4gPiA+ID4gbG9nIGRp
Z2VzdCBjb3VsZCBiZSBzaWduZWQgYnkgdGhlIFRQTS4KPiA+ID4gPgo+ID4gPiA+IE90aGVyIGNy
aXRpY2FsIGRhdGEgaXMgY2FsY3VsYXRlZCwgYmVmb3JlIGNhbGxpbmcKPiA+ID4gPiBpbWFfbWVh
c3VyZV9jcml0aWNhbF9kYXRhKCksIHdoaWNoIGFkZHMgdGhlIHJlY29yZCB0byB0aGUgbWVhc3Vy
ZW1lbnQKPiA+ID4gPiBsaXN0IGFuZCBleHRlbmRzIHRoZSBUUE0gUENSLgo+ID4gPiA+Cj4gPiA+
ID4gU2lnbmluZyB0aGUgaGFzaCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUgaWYgaXQgYmVoYXZlcyBs
aWtlIG90aGVyCj4gPiA+ID4gY3JpdGljYWwgZGF0YS4KPiA+ID4gPgo+ID4gPiA+IEluIGFkZGl0
aW9uIHRvIHRoZSBoYXNoLCBjb25zaWRlciBpbmNsdWRpbmcgb3RoZXIgaW5mb3JtYXRpb24gaW4g
dGhlCj4gPiA+ID4gbmV3IGNyaXRpY2FsIGRhdGEgcmVjb3JkIChlLmcuIHRvdGFsIG51bWJlciBv
ZiBtZWFzdXJlbWVudCByZWNvcmRzLCB0aGUKPiA+ID4gPiBudW1iZXIgb2YgbWVhc3VyZW1lbnRz
IGluY2x1ZGVkIGluIHRoZSBoYXNoLCB0aGUgbnVtYmVyIG9mIHRpbWVzIHRoZQo+ID4gPiA+IG1l
YXN1cmVtZW50IGxpc3Qgd2FzIHRyaW1tZWQsIGV0YykuCj4gPiA+Cj4gPiA+IEl0IHdvdWxkIGJl
IG5pY2UgaWYgeW91IGNvdWxkIHByb3ZpZGUgYW4gZXhwbGljaXQgbGlzdCBvZiB3aGF0IHlvdQo+
ID4gPiB3b3VsZCB3YW50IGhhc2hlZCBpbnRvIGEgc25hcHNob3RfYWdncmVnYXRlIHJlY29yZDsg
dGhlIGFib3ZlIGlzCj4gPiA+IGNsb3NlLCBidXQgaXQgaXMgc3RpbGwgYSBsaXR0bGUgaGFuZC13
YXZ5LiAgSSdtIGp1c3QgdHJ5aW5nIHRvIHJlZHVjZQo+ID4gPiB0aGUgYmFjay1uLWZvcnRoIDop
Cj4gPgo+ID4gV2hhdCBpcyBiZWluZyBkZWZpbmVkIGhlcmUgaXMgdGhlIGZpcnN0IElNQSBjcml0
aWNhbC1kYXRhIHJlY29yZCwgd2hpY2gKPiA+IHJlYWxseSByZXF1aXJlcyBzb21lIHRob3VnaHQu
Cj4gCj4gTXkgdGhpbmtpbmcgaGFzIGFsd2F5cyBiZWVuIHRoYXQgdGFraW5nIGEgaGFzaCBvZiB0
aGUgY3VycmVudAo+IG1lYXN1cmVtZW50IGxvZyB1cCB0byB0aGUgc25hcHNob3QgcG9pbnQgd291
bGQgYmUgYSBuaWNlCj4gc25hcHNob3RfYWdncmVnYXRlIG1lYXN1cmVtZW50LCBidXQgSSdtIG5v
dCBoZWF2aWx5IGludmVzdGVkIGluIHRoYXQuCj4gVG8gbWUgaXQgaXMgbW9yZSBpbXBvcnRhbnQg
dGhhdCB3ZSBmaW5kIHNvbWV0aGluZyB3ZSBjYW4gYWxsIGFncmVlIG9uLAo+IHBlcmhhcHMgcmVs
dWN0YW50bHksIHNvIHdlIGNhbiBtb3ZlIGZvcndhcmQgd2l0aCBhIHNvbHV0aW9uLgo+IAo+ID4g
Rm9yIGVhc2Ugb2YgcmV2aWV3LCB0aGlzIG5ldyBjcml0aWNhbC0KPiA+IGRhdGEgcmVjb3JkIHNo
b3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoIHNldCBmcm9tIHRyaW1taW5nIHRoZQo+ID4gbWVhc3Vy
ZW1lbnQgbGlzdC4KPiAKPiBJIHNlZSB0aGUgdHdvIGFzIGxpbmtlZCwgYnV0IGlmIHlvdSBwcmVm
ZXIgdGhlbSBhcyBzZXBhcmF0ZSB0aGVuIHNvIGJlCj4gaXQuICBPbmNlIGFnYWluLCB0aGUgaW1w
b3J0YW50IHBhcnQgaXMgdG8gbW92ZSBmb3J3YXJkIHdpdGggYQo+IHNvbHV0aW9uLCBJJ20gbm90
IG92ZXJseSBib3RoZXJlZCBpZiBpdCBhcnJpdmVzIGluIG11bHRpcGxlIHBpZWNlcwo+IGluc3Rl
YWQgb2Ygb25lLgoKVHJpbW1pbmcgdGhlIElNQSBtZWFzdXJlbWVudCBsaXN0IGNvdWxkIGJlIHVz
ZWQgaW4gY29uanVuY3Rpb24gd2l0aCB0aGUgbmV3IElNQQpjcml0aWNhbCBkYXRhIHJlY29yZCBv
ciBpbmRlcGVuZGVudGx5LiAgQm90aCBvcHRpb25zIHNob3VsZCBiZSBzdXBwb3J0ZWQuCgoxLiB0
cmltIE4gbnVtYmVyIG9mIHJlY29yZHMgZnJvbSB0aGUgaGVhZCBvZiB0aGUgaW4ga2VybmVsIElN
QSBtZWFzdXJlbWVudCBsaXN0CjIuIGludGVybWl0dGVudGx5IGluY2x1ZGUgdGhlIG5ldyBJTUEg
Y3JpdGljYWwgZGF0YSByZWNvcmQgYmFzZWQgb24gc29tZSB0cmlnZ2VyCjMuIHRyaW0gdGhlIG1l
YXN1cmVtZW50IGxpc3QgdXAgdG8gdGhlIChmaXJzdC9sYXN0L050aCkgSU1BIGNyaXRpY2FsIGRh
dGEgcmVjb3JkCgpTaW5jZSB0aGUgdHdvIGZlYXR1cmVzIGNvdWxkIGJlIHVzZWQgaW5kZXBlbmRl
bnRseSBvZiBlYWNoIG90aGVyLCB0aGVyZSBpcyBubwpyZWFzb24gdG8gdXBzdHJlYW0gdGhlbSBh
cyBhIHNpbmdsZSBwYXRjaCBzZXQuICBJdCBqdXN0IG1ha2VzIGl0IGhhcmRlciB0bwpyZXZpZXcu
Cgo+IAo+ID4gQXMgSSdtIHN1cmUgeW91J3JlIGF3YXJlLCBTRWxpbnV4IGRlZmluZXMgdHdvIGNy
aXRpY2FsLWRhdGEgcmVjb3Jkcy4KPiA+IEZyb20gc2VjdXJpdHkvc2VsaW51eC9pbWEuYzoKPiA+
Cj4gPiAgICAgICAgIGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInNlbGludXgiLCAic2VsaW51
eC1zdGF0ZSIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdGVfc3Ry
LCBzdHJsZW4oc3RhdGVfc3RyKSwgZmFsc2UsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTlVMTCwgMCk7Cj4gPgo+ID4gICAgICAgICBpbWFfbWVhc3VyZV9jcml0aWNhbF9k
YXRhKCJzZWxpbnV4IiwgInNlbGludXgtcG9saWN5LWhhc2giLAo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBvbGljeSwgcG9saWN5X2xlbiwgdHJ1ZSwKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCAwKTsKPiAKPiBZZXAsIGJ1dCB0aGVyZSBp
cyBmYXIgbW9yZSB0byB0aGlzIHRoYW4gU0VMaW51eC4KCk9ubHkgaWYgeW91IGNvbmZsYXRlIHRo
ZSB0d28gZmVhdHVyZXMuIAoKTWltaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
