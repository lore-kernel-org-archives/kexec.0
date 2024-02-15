Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8283AC4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y/szU9q9iJFFo0IPQpLyudC1+hZSLqlE/5KLGynx3Kk=; b=IquN8vkR1Fdp0c
	yTxHOEKS835cG0AjttzsL6NXNfJ9I6HFcxkI6QTz5OQENLpdV7tbeWPrY2d13SZ91hRwZv2sL4mgB
	8Ap4G7cAUDqXDc1G27HskcjzDz2864knrvV0TRA8kWwhbuWU30qf6Vc4xb6rlm50x2EqlOgGzE2rn
	z7040WAsk9EDOMJfObIa5082Cn6/2EeD7y/JHufw62LBz7HvtKnZhPXQGZWIkkrMJ5vP560Q2rw2b
	hNsbcRBJmbvvk44jreDHyOCVj2kLE9r8xPNnO5n5XI8FfAhp740kmY/aqLFQetUCM8mSWRSWwhegw
	WWNfRIvFqjvHDieREfZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVhg-0000000F9mT-0xYo;
	Thu, 15 Feb 2024 06:58:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVhe-0000000F9lY-18zp
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 06:58:39 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BD7920B2000;
	Wed, 14 Feb 2024 22:58:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BD7920B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707980317;
	bh=T5tbJLn2I5N6skvV2Z46UPwtt8FoVbcwSRbmRBgUFG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlGtNEBv9XKMtquqxWtmnjJdb5OPbZ0vc/2eVxeM4HZhKN8lM63g/pJYmaFcm3owp
	 fgv4UQsJlSlvYLq5m5+vgQadYLAujptjiqTdzhR6MThlNYpxRpQqDqA8k73JMJpX6N
	 ryOJd7HnAf4ner2tOH2/mpXpjSEyzHOC2tvbBG6U=
Message-ID: <648638bb-e360-4851-adfe-940706a7a51d@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:58:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
 <1569c07b-d66f-441d-8567-2669413c2a08@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <1569c07b-d66f-441d-8567-2669413c2a08@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_225838_415325_EFF88EC4 
X-CRM114-Status: GOOD (  11.96  )
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

CgpPbiAyLzE0LzI0IDEzOjAzLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+IAo+IAo+IE9uIDIvMTQv
MjQgMTA6MzgsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4gVGhlIGFtb3VudCBvZiBtZW1vcnkg
YWxsb2NhdGVkIGF0IGtleGVjIGxvYWQsIGV2ZW4gd2l0aCB0aGUgZXh0cmEgbWVtb3J5Cj4+IGFs
bG9jYXRlZCwgbWlnaHQgbm90IGJlIGxhcmdlIGVub3VnaCBmb3IgdGhlIGVudGlyZSBtZWFzdXJl
bWVudCBsaXN0LiAgCj4+IFRoZQo+PiBpbmRldGVybWluYXRlIGludGVydmFsIGJldHdlZW4ga2V4
ZWMgJ2xvYWQnIGFuZCAnZXhlY3V0ZScgY291bGQgCj4+IGV4YWNlcmJhdGUKPj4gdGhpcyBwcm9i
bGVtLgo+Pgo+PiBEZWZpbmUgdHdvIG5ldyBJTUEgZXZlbnRzLCAna2V4ZWNfbG9hZCcgYW5kICdr
ZXhlY19leGVjdXRlJywgdG8gYmUKPj4gbWVhc3VyZWQgYXMgY3JpdGljYWwgZGF0YSBhdCBrZXhl
YyAnbG9hZCcgYW5kICdleGVjdXRlJyByZXNwZWN0aXZlbHkuCj4+IFJlcG9ydCB0aGUgYWxsb2Nh
dGVkIGtleGVjIHNlZ21lbnQgc2l6ZSwgSU1BIGJpbmFyeSBsb2cgc2l6ZSBhbmQgdGhlCj4+IHJ1
bnRpbWUgbWVhc3VyZW1lbnRzIGNvdW50IGFzIHBhcnQgb2YgdGhvc2UgZXZlbnRzLgo+Pgo+PiBU
aGVzZSBldmVudHMsIGFuZCB0aGUgdmFsdWVzIHJlcG9ydGVkIHRocm91Z2ggdGhlbSwgc2VydmUg
YXMgbWFya2VycyBpbgo+PiB0aGUgSU1BIGxvZyB0byB2ZXJpZnkgdGhlIElNQSBldmVudHMgYXJl
IGNhcHR1cmVkIGR1cmluZyBrZXhlYyBzb2Z0Cj4+IHJlYm9vdC7CoCBUaGUgcHJlc2VuY2Ugb2Yg
YSAna2V4ZWNfbG9hZCcgZXZlbnQgaW4gYmV0d2VlbiB0aGUgbGFzdCB0d28KPj4gJ2Jvb3RfYWdn
cmVnYXRlJyBldmVudHMgaW4gdGhlIElNQSBsb2cgaW1wbGllcyB0aGlzIGlzIGEga2V4ZWMgc29m
dAo+PiByZWJvb3QsIGFuZCBub3QgYSBjb2xkLWJvb3QuwqAgQW5kIHRoZSBhYnNlbmNlIG9mICdr
ZXhlY19leGVjdXRlJyBldmVudAo+PiBhZnRlciBrZXhlYyBzb2Z0IHJlYm9vdCBpbXBsaWVzIG1p
c3NpbmcgZXZlbnRzIGluIHRoYXQgd2luZG93IHdoaWNoCj4+IHJlc3VsdHMgaW4gaW5jb25zaXN0
ZW5jeSB3aXRoIFRQTSBQQ1IgcXVvdGVzLCBuZWNlc3NpdGF0aW5nIGEgY29sZCBib290Cj4+IGZv
ciBhIHN1Y2Nlc3NmdWwgcmVtb3RlIGF0dGVzdGF0aW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBU
dXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20+Cj4gCj4gSSBzdWNj
ZXNzZnVsbHkgdGVzdGVkIHRoaXMgc2VyaWVzIG9uIHBwYzY0LiBJIHdpbGwgZ2l2ZSB5b3UgYSBU
ZXN0ZWQtYnkgCj4gdGFnIGluIHRoZSBuZXh0IHJvdW5kLgo+IAo+ICDCoMKgIFN0ZWZhbgpBd2Vz
b21lISBBcHByZWNpYXRlIGl0LgoKflR1c2hhcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
