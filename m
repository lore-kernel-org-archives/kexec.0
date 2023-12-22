Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A05C41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7kpRktqyXu5NXcYKt1qS4yUQ+wg9diZ/a89DHLKlUC4=; b=Qqgwb5OV9In6AW
	ao8OQCawauvOprB2J2Vrq0mAZ/pnHkRDBqH55kqF7ocmLCDS1Ze00RT8skNPDSaM46MMo6nPa+zuO
	+67js6VDsaxjHxAEE7Hq/lCilCoF3ijPPCxXlOt3WpQxFpAzNsljKic4mjMCZiZ/SG/ekMyj75g25
	ipS+YIXXRHf2uR+IxBTTbw5AyyHi07T4hvRqTtyujFlX7XNm+plnM/W9tFs7zW8W4eOVN24hj8GKD
	xCfL3vJss9wzzybO9DtLt/2c6dmO9R4ONRc/Sxhr+V3uj9kwH6YLbh+ChJ/wIz2PH9bUMCIomcWur
	SNAVbzmRdlAWPLQupHag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGe3Z-005qjA-2M;
	Fri, 22 Dec 2023 11:51:09 +0000
Received: from mail-m92237.xmail.ntesmail.com ([103.126.92.237])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGe3W-005qfb-0r
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 11:51:08 +0000
Received: from [10.9.0.94] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id AC02A4C0275;
	Fri, 22 Dec 2023 19:41:36 +0800 (CST)
Message-ID: <ba124f2b-3292-4c5d-b5f6-b078ce289838@easystack.cn>
Date: Fri, 22 Dec 2023 19:41:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/kexec: Fix potential out of bounds in
 crash_setup_memmap_entries()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-2-fuqiang.wang@easystack.cn>
 <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh1IVk1CGR9PGRoYTU1NHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c9154b5f7022ekunmac02a4c0275
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6HBw4LzczNShCEkgpHkIt
	OhhPCgJVSlVKTEtISU9OSUJMTU9DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFPQkhPNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_035106_511543_26480548 
X-CRM114-Status: GOOD (  21.55  )
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

