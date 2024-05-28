Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A3C25B7C
	for <kexec@archiver.kernel.org>; Tue, 28 May 2024 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WxrEBOGjdi+j0/z56yc9R4cPo2RnjbuYLvjsF1Pic1Q=; b=0gvpyZBgKstFTI
	UCnN/i49y2NW9x8fCaRE3UOwVl7P21Jmo1Bcc/drUa05Cn8MolgyW6682v6Xy6zb74NX7ntnW8rND
	VzyvNjIjbmgzhc6IlzRnTjzeCb84Gu4olLAFAPs27R6V0Ir63hs2xQJZbyjIkRSJ2zukjyFGbe3zB
	zNlb6qLUEOg68hwQwkWHkhkCmaC6Q14ZIGJbLy+JGtIXcfu0gtW5KuuxXeTLE/Hbf/hX3QXGYOniJ
	aJJlgXIMOx5Wi7/Ltiz9I/HuF1XYTRgA/oU0CAaTK00I9jI6n5x+SGRtMeOOmc+QR5L8o1lHAjGU5
	k/2PIkocyRUEj6TH8vlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBteR-000000008HH-3lmZ;
	Tue, 28 May 2024 10:01:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBteM-000000008FQ-3m98
	for kexec@lists.infradead.org;
	Tue, 28 May 2024 10:01:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 72F1B61E95
	for <kexec@lists.infradead.org>; Tue, 28 May 2024 10:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DA6C32782
	for <kexec@lists.infradead.org>; Tue, 28 May 2024 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890505;
	bh=Y2E9LMJOmZGaKwGYezKBuZaUNvib7wYH8wfYOZyvMfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S9MBWC7RSuhidbunFi1mTZaZNejNJVPTNwja0NCLR0wVZCce5l+mzOL8xKzZmZrLz
	 48YvBlO1cRZyCk93QJwoC5Vbwj6w4a4XHfuC/liSpBb0Ew1Fomiw1pZEexAWt8NSdm
	 4xDM+23raWUvURKpmPJ92TKCiSYEIw4QWD9IkpQQb1lYBuR/OvmSMeLV03AQjH4FPX
	 GN1YxNPLOlC6NoNPHX79dPQjVtMAVg2GFLjNV8XyJcDNQ6v5ooeD7zQMRnrKiT20yu
	 JE9R8Wk6S8WXf75L6S6pLdLrQlLMu0Ca/zlLHW96SttvgXd+xrYCg0zCm2ReYENyq6
	 IqEdaDJWnOYUg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b3364995b4so102002eaf.0
        for <kexec@lists.infradead.org>; Tue, 28 May 2024 03:01:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWj3A1pI3w48OTDLCOyvKhVBeFrtmayXipOYhbpgIMXrNWrvse8R1VHYiMBmRM7IApsidRhuGgSS3MBTvfTPswihHMNFKZSUINk
X-Gm-Message-State: AOJu0YwBX33X0ODXad4PO/yiSSNjSxeOI/4CrKtVcLS+DrQ/ock5oq32
	0hx+tWIWPcqurb5UrqF8k1ThLoikpH9hGg8qvsF6sP1oqRwNgI3a9cmjWlwQosodLWd65FE8UNH
	zCeFKTTBOqZH4VDEcnah6CWhwQnE=
X-Google-Smtp-Source: AGHT+IEfjO0Flb77SUHaCU5yQoE4DJGVCO3ob7qAG4UYz8mL7NteXu7Bev8T/M+BiVOKp1HzWSxUqAEZSBrZ2ld8T3I=
X-Received: by 2002:a05:6820:2e02:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b961b691eemr11395573eaf.1.1716890504453; Tue, 28 May 2024
 03:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 12:01:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUq6n4U50eqKrvdxjYxXxcUbJaYGmuyO4uWWDzc2C_Bg@mail.gmail.com>
Message-ID: <CAJZ5v0gUq6n4U50eqKrvdxjYxXxcUbJaYGmuyO4uWWDzc2C_Bg@mail.gmail.com>
Subject: Re: [PATCHv11 00/19] x86/tdx: Add kexec support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_030147_314587_03D45FDA 
X-CRM114-Status: GOOD (  12.47  )
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

T24gVHVlLCBNYXkgMjgsIDIwMjQgYXQgMTE6NTXigK9BTSBLaXJpbGwgQS4gU2h1dGVtb3YKPGtp
cmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+Cj4gVGhlIHBhdGNoc2V0IGFk
ZHMgYml0cyBhbmQgcGllY2VzIHRvIGdldCBrZXhlYyAoYW5kIGNyYXNoa2VybmVsKSB3b3JrIG9u
Cj4gVERYIGd1ZXN0Lgo+Cj4gVGhlIGxhc3QgcGF0Y2ggaW1wbGVtZW50cyBDUFUgb2ZmbGluaW5n
IGFjY29yZGluZyB0byB0aGUgYXBwcm92ZWQgQUNQSQo+IHNwZWMgY2hhbmdlIHBvcG9zYWxbMV0u
IEl0IHVubG9ja3Mga2V4ZWMgd2l0aCBhbGwgQ1BVcyB2aXNpYmxlIGluIHRoZSB0YXJnZXQKPiBr
ZXJuZWwuIEl0IHJlcXVpcmVzIEJJT1Mtc2lkZSBlbmFibGluZy4gSWYgaXQgbWlzc2luZyB3ZSBm
YWxsYmFjayB0byBib290aW5nCj4gMm5kIGtlcm5lbCB3aXRoIHNpbmdsZSBDUFUuCj4KPiBQbGVh
c2UgcmV2aWV3LiBJIHdvdWxkIGJlIGdsYWQgZm9yIGFueSBmZWVkYmFjay4KPgo+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMTMzNTYyNTEudUxaV0duS21oZUBrcmVhY2hlcgoKRm9y
IHRoZSBBQ1BJLXJlbGF0ZWQgY2hhbmdlcyBpbiB0aGUgc2VyaWVzCgpBY2tlZC1ieTogUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
