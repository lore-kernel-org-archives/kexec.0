Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90F1EB64DA
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nN1nBEfhyAL+sdNeg/+bLA5Gizz2813xGOgiJ5hSsrE=; b=Le+2b6yYkAKXAP
	pVQoJsseBuCCnCOFAJg723czf21WlfoZ+Sh0rC/5OPsWcnRt6j8lzbTufR3Hh8W9YmV2yELWqbZYI
	BlkLpX+fT5NLuUXjLPj6wcbORcppDeKcUue2vNsJov0K+oqRW4VAZzNSPEaCFy65yK4MoWDt4+AOg
	D0MAH4nixebFFfeFZHnx3sJSMFlYJwdTqS6B1RsX4/zgbsicDjlZqe94zPaDbBywjqRJ3kvNngVxE
	8RkzmcMMVt+DFYcUFlWOwW148LzwKobHtOKeWjiEWBHdpRPcWaR7Go7dpFlLfYB2yTaq2zSgx2J6w
	4VgmhnckaHb9fZ7wVI6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfqV-0012RS-2T;
	Wed, 12 Jul 2023 19:49:55 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfqT-0012Qi-0e
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 19:49:54 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1227E21C44E3;
	Wed, 12 Jul 2023 12:49:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1227E21C44E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689191392;
	bh=ViYk1dHUP0PzQJOj4xP3Ncph/FRmJwJ5E2AzHzwCZ+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=di63AnOmtZIPjP08PqwbuZ6NWzDZ0ShWal6MvmlVnmb2sz1/D5TagY7rU2nU9OC18
	 b6Cm6MP99R4OplFUTxJmpjQm1+7gsO7va0fohuCbj35zfrXAdpgrRpYehNu+Ahjiz9
	 N4KZdF2N11l6Yi/9XV6P4t/9rDgRJx5/a6Ea6y28=
Message-ID: <ea63d19e-af38-69a5-d253-3ba7fbeeca6c@linux.microsoft.com>
Date: Wed, 12 Jul 2023 12:49:51 -0700
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
 <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
 <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_124953_313859_7FC62472 
X-CRM114-Status: GOOD (  22.56  )
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

