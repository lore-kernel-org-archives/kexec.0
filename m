Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4AFC4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V+iluBAU0I+qBd8tk1X/qO6bMlZf3+Tn5z7F3S4WhoA=; b=0hNnva7rEdkQd4
	+JOWLMk56D+cVdWt6LIpp3e8jpjTWU+7z7qymYFZrg4ORtsoCeCrrFqSYocsJ6hwboYLDwrRX4ZUQ
	7wDM0O5vuQyT8vDmM2DwknxkXeDyOsD+iChltCs9p6K70naAtayYhsU1Hz9zyLjkpvyTCvkrI3Ce3
	B78fEe8DEqgWsZOsOF1Df7LCRomwlPvhNeskURwx9RMpBbhFYaDWUfdKksUbbcRB/wt7OmCnc7Z1N
	blNO/+LGpNa9lDmIXtK04e/dgEu/HipOYKZhNTR/RF5ybUHk2uZ3j8ph6GREgbui/gE28E0K7KTRY
	VjfTxjN6TwprWxOo0cZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9P8z-00Fg7f-0b;
	Sat, 02 Dec 2023 12:30:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9P8t-00Fg7E-2C
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 12:30:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6CE0460B3B
	for <kexec@lists.infradead.org>; Sat,  2 Dec 2023 12:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1761CC433C9
	for <kexec@lists.infradead.org>; Sat,  2 Dec 2023 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701520240;
	bh=D/+GUmX55OOmWdIp0QZMG5loKThjhznJ83WriSRLPIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LCXhtS/R4O0ufHGqGeZLPARBTzdRy6hDZdzQMwkyi2CFZXyE5gkQmH0T3bYnKLKCG
	 VXa/5Eb5aDhx/qUza8QRpxOMAWV/Y71fWofKJzyEdtac3FSuOsh3Qo8XWJsXENCYbV
	 HtzYfLytXRL6TbNdTiuvH5TbGrFaqGdL+175a8YzjYTYybR7G3DaEohMxHo6nlsTBa
	 lcVGI5tVAxrPgMq4SmuIoWI2wVVybsnzsRL6Ds7q5bD/tAGp4ZJlgK/HR3w8J+Wj/C
	 RrwjDv3BA+xRbWVnpGFjuQ/MoqWpgeEHPdKxXyL4MpwOrKgLcXId9V/jDzil+y62BX
	 8B/bKpanAI/CA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso718033a12.3
        for <kexec@lists.infradead.org>; Sat, 02 Dec 2023 04:30:40 -0800 (PST)
X-Gm-Message-State: AOJu0YwyCTYn18NmuW5uW6YLkWmIgqka1GD50mppom90NxED/56V6oEy
	l8aVX8IWOzCBGPGqTRZTbNfv1Wy9B6j2+Ci6/l8=
X-Google-Smtp-Source: AGHT+IHvSA7y8iqiw0Xlb73rHm59uJa2yeBed5mZaJhyoUhstRQWNN09KQYX3MdAw6MuTeWqZHYofFCXh7nPF2k3QjY=
X-Received: by 2002:aa7:ccda:0:b0:54c:4837:75a3 with SMTP id
 y26-20020aa7ccda000000b0054c483775a3mr1721832edt.79.1701520238494; Sat, 02
 Dec 2023 04:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127134653.GC3354982@kernel.org> <20231202101128.133999-1-wangrui@loongson.cn>
In-Reply-To: <20231202101128.133999-1-wangrui@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 2 Dec 2023 20:30:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com>
Message-ID: <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
To: WANG Rui <wangrui@loongson.cn>
Cc: horms@kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231202_043043_831206_8FB487A6 
X-CRM114-Status: GOOD (  15.08  )
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

