Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57FC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j7cIqvi0BQY0DS/pTgXXiRUmmhTXWHBvQbRBC/NW0C0=; b=svQP9FW7spAdHG
	0JzHa3rSdtbBXYU2zJHjKRABnMZyt033dPUl39IJErU8qMhAh28DpDceMozkMW2l41G1pWRTxTsVQ
	c47DUb5Nci0UoV6RkcqL9cpLZN9Wy1DgYRC8Y2Ttzat/c3QOM6e9LlH0rAjZYYm++eJh/UQGNRRS3
	dqLYBsBaJADwNb6VcYierrHEtcJZ0nBIwAlp4dUv2kQ3PzfJ5fIOdNbLFEb7UKDtWvUOkJmM7nDS2
	OacHw10YJc1Br6gSGf5qheVEl50ZsW3nQjWqm43oYYzM/XxZfnlSnesfKSquFPpMD35onGceCrTsO
	HLIwkgX0DSRsk65OlzRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrfB-003N7N-0o;
	Mon, 24 Jul 2023 09:15:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrf8-003N4z-0Z
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 09:15:32 +0000
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8ZD90l9yzNmYw;
	Mon, 24 Jul 2023 17:11:53 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 17:15:14 +0800
Message-ID: <50554068-061b-297d-9401-8bd44690554d@huawei.com>
Date: Mon, 24 Jul 2023 17:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <ebiederm@xmission.com>,
	<zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
 <e8be33b7-efc2-52b3-35fe-17aca9c8767b@molgen.mpg.de>
From: "Wenyu Liu(D)" <liuwenyu7@huawei.com>
In-Reply-To: <e8be33b7-efc2-52b3-35fe-17aca9c8767b@molgen.mpg.de>
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_021530_374589_A928FA46 
X-CRM114-Status: GOOD (  17.36  )
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

