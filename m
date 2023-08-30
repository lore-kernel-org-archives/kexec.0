Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B3C83F14
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 22:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtUEU2wxaQNDkZNEyPGzyFl2vG2dAlSpbpLPUaZL92o=; b=LRfISt3xRJozrj
	onu8aYsJMxlMTRXwacNiy2zSZZuMvviklEmXSavfwvg7EjcrUjylrq6m73MQaYlBw0K6nZQ5xFqYb
	EEfrYIopP+FMY7+I6fcujarESsXHZqeR5L16GEkFgbqyEjotx7VmawYRkWJ8TuVyeym0eMNfY60H1
	vdEp6SVVOMPaJ49uInR27dscS/rSGXT6W+DNZGlm+Y4fBSgFgtLBBx1bAb1MEwqr2JQFzWUvtO13S
	+l838jMzvywBm+/rFEyVo0H72nWsyrlngZFgI1IsUfoMSAQQraNS45N7j8+qhK8sxt9fx+BYZQXDS
	ZFFZ6XDHemg1hZKjDuOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbTYs-00EGxW-37;
	Wed, 30 Aug 2023 22:21:18 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbTYp-00EGx6-0x
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 22:21:18 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58fa51a0d97so3113057b3.3
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693434073; x=1694038873; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYk4CFaJHq5Hn6MNLc9y9pnXnFv2RVUlYwtYTLNBaOM=;
        b=DOaY5KKVTZkPmUvNZb6tki+ifRuZhOeX9DHDQSbDliMKYjCdmxm1mAGw46xwLzKj2p
         R4nmsMKcgxcGgtXVAJFS91R9838Rjd6TSNS7ah5IdXciHcvVL2JeUOYB6z3eQFaH+baJ
         A0CRmGwiBzrRpXwuYjjzsfX+g68hRbJNa1AMmHn55RvoQUUOhsLm9DVa5UK3rA/D0hC4
         X9F2yg3mwTkwmX0AOYrm4PNxkLZMHXs+ewkIt/HiC/WRhFjWEiWFiAILRDug/3hUiMgZ
         JAo5l02gj/XVHQ257Yy1IB/QJlwD8rL5EcRwvPkgsFcxajAYi/5kR9RZtlUrfTBj4ZGU
         E9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434073; x=1694038873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYk4CFaJHq5Hn6MNLc9y9pnXnFv2RVUlYwtYTLNBaOM=;
        b=LX1nHFBf3XcvTcs5vkKXLNncjoOa1h6VjRwtiCiyGCrxr41gyMOVraXQDtTxz9bGHd
         Xc4T01RkkDcD3l+Jr1aWXiUkGQnvBiJ7Vj+hNu4/XM2jWCm8ysy5epeKX9xOrU59iAuF
         YNZRlhXJSqthrADJknQA+WiM3XaxsYK+givALe0HoxXJbx8McVtPU40k6dGa/scNzdRu
         ciV1VPc8K6YCep+mP/5qUo1xJj5tPPWfEIHTqR6gzYmRtTJB8CUFyajDnlwBGo6nN2kt
         Ywy04piLlyrBx+5TxABs4tjAEdPVqQNaNb5e33xe/KBRBuEaoVT4SAOopVxB9uF9YAak
         eJsA==
X-Gm-Message-State: AOJu0YwqeqSFJhMKWCDPWHlJ82pNwwb8RNBHKJuNs0aI8VqucxIH24Rx
	ZOdK/ucDaoGjd5U1uH5izk2F8lF++ZzhoYjNPziZ
X-Google-Smtp-Source: AGHT+IGLa2mnu5VKtaPSkRoADo7A1aX/WXgcrneTfTmHdg8nJb9SVHLhU7aD/Zz7xh/yLdcyJJm3VMS86nMGzyYIV+I=
X-Received: by 2002:a81:4e14:0:b0:586:a627:da2d with SMTP id
 c20-20020a814e14000000b00586a627da2dmr3479971ywb.9.1693434073693; Wed, 30 Aug
 2023 15:21:13 -0700 (PDT)
MIME-Version: 1.0
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
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com> <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
In-Reply-To: <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Aug 2023 18:21:02 -0400
Message-ID: <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	Tushar Sugandhi <tusharsu@linux.mic>, linux-security-module@vger.kernel.org, 
	AmirGoldstein <amir73il@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_152116_040879_B71D202C 
