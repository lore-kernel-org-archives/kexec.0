Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44099D1CDA1
	for <kexec@archiver.kernel.org>; Tue, 22 Oct 2024 06:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUukUk8iYnKxHKCpbmFDG6eO65EZxWnwpZmslTpTqZQ=; b=Uyo7HjTPpCAqP8
	t1YTdFovA6SYB8dZfgGVu1RqAOu5umks5HE3rwaBjzM/4aVuJpixwCl/UZYbM4o1Juy1XXPtlXTD5
	xiTblMWNnydWos+XQsvmFzyAlwOZAK/TTRsxr6MyMtNKcf1T8/7pbV4MLSZbmDqi9OVQVeQUX8NEs
	cpmL9XNuzSOMogC/hvTlbwF9jsjB+l/pLvI+0JUscxegbbkHUEDeuT6cZYCyQYwlw1u3/BynOQbPe
	2Wsc00bFYyXyV3CIMumtqAASS2lOdK+CbdP0Dqa8pPf9ve7xuQBtFHgtru4Ig55LtC5hM6l5dDXTZ
	m7ksA3L+Sk94jUiYWo4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38L0-00000009nw8-0AxT;
	Tue, 22 Oct 2024 06:25:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38Kt-00000009nvU-2Ywj
	for kexec@lists.infradead.org;
	Tue, 22 Oct 2024 06:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729578340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG1CnhguTFudhDNP7EG2wfjiJo8LWO9xpmww9MVdItw=;
	b=gaipqLb3c6XatTbbD/N9dGDGiI30ifU6BLKGAHjvuNCnQJvskx3zz49PmTk3OUKAXhdBNX
	DkgAPb0CNKex67ewn8tQFe7YPb0tVMvLvUEbwTsnSlBCKwgSUdwVdSF7oJ0W3/WN4XmhiT
	soDn7jrHkXqUHGl4gfqpDbhLSUtZtj4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-3h5aSuDSOiulqsB5Cqicaw-1; Tue, 22 Oct 2024 02:25:38 -0400
X-MC-Unique: 3h5aSuDSOiulqsB5Cqicaw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ce242668ebso6619346d6.2
        for <kexec@lists.infradead.org>; Mon, 21 Oct 2024 23:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729578338; x=1730183138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG1CnhguTFudhDNP7EG2wfjiJo8LWO9xpmww9MVdItw=;
        b=afVH18Gwut519DXwqWJQJLpgk2ZVYnNUpv+gsNx8R2XOxQkEEqT4JPFaMMh/LYjTbI
         PzuHn3NCOP5vQVN+LFk9dWHsmOPptm7TqWFj9Tlmjv5Be7CXq75YEemHIdeEGct+KjHQ
         hgAJH8IN9P8z24XF3YO7JQmLWY3zlkplHHYRL3iw+5NOoifK78WpakfUrQp2aKCGQiC9
         XCMtHVXDiB2PX8c9l6QseBlQxlwCGmUwcq7Lv85tnfATZGE3Kv8VG5YPbOz7Q4FBGrkl
         u0MAicv00/Y5RY7P0YcZF9BBubiQhyWNRZ+WmHfoyCmp+IOB66lBDy+PdkutBekj8nxU
         k2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV0NYWMYHvXNCZgF+qUxiXJwLDnR1TlruCVvzdtQlKoVoOHDKLpBh/GjdrBE1wiOtFVOaOIZw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7eiTTbtLSL5U+rF9k38c9gNF7TNQ+AnmtDMDaK6qg6kJuhMoy
	rRqZlO9c/LAHz3Wy0NUGzZpv6VsDSF1AMNAzU5c6VlFJirkzWz4tD6al7e0xiT8ycHzKqSKH965
	pUX88XNibsWqH8i1ei6JUcism8aFOMDECrunWtas9aJ8Yu4mlNuPV1OzA44jCQUpXghxOgvjl5W
	jeB8YhU399Bm+W4fuj0EfwTNcFlDt8Tw42
X-Received: by 2002:a05:6214:5c47:b0:6cb:fff6:8f31 with SMTP id 6a1803df08f44-6ce23f5d15dmr17766606d6.47.1729578338379;
        Mon, 21 Oct 2024 23:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBOfheIGtzqhHWYeCprFnp6dUVrp0QgkhuTIyGLIi8taZWKHRge8OH2+yEKi2pv7pim28fS75L/8IGCQtOraM=
X-Received: by 2002:a05:6214:5c47:b0:6cb:fff6:8f31 with SMTP id
 6a1803df08f44-6ce23f5d15dmr17766496d6.47.1729578337999; Mon, 21 Oct 2024
 23:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241016113418.22568-1-piliu@redhat.com> <20241021182506.37b16102@rotkaeppchen>
