Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EE3EB64DC
	for <kexec@archiver.kernel.org>; Thu, 20 Jul 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6PaIzqrk+I8DO72TC2s1uB4gg+a6J4b4XT6kmF89HaA=; b=KgxCiobuuDps56
	54aakgVUUJGp4QaE0cABcUjtuuckM+asxGOKxckHnRtHkakwVatrCUi+4VKN1A2iuDU2toEDNQvdK
	LGqucDhxaNkxfpchMONSV3zEGPO2feATApRBcBWXiH1YU8Eil1c/wvkhCPvlSXMBk5138Pd8W+gSF
	SHMyK8KFChyiXjnATDI5CzFv97MsMTEr737E2NLbKme0pj5TbLO1MeRPy+hwI/4tM5d2u5u35CIM4
	xv9jn0bGDXT7earXMx57Uf8s5LtZHyYzU2QACx/AcT6yOUiBieFijuBwjOWS0f8l8LAKK+OECtoRI
	uY3FHA1NscN2apafgEgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMPX0-00AQz0-3C;
	Thu, 20 Jul 2023 09:01:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMPWx-00AQxa-13
	for kexec@lists.infradead.org;
	Thu, 20 Jul 2023 09:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689843660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHZ5DhM0AbiOQFELasG6Jcnejj0TAOEuoeJ9t84VyyI=;
	b=KjD9gyPQ2aJO3pNTjMq8XMTIn8vERpwVbjdcXX5stWVnFYlo1zPM/wfwmjZC/sFNFC++Y1
	bpV10Gzu1+MvT7JqcyOPS4am8szgjEc40LMxniRvRscvT5mLDlzbZSiu5aIpuMieM1GBFS
	YeZzF5iaoDIQD91VOMFJJyZt9+FFsEw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-e17pOJA3PfiaCVuSTqAEFQ-1; Thu, 20 Jul 2023 04:59:43 -0400
X-MC-Unique: e17pOJA3PfiaCVuSTqAEFQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7683da3e2a5so95643385a.3
        for <kexec@lists.infradead.org>; Thu, 20 Jul 2023 01:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843583; x=1692435583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHZ5DhM0AbiOQFELasG6Jcnejj0TAOEuoeJ9t84VyyI=;
        b=DPb3a4SaQc9SiPRnkcLK0068gY0GPoVrTsAKZ9wLI4RTuPl1VB2SzOiOX9v85YPtgX
         znT+Lz2QPXBysIpY7yu48U0LHKr3/NHoHWoUVhwbljHdwYuDusS7v41eXPkMW5bFlA71
         WaVGGiejjn759z/aXs2DgsuQMywvQyTBHbsnh7CnV+g8c7dOVwmR94y0jH0ONZVRAmd2
         2sNJnY1V2ArF7VivPlWYyzoWK76/EvP1ZTERP7QNROpbfBlWvwTDklKtfSjGaMA2gWIo
         Y0yDTvJp964+ZRK/dHPfpzh20Jh9Cl4pC/AcRaEbidvYzGVyxbi1c7K8z0xVa1G4Hs98
         uzqg==
X-Gm-Message-State: ABy/qLafmn77GU45J6zcosqEyqD05aoQR+DV5ieoZ8VDxDftOoNaKRRQ
	HOL1+SOiUQxPZ63bTrSWifRQlKiMaGY88ROnkohwTcIfAKJblSsiPbYFnkjU/gW981oeQJQvrYh
	bFE73zRZjLa88OomohoCozn36J1bLSGqANFj4
X-Received: by 2002:a0c:eb8a:0:b0:625:bb19:278c with SMTP id x10-20020a0ceb8a000000b00625bb19278cmr7462321qvo.2.1689843582894;
        Thu, 20 Jul 2023 01:59:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVNNw/VjLBcDnwVyPxxuKvFh/UiR7bzvHIx+enyv+3ZntXy/DRWhc5qRWkST47d1MY94a9O66rf2AAQQG59io=
