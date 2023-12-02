Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D54C4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0e0FD0W91YACX3ILNi+RbvZ5Og0T53Wrhj6nisS6YxE=; b=RyQs+U7XAJiGUJ
	YAq2bm776siQJAOwMnbP/YbjH9fKmKyb5M+79LDf1k7drm1Ep+mRkhAmCqzoIlDK892yeWUwO8woB
	x/kY9dJ/j/X9c1S3mERDMAFYJox1r5lNof4WhPycBTmb5njsDn6FUxW+uQg7oa2yvaa1ULfL7Xe8R
	iISKTLiGdkhTqW67ZbSVPJuqmN09Qk02Mmu9wM7a0Iy5fk7oSX68W7wQMizl6vwlOtW+30SRmAxYH
	XZAzD9eM0v1yZvZiOu4XsT9ukZH6T2fwZ6zkH1MOaYIkC+/LMkEf6YHdrHjmWWrtU5Nx92HH63E+f
	JeqfhJkKuod+1b8Vf3mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9SyJ-00Fu81-1R;
	Sat, 02 Dec 2023 16:36:03 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9SyG-00Fu7d-3B
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 16:36:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C14F4B825B9;
	Sat,  2 Dec 2023 16:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E811C433C7;
	Sat,  2 Dec 2023 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701534958;
	bh=jtk+v/LXPbug+rfaS87UXYCcXrZRhBT86cQhdOvRRPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HU4sbIj7CpKE6a8nLWnBsUwrDtaBRcUtRDzVBrMsPDVypVSRFOo05fVp8TTS8vaVN
	 Qq66mHGNJiX4JTTOJuwXW5vOaa7eQ9L+COM1Cm/LkzlLPUubd0IBKzMTJ0qttu4iWa
	 EgdZ9m/iPYSIlI1iF8vzdqWLc6HUltwDjuIxOtow0QL5wpm2WrWtBNb9AAN4PdG+Nl
	 9WkUPEXdwOMoWgbiDFYoQlaKmQpyEscTsNwAWjCLMcZe8xJ9EvdaaOAtqI/oBJ2eJv
	 guvVt/IB2zK6QJ4WYDs5F+Xd1/xIOXTxwPCWFXGfvgLedzvwHXFI8tcHqS7Qr5N6zK
	 QMJ3tZeakVzDw==
Date: Sat, 2 Dec 2023 16:35:55 +0000
From: Simon Horman <horms@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, kexec@lists.infradead.org
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
Message-ID: <20231202163555.GE836278@kernel.org>
References: <20231127134653.GC3354982@kernel.org>
 <20231202101128.133999-1-wangrui@loongson.cn>
 <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com>
 <20231202124653.GA908774@kernel.org>
 <CAAhV-H5GKkQBJa44VppqeE2-bp-9e2o99UUiX0b5_9tM5MtxwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAhV-H5GKkQBJa44VppqeE2-bp-9e2o99UUiX0b5_9tM5MtxwQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231202_083601_325921_A83632D5 
X-CRM114-Status: GOOD (  24.46  )
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

