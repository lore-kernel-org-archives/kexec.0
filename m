Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B96C0755A
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aW6TgpLtFfN89D4GBeunNjsTbKCAGRuE1JOFFedJZ8k=; b=RIQ+emDke+8MWg
	wP0pJLvDKgW3sfEgQQNvrMAmKf+18EGM912UBTCBRkByrBz8YrrQf5z/zZGhWA7fWS/094IAADlPI
	iFLRJp7Bdwhg5ywsMgXIVueha8UjZlAEn4a5G7AJkbywJqS6bhZYdT0Ma6ogtfEc+s1NuSbTpqEOJ
	Vt+ZMsk1t894tpxG5iRuZC70i302nmCUwcQJhFweg8lpEGFki5kUgfme8mXYGt8ZxOFmTMU8f3RoI
	YrKSC4vpP0s12rT1I1aTuXpY6s1Y/0BjEO/lmtQkmLWqAAPwFnzAWqfp6GezfrRiLV8EkHwdwO83n
	HhDrOqglKSPB1SYOBCbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7f5r-0035XH-1i;
	Mon, 27 Nov 2023 17:08:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7f5o-0035Sj-1D
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 17:08:22 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGIqEE024935;
	Mon, 27 Nov 2023 17:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SdXYOyFEsR3A/Q17azmhUsC6oJTh5KpTQfUstBbWeB4=;
 b=IqB4jy0pX2wfoN/MATdf3GugOKPmYfIgRIsUvrwj0Op6WvxHd5mRwdFsUWRy4nwcaSoM
 cKDGDpCAES1Lj4ty53WHucHH02X7yg3TROzk4TmkCjP+YTZLqujTUho+8xCAqsBjLt+G
 2BH440DLONrgA15UIFB3fnMC3tq9FuZhCuKqPY/nXVlhFASKDbEwPmSyvmAhVFwx3Sf7
 HIXh91tZeFhgTHeFE+7G+lPBnxyqtYx/2w5ehawZgN7tkrxFFgE2V+JSuQ0HuVDzHZUc
 brhKaYwKnPDAE+AXFZwIDwi1x3YUL0gpZf9M8qA1WHto7am0VYB53ZBbvL+F3bt0SJpb /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxh09d27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARGftfI003246;
	Mon, 27 Nov 2023 17:07:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxh09d0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGpRc1025565;
	Mon, 27 Nov 2023 17:07:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrk9xv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARH7keJ57082336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 17:07:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6C758060;
	Mon, 27 Nov 2023 17:07:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D9F5803F;
	Mon, 27 Nov 2023 17:07:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.24.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 17:07:45 +0000 (GMT)
Message-ID: <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
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
Date: Mon, 27 Nov 2023 12:07:44 -0500
In-Reply-To: <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qzRtYvMLnm7cNTjPesp9QgY9v1vPugLu
X-Proofpoint-GUID: kpFDBoidQho8vTFczMJQe8Krbzu4x7I1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_090820_517886_CC5EADB2 
X-CRM114-Status: GOOD (  59.71  )
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

