Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C541DC001B0
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Axrge0Bev2BwDMDRI1z8rcHrtpO89wDx6NAbZrJPQWg=; b=WlkzvDZWXz3XeW
	xqBIfMU+wvvSeQ1VpVbuE294XwW8eEiDQaVUYv7J4xKhjY2b657QyFyblENe05ouxGsN+zSzDycTZ
	s1URPfwSL6QJAE+iiBnTJ+ZrphiHeYfUP3Eskky9SBi7KMNc49eN41g4TrE8vDxwodFO5NSRNJGEt
	0V0YJrSKKR7iqU7cqWmppf6Z0sqzQdQ92fgq8vKviTOO5kBuoaa6gzB5KIjrPxTYQUX7zTEYj1DkI
	YJQS5cGDlIJz0rQ4G1lB32HQn1AqI1Whjj/UMPdxwGAGMA8D00ZWHGTY4+04tILKfI9xTEcFDEJdX
	UOkDgVeu05D4ufgc/W4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPeh-004KIj-19;
	Mon, 17 Jul 2023 14:56:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPee-004KHf-0f
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 14:56:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2283761118
	for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897FDC433CA
	for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689605810;
	bh=fMVMLDyaT91QMS4Y0JqnqMsVXKFXNflrRoMtl9SJR0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J4fmjA4IrIiL5blX9/bh3cQWJdD7r2RrzlJ5sQWbdRx+emBJ9qnfSPhzsIfp4fARl
	 KUMfdReB5CkdxvD93jRzR+sHsQF7ZRUJeCEflWspo+xG53qDP6PhOkCqFRD3fuBUsc
	 oiY76T1DxZ52Eh1AW/4ZRnOFYr4vyvZcN/bbXNKmccEJdFF10Ql07jUYm1/yyEHtS0
	 zPGezh34UnfoN9pwTypMk9DhBQD4feVL6h/pKyzAYu4xMLisuudukbivDZm7p/F7YY
	 Rm+NH3q2h+UE5DHILPyUUrweFs+gaEziQVyf8LqfGQJ9Dpub7mzTdZI6WEgI60C6Bv
	 OCZzddguyylUQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso70566041fa.0
        for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 07:56:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLamvKyx9s6jB8kgOq2kW44XJuiC7dSexZPh2pohc531xQdEVw+/
	bXftqOTCezqbSLLZ4Y7IsomA9S1JyzUUD2fSINA=
X-Google-Smtp-Source: APBJJlGS2j/onhT+8KrLFfXCBR/cBjItbdLyFrBpTCKJFO4b8DuZWgzwV9I8vi2Psd5cnH5hGrGW+wehNKIRyuc0EvU=
X-Received: by 2002:a2e:700b:0:b0:2b6:cff1:cd1c with SMTP id
 l11-20020a2e700b000000b002b6cff1cd1cmr8535527ljc.34.1689605808535; Mon, 17
 Jul 2023 07:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
In-Reply-To: <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Jul 2023 16:56:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
Message-ID: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Tao Liu <ltao@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_075652_379306_2E911404 
X-CRM114-Status: GOOD (  26.68  )
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

