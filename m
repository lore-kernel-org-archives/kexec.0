Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC1C00528
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IPl/Ebc4wSBPKOexZHOh9J4LPLpzv0blUuvmpIK269o=; b=b2zZl8kwg1xwpV
	cC8YUkxRH7r8fXhHZvtoB9UwD3il4q+rSm5bdAlHe8pcOO9RXIsLUCIJ0A/NKGV/xTFT8iTj2h/15
	fWHLyqpeHqyB9AIRhagcxCI/aJfqKWQCe1pEBARch77jCd+uAbMlduq+17u2d+noaGQOqfL86kMlR
	0akvkG7NDq4/d0wnCUiwzkf6WuCG7k+9EYTTY/55lD6Ea2UDA3TMl4VtTKHaQIs7TjWky4K6t+cjM
	jRLaIvK0qNgrA6x54Yizw3Xw20ut/AIL5OR1l160V5tLCI8Tel8hnAlQiCRtRipH0fNpW/Inadg1o
	ka5mb/3ZN3uCSQAu1YHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT23t-0002i2-1K;
	Mon, 07 Aug 2023 15:22:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT23r-0002hK-1Y
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 15:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691421741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpWDemyVs+sbcnurkuDWkSGCy6yx9V9ABcaneLfHzS0=;
	b=P0qt5hk/06RrzlgdVxhPA8SMzQHpDUF/KxsLmPXuTULbvpYFE6F0PvLEHsr3LRWU+nvzEu
	hVvRhPILR2sgtArRjV8Rk7fLDNRmj5eHAla4AEdI5w4y2PPgyHzsGt/RIbG/fPK/knvsA+
	MJH0l+tkcsDjyPCZ0h92pTQDNHLGiEY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-KsN6B2X3NCuc-3pjwXp3tA-1; Mon, 07 Aug 2023 11:22:20 -0400
X-MC-Unique: KsN6B2X3NCuc-3pjwXp3tA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d1695e445so58558456d6.2
        for <kexec@lists.infradead.org>; Mon, 07 Aug 2023 08:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421739; x=1692026539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpWDemyVs+sbcnurkuDWkSGCy6yx9V9ABcaneLfHzS0=;
        b=FUZFWAIcG/o+LeIvpLTStRtb11IosqbwFEgL7b8mHIHvJV+F45Nd48DqGtzqOanyAR
         v6UTjjSWI+UeVSp8VUdH+zgC0eZXRM1qQHy5O2sGjc+bUFvxkhiLB4wH+1510mC29ffx
         TwKcXtX6KidTeIIvkisDS6oISdSOJM0osCBcdRh/ZdJhWkSJ0vu61MfE47VpFX8GGE7P
         sRJqeWz7fINVcslO8OjTW6JN1q1SlaWlMn6gFI93WxORHYTrFtJ8DZr5ejc2nm8OR9cV
         knUl/m8BQ/6B9W6ZgwB0eXapCZeLKiR+3uRtPaGXQ52ScCHT9pcSEASabMEDmaxnAXBz
         Fg0w==
X-Gm-Message-State: AOJu0YyeAj5j7bx1vRawIM1cmRryrsDmeA3yuuH7vm0caLyVsBjRG4tV
	8Jvhq61KZK1u/kB925n5L85wSQo9zdP/oIHJmXocgpKyaZYJp7/KRY19U0sP0VJzQCi0KwcaU/R
	MdZUKEZoDNu15ttz+WpGL1fvR2dVNjGs3kwDiYG0XoEigsDI=
X-Received: by 2002:a0c:e04a:0:b0:63c:d763:77b6 with SMTP id y10-20020a0ce04a000000b0063cd76377b6mr8989701qvk.55.1691421739724;
        Mon, 07 Aug 2023 08:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVTX/1sx73Fl5zY0SacvZDxbR4xLwB4xNq5JPuj1ezN3r3kqAWquEU4Y7KA194VfHv55vySYz7bNrSuqiuVSw=
X-Received: by 2002:a0c:e04a:0:b0:63c:d763:77b6 with SMTP id
 y10-20020a0ce04a000000b0063cd76377b6mr8989691qvk.55.1691421739499; Mon, 07
 Aug 2023 08:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803024152.11663-1-piliu@redhat.com> <20230803024152.11663-4-piliu@redhat.com>
 <ZNDwM0YfAHT7PDef@vergenet.net>
In-Reply-To: <ZNDwM0YfAHT7PDef@vergenet.net>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 7 Aug 2023 23:22:08 +0800
Message-ID: <CAF+s44TK6O3psWco=+cQn4MFMLSCy2s7S=PAwfiYCkuPZEM-iA@mail.gmail.com>
Subject: Re: [PATCHv7 3/5] kexec/zboot: Add arch independent zboot support
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>, ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_082223_608565_8150C8AC 
X-CRM114-Status: GOOD (  24.12  )
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

