Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C53AEEAA56
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PDVYq4U/wrzNY5fhazoi8yFq0FPYQwzTmoaamKyiOW4=; b=TI+D5Slkf+6CbW
	6Jouz42aSUZN2EguwiCdV+p0JRGFwdJFNB0ehv7Oa+N0vqAfCfWbI/V9CAgQlaBJnfTIC5tvNJGa/
	KUWYxHCRPRmz8/b//udklMlEDYPcYfRgVrNNzHyoh8WY/SQnyxz3Pgy+p+33RHKmNp8sROC5B/psT
	FpkANdoCXobzLH+5Lo9cCmtKdlDAeb4C1BPjkmTJ2ib1KKLm1mIqNfG85jhTHWxH+lK4Y2Ygpd1ri
	Cgw+fvAcMJ8mVQrZrysM+qMmLcuJ9IHcTmFU+wAzzZtrUHPsenR3tLAgh5TFGn7XTp0pVCk8TUyYe
	F53ds/8bBditQseyQOaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpFR-008un1-39;
	Thu, 14 Sep 2023 16:31:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpFO-008ulu-1l
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 16:31:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 69A03CE282D
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 16:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2086C433CA
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694709072;
	bh=yK9wOyly7qXn00unB+iWDobdGAfW+ysMR294jVlJehY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YnPF73tA4FJIt1zHgix/GbKseAd2p1qSvJtvFEtLKU3tglVfdtSVXz45R90EkROQz
	 4DpirqdSNTq64df/D8anke/yvRlxoNEUDu6aYxjnyf/Z4JUO9LnCsZyYHmiNwgiMcl
	 5IHyGhGtTIOsXVfp3AD3GwKvno+ZwQOi+qR6VWpQzoWEZVywa6c35nRqcoNhN4VWYA
	 /D479EcO6+Df3QjJVMxfSgNkUz4ldk4Dp1pbDkeAG5mCGwgVWRYgOavhfoCQE6MtkC
	 2uV3mPcZf7JO5x//6SjPYIaphF1Hg5cdZ+WD+0lZMajeZUHbBOuVZHsm1/woQ9/MyH
	 wCdJ6RKgfup4Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b974031aeaso19195801fa.0
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:31:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLoFHViY4AwPTvthNaAHS4sVx/p/s2z3xBkxjxbXZ8oRbcH2Do
	YSGolebJs6lcCAvBhEiLRwNdDRni7jDZv+c5KG0=
X-Google-Smtp-Source: AGHT+IEyDvQTasFSMTuQOc1lTVEzqzqm8NEorFEDvZRS+lGp6oHxPgR0Z57DdvNG5dUkvLYrxKYK4WrAwjGHajHGftg=
X-Received: by 2002:a2e:3012:0:b0:2b9:aa4d:3719 with SMTP id
 w18-20020a2e3012000000b002b9aa4d3719mr5166010ljw.12.1694709070929; Thu, 14
 Sep 2023 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org>
In-Reply-To: <20230908231244.1092614-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 14 Sep 2023 09:30:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
Message-ID: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To: linux-kernel@vger.kernel.org
Cc: ndesaulniers@google.com, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_093118_988253_249B37CE 
X-CRM114-Status: GOOD (  19.48  )
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

