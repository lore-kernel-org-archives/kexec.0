Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0BBEB64DD
	for <kexec@archiver.kernel.org>; Tue,  4 Jul 2023 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/RozF1IJYjeUNPcF3gt5kjZ8hJx2zFUzf/OudVal5lA=; b=LgIDA0YqvobCCT
	3h7TSvfib49LsnXLy99Xi9G77+J12RHPxFlEpGj5XCvpb9CiqBMlIqUwNKd9ZLVD3BQBSukimsHz0
	8LFWQIo4psVqcymPNSgp3OayrnvK/+C4YYY85S3Kke5Bqz/EfimV2klwl6cU8+dlUeVmzIHEwjmKE
	W2jq/M97Md5uLY3hBvGpKZ9vUu9cDVXH4+77Jd8X9oOaBw2PBSExosQkMCi7+1FhkrJxr14Zkbmm1
	2tfw1guZkjT2rhexAt18hJ3TaMPq3eGTS70U1hTx5hB6cdLav3/0eEExv2vKl2sjlOjf+k48ZcRWp
	it32H2UObZcI8lZ6DWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGVxA-00BwSy-0a;
	Tue, 04 Jul 2023 02:39:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGVx7-00BwSF-2B;
	Tue, 04 Jul 2023 02:39:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 279236112A;
	Tue,  4 Jul 2023 02:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BFAC43391;
	Tue,  4 Jul 2023 02:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688438380;
	bh=tXZp+ReqzLA3RemNoEBo2LjLWj/e/XELTtoc5i/BBic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R2EeYhz6t0R+bVU1qrbDTq/R3OYi5EPzXEM/loAnBrwmzojywsmNdLCZvvR9TlQ/e
	 GUaxFkqwhLTMr4sTJ9BcwP0Vfo2z/JnghXvpheQf4upJMJVEqJNUEd16FKaghhoxK2
	 ccVQEtzcm2C9S9hNPV7lNeXbJJGQoLKNX+pM2TDw32b8gTKgMEwB6u1oYcYj6lUDd6
	 EbMWoz+xQmoz5IkMRMwgfP6PuarxSIhvsym7c2XnD3lXy2T0/dyWAcSTW1f5BgHPYt
	 Kt5EB6nO3maJTOD9NSVCQY5hmpZfDykpFNcZ9/HK48r8Ve4KssIPubgSNOz/5uuIQR
	 +xPMoZJ0WZPAg==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbac8b01b3so41711115e9.1;
        Mon, 03 Jul 2023 19:39:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDyL0VeYgHcDrzFQE4VfXFDPOzTPzSbUsqfHikO+CgbLSRupfuFD
	vu6dJ4UcXj90j1Yy8ak1NfaO72X/eLJFBX3dSlU=
X-Google-Smtp-Source: ACHHUZ7Sgf2kFqoO4n7yD8cxYDyMwazc0GyX/ssIDgmJNp6qshBxWDrkQ8kh6xbzdlEVHkpMho95UtHTksFMkene+rk=
X-Received: by 2002:a05:600c:ad4:b0:3fb:a506:5626 with SMTP id
 c20-20020a05600c0ad400b003fba5065626mr10492684wmr.1.1688438378265; Mon, 03
 Jul 2023 19:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
 <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com> <b338a366-2cc3-870e-aee6-d55999ab14b5@huawei.com>
In-Reply-To: <b338a366-2cc3-870e-aee6-d55999ab14b5@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 4 Jul 2023 10:39:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu8EQR-E1C4_gAj9JFDh2hd3WpprzVssGf+KzTZc5qOw@mail.gmail.com>
Message-ID: <CAJF2gTRu8EQR-E1C4_gAj9JFDh2hd3WpprzVssGf+KzTZc5qOw@mail.gmail.com>
Subject: Re: [PATCH -next v6 0/2] support allocating crashkernel above 4G
 explicitly on riscv
To: "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, conor.dooley@microchip.com, 
	heiko@sntech.de, bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org, 
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com, 
	horms@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_193941_798785_C4C063D9 
X-CRM114-Status: GOOD (  28.92  )
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

