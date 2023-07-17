Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B803EB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rbrVqSdEnbPQoeCjtJWUIfUmYSflqZYrAWibDuzDYi4=; b=xelrssBb7f0tad
	7CKU4E8WQ7v3EsHEcttFded6oyX8t+FIkA9Arefwfg/nnt4wIhzih/2OPDljvgWbGRioAGCi5HFTN
	UO8B0JkjwCNi59Sf096gt/6CKIMllwvUzT2Soh6CmEn4zlxmJJykAmGQ1hxRQaK9Tl8IuXd8HmBJi
	kVruG2yX/brwsmBfB9bjtYm/rXNVpzzE0oNUviPyEqpXTDah7onHF2OSGRQlOK1tKX/t+9ZBysO3l
	wikMCAi+PPpIHfHg6Pim+UKvRAnOfLZ6yhXvjE/dErGqnXFqh/z0YhOsWbSTBLsiYf7nPxCW/ESey
	5H/b0g9W16g9aHkOK9bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPl7-004LMH-2x;
	Mon, 17 Jul 2023 15:03:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPl4-004LL6-04
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 15:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689606206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiBMrn+7osyMXo/+tKE4pG92GpAUpq53+LvmvO3TmV8=;
	b=ii/aKK9F+2gFxqnia1ZU/EimH5SbZbOqNcQzIPlUH2b/t5tkjIBH0cDcmW509OWapbP3VV
	Fzl4j8MuO3nZXulRsodF3lxdiu4/Kvu+cCdk0Mk7LEqcbuLw/5yuXQmXB/7GPHJd1t05cb
	VjhA2P1AJB7QjZFers1VjrpRIJFvSpk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-8nFYDtp-Maej0mpQGH8D8g-1; Mon, 17 Jul 2023 11:03:22 -0400
X-MC-Unique: 8nFYDtp-Maej0mpQGH8D8g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51a595bc30dso5520057a12.0
        for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606200; x=1692198200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiBMrn+7osyMXo/+tKE4pG92GpAUpq53+LvmvO3TmV8=;
        b=IVmqJDFBmg8anol+xUOe6A1chw0fewoO64T7/NrtnUW22HRklLVzTlkkIdkiNUMscm
         IzI0bj6WgDhImm9WPpGsfQGLf0kwy8ishUdICks/P73+MQNDYUyY6xrchSxR29RXZFh+
         s5JibW4Mbm3BuWZPSK6yF8CmGYWBLWodzZkb45HLiuq8Rk6oxzf4965NMG7hIOPblNRB
         RML2GU7Ye+CzmJqn788cauShbe6yWcOcnHlNelMFI/HgVTuZpoBtY/z36HtZPLbdPzlg
         3J0Y9hOhMFKcX7h0Qeex3DRl2I95j4G2foy3s5fSZ/ViDKnno3Mr/y1Gfu69wKhGrtlP
         HI4A==
X-Gm-Message-State: ABy/qLYBmweS26Hoo1Bzdt3DTwSF/NUNxZcSox3oYB7vQjF/8723MHbD
	zqTT4iQDCJ2UfoQgB+Po4C5jQl2mYKfHUpDYzxwXEN2DQXXibGmW2MGY3eYZQvTNC/8yf4r0aPh
	+8+uh+RuPkTI17KeCwC+0x6NgspUJSIWg1S+r
X-Received: by 2002:a05:6402:104f:b0:521:985d:7314 with SMTP id e15-20020a056402104f00b00521985d7314mr2171129edu.18.1689606199888;
        Mon, 17 Jul 2023 08:03:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEoeC3xa/5aQjDsGItXISa8YGqmN7zj10ELFkhg1xaPxRBxx//hSueafi0Wxze1pAe8Q8cX3fxzgZYOQ+L/pNo=
X-Received: by 2002:a05:6402:104f:b0:521:985d:7314 with SMTP id
 e15-20020a056402104f00b00521985d7314mr2171100edu.18.1689606199599; Mon, 17
 Jul 2023 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv> <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local> <20230707152515.42gpfzjgvfwe6rf7@amd.com>
 <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local> <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
