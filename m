Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298D3EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 04:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4wRBa9bnLp20CEsfYHqGUZyzFX2WRT0oBoiP9mCw1r4=; b=xacIBdfb9pbOfe
	iISK54caFUobpfMvT3sr8NQdlywK1exEBV0qBNeozfWo3RqVOV1OVRqHiez0Fi/wJmOxgZZs6tiOv
	JYBdLMumfoSHixg+WPOFySUh6kK4EGYE7euj+UE9F5ubGIEo5Q7hVsOES4B7TPTr1uIAGyLYOCJE2
	8IhhoxPXT/5ethBnfaxiChyM78KUzGQoW4q1HL2yvxO1rypg0FHjpNSWmENbwQL4ad7gZlZy7OPX+
	SR6FCR66bRwqo2usMGRKPpu4045BYQc5qw0e/ACUMMEtUAumQc28jyZLfcelgxtqdWkI8RHcjs6Zd
	BQjHZEB2hnOrFWHNgCDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHd0x-003TWQ-1r;
	Fri, 07 Jul 2023 04:24:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHd0u-003TVv-2S
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 04:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688703850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH5e5yrUwYhfZlLQss/cQIH00cXYe+Ubohm+t4WsCng=;
	b=P2oWil8gsWYk7+EEYX5FlCmpl/xbGGcGniHTG+TB/NsHA0uLvwTOQDA1xqTXim1EWJeXUh
	pkbWk2cQfi6UZd6uFTm6UDXNWo9a/7J/nvOuTq0kc29vDZE644gpMGpMLJndy/b2jBbziP
	m94mc2wV+ppQzNzY3HuOakDbj3xBZ0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-9SxUlnh6OMaN0meM_RXW8g-1; Fri, 07 Jul 2023 00:24:06 -0400
X-MC-Unique: 9SxUlnh6OMaN0meM_RXW8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F2B580123E;
	Fri,  7 Jul 2023 04:24:06 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DE7492C13;
	Fri,  7 Jul 2023 04:24:03 +0000 (UTC)
Date: Fri, 7 Jul 2023 12:23:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Tao Liu <ltao@redhat.com>, jroedel@suse.de, thomas.lendacky@amd.com
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ardb@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_212412_890950_30F9C18E 
X-CRM114-Status: GOOD (  20.76  )
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

T24gMDcvMDcvMjMgYXQgMTE6MzhhbSwgVGFvIExpdSB3cm90ZToKPiBIaSBCb3Jpc2xhdiwKPiAK
PiBUaGFua3MgZm9yIHRoZSBwYXRjaCByZXZpZXchCj4gCj4gT24gVGh1LCBKdWwgNiwgMjAyMyBh
dCAxOjM04oCvQU0gQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+IHdyb3RlOgo+ID4KPiA+
IE9uIFRodSwgSnVuIDAxLCAyMDIzIGF0IDAzOjIwOjQ0UE0gKzA4MDAsIFRhbyBMaXUgd3JvdGU6
Cj4gPiA+IEEga2V4ZWMga2VybmVsIGJvb3R1cCBoYW5nIGlzIG9ic2VydmVkIG9uIEludGVsIEF0
b20gY3B1IGR1ZSB0byB1bm1hcHBlZAo+ID4KPiA+IHMvY3B1L0NQVS9nCj4gPgo+ID4gPiBFRkkg
Y29uZmlnIHRhYmxlLgo+ID4gPgo+ID4gPiBDdXJyZW50bHkgRUZJIHN5c3RlbSB0YWJsZSBpcyBp
ZGVudGl0eS1tYXBwZWQgZm9yIHRoZSBrZXhlYyBrZXJuZWwsIGJ1dCBFRkkKPiA+ID4gY29uZmln
IHRhYmxlIGlzIG5vdCBtYXBwZWQgZXhwbGljaXRseToKPiA+Cj4gPiBXaHkgZG9lcyB0aGUgRUZJ
IGNvbmZpZyB0YWJsZSAqbmVlZCogdG8gYmUgbWFwcGVkIGV4cGxpY2l0bHk/Cj4gPgo+ID4gPiAg
ICAgY29tbWl0IDZiYmViMjc2YjcxZiAoIng4Ni9rZXhlYzogQWRkIHRoZSBFRkkgc3lzdGVtIHRh
YmxlcyBhbmQgQUNQSQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhYmxlcyB0byB0
aGUgaWRlbnQgbWFwIikKPiA+ID4KPiA+ID4gTGF0ZXIgaW4gdGhlIGZvbGxvd2luZyAyIGNvbW1p
dHMsIEVGSSBjb25maWcgdGFibGUgd2lsbCBiZSBhY2Nlc3NlZCB3aGVuCj4gPiA+IGVuYWJsaW5n
IHNldiBhdCBrZXJuZWwgc3RhcnR1cC4KPiA+Cj4gPiBXaGF0IGRvZXMgU0VWIGhhdmUgdG8gZG8g
d2l0aCBhbiBJbnRlbCBwcm9ibGVtPwo+IAo+IEZvciB0aGUgMiBxdWVzdGlvbnMgYWJvdmUuIFRo
ZSBjYWxsIHN0YWNrIGlzIGZvbGxvd3M6Cj4gCj4gaGVhZF82NC5TOi5Mb25fa2VybmVsX2NzKHdo
aWNoIGlzIGJlZm9yZSBleHRyYWN0X2tlcm5lbCkgLT4gc2V2X2VuYWJsZQo+IC0+IHNucF9pbml0
IC0+IGZpbmRfY2NfYmxvYiAtPiBmaW5kX2NjX2Jsb2JfZWZpLiBObyBtYXR0ZXIgd2hhdCBjcHUs
Cj4gd2l0aCBDT05GSUdfQU1EX01FTV9FTkNSWVBUIGVuYWJsZWQsIGFsbCB3aWxsIGVudGVyIHNl
dl9lbmFibGUoKSBhbmQKPiBnbyB0aHJvdWdoIHRoZXNlIGZ1bmN0aW9ucy4gSSBhc3N1bWUgaXQg
aXMgaGFybWxlc3MgZm9yIEludGVsIGNwdSwKCkkgYW0gd29uZGVyaW5nIHdoeSB3ZSBkb24ndCBk
ZXRlY3QgdGhlIGNwdSB0eXBlIGFuZCByZXR1cm4gZWFybHkgaW5zaWRlCnNldl9lbmFibGUoKSBp
ZiBpdCdzIEludGVsIGNwdS4KCldlIGNhbid0IHJlbHkgb24gQ09ORklHX0FNRF9NRU1fRU5DUllQ
VCB0byBkZWNpZGUgaWYgdGhlIGNvZGUgbmVlZCBiZQpleGVjdXRlZCBvciBub3QgYmVjYXVzZSB3
ZSB1c3VhbGx5IGVuYWJsZSB0aGVtIGFsbCBpbiBkaXN0cm9zLgoKVGhhbmtzCkJhb3F1YW4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