T24gU2F0LCBEZWMgMiwgMjAyMyBhdCA2OjEx4oCvUE0gV0FORyBSdWkgPHdhbmdydWlAbG9vbmdz
b24uY24+IHdyb3RlOgo+Cj4gPiBPbiBGcmksIE5vdiAyNCwgMjAyMyBhdCAxMTo0Njo1OFBNICsw
ODAwLCBXQU5HIFJ1aSB3cm90ZToKPiA+ID4gQ3VycmVudGx5LCBrZXhlYyBsb2FkcyB2bWxpbnV4
LmVmaSB0byBhZGRyZXNzIDAgaW5zdGVhZCBvZiB0aGUgbGluawo+ID4gPiBhZGRyZXNzLiBUaGlz
IGNhdXNlcyBrZXhlYyB0byBmYWlsIHRvIGJvb3QgdGhlIG5ldyB2bWxpbnV4LmVmaSBvbiBxZW11
Lgo+ID4gPgo+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDoga2VybmVsX3NlZ21lbnQ6IDAwMDAw
MDAwMDAwMDAwMDAKPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGtlcm5lbF9lbnRyeTogICAw
MDAwMDAwMDAxNWRjMDAwCj4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBpbWFnZV9zaXplOiAg
ICAgMDAwMDAwMDAwMWYzMDAwMAo+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogdGV4dF9vZmZz
ZXQ6ICAgIDAwMDAwMDAwMDAyMDAwMDAKPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHBoeXNf
b2Zmc2V0OiAgICAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBQ
RSBmb3JtYXQ6ICAgICAgeWVzCj4gPiA+ICAgbG9vbmdhcmNoX2xvYWRfb3RoZXJfc2VnbWVudHM6
MzMzOiBjb21tYW5kX2xpbmU6IGtleGVjIGNvbnNvbGU9dHR5UzAsMTE1MjAwCj4gPiA+ICAga2V4
ZWNfbG9hZDogZW50cnkgPSAweDE1ZGMwMDAgZmxhZ3MgPSAweDEwMjAwMDAKPiA+ID4gICBucl9z
ZWdtZW50cyA9IDIKPiA+ID4gICBzZWdtZW50WzBdLmJ1ZiAgID0gMHg3ZmZmZWY2NjQwMTAKPiA+
ID4gICBzZWdtZW50WzBdLmJ1ZnN6ID0gMHgxZGU5YTAwCj4gPiA+ICAgc2VnbWVudFswXS5tZW0g
ICA9IChuaWwpCj4gPiA+ICAgc2VnbWVudFswXS5tZW1zeiA9IDB4MWYzMDAwMAo+ID4gPiAgIHNl
Z21lbnRbMV0uYnVmICAgPSAweDU1NTU1NWU0ODBiMAo+ID4gPiAgIHNlZ21lbnRbMV0uYnVmc3og
PSAweDIwMAo+ID4gPiAgIHNlZ21lbnRbMV0ubWVtICAgPSAweDFmMzAwMDAKPiA+ID4gICBzZWdt
ZW50WzFdLm1lbXN6ID0gMHg0MDAwCj4gPiA+Cj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBgdGV4dF9v
ZmZzZXRgIHdoZW4gYWRkaW5nIGtlcm5lbCBzZWdtZW50IHRvIGxvYWQKPiA+ID4gdm1saW51eC5l
ZmkgdG8gdGhlIGxpbmsgYWRkcmVzcy4KPiA+ID4KPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6
IGtlcm5lbF9zZWdtZW50OiAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ICAgcGVpX2xvb25nYXJjaF9s
b2FkOiBrZXJuZWxfZW50cnk6ICAgMDAwMDAwMDAwMTVkYzAwMAo+ID4gPiAgIHBlaV9sb29uZ2Fy
Y2hfbG9hZDogaW1hZ2Vfc2l6ZTogICAgIDAwMDAwMDAwMDFmMzAwMDAKPiA+ID4gICBwZWlfbG9v
bmdhcmNoX2xvYWQ6IHRleHRfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMjAwMDAwCj4gPiA+ICAgcGVp
X2xvb25nYXJjaF9sb2FkOiBwaHlzX29mZnNldDogICAgMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiAg
IHBlaV9sb29uZ2FyY2hfbG9hZDogUEUgZm9ybWF0OiAgICAgIHllcwo+ID4gPiAgIGxvb25nYXJj
aF9sb2FkX290aGVyX3NlZ21lbnRzOjMzNTogY29tbWFuZF9saW5lOiBrZXhlYyBjb25zb2xlPXR0
eVMwLDExNTIwMAo+ID4gPiAgIGtleGVjX2xvYWQ6IGVudHJ5ID0gMHgxNWRjMDAwIGZsYWdzID0g
MHgxMDIwMDAwCj4gPiA+ICAgbnJfc2VnbWVudHMgPSAyCj4gPiA+ICAgc2VnbWVudFswXS5idWYg
ICA9IDB4N2ZmZmYxYTA0MDEwCj4gPiA+ICAgc2VnbWVudFswXS5idWZzeiA9IDB4MWRlOWEwMAo+
ID4gPiAgIHNlZ21lbnRbMF0ubWVtICAgPSAweDIwMDAwMAo+ID4gPiAgIHNlZ21lbnRbMF0ubWVt
c3ogPSAweDFmMzAwMDAKPiA+ID4gICBzZWdtZW50WzFdLmJ1ZiAgID0gMHg1NTU1NTViMjgwOTgK
PiA+ID4gICBzZWdtZW50WzFdLmJ1ZnN6ID0gMHgyMDAKPiA+ID4gICBzZWdtZW50WzFdLm1lbSAg
ID0gMHgyMTMwMDAwCj4gPiA+ICAgc2VnbWVudFsxXS5tZW1zeiA9IDB4NDAwMAo+ID4gPgo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBXQU5HIFJ1aSA8d2FuZ3J1aUBsb29uZ3Nvbi5jbj4KPiA+Cj4gPiBU
aGFua3MsIGFwcGxpZWQuCj4KPiBIaSBTaW1vbiwKPgo+IFRoZSBwYXRjaCB2MSBicmVha3MgdGhl
IHJlYWwgbWFjaGluZS4gQ291bGQgeW91IHBsZWFzZSByZXZlcnQgaXQgYW5kIGp1c3Qga2VlcCB2
Mj8gVGhhbmtzLgpIbW1tLCBpZiBwb3NzaWJsZSwgSSBzdWdnZXN0IHJlc2V0dGluZyB0aGUgb2xk
IGNvbW1pdCBiZWZvcmUgdjEgYW5kCm9ubHkgYXBwbHkgdjIuLi4gVGhlIGN1cnJlbnQgc3RhdHVz
IG1ha2VzIHRoZSBoaXN0b3J5IHZlcnkgdmVyeQpjb25mdXNpbmcuCgpIdWFjYWkKCj4KPiAtIFJ1
aQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