SGkgZm9sa3MsCgpPbiBGcmksIFNlcCA4LCAyMDIzIGF0IDQ6MTPigK9QTSBTb25nIExpdSA8c29u
Z0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IFdpdGggTFRPIGVuYWJsZWQsIGxkLmxsZCBnZW5lcmF0
ZXMgbXVsdGlwbGUgLnRleHQgc2VjdGlvbnMgZm9yCj4gcHVyZ2F0b3J5LnJvOgo+Cj4gJCByZWFk
ZWxmIC1TIHB1cmdhdG9yeS5ybyAgfCBncmVwICIgLnRleHQiCj4gICBbIDFdIC50ZXh0ICAgICAg
ICAgICAgIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDAwNDAKPiAgIFsg
N10gLnRleHQucHVyZ2F0b3J5ICAgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAw
MDAwMjBlMAo+ICAgWyA5XSAudGV4dC53YXJuICAgICAgICBQUk9HQklUUyAgICAgICAgIDAwMDAw
MDAwMDAwMDAwMDAgIDAwMDAyMWMwCj4gICBbMTNdIC50ZXh0LnNoYTI1Nl91cGRhIFBST0dCSVRT
ICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDIyZjAKPiAgIFsxNV0gLnRleHQuc2hhMjI0
X3VwZGEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMmJlMAo+ICAgWzE3
XSAudGV4dC5zaGEyNTZfZmluYSBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAw
MDAyYmYwCj4gICBbMTldIC50ZXh0LnNoYTIyNF9maW5hIFBST0dCSVRTICAgICAgICAgMDAwMDAw
MDAwMDAwMDAwMCAgMDAwMDJjYzAKPgo+IFRoaXMgY2F1c2UgV0FSTklORyBmcm9tIGtleGVjX3B1
cmdhdG9yeV9zZXR1cF9zZWNoZHJzKCk6Cj4KPiBXQVJOSU5HOiBDUFU6IDI2IFBJRDogMTEwODk0
IGF0IGtlcm5lbC9rZXhlY19maWxlLmM6OTE5Cj4ga2V4ZWNfbG9hZF9wdXJnYXRvcnkrMHgzN2Yv
MHgzOTAKPgo+IEZpeCB0aGlzIGJ5IGRpc2FibGluZyBMVE8gZm9yIHB1cmdhdG9yeS4KPgo+IEZp
eGVzOiA4NjUyZDQ0ZjQ2NmEgKCJrZXhlYzogc3VwcG9ydCBwdXJnYXRvcmllcyB3aXRoIC50ZXh0
LmhvdCBzZWN0aW9ucyIpCj4gQ2M6IFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5v
cmc+Cj4gQ2M6IFNhbWkgVG9sdmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPgo+IENjOiBr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPiBDYzogeDg2QGtlcm5lbC5vcmcKPiBDYzogbGx2bUBsaXN0cy5saW51eC5kZXYKPiBTaWdu
ZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPgoKV2hhdCB3b3VsZCBiZSB0aGUg
bmV4dCBzdGVwIGZvciB0aGlzIHdvcms/IFdlIGhvcGUgdG8gYmFjayBwb3J0IGl0CnRvIG91ciBw
cm9kdWN0aW9uIGtlcm5lbCBzb29uLgoKVGhhbmtzLApTb25nCgo+Cj4gLS0tCj4gQUZBSUNULCB4
ODYgaXMgdGhlIG9ubHkgYXJjaCB0aGF0IHN1cHBvcnRzIExUTyBhbmQgcHVyZ2F0b3J5Lgo+Cj4g
Q2hhbmdlcyBpbiB2MjoKPiAxLiBVc2UgQ0NfRkxBR1NfTFRPIGluc3RlYWQgb2YgaGFyZGNvZGUg
LWZsdG8uIChOaWNrIERlc2F1bG5pZXJzKQo+IC0tLQo+ICBhcmNoL3g4Ni9wdXJnYXRvcnkvTWFr
ZWZpbGUgfCA0ICsrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZSBiL2FyY2gveDg2L3B1cmdhdG9y
eS9NYWtlZmlsZQo+IGluZGV4IGMyYTI5YmUzNWMwMS4uMDhhYTBmMjVmMTJhIDEwMDY0NAo+IC0t
LSBhL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+ICsrKyBiL2FyY2gveDg2L3B1cmdhdG9y
eS9NYWtlZmlsZQo+IEBAIC0xOSw2ICsxOSwxMCBAQCBDRkxBR1Nfc2hhMjU2Lm8gOj0gLURfX0RJ
U0FCTEVfRVhQT1JUUyAtRF9fTk9fRk9SVElGWQo+ICAjIG9wdGltaXphdGlvbiBmbGFncy4KPiAg
S0JVSUxEX0NGTEFHUyA6PSAkKGZpbHRlci1vdXQgLWZwcm9maWxlLXNhbXBsZS11c2U9JSAtZnBy
b2ZpbGUtdXNlPSUsJChLQlVJTERfQ0ZMQUdTKSkKPgo+ICsjIFdoZW4gTFRPIGlzIGVuYWJsZWQs
IGxsdm0gZW1pdHMgbWFueSB0ZXh0IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkCj4g
KyMgYnkga2V4ZWMuIFJlbW92ZSAtZmx0bz0qIGZsYWdzLgo+ICtLQlVJTERfQ0ZMQUdTIDo9ICQo
ZmlsdGVyLW91dCAkKENDX0ZMQUdTX0xUTyksJChLQlVJTERfQ0ZMQUdTKSkKPiArCj4gICMgV2hl
biBsaW5raW5nIHB1cmdhdG9yeS5ybyB3aXRoIC1yIHVucmVzb2x2ZWQgc3ltYm9scyBhcmUgbm90
IGNoZWNrZWQsCj4gICMgYWxzbyBsaW5rIGEgcHVyZ2F0b3J5LmNoayBiaW5hcnkgd2l0aG91dCAt
ciB0byBjaGVjayBmb3IgdW5yZXNvbHZlZCBzeW1ib2xzLgo+ICBQVVJHQVRPUllfTERGTEFHUyA6
PSAtZSBwdXJnYXRvcnlfc3RhcnQgLXogbm9kZWZhdWx0bGliCj4gLS0KPiAyLjM0LjEKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