5ZyoIDIwMjMvMTIvMjEgMjE6MTQsIEJhb3F1YW4gSGUg5YaZ6YGTOgoKPiBPbiAxMi8yMC8yMyBh
dCAwMTo1N3BtLCBmdXFpYW5nIHdhbmcgd3JvdGU6Cj4+IEluIG1lbW1hcF9leGNsdWRlX3Jhbmdl
cygpLCB0aGVyZSB3aWxsIGV4Y2x1ZGUgZWxmaGVhZGVyIGZyb20KPj4gY3Jhc2hrX3Jlcy4gSW4g
dGhlIGN1cnJlbnQgeDg2IGFyY2hpdGVjdHVyZSBjb2RlLCB0aGUgZWxmaGVhZGVyIGlzCj4+IGFs
d2F5cyBhbGxvY2F0ZWQgYXQgY3Jhc2hrX3Jlcy5zdGFydC4gSXQgc2VlbXMgdGhhdCB0aGVyZSB3
b24ndCBiZSBhCj4+IHNwbGl0IGEgbmV3IHJhbmdlLiBCdXQgaXQgZGVwZW5kcyBvbiB0aGUgYWxs
b2NhdGlvbiBwb3NpdGlvbiBvZgo+PiBlbGZoZWFkZXIgaW4gY3Jhc2hrX3Jlcy4gVG8gYXZvaWQg
cG90ZW50aWFsIG91dCBvZiBib3VuZHMgaW4gZnV0dXJlLCBTZXQKPj4gdGhlIGFycmF5IHNpemUg
dG8gMi4KPiBJZiBzbywgSSB3b3VsZCBzdWdnZXN0IHRvIGFkZCBleHRyYSBzbG90IGZvciBsb3cg
MU0gdG9vIGluCj4gZmlsbF91cF9jcmFzaF9lbGZfZGF0YSgpIGxlc3QgdGhlIGxvdyAxTSBjb3Vs
ZCBiZSBjaGFuZ2VkIGluIHRoZSBmdXR1cmUsCj4gZS5nIFtzdGFydCwgMU1dLgoKCkhpIEJhb3F1
YW4KClRoaXMgc2VlbXMgdG8gYmUgYmV0dGVyIGZvciBmdXR1cmUgbWFpbnRlbmFuY2UuIFRoYW5r
IHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLgoKPj4gQnV0IHNpbWlsYXIgaXNzdWUgd2lsbCBub3Qg
ZXhpc3QgaW4gZmlsbF91cF9jcmFzaF9lbGZfZGF0YSgpLiBCZWNhdXNlCj4+IHRoZSByYW5nZSB0
byBiZSBleGNsdWRlZCBpcyBbMCwgMU1dLCBzdGFydCAoMCkgaXMgc3BlY2lhbCBhbmQgd2lsbCBu
b3QKPj4gYXBwZWFyIGluIHRoZSBtaWRkbGUgb2YgZXhpc3RpbmcgY21lbS0+cmFuZ2VzW10uIEkg
YWRkZWQgYSBjb21tZW50IHRvCj4+IGV4cGxhaW4gaXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IGZ1
cWlhbmcgd2FuZyA8ZnVxaWFuZy53YW5nQGVhc3lzdGFjay5jbj4KPj4gLS0tCj4+ICAgYXJjaC94
ODYva2VybmVsL2NyYXNoLmMgfCAyMCArKysrKysrKysrKysrKy0tLS0tLQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiBp
bmRleCBjOTJkODg2ODBkYmYuLjFjMTVkMDg4NGM5MCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL2NyYXNoLmMKPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPj4gQEAgLTE0
OSw2ICsxNDksMTMgQEAgc3RhdGljIHN0cnVjdCBjcmFzaF9tZW0gKmZpbGxfdXBfY3Jhc2hfZWxm
X2RhdGEodm9pZCkKPj4gICAJLyoKPj4gICAJICogRXhjbHVzaW9uIG9mIGNyYXNoIHJlZ2lvbiBh
bmQvb3IgY3Jhc2hrX2xvd19yZXMgbWF5IGNhdXNlCj4+ICAgCSAqIGFub3RoZXIgcmFuZ2Ugc3Bs
aXQuIFNvIGFkZCBleHRyYSB0d28gc2xvdHMgaGVyZS4KPj4gKwkgKgo+PiArCSAqIEV4Y2x1c2lv
biBvZiBsb3cgMU0gbWF5IG5vdCBjYXVzZSBhbm90aGVyIHJhbmdlIHNwbGl0LCBiZWNhdXNlIHRo
ZQo+PiArCSAqIHJhbmdlIG9mIGV4Y2x1ZGUgaXMgWzAsIDFNXSBhbmQgdGhlIGNvbmRpdGlvbiBm
b3Igc3BsaXR0aW5nIGEgbmV3Cj4+ICsJICogcmVnaW9uIGlzIHRoYXQgdGhlIHN0YXJ0LCBlbmQg
cGFyYW1ldGVycyBhcmUgYm90aCBpbiBhIGNlcnRhaW4KPj4gKwkgKiBleGlzdGluZyByZWdpb24g
aW4gY21lbSBhbmQgY2Fubm90IGJlIGVxdWFsIHRvIGV4aXN0aW5nIHJlZ2lvbidzCj4+ICsJICog
c3RhcnQgb3IgZW5kLiBPYnZpb3VzbHksIHRoZSBzdGFydCBvZiBbMCwgMU1dIGNhbm5vdCBtZWV0
IHRoaXMKPj4gKwkgKiBjb25kaXRpb24uCj4+ICAgCSAqLwo+PiAgIAlucl9yYW5nZXMgKz0gMjsK
Pj4gICAJY21lbSA9IHZ6YWxsb2Moc3RydWN0X3NpemUoY21lbSwgcmFuZ2VzLCBucl9yYW5nZXMp
KTsKPj4gQEAgLTI4Miw5ICsyODksMTUgQEAgaW50IGNyYXNoX3NldHVwX21lbW1hcF9lbnRyaWVz
KHN0cnVjdCBraW1hZ2UgKmltYWdlLCBzdHJ1Y3QgYm9vdF9wYXJhbXMgKnBhcmFtcykKPj4gICAJ
c3RydWN0IGNyYXNoX21lbW1hcF9kYXRhIGNtZDsKPj4gICAJc3RydWN0IGNyYXNoX21lbSAqY21l
bTsKPj4gICAKPj4gLQljbWVtID0gdnphbGxvYyhzdHJ1Y3Rfc2l6ZShjbWVtLCByYW5nZXMsIDEp
KTsKPj4gKwljbWVtID0gdnphbGxvYyhzdHJ1Y3Rfc2l6ZShjbWVtLCByYW5nZXMsIDIpKTsKPj4g
ICAJaWYgKCFjbWVtKQo+PiAgIAkJcmV0dXJuIC1FTk9NRU07Cj4+ICsJY21lbS0+bWF4X25yX3Jh
bmdlcyA9IDI7Cj4+ICsKPj4gKwkvKiBFeGNsdWRlIHNvbWUgcmFuZ2VzIGZyb20gY3Jhc2hrX3Jl
cyBhbmQgYWRkIHJlc3QgdG8gbWVtbWFwICovCj4+ICsJcmV0ID0gbWVtbWFwX2V4Y2x1ZGVfcmFu
Z2VzKGltYWdlLCBjbWVtLCBjcmFzaGtfcmVzLnN0YXJ0LCBjcmFzaGtfcmVzLmVuZCk7Cj4+ICsJ
aWYgKHJldCkKPj4gKwkJZ290byBvdXQ7Cj4+ICAgCj4+ICAgCW1lbXNldCgmY21kLCAwLCBzaXpl
b2Yoc3RydWN0IGNyYXNoX21lbW1hcF9kYXRhKSk7Cj4+ICAgCWNtZC5wYXJhbXMgPSBwYXJhbXM7
Cj4+IEBAIC0zMjAsMTEgKzMzMyw2IEBAIGludCBjcmFzaF9zZXR1cF9tZW1tYXBfZW50cmllcyhz
dHJ1Y3Qga2ltYWdlICppbWFnZSwgc3RydWN0IGJvb3RfcGFyYW1zICpwYXJhbXMpCj4+ICAgCQlh
ZGRfZTgyMF9lbnRyeShwYXJhbXMsICZlaSk7Cj4+ICAgCX0KPj4gICAKPj4gLQkvKiBFeGNsdWRl
IHNvbWUgcmFuZ2VzIGZyb20gY3Jhc2hrX3JlcyBhbmQgYWRkIHJlc3QgdG8gbWVtbWFwICovCj4+
IC0JcmV0ID0gbWVtbWFwX2V4Y2x1ZGVfcmFuZ2VzKGltYWdlLCBjbWVtLCBjcmFzaGtfcmVzLnN0
YXJ0LCBjcmFzaGtfcmVzLmVuZCk7Cj4+IC0JaWYgKHJldCkKPj4gLQkJZ290byBvdXQ7Cj4gQW5k
IHlvdSBkaWRuJ3QgbWVudGlvbiBtb3ZpbmcgYWJvdmUgY29kZSBibG9jayB1cCBpbiBsb2cuIEkg
d291bGQKPiBzdWdnZXN0IGtlZXBpbmcgaXQgYXMgaXMgYmVjYXVzZSBpdCBsb29rcyBtb3JlIHJl
YXNvbmFibGUgdG8gYmUgYWRqYWNlbnQKPiB0byB0aGUgZm9sbG93aW5nIGNtZW0tPnJhbmdlc1td
IGhhbmRsaW5nLgoKWWVzLCBiYW9xdWFuLCBrZWVwaW5nIGl0IGFzIGl0IGlzIG1heSBiZSBtb3Jl
IGNvaGVyZW50Lkkgd2lsbCBwb3N0IGEgbmV3IHBhdGNowqBsYXRlci4KClRoYW5rcwpmdXFpYW5n
Cgo+PiAtCj4+ICAgCWZvciAoaSA9IDA7IGkgPCBjbWVtLT5ucl9yYW5nZXM7IGkrKykgewo+PiAg
IAkJZWkuc2l6ZSA9IGNtZW0tPnJhbmdlc1tpXS5lbmQgLSBjbWVtLT5yYW5nZXNbaV0uc3RhcnQg
KyAxOwo+PiAgIAo+PiAtLSAKPj4gMi40Mi4wCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
