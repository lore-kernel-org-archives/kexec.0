Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65005EB64DA
	for <kexec@archiver.kernel.org>; Wed, 19 Jul 2023 05:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W1V3/h7vB1isId26HUnEGG0Yz4wjhx6I9nHnZaJ8t10=; b=fZNJ1bqA7Rg7Wf
	o/98cVLVxsEZsPVYQmhHZGwbu2Lqr7MqZxXuxrUcfjqnrxOigwAyhzMq3yNBBnlWv6t2e/uji/OKE
	AEazIfn1lSWkrhgDFY3Q0iwosipAy6OYeRgvAkGASGCcLIxz5xestKJvOrGwIFoYIfq/eHKOmks6I
	jlS+lCoruxxS6MSU8f26WxShmgPJZjwNN8Wt2Qcy7r9PP5xUiMfFDd+RP2QmExdtUCy8bzEZNe+4v
	KB6lNG1g0OnhQKHDBA9SyInEbUszeH9E+UUbIIL6xKYTUb0j6uJqsApzLMAcxnGaeMVq3duxppqSk
	pQEHY/C5o7vvCneXvc5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLzlO-005JqY-0i;
	Wed, 19 Jul 2023 05:30:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLzlC-005JnJ-1L
	for kexec@bombadil.infradead.org;
	Wed, 19 Jul 2023 05:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KeB2jzDA3Gv6DSBks+wHB0PUw104a8wpKmW2a5qmYzY=; b=P6ZlmFI28TIZyFaU+CBIypUZpd
	m8abr7PFgikhzS5PQQBWHTW8oR6dXUiBNc1ef7/FLKOrj3RW9yMBIDelwGCqldZAqI0t5ojcwks/f
	IV0xJkjb7KlwmIX9njcIruji+5dFldHagAwFM10yh8fm0dYpBqVSbMiIWapZY6IQZIVTsgVBsImry
	//qzNzuJYLF6pH3VZPWO4rfHH0dYTVfNzKe+gGeRlv6lQq4YBqxfSNKJ1MMzovwUNPKeBPzar77N4
	BRcUqHL5kQzmGYRFMQKaSz6H8TlSE0NpBANZyjEOUcJXUZ2+Y7qmDDF2WpypzvDJqeUfCFLAo5NAL
	kSHT5ofQ==;
Received: from bee.tesarici.cz ([77.93.223.253])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLhA9-00BMl8-0m
	for kexec@lists.infradead.org;
	Tue, 18 Jul 2023 09:38:35 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C8027165293;
	Tue, 18 Jul 2023 11:37:27 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1689673047; bh=J3rpY7chO2rD8hAenAajGUc0aUf4mg1ykEcV0LVbhxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgWnxr7ZFYcUSAzRLBSc0GbWMOtIe7pu2APkKC6hkb2EuUB1MxJz3JKdyANIUgNv4
	 0mrSFPpZ55hU4YAHdufkCvew44K8y1x6Uhk5qEGyCW+VgmVyOH1bVzmhMm+5IXiCRg
	 1yXYg/G8usF46zXvrsfuwouSkxiaooICZQurn9XGr1BKjyd9XH5YKMjaqq9zQsfR6Q
	 vmg9IvK0Gtq+lUFbeG2S6yMXJjK8h0UrPfRTV/AkY+/eEycvsqcq3EV/BLXSvrov+p
	 HARJQwfQyzR01ppYNO9NhtNMoNYt0oogxlatZ+yUadoOLjv8uSMKS/CqdHTTxwYArE
	 3YRzT9+gdXJog==
Date: Tue, 18 Jul 2023 11:37:26 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Guo Ren <guoren@kernel.org>
Cc: "xianting_100@126.com" <xianting_100@126.com>, Xianting Tian
 <xianting.tian@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
 kexec@lists.infradead.org, wefu@redhat.com, yixun.lan@gmail.com, Baoquan He
 <bhe@redhat.com>
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <20230718113726.07c1f500@meshulam.tesarici.cz>
In-Reply-To: <CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
	<Y1K6TsGGC3KnFlf8@vergenet.net>
	<44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
	<c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
	<ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
	<CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230718_103833_542868_D4845C58 
