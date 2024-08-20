Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C25DC3DA4A
	for <kexec@archiver.kernel.org>; Tue, 20 Aug 2024 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ja3AiL8dapMrjEESLmoOaFo2tHqjHafqaJ4Kmm/e7XY=; b=gqawwkZXAAew/F
	KudoWJvF2Yyw4dcRtPibicWi/byuj4x9DUKKH1CjOZPpS21hti+VYMXUg2FX6Va9bRQM1XIYBPiUs
	EBwoR00+YCPoRy8B8v5W5qI3i7Gj4RhqFezWK7Z//wIyJg4ga+pcOZXf5j65O9KAQcOFTteTMY27q
	eqiKFBwWE3aU7AkrC3m/YC+Q7fx9yoTouQ7eTjBfI6WRunuhyLPGAU/a+6+YdiE0IWmKQncQh4628
	HyJqtaLfMQqaNUoDx9byY27Ldxx/0ySYW/u5srPFiXIviboczaodSGFJdwipbicOu9A8zrKEGu/v7
	Kw/udko9BxBzqo7FZP5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDCY-00000003Mwa-2TSI;
	Tue, 20 Aug 2024 00:58:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDCV-00000003MuW-2pRO
	for kexec@lists.infradead.org;
	Tue, 20 Aug 2024 00:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724115497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
	b=Ax39Rzc2dpgZ5vpZA+qwAUTy+M0g0cB+mHS/c6pCELrsQ1lnlAsKJU+8CmkPMux5WUiSgo
	phzZrKDJvAPo3bZKq3uaQRq5x0ZYgcbtnKLmuEMD5WJ7sc/eIZWI0ZJIUNTVbDwOqPyjRr
	IrJVOto2gAXZ/WX+8B3G1GZdY54P4sk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-FQW0NXlkPSGL0xe_ubUcCw-1; Mon, 19 Aug 2024 20:58:13 -0400
X-MC-Unique: FQW0NXlkPSGL0xe_ubUcCw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf77cbd34fso50453676d6.1
        for <kexec@lists.infradead.org>; Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115493; x=1724720293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
        b=kSwptxtaladHUBA/bGaDJ2FBJWaBq19bzWh9u6LOYKh/iETUt2NDF5GGP6vy/f410l
         qgAbl5kOM5iffqOIi5U0QXZwpE5xzImc9OdDM/l5vcizeDDW+TYXKYYDAt1qJ4F0Myrb
         nY48dJwCeNQGU0rzB1FmUrMfTFD/jm8ZmnNvhvm3sMCP6yLJOVVO/4U014RPakNn4lu1
         dvHDXTvDcdDk2jE2jErjIat53J0gKJTHryZesxt5Cn4iSczeuCEA2RpNbg19AgnN33UI
         zG7KqU8MqbJrZnhs8AbvYm+PF5VPO4N2HSv+USp4XQEmdGyv68luznC/SmjdEnVJwWJ3
         7+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcqC7sTZSxzJgtAE8cIQq00iNzY0TQCzg4FkZ6h1Mqy++MPrSQdf0TMGRURNZSaKuy6EsHU9Lv/R2oEMGb90r5uP/5c7fhI8h/
X-Gm-Message-State: AOJu0YwQWno647MWRvyxbnafIX9NvjXDlimfr4GloxyuAppHwRomyuFr
	62LDM02JqDG5j2Uz1OHITtqPqspCbdtc+XHyTl0bL5ec8VzokycAq/vydJROveeHwP3FQLze+zO
	bM80hk6C5FBkakYz+xsSeLYZZvxbnQXUoePqqdQoNjarkAa+yeyiTKfBrV3INV8E5MNH6bDakVW
	6bbVyeBv2enBqxV7tzHkgb6Kbje8fb17BF
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id 6a1803df08f44-6bf7ce06a55mr152731026d6.32.1724115493017;
        Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0xEAdTPZqQ0R37bhm+bI8tZ08r0K84Li3rZ/xKsFzl+U1c+/gTnEWiG6hFEZE3WA3cmHWfdPmI8H8H/7457I=
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id
 6a1803df08f44-6bf7ce06a55mr152730866d6.32.1724115492656; Mon, 19 Aug 2024
 17:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <20240819145417.23367-2-piliu@redhat.com>
 <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
In-Reply-To: <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 20 Aug 2024 08:58:01 +0800
Message-ID: <CAF+s44TK1RZ6m=b3RX_KTsptRQ06XZO_knn3=39eWXLv64AxoA@mail.gmail.com>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_175820_005298_20D30666 
X-CRM114-Status: GOOD (  21.13  )
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

