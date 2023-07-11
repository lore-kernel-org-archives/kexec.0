Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAEDEB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w9v5xvPYxlAwmtDJg4hO1DbIqFt3+IS+7VzZzFZhyyw=; b=PW5RivAINuiOGN
	fUUMGnX40wwcvyOEEULCE/4xQjP5cAI+qq53mrqGEmeIKjn1A1ReM0hAlf6ZtodH8Gno/hN3XSkKi
	ucrW+CCKSVA3P5cQQeoUtfFXJfyfPAkAA1sF3uRa5tzAblrS00J83aV4m0Aq9l4e9GbmlGEMrmsUI
	IFMWlLEG4TjDS3U2ZatI09VZiOIpBz4y1TqTn8DmRhCyt4ecvOH7Pl36pxFIaS4iNTnNaMyTCe9tS
	nw9dmOYGYLNAvVoA4ICTsdzGptmpppdCmxep0YI/5SC4mfJVJKzZBftrBHCZoRY8WXsoaE6+XzpjI
	Qot7tA19gcEyYMMCoxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIgG-00FiE5-2k;
	Tue, 11 Jul 2023 19:05:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIgD-00FiDb-0P
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 19:05:46 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11CFC21C3A93;
	Tue, 11 Jul 2023 12:05:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11CFC21C3A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689102341;
	bh=aXHvCmO1BUIQBJdEF8OxJU3dxNsm+38XW0FQsQwOeyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ib4/ZR/NX9Av/yoTigqzSwEE8+EgmmIjQx1iWiWsC9pjbKz642ZbX2vWBw4lYrCo0
	 xZi0aLZIslBFStWieMlwANpwdsGx6qN1+rVDHjm+cJhK0w2/+uD8m7xyKc1kUUEA+p
	 80wnKSeTW3gc99F9gmyGu1Y3F7CskJXZBORL08Is=
Message-ID: <192d4377-b714-b327-6b82-e445bca03bfc@linux.microsoft.com>
Date: Tue, 11 Jul 2023 12:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
 <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_120545_215582_9966FDA5 
X-CRM114-Status: GOOD (  14.80  )
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

