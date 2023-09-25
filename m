Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A80ECE7A8B
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 03:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RTg8Gz9grG5/K1qze9eNqM3R96eCe2cjPEGo5OMENXA=; b=BellOssdGpnN8V
	38jIeghC9JtIid3SQQABLJ+MdeGyTAnYdv9OBjfxZck4isAn9FTUuVD4CG55lEMIGpc3Dpm/HO18U
	/AHXjB6RA88rOvD530qgMThB22OcO0Kg0YkQaLQSfZDD72908cT6Ka77AAnXIzUFD0YKyaWa9gWdU
	Xo7nP/1XshvM2Vf9niyxn3Ec0voOSFhTfkK82wXZ9oGxByx0bzuJzSfIMhNNVy4Vqq6xcgHkn2CbV
	qTG+BUUoK6ckKDp/hPzTONo9FSZtVflc+NPMK5O+KZXuJfinYpnByqLWKm00QNA4h9/fi2hR0DdEV
	RUWjsLbgklimUzoEikBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkbr8-00DCmY-2U;
	Mon, 25 Sep 2023 03:01:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkbr5-00DClm-1a
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 03:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695610909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOHyP9dpBU8YM0EPdsfU1fLNnKIO6S+xWw3yNzjJANc=;
	b=R3KG705FKWRWfhwMdHZpqwoTd1zZZ0UDFL9GEKFyeZWp8y3Us2lnHfod8ESWF0na9UAsC+
	lF5Cim+QOBvzOeNJQsphFOuMVD0ozaHI69v5OoDWVK7pxAj+xpYwxqOQsZauQXuo5PVKL3
	uukHzki00QSIlQb9EHbicUpYHNci7Fs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-rnsPVa3ENca1ZDlHKDSLZw-1; Sun, 24 Sep 2023 23:01:47 -0400
X-MC-Unique: rnsPVa3ENca1ZDlHKDSLZw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4180bc4227bso25369501cf.1
        for <kexec@lists.infradead.org>; Sun, 24 Sep 2023 20:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695610907; x=1696215707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOHyP9dpBU8YM0EPdsfU1fLNnKIO6S+xWw3yNzjJANc=;
        b=ubzo5UzBPinGVQDBWDTs90zHCYCS98CYfOs0e6fuDDnl2WNtuC7L1FpY3xiVrp5iW6
         PK+YfJukINio4XKSBLjcTuflF+uET4BJvsLly87nn0hQvym/hUna00BeeU+RHLRKdc+f
         HBoBC9Q5WRQcLV8Hd8RUdKyruFlrpuR0mqOD85MpD7qWiCKyRUTOfRl73PGLDN4R9zrX
         fTXvNIoG3ofp9xdTAzDpHT0lqYLALSBV6jZEkZfcfEPA3om5B6ohUDVsO7Dz2A4RKU76
         M9eUzYfb4521uE4zkb/pn8f0qETzA0jFrgIsA4F1AL7RLUYENKb2pgKaKylhvLfoywsa
         SNXA==
X-Gm-Message-State: AOJu0YwaR9dut8PfCM4rvBTWZk0wiEjSgxfzpDNEClBXdLHXCAnwuKLP
	95lSGurju37HGAICmDl+qXfojzZ+QzuOE7ymjacT0WwMmWqrMwk0h+Kq2SEIAbr5jNR/Q5qa+Gv
	AU5q0lJqp7ubyPxl2tqU741jUaRTMI83VRdGH
X-Received: by 2002:a0c:b459:0:b0:656:35ec:b6cc with SMTP id e25-20020a0cb459000000b0065635ecb6ccmr8282634qvf.23.1695610907085;
        Sun, 24 Sep 2023 20:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRlbRHh9+wHvQRrykeaUSkbeKsmrCoBKl8cLZE+5UxoAeDb96dOZs0OFoN5RbYbzjz0eY7ZSAk7JQuLEhiaiQ=
X-Received: by 2002:a0c:b459:0:b0:656:35ec:b6cc with SMTP id
 e25-20020a0cb459000000b0065635ecb6ccmr8282603qvf.23.1695610906749; Sun, 24
 Sep 2023 20:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
