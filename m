Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D4C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dq5ovbldZGVzYD6v7W39r0jDTAmTPDZVHE6TwwywJy4=; b=Y2Ki0l4nDhcBlf
	qCdXRM13TS8/hkerwUCT6Zbk4EX7cBz/9FVBEPFNuqTG9WU7hX2uaXl50vWJTvEBsLUmC63w/FE0D
	icQMA1o6lmO+KzHVjRd7iokHPoJ6iw6veVMCILg3MRmZxQ1SEc+F8PiFEAUF99tZcMdvzm2dH7zl7
	wnjzScJqF9F1lcb0jPCWPKqs3Mn2MuBz3D4AOgRNEr4DTIvYZrQ+4sFhcWAxEIjeHlgJK4LC74oDn
	4ZB5RijaMRFR5Jmd/msSNUjwlhuZGuJlFOtmWQtqrkNqlrUScky4/pYUM+aVm3DYA7jAKO1t2/TY4
	KfHIFqVXifIRLzaRkhLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7s9Q-004KEx-1s;
	Tue, 28 Nov 2023 07:04:56 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7s9N-004KDW-0s
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 07:04:55 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4458451276.2
        for <kexec@lists.infradead.org>; Mon, 27 Nov 2023 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1701155090; x=1701759890; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Req9Q6cdo5RosWkHjhi4V5iqkVbrNmc6p2h2YcnqswQ=;
        b=AsVQlTfeXqBd3jI6bQjQSQufXpkrAcdopbUCXUdHYDxBE6N4zpKhTzJreSCyytU/Lt
         PL4iW25LbAxB650JzyXSsfrhjnwBU2F4A3n9AiMjSG7f1ifB38tpzdIEGle/rUxEqNQ1
         x6Dnd/40Mmz5OoyKogKPIwTCxWW3xd+lUJtFhEbgnareEOsQwW62bpikSGPJQl+8BIPK
         m/PSDbzBtL77NOoSSaGs4R6QhoksjDpaSqChZkYHZr9f4Lh+AGYZsKpaDQ/JrKkw2dTW
         ZyhSGYND5yfyvo+WmiIJgAOIXbDB9niTx81W80sFUIZlbmm/cdQlBhAzxxCEoF4BAmtc
         WclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155090; x=1701759890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Req9Q6cdo5RosWkHjhi4V5iqkVbrNmc6p2h2YcnqswQ=;
        b=StMZZev8wQ8/6plG7Y656EQLmZcUSJLTpkbTtCc9w3umvCrwB+tcHvhlMbFdbdnxDN
         YXHnYzTzcpBq7vu3YhNKmR/DWuW6iHvv6gApfAWzsSOnCzrzv3McD9L67ZTqIovvH6NX
         OCfUI6WSNWROPYyWBYf0xApXFp+TmOdmZUBbOMWuJxKITAz9oPYu6cv/7uagQRLbOGii
         wj+IlYBJKR4ZGDjZbXT8uRY9uwz+QVRKFWU6+MLiTwjxoQwCwn2mEspEFc82SoY7NEVI
         g6nFL6F0QHJqpHlCeddaBrjy4rtiePvoC5l1pF4sqrpyCeGi6rvWTFqh9YWWFFl5kgL8
         DNDw==
X-Gm-Message-State: AOJu0YyB4ABYjTal2pYp2ZBOPlpMQFMiruKycho8XyDwcFBSUG7LCkj2
	uvQ/Sygt3KkTHkMPEfYXm6P7AZWqVnuknXe0tpOZVw==
X-Google-Smtp-Source: AGHT+IFZLEvPc2cS+CNmA3IyNWxa9dCrZUiePr0cdix09/P6gYQEdKKUejQkRyf/nB6/KKemCoyRWCwtbG+oiFwFNGc=
X-Received: by 2002:a25:ad1e:0:b0:d9a:485f:5852 with SMTP id
 y30-20020a25ad1e000000b00d9a485f5852mr11618897ybi.13.1701155089993; Mon, 27
 Nov 2023 23:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20231125065232.116319-1-wangrui@loongson.cn>
In-Reply-To: <20231125065232.116319-1-wangrui@loongson.cn>
From: hev <r@hev.cc>
Date: Tue, 28 Nov 2023 15:07:11 +0800
Message-ID: <CAHirt9i=jn=3cR_RVb0tWeCmLYR=2+yrXZdTm2ti0p7K1K46DQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Load vmlinux.efi to the link address
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_230453_553496_5E2DC3C8 
X-CRM114-Status: GOOD (  18.21  )
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

