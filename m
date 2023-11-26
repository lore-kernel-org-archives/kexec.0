Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D476C4167B
	for <kexec@archiver.kernel.org>; Sun, 26 Nov 2023 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=netgtxMH7L32AzjQOPIciuXdvZBr9nHM64NIJ2o63Cw=; b=DStsUe1cdXZcwq
	HUQEh5RBpl/NdWarFoB97cJC4td+zzUY77dC6Ck3fO4HbBp9Ruuj4DgaonRoMDjiEuUJKYAu4TYy6
	n1wIRpLWE2kd6izAaeSfxjPT+jM82olRmQ48CuQe2vrFnANJHt+VBEUpZ4bXXD7vLyLpSyA4nGnsI
	xxE6qEhvEDmzJA5TgQn4E0osL0xdWS3D/0gjuQUTiZrLFL+63F7yk3IMMM+bMx8Flm/CTBiT780s/
	awFZpWiOwE3Eqye8YTL+HjrpqawnBKyPZC0TYzkEnhNvSwCca6d189gKfZs6sSDQ1IMWfCtDf6MIz
	PWazHTgfjzxGU9WeG/3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r75p8-00AAKC-1L;
	Sun, 26 Nov 2023 03:28:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r75p5-00AAJV-1h
	for kexec@lists.infradead.org;
	Sun, 26 Nov 2023 03:28:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0A4CA60D37
	for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 03:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7EBC433C9
	for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 03:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700969322;
	bh=HqIlTM9RKSfK7lwi5TdFbwO9vBS4WT6XZyPO21TEc8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z400rEpZEzaduKJG9XSno3MwRHUiYhXqeoq8kLe9b8j6hTy/Xxjv/PvY+zSAANpxX
	 eCmBpnUutoprwJWS0VM9pL0IbLQULElVR4X4++K3UuA3VV6/40Os4SU+ZsprKZ7gHo
	 a9Ln+SYmKm6wUfrbw/gQhjqdTlCqqdESVLSe70vpcXffFB3jhS7fyHq9uM0gOKUEeA
	 SSWsE1y86XEl+uKhISmnRB8b0IBGciypspGE3LdZdmbCWO1RWlDPqtORpRSfYF7i90
	 B5iA39t7SvGEVwYD/c7RCc355edhNXBCa5Lds4VFNtfqaF+5YBwcOknspEnUqJcgA8
	 2Ah0ls0fw4Z4Q==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so215844a12.3
        for <kexec@lists.infradead.org>; Sat, 25 Nov 2023 19:28:42 -0800 (PST)
X-Gm-Message-State: AOJu0YypXW7q9T1it5JI69/X0wRRtbqg7rE+KT4QXNwZN7+BDbKOQvrM
	th1cNrnoBaFlJ67S7dlg1rd/nYdWmZXsylnb/ho=
X-Google-Smtp-Source: AGHT+IGXY6sCsdtfh0hJn2IOG120g97Pcs9O3qy2jMzWw0UBC9ISGKwVrIUMHT50uUAE6aVH++FZAR+6zLM3Vr4RALA=
X-Received: by 2002:a17:906:24c:b0:a0c:2ace:5f72 with SMTP id
 12-20020a170906024c00b00a0c2ace5f72mr2409599ejl.13.1700969321133; Sat, 25 Nov
 2023 19:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20231125065232.116319-1-wangrui@loongson.cn>
In-Reply-To: <20231125065232.116319-1-wangrui@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 26 Nov 2023 11:28:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4P5=DKQ5YRKAgYVZF1dn4OjoU=aZtc-asJ53EPZdd32w@mail.gmail.com>
Message-ID: <CAAhV-H4P5=DKQ5YRKAgYVZF1dn4OjoU=aZtc-asJ53EPZdd32w@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Load vmlinux.efi to the link address
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, hev <r@hev.cc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231125_192843_666824_2F4CCF0D 
X-CRM114-Status: GOOD (  18.25  )
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

