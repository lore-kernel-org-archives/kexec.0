Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD9C43334
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjBFd8yFnZY3LTWVmrf3XGNKr+DbqUkBt4GII9/lXxo=; b=qWux+DNjX9D+8HSXQPoBsuZoBn
	Pmc34wtUXR61wp2dovNblx9MhFOpE25YneKC0qfxCHvLk66ANRFg2dxaq+Vsa0KR8fmw5ZodKpdeZ
	I8n9lM3KiLo+JFgMWhbyVGXysrapIyaYjLgBK8CT7jwoqKRqRrECb0j+SEb49QSNoW8c0OULMNmch
	0YNKON+CGJe+dQaEsvr+t1SiKv6x0xdcSnacNAGYh/r7lPDS9JV2zrmFAwvDGggMigIEAHI5Ib2u7
	s3Vdm9bEzbaOjvmslswFIDWbBpMQooS4TAwtS16Bjx/QxlavXNQsWvTAqKm51WghBM3/jbOX4Bw7A
	3NprpX2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH5W-00BlIC-9N; Tue, 26 Jul 2022 09:42:50 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH5S-00Bl29-LU; Tue, 26 Jul 2022 09:42:48 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUwL8I_1658828559;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUwL8I_1658828559)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:42:40 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: Conor.Dooley@microchip.com
Cc: alexandre.ghiti@canonical.com, heiko@sntech.de, palmer@dabbelt.com,
 mick@ics.forth.gr, guoren@kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 linux-riscv@lists.infradead.org, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
 anup@brainfault.org, corbet@lwn.net, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
 <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
 <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
 <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
 <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
Message-ID: <00776b91-6bff-e4b8-f000-5399924cd145@linux.alibaba.com>
Date: Tue, 26 Jul 2022 17:42:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_024246_913247_73BF23FD 
X-CRM114-Status: GOOD (  11.94  )
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

