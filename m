Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2575EB64DD
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 19:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=etpirLuH9wOM+HVL43M4LFAgiwd9G5199sz5Q9AGlR4=; b=zq5vyw5RgxsMlX
	ho2zoFflUq8VXeJMAvmBgq17Rqi0GihzYwuZhZS8BHZiJMaNrEghiEdcA4YAUbBKgL1wS1/SuZHJV
	BqH1IbraWNKZklVkH5Uyi1Qg3U7384sccbsfpVjD/f39o7bEhoQY62YAKcujUJzKdLVGOrnJmWw/O
	Fblvj3lM8yeHEsKUWB5h1/NdoDNn+rJWnYm/AIqTz7FB5bOhJLqZd7/FVC6QUnLihpm4tOyFXIw2P
	1InSKfzBtenkWm39OovfKSy3e1V5/PAlrrQ/fzcZcf2ZALrOe+JIZFbiSil/ROPoBuyG0vY/NInph
	PAB9xWbJd32F6N9/HQpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIp8-00Fj4q-2M;
	Tue, 11 Jul 2023 19:14:58 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIp6-00Fj4Q-1n
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 19:14:58 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA14821C3F06;
	Tue, 11 Jul 2023 12:14:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA14821C3F06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689102896;
	bh=g24d65pfZOSuPgIZU+efQlzC1j5/NEBZemdew2I0E8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X34IU3FJ8jLhPG3uw9eq1R+oZQDcMNkgjSzB6+hj8Kg03WN47XMErKxga0JHM9N6h
	 JJU1mOVh4MVfOzoTq795AgXUOs7jaGxhfPRiqJUWe//BKHpYRQiMj7bgDhkLV/kJ8U
	 +XbvCUr35DWL6K4Idf/KPvzOtmdKk4ZenH6XWS60=
Message-ID: <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
Date: Tue, 11 Jul 2023 12:14:55 -0700
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_121456_638607_CC821F3A 
X-CRM114-Status: GOOD (  22.98  )
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

