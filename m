Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28171E70700
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OcUEBHdGaAkLi/Q2XRcYJR3rPwmmhMtMxHYLLpp6uJ8=; b=3CXg0Fzr2C2RS/
	zKmdL1dzmT1Gi3Hu5DKWwASftXgAp0pDx6gJLoA5v+if0ZyGdmIyA3S6RNYTlMOSTjNu/xtxIEzIy
	r+qnxiK5sl8UBeAUfawxnzC3nXTnDmlmzbCJ/mOLICmWm8JHSihLA3RlYHOxmV0nVM/PSruIbm+7+
	LEfDwQqZyv+mkThoW28TNXWYKjAJ1/1IGT0JsXNByH1vZihoraGMbao6IzKW2K0Bvt0d5J4c1HJFB
	eZI1NzWyOB6qekzeP9IFOy06jVqHvnQE2xTkZIYZtjmHD1zu8BIC+TnH1i5BevZ+bt+UeOas8jz4o
	G6Cpnay/V7prsapMzB3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGON-005dhg-0H;
	Thu, 21 Sep 2023 09:54:39 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGOI-005dgf-1I
	for kexec@lists.infradead.org;
	Thu, 21 Sep 2023 09:54:37 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qjGO1-0004Ii-45; Thu, 21 Sep 2023 11:54:17 +0200
Message-ID: <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
Date: Thu, 21 Sep 2023 11:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Content-Language: en-US, de-DE
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>,
 Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Borislav Petkov <bp@alien8.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, kexec@lists.infradead.org,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
References: <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <20230913142410.dfqsg3l5v44mr5j3@box>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230913142410.dfqsg3l5v44mr5j3@box>
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695290074;381061ec;
X-HE-SMSGID: 1qjGO1-0004Ii-45
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_025434_579837_D687C0EF 
X-CRM114-Status: GOOD (  10.89  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMTMuMDkuMjMgMTY6MjQsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPiBPbiBNb24sIFNl
cCAxMSwgMjAyMyBhdCAwNTo1NzowN1BNICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6
Cj4+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDEwOjU2OjM2UE0gKzA4MDAsIERhdmUgWW91bmcg
d3JvdGU6Cj4+Pj4gZWFybHkgY29uc29sZSBpbiBleHRyYWN0X2tlcm5lbAo+Pj4+IGlucHV0X2Rh
dGE6IDB4MDAwMDAwODA3ZWI0MzNhOAo+Pj4+IGlucHV0X2xlbjogMHgwMDAwMDAwMDAwZDI2Mjcx
Cj4+Pj4gb3V0cHV0OiAweDAwMDAwMDgwN2IwMDAwMDAKPj4+PiBvdXRwdXRfbGVuOiAweDAwMDAw
MDAwMDQ4MDBjMTAKPj4+PiBrZXJuZWxfdG90YWxfc2l6ZTogMHgwMDAwMDAwMDAzZTI4MDAwCj4+
Pj4gbmVlZGVkX3NpemU6IDB4MDAwMDAwMDAwNGEwMDAwMAo+Pj4+IHRyYW1wb2xpbmVfMzJiaXQ6
IDB4MDAwMDAwMDAwMDA5ZDAwMAo+Pj4+Cj4+Pj4gRGVjb21wcmVzc2luZyBMaW51eC4uLiBvdXQg
b2YgcGd0X2J1ZiBpbiBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaWRlbnRfbWFwXzY0LmMhPwo+
Pj4+IHBhZ2VzLT5wZ3RfYnVmX29mZnNldDogMHgwMDAwMDAwMDAwMDA2MDAwCj4+Pj4gcGFnZXMt
PnBndF9idWZfc2l6ZTogMHgwMDAwMDAwMDAwMDA2MDAwCj4+Pj4KPj4+PiBFcnJvcjoga2VybmVs
X2lkZW50X21hcHBpbmdfaW5pdCgpIGZhaWxlZAo+IFsuLi5dCj4+IFRoZSBwcm9ibGVtIGlzIG5v
dCBsaW1pdGVkIHRvIHVuYWNjZXB0ZWQgbWVtb3J5LCBpdCBhbHNvIHRyaWdnZXJzIGlmIHdlCj4+
IHJlYWNoIGVmaV9nZXRfcnNkcF9hZGRyKCkgaW4gdGhlIHNhbWUgc2V0dXAuCj4+Cj4+IEkgdGhp
bmsgd2UgaGF2ZSBzZXZlcmFsIHByb2JsZW1zIGhlcmUuCj4gWy4uLl0KPj4gQW55IGNvbW1lbnRz
Pwo+IAo+IEkgc3RydWdnbGUgdG8gY29tZSB1cCB3aXRoIGFueXRoaW5nIGJldHRlciB0aGFuIGlu
Y3JlYXNpbmcgdGhlIGNvbnN0YW50IHRvCj4gYSB2YWx1ZSB0aGF0ICJvdWdodCB0byBiZSBlbm91
Z2ggZm9yIGFueWJvZHkiIMKpLCBsZXQncyBzYXkgMTI4Sy4KPiAKPiBBbmQgd2UgY2FuIGVsaW1p
bmF0ZSBsb2dpYyBvbiBuby1LQVNMUiB2cy4gS0FTTFIgdnMuIEtBU0xSK1ZFUkJPU0VfQk9PVFVQ
Lgo+IAo+IE9iamVjdGlvbnM/CgpBcHBhcmVudGx5IG5vdCwgYXMgdGhlcmUgd2FzIG5vIHJlcGx5
IHNpbmNlIHRoZW4gKHdoaWNoIGlzIHdoeSBJIHNob3cgdXAKaGVyZSwgYXMgaXQgbG9va2VkIGxp
a2UgZml4aW5nIHRoaXMgcmVncmVzc2lvbiBzdGFsbGVkKS4KCkNpYW8sIFRob3JzdGVuICh3ZWFy
aW5nIGhpcyAndGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlcicgaGF0KQotLQpF
dmVyeXRoaW5nIHlvdSB3YW5uYSBrbm93IGFib3V0IExpbnV4IGtlcm5lbCByZWdyZXNzaW9uIHRy
YWNraW5nOgpodHRwczovL2xpbnV4LXJlZ3RyYWNraW5nLmxlZW1odWlzLmluZm8vYWJvdXQvI3Rs
ZHIKSWYgSSBkaWQgc29tZXRoaW5nIHN0dXBpZCwgcGxlYXNlIHRlbGwgbWUsIGFzIGV4cGxhaW5l
ZCBvbiB0aGF0IHBhZ2UuCgojcmVnemJvdCBwb2tlCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
