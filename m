Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5379FC001DF
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2bc4pomT9kkfnTR2DhMqtanmE0ZPh94Xqe6VECTMj4k=; b=VDco3F2C6TCiGe
	CZK5/HZfavy6oUh7T48EM5MV2kEKUOIf3nJZvy4xW//G4quvfw7wqlvzV5Ea8Vnx7QTYduklQBdv5
	gvh6SFzcsf0hVTiLeV4VLgCufj3kvUsg0vLtPXlafcXOXHI+a3itZOPoBGNNNQUOtzVb5gvhoIVKQ
	+RFHFj7o4SyXpPGsj/E4VmbAnWMjRe6IDJ29sF38CkRJ5J22JwbXsZOEjwXD1q5b6ZiHzapDdIiMW
	qHDPwwCSEVDaGL/PcdQk+NPjH0q/xpo4rJuPLps5XbT+dZj3rjX8fUQhq7J0K7YFHU3o4jBmi8biA
	c439GEQAkZOw82U/4FGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRyLM-00CsMQ-2Y;
	Fri, 04 Aug 2023 17:12:04 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRyLK-00CsLd-15
	for kexec@lists.infradead.org;
	Fri, 04 Aug 2023 17:12:03 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id F161F207F58A;
	Fri,  4 Aug 2023 10:11:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F161F207F58A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691169118;
	bh=5HYDNc5C5jxcr2IsCCVYRz1Hk0NvwCMwdDwURbIbniw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ksoqh+tmbAFT1bqzrfLCEfdbS1cYLvKRZyEUV+yGutAvYU/g2CmuYxAdg+keVSqfL
	 DSWomwETuL1g1DoQEKGAldmz6c1eLcy+yehRrqX5w2nLyxhBOgz6e3tjx3bHM+3PGE
	 qTv6lzQc6Hq3g5Jhxyj5HLR+C8wRhcF6uma4944o=
Message-ID: <299c6b9d-a9d6-b5c9-697f-3c320fad91c6@linux.microsoft.com>
Date: Fri, 4 Aug 2023 10:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] ima: measure TPM update counter at ima_init
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com, bauermann@kolabnow.com,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-6-tusharsu@linux.microsoft.com>
 <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
 <da91b56a-83c8-d12e-71f8-887b6701f021@linux.microsoft.com>
 <e9ab98a823c2e6c536fb2acbe86229a0085bd34a.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e9ab98a823c2e6c536fb2acbe86229a0085bd34a.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_101202_425553_BBA770CB 
X-CRM114-Status: GOOD (  20.02  )
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

