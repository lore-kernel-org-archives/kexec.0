Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE05C52D7C
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oJdYuiVC9Poj16Ch2+00u92gz5gZtot52N+E8nn15Os=; b=XaqARjxfYgZGZV
	lHzGI77B4aTgNX4Jzlb2nBva+SwS8zycQfUnGUKDNoX8SFqzBY0ZAb+7gANwaCS7cuGVx1p6Nvr5d
	AfJP6ve1TFf9fK69jl+xk1hHUjhh3QvQV4yQqCPOKc/qWyy/L+Z6tOakW4e88cnrmKo244/RPcs6R
	1fJ4HzzQwNl9R4I07YGAnV/mcKdIN+K3Qb8qWwMQHPuvKrTHXFkIJFYhmbIWxK+qta+oXaPgPXPDk
	PW+MB845sQo/RuxNPsZEl+VPSgPrvv9PS0wNS070/jODYC2XEYh9muqs+GcmNYhz3SLso9em/GmXj
	ATW21GrmDvdc32rzVPHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdsU1-000000040Ms-27ib;
	Tue, 13 Aug 2024 14:26:45 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdsTx-000000040MV-1TmE
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 14:26:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 331B0CE0159;
	Tue, 13 Aug 2024 14:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD2C4AF09;
	Tue, 13 Aug 2024 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559197;
	bh=y9MZ0iptYLQq45DKrJbxA1Mb5dHp4xT7rWf+fy+/GKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgGAImmAjGjBa6v6lq7mw+fCtBh+5TUnReM0CcaajRM651c6TkrZQ6dFu8PBbhZRG
	 +Fvvq+Ei1eiD/oSG+x+Zpoix7q9pQP8XMa/NVfm1x5l187wSvaWy7MxV3/RdElOSUr
	 cHgjfHNs+Ob636HbHKt/CCN1PoE/Z8PfYUsnQVESJZ/8UFOelnwnogXXw/N9MFO7HR
	 OOjhdbrMbfFAw1y3WFPOZAN306ONNcC3zvplkTwWHo6Qav7PXHvtjRvpJcoXRVKZwP
	 5gmKvKDQIT8jFs/H5y3amn66+lcm2fHCxTDVx3RXETQ583kMX8GyMz3XffctrJwhtB
	 lNO23i9gguqTg==
Date: Tue, 13 Aug 2024 15:26:32 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Song Shuai <songshuaishuai@tinylab.org>, Dave Young <dyoung@redhat.com>,
	mick@ics.forth.gr, lizhengyu3@huawei.com, liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com, guoren@kernel.org,
	huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com,
	kexec@lists.infradead.org, hursand@fedoraproject.org
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Message-ID: <20240813142632.GA69536@kernel.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org>
 <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
 <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
 <20240518083304.GD475595@kernel.org>
 <20240812163633.098f8f07@mordecai.tesarici.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240812163633.098f8f07@mordecai.tesarici.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_072641_856331_A0E5840F 
X-CRM114-Status: GOOD (  36.90  )
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