In-Reply-To: <ZQ0j6Es88aR8cjRv@desktop>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 25 Sep 2023 11:01:35 +0800
Message-ID: <CAF+s44R0ty0-aV+Amw2pL58YGa4JHt_y0WpiDMzehULPiC_aJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <kernelfans@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, keyrings@vger.kernel.org, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mjg59@google.com, 
	James.Bottomley@hansenpartnership.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230924_200151_617698_04AD3901 
X-CRM114-Status: GOOD (  46.11  )
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMToxOeKAr1BNIEphbiBIZW5kcmlrIEZhcnIgPGtlcm5l
bEBqZmFyci5jYz4gd3JvdGU6Cj4KPiBIaSBQaW5nZmFuIQo+Cj4gT24gMjEgMjE6Mzc6MDEsIFBp
bmdmYW4gTGl1IHdyb3RlOgo+ID4gRnJvbTogUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5jb20+
Cj4gPgo+Cj4gPiBGb3Igc2VjdXJpdHkgYm9vdCwgdGhlIHZtbGludXouZWZpIHdpbGwgYmUgc2ln
bmVkIHNvIFVFRkkgYm9vdCBsb2FkZXIKPiA+IGNhbiBjaGVjayBhZ2FpbnN0IGl0LiBCdXQgYXQg
cHJlc2VudCwgdGhlcmUgaXMgbm8gc2lnbmF0dXJlIGZvciBrZXhlYwo+ID4gZmlsZSBsb2FkLCB0
aGlzIHNlcmllcyBtYWtlcyBhIHNpZ25hdHVyZSBvbiB0aGUgemJvb3QncyBwYXlsb2FkIC0tIElt
YWdlCj4gPiBiZWZvcmUgaXQgaXMgY29tcHJlc3NlZC4gQXMgYSByZXN1bHQsIHRoZSBrZXhlYy10
b29scyBwYXJzZXMgYW5kCj4gPiBkZWNvbXByZXNzZXMgdGhlIEltYWdlLmd6IHRvIGdldCB0aGUg
SW1hZ2UsIHdoaWNoIGhhcyBzaWduYXR1cmUgYW5kIGNhbgo+ID4gYmUgY2hlY2tlZCBhZ2FpbnN0
IGR1cmluZyBrZXhlYyBmaWxlIGxvYWQKPgo+IEkgbWlzc2VkIHNvbWUgb2YgdGhlIGVhcmxpZXIg
ZGlzY3Vzc2lvbiBhYm91dCB0aGlzIHpib290IGtleGVjIHN1cHBvcnQuCj4gU28ganVzdCBsZXQg
bWUga25vdyBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZS4gWW91IHdlcmUgZXhwbG9yaW5n
Cj4gdGhlc2UgdHdvIG9wdGlvbnMgaW4gZ2V0dGluZyB0aGlzIHN1cHBvcnRlZDoKPgo+IDEuIE1h
a2luZyBrZXhlY19maWxlX2xvYWQgZG8gYWxsIHRoZSB3b3JrLgo+Cj4gVGhpcyBvcHRpb24gbWFr
ZXMgdGhlIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gZWFzeS4ga2V4ZWNfZmlsZV9sb2FkCj4gY2hl
Y2tzIHRoZSBzaWduYXR1cmUgb24gdGhlIHBlIGZpbGUgYW5kIHRoZW4gZXh0cmFjdHMgaXQgYW5k
IGRvZXMgdGhlCj4ga2V4ZWMuCj4KPiBUaGlzIGlzIHNpbWlsYXIgdG8gaG93IEknbSBhcHByb2Fj
aGluZyBVS0kgc3VwcG9ydCBpbiBbMV0uCj4KClllcywgdGhhdCBpcyBteSBvcmlnaW5hbCB0cnku
Cgo+IDIuIEV4dHJhY3QgaW4gdXNlcnNwYWNlIGFuZCBwYXNzIGRlY29tcHJlc3NlZCBrZXJuZWwg
dG8ga2V4ZWNfZmlsZV9sb2FkCj4KPiBUaGlzIG9wdGlvbiByZXF1aXJlcyB0aGUgZGVjb21wcmVz
c2VkIGtlcm5lbCB0byBoYXZlIGEgdmFsaWQgc2lnbmF0dXJlIG9uCj4gaXQuIFRoYXQncyB3aHkg
dGhpcyBwYXRjaCBhZGRzIHRoZSBhYmlsaXR5IHRvIGFkZCB0aGF0IHNpZ25hdHVyZSB0byB0aGUK
PiBrZXJuZWwgY29udGFpbmVkIGluc2lkZSB0aGUgemJvb3QgaW1hZ2UuCj4KCllvdSBnb3QgaXQu
Cgo+IFRoaXMgb3B0aW9uIHdvdWxkIG5vdCBtYWtlIHNlbnNlIGZvciBVS0kgc3VwcG9ydCBhcyBp
dCB3b3VsZCBub3QKPiB2YWxpZGF0ZSB0aGUgc2lnbmF0dXJlIHdpdGggcmVzcGVjdCB0byB0aGUg
aW5pdHJkIGFuZCBjbWRsaW5lIHRoYXQgaXQKPiBjb250YWlucy4gQW0gSSBjb3JyZWN0IGluIHRo
aW5raW5nIHRoYXQgdGhlcmUgaXMgbm8gc2ltaWxhciBpc3N1ZSB3aXRoCj4gemJvb3QgaW1hZ2Vz
PyBUaGV5IGRvbid0IGNvbnRhaW4gYW55IG1vcmUgaW5mb3JtYXRpb24gYmVzaWRlcyB0aGUga2Vy
bmVsCj4gdGhhdCBpcyBpbnRlbmRlZCB0byBiZSBzZWN1cmVseSBzaWduZWQsIHJpZ2h0PyBEbyB5
b3UgaGF2ZSBhIHJlZmVyZW5jZQoKSWYgdXNpbmcgbXkgc2Vjb25kIG1ldGhvZCwgaXQgbWVhbnMg
dG8gdW5wYWNrIHRoZSBVS0kgaW1hZ2UgaW4gdXNlcgpzcGFjZSwgYW5kIHBhc3MgdGhlIGtlcm5l
bCBpbWFnZSwgaW5pdHJkIGFuZCBjbWRsaW5lIHRocm91Z2gKa2V4ZWNfZmlsZV9sb2FkIGludGVy
ZmFjZS4gSWYgdGhlIFVLSSBjYW4gaGF2ZSBzaWduYXR1cmUgb24gdGhlIGluaXRyZAphbmQgY21k
bGluZSwgd2UgZXh0ZW5kIHRoZSBjYXBhYmlsaXR5IG9mIHRoYXQgaW50ZXJmYWNlIHRvIGNoZWNr
IHRob3NlCnZlcmlmaWNhdGlvbi4KCj4gZm9yIHRoZSB6Ym9vdCBpbWFnZSBsYXlvdXQgc29tZXdo
ZXJlPwo+CgpTb3JyeSB0aGF0IG1heWJlIHRoZXJlIGlzIG5vIGRvY3VtZW50LiBJIHVuZGVyc3Rh
bmQgdGhlbSB0aHJvdWdoIHRoZSBjb2RlLgpUaGUgemJvb3QgaW1hZ2UsIGFrYSwgdm1saW51ei5l
ZmkgbG9va3MgbGlrZToKUEUgaGVhZGVyLCB3aGljaCBpcyBmb3JtZWQgbWFudWFsbHkgaW4gYXJj
aC9hcm02NC9rZXJuZWwvaGVhZC5TCkVGSSBkZWNvbXByZXNzb3IsIHdoaWNoIGNvbnNpc3RzIG9m
CmRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvemJvb3QuYyBhbmQgbGlic3R1YgpJbWFnZS5n
eiwgd2hpY2ggaXMgZm9ybWVkIGJ5IGNvbXByZXNzaW5nIEltYWdlIGFzIGluc3RydWN0ZWQgaW4g
TWFrZWZpbGUuemJvb3QKCgo+ID4gSSBoZXNpdGF0ZSB0byBwb3N0IHRoaXMgc2VyaWVzLAo+Cj4g
SSBhcHByZWNpYXRlIHlvdSBzZW5kaW5nIGl0LCBpdCdzIGhlbHBpbmcgdGhlIGRpc2N1c3Npb24g
YWxvbmcuCj4KPiA+IFsuLi5dIHNpbmNlIEFyZCBoYXMgcmVjb21tZW5kZWQgdXNpbmcgYW4KPiA+
IGVtdWxhdGVkIFVFRkkgYm9vdCBzZXJ2aWNlIHRvIHJlc29sdmUgdGhlIFVLSSBrZXhlYyBsb2Fk
IHByb2JsZW0gWzFdLgo+ID4gc2luY2Ugb24gYWFyY2g2NCwgdm1saW51ei5lZmkgaGFzIGZhY2Vk
IHRoZSBzaW1pbGFyIGlzc3VlIGF0IHByZXNlbnQuCj4gPiBCdXQgYW55d2F5LCBJIGhhdmUgYSBj
cnVkZSBvdXRsaW5lIG9mIGl0IGFuZCBhbSBzZW5kaW5nIGl0IG91dCBmb3IKPiA+IGRpc2N1c3Np
b24uCj4KPiBUaGUgbW9yZSBJJ20gdGhpbmtpbmcgYWJvdXQgaXQsIHRoZSBtb3JlIEkgbGlrZSBB
cmQncyBpZGVhLiBUaGVyZSdzIG5vdwo+IGFscmVhZHkgdHdvIGRpZmZlcmVudCBmb3JtYXRzIHRy
eWluZyB0byBiZSBhZGRlZCB0byBrZXhlYyB0aGF0IGFyZQo+IHByZXR0eSBkaWZmZXJlbnQgZnJv
bSBlYWNoIG90aGVyLCB5ZXQgdGhleSBib3RoIGhhdmUgdGhlIFVFRkkgaW50ZXJmYWNlCj4gaW4g
Y29tbW9uLiBJIHRoaW5rIGlmIHRoZSBrZXJuZWwgc3VwcG9ydGVkIGtleGVjJ2luZyBFRkkgYXBw
bGljYXRpb25zCj4gdGhhdCB3b3VsZCBiZSBhIG1vcmUgZmxleGlibGUgYW5kIGZvcndhcmQtbG9v
a2luZyBhcHByb2FjaC4gSXQncyBhCgpZZXMsIEkgYWdyZWUuIFRoYXQgbWV0aG9kIGlzIGF0dHJh
Y3RpdmUsIG9yaWdpbmFsbHkgSSBoYWQgYSB0cnkgd2hlbgpBcmQgc3VnZ2VzdGVkIGl0IGJ1dCB0
aGVyZSB3YXMgbm8gY2xlYXIgYm91bmRhcnkgb24gd2hpY2ggYm9vdCBzZXJ2aWNlCnNob3VsZCBi
ZSBpbXBsZW1lbnRlZCBmb3IgemJvb3QsIHNvIEkgZGlkIG5vdCBtb3ZlIG9uIGFsb25nIHRoYXQK
ZGlyZWN0aW9uLgoKTm93LCBVS0kgcG9zZXMgYW5vdGhlciBjaGFsbGVuZ2UgdG8ga2V4ZWNfZmls
ZV9sb2FkLCBhbmQgc2VlbXMgdG8KcmVxdWlyZSBtb3JlIHRoYW4gemJvb3QuIEFuZCBpdCBhcHBl
YXJzIHRoYXQgQXJkJ3MgYXBwcm9hY2ggaXMgYQpzaWx2ZXIgYnVsbGV0IGZvciB0aGF0IGlzc3Vl
LgoKPiBzdGFuZGFyZCB0aGF0IGJvdGggemJvb3QgYW5kIFVLSSBhcyB3ZWxsIGFzIGFsbCBmdXR1
cmUgZm9ybWF0cyBmb3IgVUVGSQo+IHBsYXRmb3JtcyB3aWxsIHN1cHBvcnQgYW55d2F5cy4gU28g
d2hpbGUgaXQncyBtb3JlIHdvcmsgcmlnaHQgbm93IHRvCj4gaW1wbGVtZW50LCBJIHRoaW5rIGl0
J2xsIGxpa2VseSBwYXkgb2ZmLgo+Cj4gSXQgaXMgc2lnbmlmaWNhbnRseSBtb3JlIHdvcmsgdGhh
biB0aGUgb3RoZXIgb3B0aW9ucyB0aG91Z2guIFNvIEkgdGhpbmsKPiBiZWZvcmUgd29yayBpcyBz
dGFydGVkIG9uIGl0LCBpdCB3b3VsZCBiZSBuaWNlIHRvIGdldCBzb21lIHR5cGUgb2YKPiBjb25z
ZW5zdXMgb24gdGhlc2UgdGhpbmdzIChub3QgYW4gZXhoYXVzdGl2ZSBsaXN0LCBwbGVhc2UgZmVl
bCBmcmVlIHRvCj4gYWRkIHRvIGl0KToKPgoKSSB0cnkgdG8gYW5zd2VyIHBhcnQgb2YgdGhlIHF1
ZXN0aW9ucy4KCj4gMS4gSXMgaXQgdGhlIHJpZ2h0IGFwcHJvYWNoPyBJdCBhZGRzIGEgc2lnbmlm
aWNhbnQgYW1vdW50IG9mIHVzZXJzcGFjZQo+IEFQSS4KCk15IGNydWRlIGFzc3VtcHRpb246IHRo
aXMgbmV3IHN0dWIgd2lsbCByZXBsYWNlIHRoZSBwdXJnYXRvcnksIGFuZCBJCmFtIG5vdCBzdXJl
IHdoZXRoZXIga2V4ZWMtdG9vbHMgc291cmNlIHRyZWUgd2lsbCBhY2NvbW1vZGF0ZSBpdC4gSXQK
Y2FuIGJlIHNpZ25lZCBhbmQgY2hlY2tlZCBkdXJpbmcgdGhlIGtleGVjX2ZpbGVfbG9hZC4KCj4g
Mi4gV2hhdCBzdWJzZXQgb2YgdGhlIFVFRkkgc3BlYyBuZWVkcy9zaG91bGQgdG8gYmUgc3VwcG9y
dGVkPwo+IDMuIENhbiB3ZSBsZXQgcnVudGltZSBzZXJ2aWNlcyBzdGlsbCBiZSBoYW5kbGVkIGJ5
IHRoZSBmaXJtd2FyZSBhZnRlcgo+IGV4aXRpbmcgYm9vdCBzZXJ2aWNlcz8KCkkgdGhpbmsgdGhl
IHJ1bnRpbWUgc2VydmljZXMgc3Vydml2ZSB0aHJvdWdoIHRoZSBrZXhlYyBwcm9jZXNzLiBJdCBp
cwpkZXJpdmVkIGZyb20gdGhlIHJlYWwgZmlybXdhcmUsIG5vdCByZWxhdGVkIHdpdGggdGhpcyBz
dHViCgo+IDQuIEhvdyBjYW4gd2UgZGVidWcgdGhlIHN0dWJzIHRoYXQgYXJlIGJlaW5nIGludm9r
ZWQ/Cj4gNS4gQ2FuIHdlIGxldCB0aGUgRUZJIGJpbmFyeSBrbm93IHRoYXQgdGhpcyBpcyBhIGtl
eGVjIGFuZCBub3QgYSBub3JtYWwKPiBib290dXAuIFBvdGVudGlhbGx5IHN5c3RlbWQtc3R1YiB3
b3VsZCB3YW50IHRvIGNoYW5nZSBob3cvaWYgaXQgZG9lcyBUUE0KPiBQQ1IgbWVhc3VyZW1lbnRz
Lgo+IC4uLgo+CgpCZXNpZGVzIHRoZXNlIHF1ZXN0aW9ucywgSSB3b25kZXIgd2hldGhlciBhIGhp
Z2hseSBjb25maWd1cmVkIEVESzIgY2FuCmJlIHVzZWQgYXMgdGhlIHN0dWIgKEFybVZpcnRRZW11
S2VybmVsLmRzYyBjYW4gYmUgdGhlIHN0YXJ0IHBvaW50KS4KQnV0IHRoZXJlIHNob3VsZCBiZSBl
ZmZvcnRzIHRvIGV4Y2x1ZGUgdGhlIGRyaXZlcnMgd2hpY2ggaGF2ZSB0aGUgTU1JTwphY2Nlc3Mu
IEkgc2F3IEFyZCBpcyBhY3RpdmUgaW4gRURLMiwgbWF5YmUgdGhhdCBpcyB0aGUgcmVhc29uIHdo
eSBoZQpkaWQgbm90IHBpY2sgdXAgRURLMiB0byBzZXJ2ZSB0aGUgc3R1Yi4KCgpUaGFua3MsCgpQ
aW5nZmFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
