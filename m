Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB805D3E779
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QFGj/piONJfWMeXFSxUvVzez90ZzjmfacnUBjCbEjw8=; b=1LCZVGUBJqOUDw
	g9zBAi1Wm4rgnR0woxT1nj9HlocMRmS8PbQ+rRppdXnpZ1t/cV8HSfilpYgViEAqj9i4uccEmBIhT
	AfwV8aAbK7TvMX4WatlJ1kYA7Vcz5H5CSu3KBXhzUc7NddqcLT9njq+yttGXElz5ewNq4V4PmEqIB
	bq6IvfI66Ne9+vxQytKgbRlKmZFMs2R9a1TeMoSv6tMLvZ/uq1l7VMJuAJXovMlLYAV63TdDVddet
	41ZjD3jl1cURHx6o/XVWdZoOGmvFKwlWPgFrXoJ+I7XVvjiJ5R5jMSXJVTKrOFFmIuuAj6/9D7Q3c
	dHpd8+7FzRueLdDh942w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8RjU-00000000xcm-0LjI;
	Tue, 05 Nov 2024 22:09:04 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8RjR-00000000xbo-0U5E
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 22:09:02 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5M8Z5R406734
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:08:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5M8Z5R406734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730844516;
	bh=xEQJl61nQgL9Mc2J5Xlg5+cKjUWmOQVy7uKugjfcPH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gsDCBzTMgLM7pK5+rpvw5GMtcFOp95L+gGRAU7IPWJy1jVgM8q4g6wgstxxx5T8Ht
	 uZXhIj34EdJwHof4hiA9vcW1fD53lbFbG79emWuan9T2No50Qgj6JsrahCFakItwwU
	 +W/Q6AgQBRfLznb2T+TYMCSQE5WTizdbOG4MNCsaHNfhhz4KYPb6jKDpdLu+f5EBF2
	 moHWtjVkPk9mgYBpwVwY4OF/pDrJgmQuqmq4wj846VFZa+7wFjs6imOd8FaKrJZox9
	 rTa/tD96J9LLtK9Knavdj6kCViVhQXeBs73fQtDJTIGSXvRixW6ZUwNhFxCPpK0hZY
	 PlKt3OD2W2XLQ==
Date: Tue, 05 Nov 2024 14:08:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Woodhouse <dwmw2@infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A__=5BRFC_PATCH_6/7=5D_x86/kexec=3A_Debuggi?=
 =?US-ASCII?Q?ng_support=3A_Dump_registers_on_exception?=
User-Agent: K-9 Mail for Android
In-Reply-To: <07117fe234cb1396a59bdb815ada26a90e02b394.camel@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk> <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com> <07117fe234cb1396a59bdb815ada26a90e02b394.camel@infradead.org>
Message-ID: <3008CD3D-FF34-4FD1-83EB-DD74398685A5@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_140901_184070_D4199E8A 
X-CRM114-Status: GOOD (  21.31  )
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