T24gTW9uLCBBdWcgNywgMjAyMyBhdCA5OjIz4oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IE9uIFRodSwgQXVnIDAzLCAyMDIzIGF0IDEwOjQxOjUwQU0gKzA4
MDAsIFBpbmdmYW4gTGl1IHdyb3RlOgo+ID4gRnJvbTogSmVyZW15IExpbnRvbiA8amVyZW15Lmxp
bnRvbkBhcm0uY29tPgo+ID4KPiA+IFRoZSBsaW51eCBrZXJuZWwgQ09ORklHX1pCT09UIG9wdGlv
biBjcmVhdGVzCj4gPiBzZWxmIGRlY29tcHJlc3NpbmcgUEUga2VybmVsIGltYWdlcy4gU28gdGhp
cyBtZWFucwo+ID4gdGhhdCBrZXhlYyBzaG91bGQgaGF2ZSBhIGdlbmVyaWMgdW5kZXJzdGFuZGlu
ZyBvZgo+ID4gdGhlIGZvcm1hdCB3aGljaCBtYXkgYmUgdXNlZCBieSBtdWx0aXBsZSBhcmNoZXMu
Cj4gPgo+ID4gU28gbGV0cyBhZGQgYW4gYXJjaCBpbmRlcGVuZGVudCB2YWxpZGF0aW9uCj4gPiBh
bmQgZGVjb21wcmVzc2lvbiByb3V0aW5lLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEplcmVteSBM
aW50b24gPGplcmVteS5saW50b25AYXJtLmNvbT4KPiA+IFtNb2RpZmllZCBieSBQaW5nZmFuIHRv
IGV4cG9ydCBrZXJuZWwgZmRdCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVA
cmVkaGF0LmNvbT4KPiA+IFRvOiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBDYzogaG9y
bXNAdmVyZ2UubmV0LmF1Cj4gPiBDYzogYXJkYkBrZXJuZWwub3JnCj4gPiBDYzogamVyZW15Lmxp
bnRvbkBhcm0uY29tCj4gPiAtLS0KPiA+ICBpbmNsdWRlL01ha2VmaWxlICAgICAgICAgfCAgIDEg
Kwo+ID4gIGluY2x1ZGUva2V4ZWMtcGUtemJvb3QuaCB8ICAxNSArKysrKwo+ID4gIGtleGVjL01h
a2VmaWxlICAgICAgICAgICB8ICAgMSArCj4gPiAga2V4ZWMva2V4ZWMtcGUtemJvb3QuYyAgIHwg
MTMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIDQgZmlsZXMg
Y2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKykKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9rZXhlYy1wZS16Ym9vdC5oCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGtleGVjL2tleGVjLXBl
LXpib290LmMKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9NYWtlZmlsZSBiL2luY2x1ZGUv
TWFrZWZpbGUKPiA+IGluZGV4IDYyMWNlOWYuLmNkODhhMjYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNs
dWRlL01ha2VmaWxlCj4gPiArKysgYi9pbmNsdWRlL01ha2VmaWxlCj4gPiBAQCAtMSw2ICsxLDcg
QEAKPiA+ICBkaXN0ICs9IGluY2x1ZGUvTWFrZWZpbGUgICAgICAgICAgICAgXAo+ID4gICAgICAg
aW5jbHVkZS9jb25maWcuaCAgICAgICAgICAgICAgICBcCj4gPiAgICAgICBpbmNsdWRlL2NvbmZp
Zy5oLmluICAgICAgICAgICAgIFwKPiA+ICsgICAgIGluY2x1ZGUva2V4ZWMtcGUtemJvb3QuaCAg
ICAgICAgXAo+ID4gICAgICAgaW5jbHVkZS9rZXhlYy11SW1hZ2UuaCAgICAgICAgICBcCj4gPiAg
ICAgICBpbmNsdWRlL3g4Ni94ODYtbGludXguaCAgICAgICAgIFwKPiA+ICAgICAgIGluY2x1ZGUv
eDg2L21iX2luZm8uaCAgICAgICAgICAgXAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUva2V4ZWMt
cGUtemJvb3QuaCBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQKPiA+IGluZGV4IDAwMDAwMDAuLmM1ODhjYTIKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsr
KyBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+ID4gQEAgLTAsMCArMSwxNSBAQAo+ID4gKyNp
Zm5kZWYgX19LRVhFQ19QRV9aQk9PVF9IX18KPiA+ICsjZGVmaW5lIF9fS0VYRUNfUEVfWkJPT1Rf
SF9fCj4gPiArCj4gPiArLyogc2VlIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvemJvb3Qt
aGVhZGVyLlMgKi8KPiA+ICtzdHJ1Y3QgbGludXhfcGVfemJvb3RfaGVhZGVyIHsKPiA+ICsgICAg
IHVpbnQzMl90IG16X21hZ2ljOwo+ID4gKyAgICAgICAgdWludDMyX3QgaW1hZ2VfdHlwZTsKPiA+
ICsgICAgICAgIHVpbnQzMl90IHBheWxvYWRfb2Zmc2V0Owo+ID4gKyAgICAgICAgdWludDMyX3Qg
cGF5bG9hZF9zaXplOwo+ID4gKyAgICAgICAgdWludDMyX3QgcmVzZXJ2ZWRbMl07Cj4gPiArICAg
ICAgICB1aW50MzJfdCBjb21wcmVzc190eXBlOwo+ID4gK307Cj4KPiBuaXQ6IHRoZSBhYm92ZSBz
aG91bGQgY29uc2lzdGVudGx5IHVzZSB0YWJzIGZvciBpbmRlbnRhdGlvbi4KPiAgICAgIEkgY2Fu
IHRyeSBhbmQgZml4IHRoaXMgd2hlbiBhcHBseWluZyBpZiB0aGVyZSBpcyBubyB2OC4KPgoKQXBw
cmVjaWF0ZSBpdCBpZiB5b3UgZG8gaXQuIEkgdGhpbmsgdGhhdCBubyB2OCBpZiBubyBvdGhlciBn
dXlzIGhhdmUKb3BpbmlvbnMgb24gdGhpcyBzZXJpZXMuCgpUaGFua3MsCgpQaW5nZmFuCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
