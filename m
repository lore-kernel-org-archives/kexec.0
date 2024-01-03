Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC6CC47073
	for <kexec@archiver.kernel.org>; Wed,  3 Jan 2024 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i4dRzHzld0//S80UlIY9DwOwSc55lmzf+l4f1FunJHU=; b=t8FT4wrAsIt5KD
	wjQrgdJ+XNTrI94QCJIhMfoQhJa32gbzZ+Esy92JsNU68DKWqqyJvu6ee4BGOTLNbgYXTLnIPeJZj
	LfclRpcRUBjGxo8ybWPH2vSyefAm63Qe79AcKeuLBQAhmcXLEbwsJGrVyR1dzUIar+WlykGa+Fa1i
	p0rzrbCfW+kXBTH4vfWHbcn1dayR+inFCD+f31qXw7vfNjQlx3MIhKeV9cIiDzAJLaJ2dkMS66pvq
	OqsADp4l6u97MLx1a8o9kGYlbBZ6y94lq7nxEF227WNBNdS2CL5EpptacRQAjSv9XcKrh/z08xqme
	vFXrGvesYXlfpWhmL+3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL6Ir-00BpXl-2f;
	Wed, 03 Jan 2024 18:49:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL6In-00BpVs-03;
	Wed, 03 Jan 2024 18:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5FC1BCE17FD;
	Wed,  3 Jan 2024 18:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7C5C433D9;
	Wed,  3 Jan 2024 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704307752;
	bh=RMZCoyni1dg/u5PWGXOjNR0UmnG/FzeuF8AtWgpE53o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QWx1LZ2PIbiMG1XZqGmr22SPfJH41Dy22FvwvzfIv4KyUPRrF5q8WzXYnLQd9rs86
	 yL9ePwqcN1S1rRlB/biKp0ukhEFgmop2NIjmL5EOxem1NomAWFjolJWxrSQqZzWr8x
	 ELxW+cJ9NFuIupoCwP1JzeF0+Ju7CBhcyieXXWz28QBbjF+H9pFE7wpQi6sKHyGWLo
	 L2y3ySPb30L7oKKU6Z2zM2pPhlsfPKq1GXfNqbTtfspFz63rKyw/qVLr48k/p6PbfD
	 eF9JrBEGat+1z6GrQFq5ndH7z1VnyfJDiHgpQPidNftQNKdMLg38oO/rYLRh2LwOOF
	 4/LJj9oAZ5qwg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd08f0c12aso23920181fa.0;
        Wed, 03 Jan 2024 10:49:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxMUCE1NJ2RzpcVN/leNFOk3nKMw4Gdt5APYz0wcQFmvlzTWf8K
	53QT9uZ49nFo3vblzyG/aUNgVHKV57IbD7LEPw==
X-Google-Smtp-Source: AGHT+IFb3zTv3w6i/eFBsPe9r0iuXmmX/2JiP7xGNWZZFBabGYb5yb23iDV40OA8jh6BzQ1/gm/DPrOco/LCOyYOSFg=
X-Received: by 2002:a05:651c:168f:b0:2cc:6dff:9383 with SMTP id
 bd15-20020a05651c168f00b002cc6dff9383mr5104245ljb.83.1704307750860; Wed, 03
 Jan 2024 10:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20231222193607.15474-1-graf@amazon.com> <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-2-graf@amazon.com>
In-Reply-To: <20231222195144.24532-2-graf@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 11:48:58 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
Message-ID: <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, x86@kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	James Gowans <jgowans@amazon.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, 
	madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_104917_414104_6B50426E 
X-CRM114-Status: GOOD (  34.55  )
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

