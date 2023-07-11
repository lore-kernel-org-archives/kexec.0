Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852F8EB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yQTx3FJfbfNk9z4FLlq+FZycTx0hq11h70+GpWEhQ2w=; b=T+HJ4WJHc30/IE
	Gw4Nwjo2CKMZWxNW8t8a2VQ3e86Z5Sh83/vdx4x8TSHU81GbZR/8v2owEpZ+UmV+Zir9Nkw6waOac
	vIQDD/hkaDn7GczGZt+a87PXq/n3CbaAQ4xDGz9jshmWeX7YYLKRZYFGqzRJhItiiZErwjntNSRCV
	riySgP8vMTt5BkZRdBPXrnsfVsoFA/DtZfLRtcAtguSaOnZFXTtfUVydSN8439cBecuk+OWmlJuKr
	OCgFM7in/JKWCCM/qeFBU7vHrZh5z3teC/BEMxK/DyL519lZE1730AhYUx2IGTymKjA1K5Ab81P1P
	/cN2YOKhjPoVBdvmHW2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIIh-00Ffuu-1w;
	Tue, 11 Jul 2023 18:41:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIIe-00FfuC-2U
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 18:41:26 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9840721C3A8D;
	Tue, 11 Jul 2023 11:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9840721C3A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689100883;
	bh=0GFCMNg+hUxtyeZcShJCkgLrUpGQ8MTiJMhSHuPwS3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iP1W+zVrSVAQrGy8cXoByzhI3bZaukOYdGVH9EqFojNZgzR1e2zhow2HqDQ4cHdG5
	 G3X1AbagoCZucIyEr0cVQ5GMrdFyeQ9FB7al/pBwTH3SPhKHWGOV+r+nWwp4sgwyw+
	 psN/2zIbasw6jX6ScpjiXYUqNGYaOCLGcFVWE9VQ=
Message-ID: <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
Date: Tue, 11 Jul 2023 11:41:23 -0700
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_114124_880993_DE41F21F 
X-CRM114-Status: GOOD (  19.36  )
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

