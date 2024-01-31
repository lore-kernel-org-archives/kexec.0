Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76825C47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JetCuQNPLIfLssP1x9WtxUt9NyhBz/sUzt0gqa9/XXQ=; b=ZrQ+1F8AejV7gJ
	e3xrVvSfRxOMeAL9eHnwOLUdsLDL//tKIYjG4ZAOcVuDs2ZsLLuGkxO2mU7JHHA4TL1ZMMOcSJtM2
	a1Io3GL6fvQjYxiNZt5F6tFI/Na55FIMXN2BD+DQqwGVW1X5Huwep22EVh+wl3TjYarfd5NiFswk/
	aNHWSGeypwexTuTzM1viBkCub3giBo9MhLvefiTWcdu3rp3bCeTIvKntA8/O0+DdWnkV+1ZazxKpE
	PEdUIv0HmCHJaabS0Rp+IUZrQFcYLa9Hgb3AeEXnpJmBeRH2lp8Y7XgjAKGSz6M0EbEVV7wH6Wk5p
	JGWWxkLuvlfEK+HlNyFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVA0Z-00000003QSO-1Z7M;
	Wed, 31 Jan 2024 12:48:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVA0W-00000003QRQ-0c0z
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 12:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706705279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZgQ3em8+hL4vf1kxriNyHbGVBBe93HygSX6eu/F3dE=;
	b=OrbljkEmXHEkdParHkb5RSyGjC6MHoja2lA1dqpisADEC4aie6CYx1hOFjB2WR+GFnFdP0
	WRd/VwlC78Yrg+yCstyOcq4Vh5gnoVycwIGElg/m0oh+INmNTTjm5Fet+laYnUNpdwWRpH
	pD46XswQTTg2F7vEpNRGisjwk4AqgEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-VJTCrdEtObC81bpv7NZDpQ-1; Wed, 31 Jan 2024 07:47:49 -0500
X-MC-Unique: VJTCrdEtObC81bpv7NZDpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA1EA800074;
	Wed, 31 Jan 2024 12:47:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA01492BC6;
	Wed, 31 Jan 2024 12:47:47 +0000 (UTC)
Date: Wed, 31 Jan 2024 20:47:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_044800_267410_EDF91144 
X-CRM114-Status: GOOD (  20.56  )
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

T24gMDEvMzEvMjQgYXQgMDk6MzFhbSwgTmlrb2xheSBCb3Jpc292IHdyb3RlOgo+IAo+IAo+IE9u
IDMwLjAxLjI0INCzLiAxNTo0MyDRhy4sIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4gPiBPbiAxLzI0
LzI0IDEzOjU1LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4gPiA+IFRoZSBwYXRjaHNldCBh
ZGRzIGJpdHMgYW5kIHBpZWNlcyB0byBnZXQga2V4ZWMgKGFuZCBjcmFzaGtlcm5lbCkgd29yayBv
bgo+ID4gPiBURFggZ3Vlc3QuCj4gPiA+IAo+ID4gPiBUaGUgbGFzdCBwYXRjaCBpbXBsZW1lbnRz
IENQVSBvZmZsaW5pbmcgYWNjb3JkaW5nIHRvIHRoZSBhcHByb3ZlZCBBQ1BJCj4gPiA+IHNwZWMg
Y2hhbmdlIHBvcG9zYWxbMV0uIEl0IHVubG9ja3Mga2V4ZWMgd2l0aCBhbGwgQ1BVcyB2aXNpYmxl
IGluCj4gPiA+IHRoZSB0YXJnZXQKPiA+ID4ga2VybmVsLiBJdCByZXF1aXJlcyBCSU9TLXNpZGUg
ZW5hYmxpbmcuIElmIGl0IG1pc3Npbmcgd2UgZmFsbGJhY2sgdG8KPiA+ID4gYm9vdGluZwo+ID4g
PiAybmQga2VybmVsIHdpdGggc2luZ2xlIENQVS4KPiA+ID4gCj4gPiA+IFBsZWFzZSByZXZpZXcu
IEkgd291bGQgYmUgZ2xhZCBmb3IgYW55IGZlZWRiYWNrLgo+ID4gCj4gPiBIaSBLaXJpbGwsCj4g
PiAKPiA+IEkgaGF2ZSBhIHZlcnkgYmFzaWMgcXVlc3Rpb246IGlzIHRoZXJlIGEgcmVhc29uIHdo
eSB0aGlzIHNlcmllcyBkb2VzIG5vdAo+ID4gcmV2ZXJ0IGNvbW1pdCBjYjhlYjA2ZDUwZmMsICJ4
ODYvdmlydC90ZHg6IERpc2FibGUgVERYIGhvc3Qgc3VwcG9ydCB3aGVuCj4gPiBrZXhlYyBpcyBl
bmFibGVkIj8KPiAKPiBXaGlsZSBvbiB0aGUgdG9waWMsIFBhb2xvIGRvIHlvdSB0aGluayBpdCdz
ICBiZXR0ZXIgdG8gaGF2ZSBhIHJ1bnRpbWUKPiBkaXNhYmxlIG9mIGtleGVjIHJhdGhlciB0aGFu
IGF0IGNvbXBpbGUgdGltZToKPiAKPiBbUkZDIFBBVENIXSB4ODYvdmlydC90ZHg6IERpc2FibGUg
S0VYRUMgaW4gdGhlIHByZXNlbmNlIG9mIFREWAo+IAo+IDIwMjQwMTE4MTYwMTE4LjE4OTkyOTkt
MS1uaWsuYm9yaXNvdkBzdXNlLmNvbQoKUnVudGltZSBkaXNhYmxpbmcga2V4ZWMgbG9va3MgYmV0
dGVyIHRoYW4gYXQgY21waWxlIHRpbWUsIGVzcCBmb3IKZGlzdHJvcy4gV2hpbGUgZnJvbSBhYm92
ZSBwYXRjaCwgbWFraW5nIHVzaW5nIG9mIGtleGVjX2xvYWRfZGlzYWJsZWQgdG8gCmFjaGl2ZSB0
aGUgcnVudGltZSBkaXNhYmxpbmcgbWF5IG5vdCBiZSBzbyBnb29kLiBCZWNhdXNlIHdlIGhhdmUg
YSBmcm9udApkb29yIHRvIGVuYWJsZSBpdCB0aHJvdWdoOgoKL3Byb2Mvc3lzL2tlcm5lbC9rZXhl
Y19sb2FkX2Rpc2FibGVkCgpJZiB0aGVyZSdzIGEgZmxhZyBvciBzdGF0dXMgdG8gY2hlY2sgaWYg
VERYIGhvc3QgaXMgZW5hYmxlZCwgYW5kIGRvZXMKdGhlIGNoZWNraW5nIGluIGtleGVjX2xvYWRf
cGVybWl0dGVkKCksIHRoYXQgY291bGQgYmUgYmV0dGVyLiBBbnl3YXksIEkKc2F3IEh1YW5nLCBL
YWkgaGFzIHBvc3RlZCB0aGUgdGR4IGhvc3Qgc3VwcG9ydCBwYXRjaHNldC4KCj4gCj4gSSdtIHRy
eWluZyB0byBnZXQgdHJhY3Rpb24gZm9yIHRoaXMgcGF0Y2guCj4gCj4gCj4gPiAKPiA+IFRoYW5r
cywKPiA+IAo+ID4gUGFvbG8KPiA+IAo+ID4gCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
