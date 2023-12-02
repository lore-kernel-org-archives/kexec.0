Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CACC4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s5fc2Yl7APvFblVkijpteDiILCfB9/xJxPZVvZcJUHg=; b=2rXjOVtSMrlO3f
	J6UkJgth8gQKpWhnS3/7ARLbiWiRi5tuYO/dHWffAV6dfKoKW8VlqcXGkj7CCAp5bFAQZpRZ1pcta
	UqeRo+HKFHPtTQUFJnST9J4uXmHIOX7A4Aq8xvwtfw8an/tAfXWv1TN3Jxy1OHDiY/RuydZ+sJzRa
	DBSKZXYdkGexocF7cqXndUdEt2VsBnAohm417tv0dHRCXTcrX1rW5Fz+/ClIKrlMCjSX/6LDwtO0M
	y9+Re2o3FZ2ukrijKJc10yV3wpC/msSQDtCxnj9wLdgFdGpsJOodcRnMWeCCnMl9jvliGj8u5U0eX
	+DB5eo4tXqlFsmAe1YXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9Qb3-00FmFO-2u;
	Sat, 02 Dec 2023 14:03:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9Qb0-00FmE2-2G
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 14:03:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 441D7CE10F9
	for <kexec@lists.infradead.org>; Sat,  2 Dec 2023 14:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28739C433C7
	for <kexec@lists.infradead.org>; Sat,  2 Dec 2023 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701525822;
	bh=D4qVTB+lpeDHCeK+Zhykybjm+peyeUKTd8QmGogAIks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SnRaQzxzGZphHJ4tKob+nAWF1kFY29emOxxC3TZntY+bN6xGXXjIlx+YS6nBFxONg
	 zRF5SIC6Fki/d5BYiOtiRgz0d2G9yk0nZqgHGO4n99VKGmOioFWO/OE8geF2EYa8iZ
	 VkVDbQrzJY7sXH5T1w/yJQW6YmF2joHOFnNXx+NG5jIeIsUzz2e9+waxKfaqx9gBLV
	 YZMZf062rmrkoe0QJzprylqkg4+VpBkDQVzhCgWkwdMvHl3a7LhdJZJAyBJ8YYi7O+
	 gAGx3Ci084AyOVIFX/sbxL7Q6koY/DOcMyS+A4G3znK9PiHoI6+URDHlHfbJY9GZNo
	 EJfMSCO40Uv6g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so1799707a12.0
        for <kexec@lists.infradead.org>; Sat, 02 Dec 2023 06:03:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7ZPmZvnfBOrWJFouhZb3eOxK3xWVMmQuYIsmXS++QfnPlFVlM
	1WTEgIsGNI62eMb+kxreu6HT3m8NMpAMvjPPf14=
X-Google-Smtp-Source: AGHT+IEE9et3QFtaCWaX8vqm1Vexw1QvLEaJnaxtPw+PEyHYUx+2mCwjcNAAnHVfz7TCF6jUlfECFRKLkeGyfdPBpWU=
X-Received: by 2002:a50:ccda:0:b0:54b:10a8:ad6f with SMTP id
 b26-20020a50ccda000000b0054b10a8ad6fmr1597222edj.40.1701525820596; Sat, 02
 Dec 2023 06:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20231127134653.GC3354982@kernel.org> <20231202101128.133999-1-wangrui@loongson.cn>
 <CAAhV-H4RBGAmvV8H3hwgadu=8WxdNkg_tWUj3sfxkrptSoUL9w@mail.gmail.com> <20231202124653.GA908774@kernel.org>
In-Reply-To: <20231202124653.GA908774@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 2 Dec 2023 22:03:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5GKkQBJa44VppqeE2-bp-9e2o99UUiX0b5_9tM5MtxwQ@mail.gmail.com>
Message-ID: <CAAhV-H5GKkQBJa44VppqeE2-bp-9e2o99UUiX0b5_9tM5MtxwQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
To: Simon Horman <horms@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231202_060351_232948_90DE23DC 
X-CRM114-Status: GOOD (  23.07  )
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