UmV2aWV3ZWQtYnk6IEh1YWNhaSBDaGVuIDxjaGVuaHVhY2FpQGxvb25nc29uLmNuPgoKT24gU2F0
LCBOb3YgMjUsIDIwMjMgYXQgMjo1M+KAr1BNIFdBTkcgUnVpIDx3YW5ncnVpQGxvb25nc29uLmNu
PiB3cm90ZToKPgo+IEN1cnJlbnRseSwga2V4ZWMgbG9hZHMgdm1saW51eC5lZmkgdG8gYWRkcmVz
cyAwIGluc3RlYWQgb2YgdGhlIGxpbmsKPiBhZGRyZXNzLiBUaGlzIGNhdXNlcyBrZXhlYyB0byBm
YWlsIHRvIGJvb3QgdGhlIG5ldyB2bWxpbnV4LmVmaSBvbiBxZW11Lgo+Cj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IGtlcm5lbF9zZWdtZW50OiAwMDAwMDAwMDAwMDAwMDAwCj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IGtlcm5lbF9lbnRyeTogICAwMDAwMDAwMDAxM2YxMDAwCj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IGltYWdlX3NpemU6ICAgICAwMDAwMDAwMDAxY2EwMDAwCj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IHRleHRfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMjAwMDAwCj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IHBoeXNfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMDAwMDAwCj4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IFBFIGZvcm1hdDogICAgICB5ZXMKPiAgIGxvb25nYXJjaF9sb2FkX290aGVyX3Nl
Z21lbnRzOjMzMzogY29tbWFuZF9saW5lOiBrZXhlYyBjb25zb2xlPXR0eVMwLDExNTIwMAo+ICAg
a2V4ZWNfbG9hZDogZW50cnkgPSAweDEzZjEwMDAgZmxhZ3MgPSAweDEwMjAwMDAKPiAgIG5yX3Nl
Z21lbnRzID0gMgo+ICAgc2VnbWVudFswXS5idWYgICA9IDB4N2ZmZmVlYTM4MDEwCj4gICBzZWdt
ZW50WzBdLmJ1ZnN6ID0gMHgxYjU1MjAwCj4gICBzZWdtZW50WzBdLm1lbSAgID0gKG5pbCkKPiAg
IHNlZ21lbnRbMF0ubWVtc3ogPSAweDFjYTAwMDAKPiAgIHNlZ21lbnRbMV0uYnVmICAgPSAweDU1
NTU1NzA5NDBiMAo+ICAgc2VnbWVudFsxXS5idWZzeiA9IDB4MjAwCj4gICBzZWdtZW50WzFdLm1l
bSAgID0gMHgxY2EwMDAwCj4gICBzZWdtZW50WzFdLm1lbXN6ID0gMHg0MDAwCj4KPiBUaGlzIHBh
dGNoIGNvbnN0cmFpbnMgdGhlIHJhbmdlIG9mIHRoZSBrZXJuZWwgc2VnbWVudCBieSBgaG9sZV9t
aW5gCj4gYW5kIGBob2xlX21heGAgdG8gcGxhY2Ugdm1saW51eC5lZmkgZXhhY3RseSBhdCB0aGUg
bGluayBhZGRyZXNzLgo+Cj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGtlcm5lbF9zZWdtZW50OiAw
MDAwMDAwMDAwMjAwMDAwCj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGtlcm5lbF9lbnRyeTogICAw
MDAwMDAwMDAxM2YxMDAwCj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGltYWdlX3NpemU6ICAgICAw
MDAwMDAwMDAxY2EwMDAwCj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHRleHRfb2Zmc2V0OiAgICAw
MDAwMDAwMDAwMjAwMDAwCj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHBoeXNfb2Zmc2V0OiAgICAw
MDAwMDAwMDAwMDAwMDAwCj4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IFBFIGZvcm1hdDogICAgICB5
ZXMKPiAgIGxvb25nYXJjaF9sb2FkX290aGVyX3NlZ21lbnRzOjMzOTogY29tbWFuZF9saW5lOiBr
ZXhlYyBjb25zb2xlPXR0eVMwLDExNTIwMAo+ICAga2V4ZWNfbG9hZDogZW50cnkgPSAweDEzZjEw
MDAgZmxhZ3MgPSAweDEwMjAwMDAKPiAgIG5yX3NlZ21lbnRzID0gMgo+ICAgc2VnbWVudFswXS5i
dWYgICA9IDB4N2ZmZmYyMDI4MDEwCj4gICBzZWdtZW50WzBdLmJ1ZnN6ID0gMHgxYjU1MjAwCj4g
ICBzZWdtZW50WzBdLm1lbSAgID0gMHgyMDAwMDAKPiAgIHNlZ21lbnRbMF0ubWVtc3ogPSAweDFj
YTAwMDAKPiAgIHNlZ21lbnRbMV0uYnVmICAgPSAweDU1NTU1NzQ5ODA5OAo+ICAgc2VnbWVudFsx
XS5idWZzeiA9IDB4MjAwCj4gICBzZWdtZW50WzFdLm1lbSAgID0gMHgxZWEwMDAwCj4gICBzZWdt
ZW50WzFdLm1lbXN6ID0gMHg0MDAwCj4KPiBTaWduZWQtb2ZmLWJ5OiBXQU5HIFJ1aSA8d2FuZ3J1
aUBsb29uZ3Nvbi5jbj4KPiAtLS0KPgo+IHYxLT52MjoKPiAgKiBGaXggdGhlIGlzc3VlIHByZXZl
bnRpbmcgaXQgZnJvbSB3b3JraW5nIG9uIHRoZSBwaHlzaWNhbCBtYWNoaW5lLgo+Cj4gIGtleGVj
L2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5jIHwgMTAgKysrKysrKy0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5jIGIva2V4ZWMvYXJjaC9s
b29uZ2FyY2gva2V4ZWMtbG9vbmdhcmNoLmMKPiBpbmRleCA2MmZmOGZkLi4zMmE0MmQyIDEwMDY0
NAo+IC0tLSBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5jCj4gKysrIGIv
a2V4ZWMvYXJjaC9sb29uZ2FyY2gva2V4ZWMtbG9vbmdhcmNoLmMKPiBAQCAtMjY1LDkgKzI2NSwx
MyBAQCB1bnNpZ25lZCBsb25nIGxvb25nYXJjaF9sb2NhdGVfa2VybmVsX3NlZ21lbnQoc3RydWN0
IGtleGVjX2luZm8gKmluZm8pCj4gICAgICAgICAgICAgICAgICAgICAgICAgaG9sZSA9IFVMT05H
X01BWDsKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfSBlbHNlIHsKPiAtICAgICAgICAg
ICAgICAgaG9sZSA9IGxvY2F0ZV9ob2xlKGluZm8sCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
bG9vbmdhcmNoX21lbS50ZXh0X29mZnNldCArIGxvb25nYXJjaF9tZW0uaW1hZ2Vfc2l6ZSwKPiAt
ICAgICAgICAgICAgICAgICAgICAgICBNaUIoMSksIDAsIFVMT05HX01BWCwgMSk7Cj4gKyAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaG9sZV9taW47Cj4gKyAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgaG9sZV9tYXg7Cj4gKwo+ICsgICAgICAgICAgICAgICBob2xlX21pbiA9IGxvb25n
YXJjaF9tZW0udGV4dF9vZmZzZXQ7Cj4gKyAgICAgICAgICAgICAgIGhvbGVfbWF4ID0gaG9sZV9t
aW4gKyBsb29uZ2FyY2hfbWVtLmltYWdlX3NpemU7Cj4gKyAgICAgICAgICAgICAgIGhvbGUgPSBs
b2NhdGVfaG9sZShpbmZvLCBsb29uZ2FyY2hfbWVtLmltYWdlX3NpemUsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgTWlCKDEpLCBob2xlX21pbiwgaG9sZV9tYXgsIDEpOwo+Cj4gICAgICAgICAg
ICAgICAgIGlmIChob2xlID09IFVMT05HX01BWCkKPiAgICAgICAgICAgICAgICAgICAgICAgICBk
YmdwcmludGYoIiVzOiBsb2NhdGVfaG9sZSBmYWlsZWRcbiIsIF9fZnVuY19fKTsKPiAtLQo+IDIu
NDIuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