CgpPbiA4LzMvMjMgMTg6MTgsIE1pbWkgWm9oYXIgd3JvdGU6Cj4gT24gVGh1LCAyMDIzLTA4LTAz
IGF0IDE2OjM0IC0wNzAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4KPj4+PiArKysgYi9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0LmMKPj4+PiBAQCAtMTU0LDUgKzE1NCw4IEBAIGlu
dCBfX2luaXQgaW1hX2luaXQodm9pZCkKPj4+PiAgICAJCQkJICBVVFNfUkVMRUFTRSwgc3RybGVu
KFVUU19SRUxFQVNFKSwgZmFsc2UsCj4+Pj4gICAgCQkJCSAgTlVMTCwgMCk7Cj4+Pj4gICAgCj4+
Pj4gKwkvKiBNZWFzdXJlcyBUUE0gdXBkYXRlIGNvdW50ZXIgYXQgaW1hX2luaXQgKi8KPj4+PiAr
CWltYV9tZWFzdXJlX3VwZGF0ZV9jb3VudGVyKCJpbWFfaW5pdF90cG1fdXBkYXRlX2NvdW50ZXIi
KTsKPj4+PiArCj4+PiBXaXRoICJpbWFfcG9saWN5PWNyaXRpY2FsX2RhdGEiIG9uIHRoZSBib290
IGNvbW1hbmQgbGluZSwgdGhlIElNQQo+Pj4gbWVhc3VyZW1lbnQgbGlzdCByZWNvcmQgbG9va3Mg
bGlrZToKPj4+Cj4+PiA2ZTE5MGNjNjQzZmYwYjcxODQ4NTk2NmEwMzAwNDczYmFlZGZhY2U3MzUg
aW1hX2luaXRfdHBtX3VwZGF0ZV9jb3VudGVyIDc1NzA2NDYxNzQ2NTVmNjM2Zjc1NmU3NDY1NzIz
ZDMzMzAzODNiCj4+Pgo+Pj4gUGxlYXNlIGNoYW5nZSB0aGUgImltYV9pbml0X3RwbV91cGRhdGVf
Y291bnRlciIgdG8gc29tZXRoaW5nIHNob3J0ZXIKPj4+IGFuZCB0aGUgaGV4IGVuY29kZWQgYXNj
aWkgc3RyaW5nIGFuZCBwY3IgY291bnRlciB0byBzb21ldGhpbmcgcmVhZGFibGUuCj4+IEkgYmVs
aWV2ZSB5b3UgYXJlIHNlZWluZyB0aGUgYWJvdmUgbGluZSBpbiBhc2NpbGxfcnVudGltZV9tZWFz
dXJlbWVudHMgbG9nLgo+IFllcywgdGhlIGFzY2lpX3J1bnRpbWVfbWVhc3VyZW1lbnRzIGFyZSBz
dXBwb3NlIHRvIGJlIHJlYWRhYmxlIHRvIHRoZQo+IGVuZCB1c2VyLgpXZSB3ZXJlIHBhc3Npbmcg
c3RyaW5nIGxpdGVyYWxzIHRvICdidWYnIHBhcmFtIGluIAppbWFfbWVhc3VyZV9jcml0aWNhbF9k
YXRhKCkuCkkgYmVsaWV2ZSB3ZSBuZWVkIHRvIGNvbnZlcnQgdGhlbSBmaXJzdC4KCj4+IFRoZSBh
c2NpaSBsb2dnaW5nIGZvcm1hdCBpcyBjb25zaXN0ZW50IHdpdGggb3RoZXIgZXZlbnQgZGF0YSBm
b3IKPj4gY3JpdGljYWxfZGF0YSBldmVudCBlLmcuIGtlcm5lbF92ZXJzaW9uLgo+IFRoZW4geW91
IGdvdCBpdCB3cm9uZy4KSSBzZWUuwqAgSSB3aWxsIGZpeCBpdCBmb3IgdHBtIGluIHRoaXMgcGF0
Y2ggc2VyaWVzLgpJIHRoaW5rIEkgc2hvdWxkIHNwaW4gdXAgYW5vdGhlciBzZXJpZXMgdG8gZml4
IGl0IGZvcgpzZWxpbnV4LCBrZXJuZWwgaW5mbywgRE0gZXRjLgo+PiAxMCA4ZjQ0OTE3NWJiZjg4
YmM1NWZjMTEyNzQ2NjYyOGMzOWEzOTU3ZDE1IGltYS1idWYKPj4gc2hhMTo0YWNhYjRmYmIwOGRi
NjYzYjdiN2I0NTI4ZTg3MjkxODdkNzI2NzgyIGtlcm5lbF92ZXJzaW9uCj4+IDM2MmUzMzJlMzAy
ZDcyNjMzMzJiCj4+IDEwIGYxMDY3OGI2M2M0YjI1MjkzMzlkZmYwMjI4MmU2M2Q5YzZiYjAzODUg
aW1hLWJ1Zgo+PiBzaGExOmQ4YzE4NzUyNDQxMmY3NGE5NjFmMjA1MWE5NTI5YzAwOWU3MDAzMzcK
Pj4gaW1hX2luaXRfdHBtX3VwZGF0ZV9jb3VudGVyIDc1NzA2NDYxNzQ2NTVmNjM2Zjc1NmU3NDY1
NzIzZDMxMzMzMDNiCj4+Cj4+IEVudHJpZXMgaW4gdGhlIGJpbmFyeSBydW50aW1lIG1lYXN1cmVt
ZW50cyBsb29rIHJlYWRhYmxlIHRvIG1lLgo+IFlvdSd2ZSBpbnZlcnRlZCB0aGUgbWVhbmluZyBv
ZiB0aGUgYXNjaWkgYW5kIGJpbmFyeSBydW50aW1lIG1lYXN1cmVtZW50Cj4gbGlzdHMuICBGb3Ig
Y29tcGFyaXNvbiBsb29rIGF0IHRoZSBpbWEtbmcvaW1hLXNpZyByZWNvcmRzLgpZdXAuwqAgQWdy
ZWVkLgo+PiBpbWFfaW5pdF90cG1fdXBkYXRlX2NvdW50ZXIgdXBkYXRlX2NvdW50ZXI9MTMwOwo+
PiAuLi4KPj4ga2V4ZWNfbG9hZF90cG1fdXBkYXRlX2NvdW50ZSBydXBkYXRlX2NvdW50ZXI9MTMz
Owo+Pgo+PiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHN0aWxsIHdhbnQgbWUgdG8gY2hhbmdl
IHRoZSBmb3JtYXQuCj4gT0kgY291cnNlIHRoZSBhc2NpaSBtZWFzdXJlbWVudCBsaXN0IHNob3Vs
ZCBiZSBodW1hbiByZWFkYWJsZS4KWXVwLsKgIEkgd2lsbCBtYWtlIHRoZSBjaGFuZ2VzIGFzIEkg
bWVudGlvbmVkIGFib3ZlLgo+Cj4+PiBQZXJoYXBzIG5hbWUgdGhpcyBjcml0aWNhbC1kYXRhICJ0
cG0iIGFuZCAidHBtLWluZm8iLCBzaW1pbGFyIHRvIHRoZQo+PiAgIEZyb20gcGF0Y2ggNC82Ogo+
PiArICAgIHJlc3VsdCA9IGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInRwbV9wY3JfdXBkYXRl
X2NvdW50ZXIiLAo+PiBldmVudF9uYW1lLAo+PiArICAgICAgICAgICAgICAgICAgYnVmLCBidWZf
bGVuLCBmYWxzZSwgTlVMTCwgMCk7Cj4+Cj4+IFRoZSBjcml0aWNhbF9kYXRhIGV2ZW50X2xhYmVs
IHZhbHVlIGlzIGN1cnJlbnRseSBzZXQgdG8KPj4gInRwbV9wY3JfdXBkYXRlX2NvdW50ZXIiLgo+
IFdoeSBpcyB0aGUgc3RyaW5nIHNvIGxvbmc/ICAgTG9uZyBzdHJpbmdzIG9yIHZhcmlhYmxlcyBk
b24ndCBtYWtlIHRoZQo+IGNvZGUgb3IgbG9ncyBtb3JlIHVuZGVyc3RhbmRhYmxlLiAgUGxlYXNl
IHNob3J0ZW4gYm90aCB0aGUgc3RyaW5ncyBhbmQKPiB2YXJpYWJsZXMuCkFncmVlZC7CoCBJIHdp
bGwgbmFtZSB0aGlzICJ0cG0iIGFuZCAidHBtLWluZm8iIG9yIHNvbWV0aGluZyBzaW1pbGFyLgo+
PiBJIGNhbiByZW5hbWUgZXZlbnRfbGFiZWwgdG8gInRwbS1pbmZvIiwgc28gdGhhdCB0aGUgYWRt
aW5zIGNhbiBmaWx0ZXIgdGhlCj4+IGV2ZW50IGluIElNQSBwb2xpY3kgYmFzZWQgb24gdGhlIGxh
YmVsIGlmIG5lZWRlZC4KPiBUaGUgbmV3IHJlY29yZCBuZWVkcyB0byBiZSBzZWxmIGNvbnRhaW5k
IGFuZCB2ZXJpZmlhYmxlLiAgVGhlCj4gYWRkaXRpb25hbCBpbmZvIEkgc3VnZ2VzdGVkIHdlcmUg
anVzdCBleGFtcGxlcy4gIFBsZWFzZSB0YWtlIHRoZSB0aW1lCj4gdG8gY29uc2lkZXIgd2hhdCBu
ZWVkcyB0byBiZSBpbmNsdWRlZCBpbiB0aGUgbmV3IHJlY29yZC4gIERlY2lkZQo+IHdoZXRoZXIg
dGhpcyBpcyBhIFRQTSBzZWN1cml0eSBjcml0aWNhbCBkYXRhIHJlY29yZC4gIE9ubHkgdGhlbiwg
ZGVjaWRlCj4gb24gdGhlIG5hbWluZy4KWWVzLsKgIEkgd2lsbCBleHBsb3JlIHdoYXQgb3RoZXIg
cG90ZW50aWFsIGF0dHJpYnV0ZXMgY2FuIGJlIGFkZGVkIHRvIAp0aGlzIHJlY29yZC4KQW5kIEkn
bGwgc2hhcmUgdGhlbSBoZXJlIGZvciB0aGUgY29tbXVuaXR5IGZlZWRiYWNrLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
