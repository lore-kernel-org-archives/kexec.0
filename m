Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B06C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NoUfjvXDCoHtz6ky8/st6GrdFx1i/53vAC/uwmIiTU8=; b=LrNa2R9gdY/1hF
	qdtVQqT9DZrnZ/6AirUx0oMm+g+A3RVo3g22usy9BZA+xXE4ny8wTenXXMhTSSFyxXY3QRvMi1egL
	ZqR3ecvvt4BkvRiO9tfCESvlgPWxaErteKrzAuNpSLKuq90BxT3c9hcuHoHf8jU4rv+Zrvg4Kl079
	APi9S22TvIr55Om/XCCxakpUy6bSAgRV5FfchhnPv/93z22lwwObelTqvJRdvioFaoEGYJ7VVV8i2
	g0dCbLcQWKAUqr87XTkjW1Q6u9KS1VrSxdQkQxkzroUJ6EolA8rwjNngh2Sd//0EGsaD3dwqSJ0yD
	RXTOVTrmKeubY2WvN2Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6OJ-0000000Cegx-02Yy;
	Thu, 22 Aug 2024 11:54:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6OG-0000000Ceg7-1MZi
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 11:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724327645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMkA4XTW/po1kh224V+jp2a5m/4eGmuH04I4L7heXb4=;
	b=EsHPa6S5QD8YpAPNQuG3OjiU6uI4WPYCg8DAbZPAc+45mrw9G5KAd574Yf/9sfrun0zopL
	0btVazm8XgHF1ANqMP29zoM7pT2jlJI122qHlizs6Q/pYyEPfkfgtnbIC/qaG47N7zBD6w
	zNKx0DuAtAgn2G8KjNiOmBrAjlxXAQI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-r4_pLPbSMuGVvz1NXYBWmw-1; Thu, 22 Aug 2024 07:54:03 -0400
X-MC-Unique: r4_pLPbSMuGVvz1NXYBWmw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2021be03c53so7738545ad.3
        for <kexec@lists.infradead.org>; Thu, 22 Aug 2024 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327643; x=1724932443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMkA4XTW/po1kh224V+jp2a5m/4eGmuH04I4L7heXb4=;
        b=a6Lypy+31bM5qefPmlrbqB+rHBE7/7TMk4FbRXHwFRcqaC+7s94qcIvZS8tQ7kID/i
         Hy6yotETWMGA/qTeiaEn+KUv6hT6iW/tFE1ezf6osZ/PgJpMb4m0n6u1FzlCk/r2BmCW
         PYOC7XlbLgb28WxpOgbsxFixE9K5qFfawlhclimk9Fdq7S6fk89UP9qtEj+q2SuYIqLA
         nT0yQjJtl3CxQkqZzmBOOzWusXMWkCErMfHDEiDx5UNDfFjDG1rSBhFefyBE32tcsNRD
         Ybo3BfUQeSZS1YMpcihxMbN8Q3npj5eKNnl56M2OxBLU30BFyE3lOVb+wCD0T+tyy5Ig
         6pZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7jOmv0tM/alkFECOeRcqCazqL90DEJwXsCzPvA1clQoDucmegm+MxroK7owV62UdK6uQ9gw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxXwEU+d+fzmdmoPaZWkisGmLhx5BLTy+GS0u3m22rNAeEC+r4m
	ciXRNWcCkdZnlqPiVKGSp3jCSt73OBO2Es4o0rrOQ7nvS85MPbNgV1q1ULYvPeFrYR5ncoRtPpr
	g9zPdrSXSRL1MiuOkovBjadUeVpLQGwHT0FG0QU1P/f2ZRxkEAkw85YAv28gPEuydoATxS7jGoV
	Nl2o+z928qBtnPWhM18s5Bm/wnLqJrMvLh
X-Received: by 2002:a17:902:e884:b0:202:4666:f02a with SMTP id d9443c01a7336-20388b3c2b1mr15102815ad.43.1724327642737;
        Thu, 22 Aug 2024 04:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqIxoPVl/clLryQj7xWyVLRy3Hsg4AUrm+9Ysi+nMqgTtlGHdBJiaIQ4nEYKjGb/jdpxZULpzyBvbnFMX5EiY=
X-Received: by 2002:a17:902:e884:b0:202:4666:f02a with SMTP id
 d9443c01a7336-20388b3c2b1mr15102615ad.43.1724327642165; Thu, 22 Aug 2024
 04:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com> <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
