Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E533C001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O3Zfq3xT/ODsDLsn6jB2w2z0e316SJy4FsUhuQisoXo=; b=jVXgAWiGfocwNy
	SuypbUGTGiR7T+Kg742WW9B6B0AuzdQYs2kMvXLJJ+D98AT4fl1fU8g0TfeJ3GqMiiDkbo1h9KZVs
	EfhxZuLObGRRqhmkZYvyijt9YPbGO+/GTprSR5HYPlZNHsOQWg5ruXPOXYFxPAIA01ZjJcNV4S2Mt
	d2mYsZp+UKUrAv//1Uk4LEsr9JyHweQvq9LARRfAbHnMrf+SySlQJ83oxcUXDAglDTIzb9sGSNgzP
	WkXs4fG8Ke9IDYlOPVEC5GzC9KDYA8ziRThyN7ghIaXcixYrVdLYeeKb4m/na+IE4XqYBCMIRYb/9
	g4hipp6UVakEuw3J0dWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwHV-002zcE-2f;
	Fri, 20 Oct 2023 20:39:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwHT-002zbs-0Z
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 20:39:40 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 125D020B74C3;
	Fri, 20 Oct 2023 13:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 125D020B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697834378;
	bh=nUkytYBweex8FSgiBNfhqS2Sgayb8/6IvaMM7FHfpuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rhia76cNBiD4gCSlrI5nPiVXjYyRYpSd1a606ghhKEF+3VR0DhHlY5P592bT5PrLI
	 Y7qDls4yaoOq8fmRYVPxG22lfsmf6zKXhF1QhTFpK3V3zX7cEx0ratVQoDKM6MKiwd
	 r8DzH2CRK3MVkPWVWUEuINinPQgHSZTglkT0rz4c=
Message-ID: <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
Date: Fri, 20 Oct 2023 13:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_133939_257183_25C2A72F 
X-CRM114-Status: GOOD (  19.96  )
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

