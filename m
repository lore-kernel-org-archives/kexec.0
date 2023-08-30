Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8391C83F01
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=49T9v1fGKBtXj8YaW3U3i2VI5CwQWqow0/FZNOy6pDY=; b=VBF/w3onfNXQdZ
	vqde8wk9zJnGB6jAsHswywEffaBK4zOqkaJ1EbFOHQDZt3aHEEchE/7eFJmBdjRryQcU4onZrXAq8
	IJI3p1xqqlDHpWOAYlxMsvK9VVlPlpPgJjew1v9aTV+HKkj9vRz+CdYTWb6nxFhGSJ81hYxH5TDpY
	FzT7gghifxK+g7Ks+bUKfsYJrVMNLdSFE1eON4dU7Gmuo5U0+VeOJy+75BE52jSQbsNZ1qGjw8+iE
	lenkUiT1/SX2h8+1mUcTFgHh49nFx2VHVjFifrhd+bVGrxYAlLL6Ms2VownzpQzAlXxG3iTrbbCuO
	uHHcrkX1rRG8yndeVuwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbMCd-00DfoH-0x;
	Wed, 30 Aug 2023 14:29:51 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbMCa-00Dfnd-1q
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 14:29:49 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5738cb00eebso1903759eaf.2
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693405786; x=1694010586; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlttlEDqW9alqjgAxWGl4jxgD1Wge7MwJD361d8FLtw=;
        b=qM9GBwuU17IpFzkgaNGpomHf1SE9P2XOD7JER9jRNV1tCjOT5XLkZBlKHTTqDs4+uV
         gZ6jtXZZh2RTyhVm+5VOaIwxuCYD2saoJ/p+Ugh397A121dW7yppsyodO25EWoR8CZJh
         +T5yEKedGdB6coJPMXQT/NpLjuGPqRpqpNUqxwVEveSWfwrP6LyZ8a8SH61GlsgaDXrG
         93CXJ60kBHYt3UFp+dF25npn9K/td2nLNNiABYJ2Oy/kd0Nz8NiQy3O1IggjDnegE1yW
         v4GimvZJLOxfLOqL34x1aLNjEVM3TjTpoigr9eKucxs4ILbyK+fSYxYJMHeI9vgmG7AX
         Sw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405786; x=1694010586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlttlEDqW9alqjgAxWGl4jxgD1Wge7MwJD361d8FLtw=;
        b=kS7no4SJb9REf8Vkk4IM3cxZt0z1VcFYHAH4bXTABpQCe6B8lxIiukj+TZT1THK9qd
         OwqBk47727PM4k4k8jHtlKKsREkl5ATDnFLVbN0cNkX8y5CfbZNNllueICjD4IIfvm9a
         DgSN5+Dnqac4CL06YOM1EtRkXpyBOiwZc5EbZj0HULTaeY6P+ZUi4MpdnEb3aWo4bIOj
         mi42MQLOe3+hFMDUzTK9ojxqtzEFcRLdCdbviOPfgBFP7+/hwbfPtRWdd40b1C6qLVwx
         +qv1vtUPsg2/PnYgrXjQVmEqByH3D7OAcm1mWpSjrjfWursimdmsbEm3QNcYD2m2Dmp0
         Et7A==
X-Gm-Message-State: AOJu0YyipblJRx+JhazYi8kSMfexlFg0xCey0Ysu4GyIt0kgNSCvHOap
	5XbH5+paiehqM+tMYF7h7PB5vA0M2Oqg6GGezj4=
X-Google-Smtp-Source: AGHT+IHJoeozkJNRqDb9wU0X9eZUS4CXC4PL8HeApeKCunqAEMeImyi5O69r6+qX4aHDquXPNOTkCV+WuexgXtraVp4=
X-Received: by 2002:a4a:3906:0:b0:56d:2229:5f94 with SMTP id
 m6-20020a4a3906000000b0056d22295f94mr2120964ooa.6.1693405786336; Wed, 30 Aug
 2023 07:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com> <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
In-Reply-To: <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Aug 2023 17:29:09 +0300
Message-ID: <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To: pstanner@redhat.com
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, 
	David Disseldorp <ddiss@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, 
	Nick Alcock <nick.alcock@oracle.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, David Airlie <airlied@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_072948_617500_2B25582E 
