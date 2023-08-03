Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557D2C001DF
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fpoDwCbau0k2OicN9xzMxjedSM+2anJWo0u4hzs/aQU=; b=NrCrZxxL0o+tyV
	qo8maK0WIT/AJA5Q12WaYLLvvBtMZkIUunE1uEZchptXFhVLcH+dSuiaqUku4YPtSz03pAawPNFc7
	cB0IeaAs+NZ42TE7Lu16oBWHfO3pIO6rXbcFrVXJ/Qmzm178GOz3VFwe1T/YGUXxKtzPX1z+bFNNC
	aXfYqRXCUbnmard03oO0eVLBtNFEoAjn/IGBHf8taYI4tjVIxRiUIOURe8lIA7SFkEd+AY8rGiBrV
	x3UaAzPGfBlB/D7lQyr+hf/agUZOwgmPByrenQPFkgjTKKXVgLyKzcD2hW5D9R/JE6qJmtRcIiNOi
	QIhL6PifUua7vgX1kRSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe58-00AkPv-2A;
	Thu, 03 Aug 2023 19:33:58 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe55-00AkPL-1b
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 19:33:56 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B33B207F5B0;
	Thu,  3 Aug 2023 12:33:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B33B207F5B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691091234;
	bh=rfoxZMZ2hyhRIAWppNtheFwJlnTpKt2nHIchOzxIXPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V2YuPDHyoo0gKow3V7av5aCdZ3WkjHujn4xvjWGSuaS9B49p1bq4DO2jcjXhDWLc6
	 1I8MBMcLemv7wOYsN/b2fKlSYmjY/PpVVrzJK43VePYp5WQT7TPFg0/9oYytK1Qpjd
	 adlWLpCPy0kM2486SiNGWLCGiXLR2uDUSqXdSmyE=
Message-ID: <d9e7297a-cda7-74e5-70a8-dd128f68f726@linux.microsoft.com>
Date: Thu, 3 Aug 2023 12:33:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
 jgg@ziepe.ca, kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
 <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_123355_561400_3DA43484 
X-CRM114-Status: GOOD (  14.62  )
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

Ck9uIDgvMy8yMyAwMTo1NywgSmFya2tvIFNha2tpbmVuIHdyb3RlOgo+IE9uIFRodSBBdWcgMywg
MjAyMyBhdCA0OjIyIEFNIEVFU1QsIE1pbWkgWm9oYXIgd3JvdGU6Cj4+IE9uIFdlZCwgMjAyMy0w
OC0wMiBhdCAwNjo1OCArMDMwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOgo+Pj4gIEZyb20gbG9u
ZyBkZXNjcmlwdGlvbiBJIHNlZSB6ZXJvIG1vdGl2YXRpb24gdG8gYWNrIHRoaXMgY2hhbmdlLCBl
eGNlcHQKPj4+IHNvbWUgaGVyZXNheSBhYm91dCBJTUEgcmVxdWlyaW5nIGl0LiBXaHkgZG9lcyBJ
TUEgbmVlZCB1cGRhdGVfY250IGFuZAo+Pj4gd2h5IHRoaXMgaXMgbm90IGRvY3VtZW50ZWQgdG8g
dGhlIGxvbmcgZGVzY3JpcHRpb24/Cj4+IFRoZSBtb3RpdmF0aW9uIGlzIHRvIGRldGVjdCB3aGV0
aGVyIHRoZSBJTUEgbWVhc3VyZW1lbnQgbGlzdCBoYXMgYmVlbgo+PiB0cnVuY2F0ZWQsIGZvciB3
aGF0ZXZlciByZWFzb24uICBBIG5ldyBJTUEgcmVjb3JkIHNob3VsZCBiZSBkZWZpbmVkCj4+IGNv
bnRhaW5pbmcgdGhlICJwY3JDb3VudGVyIiB2YWx1ZS4gIChJIGhhdmUgbm90IGhhZCBhIGNoYW5j
ZSB0byByZXZpZXcKPj4gdGhpcyBwYXRjaCBzZXQuKQo+Pgo+PiBUaGlzIG5ldyByZWNvcmQgd291
bGQgYmUgYSBwcmUtcmVxIGZvciBib3RoIFR1c2hhcidzICJpbWE6IG1lYXN1cmUKPj4gZXZlbnRz
IGJldHdlZW4ga2V4ZWMgbG9hZCBhbmQgZXhlY3V0ZSIgcGF0Y2ggc2V0IGFuZCBTdXNoJ3MgcHJv
cG9zYWwgdG8KPj4gdHJpbSB0aGUgbWVhc3VyZW1lbnQgbGlzdC4gIChJIGhhdmVuJ3QgbG9va2Vk
IGF0IGl0IHlldCBlaXRoZXIuKQo+IFBsZWFzZSBkZXNjcmliZSB0aGUgc3RvcnkgaW4gYSBiaXQg
bW9yZSB1bmRlcnN0YW5kYWJsZSBmb3JtLiBJbiB0aGUKPiBjb21taXQgbWVzc2FnZXMgaXQgaXMg
bm90IGdvb2QgdG8gaGF2ZSBzb21lIHJlZHVuZGFuY3kgaW4gcGF0Y2ggc2V0cy4KPgo+IEJSLCBK
YXJra28KVGhhbmtzIEphcmtrby7CoCBJIGhhZCBwcm92aWRlZCB0aGUgb3ZlcmFsbCBjb250ZXh0
IGluIHRoZSBjb3ZlciBsZXR0ZXIuCkJ1dCBJIHVuZGVyc3RhbmQgdGhlIGNvdmVyIGxldHRlciB3
aWxsIGJlIGxvc3Qgd2hlbiB0aGUgcGF0Y2hlcyBhcmUKbWVyZ2VkLiBJIHdpbGwgZGVzY3JpYmUg
dGhlIHN0b3J5IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbnMgYXMgd2VsbCwKaW4gdGhlIG5leHQg
dmVyc2lvbiBvZiB0aGlzIHNlcmllcy4KCn5UdXNoYXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
