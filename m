Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC3EC3DA5D
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rm+kRGYafp1MkuKTpCz5knvrodm3hhJr686k2MrsttI=; b=4QReLn0ieyH0VM
	Chr+1gcEtp/QAReEPEVCWtXys5BIYPgyFRsM9iHzXu44nZcnPL6iQNqg6+TcEmddSCfyrBmPcrcUr
	tvVOChQY9lBX47k1kL12RXstoCoWhya+tcm5XbZ0LmO9An4UehLMS9yAXgGJon3IhY6Xp2+Dk2AO4
	zDS1gAACzqlGYneIVcYziM9TukJq3GQRZk+y3Lw3tIkx1AKeZL1acHe8sdpP/ur9JNkvqwl2KRTzD
	mwXfjkggSAy0TIlf0EuUEJstnvc9SafXAQmbK1SPmz2kiPr6HB9zn0xzjJ/E0K8iohp9y+bWGJMjf
	iOy4cqHrzuic9BG2Of0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUFpF-0000000FO6A-39VZ;
	Thu, 18 Jul 2024 01:20:53 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUFpC-0000000FO4T-1xyR
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 01:20:52 +0000
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WPZdL5JWNz1X4jH;
	Thu, 18 Jul 2024 09:16:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 418D01402D0;
	Thu, 18 Jul 2024 09:20:42 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 09:20:41 +0800
Message-ID: <5193478a-b72c-0f96-a34b-c467f02effb5@huawei.com>
Date: Thu, 18 Jul 2024 09:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
 <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_182050_869844_4315C826 
X-CRM114-Status: GOOD (  24.26  )
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

