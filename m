Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1B0C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+Nb5sQyLGxCxmkFZnUjqpVBnRkzcyUskgAt8sCPNdc=; b=3uYKFh6xIGfZ0C
	smPSIa1ED60VddupINmygXEgdzgFmxk63amtbiWMBNmjjktqXZHyP6tC2BPxBB+C9GrP+JzRsasp7
	8uuepO3Ydrg6Cq+6FqdjWcgQ6ILJRLuS59DFvYn+4KX3bW2jX9q/geMg49ule9rqh1NBdG9RkFUyr
	fdGkoYZyytjDps7wUsFMZi7X1x+i9mPVKsf7UIprF/4vX2T0IB45Jc/bVUGSNtx7I6SO9iCOlEnhW
	4MHQkBAAqb3qJjdroedlqNtM0y9dIQDDf8iKWe9aKslLAnMDd3MBs/ZEFUsOCWB6h6EzXde3ibJbb
	dtc21aLoZezNTiYKorEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgoB-00000005Bxb-0PJ3;
	Wed, 24 Apr 2024 17:53:27 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgo7-00000005Bw7-3EMg
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 17:53:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 163C8CE1802
	for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 17:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DFEC4AF08
	for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713981200;
	bh=+Y1ZPNAOnvDD7u2fc6pjhcGl3M0GcN9oDhwji0epk0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7TJbDT+N7svbG0vpuJ3tinrPlxPbSpYLtp0tmTSJJxEF8lWXbS4ZfQQ0yKa0gmIX
	 G22Me/FlYTVzNGx5XyXeq69E0TzV+ijG6TpTUM7Om01z/UunwKHVan0O5RCvguFWIE
	 hkNVdxtgOhfIpTSaQQFJIwINDUlvVWtMMYvkarw6xXoycLrMY27DMHWrW4kqJToyMk
	 ifIg+3psk4vZkqYnj4Cn7SV7pQ96PD14TJXtnXQmm2NFzDPsAM7V5oTXN37qJrYhHN
	 jzmpmnfKs4zJ3by7heppEANiCFdmYCrgc7pxxNot/SAnjeE4L42BvFiNFHXfgw2193
	 IBzCAWpeTVTIQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso1363741fa.0
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 10:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6+fcO5zt0kDuxPOgpKgBUUw89IM5INX+XUnLo6aSJMWPj5DQ6gAFeYl4n3mUpdPi/4IW6c2iYnnBG8/8bPNtoOdNf985PGJs5
X-Gm-Message-State: AOJu0YznxIrewoUdhcwis6znpj45gPQx3eWqLTGpldl9S0/xQhTdRNho
	1ys/fF+9U6jX4AnjOnP2NmYXMp1c6mM2L98rxdegKXihHof2mLEdls8UuPzQGp//VWZTx0dfRQz
	g+rCyDls0ym7Wwg2GANSiBovKmU0=
X-Google-Smtp-Source: AGHT+IGaD6kQNy3sBVHgLV0XgSMMkCYb1ikpsjan0+BbARzwtTCm4njehK8ovzBB0cJMh7B8yOnSvSuisxX5Cpbybo4=
X-Received: by 2002:a2e:a602:0:b0:2da:a3ff:5254 with SMTP id
 v2-20020a2ea602000000b002daa3ff5254mr2795618ljp.1.1713981198934; Wed, 24 Apr
 2024 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-15-ardb+git@google.com> <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
In-Reply-To: <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 19:53:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
Message-ID: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_105324_178339_BD9C266D 
X-CRM114-Status: GOOD (  27.56  )
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

