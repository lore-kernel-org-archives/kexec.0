Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54343C433EF
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wKTgW8S1zDP5Y7Z6lM/dnSXrs5SG2vvX3aHA5g8neik=; b=maaMiYD6dOz8yZ
	JDorP7kIYoKeRCzKiVBkkuHMFq/FmMrF6ByLSINScCcBw6W8f3ZxIAxBpKsQsvUL9Sm8Trp37EcZD
	rLpMjcr12SQT7+ItCJpEr4jAHCoMLPlkT0Dy1bZrhI2DjdI/Es51ZOJLzeoiBf+FiUP8/hDVGl/39
	6PZfXJJ+v+i2aPyqtLKlRBaz/j8ZkdLbrKcBjDPt/khkQQeHErNznJnT5ldKXpRav633fl72Zz3sX
	DXqeQmM0Il3Ltpixl2C43YHNtpDY9xQLbngNuaPmQb0m40obJ6L67g0wbwURbWIJLbKO51V2zxIcY
	osi4DeryaR62bKE+tKsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3z57-00AGsm-LI; Wed, 22 Jun 2022 12:03:37 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3z53-00AGnM-Oi; Wed, 22 Jun 2022 12:03:36 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LShnt6bYjzkWgG;
	Wed, 22 Jun 2022 20:02:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 20:03:23 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 20:03:22 +0800
Message-ID: <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com>
Date: Wed, 22 Jun 2022 20:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, <devicetree@vger.kernel.org>, "Dave
 Young" <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>, liushixin <liushixin2@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com> <YrIIJkhKWSuAqkCx@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YrIIJkhKWSuAqkCx@arm.com>
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_050334_172251_B38FE1E9 
X-CRM114-Status: GOOD (  23.89  )
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