X-CRM114-Status: GOOD (  36.75  )
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

T24gTW9uLCAyNyBNYXIgMjAyMyAxNjoyNzo1NiArMDgwMApHdW8gUmVuIDxndW9yZW5Aa2VybmVs
Lm9yZz4gd3JvdGU6Cgo+IEYuWS5JCj4gCj4geGlhbnRpbmdfMTAwQDEyNi5jb20KPiAKPiBPbiBN
b24sIE1hciAyNywgMjAyMyBhdCA5OjUy4oCvQU0gQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4KPiA+IEhpIFhpYW50aW5nLAo+ID4KPiA+IE9uIDEwLzI2LzIyIGF0IDEwOjU5
YW0sIFhpYW50aW5nIFRpYW4gd3JvdGU6ICAKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvMTAvMjYg5LiK
5Y2IMTA6MTMsIFhpYW50aW5nIFRpYW4g5YaZ6YGTOiAgCj4gPiA+ID4gSGkgU2ltb24KPiA+ID4g
Pgo+ID4gPiA+IHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzCj4gPiA+ID4KPiA+ID4gPiDlnKggMjAy
Mi8xMC8yMSDkuIvljYgxMToyNywgU2ltb24gSG9ybWFuIOWGmemBkzogIAo+ID4gPiA+ID4gT24g
VGh1LCBPY3QgMjAsIDIwMjIgYXQgMTE6MTU6NDhBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3cm90
ZTogIAo+ID4gPiA+ID4gPiBGcm9tOiBOaWNrIEtvc3NpZmlkaXMgPG1pY2tAaWNzLmZvcnRoLmdy
Pgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgbG9h
ZGluZyB0aGUgRUxGIGtlcm5lbCBpbWFnZS4gSXQgcGFyc2VzCj4gPiA+ID4gPiA+IHRoZSBjdXJy
ZW50L3Byb3ZpZGVkIGRldmljZSB0cmVlIHRvIGRldGVybWluZSB0aGUgc3lzdGVtJ3MgbWVtb3J5
Cj4gPiA+ID4gPiA+IGxheW91dCwgYW5kIC9wcm9jL2lvbWVtIGZvciB0aGUgdmFyaW91cyBrZXJu
ZWwgc2VnbWVudHMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggd2FzIGZpcnN0
bHkgZGV2ZWxvcGVkIGJ5IE5pY2sgS29zc2lmaWRpcywgYW5kIHR3byBmaXhlcyAoCj4gPiA+ID4g
PiA+ICAgICAxOiBmYWlsIHRvIGZpbmQgZnJlZSBtZW1vcnkgYXJlYSBmb3IgZHRiIGxvYWQgd2hl
biB1c2luZwo+ID4gPiA+ID4gPiBpbml0cmQgaW1hZ2UsCj4gPiA+ID4gPiA+IGxpc3RzLmluZnJh
ZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJpc2N2LzIwMjItQXVndXN0LzAxODM5OC5odG1sOwo+
ID4gPiA+ID4gPiAgICAgMjogZml4IG1lbW9yeSByYW5nZSBzaXplIGNhbGN1bGF0aW9uLAo+ID4g
PiA+ID4gPiAgICAgICAgIGtleGVjL2FyY2gvcmlzY3YvY3Jhc2hkdW1wLXJpc2N2LmM6bGluZSA4
NQo+ID4gPiA+ID4gPiApIGFyZSBjb250cmlidXRlZCBieSBZaXh1biBMYW4sIFhpYW50aW5nIFRp
YW4uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRlc3RlZCBvbiBRZW11J3MgcnY2NCB2aXJ0IG1h
Y2hpbmUgYW5kIFNvQyBvZiBULUhlYWQgUklTQy1WCj4gPiA+ID4gPiA+IFh1YW50aWUgOTEwIENQ
VS4gIAo+ID4gPiA+ID4gSGksCj4gPiA+ID4gPgo+ID4gPiA+ID4gdGhhbmtzIGZvciBzb21lIHBh
dGNoLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNvbWUgbWlub3IgZmVlZGJhY2sgZm9sbG93cy4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBTZXBhcmF0ZWx5LCBJJ2xsIHBvc3QgYSBwYXRjaCB0byBhZGQgUklT
Qy1WIGJ1aWxkcyB0byB0aGUgZ2l0aHViCj4gPiA+ID4gPiB3b3JrZmxvdy4gSWYgeW91IGNvdWxk
IGluY2x1ZGUgdGhhdCBpbiBWMyBJJ2QgYmUgbW9zdCBncmF0ZWZ1bC4KPiA+ID4gPiA+ICAKPiA+
ID4gPiA+ID4gVGVzdGVkLWJ5OiBZaXh1biBMYW4gPHlpeHVuLmxhbkBnbWFpbC5jb20+Cj4gPiA+
ID4gPiA+IENvLWRldmVsb3BlZC1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51
eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBZaXh1biBMYW4gPHlp
eHVuLmxhbkBnbWFpbC5jb20+Cj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pY2sgS29zc2lm
aWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+ICAKPiA+ID4gPiA+IC4uLgo+ID4gPiA+ID4gIAo+ID4g
PiA+ID4gPiArICAgIHJldCA9IG1lbV9yZWdpb25zX2FsbG9jX2FuZF9hZGQobWVtX3Jhbmdlcywg
c3RhcnQsCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgIGVuZCAtIHN0YXJ0LCB0eXBl
KTsgIAo+ID4gPiA+ID4gbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZCBpc24ndCBhbHdheXMgYXZh
aWxhYmxlLgo+ID4gPiA+ID4gZi5lLiBvbiBtaXBzIHRoaXMgY2F1c2VzIGEgYnVpbGQgZmFpbHVy
ZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBSZWY6IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhl
Yy10b29scy9hY3Rpb25zL3J1bnMvMzI5ODQ5MTE0My9qb2JzLzU0NDA2Nzc1OTUgIAo+ID4gPiA+
Cj4gPiA+ID4gQXMgeW91IGtub3csIG1lbV9yZWdpb25zX3NvcnQsIG1lbV9yZWdpb25zX2FsbG9j
X2FuZF9hZGQgYXJlIHRoZSBjb21tb24KPiA+ID4gPiBmdW50aW9ucywKPiA+ID4gPgo+ID4gPiA+
IFRoZSBidWlsZCBlcnJvciBvZiBtaXBzIGlzIGNhdXNlZCBieSB0aGlzIHJpc2N2IHBhdGNoPwo+
ID4gPiA+Cj4gPiA+ID4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzp2b2lkIG1lbV9yZWdpb25zX3NvcnQo
c3RydWN0IG1lbW9yeV9yYW5nZXMgKnJhbmdlcykKPiA+ID4gPiBrZXhlYy9tZW1fcmVnaW9ucy5o
OnZvaWQgbWVtX3JlZ2lvbnNfc29ydChzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAqcmFuZ2VzKTsKPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzppbnQgbWVtX3JlZ2lvbnNf
YWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+ID4gPiA+ICpyYW5nZXMsCj4gPiA+
ID4ga2V4ZWMvbWVtX3JlZ2lvbnMuaDppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChzdHJ1
Y3QgbWVtb3J5X3Jhbmdlcwo+ID4gPiA+ICpyYW5nZXMsCj4gPiA+ID4gIAo+ID4gPiA+ID4KPiA+
ID4gPiA+IC4uLgo+ID4gPiA+ID4gIAo+ID4gPiA+ID4gPiAraW50IGR0Yl9nZXRfbWVtb3J5X3Jh
bmdlcyhjaGFyICpkdGIsIHN0cnVjdCBtZW1vcnlfcmFuZ2VzCj4gPiA+ID4gPiA+ICptZW1fcmFu
Z2VzLCBzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAqZXh0cmFfcmFuZ2VzKQo+ID4gPiA+ID4gPiAreyAg
Cj4gPiA+ID4gPiAuLi4KPiA+ID4gPiA+ICAKPiA+ID4gPiA+ID4gKyAgICBtZW1fcmVnaW9uc19z
b3J0KG1lbV9yYW5nZXMpOyAgCj4gPiA+ID4gPiBMaWtld2lzZSwgbWVtX3JlZ2lvbnNfc29ydCBp
c24ndCBhbHdheXMgYXZhaWxhYmxlLgo+ID4gPiA+ID4gZi5lLiBvbiBtaXBzIHRoaXMgY2F1c2Vz
IGEgYnVpbGQgZmFpbHVyZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAuLi4KPiA+ID4gPiA+ICAKPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3B1cmdhdG9yeS9hcmNoL3Jpc2N2L01ha2VmaWxlCj4gPiA+
ID4gPiA+IGIvcHVyZ2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZpbGUKPiA+ID4gPiA+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiA+ID4gPiA+ID4gaW5kZXggMDAwMDAwMC4uOGJkZWQ3MQo+ID4gPiA+
ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ID4gPiA+ICsrKyBiL3B1cmdhdG9yeS9hcmNoL3Jpc2N2
L01ha2VmaWxlCj4gPiA+ID4gPiA+IEBAIC0wLDAgKzEsNyBAQAo+ID4gPiA+ID4gPiArIwo+ID4g
PiA+ID4gPiArIyBQdXJnYXRvcnkgcmlzY3YKPiA+ID4gPiA+ID4gKyMKPiA+ID4gPiA+ID4gKwo+
ID4gPiA+ID4gPiArcmlzY3ZfUFVSR0FUT1JZX1NSQ1MgPQo+ID4gPiA+ID4gPiArCj4gPiA+ID4g
PiA+ICtkaXN0ICs9IHB1cmdhdG9yeS9hcmNoL3NoL01ha2VmaWxlICQocmlzY3ZfUFVSR0FUT1JZ
X1NSQ1MpICAKPiA+ID4gPiA+IHMvc2gvcmlzY3YvCj4gPiA+ID4gPgo+ID4gPiA+ID4gRWxzZSB0
aGUgZGlzdHJpYnV0aW9uIHRhcmJhbGwgd29uJ3QgaW5jbHVkZSB0aGlzIE1ha2VmaWxlCj4gPiA+
ID4gPgo+ID4gPiA+ID4gWW91IGNhbiBleGVyY2lzZSB0aGlzIHVzaW5nOgo+ID4gPiA+ID4gICAg
bWFrZSBkaXN0Y2hlY2sgRElTVENIRUNLX0NPTkZJR1VSRV9GTEFHUz0iLS1ob3N0PXJpc2N2NjQt
bGludXgtZ251IiAgCj4gPiA+ID4gdGhhbmtzLCBJIHdpbGwgZml4IHRoaXMuICAKPiA+ID4KPiA+
ID4gdGhlIGZpeCBpcyBpbiBteSBwZXJzb25hbCBnaXRlZQo+ID4gPgo+ID4gPiBodHRwczovL2dp
dGVlLmNvbS94aWFudGluZy10aWFuL2tleGVjLXRvb2xzL2NvbW1pdHMvbWFzdGVyICAKPiA+Cj4g
PiBJcyB0aGlzIHBhdGNoc2V0IHJlcG9zdGluZyBzdGlsbCBpbiB5b3VyIHdvcmtpbmcgcGxhbj8g
SSBkb24ndCBzZWUgdGhlCj4gPiBjb2RlIGluIGtleGUtdG9vbHMsIHNvIHBpbmcgdG8gYXNrLgo+
ID4KPiA+IElmIHRoaXMgaXMgbm90IHlvdXIgd29yayB0YXNrcyBhbnkgbW9yZSwgcGVvcGxlIGlu
dGVyZXN0ZWQgY2FuIHBpY2sgdGhpcwo+ID4gcGF0Y2hzZXQgYW5kIHBvc3QgYWZ0ZXIgcG9saXNo
aW5nLgoKTm93IGl0IHNlZW1zIEkgYW0gaW50ZXJlc3RlZC4gRllJIG15IHBsYW4gaXMgdG8gc3Rh
cnQgd29ya2luZyBvbiB0aGlzCmlmIHRoZXJlIGlzIG5vIGZ1cnRoZXIgcmVhY3Rpb24gZnJvbSBh
bnlib2R5IGVsc2Ugd2l0aGluIGEgZm9ydG5pZ2h0LgoKUGV0ciBUCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
