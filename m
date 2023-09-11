Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844CAEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wbb4vWdKE4ZFW6tCJbnsaKDE+/PsGxjVOkij8GAbjQs=; b=sr3Dfv6d7xtyaR
	dc6ojBmhzIpIom9zAUOBmWq5Ef2fpa4YkRnIKUjxfdNH0604vJkH+oZkP046VFwywOB5tSBXNoF/t
	+ldgUqH8FudPqHad+hAJkhQy/lVJX/exYtyX6sljjFZsg10WCPsnQ4bRRG8gYAUSf1M4rbtMuX6eB
	nqmPZv9f/Ww6C5oasJewRzD3AjryfttZ7KlO6QP3or58A/uLPfuV/CWSZciAdj2wewvofhOAt7xu8
	a+4+bKfMxxSvkYawh+pE4jPZGpaQjoeOiZjk2QTVa1pHjzZm929lZTUDZQTWMHbzSCpxcd5W0cqbo
	a9DuWXK0FTfh7Pr5G7ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjol-0010Ha-1C;
	Mon, 11 Sep 2023 16:31:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjoj-0010Ga-17
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 16:31:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3737161219
	for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 16:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5F8C433C9
	for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694449875;
	bh=f3Qo6vrFojIPwWqmmZcbQ18TQJdcfxhyQGQLG3jKQTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FCDAh3+lVLkldKUGjU089uedxOobflo8NE7QBVwSUeOeZY/HE2dsrqtbzUunspkxV
	 DxaMX7tTQYQLvpgj2B2bMFVUcX82nXTRqwhGG5xBeeIZHLMT71IA00XrxUjmkJi2QE
	 W0JcdypccA9nVQB3j6YGhtfwUE2ZhN+NFcR221G/11nuHwm8q/gLhArLxdGzHaDPC7
	 XM7YVffg12FPAVg7uNZ1qhmdm7fGZthHeQXEorK3aF973wvhbHz5ygH1daiwjm+DwJ
	 tU7JXRi48nitrD7dfF02JkhmIa8p8MNOKthxcRhZJfOZy6xv7JZJAAs0GJN/bc4Jrj
	 RlpeiVGtS5yjA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5007616b756so7676886e87.3
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 09:31:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/p+AYAKb1+IlIqf8POaHTqV2yJqDQlHJhYHs/1jjj9ZAFDl2q
	VUz6+CR0LFEE6qCCDY+Q1B1sm5ETxd9vhLFVJcQ=
X-Google-Smtp-Source: AGHT+IFUCSWoNbCnVdv+73dqZmj9FkBmSsJ2WzqpqM3ykhn0+wQPE5+sRP8nObYHWezRHG2xouoG5bQu8UF0YTh+jWU=
X-Received: by 2002:a05:6512:281c:b0:4fe:ecd:4950 with SMTP id
 cf28-20020a056512281c00b004fe0ecd4950mr10349873lfb.1.1694449873780; Mon, 11
 Sep 2023 09:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
