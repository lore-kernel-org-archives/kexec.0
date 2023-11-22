Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C49FC61D9B
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pr/lkBM1IbMl2e+5MOlW48YCE1Hj+fVgEIxi9Mx0O7c=; b=S5GKp+Si9pYxyi
	DcAafxhTxdFMv70OXa5ym+yXoCFLzDStGMKt/R3NBAwVB+VhQpFUqwOuYK4ALBeuFi50NMuiBOAEy
	Osju9FHWchQuMeWh6hAfyNDL9l9izfnfigtdDojblL9EWM+xFMgUlnCVk+A+yvuPOivTZCo+/Xrhe
	oEKFuV3u7Ek4N5Qcx8iRuol+LbaHZT0HzhlgS76WzlI7YI1uau4Ij+MHDmxmjaQm8GCi1nFEhwLSv
	DjhYB6tsJ5XPUup4u64bOB6HbelbCKjS/m/MxMEFLfvunbjdEd36SVEty+ft9aoHPw2/8xObI20NN
	fMQJU5flZdqCg1PonTKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5o7j-00263P-0t;
	Wed, 22 Nov 2023 14:22:39 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5o7g-00261l-0N
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 14:22:37 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9cbba16084so6248780276.1
        for <kexec@lists.infradead.org>; Wed, 22 Nov 2023 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700662952; x=1701267752; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4prMfUwibvSrz+SlOVCRM+XxGw8pCCbk8//pMWkdN5o=;
        b=EOqPf4Rf6QVFyIlDKqR7iNIJtXPlUu4kfwdp0nxeAwnDwFTQhX9j3lGFQb+r92jZiT
         tKfLAQhtFS1z5gxdcSw5mm4b3DYmG2PqfHPhSZMPyzsAozzNG92u8hDsufy0h2BUJYgt
         xSS+Mk+2WlvvpPz7vbXjcgQ+1U23aMxNQw79QQZQBSCuYO/Eq1/J4fD4TqPF1yUgtO7Z
         YckGcRBY/IMZzf8PBtOb0GP/PIbRPlTGBkusIlXFP4LzD7f9Fk/Iimss4YKdDCLDQeee
         ovJW9LmCI27f2aW8HA+P1KPSWn9gnyYFUTDumS7DEtb5OzSEXnfC47AVoUaVM9HEQiv4
         yUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662952; x=1701267752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4prMfUwibvSrz+SlOVCRM+XxGw8pCCbk8//pMWkdN5o=;
        b=kqDS54C8IFzUOKJ5Vm8mu04biloswwltVfThNATen0i70r8L9ISyrColGHf+RSv+qE
         W2eddWKrOsGRTAr/Fc7p3zGNjHp/+xOZ8IoamdQDqJm+eBPU/Y616g//nmbVPyV1dfmO
         c+EU5Nvclu6aOS04GxKyU/tpvd/ZIsKryILzmRR2PqyNv3EEJpl6t+WZLeLVj2kAiWKX
         zD1fCyZvguzl1S6CJLzpul2tSnttbdlwvCzs+K0G1wv1/ZOfmY1+0ymcpEZIGfcAL5hm
         uG9hg1/rlIXYGhF/H1Qks6yG8iSQ8oheVBox8g5jfsz1LY84vSj86OU6fd2+mCSi3SZj
         cchg==
X-Gm-Message-State: AOJu0Yy3XnPq+p8BGxLFhTCP2sagrdm/qH8yrhFvysyFKJJ9OAviQQM4
	N1je24a+PcM+W39d811cQCHL3QNSedPnotg+NJ8h
X-Google-Smtp-Source: AGHT+IEJL/YGcl1HeO8ReXDrsuqtzUGq1wd/C8C6zxLauzMEtqUmjA6ZwzH2itAh+DerMPVQukYfKcnK8Mzm9vv1cIE=
X-Received: by 2002:a25:e908:0:b0:d9a:ce53:4942 with SMTP id
 n8-20020a25e908000000b00d9ace534942mr2525742ybd.0.1700662952611; Wed, 22 Nov
 2023 06:22:32 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com> <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
