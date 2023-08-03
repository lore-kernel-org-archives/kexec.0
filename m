Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A864FC00528
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCT4o+Ijv6DZv53pEqXwNk840pWe6K2H9uq9AFpOSRk=; b=ZP3FlYL2j+phOF
	eUQXobuRnHcm439M78wZf+qmpDqB+tun+vTI74PIbjhkXgjnkXnTxkQpwJ2CXwzgb6NreGPMMeFm5
	6dl1vZrkjIDgqI1gPFrF3jGt8VuXHXcySplzMa7QTpZmVARwN9CfgtmAQZ4qH+1YGDMTxwWubHjsQ
	pXUgLVRG9U3dpgJZLj7bjASM2wb/lIQ+nV7cqAKCa+asSw7Aa40BMSEfjMr47F+vcZqfRQ0ntH2XO
	ooNtEk6he1eACXRP13Zt+iBfvPJIiogZv7/jjhY4Bx3nhBLtPuzA7gDkVQjghou69GIE6+TcgL79G
	nlPjQzH8IrXHTPAHlKvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe2k-00AkCb-2O;
	Thu, 03 Aug 2023 19:31:30 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe2f-00AkBi-1L
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 19:31:26 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2F05207F594;
	Thu,  3 Aug 2023 12:31:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2F05207F594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691091085;
	bh=cRoxFKq+VV+6aAVg/tuxJaYkcO2AqWQnBLwOt83PZM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hlgHZB1BO9l4MDU7W8kLZzOdja3Qcr+0aOYOoxbsGdAvsx91wk1+di/m6aoapbsy/
	 RC1PJYegmxev+a6kIuvkbsTxyejmc+gyBWj3M/w56ZduXOV2NZicko+BzXLqoSh/Kj
	 QDNs33/T4/GMvtGexJVugvaxImIJFFi34ikR2WW0=
Message-ID: <a057a6c2-92c7-33f0-f03d-2f4e255ce04c@linux.microsoft.com>
Date: Thu, 3 Aug 2023 12:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_123125_555744_07AFF833 
X-CRM114-Status: GOOD (  11.11  )
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

Ck9uIDgvMi8yMyAxODoyMiwgTWltaSBab2hhciB3cm90ZToKPiBPbiBXZWQsIDIwMjMtMDgtMDIg
YXQgMDY6NTggKzAzMDAsIEphcmtrbyBTYWtraW5lbiB3cm90ZToKPj4gIEZyb20gbG9uZyBkZXNj
cmlwdGlvbiBJIHNlZSB6ZXJvIG1vdGl2YXRpb24gdG8gYWNrIHRoaXMgY2hhbmdlLCBleGNlcHQK
Pj4gc29tZSBoZXJlc2F5IGFib3V0IElNQSByZXF1aXJpbmcgaXQuIFdoeSBkb2VzIElNQSBuZWVk
IHVwZGF0ZV9jbnQgYW5kCj4+IHdoeSB0aGlzIGlzIG5vdCBkb2N1bWVudGVkIHRvIHRoZSBsb25n
IGRlc2NyaXB0aW9uPwo+IFRoZSBtb3RpdmF0aW9uIGlzIHRvIGRldGVjdCB3aGV0aGVyIHRoZSBJ
TUEgbWVhc3VyZW1lbnQgbGlzdCBoYXMgYmVlbgo+IHRydW5jYXRlZCwgZm9yIHdoYXRldmVyIHJl
YXNvbi4gIEEgbmV3IElNQSByZWNvcmQgc2hvdWxkIGJlIGRlZmluZWQKPiBjb250YWluaW5nIHRo
ZSAicGNyQ291bnRlciIgdmFsdWUuICAoSSBoYXZlIG5vdCBoYWQgYSBjaGFuY2UgdG8gcmV2aWV3
Cj4gdGhpcyBwYXRjaCBzZXQuKQo+Cj4gVGhpcyBuZXcgcmVjb3JkIHdvdWxkIGJlIGEgcHJlLXJl
cSBmb3IgYm90aCBUdXNoYXIncyAiaW1hOiBtZWFzdXJlCj4gZXZlbnRzIGJldHdlZW4ga2V4ZWMg
bG9hZCBhbmQgZXhlY3V0ZSIgcGF0Y2ggc2V0IGFuZCBTdXNoJ3MgcHJvcG9zYWwgdG8KPiB0cmlt
IHRoZSBtZWFzdXJlbWVudCBsaXN0LiAgKEkgaGF2ZW4ndCBsb29rZWQgYXQgaXQgeWV0IGVpdGhl
ci4pCj4KIMKgVGhhbmtzIE1pbWkuIFRha2UgeW91ciB0aW1lLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
