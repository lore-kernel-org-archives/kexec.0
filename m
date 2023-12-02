Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C19C4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1sJSfUJC8UVVfoPxu4PbRL4ttzEYPFSRR6LRUG0jpO8=; b=jXF3buf2randYm
	V2TvRcW5Ont19yPtsFqHy8OzSM+DkcYy+azMVKksYVMFwTT2qTrFoRHdA7p784NGPxv6kTNbgpf8+
	XXz86GrWdbr3se9ovM3LlcA9jQjlNe3p6hN24gZ2ZVzchDFCdHv/vXyh0PWOugwcBH3hlNb3B6Fq+
	UGNx6ic7NlnmGnoKSQwXQS8uuMQVatKDMJSCnq1GV+pIffWqeXcE1UGqdV/jutKhYSagOywkfBP6j
	7xBa8PGLv/dYMkK0IqZMV67hwWqSMNixOOehYwfgET8gJPsaFXi5DMTHXrHx3+iIVcXJcqDJ+9qmK
	l836utGTsqLUl7VY8wlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9POg-00Fhgc-0y;
	Sat, 02 Dec 2023 12:47:02 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9POd-00FhgH-0q
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 12:47:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B22E7CE0AE9;
	Sat,  2 Dec 2023 12:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5FFC433C9;
	Sat,  2 Dec 2023 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701521216;
	bh=3JHWP56EteInNlLlcd3DAWzq9UnIwIKaTf6cvpL7Uzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDxhUE01JERODpbf5/Kwa5ZUl5AXVRBf/1l4XXc31sokI/1WMZ8FCsvHZTY/p4MeB
	 2hZDpFA8MgiVUOYaaPwkyZhtnfX1nhx4NCouKLkj0ac6JOsE+3sBbRxJa+vz0ILRx2
	 jQvATpb4oopnxiR3VMyk4gtTZTGPxoTsTU3NVIC7VdIDT4kmYkFneVz1QgpB5HIg0E
	 pJJTfL6U+T3hjcL2o1ucB7UZMZEK1z1SYRXUsOOFuxHuymxk+YyauvrK20M/EgsVrO
	 OgML9hb5qkW1jNQfQj5aDvEtnMPgZ24Fkl67SYZfpg/5baJa/6v2hfzw296T55e9xW
	 s04uOz2PEYqpA==
Date: Sat, 2 Dec 2023 12:46:53 +0000
From: Simon Horman <horms@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, kexec@lists.infradead.org
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
Message-ID: <20231202124653.GA908774@kernel.org>
References: <20231127134653.GC3354982@kernel.org>
 <20231202101128.133999-1-wangrui@loongson.cn>
 <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231202_044659_764668_0CCC37EA 
X-CRM114-Status: GOOD (  19.57  )
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

