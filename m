Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D64D1CDA1
	for <kexec@archiver.kernel.org>; Tue, 22 Oct 2024 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJty56UjwjInZPGPYsdfChAO/JzGzIMvf8CpzFlFFvc=; b=UPIW2v3ySYyEWa
	Kg3nifWwhdsQzMxioVKx6rzSKDMYPk4xXODLeB+R5nj/1eyQURLTRsmA1FUP5+Ac5KDzD2gOgdJNu
	6OSmA2vlTzHG6vDhGrEQCUGbVAdhQJSkwBLUOVfj5zTnOZEWplkDjeSbbX1aYP59UT5uWwkD+52JQ
	o7FZp4AuM3ND9W6wC9X/tyxrC/xG0AJBxiP7LlQtVxE48mi9e5FX1y73iSSIU9kzxIerU3LwwAqaR
	WmpbGYWf+iJx7kMvtW6L+mZ5r1dYkNlm+vISipoRsPFU+6jCQea9p8FozpJ9dewNS25vnxu/pzgys
	OSxcvz4KKV24C5wPuRZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38Ve-00000009piB-2SYH;
	Tue, 22 Oct 2024 06:36:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38Sq-00000009pDN-0yZK
	for kexec@lists.infradead.org;
	Tue, 22 Oct 2024 06:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729578834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ecYzDzUDvBrOuMjRqWJytjUS87kIcvWevnJRz5y/s4=;
	b=einlnv48IjeyggWUJ7Tcpz/LcWOG3Zb6UxrEaBTBIf/V8Njoudpgp0ymu7rBtSVk5wfE5R
	JtbrL0jblp1tI0BC7tU21qY76nuEiikiPbEwOTHWgqnEsjgDqc3cLk16DBdVnvnywrQu/v
	bwQ5JDiSKm28bcjKwshCJwAtSE3Fboo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-9ntOlbOOMfC4GRsGN5nFYg-1; Tue, 22 Oct 2024 02:33:53 -0400
X-MC-Unique: 9ntOlbOOMfC4GRsGN5nFYg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b155c120daso750361585a.3
        for <kexec@lists.infradead.org>; Mon, 21 Oct 2024 23:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729578833; x=1730183633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ecYzDzUDvBrOuMjRqWJytjUS87kIcvWevnJRz5y/s4=;
        b=ITPuohc24DX9w/lUyRCfs4yTbINk2BL3pVpxqeKyGCtWJYpH10IY5S1wwqYVeW80Z0
         PDhiE7kSGtI4XvLI2DnYyrH7Z3dPsFBdk7ScaglWd+QQN9wFmQVLYyK+GRs2ssTsrlPf
         hQgD0pZv/R3/FtUB3wnzheK9LSd2yd34ja2bF659qm7bxla75DVtK9RO1O9PjRnNUkrg
         j3dGKHsW+M59rL8M2il83vos2BJwVvQdIyeHovT2HzVTqOHoZ1vurSGFp0iS/tcyQlbe
         +d0yLIE3F5s35FAAxJ2QoKSjE+UiVtyE5NnOnRCGZCEqcP+bN2e03fYhIrpYy92Mo861
         2txw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5Y5Xh6Ns4/Mr0VPCWqDAUmpvSMrH5MTkAyIr41WCCiWHPAKnUbOL3jZ11z0PBp78zIRNXA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1HhA4MH11YDKT7VZUqD6uZsMGs1kQddCejgw5uJ0pL5b5UEvO
	R+FFHjt/ZtFRz/MEiVSX9Z0eXylwI3nZLH/yPG7sdzXjbUv2Y91qkQBsCw+PDsprjmumSNtwnMW
	osJQyOvt1gDgTbf6TqZnp6kF28u7KI04gQBHmRQxKXoNOAquqeqFztnEt0yNBFHCF5bzx5Zj7hl
	7HZqL8DX1UX1c6e//e06Lgpr7U3sM82prU
X-Received: by 2002:a05:6214:8ef:b0:6ce:266a:85d5 with SMTP id 6a1803df08f44-6ce266a893bmr8568826d6.20.1729578832816;
        Mon, 21 Oct 2024 23:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmv1btkRd26v4n9dm/yCZCxIa9yn3ZEOO+7/drgBgbcbTfV2gH6bbV+ZvkxQ85EZsSpC/gwkW11ZBXd1aIRQU=
X-Received: by 2002:a05:6214:8ef:b0:6ce:266a:85d5 with SMTP id
 6a1803df08f44-6ce266a893bmr8568726d6.20.1729578832482; Mon, 21 Oct 2024
 23:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241016113418.22568-1-piliu@redhat.com> <20241016113418.22568-3-piliu@redhat.com>
 <20241021101646.GA402847@kernel.org>
In-Reply-To: <20241021101646.GA402847@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 22 Oct 2024 14:33:41 +0800
Message-ID: <CAF+s44Ttxze7yRAFaH7ZBk7OKvTVc7iOO7-P2s6Qb+Sbn_ZXbg@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] kexec: Introduce UKI image parser
To: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_233356_381772_1292D453 
X-CRM114-Status: GOOD (  24.86  )
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

