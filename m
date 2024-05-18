Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02322C25B74
	for <kexec@archiver.kernel.org>; Sat, 18 May 2024 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jr7YjrYPQiJL6fd9z9XCwplcBxkymhHBgpPlLoj138=; b=kS1HcnKnXM5lbO
	5GSn2dzMUYxeiLM8KwTgW01Sht6qaeYDG7E02fd0r/cBQ3UAldPb1X7JtR077kwGhOiPFw6JPb91K
	kFqO/wr6GaSdym4x+8e64xfG3Q5MpMhEHxZo59PvjOw62NVFJ46N7BQXhGJjlXVQZrGineaLoZz1N
	VPxUA4r5MIR2TRN3bhwhYuc38GegyD+bYxoPs/cOnrZpmrQ91W07TRHvitmWmTjug/vQ6tFvAv/XA
	IyvIWG+qasILPv3F4MU32DDucMJhWmtPMLTzwhQEoaYy1bi4BABLjx2yXsTu6mx8Y7OHW/CLREYby
	EZhwXoQnLaPGfN74rD/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8FVI-00000009m6a-2SbN;
	Sat, 18 May 2024 08:33:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8FVE-00000009m5X-2vpP
	for kexec@lists.infradead.org;
	Sat, 18 May 2024 08:33:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 24C20CE0907;
	Sat, 18 May 2024 08:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC25C113CC;
	Sat, 18 May 2024 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716021190;
	bh=h19VpEyilEFTF1lf+DKL1kYP9Gd7gJ32jBch2kcKtIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q21WQ6+0oPDgv89jbWbS9SkEg7ju69rK7+lZtXBMIwdj4YzFxX5CWt5B1itTwaQ3W
	 d8E7pZ1qlO6MnfGr3lwA9Ew1Fh3OIFxtq4rPKmGdhYKY18aUgxXKAMWRDjC3JgMwgs
	 KPMgOENcKnqrAcu6vBK05Kpt5iaAp7XuMZTDZBXaAsHhRsxGpe9CyvptikswatSD5S
	 9f87Y/ejRw5KamVaYRi8wgOlyShQtyZx0uoPZRRlpmiG5sRfTDJLzfs4CGLDZl22BA
	 MxGow5B8/AZ5e83HRNQ5Xu+rLB/tqdfF1/CgMFSfFw+bl3hA+Zr+ZjILFu0BgPlIao
	 NOyWz5jHpjiTA==
Date: Sat, 18 May 2024 09:33:04 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Song Shuai <songshuaishuai@tinylab.org>, mick@ics.forth.gr,
	lizhengyu3@huawei.com, liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com, guoren@kernel.org,
	huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com,
	kexec@lists.infradead.org, hursand@fedoraproject.org
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Message-ID: <20240518083304.GD475595@kernel.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org>
 <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
 <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240518_013317_162808_65E22165 
X-CRM114-Status: GOOD (  29.54  )
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

