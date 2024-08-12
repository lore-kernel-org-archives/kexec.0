Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B3C52D7C
	for <kexec@archiver.kernel.org>; Mon, 12 Aug 2024 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tt9dIV3f6d5x8Mv4RNZvgtn4Wi36CBwxeBIYXDNZizo=; b=jHnXzFhdrY8N2E
	nY2FfjCYL2h8NpBqAczeLSMPHax+YWN0tXcjljhey6zrMVJPK+6Rd1kx8bwUVhpG2AcfhM7cOuxRw
	5/s9D5vQXJx6JP5oIyu4wo38TWpFFVEb8W581NVpqPxABA+e9RJc3bCNP9Jj9WDmXvyN4qHtV/uUV
	KZ39C12iNjYcQYoX+fKLyGiNQN1Lnq/hD5i21oM10WAb4YoWMYMPWSoorDRtGxrnYBSBA97x4P95/
	oDVvxMZH2nxL0hX/B0hOvItto2oUGHSV87Kybs24MFKtAp6aNzb9qD0Bbo0B+jPotQUgItMbbslxF
	T/V8vLySX2L0BNTLjqkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWCl-00000000btQ-23QP;
	Mon, 12 Aug 2024 14:39:27 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWA2-00000000bL8-0dTR
	for kexec@lists.infradead.org;
	Mon, 12 Aug 2024 14:36:39 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5bd13ea7604so2587221a12.1
        for <kexec@lists.infradead.org>; Mon, 12 Aug 2024 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723473396; x=1724078196; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjOsywNrbcE4UxuAxlu1Xwif05SAEzh0KgLoz26brY0=;
        b=QlgITGp8iyxvN/1LeudvsQQwTVGTGDFJI8llQkYSUmaT4UpyyjUlgujb3PodZ1B2fv
         apLakvBXTpwSqJ1RSIWkOT65q2aCGRxHkiSAaTYfqbvUl4S5aAqT6ia1yKbAbl/g9356
         W5t2VeEM2nNMc6cVk7A/OzuixCb5OJBSQnzpSGnmaIKaGTfYaeN5HENBz7jKt1fMs41O
         3pNyXJ501LPKO9RhmjuPL4iXkUeblge5b63LeLd01LPSJZ2HEIQQPCmXWV3vwXVHzlCc
         l8PHOX5g2H5waV9ncpavmQGEFoAWan5FVw5DGWKBBfe+TlXFkcmi+SLEPsqUNhUNk+IX
         IrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473396; x=1724078196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjOsywNrbcE4UxuAxlu1Xwif05SAEzh0KgLoz26brY0=;
        b=ZnBX4uGcLb+RVh+fkU1e032PHTLd7a8pihP5hSlv8g+aiVIseANF8LiBg24nRJdz4L
         MIF136NGz/Y9tmjwN6KnqGhfaDLklaXIqRwl598XJIgyKnD5gSeQkbLvhssAkRsWQGdT
         ouybpYZZq2RCpAftT1wbFbASYVp8QkVlhmCaMMXqpdcZ8KNB0otaXJ+j3R9/c9/yxTy5
         VXzaiKpDlYRuQwqO1PLKkji00IQn37dCGwaifAuuh3+1JwxDxSm3ffX8Cjl4YuAXpWHB
         Nq14Aq4UuWmJ1wc5ArD4J3ArCrA+QDSGfrVRBaRpdvS1wIYPnBBhjpwDf+ld2AxmG/SL
         aGzA==
X-Forwarded-Encrypted: i=1; AJvYcCXswtH0rx3clpydqc+wqawACXx2M/S96T5f3O/K5X7Odrli+OlidZyVaprnXXU2t0R5xdYrWka9qZtkBnD+aBt6edmz+Sv6t/v2
X-Gm-Message-State: AOJu0Yy/y3EMsi5+0oEVdvH+hWSd0X9sUg8LboB+OKfcoG0eXUse9gZU
	UUtfWu0OW+y2nOpYaIjrnNWY3hYdLG8fmq1LVYH6FPVP5knDdGHXzW5g8hbMgOU=
X-Google-Smtp-Source: AGHT+IHJET/I8f4o5FaTdif28OtyAhMSDahjgU3UyJpLWrL9T4oxK7DQK7nhzsRkmqBZFHsSddcNoQ==
X-Received: by 2002:a17:907:9413:b0:a7a:bb54:c852 with SMTP id a640c23a62f3a-a80ed2d1823mr32283166b.61.1723473396168;
        Mon, 12 Aug 2024 07:36:36 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1240sm235618966b.73.2024.08.12.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:36:35 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:36:33 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Simon Horman <horms@kernel.org>, Song Shuai <songshuaishuai@tinylab.org>
Cc: Dave Young <dyoung@redhat.com>, mick@ics.forth.gr,
 lizhengyu3@huawei.com, liaochang1@huawei.com,
 xianting.tian@linux.alibaba.com, guoren@kernel.org,
 huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com, kexec@lists.infradead.org,
 hursand@fedoraproject.org
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Message-ID: <20240812163633.098f8f07@mordecai.tesarici.cz>
In-Reply-To: <20240518083304.GD475595@kernel.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
	<20230920115634.GG224399@kernel.org>
	<DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
	<CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
	<20240518083304.GD475595@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_073638_219630_A6C9E9B9 