Ck9uIDIwMjIvNi8yMiAyOjA0LCBDYXRhbGluIE1hcmluYXMgd3JvdGU6Cj4gT24gVHVlLCBKdW4g
MjEsIDIwMjIgYXQgMDI6MjQ6MDFQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3JvdGU6Cj4+IE9uIDIw
MjIvNi8yMSAxMzozMywgQmFvcXVhbiBIZSB3cm90ZToKPj4+IE9uIDA2LzEzLzIyIGF0IDA0OjA5
cG0sIFpoZW4gTGVpIHdyb3RlOgo+Pj4+IElmIHRoZSBjcmFzaGtlcm5lbCBoYXMgYm90aCBoaWdo
IG1lbW9yeSBhYm92ZSBETUEgem9uZXMgYW5kIGxvdyBtZW1vcnkKPj4+PiBpbiBETUEgem9uZXMs
IGtleGVjIGFsd2F5cyBsb2FkcyB0aGUgY29udGVudCBzdWNoIGFzIEltYWdlIGFuZCBkdGIgdG8g
dGhlCj4+Pj4gaGlnaCBtZW1vcnkgaW5zdGVhZCBvZiB0aGUgbG93IG1lbW9yeS4gVGhpcyBtZWFu
cyB0aGF0IG9ubHkgaGlnaCBtZW1vcnkKPj4+PiByZXF1aXJlcyB3cml0ZSBwcm90ZWN0aW9uIGJh
c2VkIG9uIHBhZ2UtbGV2ZWwgbWFwcGluZy4gVGhlIGFsbG9jYXRpb24gb2YKPj4+PiBoaWdoIG1l
bW9yeSBkb2VzIG5vdCBkZXBlbmQgb24gdGhlIERNQSBib3VuZGFyeS4gU28gd2UgY2FuIHJlc2Vy
dmUgdGhlCj4+Pj4gaGlnaCBtZW1vcnkgZmlyc3QgZXZlbiBpZiB0aGUgY3Jhc2hrZXJuZWwgcmVz
ZXJ2YXRpb24gaXMgZGVmZXJyZWQuCj4+Pj4KPj4+PiBUaGlzIG1lYW5zIHRoYXQgdGhlIGJsb2Nr
IG1hcHBpbmcgY2FuIHN0aWxsIGJlIHBlcmZvcm1lZCBvbiBvdGhlciBrZXJuZWwKPj4+PiBsaW5l
YXIgYWRkcmVzcyBzcGFjZXMsIHRoZSBUTEIgbWlzcyByYXRlIGNhbiBiZSByZWR1Y2VkIGFuZCB0
aGUgc3lzdGVtCj4+Pj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBpbXByb3ZlZC4KPj4+IFVnaCwgdGhp
cyBsb29rcyBhIGxpdHRsZSB1Z2x5LCBob25lc3RseS4KPj4+Cj4+PiBJZiB0aGF0J3MgZm9yIHN1
cmUgYXJtNjQgY2FuJ3Qgc3BsaXQgbGFyZ2UgcGFnZSBtYXBwaW5nIG9mIGxpbmVhcgo+Pj4gcmVn
aW9uLCB0aGlzIHBhdGNoIGlzIG9uZSB3YXkgdG8gb3B0aW1pemUgbGluZWFyIG1hcHBpbmcuIEdp
dmVuIGtkdW1wCj4+PiBzZXR0aW5nIGlzIG5lY2Vzc2FyeSBvbiBhcm02NCBzZXJ2ZXIsIHRoZSBi
b290aW5nIHNwZWVkIGlzIHRydWx5Cj4+PiBpbXBhY3RlZCBoZWF2aWx5Lgo+PiBJcyB0aGVyZSBz
b21lIGNvbmNsdXNpb24gb3IgZGlzY3Vzc2lvbiB0aGF0IGFybTY0IGNhbid0IHNwbGl0IGxhcmdl
IHBhZ2UKPj4gbWFwcGluZz8KPj4KPj4gQ291bGQgdGhlIGNyYXNoa2VybmVsIHJlc2VydmF0aW9u
IChhbmQgS2ZlbmNlIHBvb2wpIGJlIHNwbGl0ZWQgZHluYW1pY2FsbHk/Cj4+Cj4+IEkgZm91bmQg
TWFyayByZXBsYXkgImFybTY0OiByZW1vdmUgcGFnZSBncmFudWxhcml0eSBsaW1pdGF0aW9uIGZy
b20KPj4gS0ZFTkNFIlsxXSwKPj4KPj4gIMKgICJXZSBhbHNvIGF2b2lkIGxpdmUgY2hhbmdlcyBm
cm9tIGJsb2NrPC0+dGFibGUgbWFwcGluZ3MsIHNpbmNlIHRoZQo+PiAgwqAgYXJjaHRpdGVjdHVy
ZSBnaXZlcyB1cyB2ZXJ5IHdlYWsgZ3VhcmFudGVlcyB0aGVyZSBhbmQgZ2VuZXJhbGx5IHJlcXVp
cmVzCj4+ICDCoCBhIEJyZWFrLUJlZm9yZS1NYWtlIHNlcXVlbmNlICh0aG91Z2ggSUlSQyB0aGlz
IHdhcyB0aWdodGVuZWQgdXAKPj4gIMKgIHNvbWV3aGF0LCBzbyBtYXliZSBnb2luZyBvbmUgd2F5
IGlzIHN1cHBvc2VkIHRvIHdvcmspLiBVbmxlc3MgaXQncwo+PiAgwqAgcmVhbGx5IG5lY2Vzc2Fy
eSwgSSdkIHJhdGhlciBub3Qgc3BsaXQgdGhlc2UgYmxvY2sgbWFwcGluZ3Mgd2hpbGUKPj4gIMKg
IHRoZXkncmUgbGl2ZS4iCj4gVGhlIHByb2JsZW0gd2l0aCBzcGxpdHRpbmcgaXMgdGhhdCB5b3Ug
Y2FuIGVuZCB1cCB3aXRoIHR3byBlbnRyaWVzIGluCj4gdGhlIFRMQiBmb3IgdGhlIHNhbWUgVkEt
PlBBIG1hcHBpbmcgKGUuZy4gb25lIGZvciBhIDRLQiBwYWdlIGFuZCBhbm90aGVyCj4gZm9yIGEg
Mk1CIGJsb2NrKS4gSW4gdGhlIGx1Y2t5IGNhc2UsIHRoZSBDUFUgd2lsbCB0cmlnZ2VyIGEgVExC
IGNvbmZsaWN0Cj4gYWJvcnQgKGJ1dCBjYW4gYmUgd29yc2UgbGlrZSBsb3NzIG9mIGNvaGVyZW5j
eSkuClRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbu+8jAo+IFByaW9yIHRvIEZFQVRfQkJNIChh
ZGRlZCBpbiBBUk12OC40KSwgc3VjaCBzY2VuYXJpbyB3YXMgbm90IGFsbG93ZWQgYXQKPiBhbGws
IHRoZSBzb2Z0d2FyZSB3b3VsZCBoYXZlIHRvIHVubWFwIHRoZSByYW5nZSwgVExCSSwgcmVtYXAu
IFdpdGgKPiBGRUFUX0JCTSAobGV2ZWwgMiksIHdlIGNhbiBkbyB0aGlzIHdpdGhvdXQgdGVhcmlu
ZyB0aGUgbWFwcGluZyBkb3duIGJ1dAo+IHdlIHN0aWxsIG5lZWQgdG8gaGFuZGxlIHRoZSBwb3Rl
bnRpYWwgVExCIGNvbmZsaWN0IGFib3J0LiBUaGUgaGFuZGxlcgo+IG9ubHkgbmVlZHMgYSBUTEJJ
IGJ1dCBpZiBpdCB0b3VjaGVzIHRoZSBtZW1vcnkgcmFuZ2UgYmVpbmcgY2hhbmdlZCBpdAo+IHJp
c2tzIGZhdWx0aW5nIGFnYWluLiBXaXRoIHZtYXAgc3RhY2tzIGFuZCB0aGUga2VybmVsIGltYWdl
IG1hcHBlZCBpbgo+IHRoZSB2bWFsbG9jIHNwYWNlLCB3ZSBoYXZlIGEgc21hbGwgd2luZG93IHdo
ZXJlIHRoaXMgY291bGQgYmUgaGFuZGxlZAo+IGJ1dCB3ZSBwcm9iYWJseSBjYW4ndCBnbyBpbnRv
IHRoZSBDIHBhcnQgb2YgdGhlIGV4Y2VwdGlvbiBoYW5kbGluZwo+ICh0cmFjaW5nIGV0Yy4gbWF5
IGFjY2VzcyBhIGttYWxsb2MnZWQgb2JqZWN0IGZvciBleGFtcGxlKS4KClNvIGlmIHdpdGhvdXQg
RkVBVF9CQk3vvIx3ZSBjYW4gb25seSBndWFyYW50ZWUgQkJNIHNlcXVlbmNlIHZpYQoKInVubWFw
IHRoZSByYW5nZSwgVExCSSwgcmVtYXAiIG9yIHRoZSBmb2xsb3dpbmcgb3B0aW9uLCBhbmQgd2l0
aAoKRkVBVF9CQk0gKGxldmVsIDIpLCB3ZSBjb3VsZCBoYXZlIGVhc3kgd2F5IHRvIGF2b2lkIFRM
QiBjb25mbGljdCBmb3IKCnNvbWUgdm1hbGxvYyBzcGFjZSwgYnV0IHN0aWxsIGhhcmQgdG8gZGVh
bCB3aXRoIG90aGVyIHNjZW5jZT8KCgo+Cj4gQW5vdGhlciBvcHRpb24gaXMgdG8gZG8gYSBzdG9w
X21hY2hpbmUoKSAoaWYgbXVsdGktcHJvY2Vzc29yIGF0IHRoYXQKPiBwb2ludCksIGRpc2FibGUg
dGhlIE1NVXMsIG1vZGlmeSB0aGUgcGFnZSB0YWJsZXMsIHJlLWVuYWJsZSB0aGUgTU1VIGJ1dAo+
IGl0J3MgYWxzbyBjb21wbGljYXRlZC4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
