Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D1BC0015E
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qFy3McV4Gi/5Var4d6RfZcY64RFSs/QRvwtdJG48zJA=; b=u9NPgpmVPEq+VI
	qDPIvdmjvbwMxQqwq/EAG+zhVeTswv60awRGIf+ECijbky/yZ1x+D0k7K7yC4MYwfBpNA92Y34DWo
	6AtFuSkOWQkj6OObUrT0uFZe0S7J/d8PnHYtmHgHrGPe+9OCjl1hyuvTxkyqnKLLVyU3cPrWAJwNS
	S2On0VZmg6l2mKWL933DLP6rgBx+GJ6OPF9Gszl7bPs0S9TogKAF0neCscgPjBm0SwU2IbN3VnPr6
	RSTci0HH+gLJwSUmx3wCToiVL3Lqi7z4/fWqXMYsopDJQPwnwFfdb39CB4525frx0zdIJv6AKETgg
	R4GOeko8utHByKBUr+5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfs6-0012lD-2h;
	Wed, 12 Jul 2023 19:51:34 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfs3-0012kK-27
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 19:51:33 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4F7521C44E3;
	Wed, 12 Jul 2023 12:51:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4F7521C44E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689191490;
	bh=XWgXWccHXGwOZynTUzmidCv6kIrNzsZRU1wO2t/sUe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZYGH9X73G0ySyAzZ3NFJaMsuvwtwrudfc/+dcEW0fbroe84lpiNTTyGG4aOc++aa
	 X2Alt9TlCxJh7fjMki8+G1EEyFuxy1jfZOmd/C5tU/e0L9nrTtbpCwVTfFNM39BEOT
	 0Xb3OQzcxTB2DpW7v1MwTStbL+PB/dsE7NYRTAdo=
Message-ID: <7ece0f6d-3c11-eeea-e540-c6dff707b06c@linux.microsoft.com>
Date: Wed, 12 Jul 2023 12:51:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] kexec: implement functions to map and unmap segment
 to kimage
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
 <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
 <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
 <4ccfe980-3c71-fa06-59e4-56c85d798224@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <4ccfe980-3c71-fa06-59e4-56c85d798224@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_125131_744515_07B617F5 
X-CRM114-Status: GOOD (  17.73  )
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

