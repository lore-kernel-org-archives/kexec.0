Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B127C83F10
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SnPs7ZkM3UW4jjTGczb0XLyL73PCmp547Di4/CfnmBU=; b=qWe6SjnYYXiJvs
	nYoolWbnKY4vVIbZ6ttM4Q10jMzBarO+GI5a7ZZoN8gmRnj3CX49Gtzz4cSMAq64T7FRtmJTI+zxn
	QpoNkRjajk9tPInr5qc75Do61lsVWt5AuteJ1rsg0rZuv+WQkR7BAkLBcbQR/YP8UF3UPxYnKKYg8
	/GdM+Xf4YCaITjjErfLeEij8oIhAeyBYX+4aC6oT8TnDyBVVxWcw8YffllD/cYVCuulf5hGmAg0N5
	7CGc7oGumco2OHxwyWObRakpUjCWxPpd3gLXg7+JGmAeCqnLeWLnBpUPhmXiiEOYwri2+jP2f865J
	dCU8yiMWtXc4CqfCsa5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbdWt-00Ev5U-00;
	Thu, 31 Aug 2023 08:59:55 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbdWq-00Ev4T-0m
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 08:59:53 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5738cb00eebso369874eaf.2
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472391; x=1694077191; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WCBkbdNR2D/dn3x6jAE+/xbR9io7eSmxn1U8tK6k34=;
        b=kUEK5SF2fhbTcBbDV1M6v2aCm5kcFByU8IbuiUTHBsxZkLRkw+qxGG6kJKs8vMLivD
         mWFDGrahdC2OmEwCQ/frJvmP0M/dkK4RrxFXoGEjOO3IbrDLrWUsKVSGcwCbHhVYwYyn
         bIkkk1CTop6KysIu60wPIofDy+ilJHsP2P9R7SLwCid5BCnW6U6woyUzPRkDoLCWYGKd
         QFFfxMBSkE1Cbl+Lf+otk++L2zvMCcFlZsYcRQuRxpdOFUkusWVW5Q/ioW2LPeu2uR6t
         mFgrD7nnfQYbNUN2SGsp1FJ+V0Uoi6UOoKjowpLfFd8IvvCIc3IyS9duhoHBc9U2ZUH5
         n/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472391; x=1694077191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WCBkbdNR2D/dn3x6jAE+/xbR9io7eSmxn1U8tK6k34=;
        b=NS1GcCmxMXw0s6YwCrdPy6fUcicis51awG7mSCjCWJ2LQJQ71x3e889AIJvKpYuhu/
         0ubdI8rA1M9EfFv6X4UCd6rahp2R6CNfft7RricjLpikrGbYS9dIGjwTrfuiMZ5GR7wY
         VQ8IcBe/2m3zpJddVoyMLguUGQyigDJKVsliMrraTFxn9eQiDD80CAISm1KDb6FrnbTl
         Bp2iILA96hX59y73ji7FVcY58mHAgm+jFKD7hsT6vmli3YNOBV5kEVbejy4PL4N4XBw4
         8o3UluyJZBRPc/AwqVmQB1IgwKUUmx6z8qOIkzh5f0B0Eyf0EXHuUOwHIOV227FBhc7p
         0F7w==
X-Gm-Message-State: AOJu0YwWAvoUVx8XUthtzj5XRGrx9OxL4TZvFY3JBFsNKKtFSXetWu+q
	6c2DbQSLTbLi8i+botBbr4LC7WXJG3QUfGBZ87s=
X-Google-Smtp-Source: AGHT+IHD40W+0VPJ3vNndBJ9GxsD1cpYZQwMg37odmvA2L5FhdqLghEG+N8XXu1zSL+1GhjtspeZlpQR10ud8jErSAU=
X-Received: by 2002:a4a:2a52:0:b0:573:3711:51c4 with SMTP id
 x18-20020a4a2a52000000b00573371151c4mr4288732oox.8.1693472390851; Thu, 31 Aug
 2023 01:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
 <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
 <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com> <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
