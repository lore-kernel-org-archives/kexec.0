Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF9C433EF
	for <kexec@archiver.kernel.org>; Tue,  5 Jul 2022 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jDQ0rJRcyAZiEkV+YMvws0tOXTbhS1mptOWPGSB4hMI=; b=V1ZbaC02lbKiJF
	p6ug/vn63lyBbB3O2VYFaJDlB0Rw6jtJXHqVJuoE7jTzLkRVJoj5u3sXOVIOb6AkzwLWzAvfl5XX2
	YSpvwz3j/WYWI6vxeu8KG220NrjrqQUxF2mZPX3bfHZW8fYS9G9et/jQVJja2OWZfhTGwdaPItJl1
	oUVqfEy5gsedUrj9CZE5hSt4GpaLcK46wBJys9OV8VK+mqhlDbgbw+bLoly0i4s50iLhEOy3TBM2W
	0TGxcLyAzY+M7KVN3qHTWCJQQT+gW+UXMBjiF/voD3slfoyWGuLz0n8E1ygHaozIMdf5o1LquzlO0
	TUtKJSUFoBjx4oKXKIHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e29-00GF7i-8d; Tue, 05 Jul 2022 08:35:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e1z-00GF3f-2s
	for kexec@lists.infradead.org; Tue, 05 Jul 2022 08:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657010137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z2UhLA9zTx8MYx+v6FOVFe00lHXS/rANJnQv0UrSL8=;
	b=Lb0Ijn52dkYUMGeau4S7lCeV/WpbOH24EtKBHXrxVilNt88oATZKLneJzx/v8Iwdu9G/mU
	fzXJC3gKq4NRejmNBvZU6kp7Ek8Hlsu53FFUHoorVueaaRuBBvr6UsaYvPCQfHWhJNZUW1
	7ahLFo9U15Qk749op5kjcZkG502g0vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-uU9BWdGCPfue2BuqLtC7dg-1; Tue, 05 Jul 2022 04:35:24 -0400
X-MC-Unique: uU9BWdGCPfue2BuqLtC7dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C311C85A581;
	Tue,  5 Jul 2022 08:35:23 +0000 (UTC)
