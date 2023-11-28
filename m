Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB6C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJEv/a0EwkDMFV+8YSWbmi+5wjHcFrQxk6EiXEiEpkQ=; b=ZSiNbQO1GPO5JE
	XpuNgj6Z1QfpJFIBolyVgUolutjxEGhDBtPUoKZ1MjZVHY+oqpY8dVSAx55LKIzfeHfU3jmjsoD1r
	74j/Solw86eA0rlz0v3zvPmR/unn/OX8fj8d/lI9dVGZ2BlE4wXVTW1JC/DoX/w434h8pQu78DqNQ
	bLhyHm+5PG7hlBr5EmS/klxC9Uxz+JSLVRNoOVlocPGIYvibO+CZzFO3OT3E19heZCegeLydV4wuB
	2mG/ioijUJTG7Tpy3JglrH7Lf4XcB5xL4kq7lmTSmdxaqiXYREeKlj8pCemAu3nXX5YjBbyDujC4t
	MDXewXspHD/82nNcJ4Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7scI-004Osx-02;
	Tue, 28 Nov 2023 07:34:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7scE-004Os8-1o
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 07:34:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OguxvPhmIBoZQOm1YAs1KZATE7vclINtSzPsNknfn1Q=;
	b=go8Fl5lsNVgIPgyL1c/2GC8UYHRCRjSYwpEiTvgWy5pjj4DGeaO6kGlAPN0MYY4T9iIDYc
	Sik9DAFxIPMHoNnPy6jrJdai2kVC7TDf5d2/Vl7KeZ9f+6lyDkhHJ1YGx3w0RXxVtFR8EX
	Q3aY2L9s0lYDnifbf8+LaV4igytK2MY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-tZ0bR6CoP1e88YaGQA1QVg-1; Tue, 28 Nov 2023 02:34:37 -0500
X-MC-Unique: tZ0bR6CoP1e88YaGQA1QVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97B9281B164;
	Tue, 28 Nov 2023 07:34:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D652B492BFA;
	Tue, 28 Nov 2023 07:34:35 +0000 (UTC)
Date: Tue, 28 Nov 2023 15:34:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>, k-hagio-ab@nec.com
Cc: Huang Shijie <shijie@os.amperecomputing.com>, lijiang@redhat.com,
	akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
 <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_233442_694990_65FD5D19 
X-CRM114-Status: GOOD (  18.88  )
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

T24gMTEvMjgvMjMgYXQgMTE6MzFhbSwgU2hpamllIEh1YW5nIHdyb3RlOgo+IAo+IOWcqCAyMDIz
LzExLzI4IDExOjI1LCBCYW9xdWFuIEhlIOWGmemBkzoKPiA+IE9uIDExLzI3LzIzIGF0IDExOjE4
YW0sIFNoaWppZSBIdWFuZyB3cm90ZToKPiA+ID4g5ZyoIDIwMjMvMTEvMjcgMTA6NTEsIEJhb3F1
YW4gSGUg5YaZ6YGTOgo+ID4gPiA+IEhpLAo+ID4gPiA+IAo+ID4gPiA+IE9uIDExLzI3LzIzIGF0
IDEwOjA3YW0sIEh1YW5nIFNoaWppZSB3cm90ZToKPiA+ID4gPiA+IEluIG1lbW9yeV9tb2RlbC5o
LCBpZiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgY29uZmlnZWQsCj4gPiA+ID4gPiBrZXJu
ZWwgd2lsbCB1c2Ugdm1lbW1hcCB0byBkbyB0aGUgX19wZm5fdG9fcGFnZS9wYWdlX3RvX3BmbiwK
PiA+ID4gPiA+IGFuZCBrZXJuZWwgd2lsbCBub3QgdXNlIHRoZSAiY2xhc3NpYyBzcGFyc2UiIHRv
IGRvIHRoZQo+ID4gPiA+ID4gX19wZm5fdG9fcGFnZS9wYWdlX3RvX3Bmbi4KPiA+ID4gPiA+IAo+
ID4gPiA+ID4gU28gZXhwb3J0IHRoZSB2bWVtbWFwIHdoZW4gQ09ORklHX1NQQVJTRU1FTV9WTUVN
TUFQIGlzIGNvbmZpZ2VkLgo+ID4gPiA+ID4gVGhpcyBtYWtlcyB0aGUgdXNlciBhcHBsaWNhdGlv
bnMgKGNyYXNoLCBldGMpIGdldCBmYXN0ZXIKPiA+ID4gPiA+IHBmbl90b19wYWdlL3BhZ2VfdG9f
cGZuIG9wZXJhdGlvbnMgdG9vLgo+ID4gPiA+IEFyZSB0aGVyZSBDcmFzaCBvciBtYWtlZHVwZmls
ZSBwYXRjaGVzIHBvc3RlZCB5ZXQgdG8gbWFrZSB1c2Ugb2YgdGhpcz8KPiA+ID4gSSBoYXZlIHBh
dGNoZXMgZm9yIENyYXNoIHRvIHVzZSB0aGUgJ3ZtZW1tYXAnLCBidXQgYWZ0ZXIgdGhpcyBwYXRj
aCBpcwo+ID4gPiBtZXJnZWQsIEkgd2lsbCBzZW5kIGl0IG91dC4KPiA+ID4gCj4gPiA+IChJIHRo
aW5rIEthenUgd2lsbCBub3QgbWVyZ2UgYSBjcmFzaCBwYXRjaCB3aGljaCBkZXBlbmRzIG9uIGEg
a2VybmVsIHBhdGNoCj4gPiA+IHdoaWNoIGlzIG5vdCBtZXJnZWQuKQo+ID4gTWF5YmUgcG9zdCB0
aGVzZSB1c2Vyc3BhY2UgcGF0Y2hlcyB0b28gc28gdGhhdCBLYXp1IGNhbiBldmFsdWF0IGlmIHRo
b3NlCj4gPiBpbXByb3ZlbWVudCBpcyBuZWNlc3Nhcnk/Cj4gCj4gTm8gcHJvYmxlbS7CoCBJIHdp
bGwgc2VuZCBvdXQgdGhlbSBsYXRlci4KClRoYW5rLCBTaGlqaWUuIExldCdzIHdhaXQgYW5kIHNl
ZSBpZiBLYXp1IGhhcyBhbnkgY29tbWVudCBhYm91dCB0aGVzZS4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
