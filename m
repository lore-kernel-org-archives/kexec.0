Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F8FEEB58D
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LOvXXR4pPq9PL2JrLNVvLtfrESnhP2MpJ7dO3VvRqxs=; b=J8aGWsY/3HzrMk
	WjTfOASiV3DNiULuf14+xEeZh7UhG2NJmscJ5sYa1T/TxLpcAb5B6ftb1pwkLDxeqIrAfbg/l9egI
	/b7jemAkyBDKIOAXj52NWxG3Ig4oKrWl53QknpdTaCfNeFV12+q7A0adx8p7ka7ypuMnRxrKxVsR5
	dhEnw7VwpgcatqNGWa0qhp39ymAYBFX1Edn9NDVbQtWEb3NoXK1vf/tLw1ks0yUcUAh6r+RwEIKNL
	v6CVPHGZwnHJxUV+zBZfavM/eeBpxMnmkQ+HKLTxumT1wbcGYi+09nJXDPuIKh8rUpqIrviCa8OOD
	WKajsUyDtXkvKGe2r28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohRS-0000000CklD-3RKx;
	Thu, 12 Sep 2024 10:52:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohQo-0000000CkcK-3y91
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 10:52:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B784A5C5A85
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 10:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A9CC4CEC3
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726138330;
	bh=cL7uDEElOY41qr+HGq/ZTZuOKa90vTrMzKP6ssUHDo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndfrSPSxz6CIkfBnsZKsrLlkbnBVpmiUM/EvG5sOGBufIIwTXIRtz5tV4MsB2bYKd
	 6Sq0TAK3Ogs+1vUs5qw97+xgE6EoiDTCty5hiem7qYtG+H4GtT7HDcGb3gHWoX+A8O
	 6jwwHBr0qm4PNfnqRJHI5WC1/T11knKSPzCCaG4rMmr7QjyZKgoDiobXcO92kDoeaK
	 7Jb/pcEq9QtqblEhdDgRM6iWktevtEVcl4vbf9xD0idyZ+DFpEhO9ese7m3oNCHb2D
	 jXn78HUk+pwAzD5S71PtFmVVpqfBRn7su0BvsE57aXhgIHBltn6j61AezeOG25/D9o
	 HKNX6fWNTDqcw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so9247441fa.2
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 03:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+VrPp04ToQo98+yJc/hsqzC6gO+DeoDOjDUeHKvBBP0zYBEuFf5VlT6lbiRRpLgguJOkkuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YybqLgqzF6v5097IrwNsY506rx9mRSBvvQhZrhS+wlPyU2akE6u
	kvVgkcibx6D2XHxTFHlEkRLs3VadNGOk0fZiKiPALvgkldHU+dxlAwq+ZK0CNLIkXWNgiNDjnKS
	W7I9xiD4pIwsefE+MHMrWH6rRq6A=
X-Google-Smtp-Source: AGHT+IG0RDOWZFcmijfEe36WItqbt0+VFYUSSIJCGg1H644oMA2zxoliUoqq9tnW8It6Ov5SLYGgsg4NMXktN5CT4as=
X-Received: by 2002:a05:651c:2104:b0:2f3:ad82:53fd with SMTP id
 38308e7fff4ca-2f787f2d6b7mr12658091fa.28.1726138328401; Thu, 12 Sep 2024
 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com> <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
In-Reply-To: <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 12:51:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Message-ID: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_035211_129433_3054F84F 
X-CRM114-Status: GOOD (  31.31  )
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

