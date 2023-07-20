Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860CCEB64DA
	for <kexec@archiver.kernel.org>; Thu, 20 Jul 2023 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bTb2q35DLMGgHkr0dVsM/lfp5/WavL9iEliqmS9AJjY=; b=DS8Agp8mYk5ktb
	+L9aXQisg/BubTtqjed1OUPJf61Vvc12hTjPOmvvc9gZNG1w7Sr91hfpz9FlbY9oiiAwb2Hq66fs1
	6UIEYdeyJjOcLWpaKF/Co8qUpxh/VN8K0V5pS/HRX3hQvkU7ofRwG0huqNso5m3b/oNzRiFLtIY1W
	xfd/jZwShhPBT99nu1cd+QGjYuAegMd9PN0y6nF5VC02M3tcXu6vsRfYTs0pkqJbFnQ+fU565ranw
	kh6mL079PYLO2YZuZkYTVJE/8Z5Ma/OnQjn6RMXH4UKDj9GS8e6UMFzy7PEGkSX/pd4oFW0h2M2+7
	m6wHDQRDE5iZSHFZ7Iew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMQZE-00Agpd-0h;
	Thu, 20 Jul 2023 10:07:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMQZB-00Agi2-0A
	for kexec@lists.infradead.org;
	Thu, 20 Jul 2023 10:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689847615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6RHdcQUaQmsrvqbhKrMl+sQhjJv/PRaKnm29ihYT4Y=;
	b=CcShdRTVMYVBB2avLIL2mW8vIr2AgWlXwxIhOfmbpsrn23cgC+cjIk+7aogEum4weoESYW
	uVnONxPgRgMRKkNr2CbJn5RJrezenORuXmN8rXbXLC8BY+duEVBsUyiQtuXT+12DORWOAU
	G6RJchOi2kvpBUDXxyTmSa3bJhgaAaw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Byxd21ASPJmvbsvur8DfQg-1; Thu, 20 Jul 2023 06:06:54 -0400
X-MC-Unique: Byxd21ASPJmvbsvur8DfQg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-783339b6c88so9468539f.0
        for <kexec@lists.infradead.org>; Thu, 20 Jul 2023 03:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689847613; x=1690452413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6RHdcQUaQmsrvqbhKrMl+sQhjJv/PRaKnm29ihYT4Y=;
        b=Pzcw30BoBAeVbnP0HbxFsqAsCGk+awAvtzVqJmrgt96aNFQr97QOWygB9XkT9GwlPb
         ffVr6/WhdO6A1CZSW6NBTvmftt/r8SCjaLbyahg8m6tfvQP7uBe7sYGFEMRrTd7T+0m7
         tVKD67MVVjAmJEGXLXTQCf9JFF0JhXdl1v2R2uSvN/1RCQvUFGka0ZtAphY7WvcwFdrS
         uqrJPwdq/z/0ftMVXjknYSPRId619j9SkD/XvuSmYZeuXSxUva3MVr1F+ieq/cEWaEQG
         naHagErWT1t4R4aa0JuGk/QsNghdseNFgTlMzehpJjUC3mlmOkL6Dzntj/X4fC35ySpy
         qtMQ==
X-Gm-Message-State: ABy/qLYAMoZQeubdZJ3EpWPjubTOzf6lbpbQ0PXksGekQ56FKiIoAQTd
	/gCniZjbnPuTpAtDPN4NGX+QHIe9mQ0oK7SCIDAFzhZ2inyDSizq575dUZVZdqsnwMqpxXztyNA
	3PnHFryEZNtHS6SVKySPL9YJp7gX7Q3XyXjAkrwb0cwal
X-Received: by 2002:a92:dacf:0:b0:345:db9a:be2c with SMTP id o15-20020a92dacf000000b00345db9abe2cmr2135129ilq.1.1689847613602;
        Thu, 20 Jul 2023 03:06:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4Un4212Lv3jpghVCZkxfDHQKMRv9odR0JncfshuIIRhnVpu54SAt4KwHL7hzfgFlRyEzLaf+lsMKrIQW6p3M=
