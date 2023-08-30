Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E7FC6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hdK74eTfV16mU6MXG+Ka2mgtbwVS1ewy6jCD4GFJ4zc=; b=tGXVGRa+WsKddl
	bXJ5+xRxCHg3OttWPwe6+62EU9q3LYM3CBoSniNJrISffFMAcG7bG5cz95fcolyL268tUFiEvd/un
	cq2IJbOgbrehGcUd/WxgVl7nNUJ0Bb3cuwpqdnv3JKBO+b89ob9sPzXt3yeWe594MLEJ9gPdV6P6i
	Zoi04Ko99RZjo6QmBcQdT/AWADoscgB9iuU1yD+uV7lI1fcKEiwxuqsDpDjVd0vXgQB07lcfueGnQ
	pP4fo4Bi4rvFHDF+clUopXJ2swm9GS53hFjcK7FHrwtJylH76qcX7z/NgO7SxhY/9tnBDmha2OZln
	yD3NhDJiYzrq3bbiud1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbQfD-00E3dQ-02;
	Wed, 30 Aug 2023 19:15:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbQf9-00E3cX-2h
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 19:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693422933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTsZyqKXCjKhOJ70mLm50QiCTy9IG31Ajtx/kBK1zM0=;
	b=hsdV9Rojq19g8YIl7kK4BjZoYNqqOYyWxyGaUJWNdSuQ+7z7/SlIcd8etfS2DVEhLt0QHh
	cmFeXsRyXJXPQshHsyP71KHmhENFXpWhboYNWMpXcxr2LkJ59GTmZdqpwEl9AujITpsjsT
	xhenGIk3y8msAG6zkehAK2tcSnjKr68=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-M7oWe-q1Mo2pssXQ9Yi9lw-1; Wed, 30 Aug 2023 15:15:31 -0400
X-MC-Unique: M7oWe-q1Mo2pssXQ9Yi9lw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso98157966b.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 12:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422930; x=1694027730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBV0HnyI31Hv2AWMsxadgPSfaYJpOZDq2RNuu2t2Z+8=;
        b=hSZz91nPYLxVXEfa4oU2kowMWw+jHm9hrg8XLBQ4xuNXZomfOAk3Gog4ACdrv41ji4
         jR18oFQ9Y31Pnrq0dMkeqkJikXQ00qgajfYUgEMH1MYcwVb1XuqbHHFCTBTud4CMJ9tc
         nrUpximvCzCJFOLt2IxB8pnPutf13QgDzXG9GujksqwXPrKjFKNh0VcvjDGgzBXTNe/N
         gVO1mU5pwre97FlmXbY9pGKzTXEFDtzTjJYkKhtPKH+ifZ7GSY1gy5CY/g4FxR7+fONh
         vcM/BlmDDsDl2bSecuJoIVS9vfTLCp4popKZsNlnATLVJqMjUOBoTFg0r2ncp6oL5ee8
         uXdw==
X-Gm-Message-State: AOJu0YyIXhjmNi2Kfg62ZKuAQfuHYex9d725iH4QeFL/rGwOqRbp1le6
	tJmq0Sst8XNw2pQOyrL2jXfDuCcV3GH5ke93nNHeEqeFRg50cyn8WF+Gh4Bp27Ka+hDPt45mWze
	og1Bnjy0Lt5PgnqwahTMb
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290536edd.4.1693422930292;
        Wed, 30 Aug 2023 12:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjUvAuvkykbuXvqA8bQi1z8q8Gj4+iVBJgsW7l3Dh0c5JlqxFhMaKRno+cvmE8+cDwXXn9mg==
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290516edd.4.1693422929985;
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b0052a198d8a4dsm7116533edq.52.2023.08.30.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Message-ID: <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From: pstanner@redhat.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
 Eric Biederman <ebiederm@xmission.com>, Christian Brauner
 <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>,  Luis Chamberlain
 <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, Nick Alcock
 <nick.alcock@oracle.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>, VMware
 Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,  linux-hardening@vger.kernel.org, David Airlie
 <airlied@redhat.com>
Date: Wed, 30 Aug 2023 21:15:28 +0200
In-Reply-To: <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
	 <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
	 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
	 <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
	 <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_121535_968629_5A288D14 