SGkgQnJpYW4sCgpUaGFua3MgZm9yIHRha2luZyBhIGxvb2suCgpPbiBXZWQsIDI0IEFwciAyMDI0
IGF0IDE5OjM5LCBCcmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24g
V2VkLCBBcHIgMjQsIDIwMjQgYXQgMTI6MDbigK9QTSBBcmQgQmllc2hldXZlbCA8YXJkYitnaXRA
Z29vZ2xlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2Vy
bmVsLm9yZz4KPiA+Cj4gPiBUaGUgcHVyZ2F0b3J5IGlzIGFsbW9zdCBlbnRpcmVseSBwb3NpdGlv
biBpbmRlcGVuZGVudCwgd2l0aG91dCBhbnkgbmVlZAo+ID4gZm9yIGFueSByZWxvY2F0aW9uIHBy
b2Nlc3NpbmcgYXQgbG9hZCB0aW1lIGV4Y2VwdCBmb3IgdGhlIHJlZmVyZW5jZSB0bwo+ID4gdGhl
IEdEVCBpbiB0aGUgZW50cnkgY29kZS4gR2VuZXJhdGUgdGhpcyByZWZlcmVuY2UgYXQgcnVudGlt
ZSBpbnN0ZWFkLAo+ID4gdG8gcmVtb3ZlIHRoZSBsYXN0IFJfWDg2XzY0XzY0IHJlbG9jYXRpb24g
ZnJvbSB0aGlzIGNvZGUuCj4gPgo+ID4gV2hpbGUgdGhlIEdEVCBpdHNlbGYgbmVlZHMgdG8gYmUg
cHJlc2VydmVkIGluIG1lbW9yeSBhcyBsb25nIGFzIGl0IGlzCj4gPiBsaXZlLCB0aGUgR0RUIGRl
c2NyaXB0b3IgdGhhdCBpcyB1c2VkIHRvIHByb2dyYW0gdGhlIEdEVCBjYW4gYmUKPiA+IGRpc2Nh
cmRlZCBzbyBpdCBjYW4gYmUgYWxsb2NhdGVkIG9uIHRoZSBzdGFjay4KPiA+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiAgYXJj
aC94ODYvcHVyZ2F0b3J5L2VudHJ5NjQuUyB8IDEwICsrKysrKystLS0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9wdXJnYXRvcnkvZW50cnk2NC5TIGIvYXJjaC94ODYvcHVyZ2F0b3J5L2VudHJ5
NjQuUwo+ID4gaW5kZXggOTkxMzg3N2IwZGJlLi44ODg2NjFkOWRiOWMgMTAwNjQ0Cj4gPiAtLS0g
YS9hcmNoL3g4Ni9wdXJnYXRvcnkvZW50cnk2NC5TCj4gPiArKysgYi9hcmNoL3g4Ni9wdXJnYXRv
cnkvZW50cnk2NC5TCj4gPiBAQCAtMTYsNyArMTYsMTEgQEAKPiA+Cj4gPiAgU1lNX0NPREVfU1RB
UlQoZW50cnk2NCkKPiA+ICAgICAgICAgLyogU2V0dXAgYSBnZHQgdGhhdCBzaG91bGQgYmUgcHJl
c2VydmVkICovCj4gPiAtICAgICAgIGxnZHQgZ2R0KCVyaXApCj4gPiArICAgICAgIGxlYXEgICAg
Z2R0KCVyaXApLCAlcmF4Cj4gPiArICAgICAgIHB1c2hxICAgJXJheAo+ID4gKyAgICAgICBwdXNo
dyAgICRnZHRfZW5kIC0gZ2R0IC0gMQo+ID4gKyAgICAgICBsZ2R0ICAgICglcnNwKQo+ID4gKyAg
ICAgICBhZGRxICAgICQxMCwgJXJzcAo+Cj4gVGhpcyBtaXNhbGlnbnMgdGhlIHN0YWNrLCBwdXNo
aW5nIDE2IGJ5dGVzIG9uIHRoZSBzdGFjayBidXQgb25seQo+IHJlbW92aW5nIDEwIChkZWNpbWFs
KS4KPgoKcHVzaHcgc3VidHJhY3RzIDIgZnJvbSBSU1AgYW5kIHN0b3JlcyBhIHdvcmQuIFNvIHRo
ZSB0b3RhbCBzaXplIHN0b3JlZAppcyAxMCBkZWNpbWFsIG5vdCAxNi4KCj4gPgo+ID4gICAgICAg
ICAvKiBsb2FkIHRoZSBkYXRhIHNlZ21lbnRzICovCj4gPiAgICAgICAgIG1vdmwgICAgJDB4MTgs
ICVlYXggICAgIC8qIGRhdGEgc2VnbWVudCAqLwo+ID4gQEAgLTgzLDggKzg3LDggQEAgU1lNX0RB
VEFfU1RBUlRfTE9DQUwoZ2R0KQo+ID4gICAgICAgICAgKiAweDA4IHVudXNlZAo+ID4gICAgICAg
ICAgKiBzbyB1c2UgdGhlbSBhcyBnZHQgcHRyCj4KPiBvYnNvbGV0ZSBjb21tZW50Cj4KPiA+ICAg
ICAgICAgICovCj4gPiAtICAgICAgIC53b3JkIGdkdF9lbmQgLSBnZHQgLSAxCj4gPiAtICAgICAg
IC5xdWFkIGdkdAo+ID4gKyAgICAgICAud29yZCAwCj4gPiArICAgICAgIC5xdWFkIDAKPiA+ICAg
ICAgICAgLndvcmQgMCwgMCwgMAo+Cj4gVGhpcyBjYW4gYmUgY29uZGVuc2VkIGRvd24gdG86Cj4g
ICAgICAgICAucXVhZCAwLCAwCj4KClRoaXMgY29kZSBhbmQgdGhlIGNvbW1lbnQgYXJlIHJlbW92
ZWQgaW4gdGhlIG5leHQgcGF0Y2guCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
