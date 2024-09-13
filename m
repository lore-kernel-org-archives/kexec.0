Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DB9EEE26C
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0IkCDcDTw6Gm0zcX9YoNiSvxkiYYfhAb4I7TWOU2bAM=; b=mANF/Ic9dOcZ4W
	kl287/L5/+SooppyQfhBU/SYWGavnWYoZZdReFvPwCQeXGqe8Wv7MsOgt3mHtYKDViYSJoWOOVgv4
	BD25tKdKdsMFoTRR4j1aJYQ3KQdb5xDQ+gNkoyE3DEjlipjcvURDvH2txSW6y+5Y54268YLzSSQ/A
	UHDDjq4ErcP3wD2K83MsiL0mdNucXDpSngoltAK9f6X0cXMw6vWin8Uzs9ASjRHgOXUMIVfO8YQ0d
	kN2349MllRw+sJPusgeRhji1zp04X5pmpVysLGjw1QgpEmpfyfn+fGvl3AHuo5SjgpMXBRskGmuN/
	EGOnpaIX34ur1KVotalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp57Z-0000000FqAn-26Id;
	Fri, 13 Sep 2024 12:09:53 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp558-0000000Fpfm-1P9k
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 12:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726229241;
	bh=OGYZmlVkcDrP5LYRua4zarLnQVw/13XyLwQqI9Lg2hE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Fr3Z+T0SJ/zHOYu780Y2cGaCP2Pd3yxY4nlj1wnXKps/z74wNheT50NRi/dF5moIH
	 MMf+pPFTQVQ6jj9SnEPIOyztnNfByLtn9sZiK2PAe2Hp9UNAYA3+HgDLT1IrXd2PnH
	 Qjx97sRbq0vR/nvQwGCfalI4Kx2D2S0gMsrYqCoE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6E3361287930;
	Fri, 13 Sep 2024 08:07:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NSlQqNqgMfc8; Fri, 13 Sep 2024 08:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726229241;
	bh=OGYZmlVkcDrP5LYRua4zarLnQVw/13XyLwQqI9Lg2hE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Fr3Z+T0SJ/zHOYu780Y2cGaCP2Pd3yxY4nlj1wnXKps/z74wNheT50NRi/dF5moIH
	 MMf+pPFTQVQ6jj9SnEPIOyztnNfByLtn9sZiK2PAe2Hp9UNAYA3+HgDLT1IrXd2PnH
	 Qjx97sRbq0vR/nvQwGCfalI4Kx2D2S0gMsrYqCoE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1F5AC128791E;
	Fri, 13 Sep 2024 08:07:20 -0400 (EDT)
Message-ID: <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com,  bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com,  x86@kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Date: Fri, 13 Sep 2024 08:07:18 -0400
In-Reply-To: <20240913-careful-maroon-crab-8a0541@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	 <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	 <20240913-careful-maroon-crab-8a0541@leitao>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_050722_407408_FEC04E23 
X-CRM114-Status: GOOD (  27.01  )
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

