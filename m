Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37607C4332F
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v+hPk8ZOSM6VXT93mcBkROAIsZ6vdsj3h0eYpfMokVI=; b=OvhdCFMb+g4smB
	3AHn/5n+m7wWB5oLpkK67Z1xN2WQ1xAentcXY+WJfZEsWzD5GwRAK/VMsSvvWyoOF48k9dcriUWBm
	ViR9aWFiE+ffgx2HZXhqbTST4RGRya3nsa3zkp8oqf8zI/liuGloRkggix288Q1lW9yewi0KnqYdI
	YTW/y+LeeAmWsKGkw/KMe/3ZtUt1yxB1LOCNkseWkzdMxm/O6UNhCGa514SdYkoHG7NnjfQUSHP2e
	jXlIRw93vRxoCLo4Hqb8ssol8Tg5n8tmIT21TQmLsUkPGMatfhcmj3utLt1IWI9EftMjNVsyVbSVf
	nm1Jb+wa9D9q0cu+IXBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orqy5-00Aqgv-BU; Mon, 07 Nov 2022 01:30:29 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orqxv-00Aqa3-1y; Mon, 07 Nov 2022 01:30:20 +0000
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5D8m0dV2zpSsn;
	Mon,  7 Nov 2022 09:26:32 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:30:09 +0800
Message-ID: <3b34d898-4690-c774-e92f-69796f9f5d37@huawei.com>
Date: Mon, 7 Nov 2022 09:30:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
To: Li Huafei <lihuafei1@huawei.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <lizhengyu3@huawei.com>,
	<u.kleine-koenig@pengutronix.de>, <rdunlap@infradead.org>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
From: "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_173019_480369_39158886 
X-CRM114-Status: GOOD (  14.74  )
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

