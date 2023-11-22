Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAD9C61D97
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lsT3cueSRKxHqgz4h7vUQ7GLJELjco7X2acyphnYlrs=; b=0LbQUyT243Hgak
	HWGj1C3Qpk4AgQOD96sguQwDwHIYBSKF1iOGcxtvVRRp2lOV1oD3OJ3q6Di5fCAWqLoiP9Eb8GmQL
	768OkLVYtYtL7LO5TrgjPlet0We+zVRBjQ5LpoQH3DevNLrgGDSCBhY1a3lUE8TcEqyimgeACtdJF
	fcR0bpx763RBzDmpFq71OUXVhEPGH4yE79Gg0vuCBsjXUL6SNEK/rGpwSoHtZZQDN3hQzI2PE6Tzr
	PoWZjwIVDpoaXfFTc5GlZhTXTcJpcrVqIiKatmN5FXF+bpwHA/sX/X2G129CpCH6w14Qd+QMuIpcv
	TwoO9WApsDp2Km1Ahfhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5n7o-001vVu-0p;
	Wed, 22 Nov 2023 13:18:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5n7k-001vVB-1B
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 13:18:38 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMD9juj030220;
	Wed, 22 Nov 2023 13:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IrmURnvMILkV8BBA/aqBOUU/iNdfg2KlHJ+BlsU/afk=;
 b=TL3Ys8Loeb9W4MhwrEPIj63ZA5Q9Qj81qaodH+QWEUdJJZna9/s+IUSKFmPo9uLh/lhc
 IgASGMUGhLyDPhOa/f+78K9q4UMGhStH1SeC3TTbPU71aF14HUTDj8qFUt9WtQTshrwg
 uuKwHQOBKiby3og+5sPJZt+I98vS3ylf0Z3VEsHA/6XvyvZ2axWa2os4e5tHuG1+p7eS
 GwCPgUDTjCz2RDvRP7EqsGXHSRVM3rtHJQBlEwOM/lSMb18WAGUYCMr6XGkh6g37v3po
 qXNcMpGY1z4DmCvpSgz3Dn2jMc/d1Ywn7I1rHlJRWB6enDQT8X6dkTgSpPPeEFZj1mLO cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj9jr9be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:20 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AMDA5EQ030739;
	Wed, 22 Nov 2023 13:18:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj9jr9ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJnVt001719;
	Wed, 22 Nov 2023 13:18:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kyup8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDIHtR17826350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:18:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF195805E;
	Wed, 22 Nov 2023 13:18:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78E358059;
	Wed, 22 Nov 2023 13:18:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.52.147])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:18:15 +0000 (GMT)
Message-ID: <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
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
Date: Wed, 22 Nov 2023 08:18:15 -0500
In-Reply-To: <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0czCmu0bpYYjxWr0WuxlMnhsqfRJCMiO
X-Proofpoint-GUID: RLicAhrwV9xSmJTXUajhN8W0XzacRsR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_051836_619695_68F8FEA9 
X-CRM114-Status: GOOD (  38.78  )
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