T24gVGh1LCAxMiBTZXB0IDIwMjQgYXQgMTI6MjMsIFVzYW1hIEFyaWYgPHVzYW1hYXJpZjY0MkBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDExLzA5LzIwMjQgMTI6NTEsIEFyZCBCaWVzaGV1
dmVsIHdyb3RlOgo+ID4gT24gV2VkLCAxMSBTZXB0IDIwMjQgYXQgMTI6NDEsIFVzYW1hIEFyaWYg
PHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gTG9va2luZyBhdCB0aGUg
VFBNIHNwZWMgWzFdCj4gPj4KPiA+PiBJZiB0aGUgQUNQSSBUUE0yIHRhYmxlIGNvbnRhaW5zIHRo
ZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBQbGF0Zm9ybQo+ID4+IEZpcm13YXJlIFRDRyBsb2cs
IGZpcm13YXJlIOKAnHBpbnPigJ0gdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlCj4gPj4g
UGxhdGZvcm0gRmlybXdhcmVUQ0cgbG9nLCBhbmQgcmVwb3J0cyB0aGlzIG1lbW9yeSBhcyDigJxS
ZXNlcnZlZOKAnSBtZW1vcnkKPiA+PiB2aWEgdGhlIElOVCAxNWgvRTgyMCBpbnRlcmZhY2UuCj4g
Pj4KPiA+PiBJdCBsb29rcyBsaWtlIHRoZSBmaXJtd2FyZSBzaG91bGQgcGFzcyB0aGlzIGFzIHJl
c2VydmVkIGluIGU4MjAgbWVtb3J5Cj4gPj4gbWFwLiBIb3dldmVyLCBpdCBkb2Vzbid0IHNlZW0g
dG8uIFRoZSBmaXJtd2FyZSBiZWluZyB0ZXN0ZWQgb24gaXM6Cj4gPj4gZG1pZGVjb2RlIC1zIGJp
b3MtdmVyc2lvbgo+ID4+IGVkazItMjAyNDAyMTQtMi5lbDkKPiA+Pgo+ID4+IFdoZW4gdGhpcyBh
cmVhIGlzIG5vdCByZXNlcnZlZCwgaXQgY29tZXMgdXAgYXMgdXNhYmxlIGluCj4gPj4gL3N5cy9m
aXJtd2FyZS9tZW1tYXAuIFRoaXMgbWVhbnMgdGhhdCBrZXhlYywgd2hpY2ggdXNlcyB0aGF0IG1l
bW1hcAo+ID4+IHRvIGZpbmQgdXNhYmxlIG1lbW9yeSByZWdpb25zLCBjYW4gc2VsZWN0IHRoZSBy
ZWdpb24gd2hlcmUgZWZpLnRwbV9sb2cKPiA+PiBpcyBhbmQgb3ZlcndyaXRlIGl0IGFuZCByZWxv
Y2F0ZV9rZXJuZWwuCj4gPj4KPiA+PiBIYXZpbmcgYSBmaXggaW4gZmlybXdhcmUgY2FuIGJlIGRp
ZmZpY3VsdCB0byBnZXQgdGhyb3VnaC4gQXMgYSBzZWNvbmRhcnkKPiA+PiBmaXgsIHRoaXMgcGF0
Y2ggbWFya3MgdGhhdCByZWdpb24gYXMgcmVzZXJ2ZWQgaW4gZTgyMF90YWJsZV9maXJtd2FyZSBp
ZiBpdAo+ID4+IGlzIGN1cnJlbnRseSBFODIwX1RZUEVfUkFNIHNvIHRoYXQga2V4ZWMgZG9lc24n
dCB1c2UgaXQgZm9yIGtlcm5lbCBzZWdtZW50cy4KPiA+Pgo+ID4+IFsxXSBodHRwczovL3RydXN0
ZWRjb21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1BDLUNsaWVudFBsYXRmb3Jt
X1Byb2ZpbGVfZm9yX1RQTV8ycDBfU3lzdGVtc192NDlfMTYxMTE0X3B1YmxpYy1yZXZpZXcucGRm
Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwu
Y29tPgo+ID4KPiA+IEkgd291bGQgZXhwZWN0IHRoZSBFRkkgbWVtb3J5IG1hcCB0byBFODIwIGNv
bnZlcnNpb24gaW1wbGVtZW50ZWQgaW4KPiA+IHRoZSBFRkkgc3R1YiB0byB0YWtlIGNhcmUgb2Yg
dGhpcy4KPiA+Cj4KPiBTbyBJIGhhdmUgYmVlbiBtYWtpbmcgYSBwcm90b3R5cGUgd2l0aCBFRkkg
c3R1YiwgYW5kIHRoZSB1bmZpbmlzaGVkIHZlcnNpb24gaXMgbG9va2luZyBsaWtlIGEKPiBob3Jy
aWJsZSBoYWNrLgo+Cj4gVGhlIG9ubHkgd2F5IHRvIGRvIHRoaXMgaW4gbGlic3R1YiBpcyB0byBw
YXNzIGxvZ190YmwgYWxsIHRoZSB3YXkgZnJvbSBlZmlfcmV0cmlldmVfdGNnMl9ldmVudGxvZwo+
IHRvIGVmaV9zdHViX2VudHJ5IGFuZCBmcm9tIHRoZXJlIHRvIHNldHVwX2U4MjAuCj4gV2hpbGUg
Z29pbmcgdGhyb3VnaCB0aGUgZWZpIG1lbW9yeSBtYXAgYW5kIGNvbnZlcnRpbmcgaXQgdG8gZTgy
MCB0YWJsZSBpbiBzZXR1cF9lODIwLCB5b3UgaGF2ZSB0byBjaGVjawo+IGlmIGxvZ190YmwgZmFs
bHMgaW4gYW55IG9mIHRoZSByYW5nZXMgYW5kIGlmIHRoZSByYW5nZSBpcyBFODIwX1RZUEVfUkFN
LiBJZiB0aGF0IGNvbmRpdGlvbiBpcyBzYXRpc2ZpZWQsCj4gdGhlbiB5b3UgaGF2ZSB0byBzcGxp
dCB0aGF0IHJhbmdlIGludG8gMy4gaS5lLiB0aGUgRTgyMF9UWVBFX1JBTSByYW5nZSBiZWZvcmUg
dHBtX2xvZywgdGhlIHRwbV9sb2cKPiBFODIwX1RZUEVfUkVTRVJWRUQgcmFuZ2UsIGFuZCB0aGUg
RTgyMF9UWVBFX1JBTSByYW5nZSBhZnRlci4gVGhlcmUgYXJlIG5vIGhlbHBlciBmdW5jdGlvbnMs
IHNvIHRoaXMKPiBzcGxpdHRpbmcgaW52b2x2ZXMgcGxheWluZyB3aXRoIGEgbG90IG9mIHBvaW50
ZXJzLCBhbmQgaXQgbG9va3MgcXVpdGUgdWdseS4gSSBiZWxpZXZlIGRvaW5nIHRoaXMKPiB3YXkg
aXMgbW9yZSBsaWtlbHkgdG8gaW50cm9kdWNlIGJ1Z3MuCj4KPiBJZiB3ZSBhcmUgaGF2aW5nIHRv
IGNvbXBlbnNhdGUgZm9yIGFuIEVGSSBidWcsIHdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gZG8gaXQg
aW4gdGhlIHdheSBkb25lCj4gaW4gUkZDIGFuZCBkbyBpdCBpbiBrZXJuZWwgcmF0aGVyIHRoYW4g
bGlic3R1Yj8gSXQgaXMgc2ltcGxlIGFuZCB2ZXJ5IGxpa2VseSB0byBiZSBidWcgZnJlZS4KPgoK
SSBkb24ndCBzZWUgaG93IHRoaXMgY291bGQgYmUgYW4gRUZJIGJ1ZywgZ2l2ZW4gdGhhdCBpdCBk
b2VzIG5vdCBkZWFsCndpdGggRTgyMCB0YWJsZXMgYXQgYWxsLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
