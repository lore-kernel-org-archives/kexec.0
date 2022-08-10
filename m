Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C24C00140
	for <kexec@archiver.kernel.org>; Wed, 10 Aug 2022 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ydx0KcZ1Yf5++I8pIc4CH+a8pYM0BsEDJ2R6/6Bj0tU=; b=Od8jARMpuHYgTC4h2iXMal76fa
	3Tqa405F5p84IVYjggUlYTMzKAaFz2rKXRJxSsuEct5HwJ2CCiNm7TrDhFbA85mpyfYAFDwPj0mYq
	0ZNLJeMWgnrsGxBegzdChM4d16tapWk8IMZLFqx9cCoRIrySNlT6CIcSRag1nVIf5iFdusL9ZjElS
	ONlZHdeJO+qz+5xhwpxWbVjk/iLKDoj0RP3ma4nMbcuTL7Rxi+TFyTYyj9VKQdQGGw7rQJkPaHn/m
	XMF21xnSUej5DSYjOWgsquKMk3XlKyTJdIm1Dd5JSxQGCkSm6FMCeZf0Ed7/kPgMe4c/VuZZomhZC
	qvG4jNrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLkO4-00BgUv-3P; Wed, 10 Aug 2022 12:00:36 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLkNx-00BgSl-In; Wed, 10 Aug 2022 12:00:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLv5JNk_1660132822;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLv5JNk_1660132822)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 20:00:23 +0800
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
To: Conor.Dooley@microchip.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
 guoren@kernel.org, mick@ics.forth.gr, alexandre.ghiti@canonical.com,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
 heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
 <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <31231d21-7d23-9412-01d4-b2d4aa73cfc9@linux.alibaba.com>
Date: Wed, 10 Aug 2022 20:00:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_050029_808379_5C388332 
X-CRM114-Status: GOOD (  20.84  )
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

