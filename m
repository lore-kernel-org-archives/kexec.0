Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B77C001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PfOLl0YyCn5jqmB8RCyNZ5aeI0tIgsQiMzFgBCVr+yA=; b=sFTPaWcSIcQQ6w
	+vkA+8XKUUZEgrvxAgpnhwjCSVNM+DcLCwjZLPElPGuRZ+YlBAWO/xDKf3D8gdg2U8Vwsw+vzDqHT
	S934cI/z6vDzhu/hbe4SxTb1DJGo5he0gifw7uJtrk33H+MIEG799p67NjJJ7kgmJ6onK0ltXzv+7
	ynZKg0fZbj1VLRO43a4ki0ULsl9Kq264G3mqEzqnzYyQQz9MXh8OTi0a7N5g47uS9JtsiVRJ1dw3b
	8wDKsO6HxrQJ7bn3Ao6a+4ptjZ/xSmsR8lfmYk6DoUqzrum6VPPbUfasnWtAnGW5nA+rmHvQY7Mlo
	uHGYrlwBah0KyJ/KEKNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwIj-002zkD-15;
	Fri, 20 Oct 2023 20:40:57 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtwIg-002zje-15
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 20:40:55 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id B838120B74C3;
	Fri, 20 Oct 2023 13:40:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B838120B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697834454;
	bh=Fjvqj0mR9iPDcKJM5SwXgcrUK9PszPvcdOUjUMyGwjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ku1pFCo8LR0Kbedb27GJ3UESz5JnWBNTcOsyFinhkkbCaWAUnZVVhM67vgEhgQoR0
	 2gsEJYV3Dq53sbClXMlF+y1qzXqKx+inc54CgrnEzlmp3MNS/kaO8l+97P/vgez7B9
	 WWBaa9Ekm+IYX/ZQX22cFZWS+JLd2UU8EWecWur8=
Message-ID: <01919978-183e-75dc-0060-123a036937be@linux.microsoft.com>
Date: Fri, 20 Oct 2023 13:40:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/7] ima: record log size at kexec load and execute
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-8-tusharsu@linux.microsoft.com>
 <50477765-05f3-9fc6-4e85-cd822d212d95@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <50477765-05f3-9fc6-4e85-cd822d212d95@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_134054_435778_B81BAAE8 
