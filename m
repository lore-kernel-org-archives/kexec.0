Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A65DC10F15
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VcoBfj1cFyAvFgYcA5DLhA7cA3DI7AjJtksccUP74A=; b=WQWZl7ihozMnJl
	lIawSjr8EM+hjJIVr3OkUIhtPrH8E67IV/7FEZcNiHgerfWX160KOhYFUKFd6zBeQ6oOjLLQGe0XU
	HFlcOQKsZh40exQ/Z9D4tGzU3rQKY3U8A3ik+V7JT+9iTafqeMEpT3JOOB84++5lUnelawlWQZqNr
	BUwQCn3s0OCYhSxKu0HWM4XvCTkbJBqS2tetvJ6LXJLemytKrKi8c+Zk7tGRXYUZ8jzlUOz9yxNBw
	8je5S6ETzGUF01GN/sJC0N1r0ikuP7VV2+bcMEdO80nIr65LUtDXiPqD3EHGUTljnGqtr7+BTz55O
	/jk+HHgjXY4ZonHDAeMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgaV-000000059Zl-40NS;
	Wed, 24 Apr 2024 17:39:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgaT-000000059Yv-3hPW
	for kexec@bombadil.infradead.org;
	Wed, 24 Apr 2024 17:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ynaUrY5l+597sEJ6P7ZfnwDusY+Y+Lu9dBF7Lyaug0M=; b=VimVLs28amqCtmEkPXccFrxZ69
	mIeqbP8suZvTLUYZe1/9rJiGLVFE3DK5pRT7t0yOWY8xG3FomY+hmJK47JFyfsa04tZgOZPSWfILH
	gAJsSP1F3VwqM23Zf8aEclq6rG09+lKPaNjw3Cb54+vPgm9JhroF+GdquiTr0j55p1fr0zb+dUsFi
	R04uL51uaBfsaOTDZaHyCCCQZTf0DcwdgIAWfwYgbKJ3VVdYM7MS0E06reu5YlPpFQxKSuC4XinSb
	EEYJt1syRkbPxROaJQTZ/nXlKeXXcKS5qBHXsuC9v8sHrUyxqghkfJTpVBhITTSENLUzF938aLLay
	h0wq4TdA==;
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgaQ-0000000ETUH-3Mtl
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 17:39:16 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso723161fa.2
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980351; x=1714585151; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynaUrY5l+597sEJ6P7ZfnwDusY+Y+Lu9dBF7Lyaug0M=;
        b=CjkE+KwjJLei7XfUm3MkCw0IWQQg8fpzx4e8lbXHwE+TC4oIPSmXa7yYly4eCkrP0B
         hHl/BPcAhCsszrFzc+103G8hj96fkQv2SDKJXRynNwnSWwQPWz3xvuuwW+95B2Nwsmd0
         X4qGb16Fi+9FmmD73a2kh+CHPuOL1YjR9dYuccP8S7D0rbDIr4SEbxN5qQvoJA+T64ge
         U51mK1tb1jqFyide0X+O+FmQBVLQjxHQBvk0DF5f5PWdCI9V26f+3vHrVDDio12njrXs
         g+WzGSylRaT6t1HQQgsgASAfhPU18wWygX55S1rwBWaCNQIjnuHPRKkVQ3Lc1VV/MOba
         MvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980351; x=1714585151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynaUrY5l+597sEJ6P7ZfnwDusY+Y+Lu9dBF7Lyaug0M=;
        b=XTQ4TsBWF3ZSAQxW5TVdT7Mu75lhACDjy7tDlUcdq0iFFy3F0a1yNJtGejTOt9hx/x
         x7+xxlDLnXDMym1uF525UQha0MjZ5Oic8xyubw1nfNDvA9lmCRBkfzUkpp9G4nqgdaLx
         wo4W0eb6r4snDitGAgBvcs/RKoYFQ/oBL5+6EArk3K5paSVBmajR8voD3W+DrKZ2/Ota
         MDobV+Yubv5TO+jp6zejv1rR798RKeI0sJhK8gi9K30AuwwngnV/lrMbYogwPfIX9vs7
         bs3MFXrkF9mFqiIrVEsStHb4IIcwU+g+PlgdBMUjU47o1w6SatPxu8O8PVCUyDeeMtqw
         kV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWqYff37COR9cSgF4bPfLOQDt0z9RROmSugZvZVmTxxh+RNvGY+RqUPiNK2Qi1nnz+AMb1wsRp0S9b92zXNI55nPiKTrKHvv2Zo
X-Gm-Message-State: AOJu0YyTnO58AagZcAp7dd/o2B173lG4YPO3IIPB77DYp7KvOL5gEE+l
	d1oNp1gTWRuttxkP2sNch7a5Eh9fsK+iBZKpfhEOw6qteH2FNLwYqjrl4p+JEgqeeC8GtUBWGCN
	zq045S+Zr9Jb+6KHRlqYBow/tIg==
X-Google-Smtp-Source: AGHT+IGA4hqEI61enJ9DfoX5fsFrF3OkliS1nO9fyos5bePwboWZ6OpjfqsYgEZaFOhR9vir/bkYtUhStH/yT7TMC2M=
X-Received: by 2002:ac2:4ed0:0:b0:518:90fd:fa40 with SMTP id
 p16-20020ac24ed0000000b0051890fdfa40mr2071996lfr.2.1713980351078; Wed, 24 Apr
 2024 10:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com> <20240424155309.1719454-15-ardb+git@google.com>