X-Received: by 2002:a92:dacf:0:b0:345:db9a:be2c with SMTP id
 o15-20020a92dacf000000b00345db9abe2cmr2135122ilq.1.1689847613373; Thu, 20 Jul
 2023 03:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230717130732.22710-1-piliu@redhat.com> <ZLdSMPJ9LxxFHCrO@darkstar.users.ipa.redhat.com>
 <CAF+s44SZSX5H_UkTjauHkxZwWRBTJ0vD6a_AqEfTxBioJ6ioTQ@mail.gmail.com>
 <CALu+AoQMib-=w3mEoaz97Yb-nG=NfgLJswifUh834duu3rnj+A@mail.gmail.com>
 <CAF+s44QVbpb=upCqY6n_FSo6QAhv6=eLNCXwz1Jng6wW75KLXQ@mail.gmail.com> <CALu+AoThG6kFEQ1-x=uv1_f8PYGNLD=hgg3vk2avDUk=K_BdOg@mail.gmail.com>
In-Reply-To: <CALu+AoThG6kFEQ1-x=uv1_f8PYGNLD=hgg3vk2avDUk=K_BdOg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 20 Jul 2023 18:08:31 +0800
Message-ID: <CALu+AoREQ9ZjtzibtKMH-ZRD6O1Lqh3hG7s2VS1xXOaqszom5g@mail.gmail.com>
Subject: Re: [PATCHv5 0/8] arm64: zboot support
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_030725_156447_94E5B338 
X-CRM114-Status: GOOD (  39.20  )
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