T24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMTI6NTLigK9QTSBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBh
bWF6b24uY29tPiB3cm90ZToKPgo+IFdpdGggS0hPIGluIHBsYWNlLCBsZXQncyBhZGQgZG9jdW1l
bnRhdGlvbiB0aGF0IGRlc2NyaWJlcyB3aGF0IGl0IGlzIGFuZAo+IGhvdyB0byB1c2UgaXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+IC0tLQo+
ICBEb2N1bWVudGF0aW9uL2toby9jb25jZXB0cy5yc3QgICB8IDg4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gIERvY3VtZW50YXRpb24va2hvL2luZGV4LnJzdCAgICAgIHwgMTkg
KysrKysrKwo+ICBEb2N1bWVudGF0aW9uL2toby91c2FnZS5yc3QgICAgICB8IDU3ICsrKysrKysr
KysrKysrKysrKysrKwo+ICBEb2N1bWVudGF0aW9uL3N1YnN5c3RlbS1hcGlzLnJzdCB8ICAxICsK
PiAgNCBmaWxlcyBjaGFuZ2VkLCAxNjUgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9raG8vY29uY2VwdHMucnN0Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2toby9pbmRleC5yc3QKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24va2hvL3VzYWdlLnJzdAo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24va2hvL2Nv
bmNlcHRzLnJzdCBiL0RvY3VtZW50YXRpb24va2hvL2NvbmNlcHRzLnJzdAo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZTRmZThjNTc4NjUKPiAtLS0gL2Rldi9u
dWxsCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9raG8vY29uY2VwdHMucnN0Cj4gQEAgLTAsMCArMSw4
OCBAQAo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsK
PiArPT09PT09PT09PT09PT09PT09PT09PT0KPiArS2V4ZWMgSGFuZG92ZXIgQ29uY2VwdHMKPiAr
PT09PT09PT09PT09PT09PT09PT09PT0KPiArCj4gK0tleGVjIEhhbmRPdmVyIChLSE8pIGlzIGEg
bWVjaGFuaXNtIHRoYXQgYWxsb3dzIExpbnV4IHRvIHByZXNlcnZlIHN0YXRlIC0KPiArYXJiaXRy
YXJ5IHByb3BlcnRpZXMgYXMgd2VsbCBhcyBtZW1vcnkgbG9jYXRpb25zIC0gYWNyb3NzIGtleGVj
Lgo+ICsKPiArSXQgaW50cm9kdWNlcyBtdWx0aXBsZSBjb25jZXB0czoKPiArCj4gK0tITyBEZXZp
Y2UgVHJlZQo+ICstLS0tLS0tLS0tLS0tLS0KPiArCj4gK0V2ZXJ5IEtITyBrZXhlYyBjYXJyaWVz
IGEgS0hPIHNwZWNpZmljIGZsYXR0ZW5lZCBkZXZpY2UgdHJlZSBibG9iIHRoYXQKPiArZGVzY3Jp
YmVzIHRoZSBzdGF0ZSBvZiB0aGUgc3lzdGVtLiBEZXZpY2UgZHJpdmVycyBjYW4gcmVnaXN0ZXIg
dG8gS0hPIHRvCj4gK3NlcmlhbGl6ZSB0aGVpciBzdGF0ZSBiZWZvcmUga2V4ZWMuIEFmdGVyIEtI
TywgZGV2aWNlIGRyaXZlcnMgY2FuIHJlYWQKPiArdGhlIGRldmljZSB0cmVlIGFuZCBleHRyYWN0
IHByZXZpb3VzIHN0YXRlLgoKSG93IGRvZXMgdGhpcyB3b3JrIHdpdGgga2V4ZWMgd2hlbiB0aGVy
ZSBpcyBhbHNvIHRoZSBGRFQgZm9yIHRoZSBoL3c/ClRoZSBoL3cgRkRUIGhhcyBhIC9jaG9zZW4g
cHJvcGVydHkgcG9pbnRpbmcgdG8gdGhpcyBGRFQgYmxvYj8KCj4gKwo+ICtLSE8gb25seSB1c2Vz
IHRoZSBmZHQgY29udGFpbmVyIGZvcm1hdCBhbmQgbGliZmR0IGxpYnJhcnksIGJ1dCBkb2VzIG5v
dAo+ICthZGhlcmUgdG8gdGhlIHNhbWUgcHJvcGVydHkgc2VtYW50aWNzIHRoYXQgbm9ybWFsIGRl
dmljZSB0cmVlcyBkbzogUHJvcGVydGllcwo+ICthcmUgcGFzc2VkIGluIG5hdGl2ZSBlbmRpYW5u
ZXNzIGFuZCBzdGFuZGFyZGl6ZWQgcHJvcGVydGllcyBsaWtlIGBgcmVnc2BgIGFuZAo+ICtgYHJh
bmdlc2BgIGRvIG5vdCBleGlzdCwgaGVuY2UgdGhlcmUgYXJlIG5vIGBgIy4uLi1jZWxsc2BgIHBy
b3BlcnRpZXMuCgpJIHRoaW5rIG5hdGl2ZSBlbmRpYW5uZXNzIGlzIGFza2luZyBmb3IgdHJvdWJs
ZS4gbGliZmR0IHdvdWxkIG5lZWQKZGlmZmVyZW50IHN3YXAgZnVuY3Rpb25zIGhlcmUgdGhhbiBl
bHNld2hlcmUgaW4gdGhlIGtlcm5lbCBmb3IgZXhhbXBsZQp3aGljaCB3b3VsZG4ndCBldmVuIHdv
cmsuIFNvIHlvdSBhcmUganVzdCBjcm9zc2luZyB5b3VyIGZpbmdlcnMgdGhhdAp5b3UgYXJlbid0
IHVzaW5nIGFueSBsaWJmZHQgZnVuY3Rpb25zIHRoYXQgc3dhcC4gQW5kIHdoZW4gSSBzeW5jCmR0
Yy9saWJmZHQgYW5kIHRoYXQgY2hhbmdlcywgSSBtaWdodCBicmVhayB5b3UuCgpBbHNvLCBpZiB5
b3Ugd2FudCB0byBkdW1wIHRoZSBGRFQgYW5kIGRvIGEgZHRjIERUQi0+RFRTIHBhc3MsIGl0IGlz
Cm5vdCBnb2luZyB0byBiZSB0b28gcmVhZGFibGUgZ2l2ZW4gdGhhdCBvdXRwdXRzIHN3YXBwZWQg
MzItYml0IHZhbHVlcwpmb3IgYW55dGhpbmcgdGhhdCdzIGEgNCBieXRlIG11bHRpcGxlLgoKPiAr
Cj4gK0tITyBpbnRyb2R1Y2VzIGEgbmV3IGNvbmNlcHQgdG8gaXRzIGRldmljZSB0cmVlOiBgYG1l
bWBgIHByb3BlcnRpZXMuIEEKPiArYGBtZW1gYCBwcm9wZXJ0eSBjYW4gaW5zaWRlIGFueSBzdWJu
b2RlIGluIHRoZSBkZXZpY2UgdHJlZS4gV2hlbiBwcmVzZW50LAo+ICtpdCBjb250YWlucyBhbiBh
cnJheSBvZiBwaHlzaWNhbCBtZW1vcnkgcmFuZ2VzIHRoYXQgdGhlIG5ldyBrZXJuZWwgbXVzdCBt
YXJrCj4gK2FzIHJlc2VydmVkIG9uIGJvb3QuIEl0IGlzIHJlY29tbWVuZGVkLCBidXQgbm90IHJl
cXVpcmVkLCB0byBtYWtlIHRoZXNlIHJhbmdlcwo+ICthcyBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMg
YXMgcG9zc2libGUgdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgYXJyYXkgZWxlbWVudHMgOjoKPiAr
Cj4gKyAgICBzdHJ1Y3Qga2hvX21lbSB7Cj4gKyAgICAgICAgICAgIF9fdTY0IGFkZHI7Cj4gKyAg
ICAgICAgICAgIF9fdTY0IGxlbjsKPiArICAgIH07Cj4gKwo+ICtBZnRlciBib290LCBkcml2ZXJz
IGNhbiBjYWxsIHRoZSBraG8gc3Vic3lzdGVtIHRvIHRyYW5zZmVyIG93bmVyc2hpcCBvZiBtZW1v
cnkKPiArdGhhdCB3YXMgcmVzZXJ2ZWQgdmlhIGEgYGBtZW1gYCBwcm9wZXJ0eSB0byB0aGVtc2Vs
dmVzIHRvIGNvbnRpbnVlIHVzaW5nIG1lbW9yeQo+ICtmcm9tIHRoZSBwcmV2aW91cyBleGVjdXRp
b24uCj4gKwo+ICtUaGUgS0hPIGRldmljZSB0cmVlIGZvbGxvd3MgdGhlIGluLUxpbnV4IHNjaGVt
YSByZXF1aXJlbWVudHMuIEFueSBlbGVtZW50IGluCj4gK3RoZSBkZXZpY2UgdHJlZSBpcyBkb2N1
bWVudGVkIHZpYSBkZXZpY2UgdHJlZSBzY2hlbWEgeWFtbHMgdGhhdCBleHBsYWluIHdoYXQKPiAr
ZGF0YSBnZXRzIHRyYW5zZmVycmVkLgoKSWYgdGhpcyBpcyBhbGwgc2VwYXJhdGUsIHRoZW4gSSB0
aGluayB0aGUgc2NoZW1hcyBzaG91bGQgYmUgdG9vLiBBbmQKdGhlbiBmcm9tIG15IChEVCBtYWlu
dGFpbmVyKSBwZXJzcGVjdGl2ZSwgeW91IGNhbiBkbyB3aGF0ZXZlciB5b3Ugd2FudApoZXJlIChs
aWtlIEZJVCBpbWFnZXMpLiBUaGUgZHRzY2hlbWEgdG9vbHMgYXJlIHByZXR0eSBtdWNoIG9ubHkg
Z2VhcmVkCmZvciAibm9ybWFsIiBEVHMuIEEgY291cGxlIG9mIHByb2JsZW1zIGNvbWUgdG8gbWlu
ZC4gWW91IGNhbid0IGV4Y2x1ZGUKb3IgY2hhbmdlIHN0YW5kYXJkIHByb3BlcnRpZXMuIFRoZSBk
ZWNvZGluZyBvZiB0aGUgRFRCIHRvIHJ1bgp2YWxpZGF0aW9uIGFzc3VtZXMgYmlnIGVuZGlhbi4g
V2UgY291bGQgcHJvYmFibHkgc3BsaXQgdGhpbmdzIHVwIGEKYml0LCBidXQgeW91IG1heSBiZSBi
ZXR0ZXIgb2ZmIGp1c3QgdXNpbmcganNvbnNjaGVtYSBkaXJlY3RseS4gSSdtIG5vdApldmVuIHN1
cmUgcnVubmluZyB2YWxpZGF0aW9uIGhlcmUgd291bGQgdGhhdCB2YWx1YWJsZS4gWW91IGhhdmUg
MQpzb3VyY2Ugb2YgY29kZSBnZW5lcmF0aW5nIHRoZSBEVCBhbmQgMSBjb25zdW1lci4gWWVzLCB0
aGVyZSdzCmRpZmZlcmVudCBrZXJuZWwgdmVyc2lvbnMgdG8gZGVhbCB3aXRoLCBidXQgaXQncyBu
b3QgMTAwcyBvZiBwZW9wbGUKY3JlYXRpbmcgMTAwMHMgb2YgRFRzIHdpdGggMTAwcyBvZiBub2Rl
cy4KCllvdSBtaWdodCBsb29rIGF0IHRoZSBuZXRsaW5rIHN0dWZmIHdoaWNoIGlzIHVzaW5nIGl0
cyBvd24geWFtbCBzeW50YXgKdG8gZ2VuZXJhdGUgY29kZSBhbmQganNvbnNjaGVtYSBpcyB1c2Vk
IHRvIHZhbGlkYXRlIHRoZSB5YW1sLgoKUm9iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