QWRkaW5nIEVyaWMgdG8gY2MuCgpPbiA3LzcvMjMgMDU6MjgsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6
Cj4KPgo+IE9uIDcvMy8yMyAxNzo1NywgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+PiBDdXJyZW50
bHksIHRoZXJlJ3Mgbm8gbWVjaGFuaXNtIHRvIG1hcCBhbmQgdW5tYXAgc2VnbWVudHMgdG8gdGhl
IGtpbWFnZQo+PiBzdHJ1Y3R1cmUuwqAgVGhpcyBmdW5jdGlvbmFsaXR5IGlzIG5lZWRlZCB3aGVu
IGRlYWxpbmcgd2l0aCBtZW1vcnkgCj4+IHNlZ21lbnRzCj4+IGluIHRoZSBjb250ZXh0IG9mIGEg
a2V4ZWMgb3BlcmF0aW9uLgo+Pgo+PiBUaGUgcGF0Y2ggYWRkcyB0d28gbmV3IGZ1bmN0aW9uczog
a2ltYWdlX21hcF9zZWdtZW50KCkgYW5kCj4+IGtpbWFnZV91bm1hcF9zZWdtZW50KCkuCj4+Cj4+
IEltcGxlbWVudCBraW1hZ2VfbWFwX3NlZ21lbnQoKSB3aGljaCB0YWtlcyBhIGtpbWFnZSBwb2lu
dGVyLCBhbiBhZGRyZXNzLAo+PiBhbmQgYSBzaXplLsKgIEVuc3VyZXMgdGhhdCB0aGUgZW50aXJl
IHNlZ21lbnQgaXMgYmVpbmcgbWFwcGVkIGJ5IAo+PiBjb21wYXJpbmcKPj4gdGhlIGdpdmVuIGFk
ZHJlc3MgYW5kIHNpemUgdG8gZWFjaCBzZWdtZW50IGluIHRoZSBraW1hZ2UncyBzZWdtZW50IAo+
PiBhcnJheS4KPj4gQ29sbGVjdCB0aGUgc291cmNlIHBhZ2VzIHRoYXQgY29ycmVzcG9uZCB0byB0
aGUgZ2l2ZW4gYWRkcmVzcyByYW5nZSwKPj4gYWxsb2NhdGUgYW4gYXJyYXkgb2YgcG9pbnRlcnMg
dG8gdGhlc2UgcGFnZXMsIGFuZCBtYXAgdGhlbSB0byBhIAo+PiBjb250aWd1b3VzCj4+IHJhbmdl
IG9mIHZpcnR1YWwgYWRkcmVzc2VzLsKgIElmIHRoZSBtYXBwaW5nIG9wZXJhdGlvbiBpcyBzdWNj
ZXNzZnVsLCB0aGUKPj4gZnVuY3Rpb24gcmV0dXJucyB0aGUgc3RhcnQgb2YgdGhpcyByYW5nZS7C
oCBPdGhlcndpc2UsIGl0IGZyZWVzIHRoZSBwYWdlCj4+IHBvaW50ZXIgYXJyYXkgYW5kIHJldHVy
bnMgTlVMTC4KPj4KPj4gSW1wbGVtZW50IGtpbWFnZV91bm1hcF9zZWdtZW50KCkgdGhhdCB0YWtl
cyBhIHBvaW50ZXIgdG8gYSBzZWdtZW50IAo+PiBidWZmZXIKPj4gYW5kIHVubWFwcyBpdCB1c2lu
ZyB2dW5tYXAoKS4KPj4KPj4gRmluYWxseSwgbW92ZSBmb3JfZWFjaF9raW1hZ2VfZW50cnkoKSBt
YWNybyB0byBrZXhlYy5oLgo+Pgo+PiBOb3RlOiBVc2Uga2ltYWdlX21hcF9zZWdtZW50KCkgYW5k
IGtpbWFnZV91bm1hcF9zZWdtZW50KCkgY2FyZWZ1bGx5IHRvCj4+IGF2b2lkIG1lbW9yeSBsZWFr
cyBhbmQgZW5zdXJlIHRoYXQgYWxsIG1hcHBlZCBzZWdtZW50cyBhcmUgcHJvcGVybHkKPj4gdW5t
YXBwZWQgd2hlbiB0aGV5J3JlIG5vIGxvbmdlciBuZWVkZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IFR1c2hhciBTdWdhbmRoaSA8dHVzaGFyc3VAbGludXgubWljcm9zb2Z0LmNvbT4KPgo+PiArCj4+
ICvCoMKgwqAgaSA9IDA7Cj4+ICvCoMKgwqAgZm9yX2VhY2hfa2ltYWdlX2VudHJ5KGltYWdlLCBw
dHIsIGVudHJ5KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZW50cnkgJiBJTkRfREVTVElOQVRJ
T04pCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc3RfcGFnZV9hZGRyID0gZW50cnkgJiBQ
QUdFX01BU0s7Cj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlIGlmIChlbnRyeSAmIElORF9TT1VSQ0Up
IHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRlc3RfcGFnZV9hZGRyID49IGFkZHIg
JiYgZGVzdF9wYWdlX2FkZHIgPCBlYWRkcikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNyY19wYWdlX2FkZHIgPSBlbnRyeSAmIFBBR0VfTUFTSzsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzcmNfcGFnZXNbaSsrXSA9IHBoeXNfdG9fcGFnZShzcmNfcGFn
ZV9hZGRyKTsKPgo+IFNpbmNlIHBoeXNfdG9fcGFnZSBpcyBub3QgZGVmaW5lZCBvbiBtYW55L21v
c3QgYXJjaGl0ZWN0dXJlcyBJIGNoYW5nZSAKPiBpdCBmb3IgcHBjNjQgYW5kIGhhdmUgc3VjY2Vz
c2Z1bGx5IHVzZWQgdGhlIGZvbGxvd2luZzoKPgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjX3BhZ2VzW2krK10gPSAKPiB2
aXJ0X3RvX3BhZ2UoX192YShzcmNfcGFnZV9hZGRyKSkKPgo+Cj4gQWZ0ZXIgc2V2ZXJhbCBrZXhl
Y3MgdGhlIGZvbGxvd2luZyBjaGVjayBzdGlsbCB3b3JrczoKPgo+ICMgZXZtY3RsIGltYV9tZWFz
dXJlbWVudCAtLWlnbm9yZS12aW9sYXRpb25zIAo+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9i
aW5hcnlfcnVudGltZV9tZWFzdXJlbWVudHMKPiBNYXRjaGVkIHBlciBUUE0gYmFuayBjYWxjdWxh
dGVkIGRpZ2VzdChzKS4KPgo+Cj4gwqDCoCBTdGVmYW4KVGhhbmsgeW91IHNvIG11Y2ggU3RlZmFu
IGZvciByZXZpZXdpbmcgdGhpcyBzZXJpZXMsIGFuZCBjYXRjaGluZyB0aGlzCmlzc3VlLsKgIEFy
ZSB5b3Ugc3VnZ2VzdGluZyBJIHNob3VsZCB1c2UgdmlydF90b19wYWdlIG9uIGFsbCBhcmNoaXRl
Y3R1cmVzCnVuY29uZGl0aW9uYWxseSwgb3IgdXNlIGl0IG9ubHkgd2hlbiBwaHlzX3RvX3BhZ2Ug
aXMgbm90IGF2YWlsYWJsZT8KCn5UdXNoYXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
