Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A8EC4707B
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ee9bdt8Yhw2wqb9zhlEG6RvB/Pw1I7fZ2KOrse8GpWY=; b=Rmw+6kcLph61bN
	GJDIPs/HywGdJb7u4LXTNPFlhLFd/+qp8PpJSbdHHhPgxzl+9U7gxG29Fag+d818J0wPffVqimUu4
	5RQ0wJntYmC5CWrUFvKKKZR06sG+Upo981qGluR/Pqc4gNJrm6nr2rqEgh2KOCF05rdRKg7e0jaXt
	iuUX1c6sFiEI9s6FyRsC83C2g2TNjqxMTTDw851PSKS4YBOd0UHhaME3z0UPX/vbPxFLJLhsU/f68
	IWGp6tQMFtZ8K6axYkwxorRob6YcL2Fi+wv8BOVBiJDQKsa56jtstMNiyCsEnIkQluRU9hw6dmF6z
	3YaFzvROVlcVNVh68obg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO22k-001Cdc-2E;
	Thu, 11 Jan 2024 20:52:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO22g-001Ccq-1Q
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 20:52:48 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D58D20B3CC1;
	Thu, 11 Jan 2024 12:52:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D58D20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705006363;
	bh=U07oEfekVzDj2Hd+ToSATINRRHXIoJTAZMkZ474ONcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATNX2wP9sCU6UMS744ITvfdCNZWesi+PZ/ZUhFfT+hmPVwO91G5sGKHAgYdbkqmAL
	 FGeX4kbGjhsjYhYZt6WvG4L6XfBWyzX9AiVevmLvxf9zmDgYGjK/j9HxYxpAWrzQKe
	 QF4QjA5kh4ShPVpHa40Ta9EiXNN2d9zI9XrlFsCs=
Message-ID: <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
Date: Thu, 11 Jan 2024 12:52:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
 <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_125246_559469_C16C99B5 
X-CRM114-Status: GOOD (  19.69  )
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

