Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD1C433EF
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 06:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hmWNyGAF09PvU7aN9u991cdHgmxUMY8NmoVGqOXWwJQ=; b=QKwcPBbjAViNGi
	SCH14n1HvGpoaIEhCTD90UMBEeYAnWT2cCre6Ve1v/ydSCAG0Q1RzzTCDMYogX6ZMnD0z0gWkBDjU
	aCBNYJHRcS6iiPHVaOsT0y58NKK75NavjuuDsW6ZVRNceMYyQZsx43RWKibfBT2IsWy5vimdPIYpB
	4geJhsEfQZ+BPYcAPcK3F5Yj0HNynJq3/iS09hw2V9a3395lZ1m/4yGMSPXqWva9qbOmJ0LqoRnpd
	HKQiHtlQQ/o+XA+2Y3lQ6NMR++9y1P9tKkkwYh/y1eiTMnnN/cS3Cg8y76nTQz6mRbd3JUIHVgdN9
	Gop7OPZcP3xqoCY+HvTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3XJR-003rGT-Vi; Tue, 21 Jun 2022 06:24:33 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3XJO-003rDe-4J; Tue, 21 Jun 2022 06:24:32 +0000
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRxK01kWszkWZJ;
	Tue, 21 Jun 2022 14:23:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:24:09 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:24:03 +0800
Message-ID: <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
Date: Tue, 21 Jun 2022 14:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou
	<zhoufeng.zf@bytedance.com>, Chen Zhou <dingguo.cz@antgroup.com>, "John
 Donnelly" <John.p.donnelly@oracle.com>, Dave Kleikamp
	<dave.kleikamp@oracle.com>, liushixin <liushixin2@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_232430_541932_B2EB7294 
X-CRM114-Status: GOOD (  24.77  )
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