T24gU2F0LCBEZWMgMDIsIDIwMjMgYXQgMTA6MDM6MjlQTSArMDgwMCwgSHVhY2FpIENoZW4gd3Jv
dGU6Cj4gT24gU2F0LCBEZWMgMiwgMjAyMyBhdCA4OjQ24oCvUE0gU2ltb24gSG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBTYXQsIERlYyAwMiwgMjAyMyBhdCAwODoz
MDoyN1BNICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKPiA+ID4gT24gU2F0LCBEZWMgMiwgMjAy
MyBhdCA2OjEx4oCvUE0gV0FORyBSdWkgPHdhbmdydWlAbG9vbmdzb24uY24+IHdyb3RlOgo+ID4g
PiA+Cj4gPiA+ID4gPiBPbiBGcmksIE5vdiAyNCwgMjAyMyBhdCAxMTo0Njo1OFBNICswODAwLCBX
QU5HIFJ1aSB3cm90ZToKPiA+ID4gPiA+ID4gQ3VycmVudGx5LCBrZXhlYyBsb2FkcyB2bWxpbnV4
LmVmaSB0byBhZGRyZXNzIDAgaW5zdGVhZCBvZiB0aGUgbGluawo+ID4gPiA+ID4gPiBhZGRyZXNz
LiBUaGlzIGNhdXNlcyBrZXhlYyB0byBmYWlsIHRvIGJvb3QgdGhlIG5ldyB2bWxpbnV4LmVmaSBv
biBxZW11Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDoga2Vy
bmVsX3NlZ21lbnQ6IDAwMDAwMDAwMDAwMDAwMDAKPiA+ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNo
X2xvYWQ6IGtlcm5lbF9lbnRyeTogICAwMDAwMDAwMDAxNWRjMDAwCj4gPiA+ID4gPiA+ICAgcGVp
X2xvb25nYXJjaF9sb2FkOiBpbWFnZV9zaXplOiAgICAgMDAwMDAwMDAwMWYzMDAwMAo+ID4gPiA+
ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogdGV4dF9vZmZzZXQ6ICAgIDAwMDAwMDAwMDAyMDAw
MDAKPiA+ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHBoeXNfb2Zmc2V0OiAgICAwMDAw
MDAwMDAwMDAwMDAwCj4gPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBQRSBmb3JtYXQ6
ICAgICAgeWVzCj4gPiA+ID4gPiA+ICAgbG9vbmdhcmNoX2xvYWRfb3RoZXJfc2VnbWVudHM6MzMz
OiBjb21tYW5kX2xpbmU6IGtleGVjIGNvbnNvbGU9dHR5UzAsMTE1MjAwCj4gPiA+ID4gPiA+ICAg
a2V4ZWNfbG9hZDogZW50cnkgPSAweDE1ZGMwMDAgZmxhZ3MgPSAweDEwMjAwMDAKPiA+ID4gPiA+
ID4gICBucl9zZWdtZW50cyA9IDIKPiA+ID4gPiA+ID4gICBzZWdtZW50WzBdLmJ1ZiAgID0gMHg3
ZmZmZWY2NjQwMTAKPiA+ID4gPiA+ID4gICBzZWdtZW50WzBdLmJ1ZnN6ID0gMHgxZGU5YTAwCj4g
PiA+ID4gPiA+ICAgc2VnbWVudFswXS5tZW0gICA9IChuaWwpCj4gPiA+ID4gPiA+ICAgc2VnbWVu
dFswXS5tZW1zeiA9IDB4MWYzMDAwMAo+ID4gPiA+ID4gPiAgIHNlZ21lbnRbMV0uYnVmICAgPSAw
eDU1NTU1NWU0ODBiMAo+ID4gPiA+ID4gPiAgIHNlZ21lbnRbMV0uYnVmc3ogPSAweDIwMAo+ID4g
PiA+ID4gPiAgIHNlZ21lbnRbMV0ubWVtICAgPSAweDFmMzAwMDAKPiA+ID4gPiA+ID4gICBzZWdt
ZW50WzFdLm1lbXN6ID0gMHg0MDAwCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2gg
YWRkcyBgdGV4dF9vZmZzZXRgIHdoZW4gYWRkaW5nIGtlcm5lbCBzZWdtZW50IHRvIGxvYWQKPiA+
ID4gPiA+ID4gdm1saW51eC5lZmkgdG8gdGhlIGxpbmsgYWRkcmVzcy4KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGtlcm5lbF9zZWdtZW50OiAwMDAwMDAwMDAw
MDAwMDAwCj4gPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBrZXJuZWxfZW50cnk6ICAg
MDAwMDAwMDAwMTVkYzAwMAo+ID4gPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogaW1hZ2Vf
c2l6ZTogICAgIDAwMDAwMDAwMDFmMzAwMDAKPiA+ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xv
YWQ6IHRleHRfb2Zmc2V0OiAgICAwMDAwMDAwMDAwMjAwMDAwCj4gPiA+ID4gPiA+ICAgcGVpX2xv
b25nYXJjaF9sb2FkOiBwaHlzX29mZnNldDogICAgMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+ID4g
PiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogUEUgZm9ybWF0OiAgICAgIHllcwo+ID4gPiA+ID4gPiAg
IGxvb25nYXJjaF9sb2FkX290aGVyX3NlZ21lbnRzOjMzNTogY29tbWFuZF9saW5lOiBrZXhlYyBj
b25zb2xlPXR0eVMwLDExNTIwMAo+ID4gPiA+ID4gPiAgIGtleGVjX2xvYWQ6IGVudHJ5ID0gMHgx
NWRjMDAwIGZsYWdzID0gMHgxMDIwMDAwCj4gPiA+ID4gPiA+ICAgbnJfc2VnbWVudHMgPSAyCj4g
PiA+ID4gPiA+ICAgc2VnbWVudFswXS5idWYgICA9IDB4N2ZmZmYxYTA0MDEwCj4gPiA+ID4gPiA+
ICAgc2VnbWVudFswXS5idWZzeiA9IDB4MWRlOWEwMAo+ID4gPiA+ID4gPiAgIHNlZ21lbnRbMF0u
bWVtICAgPSAweDIwMDAwMAo+ID4gPiA+ID4gPiAgIHNlZ21lbnRbMF0ubWVtc3ogPSAweDFmMzAw
MDAKPiA+ID4gPiA+ID4gICBzZWdtZW50WzFdLmJ1ZiAgID0gMHg1NTU1NTViMjgwOTgKPiA+ID4g
PiA+ID4gICBzZWdtZW50WzFdLmJ1ZnN6ID0gMHgyMDAKPiA+ID4gPiA+ID4gICBzZWdtZW50WzFd
Lm1lbSAgID0gMHgyMTMwMDAwCj4gPiA+ID4gPiA+ICAgc2VnbWVudFsxXS5tZW1zeiA9IDB4NDAw
MAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXQU5HIFJ1aSA8d2FuZ3J1
aUBsb29uZ3Nvbi5jbj4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MsIGFwcGxpZWQuCj4gPiA+
ID4KPiA+ID4gPiBIaSBTaW1vbiwKPiA+ID4gPgo+ID4gPiA+IFRoZSBwYXRjaCB2MSBicmVha3Mg
dGhlIHJlYWwgbWFjaGluZS4gQ291bGQgeW91IHBsZWFzZSByZXZlcnQgaXQgYW5kIGp1c3Qga2Vl
cCB2Mj8gVGhhbmtzLgo+ID4gPiBIbW1tLCBpZiBwb3NzaWJsZSwgSSBzdWdnZXN0IHJlc2V0dGlu
ZyB0aGUgb2xkIGNvbW1pdCBiZWZvcmUgdjEgYW5kCj4gPiA+IG9ubHkgYXBwbHkgdjIuLi4gVGhl
IGN1cnJlbnQgc3RhdHVzIG1ha2VzIHRoZSBoaXN0b3J5IHZlcnkgdmVyeQo+ID4gPiBjb25mdXNp
bmcuCj4gPgo+ID4gVGhhbmtzLCBJIHdvdWxkIHJhdGhlciBub3QgZHJvcCBwYXRjaGVzIGZyb20g
dGhlIHRyZWUgYXMgaXQgY2hhbmdlcwo+ID4gdGhlIGhhc2hlcyBvZiB0aGUgdHJlZSBmcm9tIHRo
YXQgcG9pbnQuIEhvd2V2ZXIsIGluIHRoaXMgY2FzZSwgSSBhZ3JlZQo+ID4gdGhhdCBhIHNpbXBs
ZSByZXZlcnQgbWFrZXMgdGhpbmdzIGNvbmZ1c2luZywgc28gSSBoYXZlIGRvbmUgYXMgeW91IHN1
Z2dlc3QKPiA+IC0gdjEgaGFzIGJlZW4gZHJvcHBlZCBmcm9tIHRoZSB0cmVlLgo+ID4KPiA+IENh
biB5b3UgcGxlYXNlIGNoZWNrIHRoYXQgdGhlIHRyZWUgYXMgb2YgdGhlIGZvbGxvd2luZyBjb21t
aXQsIHdoaWNoIGlzCj4gPiBub3cgdGhlIEhFQUQgY29tbWl0IG9mIHRoZSBtYWluIGJyYW5jaCwg
aXMgY29ycmVjdD8KPiA+Cj4gPiA1NDk0NjY0MzBhZTYgKCJMb29uZ0FyY2g6IExvYWQgdm1saW51
eC5lZmkgdG8gdGhlIGxpbmsgYWRkcmVzcyIpCj4gVGhhbmsgeW91LCBpdCBpcyBwZXJmZWN0IG5v
dy4KClRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcyB0byBteSBhdHRlbnRpb24gYW5kIHRoYW5rcyBm
b3IgY2hlY2tpbmcuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