T24gVGh1LCAyMCBKdWwgMjAyMyBhdCAxODowOCwgRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gVGh1LCAyMCBKdWwgMjAyMyBhdCAxNjo1OSwgUGluZ2ZhbiBMaXUg
PHBpbGl1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVsIDIwLCAyMDIzIGF0
IDM6MjfigK9QTSBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IEhpIFBpbmdmYW4sCj4gPiA+Cj4gPiA+IE9uIFRodSwgMjAgSnVsIDIwMjMgYXQgMTA6MDUs
IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IEhp
IERhdmUsCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgaW5zaWdodC4gUGxlYXNlIHNl
ZSB0aGUgY29tbWVudHMgaW5saW5lIGJlbG93Lgo+ID4gPiA+Cj4gPiA+ID4gT24gV2VkLCBKdWwg
MTksIDIwMjMgYXQgMTE6MDDigK9BTSBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSGkgUGluZ2ZhbiwgU2ltb24sCj4gPiA+ID4gPgo+ID4g
PiA+ID4gT24gMDcvMTcvMjMgYXQgMDk6MDdwbSwgUGluZ2ZhbiBMaXUgd3JvdGU6Cj4gPiA+ID4g
PiA+IEFzIG1vcmUgY29tcGxpY2F0ZWQgY2Fwc3VsZSBrZXJuZWwgZm9ybWF0IG9jY3VycyBsaWtl
IHpib290LCB3aGVyZSB0aGUKPiA+ID4gPiA+ID4gY29tcHJlc3NlZCBrZXJuZWwgaXMgc3RvcmVk
IGFzIGEgcGF5bG9hZC4gVGhlIHN0cmFpZ2h0IGZvcndhcmQKPiA+ID4gPiA+ID4gZGVjb21wcmVz
c2lvbiBjYW4gbm90IG1lZXQgdGhlIGRlbWFuZC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQXMg
dGhlIGZpcnN0IHN0ZXAsIG9uIGFhcmNoNjQsIHJlYWRpbmcgaW4gdGhlIGtlcm5lbCBmaWxlIGlu
IGEgcHJvYmUKPiA+ID4gPiA+ID4gbWV0aG9kIGFuZCBkZWNpZGUgaG93IHRvIHVuZm9sZCB0aGUg
Y29udGVudCBieSB0aGUgbWV0aG9kIGl0c2VsZi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhp
cyBzZXJpZXMgaW50cm9kdWNlIGEgbmV3IGltYWdlIHByb2JlIGludGVyZmFjZSBwcm9iZTIoKSwg
d2hpY2gKPiA+ID4gPiA+ID4gcmV0dXJucyB0aHJlZSBmYWN0b3JzOiBrZXJuZWwgYnVmZmVyLCBr
ZXJuZWwgc2l6ZSBhbmQga2VybmVsIGZkIHRocm91Z2gKPiA+ID4gPiA+ID4gYSBzdHJ1Y3QgcGFy
c2VkX2luZm8uCj4gPiA+ID4gPiA+IC0xLiB0aGUgcGFyc2VkIGtlcm5lbF9idWYgc2hvdWxkIGJl
IHJldHVybmVkIHNvIHRoYXQgaXQgY2FuIGJlIHVzZWQgYnkKPiA+ID4gPiA+ID4gdGhlIGltYWdl
IGxvYWQgbWV0aG9kIGxhdGVyLgo+ID4gPiA+ID4gPiAtMi4gdGhlIGZpbmFsIGZkIHBhc3NlZCB0
byBzeXNfa2V4ZWNfZmlsZV9sb2FkLCBzaW5jZSBhYXJjaDY0IGtlcm5lbCBjYW4KPiA+ID4gPiA+
ID4gb25seSB3b3JrIHdpdGggSW1hZ2UgZm9ybWF0LCB0aGUgb3V0ZXIgcGF5bG9hZCBzaG91bGQg
YmUgc3RyaXBwZWQgYW5kIGEKPiA+ID4gPiA+ID4gdGVtcG9yYXJ5IGZpbGUgb2YgSW1hZ2Ugc2hv
dWxkIGJlIGNyZWF0ZWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUg
SW1hZ2UuZ3ogZmlsZSBsb2FkIGNvZGUsIHRoZSBjdXJyZW50IGNvZGUgY2FuIGJlCj4gPiA+ID4g
PiBzaW1wbGlmaWVkIHdpdGggcGFzc2luZyBhIGZkIGRpcmVjdGx5IGluc3RlYWQgb2YgY3JlYXRp
bmcgdGVtcCBmaWxlcyB2aWEKPiA+ID4gPiA+IG1lbWZkX2NyZWF0ZSB3aXRoIHRoZSBhbHJlYWR5
IGRlY29tcHJlc3NlZCBrZXJuZWxfYnVmLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBjdXJyZW50
IGZpbGUgbG9hZCBpcyBsaWtlIGJlbG93Ogo+ID4gPiA+ID4KPiA+ID4gPiA+IGRvX2tleGVjX2Zp
bGVfbG9hZCgpOgo+ID4gPiA+ID4gICAxLnNsdXJwX2RlY29tcHJlc3NfZmlsZQo+ID4gPiA+ID4g
ICAgIDIuIHByb2JlCj4gPiA+ID4gPiAgICAgICAzLiBsb2FkCj4gPiA+ID4gPiAgICAgICAgIDQu
IGtleGVjX2ZpbGVfbG9hZAo+ID4gPiA+ID4KPiA+ID4gPiA+IEluIHN0ZXAgMSwgdGhlIEltYWdl
Lmd6IGhhcyBiZWVuIGRlY29tcHJlc3NlZCB0byBrZXJuZWxfYnVmLCBzbyBqdXN0Cj4gPiA+ID4g
PiBjcmVhdGUgYSB2aXJ0dWFsIG1lbWZkIGNvcHkgdG8gaXQsIHRoZW4gc2F2ZSB0aGUgdmlydHVh
bCBmZCBmb3Igc3RlcCA0Cj4gPiA+ID4gPiB1c2UuCj4gPiA+ID4gPgo+ID4gPiA+ID4gT3RoZXJ3
aXNlIGluIHN0ZXAgMiBpdCBpcyBzb21lIHNhbml0eSBjaGVja2luZywgc3RlcCAzIGlzIHNldHRp
bmcKPiA+ID4gPiA+IHNvbWV0aGluZyBlbHNlIGVnLiBpbml0cmRfZmQsIGNtZGxpbmUuIFdpdGgg
dGhlIGNoYW5nZXMgYmVsb3cgSW1hZ2UgYW5kCj4gPiA+ID4gPiBJbWFnZS5neiB3aWxsIHNoYXJl
IHNhbWUgY29kZS4gSSB0aGluayB5b3UgY2FuIGFkZCB0aGUgemJvb3QKPiA+ID4gPiA+IGRldGVj
dGlvbi9jaGVja2luZyBjb2RlIGluIHRoZSBJbWFnZSBwcm9iZSwgbG9hZCBmdW5jdGlvbnMsIHdp
dGggYSBuZXcKPiA+ID4gPiA+IGluZm8tPmtlcm5lbF9mZCwgeW91IGNhbiBkZWNvbXByZXNzIHRo
ZSB6Ym9vdCBrZXJuZWxfYnVmIGFuZCBzYXZlIHRvCj4gPiA+ID4gPiBhbm90aGVyIHZpcnR1YWwg
bWVtZmQsIGFuZCBzZXQgdG8gdGhlIGluZm8tPmtlcm5lbF9mZC4gIFRoZW4gaW4gc3RlcCA0Cj4g
PiA+ID4gPiB0aGUga2V4ZWNfZmlsZV9sb2FkIGNhbiBqdXN0IHVzZSBpdC4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiBUaGlzIG9ubHkgcmVzdWx0cyBpbiBhIG1pbm9yIGNoYW5nZSBpbiB0aGUg
aW50ZXJmYWNlLCBub3QgbGlrZSBtaW5lLiBJCj4gPiA+ID4gcHJlZmVyIHRoaXMgbWV0aG9kLgo+
ID4gPiA+Cj4gPiA+ID4gPiBUaGUga2VybmVsX2J1ZiBpdHNlbGYgaXMgb25seSB1c2VkIGZvciBz
YW5pdHkgY2hlY2tpbmcgb2YgdGhlIGZvcm1hdHMsCj4gPiA+ID4gPiBrZXJuZWwgb25seSBuZWVk
cyBhIGZpbGUgZmQsIHNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUgYW5kIGVhc2llcgo+ID4g
PiA+ID4gdGhhbiB0aGUgb3JpZ2luYWwgd2F5cy4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBP
dmVyYWxsLCB0aGlzIG5ldyBtZXRob2QgbWluaW1hbGx5IGFmZmVjdHMgdGhlIGZ1bmN0aW9uIGlu
dGVyZmFjZSwgaW4KPiA+ID4gPiBhZGRpdGlvbiB0byB0aGUgY29kZSBzaW1wbGlmaWNhdGlvbi4K
PiA+ID4gPiBJIHdpbGwgdHJ5IHRvIHRha2UgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4KPiA+ID4g
Pgo+ID4gPiBPaywgZ3JlYXQuICBCdHcsIGl0IHdvdWxkIGJlIGlkZWFsIGlmIHNvbWUgb2YgdGhl
IHBlel9wcmVwYXJlIHdvcmsgY2FuCj4gPiA+IGJlIGRvbmUgZWFybHkgYmVmb3JlIHRoZSBzbHVy
cF9kZWNvbXByZXNzX2ZpbGUgaW4KPiA+ID4gZG9fa2V4ZWNfZmlsZV9sb2FkKCksIHRoZW4gaXQg
Y291bGQgYmUganVzdCBhcmNoIGluZGVwZW5kZW50IDopCj4gPiA+Cj4gPgo+ID4gSSBhc3N1bWUg
dGhhdCB5b3Ugc3VnZ2VzdCB0aGUgZm9sbG93aW5nIGJpZyBwaWN0dXJlOgo+ID4gICAgIGlmIHRy
eWluZyBzbHVycF9kZWNvbXByZXNzX2ZpbGUoKQo+ID4gICAgIGVsc2UgdHJ5aW5nIHBlel9wcmVw
YXJlKCkKPiA+ICAgICBmb3IgKGkgPSAwOyBpIDwgZmlsZV90eXBlczsgaSsrKSB7Cj4gPiAgICAg
ICBpZiAoZmlsZV90eXBlW2ldLnByb2JlKGtlcm5lbF9idWYsIGtlcm5lbF9zaXplKSA+PSAwKQo+
ID4gICAgfQo+ID4KPiA+IEJ1dCB0aGVyZSBpcyBzb21lIGNoZWNrIGJlZm9yZSBwZXpfcHJlcGFy
ZSgpIGluIHBlel9hcm02NF9wcm9iZSgpLCBJCj4gPiBhbSBub3Qgc3VyZSB3aGV0aGVyIHRoZXkg
Y2FuIGJlIHNraXBwZWQgb3Igbm90Lgo+Cj4gT2ssIGdvdCBpdCwgaWYgdGhlIHppbWFnZSBoZWFk
ZXIgb2YgYXJtNjQgaXMgYXJjaCBzcGVjaWZpYyAsIGl0IHNob3VsZAoKcy96aW1hZ2UvemJvb3QK
Cj4gc3RpbGwgZ28gdG8gdGhlIGFyY2ggcGFydC4KPgo+IFRoYW5rcwo+IERhdmUKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
