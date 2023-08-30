Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965AC83F14
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9/0jgWgeKmNz3tGZAuY0cTmImJSRBG0CffpsDZ0ox0=; b=hrVwMfV/3tevbX
	D07Z9QXw4bpS6niyQ+8CnLDOIKCRqAMW6V8HEBPbZtMD3P+IG4sfgA4xK5ErGjHaCuklZC2YJuB6g
	ed7Rwk5+QZ49Htwc4dLHMHzRrvtFdvssdyyyHAPPBA1Fdp22X6uIr8sQJSVsVetWixOF56tSxuQ/U
	MnLpcQWvuKvT/CV7kpMONHjhxarVlofrNms+bGDQyKTRhEQ+gvAPcqHb8hb16DCfFXS7K5HhHoA5C
	i14nKkcfA77vuP6k/g3Z2OgOiGTxAKjxk78G9jqA9XnQdMxoAmz5EsWei9bzQT9HsrfGzp38Nkh8u
	rYpnLu/5tPnXouRAzxcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbT58-00EE5g-2r;
	Wed, 30 Aug 2023 21:50:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbT56-00EE4w-0H
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 21:50:33 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ULbkpf005435;
	Wed, 30 Aug 2023 21:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3frPMVoA975G69l1GA3cah2M5FfV7vEttHALXEQSKE0=;
 b=NT4fOp9qQdZyLGwZ97s7jM7qGuwk1rur9lQU3L2yfjHbJJH0hsxWHdt41WqiFawMwnpv
 2FRXU47T0XU0llg7dOr6ZenoMyZ/JUFQA1hYmeF5jlq6rwkN1sLz3AHI1p9UOV28qUj3
 zjvFxS070ZxELyosqPaJv7bZVPtPex8NvbnGmjLtjV5bIclVFXqRyiFpQfS1FzDm5fO1
 tMDVmZqBir0jeIUb+ruhqLDaYdDPWGs4Oum0WY/pP2Zhd+SMLBIGDaMXUn/l7f5lzf1S
 mGO8VfVqKncRApt+Ut5vBW98DTYiOeH2q4z4IXGjCpN6L0CY75a605VaUKIPcCXrBJ9j +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stdph09qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 21:50:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ULdEqr009163;
	Wed, 30 Aug 2023 21:50:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stdph09ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 21:50:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UL1PHf009966;
	Wed, 30 Aug 2023 21:50:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kq2tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 21:50:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37ULoEQW4784812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 21:50:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E7F5805D;
	Wed, 30 Aug 2023 21:50:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2352E58054;
	Wed, 30 Aug 2023 21:50:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 21:50:13 +0000 (GMT)
Message-ID: <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar
 Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date: Wed, 30 Aug 2023 17:50:12 -0400