T24gV2VkLCAyMDIzLTExLTIyIGF0IDA5OjIyIC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFdlZCwgTm92IDIyLCAyMDIzIGF0IDg6MTjigK9BTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAyMzoyNyAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgNToyOOKAr1BNIFBh
dWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgT2N0
IDMxLCAyMDIzIGF0IDM6MTXigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToKPiA+ID4KPiA+ID4gLi4uCj4gPiA+Cj4gPiA+ID4gPiBVc2Vyc3BhY2UgY2FuIGFscmVh
ZHkgZXhwb3J0IHRoZSBJTUEgbWVhc3VyZW1lbnQgbGlzdChzKSB2aWEgdGhlCj4gPiA+ID4gPiBz
ZWN1cml0eWZzIHthc2NpaSxiaW5hcnl9X3J1bnRpbWVfbWVhc3VyZW1lbnRzIGZpbGUocykgYW5k
IGRvIHdoYXRldmVyCj4gPiA+ID4gPiBpdCB3YW50cyB3aXRoIGl0LiAgQWxsIHRoYXQgaXMgbWlz
c2luZyBpbiB0aGUga2VybmVsIGlzIHRoZSBhYmlsaXR5IHRvCj4gPiA+ID4gPiB0cmltIHRoZSBt
ZWFzdXJlbWVudCBsaXN0LCB3aGljaCBkb2Vzbid0IHNlZW0gYWxsIHRoYXQgY29tcGxpY2F0ZWQu
Cj4gPiA+ID4KPiA+ID4gPiBGcm9tIG15IHBlcnNwZWN0aXZlIHdoYXQgaGFzIGJlZW4gcHJlc2Vu
dGVkIGlzIGJhc2ljYWxseSBqdXN0IHRyaW1taW5nCj4gPiA+ID4gdGhlIGluLW1lbW9yeSBtZWFz
dXJlbWVudCBsb2csIHRoZSBhZGRpdGlvbmFsIGNvbXBsZXhpdHkgKHdoaWNoIHJlYWxseQo+ID4g
PiA+IGRvZXNuJ3QgbG9vayB0aGF0IGJhZCBJTU8pIGlzIHRoZXJlIHRvIGVuc3VyZSByb2J1c3Ru
ZXNzIGluIHRoZSBmYWNlCj4gPiA+ID4gb2YgYW4gdW5yZWxpYWJsZSB1c2Vyc3BhY2UgKHByb2Nl
c3NlcyBkaWUsIGdldCBraWxsZWQsIGV0Yy4pIGFuZCB0bwo+ID4gPiA+IGVzdGFibGlzaCBhIG5l
dywgdHJhbnNpdGl2ZSByb290IG9mIHRydXN0IGluIHRoZSBuZXdseSB0cmltbWVkCj4gPiA+ID4g
aW4tbWVtb3J5IGxvZy4KPiA+ID4gPgo+ID4gPiA+IEkgc3VwcG9zZSBvbmUgY291bGQgc2ltcGxp
ZnkgdGhpbmdzIGdyZWF0bHkgYnkgaGF2aW5nIGEgZGVzaWduIHdoZXJlCj4gPiA+ID4gdXNlcnNw
YWNlICBjYXB0dXJlcyB0aGUgbWVhc3VyZW1lbnQgbG9nIGFuZCB0aGVuIHdyaXRlcyB0aGUgbnVt
YmVyIG9mCj4gPiA+ID4gbWVhc3VyZW1lbnQgcmVjb3JkcyB0byB0cmltIGZyb20gdGhlIHN0YXJ0
IG9mIHRoZSBtZWFzdXJlbWVudCBsb2cgdG8gYQo+ID4gPiA+IHN5c2ZzIGZpbGUgYW5kIHRoZSBr
ZXJuZWwgYWN0cyBvbiB0aGF0LiAgWW91IGNvdWxkIGRvIHRoaXMgd2l0aCwgb3IKPiA+ID4gPiB3
aXRob3V0LCB0aGUgc25hcHNob3RfYWdncmVnYXRlIGVudHJ5IGNvbmNlcHQ7IGluIGZhY3QgdGhh
dCBjb3VsZCBiZQo+ID4gPiA+IHNvbWV0aGluZyB0aGF0IHdhcyBjb250cm9sbGVkIGJ5IHVzZXJz
cGFjZSwgZS5nLiB3cml0ZSB0aGUgbnVtYmVyIG9mCj4gPiA+ID4gbGluZXMgYW5kIGEgZmxhZyB0
byBpbmRpY2F0ZSBpZiBhIHNuYXBzaG90X2FnZ3JlZ2F0ZSB3YXMgZGVzaXJlZCB0bwo+ID4gPiA+
IHRoZSBzeXNmcyBmaWxlLiAgSSBjYW4ndCBzYXkgSSd2ZSB0aG91Z2h0IGl0IGFsbCB0aGUgd2F5
IHRocm91Z2ggdG8KPiA+ID4gPiBtYWtlIHN1cmUgdGhlcmUgYXJlIG5vIGdvdGNoYXMsIGJ1dCBJ
J20gZ3Vlc3NpbmcgdGhhdCBpcyBhYm91dCBhcwo+ID4gPiA+IHNpbXBsZSBhcyBvbmUgY2FuIGdl
dC4KPiA+Cj4gPiA+ID4gSWYgdGhlcmUgaXMgc29tZXRoaW5nIGVsc2UgeW91IGhhZCBpbiBtaW5k
LCBNaW1pLCBwbGVhc2Ugc2hhcmUgdGhlCj4gPiA+ID4gZGV0YWlscy4gIFRoaXMgaXMgYSB2ZXJ5
IHJlYWwgcHJvYmxlbSB3ZSBhcmUgZmFjaW5nIGFuZCB3ZSB3YW50IHRvCj4gPiA+ID4gd29yayB0
byBnZXQgYSBzb2x1dGlvbiB1cHN0cmVhbS4KPiA+ID4KPiA+ID4gQW55IHRob3VnaHRzIG9uIHRo
aXMgTWltaT8gIFdlIGhhdmUgYSByZWFsIGludGVyZXN0IGluIHdvcmtpbmcgd2l0aAo+ID4gPiB5
b3UgdG8gc29sdmUgdGhpcyBwcm9ibGVtIHVwc3RyZWFtLCBidXQgd2UgbmVlZCBtb3JlIGRldGFp
bGVkIGZlZWRiYWNrCj4gPiA+IHRoYW4gInRvbyBjb21wbGljYXRlZCIuICBJZiB5b3UgZG9uJ3Qg
bGlrZSB0aGUgc29sdXRpb25zIHByZXNlbnRlZAo+ID4gPiB0aHVzIGZhciwgd2hhdCB0eXBlIG9m
IHNvbHV0aW9uIHdvdWxkIHlvdSBsaWtlIHRvIHNlZT8KPiA+Cj4gPiBQYXVsLCB0aGUgZGVzaWdu
IGNvcGllcyB0aGUgbWVhc3VyZW1lbnQgbGlzdCB0byBhIHRlbXBvcmFyeSAic25hcHNob3QiCj4g
PiBmaWxlLCBiZWZvcmUgdHJpbW1pbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QsIHdoaWNoIGFjY29y
ZGluZyB0byB0aGUKPiA+IGRlc2lnbiBkb2N1bWVudCBsb2NrcyB0aGUgZXhpc3RpbmcgbWVhc3Vy
ZW1lbnQgbGlzdC4gIEFuZCBmdXJ0aGVyCj4gPiBwYXVzZXMgZXh0ZW5kaW5nIHRoZSBtZWFzdXJl
bWVudCBsaXN0IHRvIGNhbGN1bGF0ZSB0aGUKPiA+ICJzbmFwc2hvdF9hZ2dyZWdhdGUiLgo+IAo+
IEkgYmVsaWV2ZSB0aGUgaW50ZW50IGlzIHRvIG9ubHkgcGF1c2UgdGhlIG1lYXN1cmVtZW50cyB3
aGlsZSB0aGUKPiBzbmFwc2hvdF9hZ2dyZWdhdGUgaXMgZ2VuZXJhdGVkLCBub3QgZm9yIHRoZSBk
dXJhdGlvbiBvZiB0aGUgZW50aXJlCj4gc25hcHNob3QgcHJvY2Vzcy4gIFRoZSBwdXJwb3NlIG9m
IHRoZSBzbmFwc2hvdF9hZ2dyZWdhdGUgaXMgdG8KPiBlc3RhYmxpc2ggYSBuZXcgcm9vdCBvZiB0
cnVzdCwgc2ltaWxhciB0byB0aGUgYm9vdF9hZ2dyZWdhdGUsIHRvIGhlbHAKPiBpbXByb3ZlIGF0
dGVzdGF0aW9uIHBlcmZvcm1hbmNlLgo+IAo+ID4gVXNlcnNwYWNlIGNhbiBleHBvcnQgdGhlIG1l
YXN1cmVtZW50IGxpc3QgYWxyZWFkeSwgc28gd2h5IHRoaXMKPiA+IGNvbXBsaWNhdGVkIGRlc2ln
bj8KPiAKPiBUaGUgY3VycmVudCBjb2RlIGhhcyBubyBwcm92aXNpb24gZm9yIHRyaW1taW5nIHRo
ZSBtZWFzdXJlbWVudCBsb2csCj4gdGhhdCdzIHRoZSBwcmltYXJ5IHJlYXNvbi4KPiAKPiA+IEFz
IEkgbWVudGlvbmVkIHByZXZpb3VzbHkgYW5kIHJlcGVhdGVkIHllc3RlcmRheSwgdGhlCj4gPiAi
c25hcHNob3RfYWdncmVnYXRlIiBpcyBhIG5ldyB0eXBlIG9mIGNyaXRpY2FsIGRhdGEgYW5kIHNo
b3VsZCBiZQo+ID4gdXBzdHJlYW1lZCBpbmRlcGVuZGVudGx5IG9mIHRoaXMgcGF0Y2ggc2V0IHRo
YXQgdHJpbXMgdGhlIG1lYXN1cmVtZW50Cj4gPiBsaXN0LiAgVHJpbW1pbmcgdGhlIG1lYXN1cmVt
ZW50IGxpc3QgY291bGQgYmUgYmFzZWQsIGFzIHlvdSBzdWdnZXN0ZWQKPiA+IG9uIHRoZSBudW1i
ZXIgb2YgcmVjb3JkcyB0byByZW1vdmUsIG9yIGl0IGNvdWxkIGJlIHVwIHRvIHRoZSBuZXh0L2xh
c3QKPiA+ICJzbmFwc2hvdF9hZ2dyZWdhdGUiIHJlY29yZC4KPiAKPiBPa2F5LCB3ZSBhcmUgc3Rh
cnRpbmcgdG8gZ2V0IGNsb3NlciwgYnV0IEknbSBzdGlsbCBtaXNzaW5nIHRoZSBwYXJ0Cj4gd2hl
cmUgeW91IHNheSAiaWYgeW91IGRvIFgsIFksIGFuZCBaLCBJJ2xsIGFjY2VwdCBhbmQgbWVyZ2Ug
dGhlCj4gc29sdXRpb24uIiAgQ2FuIHlvdSBiZSBtb3JlIGV4cGxpY2l0IGFib3V0IHdoYXQgYXBw
cm9hY2goZXMpIHlvdSB3b3VsZAo+IGJlIHdpbGxpbmcgdG8gYWNjZXB0IHVwc3RyZWFtPwoKSW5j
bHVkZWQgd2l0aCB3aGF0IGlzIHdhbnRlZC9uZWVkZWQgaXMgYW4gZXhwbGFuYXRpb24gYXMgdG8g
bXkgY29uY2VybnMKd2l0aCB0aGUgZXhpc3RpbmcgcHJvcG9zYWwuCgpGaXJzdCB3ZSBuZWVkIHRv
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBrZXJuZWwgYW5kIHVoc2Vyc3BhY2UKcmVxdWlyZW1lbnRz
LiAgKFRoZSAic25hcHNob3R0aW5nIiBkZXNpZ24gcHJvcG9zYWwgaW50ZXJtaXhlcyB0aGVtLikK
CkZyb20gdGhlIGtlcm5lbCBwZXJzZWN0aXZlLCB0aGUgTG9nIFNuYXBzaG90dGluZyBEZXNpZ24g
cHJvcG9zYWwgIkIuMQpHb2FscyIgaXMgdmVyeSBuaWNlLCBidXQgb25jZSB0aGUgbWVhc3VyZW1l
bnQgbGlzdCBjYW4gYmUgdHJpbW1lZCBpdCBpcwpyZWFsbHkgaXJyZWxldmFudC4gIFVzZXJzcGFj
ZSBjYW4gZG8gd2hhdGV2ZXIgaXQgd2FudHMgd2l0aCB0aGUKbWVhc3VyZW1lbnQgbGlzdCByZWNv
cmRzLiAgU28gaW5zdGVhZCBvZiBwYXlpbmcgbGlwIHNlcnZpY2UgdG8gd2hhdApzaG91bGQgYmUg
ZG9uZSwganVzdCBjYWxsIGl0IGFzIGl0IGlzIC0gdHJpbW1pbmcgdGhlIG1lYXN1cmVtZW50IGxp
c3QuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQp8IEIuMSBHb2FscyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUbyBhZGRy
ZXNzIHRoZSBpc3N1ZXMgZGVzY3JpYmVkIGluIHRoZSBzZWN0aW9uIGFib3ZlLCB3ZSBwcm9wb3Nl
CmVuaGFuY2VtZW50cyB0byB0aGUgSU1BIHN1YnN5c3RlbSB0byBhY2hpZXZlIHRoZSBmb2xsb3dp
bmcgZ29hbHM6CgogIGEuIFJlZHVjZSBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIEtlcm5lbCBjYXVz
ZWQgYnkgbGFyZ2VyIGluLW1lbW9yeQogICAgIElNQSBsb2dzLgoKICBiLiBQcmVzZXJ2ZSB0aGUg
c3lzdGVtJ3MgYWJpbGl0eSB0byBnZXQgcmVtb3RlbHkgYXR0ZXN0ZWQgdXNpbmcgdGhlCiAgICAg
SU1BIGxvZywgZXZlbiBhZnRlciBpbXBsZW1lbnRpbmcgdGhlIGVuaGFuY2VtZW50cyB0byByZWR1
Y2UgbWVtb3J5CiAgICAgcHJlc3N1cmUgY2F1c2VkIGJ5IHRoZSBJTUEgbG9nLiBJTUEncyBJbnRl
Z3JpdHkgZ3VhcmFudGVlcyBzaG91bGQKICAgICBiZSBtYWludGFpbmVkLgoKICBjLiBQcm92aWRl
IG1lY2hhbmlzbXMgZnJvbSBLZXJuZWwgc2lkZSB0byB0aGUgcmVtb3RlIGF0dGVzdGF0aW9uCiAg
ICAgc2VydmljZSB0byBtYWtlIHNlcnZpY2Utc2lkZSBwcm9jZXNzaW5nIG1vcmUgZWZmaWNpZW50
LgoKRnJvbSB0aGUga2VybmVsIHBlcnNwZWN0aXZlIHRoZXJlIG5lZWRzIHRvIGJlIGEgbWV0aG9k
IG9mIHRyaW1taW5nIE4KbnVtYmVyIG9mIHJlY29yZHMgZnJvbSB0aGUgaGVhZCBvZiB0aGUgbWVh
c3VyZW1lbnQgbGlzdC4gIEluIGFkZGl0aW9uCnRvIHRoZSBleGlzdGluZyBzZWN1cml0eWZzICJy
dW50aW1lIG1lYXN1cmVtZW50IGxpc3QiLCAgZGVmaW5pbmcgYSBuZXcKc2VjdXJpdHlmcyBmaWxl
IGNvbnRhaW5pbmcgdGhlIGN1cnJlbnQgY291bnQgb2YgaW4gbWVtb3J5IG1lYXN1cmVtZW50CnJl
Y29yZHMgd291bGQgYmUgYmVuZWZpY2lhbC4gIERlZmluaW5nIG90aGVyIElNQSBzZWN1cml0eWZz
IGZpbGVzIGxpa2UKaG93IG1hbnkgdGltZXMgdGhlIG1lYXN1cmVtZW50IGxpc3QgaGFzIGJlZW4g
dHJpbW1lZCBtaWdodCBiZQpiZW5lZmljaWFsIGFzIHdlbGwuICBPZiBjb3Vyc2UgcHJvcGVybHkg
ZG9jdW1lbnQgdGhlIGludGVncml0eQppbXBsaWNhdGlvbnMgYW5kIHJlcGVyY3Vzc2lvbnMgb2Yg
dGhlIG5ldyBLY29uZmlnIHRoYXQgYWxsb3dzIHRyaW1taW5nCnRoZSBtZWFzdXJlbWVudCBsaXN0
LgoKRGVmaW5pbmcgYSBzaW1wbGUgInRyaW0iIG1hcmtlciBtZWFzdXJlbWVudCByZWNvcmQgd291
bGQgYmUgYSB2aXN1YWwKaW5kaWNhdGlvbiB0aGF0IHRoZSBtZWFzdXJlbWVudCBsaXN0IGhhcyBi
ZWVuIHRyaW1tZWQuICBJIG1pZ2h0IGV2ZW4KaGF2ZSBjb21wYXJlZCBpdCB0byB0aGUgImJvb3Rf
YWdncmVnYXRlIi4gIEhvd2V2ZXIsIHRoZSBwcm9wb3NlZCBtYXJrZXIKYmFzZWQgb24gVFBNIFBD
UnMgcmVxdWlyZXMgcGF1c2luZyBleHRlbmRpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QuICAKQWx0
aG91Z2ggdGhlIFRDRyBUUE0gc3BlYyBhbGxvd3MgcmVhZGluZyBtdWx0aXBsZSBQQ1JzLCBpdCBt
YXkgZmFpbCBkdWUKdG8gdGhlIG91dHB1dCBidWZmZXIgc2l6ZS4gIFRvIGF2b2lkIFRQTSByZWFk
IG11bHRpcGxlIFBDUnMgZmFpbHVyZSwKcmVhZGluZyBvbmUgVFBNIFBDUiB2YWx1ZSBhdCBhIHRp
bWUgaXMgc2FmZXIuICBUaGUgbW9yZSBUUE0gYmFua3MgYW5kClBDUnMgbmVlZGVkIHRoZSBsb25n
ZXIgaXQgd2lsbCB0YWtlLiAgUmVtZW1iZXIgdGhpcyBjcml0aWNhbC1kYXRhCnJlY29yZCB3b24n
dCBiZSBsaW1pdGVkIHRvIGp1c3Qgc29mdHdhcmUgVFBNcywgYnV0IGNvdWxkIGJlIHVzZWQgd2l0
aApwaHlzaWNhbCBvbmVzIGFzIHdlbGwuICBGb3IgYSBwaHlzaWNhbCBUUE0sIHRoaXMgY291bGQg
YmUgb24gdGhlIG9yZGVyb2YgMjQwIG1zIHBlciBUUE0gYmFuayAoMjQgUENScykuIAoKQmVmb3Jl
IGRlZmluaW5nIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkLCB3ZSBuZWVkIHRvIGRlY2lkZSB3
aGV0aGVyCml0IGlzIHJlYWxseSBuZWNlc3Nhcnkgb3IgaWYgaXQgaXMgcmVkdW5kYW50LiAgSWYg
d2UgZGVmaW5lIGEgbmV3CiJjcml0aWNhbC1kYXRhIiByZWNvcmQsIGNhbiBpdCBiZSBkZWZpbmVk
IHN1Y2ggdGhhdCBpdCBkb2Vzbid0IHJlcXVpcmUKcGF1c2luZyBleHRlbmRpbmcgdGhlIG1lYXN1
cmVtZW50IGxpc3Q/ICBGb3IgZXhhbXBsZSwgYSBuZXcgc2ltcGxlCnZpc3VhbCBjcml0aWNhbC1k
YXRhIHJlY29yZCBjb3VsZCBjb250YWluIHRoZSBudW1iZXIgb2YgcmVjb3JkcyAoZS5nLgo8c2Vj
dXJpdHlmcz4vaW1hL3J1bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50KSB1cCB0byB0aGF0IHBvaW50
LgoKVGhlIG5ldyBjcml0aWNhbC1kYXRhIHJlY29yZCBhbmQgdHJpbW1pbmcgdGhlIG1lYXN1cmVt
ZW50IGxpc3Qgc2hvdWxkCmJlIGRpc2pvaW50IGZlYXR1cmVzLiAgSWYgdGhlIGZpcnN0IHJlY29y
ZCBhZnRlciB0cmltbWluZyB0aGUKbWVhc3VyZW1lbnQgbGlzdCBzaG91bGQgYmUgdGhlIGNyaXRp
Y2FsLWRhdGEgcmVjb3JkLCB0aGVuIHRyaW0gdGhlCm1lYXN1cmVtZW50IGxpc3QgdXAgdG8gdGhh
dCBwb2ludC4KCkZyb20gYSB1c2Vyc3BhY2UgcGVyc3BlY3RpdmUsIHRyaW1taW5nIHRoZSBtZWFz
dXJlbWVudCBsaXN0IGlzIGEgbWFqb3IKY2hhbmdlIGFuZCB3aWxsIGJyZWFrIGV4aXN0aW5nIGF0
dGVzdGF0aW9uIHJlcXVlc3RzLCB1bmxlc3MgdGhlIGNoYW5nZQppcyB0cmFuc3BhcmVudC4gIFJl
bW92aW5nICJzbmFwc2hvdHMiLyJzaGFyZHMiIHdpbGwgb2YgY291cnNlIGJyZWFrCmF0dGVzdGF0
aW9uIHJlcXVlc3RzLiAgUmVmZXIgdG8gU3RlZmFuJ3Mgc3VnZ2VzdGlvbnM6IApodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1pbnRlZ3JpdHkvMWVkMmQ3MmMtNGNiMi00OGIzLWJiMGYtYjA4
NzdmYzFlOWNhQGxpbnV4LmlibS5jb20vCgotLSAKdGhhbmtzLAoKTWltaQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
