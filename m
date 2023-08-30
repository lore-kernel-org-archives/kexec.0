Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E73C83F15
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wTnVK/io1lvbw+n3LbkTBrLJcGFQgyT2huY0CQvmoOk=; b=ot5xoLGrs6U8HI
	ks4vyLImdBgjW8BmVzVf5Bgk6iqP+2z+Etp09uKGY7xmtDXQ0uZTfjGUwFxfc+D0lsjQ//v+eAPFB
	9yxeL+f0kC/mKfXTFZV6O0zRKT2lY0F4+Ltz/q9hTi5yGQMLo6C/hExv3DhSVrjM2G25ifrgDv6Il
	s6bZVk00MEa+UCgQHukZdVIj8xOg1VfUs7CxbWLXqMcDcsFcggIfX464w5APWO9+UEuddvmI8qVmV
	TxOSKGHfOwlUU0OomSrvs3YfO+zrKRRQGYFVujLIZslx1mlE+vPkvKXbH5d7ywGTTaIGk6F3xLhRF
	S2oXBD2Ogcc5Gdrl8QcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbUWJ-00EKmj-2g;
	Wed, 30 Aug 2023 23:22:43 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbUWG-00EKmO-1h
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 23:22:42 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58d31f142eeso3880967b3.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693437759; x=1694042559; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LozI1M1nDgeznkAZtWGyHDj2+KgA5la438X1P0EaA5s=;
        b=bSibV02Q8D6wuo7bAwqv5IXX0pKPDUYp302BYRk75VouGyoFqrr9SVUnigg58Jr7+i
         hNLfwmRSWvVoQY3+7/2x373aOTRQySVMpgMKvMkOqEIT8g436Crq6wvwdD1AHXGr0wFU
         yU9wuQsTPlX2SRMFMddHv4vBfslKpjpjyZBDyVX7+JvwOnvoZH6FNMIVeTTXQ0+dq73W
         C2CCv0SEYjk0+zW0wkhpHHTBmxZfUF+JsEurja1DAsAVbPviCnBeBEbby8D9GLL6sg0E
         kwaxmRurpl+nQ6F0eRYTdhfvIGk9nCeNt6wa/OEME+tSNuHI/odGapxTnO7Me2HZqXsB
         zdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437759; x=1694042559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LozI1M1nDgeznkAZtWGyHDj2+KgA5la438X1P0EaA5s=;
        b=VaKShFge9+NfOiWLiW7jdwavwkXGDF9ahQNQzeI95u1Uy4R+kEJwhWDc6PUAmeYkUf
         iHm0o85ll09tUYK5SLBX4dKd//ohhSvjbTmbJcq4iVe56/twbqQuz2J3pm52w8qomNsa
         qlVZETvJ9v1UGTfW3xKh+Ic/dyUk5r/UekHctwk2a5/Cf+Ye8w8Tm7hu89ss5yUdsbeO
         TSNg6/GGlzuLRyBs0bIIC7YGURuc9NLrlp0DsQrZWP4mjtpRsiQbJouFFuPFkqVjXgTK
         8zUd2WZbmugsb5MBdb278j7y6z8sHhaZBMmVg/be3wPAEx+yA0lz8nhZzpjwe2JgtYzj
         nSYw==
X-Gm-Message-State: AOJu0Yyp+4aBarv6p4Ev4hBv1r/L7Ey/vsfgJMNxPPhXQjVULVE2BPDJ
	mhAKRRnTkNaEmt/xetQnpMR+oHGVxKs6n6JJy3kF
