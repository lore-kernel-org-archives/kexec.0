Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9BEE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=57p5utNEelcgBZ8T12gjBStIasWOR7ph3iXX7u4hIbs=; b=RZ/cRBv7VVDK5l
	fBi5cWiyIKmJ/W0ucB3ZWAud2AoA+IZrC0CxqYj32s3Kx+3/fMh0XKdGjuDVuYg48vNavqxDpxKV0
	hsGpW6f0ziuMmYKfKYByM32hil4EL7dtj4bkPZvKp7tU1D1rfGnwuaPnZa/tTFLotHPztWIP6OVtt
	VS64fAyJIG3M9TNf8s/tl2lSpOvg3b0ryovmHRiLzRQIi6liX71v30qD/S8XGnA/9NDYtqsd0Bb9g
	aM9C7kV88R9bCWxyTNuPHQX5t8GxL4JLbs18zO1QpS8yJ2GYHe9/ywc7nq+HKwqtRb+eHnZaak1Jm
	Qd8blu/myeMqbk1P+kwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjKa-000xTZ-0p;
	Mon, 11 Sep 2023 16:00:08 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjKX-000xRp-2S
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 16:00:07 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64f457c97a3so29807266d6.2
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694448000; x=1695052800; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhCiYm6x7iq9o4rbclNiuNRftcu8ARPlt13VmKx0QnQ=;
        b=NSSJhQonb8Cq2mXKuT9UIiZs816LsnAov2GRr33lbFnMxZgWK0hpNUyIbOZ1zXISaq
         cEOCvhYpW8gQJE6QSgn7M82fsuHYypfMFU/wol3K2B2SN8aWCOA4oDFFG8kgSd6+F6u+
         pHHcuURX3uSvJFNQiJw+h3X+o7SwS6jPkfPLzeNK4m8viY+BOYpj56SIwB2SgRZtbCzq
         HkpNP8oXvHfDu6i9qZvdKULyn8jmRMHcXwxcdiOGDcTSWJMvdLLPsUlABnLCI1qYeWAc
         h5JU815/dZqFKFPr/Th/lmm1zATqFP1iPi1BGPyLSIDOhOQZkivzQmfWM2oiyAVR0Krp
         wL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448000; x=1695052800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhCiYm6x7iq9o4rbclNiuNRftcu8ARPlt13VmKx0QnQ=;
        b=ln/UgurUrZteHwrB67u3fX5Rjw/bjx29IpkRBlyutth3qcjLScEeT34XqFuFOafuTI
         YQWgBpVynlKyrYJIyAPqFeE0yFRCsD2OGlGew6BWjkjBzlCJy0XAjxarTx5BpLj+qc8u
         2jc6I1i4t/MMtJoh48Ee8ENRZlh5w3BVSD/k3P1MAkuoeC2xamzgEps6Ju5geVGOgzzX
         zYHqR+ckSIZluIedvXWpOqRPW4+PcJuRtrYVxDfbaGfxPSrb5rivgoV7AWXBwNAR2nL+
         R27ZY5VAZjm6COCbq1B8uKDxN9EthPesdUtbcS79YvEUS/zURrJXA7KoP4prrqYV/RKh
         OSEA==
X-Gm-Message-State: AOJu0Yyirh3q1y1GlzSNhxO3fLED4QmNXFb1LmSnFeemaVn5Y8YyBhn9
	cPbZbTy0J7Lh/R/fL1fV5vEEpqjAlSIxu6F0oYZFiw==
X-Google-Smtp-Source: AGHT+IG1BrjMOhxrQ5uTqPmUsGxbwZhnQhQdQWAFkmEevIFzaHDDcwRIiVmuW4KxFZCM92Owt5ocwv+noWH4lf1gUmY=
X-Received: by 2002:a0c:8ecb:0:b0:655:87a1:49c4 with SMTP id
 y11-20020a0c8ecb000000b0065587a149c4mr8746780qvb.39.1694447999884; Mon, 11
 Sep 2023 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org>
In-Reply-To: <20230908231244.1092614-1-song@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Sep 2023 08:59:48 -0700
Message-ID: <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_090005_820656_B1F131CB 
X-CRM114-Status: GOOD (  22.70  )
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

