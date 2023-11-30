Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470B6C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QIxltMySJhvzGYvly2p1xTn0r4DUfiSE80DIBTW6vGQ=; b=twOwt+6Mq2YMtp
	zuTTt9/hi10m2NoELz691XsPkFqApda3UN18Cy1PVdBmARb0tPq9vr6skR5cRAayBTyuVNR0h+CdC
	jp+bUDevjV2qxT3FFkseMwdw0mmanT57au/mtN+34NPzxMUhR7OlN+ITmV90+rwhtxqzvqgNVxtyA
	izE0+2Y0EeJsjutU7c1eTCctJmMsQ3A0CPhfk5Rhg+5VDmbXhueIwB0JJ4ZCdjjKVpC6d3VMYUfFW
	y4Fp5GQ8Gjc3T8cu0Qi5pyKebVOk0dveO9LTPIjlq/2UjCh3/IsBVsIy3j7R7m4mQBCC0+TjWS5ek
	UjlPGBGNftTy6+ij6kUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8gyj-00AwxX-1b;
	Thu, 30 Nov 2023 13:21:17 +0000
Received: from mail-m6010.netease.com ([210.79.60.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8gyg-00Awwe-1x
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 13:21:16 +0000
Received: from [10.9.0.118] (unknown [211.103.144.18])
	by mail-m2838.qiye.163.com (Hmail) with ESMTPA id 57A6D3C00EC;
	Thu, 30 Nov 2023 21:20:57 +0800 (CST)
Message-ID: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
Date: Thu, 30 Nov 2023 21:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUsYVkoYQh9CS0IfSkNKSlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTUNMTE9VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c2063c1748420kuqw57a6d3c00ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Izo5LDE4CRkMEy0aMTAv
	SUowC0hVSlVKTEtKSE5LT05DSElPVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFPTk1ONwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_052114_893873_457ECF93 
X-CRM114-Status: GOOD (  18.69  )
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

Ck9uIDIwMjMvMTEvMzAgMTU6NDQsIEJhb3F1YW4gSGUgd3JvdGU6Cj4gT24gMTEvMjcvMjMgYXQg
MTA6NTZhbSwgZnVxaWFuZyB3YW5nIHdyb3RlOgo+PiBXaGVuIHRoZSBzcGxpdCBoYXBwZW5lZCwg
anVkZ2Ugd2hldGhlciBtZW0tPm5yX3JhbmdlcyBpcyBlcXVhbCB0bwo+PiBtZW0tPm1heF9ucl9y
YW5nZXMuIElmIGl0IGlzIHRydWUsIHJldHVybiAtRU5PTUVNLgo+Pgo+PiBUaGUgYWR2YW50YWdl
IG9mIGRvaW5nIHRoaXMgaXMgdGhhdCBpdCBjYW4gYXZvaWQgYXJyYXkgYm91bmRzIGNhdXNlZCBi
eQo+PiBzb21lIGJ1Z3MuIEUuZy4sIEJlZm9yZSBjb21taXQgNDgzMWJlNzAyYjk1ICgiYXJtNjQv
a2V4ZWM6IEZpeCBtaXNzaW5nCj4+IGV4dHJhIHJhbmdlIGZvciBjcmFzaGtyZXNfbG93LiIpLCBy
ZXNlcnZlIGJvdGggaGlnaCBhbmQgbG93IG1lbW9yaWVzIGZvcgo+PiB0aGUgY3Jhc2hrZXJuZWwg
bWF5IGNhdXNlIG91dCBvZiBib3VuZHMuCj4+Cj4+IE9uIHRoZSBvdGhlciBoYW5kLCBtb3ZlIHRo
aXMgY29kZSBiZWZvcmUgdGhlIHNwbGl0IHRvIGVuc3VyZSB0aGF0IHRoZQo+PiBhcnJheSB3aWxs
IG5vdCBiZSBjaGFuZ2VkIHdoZW4gcmV0dXJuIGVycm9yLgo+IElmIG91dCBvZiBhcnJheSBib3Vu
ZGFyeSBpcyBjYXVzZWQsIG1lYW5zIHRoZSBsYW9kaW5nIGZhaWxlZCwgd2hldGhlcgo+IHRoZSBv
dXQgb2YgYm91bmRhcnkgaGFwcGVuZWQgb3Igbm90LiBJIGRvbid0IHNlZSBob3cgdGhpcyBjb2Rl
IGNoYW5nZQo+IG1ha2VzIHNlbnNlLiBEbyBJIG1pc3MgYW55dGhpbmc/Cj4KPiBUaGFua3MKPiBC
YW9xdWFuCj4KSGkgYmFvcXVhbiwKCkluIHNvbWUgY29uZmlndXJhdGlvbnMsIG91dCBvZiBib3Vu
ZHMgbWF5IG5vdCBjYXVzZSBjcmFzaF9leGNsdWRlX21lbV9yYW5nZSgpCnJldHVybnMgZXJyb3Is
IHRoZW4gdGhlIGxvYWQgd2lsbCBzdWNjZWVkLgoKRS5nLgpUaGVyZSBpcyBhIGNtZW0gYmVmb3Jl
IGV4ZWN1dGUgY3Jhc2hfZXhjbHVkZV9tZW1fcmFuZ2UoKToKCiDCoCBjbWVtID0gewogwqDCoMKg
IG1heF9ucl9yYW5nZXMgPSAzCiDCoMKgwqAgbnJfcmFuZ2VzID0gMgogwqDCoMKgIHJhbmdlcyA9
IHsKIMKgwqDCoMKgwqDCoCB7c3RhcnQgPSAxLMKgwqDCoMKgwqAgZW5kID0gMTAwMH0KIMKgwqDC
oMKgwqDCoCB7c3RhcnQgPSAxMDAxLMKgwqDCoCBlbmQgPSAyMDAwfQogwqDCoMKgIH0KIMKgIH0K
CkFmdGVyIGV4ZWN1dGluZyB0d2ljZSBjcmFzaF9leGNsdWRlX21lbV9yYW5nZSgpIHdpdGggdGhl
IHN0YXJ0L2VuZCBwYXJhbXMKMTAwLzIwMCwgMzAwLzQwMCByZXNwZWN0aXZlbHksIHRoZSBjbWVt
IHdpbGwgYmU6CgogwqAgY21lbSA9IHsKIMKgwqDCoCBtYXhfbnJfcmFuZ2VzID0gMwogwqDCoMKg
IG5yX3JhbmdlcyA9IDTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8PT0g
bnJfcmFuZ2VzID4gbWF4X25yX3JhbmdlcwogwqDCoMKgIHJhbmdlcyA9IHsKIMKgwqDCoMKgwqAg
e3N0YXJ0ID0gMSzCoMKgwqDCoMKgwqAgZW5kID0gOTnCoCB9CiDCoMKgwqDCoMKgIHtzdGFydCA9
IDIwMSzCoMKgwqDCoCBlbmQgPSAyOTkgfQogwqDCoMKgwqDCoCB7c3RhcnQgPSA0MDEswqDCoMKg
wqAgZW5kID0gMTAwMH0KIMKgwqDCoMKgwqAge3N0YXJ0ID0gMTAwMSzCoMKgwqAgZW5kID0gMjAw
MH3CoCA8PT0gT1VUIE9GIEJPVU5EUwogwqDCoMKgIH0KIMKgIH0KCldoZW4gYW4gb3V0IG9mIGJv
dW5kcyBvY2N1cnMgZHVyaW5nIHRoZSBzZWNvbmQgZXhlY3V0aW9uLCB0aGUgZnVuY3Rpb24gd2ls
bCBub3QKcmV0dXJuIGVycm9yLgoKQWRkaXRpb25hbGx5LCB3aGVuIHRoZSBmdW5jdGlvbiByZXR1
cm5zIGVycm9yLCBtZWFucyB0aGUgbG9hZCBmYWlsZWQuIEl0IHNlZW1zCm1lYW5pbmdsZXNzIHRv
IGtlZXAgdGhlIG9yaWdpbmFsIGRhdGEgdW5jaGFuZ2VkLiBCdXQgaW4gbXkgb3BpbmlvbiwgdGhp
cyB3aWxsCm1ha2UgdGhpcyBmdW5jdGlvbiBtb3JlIHJpZ29yb3VzIGFuZCBtb3JlIHZlcnNhdGls
ZS4gKEhvd2V2ZXIsIEkgYW0gbm90IHN1cmUgaWYKaXQgaXMgc2VsZi1kZWZlYXRpbmcgYW5kIEkg
aG9wZSB0byByZWNlaXZlIG1vcmUgc3VnZ2VzdGlvbnMpLgoKVGhhbmtzCmZ1cWlhbmcKCgo+PiBT
aWduZWQtb2ZmLWJ5OiBmdXFpYW5nIHdhbmcgPGZ1cWlhbmcud2FuZ0BlYXN5c3RhY2suY24+Cj4+
IC0tLQo+PiAgIGtlcm5lbC9jcmFzaF9jb3JlLmMgfCA2ICsrKy0tLQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvY3Jhc2hfY29yZS5jIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+PiBpbmRleCBlZmU4N2Q1
MDFjOGMuLmZmZGMyNDZjZjQyNSAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+
PiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+IEBAIC02MTEsNiArNjExLDkgQEAgaW50IGNy
YXNoX2V4Y2x1ZGVfbWVtX3JhbmdlKHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwKPj4gICAJCX0KPj4g
ICAKPj4gICAJCWlmIChwX3N0YXJ0ID4gc3RhcnQgJiYgcF9lbmQgPCBlbmQpIHsKPj4gKwkJCS8q
IFNwbGl0IGhhcHBlbmVkICovCj4+ICsJCQlpZiAobWVtLT5ucl9yYW5nZXMgPT0gbWVtLT5tYXhf
bnJfcmFuZ2VzKQo+PiArCQkJCXJldHVybiAtRU5PTUVNOwo+PiAgIAkJCS8qIFNwbGl0IG9yaWdp
bmFsIHJhbmdlICovCj4+ICAgCQkJbWVtLT5yYW5nZXNbaV0uZW5kID0gcF9zdGFydCAtIDE7Cj4+
ICAgCQkJdGVtcF9yYW5nZS5zdGFydCA9IHBfZW5kICsgMTsKPj4gQEAgLTYyNiw5ICs2MjksNiBA
QCBpbnQgY3Jhc2hfZXhjbHVkZV9tZW1fcmFuZ2Uoc3RydWN0IGNyYXNoX21lbSAqbWVtLAo+PiAg
IAlpZiAoIXRlbXBfcmFuZ2UuZW5kKQo+PiAgIAkJcmV0dXJuIDA7Cj4+ICAgCj4+IC0JLyogU3Bs
aXQgaGFwcGVuZWQgKi8KPj4gLQlpZiAoaSA9PSBtZW0tPm1heF9ucl9yYW5nZXMgLSAxKQo+PiAt
CQlyZXR1cm4gLUVOT01FTTsKPj4gICAKPj4gICAJLyogTG9jYXRpb24gd2hlcmUgbmV3IHJhbmdl
IHNob3VsZCBnbyAqLwo+PiAgIAlqID0gaSArIDE7Cj4+IC0tIAo+PiAyLjQyLjAKPj4KPj4KPj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4ga2V4ZWMg
bWFpbGluZyBsaXN0Cj4+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+PgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