SGkgU2ltb24sCgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LgoKT24gTW9uLCBPY3QgMjEsIDIwMjQg
YXQgNjoxNuKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBP
biBXZWQsIE9jdCAxNiwgMjAyNCBhdCAwNzozNDoxNFBNICswODAwLCBQaW5nZmFuIExpdSB3cm90
ZToKPiA+IEEgVUtJIGltYWdlIGlzIGEgUEUgZmlsZSB0aGF0IGNvbnNpc3RzIG9mIHNldmVyYWwg
c2VjdGlvbnMsIHR5cGljYWxseQo+ID4gaW5jbHVkaW5nOiAudGV4dCwgLmRhdGEsIC5saW51eCwg
LmluaXRyZCwgLmNtZGxpbmUsIGFuZCBvdGhlcnMuCj4gPgo+ID4gVGhlIGtlcm5lbCBpbWFnZSBp
cyBzdG9yZWQgaW4gdGhlIC5saW51eCBzZWN0aW9uLCB3aGljaCBpcyBvbmUgb2YgdGhlCj4gPiBm
b3JtYXRzIGN1cnJlbnRseSByZWNvZ25pemVkIGJ5IGtleGVjLXRvb2xzLiBUaGVyZWZvcmUsIHRo
ZSBVS0kgcGFyc2VyCj4gPiBjYW4gYmUgdXNlZCB0byBzdHJpcCBhd2F5IHRoZSBVS0kgbGF5ZXIs
IGFsbG93aW5nIHRoZSBvdGhlciBwYXJzZXIgdG8KPiA+IGNvbnRpbnVlIHRoZSBwcm9jZXNzaW9u
IG9mIHRoZSBrZXJuZWwgaW1hZ2UuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUGluZ2ZhbiBMaXUg
PHBpbGl1QHJlZGhhdC5jb20+Cj4KPiAuLi4KPgo+ID4gZGlmZiAtLWdpdCBhL2tleGVjL2tleGVj
LXVraS5jIGIva2V4ZWMva2V4ZWMtdWtpLmMKPgo+IC4uLgo+Cj4gPiAraW50IHVraV9pbWFnZV9w
cm9iZShjb25zdCBjaGFyICpmaWxlX2J1Ziwgb2ZmX3QgYnVmX3N6KQo+ID4gK3sKPiA+ICsgICAg
IHN0cnVjdCBwZV9oZHIgKnBlX2hkcjsKPiA+ICsgICAgIHN0cnVjdCBwZTMycGx1c19vcHRfaGRy
ICpvcHRfaGRyOwo+ID4gKyAgICAgc3RydWN0IHNlY3Rpb25faGVhZGVyICpzZWN0X2hkcjsKPiA+
ICsgICAgIGludCBwZV9oZHJfb2Zmc2V0LCBzZWN0aW9uX25yLCBsaW51eF9zeiA9IC0xOwo+ID4g
KyAgICAgY2hhciAqcGVfcGFydF9idWYsICpsaW51eF9zcmM7Cj4gPiArICAgICBjaGFyICppbml0
cmRfZm5hbWUgPSBOVUxMOwo+ID4gKyAgICAgaW50IGluaXRyZF9mZCA9IC0xOwo+ID4gKwo+ID4g
KyAgICAgcGVfaGRyX29mZnNldCA9IGdldF9wZWhkcl9vZmZzZXQoZmlsZV9idWYpOwo+ID4gKyAg
ICAgcGVfcGFydF9idWYgPSAoY2hhciAqKWZpbGVfYnVmICsgcGVfaGRyX29mZnNldDsKPiA+ICsg
ICAgIHBlX2hkciA9IChzdHJ1Y3QgcGVfaGRyICopcGVfcGFydF9idWY7Cj4gPiArICAgICBpZiAo
cGVfaGRyLT5vcHRfaGRyX3NpemUgPT0gMCkgewo+ID4gKyAgICAgICAgICAgICBwcmludGYoIkVS
Ujogb3B0aW9uYWwgaGVhZGVyIGlzIG1pc3NpbmdcbiIpOwo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gLTE7Cj4gPiArICAgICB9Cj4gPiArICAgICBzZWN0aW9uX25yID0gcGVfaGRyLT5zZWN0aW9u
czsKPiA+ICsgICAgIG9wdF9oZHIgPSAoc3RydWN0IHBlMzJwbHVzX29wdF9oZHIgKikocGVfcGFy
dF9idWYgKyBzaXplb2Yoc3RydWN0IHBlX2hkcikpOwo+ID4gKyAgICAgc2VjdF9oZHIgPSAoc3Ry
dWN0IHNlY3Rpb25faGVhZGVyICopKChjaGFyICopb3B0X2hkciArIHBlX2hkci0+b3B0X2hkcl9z
aXplKTsKPiA+ICsKPiA+ICsgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgc2VjdGlvbl9ucjsgaSsr
KSB7Cj4gPiArICAgICAgICAgICAgIGlmICghc3RyY21wKHNlY3RfaGRyLT5uYW1lLCBVS0lfTElO
VVhfU0VDVElPTikpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAvKiBkYXRhX2FkZHIgaXMg
cmVsYXRpdmUgdG8gdGhlIHdob2xlIGZpbGUgKi8KPiA+ICsgICAgICAgICAgICAgICAgICAgICBs
aW51eF9zcmMgPSAoY2hhciAqKWZpbGVfYnVmICsgc2VjdF9oZHItPmRhdGFfYWRkcjsKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBsaW51eF9zeiA9IHNlY3RfaGRyLT5yYXdfZGF0YV9zaXplOwo+
ID4gKwo+ID4gKyAgICAgICAgICAgICB9IGVsc2UgaWYgKCFzdHJjbXAoc2VjdF9oZHItPm5hbWUs
IFVLSV9JTklUUkRfU0VDVElPTikpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoIShp
bml0cmRfZm5hbWUgPSBzdHJkdXAoRklMRU5BTUVfVUtJX0lOSVRSRCkpKSB7Cj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkYmdwcmludGYoIiVzOiBDYW4ndCBkdXBsaWNhdGUgc3Ry
aW5nc1xuIiwgX19mdW5jX18pOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBuZXh0Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBpZiAoKGluaXRyZF9mZCA9IG1rc3RlbXAoaW5pdHJkX2ZuYW1lKSkgPCAwKSB7
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYmdwcmludGYoIiVzOiBDYW4ndCBv
cGVuIGZpbGUgJXNcbiIsIF9fZnVuY19fLCBpbml0cmRfZm5hbWUpOwo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBuZXh0Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0K
PiA+ICsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAod3JpdGUoaW5pdHJkX2ZkLCAoY2hh
ciAqKWZpbGVfYnVmICsgc2VjdF9oZHItPmRhdGFfYWRkciwKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2VjdF9oZHItPnJhd19kYXRhX3NpemUpICE9IHNlY3RfaGRy
LT5yYXdfZGF0YV9zaXplKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYmdw
cmludGYoIiVzOiBDYW4ndCB3cml0ZSB0aGUgY29tcHJlc3NlZCBmaWxlICVzXG4iLAo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbml0
cmRfZm5hbWUpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBuZXh0Owo+
Cj4gSSBwbGFuIHRvIGFwcGx5IHRoaXMgc2VyaWVzLCBidXQgaW5pdHJkX2ZkIGFwcGVhcnMgdG8g
YmUgbGVha2VkIGhlcmUuCj4gQ291bGQgeW91IHNlbmQgYSBmb2xsb3ctdXAgcGF0Y2ggdG8gYWRk
cmVzcyB0aGF0PyBQZXJoYXBzIGxpa2UgdGhpczoKPgpJIGhhdmUgc2VudCBvdXQgYSBkZWRpY2F0
ZWQgdjMgIltQQVRDSHYzIDIvM10ga2V4ZWM6IEludHJvZHVjZSBVS0kKaW1hZ2UgcGFyc2VyIiB0
byBmaXggdGhpcyBsZWFrIGlzc3VlLgoKPiAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSB3
cml0ZSguLi4pOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb3NlKGluaXRyZF9mZCkKCk15
IGZpeCBkdXBsaWNhdGVzIHRoZSBjbG9zZShpbml0cmRfZmQpIGluIGVhY2ggYnJhbmNoLiBTaW5j
ZSBpbml0cmRfZmQKaXMgdGhlIG9ubHkgcmVmZXJlbmNlIHRvIG1rc3RlbXAoaW5pdHJkX2ZuYW1l
KSwgSSB0aGluayBpZiBjbG9zaW5nIGl0LAp0aGUgdGVtcCBmaWxlIG1heSBkaXNhcHBlYXIgYmVm
b3JlIGltcGxpY2l0X2luaXRyZF9mZD0Kb3Blbihpbml0cmRfZm5hbWUsIE9fUkRPTkxZKS4KCgpC
ZXN0IFJlZ2FyZHMsCgpQaW5nZmFuCgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIg
IT0gc2VjdF9oZHItPnJhd19kYXRhX3NpemUpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC4uLgo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAuLi4KPiAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4K
PiBUaGFua3MhCj4KPiA+ICsgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW1wbGljaXRfaW5pdHJkX2ZkID0gb3Blbihpbml0cmRf
Zm5hbWUsIE9fUkRPTkxZKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb3Nl
KGluaXRyZF9mZCk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgfQo+ID4gKyAgICAgICAgICAg
ICB9Cj4gPiArbmV4dDoKPiA+ICsgICAgICAgICAgICAgc2VjdF9oZHIrKzsKPiA+ICsgICAgIH0K
Pgo+IC4uLgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