X-CRM114-Status: GOOD (  17.20  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNTo1MOKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxNjo0NyAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDQ6MjXigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gWW91ciBpbml0aWFsIHF1
ZXN0aW9uIHdhcyAid2hhdCBoYXBwZW5zIGlmIHRoZSBmaWxlL2ZpbGVzeXN0ZW0gYmVjb21lcwo+
ID4gPiBpbmFjY2Vzc2libGUgYXQgc29tZSBwb2ludCBhbmQgYW4gYXR0ZXN0YXRpb24gY2xpZW50
IGF0dGVtcHRzIHRvIHJlYWQKPiA+ID4gdGhlIGVudGlyZSBsb2c/Ii4gIEZvciB3aGF0IHJlYXNv
biB3b3VsZCBpdCBiZSBpbmFjY2Vzc2libGU/ICBGb3IgdGhlCj4gPiA+IG9yaWdpbmFsIHNpbmds
ZSB0bXBmcyBmaWxlLCB3aGF0IHdvdWxkIG1ha2UgaXQgaW5hY2Nlc3NpYmxlPwo+ID4KPiA+IElu
IHlvdXIgcmVwbHkgdGhhdCBJIGhhZCByZXNwb25kZWQgdG8geW91IGhhZCBtZW50aW9uZWQgdGhh
dCB0aGUKPiA+IGtlcm5lbCB3YXMgc2ltcGx5IGJlaW5nIHBhc3NlZCBhIGZkIGFuZCB0YWtpbmcg
b3duZXJzaGlwIG9mIGl0LCB0aGUgZmQKPiA+IGNvdWxkIGVpdGhlciBiZSBhIHRtcGZzIGJhY2tl
ZCBmaWxlIG9yIHNvbWUgZm9ybSBvZiBwZXJzaXN0ZW50IHN0b3JhZ2UKPiA+IGFzIGJvdGggd2Vy
ZSBkaXNjdXNzZWQgaW4gdGhpcyB0aHJlYWQuICBJIGltYWdpbmUgYSB0bXBmcyBmaWxlc3lzdGVt
Cj4gPiBjb3VsZCBzdGlsbCBiZSBmb3JjaWJseSB1bm1vdW50ZWQsIHJlc3VsdGluZyBpbiBwcm9i
bGVtcywgYnV0IEkgY2FuJ3QKPiA+IHNheSB0aGF0IGZvciBjZXJ0YWluLiAgSG93ZXZlciwgdGhl
cmUgYXJlIGRlZmluaXRlbHkgY2FzZXMgd2hlcmUgYSBmZAo+ID4gYmFja2VkIGFnYWluc3QgYW4g
YXJiaXRyYXJ5IGZpbGVzeXN0ZW0gY291bGQgcnVuIGludG8gcHJvYmxlbXM6Cj4gPiBzdG9yYWdl
IGRldmljZSBpc3N1ZXMgZm9yIGxvY2FsIGZpbGVzeXN0ZW1zLCBuZXR3b3JraW5nIGlzc3VlcyBm
b3IKPiA+IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBnb29kIG9sZCBmYXNoaW9uZWQgdXNlci9h
ZG1pbiBpbnRlcnZlbnRpb24gaW4KPiA+IGJvdGggY2FzZXMuCj4KPiAiSSBpbWFnaW5lIHRtcGZz
IGZpbGVzeXN0ZW0gY291bGQgc3RpbGwgYmUgZm9yY2libHkgdW5tb3VudGVkIiBzb3VuZHMKPiBs
aWtlIGFuIGF0dGFjay4gTm90IGJlaW5nIGFibGUgdG8gdmVyaWZ5IHRoZSBtZWFzdXJlbWVudCBs
aXN0IGFnYWluc3QgYQo+IHF1b3RlIGlzIHByb2JhYmx5IGEgZ29vZCB0aGluZy4KCk9rYXksIGNh
biB5b3UgYW5zd2VyIHRoZSBxdWVzdGlvbiBmb3IgYW4gYXJiaXRyYXJ5IHBlcnNpc3RlbnQKZmls
ZXN5c3RlbT8gIFRoYXQgd2FzIGFsd2F5cyB0aGUgbW9yZSBpbXBvcnRhbnQgcXVlc3Rpb24sIGFu
ZCB5b3VyCmNvbnRpbnVlZCBhdm9pZGFuY2UgaXMgZ2V0dGluZyBtZSBpbmNyZWFzaW5nbHkgYW5u
b3llZC4KCi0tIApwYXVsLW1vb3JlLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