T24gTW9uLCAxNyBKdWwgMjAyMyBhdCAxNTo1MywgVGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPiB3
cm90ZToKPgo+IEhpIEJvcmlzbGF2LAo+Cj4gT24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgNjowNeKA
r1BNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IEp1biAwMSwgMjAyMyBhdCAwMzoyMDo0NFBNICswODAwLCBUYW8gTGl1IHdyb3RlOgo+ID4gPiAg
YXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyB8IDM1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4gPgo+ID4gT2ssIHBscyB0cnkgdGhpcyB0b3RhbGx5IHVudGVzdGVkIHRo
aW5nLgo+ID4KPiA+IFRoeC4KPiA+Cj4gPiAtLS0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9i
b290L2NvbXByZXNzZWQvc2V2LmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvc2V2LmMKPiA+
IGluZGV4IDA5ZGM4YzE4N2IzYy4uZmVmZTI3YjJhZjg1IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC94
ODYvYm9vdC9jb21wcmVzc2VkL3Nldi5jCj4gPiArKysgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNz
ZWQvc2V2LmMKPiA+IEBAIC00MDQsMTMgKzQwNCwyMCBAQCB2b2lkIHNldl9lbmFibGUoc3RydWN0
IGJvb3RfcGFyYW1zICpicCkKPiA+ICAgICAgICAgaWYgKGJwKQo+ID4gICAgICAgICAgICAgICAg
IGJwLT5jY19ibG9iX2FkZHJlc3MgPSAwOwo+ID4KPiA+ICsgICAgICAgLyogQ2hlY2sgZm9yIHRo
ZSBTTUUvU0VWIHN1cHBvcnQgbGVhZiAqLwo+ID4gKyAgICAgICBlYXggPSAweDgwMDAwMDAwOwo+
ID4gKyAgICAgICBlY3ggPSAwOwo+ID4gKyAgICAgICBuYXRpdmVfY3B1aWQoJmVheCwgJmVieCwg
JmVjeCwgJmVkeCk7Cj4gPiArICAgICAgIGlmIChlYXggPCAweDgwMDAwMDFmKQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybjsKPiA+ICsKPiA+ICAgICAgICAgLyoKPiA+ICAgICAgICAgICogU2V0
dXAvcHJlbGltaW5hcnkgZGV0ZWN0aW9uIG9mIFNOUC4gVGhpcyB3aWxsIGJlIHNhbml0eS1jaGVj
a2VkCj4gPiAgICAgICAgICAqIGFnYWluc3QgQ1BVSUQvTVNSIHZhbHVlcyBsYXRlci4KPiA+ICAg
ICAgICAgICovCj4gPiAgICAgICAgIHNucCA9IHNucF9pbml0KGJwKTsKPiA+Cj4gPiAtICAgICAg
IC8qIENoZWNrIGZvciB0aGUgU01FL1NFViBzdXBwb3J0IGxlYWYgKi8KPiA+ICsgICAgICAgLyog
UmVjaGVjayB0aGUgU01FL1NFViBzdXBwb3J0IGxlYWYgKi8KPiA+ICAgICAgICAgZWF4ID0gMHg4
MDAwMDAwMDsKPiA+ICAgICAgICAgZWN4ID0gMDsKPiA+ICAgICAgICAgbmF0aXZlX2NwdWlkKCZl
YXgsICZlYngsICZlY3gsICZlZHgpOwo+ID4KPiBUaGFua3MgYSBsb3QgZm9yIHRoZSBwYXRjaCBh
Ym92ZSEgU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLiBJIGhhdmUKPiBjb21waWxlZCBhbmQg
dGVzdGVkIGl0IGxvY2FsbHkgYWdhaW5zdCA2LjUuMC1yYzEsIHRob3VnaCBpdCBjYW4gcGFzcwo+
IHRoZSBlYXJseSBzdGFnZSBvZiBrZXhlYyBrZXJuZWwgYm9vdHVwLAoKT0ssIHNvIHRoYXQgcHJv
dmVzIHRoYXQgdGhlIGNjX2Jsb2IgdGFibGUgYWNjZXNzIGlzIHRoZSBjdWxwcml0IGhlcmUuClRo
YXQgc3RpbGwgbWVhbnMgdGhhdCBrZXhlYyBvbiBTRVYgaXMgbGlrZWx5IHRvIGV4cGxvZGUgaW4g
dGhlIGV4YWN0CnNhbWUgd2F5IHNob3VsZCBhbnlvbmUgYXR0ZW1wdCB0aGF0LgoKCj4gaG93ZXZl
ciB0aGUga2VybmVsIHdpbGwgcGFuaWMKPiBvY2Nhc2lvbmFsbHkgbGF0ZXIuIFRoZSB0ZXN0IG1h
Y2hpbmUgaXMgdGhlIG9uZSB3aXRoIEludGVsIEF0b20KPiB4NjQyNVJFIGNwdSB3aGljaCBlbmNv
dW50ZXJlZCB0aGUgcGFnZSBmYXVsdCBpc3N1ZSBvZiBtaXNzaW5nIGVmaQo+IGNvbmZpZyB0YWJs
ZS4KPgoKQWdyZWUgd2l0aCBCb3JpcyB0aGF0IHRoaXMgc2VlbXMgZW50aXJlbHkgdW5yZWxhdGVk
LgoKPiAuLi5zbmlwLi4uCj4gWyAgIDIxLjM2MDc2M10gIG52bWUwbjE6IHAxIHAyIHAzCj4gWyAg
IDIxLjM2NDIwN10gaWdjIDAwMDA6MDM6MDAuMDogUFRNIGVuYWJsZWQsIDRucyBncmFudWxhcml0
eQo+IFsgICAyMS40MjEwOTddIHBwcyBwcHMxOiBuZXcgUFBTIHNvdXJjZSBwdHAxCj4gWyAgIDIx
LjQyNTM5Nl0gaWdjIDAwMDA6MDM6MDAuMCAodW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFs
aXplZCk6IFBIQyBhZGRlZAo+IFsgICAyMS40NTcwMDVdIGlnYyAwMDAwOjAzOjAwLjA6IDQuMDAw
IEdiL3MgYXZhaWxhYmxlIFBDSWUgYmFuZHdpZHRoCj4gKDUuMCBHVC9zIFBDSWUgeDEgbGluaykK
PiBbICAgMjEuNDY1MjEwXSBpZ2MgMDAwMDowMzowMC4wIGV0aDE6IE1BQzogLi4uc25pcC4uLgo+
IFsgICAyMS40NzM0MjRdIGlnYyAwMDAwOjAzOjAwLjAgZW5wM3MwOiByZW5hbWVkIGZyb20gZXRo
MQo+IFsgICAyMS40Nzk0NDZdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwg
YWRkcmVzczogMDAwMDAwMDAwMDAwMDAwOAo+IFsgICAyMS40ODY0MDVdICNQRjogc3VwZXJ2aXNv
ciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQo+IFsgICAyMS40OTE1MTldIG1tYzE6IEZhaWxl
ZCB0byBpbml0aWFsaXplIGEgbm9uLXJlbW92YWJsZSBjYXJkCj4gWyAgIDIxLjQ5MTUzOF0gI1BG
OiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gWyAgIDIxLjUwMjIyOV0g
UEdEIDAgUDREIDAKPiBbICAgMjEuNTA0NzczXSBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAg
Tk9QVEkKPiBbICAgMjEuNTA5MTMzXSBDUFU6IDMgUElEOiA0MDIgQ29tbTogc3lzdGVtZC11ZGV2
ZCBOb3QgdGFpbnRlZCA2LjUuMC1yYzErICMxCj4gWyAgIDIxLjUxNTkwNV0gSGFyZHdhcmUgbmFt
ZTogLi4uc25pcC4uLgoKCldoeSBhcmUgeW91IHNuaXBwaW5nIHRoZSBoYXJkd2FyZSBuYW1lPwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