CgpPbiAyMDI0LzcvMTcgMjE6MzgsIEJhb3F1YW4gSGUgd3JvdGU6Cj4gT24gMDcvMTcvMjQgYXQg
MDM6MDlwbSwgSmluamllIFJ1YW4gd3JvdGU6Cj4+IFNpbWlsYXIgdG8gY29tbWl0IDhmOWRhZGU1
OTA2YSAoImNyYXNoOiBmaXggeDg2XzMyIG1lbW9yeSByZXNlcnZlIGRlYWQgbG9vcAo+PiByZXRy
eSBidWciKSBhbmQgaW4gdGhlIHN5bW1ldHJ5IGNhc2UsIG9uIHg4Nl8zMiBRZW11IG1hY2hpbmUg
d2l0aAo+PiAxR0IgbWVtb3J5LCB0aGUgY21kbGluZSAiY3Jhc2hrZXJuZWw9NTEyTSIgd2lsbCBh
bHNvIGNhdXNlIHN5c3RlbSBzdGFsbAo+PiBhcyBiZWxvdzoKPj4KPj4gCUFDUEk6IFJlc2Vydmlu
ZyBGQUNQIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2ZmZTE4YjgtMHgzZmZlMTkyYl0KPj4gCUFD
UEk6IFJlc2VydmluZyBEU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2ZmZTAwNDAtMHgzZmZl
MThiN10KPj4gCUFDUEk6IFJlc2VydmluZyBGQUNTIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2Zm
ZTAwMDAtMHgzZmZlMDAzZl0KPj4gCUFDUEk6IFJlc2VydmluZyBBUElDIHRhYmxlIG1lbW9yeSBh
dCBbbWVtIDB4M2ZmZTE5MmMtMHgzZmZlMTliYl0KPj4gCUFDUEk6IFJlc2VydmluZyBIUEVUIHRh
YmxlIG1lbW9yeSBhdCBbbWVtIDB4M2ZmZTE5YmMtMHgzZmZlMTlmM10KPj4gCUFDUEk6IFJlc2Vy
dmluZyBXQUVUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2ZmZTE5ZjQtMHgzZmZlMWExYl0KPj4g
CTE0M01CIEhJR0hNRU0gYXZhaWxhYmxlLgo+PiAJODc5TUIgTE9XTUVNIGF2YWlsYWJsZS4KPj4g
CSAgbWFwcGVkIGxvdyByYW06IDAgLSAzNmZmZTAwMAo+PiAJICBsb3cgcmFtOiAwIC0gMzZmZmUw
MDAKPj4gCSAgKHN0YWxsIGhlcmUpCj4+Cj4+IFRoZSByZWFzb24gaXMgdGhhdCB0aGUgQ1JBU0hf
QUREUl9MT1dfTUFYIGlzIGVxdWFsIHRvIENSQVNIX0FERFJfSElHSF9NQVgKPj4gb24geDg2XzMy
LCB0aGUgZmlyc3QgImxvdyIgY3Jhc2gga2VybmVsIG1lbW9yeSByZXNlcnZhdGlvbiBmb3IgNTEy
TSBmYWlscywKPj4gdGhlbiBpdCBnbyBpbnRvIHRoZSAicmV0cnkiIGxvb3AgYW5kIG5ldmVyIGNh
bWUgb3V0IGFzIGJlbG93IChjb25zaWRlcgo+PiBDUkFTSF9BRERSX0xPV19NQVggPSBDUkFTSF9B
RERSX0hJR0hfTUFYID0gNTEyTSk6Cj4+Cj4+IC0+IHJlc2VydmVfY3Jhc2hrZXJuZWxfZ2VuZXJp
YygpIGFuZCBoaWdoIGlzIGZhbHNlCj4+ICAgIC0+IGFsbG9jIGF0IFswLCAweDIwMDAwMDAwXSBm
YWlsCj4+ICAgICAgIC0+IGFsbG9jIGF0IFsweDIwMDAwMDAwLCAweDIwMDAwMDAwXSBmYWlsIGFu
ZCByZXBlYXRlZGx5Cj4+ICAgICAgIChiZWNhdXNlIENSQVNIX0FERFJfTE9XX01BWCA9IENSQVNI
X0FERFJfSElHSF9NQVgpLgo+Pgo+PiBGaXggaXQgYnkgYWxzbyBjaGFuZ2luZyB0aGUgYW5vdGhl
ciBvdXQgY2hlY2sgY29uZGl0aW9uLCB0aGUgZml4ZWQgYmFzZQo+PiBzaXR1YXRpb24gaGFzIG5v
IHByb2JsZW0gYmVjYXVzZSBpdCB3YXJuIG91dCBpZiBpdCBmYWlsIHRvIGFsbG9jLgo+Pgo+PiBB
ZnRlciB0aGlzIHBhdGNoLCBpdCBwcmludHM6Cj4+IAljYW5ub3QgYWxsb2NhdGUgY3Jhc2hrZXJu
ZWwgKHNpemU6MHgyMDAwMDAwMCkKPj4KPj4gRml4ZXM6IDljMDhhMmExMzlmZSAoIng4Njoga2R1
bXA6IHVzZSBnZW5lcmljIGludGVyZmFjZSB0byBzaW1wbGlmeSBjcmFzaGtlcm5lbCByZXNlcnZh
dGlvbiBjb2RlIikKPj4gU2lnbmVkLW9mZi1ieTogSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVh
d2VpLmNvbT4KPj4gLS0tCj4+ICBrZXJuZWwvY3Jhc2hfcmVzZXJ2ZS5jIHwgMiArLQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvY3Jhc2hfcmVzZXJ2ZS5jIGIva2VybmVsL2NyYXNoX3Jlc2VydmUuYwo+PiBp
bmRleCAwM2U0NTU3MzhlNzUuLjM2YzEzY2Y5NDJmNCAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2Ny
YXNoX3Jlc2VydmUuYwo+PiArKysgYi9rZXJuZWwvY3Jhc2hfcmVzZXJ2ZS5jCj4+IEBAIC00MDks
NyArNDA5LDcgQEAgdm9pZCBfX2luaXQgcmVzZXJ2ZV9jcmFzaGtlcm5lbF9nZW5lcmljKGNoYXIg
KmNtZGxpbmUsCj4+ICAJCSAqIGxvdyBtZW1vcnksIGZhbGwgYmFjayB0byBoaWdoIG1lbW9yeSwg
dGhlIG1pbmltdW0gcmVxdWlyZWQKPj4gIAkJICogbG93IG1lbW9yeSB3aWxsIGJlIHJlc2VydmVk
IGxhdGVyLgo+PiAgCQkgKi8KPj4gLQkJaWYgKCFoaWdoICYmIHNlYXJjaF9lbmQgPT0gQ1JBU0hf
QUREUl9MT1dfTUFYKSB7Cj4+ICsJCWlmICghaGlnaCAmJiAhc2VhcmNoX2Jhc2UpIHsKPiAKPiBI
bW0sIHRoaXMgbWF5IG5vdCBiZSBnb29kLiBXZSBjYW4ndCBndWFyYW50ZWUgdGhhdCBDUkFTSF9B
RERSX0xPV19NQVggbXVzdAo+IG5vdCBiZSAwLiBJIHN0aWxsIHN1Z2dlc3QgeW91IHRlc3Rpbmcg
YmVsb3cgZHJhZnQgcGF0Y2ggdG8gc2VlIGlmIGl0IHdvcmtzCj4gd2VsbC4gQW5kIHdlIHNob3Vs
ZCByZXZlcnQgdGhlIHBhdGNoIGluIEFuZHJldydzIHRyZWUgc2luY2UgaXQncyBub3QgZ29vZC4K
PiBQb3N0aW5nIGxpa2UgdGhlc2UgbWVzcyB3aWxsIGNvbmZ1c2UgcGVvcGxlIGFuZCBhZGQgZGlm
ZmljdWx0eSB3aGVuCj4gYmFja3BvcnRpbmcuCgpPS++8jGxldCBtZSBnZXQgdGhpcyBzdHJhaWdo
dCBhbmQgdGVzdCB5b3VyIGRyYWZ0IHBhdGNoZXMsIGlmIGl0IGlzIG9rLApJJ2xsIHNlbmQgdGhl
bSBzb29uZXIuCgo+IAo+IFlvdSBoYXZlbid0IHJlc3BvbmRlZCB0byBteSBlYXJsaWVyIHJlcXVl
c3QgdG8gdGVzdCB0aG9zZSB0d28gZHJhZnQKPiBwYXRjaGVzLiBXaGVuIHlvdSB0ZXN0ZWQgYmVs
b3cgY29kZSBhbmQgaXQncyBnb29kLCB5b3UgY2FuIHBvc3QgdGhpcyBhcwo+IGEgZm9ybWFsIHBh
dGNoLiBTbyBteSBzdWdnZXN0aW9uIHRvIHRoZSB3aG9sZSB3b3JrIGlzOgo+IAo+IDEpIHJldmVy
dCBjb21taXQgOGY5ZGFkZTU5MDZhIGluIEFuZHJldydzIHRyZWU7Cj4gCj4gMikgcG9zdCB0d28g
cGF0Y2hlcyBJIHN1Z2dlc3RlZCB0byBwcmV2ZXJ0IGNyYXNoa2VybmVsPSxoaWdoIGZvciAzMmJp
dAo+IHN5c3RlbSwgYW5kIGZpeCB0aGUgaXNzdWUgeW91IGZvdW5kOwo+IAo+IDMpIHBvc3QgcGF0
Y2hzZXQgdG8gbWFrZSBhcm0zMiB1c2UgZ2VuZXJpYyBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbi4K
ClNvcnJ5LCBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0YW5kIHlvdXIgcmVhbCBpbnRlbnRpb25zIGJl
Zm9yZS4gVGhhbmtzIGZvcgp0aGUgc3VnZ2VzdGlvbi4gSSdsbCByZXRlc3QgYW5kIHN1Ym1pdCB0
aGUgcGF0Y2ggYmFzZWQgb24geW91ciBzdWdnZXN0aW9uLgoKPiAKPiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2NyYXNoX3Jlc2VydmUuYyBiL2tlcm5lbC9jcmFzaF9yZXNlcnZlLmMKPiBpbmRleCA1YjI3
MjJhOTNhNDguLmFjMDg3YmE0NDJjZCAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvY3Jhc2hfcmVzZXJ2
ZS5jCj4gKysrIGIva2VybmVsL2NyYXNoX3Jlc2VydmUuYwo+IEBAIC00MTQsNyArNDE0LDggQEAg
dm9pZCBfX2luaXQgcmVzZXJ2ZV9jcmFzaGtlcm5lbF9nZW5lcmljKGNoYXIgKmNtZGxpbmUsCj4g
IAkJCXNlYXJjaF9lbmQgPSBDUkFTSF9BRERSX0hJR0hfTUFYOwo+ICAJCQlzZWFyY2hfYmFzZSA9
IENSQVNIX0FERFJfTE9XX01BWDsKPiAgCQkJY3Jhc2hfbG93X3NpemUgPSBERUZBVUxUX0NSQVNI
X0tFUk5FTF9MT1dfU0laRTsKPiAtCQkJZ290byByZXRyeTsKPiArCQkJaWYgKHNlYXJjaF9iYXNl
ICE9IHNlYXJjaF9lbmQpCj4gKwkJCQlnb3RvIHJldHJ5Owo+ICAJCX0KPiAgCj4gIAkJLyoKPiAK
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