X-CRM114-Status: GOOD (  35.45  )
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

SGksCgpPbiBTYXQsIDE4IE1heSAyMDI0IDA5OjMzOjA0ICswMTAwClNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4gd3JvdGU6Cgo+IE9uIFNhdCwgTWF5IDE4LCAyMDI0IGF0IDExOjM5OjE4
QU0gKzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4gPiBPbiBXZWQsIDExIE9jdCAyMDIzIGF0IDEz
OjI0LCBTb25nIFNodWFpIDxzb25nc2h1YWlzaHVhaUB0aW55bGFiLm9yZz4gd3JvdGU6ICAKPiA+
ID4KPiA+ID4KPiA+ID4KPiA+ID4g5ZyoIDIwMjMvOS8yMCAxOTo1NiwgU2ltb24gSG9ybWFuIOWG
memBkzogIAo+ID4gPiA+IE9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDExOjUwOjA2QU0gKzA4MDAs
IFNvbmcgU2h1YWkgd3JvdGU6ICAKPiA+ID4gPj4gSGksCj4gPiA+ID4+Cj4gPiA+ID4+IFRoaXMg
c2VyaWVzIGlzIGNyZWF0ZWQgdG8gaW1wcm92ZSBSSVNDLVYgcG9ydCBvZiBrZXhlYy10b29scywK
PiA+ID4gPj4gYW5kIGlzIGJhc2VkIG9uIHRoZSBob3Jtcy9rZXhlYy10b29sczpidWlsZC10ZXN0
LXJpc2N2LXYyIGJyYW5jaC4gIAo+ID4gPiA+Cj4gPiA+ID4gSW4gbXkgbWluZCB0aGUgYmlnIHF1
ZXN0aW9uIGlzIGhvdyB0byBtb3ZlIFJJU0MtViBzdXBwb3J0Cj4gPiA+ID4gZnJvbSB0aGF0IGJy
YW5jaCwgdG8gYmVpbmcgbWVyZ2VkIGludG8gbWFpbi4KPiA+ID4gPgo+ID4gPiA+IElJUkMgdGhl
cmUgd2VyZSBzb21lIGlzc3VlcyB0aGF0IG5lZWRlZCB0byBiZSBhZGRyZXNzZWQuCj4gPiA+ID4g
UGVyaGFwcyB0aGV5IGFyZSBhbGwgYWRkcmVzc2VkIGJ5IHRoaXMgc2VyaWVzLCBhbmQgd2l0aAo+
ID4gPiA+IHNvbWUgYXBwcm9wcmlhdGUgc3F1YXNoaW5nIHdlIGNhbiBtb3ZlIGZvcndhcmRzIHdp
dGggYSBzZXJpZXMKPiA+ID4gPiBiYXNlZCBvbiBtYWluPyAgCj4gPiA+Cj4gPiA+IEhpLCBTaW1v
biBhbmQgTmljazoKPiA+ID4KPiA+ID4gSSBzcXVhc2hlZCB0aGUgZmlyc3QgZm91ciBwYXRjaGVz
IGFzIGEgIlJJU0MtVjogU29tZSBmaXhlcyBmb3IgcmlzY3YKPiA+ID4gcG9ydCIgcGF0Y2ggYW5k
IHRoZW4gdG9vayB0aGUgaG9ybXMvbWFpbiBhcyB0aGUgYmFzZSB0byBjb2xsZWN0IHRoZSAyCj4g
PiA+IHBhdGNoZXMgZnJvbSBob3Jtcy9idWlsZC10ZXN0LXJpc2N2LXYyIGJyYW5jaCBhbmQgdGhp
cyBzZXJpZXMgdG9nb3RoZXIuCj4gPiA+IFRoZXNlIGFyZSB0aGUgR2l0aHViIGxpbmsgYW5kIGFs
bCBjb21taXRzIGZvciBSSVNDLVYuCj4gPiA+Cj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9zdWdh
cmZpbGxldC9rZXhlYy10b29scy9jb21taXRzL21haW5fcnYKPiA+ID4KPiA+ID4gNWRjMTMzZSBS
SVNDLVY6IFN1cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5hcnkgZmlsZQo+ID4gPiBiMDQyZjZkIFJJ
U0MtVjogU2VwYXJhdGUgZWxmX3Jpc2N2X2ZpbmRfcGJhc2Ugb3V0Cj4gPiA+IDhmMzQ0YzcgUklT
Qy1WOiBFbmFibGUga2V4ZWNfZmlsZV9sb2FkIHN5c2NhbGwKPiA+ID4gN2Q0Yjk4MiBSSVNDLVY6
IFNvbWUgZml4ZXMgZm9yIHJpc2N2IHBvcnQKPiA+ID4gMzIwNWMxYyBsb2NhbDogUklTQy1WOiBk
aXN0cmlidXRlIHB1cmdhdG9yeS9yaXNjdi9NYWtlZmlsZQo+ID4gPiA1NGY5ZGFmIFJJU0MtVjog
QWRkIHN1cHBvcnQgZm9yIHJpc2N2IGtleGVjL2tkdW1wIG9uIGtleGVjLXRvb2xzCj4gPiA+Cj4g
PiA+IFNpbmNlIEkgZGlkbid0IGZvdW5kIHRoZSBpc3N1ZXMvZml4ZXMgYXMgTmljayBtZW50aW9u
ZWQgd2l0aCB0aGVzZQo+ID4gPiBjb21taXRzLCBJIHByZWZlciB0byBtZXJnZSB0aGVtIGludG8g
aG9ybXMvbWFpbiBhbmQgbGV0IG1vcmUga2V4ZWMva2R1bXAKPiA+ID4gdXNlcnMgdG8gaGVscCBp
bXByb3ZlL2ZpeHVwIFJJU0MtViBwb3J0LiAgCj4gPiAKPiA+IEhpLCAgSSBub3RpY2VkIGFub3Ro
ZXIgcHIgZm9yIEZlZG9yYSBrZXhlYy10b29sczoKPiA+IGh0dHBzOi8vc3JjLmZlZG9yYXByb2pl
Y3Qub3JnL3JwbXMva2V4ZWMtdG9vbHMvcHVsbC1yZXF1ZXN0LzI0Cj4gPiAKPiA+IEl0IGlzIGJh
ZCB0byB0YWtlIGl0IGFzIEZlZG9yYSBvbmx5LCAgIEkgd291bGQgc3VnZ2VzdCBwb3N0aW5nIGFs
bCB0aGUKPiA+IHJlZnJlc2hlZCBwYXRjaGVzIHRvZ2V0aGVyIGhlcmUgYWdhaW4gZm9yIHJldmll
dy4KPiA+IAo+ID4gSWYgbm8gZW5vdWdoIHJldmlld2VycyBjYW4gcmV2aWV3IHRoZW0gbXkgYW5v
dGhlciBzdWdnZXN0aW9uIGlzIHRvCj4gPiBkcm9wIHRoZSBrZXhlY19sb2FkIHN1cHBvcnQgY29k
ZSBmb3IgdGhlIHRpbWUgYmVpbmcsIGFuZCBvbmx5IGVuYWJsZQo+ID4gdGhlIGtleGVjX2ZpbGVf
bG9hZCBzdXBwb3J0IGNvZGUgaW4ga2V4ZWMtdG9vbHMsIGFuZCBJIGFzc3VtZSBiZWxvdwo+ID4g
a2VybmVsIGNvbW1pdCBtYWtlIHRoZSBrZXhlY19maWxlX2xvYWQga2VybmVsIHBpZWNlIG9mIHdv
cmsgZG9uZS4KPiA+IFRoZW4gaXQgd2lsbCBiZSBlYXNpZXIgdG8gcmV2aWV3IGFuZCBtYWtlIHNv
bWV0aGluZyB3b3JraW5nIGF0IGxlYXN0Lgo+ID4gY29tbWl0IDYyNjE1ODZlMGM5MWRiMTRjMzRm
ODk0ZjRiYzQ4ZjIzMDBjZmYxZDQKPiA+IEF1dGhvcjogTGlhbyBDaGFuZyA8bGlhb2NoYW5nMUBo
dWF3ZWkuY29tPgo+ID4gRGF0ZTogICBGcmkgQXByIDggMTg6MDk6MTEgMjAyMiArMDgwMAo+ID4g
Cj4gPiAgICAgUklTQy1WOiBBZGQga2V4ZWNfZmlsZSBzdXBwb3J0ICAKPiAKPiBIaSwKPiAKPiBJ
IHdvdWxkIGdsYWRseSB0YWtlIGEgcGF0Y2hzZXQgZm9yIGtleGVjLXRvb2xzIHRoYXQgYWRkcyBS
SVNDLVYgc3VwcG9ydCBpbgo+IGEgY29oZXJlbnQgbWFubmVyLgoKSGF2ZSBJIG1pc3NlZCBzb21l
IHByb2dyZXNzIG9uIHRoaXMgdG9waWM/IEZXSVcgSSBjYW4gdGFrZSBjYXJlIG9mClJJU0MtViBz
dXBwb3J0IGluIGtleGVjLXRvb2xzLCBJIGV2ZW4gcmVjZWl2ZWQgYSBWaXNpb25GaXZlIDIgYm9h
cmQKZnJvbSBSVkkgbGFzdCB5ZWFyIHNwZWNpZmljYWxseSB0byBoZWxwIHdpdGgga2V4ZWMuCgpJ
IG1lcmVseSBkb24ndCB3YW50IHRvIGR1cGxpY2F0ZSBlZmZvcnRzIG9yICJzdGVhbCIgc29tZW9u
ZSBlbHNlJ3MKcHJvamVjdC4gSXMgUklTQy1WIHN1cHBvcnQgaW4ga2V4ZWMtdG9vbHMgYW4gb3Jw
aGFuZWQgcHJvamVjdCBub3c/CgpQZXRyIFQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