T24gRnJpLCAyMDI0LTA5LTEzIGF0IDA0OjU3IC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6Cj4g
SGVsbG8gSmFtZXMsCj4gCj4gT24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgMTI6MjI6MDFQTSAtMDQw
MCwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+ID4gT24gVGh1LCAyMDI0LTA5LTEyIGF0IDA2OjAz
IC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6Cj4gPiA+IEhlbGxvIEFyZCwKPiA+ID4gCj4gPiA+
IE9uIFRodSwgU2VwIDEyLCAyMDI0IGF0IDEyOjUxOjU3UE0gKzAyMDAsIEFyZCBCaWVzaGV1dmVs
IHdyb3RlOgo+ID4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGNvdWxkIGJlIGFuIEVGSSBidWcs
IGdpdmVuIHRoYXQgaXQgZG9lcwo+ID4gPiA+IG5vdCBkZWFsIHdpdGggRTgyMCB0YWJsZXMgYXQg
YWxsLgo+ID4gPiAKPiA+ID4gSSB3YW50IHRvIGJhY2sgdXAgYSBsaXR0bGUgYml0IGFuZCBtYWtl
IHN1cmUgSSBhbSBmb2xsb3dpbmcgdGhlCj4gPiA+IGRpc2N1c3Npb24uCj4gPiA+IAo+ID4gPiBG
cm9tIHdoYXQgSSB1bmRlcnN0YW5kIGZyb20gcHJldmlvdXMgZGlzY3Vzc2lvbiwgd2UgaGF2ZSBh
biBFRkkKPiA+ID4gYnVnIGFzIHRoZSByb290IGNhdXNlIG9mIHRoaXMgaXNzdWUuCj4gPiA+IAo+
ID4gPiBUaGlzIGhhcHBlbnMgYmVjYXVzZSB0aGUgRUZJIGRvZXMgTk9UIG1hcmsgdGhlIEVGSSBU
UE0gZXZlbnQgbG9nCj4gPiA+IG1lbW9yeSByZWdpb24gYXMgcmVzZXJ2ZWQgKEVGSV9SRVNFUlZF
RF9UWVBFKS4gTm90IGhhdmluZyBhbgo+ID4gPiBlbnRyeSBmb3IgdGhlIGV2ZW50IHRhYmxlIG1l
bW9yeSBpbiBFRkkgbWVtb3J5IG1hcHBlZCwgdGhlbgo+ID4gPiBsaWJzdHViIHdpbGwgaWdub3Jl
IGl0IGNvbXBsZXRlbHkgKHRoZSBUUE0gZXZlbnQgbG9nIG1lbW9yeQo+ID4gPiByYW5nZSkgYW5k
IG5vdCBwb3B1bGF0ZSBlODIwIHRhYmxlIHdpdGggaXQuCj4gPiAKPiA+IFdhaXQsIHRoYXQncyBu
b3QgY29ycmVjdC7CoCBUaGUgVFBNIGxvZyBpcyBpbiBtZW1vcnkgdGhhdCBkb2Vzbid0Cj4gPiBz
dXJ2aXZlIEV4aXRCb290U2VydmljZXMgKGJ5IGRlc2lnbiBpbiBjYXNlIHRoZSBPUyBkb2Vzbid0
IGNhcmUKPiA+IGFib3V0IGl0KS7CoCBTbyB0aGUgRUZJIHN0dWIgYWN0dWFsbHkgY29waWVzIGl0
IG92ZXIgdG8gYSBuZXcKPiA+IGNvbmZpZ3VyYXRpb24gdGFibGUgdGhhdCBpcyBpbiByZXNlcnZl
ZCBtZW1vcnkgYmVmb3JlIGl0IGNhbGxzCj4gPiBFeGl0Qm9vdFNlcnZpY2VzLiAgVGhpcyBuZXcg
Y29weSBzaG91bGQgYmUgaW4ga2VybmVsIHJlc2VydmVkCj4gPiBtZW1vcnkgcmVnYXJkbGVzcyBv
ZiBpdHMgZTgyMCBtYXAgc3RhdHVzLgo+IAo+IEZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciBjbGFy
aWZ5aW5nIHNvbWUgcG9pbnRzIGhlcmUuCj4gCj4gSG93IHNob3VsZCB0aGUgVFBNIGxvZyB0YWJs
ZSBiZSBwYXNzZWQgdG8gdGhlIG5leHQga2VybmVsIHdoZW4KPiBrZXhlY2luZygpIHNpbmNlIGl0
IGRpZG4ndCBzdXJpdmUgRXhpdEJvb3RTZXJ2aWNlcz8KCkkndmUgbm8gaWRlYS4gIEknbSBhc3N1
bWluZyB5b3UgZG9uJ3QgZWxhYm9yYXRlbHkgcmVjb25zdHJ1Y3QgdGhlIEVGSQpib290IHNlcnZp
Y2VzLCBzbyB5b3UgY2FuJ3QgZW50ZXIgdGhlIEVGSSBib290IHN0dWIgYmVmb3JlCkV4aXRCb290
U2VydmljZXMgaXMgY2FsbGVkPyAgU28gSSdkIGd1ZXNzIHlvdSB3YW50IHRvIHByZXNlcnZlIHRo
ZSBFRkkKdGFibGUgdGhhdCBjb3BpZWQgdGhlIFRQTSBkYXRhIGluIHRvIGtlcm5lbCBtZW1vcnku
CgpKYW1lcwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