T24gU2F0LCBNYXkgMTgsIDIwMjQgYXQgMTE6Mzk6MThBTSArMDgwMCwgRGF2ZSBZb3VuZyB3cm90
ZToKPiBPbiBXZWQsIDExIE9jdCAyMDIzIGF0IDEzOjI0LCBTb25nIFNodWFpIDxzb25nc2h1YWlz
aHVhaUB0aW55bGFiLm9yZz4gd3JvdGU6Cj4gPgo+ID4KPiA+Cj4gPiDlnKggMjAyMy85LzIwIDE5
OjU2LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+ID4gPiBPbiBGcmksIFNlcCAxNSwgMjAyMyBhdCAx
MTo1MDowNkFNICswODAwLCBTb25nIFNodWFpIHdyb3RlOgo+ID4gPj4gSGksCj4gPiA+Pgo+ID4g
Pj4gVGhpcyBzZXJpZXMgaXMgY3JlYXRlZCB0byBpbXByb3ZlIFJJU0MtViBwb3J0IG9mIGtleGVj
LXRvb2xzLAo+ID4gPj4gYW5kIGlzIGJhc2VkIG9uIHRoZSBob3Jtcy9rZXhlYy10b29sczpidWls
ZC10ZXN0LXJpc2N2LXYyIGJyYW5jaC4KPiA+ID4KPiA+ID4gSW4gbXkgbWluZCB0aGUgYmlnIHF1
ZXN0aW9uIGlzIGhvdyB0byBtb3ZlIFJJU0MtViBzdXBwb3J0Cj4gPiA+IGZyb20gdGhhdCBicmFu
Y2gsIHRvIGJlaW5nIG1lcmdlZCBpbnRvIG1haW4uCj4gPiA+Cj4gPiA+IElJUkMgdGhlcmUgd2Vy
ZSBzb21lIGlzc3VlcyB0aGF0IG5lZWRlZCB0byBiZSBhZGRyZXNzZWQuCj4gPiA+IFBlcmhhcHMg
dGhleSBhcmUgYWxsIGFkZHJlc3NlZCBieSB0aGlzIHNlcmllcywgYW5kIHdpdGgKPiA+ID4gc29t
ZSBhcHByb3ByaWF0ZSBzcXVhc2hpbmcgd2UgY2FuIG1vdmUgZm9yd2FyZHMgd2l0aCBhIHNlcmll
cwo+ID4gPiBiYXNlZCBvbiBtYWluPwo+ID4KPiA+IEhpLCBTaW1vbiBhbmQgTmljazoKPiA+Cj4g
PiBJIHNxdWFzaGVkIHRoZSBmaXJzdCBmb3VyIHBhdGNoZXMgYXMgYSAiUklTQy1WOiBTb21lIGZp
eGVzIGZvciByaXNjdgo+ID4gcG9ydCIgcGF0Y2ggYW5kIHRoZW4gdG9vayB0aGUgaG9ybXMvbWFp
biBhcyB0aGUgYmFzZSB0byBjb2xsZWN0IHRoZSAyCj4gPiBwYXRjaGVzIGZyb20gaG9ybXMvYnVp
bGQtdGVzdC1yaXNjdi12MiBicmFuY2ggYW5kIHRoaXMgc2VyaWVzIHRvZ290aGVyLgo+ID4gVGhl
c2UgYXJlIHRoZSBHaXRodWIgbGluayBhbmQgYWxsIGNvbW1pdHMgZm9yIFJJU0MtVi4KPiA+Cj4g
PiBodHRwczovL2dpdGh1Yi5jb20vc3VnYXJmaWxsZXQva2V4ZWMtdG9vbHMvY29tbWl0cy9tYWlu
X3J2Cj4gPgo+ID4gNWRjMTMzZSBSSVNDLVY6IFN1cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5hcnkg
ZmlsZQo+ID4gYjA0MmY2ZCBSSVNDLVY6IFNlcGFyYXRlIGVsZl9yaXNjdl9maW5kX3BiYXNlIG91
dAo+ID4gOGYzNDRjNyBSSVNDLVY6IEVuYWJsZSBrZXhlY19maWxlX2xvYWQgc3lzY2FsbAo+ID4g
N2Q0Yjk4MiBSSVNDLVY6IFNvbWUgZml4ZXMgZm9yIHJpc2N2IHBvcnQKPiA+IDMyMDVjMWMgbG9j
YWw6IFJJU0MtVjogZGlzdHJpYnV0ZSBwdXJnYXRvcnkvcmlzY3YvTWFrZWZpbGUKPiA+IDU0Zjlk
YWYgUklTQy1WOiBBZGQgc3VwcG9ydCBmb3IgcmlzY3Yga2V4ZWMva2R1bXAgb24ga2V4ZWMtdG9v
bHMKPiA+Cj4gPiBTaW5jZSBJIGRpZG4ndCBmb3VuZCB0aGUgaXNzdWVzL2ZpeGVzIGFzIE5pY2sg
bWVudGlvbmVkIHdpdGggdGhlc2UKPiA+IGNvbW1pdHMsIEkgcHJlZmVyIHRvIG1lcmdlIHRoZW0g
aW50byBob3Jtcy9tYWluIGFuZCBsZXQgbW9yZSBrZXhlYy9rZHVtcAo+ID4gdXNlcnMgdG8gaGVs
cCBpbXByb3ZlL2ZpeHVwIFJJU0MtViBwb3J0Lgo+IAo+IEhpLCAgSSBub3RpY2VkIGFub3RoZXIg
cHIgZm9yIEZlZG9yYSBrZXhlYy10b29sczoKPiBodHRwczovL3NyYy5mZWRvcmFwcm9qZWN0Lm9y
Zy9ycG1zL2tleGVjLXRvb2xzL3B1bGwtcmVxdWVzdC8yNAo+IAo+IEl0IGlzIGJhZCB0byB0YWtl
IGl0IGFzIEZlZG9yYSBvbmx5LCAgIEkgd291bGQgc3VnZ2VzdCBwb3N0aW5nIGFsbCB0aGUKPiBy
ZWZyZXNoZWQgcGF0Y2hlcyB0b2dldGhlciBoZXJlIGFnYWluIGZvciByZXZpZXcuCj4gCj4gSWYg
bm8gZW5vdWdoIHJldmlld2VycyBjYW4gcmV2aWV3IHRoZW0gbXkgYW5vdGhlciBzdWdnZXN0aW9u
IGlzIHRvCj4gZHJvcCB0aGUga2V4ZWNfbG9hZCBzdXBwb3J0IGNvZGUgZm9yIHRoZSB0aW1lIGJl
aW5nLCBhbmQgb25seSBlbmFibGUKPiB0aGUga2V4ZWNfZmlsZV9sb2FkIHN1cHBvcnQgY29kZSBp
biBrZXhlYy10b29scywgYW5kIEkgYXNzdW1lIGJlbG93Cj4ga2VybmVsIGNvbW1pdCBtYWtlIHRo
ZSBrZXhlY19maWxlX2xvYWQga2VybmVsIHBpZWNlIG9mIHdvcmsgZG9uZS4KPiBUaGVuIGl0IHdp
bGwgYmUgZWFzaWVyIHRvIHJldmlldyBhbmQgbWFrZSBzb21ldGhpbmcgd29ya2luZyBhdCBsZWFz
dC4KPiBjb21taXQgNjI2MTU4NmUwYzkxZGIxNGMzNGY4OTRmNGJjNDhmMjMwMGNmZjFkNAo+IEF1
dGhvcjogTGlhbyBDaGFuZyA8bGlhb2NoYW5nMUBodWF3ZWkuY29tPgo+IERhdGU6ICAgRnJpIEFw
ciA4IDE4OjA5OjExIDIwMjIgKzA4MDAKPiAKPiAgICAgUklTQy1WOiBBZGQga2V4ZWNfZmlsZSBz
dXBwb3J0CgpIaSwKCkkgd291bGQgZ2xhZGx5IHRha2UgYSBwYXRjaHNldCBmb3Iga2V4ZWMtdG9v
bHMgdGhhdCBhZGRzIFJJU0MtViBzdXBwb3J0IGluCmEgY29oZXJlbnQgbWFubmVyLgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
