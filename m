Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF61EEAA66
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwUllPnnsh/W554TKjRR88gRMuSknlnpLLcN9JajB4M=; b=zAja7FgdK81Uuh
	vid4bLjSDvqdypg+TfGLDJpbFd11qZok0bxQ1HxN+CKupei67CpqHlJtycDpokUeHxAG66a6Aw+8S
	2Qbp09DuUsFpGXYs+IECwiILK/yllQ2hXcAZ9RIiW63od4OebkLzo57ADql8fChTzaetNAXJ3DMPc
	vhaRWVgHM4fdtl7tgCbE+5dEaaVlpNfQ5LTJpGfOWmfyvxqoaH0XyPGFqKGNILy3OK6nP3lk+R4XP
	cX+LsZPp/vrAERwJrIlyCLFIUaOfAshU6cY8PN/N3xo4kCnRbYGJ4AMP8k+QTC/zYgAMUF9k0WUik
	TdOiZUt3GSQ1q+USWVAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgros-0099Ic-30;
	Thu, 14 Sep 2023 19:16:06 +0000
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgroq-0099Gb-1m
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 19:16:05 +0000
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c09f1f4610so764400a34.0
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694718958; x=1695323758; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/OKaoFTzHFPckQ8elHjeRhc3HPJtJWQjmgI/gL6p9I=;
        b=LYHnTbkmtPvzZMTpug9iqDzBN5DSOP2e+hD9RGCjleOI1uRZGLmFsY5ZUU+v0zPtya
         XNQsQw2J/NgKVqKAKRt7fHuVZzSnBMnbgqC+szWX0rx9lQu3AHYrncWWdYnH/JnNRteI
         RX6EbGhSEXVxyqedzr64vBx4w4ayv+Ki24sOyJs6js3PWV503oY9biS+gnLsOxVvcg4P
         J/ez+luBoQCcZNNvQcdW9FeP/dXvwUPsUy21V8z6hF5Zz1/WaD7hPUy2l//qY9lqFL82
         RpTF8hlv+6lX/SJTWEdWKmNfTBmPa4515gL2CMKl98hHmu3IXfVfA5ppOvWIRZmT4a1U
         /dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694718958; x=1695323758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/OKaoFTzHFPckQ8elHjeRhc3HPJtJWQjmgI/gL6p9I=;
        b=X9BjdCvEsrC7S0xQ5qefT9/xIKnodYHePi0yhmdTGXAfESXRyTAs8Sc36q6AMYaZ42
         TvpTqbT2JbB27G3rG00qczGy/1Uw2k0WbBSdGF8OWHR8OaLpJB0GA41+qes3TuY714zI
         ElDFEQqGxFFp8xGHsqtgCDfLhfXHkVnim+SD6l//fuwEeS5qv3/oEb8d2H9Zr/TghRMK
         336Ue+uhS8GPTNpRl8zSIT1apbPjmoE37XJIlmjEnkVNh+b8Hd3KQPYrXa4+bFy60Efl
         4yhxz1tHALPuVI1ebMMtzihdLWsMSn9i2YAoyIp5G/xMXHxOxg50ybzLpSWPz6ebx+/c
         X7oA==
X-Gm-Message-State: AOJu0YzUfYa1cEmgfSGzhINgpzZEVpYfhguiI0gbV2daEzugsBu1PbYm
	ndvrD14K9CSP+2kT6zV7jegE+O9lMf4IUfcFoX+Eag==
X-Google-Smtp-Source: AGHT+IFgjCX7b6T7mbh0ViVMGicpC/DaCfIz07Wpfl/pmZh0VIBshCVYBpO+RJhvDcH2HnGIfPB6GohIOiUqcipNCFE=
X-Received: by 2002:a05:6358:7302:b0:135:4003:7857 with SMTP id
 d2-20020a056358730200b0013540037857mr3832327rwg.31.1694718958043; Thu, 14 Sep
 2023 12:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230914170138.995606-1-song@kernel.org>
In-Reply-To: <20230914170138.995606-1-song@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 14 Sep 2023 12:15:21 -0700
Message-ID: <CABCJKufZJstbnjtcwKRY1CSE-eZBnbYScpD6wp9fMXmpFfdBoA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/purgatory: Remove LTO flags
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, ndesaulniers@google.com, 
	Ricardo Ribalda <ribalda@chromium.org>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_121604_590968_138252E5 
