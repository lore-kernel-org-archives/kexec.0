Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38DC54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wf3KIg6QT0+1sbIfdY6qB7YTYhhh33GJ5+9pQP+uZIU=; b=ZyiJpVL7PgmDE4
	3REvHMY2wWslRxWoxMD7tclzSkt+ZJDkSEPx8UFNhM3FN93hl3oCfn7oNFlyT9Ik6CU3P6vD2G79K
	JVsqjOLMYHLOdKGCgAQ1os7lYrBsFClVQ8zXrLgIxiTUNEVtNFfNMqVcDpqr0Gbals9lPTHhtDKgE
	SEEEfs4EJtl2K2kN2fmoI5DA61Pwk29mSxeWTmOfrjjka7kCVTJeMAaN5hIYD8jH4G6BWBiPmvDsX
	NS7zLDQ3JLGyZttoKsj+jbSk2Ghzd5l/Q62nWFjeZOoGJuWwV4uTWHCA1ZQYQf7jFS9Eqcj9wgRXX
	dXwCX8TCHgHLZBawswHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnRrk-000000056eR-0MGR;
	Thu, 21 Mar 2024 23:30:32 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnRrf-000000056cE-2tNk
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 23:30:31 +0000
Message-ID: <0be8711f-31cb-4bfa-8501-4ad11e34b09a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711063819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUKRlKfRws+/FxXAEZkSJcbbjD61bO3gnsZWEBPgNek=;
	b=MZNSEQs5otXzS0VjwkryDeKsKBQQ9QbgQN+uBW+PB5poxTPY396E4EAYBaI8N63JGrC43Z
	zncO/c6ofwcBjM6bXLlpx+v+4Q/KBPGdxpSMEEUI/SALRwjbn+EqS3SJglHdM0DEHWAPGn
	WwNZJlsyGGyc0BGqpktbEgkpemfG7Dk=
Date: Thu, 21 Mar 2024 16:30:11 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@google.com>
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
 <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_163029_507280_798AD8F0 