SGVsbG8gU2ltb24sCgpDb3VsZCB5b3UgYXBwbHkgdGhpcyBwYXRjaCAodjIpIGluc3RlYWQgb2Yg
cGF0Y2ggKHYxKSBbMV0gPwpUaGFua3MhCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva2V4
ZWMvMjAyMzExMjQxNTQ2NTguMTE0NTc5LTEtd2FuZ3J1aUBsb29uZ3Nvbi5jbi8KCk9uIFNhdCwg
Tm92IDI1LCAyMDIzIGF0IDI6NTLigK9QTSBXQU5HIFJ1aSA8d2FuZ3J1aUBsb29uZ3Nvbi5jbj4g
d3JvdGU6Cj4KPiBDdXJyZW50bHksIGtleGVjIGxvYWRzIHZtbGludXguZWZpIHRvIGFkZHJlc3Mg
MCBpbnN0ZWFkIG9mIHRoZSBsaW5rCj4gYWRkcmVzcy4gVGhpcyBjYXVzZXMga2V4ZWMgdG8gZmFp
bCB0byBib290IHRoZSBuZXcgdm1saW51eC5lZmkgb24gcWVtdS4KPgo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiBrZXJuZWxfc2VnbWVudDogMDAwMDAwMDAwMDAwMDAwMAo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiBrZXJuZWxfZW50cnk6ICAgMDAwMDAwMDAwMTNmMTAwMAo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiBpbWFnZV9zaXplOiAgICAgMDAwMDAwMDAwMWNhMDAwMAo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiB0ZXh0X29mZnNldDogICAgMDAwMDAwMDAwMDIwMDAwMAo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiBwaHlzX29mZnNldDogICAgMDAwMDAwMDAwMDAwMDAwMAo+ICAgcGVpX2xvb25nYXJj
aF9sb2FkOiBQRSBmb3JtYXQ6ICAgICAgeWVzCj4gICBsb29uZ2FyY2hfbG9hZF9vdGhlcl9zZWdt
ZW50czozMzM6IGNvbW1hbmRfbGluZToga2V4ZWMgY29uc29sZT10dHlTMCwxMTUyMDAKPiAgIGtl
eGVjX2xvYWQ6IGVudHJ5ID0gMHgxM2YxMDAwIGZsYWdzID0gMHgxMDIwMDAwCj4gICBucl9zZWdt
ZW50cyA9IDIKPiAgIHNlZ21lbnRbMF0uYnVmICAgPSAweDdmZmZlZWEzODAxMAo+ICAgc2VnbWVu
dFswXS5idWZzeiA9IDB4MWI1NTIwMAo+ICAgc2VnbWVudFswXS5tZW0gICA9IChuaWwpCj4gICBz
ZWdtZW50WzBdLm1lbXN6ID0gMHgxY2EwMDAwCj4gICBzZWdtZW50WzFdLmJ1ZiAgID0gMHg1NTU1
NTcwOTQwYjAKPiAgIHNlZ21lbnRbMV0uYnVmc3ogPSAweDIwMAo+ICAgc2VnbWVudFsxXS5tZW0g
ICA9IDB4MWNhMDAwMAo+ICAgc2VnbWVudFsxXS5tZW1zeiA9IDB4NDAwMAo+Cj4gVGhpcyBwYXRj
aCBjb25zdHJhaW5zIHRoZSByYW5nZSBvZiB0aGUga2VybmVsIHNlZ21lbnQgYnkgYGhvbGVfbWlu
YAo+IGFuZCBgaG9sZV9tYXhgIHRvIHBsYWNlIHZtbGludXguZWZpIGV4YWN0bHkgYXQgdGhlIGxp
bmsgYWRkcmVzcy4KPgo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBrZXJuZWxfc2VnbWVudDogMDAw
MDAwMDAwMDIwMDAwMAo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBrZXJuZWxfZW50cnk6ICAgMDAw
MDAwMDAwMTNmMTAwMAo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBpbWFnZV9zaXplOiAgICAgMDAw
MDAwMDAwMWNhMDAwMAo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiB0ZXh0X29mZnNldDogICAgMDAw
MDAwMDAwMDIwMDAwMAo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBwaHlzX29mZnNldDogICAgMDAw
MDAwMDAwMDAwMDAwMAo+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBQRSBmb3JtYXQ6ICAgICAgeWVz
Cj4gICBsb29uZ2FyY2hfbG9hZF9vdGhlcl9zZWdtZW50czozMzk6IGNvbW1hbmRfbGluZToga2V4
ZWMgY29uc29sZT10dHlTMCwxMTUyMDAKPiAgIGtleGVjX2xvYWQ6IGVudHJ5ID0gMHgxM2YxMDAw
IGZsYWdzID0gMHgxMDIwMDAwCj4gICBucl9zZWdtZW50cyA9IDIKPiAgIHNlZ21lbnRbMF0uYnVm
ICAgPSAweDdmZmZmMjAyODAxMAo+ICAgc2VnbWVudFswXS5idWZzeiA9IDB4MWI1NTIwMAo+ICAg
c2VnbWVudFswXS5tZW0gICA9IDB4MjAwMDAwCj4gICBzZWdtZW50WzBdLm1lbXN6ID0gMHgxY2Ew
MDAwCj4gICBzZWdtZW50WzFdLmJ1ZiAgID0gMHg1NTU1NTc0OTgwOTgKPiAgIHNlZ21lbnRbMV0u
YnVmc3ogPSAweDIwMAo+ICAgc2VnbWVudFsxXS5tZW0gICA9IDB4MWVhMDAwMAo+ICAgc2VnbWVu
dFsxXS5tZW1zeiA9IDB4NDAwMAo+Cj4gU2lnbmVkLW9mZi1ieTogV0FORyBSdWkgPHdhbmdydWlA
bG9vbmdzb24uY24+Cj4gLS0tCj4KPiB2MS0+djI6Cj4gICogRml4IHRoZSBpc3N1ZSBwcmV2ZW50
aW5nIGl0IGZyb20gd29ya2luZyBvbiB0aGUgcGh5c2ljYWwgbWFjaGluZS4KPgo+ICBrZXhlYy9h
cmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2guYyB8IDEwICsrKysrKystLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9rZXhlYy9hcmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2guYyBiL2tleGVjL2FyY2gvbG9v
bmdhcmNoL2tleGVjLWxvb25nYXJjaC5jCj4gaW5kZXggNjJmZjhmZC4uMzJhNDJkMiAxMDA2NDQK
PiAtLS0gYS9rZXhlYy9hcmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2guYwo+ICsrKyBiL2tl
eGVjL2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5jCj4gQEAgLTI2NSw5ICsyNjUsMTMg
QEAgdW5zaWduZWQgbG9uZyBsb29uZ2FyY2hfbG9jYXRlX2tlcm5lbF9zZWdtZW50KHN0cnVjdCBr
ZXhlY19pbmZvICppbmZvKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGhvbGUgPSBVTE9OR19N
QVg7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0gZWxzZSB7Cj4gLSAgICAgICAgICAg
ICAgIGhvbGUgPSBsb2NhdGVfaG9sZShpbmZvLAo+IC0gICAgICAgICAgICAgICAgICAgICAgIGxv
b25nYXJjaF9tZW0udGV4dF9vZmZzZXQgKyBsb29uZ2FyY2hfbWVtLmltYWdlX3NpemUsCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgTWlCKDEpLCAwLCBVTE9OR19NQVgsIDEpOwo+ICsgICAgICAg
ICAgICAgICB1bnNpZ25lZCBsb25nIGhvbGVfbWluOwo+ICsgICAgICAgICAgICAgICB1bnNpZ25l
ZCBsb25nIGhvbGVfbWF4Owo+ICsKPiArICAgICAgICAgICAgICAgaG9sZV9taW4gPSBsb29uZ2Fy
Y2hfbWVtLnRleHRfb2Zmc2V0Owo+ICsgICAgICAgICAgICAgICBob2xlX21heCA9IGhvbGVfbWlu
ICsgbG9vbmdhcmNoX21lbS5pbWFnZV9zaXplOwo+ICsgICAgICAgICAgICAgICBob2xlID0gbG9j
YXRlX2hvbGUoaW5mbywgbG9vbmdhcmNoX21lbS5pbWFnZV9zaXplLAo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIE1pQigxKSwgaG9sZV9taW4sIGhvbGVfbWF4LCAxKTsKPgo+ICAgICAgICAgICAg
ICAgICBpZiAoaG9sZSA9PSBVTE9OR19NQVgpCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGJn
cHJpbnRmKCIlczogbG9jYXRlX2hvbGUgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7Cj4gLS0KPiAyLjQy
LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
