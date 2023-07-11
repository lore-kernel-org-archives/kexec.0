Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D7EB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bFOmis62PzWQ96ZWjqac+GEkkULZOWhGsiC628B5fc0=; b=B4rbRe/R8ru1a6
	f67opJUUJzw4V50PcgKYRidJrPKNwQQmhhbCvSi7gm6ZJD987liNN5mLzM21qcE5t2zmtotS/otSJ
	3vF4Qy9K9pB7Opty3gnyhFcgTbsyJkhJ3u4SOrahHnqwDHvvWF/5SRpO2KfGPQiB+BCIRnneMluAW
	fQQyQpEnHnnXNApkwQHETPb+Fte6FD/vBMOR5LwSOMqTeGMPJeqLKvIew3sAToLfDJhEps2xGudfy
	4BghnwvYJMTp/VL2O1R7+czgKc3hJSZ0pAnvUE1oQDDMQAQOwdT8uLDce4CwyTKCh7BbfW5JqkyIC
	+CqA31vz/VfDGysZnh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJHdp-00FbdX-1b;
	Tue, 11 Jul 2023 17:59:13 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJHdn-00Fbcx-0J
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 17:59:12 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id F14F721C3A86;
	Tue, 11 Jul 2023 10:59:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F14F721C3A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689098350;
	bh=WSjxDjeKuh5YC4rclUlKkaHpQJmUGwQ/LPglD0lAajY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OOLpHPQ74J0/O6dlN6YUBT8yhJPxTahq8fK6vLAO9dDTS1LS0aF8OdHH7LDA+8Xxi
	 4KHrLIK+f/81HZ29Bxx/pu1wHQ8aN/iM+tTXV7rdqTgdWmx6fJsb/qvFIc2Hmhhpke
	 wShAU6RiKyaBW34uQRPtE1cHbaMIBA8stWK+3E2w=
Message-ID: <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
Date: Tue, 11 Jul 2023 10:59:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/10] ima: implement function to allocate buffer at kexec
 load
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
 <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_105911_158362_08F67648 
X-CRM114-Status: GOOD (  18.04  )
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