Ck9uIDIwMjIvNi8yMSAxMzozMywgQmFvcXVhbiBIZSB3cm90ZToKPiBIaSwKPgo+IE9uIDA2LzEz
LzIyIGF0IDA0OjA5cG0sIFpoZW4gTGVpIHdyb3RlOgo+PiBJZiB0aGUgY3Jhc2hrZXJuZWwgaGFz
IGJvdGggaGlnaCBtZW1vcnkgYWJvdmUgRE1BIHpvbmVzIGFuZCBsb3cgbWVtb3J5Cj4+IGluIERN
QSB6b25lcywga2V4ZWMgYWx3YXlzIGxvYWRzIHRoZSBjb250ZW50IHN1Y2ggYXMgSW1hZ2UgYW5k
IGR0YiB0byB0aGUKPj4gaGlnaCBtZW1vcnkgaW5zdGVhZCBvZiB0aGUgbG93IG1lbW9yeS4gVGhp
cyBtZWFucyB0aGF0IG9ubHkgaGlnaCBtZW1vcnkKPj4gcmVxdWlyZXMgd3JpdGUgcHJvdGVjdGlv
biBiYXNlZCBvbiBwYWdlLWxldmVsIG1hcHBpbmcuIFRoZSBhbGxvY2F0aW9uIG9mCj4+IGhpZ2gg
bWVtb3J5IGRvZXMgbm90IGRlcGVuZCBvbiB0aGUgRE1BIGJvdW5kYXJ5LiBTbyB3ZSBjYW4gcmVz
ZXJ2ZSB0aGUKPj4gaGlnaCBtZW1vcnkgZmlyc3QgZXZlbiBpZiB0aGUgY3Jhc2hrZXJuZWwgcmVz
ZXJ2YXRpb24gaXMgZGVmZXJyZWQuCj4+Cj4+IFRoaXMgbWVhbnMgdGhhdCB0aGUgYmxvY2sgbWFw
cGluZyBjYW4gc3RpbGwgYmUgcGVyZm9ybWVkIG9uIG90aGVyIGtlcm5lbAo+PiBsaW5lYXIgYWRk
cmVzcyBzcGFjZXMsIHRoZSBUTEIgbWlzcyByYXRlIGNhbiBiZSByZWR1Y2VkIGFuZCB0aGUgc3lz
dGVtCj4+IHBlcmZvcm1hbmNlIHdpbGwgYmUgaW1wcm92ZWQuCj4gVWdoLCB0aGlzIGxvb2tzIGEg
bGl0dGxlIHVnbHksIGhvbmVzdGx5Lgo+Cj4gSWYgdGhhdCdzIGZvciBzdXJlIGFybTY0IGNhbid0
IHNwbGl0IGxhcmdlIHBhZ2UgbWFwcGluZyBvZiBsaW5lYXIKPiByZWdpb24sIHRoaXMgcGF0Y2gg
aXMgb25lIHdheSB0byBvcHRpbWl6ZSBsaW5lYXIgbWFwcGluZy4gR2l2ZW4ga2R1bXAKPiBzZXR0
aW5nIGlzIG5lY2Vzc2FyeSBvbiBhcm02NCBzZXJ2ZXIsIHRoZSBib290aW5nIHNwZWVkIGlzIHRy
dWx5Cj4gaW1wYWN0ZWQgaGVhdmlseS4KCklzIHRoZXJlIHNvbWUgY29uY2x1c2lvbiBvciBkaXNj
dXNzaW9uIHRoYXQgYXJtNjQgY2FuJ3Qgc3BsaXQgbGFyZ2UgcGFnZSAKbWFwcGluZz8KCkNvdWxk
IHRoZSBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbiAoYW5kIEtmZW5jZSBwb29sKSBiZSBzcGxpdGVk
IGR5bmFtaWNhbGx5PwoKSSBmb3VuZCBNYXJrIHJlcGxheSAiYXJtNjQ6IHJlbW92ZSBwYWdlIGdy
YW51bGFyaXR5IGxpbWl0YXRpb24gZnJvbSAKS0ZFTkNFIlsxXSwKCiDCoCAiV2UgYWxzbyBhdm9p
ZCBsaXZlIGNoYW5nZXMgZnJvbSBibG9jazwtPnRhYmxlIG1hcHBpbmdzLCBzaW5jZSB0aGUKIMKg
IGFyY2h0aXRlY3R1cmUgZ2l2ZXMgdXMgdmVyeSB3ZWFrIGd1YXJhbnRlZXMgdGhlcmUgYW5kIGdl
bmVyYWxseSByZXF1aXJlcwogwqAgYSBCcmVhay1CZWZvcmUtTWFrZSBzZXF1ZW5jZSAodGhvdWdo
IElJUkMgdGhpcyB3YXMgdGlnaHRlbmVkIHVwCiDCoCBzb21ld2hhdCwgc28gbWF5YmUgZ29pbmcg
b25lIHdheSBpcyBzdXBwb3NlZCB0byB3b3JrKS4gVW5sZXNzIGl0J3MKIMKgIHJlYWxseSBuZWNl
c3NhcnksIEknZCByYXRoZXIgbm90IHNwbGl0IHRoZXNlIGJsb2NrIG1hcHBpbmdzIHdoaWxlCiDC
oCB0aGV5J3JlIGxpdmUuIgoKSGkgTWFyayBhbmQgQ2F0YWxpbizCoCBjb3VsZCB5b3UgZ2l2ZSBz
b21lIGNvbW1lbnQswqAgbWFueSB0aGFua3MuCgpbMV0gCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMTA5MjAxMDE5MzguR0ExMzg2M0BDMDJURDBVVEhGMVQubG9jYWwvVC8jbTFhN2Y5
NzQ1OTNmNTU0NWNiY2ZjMGQyMTU2MGRmNGU3OTI2YjEzODEKCgo+Cj4gSG93ZXZlciwgSSB3b3Vs
ZCBzdWdnZXN0IGxldHRpbmcgaXQgYXMgaXMgd2l0aCBiZWxvdyByZWFzb25zOgo+Cj4gMSkgVGhl
IGNvZGUgd2lsbCBjb21wbGljYXRlIHRoZSBjcmFzaGtlcm5lbCByZXNlcnZhdG9pbiBjb2RlIHdo
aWNoCj4gaXMgYWxyZWFkeSBkaWZmaWN1bHQgdG8gdW5kZXJzdGFuZC4KPiAyKSBJdCBjYW4gb25s
eSBvcHRpbWl6ZSB0aGUgdHdvIGNhc2VzLCBmaXJzdCBpcyBDT05GSUdfWk9ORV9ETUF8RE1BMzIK
PiAgICBkaXNhYmxlZCwgdGhlIG90aGVyIGlzIGNyYXNoa2VybmVsPSxoaWdoIGlzIHNwZWNpZmll
ZC4gV2hpbGUgYm90aAo+ICAgIHR3byBjYXNlcyBhcmUgY29ybmVyIGNhc2UsIG1vc3Qgb2Ygc3lz
dGVtcyBoYXZlIENPTkZJR19aT05FX0RNQXxETUEzMgo+ICAgIGVuYWJsZWQsIGFuZCBtb3N0IG9m
IHN5c3RlbXMgaGF2ZSBjcmFzaGtlcm5lbD14TSB3aGljaCBpcyBlbm91Z2guCj4gICAgSGF2aW5n
IHRoZW0gb3B0aW1pemVkIHdvbid0IGJyaW5nIGJlbmVmaXQgdG8gbW9zdCBvZiBzeXN0ZW1zLgo+
IDMpIEJlc2lkZXMsIHRoZSBjcmFzaGtlcm5lbD0saGlnaCBjYW4gYmUgaGFuZGxlZCBlYXJsaWVy
IGJlY2F1c2UKPiAgICBhcm02NCBhbHdhc3lzIGhhdmUgbWVtYmxvY2suYm90dG9tX3VwID09IGZh
bHNlIGN1cnJlbnRseSwgdGh1cyB3ZQo+ICAgIGRvbid0IG5lZWQgd29ycnkgYXJib3V0IHRoZSBs
b3dlciBsaW1pdCBvZiBjcmFzaGtlcm5lbCxoaWdoCj4gICAgcmVzZXJ2YXRpb24gZm9yIG5vdy4g
SWYgbWVtYmxvY2suYm90dG9tX3VwIGlzIHNldCB0cnVlIGluIHRoZSBmdXR1cmUsCj4gICAgdGhp
cyBwYXRjaCBkb2Vzbid0IHdvcmsgYW55IG1vcmUuCj4KPgo+IC4uLgo+ICAgICAgICAgIGNyYXNo
X2Jhc2UgPSBtZW1ibG9ja19waHlzX2FsbG9jX3JhbmdlKGNyYXNoX3NpemUsIENSQVNIX0FMSUdO
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNyYXNo
X2Jhc2UsIGNyYXNoX21heCk7Cj4KPiBTbywgaW4gbXkgb3Bpbmlvbiwgd2UgY2FuIGxlYXZlIHRo
ZSBjdXJyZW50IE5PTl9CTE9DS3xTRUNUIG1hcHBpbmcgYXMKPiBpcyBjYXVzZWQgYnkgY3Jhc2hr
ZXJuZWwgcmVzZXJ2aW5nLCBzaW5jZSBubyByZWdyZXNzaW9uIGlzIGJyb3VnaHQuCj4gQW5kIG1l
YW50aW1lLCB0dXJuaW5nIHRvIGNoZWNrIGlmIHRoZXJlJ3MgYW55IHdheSB0byBtYWtlIHRoZSBj
b250aWd1b3VzCj4gbGluZWFyIG1hcHBpbmcgYW5kIGxhdGVyIHNwbGl0dGluZyB3b3JrLiBUaGUg
cGF0Y2ggNCwgNSBpbiB0aGlzIHBhdGNoc2V0Cj4gZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8g
bWUsIGZyYW5rbHkgc3BlYWtpbmcuCj4KPiBUaGFua3MKPiBCYW9xdWFuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
