Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3654ECD4F4F
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1J7PN1LOie2UW9fKvcah3tCALUfmu7kHOl++/imTWB0=; b=09rqTBH+u8ijRv
	dnLKtBh79mtvJm+IgyHhPs0/kgvHTuJr4ucDhsjlWLqrfsqLUD3xHYt1ubkdm/Mofwlh8GGlmTDfl
	1V4DOElNgV0JtG6BA1FVWCrht9PbveV6xzSDjdn58TUH6v5HG+5T4duCMWkw8oWRtYWAVz10Zt3RC
	NRqeUUWETYJzWPtra5Hq1W6YGEZd7E4K4dpF3HbMrQf6P/iCU8jAvzhYcGqHYfIFEy3VkRlGxrl9b
	0nn+uqRQWRXNVrmCStS1E62BOaC7wk6IcjmrjW98eiVIszqaKoG1bcdo8LEXu27RlQ1jKG7lHB1gP
	Hv+UTchylOT34PXjj+4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjd9m-008hfM-20;
	Fri, 22 Sep 2023 10:13:06 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjd9i-008hbE-1o
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 10:13:04 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qjd9R-0004p2-AR; Fri, 22 Sep 2023 12:12:45 +0200
Message-ID: <08a432e0-4e16-41a6-bad6-e6a51ea34a97@leemhuis.info>
Date: Fri, 22 Sep 2023 12:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Content-Language: en-US, de-DE
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@google.com>,
 Kees Cook <keescook@chromium.org>, Aaron Lu <aaron.lu@intel.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org
References: <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <20230913142410.dfqsg3l5v44mr5j3@box>
 <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
 <20230921160325.g5ei2gfads6deb32@box.shutemov.name>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230921160325.g5ei2gfads6deb32@box.shutemov.name>
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695377582;09d42c6b;
X-HE-SMSGID: 1qjd9R-0004p2-AR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_031302_769876_8504E13E 
X-CRM114-Status: GOOD (  10.94  )
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

