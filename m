Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EDCEEB570
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MA10HiX2V+FXs+yeEmdHjf/ym53YHHYVvxAdbPL5Yx0=; b=PIS6Y9mEmHXpe3
	R/hL3OLppUkiCONv+FQIr0QWV3wSznekl+NpB8O7hrK12mzj3g5zJ8rnPC8O7J6vPudZ2G1ES81as
	6pPEnYhvdzZhc0jD5a3J41BvQSodlN9+BoYuEba5sWR9PHeR+IIy0n0bUAdIj6FGrEZYn8UM+ZhLx
	Z+rkgsFsmiGdSIw7UKubbHb2pmTdX7e0S9uWXtZCGPNOpDLUlBV4cWqccCVDEYlPMo7OK+p5s0oP6
	0ZFpbbgbkSrrdGanlURumRsC/buITrDJTwPSoycN1ppaZ8IJFqNrd+zMZJAHPq/+2eZoKYWhj+7bX
	ruymeuj6bLmFzZQuAYYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qekcx-00Efoc-0h;
	Fri, 08 Sep 2023 23:11:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qekcu-00Efo2-0F
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 23:11:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 19C3D614F5
	for <kexec@lists.infradead.org>; Fri,  8 Sep 2023 23:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD2C433CD
	for <kexec@lists.infradead.org>; Fri,  8 Sep 2023 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694214658;
	bh=f+inhm0X+wSIsbS7nGkQlD4ziqDqwkrezqRi8joSHLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qlJ/EojXbzqZjFi+HZY9uVC39b8rjhVxZAH8ldpry0BCboXtBwSlcY+7Aw+M6cpDZ
	 7KZ9jjejq04va6b+dakqIxyJnqeICXk/A9Kpti4xc9FcsBQZWYV1bDcJSm/qP3HUM5
	 7yCo91vB0XpkV2qfrXgAGhXoVHK9tdTsg8ZXs27jGSqrCDy2IOTZTgfsQrcnonGM0r
	 dVS07BIllfYf5G8TOMDAeMW5yx0lrdxyZ7gKGhQTg4HdQwkdG8e4J1X5pGwB5BM0M9
	 5xcZTYO8yXfNesPBURDSi9HyCDHOg6nEbtowGfQO7WdHd72ADnOJwezWIur9cJy4qs
	 9yIQqLhY+YYGQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5007c8308c3so4310472e87.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 16:10:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLOqAropxRZVhwfaZ+Enw1o4iL6UK5469dAlplacEFR29UQFY+
	EEbgY86eYLXktjZP1QC0OwgFsjJfetmcTs+XK2g=
X-Google-Smtp-Source: AGHT+IFAHSeut3CZTN1maFrthLyJK3L37GkdrjNTQk98ZKwPoYw8ayKHxL/mm5gYph+nAmphdU3ADPjaat9Ut2fB0oQ=
X-Received: by 2002:ac2:4c94:0:b0:500:94c5:6e06 with SMTP id
 d20-20020ac24c94000000b0050094c56e06mr2520205lfl.56.1694214656726; Fri, 08
 Sep 2023 16:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230908225353.984169-1-song@kernel.org> <ZPunWKU/TlrN9xiH@google.com>
In-Reply-To: <ZPunWKU/TlrN9xiH@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Sep 2023 16:10:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZovvWG=KyDR80tEDbKda0=sGsVoKzLJDfBz1n4A7BPg@mail.gmail.com>
Message-ID: <CAPhsuW5ZovvWG=KyDR80tEDbKda0=sGsVoKzLJDfBz1n4A7BPg@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Remove LTO flags
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, songliubraving@fb.com, 
	Ricardo Ribalda <ribalda@chromium.org>, kexec@lists.infradead.org, x86@kernel.org, 
	samitolvanen@google.com, llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_161100_222309_031976CD 
X-CRM114-Status: GOOD (  23.05  )
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