Ck9uIDcvNy8yMyAwMToyMCwgUnVpUnVpIFlhbmcgd3JvdGU6Cj4gT24gVHVlLCA0IEp1bCAyMDIz
IGF0IDA1OjU4LCBUdXNoYXIgU3VnYW5kaGkKPiA8dHVzaGFyc3VAbGludXgubWljcm9zb2Z0LmNv
bT4gd3JvdGU6Cj4+IFRoZSBrZXhlY19maWxlX2xvYWQgc3lzY2FsbCBpcyB1c2VkIHRvIGxvYWQg
YSBuZXcga2VybmVsIGZvciBrZXhlYy4KPj4gVGhlIHN5c2NhbGwgbmVlZHMgdG8gdXBkYXRlIGl0
cyBmdW5jdGlvbiB0byBjYWxsIGltYV9rZXhlY19wb3N0X2xvYWQsIHdoaWNoCj4+IHdhcyBpbXBs
ZW1lbnRlZCBpbiBhIHByZXZpb3VzIHBhdGNoLiAgaW1hX2tleGVjX3Bvc3RfbG9hZCB0YWtlcyBj
YXJlIG9mCj4+IG1hcHBpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QgZm9yIHRoZSBuZXh0IGtlcm5l
bCBhbmQgcmVnaXN0ZXJpbmcgYSByZWJvb3QKPj4gbm90aWZpZXIgaWYgaXQncyBub3QgYWxyZWFk
eSByZWdpc3RlcmVkLgo+Pgo+PiBNb2RpZnkgdGhlIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxsIHRv
IGNhbGwgaW1hX2tleGVjX3Bvc3RfbG9hZCBhZnRlciB0aGUKPj4gaW1hZ2UgaGFzIGJlZW4gbG9h
ZGVkIGFuZCBwcmVwYXJlZCBmb3Iga2V4ZWMuICBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgSU1BCj4+
IG1lYXN1cmVtZW50IGxpc3Qgd2lsbCBiZSBhdmFpbGFibGUgdG8gdGhlIG5leHQga2VybmVsIGFm
dGVyIGEga2V4ZWMgcmVib290Lgo+PiBUaGlzIGFsc28gZW5zdXJlcyB0aGUgbWVhc3VyZW1lbnRz
IHRha2VuIGluIHRoZSB3aW5kb3cgYmV0d2VlbiBrZXhlYyBsb2FkCj4+IGFuZCBleGVjdXRlIGFy
ZSBjYXB0dXJlZCBhbmQgcGFzc2VkIHRvIHRoZSBuZXh0IGtlcm5lbC4KPj4KPj4gRGVjbGFyZSB0
aGUga2ltYWdlX2ZpbGVfcG9zdF9sb2FkIGZ1bmN0aW9uIGluIHRoZSBrZXJuZWwva2V4ZWNfaW50
ZXJuYWwuaCwKPj4gc28gaXQgY2FuIGJlIHByb3Blcmx5IHVzZWQgaW4gdGhlIHN5c2NhbGwuCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IFR1c2hhciBTdWdhbmRoaSA8dHVzaGFyc3VAbGludXgubWljcm9z
b2Z0LmNvbT4KPj4gLS0tCj4+ICAga2VybmVsL2tleGVjX2ZpbGUuYyAgICAgfCA3ICsrKysrKysK
Pj4gICBrZXJuZWwva2V4ZWNfaW50ZXJuYWwuaCB8IDEgKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNfZmlsZS5jIGIv
a2VybmVsL2tleGVjX2ZpbGUuYwo+PiBpbmRleCBmOTg5ZjVmMTkzM2IuLmVmZTI4ZTc3MjgwYyAx
MDA2NDQKPj4gLS0tIGEva2VybmVsL2tleGVjX2ZpbGUuYwo+PiArKysgYi9rZXJuZWwva2V4ZWNf
ZmlsZS5jCj4+IEBAIC0xODQsNiArMTg0LDExIEBAIGtpbWFnZV92YWxpZGF0ZV9zaWduYXR1cmUo
c3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+ICAgfQo+PiAgICNlbmRpZgo+Pgo+PiArdm9pZCBraW1h
Z2VfZmlsZV9wb3N0X2xvYWQoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+ICt7Cj4+ICsgICAgICAg
aW1hX2tleGVjX3Bvc3RfbG9hZChpbWFnZSk7Cj4+ICt9Cj4+ICsKPj4gICAvKgo+PiAgICAqIElu
IGZpbGUgbW9kZSBsaXN0IG9mIHNlZ21lbnRzIGlzIHByZXBhcmVkIGJ5IGtlcm5lbC4gQ29weSBy
ZWxldmFudAo+PiAgICAqIGRhdGEgZnJvbSB1c2VyIHNwYWNlLCBkbyBlcnJvciBjaGVja2luZywg
cHJlcGFyZSBzZWdtZW50IGxpc3QKPj4gQEAgLTM5OSw2ICs0MDQsOCBAQCBTWVNDQUxMX0RFRklO
RTUoa2V4ZWNfZmlsZV9sb2FkLCBpbnQsIGtlcm5lbF9mZCwgaW50LCBpbml0cmRfZmQsCj4+Cj4+
ICAgICAgICAgIGtpbWFnZV90ZXJtaW5hdGUoaW1hZ2UpOwo+Pgo+PiArICAgICAgIGtpbWFnZV9m
aWxlX3Bvc3RfbG9hZChpbWFnZSk7Cj4gSSB0aGluayBpdCBzaG91bGQgYmUgb25seSBkb25lIGZv
ciB0aGUgcmVib290IGNhc2UsICBwbGVhc2UganVzdAo+IGV4Y2x1ZGUgdGhlIGtkdW1wIGNhc2Ug
aGVyZS4uCj4KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sgUnVpUnVpLsKgIEFwcHJlY2lhdGUgaXQu
CgpDb25jZXB0dWFsbHkgSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IHRoaXMgbmVlZHMgdG8gYmUgZG9u
ZSBvbmx5IGZvciByZWJvb3QuCkkgbmVlZCB0byBmaWd1cmUgb3V0IGhvdyB0byBkbyBpdCBpbXBs
ZW1lbnRhdGlvbiB3aXNlLgoKSWYgeW91IGNhbiBnaXZlIG1lIHBvaW50ZXJzL3N1Z2dlc3Rpb25z
LCB0aGF0IHdvdWxkIGhlbHAuCgp+VHVzaGFyCj4+ICsKPj4gICAgICAgICAgcmV0ID0gbWFjaGlu
ZV9rZXhlY19wb3N0X2xvYWQoaW1hZ2UpOwo+PiAgICAgICAgICBpZiAocmV0KQo+PiAgICAgICAg
ICAgICAgICAgIGdvdG8gb3V0Owo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2tleGVjX2ludGVybmFs
LmggYi9rZXJuZWwva2V4ZWNfaW50ZXJuYWwuaAo+PiBpbmRleCA3NGRhMTQwOWNkMTQuLjk4ZGQ1
ZmNhZmFmMCAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2tleGVjX2ludGVybmFsLmgKPj4gKysrIGIv
a2VybmVsL2tleGVjX2ludGVybmFsLmgKPj4gQEAgLTMwLDYgKzMwLDcgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIGtleGVjX3VubG9jayh2b2lkKQo+Pgo+PiAgICNpZmRlZiBDT05GSUdfS0VYRUNfRklM
RQo+PiAgICNpbmNsdWRlIDxsaW51eC9wdXJnYXRvcnkuaD4KPj4gK3ZvaWQga2ltYWdlX2ZpbGVf
cG9zdF9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKTsKPj4gICB2b2lkIGtpbWFnZV9maWxlX3Bv
c3RfbG9hZF9jbGVhbnVwKHN0cnVjdCBraW1hZ2UgKmltYWdlKTsKPj4gICBleHRlcm4gY2hhciBr
ZXhlY19wdXJnYXRvcnlbXTsKPj4gICBleHRlcm4gc2l6ZV90IGtleGVjX3B1cmdhdG9yeV9zaXpl
Owo+PiAtLQo+PiAyLjI1LjEKPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4+IGtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