In-Reply-To: <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 11 Sep 2023 09:31:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4CejZE443U1U+Svc-auPvOp97UcS3Die=rkstz0HRExw@mail.gmail.com>
Message-ID: <CAPhsuW4CejZE443U1U+Svc-auPvOp97UcS3Die=rkstz0HRExw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_093117_494172_22D71BB3 
X-CRM114-Status: GOOD (  32.54  )
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgOTowMOKAr0FNIE5pY2sgRGVzYXVsbmllcnMKPG5kZXNh
dWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgU2VwIDgsIDIwMjMgYXQgNDox
M+KAr1BNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IFdpdGggTFRP
IGVuYWJsZWQsIGxkLmxsZCBnZW5lcmF0ZXMgbXVsdGlwbGUgLnRleHQgc2VjdGlvbnMgZm9yCj4g
PiBwdXJnYXRvcnkucm86Cj4gPgo+ID4gJCByZWFkZWxmIC1TIHB1cmdhdG9yeS5ybyAgfCBncmVw
ICIgLnRleHQiCj4gPiAgIFsgMV0gLnRleHQgICAgICAgICAgICAgUFJPR0JJVFMgICAgICAgICAw
MDAwMDAwMDAwMDAwMDAwICAwMDAwMDA0MAo+ID4gICBbIDddIC50ZXh0LnB1cmdhdG9yeSAgIFBS
T0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDIwZTAKPiA+ICAgWyA5XSAudGV4
dC53YXJuICAgICAgICBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyMWMw
Cj4gPiAgIFsxM10gLnRleHQuc2hhMjU2X3VwZGEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAw
MDAwMDAwICAwMDAwMjJmMAo+ID4gICBbMTVdIC50ZXh0LnNoYTIyNF91cGRhIFBST0dCSVRTICAg
ICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDJiZTAKPiA+ICAgWzE3XSAudGV4dC5zaGEyNTZf
ZmluYSBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyYmYwCj4gPiAgIFsx
OV0gLnRleHQuc2hhMjI0X2ZpbmEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAw
MDAwMmNjMAo+ID4KPiA+IFRoaXMgY2F1c2UgV0FSTklORyBmcm9tIGtleGVjX3B1cmdhdG9yeV9z
ZXR1cF9zZWNoZHJzKCk6Cj4gPgo+ID4gV0FSTklORzogQ1BVOiAyNiBQSUQ6IDExMDg5NCBhdCBr
ZXJuZWwva2V4ZWNfZmlsZS5jOjkxOQo+ID4ga2V4ZWNfbG9hZF9wdXJnYXRvcnkrMHgzN2YvMHgz
OTAKPiA+Cj4gPiBGaXggdGhpcyBieSBkaXNhYmxpbmcgTFRPIGZvciBwdXJnYXRvcnkuCj4KPiBU
aGFua3MgZm9yIHRoZSB2MiEKPgo+ID4KPiA+IEZpeGVzOiA4NjUyZDQ0ZjQ2NmEgKCJrZXhlYzog
c3VwcG9ydCBwdXJnYXRvcmllcyB3aXRoIC50ZXh0LmhvdCBzZWN0aW9ucyIpCj4KPiBEdW5ubyB0
aGF0IHRoaXMgZml4ZXMgdGFnIGlzIHByZWNpc2UuICBJIHRoaW5rIHBlcmhhcHMKPgo+IEZpeGVz
OiBiMzNmZmYwN2UzZTMgKCJ4ODYsIGJ1aWxkOiBhbGxvdyBMVE8gdG8gYmUgc2VsZWN0ZWQiKQoK
VGhhbmtzIGZvciB0aGUgY29ycmVjdGlvbiEKCj4KPiB3b3VsZCBiZSBtb3JlIHByZWNpc2UuCj4K
PiA+IENjOiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3JnPgo+ID4gQ2M6IFNh
bWkgVG9sdmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPgo+ID4gQ2M6IGtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiBD
YzogeDg2QGtlcm5lbC5vcmcKPiA+IENjOiBsbHZtQGxpc3RzLmxpbnV4LmRldgo+ID4gU2lnbmVk
LW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4KPiA+Cj4gPiAtLS0KPiA+IEFGQUlD
VCwgeDg2IGlzIHRoZSBvbmx5IGFyY2ggdGhhdCBzdXBwb3J0cyBMVE8gYW5kIHB1cmdhdG9yeS4K
PiA+Cj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gMS4gVXNlIENDX0ZMQUdTX0xUTyBpbnN0ZWFkIG9m
IGhhcmRjb2RlIC1mbHRvLiAoTmljayBEZXNhdWxuaWVycykKPiA+IC0tLQo+ID4gIGFyY2gveDg2
L3B1cmdhdG9yeS9NYWtlZmlsZSB8IDQgKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxl
IGIvYXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxlCj4gPiBpbmRleCBjMmEyOWJlMzVjMDEuLjA4
YWEwZjI1ZjEyYSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+
ID4gKysrIGIvYXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxlCj4gPiBAQCAtMTksNiArMTksMTAg
QEAgQ0ZMQUdTX3NoYTI1Ni5vIDo9IC1EX19ESVNBQkxFX0VYUE9SVFMgLURfX05PX0ZPUlRJRlkK
PiA+ICAjIG9wdGltaXphdGlvbiBmbGFncy4KPiA+ICBLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVy
LW91dCAtZnByb2ZpbGUtc2FtcGxlLXVzZT0lIC1mcHJvZmlsZS11c2U9JSwkKEtCVUlMRF9DRkxB
R1MpKQo+ID4KPiA+ICsjIFdoZW4gTFRPIGlzIGVuYWJsZWQsIGxsdm0gZW1pdHMgbWFueSB0ZXh0
IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkCj4gPiArIyBieSBrZXhlYy4gUmVtb3Zl
IC1mbHRvPSogZmxhZ3MuCj4KPiAtZmx0byogaW4gTExWTSBpbXBsaWVzIC1mZnVuY3Rpb24tc2Vj
dGlvbnMsIHdoaWNoIGNyZWF0ZXMgYSAudGV4dC48Zm4KPiBuYW1lPiBzZWN0aW9uIHBlciBmdW5j
dGlvbiBkZWZpbml0aW9uIHRvIGZhY2lsaXRhdGUgLVdsLC0tZ2Mtc2VjdGlvbnMuCj4KPiBPdmVy
YWxsIHRoZSBxdWVzdGlvbiBoZXJlIGlzICJkbyB3ZSByZWFsbHkgbmVlZCB0byBvcHRpbWl6ZSBr
ZXhlYz8iCj4KPiBJZiB0aGUgYW5zd2VyIGlzIHllcywgdGhlbiB0aGlzIHBhdGNoIEFORCA4NjUy
ZDQ0ZjQ2NmEgYXJlIGJvdGgKPiBwZXNzaW1pemluZyBrZXhlYyAodGhvdWdoIGhhdmluZyBpdCB3
b3JrIGF0IGFsbCBpcyBzdHJpY3RseSBiZXR0ZXIKPiB0aGFuIG5vdCBhdCBhbGwpLiAgVGhlIGJl
c3QgZml4IElNTyB3b3VsZCBiZSB0byBwcm92aWRlIGEgbGlua2VyCj4gc2NyaXB0IGZvciB0aGlz
IHB1cmdhdG9yeSBpbWFnZSB0aGF0IHJlam9pbnMgdGhlIHRleHQgc2VjdGlvbnMgYmFjawo+IGlu
dG8gb25lIC50ZXh0LiAgRm9yIGV4YW1wbGU6Cj4KPiBjb21taXQgZWZmODcyOGZlNjk4ICgidm1s
aW51eC5sZHMuaDogQWRkIFBHTyBhbmQgQXV0b0ZETyBpbnB1dCBzZWN0aW9ucyIpCj4KPiBJIGFz
c3VtZSBwZW9wbGUgZG8gY2FyZSBhYm91dCB0aGUgdGltZSB0byBrZXhlYywgaGVuY2UgdGhlIHJh
aXNvbgo+IGQnZXRyZSBmb3IgcHJvamVjdHMgbGlrZSBrcGF0Y2guCgpBRkFJQ1QsIG9wdGltaXph
dGlvbnMgbGlrZSBMVE8gYW5kIFBHTyBjYW4gZ2l2ZSBhIGZldyAlIG9mCmltcHJvdmVtZW50LCB3
aGljaCBpcyBwcm9iYWJseSBub3QgaW1wb3J0YW50IGZvciBrZXhlYy4gVGhlIGJlbmVmaXQKaXMg
aW4gdGhlIG9yZGVyIG9mIHNlY29uZHMgKG9yIGxlc3M/KS4gVGhlIGJlbmVmaXQgb2Yga3BhdGNo
IGlzIHRoYXQgd2UKY2FuIGtlZXAgdGhlIHdvcmtsb2FkIHJ1bm5pbmcgd2hpbGUgZml4aW5nIHRo
ZSBrZXJuZWwgYnVnLiBCYXNlZCBvbgpvdXIgZXhwZXJpZW5jZSBhdCBNZXRhLCBpdCBtYXkgdGFr
ZSBob3VycyB0byBncmFjZWZ1bCBzaHV0ZG93biB0aGUKYXBwbGljYXRpb24gdG8gcnVuIGtleGVj
LiBJbiB0aGlzIGNhc2UsIGEgZmV3IHNlY29uZHMgb2YgaW1wcm92ZW1lbnQKKHZpYSBMVE8vUEdP
IHB1cmdhdG9yeSkgZG9lc24ndCBzYXZlIHVzIG11Y2guCgpUaGFua3MsClNvbmcKCj4KPiBJJ20g
ZmluZSB0byBzaWduIG9mZiBvbiB0aGlzIGFwcHJvYWNoIGlmIHdlIGRvbid0IHJlYWxseSBjYXJl
LCBvciB3YW50Cj4gdG8gY2FyZSBtb3JlIGxhdGVyLCBidXQgd2UgY2FuIGRvIGJldHRlciBoZXJl
Lgo+Cj4gPiArS0JVSUxEX0NGTEFHUyA6PSAkKGZpbHRlci1vdXQgJChDQ19GTEFHU19MVE8pLCQo
S0JVSUxEX0NGTEFHUykpCj4gPiArCj4gPiAgIyBXaGVuIGxpbmtpbmcgcHVyZ2F0b3J5LnJvIHdp
dGggLXIgdW5yZXNvbHZlZCBzeW1ib2xzIGFyZSBub3QgY2hlY2tlZCwKPiA+ICAjIGFsc28gbGlu
ayBhIHB1cmdhdG9yeS5jaGsgYmluYXJ5IHdpdGhvdXQgLXIgdG8gY2hlY2sgZm9yIHVucmVzb2x2
ZWQgc3ltYm9scy4KPiA+ICBQVVJHQVRPUllfTERGTEFHUyA6PSAtZSBwdXJnYXRvcnlfc3RhcnQg
LXogbm9kZWZhdWx0bGliCj4gPiAtLQo+ID4gMi4zNC4xCj4gPgo+Cj4KPiAtLQo+IFRoYW5rcywK
PiB+TmljayBEZXNhdWxuaWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