In-Reply-To: <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 Aug 2023 11:59:14 +0300
Message-ID: <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230831_015952_277350_D7C5CEC0 
X-CRM114-Status: GOOD (  33.83  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgMTA6MTXigK9QTSA8cHN0YW5uZXJAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gT24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjI5ICswMzAwLCBBbmR5IFNoZXZjaGVu
a28gd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA1OjE54oCvUE0gPHBzdGFubmVy
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTc6MTEgKzAz
MDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBh
dCA0OjQ24oCvUE0gUGhpbGlwcCBTdGFubmVyCj4gPiA+ID4gPHBzdGFubmVyQHJlZGhhdC5jb20+
Cj4gPiA+ID4gd3JvdGU6CgouLi4KCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
ICAgICAgIC8qIGZvciBzaXplX3QgKi8KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvc3RkZGVm
Lmg+ICAgICAgLyogZm9yIE5VTEwgKi8KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvZXJybm8u
aD4gICAgICAgLyogZm9yIEUyQklHICovCj4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L292ZXJm
bG93Lmg+ICAgIC8qIGZvciBjaGVja19tdWxfb3ZlcmZsb3coKSAqLwo+ID4gPiA+ID4gKyNpbmNs
dWRlIDxsaW51eC9lcnIuaD4gICAgICAgICAvKiBmb3IgRVJSX1BUUigpICovCj4gPiA+ID4KPiA+
ID4gPiBDYW4gd2UgcHJlc2VydmUgb3JkZXIgKHRvIHNvbWUgZXh0ZW50KT8KPiA+ID4KPiA+ID4g
U3VyZS4gSSBqdXN0IHB1dCBpdCB0aGVyZSBzbyB0aGUgY29tbWVudHMgYnVpbGQgYSBjb25ncnVl
bnQgYmxvY2suCj4gPiA+IFdoaWNoIG9yZGVyIHdvdWxkIHlvdSBwcmVmZXI/Cj4gPgo+ID4gQWxw
aGFiZXRpY2FsLgo+ID4KPiA+IGNvbXBpbGVyLmgKPiA+IGVyci5oCj4gPiBvdmVyZmxvdy5oCj4g
PiAuLi50aGUgcmVzdCB0aGF0IGlzIGEgYml0IHVub3JkZXJlZC4uLgo+ID4KPiA+ID4gPiA+ICAj
aW5jbHVkZSA8bGludXgvc3RkYXJnLmg+Cj4gPiA+ID4gPiAgI2luY2x1ZGUgPHVhcGkvbGludXgv
c3RyaW5nLmg+Cj4KPiBJIG1lYW4gSSBjb3VsZCBpbmNsdWRlIG15IG93biBpbiBhIHNvcnRlZCBt
YW5uZXIg4oCTIGJ1dCB0aGUgZXhpc3RpbmcKPiBvbmVzIGFyZSBub3Qgc29ydGVkOgoKSSBrbm93
LCB0aGF0J3Mgd2h5IEkgcHV0ICIodG8gc29tZSBleHRlbnQpIiBpbiBteSBpbml0aWFsIGNvbW1l
bnQuCgo+IFdlIGNvdWxkIHNvcnQgdGhlbSBhbGwsIGJ1dCBJJ2QgcHJlZmVyIHRvIGRvIHRoYXQg
aW4gYSBzZXBhcmF0ZSBwYXRjaAo+IHNvIHRoYXQgdGhpcyBjb21taXQgZG9lcyBub3QgbWFrZSB0
aGUgaW1wcmVzc2lvbiBvZiBkb2luZyBhbnl0aGluZyBlbHNlCj4gdGhhbiBpbmNsdWRpbmcgdGhl
IHR3byBuZXcgaGVhZGVycwoKQnV0IHlvdSBjYW4gZG8geW91ciBzdHVmZiBmaXJzdCB3aXRoIGJl
dHRlciBvcmRlcmluZyB0aGFuIHlvdSBwcm9wb3NlZAppbml0aWFsbHksIHNvIHRoZXJlIHdpbGwg
YmUgbGVzcyBjaHVybiBmb3IgYW55IGFkZGl0aW9uYWwgY2hhbmdlCihlaXRoZXIgdGhhdCBzaW1w
bHkgdW5pZmllcyB0aGUgdGhpbmcgb3Igc29tZXRoaW5nIGVsc2UpLgoKPiBTdWNoIGEgc2VwYXJh
dGUgcGF0Y2ggY291bGQgYWxzbyB1bmlmeSB0aGUgZG9jc3RyaW5nIHN0eWxlLCBzZWUgYmVsb3cK
ClN1cmUsIHBhdGNoZXMgYXJlIHdlbGNvbWUhCgo+ID4gPiA+ID4gKy8qKgo+ID4gPiA+ID4gKyAq
IG1lbWR1cF9hcnJheV91c2VyIC0gZHVwbGljYXRlIGFycmF5IGZyb20gdXNlciBzcGFjZQo+ID4g
PiA+Cj4gPiA+ID4gPiArICoKPiA+ID4gPgo+ID4gPiA+IERvIHdlIG5lZWQgdGhpcyBibGFuayBs
aW5lPwo+ID4gPgo+ID4gPiBJIG1vcmUgb3IgbGVzcyBkaXJlY3RseSBjb3BpZWQgdGhlIGRvY3N0
cmluZyBmb3JtYXQgZnJvbSB0aGUKPiA+ID4gb3JpZ2luYWwKPiA+ID4gZnVuY3Rpb25zICh2KW1l
bWR1cF91c2VyKCkgaW4gbW0vdXRpbC5jCj4gPiA+IEkgZ3Vlc3MgdGhpcyBpcyBjb21tb24gc3R5
bGU/Cj4gPgo+ID4gSSB0aGluayBpdCdzIG5vdC4gQnV0IHlvdSBtYXkgZ3JlcCBrZXJuZWwgc291
cmNlIHRyZWUgYW5kIHRlbGwgd2hpY2gKPiA+IG9uZSBvY2N1cnMgbW9yZSBvZnRlbiB3aXRoIG9y
IHdpdGhvdXQgdGhpcyAodW5uZWVkZWQpIGJsYW5rIGxpbmUuCj4KPgo+IEl0IHNlZW1zIHRvIGJl
IHZlcnkgbXVjaCBtaXhlZC4gc3RyaW5nLmggaXRzZWxmIGlzIG1peGVkLgo+IFdoZW4geW91IGxv
b2sgYXQgdGhlIGJvdHRvbSBvZiBzdHJpbmcuaCwgeW91J2xsIGZpbmQgZnVuY3Rpb25zIHN1Y2gg
YXMKPiBrYmFzZW5hbWUoKSB0aGF0IGhhdmUgdGhlIGV4dHJhIGxpbmUuCj4KPiBUaGF0J3Mgbm90
IHJlYWxseSBhIHN1cGVyIGRlY2lzaXZlIHBvaW50IGZvciBtZSwgdGhvdWdoLiBXZSBjYW4gcmVt
b3ZlCj4gdGhlIGxpbmUgSSBndWVzcwoKSSB0aGluayB0aGUgbGVzcyBMb0NzIHRoZSBiZXR0ZXIg
Z2VuZXJhbGx5IHNwZWFraW5nLiBTbywgaWYgd2UgZG9uJ3QKbmVlZCB0aGF0IGxpbmUgYW5kIGl0
IGRvZXNuJ3QgbWFrZSB0aGUgcmVhZGFiaWxpdHkgd29yc2UsIHdoeSB0byBrZWVwCml0PwoKPiA+
ID4gPiA+ICsgKiBAc3JjOiBzb3VyY2UgYWRkcmVzcyBpbiB1c2VyIHNwYWNlCj4gPiA+ID4gPiAr
ICogQG46IG51bWJlciBvZiBhcnJheSBtZW1iZXJzIHRvIGNvcHkKPiA+ID4gPiA+ICsgKiBAc2l6
ZTogc2l6ZSBvZiBvbmUgYXJyYXkgbWVtYmVyCj4gPiA+ID4gPiArICoKPiA+ID4gPiA+ICsgKiBS
ZXR1cm46IGFuIEVSUl9QVFIoKSBvbiBmYWlsdXJlLiAgUmVzdWx0IGlzIHBoeXNpY2FsbHkKPiA+
ID4gPiA+ICsgKiBjb250aWd1b3VzLCB0byBiZSBmcmVlZCBieSBrZnJlZSgpLgo+ID4gPiA+ID4g
KyAqLwoKLS0KV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