X-CRM114-Status: GOOD (  35.24  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjI5ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNToxOeKAr1BNIDxwc3Rhbm5lckByZWRoYXQuY29t
PiB3cm90ZToKPiA+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxNzoxMSArMDMwMCwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA0OjQ24oCvUE0gUGhp
bGlwcCBTdGFubmVyCj4gPiA+IDxwc3Rhbm5lckByZWRoYXQuY29tPgo+ID4gPiB3cm90ZToKPiAK
PiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N0cmluZy5oCj4gPiA+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9zdHJpbmcuaAo+ID4gPiAKPiA+ID4gSSdtIHdvbmRlcmluZyBpZiB0aGlzIGhhcyBu
byBzaWRlLWVmZmVjdHMgYXMgc3RyaW5nLmgvc3RyaW5nLmMKPiA+ID4gSUlSQwo+ID4gPiBpcwo+
ID4gPiB1c2VkIGFsc28gZm9yIGVhcmx5IHN0YWdlcyB3aGVyZSBzb21lIG9mIHRoZSBBUElzIGFy
ZSBub3QKPiA+ID4gYXZhaWxhYmxlLgo+ID4gPiAKPiA+ID4gPiBAQCAtNiw2ICs2LDggQEAKPiA+
ID4gPiDCoCNpbmNsdWRlIDxsaW51eC90eXBlcy5oPsKgwqDCoMKgwqDCoCAvKiBmb3Igc2l6ZV90
ICovCj4gPiA+ID4gwqAjaW5jbHVkZSA8bGludXgvc3RkZGVmLmg+wqDCoMKgwqDCoCAvKiBmb3Ig
TlVMTCAqLwo+ID4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+wqDCoMKgwqDCoMKgIC8q
IGZvciBFMkJJRyAqLwo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb3ZlcmZsb3cuaD7CoMKgwqAg
LyogZm9yIGNoZWNrX211bF9vdmVyZmxvdygpICovCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9l
cnIuaD7CoMKgwqDCoMKgwqDCoMKgIC8qIGZvciBFUlJfUFRSKCkgKi8KPiA+ID4gCj4gPiA+IENh
biB3ZSBwcmVzZXJ2ZSBvcmRlciAodG8gc29tZSBleHRlbnQpPwo+ID4gCj4gPiBTdXJlLiBJIGp1
c3QgcHV0IGl0IHRoZXJlIHNvIHRoZSBjb21tZW50cyBidWlsZCBhIGNvbmdydWVudCBibG9jay4K
PiA+IFdoaWNoIG9yZGVyIHdvdWxkIHlvdSBwcmVmZXI/Cj4gCj4gQWxwaGFiZXRpY2FsLgo+IAo+
IGNvbXBpbGVyLmgKPiBlcnIuaAo+IG92ZXJmbG93LmgKPiAuLi50aGUgcmVzdCB0aGF0IGlzIGEg
Yml0IHVub3JkZXJlZC4uLgo+IAo+ID4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3N0ZGFyZy5oPgo+
ID4gPiA+IMKgI2luY2x1ZGUgPHVhcGkvbGludXgvc3RyaW5nLmg+Cj4gCj4gLi4uCgpJIG1lYW4g
SSBjb3VsZCBpbmNsdWRlIG15IG93biBpbiBhIHNvcnRlZCBtYW5uZXIg4oCTIGJ1dCB0aGUgZXhp
c3RpbmcKb25lcyBhcmUgbm90IHNvcnRlZDoKCi8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovCiNpZm5kZWYgX0xJTlVYX1NUUklOR19IXwojZGVmaW5lIF9MSU5VWF9TVFJJTkdf
SF8KCiNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPgkvKiBmb3IgaW5saW5lICovCiNpbmNsdWRl
IDxsaW51eC90eXBlcy5oPgkvKiBmb3Igc2l6ZV90ICovCiNpbmNsdWRlIDxsaW51eC9zdGRkZWYu
aD4JLyogZm9yIE5VTEwgKi8KI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+CS8qIGZvciBFMkJJRyAq
LwojaW5jbHVkZSA8bGludXgvc3RkYXJnLmg+CiNpbmNsdWRlIDx1YXBpL2xpbnV4L3N0cmluZy5o
PgoKZXh0ZXJuIGNoYXIgKnN0cm5kdXBfdXNlcihjb25zdCBjaGFyIF9fdXNlciAqLCBsb25nKTsK
CldlIGNvdWxkIHNvcnQgdGhlbSBhbGwsIGJ1dCBJJ2QgcHJlZmVyIHRvIGRvIHRoYXQgaW4gYSBz
ZXBhcmF0ZSBwYXRjaApzbyB0aGF0IHRoaXMgY29tbWl0IGRvZXMgbm90IG1ha2UgdGhlIGltcHJl
c3Npb24gb2YgZG9pbmcgYW55dGhpbmcgZWxzZQp0aGFuIGluY2x1ZGluZyB0aGUgdHdvIG5ldyBo
ZWFkZXJzCgpTdWNoIGEgc2VwYXJhdGUgcGF0Y2ggY291bGQgYWxzbyB1bmlmeSB0aGUgZG9jc3Ry
aW5nIHN0eWxlLCBzZWUgYmVsb3cKCj4gCj4gPiA+ID4gKy8qKgo+ID4gPiA+ICsgKiBtZW1kdXBf
YXJyYXlfdXNlciAtIGR1cGxpY2F0ZSBhcnJheSBmcm9tIHVzZXIgc3BhY2UKPiA+ID4gCj4gPiA+
ID4gKyAqCj4gPiA+IAo+ID4gPiBEbyB3ZSBuZWVkIHRoaXMgYmxhbmsgbGluZT8KPiA+IAo+ID4g
SSBtb3JlIG9yIGxlc3MgZGlyZWN0bHkgY29waWVkIHRoZSBkb2NzdHJpbmcgZm9ybWF0IGZyb20g
dGhlCj4gPiBvcmlnaW5hbAo+ID4gZnVuY3Rpb25zICh2KW1lbWR1cF91c2VyKCkgaW4gbW0vdXRp
bC5jCj4gPiBJIGd1ZXNzIHRoaXMgaXMgY29tbW9uIHN0eWxlPwo+IAo+IEkgdGhpbmsgaXQncyBu
b3QuIEJ1dCB5b3UgbWF5IGdyZXAga2VybmVsIHNvdXJjZSB0cmVlIGFuZCB0ZWxsIHdoaWNoCj4g
b25lIG9jY3VycyBtb3JlIG9mdGVuIHdpdGggb3Igd2l0aG91dCB0aGlzICh1bm5lZWRlZCkgYmxh
bmsgbGluZS4KCgpJdCBzZWVtcyB0byBiZSB2ZXJ5IG11Y2ggbWl4ZWQuIHN0cmluZy5oIGl0c2Vs
ZiBpcyBtaXhlZC4KV2hlbiB5b3UgbG9vayBhdCB0aGUgYm90dG9tIG9mIHN0cmluZy5oLCB5b3Un
bGwgZmluZCBmdW5jdGlvbnMgc3VjaCBhcwprYmFzZW5hbWUoKSB0aGF0IGhhdmUgdGhlIGV4dHJh
IGxpbmUuCgpUaGF0J3Mgbm90IHJlYWxseSBhIHN1cGVyIGRlY2lzaXZlIHBvaW50IGZvciBtZSwg
dGhvdWdoLiBXZSBjYW4gcmVtb3ZlCnRoZSBsaW5lIEkgZ3Vlc3MKCgpQLgoKCj4gCj4gPiA+ID4g
KyAqIEBzcmM6IHNvdXJjZSBhZGRyZXNzIGluIHVzZXIgc3BhY2UKPiA+ID4gPiArICogQG46IG51
bWJlciBvZiBhcnJheSBtZW1iZXJzIHRvIGNvcHkKPiA+ID4gPiArICogQHNpemU6IHNpemUgb2Yg
b25lIGFycmF5IG1lbWJlcgo+ID4gPiA+ICsgKgo+ID4gPiA+ICsgKiBSZXR1cm46IGFuIEVSUl9Q
VFIoKSBvbiBmYWlsdXJlLsKgIFJlc3VsdCBpcyBwaHlzaWNhbGx5Cj4gPiA+ID4gKyAqIGNvbnRp
Z3VvdXMsIHRvIGJlIGZyZWVkIGJ5IGtmcmVlKCkuCj4gPiA+ID4gKyAqLwo+IAo+IC4uLgo+IAo+
ID4gPiA+ICsvKioKPiA+ID4gPiArICogdm1lbWR1cF9hcnJheV91c2VyIC0gZHVwbGljYXRlIGFy
cmF5IGZyb20gdXNlciBzcGFjZQo+ID4gPiAKPiA+ID4gPiArICoKPiA+ID4gCj4gPiA+IFJlZHVu
ZGFudD8KPiA+IAo+ID4gTm8sIHRoZXJlIGFyZSB0d28gZnVuY3Rpb25zOgo+ID4gwqAqIG1lbWR1
cF9hcnJheV91c2VyKCkKPiA+IMKgKiB2bWVtZHVwX2FycmF5X3VzZXIoKQo+ID4gCj4gPiBPbiB0
aGUgZGVlcGVyIGxheWVycyB0aGV5IHV0aWxpemUga21hbGxvYygpIG9yIGt2bWFsbG9jKCksCj4g
PiByZXNwZWN0aXZlbHkuCj4gCj4gSSBndWVzcyB5b3UgbWlzdW5kZXJzdG9vZCBteSBjb21tZW50
LiBJIHdhcyB0YWxraW5nIGFib3V0IGtlcm5lbCBkb2MKPiAoYXMgaW4gdGhlIHByZXZpb3VzIGZ1
bmN0aW9uKS4KPiAKPiA+ID4gPiArICogQHNyYzogc291cmNlIGFkZHJlc3MgaW4gdXNlciBzcGFj
ZQo+ID4gPiA+ICsgKiBAbjogbnVtYmVyIG9mIGFycmF5IG1lbWJlcnMgdG8gY29weQo+ID4gPiA+
ICsgKiBAc2l6ZTogc2l6ZSBvZiBvbmUgYXJyYXkgbWVtYmVyCj4gPiA+ID4gKyAqCj4gPiA+ID4g
KyAqIFJldHVybjogYW4gRVJSX1BUUigpIG9uIGZhaWx1cmUuwqAgUmVzdWx0IG1heSBiZSBub3QK
PiA+ID4gPiArICogcGh5c2ljYWxseSBjb250aWd1b3VzLsKgIFVzZSBrdmZyZWUoKSB0byBmcmVl
Lgo+ID4gPiA+ICsgKi8KPiAKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
