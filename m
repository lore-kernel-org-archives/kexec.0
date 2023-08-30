Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E938C83F14
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cSiBXkozmtGZevm+tFhmxzd8ohpVsIjJUOoCa0I/E4I=; b=Pu3j8d1x1bncS5
	mNLe3auG4QTF5QV05BF81pYt5Rap8/gEPrKQazq+tzH6dGFm4UBsTZn2vWQevXWrGRQEeihpiMKDv
	DupEhUfK4DAFJM0hxAiqbIaLMo3XKq8eBmQ/srIsz8QfeOoqOURw0iyDZQ8rrBBaARNHdtf+akSIk
	/EXaBJz4x2KKm500K22u+SnwrF5zWl106rvTCQX1eLCgdKO/EZTAp3w8siugmDxfPakWiSdXDtk74
	xBtC9FxMtfvhO0rTE0opQFOkS3bcCHBB2QJCg4YaIVm6x4kY8KcawES2hobCEjW4UKY4iY8lsM+6M
	v/TPVxHwin63VhyqJwVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbUHT-00EK52-1g;
	Wed, 30 Aug 2023 23:07:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbUHQ-00EK4a-0A
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 23:07:21 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UMbREB031098;
	Wed, 30 Aug 2023 23:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bWBzxTfMcQf+7eaMVW9la0+/5KNXmeqkhFJzfa7n0W0=;
 b=W6TnsTcbgQ1Dk14MMb+BETjNGudYhyrWIN19f8pDCbdJuI+8zQ81w5GB6gqQxwbPUz02
 cUb3ohww0KnDFTYddJrhH00/XYWH886sKm+h+BpEnX4+LnWURcyEwIA0r5vJDpAQ6otS
 WtUuACs1IuY6miO0a1x+vv9HrSvO9VnIKHMHYJCmbeldb7XD4O0Me/XsQO5G1ozRVbhw
 AM3IZrQANCJ22PkWi6xy6TQj9zyVGesEyc48bsx2rTyAW/d2DYGRCkZkxvXrfcJMLatw
 nBq1ZehZC9Ky/L2JIqqkuKLZcFVpPxRncxsRjoZRdFpFjFHpIfvIqMxGRaMpNKXiovao 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stcbyky44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 23:07:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UN6B0L018723;
	Wed, 30 Aug 2023 23:06:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stcbykxnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 23:06:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37ULjsRJ004884;
	Wed, 30 Aug 2023 23:06:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqsyy9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 23:06:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UN6Y4T46399764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 23:06:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50CB858070;
	Wed, 30 Aug 2023 23:06:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB38D58043;
	Wed, 30 Aug 2023 23:06:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 23:06:32 +0000 (GMT)
Message-ID: <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Date: Wed, 30 Aug 2023 19:06:32 -0400
In-Reply-To: <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
	 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
	 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
	 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
	 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
	 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
	 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
	 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
	 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
	 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
	 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
	 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
	 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
	 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
	 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VEMtDM6WuitrslPHoPoNyN3_CV9oF8Ff