T24gVHVlLCBBdWcgMjAsIDIwMjQgYXQgMjowMOKAr0FNIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uIEF1ZyAxOSwgMjAyNCBhdCA1OjUzIFBNIEVF
U1QsIFBpbmdmYW4gTGl1IHdyb3RlOgo+ID4gZWZpX3JhbmRvbV9hbGxvYygpIGRlbWFuZHMgRUZJ
X0FMTE9DQVRFX0FERFJFU1Mgd2hlbiBhbGxvY2F0ZV9wYWdlcygpLAo+ID4gYnV0IHRoZSBjdXJy
ZW50IGltcGxlbWVudCBjYW4gbm90IGVuc3VyZSB0aGUgc2VsZWN0ZWQgdGFyZ2V0IGxvY2F0ZXMK
PiA+IGluc2lkZSBmcmVlIGFyZWEsIHRoYXQgaXMgdG8gZXhjbHVkZSBFRklfQk9PVF9TRVJWSUNF
U18qLAo+ID4gRUZJX1JVTlRJTUVfU0VSVklDRVNfKiBldGMuCj4gPgo+ID4gRml4IHRoZSBpc3N1
ZSBieSBjaGVja2luZyBtZC0+dHlwZS4KPgo+IElmIGl0IGlzIGEgZml4IHNob3VsZG4ndCB0aGlz
IGhhdmUgYSBmaXhlcyB0YWc/Cj4KWWVzLCBJIHdpbGwgc3VwcGxlbWVudCB0aGUgZm9sbG93aW5n
IGluIHRoZSBuZXh0IHZlcnNpb24KRml4ZXM6IDJkZGJmYzgxZWFjOCAoImVmaTogc3R1YjogYWRk
IGltcGxlbWVudGF0aW9uIG9mIGVmaV9yYW5kb21fYWxsb2MoKSIpCgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgo+ID4gQ2M6IEFyZCBCaWVzaGV1
dmVsIDxhcmRiQGtlcm5lbC5vcmc+Cj4gPiBUbzogbGludXgtZWZpQHZnZXIua2VybmVsLm9yZwo+
ID4gLS0tCj4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yYW5kb21hbGxvYy5jIHwg
NSArKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yYW5kb21hbGxvYy5jIGIvZHJp
dmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yYW5kb21hbGxvYy5jCj4gPiBpbmRleCBjNDFlN2Iy
MDkxY2RkLi43MzA0ZTc2NzY4OGYyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9l
ZmkvbGlic3R1Yi9yYW5kb21hbGxvYy5jCj4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9s
aWJzdHViL3JhbmRvbWFsbG9jLmMKPiA+IEBAIC03OSw2ICs3OSw4IEBAIGVmaV9zdGF0dXNfdCBl
ZmlfcmFuZG9tX2FsbG9jKHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiA+ICAgICAgICAgICAgICAgZWZp
X21lbW9yeV9kZXNjX3QgKm1kID0gKHZvaWQgKiltYXAtPm1hcCArIG1hcF9vZmZzZXQ7Cj4gPiAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgc2xvdHM7Cj4gPgo+Cj4gSSdkIGFkZCB0aGlzIGlu
bGluZSBjb21tZW50Ogo+Cj4gLyogU2tpcCAidW5jb252ZW50aW9uYWwiIG1lbW9yeTogKi8KPgoK
QWRvcHQuCgpUaGFua3MgZm9yIHlvdXIga2luZCByZXZpZXcuCgpCZXN0IFJlZ2FyZHMsCgpQaW5n
ZmFuCgo+ID4gKyAgICAgICAgICAgICBpZiAoIShtZC0+dHlwZSAmIChFRklfQ09OVkVOVElPTkFM
X01FTU9SWSB8fCBFRklfUEVSU0lTVEVOVF9NRU1PUlkpKSkKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsKPiA+ICAgICAgICAgICAgICAgc2xvdHMgPSBnZXRfZW50cnlfbnVtX3Ns
b3RzKG1kLCBzaXplLCBpbG9nMihhbGlnbiksIGFsbG9jX21pbiwKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFsbG9jX21heCk7Cj4gPiAgICAgICAgICAgICAg
IE1EX05VTV9TTE9UUyhtZCkgPSBzbG90czsKPiA+IEBAIC0xMTEsNiArMTEzLDkgQEAgZWZpX3N0
YXR1c190IGVmaV9yYW5kb21fYWxsb2ModW5zaWduZWQgbG9uZyBzaXplLAo+ID4gICAgICAgICAg
ICAgICBlZmlfcGh5c2ljYWxfYWRkcl90IHRhcmdldDsKPiA+ICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBwYWdlczsKPiA+Cj4gPiArICAgICAgICAgICAgIGlmICghKG1kLT50eXBlICYgKEVG
SV9DT05WRU5USU9OQUxfTUVNT1JZIHx8IEVGSV9QRVJTSVNURU5UX01FTU9SWSkpKQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ID4gKwo+ID4gICAgICAgICAgICAgICBpZiAo
dG90YWxfbWlycm9yZWRfc2xvdHMgPiAwICYmCj4gPiAgICAgICAgICAgICAgICAgICAhKG1kLT5h
dHRyaWJ1dGUgJiBFRklfTUVNT1JZX01PUkVfUkVMSUFCTEUpKQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOwo+Cj4gQlIsIEphcmtrbwo+CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
