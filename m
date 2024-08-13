Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F013C52D7B
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/VeVB56In4imKKm/o3MqzX6hy8yDL4vJJEwz/BX3bA=; b=p5VxfFssL9TcXd
	m3jwm2MInbs4TfLC+SyKwZUp8V489QEGma3f170iuJgi1dkpF9kMcDP+QweZ2Mgl9tjZEHRN1/6U/
	TRcFTe8Z7AbGzgFdRm5RPjVjcKYliuFEDe4H5ftYLUYpkH04STjealyY/mEAaerIuIfZOVT0BMoRb
	d60Q71pV48d2/jZgq7dJte9v51G2M87SgPsj53w8WZGXsiXXa5NxU2fm70t1XTyq/YTBm2aRh+r12
	AQ+Q6BF61BIxFGDujFU7rSJ03+7VbI/qt8iYpE99L/Od4vbH1SVtAQBodkyIyXcF5g3hEnqwlF17l
	NOQyi3ydwLtA3ffY8yXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdrgS-00000003tXr-0x30;
	Tue, 13 Aug 2024 13:35:32 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdrex-00000003t7Q-45JS;
	Tue, 13 Aug 2024 13:34:01 +0000
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4C55D1E0F82;
	Tue, 13 Aug 2024 15:33:57 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723556037; bh=t6gpWH8IPDdk9454o+l9OptGhzjcjk+DvpbWwyHTvow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fqEwTgwcxJ2kyxAQDXiU3eiP16ZLHy0gb/pH8Q1o/Geor1VdWaDiAtXcIZa7niiyZ
	 +fcueGLBlyXcPHRtbt6sOegGQLXB0I9YUgcrlFONTXeQKYgyBdsrL70jjjoxr2Zk8J
	 Ej+vVePwXBtnvuH3L5qLhTftfkXBMM30fzRvVcPGwTlnXpw+5wNDFKIhhGjNKavISH
	 tbCZ2tNuhl13OTLB+uU8yNCCv2FWu81ZVgvOIWJoDH/VwSd61f2HuTpGP9mvmKQl7r
	 Aq90gWKz5djOF0rSao1+raowUK5CePUY1ISPku9S0XJuv2Ba6gvqu1kH6xhcOLvok5
	 +uRdn8eoLetrg==
Date: Tue, 13 Aug 2024 15:33:52 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baoquan He <bhe@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
 akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <20240813153338.1972c10c@mordecai.tesarici.cz>
In-Reply-To: <ZrtLz8VHzZIULbOT@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
	<ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
	<ZrJ1JkyDVpRRB_9e@arm.com>
	<ZrJ60vopeGDXFZyK@arm.com>
	<20240813104006.520bf42d@mordecai.tesarici.cz>
	<ZrtLz8VHzZIULbOT@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_063400_189890_B7BCDD5D 
X-CRM114-Status: GOOD (  32.40  )
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

