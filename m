Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8451FEB64DD
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PF67uWTS+WkKxXT74qQGV+ZJSxtvUTG8nqgPBCwPz8Q=; b=4G0kKe/yUGhxVE
	7Ayi+0mRHu8kHvhHsyh9aLMIoeOaPgb1T/6IPcwfSlyK/XUpggEfakD7m6MC2I6gNP+c91G0Ftjb7
	taCdlxfClBOeS4zYJXvnKa0YMImZalDt5TTk/BoNoDqZOpAcLFiFpoRIXcnecCpt0A8ak/iseGRxG
	4ZlFPflkcNg7T94AedTNEcw+Zm1Ehyyo0ZCM8zwE7mLbmsN/qDYEjKU4R1fZ3N0Tznp4t7Q3OemcF
	N3FOoSaoq1q3Ct+/c7ltk7R3xsTKcP1K33aJZz/hK3sQ2/JeX3GKGvsPQHY2Sptj6yJa6FK9NHFkr
	FZNVRESZpLcIX66mAPzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIir-00FiXW-1w;
	Tue, 11 Jul 2023 19:08:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIio-00FiX1-2o
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 19:08:28 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B729821C3A93;
	Tue, 11 Jul 2023 12:08:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B729821C3A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689102506;
	bh=LPli2HTbXE2281jdsnFjMad67IlCVJdzYiNCSMTBkA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XbEja+wqWTOfCry2WJiDw9gszkL3yQ4+gRp6Y0iVTp8xnRmEv5gU8YIkVrsRZuHSN
	 aJV27StOq1uSKOLB7VYf1kNDefTfeCLtj6agHLA8Nl1eFHcI5ks0vnrp+412nvtEnY
	 sV1cmwj3Q0V2G09/sR9+tcPJk5JVg2Nk6FyBQIQw=
Message-ID: <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
Date: Tue, 11 Jul 2023 12:08:24 -0700
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
 <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_120826_959020_47A417B8 
X-CRM114-Status: GOOD (  15.28  )
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