T24gTm92ZW1iZXIgNSwgMjAyNCAxOjI5OjU0IFBNIFBTVCwgRGF2aWQgV29vZGhvdXNlIDxkd213
MkBpbmZyYWRlYWQub3JnPiB3cm90ZToKPk9uIFR1ZSwgMjAyNC0xMS0wNSBhdCAxMjo1MCAtMDgw
MCwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4+IE9uIE5vdmVtYmVyIDUsIDIwMjQgMTI6Mzg6MTAg
UE0gUFNULCAiV29vZGhvdXNlLCBEYXZpZCIgPGR3bXdAYW1hem9uLmNvLnVrPiB3cm90ZToKPj4g
PiBPbiBTdW4sIDIwMjQtMTEtMDMgYXQgMDU6MzUgKzAwMDAsIERhdmlkIFdvb2Rob3VzZSB3cm90
ZToKPj4gPiA+IAo+PiA+ID4gKwo+PiA+ID4gKy8qIFByaW50IHRoZSBieXRlIGluICVibCwgY2xv
YmJlciAlcmF4ICovCj4+ID4gPiArU1lNX0NPREVfU1RBUlRfTE9DQUxfTk9BTElHTihwcl9ieXRl
KQo+PiA+ID4gK8KgwqDCoMKgwqDCoCBtb3ZiwqDCoMKgICVibCwgJWFsCj4+ID4gPiArwqDCoMKg
wqDCoMKgIG5vcAo+PiA+ID4gK8KgwqDCoMKgwqDCoCBhbmRiwqDCoMKgICQweDBmLCAlYWwKPj4g
PiA+ICvCoMKgwqDCoMKgwqAgYWRkYsKgwqDCoCAkMHgzMCwgJWFsCj4+ID4gPiArwqDCoMKgwqDC
oMKgIGNtcGLCoMKgwqAgJDB4M2EsICVhbAo+PiA+ID4gK8KgwqDCoMKgwqDCoCBqYsKgwqDCoMKg
wqAgMWYKPj4gPiA+ICvCoMKgwqDCoMKgwqAgYWRkYsKgwqDCoCAkKCdhJyAtICcwJyAtIDEwKSwg
JWFsCj4+ID4gPiArMTrCoMKgwqDCoCBwcl9jaGFyCj4+ID4gPiArwqDCoMKgwqDCoMKgIEFOTk9U
QVRFX1VOUkVUX1NBRkUKPj4gPiA+ICvCoMKgwqDCoMKgwqAgcmV0Cj4+ID4gPiArU1lNX0NPREVf
RU5EKHByX2J5dGUpCj4+ID4gPiArCj4+ID4gCj4+ID4gT2J2aW91c2x5IHRoYXQgZnVuY3Rpb24g
bmFtZSAoYW5kIGNvbW1lbnQpIGFyZSB3cm9uZzsgZml4ZWQgaW4gbXkgdHJlZS4KPj4gPiBhdAo+
PiA+IGh0dHBzOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvZHdtdzIvbGludXguZ2l0L3Nob3J0
bG9nL3JlZnMvaGVhZHMva2V4ZWMtZGVidWcKPj4gPiAKPj4gPiBUaGlzIGZ1bmN0aW9uIChhbmQg
YWxzbyBwcl9xd29yZCkgYXJlIGFsc28gd2hhdCBvYmp0b29sIGlzIGNvbXBsYWluaW5nCj4+ID4g
YWJvdXQ6Cj4+ID4gCj4+ID4gdm1saW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiByZWxvY2F0ZV9y
YW5nZSsweDJmNjogdW5yZWFjaGFibGUgaW5zdHJ1Y3Rpb24KPj4gPiB2bWxpbnV4Lm86IHdhcm5p
bmc6IG9ianRvb2w6IHJlbG9jYXRlX3JhbmdlKzB4MzA1OiB1bnJlYWNoYWJsZSBpbnN0cnVjdGlv
bgo+PiA+IAo+PiA+IEkgZG9uJ3QgcXVpdGUgc2VlIHdoeSwgYmVjYXVzZSBwcl9xd29yZCgpIHF1
aXRlIGJsYXRhbnRseSBjYWxscwo+PiA+IHByX255YmxsZSgpLCBhcyBpdCdzIG5vdyBuYW1lZC4g
QW5kIGV4Y19oYW5kbGVyKCkgcmVwZWF0ZWRseSBjYWxscwo+PiA+IHByX3F3b3JkKCkuCj4+ID4g
Cj4+ID4gQnV0IG1vc3Qgb2YgdGhlIG9ianRvb2wgYW5ub3RhdGlvbnMgSSd2ZSBhZGRlZCBoZXJl
IHdlcmUganVzdCB0byBtYWtlCj4+ID4gaXQgc2h1dCB1cCBhbmQgYnVpbGQsIHdpdGhvdXQgbXVj
aCB0aG91Z2guIFBldGVyLCBKb3NoLCBhbnkgY2hhbmNlIHlvdQo+PiA+IGNhbiBoZWxwIG1lIGZp
eCBpdCB1cCBwbGVhc2U/Cj4+ID4gCj4+ID4gSXQgd291bGQgYWxzbyBiZSByZWFsbHkgdXNlZnVs
IGlmIG9ianRvb2wgd291bGQgbGV0IG1lIGhhdmUgZGF0YSBpbnNpZGUKPj4gPiBhICJjb2RlIiBz
ZWdtZW50LCB3aXRob3V0IGNvbXBsYWluaW5nIHRoYXQgaXQgY2FuJ3QgZGVjb2RlIGl0IGFzCj4+
ID4gaW5zdHJ1Y3Rpb25zIOKAlCBhbmQgd2l0aG91dCBhbHNvIGZhaWxpbmcgdG8gZGVjb2RlIHRo
ZSBmaXJzdCBpbnN0cnVjdGlvbgo+PiA+IG9mIHRoZSAqc3Vic2VxdWVudCogZnVuY3Rpb24uIEkn
dmUgcHV0IHRoZSBHRFQgYXQgdGhlIGVuZCB0byB3b3JrCj4+ID4gYXJvdW5kIHRoYXQsIGJ1dCBp
dCdzIGEgYml0IG5hc3R5Lgo+PiAKPj4gY29kZSBpbiB0aGUgZGF0YSAqc2VjdGlvbiogb3IgKnNl
Z21lbnQqPyBFaXRoZXIgaXMgbmFzdHksIHRob3VnaC4gVGhhdCdzIHdoYXQgLnJvZGF0YSBpcyBm
b3IuCj4KPlRoaXMgaXMgdGhlIHJlbG9jYXRlX2tlcm5lbCgpIGZ1bmN0aW9uIGluCj5hcmNoL3g4
Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMKPgo+SXQncyBjb3BpZWQgaW50byBhIHNlcGFy
YXRlIHBhZ2UsIGNhbGxlZCAoaW4gaXRzIG9yaWdpbmFsIGxvY2F0aW9uKSBhcwo+YSBzaW1wbGUg
ZnVuY3Rpb24gZnJvbSB0aGUga2VybmVsLCBjaGFuZ2VzICVjcjMgdG8gc2V0IG9mIGlkZW50aXR5
LQo+bWFwcGVkIHBhZ2UgdGFibGVzIGFuZCBqdW1wcyB0byBpdHMgKmlkZW50aXR5LW1hcHBlZCog
YWRkcmVzcywgdGhlbgo+Y29waWVzIGFsbCB0aGUgcmlnaHQgcGFnZXMgZm9yIGtleGVjIGFuZCBq
dW1wcyBpbnRvIHRoZSBuZXcga2VybmVsLgo+Cj5TbyBpdCdzIGFsbCBpbiBhIHNpbmdsZSBwYWdl
LCBhbmQgY3VycmVudGx5IGl0IHBsYXlzIG5hc3R5IHRyaWNrcyB0bwo+c3RvcmUgZGF0YSBhZnRl
ciB0aGUgY29kZS4gUGVyaGFwcyBpdCAqc2hvdWxkKiBoYXZlIGl0cyBvd24gY29kZSBhbmQKPmRh
dGEgc2VjdGlvbnMgYW5kIGEgbGlua2VyIHNjcmlwdCB0byBrZWVwIHRoZW0gdG9nZXRoZXIuLi4K
ClllcywgaXQgc2hvdWxkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
