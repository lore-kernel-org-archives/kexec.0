Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54312CDE032
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EaIGl6EhlQ4V9CUY31LrgRIkIsFC5ga8p6ILWDzFD84=; b=pHsRttozO1+Wq0KpfKJwWcN2Ux
	VpmT8ucLQuUy+JYck/4Mkk2z3soKTPlz4+XDj6RWJIibI9Mm9ngJX2ntcV3FN9Yv8UD83gITjH7xS
	PAAlwfzNon8q0dH2b4yLsq33+byo/6MC5EkY4cdJdw1PjqzQ5+um8VOE/JATg1qPcZp0orMz7Mu1y
	4HH4hE9NRiYUMSSh1S7ziovvkHRicG+5BqckxBv6KvYXORcpT1uV5B/XxKM8fa71IyKAG0DYKO613
	y5PFTJMqEYvNRemV5A3QvPoViEemKS6tO1R4DlN5+U62Vr4MMb26rblduBFM/9+1syieGDYPTOPD1
	XSOoAFrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpgV-0000000Br47-1u9s;
	Fri, 14 Nov 2025 09:01:35 +0000
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.26.1.71])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpgS-0000000Br3R-45VW
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 09:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763110892; x=1794646892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EaIGl6EhlQ4V9CUY31LrgRIkIsFC5ga8p6ILWDzFD84=;
  b=Q/e1j9OA3m/KrVeJeJefnMjuD4BbZJlB3iAKcBUApkiVQUHNOTSh2yCy
   rJy0Xwavcy2LIEu3TecBPOkEJTKOHyscHp0B705+DmaVvsCiS4cOwxp52
   pTAaModeugAUWDEGGxrzYoAI7a9zBNlaKmlcHk87YqaMDLCK9hlqR9GrV
   NLgNZJLF5/E6zid7zYp63K5y5mqxcmM95mHMBueABbcsGGY9ZwEBASTuL
   7ajyXIABoZeRAAA4qaQqjpPJDZDPZbNMeQ9UfTGUkPpjxGt67nZeTZYGN
   eRcSiGed1c+/Xpnwh3oqMOnZ0kzho4Rks9UAyAmzJXNiynYccSuPUU/x/
   Q==;
X-CSE-ConnectionGUID: Uq1Ipwx9RJW9zvAJniWZLA==
X-CSE-MsgGUID: M25iTk7PRVC43yz2Zp6MFQ==
X-IronPort-AV: E=Sophos;i="6.19,304,1754956800"; 
   d="scan'208";a="7112418"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 09:01:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:22919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.95:2525] with esmtp (Farcaster)
 id 7b41653c-f962-4fb6-9b96-b9676b9afb43; Fri, 14 Nov 2025 09:01:25 +0000 (UTC)
X-Farcaster-Flow-ID: 7b41653c-f962-4fb6-9b96-b9676b9afb43
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 09:01:25 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 14 Nov 2025
 09:01:23 +0000
Message-ID: <e6f3c999-7a17-4c6b-8de7-a380cccdde9f@amazon.com>
Date: Fri, 14 Nov 2025 10:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>
CC: <akpm@linux-foundation.org>, <pratyush@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
 <aRbag7qR9OVNAQXN@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <aRbag7qR9OVNAQXN@kernel.org>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_010133_059531_C13361BE 