T24gVHVlLCAyMDIzLTExLTIxIGF0IDIzOjI3IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFRodSwgTm92IDE2LCAyMDIzIGF0IDU6MjjigK9QTSBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgT2N0IDMxLCAyMDIzIGF0IDM6MTXigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiAKPiAuLi4KPiAKPiA+ID4gVXNl
cnNwYWNlIGNhbiBhbHJlYWR5IGV4cG9ydCB0aGUgSU1BIG1lYXN1cmVtZW50IGxpc3Qocykgdmlh
IHRoZQo+ID4gPiBzZWN1cml0eWZzIHthc2NpaSxiaW5hcnl9X3J1bnRpbWVfbWVhc3VyZW1lbnRz
IGZpbGUocykgYW5kIGRvIHdoYXRldmVyCj4gPiA+IGl0IHdhbnRzIHdpdGggaXQuICBBbGwgdGhh
dCBpcyBtaXNzaW5nIGluIHRoZSBrZXJuZWwgaXMgdGhlIGFiaWxpdHkgdG8KPiA+ID4gdHJpbSB0
aGUgbWVhc3VyZW1lbnQgbGlzdCwgd2hpY2ggZG9lc24ndCBzZWVtIGFsbCB0aGF0IGNvbXBsaWNh
dGVkLgo+ID4KPiA+IEZyb20gbXkgcGVyc3BlY3RpdmUgd2hhdCBoYXMgYmVlbiBwcmVzZW50ZWQg
aXMgYmFzaWNhbGx5IGp1c3QgdHJpbW1pbmcKPiA+IHRoZSBpbi1tZW1vcnkgbWVhc3VyZW1lbnQg
bG9nLCB0aGUgYWRkaXRpb25hbCBjb21wbGV4aXR5ICh3aGljaCByZWFsbHkKPiA+IGRvZXNuJ3Qg
bG9vayB0aGF0IGJhZCBJTU8pIGlzIHRoZXJlIHRvIGVuc3VyZSByb2J1c3RuZXNzIGluIHRoZSBm
YWNlCj4gPiBvZiBhbiB1bnJlbGlhYmxlIHVzZXJzcGFjZSAocHJvY2Vzc2VzIGRpZSwgZ2V0IGtp
bGxlZCwgZXRjLikgYW5kIHRvCj4gPiBlc3RhYmxpc2ggYSBuZXcsIHRyYW5zaXRpdmUgcm9vdCBv
ZiB0cnVzdCBpbiB0aGUgbmV3bHkgdHJpbW1lZAo+ID4gaW4tbWVtb3J5IGxvZy4KPiA+Cj4gPiBJ
IHN1cHBvc2Ugb25lIGNvdWxkIHNpbXBsaWZ5IHRoaW5ncyBncmVhdGx5IGJ5IGhhdmluZyBhIGRl
c2lnbiB3aGVyZQo+ID4gdXNlcnNwYWNlICBjYXB0dXJlcyB0aGUgbWVhc3VyZW1lbnQgbG9nIGFu
ZCB0aGVuIHdyaXRlcyB0aGUgbnVtYmVyIG9mCj4gPiBtZWFzdXJlbWVudCByZWNvcmRzIHRvIHRy
aW0gZnJvbSB0aGUgc3RhcnQgb2YgdGhlIG1lYXN1cmVtZW50IGxvZyB0byBhCj4gPiBzeXNmcyBm
aWxlIGFuZCB0aGUga2VybmVsIGFjdHMgb24gdGhhdC4gIFlvdSBjb3VsZCBkbyB0aGlzIHdpdGgs
IG9yCj4gPiB3aXRob3V0LCB0aGUgc25hcHNob3RfYWdncmVnYXRlIGVudHJ5IGNvbmNlcHQ7IGlu
IGZhY3QgdGhhdCBjb3VsZCBiZQo+ID4gc29tZXRoaW5nIHRoYXQgd2FzIGNvbnRyb2xsZWQgYnkg
dXNlcnNwYWNlLCBlLmcuIHdyaXRlIHRoZSBudW1iZXIgb2YKPiA+IGxpbmVzIGFuZCBhIGZsYWcg
dG8gaW5kaWNhdGUgaWYgYSBzbmFwc2hvdF9hZ2dyZWdhdGUgd2FzIGRlc2lyZWQgdG8KPiA+IHRo
ZSBzeXNmcyBmaWxlLiAgSSBjYW4ndCBzYXkgSSd2ZSB0aG91Z2h0IGl0IGFsbCB0aGUgd2F5IHRo
cm91Z2ggdG8KPiA+IG1ha2Ugc3VyZSB0aGVyZSBhcmUgbm8gZ290Y2hhcywgYnV0IEknbSBndWVz
c2luZyB0aGF0IGlzIGFib3V0IGFzCj4gPiBzaW1wbGUgYXMgb25lIGNhbiBnZXQuCgo+ID4gSWYg
dGhlcmUgaXMgc29tZXRoaW5nIGVsc2UgeW91IGhhZCBpbiBtaW5kLCBNaW1pLCBwbGVhc2Ugc2hh
cmUgdGhlCj4gPiBkZXRhaWxzLiAgVGhpcyBpcyBhIHZlcnkgcmVhbCBwcm9ibGVtIHdlIGFyZSBm
YWNpbmcgYW5kIHdlIHdhbnQgdG8KPiA+IHdvcmsgdG8gZ2V0IGEgc29sdXRpb24gdXBzdHJlYW0u
Cj4gCj4gQW55IHRob3VnaHRzIG9uIHRoaXMgTWltaT8gIFdlIGhhdmUgYSByZWFsIGludGVyZXN0
IGluIHdvcmtpbmcgd2l0aAo+IHlvdSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gdXBzdHJlYW0sIGJ1
dCB3ZSBuZWVkIG1vcmUgZGV0YWlsZWQgZmVlZGJhY2sKPiB0aGFuICJ0b28gY29tcGxpY2F0ZWQi
LiAgSWYgeW91IGRvbid0IGxpa2UgdGhlIHNvbHV0aW9ucyBwcmVzZW50ZWQKPiB0aHVzIGZhciwg
d2hhdCB0eXBlIG9mIHNvbHV0aW9uIHdvdWxkIHlvdSBsaWtlIHRvIHNlZT8KClBhdWwsIHRoZSBk
ZXNpZ24gY29waWVzIHRoZSBtZWFzdXJlbWVudCBsaXN0IHRvIGEgdGVtcG9yYXJ5ICJzbmFwc2hv
dCIKZmlsZSwgYmVmb3JlIHRyaW1taW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0LCB3aGljaCBhY2Nv
cmRpbmcgdG8gdGhlCmRlc2lnbiBkb2N1bWVudCBsb2NrcyB0aGUgZXhpc3RpbmcgbWVhc3VyZW1l
bnQgbGlzdC4gIEFuZCBmdXJ0aGVyCnBhdXNlcyBleHRlbmRpbmcgdGhlIG1lYXN1cmVtZW50IGxp
c3QgdG8gY2FsY3VsYXRlIHRoZQoic25hcHNob3RfYWdncmVnYXRlIi4KClVzZXJzcGFjZSBjYW4g
ZXhwb3J0IHRoZSBtZWFzdXJlbWVudCBsaXN0IGFscmVhZHksIHNvIHdoeSB0aGlzCmNvbXBsaWNh
dGVkIGRlc2lnbj8KCkFzIEkgbWVudGlvbmVkIHByZXZpb3VzbHkgYW5kIHJlcGVhdGVkIHllc3Rl
cmRheSwgdGhlCiJzbmFwc2hvdF9hZ2dyZWdhdGUiIGlzIGEgbmV3IHR5cGUgb2YgY3JpdGljYWwg
ZGF0YSBhbmQgc2hvdWxkIGJlCnVwc3RyZWFtZWQgaW5kZXBlbmRlbnRseSBvZiB0aGlzIHBhdGNo
IHNldCB0aGF0IHRyaW1zIHRoZSBtZWFzdXJlbWVudApsaXN0LiAgVHJpbW1pbmcgdGhlIG1lYXN1
cmVtZW50IGxpc3QgY291bGQgYmUgYmFzZWQsIGFzIHlvdSBzdWdnZXN0ZWQKb24gdGhlIG51bWJl
ciBvZiByZWNvcmRzIHRvIHJlbW92ZSwgb3IgaXQgY291bGQgYmUgdXAgdG8gdGhlIG5leHQvbGFz
dAoic25hcHNob3RfYWdncmVnYXRlIiByZWNvcmQuCgotLSAKdGhhbmtzLAoKTWltaQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