CuWcqCAyMDIyLzgvMTAg5LiK5Y2INToyMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g5YaZ
6YGTOgo+IE9uIDAyLzA4LzIwMjIgMTM6MTgsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IHJpc2N2
OiBjcmFzaF9jb3JlOiBFeHBvcnQga2VybmVsIHZtIGxheW91dCwgcGh5c19yYW1fYmFzZQo+IENh
biB5b3UgcGxlYXNlIGp1c3QgdXNlIFJJU0MtVjogZm9yIHRoZSB3aG9sZSBzZXJpZXMsIG15IE9D
RAo+IGhhdGVzIHRoZSBtaXggaGFoYS4KClNvcnJ5LCBJIG1pc3NlZCBpdCzCoCB5b3UgZXZlciBw
b2ludGVkIG91dCB0aGlzIHBvYmxlbSBpbiB0aGUgY29tbWVudHMgb2YgClYzLCBJIHdpbGwgZGVm
aW5pdGVseSBmaXggdGhlIGlzc3VlIGluIFY2LgoKPgo+PiBUaGVzZSBpbmZvcyBhcmUgbmVlZGVk
IGJ5IHRoZSBrZHVtcCBjcmFzaCB0b29sLiBTaW5jZSB0aGVzZSB2YWx1ZXMgY2hhbmdlCj4+IGZy
b20gdGltZSB0byB0aW1lLCBpdCBpcyBwcmVmZXJhYmxlIHRvIGV4cG9ydCB0aGVtIHZpYSB2bWNv
cmVpbmZvIHRoYW4gdG8KPj4gY2hhbmdlIHRoZSBjcmFzaCdzIGNvZGUgZnJlcXVlbnRseS4KPiBU
aGlzIGNvbW1pdCBkZXNjcmlwdGlvbiBkb2Vzbid0IHNlZW0gdG8gbWF0Y2ggdGhlIHBhdGNoZXMg
YXQgYWxsLgo+IEkgZG9uJ3Qgc2VlIGFueSBleHBvcnRpbmcgaGFwcGVuaW5nIGhlcmUgYXQgYWxs
IC0gdGhpcyBpcyBkb2N1bWVudGluZwpUaGUgcmVhbCBleHBvcnQgY29kZSBpcyBpbiAyLzYgcGF0
Y2gsIHllcyB0aGlzIGlzIHRoZSBkb2N1bWVudCBqdXN0IApkZXNjcmliZSB0aGUgZXhwb3J0aW5n
IGNvbnRlbnRzCj4gdGhlIGV4cG9ydC4gTWF5YmUgSSBhbSBqdXN0IG1pc3VuZGVyc3RhbmRpbmcs
IGJ1dCB0aGlzIGNvbW1pdCBtZXNzYWdlCj4ganVzdCBkb2Vzbid0IHNlZW0gdG8gbWF0Y2ggdGhl
IGNoYW5nZS4gU2Vjb25kbHksIHNob3VsZCB0aGUgc3ViamVjdCBub3QKPiBiZSBzb21ldGhpbmcg
bGlrZSAiZG9jczogYWRtaW4tZ3VpZGU6IGFkZCByaXNjdiBjcmFzaCBrZXJuZWwgeWFkYSB5YWRh
Ij8KdGhlIGNvbW1pdCBsb2cgZm9yIHRoZSBmaWxlIAonRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZHVtcC92bWNvcmVpbmZvLnJzdCcgaXMgbm90IHVuaWZpZWQgaW4gdGhlIApjb21taXQgaGlz
dG9yeSBvZiB0aGUgZmlsZS4gSSBhZ3JlZSB3aXRoIHlvdSAnZG9jczogYWRtaW4tZ3VpZGU6IHh4
eCcgaXMgCmJldHRlcizCoCB3aWxsIGZpeCBpdCBWNi4KPiBNYXliZSB0aGUgY3VycmVudCBzdWJq
ZWN0IGxpbWUgdGhhdCBleHBsYWlucyB0aGUgbGFjayBvZiBhIHJldmlldyBmcm9tCj4gdGhlIGRv
Y3MgbWFpbnRhaW5lcj8KeWVzLCBpdCBpcyBwb3NzaWJsZSA6KQo+Cj4gVGhhbmtzLAo+IENvbm9y
LgpGb3IgeW91ciBjb21tZW50cyBmb3Igb3RoZXIgcGF0Y2hlcywgSSB3aWxsIGZpeCBpdCBpbiB2
NiwgdGhhbmtzCj4KPj4gU2lnbmVkLW9mZi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlh
bkBsaW51eC5hbGliYWJhLmNvbT4KPj4gLS0tCj4+ICAgLi4uL2FkbWluLWd1aWRlL2tkdW1wL3Zt
Y29yZWluZm8ucnN0ICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKwo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdAo+PiBpbmRleCA4NDE5MDE5YjZhODguLjZiNzYy
ODRhNTAzYyAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92
bWNvcmVpbmZvLnJzdAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3Zt
Y29yZWluZm8ucnN0Cj4+IEBAIC01OTUsMyArNTk1LDM0IEBAIFgyVExCCj4+ICAgLS0tLS0KPj4g
ICAKPj4gICBJbmRpY2F0ZXMgd2hldGhlciB0aGUgY3Jhc2hlZCBrZXJuZWwgZW5hYmxlZCBTSCBl
eHRlbmRlZCBtb2RlLgo+PiArCj4+ICtSSVNDVjY0Cj4+ICs9PT09PT09Cj4+ICsKPj4gK1ZBX0JJ
VFMKPj4gKy0tLS0tLS0KPj4gKwo+PiArVGhlIG1heGltdW0gbnVtYmVyIG9mIGJpdHMgZm9yIHZp
cnR1YWwgYWRkcmVzc2VzLiBVc2VkIHRvIGNvbXB1dGUgdGhlCj4+ICt2aXJ0dWFsIG1lbW9yeSBy
YW5nZXMuCj4+ICsKPj4gK1BBR0VfT0ZGU0VUCj4+ICstLS0tLS0tLS0tLQo+PiArCj4+ICtJbmRp
Y2F0ZXMgdGhlIHZpcnR1YWwga2VybmVsIHN0YXJ0IGFkZHJlc3Mgb2YgZGlyZWN0LW1hcHBlZCBS
QU0gcmVnaW9uLgo+PiArCj4+ICtwaHlzX3JhbV9iYXNlCj4+ICstLS0tLS0tLS0tLS0tCj4+ICsK
Pj4gK0luZGljYXRlcyB0aGUgc3RhcnQgcGh5c2ljYWwgUkFNIGFkZHJlc3MuCj4+ICsKPj4gK01P
RFVMRVNfVkFERFJ8TU9EVUxFU19FTkR8Vk1BTExPQ19TVEFSVHxWTUFMTE9DX0VORHxWTUVNTUFQ
X1NUQVJUfFZNRU1NQVBfRU5ECj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiArS0FTQU5fU0hB
RE9XX1NUQVJUfEtBU0FOX1NIQURPV19FTkR8S0VSTkVMX0xJTktfQUREUnxBRERSRVNTX1NQQUNF
X0VORAo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiArCj4+ICtVc2VkIHRvIGdldCB0aGUgY29ycmVjdCBy
YW5nZXM6Cj4+ICsJTU9EVUxFU19WQUREUiB+IE1PRFVMRVNfRU5EIDogS2VybmVsIG1vZHVsZSBz
cGFjZS4KPj4gKwlWTUFMTE9DX1NUQVJUIH4gVk1BTExPQ19FTkQgOiB2bWFsbG9jKCkgLyBpb3Jl
bWFwKCkgc3BhY2UuCj4+ICsJVk1FTU1BUF9TVEFSVCB+IFZNRU1NQVBfRU5EIDogdm1lbW1hcCBy
ZWdpb24sIHVzZWQgZm9yIHN0cnVjdCBwYWdlIGFycmF5Lgo+PiArCUtBU0FOX1NIQURPV19TVEFS
VCB+IEtBU0FOX1NIQURPV19FTkQgOiBrYXNhbiBzaGFkb3cgc3BhY2UuCj4+ICsJS0VSTkVMX0xJ
TktfQUREUiB+IEFERFJFU1NfU1BBQ0VfRU5EIDogS2VybmVsIGxpbmsgYW5kIEJQRiBzcGFjZS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