T24gTW9uLCBKdWwgMywgMjAyMyBhdCA5OjA34oCvUE0gY2hlbmppYWhhbyAoQykgPGNoZW5qaWFo
YW8xNkBodWF3ZWkuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMy83LzEgMjE6NDUsIEd1byBSZW4g
d3JvdGU6Cj4gPiBPbiBTYXQsIEp1bCAxLCAyMDIzIGF0IDU6MTLigK9QTSBDaGVuIEppYWhhbyA8
Y2hlbmppYWhhbzE2QGh1YXdlaS5jb20+IHdyb3RlOgo+ID4+IE9uIHJpc2N2LCB0aGUgY3VycmVu
dCBjcmFzaCBrZXJuZWwgYWxsb2NhdGlvbiBsb2dpYyBpcyB0cnlpbmcgdG8KPiA+PiBhbGxvY2F0
ZSB3aXRoaW4gMzJiaXQgYWRkcmVzc2libGUgbWVtb3J5IHJlZ2lvbiBieSBkZWZhdWx0LCBpZgo+
ID4+IGZhaWxlZCwgdHJ5IHRvIGFsbG9jYXRlIHdpdGhvdXQgNEcgcmVzdHJpY3Rpb24uCj4gPj4K
PiA+PiBJbiBuZWVkIG9mIHNhdmluZyBETUEgem9uZSBtZW1vcnkgd2hpbGUgYWxsb2NhdGluZyBh
IHJlbGF0aXZlbHkgbGFyZ2UKPiA+PiBjcmFzaCBrZXJuZWwgcmVnaW9uLCBhbGxvY2F0aW5nIHRo
ZSByZXNlcnZlZCBtZW1vcnkgdG9wIGRvd24gaW4KPiA+PiBoaWdoIG1lbW9yeSwgd2l0aG91dCBv
dmVybGFwcGluZyB0aGUgRE1BIHpvbmUsIGlzIGEgbWF0dXJlIHNvbHV0aW9uLgo+ID4+IEhlbmNl
IHRoaXMgcGF0Y2hzZXQgaW50cm9kdWNlcyB0aGUgcGFyYW1ldGVyIG9wdGlvbiBjcmFzaGtlcm5l
bD1YLFtoaWdoLGxvd10uCj4gPj4KPiA+PiBPbmUgY2FuIHJlc2VydmUgdGhlIGNyYXNoIGtlcm5l
bCBmcm9tIGhpZ2ggbWVtb3J5IGFib3ZlIERNQSB6b25lIHJhbmdlCj4gPj4gYnkgZXhwbGljaXRs
eSBwYXNzaW5nICJjcmFzaGtlcm5lbD1YLGhpZ2giOyBvciByZXNlcnZlIGEgbWVtb3J5IHJhbmdl
Cj4gPj4gYmVsb3cgNEcgd2l0aCAiY3Jhc2hrZXJuZWw9WCxsb3ciLiBCZXNpZGVzLCB0aGVyZSBh
cmUgZmV3IHJ1bGVzIG5lZWQKPiA+PiB0byB0YWtlIG5vdGljZToKPiA+PiAxLiAiY3Jhc2hrZXJu
ZWw9WCxbaGlnaCxsb3ddIiB3aWxsIGJlIGlnbm9yZWQgaWYgImNyYXNoa2VybmVsPXNpemUiCj4g
Pj4gICAgIGlzIHNwZWNpZmllZC4KPiA+PiAyLiAiY3Jhc2hrZXJuZWw9WCxsb3ciIGlzIHZhbGlk
IG9ubHkgd2hlbiAiY3Jhc2hrZXJuZWw9WCxoaWdoIiBpcyBwYXNzZWQKPiA+PiAgICAgYW5kIHRo
ZXJlIGlzIGVub3VnaCBtZW1vcnkgdG8gYmUgYWxsb2NhdGVkIHVuZGVyIDRHLgo+ID4+IDMuIFdo
ZW4gYWxsb2NhdGluZyBjcmFzaGtlcm5lbCBhYm92ZSA0RyBhbmQgbm8gImNyYXNoa2VybmVsPVgs
bG93IiBpcwo+ID4+ICAgICBzcGVjaWZpZWQsIGEgMTI4TSBsb3cgbWVtb3J5IHdpbGwgYmUgYWxs
b2NhdGVkIGF1dG9tYXRpY2FsbHkgZm9yCj4gPj4gICAgIHN3aW90bGIgYm91bmNlIGJ1ZmZlci4K
PiA+PiBTZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQg
Zm9yIG1vcmUgaW5mb3JtYXRpb24uCj4gPj4KPiA+PiBUbyB2ZXJpZnkgbG9hZGluZyB0aGUgY3Jh
c2hrZXJuZWwsIGFkYXB0ZWQga2V4ZWMtdG9vbHMgaXMgYXR0YWNoZWQgYmVsb3c6Cj4gPj4gaHR0
cHM6Ly9naXRodWIuY29tL2NoZW5qaDAwNS9rZXhlYy10b29scy90cmVlL2J1aWxkLXRlc3Qtcmlz
Y3YtdjIKPiA+Pgo+ID4+IEZvbGxvd2luZyB0ZXN0IGNhc2VzIGhhdmUgYmVlbiBwZXJmb3JtZWQg
YXMgZXhwZWN0ZWQ6Cj4gPj4gMSkgY3Jhc2hrZXJuZWw9MjU2TSAgICAgICAgICAgICAgICAgICAg
ICAgICAgLy9sb3c9MjU2TQo+ID4+IDIpIGNyYXNoa2VybmVsPTFHICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8vbG93PTFHCj4gPiBIYXZlIHlvdSB0cmllZCAxR0IgbWVtb3J5PyB3ZSBmb3Vu
ZCBhIHB1ZCBtYXBwaW5nIHByb2JsZW0gb24gU3YzOSBvZiBrZXhlYywgU2VlOgo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMzA2MjkwODIwMzIuMzQ4MTIzNy0xLWd1
b3JlbkBrZXJuZWwub3JnLwo+Cj4gSSBoYXZlIHRlc3RlZCBvbiBRRU1VIHdpdGggc3Y1NyBtbXUs
IHNvIGl0IHNlZW1zIHRoZSBzeW5jaHJvbml6YXRpb24gcHJvYmxlbQo+IHdhcyBub3QgcmVwcm9k
dWNlIHdoZW4gcmVzZXJ2aW5nIDFHIG1lbW9yeSBhbmQgbG9hZGluZyB0aGUgY2FwdHVyZSBrZXJu
ZWwuClllcywgdGhlIHB1ZCBvZiBzdjU3IGlzIG5vdCB0aGUgcGdkIGVudHJpZXMsIHNvIHlvdSBk
aWRuJ3QgZ2V0IHByb2JsZW0uCgo+Cj4KPiBUaGFua3MsCj4gSmlhaGFvCj4KPiA+Cj4gPj4gMykg
Y3Jhc2hrZXJuZWw9NEcgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy9oaWdoPTRHLCBsb3c9
MTI4TShkZWZhdWx0KQo+ID4+IDQpIGNyYXNoa2VybmVsPTRHIGNyYXNoa2VybmVsPTI1Nk0saGln
aCAgICAgIC8vaGlnaD00RywgbG93PTEyOE0oZGVmYXVsdCksIGhpZ2ggaXMgaWdub3JlZAo+ID4+
IDUpIGNyYXNoa2VybmVsPTRHIGNyYXNoa2VybmVsPTI1Nk0sbG93ICAgICAgIC8vaGlnaD00Rywg
bG93PTEyOE0oZGVmYXVsdCksIGxvdyBpcyBpZ25vcmVkCj4gPj4gNikgY3Jhc2hrZXJuZWw9NEcs
aGlnaCAgICAgICAgICAgICAgICAgICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShkZWZhdWx0KQo+
ID4+IDcpIGNyYXNoa2VybmVsPTI1Nk0sbG93ICAgICAgICAgICAgICAgICAgICAgIC8vbG93PTBN
LCBpbnZhbGlkCj4gPj4gOCkgY3Jhc2hrZXJuZWw9NEcsaGlnaCBjcmFzaGtlcm5lbD0yNTZNLGxv
dyAgLy9oaWdoPTRHLCBsb3c9MjU2TQo+ID4+IDkpIGNyYXNoa2VybmVsPTRHLGhpZ2ggY3Jhc2hr
ZXJuZWw9NEcsbG93ICAgIC8vaGlnaD0wTSwgbG93PTBNLCBpbnZhbGlkCj4gPj4gMTApIGNyYXNo
a2VybmVsPTUxMk1AMHhkMDAwMDAwMCAgICAgICAgICAgICAgLy9sb3c9NTEyTQo+ID4+Cj4gPj4g
Q2hhbmdlcyBzaW5jZSBbdjZdOgo+ID4+IDEuIEludHJvZHVjZSB0aGUgImhpZ2giIGZsYWcgdG8g
bWFyayB3aGV0aGVyICJjcmFzaGtlcm5lbD1YLGhpZ2giCj4gPj4gICAgIGlzIHBhc3NlZC4gRml4
IHRoZSByZXRyeWluZyBsb2dpYyBiZXR3ZWVuICJjcmFzaGtlcm5lbD1YLGhpZ2giCj4gPj4gICAg
IGNhc2UgYW5kIG90aGVycyB3aGVuIHRoZSBmaXJzdCBhbGxvY2F0aW9uIGF0dGVtcHQgZmFpbHMu
Cj4gPj4KPiA+PiBDaGFuZ2VzIHNpbmNlIFt2NV06Cj4gPj4gMS4gVXBkYXRlIHRoZSBjcmFzaGtl
cm5lbCBhbGxvY2F0aW9uIGxvZ2ljIHdoZW4gY3Jhc2hrZXJuZWw9WCxoaWdoCj4gPj4gICAgIGlz
IHNwZWNpZmllZC4gSW4gdGhpcyBjYXNlLCByZWdpb24gYWJvdmUgNEcgd2lsbCBkaXJlY3RseSBn
ZXQKPiA+PiAgICAgcmVzZXJ2ZWQgYXMgY3Jhc2hrZXJuZWwsIHJhdGhlciB0aGFuIHRyeWluZyBs
b3dlciAzMmJpdCBhbGxvY2F0aW9uCj4gPj4gICAgIGZpcnN0Lgo+ID4+Cj4gPj4gQ2hhbmdlcyBz
aW5jZSBbdjRdOgo+ID4+IDEuIFVwZGF0ZSBzb21lIGltcHJlY2lzZSBjb2RlIGNvbW1lbnRzIGZv
ciBjbWRsaW5lIHBhcnNpbmcuCj4gPj4KPiA+PiBDaGFuZ2VzIHNpbmNlIFt2M106Cj4gPj4gMS4g
VXBkYXRlIHRvIHByaW50IHdhcm5pbmcgYW5kIHJldHVybiBleHBsaWNpdGx5IG9uIGZhaWx1cmUg
d2hlbgo+ID4+ICAgICBjcmFzaGtlcm5lbD1zaXplQG9mZnNldCBpcyBzcGVjaWZpZWQuIE5vdCBj
aGFuZ2luZyB0aGUgcmVzdWx0Cj4gPj4gICAgIGluIHRoaXMgY2FzZSBidXQgbWFraW5nIHRoZSBs
b2dpYyBtb3JlIHN0cmFpZ2h0Zm9yd2FyZC4KPiA+PiAyLiBTb21lIG1pbm9yIGNsZWFudXAuCj4g
Pj4KPiA+PiBDaGFuZ2VzIHNpbmNlIFt2Ml06Cj4gPj4gMS4gVXBkYXRlIHRoZSBhbGxvY2F0aW9u
IGxvZ2ljIHRvIGVuc3VyZSB0aGUgaGlnaCBjcmFzaGtlcm5lbAo+ID4+ICAgICByZWdpb24gaXMg
cmVzZXJ2ZWQgc3RyaWN0bHkgYWJvdmUgZG1hMzJfcGh5c19saW1pdC4KPiA+PiAyLiBDbGVhbiB1
cCBzb21lIG1pbm9yIGZvcm1hdCBwcm9ibGVtcy4KPiA+Pgo+ID4+IENoZW4gSmlhaGFvICgyKToK
PiA+PiAgICByaXNjdjoga2R1bXA6IEltcGxlbWVudCBjcmFzaGtlcm5lbD1YLFtoaWdoLGxvd10K
PiA+PiAgICBkb2NzOiBrZHVtcDogVXBkYXRlIHRoZSBjcmFzaGtlcm5lbCBkZXNjcmlwdGlvbiBm
b3IgcmlzY3YKPiA+Pgo+ID4+ICAgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dCAgICAgICAgIHwgMTUgKystLQo+ID4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYyAgICAg
ICAgICAgICAgICAgICAgIHwgIDUgKysKPiA+PiAgIGFyY2gvcmlzY3YvbW0vaW5pdC5jICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDg0ICsrKysrKysrKysrKysrKysrLS0KPiA+PiAgIDMgZmls
ZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4gPj4KPiA+PiAt
LQo+ID4+IDIuMzQuMQo+ID4+Cj4gPgoKCgotLSAKQmVzdCBSZWdhcmRzCiBHdW8gUmVuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