X-CRM114-Status: GOOD (  19.45  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDE0LjExLjI1IDA4OjMwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+IE9uIE1vbiwgTm92IDEw
LCAyMDI1IGF0IDAxOjA3OjE1UE0gLTA1MDAsIFBhc2hhIFRhdGFzaGluIHdyb3RlOgo+PiBVcGNv
bWluZyBMVU8gcmVxdWlyZXMgS0hPIGZvciBpdHMgb3BlcmF0aW9ucywgdGhlIHJlcXVpcmVtZW50
IHRvIHBsYWNlCj4+IGJvdGggS0hPPW9uIGFuZCBsaXZldXBkYXRlPW9uIGJlY29tZXMgcmVkdW5k
YW50LiBTZXQgS0hPIHRvIGJlIGVuYWJsZWQKPj4gYnkgZGVmYXVsdC4KPiBJIHRob3VnaCBtb3Jl
IGFib3V0IHRoaXMgYW5kIGl0IHNlZW1zIHRvbyBtdWNoIG9mIGEgY2hhbmdlLiBraG89MSBlbmFi
bGVzCj4gc2NyYXRjaCBhcmVhcyBhbmQgdGhhdCBzaWduaWZpY2FudGx5IGNoYW5nZXMgaG93IGZy
ZWUgcGFnZXMgYXJlIGRpc3RyaWJ1dGVkCj4gaW4gdGhlIGZyZWUgbGlzdHMuCj4KPiBMZXQncyBn
byB3aXRoIGEgS2NvbmZpZyBvcHRpb24gd2UgZGlzY3Vzc2VkIG9mLWxpc3Q6Cj4gKHRoaXMgaXMg
b24gdG9wIG9mIHRoZSBjdXJyZW50IG1tb3RtL21tLW5vbm1tLXVuc3RhYmxlKQo+Cj4gIEZyb20g
ODIzMjk5ZDgwYWE0ZjdjMTZlZjZjZmQ3OThhMTllMWRmZTFhOTFhYiBNb24gU2VwIDE3IDAwOjAw
OjAwIDIwMDEKPiBGcm9tOiBQYXNoYSBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29sZWVuLmNv
bT4KPiBEYXRlOiBGcmksIDE0IE5vdiAyMDI1IDA5OjI3OjQ3ICswMjAwCj4gU3ViamVjdDogW1BB
VENIXSBraG86IEFsbG93IEtITyB0byBiZSBlbmFibGVkIGJ5IGRlZmF1bHQKPgo+IFVwY29taW5n
IExVTyByZXF1aXJlcyBLSE8gZm9yIGl0cyBvcGVyYXRpb25zLCB0aGUgcmVxdWlyZW1lbnQgdG8g
cGxhY2UKPiBib3RoIEtITz1vbiBhbmQgbGl2ZXVwZGF0ZT1vbiBiZWNvbWVzIHJlZHVudGFudC4g
TGV0J3MgYWxsb3cgS0hPIHRvIGJlCj4gZW5hYmxlZCBieSBkZWZhdWx0LCBhbmQgQ09ORklHX0xJ
VkVVUERBVEUgY2FuIHNlbGVjdCB0aGlzIENPTkZJRy4KCgpMb29rcyBtdWNoIGJldHRlciwgeWVz
IDopLiBZb3UgY2FuIGFsc28gaW1wbHkgdGhpcyBvcHRpb24gYXV0b21hdGljYWxseSAKd2hlbiBM
VU89eS4KClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgoKCkFs
ZXgKCgo+Cj4gU2lnbmVkLW9mZi1ieTogUGFzaGEgVGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNv
bGVlbi5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KSA8cnBw
dEBrZXJuZWwub3JnPgo+IC0tLQo+ICAga2VybmVsL2xpdmV1cGRhdGUvS2NvbmZpZyAgICAgICAg
ICB8IDggKysrKysrKysKPiAgIGtlcm5lbC9saXZldXBkYXRlL2tleGVjX2hhbmRvdmVyLmMgfCAy
ICstCj4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9saXZldXBkYXRlL0tjb25maWcgYi9rZXJuZWwvbGl2ZXVw
ZGF0ZS9LY29uZmlnCj4gaW5kZXggZDczNDRkMzQ3ZjY5Li4yNWM5YTRkNzc4MWYgMTAwNjQ0Cj4g
LS0tIGEva2VybmVsL2xpdmV1cGRhdGUvS2NvbmZpZwo+ICsrKyBiL2tlcm5lbC9saXZldXBkYXRl
L0tjb25maWcKPiBAQCAtNjMsNCArNjMsMTIgQEAgY29uZmlnIEtFWEVDX0hBTkRPVkVSX0RFQlVH
RlMKPiAgICAgICAgICAgIEFsc28sIGVuYWJsZXMgaW5zcGVjdGluZyB0aGUgS0hPIGZkdCB0cmVl
cyB3aXRoIHRoZSBkZWJ1Z2ZzIGJpbmFyeQo+ICAgICAgICAgICAgYmxvYnMuCj4KPiArY29uZmln
IEtFWEVDX0hBTkRPVkVSX0VOQUJMRV9ERUZBVUxUCj4gKyAgICAgICBib29sICJFbmFibGUga2V4
ZWMgaGFuZG92ZXIgYnkgZGVmYXVsdCIKPiArICAgICAgIGRlcGVuZHMgb24gS0VYRUNfSEFORE9W
RVIKPiArICAgICAgIGhlbHAKPiArICAgICAgICAgRW5hYmxlIHRoZSBrZXhlYyBoYW5kb3ZlciBi
eSBkZWZhdWx0LiBJdCBpcyBlcXVpdmFsZW50IG9mIHBhc3NpbmcKPiArICAgICAgICAga2hvPW9u
IHZpYSBrZXJuZWwgcGFyYW1ldGVyLCBhbmQgY2FuIGJlIG92ZXJ3cml0dGVuIHRvIG9mZiB2aWEK
PiArICAgICAgICAga2hvPW9mZi4KPiArCj4gICBlbmRtZW51Cj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9saXZldXBkYXRlL2tleGVjX2hhbmRvdmVyLmMgYi9rZXJuZWwvbGl2ZXVwZGF0ZS9rZXhlY19o
YW5kb3Zlci5jCj4gaW5kZXggNTY4Y2Q5ZmU5YWNhLi4yM2EzZGYyOTdiYjMgMTAwNjQ0Cj4gLS0t
IGEva2VybmVsL2xpdmV1cGRhdGUva2V4ZWNfaGFuZG92ZXIuYwo+ICsrKyBiL2tlcm5lbC9saXZl
dXBkYXRlL2tleGVjX2hhbmRvdmVyLmMKPiBAQCAtNTEsNyArNTEsNyBAQCB1bmlvbiBraG9fcGFn
ZV9pbmZvIHsKPgo+ICAgc3RhdGljX2Fzc2VydChzaXplb2YodW5pb24ga2hvX3BhZ2VfaW5mbykg
PT0gc2l6ZW9mKCgoc3RydWN0IHBhZ2UgKikwKS0+cHJpdmF0ZSkpOwo+Cj4gLXN0YXRpYyBib29s
IGtob19lbmFibGUgX19yb19hZnRlcl9pbml0ID0gdHJ1ZTsKPiArc3RhdGljIGJvb2wga2hvX2Vu
YWJsZSBfX3JvX2FmdGVyX2luaXQgPSBJU19FTkFCTEVEKENPTkZJR19LRVhFQ19IQU5ET1ZFUl9F
TkFCTEVfREVGQVVMVCk7Cj4KPiAgIGJvb2wga2hvX2lzX2VuYWJsZWQodm9pZCkKPiAgIHsKPiAt
LQo+IDIuNTAuMQo+Cj4KPgo+IC0tCj4gU2luY2VyZWx5IHlvdXJzLAo+IE1pa2UuCgoKCkFtYXpv
biBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFu
ei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIENocmlzdG9mIEhlbGxtaXMKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1
MzggNTk3Cg==