T24gTW9uLCBBdWcgMTIsIDIwMjQgYXQgMDQ6MzY6MzNQTSArMDIwMCwgUGV0ciBUZXNhcmlrIHdy
b3RlOgo+IEhpLAo+IAo+IE9uIFNhdCwgMTggTWF5IDIwMjQgMDk6MzM6MDQgKzAxMDAKPiBTaW1v
biBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IHdyb3RlOgo+IAo+ID4gT24gU2F0LCBNYXkgMTgs
IDIwMjQgYXQgMTE6Mzk6MThBTSArMDgwMCwgRGF2ZSBZb3VuZyB3cm90ZToKPiA+ID4gT24gV2Vk
LCAxMSBPY3QgMjAyMyBhdCAxMzoyNCwgU29uZyBTaHVhaSA8c29uZ3NodWFpc2h1YWlAdGlueWxh
Yi5vcmc+IHdyb3RlOiAgCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g5ZyoIDIwMjMv
OS8yMCAxOTo1NiwgU2ltb24gSG9ybWFuIOWGmemBkzogIAo+ID4gPiA+ID4gT24gRnJpLCBTZXAg
MTUsIDIwMjMgYXQgMTE6NTA6MDZBTSArMDgwMCwgU29uZyBTaHVhaSB3cm90ZTogIAo+ID4gPiA+
ID4+IEhpLAo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gVGhpcyBzZXJpZXMgaXMgY3JlYXRlZCB0byBp
bXByb3ZlIFJJU0MtViBwb3J0IG9mIGtleGVjLXRvb2xzLAo+ID4gPiA+ID4+IGFuZCBpcyBiYXNl
ZCBvbiB0aGUgaG9ybXMva2V4ZWMtdG9vbHM6YnVpbGQtdGVzdC1yaXNjdi12MiBicmFuY2guICAK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiBteSBtaW5kIHRoZSBiaWcgcXVlc3Rpb24gaXMgaG93IHRv
IG1vdmUgUklTQy1WIHN1cHBvcnQKPiA+ID4gPiA+IGZyb20gdGhhdCBicmFuY2gsIHRvIGJlaW5n
IG1lcmdlZCBpbnRvIG1haW4uCj4gPiA+ID4gPgo+ID4gPiA+ID4gSUlSQyB0aGVyZSB3ZXJlIHNv
bWUgaXNzdWVzIHRoYXQgbmVlZGVkIHRvIGJlIGFkZHJlc3NlZC4KPiA+ID4gPiA+IFBlcmhhcHMg
dGhleSBhcmUgYWxsIGFkZHJlc3NlZCBieSB0aGlzIHNlcmllcywgYW5kIHdpdGgKPiA+ID4gPiA+
IHNvbWUgYXBwcm9wcmlhdGUgc3F1YXNoaW5nIHdlIGNhbiBtb3ZlIGZvcndhcmRzIHdpdGggYSBz
ZXJpZXMKPiA+ID4gPiA+IGJhc2VkIG9uIG1haW4/ICAKPiA+ID4gPgo+ID4gPiA+IEhpLCBTaW1v
biBhbmQgTmljazoKPiA+ID4gPgo+ID4gPiA+IEkgc3F1YXNoZWQgdGhlIGZpcnN0IGZvdXIgcGF0
Y2hlcyBhcyBhICJSSVNDLVY6IFNvbWUgZml4ZXMgZm9yIHJpc2N2Cj4gPiA+ID4gcG9ydCIgcGF0
Y2ggYW5kIHRoZW4gdG9vayB0aGUgaG9ybXMvbWFpbiBhcyB0aGUgYmFzZSB0byBjb2xsZWN0IHRo
ZSAyCj4gPiA+ID4gcGF0Y2hlcyBmcm9tIGhvcm1zL2J1aWxkLXRlc3QtcmlzY3YtdjIgYnJhbmNo
IGFuZCB0aGlzIHNlcmllcyB0b2dvdGhlci4KPiA+ID4gPiBUaGVzZSBhcmUgdGhlIEdpdGh1YiBs
aW5rIGFuZCBhbGwgY29tbWl0cyBmb3IgUklTQy1WLgo+ID4gPiA+Cj4gPiA+ID4gaHR0cHM6Ly9n
aXRodWIuY29tL3N1Z2FyZmlsbGV0L2tleGVjLXRvb2xzL2NvbW1pdHMvbWFpbl9ydgo+ID4gPiA+
Cj4gPiA+ID4gNWRjMTMzZSBSSVNDLVY6IFN1cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5hcnkgZmls
ZQo+ID4gPiA+IGIwNDJmNmQgUklTQy1WOiBTZXBhcmF0ZSBlbGZfcmlzY3ZfZmluZF9wYmFzZSBv
dXQKPiA+ID4gPiA4ZjM0NGM3IFJJU0MtVjogRW5hYmxlIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxs
Cj4gPiA+ID4gN2Q0Yjk4MiBSSVNDLVY6IFNvbWUgZml4ZXMgZm9yIHJpc2N2IHBvcnQKPiA+ID4g
PiAzMjA1YzFjIGxvY2FsOiBSSVNDLVY6IGRpc3RyaWJ1dGUgcHVyZ2F0b3J5L3Jpc2N2L01ha2Vm
aWxlCj4gPiA+ID4gNTRmOWRhZiBSSVNDLVY6IEFkZCBzdXBwb3J0IGZvciByaXNjdiBrZXhlYy9r
ZHVtcCBvbiBrZXhlYy10b29scwo+ID4gPiA+Cj4gPiA+ID4gU2luY2UgSSBkaWRuJ3QgZm91bmQg
dGhlIGlzc3Vlcy9maXhlcyBhcyBOaWNrIG1lbnRpb25lZCB3aXRoIHRoZXNlCj4gPiA+ID4gY29t
bWl0cywgSSBwcmVmZXIgdG8gbWVyZ2UgdGhlbSBpbnRvIGhvcm1zL21haW4gYW5kIGxldCBtb3Jl
IGtleGVjL2tkdW1wCj4gPiA+ID4gdXNlcnMgdG8gaGVscCBpbXByb3ZlL2ZpeHVwIFJJU0MtViBw
b3J0LiAgCj4gPiA+IAo+ID4gPiBIaSwgIEkgbm90aWNlZCBhbm90aGVyIHByIGZvciBGZWRvcmEg
a2V4ZWMtdG9vbHM6Cj4gPiA+IGh0dHBzOi8vc3JjLmZlZG9yYXByb2plY3Qub3JnL3JwbXMva2V4
ZWMtdG9vbHMvcHVsbC1yZXF1ZXN0LzI0Cj4gPiA+IAo+ID4gPiBJdCBpcyBiYWQgdG8gdGFrZSBp
dCBhcyBGZWRvcmEgb25seSwgICBJIHdvdWxkIHN1Z2dlc3QgcG9zdGluZyBhbGwgdGhlCj4gPiA+
IHJlZnJlc2hlZCBwYXRjaGVzIHRvZ2V0aGVyIGhlcmUgYWdhaW4gZm9yIHJldmlldy4KPiA+ID4g
Cj4gPiA+IElmIG5vIGVub3VnaCByZXZpZXdlcnMgY2FuIHJldmlldyB0aGVtIG15IGFub3RoZXIg
c3VnZ2VzdGlvbiBpcyB0bwo+ID4gPiBkcm9wIHRoZSBrZXhlY19sb2FkIHN1cHBvcnQgY29kZSBm
b3IgdGhlIHRpbWUgYmVpbmcsIGFuZCBvbmx5IGVuYWJsZQo+ID4gPiB0aGUga2V4ZWNfZmlsZV9s
b2FkIHN1cHBvcnQgY29kZSBpbiBrZXhlYy10b29scywgYW5kIEkgYXNzdW1lIGJlbG93Cj4gPiA+
IGtlcm5lbCBjb21taXQgbWFrZSB0aGUga2V4ZWNfZmlsZV9sb2FkIGtlcm5lbCBwaWVjZSBvZiB3
b3JrIGRvbmUuCj4gPiA+IFRoZW4gaXQgd2lsbCBiZSBlYXNpZXIgdG8gcmV2aWV3IGFuZCBtYWtl
IHNvbWV0aGluZyB3b3JraW5nIGF0IGxlYXN0Lgo+ID4gPiBjb21taXQgNjI2MTU4NmUwYzkxZGIx
NGMzNGY4OTRmNGJjNDhmMjMwMGNmZjFkNAo+ID4gPiBBdXRob3I6IExpYW8gQ2hhbmcgPGxpYW9j
aGFuZzFAaHVhd2VpLmNvbT4KPiA+ID4gRGF0ZTogICBGcmkgQXByIDggMTg6MDk6MTEgMjAyMiAr
MDgwMAo+ID4gPiAKPiA+ID4gICAgIFJJU0MtVjogQWRkIGtleGVjX2ZpbGUgc3VwcG9ydCAgCj4g
PiAKPiA+IEhpLAo+ID4gCj4gPiBJIHdvdWxkIGdsYWRseSB0YWtlIGEgcGF0Y2hzZXQgZm9yIGtl
eGVjLXRvb2xzIHRoYXQgYWRkcyBSSVNDLVYgc3VwcG9ydCBpbgo+ID4gYSBjb2hlcmVudCBtYW5u
ZXIuCj4gCj4gSGF2ZSBJIG1pc3NlZCBzb21lIHByb2dyZXNzIG9uIHRoaXMgdG9waWM/IEZXSVcg
SSBjYW4gdGFrZSBjYXJlIG9mCj4gUklTQy1WIHN1cHBvcnQgaW4ga2V4ZWMtdG9vbHMsIEkgZXZl
biByZWNlaXZlZCBhIFZpc2lvbkZpdmUgMiBib2FyZAo+IGZyb20gUlZJIGxhc3QgeWVhciBzcGVj
aWZpY2FsbHkgdG8gaGVscCB3aXRoIGtleGVjLgo+IAo+IEkgbWVyZWx5IGRvbid0IHdhbnQgdG8g
ZHVwbGljYXRlIGVmZm9ydHMgb3IgInN0ZWFsIiBzb21lb25lIGVsc2Uncwo+IHByb2plY3QuIElz
IFJJU0MtViBzdXBwb3J0IGluIGtleGVjLXRvb2xzIGFuIG9ycGhhbmVkIHByb2plY3Qgbm93PwoK
SGkgUGV0ciwKCklmIHRoZXJlIGhhcyBiZWVuIHByb2dyZXNzIHRoZW4gSSBhbSBub3QgYXdhcmUg
b2YgaXQuCkFuZCBpZiB5b3Ugd291bGQgbGlrZSB0byBzdGVwIHVwIGFuZCBwcm92aWRlIGEgc2lu
Z2xlLCB3ZWxsIHN0cnVjdHVyZWQsCnBhdGNoc2V0IHRoYXQgYWRkcyBSSVNDLVYgc3VwcG9ydCB0
aGVuIEkgZm9yIG9uZSB3b3VsZCBiZSBtb3N0IGdyYXRlZnVsLgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