CgpPbiAxLzExLzI0IDExOjIwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+IAo+IAo+IE9uIDEvMTEv
MjQgMTM6MTMsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4KPj4KPj4gT24gMS83LzI0IDA5OjAw
LCBNaW1pIFpvaGFyIHdyb3RlOgo+Pj4gT24gRnJpLCAyMDI0LTAxLTA1IGF0IDEyOjIwIC0wODAw
LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9LY29uZmlnIAo+Pj4+Pj4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25m
aWcKPj4+Pj4+IGluZGV4IDYwYTUxMWM2YjU4My4uODc5MmI3YWFiNzY4IDEwMDY0NAo+Pj4+Pj4g
LS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29uZmlnCj4+Pj4+PiArKysgYi9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcKPj4+Pj4+IEBAIC0zMzgsMyArMzM4LDEyIEBAIGNvbmZp
ZyBJTUFfRElTQUJMRV9IVEFCTEUKPj4+Pj4+IMKgwqDCoMKgwqAgZGVmYXVsdCBuCj4+Pj4+PiDC
oMKgwqDCoMKgIGhlbHAKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgVGhpcyBvcHRpb24gZGlzYWJs
ZXMgaHRhYmxlIHRvIGFsbG93IG1lYXN1cmVtZW50IG9mIAo+Pj4+Pj4gZHVwbGljYXRlIHJlY29y
ZHMuCj4+Pj4+PiArCj4+Pj4+PiArY29uZmlnIElNQV9LRVhFQ19FWFRSQV9NRU1PUllfS0IKPj4+
Pj4+ICvCoMKgwqAgaW50Cj4+Pj4+PiArwqDCoMKgIGRlcGVuZHMgb24gSU1BICYmIElNQV9LRVhF
Qwo+Pj4+Pj4gK8KgwqDCoCBkZWZhdWx0IDY0Cj4+Pj4+Cj4+Pj4+IFNpbmNlIHRoaXMgaXNuJ3Qg
b3B0aW9uYWwsIHRoZSBkZWZhdWx0IHNob3VsZCByZW1haW4gYXMgYSBoYWxmIHBhZ2UuCj4+Pj4+
IFNpbmNlIGEgcGFnZSBpcyBhcmNoaXRlY3R1cmUgc3BlY2lmaWMsIHRoZSBkZWZhdWx0IHdpbGwg
bmVlZCB0byBiZSAKPj4+Pj4gYXJjaAo+Pj4+PiDCoMKgIHNwZWNpZmljCj4+Pj4+Cj4+Pj4gSXQg
d2FzIGEgZmVlZGJhY2sgZnJvbSBTdGVmYW4gaW4gdGhlIFYyIG9mIHRoaXMgc2VyaWVzIHRvIGNv
bnZlcnQgaXQKPj4+PiBmcm9tIG51bWJlciBvZiBQQUdFUyB0byBLQi5bMV0KPj4+Pgo+Pj4+IEJ1
dCBJIGNhbiByZXZlcnQgaXQgdG8gbnVtYmVyIG9mIHBhZ2VzIGFnYWluLgo+Pj4+Cj4+Pj4gQWxz
bywgbWFraW5nIHRoZSBkZWZhdWx0IHZhbHVlIGFzIGEgZnJhY3Rpb24gKDEvMiBwYWdlKSBmZWVs
cyB3ZWlyZCBmb3IKPj4+PiBhIENPTkZJRyB2YXJpYWJsZS4KPj4+Pgo+Pj4+IElzIGl0IG9rIHRv
IG1ha2UgdGhlIGRlZmF1bHQgdmFsdWUgYXMgb25lIHBhZ2UgcmF0aGVyIHRoYW4gaGFsZiBwYWdl
Pwo+Pj4KPj4+IFRoZSBwb2ludCBpcyBub3Qgd2hldGhlciB0aGUgZXh0cmEgbWVtb3J5IGlzIHNw
ZWNpZmllZCBpbiB0ZXJtcyBvZiAKPj4+IHBhZ2VzIG9yIEtCLgo+Pj4gRm9yIGJhY2t3YXJkcyBj
b21wYXRpYmlsaXR5IHRoZSBleGlzdGluZyBkZWZhdWx0IHNob3VsZCBiZSB0aGUgc2FtZSBhcwo+
Pj4gcHJldmlvdXNseS7CoCBUaGlzIG1lYW5zIHRoZSBkZWZhdWx0IG5lZWRzIHRvIGJlIGFyY2hp
dGVjdHVyZSBzcGVjaWZpYy5iCj4+PiAkIHVuYW1lIC1tOyBnZXRjb25mIFBBR0VTSVpFCj4+PiB4
ODZfNjQKPj4+IDQwOTYKPj4+ICQgdW5hbWUgLW07IGdldGNvbmYgUEFHRVNJWkUKPj4+IHBwYzY0
bGUKPj4+IDY1NTM2Cj4+Pgo+Pj4gRm9yIGV4YW1wbGU6Cj4+Pgo+Pj4gZGVmYXVsdCAzMiBpZiBQ
UENfNjRLX1BBR0VTCj4+PiBkZWZhdWx0IDIKPj4+Cj4+IE9rLiBUaGFua3MgZm9yIHRoZSBjbGFy
aWZpY2F0aW9uLgo+Pgo+Pgo+PiBEbyB3ZSB3YW50IHRvIHN1cHBvcnQgb25seSA2NEsgb3IgNEsg
YXMgcG9zc2libGUgUEFHRV9TSVpFIHZhbHVlcz8KPj4gSSBzcG90IGNoZWNrZWQgYSBmZXcgYXJj
aGl0ZWN0dXJlcywgdGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVyZSBQQUdFX1NJWkUKPj4gY291bGQg
YmUgOEssIDE2SywgMTI4SywgMjU2SyBldGMuIEFuZCBvZiBjb3Vyc2UgbWVnYSBwYWdlcyB3aXRo
Cj4+IFBBR0VfU0laRSBJTiBNQnMgKGRldGFpbHMgYmVsb3cpLgo+IAo+IEkgd291bGQgbGV0IHRo
ZSB1c2VyIHNwZWNpZnkgdGhlIG51bWJlciBvZiBraWxvYnl0ZXMgdG8gcmVzZXJ2ZSBhbmQgZnJv
bSAKPiB0aGlzIHlvdSBjYW4gY29uY2x1ZGUgdGhlIHBhZ2UgbnVtYmVyczoKPiAKPiBuZWVkZWRf
cGFnZXMgPSBLQnNfVE9fUkVTRVJWRSAvIFBBR0VfU0laRQo+IGlmIChLQnNfVE9fUkVTRVJWRVIg
JSBQQUdFX1NJWkUpCj4gIMKgwqDCoCBuZWVkZWRfcGFnZXMrKzsKPiAKPiAgwqDCoCBTdGVmYW4K
VGhhbmtzIFN0ZWZhbi4KCkJ1dCB0aGUgaXNzdWUgaGVyZSBpcyBhYm91dCB0aGUgZGVmYXVsdCB2
YWx1ZSwKbm90IHRoZSB1c2VyIHNwZWNpZmllZCB2YWx1ZS4KCk1pbWkgaXMgc3VnZ2VzdGluZyB0
byBrZWVwIHRoZSBkZWZhdWx0IHZhbHVlIGhhbGYtYS1wYWdlLAp0byBtYWludGFpbiBiYWNrd2Fy
ZHMgY29tcGF0aWJpbGl0eS4KCklmIHdlIGdvIHdpdGggdGhlIEtCcyBhcHByb2FjaCAtCmhhbGYt
YS1wYWdlIHRyYW5zbGF0ZXMgdG8gZGlmZmVyZW50IEtCcyBvbiBkaWZmZXJlbnQgYXJjaGl0ZWN0
dXJlcy4KQW5kIHNldHRpbmcgdGhlIHJpZ2h0IGRlZmF1bHQgdmFsdWUgaW4gS0JzIHdoaWNoIHdv
dWxkIHRyYW5zbGF0ZSB0bwp0aGUgZGVzaXJlZCBoYWxmLWEtcGFnZSwgb24gYSBnaXZlbiBhcmNo
LCBpbnNpZGUgdGhlIEtjb25maWcgc2VlbXMKZnJhZ2lsZSAoYXMgSSBtZW50aW9uZWQgaW4gdGhl
IGNvbnRleHQgb2YgT3B0aW9uIEEgaW4gbXkgcHJldmlvdXMKcmVzcG9uc2UuCgpBbmQgaWYgd2Ug
Z28gd2l0aCBudW1fcGFnZXMgYXBwcm9hY2ggLQpwdXR0aW5nIGEgZnJhY3Rpb25hbCB2YWx1ZSAo
MC41KSBhcyBhIGRlZmF1bHQgaW4gS2NvbmZpZyBzZWVtcyB0byBiZSBub24KdHJpdmlhbCB0b28u
CgpUcmFuc2xhdGluZyBudW1fcGFnZXMgdG8gS0JzIGlzIHRyaXZpYWwgaW4gY29kZSwgYnV0IEkg
dGhpbmsgaXRzCm9ydGhvZ29uYWwgdG8gdGhpcyBjb252ZXJzYXRpb24sIHNpbmNlIGl0cyBhYm91
dCBzZXR0aW5nIHRoZSBkZXNpcmVkIAphcmNoIHNwZWNpZmljIGRlZmF1bHQgdmFsdWUgaW4gS2Nv
bmZpZy4KCgpPcHRpb24gQToKLS0tLS0tLS0tCmNvbmZpZyBJTUFfS0VYRUNfRVhUUkFfTUVNT1JZ
X0tCCiAgICAgaW50CiAgICAgZGVwZW5kcyBvbiBJTUEgJiYgSU1BX0tFWEVDCiAgICAgZGVmYXVs
dCAxMjggaWYgUEFHRV9TSVpFXzI1NktCCiAgICAgZGVmYXVsdCAzMiBpZiBQUENfNjRLX1BBR0VT
IHx8IFBBR0VfU0laRV82NEtCIHx8IFBBUklTQ19QQUdFX1NJWkVfMTZLQgogICAgIGRlZmF1bHQg
MTYgaWYgUEFHRV9TSVpFXzMyS0IKICAgICBkZWZhdWx0IDggaWYgUEFHRV9TSVpFXzE2S0IgfHwg
QVJDX1BBR0VfU0laRV8xNksgfHwgClBBUklTQ19QQUdFX1NJWkVfMTZLQgogICAgIGRlZmF1bHQg
NCBpZiBQQUdFX1NJWkVfOEtCIHx8IEFSQ19QQUdFX1NJWkVfOEsKICAgICBkZWZhdWx0IDIKICAg
ICAgIElNQV9LRVhFQ19FWFRSQV9NRU1PUllfS0IgZGV0ZXJtaW5lcyB0aGUgbnVtYmVyIG9mIGV4
dHJhCiAgICAgICBtZW1vcnkgKGluIEtCKSB0byBiZSBhbGxvY2F0ZWQgZm9yIElNQSBtZWFzdXJl
bWVudHMgYWRkZWQKICAgICAgIGR1cmluZyBrZXhlYyBzb2Z0LXJlYm9vdC4KCk9wdGlvbiBCOgot
LS0tLS0tLQpjb25maWcgSU1BX0tFWEVDX0VYVFJBX1BBR0VTCiAgICAgaW50CiAgICAgZGVwZW5k
cyBvbiBJTUEgJiYgSU1BX0tFWEVDCiAgICAgZGVmYXVsdCAxCiAgICAgaGVscAogICAgICAgSU1B
X0tFWEVDX0VYVFJBX1BBR0VTIGRldGVybWluZXMgdGhlIG51bWJlciBvZiBleHRyYQogICAgICAg
cGFnZXMgdG8gYmUgYWxsb2NhdGVkIGZvciBJTUEgbWVhc3VyZW1lbnRzIGFkZGVkIGR1cmluZwog
ICAgICAga2V4ZWMgc29mdC1yZWJvb3QuCgp+VHVzaGFyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