QWRkaW5nIEVyaWMgdG8gY2MuCgpPbiA3LzcvMjMgMDg6MDEsIE1pbWkgWm9oYXIgd3JvdGU6Cj4g
SGkgVHVzaGFyLAo+Cj4gT24gTW9uLCAyMDIzLTA3LTAzIGF0IDE0OjU3IC0wNzAwLCBUdXNoYXIg
U3VnYW5kaGkgd3JvdGU6Cj4KPj4gKy8qCj4+ICsgKiBDYWxsZWQgZHVyaW5nIGtleGVjIGV4ZWN1
dGUgc28gdGhhdCBJTUEgY2FuIHVwZGF0ZSB0aGUgbWVhc3VyZW1lbnQgbGlzdC4KPj4gKyAqLwo+
PiArc3RhdGljIGludCBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlcihzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKnNlbGYsCj4+ICsJCQkJICAgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRhdGEpCj4+
ICt7Cj4+ICsJdm9pZCAqbmV3X2J1ZmZlciA9IE5VTEw7Cj4+ICsJc2l6ZV90IG5ld19idWZmZXJf
c2l6ZSwgY3VyX2J1ZmZlcl9zaXplOwo+PiArCWJvb2wgcmVzdW1lID0gZmFsc2U7Cj4+ICsKPj4g
KwlpZiAoIWtleGVjX2luX3Byb2dyZXNzKSB7Cj4+ICsJCXByX2luZm8oIiVzOiBObyBrZXhlYyBp
biBwcm9ncmVzcy5cbiIsIF9fZnVuY19fKTsKPj4gKwkJcmV0dXJuIE5PVElGWV9PSzsKPj4gKwl9
Cj4+ICsKPj4gKwlpZiAoIWltYV9rZXhlY19idWZmZXIpIHsKPj4gKwkJcHJfZXJyKCIlczogS2V4
ZWMgYnVmZmVyIG5vdCBzZXQuXG4iLCBfX2Z1bmNfXyk7Cj4+ICsJCXJldHVybiBOT1RJRllfT0s7
Cj4+ICsJfQo+PiArCj4+ICsJaW1hX21lYXN1cmVtZW50c19zdXNwZW5kKCk7Cj4+ICsKPj4gKwlj
dXJfYnVmZmVyX3NpemUgPSBrZXhlY19zZWdtZW50X3NpemUgLSBzaXplb2Yoc3RydWN0IGltYV9r
ZXhlY19oZHIpOwo+PiArCW5ld19idWZmZXJfc2l6ZSA9IGltYV9nZXRfYmluYXJ5X3J1bnRpbWVf
c2l6ZSgpOwo+PiArCWlmIChuZXdfYnVmZmVyX3NpemUgPiBjdXJfYnVmZmVyX3NpemUpIHsKPj4g
KwkJcHJfZXJyKCIlczogTWVhc3VyZW1lbnQgbGlzdCBncmV3IHRvbyBsYXJnZS5cbiIsIF9fZnVu
Y19fKTsKPj4gKwkJcmVzdW1lID0gdHJ1ZTsKPj4gKwkJZ290byBvdXQ7Cj4+ICsJfQo+IFRoaXMg
Y2hhbmdlcyB0aGUgY3VycmVudCBiZWhhdmlvciBvZiBjYXJyeWluZyBhcyBtYW55IG1lYXN1cmVt
ZW50cwo+IGFjcm9zcyBrZXhlYyBhcyBwb3NzaWJsZS4gIFRydWUgdGhlIG1lYXN1cmVtZW50IGxp
c3Qgd29uJ3QgdmVyaWZ5Cj4gYWdhaW5zdCB0aGUgVFBNIFBDUnMsIGJ1dCBub3QgY29weWluZyB0
aGUgbWVhc3VyZW1lbnRzIGxlYXZlcyB0aGUKPiBpbXByZXNzaW9uIHRoZXJlIHdlcmVuJ3QgYW55
IHByZXZpb3VzIG1lYXN1cmVtZW50cy4KPgo+IFRoaXMgYWxzbyBleHBsYWlucyB0aGUgcmVhc29u
IGZvciBhbGxvY2F0aW5nIGFuIElNQSBidWZmZXIgKHBhdGNoIDEvMTApCj4gYW5kIG5vdCB3cml0
aW5nIHRoZSBtZWFzdXJlbWVudHMgZGlyZWN0bHkgaW50byB0aGUga2V4ZWMgYnVmZmVyLgpUaGFu
a3MuCgpJIHdpbGwgdXBkYXRlIHRoaXMgbG9naWMgZGVwZW5kaW5nIGlmIHdlIGRlY2lkZSB0byB1
c2UKaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgpIGF0IGtleGVjIOKAmGV4ZWN1dGXigJksIG9y
IGNvbWJpbmF0aW9uIG9mCmltYV9hbGxvY2F0ZV9idWZfYXRfa2V4ZWNfbG9hZCgpIGFuZCBpbWFf
cG9wdWxhdGVfYnVmX2F0X2tleGVjX2V4ZWN1dGUoKQphdCBrZXhlYyDigJhsb2Fk4oCZIGFuZCBr
ZXhlYyDigJhleGVjdXRl4oCZIHJlc3BlY3RpdmVseS4KCn5UdXNoYXIKCj4+ICsJaW1hX3BvcHVs
YXRlX2J1Zl9hdF9rZXhlY19leGVjdXRlKCZuZXdfYnVmZmVyX3NpemUsICZuZXdfYnVmZmVyKTsK
Pj4gKwo+PiArCWlmICghbmV3X2J1ZmZlcikgewo+PiArCQlwcl9lcnIoIiVzOiBEdW1wIG1lYXN1
cmVtZW50cyBmYWlsZWQuXG4iLCBfX2Z1bmNfXyk7Cj4+ICsJCXJlc3VtZSA9IHRydWU7Cj4+ICsJ
CWdvdG8gb3V0Owo+PiArCX0KPj4gKwltZW1jcHkoaW1hX2tleGVjX2J1ZmZlciwgbmV3X2J1ZmZl
ciwgbmV3X2J1ZmZlcl9zaXplKTsKPj4gK291dDoKPj4gKwlraW1hZ2VfdW5tYXBfc2VnbWVudChp
bWFfa2V4ZWNfYnVmZmVyKTsKPj4gKwlpbWFfa2V4ZWNfYnVmZmVyID0gTlVMTDsKPj4gKwo+PiAr
CWlmIChyZXN1bWUpCj4+ICsJCWltYV9tZWFzdXJlbWVudHNfcmVzdW1lKCk7Cj4+ICsKPj4gKwly
ZXR1cm4gTk9USUZZX09LOwo+PiArfQo+PiArCj4+ICAgI2VuZGlmIC8qIElNQV9LRVhFQyAqLwo+
PiAgIAo+PiAgIC8qCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