In-Reply-To: <20240424155309.1719454-15-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 24 Apr 2024 13:38:59 -0400
Message-ID: <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_183914_980540_0FFDCB3D 
X-CRM114-Status: GOOD (  21.75  )
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

T24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMTI6MDbigK9QTSBBcmQgQmllc2hldXZlbCA8YXJkYitn
aXRAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJu
ZWwub3JnPgo+Cj4gVGhlIHB1cmdhdG9yeSBpcyBhbG1vc3QgZW50aXJlbHkgcG9zaXRpb24gaW5k
ZXBlbmRlbnQsIHdpdGhvdXQgYW55IG5lZWQKPiBmb3IgYW55IHJlbG9jYXRpb24gcHJvY2Vzc2lu
ZyBhdCBsb2FkIHRpbWUgZXhjZXB0IGZvciB0aGUgcmVmZXJlbmNlIHRvCj4gdGhlIEdEVCBpbiB0
aGUgZW50cnkgY29kZS4gR2VuZXJhdGUgdGhpcyByZWZlcmVuY2UgYXQgcnVudGltZSBpbnN0ZWFk
LAo+IHRvIHJlbW92ZSB0aGUgbGFzdCBSX1g4Nl82NF82NCByZWxvY2F0aW9uIGZyb20gdGhpcyBj
b2RlLgo+Cj4gV2hpbGUgdGhlIEdEVCBpdHNlbGYgbmVlZHMgdG8gYmUgcHJlc2VydmVkIGluIG1l
bW9yeSBhcyBsb25nIGFzIGl0IGlzCj4gbGl2ZSwgdGhlIEdEVCBkZXNjcmlwdG9yIHRoYXQgaXMg
dXNlZCB0byBwcm9ncmFtIHRoZSBHRFQgY2FuIGJlCj4gZGlzY2FyZGVkIHNvIGl0IGNhbiBiZSBh
bGxvY2F0ZWQgb24gdGhlIHN0YWNrLgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwg
PGFyZGJAa2VybmVsLm9yZz4KPiAtLS0KPiAgYXJjaC94ODYvcHVyZ2F0b3J5L2VudHJ5NjQuUyB8
IDEwICsrKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9wdXJnYXRvcnkvZW50cnk2NC5TIGIv
YXJjaC94ODYvcHVyZ2F0b3J5L2VudHJ5NjQuUwo+IGluZGV4IDk5MTM4NzdiMGRiZS4uODg4NjYx
ZDlkYjljIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L3B1cmdhdG9yeS9lbnRyeTY0LlMKPiArKysg
Yi9hcmNoL3g4Ni9wdXJnYXRvcnkvZW50cnk2NC5TCj4gQEAgLTE2LDcgKzE2LDExIEBACj4KPiAg
U1lNX0NPREVfU1RBUlQoZW50cnk2NCkKPiAgICAgICAgIC8qIFNldHVwIGEgZ2R0IHRoYXQgc2hv
dWxkIGJlIHByZXNlcnZlZCAqLwo+IC0gICAgICAgbGdkdCBnZHQoJXJpcCkKPiArICAgICAgIGxl
YXEgICAgZ2R0KCVyaXApLCAlcmF4Cj4gKyAgICAgICBwdXNocSAgICVyYXgKPiArICAgICAgIHB1
c2h3ICAgJGdkdF9lbmQgLSBnZHQgLSAxCj4gKyAgICAgICBsZ2R0ICAgICglcnNwKQo+ICsgICAg
ICAgYWRkcSAgICAkMTAsICVyc3AKClRoaXMgbWlzYWxpZ25zIHRoZSBzdGFjaywgcHVzaGluZyAx
NiBieXRlcyBvbiB0aGUgc3RhY2sgYnV0IG9ubHkKcmVtb3ZpbmcgMTAgKGRlY2ltYWwpLgoKPgo+
ICAgICAgICAgLyogbG9hZCB0aGUgZGF0YSBzZWdtZW50cyAqLwo+ICAgICAgICAgbW92bCAgICAk
MHgxOCwgJWVheCAgICAgLyogZGF0YSBzZWdtZW50ICovCj4gQEAgLTgzLDggKzg3LDggQEAgU1lN
X0RBVEFfU1RBUlRfTE9DQUwoZ2R0KQo+ICAgICAgICAgICogMHgwOCB1bnVzZWQKPiAgICAgICAg
ICAqIHNvIHVzZSB0aGVtIGFzIGdkdCBwdHIKCm9ic29sZXRlIGNvbW1lbnQKCj4gICAgICAgICAg
Ki8KPiAtICAgICAgIC53b3JkIGdkdF9lbmQgLSBnZHQgLSAxCj4gLSAgICAgICAucXVhZCBnZHQK
PiArICAgICAgIC53b3JkIDAKPiArICAgICAgIC5xdWFkIDAKPiAgICAgICAgIC53b3JkIDAsIDAs
IDAKClRoaXMgY2FuIGJlIGNvbmRlbnNlZCBkb3duIHRvOgogICAgICAgIC5xdWFkIDAsIDAKCj4K
PiAgICAgICAgIC8qIDB4MTAgNEdCIGZsYXQgY29kZSBzZWdtZW50ICovCj4gLS0KPiAyLjQ0LjAu
NzY5LmczYzQwNTE2ODc0LWdvb2cKCkJyaWFuIEdlcnN0CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
