Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B04C0015E
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Po4EhxKTiDvprUqyk05AC3oEP5Vz3V8q6ZDshUhDe4=; b=U1mnH+btu24iAj
	j8Pm2yFytCgMifr6cf/flKekr6G7C3jlpt0tHDndBjtto63IpQve/BJ8EFmqLusZCoiMU+qnLruVv
	XjSM92jKNVGvzF0SWiivVWPGtb4nkVI6Lfmt5cD6ADDc2aBeA13LjmGCfQF9GiQrOK22xPULM6gVb
	js0OzM9UcMg7lBfOqT8R80TFFhyWnQS0mVk1c6LB6ZbkSModme9T2knLEFakMn1EyX4zBfinCo+vI
	Itpx7Rir6J4FxpKL7/NAFcsLns6fIG1dc7AmBvUhvHSbkk+4sTKK7lIklqv5JUG5CmEaPFMI105dm
	TMUJI2FnUH9/JizF9l4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfXh-000zmC-0x;
	Wed, 12 Jul 2023 19:30:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJfXd-000zlM-30
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 19:30:27 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAAA921C44E5;
	Wed, 12 Jul 2023 12:30:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAAA921C44E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689190225;
	bh=Yu+xJdcstGuYIdFXmY3aIzZrTs0/bPtsUuWd7EMLaVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDT+i0Qpl4arWVvlIM+98p/Wb2mlz6qlnfQBR0ByVk19cIGp/JMPGPSdueCTS0f1R
	 5zor+uh4a6KF9Qh8SMWGaIObVDf+aKkd2kf53BTpWDnNaNGRQQRoqRvMt8Ei1WEGFo
	 jdCPbvHM1oTehF/9BxOxsfHjayVP1pCtJKd2ZpPw=
Message-ID: <85dc6104-0d15-c31b-b36f-5345480d01e6@linux.microsoft.com>
Date: Wed, 12 Jul 2023 12:30:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call
 ima_kexec_post_load
Content-Language: en-US
To: RuiRui Yang <ruyang@redhat.com>
Cc: zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
 code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
 <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
 <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
 <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_123026_017059_911D7607 
X-CRM114-Status: GOOD (  24.16  )
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