X-Google-Smtp-Source: AGHT+IEYKAHbwaesSvMzTZIyHDlw17HvTNL4W6R0cqZW/wSeiJ3txeiz9+OtAj/abZjPlHDQh/Cz2DijmHMOIjZaSOY=
X-Received: by 2002:a0d:cc8e:0:b0:561:206a:ee52 with SMTP id
 o136-20020a0dcc8e000000b00561206aee52mr3775183ywd.24.1693437758924; Wed, 30
 Aug 2023 16:22:38 -0700 (PDT)
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
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com> <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
In-Reply-To: <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Aug 2023 19:22:27 -0400
Message-ID: <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org, AmirGoldstein <amir73il@gmail.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_162240_724966_CFED686D 
X-CRM114-Status: GOOD (  23.16  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNzowN+KAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxODoyMyAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDY6MjHigK9QTSBQYXVs
IE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMzAs
IDIwMjMgYXQgNTo1MOKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3Rl
Ogo+ID4gPiA+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxNjo0NyAtMDQwMCwgUGF1bCBNb29yZSB3
cm90ZToKPiA+ID4gPiA+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDQ6MjXigK9QTSBNaW1pIFpv
aGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gWW91ciBpbml0aWFs
IHF1ZXN0aW9uIHdhcyAid2hhdCBoYXBwZW5zIGlmIHRoZSBmaWxlL2ZpbGVzeXN0ZW0gYmVjb21l
cwo+ID4gPiA+ID4gPiBpbmFjY2Vzc2libGUgYXQgc29tZSBwb2ludCBhbmQgYW4gYXR0ZXN0YXRp
b24gY2xpZW50IGF0dGVtcHRzIHRvIHJlYWQKPiA+ID4gPiA+ID4gdGhlIGVudGlyZSBsb2c/Ii4g
IEZvciB3aGF0IHJlYXNvbiB3b3VsZCBpdCBiZSBpbmFjY2Vzc2libGU/ICBGb3IgdGhlCj4gPiA+
ID4gPiA+IG9yaWdpbmFsIHNpbmdsZSB0bXBmcyBmaWxlLCB3aGF0IHdvdWxkIG1ha2UgaXQgaW5h
Y2Nlc3NpYmxlPwo+ID4gPiA+ID4KPiA+ID4gPiA+IEluIHlvdXIgcmVwbHkgdGhhdCBJIGhhZCBy
ZXNwb25kZWQgdG8geW91IGhhZCBtZW50aW9uZWQgdGhhdCB0aGUKPiA+ID4gPiA+IGtlcm5lbCB3
YXMgc2ltcGx5IGJlaW5nIHBhc3NlZCBhIGZkIGFuZCB0YWtpbmcgb3duZXJzaGlwIG9mIGl0LCB0
aGUgZmQKPiA+ID4gPiA+IGNvdWxkIGVpdGhlciBiZSBhIHRtcGZzIGJhY2tlZCBmaWxlIG9yIHNv
bWUgZm9ybSBvZiBwZXJzaXN0ZW50IHN0b3JhZ2UKPiA+ID4gPiA+IGFzIGJvdGggd2VyZSBkaXNj
dXNzZWQgaW4gdGhpcyB0aHJlYWQuICBJIGltYWdpbmUgYSB0bXBmcyBmaWxlc3lzdGVtCj4gPiA+
ID4gPiBjb3VsZCBzdGlsbCBiZSBmb3JjaWJseSB1bm1vdW50ZWQsIHJlc3VsdGluZyBpbiBwcm9i
bGVtcywgYnV0IEkgY2FuJ3QKPiA+ID4gPiA+IHNheSB0aGF0IGZvciBjZXJ0YWluLiAgSG93ZXZl
ciwgdGhlcmUgYXJlIGRlZmluaXRlbHkgY2FzZXMgd2hlcmUgYSBmZAo+ID4gPiA+ID4gYmFja2Vk
IGFnYWluc3QgYW4gYXJiaXRyYXJ5IGZpbGVzeXN0ZW0gY291bGQgcnVuIGludG8gcHJvYmxlbXM6
Cj4gPiA+ID4gPiBzdG9yYWdlIGRldmljZSBpc3N1ZXMgZm9yIGxvY2FsIGZpbGVzeXN0ZW1zLCBu
ZXR3b3JraW5nIGlzc3VlcyBmb3IKPiA+ID4gPiA+IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBn
b29kIG9sZCBmYXNoaW9uZWQgdXNlci9hZG1pbiBpbnRlcnZlbnRpb24gaW4KPiA+ID4gPiA+IGJv
dGggY2FzZXMuCj4gPiA+ID4KPiA+ID4gPiAiSSBpbWFnaW5lIHRtcGZzIGZpbGVzeXN0ZW0gY291
bGQgc3RpbGwgYmUgZm9yY2libHkgdW5tb3VudGVkIiBzb3VuZHMKPiA+ID4gPiBsaWtlIGFuIGF0
dGFjay4gTm90IGJlaW5nIGFibGUgdG8gdmVyaWZ5IHRoZSBtZWFzdXJlbWVudCBsaXN0IGFnYWlu
c3QgYQo+ID4gPiA+IHF1b3RlIGlzIHByb2JhYmx5IGEgZ29vZCB0aGluZy4KPiA+ID4KPiA+ID4g
T2theSwgY2FuIHlvdSBhbnN3ZXIgdGhlIHF1ZXN0aW9uIGZvciBhbiBhcmJpdHJhcnkgcGVyc2lz
dGVudAo+ID4gPiBmaWxlc3lzdGVtPyAgVGhhdCB3YXMgYWx3YXlzIHRoZSBtb3JlIGltcG9ydGFu
dCBxdWVzdGlvbiwgLi4uCj4KPiBUaGUgb3JpZ2luYWwgcHJvcG9zYWwsIG5vdCBtaW5lLCBzdWdn
ZXN0ZWQgdXNpbmcgYSB0bXBmcyBmaWxlLiAgIFRoZQo+IGlkZWEgb2Ygd3JpdGluZyB0aGUgbWVh
c3VyZW1lbnRzIHRvIGEgZmlsZSBvbiBhIHBlcnNpc3RlbnQgZmlsZXN5c3RlbQo+IHdhc24ndCBt
aW5lIGVpdGhlci4gIFN1c2gvVHVzaGFyIHdlcmUgcHVzaGluZyBmb3Igd3JpdGluZyB0byBhCj4g
cGVyc2lzdGVudCBmaWxlKHMpLiAgTm8gYXJndW1lbnQgZnJvbSBtZSB0aGF0IHdyaXRpbmcgdG8g
YSBmaWxlIG9uIGFuCj4gYXJiaXRyYXJ5IHBlcnNpc3RlbnQgZmlsZXN5c3RlbSBpcyBub3QgYSBn
b29kIGlkZWEuCgpQcm9ncmVzcy4gIE9rYXksIHNvIHdlIGFsbCBub3cgYWdyZWUgdGhhdCB0aGUg
a2VybmVsIHdyaXRpbmcgdG8gYW4KYXJiaXRyYXJ5IGZpbGVzeXN0ZW0gaXMgbm90IGEgZ29vZCBp
ZGVhLCBhbmQgdXNpbmcgdG1wZnMgZG9lc24ndCBzb2x2ZQp0aGUgcHJvYmxlbSBvZiBnZW5lcmFs
IG1lbW9yeSBwcmVzc3VyZSAoZnJvbSBwcmV2aW91c2x5IGluIHRoaXMKdGhyZWFkKSwgdGhhdCdz
IGFsbCBoZWxwZnVsIGFuZCBnb29kIHRvIGNsYXJpZnkuCgpBc3N1bWluZyBTdXNoIGFuZCBUdXNo
YXIgcmV3b3JrIHRoZSBkb2N1bWVudCB0byBjbGFyaWZ5IHRoZQptb3RpdmF0aW9uL3B1cnBvc2Ug
Zm9yIHRoZSB3b3JrLCBhcyB5b3Ugc3VnZ2VzdGVkIGVhcmxpZXIsIEknbQphc3N1bWluZyB3ZSBj
YW4gcmV2aXNpdCB0aGlzIHByb2JsZW0gYW5kIHNvbHV0aW9ucz8KCi0tIApwYXVsLW1vb3JlLmNv
bQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