In-Reply-To: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 17 Jul 2023 23:02:43 +0800
Message-ID: <CAO7dBbW8pAP9PsBBu+ywygc_RivX4t0yBNOa+aDkyBWA9HECjg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Michael Roth <michael.roth@amd.com>, Joerg Roedel <jroedel@suse.de>, 
	Baoquan He <bhe@redhat.com>, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_080330_131437_677865DE 
X-CRM114-Status: GOOD (  41.98  )
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

SGkgQXJkLAoKVGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uIQoKT24gVGh1LCBKdWwgMTMsIDIw
MjMgYXQgNjoxOOKAr1BNIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+IHdyb3RlOgo+
Cj4gT24gRnJpLCA3IEp1bCAyMDIzIGF0IDE5OjEyLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBKdWwgMDcsIDIwMjMgYXQgMTA6MjU6MTVBTSAt
MDUwMCwgTWljaGFlbCBSb3RoIHdyb3RlOgo+ID4gPiAuLi4KPiA+ID4gSXQgd291bGQgYmUgdW5m
b3J0dW5hdGUgaWYgd2UgZmluYWxseSBhYmFuZG9uZWQgdGhpcyBwYXRoIGJlY2F1c2Ugb2YgdGhl
Cj4gPiA+IGlzc3VlIGJlaW5nIGhpdCBoZXJlIHRob3VnaC4gSSB0aGluayB0aGUgcGF0Y2ggcG9z
dGVkIGhlcmUgaXMgdGhlIHByb3Blcgo+ID4gPiByZXNvbHV0aW9uIHRvIHRoZSBpc3N1ZSBiZWlu
ZyBoaXQsIGFuZCBJJ20gaG9waW5nIGF0IHRoaXMgcG9pbnQgd2UndmUKPiA+ID4gaWRlbnRpZmll
ZCBhbGwgdGhlIHNpbWlsYXIgY2FzZXMgd2hlcmUgRUZJL3NldHVwX2RhdGEtcmVsYXRlZCBzdHJ1
Y3R1cmVzCj4gPiA+IHdlcmUgbWlzc2luZyBleHBsaWNpdCBtYXBwaW5ncy4gQnV0IGlmIHdlIHN0
aWxsIHRoaW5rIGl0J3MgdG9vIG11Y2ggb2YgYQo+ID4gPiBsaWFiaWxpdHkgdG8gYWNjZXNzIHRo
ZSBFRkkgY29uZmlnIHRhYmxlIG91dHNpZGUgb2YgU0VWLWVuYWJsZWQgZ3Vlc3RzLAo+ID4gPiB0
aGVuIEkgY2FuIHdvcmsgb24gcmUtaW1wbGVtZW50aW5nIHRoaW5ncyBiYXNlZCBvbiB0aGUgYWJv
dmUgbG9naWMuCj4gPgo+ID4gUmVwbHlpbmcgaGVyZSB0byBUb20ncyBub3RlIHRvby4uLgo+ID4K
PiA+IFNvLCBJIGxpa2UgdGhlIGlkZWEgb2YgcmVjaGVja2luZyBDUFVJRC4gWWVzLCBsZXQncyBk
byB0aGUgc2V2X3N0YXR1cwo+ID4gY2hlY2suIEFzIGEgcmVzdWx0LCB3ZSBlaXRoZXIgZmFpbCB0
aGUgZ3Vlc3QgLSBubyBwcm9ibGVtIC0gb3Igd2UgYm9vdAo+ID4gYW5kIHdlIHJlY2hlY2suIFRo
dXMsIHdlIGRvbid0IHJ1biBBTUQgY29kZSBvbiAhQU1EIG1hY2hpbmVzLCBpZiB0aGUgSFYKPiA+
IGlzIG5vdCBhIGx5aW5nIGJhc3RhcmQuCj4gPgo+ID4gTm93LCBpZiB3ZSd2ZSBnb3R0ZW4gYSB2
YWxpZCBzZXR1cF9kYXRhIFNFVFVQX0VGSSBlbnRyeSB3aXRoIGEgdmFsaWQKPiA+IHBvaW50ZXIg
dG8gYW4gRUZJIGNvbmZpZyB0YWJsZSwgdGhlbiB0aGF0IHNob3VsZCBoYXBwZW4gaW4gdGhlIGdl
bmVyaWMKPiA+IHBhdGggLSBpbml0aWFsaXplX2lkZW50aXR5X21hcHMoKSwgZm9yIGV4YW1wbGUg
LSBsaWtlIHlvdSd2ZSBkb25lIGluCj4gPiBiNTdmZWVkMmNjMjYgLSBub3QgaW4gdGhlIGtleGVj
IGNvZGUgYmVjYXVzZSBrZXhlYyAqaGFwcGVucyogdG8gbmVlZCBpdC4KPiA+Cj4gPiBXZSB3YW50
IHRvIGFjY2VzcyB0aGUgRUZJIGNvbmZpZyB0YWJsZT8gU3VyZSwgYnkgYWxsIG1lYW5zLCBidXQg
bWFrZQo+ID4gdGhhdCBnZW5lcmljIGZvciBhbGwgY29kZS4KPiA+Cj4KPiBPSywgc28gaW4gc3Vt
bWFyeSwgd2hhdCBzZWVtcyB0byBiZSBoYXBwZW5pbmcgaGVyZSBpcyB0aGF0IHRoZSBTRVYKPiBp
bml0IGNvZGUgaW4gdGhlIGRlY29tcHJlc3NvciBsb29rcyBmb3IgdGhlIGNjIGJsb2IgdGFibGUg
YmVmb3JlIHRoZQo+IG9uLWRlbWFuZCBtYXBwaW5nIGNvZGUgaXMgdXAsIHdoaWNoIG5vcm1hbGx5
IGVuc3VyZXMgdGhhdCBhbnkgUkFNCj4gYWRkcmVzcyBpcyBhY2Nlc3NpYmxlIGV2ZW4gaWYgaXQg
aGFzbid0IGJlZW4gbWFwcGVkIGV4cGxpY2l0bHkuCj4KWWVzIGl0IGlzIGV4YWN0bHkgdGhlIGNh
c2UuCgo+IFRoaXMgaXMgd2h5IHRoZSBmaXggaGFwcGVucyB0byB3b3JrOiB0aGUgY29kZSBvbmx5
IG1hcHMgdGhlIGFycmF5IG9mCj4gKGd1aWQsIHBoeXNfYWRkcikgdHVwbGVzIHRoYXQgZGVzY3Jp
YmVzIHRoZSBsaXN0IG9mIGNvbmZpZ3VyYXRpb24KPiB0YWJsZXMgdGhhdCBoYXZlIGJlZW4gcHJv
dmlkZWQgYnkgdGhlIGZpcm13YXJlLiBUaGUgYWN0dWFsCj4gY29uZmlndXJhdGlvbiB0YWJsZXMg
dGhlbXNlbHZlcyBjb3VsZCBiZSBhbnl3aGVyZSBpbiBwaHlzaWNhbCBtZW1vcnksCj4gYW5kIHdp
dGhvdXQgcHJpb3Iga25vd2xlZGdlIG9mIGEgcGFydGljdWxhciBHVUlEIHZhbHVlLCB0aGVyZSBp
cyBubwo+IHdheSB0byBrbm93IHRoZSBzaXplIG9mIHRoZSB0YWJsZSwgYW5kIHNvIHRoZXkgY2Fu
bm90IGJlIG1hcHBlZAoKU2hvdWxkIHdlIGxvb3AgbWFwIGVhY2ggZWxlbWVudCBvZiB0aGUgY29u
ZmlnIHRhYmxlIG9uZSBhdCBhIHRpbWU/IFdlCnJlYWQgYSBHVUlEIHZhbHVlLCB0aGVuIHdlIG1h
cCBpdCB3aXRoIHBoeXNfYWRkciwgcGh5c19hZGRyICsKc2l6ZW9mKHN0cnVjdCksIHRoZW4gd2Ug
cmVhZC1tYXAgdGhlIG5leHQgb25lLCBpbiB0aGlzIHdheSB3ZSBtYXkgbm90Cm5lZWQgdG8ga25v
dyB0aGUgc2l6ZSBvZiB0aGUgdGFibGU/Cgo+IHVwZnJvbnQgbGlrZSB0aGlzLiBIb3dldmVyLCB0
aGUgY2MgYmxvYiB0YWJsZSBkb2VzIG5vdCBleGlzdCBvbiB0aGlzCj4gbWFjaGluZSwgYW5kIHNv
IHdoZXRoZXIgdGhlIEVGSSBjb25maWcgdGFibGVzIHRoZW1zZWx2ZXMgYXJlIG1hcHBlZCBvcgo+
IG5vdCBpcyBpcnJlbGV2YW50LgoKQ3VycmVudGx5IHdlIGRvbid0IG5lZWQgYWxsIHRoZSBkYXRh
IG9mIHRoZSBjb25maWcgdGFibGUsIG9ubHkgcGFydCBvZgppdC4gU28gb25seSAgKGd1aWQsIHBo
eXNfYWRkcikgdHVwbGUgYXJyYXlzIGFyZSBtYXBwZWQgaW50by4gV29uJ3QgaXQKYmUgYmV0dGVy
IGlmIHdlIG1hcCBjb25maWcgdGFibGUgb24gZGVtYW5kIGlmIHdlIG5lZWQgZnVydGhlciBkYXRh
CmxhdGVyPwoKPgo+IEJ1dCBpdCBkb2VzIG1lYW4gdGhlIGZpeCBpcyBpbmNvbXBsZXRlLCBhbmQg
Y2VydGFpbmx5IGRvZXMgbm90IGJlbG9uZwo+IGluIGdlbmVyaWMga2V4ZWMgY29kZS4gSWYgYW55
dGhpbmcsIHdlIHNob3VsZCBiZSBmaXhpbmcgdGhlCj4gZGVjb21wcmVzc29yIGNvZGUgdG8gZGVm
ZXIgdGhlIGNjIGJsb2IgdGFibGUgY2hlY2sgdW50aWwgYWZ0ZXIgdGhlCj4gZGVtYW5kIG1hcHBp
bmcgY29kZSBpcyB1cC4KClllcywgaWYgd2UgY2FuIGRlZmVyIHRoZSBjYyBibG9iIGFjY2Vzcywg
dGhlIGlzc3VlIGNhbiBiZSByZXNvbHZlZC4gSQpkb24ndCBrbm93IGlmIGl0IGlzIGRvYWJsZSBm
cm9tIEFNRCdzIHZpZXcuLi4KPgo+IElmIHRoaXMgaXMgcHJvYmxlbWF0aWMsIHdlIG1pZ2h0IGlu
c3RlYWQgZGlzYWJsZSBTRVYgZm9yIGtleGVjLCBhbmQKPiByZWx5IG9uIHRoZSBmYWN0IHRoYXQg
U0VWIGZpcm13YXJlIGVudGVycyB3aXRoIGEgY29tcGxldGUgMToxIG1hcCAoYXMKCldlIHN0aWxs
IG5lZWQgc2V2IHN1cHBvcnQgZm9yIGtleGVjLiBJZiB3ZSBkaXNhYmxlIHNldiBkdXJpbmcga2V4
ZWMsIEkKc3VwcG9zZSBrZHVtcCBtYXkgYmUgYnJva2VuIG9uIGEgc2V2IGd1ZXN0LCBtYXliZT8K
ClRoYW5rcywKVGFvIExpdQoKPiB3ZSBzZWVtIHRvIGJlIGRvaW5nIGN1cnJlbnRseSkuIElmIGtl
eGVjIGZvciBTRVYgaXMgbmVlZGVkIGF0IHNvbWUKPiBwb2ludCwgd2UgY2FuIHJlLWVuYWJsZSBp
dCBieSBoYXZpbmcgaXQgcHJvdmlkZSBhIG1hcHBpbmcgZm9yIHRoZQo+IGNvbmZpZyB0YWJsZSBh
cnJheSBhbmQgdGhlIGNjIGJsb2IgdGFibGUgZXhwbGljaXRseS4KPgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