In-Reply-To: <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 19:54:12 +0800
Message-ID: <CALu+AoRMFRjnp5CB1zyCrEePmqbwoWjpABNmfxRrJA8b9nv9qA@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_045408_467357_28A41380 
X-CRM114-Status: GOOD (  35.27  )
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

T24gVGh1LCAyMiBBdWcgMjAyNCBhdCAxODo1MSwgUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMjoxN+KAr1BNIERhdmUgWW91
bmcgPGR5b3VuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIDIyIEF1ZyAyMDI0
IGF0IDEzOjQyLCBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIFdlZCwgQXVnIDIxLCAyMDI0IGF0IDEwOjI34oCvUE0gTGVubmFydCBQb2V0dGVyaW5n
Cj4gPiA+IDxtenhyZWFyeUAwcG9pbnRlci5kZT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBN
bywgMTkuMDguMjQgMjI6NTMsIFBpbmdmYW4gTGl1IChwaWxpdUByZWRoYXQuY29tKSB3cm90ZToK
PiA+ID4gPgo+ID4gPiA+ID4gKioqIEJhY2tncm91bmQgKioqCj4gPiA+ID4gPgo+ID4gPiA+ID4g
QXMgbW9yZSBQRSBmb3JtYXQga2VybmVsIGltYWdlcyBhcmUgaW50cm9kdWNlZCwgaXQgcG9zdCBj
aGFsbGVuZ2UgdG8ga2V4ZWMgdG8KPiA+ID4gPiA+IGNvcGUgd2l0aCB0aGUgbmV3IGZvcm1hdC4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiBteSBhdHRlbXB0IHRvIGFkZCBzdXBwb3J0IGZvciBhcm02
NCB6Ym9vdCBpbWFnZSBpbiB0aGUga2VybmVsIFsxXSwKPiA+ID4gPiA+IEFyZCBzdWdnZXN0ZWQg
dXNpbmcgYW4gZW11bGF0b3IgdG8gdGFja2xlIHRoaXMgaXNzdWUuICBMYXN0IHllYXIsIHdoZW4K
PiA+ID4gPiA+IEphbiB0cmllZCB0byBpbnRyb2R1Y2UgVUtJIHN1cHBvcnQgaW4gdGhlIGtlcm5l
bCBbMl0sIEFyZCBtZW50aW9uZWQgdGhlCj4gPiA+ID4gPiBlbXVsYXRvciBhcHByb2FjaCBhZ2Fp
biBbM10KPiA+ID4gPgo+ID4gPiA+IEhtbSwgc3lzdGVtZCdzIHN5c3RlbWQtc3R1YiBjb2RlIHRy
aWVzIHRvIGxvYWQgY2VydGFpbiAic2lkZS1jYXIiCj4gPiA+ID4gZmlsZXMgcGxhY2VkIG5leHQg
dG8gdGhlIFVLSSwgdmlhIHRoZSBVRUZJIGZpbGUgc3lzdGVtIEFQSXMuIFdoYXQncwo+ID4gPiA+
IHlvdXIgaW50ZW50aW9uIHdpdGggdGhlIFVFRkkgZW11bGF0b3IgcmVnYXJkaW5nIHRoYXQ/IFRo
ZSBzaWRlY2FycyBhcmUKPiA+ID4gPiBzb21ld2hhdCBpbXBvcnRhbnQsIGJlY2F1c2UgdGhhdCdz
IGhvdyB3ZSBwYXJhbWV0ZXJpemUgb3RoZXJ3aXNlCj4gPiA+ID4gc3RyaWN0bHkgc2VhbGVkLCBp
bW11dGFibGUgVUtJcy4KPiA+ID4gPgo+ID4gPiBJSVVDLCB5b3UgYXJlIHJlZmVycmluZyB0byBV
S0kgYWRkb25zLgo+ID4gPgo+ID4gPiA+IEhlbmNlLCB3aGF0J3MgdGhlIHN0b3J5IHRoZXJlPyBp
bXBsZW1lbnQgc29tZSBmb3JtIG9mIGZzIGRyaXZlciAoZm9yCj4gPiA+ID4gd2hhdCBmcyBwcmVj
aXNlbHk/KSBpbiB0aGUgZW11bGF0b3IgdG9vPwo+ID4gPiA+Cj4gPiA+IEFzIGZvciBhZGRvbiwg
dGhhdCBpcyBhIG1pc3NpbmcgcGFydCBpbiB0aGlzIHNlcmllcy4gSSBoYXZlIG92ZXJsb29rZWQK
PiA+ID4gdGhpcyBpc3N1ZS4gT3JpZ2luYWxseSwgSSB0aG91Z2h0IHRoYXQgdGhlcmUgd2FzIG5v
IG5lZWQgdG8gaW1wbGVtZW50Cj4gPiA+IGEgZGlzayBkcml2ZXIgYW5kIHZmYXQgZmlsZSBzeXN0
ZW0sIGp1c3QgcHJlbG9hZCB0aGVtIGludG8gbWVtb3J5LCBhbmQKPiA+ID4gZmluYWxseSBwcmVz
ZW50IHRoZW0gdGhyb3VnaCB0aGUgdWVmaSBBUEkuIEkgd2lsbCB0YWtlIGEgY2xvc2VyIGxvb2sK
PiA+ID4gYXQgaXQgYW5kIGNoZXcgb24gaXQuCj4gPiA+Cj4gPgo+ID4gSGkgUGluZ2ZhbiwKPiA+
Cj4gPiBJZiBtb3JlIGFuZCBtb3JlIHN0dWZmIG5lZWRzIGNvbWluZyBpbiwgIG5vdCBvbmx5IHRo
ZSBsaW1pdGVkIGJvb3QKPiA+IHNlcnZpY2VzIHRoZW4gaXQgd2lsbCBiZSB3YXkgdG9vIGNvbXBs
aWNhdGVkIGFuZCBoYXJkIHRvIG1haW50YWluIGFuZAo+ID4gZGVidWcsICBhbHNvIHRoZSB0d28g
a2V4ZWMgY29kZSBwYXRocyBhcmUgZHVwbGljYXRlZCBzb21laG93LiBJdCBpcwo+ID4gcmVhbGx5
IGJhZC4uCj4gPgo+IE9LLCBJIHdpbGwgdHJ5IHRvIGtlZXAgdGhpbmdzIGVhc2llci4gQW5kIHdo
YXQgZG8geW91IG1lYW4gYWJvdXQgIiB0d28KPiBrZXhlYyBjb2RlIHBhdGhzIj8KCkkgbWVhbiB3
ZSBoYXZlIHRoZSBFRkkgYW5kIG5vbi1FRkkga2V4ZWMgaW1wbGVtZW50YXRpb24uIEFsc28gZm9y
IHRoZQpFRkkga2V4ZWMgY29kZSBmb3IgWDg2IHRoZXJlIGlzIHNvbWV0aGluZyB3ZSBwYXNzZWQg
ZnJvbSAxc3Qga2VybmVsIHRvCjJuZCBrZXJuZWwgZHVlIHRvIG5vIEVGSSBmaXJtd2FyZSBwaGFz
ZSwgYW55d2F5IHRoaXMgcGFydCBjYW4gYmUKY2xlYW5lZCB1cCBpZiB0aGUgZW11bGF0b3IgY2Fu
IGJlIGRvbmUgZ3JhY2VmdWxseS4KCj4KPiA+IEkgZm9yZ290IHdoeSB3ZSBjYW4gbm90IGp1c3Qg
ZXh0cmFjdCB0aGUga2VybmVsIGZyb20gVUtJIGFuZCB0aGVuIGxvYWQKPiA+IGl0IGRpcmVjdGx5
LCAgaWYgdGhlIGVtYmVkZGVkIGtlcm5lbCBpcyBhbHNvIHNpZ25lZCBpdCBzaG91bGQgYmUgZ29v
ZD8KPiA+Cj4KPiBJIHRoaW5rIHRoZSBtYWluIGNvbmNlcm4gaXMgYWJvdXQgdGhlIHNpZ25hdHVy
ZS4KCkkgdGhvdWdodCBmb3IgdGhlIG1pbmltdW0gY2FzZSBvZiBrZHVtcCwgd2UgbWF5IGp1c3Qg
bGl2ZSB3aXRoIGtlcm5lbApzaWduZWQgb25seSBhbmQgbGVhdmUgdGhlIGluaXRyZC9jbWRsaW5l
IHVuc2lnbmVkLiAgIEFueXdheSBmb3Iga2V4ZWMKcmVib290IGl0IGlzIGEgcHJvYmxlbS4KCj4K
PiBUaGFua3MsCj4KPiBQaW5nZmFuCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