X-CRM114-Status: GOOD (  14.60  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMTkvMjQgMzo1NiBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOgo+IE9uIFR1ZSwgTWFy
IDE5LCAyMDI0IGF0IDE6MDLigK9BTSBIYXJpIEJhdGhpbmkgPGhiYXRoaW5pQGxpbnV4LmlibS5j
b20+IHdyb3RlOgo+PiBXaXRoIFsxXSwgY3Jhc2ggZHVtcCBzcGVjaWZpYyBjb2RlIGlzIG1vdmVk
IG91dCBvZiBDT05GSUdfS0VYRUNfQ09SRQo+PiBhbmQgcGxhY2VkIHVuZGVyIENPTkZJR19DUkFT
SF9EVU1QLCB3aGVyZSBpdCBpcyBtb3JlIGFwcHJvcHJpYXRlLgo+PiBBbmQgc2luY2UgQ09ORklH
X0tFWEVDICYgIUNPTkZJR19DUkFTSF9EVU1QIGJ1aWxkIG9wdGlvbiBpcyBzdXBwb3J0ZWQKPj4g
d2l0aCB0aGF0LCBpdCBsZWQgdG8gdGhlIGJlbG93IHdhcm5pbmc6Cj4+Cj4+ICAgICJXQVJOOiBy
ZXNvbHZlX2J0ZmlkczogdW5yZXNvbHZlZCBzeW1ib2wgY3Jhc2hfa2V4ZWMiCj4+Cj4+IEZpeCBp
dCBieSB1c2luZyB0aGUgYXBwcm9wcmlhdGUgI2lmZGVmLgo+Pgo+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwMTI0MDUxMjU0LjY3MTA1LTEtYmhlQHJlZGhhdC5jb20vCj4+
Cj4+IEFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPj4gRml4ZXM6IDI5ZmQ5
YWU2MjkxMCAoImNyYXNoOiBzcGxpdCBjcmFzaCBkdW1waW5nIGNvZGUgb3V0IGZyb20ga2V4ZWNf
Y29yZS5jIikKPiBJIGRvbid0IHRoaW5rIGVpdGhlciBicGYgb3IgYnBmLW5leHQgaGF2ZSB0aGlz
IGNvbW1pdCBqdXN0IHlldCwgc28KPiBsYW5kaW5nIGl0IGluIHRoZSBicGYvYnBmLW5leHQgdHJl
ZSBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZS4gSXQKPiBwcm9iYWJseSB3b3VsZCBiZSBiZXN0IHRv
IGxhbmQgaXQgdGhyb3VnaCB0aGUgdHJlZSB3aGljaCBkb2VzIHRoZQo+IENPTkZJR19LRVhFQ19D
T1JFIC0+IENPTkZJR19DUkFTSF9EVU1QIGNoYW5nZSBpbiBrZXJuZWwvTWFrZWZpbGUuCgpXaXRo
IGJwZi1uZXh0LCBJIGZvdW5kIHRoZSBjb25maWcgYXQga2VybmVsL0tjb25maWcua2V4ZWM6Cgpj
b25maWcgQ1JBU0hfRFVNUAogwqDCoMKgwqDCoMKgwqAgYm9vbCAia2VybmVsIGNyYXNoIGR1bXBz
IgogwqDCoMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBBUkNIX1NVUFBPUlRTX0NSQVNIX0RVTVAKIMKg
wqDCoMKgwqDCoMKgIHNlbGVjdCBDUkFTSF9DT1JFCiDCoMKgwqDCoMKgwqDCoCBzZWxlY3QgS0VY
RUNfQ09SRQogwqDCoMKgwqDCoMKgwqAgaGVscAoKLi4uCgo+IHB3LWJvdDogY3IKPgo+PiBBY2tl
ZC1ieTogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPgo+PiBBY2tlZC1ieTogU3RhbmlzbGF2
IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSGFyaSBCYXRoaW5p
IDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgo+PiAtLS0KPj4KPj4gQ2hhbmdlcyBpbiB2MjoKPj4g
KiBVcGRhdGVkIGNoYW5nZWxvZy4KPj4gKiBBZGRlZCBGaXhlcyBhbmQgQWNrZWQtYnkgdGFncy4K
Pj4KPj4KPj4gICBrZXJuZWwvYnBmL2hlbHBlcnMuYyB8IDIgKy0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9icGYvaGVscGVycy5jIGIva2VybmVsL2JwZi9oZWxwZXJzLmMKPj4gaW5kZXggYTg5NTg3ODU5
NTcxLi40NDliOWE1ZDNmZTMgMTAwNjQ0Cj4+IC0tLSBhL2tlcm5lbC9icGYvaGVscGVycy5jCj4+
ICsrKyBiL2tlcm5lbC9icGYvaGVscGVycy5jCj4+IEBAIC0yNTQ4LDcgKzI1NDgsNyBAQCBfX2Jw
Zl9rZnVuYyB2b2lkIGJwZl90aHJvdyh1NjQgY29va2llKQo+PiAgIF9fYnBmX2tmdW5jX2VuZF9k
ZWZzKCk7Cj4+Cj4+ICAgQlRGX0tGVU5DU19TVEFSVChnZW5lcmljX2J0Zl9pZHMpCj4+IC0jaWZk
ZWYgQ09ORklHX0tFWEVDX0NPUkUKPj4gKyNpZmRlZiBDT05GSUdfQ1JBU0hfRFVNUAo+PiAgIEJU
Rl9JRF9GTEFHUyhmdW5jLCBjcmFzaF9rZXhlYywgS0ZfREVTVFJVQ1RJVkUpCj4+ICAgI2VuZGlm
Cj4+ICAgQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9vYmpfbmV3X2ltcGwsIEtGX0FDUVVJUkUgfCBL
Rl9SRVRfTlVMTCkKPj4gLS0KPj4gMi40NC4wCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