QWRkaW5nIEVyaWMgdG8gY2MuCgpPbiA3LzcvMjMgMDY6MDAsIE1pbWkgWm9oYXIgd3JvdGU6Cj4g
SGkgVHVzaGFyLAo+Cj4gT24gTW9uLCAyMDIzLTA3LTAzIGF0IDE0OjU3IC0wNzAwLCBUdXNoYXIg
U3VnYW5kaGkgd3JvdGU6Cj4+IElNQSBkb2VzIG5vdCBwcm92aWRlIGEgbWVjaGFuaXNtIHRvIGFs
bG9jYXRlIG1lbW9yeSBmb3IgSU1BIGxvZyBzdG9yYWdlCj4+IGR1cmluZyBrZXhlYyBvcGVyYXRp
b24uCj4gVGhlIElNQSBtZWFzdXJlbWVudCBsaXN0IGlzIGN1cnJlbnRseSBiZWluZyBjYXJyaWVk
IGFjcm9zcyBrZXhlYywgc28KPiBvYnZpb3VzbHkgYSBidWZmZXIgaXMgYmVpbmcgYWxsb2NhdGVk
IGZvciBpdC4gIElNQSBub3QgYWxsb2NhdGluZwo+IG1lbW9yeSBmb3IgdGhlIG1lYXN1cm1lbnQg
bGlzdCBpcyBub3QgdGhlIHByb2JsZW0gc3RhdGVtZW50LiAgUGxlYXNlCj4gY29uY2lzZWx5IHBy
b3ZpZGUgdGhlIHByb2JsZW0gc3RhdGVtZW50LCBleHBsYWluaW5nIHdoeSBJTUEgbmVlZHMgdG8K
PiBhbGxvY2F0ZSB0aGUgYnVmZmVyLgo+CkkgbWVhbnQgSU1BIGRvZXMgbm90IHByb3ZpZGUgc2Vw
YXJhdGUgZnVuY3Rpb25zIHRvIGFsbG9jYXRlIGJ1ZmZlciBhbmQKcG9wdWxhdGUgbWVhc3VyZW1l
bnRzLsKgIEJvdGggb3BlcmF0aW9ucyBhcmUgd3JhcHBlZCBpbiBhbiBhdG9taWMKaW1hX2R1bXBf
bWVhc3VyZW1lbnRfbGlzdCgpLgoKQXMgSSBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnQgaW4gdGhl
IGNvdmVyIGxldHRlciwgaWYgdGhlcmUgaXMgbm8gc3VjaAp0ZWNobmljYWwgbGltaXRhdGlvbiB0
byBhbGxvY2F0ZSB0aGUgYnVmZmVyIGFuZCBjb3B5IHRoZSBtZWFzdXJlbWVudHMgYXQKa2V4ZWMg
4oCYZXhlY3V0ZeKAmSDigJMgSSB3aWxsIG1ha2UgdGhlIG5lY2Vzc2FyeSBjb2RlIGNoYW5nZXMg
YW5kIHVwZGF0ZSB0aGUKYWJvdmUgbGluZSBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gYWNjb3Jk
aW5nbHkuCj4+IFRoZSBmdW5jdGlvbiBzaG91bGQgaGFuZGxlIHRoZSBzY2VuYXJpbyB3aGVyZQo+
PiB0aGUga2V4ZWMgbG9hZCBpcyBjYWxsZWQgbXVsdGlwbGUgdGltZXMuCj4gQ3VycmVudGx5IHRo
ZSBidWZmZXIgaXMgYmVpbmcgZnJlZWQgd2l0aCB0aGUga2V4ZWMgJ3VubG9hZCcuICBXaXRoIHRo
aXMKPiBwYXRjaCBJTUEgaXMgYWxsb2NhdGluZyBhIGJ1ZmZlciBmb3IgdGhlIG1lYXN1cmVtZW50
IGxpc3QsIHdoaWNoIG5lZWRzCj4gdG8gYmUgZnJlZWQgaW5kZXBlbmRlbnRseSBvZiB0aGUga2V4
ZWMgJ3VubG9hZCcuCklmIHdlIGVuZCB1cCBhbGxvY2F0aW5nIHRoZSBidWZmZXIgYXQga2V4ZWMg
4oCYZXhlY3V0ZeKAmSAod2hpY2ggcmVzdWx0cyBpbgpzb2Z0IGJvb3QgdG8gbmV4dCBLZXJuZWwp
IOKAkyBpcyBpdCB0ZWNobmljYWxseSBwb3NzaWJsZSB0aGF0CmtleGVjIOKAmHVubG9hZOKAmSBi
ZWluZyBjYWxsZWQgYWZ0ZXIgY2FsbGluZyBrZXhlYyDigJhleGVjdXRl4oCZPwoKSWYgbm90LCBz
aG91bGQgSSBzdGlsbCBmcmVlIHRoZSBidWZmZXIgYXQga2V4ZWMg4oCYdW5sb2Fk4oCZIGluIHRo
aXMKc2NlbmFyaW8/Cgp+VHVzaGFyCgoKPj4gSW1wbGVtZW50IGEgZnVuY3Rpb24gdG8gYWxsb2Nh
dGUgYnVmZmVyIG9mIHNpemUga2V4ZWNfc2VnbWVudF9zaXplIGF0Cj4+IGtleGVjIGxvYWQuICBJ
ZiB0aGUgYnVmZmVyIHdhcyBhbHJlYWR5IGFsbG9jYXRlZCwgZnJlZSB0aGF0IGJ1ZmZlciBhbmQK
Pj4gcmVhbGxvY2F0ZS4gIEZpbmFsbHksIGluaXRpYWxpaHplIGltYV9raGRyIHN0cnVjdC4KPj4K
Pj4gVGhlIHBhdGNoIG9wZXJhdGVzIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHNlZ21l
bnQgc2l6ZSBkb2VzIG5vdAo+PiBjaGFuZ2UgYmV0d2VlbiBrZXhlYyBsb2FkIGFuZCBleGVjdXRl
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1p
Y3Jvc29mdC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
