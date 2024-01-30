Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F784C46CD2
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ewFhhlw+BrJTXlxRQADkQnL8ESPE/kPETC9g3uif5CU=; b=vojFx0ESKG8mdh
	o+2HEu6PHB6cqGhE463XUOoZ7MicryTVIKaKwQ0xOevuCVE491B3mJ/OYb4Qi/jwMJVWfQWl4BeyV
	91LYQdmlV6FogXNOAj95z2+grAOHvUBVuDooeO3PrSaRLBIJx7YA5BH+NqrSj8oysveBtv7wj5I0i
	MVlyJCJpNsQVFxOMKmpVYn3q/rf3qgtB8rHQUBclxEyD4waLZC3qdGtGe3cCA74QVX0Eo5LhCR+pB
	3syCMh3EORT5izsaiBAWpHRckU8Lz4u+XNFguffUkhLvfH8nTf/RHFbQRsoSOT4I1t8gkVD+T6lau
	ySuAUyymG7glmU7txw3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpaZ-0000000H4Aq-3mkz;
	Tue, 30 Jan 2024 14:59:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpaX-0000000H49p-19Dh
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 14:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706626788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tgAgVSY1WXEHtXlxjinJFnJmsZeG3N/wjN5CzUBIZc=;
	b=GuRxMZHy0UaNK+wlbYPJnSepZni/zPip5USJ1M2pUmSz/lIJoK9Mjkb5uxG0OFCbZpXJo/
	FFwaIDC1PXZQg1r5Ns7OlPZSOgRmvhd3yPU5f3sH+HP/NtorHOKYocBhheCOM+W86uKKMC
	Jq+GTfRj0c3RCM08ez6K0ADKD9UL41A=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-GwE3-w-2NzSheIlMjxQ5Nw-1; Tue, 30 Jan 2024 09:59:46 -0500
X-MC-Unique: GwE3-w-2NzSheIlMjxQ5Nw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b8so1216980241.1
        for <kexec@lists.infradead.org>; Tue, 30 Jan 2024 06:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626786; x=1707231586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tgAgVSY1WXEHtXlxjinJFnJmsZeG3N/wjN5CzUBIZc=;
        b=NMqzP3XFsp0T6AqBYe8SDUFp8ue2m4+x++daO0IfSu5Dd1NUGyYzhrrQuCSPhowOCF
         NtVG4Zukfl3ooF0q66YabZ/GO5hJivIYIVCZCqs95y+hv11LD3PLZLg9gRodwKUolXee
         nMcbvj93D8s8iZGA2d3vW3ik8TuBYXAFFZ9z9NAKoQ8F2ekN1F/4hLYS/Y/qzPtPh7Y7
         RKgp5G32f9jvQNFD3dP1xfF1RK4r1XJuJGXjMZQQzkA1TggCR546zh2lKOh0+4kSdkKE
         yqT/pJXq6XNB9YZNvideuoRhcpgqcE68/0JzgsBv2XtGLKAODzxomKe5Qmti2D1EyZ1i
         L2Ag==
X-Gm-Message-State: AOJu0YwGkcAZMVapgUDtQyEOP2lmD7w/YB42SGeiBqpYj5D1gitCvpMJ
	LvpmIblt1G5UVziJ6Fa/JaF7p+940thj3j8xY9RfrXn3g0LNMXl9+cO32yABiPI3pK5kDGsZHc+
	OB6SPW6YhB7lskuoq9qsQ3yd7mh3FQQxRiWqc1xclu3GHTTYY1bM2YFxb+xN6z3VxbasbGJNQhD
	jbxwmkuh5XE4VxUbgibNhUCZoc/VmfUkq8
X-Received: by 2002:a05:6102:2256:b0:46b:6a7a:30a1 with SMTP id e22-20020a056102225600b0046b6a7a30a1mr2218314vsb.6.1706626786414;
        Tue, 30 Jan 2024 06:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDswsxCrtanUl+20n0ev8u+2WT23/0oF8G8nh8pG6OHZQJZLcwjksCHvNXwQ79sSgdmASJmVb7xQIYR598Wyc=
X-Received: by 2002:a05:6102:2256:b0:46b:6a7a:30a1 with SMTP id
 e22-20020a056102225600b0046b6a7a30a1mr2218288vsb.6.1706626786190; Tue, 30 Jan
 2024 06:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com> <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
