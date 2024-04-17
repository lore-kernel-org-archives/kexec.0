Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9E2C4345F
	for <kexec@archiver.kernel.org>; Wed, 17 Apr 2024 03:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=63ZHG78dhckta+znNPC5xZBkFuB2jIOMRx57MXpjp+M=; b=K/t9I8olZnRF+N
	fIhe2X8Vl6OOgNZqZZ6amLKjgJ2bsLtFxC2qdrIMeuNCdtnYLf3wZJ8Im2yI5LGZQMLmJ3hjYFANq
	MY0ZX7Ry3GbW2aNQRf9j8cFzj15DaVMMKSNyi9EWFPl7BP9PP/yWGpdQJ29F9GRKHfv+CnpjB6YEh
	4Uq/pEL0BcB/oXQt5QMpidYQOUSmFHG+4lX4BaleGtCTDndN/gd6WreLcJusOXyExM/DLSphpFrtg
	ld9AYHOxfl1O496r2w49L6PgY8rn9JswchjbBPGlZbXWuysoVqxmKjWgl69C/1Jo5WpW8XHZDTVVS
	Ud6n3JaLT2jYg5brQltw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwvlF-0000000EYS2-25m2;
	Wed, 17 Apr 2024 03:15:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwvlB-0000000EYRJ-1xRD
	for kexec@lists.infradead.org;
	Wed, 17 Apr 2024 03:14:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A5C516125C
	for <kexec@lists.infradead.org>; Wed, 17 Apr 2024 03:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FF7C113CE
	for <kexec@lists.infradead.org>; Wed, 17 Apr 2024 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713323695;
	bh=GTVTtdoMrTHwBS2kkGpeq8wvd0niAoFCDltH1ZaIvEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZlKMHV6od03z3f1c2F1qeIGNVXfvqZFktcOPZct8A+h5P238qor4RGV+7DJybV4JX
	 5mzDf9umhNNsvvRtm+0BpgIlKrubbUcr72tZqK5AzmzrtzqvKN+Dob1++lMj8P0fZ5
	 0QTRPcyg3369sva3G5CvB9uBeK5qtPa/QDNi1RvI/X0HjBuhwALneHEKFQfyLMM2IE
	 6/Gi9R+fixpK0oAFfpEnGKJ9Lpbq8V7omMTB3NWl9GqGy6ESp79yEAhV5wLLPpTKVa
	 D5DQgCl8U27jdeblIQdgMTcM77MxTP2aGBV8b6Q97qduE+z+UD+TmAHv7XUy7WpesE
	 WQZqxTg+pGm/w==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51beae2f13so583977566b.1
        for <kexec@lists.infradead.org>; Tue, 16 Apr 2024 20:14:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfoofEuFiDfWcZEnieISQ+1/2hEKmTPBbL2gUwdPIWhsW8VLTr
	qAfTHIdWd8TGfdLVES1aBJcH7zizZyJ3GY1AYRla9pO8CYTobVV3vaJGhbo2AE1fF/djELeG+RZ
	FZt1zJhnKpBqUBeitJ66bKUM6Q2M=
X-Google-Smtp-Source: AGHT+IF1jmsN2RBuY213tAWuSeHyonGmujLDyM8+rcOOXVKi4mc1ctOe5On9JsCQolROZAGoBMzrUUNRDBeRlqaIlk4=
X-Received: by 2002:a17:906:29cb:b0:a52:61b9:be48 with SMTP id
 y11-20020a17090629cb00b00a5261b9be48mr5129879eje.35.1713323693797; Tue, 16
 Apr 2024 20:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240329132825.1102459-1-bhe@redhat.com> <20240329132825.1102459-2-bhe@redhat.com>
 <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com> <ZgggcyeJ1bnkfGOp@MiWiFi-R3L-srv>
