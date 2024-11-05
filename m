Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B761D3E775
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aV4uT6575R640FVFEYIxmY8R/ac2o5jUiIW7kCVGcJI=; b=nrIlQQ2OlrVAXb
	ECJGnO+0xkGiMmKN6Sa03DfZEc8zo1BtADr7gDNK3oVnvErMiXoKzCi54luPeCgTnwW9qfl7chm1O
	St71FvViNoFUBSKxYb7VxDmMbyuNpVnoL1pDiypXWA1QdhYX0tUiIWZE8qXa+hwly5VJ2U/+6jYXd
	HrD3oQrm380QGoRgQJrgDCAimsJKmMF9WoZ48jE6ox6i4+BpGqG4eI5pcwPajrHrNRHsSZI1UkGo2
	fUhwZvPjxxf/3aH7wAtHFAKTxkVdmuv21tcY66FtugXGOAaPdFWDPGsv5ptyo3TAC2yIv3TmE/tEE
	KqrSaz16qcWKtavb5hYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8S27-000000010TD-1n5t;
	Tue, 05 Nov 2024 22:28:19 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8S24-000000010SU-239R
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 22:28:17 +0000
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5MRoc9414997
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:27:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5MRoc9414997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730845672;
	bh=IH13q9iPFTI89hpznrhXCva+vUvCu42Sl1a7/K/TTAk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HChlsozMrvOP1l8+5N9GO+W6JSJdNeClPzJnm1LHT4mpzRjbJt6m+DX2/lbDkKj5O
	 sfiVcmysHFrEviRMc3GiEc9G/EiSBAEQuX1O++erTD1TXGLg6qO8s1/v+akVn5GAP6
	 SjNoo8kO+dyftE5HjXDQxDpxaYk8wZEWOc/vV6yW2G4k1SeL0EHMnykUwLGh47zP3Q
	 kLSYp/IibDRH/NV3bdn9Bfd+SIXBLtd59ZMT4HBg7cl5ICIKEbK50oAofCcQYc/7L9
	 UDlSexWhd34TGSkLbuTdkd8qtI+Ky97BZulRmd7T1ZJrV2YYb1xlxoMIyDh6mAlFEP
	 4HbSo1YRdV73w==
Message-ID: <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
Date: Tue, 5 Nov 2024 14:27:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
 <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Content-Language: en-US
In-Reply-To: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_142816_555686_CA4D6968 
X-CRM114-Status: GOOD (  12.91  )
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

T24gMTEvNS8yNCAxMzo1OCwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4gCj4gVGhlbiB5b3UgY2Fu
IGp1c3QgZG8gdGhlIG9idmlvdXMgKGhhdmUgeW91ciBhc3NlbWJseSBzdHViIHBvaW50ICVyZGkg
dG8gCj4gdGhlIGJhc2Ugb2YgdGhlIHJlZ2lzdGVyIGR1bXA7IHNldCB0aGUgZnJhbWUgb3JkZXIg
dG8gd2hhdGV2ZXIgeW91J2QgCj4gbGlrZSwgZXhjZXB0IHJpcC9lcnIvZXhjLCBvciByZXZlcnNl
IHRoZSBvcmRlciBpZiB5b3UgcHJlZmVyIGJ5IGNoYW5naW5nIAo+IHRoZSBsb29wKToKPiAKPiBz
dGF0aWMgaW5saW5lIF9fbm9yZXR1cm4gdm9pZCBkaWUodm9pZCkKPiB7Cj4gIMKgwqDCoMKgd2hp
bGUgKDEpCj4gIMKgwqDCoMKgwqDCoMKgIGFzbSB2b2xhdGlsZSgiaGx0Iik7Cj4gfQo+IAo+IHZv
aWQgZHVtcF9yZWdpc3Rlcl9mcmFtZShjb25zdCB1bnNpZ25lZCBsb25nIGZyYW1lW10pCj4gewo+
ICDCoMKgwqDCoHN0YXRpYyBjb25zdCBjaGFyIHJlZ25hbWVzW11bNV0gPSB7Cj4gIMKgwqDCoMKg
wqDCoMKgICJyYXg6IiwgInJjeDoiLCAicmR4OiIsICJyYng6IiwKPiAgwqDCoMKgwqDCoMKgwqAg
InJzcDoiLCAicmJwOiIsICJyc2k6IiwgInJkaToiLAo+ICDCoMKgwqDCoMKgwqDCoCAicjg6ICIs
ICJyOTogIiwgInIxMDoiLCAicjExOiIsCj4gIMKgwqDCoMKgwqDCoMKgICJyMTI6IiwgInIxMzoi
LCAicjE0OiIsICJyMTU6IiwKPiAgwqDCoMKgwqDCoMKgwqAgImNyMjoiLCAiRXhjOiIsICJFcnI6
IiwgInJpcDoiCj4gIMKgwqDCoMKgfTsKPiAKPiAgwqDCoMKgwqBmb3IgKHNpemVfdCBpID0gMDsg
aSA8IEFSUkFZX1NJWkUocmVnbmFtZXMpOyBpKyspIHsKPiAgwqDCoMKgwqDCoMKgwqAgX19wdXRz
dHIocmVnbmFtZXNbaV0pOwo+ICDCoMKgwqDCoMKgwqDCoCBfX3B1dGhleChmcmFtZVtpXSk7Cj4g
IMKgwqDCoMKgwqDCoMKgIF9fcHV0c3RyKCJcbiIpOwo+ICDCoMKgwqDCoH0KPiAKPiAgwqDCoMKg
wqAvKiBPbmx5IHJldHVybiBmcm9tIGludDMgKi8KPiAgwqDCoMKgwqBpZiAoZnJhbWVbMTddICE9
IDMpCj4gIMKgwqDCoMKgwqDCoMKgIGRpZSgpOwo+IH0KPiAKCkkgZG9uJ3Qga25vdyBpZiBpdCBp
cyBuZWNlc3NhcnksIGJ1dCB5b3UgY2FuIGRvIHNvbWV0aGluZyBsaWtlIHRoaXMgdG8gCm1ha2Ug
YWJzb2x1dGVseSBzdXJlIHlvdSBkb24ndCBlbmQgdXAgd2l0aCBub24tcmVsYXRpdmUgc3ltYm9s
IHJlZmVyZW5jZXM6CgpzdGF0aWMgaW5saW5lIF9fY29uc3RmdW5jIHZvaWQgKiBzeW1fYWRkcihj
b25zdCB2b2lkICpzeW0pCnsKCXZvaWQgKmFkZHI7Cglhc20oImxlYSAlYzEoJSVyaXApLCUwIiA6
ICI9ciIgKGFkZHIpIDogImkiIChzeW0pKTsKCXJldHVybiBhZGRyOwp9CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