T24gVHVlLCAxMyBBdWcgMjAyNCAxMzowNDozMSArMDEwMApDYXRhbGluIE1hcmluYXMgPGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tPiB3cm90ZToKCj4gSGkgUGV0ciwKPiAKPiBPbiBUdWUsIEF1ZyAx
MywgMjAyNCBhdCAxMDo0MDowNkFNICswMjAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToKPiA+IE9u
IFR1ZSwgNiBBdWcgMjAyNCAyMDozNDo0MiArMDEwMAo+ID4gQ2F0YWxpbiBNYXJpbmFzIDxjYXRh
bGluLm1hcmluYXNAYXJtLmNvbT4gd3JvdGU6ICAKPiA+ID4gSSBoYXZlbid0IHRyaWVkIGJ1dCBp
dCdzIHBvc3NpYmxlIHRoYXQgdGhpcyBwYXRjaCBhbHNvIGJyZWFrcyB0aG9zZQo+ID4gPiBhcm02
NCBwbGF0Zm9ybXMgd2l0aCBhbGwgUkFNIGFib3ZlIDRHQiB3aGVuIENSQVNIX0FERFJfTE9XX01B
WCBpcwo+ID4gPiBtZW1ibG9ja19lbmRfb2ZfRFJBTSgpLiBIZXJlIGFsbCBtZW1vcnkgd291bGQg
YmUgbG93IGFuZCBpbiB0aGUgYWJzZW5jZQo+ID4gPiBvZiBubyBmYWxsYmFjaywgaXQgZmFpbHMg
dG8gYWxsb2NhdGUuICAKPiA+IAo+ID4gSSdtIGFmcmFpZCB5b3UndmUganVzdCBvcGVuZWQgYSBQ
YW5kb3JhIGJveC4uLiA7LSkgIAo+IAo+IE5vdCB0aGF0IGJhZCA7KSBidXQsIHllYWgsIHRoaXMg
cGF0Y2ggd2FzIGRyb3BwZWQgaW4gZmF2b3VyIG9mIHRoaXM6Cj4gCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI0MDgxMjA2MjAxNy4yNjc0NDQxLTEtcnVhbmppbmppZUBodWF3ZWkuY29t
LwoKWWVzLCBJIGhhdmUgbm90aWNlZC4gVGhhdCBvbmUgc2ltcGx5IHByZXNlcnZlcyB0aGUgc3Rh
dHVzIHF1byBhbmQgYQpmdXp6eSBkZWZpbml0aW9uIG9mICJsb3ciLgoKPiA+IEFub3RoZXIgKHVu
cmVsYXRlZCkgcGF0Y2ggc2VyaWVzIG1hZGUgdXMgYXdhcmUgb2YgYSBwbGF0Zm9ybXMgd2hlcmUg
UkFNCj4gPiBzdGFydHMgYXQgMzJHLCBidXQgSUlVQyB0aGUgaG9zdCBicmlkZ2UgbWFwcyAzMkct
MzNHIHRvIGJ1cyBhZGRyZXNzZXMKPiA+IDAtMUcsIGFuZCB0aGVyZSBpcyBhIGRldmljZSBvbiB0
aGF0IGJ1cyB3aGljaCBjYW4gcHJvZHVjZSBvbmx5IDMwLWJpdAo+ID4gYWRkcmVzc2VzLgo+ID4g
Cj4gPiBOb3csIHdoYXQgd2FzIHRoZSBpZGVhIGJlaGluZCBhbGxvY2F0aW5nIHNvbWUgY3Jhc2gg
bWVtb3J5ICJsb3ciPwo+ID4gUmlnaHQsIGl0IHNob3VsZCBhbGxvdyB0aGUgY3Jhc2gga2VybmVs
IHRvIGFjY2VzcyBkZXZpY2VzIHdpdGgKPiA+IGFkZHJlc3NpbmcgY29uc3RyYWludHMuIFNvLCBv
biB0aGUgYWJvdmUtbWVudGlvbmVkIHBsYXRmb3JtLCBhbGxvY2F0aW5nCj4gPiAibG93IiB3b3Vs
ZCBpbiBmYWN0IG1lYW4gYWxsb2NhdGluZyBiZXR3ZWVuIDMyRyBhbmQgMzNHIChpbiBob3N0IGFk
ZHJlc3MKPiA+IGRvbWFpbikuICAKPiAKPiBJbmRlZWQuIElmIHRoYXQncyBub3QgYXZhaWxhYmxl
LCB0aGUgY3Jhc2gga2VybmVsIHdvbid0IGJlIGFibGUgdG8gYm9vdAo+ICh1bmxlc3MgdGhlIGNv
cnJlc3BvbmRpbmcgZGV2aWNlIGlzIHJlbW92ZWQgZnJvbSBEVCBvciBBQ1BJIHRhYmxlcykuCgpU
aGVuIGl0IG1heSBiZSBhYmxlIHRvIGJvb3QsIGJ1dCBpdCB3b24ndCBiZSBhYmxlIHRvIHNhdmUg
YSBjcmFzaCBkdW1wCm9uIGRpc2sgb3Igc2VuZCBpdCBvdmVyIHRoZSBuZXR3b3JrLCByZW5kZXJp
bmcgdGhlIHBhbmljIGtlcm5lbAplbnZpcm9ubWVudCBhIGJpdCBsZXNzIHVzZWZ1bC4gCgo+ID4g
U2hvdWxkIHdlIHJldGhpbmsgdGhlIHdob2xlIGNvbmNlcHQgb2YgaGlnaC9sb3c/ICAKPiAKPiBZ
ZWFoLCBpdCB3b3VsZCBiZSBnb29kIHRvIHJldmlzaXQgdGhvc2UgYXQgc29tZSBwb2ludC4gRm9y
IHRoZSB0aW1lCj4gYmVpbmcsICdsb3cnIGluIHRoaXMgY29udGV4dCBvbiBhcm02NCBtZWFucyBa
T05FX0RNQSBtZW1vcnksIGJhc2ljYWxseQo+IHRoZSBjb21tb24gZGVub21pbmF0b3IgYWRkcmVz
cyByYW5nZSB0aGF0IHN1cHBvcnRzIGFsbCBkZXZpY2VzIG9uIGFuCj4gU29DLiBGb3Igb3RoZXJz
IGxpa2UgeDg2XzMyLCB0aGlzIG1lYW5zIHRoZSBtZW1vcnkgdGhhdCB0aGUga2VybmVsIGNhbgo+
IGFjdHVhbGx5IG1hcCAobm90IG5lY2Vzc2FyaWx5IGRldmljZS9ETUEgcmVsYXRlZCkuCgpBaCwg
cmlnaHQuIEkgZm9yZ290IHRoYXQgdGhlcmUgYXJlIGFsc28gY29uc3RyYWludHMgb24gdGhlIHBs
YWNlbWVudCBvZgp0aGUga2VybmVsIGlkZW50aXR5IG1hcHBpbmcgaW4gQ1BVIHBoeXNpY2FsIGFk
ZHJlc3Mgc3BhY2UuCgo+IFNvLCBpdCdzIG5vdCBhbHdheXMgYWJvdXQgdGhlIERNQSBjYXBhYmls
aXRpZXMgYnV0IGFsc28gd2hhdCB0aGUgY3Jhc2gKPiBrZXJuZWwgY2FuIG1hcCAoc28gc29tZXdo
YXQgZGlmZmVyZW50IGZyb20gdGhlIHpvbmUgYWxsb2NhdG9yIGNhc2Ugd2UndmUKPiBiZWVuIGRp
c2N1c3NpbmcgaW4gb3RoZXIgdGhyZWFkcykuCgpJdCBzZWVtcyB0byBtZSB0aGF0IGEgZ29vZCBw
YW5pYyBrZXJuZWwgZW52aXJvbm1lbnQgcmVxdWlyZXM6CgogIDEuIG1lbW9yeSB3aGVyZSBrZXJu
ZWwgdGV4dC9kYXRhIGNhbiBiZSBtYXBwZWQgKGV2ZW4gYXQgZWFybHkgaW5pdCkKICAyLiBtZW1v
cnkgdGhhdCBpcyBhY2Nlc3NpYmxlIHRvIEkvTyBkZXZpY2VzCiAgMy4gbWVtb3J5IHRoYXQgY2Fu
IGJlIGFsbG9jYXRlZCB0byB1c2VyIHNwYWNlIChlLmcuIG1ha2VkdW1wZmlsZSkKClRoZSBmaXJz
dCB0d28gYmxvY2tzIG1heSByZXF1aXJlIHNwZWNpYWwgcGxhY2VtZW50IGluIGJ1cy9DUFUgcGh5
c2ljYWwKYWRkcmVzcyBzcGFjZSwgdGhlIHRoaXJkIGRvZXMgbm90LCBidXQgaXQgbmVlZHMgdG8g
YmUgYmlnIGVub3VnaCBmb3IKdGhlIHdvcmtsb2FkLgoKSSdsbCB0cnkgdG8gdHJhbnNmb3JtIHRo
aXMga25vd2xlZGdlIGludG8gc29tZXRoaW5nIGFjdGlvbmFibGUgb3IgZXZlbgpyZXZpZXdhYmxl
LgoKRm9yIG5vdywgSSBhZ3JlZSB0aGVyZSdzIG5vdGhpbmcgbW9yZSB0byBkaXNjdXNzLgoKVGhh
bmtzClBldHIgVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