Ck9uIDcvMTEvMjMgMTI6MTksIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4KPgo+IE9uIDcvMTEvMjMg
MTQ6NDEsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4gQWRkaW5nIEVyaWMgdG8gY2MuCj4+Cj4+
IE9uIDcvNy8yMyAwNToyOCwgU3RlZmFuIEJlcmdlciB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gNy8z
LzIzIDE3OjU3LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+Pj4gQ3VycmVudGx5LCB0aGVyZSdz
IG5vIG1lY2hhbmlzbSB0byBtYXAgYW5kIHVubWFwIHNlZ21lbnRzIHRvIHRoZSAKPj4+PiBraW1h
Z2UKPj4+PiBzdHJ1Y3R1cmUuwqAgVGhpcyBmdW5jdGlvbmFsaXR5IGlzIG5lZWRlZCB3aGVuIGRl
YWxpbmcgd2l0aCBtZW1vcnkgCj4+Pj4gc2VnbWVudHMKPj4+PiBpbiB0aGUgY29udGV4dCBvZiBh
IGtleGVjIG9wZXJhdGlvbi4KPj4+Pgo+Pj4+IFRoZSBwYXRjaCBhZGRzIHR3byBuZXcgZnVuY3Rp
b25zOiBraW1hZ2VfbWFwX3NlZ21lbnQoKSBhbmQKPj4+PiBraW1hZ2VfdW5tYXBfc2VnbWVudCgp
Lgo+Pj4+Cj4+Pj4gSW1wbGVtZW50IGtpbWFnZV9tYXBfc2VnbWVudCgpIHdoaWNoIHRha2VzIGEg
a2ltYWdlIHBvaW50ZXIsIGFuIAo+Pj4+IGFkZHJlc3MsCj4+Pj4gYW5kIGEgc2l6ZS7CoCBFbnN1
cmVzIHRoYXQgdGhlIGVudGlyZSBzZWdtZW50IGlzIGJlaW5nIG1hcHBlZCBieSAKPj4+PiBjb21w
YXJpbmcKPj4+PiB0aGUgZ2l2ZW4gYWRkcmVzcyBhbmQgc2l6ZSB0byBlYWNoIHNlZ21lbnQgaW4g
dGhlIGtpbWFnZSdzIHNlZ21lbnQgCj4+Pj4gYXJyYXkuCj4+Pj4gQ29sbGVjdCB0aGUgc291cmNl
IHBhZ2VzIHRoYXQgY29ycmVzcG9uZCB0byB0aGUgZ2l2ZW4gYWRkcmVzcyByYW5nZSwKPj4+PiBh
bGxvY2F0ZSBhbiBhcnJheSBvZiBwb2ludGVycyB0byB0aGVzZSBwYWdlcywgYW5kIG1hcCB0aGVt
IHRvIGEgCj4+Pj4gY29udGlndW91cwo+Pj4+IHJhbmdlIG9mIHZpcnR1YWwgYWRkcmVzc2VzLsKg
IElmIHRoZSBtYXBwaW5nIG9wZXJhdGlvbiBpcyAKPj4+PiBzdWNjZXNzZnVsLCB0aGUKPj4+PiBm
dW5jdGlvbiByZXR1cm5zIHRoZSBzdGFydCBvZiB0aGlzIHJhbmdlLsKgIE90aGVyd2lzZSwgaXQg
ZnJlZXMgdGhlIAo+Pj4+IHBhZ2UKPj4+PiBwb2ludGVyIGFycmF5IGFuZCByZXR1cm5zIE5VTEwu
Cj4+Pj4KPj4+PiBJbXBsZW1lbnQga2ltYWdlX3VubWFwX3NlZ21lbnQoKSB0aGF0IHRha2VzIGEg
cG9pbnRlciB0byBhIHNlZ21lbnQgCj4+Pj4gYnVmZmVyCj4+Pj4gYW5kIHVubWFwcyBpdCB1c2lu
ZyB2dW5tYXAoKS4KPj4+Pgo+Pj4+IEZpbmFsbHksIG1vdmUgZm9yX2VhY2hfa2ltYWdlX2VudHJ5
KCkgbWFjcm8gdG8ga2V4ZWMuaC4KPj4+Pgo+Pj4+IE5vdGU6IFVzZSBraW1hZ2VfbWFwX3NlZ21l
bnQoKSBhbmQga2ltYWdlX3VubWFwX3NlZ21lbnQoKSBjYXJlZnVsbHkgdG8KPj4+PiBhdm9pZCBt
ZW1vcnkgbGVha3MgYW5kIGVuc3VyZSB0aGF0IGFsbCBtYXBwZWQgc2VnbWVudHMgYXJlIHByb3Bl
cmx5Cj4+Pj4gdW5tYXBwZWQgd2hlbiB0aGV5J3JlIG5vIGxvbmdlciBuZWVkZWQuCj4+Pj4KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29m
dC5jb20+Cj4+Pgo+Pj4+ICsKPj4+PiArwqDCoMKgIGkgPSAwOwo+Pj4+ICvCoMKgwqAgZm9yX2Vh
Y2hfa2ltYWdlX2VudHJ5KGltYWdlLCBwdHIsIGVudHJ5KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChlbnRyeSAmIElORF9ERVNUSU5BVElPTikKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXN0X3BhZ2VfYWRkciA9IGVudHJ5ICYgUEFHRV9NQVNLOwo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBlbHNlIGlmIChlbnRyeSAmIElORF9TT1VSQ0UpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZGVzdF9wYWdlX2FkZHIgPj0gYWRkciAmJiBkZXN0X3BhZ2VfYWRkciA8IGVhZGRy
KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcmNfcGFnZV9hZGRyID0g
ZW50cnkgJiBQQUdFX01BU0s7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
cmNfcGFnZXNbaSsrXSA9IHBoeXNfdG9fcGFnZShzcmNfcGFnZV9hZGRyKTsKPj4+Cj4+PiBTaW5j
ZSBwaHlzX3RvX3BhZ2UgaXMgbm90IGRlZmluZWQgb24gbWFueS9tb3N0IGFyY2hpdGVjdHVyZXMg
SSAKPj4+IGNoYW5nZSBpdCBmb3IgcHBjNjQgYW5kIGhhdmUgc3VjY2Vzc2Z1bGx5IHVzZWQgdGhl
IGZvbGxvd2luZzoKPj4+Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNyY19wYWdlc1tpKytdID0gCj4+PiB2aXJ0X3RvX3Bh
Z2UoX192YShzcmNfcGFnZV9hZGRyKSkKPj4+Cj4+Pgo+Pj4gQWZ0ZXIgc2V2ZXJhbCBrZXhlY3Mg
dGhlIGZvbGxvd2luZyBjaGVjayBzdGlsbCB3b3JrczoKPj4+Cj4+PiAjIGV2bWN0bCBpbWFfbWVh
c3VyZW1lbnQgLS1pZ25vcmUtdmlvbGF0aW9ucyAKPj4+IC9zeXMva2VybmVsL3NlY3VyaXR5L2lt
YS9iaW5hcnlfcnVudGltZV9tZWFzdXJlbWVudHMKPj4+IE1hdGNoZWQgcGVyIFRQTSBiYW5rIGNh
bGN1bGF0ZWQgZGlnZXN0KHMpLgo+Pj4KPj4+Cj4+PiDCoMKgIFN0ZWZhbgo+PiBUaGFuayB5b3Ug
c28gbXVjaCBTdGVmYW4gZm9yIHJldmlld2luZyB0aGlzIHNlcmllcywgYW5kIGNhdGNoaW5nIHRo
aXMKPj4gaXNzdWUuwqAgQXJlIHlvdSBzdWdnZXN0aW5nIEkgc2hvdWxkIHVzZSB2aXJ0X3RvX3Bh
Z2Ugb24gYWxsIAo+PiBhcmNoaXRlY3R1cmVzCj4+IHVuY29uZGl0aW9uYWxseSwgb3IgdXNlIGl0
IG9ubHkgd2hlbiBwaHlzX3RvX3BhZ2UgaXMgbm90IGF2YWlsYWJsZT8KPgo+IEkgd291bGQgdHJ5
IHRvIHVzZWQgaXQgb24gYWxsIGFyY2hpdGVjdHVyZXMuCj4KPiDCoMKgIFN0ZWZhbgo+Ck9rLsKg
IFRoYW5rcy4KPj4KPj4gflR1c2hhcgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+PiBrZXhlYyBtYWlsaW5nIGxpc3QKPj4ga2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