In-Reply-To: <ZgggcyeJ1bnkfGOp@MiWiFi-R3L-srv>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Apr 2024 11:14:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xGDAkF2kjdveKoGd+GwYrmix8_E=YB0i=c98qOGvffw@mail.gmail.com>
Message-ID: <CAAhV-H5xGDAkF2kjdveKoGd+GwYrmix8_E=YB0i=c98qOGvffw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/loongarch: clean up the left code and Kconfig
 item related to CRASH_CORE
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, geert@linux-m68k.org, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_201457_614497_A6C47872 
X-CRM114-Status: GOOD (  23.07  )
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

SGksIEFuZHJldywKCk9uIFNhdCwgTWFyIDMwLCAyMDI0IGF0IDEwOjI04oCvUE0gQmFvcXVhbiBI
ZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gMDMvMzAvMjQgYXQgMDk6NTlwbSwgSHVh
Y2FpIENoZW4gd3JvdGU6Cj4gPiBRdWV1ZWQsIHRoYW5rcy4KPgo+IFRoYW5rcywgSHVhY2FpLiBX
aGlsZSBJIG5vdGljZWQgQW5kcmV3IGhhcyBxdWV1ZWQgdGhpcyBwYXRjaHNldCBpbiBoaXMKPiBt
bS11bnN0YWJsZSBicmFuY2guCklmIEknbSBub3QgbWlzdGFrZW4sIG1tLXVuc3RhYmxlIGlzIHRh
cmdldCBmb3IgdGhlIG5leHQgNi4xMCwgbm90IGZvcgp0aGUgY3VycmVudCA2LjkuIEJ1dCBJIHRo
aW5rIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGEgZml4IGZvciA2LjksIHNvIEkKdGhpbmsgaXQgaXMg
bW9yZSBzdWl0YWJsZSBpbiB0aGUgbG9vbmdhcmNoLWZpeGVzIGJyYW5jaC4gV2hhdCdzIHlvdXIK
b3Bpbmlvbj8KClRoZSBzYW1lIHF1ZXN0aW9uIGZvciB0aGlzIHBhdGNoIHdoaWNoIGZpeCBhIGJ1
aWxkIHdhcm5pbmc6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xvb25nYXJjaC9DQU5pcTcya0FD
dCtGZmVZWEp4ZlFwbUdIPXVQcWtEQTBvcHJmbmVidzUyVlNLeW43a1FAbWFpbC5nbWFpbC5jb20v
VC8jdAoKCkh1YWNhaQoKPgo+ID4KPiA+IEh1YWNhaQo+ID4KPiA+IE9uIEZyaSwgTWFyIDI5LCAy
MDI0IGF0IDk6MjjigK9QTSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
Cj4gPiA+IEluIGNvbW1pdCA4NWZjZGU0MDJkYjEgKCJrZXhlYzogc3BsaXQgY3Jhc2hrZXJuZWwg
cmVzZXJ2YXRpb24gY29kZQo+ID4gPiBvdXQgZnJvbSBjcmFzaF9jb3JlLmMiKSwgY3Jhc2hrZXJu
ZWwgcmVzZXJ2YXRpb24gY29kZSBpcyBzcGxpdCBvdXQgZnJvbQo+ID4gPiBjcmFzaF9jb3JlLmMs
IGFuZCBhZGQgQ1JBU0hfUkVTRVJWRSB0byBjb250cm9sIGl0LiBBbmQgYWxzbyByZW5hbWUgZWFj
aAo+ID4gPiBBUkNIJ3MgPGFzbS9jcmFzaF9jb3JlLmg+IHRvIDxhc20vY3Jhc2hfcmVzZXJ2ZS5o
PiBhY2NvcmRpbmdseS4KPiA+ID4KPiA+ID4gQnV0IHRoZSByZWxldmFudCBwYXJ0IGluIGxvb25n
YXJjaCBpcyBtaXNzZWQuIERvIGl0IG5vdy4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmFv
cXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gPiA+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNh
aUBrZXJuZWwub3JnPgo+ID4gPiBDYzogV0FORyBYdWVydWkgPGtlcm5lbEB4ZW4wbi5uYW1lPgo+
ID4gPiBDYzogbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldgo+ID4gPiAtLS0KPiA+ID4gIGFyY2gv
bG9vbmdhcmNoL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDIgKy0KPiA+ID4gIGFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3tjcmFzaF9jb3JlLmggPT4g
Y3Jhc2hfcmVzZXJ2ZS5ofSB8IDQgKystLQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPiA+ICByZW5hbWUgYXJjaC9sb29uZ2FyY2gvaW5j
bHVkZS9hc20ve2NyYXNoX2NvcmUuaCA9PiBjcmFzaF9yZXNlcnZlLmh9ICg3NSUpCj4gPiA+Cj4g
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9LY29uZmlnIGIvYXJjaC9sb29uZ2FyY2gv
S2NvbmZpZwo+ID4gPiBpbmRleCBhNWYzMDBlYzZmMjguLjU0YWQwNGRhY2RlZSAxMDA2NDQKPiA+
ID4gLS0tIGEvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZwo+ID4gPiArKysgYi9hcmNoL2xvb25nYXJj
aC9LY29uZmlnCj4gPiA+IEBAIC01OTUsNyArNTk1LDcgQEAgY29uZmlnIEFSQ0hfU0VMRUNUU19D
UkFTSF9EVU1QCj4gPiA+ICAgICAgICAgc2VsZWN0IFJFTE9DQVRBQkxFCj4gPiA+Cj4gPiA+ICBj
b25maWcgQVJDSF9IQVNfR0VORVJJQ19DUkFTSEtFUk5FTF9SRVNFUlZBVElPTgo+ID4gPiAtICAg
ICAgIGRlZl9ib29sIENSQVNIX0NPUkUKPiA+ID4gKyAgICAgICBkZWZfYm9vbCBDUkFTSF9SRVNF
UlZFCj4gPiA+Cj4gPiA+ICBjb25maWcgUkVMT0NBVEFCTEUKPiA+ID4gICAgICAgICBib29sICJS
ZWxvY2F0YWJsZSBrZXJuZWwiCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9pbmNs
dWRlL2FzbS9jcmFzaF9jb3JlLmggYi9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jcmFzaF9y
ZXNlcnZlLmgKPiA+ID4gc2ltaWxhcml0eSBpbmRleCA3NSUKPiA+ID4gcmVuYW1lIGZyb20gYXJj
aC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfY29yZS5oCj4gPiA+IHJlbmFtZSB0byBhcmNo
L2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jcmFzaF9yZXNlcnZlLmgKPiA+ID4gaW5kZXggMjE4YmRi
ZmE1MjdiLi5hMWQ5Yjg0YjFjN2QgMTAwNjQ0Cj4gPiA+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL2lu
Y2x1ZGUvYXNtL2NyYXNoX2NvcmUuaAo+ID4gPiArKysgYi9hcmNoL2xvb25nYXJjaC9pbmNsdWRl
L2FzbS9jcmFzaF9yZXNlcnZlLmgKPiA+ID4gQEAgLTEsNiArMSw2IEBACj4gPiA+ICAvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCj4gPiA+IC0jaWZuZGVmIF9MT09O
R0FSQ0hfQ1JBU0hfQ09SRV9ICj4gPiA+IC0jZGVmaW5lIF9MT09OR0FSQ0hfQ1JBU0hfQ09SRV9I
Cj4gPiA+ICsjaWZuZGVmIF9MT09OR0FSQ0hfQ1JBU0hfUkVTRVJWRV9ICj4gPiA+ICsjZGVmaW5l
IF9MT09OR0FSQ0hfQ1JBU0hfUkVTRVJWRV9ICj4gPiA+Cj4gPiA+ICAjZGVmaW5lIENSQVNIX0FM
SUdOICAgICAgICAgICAgICAgICAgICBTWl8yTQo+ID4gPgo+ID4gPiAtLQo+ID4gPiAyLjQxLjAK
PiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