T24gRnJpLCBTZXAgOCwgMjAyMyBhdCAzOjU54oCvUE0gTmljayBEZXNhdWxuaWVycyA8bmRlc2F1
bG5pZXJzQGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBTZXAgMDgsIDIwMjMgYXQgMDM6
NTM6NTNQTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6Cj4gPiBXaXRoIExUTyBlbmFibGVkLCBsZC5s
bGQgZ2VuZXJhdGVzIG11bHRpcGxlIC50ZXh0IHNlY3Rpb25zIGZvcgo+ID4gcHVyZ2F0b3J5LnJv
Ogo+ID4KPiA+ICQgcmVhZGVsZiAtUyBwdXJnYXRvcnkucm8gIHwgZ3JlcCAiIC50ZXh0Igo+ID4g
ICBbIDFdIC50ZXh0ICAgICAgICAgICAgIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAw
MCAgMDAwMDAwNDAKPiA+ICAgWyA3XSAudGV4dC5wdXJnYXRvcnkgICBQUk9HQklUUyAgICAgICAg
IDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyMGUwCj4gPiAgIFsgOV0gLnRleHQud2FybiAgICAgICAg
UFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMjFjMAo+ID4gICBbMTNdIC50
ZXh0LnNoYTI1Nl91cGRhIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDIy
ZjAKPiA+ICAgWzE1XSAudGV4dC5zaGEyMjRfdXBkYSBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAw
MDAwMDAwMDAgIDAwMDAyYmUwCj4gPiAgIFsxN10gLnRleHQuc2hhMjU2X2ZpbmEgUFJPR0JJVFMg
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMmJmMAo+ID4gICBbMTldIC50ZXh0LnNoYTIy
NF9maW5hIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDJjYzAKPiA+Cj4g
PiBUaGlzIGNhdXNlIFdBUk5JTkcgZnJvbSBrZXhlY19wdXJnYXRvcnlfc2V0dXBfc2VjaGRycygp
Ogo+ID4KPiA+IFdBUk5JTkc6IENQVTogMjYgUElEOiAxMTA4OTQgYXQga2VybmVsL2tleGVjX2Zp
bGUuYzo5MTkKPiA+IGtleGVjX2xvYWRfcHVyZ2F0b3J5KzB4MzdmLzB4MzkwCj4gPgo+ID4gRml4
IHRoaXMgYnkgZGlzYWJsaW5nIExUTyBmb3IgcHVyZ2F0b3J5Lgo+ID4KPiA+IEZpeGVzOiA4NjUy
ZDQ0ZjQ2NmEgKCJrZXhlYzogc3VwcG9ydCBwdXJnYXRvcmllcyB3aXRoIC50ZXh0LmhvdCBzZWN0
aW9ucyIpCj4gPiBDYzogUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4KPiA+
IENjOiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwo+ID4gQ2M6IHg4NkBrZXJuZWwub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBTb25n
IExpdSA8c29uZ0BrZXJuZWwub3JnPgo+ID4KPiA+IC0tLQo+ID4gQUZBSUNULCB4ODYgaXMgdGhl
IG9ubHkgYXJjaCB0aGF0IHN1cHBvcnRzIExUTyBhbmQgcHVyZ2F0b3J5Lgo+ID4gLS0tCj4gPiAg
YXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxlIHwgNCArKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9wdXJnYXRvcnkv
TWFrZWZpbGUgYi9hcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUKPiA+IGluZGV4IGMyYTI5YmUz
NWMwMS4uOWMwYmZmNDk5MmVhIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC94ODYvcHVyZ2F0b3J5L01h
a2VmaWxlCj4gPiArKysgYi9hcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUKPiA+IEBAIC0xOSw2
ICsxOSwxMCBAQCBDRkxBR1Nfc2hhMjU2Lm8gOj0gLURfX0RJU0FCTEVfRVhQT1JUUyAtRF9fTk9f
Rk9SVElGWQo+ID4gICMgb3B0aW1pemF0aW9uIGZsYWdzLgo+ID4gIEtCVUlMRF9DRkxBR1MgOj0g
JChmaWx0ZXItb3V0IC1mcHJvZmlsZS1zYW1wbGUtdXNlPSUgLWZwcm9maWxlLXVzZT0lLCQoS0JV
SUxEX0NGTEFHUykpCj4gPgo+ID4gKyMgV2hlbiBMVE8gaXMgZW5hYmxlZCwgbGx2bSBlbWl0cyBt
YW55IHRleHQgc2VjdGlvbnMsIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQKPiA+ICsjIGJ5IGtleGVj
LiBSZW1vdmUgLWZsdG89KiBmbGFncy4KPiA+ICtLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVyLW91
dCAtZmx0bz0lLCQoS0JVSUxEX0NGTEFHUykpCj4KPiBUaGFua3MgZm9yIHRoZSBwYXRjaCEKPgo+
IFBsZWFzZSBwcmVmZXIgc29tZXRoaW5nIGFraW4gdG86Cj4gY29tbWl0IDZlMjBmMTg1NzljNSAo
ImVmaS9saWJzdHViOiBkaXNhYmxlIExUTyIpCgpUaGFua3MgZm9yIHRoZSBwb2ludGVyISBUaGlz
IGRvZXMgbG9vayBiZXR0ZXIuCgpUaGFua3MsClNvbmcKCj4KPiBQbGVhc2UgYWxzbyBDQyBTYW1p
IGFuZCBsbHZtQGxpc3RzLmxpbnV4LmRldiBmb3IgdjIuCj4KPiBQcmV0dHkgc3VyZSB3ZSB1c2Ug
YSBsaW5rZXIgc2NyaXB0IHRvIHJlam9pbiAudGV4dC4qIGVsc2V3aGVyZSBpbiB0aGUKPiBrZXJu
ZWwsIGJ1dCBpdCBkb2Vzbid0IGxvb2sgbGlrZSB4ODYgcHVyZ2F0b3J5IGhhcyBvbmUuCj4KPiA+
ICsKPiA+ICAjIFdoZW4gbGlua2luZyBwdXJnYXRvcnkucm8gd2l0aCAtciB1bnJlc29sdmVkIHN5
bWJvbHMgYXJlIG5vdCBjaGVja2VkLAo+ID4gICMgYWxzbyBsaW5rIGEgcHVyZ2F0b3J5LmNoayBi
aW5hcnkgd2l0aG91dCAtciB0byBjaGVjayBmb3IgdW5yZXNvbHZlZCBzeW1ib2xzLgo+ID4gIFBV
UkdBVE9SWV9MREZMQUdTIDo9IC1lIHB1cmdhdG9yeV9zdGFydCAteiBub2RlZmF1bHRsaWIKPiA+
IC0tCj4gPiAyLjM0LjEKPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