In-Reply-To: <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Jan 2024 15:59:34 +0100
Message-ID: <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_065949_411965_10837968 
X-CRM114-Status: GOOD (  17.99  )
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMzozNOKAr1BNIEtpcmlsbCBBLiBTaHV0ZW1vdgo8a2ly
aWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEphbiAzMCwg
MjAyNCBhdCAwMjo0MzoxNVBNICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+ID4gT24gMS8y
NC8yNCAxMzo1NSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOgo+ID4gPiBUaGUgcGF0Y2hzZXQg
YWRkcyBiaXRzIGFuZCBwaWVjZXMgdG8gZ2V0IGtleGVjIChhbmQgY3Jhc2hrZXJuZWwpIHdvcmsg
b24KPiA+ID4gVERYIGd1ZXN0Lgo+ID4gPgo+ID4gPiBUaGUgbGFzdCBwYXRjaCBpbXBsZW1lbnRz
IENQVSBvZmZsaW5pbmcgYWNjb3JkaW5nIHRvIHRoZSBhcHByb3ZlZCBBQ1BJCj4gPiA+IHNwZWMg
Y2hhbmdlIHBvcG9zYWxbMV0uIEl0IHVubG9ja3Mga2V4ZWMgd2l0aCBhbGwgQ1BVcyB2aXNpYmxl
IGluIHRoZSB0YXJnZXQKPiA+ID4ga2VybmVsLiBJdCByZXF1aXJlcyBCSU9TLXNpZGUgZW5hYmxp
bmcuIElmIGl0IG1pc3Npbmcgd2UgZmFsbGJhY2sgdG8gYm9vdGluZwo+ID4gPiAybmQga2VybmVs
IHdpdGggc2luZ2xlIENQVS4KPiA+ID4KPiA+ID4gUGxlYXNlIHJldmlldy4gSSB3b3VsZCBiZSBn
bGFkIGZvciBhbnkgZmVlZGJhY2suCj4gPgo+ID4gSGkgS2lyaWxsLAo+ID4KPiA+IEkgaGF2ZSBh
IHZlcnkgYmFzaWMgcXVlc3Rpb246IGlzIHRoZXJlIGEgcmVhc29uIHdoeSB0aGlzIHNlcmllcyBk
b2VzIG5vdAo+ID4gcmV2ZXJ0IGNvbW1pdCBjYjhlYjA2ZDUwZmMsICJ4ODYvdmlydC90ZHg6IERp
c2FibGUgVERYIGhvc3Qgc3VwcG9ydCB3aGVuCj4gPiBrZXhlYyBpcyBlbmFibGVkIj8KPgo+IE15
IHBhdGNoc2V0IGVuYWJsZXMga2V4ZWMgZm9yIFREWCBndWVzdC4gVGhlIGNvbW1pdCB5b3UgcmVm
ZXIgYmxvY2tzIGtleGVjCj4gZm9yIGhvc3QuIFREWCBob3N0IGFuZCBndWVzdCBoYXZlIHRvdGFs
bHkgZGlmZmVyZW50IHByb2JsZW1zIHdpdGggaGFuZGxpbmcKPiBrZXhlYy4gS2FpIGxvb2tzIG9u
IGhvdyB0byBnZXQgaG9zdCBrZXhlYyBmdW5jdGlvbmFsLgoKWWVhaCwgdGhhdCB3YXMgcmlnaHQg
dGhlcmUgaW4gdGhlIGNvdmVyIGxldHRlciAoYW5kIEkgc2hvdWxkIGhhdmUKZ290dGVuIGEgY2x1
ZSBmcm9tIHRoZSBtYW55IHJlZmVyZW5jZXMgdG8gQ0NfKiBjb25zdGFudHMuLi4pLiBTb21lYm9k
eQpwb2ludGVkIG1lIHRvIHRoaXMgc2VyaWVzIGFzICJ0aGUgVERYIGtleGVjIHNlcmllcyBmcm9t
IEludGVsIiBhbmQgSQpoYWQgc29tZSB0dW5uZWwgdmlzaW9uIGlzc3Vlcy4gU29ycnkgZm9yIHRo
ZSBub2lzZSEKCkJ1dCBzaW5jZSBJIGhhdmUgeW91ciBhdHRlbnRpb24sIGRvIHlvdSBoYXZlIGEg
cG9pbnRlciB0byB0aGUKY29ycmVzcG9uZGluZyBlZGsyIHNlcmllcz8gVGhhbmtzLAoKUGFvbG8K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