Received: from localhost (ovpn-13-74.pek2.redhat.com [10.72.13.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 393584010D28;
	Tue,  5 Jul 2022 08:35:22 +0000 (UTC)
Date: Tue, 5 Jul 2022 16:35:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, kexec@lists.infradead.org,
	"guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
	baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
	akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
	james.morse@arm.com, quic_qiancai@quicinc.com,
	christophe.leroy@csgroup.eu, jonathan@marek.ca,
	mark.rutland@arm.com, thunder.leizhen@huawei.com,
	anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rppt@kernel.org,
	geert+renesas@glider.be, linux-mm@kvack.org,
	yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsP3xnpyPON9KsMQ@MiWiFi-R3L-srv>
References: <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_013539_225206_BEC7B1D7 
X-CRM114-Status: GOOD (  30.77  )
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

T24gMDcvMDQvMjIgYXQgMDc6MDlwbSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gT24gTW9uLCA0
IEp1bCAyMDIyIGF0IDE4OjM4LCBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPiB3cm90ZToK
PiA+Cj4gPiBPbiBNb24sIEp1bCAwNCwgMjAyMiBhdCAxMDozNDowN1BNICswODAwLCBndWFuZ2h1
aS5mZ2ggd3JvdGU6Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4g5ZyoIDIwMjIvNy80IDIyOjIz
LCBXaWxsIERlYWNvbiDlhpnpgZM6Cj4gPiA+ID4gT24gTW9uLCBKdWwgMDQsIDIwMjIgYXQgMTA6
MTE6MjdQTSArMDgwMCwgZ3VhbmdodWkuZmdoIHdyb3RlOgo+IC4uLgo+ID4gPiA+ID4gTmFtZWx5
LCBpdCdzIG5lZWQgdG8gdXNlIG5vbiBibG9jay9zZWN0aW9uIG1hcHBpbmcgZm9yIGNyYXNoa2Vy
bmVsIG1lbQo+ID4gPiA+ID4gYmVmb3JlIHNocmluZ2tpbmcuCj4gPiA+ID4KPiA+ID4gPiBXZWxs
LCB5ZXMsIGJ1dCB3ZSBjYW4gY2hhbmdlIGFyY2hfa2V4ZWNfW3VuXXByb3RlY3RfY3Jhc2hrcmVz
KCkgbm90IHRvIGRvCj4gPiA+ID4gdGhhdCBpZiB3ZSdyZSBsZWF2aW5nIHRoZSB0aGluZyBtYXBw
ZWQsIG5vPwo+ID4gPiA+Cj4gPiA+IEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBhcmNoX2tleGVjX1t1
bl1wcm90ZWN0X2NyYXNoa3JlcyBmb3IgY3Jhc2hrZXJuZWwgbWVtLgo+ID4gPgo+ID4gPiBCZWNh
dXNlIHdoZW4gaW52YWxpZCBjcmFzaGtlcm5lbCBtZW0gcGFnZXRhYmxlLCB0aGVyZSBpcyBubyBj
aGFuY2UgdG8gcmQvd3IKPiA+ID4gdGhlIGNyYXNoa2VybmVsIG1lbSBieSBtaXN0YWtlLgo+ID4g
Pgo+ID4gPiBJZiB3ZSBkb24ndCB1c2UgYXJjaF9rZXhlY19bdW5dcHJvdGVjdF9jcmFzaGtyZXMg
dG8gaW52YWxpZCBjcmFzaGtlcm5lbCBtZW0KPiA+ID4gcGFnZXRhYmxlLCB0aGVyZSBtYXliZSBz
b21lIHdyaXRlIG9wZXJhdGlvbnMgdG8gdGhlc2UgbWVtIGJ5IG1pc3Rha2Ugd2hpY2gKPiA+ID4g
bWF5IGNhdXNlIGNyYXNoa2VybmVsIGJvb3QgZXJyb3IgYW5kIHZtY29yZSBzYXZpbmcgZXJyb3Iu
Cj4gPgo+ID4gSSBkb24ndCByZWFsbHkgYnV5IHRoaXMgbGluZSBvZiByZWFzb25pbmcuIFRoZSBl
bnRpcmUgbWFpbiBrZXJuZWwgaXMKPiA+IHdyaXRhYmxlLCBzbyB3aHkgZG8gd2UgY2FyZSBhYm91
dCBwcm90ZWN0aW5nIHRoZSBjcmFzaGtlcm5lbCBzbyBtdWNoPyBUaGUKPiA+IF9jb2RlXyB0byBs
YXVuY2ggdGhlIGNyYXNoIGtlcm5lbCBpcyB3cml0YWJsZSEgSWYgeW91IGNhcmUgYWJvdXQgcHJl
dmVudGluZwo+ID4gd3JpdGVzIHRvIG1lbW9yeSB3aGljaCBzaG91bGQgbm90IGJlIHdyaXRhYmxl
LCB0aGVuIHlvdSBzaG91bGQgdXNlCj4gPiByb2RhdGE9ZnVsbC4KPiA+Cj4gCj4gVGhpcyBpcyBu
b3QgZW50aXJlbHkgdHJ1ZSAtIHRoZSBjb3JlIGtlcm5lbCB0ZXh0IGFuZCByb2RhdGEgYXJlCj4g
cmVtYXBwZWQgci9vIGluIHRoZSBsaW5lYXIgbWFwLCB3aGVyZWFzIGFsbCBtb2R1bGUgY29kZSBh
bmQgcm9kYXRhIGFyZQo+IGxlZnQgd3JpdGFibGUgd2hlbiByb2RhdGEgIT0gZnVsbC4KPiAKPiBC
dXQgdGhlIGNvbmNsdXNpb24gaXMgdGhlIHNhbWUsIGltbzogaWYgeW91IGNhbid0IGJlIGJvdGhl
cmVkIHRvCj4gcHJvdGVjdCBhIGdvb2QgY2h1bmsgb2YgdGhlIGNvZGUgYW5kIHJvZGF0YSB0aGF0
IHRoZSBrZXJuZWwgcmVsaWVzIG9uLAo+IHdoeSBzaG91bGQgdGhlIGNyYXNoa2VybmVsIGJlIHRy
ZWF0ZWQgYW55IGRpZmZlcmVudGx5PwoKS2VybmVsIHRleHQgYW5kIHJvZGF0YSBhcmUgcmVtYXBw
ZWQgci9vIGluIGxpbmVhciBtYXAsIHdoZXJlYXMKbW9kdWxlIGNvZGUgYW5kIHJvZGF0YSBhcmUg
bGVmdCB3cml0YWJsZSwgaXQncyBkaWZmZXJlbnQgY29uY2VwdAp0aGFuIGNyYXNoa2VybmVsIHJl
Z2lvbiBiZWluZyBtYXBwZWQgci9vLgoKSWYgaXQncyBkb2FibGUgaW4gdGVjaG5vbG9neSB0byBy
ZW1hcCBtb2R1bGUgY29kZSBhbmQgcm9kYXRhIHIvbywgYW5kCnN0YW1waW5nIGludG8gdGhvc2Ug
cmVnaW9ucyB3aWxsIGNvcnJ1cHQgdGhlIGVudGlyZSBzeXN0ZW0sIHdlIHNob3VsZCBkbwppdCB0
b28uIEhvd2V2ZXIsIGtkdW1wIGlzIGEgc3lzdGVtIGVycm9yIGRpYWdvbm9zaW5nIG1lY2hhbmlz
bSB3aGljaCBpcwp2ZXJ5IGltcG9ydGFudCBhbmQgaGVscGZ1bCBvbiBzZXJ2ZXIsIG9yIHNvbWUg
YXBwbGljYXRpb24gc2NlbmFyaW9zLCBlLmcKY2xvdWQuIFN0YW1waW5nIGludG8gY3Jhc2hrZXJu
ZWwgcmVnaW9uIHdpbGwgbWFrZSBpdCB1c2VsZXNzLgoKSSBhbSBub3QgYWdhaW5zdCByZW1vdmlu
ZyB0aGUgYXJjaF9rZXhlY19bdW5dcHJvdGVjdF9jcmFzaGtyZXMgb24gYXJtNjQuCkl0IGlzIGEg
YmFsYW5jZToKClByb3RlY3RpbmcgdGhlIGNyYXNoa2VybmVsIHJlZ2lvbiwgY2F1c2Vpbmcgc2V2
ZXJlIHBlcmZvcm1hbmNlCmRlZ3JhZGF0aW9uLiBUaGlzIGlzIGFsd2F5cyBmZWx0IHNpbmNlIHdl
IHVzdWFsbHkgZG9uJ3Qgc3BlY2lmeSByb2RhdGEKYW5kIGVuYWJsZSBrZmVuY2UuCgpUYWtpbmcg
b2ZmIHRoZSBwcm90ZWN0aW5nIG9mIGNyYXNoa2VybmVsIHJlZ2lvbiwgcGVyZm9ybWFuY2UgaW1w
cm92ZWQKdmVyeSBtdWNoLCB3aGlsZSB3cm9uZyBjb2RlIG1heSBzdGFtcCBpbnRvIGNyYXNoa2Vy
bmVsIHJlZ2lvbiBhbmQgZmFpbAprZHVtcC4gVGhhdCBjb3VsZCBoYXBwZW4gb25lIGluIGEgbWls
bGlvbi4gT25jZSBoYXBwZW4sIGl0J3MgYSBuaWdodG1hcmUKb2Yga2VybmVsIGRldi4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