VGhhbmtzIGZvciB0aGUgdGlwcywgSSdsbCBtYWtlIGEgZG91YmxlLWNoZWNrcG9zdCBhbmQgcG9z
dCBhIG5ldyBvbmUgbGF0ZXIKCuWcqCAyMDIzLzcvMjQgMTY6NDksIFBhdWwgTWVuemVsIOWGmemB
kzoKPiBEZWFyIFdlbnl1LAo+IAo+IAo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gU29tZSBt
aW5vciBjb21tZW50cywgeW91IGNhbiBpZ25vcmUuCj4gCj4gQW0gMjQuMDcuMjMgdW0gMDU6NDUg
c2NocmllYiBXZW55dSBMaXUoRCk6Cj4gCj4gVGhlIChEKSBsb29rcyBzdHJhbmdlLiBBdCBsZWFz
dCBhIHNwYWNlIHNob3VsZCBiZSBhZGRlZCBiZWZvcmUgdGhlICguCj4gCj4+IGtleGVjX211dGV4
IGlzIHJlcGxhY2VkIGJ5IGFuIGF0b21pYyB2YXJpYWJsZSBpbgo+PiA1NjMxNGI5MGZkNDNiZDI0
NDQgKHBhbmljLCBrZXhlYzogbWFrZSBfX2NyYXNoX2tleGVjKCkgTk1JIHNhZmUpLgo+Pgo+PiBG
aXggc29tZSBjb21tZW50IHRoYXQgc3RpbGwgdXNpbmcga2V4ZWNfbXV0ZXguCj4gCj4gY29tbWVu
dCpzKgo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBXZW55dSBMaXXCoCA8bGl1d2VueXU3QGh1YXdl
aS5jb20+Cj4gCj4gRHVlIHRvIHRoZSAoRCkgdGhpcyBkb2VzbuKAmXQgZXhhY3RseSBtYXRjaCB3
aXRoIHRoZSBBdXRob3IgZmllbGQuIFlvdSBhbHNvIGhhdmUgdHdvIHNwYWNlcyBiZWZvcmUgPCBp
bnN0ZWFkIG9mIG9uZS4KPiAKPiBBbHNvIGZvciB0aGUgY29tbWl0IG1lc3NhZ2Ugc3VtbWFyeSB5
b3UgY291bGQgYmUgbW9yZSBzcGVjaWZpYzoKPiAKPj4ga2V4ZWNfbG9jazogUmVwbGFjZSBrZXhl
Y19tdXRleCgpIGJ5IGtleGVjX2xvY2soKSBpbiB0d28gY29tbWVudHMKPiAKPiBBdCBsZWFzdCwg
cGxlYXNlIGFkZCBhIHNwYWNlIGFmdGVyIHRoZSBjb2xvbiAoOikuCj4gCj4+IC0tLQo+PiDCoCBr
ZXJuZWwva2V4ZWNfZmlsZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+
PiDCoCBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jIHwgMiArLQo+PiDCoCAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9rZXhlY19maWxlLmMgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCj4+IGluZGV4
IDg4MWJhMGQxNzE0Yy4uYjViYmIyZmUwNjY4IDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwva2V4ZWNf
ZmlsZS5jCj4+ICsrKyBiL2tlcm5lbC9rZXhlY19maWxlLmMKPj4gQEAgLTYyNCw3ICs2MjQsNyBA
QCBpbnQga2V4ZWNfbG9jYXRlX21lbV9ob2xlKHN0cnVjdCBrZXhlY19idWYgKmtidWYpCj4+IMKg
wqAgKiBrZXhlY19hZGRfYnVmZmVyIC0gcGxhY2UgYSBidWZmZXIgaW4gYSBrZXhlYyBzZWdtZW50
Cj4+IMKgwqAgKiBAa2J1ZjrCoCBCdWZmZXIgY29udGVudHMgYW5kIG1lbW9yeSBwYXJhbWV0ZXJz
Lgo+PiDCoMKgICoKPj4gLSAqIFRoaXMgZnVuY3Rpb24gYXNzdW1lcyB0aGF0IGtleGVjX211dGV4
IGlzIGhlbGQuCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIGFzc3VtZXMgdGhhdCBrZXhlY19sb2NrIGlz
IGhlbGQuCj4+IMKgwqAgKiBPbiBzdWNjZXNzZnVsIHJldHVybiwgQGtidWYtPm1lbSB3aWxsIGhh
dmUgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YKPj4gwqDCoCAqIHRoZSBidWZmZXIgaW4gbWVtb3J5
Lgo+PiDCoMKgICoKPj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tl
eGVjLmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jCj4+IGluZGV4IDQxOWRj
NDA1YzgzMS4uYWQxMzNmZTEyMGRiIDEwMDY0NAo+PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL2ltYV9rZXhlYy5jCj4+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVj
LmMKPj4gQEAgLTc3LDcgKzc3LDcgQEAgc3RhdGljIGludCBpbWFfZHVtcF9tZWFzdXJlbWVudF9s
aXN0KHVuc2lnbmVkIGxvbmcgKmJ1ZmZlcl9zaXplLCB2b2lkICoqYnVmZmVyLAo+PiDCoMKgICog
Q2FsbGVkIGR1cmluZyBrZXhlY19maWxlX2xvYWQgc28gdGhhdCBJTUEgY2FuIGFkZCBhIHNlZ21l
bnQgdG8gdGhlIGtleGVjCj4+IMKgwqAgKiBpbWFnZSBmb3IgdGhlIG1lYXN1cmVtZW50IGxpc3Qg
Zm9yIHRoZSBuZXh0IGtlcm5lbC4KPj4gwqDCoCAqCj4+IC0gKiBUaGlzIGZ1bmN0aW9uIGFzc3Vt
ZXMgdGhhdCBrZXhlY19tdXRleCBpcyBoZWxkLgo+PiArICogVGhpcyBmdW5jdGlvbiBhc3N1bWVz
IHRoYXQga2V4ZWNfbG9jayBpcyBoZWxkLgo+PiDCoMKgICovCj4+IMKgIHZvaWQgaW1hX2FkZF9r
ZXhlY19idWZmZXIoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+IMKgIHsKPj4gLS0gCj4+IDIuMzMu
MAo+IAo+IAo+IEtpbmQgcmVnYXJkcywKPiAKPiBQYXVsCj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