Ck9uIDcvMTEvMjMgMTQ6MTEsIE1pbWkgWm9oYXIgd3JvdGU6Cj4gT24gVHVlLCAyMDIzLTA3LTEx
IGF0IDEwOjU5IC0wNzAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+IEFkZGluZyBFcmljIHRv
IGNjLgo+Pgo+PiBPbiA3LzcvMjMgMDY6MDAsIE1pbWkgWm9oYXIgd3JvdGU6Cj4+PiBIaSBUdXNo
YXIsCj4+Pgo+Pj4gT24gTW9uLCAyMDIzLTA3LTAzIGF0IDE0OjU3IC0wNzAwLCBUdXNoYXIgU3Vn
YW5kaGkgd3JvdGU6Cj4+Pj4gSU1BIGRvZXMgbm90IHByb3ZpZGUgYSBtZWNoYW5pc20gdG8gYWxs
b2NhdGUgbWVtb3J5IGZvciBJTUEgbG9nIHN0b3JhZ2UKPj4+PiBkdXJpbmcga2V4ZWMgb3BlcmF0
aW9uLgo+Pj4gVGhlIElNQSBtZWFzdXJlbWVudCBsaXN0IGlzIGN1cnJlbnRseSBiZWluZyBjYXJy
aWVkIGFjcm9zcyBrZXhlYywgc28KPj4+IG9idmlvdXNseSBhIGJ1ZmZlciBpcyBiZWluZyBhbGxv
Y2F0ZWQgZm9yIGl0LiAgSU1BIG5vdCBhbGxvY2F0aW5nCj4+PiBtZW1vcnkgZm9yIHRoZSBtZWFz
dXJtZW50IGxpc3QgaXMgbm90IHRoZSBwcm9ibGVtIHN0YXRlbWVudC4gIFBsZWFzZQo+Pj4gY29u
Y2lzZWx5IHByb3ZpZGUgdGhlIHByb2JsZW0gc3RhdGVtZW50LCBleHBsYWluaW5nIHdoeSBJTUEg
bmVlZHMgdG8KPj4+IGFsbG9jYXRlIHRoZSBidWZmZXIuCj4+Pgo+PiBJIG1lYW50IElNQSBkb2Vz
IG5vdCBwcm92aWRlIHNlcGFyYXRlIGZ1bmN0aW9ucyB0byBhbGxvY2F0ZSBidWZmZXIgYW5kCj4+
IHBvcHVsYXRlIG1lYXN1cmVtZW50cy4gIEJvdGggb3BlcmF0aW9ucyBhcmUgd3JhcHBlZCBpbiBh
biBhdG9taWMKPj4gaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgpLgo+IE9rLgo+Cj4+IEFzIEkg
bWVudGlvbmVkIGluIHRoZSBjb21tZW50IGluIHRoZSBjb3ZlciBsZXR0ZXIsIGlmIHRoZXJlIGlz
IG5vIHN1Y2gKPj4gdGVjaG5pY2FsIGxpbWl0YXRpb24gdG8gYWxsb2NhdGUgdGhlIGJ1ZmZlciBh
bmQgY29weSB0aGUgbWVhc3VyZW1lbnRzIGF0Cj4+IGtleGVjIOKAmGV4ZWN1dGXigJkg4oCTIEkg
d2lsbCBtYWtlIHRoZSBuZWNlc3NhcnkgY29kZSBjaGFuZ2VzIGFuZCB1cGRhdGUgdGhlCj4+IGFi
b3ZlIGxpbmUgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGFjY29yZGluZ2x5Lgo+IFRoZSAibm9y
bWFsIiB3YXkgb2YgbWFraW5nIHRoaXMgdHlwZSBvZiBjaGFuZ2Ugd291bGQgYmUgdG8gc3BsaXQg
dGhlCj4gZXhpc3RpbmcgaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgpIGZ1bmN0aW9uLiAgQ29w
eWluZyB0aGUgbWVhc3VyZW1lbnQKPiBsaXN0IHdvdWxkIHN0aWxsIGJlIG5hbWVkIGltYV9kdW1w
X21lYXN1cmVtZW50X2xpc3QoKS4gIFRoZSBvdGhlciBjb3VsZAo+IGJlIG5hbWVkIGltYV9hbGxv
Y19rZXhlY19idWYoKS4gIEJvdGggZnVuY3Rpb25zIGluaXRpYWxseSB3b3VsZCBiZQo+IGNhbGxl
ZC4KPgpTb3VuZHMgZ29vZC7CoCBJIHdpbGwgbWFrZSB0aGF0IGNoYW5nZS4KSSB3aWxsIGRlZmlu
ZSBpbWFfYWxsb2Nfa2V4ZWNfYnVmKCkgdG8gYWxsb2NhdGUgbWVtb3J5IGF0IGtleGVjICdsb2Fk
Jy4KQW5kIHVwZGF0ZSBpbWFfZHVtcF9tZWFzdXJlbWVudF9saXN0KCkgdG8gb25seSBjb3B5IHRo
ZSBtZWFzdXJlbWVudHMuCgpCb3RoIHRoZSBmdW5jdGlvbnMgd2lsbCBiZSBjYWxsZWQgZHVyaW5n
IGtleGVjICdsb2FkJy4KCkFuZCBvbmx5IHRoZSB1cGRhdGVkIGltYV9kdW1wX21lYXN1cmVtZW50
X2xpc3QoKSB3aWxsIGJlIGNhbGxlZApkdXJpbmcga2V4ZWMgJ2V4ZWN1dGUnLgoKUGxlYXNlIGNv
cnJlY3QgbWUgaWYgSSBtaXN1bmRlcnN0b29kLgoKQlRXLCBhcyBkaXNjdXNzZWQgZWxzZXdoZXJl
IEkgYW0gaG9waW5nIHRvIGdldCBjbGFyaXR5IG9uIGlmIHdlIGNhbiBtb3ZlCmV2ZXJ5dGhpbmcg
KG1lbW9yeSBhbGxvY2F0aW9uIGFuZCBjb3B5aW5nIG1lYXN1cmVtZW50cykgdG8ga2V4ZWMgJ2V4
ZWN1dGUnLgoKTXkgY3VycmVudCB1bmRlcnN0YW5kaW5nIGlzIHNlZ21lbnQgbWFwcGluZyBtdXN0
IGhhcHBlbiBhdCBrZXhlYyAnbG9hZCcuCkhvcGVmdWxseSBzb21lb25lIG9uIHRoaXMgdGhyZWFk
IGNhbiB2YWxpZGF0ZSBpZiBpdHMgdHJ1ZSBvciBub3QuCgo+IEVyaWMsIGJlc2lkZXMgdXBkYXRp
bmcgdGhlIGJ1ZmZlciBhdCBrZXhlYyBleGVjdXRlLCBpcyB0aGVyZSBhbnl0aGluZwo+IGVsc2Ug
dGhhdCBuZWVkcyB0byBiZSBkb25lIChlLmcuIHVwZGF0aW5nIGRpZ2VzdHMpPwo+Ckkgd2lsbCBh
bHNvIHdhaXQgZm9yIGhpcyByZXNwb25zZS4gOikKPj4+PiBUaGUgZnVuY3Rpb24gc2hvdWxkIGhh
bmRsZSB0aGUgc2NlbmFyaW8gd2hlcmUKPj4+PiB0aGUga2V4ZWMgbG9hZCBpcyBjYWxsZWQgbXVs
dGlwbGUgdGltZXMuCj4+PiBDdXJyZW50bHkgdGhlIGJ1ZmZlciBpcyBiZWluZyBmcmVlZCB3aXRo
IHRoZSBrZXhlYyAndW5sb2FkJy4gIFdpdGggdGhpcwo+Pj4gcGF0Y2ggSU1BIGlzIGFsbG9jYXRp
bmcgYSBidWZmZXIgZm9yIHRoZSBtZWFzdXJlbWVudCBsaXN0LCB3aGljaCBuZWVkcwo+Pj4gdG8g
YmUgZnJlZWQgaW5kZXBlbmRlbnRseSBvZiB0aGUga2V4ZWMgJ3VubG9hZCcuCj4+IElmIHdlIGVu
ZCB1cCBhbGxvY2F0aW5nIHRoZSBidWZmZXIgYXQga2V4ZWMg4oCYZXhlY3V0ZeKAmSAod2hpY2gg
cmVzdWx0cyBpbgo+PiBzb2Z0IGJvb3QgdG8gbmV4dCBLZXJuZWwpIOKAkyBpcyBpdCB0ZWNobmlj
YWxseSBwb3NzaWJsZSB0aGF0Cj4+IGtleGVjIOKAmHVubG9hZOKAmSBiZWluZyBjYWxsZWQgYWZ0
ZXIgY2FsbGluZyBrZXhlYyDigJhleGVjdXRl4oCZPwo+PiBJZiBub3QsIHNob3VsZCBJIHN0aWxs
IGZyZWUgdGhlIGJ1ZmZlciBhdCBrZXhlYyDigJh1bmxvYWTigJkgaW4gdGhpcwo+PiBzY2VuYXJp
bz8KPiBUaGUgcXVlc3Rpb24gaXMgaG93IHRvIGFjY2VzcyB0aGUgYnVmZmVyIG9uY2Uga2V4ZWNf
YWRkX2J1ZmZlcigpIGlzCj4gY2FsbGVkLgo+Cj4gTWltaQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