In-Reply-To: <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
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
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sKUQ6JKOOFKqA3Azkuxn9TtEcHZ1lTxs
X-Proofpoint-ORIG-GUID: oTdMYYJ15PzjcUmfx6Tichvl09FKsgMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_18,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300196
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_145032_363006_76F021E4 
X-CRM114-Status: GOOD (  29.03  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE2OjQ3IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFdlZCwgQXVnIDMwLCAyMDIzIGF0IDQ6MjXigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IFlvdXIgaW5pdGlhbCBxdWVzdGlvbiB3YXMgIndoYXQgaGFwcGVu
cyBpZiB0aGUgZmlsZS9maWxlc3lzdGVtIGJlY29tZXMKPiA+IGluYWNjZXNzaWJsZSBhdCBzb21l
IHBvaW50IGFuZCBhbiBhdHRlc3RhdGlvbiBjbGllbnQgYXR0ZW1wdHMgdG8gcmVhZAo+ID4gdGhl
IGVudGlyZSBsb2c/Ii4gIEZvciB3aGF0IHJlYXNvbiB3b3VsZCBpdCBiZSBpbmFjY2Vzc2libGU/
ICBGb3IgdGhlCj4gPiBvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwgd2hhdCB3b3VsZCBtYWtl
IGl0IGluYWNjZXNzaWJsZT8KPiAKPiBJbiB5b3VyIHJlcGx5IHRoYXQgSSBoYWQgcmVzcG9uZGVk
IHRvIHlvdSBoYWQgbWVudGlvbmVkIHRoYXQgdGhlCj4ga2VybmVsIHdhcyBzaW1wbHkgYmVpbmcg
cGFzc2VkIGEgZmQgYW5kIHRha2luZyBvd25lcnNoaXAgb2YgaXQsIHRoZSBmZAo+IGNvdWxkIGVp
dGhlciBiZSBhIHRtcGZzIGJhY2tlZCBmaWxlIG9yIHNvbWUgZm9ybSBvZiBwZXJzaXN0ZW50IHN0
b3JhZ2UKPiBhcyBib3RoIHdlcmUgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkLiAgSSBpbWFnaW5l
IGEgdG1wZnMgZmlsZXN5c3RlbQo+IGNvdWxkIHN0aWxsIGJlIGZvcmNpYmx5IHVubW91bnRlZCwg
cmVzdWx0aW5nIGluIHByb2JsZW1zLCBidXQgSSBjYW4ndAo+IHNheSB0aGF0IGZvciBjZXJ0YWlu
LiAgSG93ZXZlciwgdGhlcmUgYXJlIGRlZmluaXRlbHkgY2FzZXMgd2hlcmUgYSBmZAo+IGJhY2tl
ZCBhZ2FpbnN0IGFuIGFyYml0cmFyeSBmaWxlc3lzdGVtIGNvdWxkIHJ1biBpbnRvIHByb2JsZW1z
Ogo+IHN0b3JhZ2UgZGV2aWNlIGlzc3VlcyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMsIG5ldHdvcmtp
bmcgaXNzdWVzIGZvcgo+IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBnb29kIG9sZCBmYXNoaW9u
ZWQgdXNlci9hZG1pbiBpbnRlcnZlbnRpb24gaW4KPiBib3RoIGNhc2VzLgoKIkkgaW1hZ2luZSB0
bXBmcyBmaWxlc3lzdGVtIGNvdWxkIHN0aWxsIGJlIGZvcmNpYmx5IHVubW91bnRlZCIgc291bmRz
Cmxpa2UgYW4gYXR0YWNrLiBOb3QgYmVpbmcgYWJsZSB0byB2ZXJpZnkgdGhlIG1lYXN1cmVtZW50
IGxpc3QgYWdhaW5zdCBhCnF1b3RlIGlzIHByb2JhYmx5IGEgZ29vZCB0aGluZy4KCj4gCj4gPiBJ
biB0aGUKPiA+ICJzbmFwc2hvdHRpbmciIGRlc2lnbiB0aGlzIHByb2JsZW0gYmVjb21lcyBhIHVz
ZXJzcGFjZSBpc3N1ZS4KPiAKPiBZZXMsIGV4YWN0bHkuICBVc2Vyc3BhY2UgaXMgYWxtb3N0IGFs
d2F5cyBnb2luZyB0byBoYXZlIGFuIGVhc2llciB0aW1lCj4gcmVjb3ZlcmluZyBmcm9tIHRoZXNl
IHR5cGVzIG9mIGVycm9ycyAuLi4gb3IgYXQgbGVhc3QgSSBiZWxpZXZlIHNvLAo+IHBlcmhhcHMg
eW91IGhhdmUgYSBjbGV2ZXIgc29sdXRpb24gZm9yIGhvdyB0aGUga2VybmVsIGNhbiBoYW5kbGUg
dGhlCj4gZmlsZS9maWxlc3lzdGVtIGRpc2FwcGVhcmluZyBmcm9tIHVuZGVyIHRoZSBmZD8KCk5v
dGhpbmcgY2hhbmdlcy4gIE5ldyBtZWFzdXJlbWVudHMgYXJlIGluaXRpYWxseSBzdG9yZWQgaW4g
a2VybmVsCm1lbW9yeSwgdW50aWwgdGhleSBhcmUgc3VjY2Vzc2Z1bGx5IGNvcGllZC4KCj4gPiBU
aGUgZmlyc3Qgc2VudGVuY2Ugb2YgdGhlIGNvdmVyIGxldHRlciBpcyAiRGVwZW5kaW5nIG9uIHRo
ZSBJTUEgcG9saWN5LAo+ID4gdGhlIElNQSBsb2cgY2FuIGNvbnN1bWUgYSBsb3Qgb2YgS2VybmVs
IG1lbW9yeSBvbiB0aGUgZGV2aWNlLiIgLi4uCj4gCj4gQXMgSSdtIHN0aWxsIGxvb2tpbmcgZm9y
IGFuIGFuc3dlciB0byBteSBxdWVzdGlvbiwgbGV0J3Mgc3RheSBmb2N1c2VkCj4gb24gdGhhdCBi
ZWZvcmUgd2Ugc3RhcnQgd29ycnlpbmcgdG9vIG11Y2ggYWJvdXQgdGhlIHBocmFzaW5nIG9mIHRo
ZQo+IGRlc2lnbiBwcm9wb3NhbCB0aGF0IHdhcyBzdWJtaXR0ZWQuCgpJdCdzIG1vcmUgdGhhbiBq
dXN0IHBocmFzaW5nLCBidXQgdGhlIHB1cnBvc2UvbW90aXZhdGlvbiBvZiB0aGUKcHJvcG9zZWQg
Y2hhbmdlcy4KCi0tICAKdGhhbmtzLAoKTWltaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