X-Proofpoint-ORIG-GUID: viWottO6RWAVJm23NJcvh6L2lmowyLP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_18,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300209
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_160720_448312_2101B272 
X-CRM114-Status: GOOD (  28.13  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE4OjIzIC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFdlZCwgQXVnIDMwLCAyMDIzIGF0IDY6MjHigK9QTSBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDU6NTDigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gT24gV2VkLCAyMDIzLTA4
LTMwIGF0IDE2OjQ3IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgQXVn
IDMwLCAyMDIzIGF0IDQ6MjXigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToKPiA+ID4gPiA+IFlvdXIgaW5pdGlhbCBxdWVzdGlvbiB3YXMgIndoYXQgaGFwcGVucyBp
ZiB0aGUgZmlsZS9maWxlc3lzdGVtIGJlY29tZXMKPiA+ID4gPiA+IGluYWNjZXNzaWJsZSBhdCBz
b21lIHBvaW50IGFuZCBhbiBhdHRlc3RhdGlvbiBjbGllbnQgYXR0ZW1wdHMgdG8gcmVhZAo+ID4g
PiA+ID4gdGhlIGVudGlyZSBsb2c/Ii4gIEZvciB3aGF0IHJlYXNvbiB3b3VsZCBpdCBiZSBpbmFj
Y2Vzc2libGU/ICBGb3IgdGhlCj4gPiA+ID4gPiBvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwg
d2hhdCB3b3VsZCBtYWtlIGl0IGluYWNjZXNzaWJsZT8KPiA+ID4gPgo+ID4gPiA+IEluIHlvdXIg
cmVwbHkgdGhhdCBJIGhhZCByZXNwb25kZWQgdG8geW91IGhhZCBtZW50aW9uZWQgdGhhdCB0aGUK
PiA+ID4gPiBrZXJuZWwgd2FzIHNpbXBseSBiZWluZyBwYXNzZWQgYSBmZCBhbmQgdGFraW5nIG93
bmVyc2hpcCBvZiBpdCwgdGhlIGZkCj4gPiA+ID4gY291bGQgZWl0aGVyIGJlIGEgdG1wZnMgYmFj
a2VkIGZpbGUgb3Igc29tZSBmb3JtIG9mIHBlcnNpc3RlbnQgc3RvcmFnZQo+ID4gPiA+IGFzIGJv
dGggd2VyZSBkaXNjdXNzZWQgaW4gdGhpcyB0aHJlYWQuICBJIGltYWdpbmUgYSB0bXBmcyBmaWxl
c3lzdGVtCj4gPiA+ID4gY291bGQgc3RpbGwgYmUgZm9yY2libHkgdW5tb3VudGVkLCByZXN1bHRp
bmcgaW4gcHJvYmxlbXMsIGJ1dCBJIGNhbid0Cj4gPiA+ID4gc2F5IHRoYXQgZm9yIGNlcnRhaW4u
ICBIb3dldmVyLCB0aGVyZSBhcmUgZGVmaW5pdGVseSBjYXNlcyB3aGVyZSBhIGZkCj4gPiA+ID4g
YmFja2VkIGFnYWluc3QgYW4gYXJiaXRyYXJ5IGZpbGVzeXN0ZW0gY291bGQgcnVuIGludG8gcHJv
YmxlbXM6Cj4gPiA+ID4gc3RvcmFnZSBkZXZpY2UgaXNzdWVzIGZvciBsb2NhbCBmaWxlc3lzdGVt
cywgbmV0d29ya2luZyBpc3N1ZXMgZm9yCj4gPiA+ID4gbmV0d29yayBmaWxlc3lzdGVtcywgYW5k
IGdvb2Qgb2xkIGZhc2hpb25lZCB1c2VyL2FkbWluIGludGVydmVudGlvbiBpbgo+ID4gPiA+IGJv
dGggY2FzZXMuCj4gPiA+Cj4gPiA+ICJJIGltYWdpbmUgdG1wZnMgZmlsZXN5c3RlbSBjb3VsZCBz
dGlsbCBiZSBmb3JjaWJseSB1bm1vdW50ZWQiIHNvdW5kcwo+ID4gPiBsaWtlIGFuIGF0dGFjay4g
Tm90IGJlaW5nIGFibGUgdG8gdmVyaWZ5IHRoZSBtZWFzdXJlbWVudCBsaXN0IGFnYWluc3QgYQo+
ID4gPiBxdW90ZSBpcyBwcm9iYWJseSBhIGdvb2QgdGhpbmcuCj4gPgo+ID4gT2theSwgY2FuIHlv
dSBhbnN3ZXIgdGhlIHF1ZXN0aW9uIGZvciBhbiBhcmJpdHJhcnkgcGVyc2lzdGVudAo+ID4gZmls
ZXN5c3RlbT8gIFRoYXQgd2FzIGFsd2F5cyB0aGUgbW9yZSBpbXBvcnRhbnQgcXVlc3Rpb24sIC4u
LgoKVGhlIG9yaWdpbmFsIHByb3Bvc2FsLCBub3QgbWluZSwgc3VnZ2VzdGVkIHVzaW5nIGEgdG1w
ZnMgZmlsZS4gICBUaGUKaWRlYSBvZiB3cml0aW5nIHRoZSBtZWFzdXJlbWVudHMgdG8gYSBmaWxl
IG9uIGEgcGVyc2lzdGVudCBmaWxlc3lzdGVtCndhc24ndCBtaW5lIGVpdGhlci4gIFN1c2gvVHVz
aGFyIHdlcmUgcHVzaGluZyBmb3Igd3JpdGluZyB0byBhCnBlcnNpc3RlbnQgZmlsZShzKS4gIE5v
IGFyZ3VtZW50IGZyb20gbWUgdGhhdCB3cml0aW5nIHRvIGEgZmlsZSBvbiBhbgphcmJpdHJhcnkg
cGVyc2lzdGVudCBmaWxlc3lzdGVtIGlzIG5vdCBhIGdvb2QgaWRlYS4KCi0tIAp0aGFua3MsCgpN
aW1pCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