T24gRnJpLCBTZXAgOCwgMjAyMyBhdCA0OjEz4oCvUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBXaXRoIExUTyBlbmFibGVkLCBsZC5sbGQgZ2VuZXJhdGVzIG11bHRpcGxl
IC50ZXh0IHNlY3Rpb25zIGZvcgo+IHB1cmdhdG9yeS5ybzoKPgo+ICQgcmVhZGVsZiAtUyBwdXJn
YXRvcnkucm8gIHwgZ3JlcCAiIC50ZXh0Igo+ICAgWyAxXSAudGV4dCAgICAgICAgICAgICBQUk9H
QklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAwMDQwCj4gICBbIDddIC50ZXh0LnB1
cmdhdG9yeSAgIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDIwZTAKPiAg
IFsgOV0gLnRleHQud2FybiAgICAgICAgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAw
ICAwMDAwMjFjMAo+ICAgWzEzXSAudGV4dC5zaGEyNTZfdXBkYSBQUk9HQklUUyAgICAgICAgIDAw
MDAwMDAwMDAwMDAwMDAgIDAwMDAyMmYwCj4gICBbMTVdIC50ZXh0LnNoYTIyNF91cGRhIFBST0dC
SVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDJiZTAKPiAgIFsxN10gLnRleHQuc2hh
MjU2X2ZpbmEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMmJmMAo+ICAg
WzE5XSAudGV4dC5zaGEyMjRfZmluYSBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAg
IDAwMDAyY2MwCj4KPiBUaGlzIGNhdXNlIFdBUk5JTkcgZnJvbSBrZXhlY19wdXJnYXRvcnlfc2V0
dXBfc2VjaGRycygpOgo+Cj4gV0FSTklORzogQ1BVOiAyNiBQSUQ6IDExMDg5NCBhdCBrZXJuZWwv
a2V4ZWNfZmlsZS5jOjkxOQo+IGtleGVjX2xvYWRfcHVyZ2F0b3J5KzB4MzdmLzB4MzkwCj4KPiBG
aXggdGhpcyBieSBkaXNhYmxpbmcgTFRPIGZvciBwdXJnYXRvcnkuCgpUaGFua3MgZm9yIHRoZSB2
MiEKCj4KPiBGaXhlczogODY1MmQ0NGY0NjZhICgia2V4ZWM6IHN1cHBvcnQgcHVyZ2F0b3JpZXMg
d2l0aCAudGV4dC5ob3Qgc2VjdGlvbnMiKQoKRHVubm8gdGhhdCB0aGlzIGZpeGVzIHRhZyBpcyBw
cmVjaXNlLiAgSSB0aGluayBwZXJoYXBzCgpGaXhlczogYjMzZmZmMDdlM2UzICgieDg2LCBidWls
ZDogYWxsb3cgTFRPIHRvIGJlIHNlbGVjdGVkIikKCndvdWxkIGJlIG1vcmUgcHJlY2lzZS4KCj4g
Q2M6IFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+Cj4gQ2M6IFNhbWkgVG9s
dmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPgo+IENjOiBrZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogeDg2QGtlcm5l
bC5vcmcKPiBDYzogbGx2bUBsaXN0cy5saW51eC5kZXYKPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExp
dSA8c29uZ0BrZXJuZWwub3JnPgo+Cj4gLS0tCj4gQUZBSUNULCB4ODYgaXMgdGhlIG9ubHkgYXJj
aCB0aGF0IHN1cHBvcnRzIExUTyBhbmQgcHVyZ2F0b3J5Lgo+Cj4gQ2hhbmdlcyBpbiB2MjoKPiAx
LiBVc2UgQ0NfRkxBR1NfTFRPIGluc3RlYWQgb2YgaGFyZGNvZGUgLWZsdG8uIChOaWNrIERlc2F1
bG5pZXJzKQo+IC0tLQo+ICBhcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUgfCA0ICsrKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L3B1cmdhdG9yeS9NYWtlZmlsZSBiL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+IGluZGV4
IGMyYTI5YmUzNWMwMS4uMDhhYTBmMjVmMTJhIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L3B1cmdh
dG9yeS9NYWtlZmlsZQo+ICsrKyBiL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQo+IEBAIC0x
OSw2ICsxOSwxMCBAQCBDRkxBR1Nfc2hhMjU2Lm8gOj0gLURfX0RJU0FCTEVfRVhQT1JUUyAtRF9f
Tk9fRk9SVElGWQo+ICAjIG9wdGltaXphdGlvbiBmbGFncy4KPiAgS0JVSUxEX0NGTEFHUyA6PSAk
KGZpbHRlci1vdXQgLWZwcm9maWxlLXNhbXBsZS11c2U9JSAtZnByb2ZpbGUtdXNlPSUsJChLQlVJ
TERfQ0ZMQUdTKSkKPgo+ICsjIFdoZW4gTFRPIGlzIGVuYWJsZWQsIGxsdm0gZW1pdHMgbWFueSB0
ZXh0IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkCj4gKyMgYnkga2V4ZWMuIFJlbW92
ZSAtZmx0bz0qIGZsYWdzLgoKLWZsdG8qIGluIExMVk0gaW1wbGllcyAtZmZ1bmN0aW9uLXNlY3Rp
b25zLCB3aGljaCBjcmVhdGVzIGEgLnRleHQuPGZuCm5hbWU+IHNlY3Rpb24gcGVyIGZ1bmN0aW9u
IGRlZmluaXRpb24gdG8gZmFjaWxpdGF0ZSAtV2wsLS1nYy1zZWN0aW9ucy4KCk92ZXJhbGwgdGhl
IHF1ZXN0aW9uIGhlcmUgaXMgImRvIHdlIHJlYWxseSBuZWVkIHRvIG9wdGltaXplIGtleGVjPyIK
CklmIHRoZSBhbnN3ZXIgaXMgeWVzLCB0aGVuIHRoaXMgcGF0Y2ggQU5EIDg2NTJkNDRmNDY2YSBh
cmUgYm90aApwZXNzaW1pemluZyBrZXhlYyAodGhvdWdoIGhhdmluZyBpdCB3b3JrIGF0IGFsbCBp
cyBzdHJpY3RseSBiZXR0ZXIKdGhhbiBub3QgYXQgYWxsKS4gIFRoZSBiZXN0IGZpeCBJTU8gd291
bGQgYmUgdG8gcHJvdmlkZSBhIGxpbmtlcgpzY3JpcHQgZm9yIHRoaXMgcHVyZ2F0b3J5IGltYWdl
IHRoYXQgcmVqb2lucyB0aGUgdGV4dCBzZWN0aW9ucyBiYWNrCmludG8gb25lIC50ZXh0LiAgRm9y
IGV4YW1wbGU6Cgpjb21taXQgZWZmODcyOGZlNjk4ICgidm1saW51eC5sZHMuaDogQWRkIFBHTyBh
bmQgQXV0b0ZETyBpbnB1dCBzZWN0aW9ucyIpCgpJIGFzc3VtZSBwZW9wbGUgZG8gY2FyZSBhYm91
dCB0aGUgdGltZSB0byBrZXhlYywgaGVuY2UgdGhlIHJhaXNvbgpkJ2V0cmUgZm9yIHByb2plY3Rz
IGxpa2Uga3BhdGNoLgoKSSdtIGZpbmUgdG8gc2lnbiBvZmYgb24gdGhpcyBhcHByb2FjaCBpZiB3
ZSBkb24ndCByZWFsbHkgY2FyZSwgb3Igd2FudAp0byBjYXJlIG1vcmUgbGF0ZXIsIGJ1dCB3ZSBj
YW4gZG8gYmV0dGVyIGhlcmUuCgo+ICtLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVyLW91dCAkKEND
X0ZMQUdTX0xUTyksJChLQlVJTERfQ0ZMQUdTKSkKPiArCj4gICMgV2hlbiBsaW5raW5nIHB1cmdh
dG9yeS5ybyB3aXRoIC1yIHVucmVzb2x2ZWQgc3ltYm9scyBhcmUgbm90IGNoZWNrZWQsCj4gICMg
YWxzbyBsaW5rIGEgcHVyZ2F0b3J5LmNoayBiaW5hcnkgd2l0aG91dCAtciB0byBjaGVjayBmb3Ig
dW5yZXNvbHZlZCBzeW1ib2xzLgo+ICBQVVJHQVRPUllfTERGTEFHUyA6PSAtZSBwdXJnYXRvcnlf
c3RhcnQgLXogbm9kZWZhdWx0bGliCj4gLS0KPiAyLjM0LjEKPgoKCi0tIApUaGFua3MsCn5OaWNr
IERlc2F1bG5pZXJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
