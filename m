Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E8C61DA4
	for <kexec@archiver.kernel.org>; Wed, 15 Feb 2023 03:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6OkSHffDbWO9789S89qywPxvQRzyYNLHbwtuJITewWI=; b=n9JFQOtGJyn9U8
	N26agr1h46JXCHr5VkZVVGvvhMdOWu6mple2t3hMYAVX832RB0kDP2CkkwW8Kx3sIluMARo781fGi
	yzjQwqm61PmlTI4eAMeog7ypnRs0L/Vo/wmjWQ9jToNid6oKmg6AewUI7GuTVdPJBt8a4J7PxK7cl
	yPuuznG3P1iPzZvzrRFr8c/fT4nDLeA05RIs8MZwE85efcgFVwhJJjnHIUjv6DfLfcqHo/zdfKgeA
	HCiPLEbKdkeWAboJYTBS+/8osU8BzQSd4VraYQKeRYBbuUFKhh/aQvH+jGsMaf0l2h0hKQeUZ9gGe
	3PEALiN7A9Wc2cFJCyCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS86k-004U2m-Qo; Wed, 15 Feb 2023 03:05:22 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS86h-004U1G-P7
	for kexec@lists.infradead.org; Wed, 15 Feb 2023 03:05:21 +0000
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PGjYX52CNzRs5G;
	Wed, 15 Feb 2023 11:02:40 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 11:05:12 +0800
Message-ID: <abe55a65-1ab9-39ca-2cca-3190c6ba2e21@huawei.com>
Date: Wed, 15 Feb 2023 11:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <bp@alien8.de>, <jroedel@suse.de>, <vbabka@suse.cz>,
	<hpa@zytor.com>, <tglx@linutronix.de>, <eric.devolder@oracle.com>,
	<tiwai@suse.de>, <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <liwei391@huawei.com>,
	<xiexiuqi@huawei.com>, <kexec@lists.infradead.org>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
 <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
 <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
 <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_190520_005047_430E4A9A 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

CuWcqCAyMDIzLzIvMTUgOTowMSwgQmFvcXVhbiBIZSDlhpnpgZM6Cj4gQWRkIGtleGVjIGxpc3Qg
dG8gQ0MuCj4KPiBPbiAwMi8xNC8yMyBhdCAxMDo0OWFtLCBQZXRlciBaaWpsc3RyYSB3cm90ZToK
Pj4gT24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMDU6MzA6NDZQTSArMDgwMCwgWmVuZyBIZW5nIHdy
b3RlOgo+Pgo+Pj4+IEkgbmV2ZXIgcmVtZW1iZXIgdGhlIHNodXRkb3duIHBhdGhzIC0tIGRvIHdl
IGZvcmNlIHdpcGUgdGhlIFBNVQo+Pj4+IHJlZ2lzdGVycyBzb21ld2hlcmUgYmVmb3JlIHRoaXM/
Cj4+PiBJIGhhdmUgY2hlY2tlZCB0aGUgcGFuaWMgcHJvY2VzcywgYW5kIHRoZXJlIGlzIG5vIHdp
cGUgb3BlcmF0aW9uIGZvciBQTVUKPj4+IHJlZ2lzdGVycywKPj4+Cj4+PiB3aGljaCBjYXVzZXMg
dGhlIHdhdGNoZG9nIGJpdGVzLgo+Pj4KPj4+IERvIHlvdSBtZWFuIHdlIHNob3VsZCBkaXJlY3Rs
eSBkaXNhYmxlIFBNVSByZWdpc3RlcnMgaW5zdGVhZCBvZiBjYWxsaW5nCj4+PiBgaXJldF90b19z
ZWxmYCB0bwo+Pj4KPj4+IGNvbnN1bWUgYmxvY2tlZCBOTUkgaW50ZXJydXB0cyA/Cj4+IElmIHlv
dSBkb24ndCB3aXBlIHRoZSBQTVUsIHRoZXJlIHdpbGwgYmUgbWFueSBhbmQgY29udGludW91cyBO
TUlzLCBhCj4+IHNpbmdsZSBJUkVULXRvLVNFTEYgaXNuJ3QgZ29pbmcgdG8gc2FmZSB5b3UuCj4+
Cj4+IEFueXdheSwgSSBoYWQgYSBiaXQgb2YgYSBncmVwIGFyb3VuZCBhbmQgSSBmaW5kIHdlIGhh
dmU6Cj4+Cj4+ICAgIGtlcm5lbC9ldmVudHMvY29yZS5jOiAgIHJlZ2lzdGVyX3JlYm9vdF9ub3Rp
ZmllcigmcGVyZl9yZWJvb3Rfbm90aWZpZXIpOwo+Pgo+PiB3aGljaCBzaG91bGQgZW5kIHVwIGtp
bGxpbmcgYWxsIHRoZSBQTVUgYWN0aXZpdHkuIFNvbWV3aGVyZSBhcm91bmQgdGhlcmUKPj4gdGhl
cmUncyBhbHNvIGEgQ09ORklHX0tFWEVDX0NPUkUgaWZkZWYsIHNvIEknbSB0aGlua2luZyBpdCBn
ZXRzIGNhbGxlZAo+PiBvbiB0aGUgcGFuaWMtPmNyYXNoLWtlcm5lbCBwYXRoIHRvbz8KPiBObywg
cmVib290X25vdGlmaWVyX2xpc3QgaXMgb25seSBoYW5kbGVkIGluIGtleGVjIHJlYm9vdC9yZWJv
b3QgcGF0aCwKPiBwbGVhc2Ugc2VlIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUoKSBpbnZvY2F0aW9u
LiBLZHVtcCBwYXRoIG9ubHkgc2h1dGRvd24KPiBrZXkgY29tcG9uZW50IGxpa2UgY3B1LCBpbnRl
cnJ1cHQgY29udHJvbGxlci4KCkkgd291bGQgcmVwbGFjZSBpcmV0X3RvX3NlbGYoKSB3aXRoIHBl
cmZfZXZlbnRfZXhpdF9jcHUoKSBpbiBrZHVtcCBzaHV0ZG93bgoKcGF0aCAoaW4gbmF0aXZlX21h
Y2hpbmVfY3Jhc2hfc2h1dGRvd24oKSkuCgoKQWZ0ZXIgdGVzdCwgSSB3b3VsZCBzZW5kIHY0IGxh
dGVyLgoKVGhhbmtzIGFsbCwKClplbmcgSGVuZwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
