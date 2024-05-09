Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFE6C10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4i8coJ0+JJhqZRp80j4UHE81DS/nP5DpMMLZ8yEqOXQ=; b=G0Qm+DPF/pnvMe
	UoqpUMiEDmQO/TuY1OV6s+2jw6gMK7bC3vMDjMtQeR2nwsgKYHQ3ZjmxTn5OgD3ZxleMHqYwTqm2a
	mBISgneS0C/tSsfFUoXmGO64hc4CROXWQskfiTHcH60vOy6EEQnoEWFqaBXtRbv+8a2E1FU7EdNsj
	+K+Cm8Z9a1rrbrbDJmMwRp8VXI7AVIvUSKJQSWvHgi2aSJJS+bqBwfLNeQBwsdVJfqtaZVjvnlrzO
	NDr/Tk+p2IYpMieo+gkYydql8tggL7lZUeLzWFX+JyHQYegGwDuLbNJ8QZ+NY/7TVUObd26xSumyr
	+X1iLfAaU+SI1xOKjgkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s542m-00000001bSm-0Yo5;
	Thu, 09 May 2024 13:42:44 +0000
Received: from shelob.surriel.com ([96.67.55.147])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s542i-00000001bQW-2OoS
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 13:42:42 +0000
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1s541X-0000000063q-16NF;
	Thu, 09 May 2024 09:41:27 -0400
Message-ID: <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
From: Rik van Riel <riel@surriel.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
Date: Thu, 09 May 2024 09:41:27 -0400
In-Reply-To: <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
References: <20240507091858.36ff767f@imladris.surriel.com>
	 <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_064240_628105_2EDBCC43 
X-CRM114-Status: GOOD (  14.77  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDI0LTA1LTA5IGF0IDExOjUyICswODAwLCBCYW9xdWFuIEhlIHdyb3RlOgo+IEhp
LAo+IAo+IE9uIDA1LzA3LzI0IGF0IDA5OjE4YW0sIFJpayB2YW4gUmllbCB3cm90ZToKPiA+IFdo
aWxlIHRha2luZyBhIGtlcm5lbCBjb3JlIGR1bXAgd2l0aCBtYWtlZHVtcGZpbGUgb24gYSBsYXJn
ZXIKPiA+IHN5c3RlbSwKPiA+IHNvZnRsb2NrdXAgbWVzc2FnZXMgb2Z0ZW4gYXBwZWFyLgo+ID4g
Cj4gPiBXaGlsZSBzb2Z0bG9ja3VwIHdhcm5pbmdzIGNhbiBiZSBoYXJtbGVzcywgdGhleSBjYW4g
YWxzbyBpbnRlcmZlcmUKPiA+IHdpdGggdGhpbmdzIGxpa2UgUkNVIGZyZWVpbmcgbWVtb3J5LCB3
aGljaCBjYW4gYmUgcHJvYmxlbWF0aWMgd2hlbgo+ID4gdGhlIGtkdW1wIGtleGVjIGltYWdlIGlz
IGNvbmZpZ3VyZWQgd2l0aCBhcyBsaXR0bGUgbWVtb3J5IGFzCj4gPiBwb3NzaWJsZS4KPiA+IAo+
ID4gQXZvaWQgdGhlIHNvZnRsb2NrdXAsIGFuZCBnaXZlIHRoaW5ncyBsaWtlIHdvcmsgaXRlbXMg
YW5kIFJDVSBhCj4gPiBjaGFuY2UgdG8gZG8gdGhlaXIgdGhpbmcgZHVyaW5nIF9fcmVhZF92bWNv
cmUgYnkgYWRkaW5nIGEKPiA+IGNvbmRfcmVzY2hlZC4KPiAKPiBUaGFua3MgZm9yIGZpeGluZyB0
aGlzLgo+IAo+IEJ5IHRoZSB3YXksIGlzIGl0IGVhc3kgdG8gcmVwcm9kdWNlPyBBbmQgc2hvdWxk
IHdlIGFkZCBzb21lIHRyYWNlIG9mCj4gdGhlCj4gc29mdGxvY2t1cCBpbnRvIGxvZyBzbyB0aGF0
IHBlb3BsZSBjYW4gc2VhcmNoIGZvciBpdCBhbmQgY29uZmlybSB3aGVuCj4gZW5jb3VudGVyaW5n
IGl0PwoKSXQgaXMgcHJldHR5IGVhc3kgdG8gcmVwcm9kdWNlLCBidXQgaXQgZG9lcyBub3QgaGFw
cGVuIGFsbCB0aGUgdGltZS4KV2l0aCBtaWxsaW9ucyBvZiBzeXN0ZW1zLCBldmVuIHJhcmUgZXJy
b3JzIGFyZSBjb21tb24gOikKCkhvd2V2ZXIsIHdlIGhhdmUgYmVlbiBydW5uaW5nIHdpdGggdGhp
cyBmaXggZm9yIGxvbmcgZW5vdWdoICh3ZQpkZXBsb3llZCBpdCBpbiBvcmRlciB0byB0ZXN0IGl0
KSB0aGF0IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSB0aGXCoAp3YXJuaW5nIHN0b3JlZCBhbnkgbW9y
ZS4gVGhvc2UgbG9ncyB3ZXJlIHJvdGF0ZWQgb3V0IGxvbmcgYWdvLgoKa2luZCByZWdhcmRzLAoK
UmlrCi0tIApBbGwgUmlnaHRzIFJldmVyc2VkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