CgpPbiAxMC8xMi8yMyAxNzoyNywgU3RlZmFuIEJlcmdlciB3cm90ZToKPiAKPiBPbiAxMC81LzIz
IDE0OjI2LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+IElNQSBjdXJyZW50bHkgYWxsb2NhdGVz
IGhhbGYgYSBQQUdFX1NJWkUgZm9yIHRoZSBleHRyYSBldmVudHMgdGhhdCB3b3VsZAo+PiBiZSBt
ZWFzdXJlZCBiZXR3ZWVuIGtleGVjICdsb2FkJyBhbmQgJ2V4ZWN1dGUnLsKgIERlcGVuZGluZyBv
biB0aGUgSU1BCj4+IHBvbGljeSBhbmQgdGhlIHN5c3RlbSBzdGF0ZSwgdGhhdCBtZW1vcnkgbWF5
IG5vdCBiZSBzdWZmaWNpZW50IHRvIGhvbGQKPj4gdGhlIGV4dHJhIElNQSBldmVudHMgbWVhc3Vy
ZWQgYWZ0ZXIga2V4ZWMgJ2xvYWQnLsKgIFRoZSBtZW1vcnkKPj4gcmVxdWlyZW1lbnRzIHZhcnkg
ZnJvbSBzeXN0ZW0gdG8gc3lzdGVtIGFuZCB0aGV5IHNob3VsZCBiZSBjb25maWd1cmFibGUuCj4+
Cj4+IERlZmluZSBhIEtjb25maWcgb3B0aW9uLCBJTUFfS0VYRUNfRVhUUkFfUEFHRVMsIHRvIGNv
bmZpZ3VyZSB0aGUgbnVtYmVyCj4+IG9mIGV4dHJhIHBhZ2VzIHRvIGJlIGFsbG9jYXRlZCBmb3Ig
SU1BIG1lYXN1cmVtZW50cyBhZGRlZCBpbiB0aGUgd2luZG93Cj4+IGZyb20ga2V4ZWMgJ2xvYWQn
IHRvIGtleGVjICdleGVjdXRlJy4KPj4KPj4gVXBkYXRlIGltYV9hZGRfa2V4ZWNfYnVmZmVyKCkg
ZnVuY3Rpb24gdG8gYWxsb2NhdGUgbWVtb3J5IGJhc2VkIG9uIHRoZQo+PiBLY29uZmlnIG9wdGlv
biB2YWx1ZSwgcmF0aGVyIHRoYW4gdGhlIGN1cnJlbnRseSBoYXJkY29kZWQgb25lLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGk8dHVzaGFyc3VAbGludXgubWljcm9zb2Z0LmNv
bT4KPj4gLS0tCj4+IMKgIHNlY3VyaXR5L2ludGVncml0eS9pbWEvS2NvbmZpZ8KgwqDCoMKgIHzC
oCA5ICsrKysrKysrKwo+PiDCoCBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jIHwg
MTMgKysrKysrKystLS0tLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L0tjb25maWcgCj4+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29uZmlnCj4+IGluZGV4IDYw
YTUxMWM2YjU4My4uMWI1NWNkMmJjYjM2IDEwMDY0NAo+PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL0tjb25maWcKPj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29uZmlnCj4+
IEBAIC0zMzgsMyArMzM4LDEyIEBAIGNvbmZpZyBJTUFfRElTQUJMRV9IVEFCTEUKPj4gwqDCoMKg
wqDCoCBkZWZhdWx0IG4KPj4gwqDCoMKgwqDCoCBoZWxwCj4+IMKgwqDCoMKgwqDCoMKgwqAgVGhp
cyBvcHRpb24gZGlzYWJsZXMgaHRhYmxlIHRvIGFsbG93IG1lYXN1cmVtZW50IG9mIGR1cGxpY2F0
ZSAKPj4gcmVjb3Jkcy4KPj4gKwo+PiArY29uZmlnIElNQV9LRVhFQ19FWFRSQV9QQUdFUwo+PiAr
wqDCoMKgIGludAo+PiArwqDCoMKgIGRlcGVuZHMgb24gSU1BICYmIElNQV9LRVhFQwo+PiArwqDC
oMKgIGRlZmF1bHQgMTYKPj4gK8KgwqDCoCBoZWxwCj4+ICvCoMKgwqDCoMKgIElNQV9LRVhFQ19F
WFRSQV9QQUdFUyBkZXRlcm1pbmVzIHRoZSBudW1iZXIgb2YgZXh0cmEKPj4gK8KgwqDCoMKgwqAg
cGFnZXMgdG8gYmUgYWxsb2NhdGVkIGZvciBJTUEgbWVhc3VyZW1lbnRzIGFkZGVkIGluIHRoZQo+
PiArwqDCoMKgwqDCoCB3aW5kb3cgZnJvbSBrZXhlYyAnbG9hZCcgdG8ga2V4ZWMgJ2V4ZWN1dGUn
Lgo+IAo+IAo+IE9uIHBwYzY0IGEgcGFnZSBpcyA2NGtiLiBJIHdvdWxkIGFzayBmb3IgYWRkaXRp
b25hbCBrYiBoZXJlLgo+IAo+IApOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuICBEbyB5b3UgbWVhbiBJ
IHNob3VsZCBtYWtlIHRoZSBkZWZhdWx0IHZhbHVlIG9mCnRoZSBjb25maWcgSU1BX0tFWEVDX0VY
VFJBX1BBR0VTIDY0IG9yIHNvbWV0aGluZz8KCkluIGNvZGUsIEkgbXVsdGlwbHkgdGhlIGNvbmZp
ZyB2YWx1ZSB3aXRoIFBBR0VfU0laRS4gIFNvIG1vcmUgbWVtb3J5CndvdWxkIGJlIGFsbG9jYXRl
ZCBvbiBwcGM2NCBmb3IgZ2l2ZW4gZGVmYXVsdCBjb25maWcgdmFsdWUuIENvdWxkIHlvdQpwbGVh
c2UgY2xhcmlmeSB3aGF0IGNoYW5nZSB5b3UgYXJlIHN1Z2dlc3RpbmcgaGVyZT8KCgorICAgICAg
ICBiaW5hcnlfcnVudGltZV9zaXplID0gaW1hX2dldF9iaW5hcnlfcnVudGltZV9zaXplKCkgKwor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgaW1hX2tleGVjX2hk
cikgKworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChDT05GSUdfSU1BX0tFWEVDX0VY
VFJBX1BBR0VTICoKUEFHRV9TSVpFKTsKCn5UdXNoYXIKCj4+IGRpZmYgLS1naXQgYS9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jIAo+PiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX2tleGVjLmMKPj4gaW5kZXggMTNmYmJiOTAzMTliLi42Y2Q1ZjQ2YTcyMDggMTAwNjQ0Cj4+
IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMKPj4gKysrIGIvc2VjdXJp
dHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYwo+PiBAQCAtMTUwLDE1ICsxNTAsMTggQEAgdm9p
ZCBpbWFfYWRkX2tleGVjX2J1ZmZlcihzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4gwqDCoMKgwqDC
oCBpbnQgcmV0Owo+PiDCoMKgwqDCoMKgIC8qCj4+IC3CoMKgwqDCoCAqIFJlc2VydmUgYW4gZXh0
cmEgaGFsZiBwYWdlIG9mIG1lbW9yeSBmb3IgYWRkaXRpb25hbCBtZWFzdXJlbWVudHMKPj4gLcKg
wqDCoMKgICogYWRkZWQgZHVyaW5nIHRoZSBrZXhlYyBsb2FkLgo+PiArwqDCoMKgwqAgKiBSZXNl
cnZlIGV4dHJhIG1lbW9yeSBmb3IgbWVhc3VyZW1lbnRzIGFkZGVkIGluIHRoZSB3aW5kb3cgZnJv
bQo+PiArwqDCoMKgwqAgKiBrZXhlYyAnbG9hZCcgdG8ga2V4ZWMgJ2V4ZWN1dGUnLgo+PiDCoMKg
wqDCoMKgwqAgKi8KPj4gLcKgwqDCoCBiaW5hcnlfcnVudGltZV9zaXplID0gaW1hX2dldF9iaW5h
cnlfcnVudGltZV9zaXplKCk7Cj4+ICvCoMKgwqAgYmluYXJ5X3J1bnRpbWVfc2l6ZSA9IGltYV9n
ZXRfYmluYXJ5X3J1bnRpbWVfc2l6ZSgpICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBpbWFfa2V4ZWNfaGRyKSArCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChDT05GSUdfSU1BX0tFWEVDX0VYVFJBX1BBR0VTICogUEFH
RV9TSVpFKTsKPj4gKwo+PiDCoMKgwqDCoMKgIGlmIChiaW5hcnlfcnVudGltZV9zaXplID49IFVM
T05HX01BWCAtIFBBR0VfU0laRSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGtleGVjX3NlZ21lbnRf
c2l6ZSA9IFVMT05HX01BWDsKPj4gwqDCoMKgwqDCoCBlbHNlCj4+IC3CoMKgwqDCoMKgwqDCoCBr
ZXhlY19zZWdtZW50X3NpemUgPSBBTElHTihpbWFfZ2V0X2JpbmFyeV9ydW50aW1lX3NpemUoKSAr
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQUdFX1NJ
WkUgLyAyLCBQQUdFX1NJWkUpOwo+PiArwqDCoMKgwqDCoMKgwqAga2V4ZWNfc2VnbWVudF9zaXpl
ID0gQUxJR04oYmluYXJ5X3J1bnRpbWVfc2l6ZSwgUEFHRV9TSVpFKTsKPj4gKwo+PiDCoMKgwqDC
oMKgIGlmICgoa2V4ZWNfc2VnbWVudF9zaXplID09IFVMT05HX01BWCkgfHwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgICgoa2V4ZWNfc2VnbWVudF9zaXplID4+IFBBR0VfU0hJRlQpID4gdG90YWxyYW1f
cGFnZXMoKSAvIDIpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoIkJpbmFyeSBtZWFz
dXJlbWVudCBsaXN0IHRvbyBsYXJnZS5cbiIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