X-CRM114-Status: GOOD (  26.98  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNToxOeKAr1BNIDxwc3Rhbm5lckByZWRoYXQuY29tPiB3
cm90ZToKPiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTc6MTEgKzAzMDAsIEFuZHkgU2hldmNoZW5r
byB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDQ6NDbigK9QTSBQaGlsaXBwIFN0
YW5uZXIgPHBzdGFubmVyQHJlZGhhdC5jb20+Cj4gPiB3cm90ZToKCj4gPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvc3RyaW5nLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdHJpbmcuaAo+ID4K
PiA+IEknbSB3b25kZXJpbmcgaWYgdGhpcyBoYXMgbm8gc2lkZS1lZmZlY3RzIGFzIHN0cmluZy5o
L3N0cmluZy5jIElJUkMKPiA+IGlzCj4gPiB1c2VkIGFsc28gZm9yIGVhcmx5IHN0YWdlcyB3aGVy
ZSBzb21lIG9mIHRoZSBBUElzIGFyZSBub3QgYXZhaWxhYmxlLgo+ID4KPiA+ID4gQEAgLTYsNiAr
Niw4IEBACj4gPiA+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4gICAgICAgLyogZm9yIHNpemVf
dCAqLwo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5oPiAgICAgIC8qIGZvciBOVUxMICov
Cj4gPiA+ICAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4gICAgICAgLyogZm9yIEUyQklHICovCj4g
PiA+ICsjaW5jbHVkZSA8bGludXgvb3ZlcmZsb3cuaD4gICAgLyogZm9yIGNoZWNrX211bF9vdmVy
ZmxvdygpICovCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+ICAgICAgICAgLyogZm9yIEVS
Ul9QVFIoKSAqLwo+ID4KPiA+IENhbiB3ZSBwcmVzZXJ2ZSBvcmRlciAodG8gc29tZSBleHRlbnQp
Pwo+Cj4gU3VyZS4gSSBqdXN0IHB1dCBpdCB0aGVyZSBzbyB0aGUgY29tbWVudHMgYnVpbGQgYSBj
b25ncnVlbnQgYmxvY2suCj4gV2hpY2ggb3JkZXIgd291bGQgeW91IHByZWZlcj8KCkFscGhhYmV0
aWNhbC4KCmNvbXBpbGVyLmgKZXJyLmgKb3ZlcmZsb3cuaAouLi50aGUgcmVzdCB0aGF0IGlzIGEg
Yml0IHVub3JkZXJlZC4uLgoKPiA+ID4gICNpbmNsdWRlIDxsaW51eC9zdGRhcmcuaD4KPiA+ID4g
ICNpbmNsdWRlIDx1YXBpL2xpbnV4L3N0cmluZy5oPgoKLi4uCgo+ID4gPiArLyoqCj4gPiA+ICsg
KiBtZW1kdXBfYXJyYXlfdXNlciAtIGR1cGxpY2F0ZSBhcnJheSBmcm9tIHVzZXIgc3BhY2UKPiA+
Cj4gPiA+ICsgKgo+ID4KPiA+IERvIHdlIG5lZWQgdGhpcyBibGFuayBsaW5lPwo+Cj4gSSBtb3Jl
IG9yIGxlc3MgZGlyZWN0bHkgY29waWVkIHRoZSBkb2NzdHJpbmcgZm9ybWF0IGZyb20gdGhlIG9y
aWdpbmFsCj4gZnVuY3Rpb25zICh2KW1lbWR1cF91c2VyKCkgaW4gbW0vdXRpbC5jCj4gSSBndWVz
cyB0aGlzIGlzIGNvbW1vbiBzdHlsZT8KCkkgdGhpbmsgaXQncyBub3QuIEJ1dCB5b3UgbWF5IGdy
ZXAga2VybmVsIHNvdXJjZSB0cmVlIGFuZCB0ZWxsIHdoaWNoCm9uZSBvY2N1cnMgbW9yZSBvZnRl
biB3aXRoIG9yIHdpdGhvdXQgdGhpcyAodW5uZWVkZWQpIGJsYW5rIGxpbmUuCgo+ID4gPiArICog
QHNyYzogc291cmNlIGFkZHJlc3MgaW4gdXNlciBzcGFjZQo+ID4gPiArICogQG46IG51bWJlciBv
ZiBhcnJheSBtZW1iZXJzIHRvIGNvcHkKPiA+ID4gKyAqIEBzaXplOiBzaXplIG9mIG9uZSBhcnJh
eSBtZW1iZXIKPiA+ID4gKyAqCj4gPiA+ICsgKiBSZXR1cm46IGFuIEVSUl9QVFIoKSBvbiBmYWls
dXJlLiAgUmVzdWx0IGlzIHBoeXNpY2FsbHkKPiA+ID4gKyAqIGNvbnRpZ3VvdXMsIHRvIGJlIGZy
ZWVkIGJ5IGtmcmVlKCkuCj4gPiA+ICsgKi8KCi4uLgoKPiA+ID4gKy8qKgo+ID4gPiArICogdm1l
bWR1cF9hcnJheV91c2VyIC0gZHVwbGljYXRlIGFycmF5IGZyb20gdXNlciBzcGFjZQo+ID4KPiA+
ID4gKyAqCj4gPgo+ID4gUmVkdW5kYW50Pwo+Cj4gTm8sIHRoZXJlIGFyZSB0d28gZnVuY3Rpb25z
Ogo+ICAqIG1lbWR1cF9hcnJheV91c2VyKCkKPiAgKiB2bWVtZHVwX2FycmF5X3VzZXIoKQo+Cj4g
T24gdGhlIGRlZXBlciBsYXllcnMgdGhleSB1dGlsaXplIGttYWxsb2MoKSBvciBrdm1hbGxvYygp
LAo+IHJlc3BlY3RpdmVseS4KCkkgZ3Vlc3MgeW91IG1pc3VuZGVyc3Rvb2QgbXkgY29tbWVudC4g
SSB3YXMgdGFsa2luZyBhYm91dCBrZXJuZWwgZG9jCihhcyBpbiB0aGUgcHJldmlvdXMgZnVuY3Rp
b24pLgoKPiA+ID4gKyAqIEBzcmM6IHNvdXJjZSBhZGRyZXNzIGluIHVzZXIgc3BhY2UKPiA+ID4g
KyAqIEBuOiBudW1iZXIgb2YgYXJyYXkgbWVtYmVycyB0byBjb3B5Cj4gPiA+ICsgKiBAc2l6ZTog
c2l6ZSBvZiBvbmUgYXJyYXkgbWVtYmVyCj4gPiA+ICsgKgo+ID4gPiArICogUmV0dXJuOiBhbiBF
UlJfUFRSKCkgb24gZmFpbHVyZS4gIFJlc3VsdCBtYXkgYmUgbm90Cj4gPiA+ICsgKiBwaHlzaWNh
bGx5IGNvbnRpZ3VvdXMuICBVc2Uga3ZmcmVlKCkgdG8gZnJlZS4KPiA+ID4gKyAqLwoKCi0tIApX
aXRoIEJlc3QgUmVnYXJkcywKQW5keSBTaGV2Y2hlbmtvCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