T24gU2F0LCBEZWMgMiwgMjAyMyBhdCA4OjQ24oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IE9uIFNhdCwgRGVjIDAyLCAyMDIzIGF0IDA4OjMwOjI3UE0gKzA4
MDAsIEh1YWNhaSBDaGVuIHdyb3RlOgo+ID4gT24gU2F0LCBEZWMgMiwgMjAyMyBhdCA2OjEx4oCv
UE0gV0FORyBSdWkgPHdhbmdydWlAbG9vbmdzb24uY24+IHdyb3RlOgo+ID4gPgo+ID4gPiA+IE9u
IEZyaSwgTm92IDI0LCAyMDIzIGF0IDExOjQ2OjU4UE0gKzA4MDAsIFdBTkcgUnVpIHdyb3RlOgo+
ID4gPiA+ID4gQ3VycmVudGx5LCBrZXhlYyBsb2FkcyB2bWxpbnV4LmVmaSB0byBhZGRyZXNzIDAg
aW5zdGVhZCBvZiB0aGUgbGluawo+ID4gPiA+ID4gYWRkcmVzcy4gVGhpcyBjYXVzZXMga2V4ZWMg
dG8gZmFpbCB0byBib290IHRoZSBuZXcgdm1saW51eC5lZmkgb24gcWVtdS4KPiA+ID4gPiA+Cj4g
PiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDoga2VybmVsX3NlZ21lbnQ6IDAwMDAwMDAwMDAw
MDAwMDAKPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBrZXJuZWxfZW50cnk6ICAgMDAw
MDAwMDAwMTVkYzAwMAo+ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGltYWdlX3NpemU6
ICAgICAwMDAwMDAwMDAxZjMwMDAwCj4gPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogdGV4
dF9vZmZzZXQ6ICAgIDAwMDAwMDAwMDAyMDAwMDAKPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9s
b2FkOiBwaHlzX29mZnNldDogICAgMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+ID4gICBwZWlfbG9v
bmdhcmNoX2xvYWQ6IFBFIGZvcm1hdDogICAgICB5ZXMKPiA+ID4gPiA+ICAgbG9vbmdhcmNoX2xv
YWRfb3RoZXJfc2VnbWVudHM6MzMzOiBjb21tYW5kX2xpbmU6IGtleGVjIGNvbnNvbGU9dHR5UzAs
MTE1MjAwCj4gPiA+ID4gPiAgIGtleGVjX2xvYWQ6IGVudHJ5ID0gMHgxNWRjMDAwIGZsYWdzID0g
MHgxMDIwMDAwCj4gPiA+ID4gPiAgIG5yX3NlZ21lbnRzID0gMgo+ID4gPiA+ID4gICBzZWdtZW50
WzBdLmJ1ZiAgID0gMHg3ZmZmZWY2NjQwMTAKPiA+ID4gPiA+ICAgc2VnbWVudFswXS5idWZzeiA9
IDB4MWRlOWEwMAo+ID4gPiA+ID4gICBzZWdtZW50WzBdLm1lbSAgID0gKG5pbCkKPiA+ID4gPiA+
ICAgc2VnbWVudFswXS5tZW1zeiA9IDB4MWYzMDAwMAo+ID4gPiA+ID4gICBzZWdtZW50WzFdLmJ1
ZiAgID0gMHg1NTU1NTVlNDgwYjAKPiA+ID4gPiA+ICAgc2VnbWVudFsxXS5idWZzeiA9IDB4MjAw
Cj4gPiA+ID4gPiAgIHNlZ21lbnRbMV0ubWVtICAgPSAweDFmMzAwMDAKPiA+ID4gPiA+ICAgc2Vn
bWVudFsxXS5tZW1zeiA9IDB4NDAwMAo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRk
cyBgdGV4dF9vZmZzZXRgIHdoZW4gYWRkaW5nIGtlcm5lbCBzZWdtZW50IHRvIGxvYWQKPiA+ID4g
PiA+IHZtbGludXguZWZpIHRvIHRoZSBsaW5rIGFkZHJlc3MuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
ICBwZWlfbG9vbmdhcmNoX2xvYWQ6IGtlcm5lbF9zZWdtZW50OiAwMDAwMDAwMDAwMDAwMDAwCj4g
PiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDoga2VybmVsX2VudHJ5OiAgIDAwMDAwMDAwMDE1
ZGMwMDAKPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9sb2FkOiBpbWFnZV9zaXplOiAgICAgMDAw
MDAwMDAwMWYzMDAwMAo+ID4gPiA+ID4gICBwZWlfbG9vbmdhcmNoX2xvYWQ6IHRleHRfb2Zmc2V0
OiAgICAwMDAwMDAwMDAwMjAwMDAwCj4gPiA+ID4gPiAgIHBlaV9sb29uZ2FyY2hfbG9hZDogcGh5
c19vZmZzZXQ6ICAgIDAwMDAwMDAwMDAwMDAwMDAKPiA+ID4gPiA+ICAgcGVpX2xvb25nYXJjaF9s
b2FkOiBQRSBmb3JtYXQ6ICAgICAgeWVzCj4gPiA+ID4gPiAgIGxvb25nYXJjaF9sb2FkX290aGVy
X3NlZ21lbnRzOjMzNTogY29tbWFuZF9saW5lOiBrZXhlYyBjb25zb2xlPXR0eVMwLDExNTIwMAo+
ID4gPiA+ID4gICBrZXhlY19sb2FkOiBlbnRyeSA9IDB4MTVkYzAwMCBmbGFncyA9IDB4MTAyMDAw
MAo+ID4gPiA+ID4gICBucl9zZWdtZW50cyA9IDIKPiA+ID4gPiA+ICAgc2VnbWVudFswXS5idWYg
ICA9IDB4N2ZmZmYxYTA0MDEwCj4gPiA+ID4gPiAgIHNlZ21lbnRbMF0uYnVmc3ogPSAweDFkZTlh
MDAKPiA+ID4gPiA+ICAgc2VnbWVudFswXS5tZW0gICA9IDB4MjAwMDAwCj4gPiA+ID4gPiAgIHNl
Z21lbnRbMF0ubWVtc3ogPSAweDFmMzAwMDAKPiA+ID4gPiA+ICAgc2VnbWVudFsxXS5idWYgICA9
IDB4NTU1NTU1YjI4MDk4Cj4gPiA+ID4gPiAgIHNlZ21lbnRbMV0uYnVmc3ogPSAweDIwMAo+ID4g
PiA+ID4gICBzZWdtZW50WzFdLm1lbSAgID0gMHgyMTMwMDAwCj4gPiA+ID4gPiAgIHNlZ21lbnRb
MV0ubWVtc3ogPSAweDQwMDAKPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXQU5H
IFJ1aSA8d2FuZ3J1aUBsb29uZ3Nvbi5jbj4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcywgYXBwbGll
ZC4KPiA+ID4KPiA+ID4gSGkgU2ltb24sCj4gPiA+Cj4gPiA+IFRoZSBwYXRjaCB2MSBicmVha3Mg
dGhlIHJlYWwgbWFjaGluZS4gQ291bGQgeW91IHBsZWFzZSByZXZlcnQgaXQgYW5kIGp1c3Qga2Vl
cCB2Mj8gVGhhbmtzLgo+ID4gSG1tbSwgaWYgcG9zc2libGUsIEkgc3VnZ2VzdCByZXNldHRpbmcg
dGhlIG9sZCBjb21taXQgYmVmb3JlIHYxIGFuZAo+ID4gb25seSBhcHBseSB2Mi4uLiBUaGUgY3Vy
cmVudCBzdGF0dXMgbWFrZXMgdGhlIGhpc3RvcnkgdmVyeSB2ZXJ5Cj4gPiBjb25mdXNpbmcuCj4K
PiBUaGFua3MsIEkgd291bGQgcmF0aGVyIG5vdCBkcm9wIHBhdGNoZXMgZnJvbSB0aGUgdHJlZSBh
cyBpdCBjaGFuZ2VzCj4gdGhlIGhhc2hlcyBvZiB0aGUgdHJlZSBmcm9tIHRoYXQgcG9pbnQuIEhv
d2V2ZXIsIGluIHRoaXMgY2FzZSwgSSBhZ3JlZQo+IHRoYXQgYSBzaW1wbGUgcmV2ZXJ0IG1ha2Vz
IHRoaW5ncyBjb25mdXNpbmcsIHNvIEkgaGF2ZSBkb25lIGFzIHlvdSBzdWdnZXN0Cj4gLSB2MSBo
YXMgYmVlbiBkcm9wcGVkIGZyb20gdGhlIHRyZWUuCj4KPiBDYW4geW91IHBsZWFzZSBjaGVjayB0
aGF0IHRoZSB0cmVlIGFzIG9mIHRoZSBmb2xsb3dpbmcgY29tbWl0LCB3aGljaCBpcwo+IG5vdyB0
aGUgSEVBRCBjb21taXQgb2YgdGhlIG1haW4gYnJhbmNoLCBpcyBjb3JyZWN0Pwo+Cj4gNTQ5NDY2
NDMwYWU2ICgiTG9vbmdBcmNoOiBMb2FkIHZtbGludXguZWZpIHRvIHRoZSBsaW5rIGFkZHJlc3Mi
KQpUaGFuayB5b3UsIGl0IGlzIHBlcmZlY3Qgbm93LgoKSHVhY2FpCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