QWRkaW5nIEVyaWMgdG8gY2MuCgpPbiA3LzcvMjMgMTI6NDksIE1pbWkgWm9oYXIgd3JvdGU6Cj4g
T24gRnJpLCAyMDIzLTA3LTA3IGF0IDExOjAxIC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+PiBI
aSBUdXNoYXIsCj4+Cj4+IE9uIE1vbiwgMjAyMy0wNy0wMyBhdCAxNDo1NyAtMDcwMCwgVHVzaGFy
IFN1Z2FuZGhpIHdyb3RlOgo+Pgo+Pj4gKy8qCj4+PiArICogQ2FsbGVkIGR1cmluZyBrZXhlYyBl
eGVjdXRlIHNvIHRoYXQgSU1BIGNhbiB1cGRhdGUgdGhlIG1lYXN1cmVtZW50IGxpc3QuCj4+PiAr
ICovCj4+PiArc3RhdGljIGludCBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlcihzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgKnNlbGYsCj4+PiArCQkJCSAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpk
YXRhKQo+Pj4gK3sKPj4+ICsJdm9pZCAqbmV3X2J1ZmZlciA9IE5VTEw7Cj4+PiArCXNpemVfdCBu
ZXdfYnVmZmVyX3NpemUsIGN1cl9idWZmZXJfc2l6ZTsKPj4+ICsJYm9vbCByZXN1bWUgPSBmYWxz
ZTsKPj4+ICsKPj4+ICsJaWYgKCFrZXhlY19pbl9wcm9ncmVzcykgewo+Pj4gKwkJcHJfaW5mbygi
JXM6IE5vIGtleGVjIGluIHByb2dyZXNzLlxuIiwgX19mdW5jX18pOwo+Pj4gKwkJcmV0dXJuIE5P
VElGWV9PSzsKPj4+ICsJfQo+Pj4gKwo+Pj4gKwlpZiAoIWltYV9rZXhlY19idWZmZXIpIHsKPj4+
ICsJCXByX2VycigiJXM6IEtleGVjIGJ1ZmZlciBub3Qgc2V0LlxuIiwgX19mdW5jX18pOwo+Pj4g
KwkJcmV0dXJuIE5PVElGWV9PSzsKPj4+ICsJfQo+Pj4gKwo+Pj4gKwlpbWFfbWVhc3VyZW1lbnRz
X3N1c3BlbmQoKTsKPj4+ICsKPj4+ICsJY3VyX2J1ZmZlcl9zaXplID0ga2V4ZWNfc2VnbWVudF9z
aXplIC0gc2l6ZW9mKHN0cnVjdCBpbWFfa2V4ZWNfaGRyKTsKPj4+ICsJbmV3X2J1ZmZlcl9zaXpl
ID0gaW1hX2dldF9iaW5hcnlfcnVudGltZV9zaXplKCk7Cj4+PiArCWlmIChuZXdfYnVmZmVyX3Np
emUgPiBjdXJfYnVmZmVyX3NpemUpIHsKPj4+ICsJCXByX2VycigiJXM6IE1lYXN1cmVtZW50IGxp
c3QgZ3JldyB0b28gbGFyZ2UuXG4iLCBfX2Z1bmNfXyk7Cj4+PiArCQlyZXN1bWUgPSB0cnVlOwo+
Pj4gKwkJZ290byBvdXQ7Cj4+PiArCX0KPj4gVGhpcyBjaGFuZ2VzIHRoZSBjdXJyZW50IGJlaGF2
aW9yIG9mIGNhcnJ5aW5nIGFzIG1hbnkgbWVhc3VyZW1lbnRzCj4+IGFjcm9zcyBrZXhlYyBhcyBw
b3NzaWJsZS4gIFRydWUgdGhlIG1lYXN1cmVtZW50IGxpc3Qgd29uJ3QgdmVyaWZ5Cj4+IGFnYWlu
c3QgdGhlIFRQTSBQQ1JzLCBidXQgbm90IGNvcHlpbmcgdGhlIG1lYXN1cmVtZW50cyBsZWF2ZXMg
dGhlCj4+IGltcHJlc3Npb24gdGhlcmUgd2VyZW4ndCBhbnkgcHJldmlvdXMgbWVhc3VyZW1lbnRz
Lgo+Pgo+PiBUaGlzIGFsc28gZXhwbGFpbnMgdGhlIHJlYXNvbiBmb3IgYWxsb2NhdGluZyBhbiBJ
TUEgYnVmZmVyIChwYXRjaCAxLzEwKQo+PiBhbmQgbm90IHdyaXRpbmcgdGhlIG1lYXN1cmVtZW50
cyBkaXJlY3RseSBpbnRvIHRoZSBrZXhlYyBidWZmZXIuCj4gSWYgbm90IGNhcnJ5aW5nIGV2ZW4g
YSBwYXJ0aWFsIG1lYXN1cmVtZW50IGxpc3QgYWNyb3NzIGtleGVjIGlzCj4gZGVzaXJlZCwgdGhl
biBpbiBhZGRpdGlvbiB0byB0aGUgImJvb3RfYWdncmVnYXRlIiByZWNvcmQsIGRlZmluZSBhIG5l
dwo+IHJlY29yZCBjb250YWluaW5nIHRoZSBUUE0gcGNyY291bnRlci4gIFdpdGggdGhpcyBpbmZv
cm1hdGlvbiwKPiBhdHRlc3RhdGlvbiBzZXJ2ZXJzIHdpbGwgYXQgbGVhc3QgYmUgYWJsZSB0byBk
ZXRlY3QgaWYgdGhlIG1lYXN1cmVtZW50Cj4gbGlzdCB3YXMgdHJ1bmNhdGVkLgo+Cj4gdGhhbmtz
LAo+Cj4gTWltaQpTdXJlLsKgIFJlY29yZGluZyBUUE0gcGNyY291bnRlciBhdCBib290IGFnZ3Jl
Z2F0ZSBhbmQKS2V4ZWMgJ2xvYWQnIHNob3VsZCBwcm92aWRlIHRoZSBuZWNlc3NhcnkgaW5mb3Jt
YXRpb24gdG8gdGhlCmF0dGVzdGF0aW9uIHNlcnZlcnMuwqAgV2UgY2FuIGltcGxlbWVudCB0aGlz
IGlmIG5lZWRlZCwgYmFzZWQgb24gaG93CnJlc3Qgb2YgdGhlIHNlcmllcyBldm9sdmVzLgoKflR1
c2hhcgo+Pj4gKwlpbWFfcG9wdWxhdGVfYnVmX2F0X2tleGVjX2V4ZWN1dGUoJm5ld19idWZmZXJf
c2l6ZSwgJm5ld19idWZmZXIpOwo+Pj4gKwo+Pj4gKwlpZiAoIW5ld19idWZmZXIpIHsKPj4+ICsJ
CXByX2VycigiJXM6IER1bXAgbWVhc3VyZW1lbnRzIGZhaWxlZC5cbiIsIF9fZnVuY19fKTsKPj4+
ICsJCXJlc3VtZSA9IHRydWU7Cj4+PiArCQlnb3RvIG91dDsKPj4+ICsJfQo+Pj4gKwltZW1jcHko
aW1hX2tleGVjX2J1ZmZlciwgbmV3X2J1ZmZlciwgbmV3X2J1ZmZlcl9zaXplKTsKPj4+ICtvdXQ6
Cj4+PiArCWtpbWFnZV91bm1hcF9zZWdtZW50KGltYV9rZXhlY19idWZmZXIpOwo+Pj4gKwlpbWFf
a2V4ZWNfYnVmZmVyID0gTlVMTDsKPj4+ICsKPj4+ICsJaWYgKHJlc3VtZSkKPj4+ICsJCWltYV9t
ZWFzdXJlbWVudHNfcmVzdW1lKCk7Cj4+PiArCj4+PiArCXJldHVybiBOT1RJRllfT0s7Cj4+PiAr
fQo+Pj4gKwo+Pj4gICAjZW5kaWYgLyogSU1BX0tFWEVDICovCj4+PiAgIAo+Pj4gICAvKgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