In-Reply-To: <20241021182506.37b16102@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 22 Oct 2024 14:25:27 +0800
Message-ID: <CAF+s44R3PmzQXxzoHavmL-PziGSmvwjn-DN8zHFYwSd9jejdnA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] kexec: Add support for UKI format kernel
To: Philipp Rudo <prudo@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Lennart Poettering <mzxreary@0pointer.de>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_232543_751316_5DC47391 
X-CRM114-Status: GOOD (  34.76  )
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

SGkgUGhpbGlwcCwKClRoYW5rcyBmb3Igc2hhcmluZyB5b3VyIHRob3VnaHRzLgoKT24gVHVlLCBP
Y3QgMjIsIDIwMjQgYXQgMTI6MjXigK9BTSBQaGlsaXBwIFJ1ZG8gPHBydWRvQHJlZGhhdC5jb20+
IHdyb3RlOgo+Cj4gSGkgUGluZ2ZhbiwKPiBIaSBTaW1vbiwKPgo+IEkga25vdyBJJ20gYSBsaXR0
bGUgYml0IHRvbyBsYXRlLCBidXQgSSBmaW5hbGx5IGhhZCB0aW1lIHRvIHRha2UgYQo+IGxvb2su
IEFsbCBpbiBhbGwgdGhlIHNlcmllcyBsb29rcyBmaW5lIHRvIG1lLiBCdXQgSSBoYXZlIHR3byBx
dWVzdGlvbnMuCj4KPiAxKSBJcyB0aGVyZSBhIHJlYXNvbiB3aHkgeW91IGRvbid0IGVuYWJsZSB0
aGUgVUtJIGZvciB4ODYgYXMgd2VsbD8gVGhlCj4gd2F5IEkgc2VlIGl0IHBhdGNoIDEgYW5kIDIg
Y292ZXIgeDg2IGFzIHdlbGwuIFNvIHlvdSBvbmx5IHNob3VsZCBuZWVkIGEKPiBwYXRjaCBzaW1p
bGFyIHRvIHBhdGNoIDMuIE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4KClllcywgdGhlcmUg
c2hvdWxkIGJlIG9uZSBmb3IgeDg2LiBJIHdpbGwgZG8gaXQgYWZ0ZXIgdGhpcyBzZXJpZXMgaXMg
bWVyZ2VkLgoKPiAyKSBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvICJyZXVzZSIgdGhlIG1lY2hhbmlz
bSB5b3UgaW50cm9kdWNlZCBmb3IgdGhlCj4gaW5pdHJkIGZvciB0aGUgY29tbWFuZCBsaW5lIGFz
IHdlbGwuIEkuZS4gaWYgaXQncyBhIFVLSSB3aXRoIGEgLmNtZGxpbmUKPiBzZWN0aW9uIGFuZCB0
aGUgdXNlciBkaWRuJ3QgcHJvdmlkZSBhbnkgb2YgdGhlIC0tY29tbWFuZC1saW5lLAo+IC0tcmV1
c2UtY21kbGluZSwgZXRjLiB0aGVuIHVzZSB0aGUgY29tbWFuZCBsaW5lIGZyb20gdGhlIFVLSS4K
PgoKSSBoYWQgdGhvdWdodCBhYm91dCBpdCwgYW5kIHRoZSBzY2VuYXJpbyBzaG91bGQgbG9vayBs
aWtlIHRoaXM6IGEKc3lzdGVtIHdpdGggYSBVS0kgaW1hZ2Ugc28gdGhlcmUgaXMgbm8gZGlyZWN0
IGFjY2VzcyB0byBnZXQgaW5pdHJkLAp3aGljaCBvYnN0cnVjdHMgdGhlIHVzZSBvZiAtLWluaXRy
ZCBvcHRpb24uIE9uIHRoZSBvdGhlciBoYW5kLAotLXJldXNlLWNtZGxpbmUgY2FuIGFsd2F5cyBn
ZXQgdGhlIGNtZGxpbmUgZnJvbSAvcHJvYy9jbWRsaW5lIHdpdGhvdXQKdHJvdWJsZS4KClRoYW5r
cywKClBpbmdmYW4KCj4gVGhhbmtzCj4gUGhpbGlwcAo+Cj4gT24gV2VkLCAxNiBPY3QgMjAyNCAx
OTozNDoxMiArMDgwMAo+IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPiB3cm90ZToKPgo+
ID4gQXMgYSBVRUZJIFBFIGZvcm1hdCBrZXJuZWwgaW1hZ2UgYmVjb21lcyBtb3JlIHBvcHVsYXIs
IHRoZXJlIGlzIGEgbmVlZAo+ID4gZm9yIGtleGVjIHRvIHJlYm9vdCB0aG9zZSBraW5kcyBvZiBp
bWFnZXMuCj4gPgo+ID4gQWZ0ZXIgdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgVUtJIChhbm90aGVy
IFBFKSwgYXQgcHJlc2VudCwgdGhlcmUgYXJlCj4gPiB0aHJlZSBjb21wZXRpdGl2ZSBtZXRob2Rz
IHRvIHN1cHBvcnQgdGhhdCBnb2FsLCBidXQgYWxsIG9mIHRoZW0gaGF2ZQo+ID4gcHJvcyBhbmQg
Y29ucy5bMV0gSXQgc2VlbXMgdGhhdCBub25lIG9mIHRoZW0gY2FuIGJlIGFjY2VwdGVkIGluIHRo
ZSBuZWFyCj4gPiBmdXR1cmUuICBUaGVyZWZvcmUsIHdlIGFyZSByZXNvcnRpbmcgdG8gdGhlIHVz
ZXIgc3BhY2Uga2V4ZWMtdG9vbHMgdG8KPiA+IHBhcnNlIHRoZSBVS0kgZm9ybWF0IGZvciB0aGUg
dGltZSBiZWluZy4KPiA+Cj4gPiBCeSBwYXJzaW5nIHRoZSBVS0ksIHN5c3RlbWQtc3R1YiBpcyBz
dGVwcGVkIGFyb3VuZCBhbmQgUENNIHdpbGwgbm90IGFmZmVjdAo+ID4gdGhlIGJvb3QgdXAgb2Yg
dGhlIHNlY29uZCBzeXN0ZW0uCj4gPgo+ID4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vcmhrZHVt
cC9rZXhlY191ZWZpL2Jsb2IvbWFpbi9vdmVydmlldy5tZCN0aGUtY29tcGV0aXRpdmUtc29sdXRp
b25zCj4gPgo+ID4gQ2M6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KPiA+IENjOiBF
cmljIEJpZWRlcm1hbiA8ZWJpZWRlcm1AeG1pc3Npb24uY29tPgo+ID4gQ2M6IEJhb3F1YW4gSGUg
PGJoZUByZWRoYXQuY29tPgo+ID4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+
ID4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Cj4gPiBDYzogSmFuIEhlbmRy
aWsgRmFyciA8a2VybmVsQGpmYXJyLmNjPgo+ID4gQ2M6IFBoaWxpcHAgUnVkbyA8cHJ1ZG9AcmVk
aGF0LmNvbT4KPiA+IENjOiBMZW5uYXJ0IFBvZXR0ZXJpbmcgPG16eHJlYXJ5QDBwb2ludGVyLmRl
Pgo+ID4gQ2M6IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+IC0tLQo+ID4gdjEgLT4gdjI6
Cj4gPiBBZGQgaW5jbHVkZS9wZS5oIGluIG1ha2VmaWxlIHRvIGZpeCAnbWFrZSBkaXN0Jwo+ID4g
UmVuYW1lIGRlZmF1bHRfaW5pdHJkX2ZkIHRvIGltcGxpY2l0X2luaXRyZF9mZAo+ID4KPiA+Cj4g
PiBQaW5nZmFuIExpdSAoMyk6Cj4gPiAgIGtleGVjOiBJbnRyb2R1Y2UgaW1wbGljaXRfaW5pdHJk
X2ZkIHRvIHBhc3MgaW50ZXJuYWwgaW5pdHJkCj4gPiAgICAgaW5mb3JtYXRpb24KPiA+ICAga2V4
ZWM6IEludHJvZHVjZSBVS0kgaW1hZ2UgcGFyc2VyCj4gPiAgIGFybTY0OiBTdXBwb3J0IFVLSSBp
bWFnZSBmb3JtYXQKPiA+Cj4gPiAgaW5jbHVkZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
IHwgICAxICsKPiA+ICBpbmNsdWRlL3BlLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAxMDQg
KysrKysrKysrKysrKysrKysrKysrKysKPiA+ICBrZXhlYy9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKwo+ID4gIGtleGVjL2FyY2gvYXJtNjQva2V4ZWMtYXJtNjQuYyAgICAg
ICB8ICAgMSArCj4gPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy1pbWFnZS1hcm02NC5jIHwgICAz
ICstCj4gPiAga2V4ZWMvYXJjaC94ODZfNjQva2V4ZWMtYnpJbWFnZTY0LmMgIHwgICAzICstCj4g
PiAga2V4ZWMva2V4ZWMtdWtpLmMgICAgICAgICAgICAgICAgICAgIHwgMTIyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ID4gIGtleGVjL2tleGVjLmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMiArCj4gPiAga2V4ZWMva2V4ZWMuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1
ICsrCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAyNDAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9wZS5oCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGtleGVjL2tleGVjLXVraS5jCj4gPgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