CgrlnKggMjAyMi8xMS80IDE3OjU2LCBMaSBIdWFmZWkg5YaZ6YGTOgo+IFRoaXMgaXMgcmVwb3J0
ZWQgYnkga21lbWxlYWsgZGV0ZWN0b3I6Cj4gCj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmNjAw
MDAwODI4NjQwMDAgKHNpemUgOTU4OCk6Cj4gICBjb21tICJrZXhlYyIsIHBpZCAxNDYsIGppZmZp
ZXMgNDI5NDkwMDYzNCAoYWdlIDY0Ljc4OHMpCj4gICBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMp
Ogo+ICAgICBkMCAwZCBmZSBlZCAwMCAwMCAxMiBlZCAwMCAwMCAwMCA0OCAwMCAwMCAxMSA0MCAg
Li4uLi4uLi4uLi5ILi4uQAo+ICAgICAwMCAwMCAwMCAyOCAwMCAwMCAwMCAxMSAwMCAwMCAwMCAw
MiAwMCAwMCAwMCAwMCAgLi4uKC4uLi4uLi4uLi4uLgo+ICAgYmFja3RyYWNlOgo+ICAgICBbPDAw
MDAwMDAwZjk1YjE3YzQ+XSBrbWVtbGVha19hbGxvYysweDM0LzB4M2UKPiAgICAgWzwwMDAwMDAw
MGI5ZWM4ZTNlPl0ga21hbGxvY19vcmRlcisweDljLzB4YzQKPiAgICAgWzwwMDAwMDAwMGE5NWNm
MDJlPl0ga21hbGxvY19vcmRlcl90cmFjZSsweDM0LzB4YjYKPiAgICAgWzwwMDAwMDAwMGYwMWU2
OGI0Pl0gX19rbWFsbG9jKzB4NWMyLzB4NjJhCj4gICAgIFs8MDAwMDAwMDAyYmQ0OTdiMj5dIGt2
bWFsbG9jX25vZGUrMHg2Ni8weGQ2Cj4gICAgIFs8MDAwMDAwMDA5MDY1NDJmYT5dIG9mX2tleGVj
X2FsbG9jX2FuZF9zZXR1cF9mZHQrMHhhNi8weDZlYQo+ICAgICBbPDAwMDAwMDAwZTExNjZiZGU+
XSBlbGZfa2V4ZWNfbG9hZCsweDIwNi8weDRlYwo+ICAgICBbPDAwMDAwMDAwMzY1NDhlMDk+XSBr
ZXhlY19pbWFnZV9sb2FkX2RlZmF1bHQrMHg0MC8weDRjCj4gICAgIFs8MDAwMDAwMDA3OWZiZTFi
ND5dIHN5c19rZXhlY19maWxlX2xvYWQrMHgxYzQvMHgzMjIKPiAgICAgWzwwMDAwMDAwMDQwYzYy
YzAzPl0gcmV0X2Zyb21fc3lzY2FsbCsweDAvMHgyCj4gCj4gSW4gZWxmX2tleGVjX2xvYWQoKSwg
YSBidWZmZXIgaXMgYWxsb2NhdGVkIHZpYSBrdm1hbGxvYygpIHRvIHN0b3JlIGZkdC4KPiBXaGls
ZSBpdCdzIG5vdCBmcmVlZCBiYWNrIHRvIHN5c3RlbSB3aGVuIGtleGVjIGtlcm5lbCBpcyByZWxv
YWRlZCBvcgo+IHVubG9hZGVkLiAgVGhlbiBtZW1vcnkgbGVhayBpcyBjYXVzZWQuICBGaXggaXQg
YnkgaW50cm9kdWNpbmcgcmlzY3YKPiBzcGVjaWZpYyBmdW5jdGlvbiBhcmNoX2tpbWFnZV9maWxl
X3Bvc3RfbG9hZF9jbGVhbnVwKCksIGFuZCBmcmVlaW5nIHRoZQo+IGJ1ZmZlciB0aGVyZS4KPiAK
PiBGaXhlczogNjI2MTU4NmUwYzkxICgiUklTQy1WOiBBZGQga2V4ZWNfZmlsZSBzdXBwb3J0IikK
PiBTaWduZWQtb2ZmLWJ5OiBMaSBIdWFmZWkgPGxpaHVhZmVpMUBodWF3ZWkuY29tPgo+IC0tLQo+
ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2tleGVjLmggfCAgNSArKysrKwo+ICBhcmNoL3Jpc2N2
L2tlcm5lbC9lbGZfa2V4ZWMuYyAgfCAxMCArKysrKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2tleGVjLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2tleGVjLmgKPiBpbmRleCBlZWUyNjBl
OGFiMzAuLjJiNTY3NjljYjUzMCAxMDA2NDQKPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2tleGVjLmgKPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2tleGVjLmgKPiBAQCAtMzks
NiArMzksNyBAQCBjcmFzaF9zZXR1cF9yZWdzKHN0cnVjdCBwdF9yZWdzICpuZXdyZWdzLAo+ICAj
ZGVmaW5lIEFSQ0hfSEFTX0tJTUFHRV9BUkNICj4gIAo+ICBzdHJ1Y3Qga2ltYWdlX2FyY2ggewo+
ICsJdm9pZCAqZmR0OyAvKiBGb3IgQ09ORklHX0tFWEVDX0ZJTEUgKi8KPiAgCXVuc2lnbmVkIGxv
bmcgZmR0X2FkZHI7Cj4gIH07Cj4gIAo+IEBAIC02Miw2ICs2MywxMCBAQCBpbnQgYXJjaF9rZXhl
Y19hcHBseV9yZWxvY2F0aW9uc19hZGQoc3RydWN0IHB1cmdhdG9yeV9pbmZvICpwaSwKPiAgCQkJ
CSAgICAgY29uc3QgRWxmX1NoZHIgKnJlbHNlYywKPiAgCQkJCSAgICAgY29uc3QgRWxmX1NoZHIg
KnN5bXRhYik7Cj4gICNkZWZpbmUgYXJjaF9rZXhlY19hcHBseV9yZWxvY2F0aW9uc19hZGQgYXJj
aF9rZXhlY19hcHBseV9yZWxvY2F0aW9uc19hZGQKPiArCj4gK3N0cnVjdCBraW1hZ2U7Cj4gK2lu
dCBhcmNoX2tpbWFnZV9maWxlX3Bvc3RfbG9hZF9jbGVhbnVwKHN0cnVjdCBraW1hZ2UgKmltYWdl
KTsKPiArI2RlZmluZSBhcmNoX2tpbWFnZV9maWxlX3Bvc3RfbG9hZF9jbGVhbnVwIGFyY2hfa2lt
YWdlX2ZpbGVfcG9zdF9sb2FkX2NsZWFudXAKPiAgI2VuZGlmCj4gIAo+ICAjZW5kaWYKPiBkaWZm
IC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMgYi9hcmNoL3Jpc2N2L2tlcm5l
bC9lbGZfa2V4ZWMuYwo+IGluZGV4IDBjYjk0OTkyYzE1Yi4uZmYzMGZjYjQzZjQ3IDEwMDY0NAo+
IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jCj4gKysrIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvZWxmX2tleGVjLmMKPiBAQCAtMjEsNiArMjEsMTQgQEAKPiAgI2luY2x1ZGUgPGxpbnV4
L21lbWJsb2NrLmg+Cj4gICNpbmNsdWRlIDxhc20vc2V0dXAuaD4KPiAgCj4gK2ludCBhcmNoX2tp
bWFnZV9maWxlX3Bvc3RfbG9hZF9jbGVhbnVwKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+ICt7Cj4g
KwlrdmZyZWUoaW1hZ2UtPmFyY2guZmR0KTsKPiArCWltYWdlLT5hcmNoLmZkdCA9IE5VTEw7Cj4g
Kwo+ICsJcmV0dXJuIGtleGVjX2ltYWdlX3Bvc3RfbG9hZF9jbGVhbnVwX2RlZmF1bHQoaW1hZ2Up
Owo+ICt9CgpHb29kIGNhdGNoLExHVE0KClJldmlld2VkLWJ5OiBMaWFvIENoYW5nIDxsaWFvY2hh
bmcxQGh1YXdlaS5jb20+Cgo+ICsKPiAgc3RhdGljIGludCByaXNjdl9rZXhlY19lbGZfbG9hZChz
dHJ1Y3Qga2ltYWdlICppbWFnZSwgc3RydWN0IGVsZmhkciAqZWhkciwKPiAgCQkJCXN0cnVjdCBr
ZXhlY19lbGZfaW5mbyAqZWxmX2luZm8sIHVuc2lnbmVkIGxvbmcgb2xkX3BiYXNlLAo+ICAJCQkJ
dW5zaWduZWQgbG9uZyBuZXdfcGJhc2UpCj4gQEAgLTI5OCw2ICszMDYsOCBAQCBzdGF0aWMgdm9p
ZCAqZWxmX2tleGVjX2xvYWQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsIGNoYXIgKmtlcm5lbF9idWYs
Cj4gIAkJcHJfZXJyKCJFcnJvciBhZGQgRFRCIGtidWYgcmV0PSVkXG4iLCByZXQpOwo+ICAJCWdv
dG8gb3V0X2ZyZWVfZmR0Owo+ICAJfQo+ICsJLyogQ2FjaGUgdGhlIGZkdCBidWZmZXIgYWRkcmVz
cyBmb3IgbWVtb3J5IGNsZWFudXAgKi8KPiArCWltYWdlLT5hcmNoLmZkdCA9IGZkdDsKPiAgCXBy
X25vdGljZSgiTG9hZGVkIGRldmljZSB0cmVlIGF0IDB4JWx4XG4iLCBrYnVmLm1lbSk7Cj4gIAln
b3RvIG91dDsKPiAgCgotLSAKQlIsCkxpYW8sIENoYW5nCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