Ck9uIDcvMTEvMjMgMTg6MjgsIFJ1aVJ1aSBZYW5nIHdyb3RlOgo+IE9uIFdlZCwgMTIgSnVsIDIw
MjMgYXQgMDM6MTUsIFR1c2hhciBTdWdhbmRoaQo+IDx0dXNoYXJzdUBsaW51eC5taWNyb3NvZnQu
Y29tPiB3cm90ZToKPj4KPj4gT24gNy83LzIzIDAxOjIwLCBSdWlSdWkgWWFuZyB3cm90ZToKPj4+
IE9uIFR1ZSwgNCBKdWwgMjAyMyBhdCAwNTo1OCwgVHVzaGFyIFN1Z2FuZGhpCj4+PiA8dHVzaGFy
c3VAbGludXgubWljcm9zb2Z0LmNvbT4gd3JvdGU6Cj4+Pj4gVGhlIGtleGVjX2ZpbGVfbG9hZCBz
eXNjYWxsIGlzIHVzZWQgdG8gbG9hZCBhIG5ldyBrZXJuZWwgZm9yIGtleGVjLgo+Pj4+IFRoZSBz
eXNjYWxsIG5lZWRzIHRvIHVwZGF0ZSBpdHMgZnVuY3Rpb24gdG8gY2FsbCBpbWFfa2V4ZWNfcG9z
dF9sb2FkLCB3aGljaAo+Pj4+IHdhcyBpbXBsZW1lbnRlZCBpbiBhIHByZXZpb3VzIHBhdGNoLiAg
aW1hX2tleGVjX3Bvc3RfbG9hZCB0YWtlcyBjYXJlIG9mCj4+Pj4gbWFwcGluZyB0aGUgbWVhc3Vy
ZW1lbnQgbGlzdCBmb3IgdGhlIG5leHQga2VybmVsIGFuZCByZWdpc3RlcmluZyBhIHJlYm9vdAo+
Pj4+IG5vdGlmaWVyIGlmIGl0J3Mgbm90IGFscmVhZHkgcmVnaXN0ZXJlZC4KPj4+Pgo+Pj4+IE1v
ZGlmeSB0aGUga2V4ZWNfZmlsZV9sb2FkIHN5c2NhbGwgdG8gY2FsbCBpbWFfa2V4ZWNfcG9zdF9s
b2FkIGFmdGVyIHRoZQo+Pj4+IGltYWdlIGhhcyBiZWVuIGxvYWRlZCBhbmQgcHJlcGFyZWQgZm9y
IGtleGVjLiAgVGhpcyBlbnN1cmVzIHRoYXQgdGhlIElNQQo+Pj4+IG1lYXN1cmVtZW50IGxpc3Qg
d2lsbCBiZSBhdmFpbGFibGUgdG8gdGhlIG5leHQga2VybmVsIGFmdGVyIGEga2V4ZWMgcmVib290
Lgo+Pj4+IFRoaXMgYWxzbyBlbnN1cmVzIHRoZSBtZWFzdXJlbWVudHMgdGFrZW4gaW4gdGhlIHdp
bmRvdyBiZXR3ZWVuIGtleGVjIGxvYWQKPj4+PiBhbmQgZXhlY3V0ZSBhcmUgY2FwdHVyZWQgYW5k
IHBhc3NlZCB0byB0aGUgbmV4dCBrZXJuZWwuCj4+Pj4KPj4+PiBEZWNsYXJlIHRoZSBraW1hZ2Vf
ZmlsZV9wb3N0X2xvYWQgZnVuY3Rpb24gaW4gdGhlIGtlcm5lbC9rZXhlY19pbnRlcm5hbC5oLAo+
Pj4+IHNvIGl0IGNhbiBiZSBwcm9wZXJseSB1c2VkIGluIHRoZSBzeXNjYWxsLgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogVHVzaGFyIFN1Z2FuZGhpIDx0dXNoYXJzdUBsaW51eC5taWNyb3NvZnQu
Y29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGtlcm5lbC9rZXhlY19maWxlLmMgICAgIHwgNyArKysrKysr
Cj4+Pj4gICAga2VybmVsL2tleGVjX2ludGVybmFsLmggfCAxICsKPj4+PiAgICAyIGZpbGVzIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhl
Y19maWxlLmMgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCj4+Pj4gaW5kZXggZjk4OWY1ZjE5MzNiLi5l
ZmUyOGU3NzI4MGMgMTAwNjQ0Cj4+Pj4gLS0tIGEva2VybmVsL2tleGVjX2ZpbGUuYwo+Pj4+ICsr
KyBiL2tlcm5lbC9rZXhlY19maWxlLmMKPj4+PiBAQCAtMTg0LDYgKzE4NCwxMSBAQCBraW1hZ2Vf
dmFsaWRhdGVfc2lnbmF0dXJlKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+Pj4+ICAgIH0KPj4+PiAg
ICAjZW5kaWYKPj4+Pgo+Pj4+ICt2b2lkIGtpbWFnZV9maWxlX3Bvc3RfbG9hZChzdHJ1Y3Qga2lt
YWdlICppbWFnZSkKPj4+PiArewo+Pj4+ICsgICAgICAgaW1hX2tleGVjX3Bvc3RfbG9hZChpbWFn
ZSk7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gICAgLyoKPj4+PiAgICAgKiBJbiBmaWxlIG1vZGUgbGlz
dCBvZiBzZWdtZW50cyBpcyBwcmVwYXJlZCBieSBrZXJuZWwuIENvcHkgcmVsZXZhbnQKPj4+PiAg
ICAgKiBkYXRhIGZyb20gdXNlciBzcGFjZSwgZG8gZXJyb3IgY2hlY2tpbmcsIHByZXBhcmUgc2Vn
bWVudCBsaXN0Cj4+Pj4gQEAgLTM5OSw2ICs0MDQsOCBAQCBTWVNDQUxMX0RFRklORTUoa2V4ZWNf
ZmlsZV9sb2FkLCBpbnQsIGtlcm5lbF9mZCwgaW50LCBpbml0cmRfZmQsCj4+Pj4KPj4+PiAgICAg
ICAgICAga2ltYWdlX3Rlcm1pbmF0ZShpbWFnZSk7Cj4+Pj4KPj4+PiArICAgICAgIGtpbWFnZV9m
aWxlX3Bvc3RfbG9hZChpbWFnZSk7Cj4+PiBJIHRoaW5rIGl0IHNob3VsZCBiZSBvbmx5IGRvbmUg
Zm9yIHRoZSByZWJvb3QgY2FzZSwgIHBsZWFzZSBqdXN0Cj4+PiBleGNsdWRlIHRoZSBrZHVtcCBj
YXNlIGhlcmUuLgo+Pj4KPj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sgUnVpUnVpLiAgQXBwcmVj
aWF0ZSBpdC4KPj4KPj4gQ29uY2VwdHVhbGx5IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB0aGlzIG5l
ZWRzIHRvIGJlIGRvbmUgb25seSBmb3IgcmVib290Lgo+PiBJIG5lZWQgdG8gZmlndXJlIG91dCBo
b3cgdG8gZG8gaXQgaW1wbGVtZW50YXRpb24gd2lzZS4KPj4KPj4gSWYgeW91IGNhbiBnaXZlIG1l
IHBvaW50ZXJzL3N1Z2dlc3Rpb25zLCB0aGF0IHdvdWxkIGhlbHAuCj4gSGkgVHVzaGFyLAo+Cj4g
WW91IGNhbiBjaGVjayB0aGUgZmxhZ3MgYXJndW1lbnQgaW4gdGhlIGZ1bmN0aW9uCj4gaWYgKGZs
YWdzICYgS0VYRUNfRklMRV9PTl9DUkFTSCkgaXMgdHJ1ZSB0aGVuIHRoaXMgaXMgYSBrZHVtcCBr
ZXJuZWwKPiBsb2FkaW5nLCBqdXN0IHNraXAgdGhlIGtpbWFnZV9maWxlX3Bvc3RfbG9hZCBpbiB0
aGF0IGNhc2U/CkdyZWF0LsKgIFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIuwqAgV2lsbCBkby4KflR1
c2hhcgo+PiB+VHVzaGFyCj4+Pj4gKwo+Pj4+ICAgICAgICAgICByZXQgPSBtYWNoaW5lX2tleGVj
X3Bvc3RfbG9hZChpbWFnZSk7Cj4+Pj4gICAgICAgICAgIGlmIChyZXQpCj4+Pj4gICAgICAgICAg
ICAgICAgICAgZ290byBvdXQ7Cj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19pbnRlcm5h
bC5oIGIva2VybmVsL2tleGVjX2ludGVybmFsLmgKPj4+PiBpbmRleCA3NGRhMTQwOWNkMTQuLjk4
ZGQ1ZmNhZmFmMCAxMDA2NDQKPj4+PiAtLS0gYS9rZXJuZWwva2V4ZWNfaW50ZXJuYWwuaAo+Pj4+
ICsrKyBiL2tlcm5lbC9rZXhlY19pbnRlcm5hbC5oCj4+Pj4gQEAgLTMwLDYgKzMwLDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGtleGVjX3VubG9jayh2b2lkKQo+Pj4+Cj4+Pj4gICAgI2lmZGVmIENP
TkZJR19LRVhFQ19GSUxFCj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3B1cmdhdG9yeS5oPgo+Pj4+
ICt2b2lkIGtpbWFnZV9maWxlX3Bvc3RfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSk7Cj4+Pj4g
ICAgdm9pZCBraW1hZ2VfZmlsZV9wb3N0X2xvYWRfY2xlYW51cChzdHJ1Y3Qga2ltYWdlICppbWFn
ZSk7Cj4+Pj4gICAgZXh0ZXJuIGNoYXIga2V4ZWNfcHVyZ2F0b3J5W107Cj4+Pj4gICAgZXh0ZXJu
IHNpemVfdCBrZXhlY19wdXJnYXRvcnlfc2l6ZTsKPj4+PiAtLQo+Pj4+IDIuMjUuMQo+Pj4+Cj4+
Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
Pj4+IGtleGVjIG1haWxpbmcgbGlzdAo+Pj4+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4+
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4+Pj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
