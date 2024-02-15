Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B771FC4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hE/g1OvPYTYWD0qoA5grja6CxYHGKh68upq58tf3VOg=; b=DU/y2QpgNRzigC
	i7KfRsLH94woQVOomnnuPVIbvJodruUPrKR7DK78O0rpP+jFLKXkiTE6rYh5Az16Dt6s8Ke9gssYZ
	oF3Upq/oSrPItGHq6HbX/oEiso5L1z0T/b8auN+x7rhEdO73t6nYFdM3AcPOwSBKtGu28mbWZ5ifQ
	mF9ksnY3kiEKdnFD5z5hA1x6DHHk2VIa2KhFGBHo7p8rmwUbZxb+ghA5AHTtnmkE3JjXfJyRwQl8d
	bdDfeLuzQklrX1XHJf+Hs/xAYWabI1MUyk6E3CCyrph7ylt8gHRA0juKFvtgWGKehVDk2Mrs8neAj
	SwDcapoDI9nyla/+10vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVf5-0000000F9WI-1frJ;
	Thu, 15 Feb 2024 06:55:59 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVf2-0000000F9Vu-1cn9
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 06:55:57 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5AE1207F228;
	Wed, 14 Feb 2024 22:55:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5AE1207F228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707980155;
	bh=bkxc7nHkeBriUENd6669TjcMt9DOTF2AwIiWhyYhBKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b19pVT1E3P2KKBxgZ1knNnIE4LLIBCLZ//H+owN4eEy2ZRCFZRs+FgpcJlppFh60T
	 QC1zv+w6LlDyd4vqlaKOMAOnWIZP55983tE7x90WDqWN1pdHhcjkZFcVAx+XMPxFeS
	 G35fmV+/GEAnUboEO9rrFS2RGQp8QUAXmXS5eYe0=
Message-ID: <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:55:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
 <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_225556_530308_411FA04D 
X-CRM114-Status: GOOD (  14.43  )
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

CgpPbiAyLzE0LzI0IDEyOjQ3LCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+IAo+IAo+IE9uIDIvMTQv
MjQgMTA6MzgsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKLi4uCjxzbmlwLz4KLi4uCj4+ICt2b2lk
IGtpbWFnZV9maWxlX3Bvc3RfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4gK3sKPj4gK8Kg
wqDCoCBpbWFfa2V4ZWNfcG9zdF9sb2FkKGltYWdlKTsKPj4gK30KPj4gKwo+IAo+IFdlIGdldCB0
aGlzIGhlcmUgYXQgdGhpcyBwb2ludCBidXQgaXQgZGlzYXBwZWFycyBsYXRlciAtLSBtaXNzaW5n
IGhlYWRlcj8KPiAKPiBrZXJuZWwva2V4ZWNfZmlsZS5jOjE4OTo2OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIAo+IOKAmGtpbWFnZV9maWxlX3Bvc3RfbG9hZOKAmSBbLVdtaXNz
aW5nLXByb3RvdHlwZXNdCj4gIMKgIDE4OSB8IHZvaWQga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKHN0
cnVjdCBraW1hZ2UgKmltYWdlKQo+ICDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fgo+IAo+IApUaGFua3MgU3RlZmFuLgpJIHdhcyBhbHNvIGdldHRpbmcgaXQuCkJ1
dCBjb3VsZG4ndCBmaWd1cmUgb3V0IHdoeS4gQW5kIEkgd2FzIHB1enpsZWQgd2h5IGl0IHdhcyBn
b2luZyBhd2F5LgoKU2luY2Uga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKCkgaXMgY2FsbGVkIGZyb20g
dGhlIHNhbWUgZmlsZSBpbiBwYXRjaCA1LzgsCkkgZG9uJ3Qgc2VlIGEgbmVlZCBvZiBkZWNsYXJp
bmcgaXQgaW4gYSBoZWFkZXIgZmlsZSBsaWtlIAppbmNsdWRlL2xpbnV4L2tleGVjLmguCgpNYWtp
bmcga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKCkgbG9jYWwgc3RhdGljIHJlc29sdmVzIHRoZSB3YXJu
aW5nLgpCdXQgdGhlbiBpdCB0aHJvd3MgImRlZmluZWQgYnV0IG5vdCB1c2VkIiB3YXJuaW5nLiBJ
IHdpbGwgaGF2ZSB0byBjYWxsIAppdCBmcm9tIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxsIGluIHRo
aXMgcGF0Y2ggKDQvOCkgaW5zdGVhZCA1LzggdG8gCnJlc29sdmUgdGhhdCB3YXJuaW5nLgoKSSB3
aWxsIG1ha2UgdGhlIGZ1bmN0aW9uIGEgc3R1YiBmdW5jdGlvbiBpbiB0aGlzIHBhdGNoIGFuZApt
YWtlIGl0IGNhbGwgaW1hX2tleGVjX3Bvc3RfbG9hZChpbWFnZSkgaW4gdGhlIG5leHQgcGF0Y2gg
dG8gYXZvaWQgYW55IApwb3RlbnRpYWwgYmlzZWN0IHNhZmUgaXNzdWVzLgoKSXQgYWxpZ25zIHdp
dGggdGhlIGdvYWxzIG9mIHBhdGNoIDQvOCBhbmQgNS84IGFueXdheXMuCgorc3RhdGljIHZvaWQg
a2ltYWdlX2ZpbGVfcG9zdF9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKQoreworCS8qCisJICog
dGhpcyB3aWxsIGNhbGwgaW1hX2tleGVjX3Bvc3RfbG9hZChpbWFnZSkgdG8gbWFwIHRoZSBzZWdt
ZW50CisJICogYW5kIHJlZ2lzdGVyIHRoZSByZWJvb3Qgbm90aWZpZXIgZm9yIG1vdmluZyB0aGUg
SU1BIGxvZyBhdAorCSAqIGtleGVjIGV4ZWN1dGUKKwkgKi8KK30KKwoKCkBAIC00MTAsNiArNDEw
LDkgQEAgU1lTQ0FMTF9ERUZJTkU1KGtleGVjX2ZpbGVfbG9hZCwgaW50LCBrZXJuZWxfZmQsIApp
bnQsIGluaXRyZF9mZCwKICAgICAgICAga2ltYWdlX3Rlcm1pbmF0ZShpbWFnZSk7CisgICAgaWYg
KCEoZmxhZ3MgJiBLRVhFQ19GSUxFX09OX0NSQVNIKSkKKyAgICAgICAga2ltYWdlX2ZpbGVfcG9z
dF9sb2FkKGltYWdlKTsKKwoKLi4uCi4uLjxzbmlwLz4KLi4uCgo+IAo+IFJldmlld2VkLWJ5OiBT
dGVmYW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4LmlibS5jb20+ClRoYW5rcyBmb3IgdGhlIHRhZy4g
SSB3aWxsIGFwcGx5IGl0IG9uIHRoZSBuZXh0IHZlcnNpb24uCgp+VHVzaGFyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
