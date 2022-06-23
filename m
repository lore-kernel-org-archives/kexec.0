Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE072C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rvAJlzVu7xw85VJQxl6e762CxTxLCDVVq4/j6XtCRAk=; b=A8awIosHO8vl6W
	7BdMfdrTP6BV9iid6lAGVeOXbg04VtmxVoYh/bxFoGUymdweY9m+WH++BRCuMh42VAnfwXj9e7HfP
	AXEhc7oNiieSBN8dhAVDmP/KPvlzvkz0L+JuLVMi+6zmeNyVuHcBKpJh5xJi6Ew3gRv7DFKwqgesQ
	Dz9MBOh/cSZwfgFElqhyS5C9IssZbBzcOEzE5VvPSjIDP/MdoogXMgUyGdT017/SpNJMglpOEVpb6
	y/OpntxZQ62YWZvNrd6CkNktg9LnDDBQqlRdJEOhCyytYo1fapOWpmZGhyBDl3KKC8W1JYDENiSe6
	MRKpPqmJo4r1QbOUguJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NkR-00FWfS-PS; Thu, 23 Jun 2022 14:23:55 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NkN-00FWcm-8u; Thu, 23 Jun 2022 14:23:54 +0000
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTMrk00dLzkWTt;
	Thu, 23 Jun 2022 22:21:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 22:23:40 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 22:23:39 +0800
Message-ID: <f400756c-dd41-e347-c281-c4a594fdb429@huawei.com>
Date: Thu, 23 Jun 2022 22:23:39 +0800
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
 <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com> <YrQ/98J5UqPh8K89@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YrQ/98J5UqPh8K89@arm.com>
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_072351_765924_36D6613F 
X-CRM114-Status: GOOD (  24.97  )
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