In-Reply-To: <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Nov 2023 09:22:21 -0500
Message-ID: <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_062236_360883_78005439 
X-CRM114-Status: GOOD (  37.68  )
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

T24gV2VkLCBOb3YgMjIsIDIwMjMgYXQgODoxOOKAr0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAyMzoyNyAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIFRodSwgTm92IDE2LCAyMDIzIGF0IDU6MjjigK9QTSBQYXVs
IE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90ZToKPiA+ID4gT24gVHVlLCBPY3QgMzEs
IDIwMjMgYXQgMzoxNeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3Rl
Ogo+ID4KPiA+IC4uLgo+ID4KPiA+ID4gPiBVc2Vyc3BhY2UgY2FuIGFscmVhZHkgZXhwb3J0IHRo
ZSBJTUEgbWVhc3VyZW1lbnQgbGlzdChzKSB2aWEgdGhlCj4gPiA+ID4gc2VjdXJpdHlmcyB7YXNj
aWksYmluYXJ5fV9ydW50aW1lX21lYXN1cmVtZW50cyBmaWxlKHMpIGFuZCBkbyB3aGF0ZXZlcgo+
ID4gPiA+IGl0IHdhbnRzIHdpdGggaXQuICBBbGwgdGhhdCBpcyBtaXNzaW5nIGluIHRoZSBrZXJu
ZWwgaXMgdGhlIGFiaWxpdHkgdG8KPiA+ID4gPiB0cmltIHRoZSBtZWFzdXJlbWVudCBsaXN0LCB3
aGljaCBkb2Vzbid0IHNlZW0gYWxsIHRoYXQgY29tcGxpY2F0ZWQuCj4gPiA+Cj4gPiA+IEZyb20g
bXkgcGVyc3BlY3RpdmUgd2hhdCBoYXMgYmVlbiBwcmVzZW50ZWQgaXMgYmFzaWNhbGx5IGp1c3Qg
dHJpbW1pbmcKPiA+ID4gdGhlIGluLW1lbW9yeSBtZWFzdXJlbWVudCBsb2csIHRoZSBhZGRpdGlv
bmFsIGNvbXBsZXhpdHkgKHdoaWNoIHJlYWxseQo+ID4gPiBkb2Vzbid0IGxvb2sgdGhhdCBiYWQg
SU1PKSBpcyB0aGVyZSB0byBlbnN1cmUgcm9idXN0bmVzcyBpbiB0aGUgZmFjZQo+ID4gPiBvZiBh
biB1bnJlbGlhYmxlIHVzZXJzcGFjZSAocHJvY2Vzc2VzIGRpZSwgZ2V0IGtpbGxlZCwgZXRjLikg
YW5kIHRvCj4gPiA+IGVzdGFibGlzaCBhIG5ldywgdHJhbnNpdGl2ZSByb290IG9mIHRydXN0IGlu
IHRoZSBuZXdseSB0cmltbWVkCj4gPiA+IGluLW1lbW9yeSBsb2cuCj4gPiA+Cj4gPiA+IEkgc3Vw
cG9zZSBvbmUgY291bGQgc2ltcGxpZnkgdGhpbmdzIGdyZWF0bHkgYnkgaGF2aW5nIGEgZGVzaWdu
IHdoZXJlCj4gPiA+IHVzZXJzcGFjZSAgY2FwdHVyZXMgdGhlIG1lYXN1cmVtZW50IGxvZyBhbmQg
dGhlbiB3cml0ZXMgdGhlIG51bWJlciBvZgo+ID4gPiBtZWFzdXJlbWVudCByZWNvcmRzIHRvIHRy
aW0gZnJvbSB0aGUgc3RhcnQgb2YgdGhlIG1lYXN1cmVtZW50IGxvZyB0byBhCj4gPiA+IHN5c2Zz
IGZpbGUgYW5kIHRoZSBrZXJuZWwgYWN0cyBvbiB0aGF0LiAgWW91IGNvdWxkIGRvIHRoaXMgd2l0
aCwgb3IKPiA+ID4gd2l0aG91dCwgdGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSBlbnRyeSBjb25jZXB0
OyBpbiBmYWN0IHRoYXQgY291bGQgYmUKPiA+ID4gc29tZXRoaW5nIHRoYXQgd2FzIGNvbnRyb2xs
ZWQgYnkgdXNlcnNwYWNlLCBlLmcuIHdyaXRlIHRoZSBudW1iZXIgb2YKPiA+ID4gbGluZXMgYW5k
IGEgZmxhZyB0byBpbmRpY2F0ZSBpZiBhIHNuYXBzaG90X2FnZ3JlZ2F0ZSB3YXMgZGVzaXJlZCB0
bwo+ID4gPiB0aGUgc3lzZnMgZmlsZS4gIEkgY2FuJ3Qgc2F5IEkndmUgdGhvdWdodCBpdCBhbGwg
dGhlIHdheSB0aHJvdWdoIHRvCj4gPiA+IG1ha2Ugc3VyZSB0aGVyZSBhcmUgbm8gZ290Y2hhcywg
YnV0IEknbSBndWVzc2luZyB0aGF0IGlzIGFib3V0IGFzCj4gPiA+IHNpbXBsZSBhcyBvbmUgY2Fu
IGdldC4KPgo+ID4gPiBJZiB0aGVyZSBpcyBzb21ldGhpbmcgZWxzZSB5b3UgaGFkIGluIG1pbmQs
IE1pbWksIHBsZWFzZSBzaGFyZSB0aGUKPiA+ID4gZGV0YWlscy4gIFRoaXMgaXMgYSB2ZXJ5IHJl
YWwgcHJvYmxlbSB3ZSBhcmUgZmFjaW5nIGFuZCB3ZSB3YW50IHRvCj4gPiA+IHdvcmsgdG8gZ2V0
IGEgc29sdXRpb24gdXBzdHJlYW0uCj4gPgo+ID4gQW55IHRob3VnaHRzIG9uIHRoaXMgTWltaT8g
IFdlIGhhdmUgYSByZWFsIGludGVyZXN0IGluIHdvcmtpbmcgd2l0aAo+ID4geW91IHRvIHNvbHZl
IHRoaXMgcHJvYmxlbSB1cHN0cmVhbSwgYnV0IHdlIG5lZWQgbW9yZSBkZXRhaWxlZCBmZWVkYmFj
awo+ID4gdGhhbiAidG9vIGNvbXBsaWNhdGVkIi4gIElmIHlvdSBkb24ndCBsaWtlIHRoZSBzb2x1
dGlvbnMgcHJlc2VudGVkCj4gPiB0aHVzIGZhciwgd2hhdCB0eXBlIG9mIHNvbHV0aW9uIHdvdWxk
IHlvdSBsaWtlIHRvIHNlZT8KPgo+IFBhdWwsIHRoZSBkZXNpZ24gY29waWVzIHRoZSBtZWFzdXJl
bWVudCBsaXN0IHRvIGEgdGVtcG9yYXJ5ICJzbmFwc2hvdCIKPiBmaWxlLCBiZWZvcmUgdHJpbW1p
bmcgdGhlIG1lYXN1cmVtZW50IGxpc3QsIHdoaWNoIGFjY29yZGluZyB0byB0aGUKPiBkZXNpZ24g
ZG9jdW1lbnQgbG9ja3MgdGhlIGV4aXN0aW5nIG1lYXN1cmVtZW50IGxpc3QuICBBbmQgZnVydGhl
cgo+IHBhdXNlcyBleHRlbmRpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QgdG8gY2FsY3VsYXRlIHRo
ZQo+ICJzbmFwc2hvdF9hZ2dyZWdhdGUiLgoKSSBiZWxpZXZlIHRoZSBpbnRlbnQgaXMgdG8gb25s
eSBwYXVzZSB0aGUgbWVhc3VyZW1lbnRzIHdoaWxlIHRoZQpzbmFwc2hvdF9hZ2dyZWdhdGUgaXMg
Z2VuZXJhdGVkLCBub3QgZm9yIHRoZSBkdXJhdGlvbiBvZiB0aGUgZW50aXJlCnNuYXBzaG90IHBy
b2Nlc3MuICBUaGUgcHVycG9zZSBvZiB0aGUgc25hcHNob3RfYWdncmVnYXRlIGlzIHRvCmVzdGFi
bGlzaCBhIG5ldyByb290IG9mIHRydXN0LCBzaW1pbGFyIHRvIHRoZSBib290X2FnZ3JlZ2F0ZSwg
dG8gaGVscAppbXByb3ZlIGF0dGVzdGF0aW9uIHBlcmZvcm1hbmNlLgoKPiBVc2Vyc3BhY2UgY2Fu
IGV4cG9ydCB0aGUgbWVhc3VyZW1lbnQgbGlzdCBhbHJlYWR5LCBzbyB3aHkgdGhpcwo+IGNvbXBs
aWNhdGVkIGRlc2lnbj8KClRoZSBjdXJyZW50IGNvZGUgaGFzIG5vIHByb3Zpc2lvbiBmb3IgdHJp
bW1pbmcgdGhlIG1lYXN1cmVtZW50IGxvZywKdGhhdCdzIHRoZSBwcmltYXJ5IHJlYXNvbi4KCj4g
QXMgSSBtZW50aW9uZWQgcHJldmlvdXNseSBhbmQgcmVwZWF0ZWQgeWVzdGVyZGF5LCB0aGUKPiAi
c25hcHNob3RfYWdncmVnYXRlIiBpcyBhIG5ldyB0eXBlIG9mIGNyaXRpY2FsIGRhdGEgYW5kIHNo
b3VsZCBiZQo+IHVwc3RyZWFtZWQgaW5kZXBlbmRlbnRseSBvZiB0aGlzIHBhdGNoIHNldCB0aGF0
IHRyaW1zIHRoZSBtZWFzdXJlbWVudAo+IGxpc3QuICBUcmltbWluZyB0aGUgbWVhc3VyZW1lbnQg
bGlzdCBjb3VsZCBiZSBiYXNlZCwgYXMgeW91IHN1Z2dlc3RlZAo+IG9uIHRoZSBudW1iZXIgb2Yg
cmVjb3JkcyB0byByZW1vdmUsIG9yIGl0IGNvdWxkIGJlIHVwIHRvIHRoZSBuZXh0L2xhc3QKPiAi
c25hcHNob3RfYWdncmVnYXRlIiByZWNvcmQuCgpPa2F5LCB3ZSBhcmUgc3RhcnRpbmcgdG8gZ2V0
IGNsb3NlciwgYnV0IEknbSBzdGlsbCBtaXNzaW5nIHRoZSBwYXJ0CndoZXJlIHlvdSBzYXkgImlm
IHlvdSBkbyBYLCBZLCBhbmQgWiwgSSdsbCBhY2NlcHQgYW5kIG1lcmdlIHRoZQpzb2x1dGlvbi4i
ICBDYW4geW91IGJlIG1vcmUgZXhwbGljaXQgYWJvdXQgd2hhdCBhcHByb2FjaChlcykgeW91IHdv
dWxkCmJlIHdpbGxpbmcgdG8gYWNjZXB0IHVwc3RyZWFtPwoKLS0gCnBhdWwtbW9vcmUuY29tCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