X-CRM114-Status: GOOD (  23.08  )
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
IDE0OjI2LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+IFRoZSB3aW5kb3cgYmV0d2VlbiBrZXhl
YyAnbG9hZCcgYW5kICdleGVjdXRlJyBjb3VsZCBiZSBhcmJpdHJhcmlseSBsb25nLgo+PiBFdmVu
IHdpdGggdGhlIGxhcmdlIGNodW5rIG9mIG1lbW9yeSBhbGxvY2F0ZWQgYXQga2V4ZWMgJ2xvYWQn
LCBpdCBtYXkKPj4gcnVuIG91dCB3aGljaCB3b3VsZCByZXN1bHQgaW4gbWlzc2luZyBldmVudHMg
aW4gSU1BIGxvZyBhZnRlciB0aGUgc3lzdGVtCj4+IHNvZnQgcmVib290cyB0byB0aGUgbmV3IEtl
cm5lbC7CoCBUaGlzIHdvdWxkIHJlc3VsdCBpbiBJTUEgbWVhc3VyZW1lbnRzCj4+IGdldHRpbmcg
b3V0IG9mIHN5bmMgd2l0aCB0aGUgVFBNIFBDUiBxdW90ZXMgd2hpY2ggd291bGQgcmVzdWx0IGlu
IHJlbW90ZQo+PiBhdHRlc3RhdGlvbiBmYWlsaW5nIGZvciB0aGF0IHN5c3RlbS7CoCBUaGVyZSBp
cyBjdXJyZW50bHkgbm8gd2F5IGZvciB0aGUKPj4gbmV3IEtlcm5lbCB0byBrbm93IGlmIHRoZSBJ
TUEgbG9nIFRQTSBQQ1IgcXVvdGUgb3V0IG9mIHN5bmMgcHJvYmxlbSBpcwo+PiBiZWNhdXNlIG9m
IHRoZSBtaXNzaW5nIG1lYXN1cmVtZW50cyBkdXJpbmcga2V4ZWMuCj4+Cj4+IERlZmluZSB0d28g
bmV3IElNQSBldmVudHMsICdrZXhlY19sb2FkJyBhbmQgJ2tleGVjX2V4ZWN1dGUnLCB0byBiZQo+
PiBtZWFzdXJlZCBhdCBrZXhlYyAnbG9hZCcgYW5kICdleGVjdXRlJyByZXNwZWN0aXZlbHkuCj4+
Cj4+IElNQSBtZWFzdXJlcyAnYm9vdF9hZ2dyZWdhdGUnIGFzIHRoZSBmaXJzdCBldmVudCB3aGVu
IHRoZSBzeXN0ZW0gYm9vdHMgLQo+PiBlaXRoZXIgY29sZCBib290IG9yIGtleGVjIHNvZnQgYm9v
dC7CoCBJbiBjYXNlIHdoZW4gdGhlIHN5c3RlbSBnb2VzCj4+IHRocm91Z2ggbXVsdGlwbGUgc29m
dCByZWJvb3RzLCB0aGUgbnVtYmVyIG9mICdib290X2FnZ3JlZ2F0ZScgZXZlbnRzIGluCj4+IElN
QSBsb2cgY29ycmVzcG9uZHMgdG8gdG90YWwgbnVtYmVyIG9mIGJvb3RzIChjb2xkIGJvb3QgcGx1
cyBtdWx0aXBsZQo+PiBrZXhlYyBzb2Z0IHJlYm9vdHMpLsKgIFdpdGggdGhpcyBjaGFuZ2UsIHRo
ZXJlIHdvdWxkIGJlIGFkZGl0aW9uYWwKPj4gJ2tleGVjX2xvYWQnIGFuZCAna2V4ZWNfZXhlY3V0
ZScgZXZlbnRzIGluIGJldHdlZW4gdGhlIHR3bwo+PiAnYm9vdF9hZ2dyZWdhdGUnIGV2ZW50cy7C
oCBJbiByYXJlIGNhc2VzLCB3aGVuIHRoZSBzeXN0ZW0gcnVucyBvdXQgb2YKPj4gbWVtb3J5IGR1
cmluZyBrZXhlYyBzb2Z0IHJlYm9vdCwgJ2tleGVjX2V4ZWN1dGUnIHdvbid0IGJlIGNvcGllZCBz
aW5jZQo+PiBpdHMgb25lIG9mIHRoZSB2ZXJ5IGxhc3QgZXZlbnQgbWVhc3VyZWQganVzdCBiZWZv
cmUga2V4ZWMgc29mdCByZWJvb3QuCj4+IFRoZSBhYnNlbmNlIG9mIHRoZSBldmVudCAna2V4ZWNf
ZXhlY3V0ZScgaW4gYmV0d2VlbiB0aGUgdHdvCj4+IGJvb3RfYWdncmVnYXRlJyBldmVudHMgd291
bGQgc2lnbmFsIHRoZSBhdHRlc3RhdGlvbiBzZXJ2aWNlIHRoYXQgdGhlIElNQQo+PiBsb2cgb24g
dGhlIHN5c3RlbSBpcyBvdXQgb2Ygc3luYyB3aXRoIFRQTSBQQ1IgcXVvdGVzIGFuZCB0aGUgc3lz
dGVtIG5lZWRzCj4+IHRvIGJlIGNvbGQgYm9vdGVkIGZvciB0aGUgcmVtb3RlIGF0dGVzdGF0aW9u
IHRvIHN1Y2NlZWQgYWdhaW4uCj4+Cj4+Cj4+IEBAIC0xOTgsNiArMjA4LDcgQEAgdm9pZCBpbWFf
YWRkX2tleGVjX2J1ZmZlcihzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4gwqAgc3RhdGljIGludCBp
bWFfdXBkYXRlX2tleGVjX2J1ZmZlcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnNlbGYsCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhY3Rp
b24sIHZvaWQgKmRhdGEpCj4+IMKgIHsKPj4gK8KgwqDCoCBjaGFyIGltYV9rZXhlY19ldmVudFtJ
TUFfS0VYRUNfRVZFTlRfTEVOXTsKPj4gwqDCoMKgwqDCoCB2b2lkICpidWYgPSBOVUxMOwo+PiDC
oMKgwqDCoMKgIHNpemVfdCBidWZfc2l6ZTsKPj4gwqDCoMKgwqDCoCBib29sIHJlc3VtZSA9IGZh
bHNlOwo+PiBAQCAtMjEzLDkgKzIyNCwzMSBAQCBzdGF0aWMgaW50IGltYV91cGRhdGVfa2V4ZWNf
YnVmZmVyKHN0cnVjdCAKPj4gbm90aWZpZXJfYmxvY2sgKnNlbGYsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gTk9USUZZX09LOwo+PiDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCBidWZfc2l6
ZSA9IGltYV9nZXRfYmluYXJ5X3J1bnRpbWVfc2l6ZSgpOwo+PiArwqDCoMKgIHNjbnByaW50Zihp
bWFfa2V4ZWNfZXZlbnQsIElNQV9LRVhFQ19FVkVOVF9MRU4sCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgImtleGVjX3NlZ21lbnRfc2l6ZT0lbHU7aW1hX2JpbmFyeV9ydW50aW1lX3NpemU9JWx1OyIs
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAga2V4ZWNfc2VnbWVudF9zaXplLCBidWZfc2l6ZSk7Cj4+
ICsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBUaGlzIGlzIG9uZSBvZiB0aGUgdmVyeSBs
YXN0IGV2ZW50cyBtZWFzdXJlZCBieSBJTUEgYmVmb3JlIGtleGVjCj4+ICvCoMKgwqDCoCAqIHNv
ZnQgcmVib290aW5nIGludG8gdGhlIG5ldyBLZXJuYWwuCj4+ICvCoMKgwqDCoCAqIFRoaXMgZXZl
bnQgY2FuIGJlIHVzZWQgYXMgYSBtYXJrZXIgYWZ0ZXIgdGhlIHN5c3RlbSBzb2Z0IHJlYm9vdHMK
Pj4gK8KgwqDCoMKgICogdG8gdGhlIG5ldyBLZXJuZWwgdG8gY2hlY2sgaWYgdGhlcmUgd2FzIHN1
ZmZpY2llbnQgbWVtb3J5IAo+PiBhbGxvY2F0ZWQKPj4gK8KgwqDCoMKgICogYXQga2V4ZWMgJ2xv
YWQnIHRvIGNhcHR1cmUgdGhlIGV2ZW50cyBtZWFzdXJlZCBiZXR3ZWVuIHRoZSB3aW5kb3cKPj4g
K8KgwqDCoMKgICogb2Yga2V4ZWMgJ2xvYWQnIGFuZCAnZXhlY3V0ZScuCj4+ICvCoMKgwqDCoCAq
IFRoaXMgZXZlbnQgbmVlZHMgdG8gYmUgcHJlc2VudCBpbiB0aGUgSU1BIGxvZywgaW4gYmV0d2Vl
biB0aGUgdHdvCj4+ICvCoMKgwqDCoCAqICdib290X2FnZ3JlZ2F0ZScgZXZlbnRzIHRoYXQgYXJl
IGxvZ2dlZCBmb3IgdGhlIHByZXZpb3VzIGJvb3QgYW5kCj4+ICvCoMKgwqDCoCAqIHRoZSBjdXJy
ZW50IHNvZnQgcmVib290LiBJZiBpdCBpcyBub3QgcHJlc2VudCBhZnRlciB0aGUgc3lzdGVtIAo+
PiBzb2Z0Cj4+ICvCoMKgwqDCoCAqIHJlYm9vdHMgaW50byB0aGUgbmV3IEtlcm5lbCwgaXQgd291
bGQgbWVhbiB0aGUgSU1BIGxvZyBpcyBub3QKPj4gK8KgwqDCoMKgICogY29uc2lzdGVudCB3aXRo
IHRoZSBUUE0gUENSIHF1b3RlcywgYW5kIHRoZSBzeXN0ZW0gbmVlZHMgdG8gYmUKPj4gK8KgwqDC
oMKgICogY29sZC1ib290ZWQgZm9yIHRoZSBhdHRlc3RhdGlvbiB0byBzdWNjZWVkIGFnYWluLgo+
PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBpbWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCJpbWFf
a2V4ZWMiLCAia2V4ZWNfZXhlY3V0ZSIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGltYV9rZXhlY19ldmVudCwgc3RybGVuKGltYV9rZXhlY19ldmVudCksCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhbHNlLCBOVUxMLCAwKTsKPj4gKwo+PiDC
oMKgwqDCoMKgIGltYV9tZWFzdXJlbWVudHNfc3VzcGVuZCgpOwo+PiAtwqDCoMKgIGJ1Zl9zaXpl
ID0gaW1hX2dldF9iaW5hcnlfcnVudGltZV9zaXplKCk7Cj4gCj4gVGhpcyBzaG91bGQgYmUgcmVt
b3ZlZCBlYXJsaWVyLCBpbiAyLzcuCj4gCj4gCj4gCkFncmVlZC4gV2lsbCBkby4KCn5UdXNoYXIK
Cj4+IMKgwqDCoMKgwqAgcmV0ID0gaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgmYnVmX3NpemUs
ICZidWYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXhl
Y19zZWdtZW50X3NpemUpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