Ck9uIDIwMjIvNi8yMyAxODoyNywgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOgo+IE9uIFdlZCwgSnVu
IDIyLCAyMDIyIGF0IDA4OjAzOjIxUE0gKzA4MDAsIEtlZmVuZyBXYW5nIHdyb3RlOgo+PiBPbiAy
MDIyLzYvMjIgMjowNCwgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOgo+Pj4gT24gVHVlLCBKdW4gMjEs
IDIwMjIgYXQgMDI6MjQ6MDFQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3JvdGU6Cj4+Pj4gT24gMjAy
Mi82LzIxIDEzOjMzLCBCYW9xdWFuIEhlIHdyb3RlOgo+Pj4+PiBPbiAwNi8xMy8yMiBhdCAwNDow
OXBtLCBaaGVuIExlaSB3cm90ZToKPj4+Pj4+IElmIHRoZSBjcmFzaGtlcm5lbCBoYXMgYm90aCBo
aWdoIG1lbW9yeSBhYm92ZSBETUEgem9uZXMgYW5kIGxvdyBtZW1vcnkKPj4+Pj4+IGluIERNQSB6
b25lcywga2V4ZWMgYWx3YXlzIGxvYWRzIHRoZSBjb250ZW50IHN1Y2ggYXMgSW1hZ2UgYW5kIGR0
YiB0byB0aGUKPj4+Pj4+IGhpZ2ggbWVtb3J5IGluc3RlYWQgb2YgdGhlIGxvdyBtZW1vcnkuIFRo
aXMgbWVhbnMgdGhhdCBvbmx5IGhpZ2ggbWVtb3J5Cj4+Pj4+PiByZXF1aXJlcyB3cml0ZSBwcm90
ZWN0aW9uIGJhc2VkIG9uIHBhZ2UtbGV2ZWwgbWFwcGluZy4gVGhlIGFsbG9jYXRpb24gb2YKPj4+
Pj4+IGhpZ2ggbWVtb3J5IGRvZXMgbm90IGRlcGVuZCBvbiB0aGUgRE1BIGJvdW5kYXJ5LiBTbyB3
ZSBjYW4gcmVzZXJ2ZSB0aGUKPj4+Pj4+IGhpZ2ggbWVtb3J5IGZpcnN0IGV2ZW4gaWYgdGhlIGNy
YXNoa2VybmVsIHJlc2VydmF0aW9uIGlzIGRlZmVycmVkLgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgbWVh
bnMgdGhhdCB0aGUgYmxvY2sgbWFwcGluZyBjYW4gc3RpbGwgYmUgcGVyZm9ybWVkIG9uIG90aGVy
IGtlcm5lbAo+Pj4+Pj4gbGluZWFyIGFkZHJlc3Mgc3BhY2VzLCB0aGUgVExCIG1pc3MgcmF0ZSBj
YW4gYmUgcmVkdWNlZCBhbmQgdGhlIHN5c3RlbQo+Pj4+Pj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBp
bXByb3ZlZC4KPj4+Pj4gVWdoLCB0aGlzIGxvb2tzIGEgbGl0dGxlIHVnbHksIGhvbmVzdGx5Lgo+
Pj4+Pgo+Pj4+PiBJZiB0aGF0J3MgZm9yIHN1cmUgYXJtNjQgY2FuJ3Qgc3BsaXQgbGFyZ2UgcGFn
ZSBtYXBwaW5nIG9mIGxpbmVhcgo+Pj4+PiByZWdpb24sIHRoaXMgcGF0Y2ggaXMgb25lIHdheSB0
byBvcHRpbWl6ZSBsaW5lYXIgbWFwcGluZy4gR2l2ZW4ga2R1bXAKPj4+Pj4gc2V0dGluZyBpcyBu
ZWNlc3Nhcnkgb24gYXJtNjQgc2VydmVyLCB0aGUgYm9vdGluZyBzcGVlZCBpcyB0cnVseQo+Pj4+
PiBpbXBhY3RlZCBoZWF2aWx5Lgo+Pj4+IElzIHRoZXJlIHNvbWUgY29uY2x1c2lvbiBvciBkaXNj
dXNzaW9uIHRoYXQgYXJtNjQgY2FuJ3Qgc3BsaXQgbGFyZ2UgcGFnZQo+Pj4+IG1hcHBpbmc/Cj4+
Pj4KPj4+PiBDb3VsZCB0aGUgY3Jhc2hrZXJuZWwgcmVzZXJ2YXRpb24gKGFuZCBLZmVuY2UgcG9v
bCkgYmUgc3BsaXRlZCBkeW5hbWljYWxseT8KPj4+Pgo+Pj4+IEkgZm91bmQgTWFyayByZXBsYXkg
ImFybTY0OiByZW1vdmUgcGFnZSBncmFudWxhcml0eSBsaW1pdGF0aW9uIGZyb20KPj4+PiBLRkVO
Q0UiWzFdLAo+Pj4+Cj4+Pj4gICDCoCAiV2UgYWxzbyBhdm9pZCBsaXZlIGNoYW5nZXMgZnJvbSBi
bG9jazwtPnRhYmxlIG1hcHBpbmdzLCBzaW5jZSB0aGUKPj4+PiAgIMKgIGFyY2h0aXRlY3R1cmUg
Z2l2ZXMgdXMgdmVyeSB3ZWFrIGd1YXJhbnRlZXMgdGhlcmUgYW5kIGdlbmVyYWxseSByZXF1aXJl
cwo+Pj4+ICAgwqAgYSBCcmVhay1CZWZvcmUtTWFrZSBzZXF1ZW5jZSAodGhvdWdoIElJUkMgdGhp
cyB3YXMgdGlnaHRlbmVkIHVwCj4+Pj4gICDCoCBzb21ld2hhdCwgc28gbWF5YmUgZ29pbmcgb25l
IHdheSBpcyBzdXBwb3NlZCB0byB3b3JrKS4gVW5sZXNzIGl0J3MKPj4+PiAgIMKgIHJlYWxseSBu
ZWNlc3NhcnksIEknZCByYXRoZXIgbm90IHNwbGl0IHRoZXNlIGJsb2NrIG1hcHBpbmdzIHdoaWxl
Cj4+Pj4gICDCoCB0aGV5J3JlIGxpdmUuIgo+Pj4gVGhlIHByb2JsZW0gd2l0aCBzcGxpdHRpbmcg
aXMgdGhhdCB5b3UgY2FuIGVuZCB1cCB3aXRoIHR3byBlbnRyaWVzIGluCj4+PiB0aGUgVExCIGZv
ciB0aGUgc2FtZSBWQS0+UEEgbWFwcGluZyAoZS5nLiBvbmUgZm9yIGEgNEtCIHBhZ2UgYW5kIGFu
b3RoZXIKPj4+IGZvciBhIDJNQiBibG9jaykuIEluIHRoZSBsdWNreSBjYXNlLCB0aGUgQ1BVIHdp
bGwgdHJpZ2dlciBhIFRMQiBjb25mbGljdAo+Pj4gYWJvcnQgKGJ1dCBjYW4gYmUgd29yc2UgbGlr
ZSBsb3NzIG9mIGNvaGVyZW5jeSkuCj4+IFRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbu+8jAo+
Pj4gUHJpb3IgdG8gRkVBVF9CQk0gKGFkZGVkIGluIEFSTXY4LjQpLCBzdWNoIHNjZW5hcmlvIHdh
cyBub3QgYWxsb3dlZCBhdAo+Pj4gYWxsLCB0aGUgc29mdHdhcmUgd291bGQgaGF2ZSB0byB1bm1h
cCB0aGUgcmFuZ2UsIFRMQkksIHJlbWFwLiBXaXRoCj4+PiBGRUFUX0JCTSAobGV2ZWwgMiksIHdl
IGNhbiBkbyB0aGlzIHdpdGhvdXQgdGVhcmluZyB0aGUgbWFwcGluZyBkb3duIGJ1dAo+Pj4gd2Ug
c3RpbGwgbmVlZCB0byBoYW5kbGUgdGhlIHBvdGVudGlhbCBUTEIgY29uZmxpY3QgYWJvcnQuIFRo
ZSBoYW5kbGVyCj4+PiBvbmx5IG5lZWRzIGEgVExCSSBidXQgaWYgaXQgdG91Y2hlcyB0aGUgbWVt
b3J5IHJhbmdlIGJlaW5nIGNoYW5nZWQgaXQKPj4+IHJpc2tzIGZhdWx0aW5nIGFnYWluLiBXaXRo
IHZtYXAgc3RhY2tzIGFuZCB0aGUga2VybmVsIGltYWdlIG1hcHBlZCBpbgo+Pj4gdGhlIHZtYWxs
b2Mgc3BhY2UsIHdlIGhhdmUgYSBzbWFsbCB3aW5kb3cgd2hlcmUgdGhpcyBjb3VsZCBiZSBoYW5k
bGVkCj4+PiBidXQgd2UgcHJvYmFibHkgY2FuJ3QgZ28gaW50byB0aGUgQyBwYXJ0IG9mIHRoZSBl
eGNlcHRpb24gaGFuZGxpbmcKPj4+ICh0cmFjaW5nIGV0Yy4gbWF5IGFjY2VzcyBhIGttYWxsb2Mn
ZWQgb2JqZWN0IGZvciBleGFtcGxlKS4KPj4gU28gaWYgd2l0aG91dCBGRUFUX0JCTe+8jHdlIGNh
biBvbmx5IGd1YXJhbnRlZSBCQk0gc2VxdWVuY2UgdmlhCj4+ICJ1bm1hcCB0aGUgcmFuZ2UsIFRM
QkksIHJlbWFwIiBvciB0aGUgZm9sbG93aW5nIG9wdGlvbiwKPiBZZXMsIHRoYXQncyB0aGUgYnJl
YWstYmVmb3JlLW1ha2Ugc2VxdWVuY2UuCj4KPj4gYW5kIHdpdGggRkVBVF9CQk0gKGxldmVsIDIp
LCB3ZSBjb3VsZCBoYXZlIGVhc3kgd2F5IHRvIGF2b2lkIFRMQgo+PiBjb25mbGljdCBmb3Igc29t
ZSB2bWFsbG9jIHNwYWNlLCBidXQgc3RpbGwgaGFyZCB0byBkZWFsIHdpdGggb3RoZXIKPj4gc2Nl
bmNlPwo+IEl0J3Mgbm90IHRvbyBoYXJkIGluIHRoZW9yeS4gQmFzaWNhbGx5IHRoZXJlJ3MgYSBz
bWFsbCByaXNrIG9mIGdldHRpbmcgYQo+IFRMQiBjb25mbGljdCBhYm9ydCBmb3IgdGhlIG1hcHBp
bmdzIHlvdSBjaGFuZ2Ugd2l0aG91dCBhIEJCTSBzZXF1ZW5jZSAoSQo+IHRoaW5rIGl0J3MgbmVh
cmx5IG5vbi1leGlzdGVkIHdoZW4gZ29pbmcgZnJvbSBsYXJnZSBibG9jayB0byBzbWFsbGVyCj4g
cGFnZXMsIHRob3VnaCB0aGUgYXJjaGl0ZWN0dXJlIHN0YXRlcyB0aGF0IGl0J3Mgc3RpbGwgcG9z
c2libGUpLiBTaW5jZQo+IHdlIG9ubHkgd2FudCB0byBkbyB0aGlzIGZvciB0aGUgbGluZWFyIG1h
cCBhbmQgdGhlIGtlcm5lbCBhbmQgc3RhY2sgYXJlCj4gaW4gdGhlIHZtYWxsb2Mgc3BhY2UsIHdl
IGNhbiBoYW5kbGUgc3VjaCB0cmFwIGFzIGFuIHNhZmV0eSBtZWFzdXJlIChpdAo+IGp1c3QgbmVl
ZHMgYSBUTEJJKS4gSXQgbWF5IGhlbHAgdG8gdHdlYWsgYSBtb2RlbCB0byBmb3JjZSBpdCB0byBn
ZW5lcmF0ZQo+IHN1Y2ggY29uZmxpY3QgYWJvcnRzLCBvdGhlcndpc2Ugd2UnZCBub3QgYmUgYWJs
ZSB0byB0ZXN0IHRoZSBjb2RlLgo+Cj4gSXQncyBwb3NzaWJsZSB0aGF0IHN1Y2ggdHJhcCBpcyBy
YWlzZWQgYXQgRUwyIGlmIGEgZ3Vlc3QgY2F1c2VkIHRoZQo+IGNvbmZsaWN0IGFib3J0ICh0aGUg
YXJjaGl0ZWN0dXJlIGxlZnQgdGhpcyBhcyBJTVAgREVGKS4gVGhlIGh5cGVydmlzb3JzCj4gbWF5
IG5lZWQgdG8gYmUgdGF1Z2h0IHRvIGRvIGEgVExCSSBWTUFMTFMxMkUxIGluc3RlYWQgb2Yga2ls
bGluZyB0aGUKPiBndWVzdC4gSSBoYXZlbid0IGNoZWNrZWQgd2hhdCBLVk0gZG9lcy4KR290IGl0
77yMbWFueSB0aGFua3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