X-Received: by 2002:a0c:eb8a:0:b0:625:bb19:278c with SMTP id
 x10-20020a0ceb8a000000b00625bb19278cmr7462285qvo.2.1689843581677; Thu, 20 Jul
 2023 01:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230717130732.22710-1-piliu@redhat.com> <ZLdSMPJ9LxxFHCrO@darkstar.users.ipa.redhat.com>
 <CAF+s44SZSX5H_UkTjauHkxZwWRBTJ0vD6a_AqEfTxBioJ6ioTQ@mail.gmail.com> <CALu+AoQMib-=w3mEoaz97Yb-nG=NfgLJswifUh834duu3rnj+A@mail.gmail.com>
In-Reply-To: <CALu+AoQMib-=w3mEoaz97Yb-nG=NfgLJswifUh834duu3rnj+A@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 20 Jul 2023 16:59:30 +0800
Message-ID: <CAF+s44QVbpb=upCqY6n_FSo6QAhv6=eLNCXwz1Jng6wW75KLXQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/8] arm64: zboot support
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_020103_444209_DD5C4B8D 
X-CRM114-Status: GOOD (  34.32  )
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

T24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMzoyN+KAr1BNIERhdmUgWW91bmcgPGR5b3VuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IEhpIFBpbmdmYW4sCj4KPiBPbiBUaHUsIDIwIEp1bCAyMDIzIGF0
IDEwOjA1LCBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkg
RGF2ZSwKPiA+Cj4gPiBUaGFua3MgZm9yIHlvdXIgaW5zaWdodC4gUGxlYXNlIHNlZSB0aGUgY29t
bWVudHMgaW5saW5lIGJlbG93Lgo+ID4KPiA+IE9uIFdlZCwgSnVsIDE5LCAyMDIzIGF0IDExOjAw
4oCvQU0gRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBI
aSBQaW5nZmFuLCBTaW1vbiwKPiA+ID4KPiA+ID4gT24gMDcvMTcvMjMgYXQgMDk6MDdwbSwgUGlu
Z2ZhbiBMaXUgd3JvdGU6Cj4gPiA+ID4gQXMgbW9yZSBjb21wbGljYXRlZCBjYXBzdWxlIGtlcm5l
bCBmb3JtYXQgb2NjdXJzIGxpa2UgemJvb3QsIHdoZXJlIHRoZQo+ID4gPiA+IGNvbXByZXNzZWQg
a2VybmVsIGlzIHN0b3JlZCBhcyBhIHBheWxvYWQuIFRoZSBzdHJhaWdodCBmb3J3YXJkCj4gPiA+
ID4gZGVjb21wcmVzc2lvbiBjYW4gbm90IG1lZXQgdGhlIGRlbWFuZC4KPiA+ID4gPgo+ID4gPiA+
IEFzIHRoZSBmaXJzdCBzdGVwLCBvbiBhYXJjaDY0LCByZWFkaW5nIGluIHRoZSBrZXJuZWwgZmls
ZSBpbiBhIHByb2JlCj4gPiA+ID4gbWV0aG9kIGFuZCBkZWNpZGUgaG93IHRvIHVuZm9sZCB0aGUg
Y29udGVudCBieSB0aGUgbWV0aG9kIGl0c2VsZi4KPiA+ID4gPgo+ID4gPiA+IFRoaXMgc2VyaWVz
IGludHJvZHVjZSBhIG5ldyBpbWFnZSBwcm9iZSBpbnRlcmZhY2UgcHJvYmUyKCksIHdoaWNoCj4g
PiA+ID4gcmV0dXJucyB0aHJlZSBmYWN0b3JzOiBrZXJuZWwgYnVmZmVyLCBrZXJuZWwgc2l6ZSBh
bmQga2VybmVsIGZkIHRocm91Z2gKPiA+ID4gPiBhIHN0cnVjdCBwYXJzZWRfaW5mby4KPiA+ID4g
PiAtMS4gdGhlIHBhcnNlZCBrZXJuZWxfYnVmIHNob3VsZCBiZSByZXR1cm5lZCBzbyB0aGF0IGl0
IGNhbiBiZSB1c2VkIGJ5Cj4gPiA+ID4gdGhlIGltYWdlIGxvYWQgbWV0aG9kIGxhdGVyLgo+ID4g
PiA+IC0yLiB0aGUgZmluYWwgZmQgcGFzc2VkIHRvIHN5c19rZXhlY19maWxlX2xvYWQsIHNpbmNl
IGFhcmNoNjQga2VybmVsIGNhbgo+ID4gPiA+IG9ubHkgd29yayB3aXRoIEltYWdlIGZvcm1hdCwg
dGhlIG91dGVyIHBheWxvYWQgc2hvdWxkIGJlIHN0cmlwcGVkIGFuZCBhCj4gPiA+ID4gdGVtcG9y
YXJ5IGZpbGUgb2YgSW1hZ2Ugc2hvdWxkIGJlIGNyZWF0ZWQuCj4gPiA+Cj4gPiA+IEkgdG9vayBh
IGxvb2sgYXQgdGhlIEltYWdlLmd6IGZpbGUgbG9hZCBjb2RlLCB0aGUgY3VycmVudCBjb2RlIGNh
biBiZQo+ID4gPiBzaW1wbGlmaWVkIHdpdGggcGFzc2luZyBhIGZkIGRpcmVjdGx5IGluc3RlYWQg
b2YgY3JlYXRpbmcgdGVtcCBmaWxlcyB2aWEKPiA+ID4gbWVtZmRfY3JlYXRlIHdpdGggdGhlIGFs
cmVhZHkgZGVjb21wcmVzc2VkIGtlcm5lbF9idWYuCj4gPiA+Cj4gPiA+IFRoZSBjdXJyZW50IGZp
bGUgbG9hZCBpcyBsaWtlIGJlbG93Ogo+ID4gPgo+ID4gPiBkb19rZXhlY19maWxlX2xvYWQoKToK
PiA+ID4gICAxLnNsdXJwX2RlY29tcHJlc3NfZmlsZQo+ID4gPiAgICAgMi4gcHJvYmUKPiA+ID4g
ICAgICAgMy4gbG9hZAo+ID4gPiAgICAgICAgIDQuIGtleGVjX2ZpbGVfbG9hZAo+ID4gPgo+ID4g
PiBJbiBzdGVwIDEsIHRoZSBJbWFnZS5neiBoYXMgYmVlbiBkZWNvbXByZXNzZWQgdG8ga2VybmVs
X2J1Ziwgc28ganVzdAo+ID4gPiBjcmVhdGUgYSB2aXJ0dWFsIG1lbWZkIGNvcHkgdG8gaXQsIHRo
ZW4gc2F2ZSB0aGUgdmlydHVhbCBmZCBmb3Igc3RlcCA0Cj4gPiA+IHVzZS4KPiA+ID4KPiA+ID4g
T3RoZXJ3aXNlIGluIHN0ZXAgMiBpdCBpcyBzb21lIHNhbml0eSBjaGVja2luZywgc3RlcCAzIGlz
IHNldHRpbmcKPiA+ID4gc29tZXRoaW5nIGVsc2UgZWcuIGluaXRyZF9mZCwgY21kbGluZS4gV2l0
aCB0aGUgY2hhbmdlcyBiZWxvdyBJbWFnZSBhbmQKPiA+ID4gSW1hZ2UuZ3ogd2lsbCBzaGFyZSBz
YW1lIGNvZGUuIEkgdGhpbmsgeW91IGNhbiBhZGQgdGhlIHpib290Cj4gPiA+IGRldGVjdGlvbi9j
aGVja2luZyBjb2RlIGluIHRoZSBJbWFnZSBwcm9iZSwgbG9hZCBmdW5jdGlvbnMsIHdpdGggYSBu
ZXcKPiA+ID4gaW5mby0+a2VybmVsX2ZkLCB5b3UgY2FuIGRlY29tcHJlc3MgdGhlIHpib290IGtl
cm5lbF9idWYgYW5kIHNhdmUgdG8KPiA+ID4gYW5vdGhlciB2aXJ0dWFsIG1lbWZkLCBhbmQgc2V0
IHRvIHRoZSBpbmZvLT5rZXJuZWxfZmQuICBUaGVuIGluIHN0ZXAgNAo+ID4gPiB0aGUga2V4ZWNf
ZmlsZV9sb2FkIGNhbiBqdXN0IHVzZSBpdC4KPiA+ID4KPiA+Cj4gPiBUaGlzIG9ubHkgcmVzdWx0
cyBpbiBhIG1pbm9yIGNoYW5nZSBpbiB0aGUgaW50ZXJmYWNlLCBub3QgbGlrZSBtaW5lLiBJCj4g
PiBwcmVmZXIgdGhpcyBtZXRob2QuCj4gPgo+ID4gPiBUaGUga2VybmVsX2J1ZiBpdHNlbGYgaXMg
b25seSB1c2VkIGZvciBzYW5pdHkgY2hlY2tpbmcgb2YgdGhlIGZvcm1hdHMsCj4gPiA+IGtlcm5l
bCBvbmx5IG5lZWRzIGEgZmlsZSBmZCwgc28gSSB0aGluayBpdCBzaG91bGQgYmUgZmluZSBhbmQg
ZWFzaWVyCj4gPiA+IHRoYW4gdGhlIG9yaWdpbmFsIHdheXMuCj4gPiA+Cj4gPgo+ID4gT3ZlcmFs
bCwgdGhpcyBuZXcgbWV0aG9kIG1pbmltYWxseSBhZmZlY3RzIHRoZSBmdW5jdGlvbiBpbnRlcmZh
Y2UsIGluCj4gPiBhZGRpdGlvbiB0byB0aGUgY29kZSBzaW1wbGlmaWNhdGlvbi4KPiA+IEkgd2ls
bCB0cnkgdG8gdGFrZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4KPiBPaywgZ3JlYXQuICBC
dHcsIGl0IHdvdWxkIGJlIGlkZWFsIGlmIHNvbWUgb2YgdGhlIHBlel9wcmVwYXJlIHdvcmsgY2Fu
Cj4gYmUgZG9uZSBlYXJseSBiZWZvcmUgdGhlIHNsdXJwX2RlY29tcHJlc3NfZmlsZSBpbgo+IGRv
X2tleGVjX2ZpbGVfbG9hZCgpLCB0aGVuIGl0IGNvdWxkIGJlIGp1c3QgYXJjaCBpbmRlcGVuZGVu
dCA6KQo+CgpJIGFzc3VtZSB0aGF0IHlvdSBzdWdnZXN0IHRoZSBmb2xsb3dpbmcgYmlnIHBpY3R1
cmU6CiAgICBpZiB0cnlpbmcgc2x1cnBfZGVjb21wcmVzc19maWxlKCkKICAgIGVsc2UgdHJ5aW5n
IHBlel9wcmVwYXJlKCkKICAgIGZvciAoaSA9IDA7IGkgPCBmaWxlX3R5cGVzOyBpKyspIHsKICAg
ICAgaWYgKGZpbGVfdHlwZVtpXS5wcm9iZShrZXJuZWxfYnVmLCBrZXJuZWxfc2l6ZSkgPj0gMCkK
ICAgfQoKQnV0IHRoZXJlIGlzIHNvbWUgY2hlY2sgYmVmb3JlIHBlel9wcmVwYXJlKCkgaW4gcGV6
X2FybTY0X3Byb2JlKCksIEkKYW0gbm90IHN1cmUgd2hldGhlciB0aGV5IGNhbiBiZSBza2lwcGVk
IG9yIG5vdC4KCkJUVywgSSBoYXZlIGEgcHJldmlldyB2ZXJzaW9uLCB3aGljaCB0YWtlcyBpbiB5
b3VyIHBhdGNoIGF0Cmh0dHBzOi8vZ2l0aHViLmNvbS9wZmxpdS9rZXhlYy10b29scywgYnJhbmNo
OiB6Ym9vdFY2LgoKClRoYW5rcywKClBpbmdmYW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