CuWcqCAyMDIyLzcvMjYg5LiL5Y2INToyOCwgWGlhbnRpbmcgVGlhbiDlhpnpgZM6Cj4KPiDlnKgg
MjAyMi83LzI2IOS4i+WNiDQ6MTYsIFhpYW50aW5nIFRpYW4g5YaZ6YGTOgo+Pgo+PiDlnKggMjAy
Mi83LzI2IOS4i+WNiDQ6MDEsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIOWGmemBkzoKPj4+
IE9uIDI2LzA3LzIwMjIgMDg6NTQsIHRpYW54aWFudGluZyB3cm90ZToKPj4+PiDlnKggMjAyMi83
LzI2IOS4iuWNiDE6MTMsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIOWGmemBkzoKPj4+Pj4g
VGhhdCBzYWlkLCB0aGlzIGRvZXMgbm90IGFwcGx5IHRvIHJpc2N2L2Zvci1uZXh0Ogo+Pj4+PiBi
NCBzaGF6YW0gMjAyMjA3MjUwMTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW5AbGludXguYWxp
YmFiYS5jb20KPj4+Pj4gR3JhYmJpbmcgdGhyZWFkIGZyb20gCj4+Pj4+IGxvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMjA3MjUwMTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW4lNDBsaW51eC5hbGli
YWJhLmNvbS90Lm1ib3guZ3oKPj4+Pj4gQ2hlY2tpbmcgZm9yIG5ld2VyIHJldmlzaW9ucyBvbiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvCj4+Pj4+IEFuYWx5emluZyA2IG1lc3NhZ2VzIGlu
IHRoZSB0aHJlYWQKPj4+Pj4gQ2hlY2tpbmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBt
YXkgdGFrZSBhIG1vbWVudC4uLgo+Pj4+PiAtLS0KPj4+Pj4gwqDCoMKgIFtQQVRDSCB2MiAxLzVd
IFJJU0MtVjogdXNlIF9fc21wX3Byb2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2YgCj4+Pj4+IHNtcF9w
cm9jZXNzb3JfaWQoKQo+Pj4+PiDCoMKgwqAgW1BBVENIIHYyIDIvNV0gUklTQy1WOiBBZGQgYXJj
aF9jcmFzaF9zYXZlX3ZtY29yZWluZm8gc3VwcG9ydAo+Pj4+PiDCoMKgwqAgW1BBVENIIHYyIDMv
NV0gcmlzY3Y6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwga2VybmVsIG1lbW9yeSAKPj4+Pj4gbGF5
b3V0IGR1bXAKPj4+Pj4gwqDCoMKgIFtQQVRDSCB2MiA0LzVdIFJJU0MtVjogRml4dXAgZ2V0dGlu
ZyBjb3JyZWN0IGN1cnJlbnQgcGMKPj4+Pj4gwqDCoMKgIFtQQVRDSCB2MiA1LzVdIHJpc2N2OiBj
cmFzaF9jb3JlOiBFeHBvcnQga2VybmVsIHZtIGxheW91dCwgCj4+Pj4+IHBoeXNfcmFtX2Jhc2UK
Pj4+Pj4gLS0tCj4+Pj4+IFRvdGFsIHBhdGNoZXM6IDUKPj4+Pj4gLS0tCj4+Pj4+IEFwcGx5aW5n
OiBSSVNDLVY6IHVzZSBfX3NtcF9wcm9jZXNzb3JfaWQoKSBpbnN0ZWFkIG9mIAo+Pj4+PiBzbXBf
cHJvY2Vzc29yX2lkKCkKPj4+Pj4gQXBwbHlpbmc6IFJJU0MtVjogQWRkIGFyY2hfY3Jhc2hfc2F2
ZV92bWNvcmVpbmZvIHN1cHBvcnQKPj4+Pj4gUGF0Y2ggZmFpbGVkIGF0IDAwMDIgUklTQy1WOiBB
ZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8gc3VwcG9ydAo+Pj4+IHBhdGNoIDIgYXBwbHkg
aXMgT0sgZm9yIG1lLCBJIGRvbid0IGtub3cgd2h5IHlvdSBmYWlsZWQgOigKPj4+PiBEbyB5b3Ug
aGF2ZSBtb3JlIGRldGFscyBmb3IgdGhpcz8KPj4+Pgo+Pj4gV2hhdCBkaWQgeW91IGFwcGx5IGl0
IHRvPyBJdCBkb2VzIG5vdCBhcHBseSBmb3IgbWUgdG8gcmlzY3YvZm9yLW5leHQ6Cj4+PiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eC5n
aXQvbG9nLz9oPWZvci1uZXh0IAo+Pj4KPj4KPj4gVGhpcyA1IHBhdGNoZXMgYXJlIGJhc2VkIG9u
IHRoZSBtYXN0ZXIgYnJhbmNoIG9mIGJlbG93IGdpdDoKPj4KPj4gaHR0cHM6Ly9rZXJuZWwuZ29v
Z2xlc291cmNlLmNvbS9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
IAo+Pgo+Pgo+PiAiZ2l0IGFtIDAwMDItUklTQy1WLUFkZC1hcmNoX2NyYXNoX3NhdmVfdm1jb3Jl
aW5mby1zdXBwb3J0LnBhdGNoIiB0byAKPj4gdGhpcyBnaXQgaXMgb2sgZm9yIG1lLgo+Pgo+PiBB
bGwgaXMgY29ycmVjdD8KPgo+IEkgZmlndXJlZCBvdXQgdGhlIHJlYXNvbiwgdGhlcmUgaXMgb25l
IGRpZmZlcmVuY2UgaW4gCj4gYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgYmV0d2VlbiByaXNj
di9mb3ItbmV4dCBhbmQgdG9ydmFsZHMvbGludXguCj4KPiBGb3IgcmlzY3YvZm9yLW5leHQsIGlu
IGxpbmUgODEgb2YgYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUsIGl0IGlzOgo+Cj4gwqDCoMKg
IG9iai0kKENPTkZJR19LRVhFQynCoMKgwqAgwqDCoMKgICs9IGtleGVjX3JlbG9jYXRlLm8gY3Jh
c2hfc2F2ZV9yZWdzLm8gCj4gbWFjaGluZV9rZXhlYy5vCj4KPiBCdXQgZm9yIHRvcnZhbGRzL2xp
bnV4LCBpbiBsaW5lIDgxIG9mIGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlLCBpdCBpczoKPgo+
IMKgwqDCoCBvYmotJChDT05GSUdfS0VYRUNfQ09SRSnCoMKgwqDCoMKgwqDCoCArPSBrZXhlY19y
ZWxvY2F0ZS5vIAo+IGNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwo+Cj4gdG9ydmFs
ZHMvbGludXggaXMgbmV3ZXIgdGhhbiByaXNjdi9mb3ItbmV4dCzCoCBjb21taXQgM2E2NmEwODc1
OSAKPiAoIlJJU0MtVjoga2V4ZWM6IEZpeCBidWlsZCBlcnJvciB3aXRob3V0IENPTkZJR19LRVhF
QyIpIGFkZGVkIAo+ICJDT05GSUdfS0VYRUNfQ09SRSIgZm9yIHRvcnZhbGRzL2xpbnV4LCBCdXQg
cmlzY3YvZm9yLW5leHQKPgo+IGRvZXNuJ3QgY29udGFpbiB0aGUgY29tbWl0LgoKSGkgRG9vbGV5
CgpJIHRoaW5rIHJpc2N2IGdpdCBuZWVkcyB0byBiZSB1cGRhdGVkIGZyb20gbGludXMgZ2l0LCBh
bmQgdGhlbiBJIHRoaW5rIApWNCBjYW4gYmUgYXBwbGllZCBub3JtYWxseS4KClY0OiBodHRwczov
L2xrbWwub3JnL2xrbWwvMjAyMi83LzI2LzMxNwoKPgo+Cj4+Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4g
Q29ub3IuCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