T24gMjEuMDkuMjMgMTg6MDMsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPiBPbiBUaHUsIFNl
cCAyMSwgMjAyMyBhdCAxMTo1NDoxNUFNICswMjAwLCBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5n
IChUaG9yc3RlbiBMZWVtaHVpcykgd3JvdGU6Cj4+IE9uIDEzLjA5LjIzIDE2OjI0LCBLaXJpbGwg
QS4gU2h1dGVtb3Ygd3JvdGU6Cj4+PiBPbiBNb24sIFNlcCAxMSwgMjAyMyBhdCAwNTo1NzowN1BN
ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4+Pj4gT24gTW9uLCBTZXAgMTEsIDIw
MjMgYXQgMTA6NTY6MzZQTSArMDgwMCwgRGF2ZSBZb3VuZyB3cm90ZToKPj4+Pj4+IGVhcmx5IGNv
bnNvbGUgaW4gZXh0cmFjdF9rZXJuZWwKPj4+Pj4+IGlucHV0X2RhdGE6IDB4MDAwMDAwODA3ZWI0
MzNhOAo+Pj4+Pj4gaW5wdXRfbGVuOiAweDAwMDAwMDAwMDBkMjYyNzEKPj4+Pj4+IG91dHB1dDog
MHgwMDAwMDA4MDdiMDAwMDAwCj4+Pj4+PiBvdXRwdXRfbGVuOiAweDAwMDAwMDAwMDQ4MDBjMTAK
Pj4+Pj4+IGtlcm5lbF90b3RhbF9zaXplOiAweDAwMDAwMDAwMDNlMjgwMDAKPj4+Pj4+IG5lZWRl
ZF9zaXplOiAweDAwMDAwMDAwMDRhMDAwMDAKPj4+Pj4+IHRyYW1wb2xpbmVfMzJiaXQ6IDB4MDAw
MDAwMDAwMDA5ZDAwMAo+Pj4+Pj4KPj4+Pj4+IERlY29tcHJlc3NpbmcgTGludXguLi4gb3V0IG9m
IHBndF9idWYgaW4gYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2lkZW50X21hcF82NC5jIT8KPj4+
Pj4+IHBhZ2VzLT5wZ3RfYnVmX29mZnNldDogMHgwMDAwMDAwMDAwMDA2MDAwCj4+Pj4+PiBwYWdl
cy0+cGd0X2J1Zl9zaXplOiAweDAwMDAwMDAwMDAwMDYwMDAKPj4+Pj4+Cj4+Pj4+PiBFcnJvcjog
a2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgpIGZhaWxlZAo+Pj4gWy4uLl0KPj4+PiBUaGUgcHJv
YmxlbSBpcyBub3QgbGltaXRlZCB0byB1bmFjY2VwdGVkIG1lbW9yeSwgaXQgYWxzbyB0cmlnZ2Vy
cyBpZiB3ZQo+Pj4+IHJlYWNoIGVmaV9nZXRfcnNkcF9hZGRyKCkgaW4gdGhlIHNhbWUgc2V0dXAu
Cj4+Pj4KPj4+PiBJIHRoaW5rIHdlIGhhdmUgc2V2ZXJhbCBwcm9ibGVtcyBoZXJlLgo+Pj4gWy4u
Ll0KPj4+PiBBbnkgY29tbWVudHM/Cj4+Pgo+Pj4gSSBzdHJ1Z2dsZSB0byBjb21lIHVwIHdpdGgg
YW55dGhpbmcgYmV0dGVyIHRoYW4gaW5jcmVhc2luZyB0aGUgY29uc3RhbnQgdG8KPj4+IGEgdmFs
dWUgdGhhdCAib3VnaHQgdG8gYmUgZW5vdWdoIGZvciBhbnlib2R5IiDCqSwgbGV0J3Mgc2F5IDEy
OEsuCj4+Pgo+Pj4gQW5kIHdlIGNhbiBlbGltaW5hdGUgbG9naWMgb24gbm8tS0FTTFIgdnMuIEtB
U0xSIHZzLiBLQVNMUitWRVJCT1NFX0JPT1RVUC4KPj4+Cj4+PiBPYmplY3Rpb25zPwo+Pgo+PiBB
cHBhcmVudGx5IG5vdCwgYXMgdGhlcmUgd2FzIG5vIHJlcGx5IHNpbmNlIHRoZW4gKHdoaWNoIGlz
IHdoeSBJIHNob3cgdXAKPj4gaGVyZSwgYXMgaXQgbG9va2VkIGxpa2UgZml4aW5nIHRoaXMgcmVn
cmVzc2lvbiBzdGFsbGVkKS4KPiAKPiBJdCBoYXMgYmVlbiBmaXhlZCBpbiB1cHN0cmVhbSBieSB0
aGUgY29tbWl0IGY1MzBlZTk1YjcyZQo+ICgieDg2L2Jvb3QvY29tcHJlc3NlZDogUmVzZXJ2ZSBt
b3JlIG1lbW9yeSBmb3IgcGFnZSB0YWJsZXMiKQoKQWhoLCBncmVhdCwgdGh4IGZvciBsZXR0aW5n
IG1lIGtub3cuIFRoYXQgY29tbWl0IHNhZGx5IG1pc3NlZCBhIExpbms6IG9yCkNsb3NlczogdGFn
IHRvIHRoZSByZWdyZXNzaW9uIHJlcG9ydCwgd2hpY2ggTGludXMgYW5kIHRoZSBkb2NzIGFzayBm
b3IKKGFuZCByZWdyZXNzaW9uIHRyYWNraW5nIHJlbGllcyBvbiksIHRoZW4gaXQgd291bGQgaGF2
ZSBub3RpY2VkIHRoaXMKYXV0b21hdGljYWxseS4gV2hhdGV2ZXIsIHRoaW5ncyBoYXBwZW4sIHRo
eCBhZ2Fpbi4KCiNyZWd6Ym90IGZpeDogZjUzMGVlOTViNzJlCgpDaWFvLCBUaG9yc3RlbiAod2Vh
cmluZyBoaXMgJ3RoZSBMaW51eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXInIGhhdCkKLS0K
RXZlcnl0aGluZyB5b3Ugd2FubmEga25vdyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0
cmFja2luZzoKaHR0cHM6Ly9saW51eC1yZWd0cmFja2luZy5sZWVtaHVpcy5pbmZvL2Fib3V0LyN0
bGRyCklmIEkgZGlkIHNvbWV0aGluZyBzdHVwaWQsIHBsZWFzZSB0ZWxsIG1lLCBhcyBleHBsYWlu
ZWQgb24gdGhhdCBwYWdlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