T24gU2F0LCBEZWMgMDIsIDIwMjMgYXQgMDg6MzA6MjdQTSArMDgwMCwgSHVhY2FpIENoZW4gd3Jv
dGU6Cj4gT24gU2F0LCBEZWMgMiwgMjAyMyBhdCA2OjEx4oCvUE0gV0FORyBSdWkgPHdhbmdydWlA
bG9vbmdzb24uY24+IHdyb3RlOgo+ID4KPiA+ID4gT24gRnJpLCBOb3YgMjQsIDIwMjMgYXQgMTE6
NDY6NThQTSArMDgwMCwgV0FORyBSdWkgd3JvdGU6Cj4gPiA+ID4gQ3VycmVudGx5LCBrZXhlYyBs
b2FkcyB2bWxpbnV4LmVmaSB0byBhZGRyZXNzIDAgaW5zdGVhZCBvZiB0aGUgbGluawo+ID4gPiA+
IGFkZHJlc3MuIFRoaXMgY2F1c2VzIGtleGVjIHRvIGZhaWwgdG8gYm9vdCB0aGUgbmV3IHZtbGlu
dXguZWZpIG9uIHFlbXUuCj4gPiA+ID4KPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDoga2Vy
bmVsX3NlZ21lbnQ6IDAwMDAwMDAwMDAwMDAwMDAKPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9h
ZDoga2VybmVsX2VudHJ5OiAgIDAwMDAwMDAwMDE1ZGMwMDAKPiA+ID4gPiAgIHBlaV9sb29uZ2Fy
Y2hfbG9hZDogaW1hZ2Vfc2l6ZTogICAgIDAwMDAwMDAwMDFmMzAwMDAKPiA+ID4gPiAgIHBlaV9s
b29uZ2FyY2hfbG9hZDogdGV4dF9vZmZzZXQ6ICAgIDAwMDAwMDAwMDAyMDAwMDAKPiA+ID4gPiAg
IHBlaV9sb29uZ2FyY2hfbG9hZDogcGh5c19vZmZzZXQ6ICAgIDAwMDAwMDAwMDAwMDAwMDAKPiA+
ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogUEUgZm9ybWF0OiAgICAgIHllcwo+ID4gPiA+ICAg
bG9vbmdhcmNoX2xvYWRfb3RoZXJfc2VnbWVudHM6MzMzOiBjb21tYW5kX2xpbmU6IGtleGVjIGNv
bnNvbGU9dHR5UzAsMTE1MjAwCj4gPiA+ID4gICBrZXhlY19sb2FkOiBlbnRyeSA9IDB4MTVkYzAw
MCBmbGFncyA9IDB4MTAyMDAwMAo+ID4gPiA+ICAgbnJfc2VnbWVudHMgPSAyCj4gPiA+ID4gICBz
ZWdtZW50WzBdLmJ1ZiAgID0gMHg3ZmZmZWY2NjQwMTAKPiA+ID4gPiAgIHNlZ21lbnRbMF0uYnVm
c3ogPSAweDFkZTlhMDAKPiA+ID4gPiAgIHNlZ21lbnRbMF0ubWVtICAgPSAobmlsKQo+ID4gPiA+
ICAgc2VnbWVudFswXS5tZW1zeiA9IDB4MWYzMDAwMAo+ID4gPiA+ICAgc2VnbWVudFsxXS5idWYg
ICA9IDB4NTU1NTU1ZTQ4MGIwCj4gPiA+ID4gICBzZWdtZW50WzFdLmJ1ZnN6ID0gMHgyMDAKPiA+
ID4gPiAgIHNlZ21lbnRbMV0ubWVtICAgPSAweDFmMzAwMDAKPiA+ID4gPiAgIHNlZ21lbnRbMV0u
bWVtc3ogPSAweDQwMDAKPiA+ID4gPgo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBgdGV4dF9vZmZz
ZXRgIHdoZW4gYWRkaW5nIGtlcm5lbCBzZWdtZW50IHRvIGxvYWQKPiA+ID4gPiB2bWxpbnV4LmVm
aSB0byB0aGUgbGluayBhZGRyZXNzLgo+ID4gPiA+Cj4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xv
YWQ6IGtlcm5lbF9zZWdtZW50OiAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ID4gICBwZWlfbG9vbmdh
cmNoX2xvYWQ6IGtlcm5lbF9lbnRyeTogICAwMDAwMDAwMDAxNWRjMDAwCj4gPiA+ID4gICBwZWlf
bG9vbmdhcmNoX2xvYWQ6IGltYWdlX3NpemU6ICAgICAwMDAwMDAwMDAxZjMwMDAwCj4gPiA+ID4g
ICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHRleHRfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMjAwMDAwCj4g
PiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHBoeXNfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMDAw
MDAwCj4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IFBFIGZvcm1hdDogICAgICB5ZXMKPiA+
ID4gPiAgIGxvb25nYXJjaF9sb2FkX290aGVyX3NlZ21lbnRzOjMzNTogY29tbWFuZF9saW5lOiBr
ZXhlYyBjb25zb2xlPXR0eVMwLDExNTIwMAo+ID4gPiA+ICAga2V4ZWNfbG9hZDogZW50cnkgPSAw
eDE1ZGMwMDAgZmxhZ3MgPSAweDEwMjAwMDAKPiA+ID4gPiAgIG5yX3NlZ21lbnRzID0gMgo+ID4g
PiA+ICAgc2VnbWVudFswXS5idWYgICA9IDB4N2ZmZmYxYTA0MDEwCj4gPiA+ID4gICBzZWdtZW50
WzBdLmJ1ZnN6ID0gMHgxZGU5YTAwCj4gPiA+ID4gICBzZWdtZW50WzBdLm1lbSAgID0gMHgyMDAw
MDAKPiA+ID4gPiAgIHNlZ21lbnRbMF0ubWVtc3ogPSAweDFmMzAwMDAKPiA+ID4gPiAgIHNlZ21l
bnRbMV0uYnVmICAgPSAweDU1NTU1NWIyODA5OAo+ID4gPiA+ICAgc2VnbWVudFsxXS5idWZzeiA9
IDB4MjAwCj4gPiA+ID4gICBzZWdtZW50WzFdLm1lbSAgID0gMHgyMTMwMDAwCj4gPiA+ID4gICBz
ZWdtZW50WzFdLm1lbXN6ID0gMHg0MDAwCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBX
QU5HIFJ1aSA8d2FuZ3J1aUBsb29uZ3Nvbi5jbj4KPiA+ID4KPiA+ID4gVGhhbmtzLCBhcHBsaWVk
Lgo+ID4KPiA+IEhpIFNpbW9uLAo+ID4KPiA+IFRoZSBwYXRjaCB2MSBicmVha3MgdGhlIHJlYWwg
bWFjaGluZS4gQ291bGQgeW91IHBsZWFzZSByZXZlcnQgaXQgYW5kIGp1c3Qga2VlcCB2Mj8gVGhh
bmtzLgo+IEhtbW0sIGlmIHBvc3NpYmxlLCBJIHN1Z2dlc3QgcmVzZXR0aW5nIHRoZSBvbGQgY29t
bWl0IGJlZm9yZSB2MSBhbmQKPiBvbmx5IGFwcGx5IHYyLi4uIFRoZSBjdXJyZW50IHN0YXR1cyBt
YWtlcyB0aGUgaGlzdG9yeSB2ZXJ5IHZlcnkKPiBjb25mdXNpbmcuCgpUaGFua3MsIEkgd291bGQg
cmF0aGVyIG5vdCBkcm9wIHBhdGNoZXMgZnJvbSB0aGUgdHJlZSBhcyBpdCBjaGFuZ2VzCnRoZSBo
YXNoZXMgb2YgdGhlIHRyZWUgZnJvbSB0aGF0IHBvaW50LiBIb3dldmVyLCBpbiB0aGlzIGNhc2Us
IEkgYWdyZWUKdGhhdCBhIHNpbXBsZSByZXZlcnQgbWFrZXMgdGhpbmdzIGNvbmZ1c2luZywgc28g
SSBoYXZlIGRvbmUgYXMgeW91IHN1Z2dlc3QKLSB2MSBoYXMgYmVlbiBkcm9wcGVkIGZyb20gdGhl
IHRyZWUuCgpDYW4geW91IHBsZWFzZSBjaGVjayB0aGF0IHRoZSB0cmVlIGFzIG9mIHRoZSBmb2xs
b3dpbmcgY29tbWl0LCB3aGljaCBpcwpub3cgdGhlIEhFQUQgY29tbWl0IG9mIHRoZSBtYWluIGJy
YW5jaCwgaXMgY29ycmVjdD8KCjU0OTQ2NjQzMGFlNiAoIkxvb25nQXJjaDogTG9hZCB2bWxpbnV4
LmVmaSB0byB0aGUgbGluayBhZGRyZXNzIikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