X-CRM114-Status: GOOD (  19.87  )
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

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTA6MDLigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPiB3cm90ZToKPgo+IC1mbHRvKiBpbXBsaWVzIC1mZnVuY3Rpb24tc2VjdGlvbnMuIFdpdGgg
TFRPIGVuYWJsZWQsIGxkLmxsZCBnZW5lcmF0ZXMKPiBtdWx0aXBsZSAudGV4dCBzZWN0aW9ucyBm
b3IgcHVyZ2F0b3J5LnJvOgo+Cj4gJCByZWFkZWxmIC1TIHB1cmdhdG9yeS5ybyAgfCBncmVwICIg
LnRleHQiCj4gICBbIDFdIC50ZXh0ICAgICAgICAgICAgIFBST0dCSVRTICAgICAgICAgMDAwMDAw
MDAwMDAwMDAwMCAgMDAwMDAwNDAKPiAgIFsgN10gLnRleHQucHVyZ2F0b3J5ICAgUFJPR0JJVFMg
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMjBlMAo+ICAgWyA5XSAudGV4dC53YXJuICAg
ICAgICBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyMWMwCj4gICBbMTNd
IC50ZXh0LnNoYTI1Nl91cGRhIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAw
MDIyZjAKPiAgIFsxNV0gLnRleHQuc2hhMjI0X3VwZGEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAw
MDAwMDAwMDAwICAwMDAwMmJlMAo+ICAgWzE3XSAudGV4dC5zaGEyNTZfZmluYSBQUk9HQklUUyAg
ICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyYmYwCj4gICBbMTldIC50ZXh0LnNoYTIyNF9m
aW5hIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDJjYzAKPgo+IFRoaXMg
Y2F1c2UgV0FSTklORyBmcm9tIGtleGVjX3B1cmdhdG9yeV9zZXR1cF9zZWNoZHJzKCk6Cj4KPiBX
QVJOSU5HOiBDUFU6IDI2IFBJRDogMTEwODk0IGF0IGtlcm5lbC9rZXhlY19maWxlLmM6OTE5Cj4g
a2V4ZWNfbG9hZF9wdXJnYXRvcnkrMHgzN2YvMHgzOTAKPgo+IEZpeCB0aGlzIGJ5IGRpc2FibGlu
ZyBMVE8gZm9yIHB1cmdhdG9yeS4KPgo+IFdlIGNvdWxkIGFsc28gZml4IHRoaXMgd2l0aCBhbiBl
eHBsaWNpdCBsaW5rZXIgc2NyaXB0IHRvIHJlam9pbiAudGV4dC4qCj4gc2VjdGlvbnMgYmFjayBp
bnRvIC50ZXh0LiBIb3dldmVyLCBnaXZlbiB0aGUgYmVuZWZpdCBvZiBMVE9pbmcgcHVnYXRvcnkK
PiBpcyBzbWFsbCwgc2ltcGx5IGRpc2FibGUgdGhlIHByb2R1Y3Rpb24gb2YgbW9yZSAudGV4dC4q
IHNlY3Rpb25zIGZvciBub3cuCj4KPiBGaXhlczogYjMzZmZmMDdlM2UzICgieDg2LCBidWlsZDog
YWxsb3cgTFRPIHRvIGJlIHNlbGVjdGVkIikKPiBDYzogUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRh
QGNocm9taXVtLm9yZz4KPiBDYzogU2FtaSBUb2x2YW5lbiA8c2FtaXRvbHZhbmVuQGdvb2dsZS5j
b20+Cj4gQ2M6IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwo+IENjOiB4ODZAa2VybmVsLm9yZwo+IENjOiBsbHZtQGxpc3RzLmxpbnV4
LmRldgo+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+Cj4KPiAtLS0K
PiBBRkFJQ1QsIHg4NiBpcyB0aGUgb25seSBhcmNoIHRoYXQgc3VwcG9ydHMgTFRPIGFuZCBwdXJn
YXRvcnkuCj4KPiBDaGFuZ2VzIGluIHYzOgo+IDEuIEZpeCAiRml4ZXMiIHRhZy4gKE5pY2sgRGVz
YXVsbmllcnMpCj4gMi4gQWRkIGRlc2NyaXB0aW9uIG9mIGFuIGFsdGVybmF0aXZlIGZpeCwgd2l0
aCBsaW5rZXIgc2NyaXB0Lgo+ICAgIChOaWNrIERlc2F1bG5pZXJzKQo+Cj4gQ2hhbmdlcyBpbiB2
MjoKPiAxLiBVc2UgQ0NfRkxBR1NfTFRPIGluc3RlYWQgb2YgaGFyZGNvZGUgLWZsdG8uIChOaWNr
IERlc2F1bG5pZXJzKQo+IC0tLQo+ICBhcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUgfCA0ICsr
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZSBiL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+
IGluZGV4IGMyYTI5YmUzNWMwMS4uMDhhYTBmMjVmMTJhIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2
L3B1cmdhdG9yeS9NYWtlZmlsZQo+ICsrKyBiL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+
IEBAIC0xOSw2ICsxOSwxMCBAQCBDRkxBR1Nfc2hhMjU2Lm8gOj0gLURfX0RJU0FCTEVfRVhQT1JU
UyAtRF9fTk9fRk9SVElGWQo+ICAjIG9wdGltaXphdGlvbiBmbGFncy4KPiAgS0JVSUxEX0NGTEFH
UyA6PSAkKGZpbHRlci1vdXQgLWZwcm9maWxlLXNhbXBsZS11c2U9JSAtZnByb2ZpbGUtdXNlPSUs
JChLQlVJTERfQ0ZMQUdTKSkKPgo+ICsjIFdoZW4gTFRPIGlzIGVuYWJsZWQsIGxsdm0gZW1pdHMg
bWFueSB0ZXh0IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkCj4gKyMgYnkga2V4ZWMu
IFJlbW92ZSAtZmx0bz0qIGZsYWdzLgo+ICtLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVyLW91dCAk
KENDX0ZMQUdTX0xUTyksJChLQlVJTERfQ0ZMQUdTKSkKPiArCj4gICMgV2hlbiBsaW5raW5nIHB1
cmdhdG9yeS5ybyB3aXRoIC1yIHVucmVzb2x2ZWQgc3ltYm9scyBhcmUgbm90IGNoZWNrZWQsCj4g
ICMgYWxzbyBsaW5rIGEgcHVyZ2F0b3J5LmNoayBiaW5hcnkgd2l0aG91dCAtciB0byBjaGVjayBm
b3IgdW5yZXNvbHZlZCBzeW1ib2xzLgo+ICBQVVJHQVRPUllfTERGTEFHUyA6PSAtZSBwdXJnYXRv
cnlfc3RhcnQgLXogbm9kZWZhdWx0bGliCgpMR1RNLCB0aGFua3MgZm9yIHRoZSBwYXRjaCEKClJl
dmlld2VkLWJ5OiBTYW1pIFRvbHZhbmVuIDxzYW1pdG9sdmFuZW5AZ29vZ2xlLmNvbT4KClNhbWkK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
