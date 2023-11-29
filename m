Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0261C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9qVD92pQulsAJLBNnMnm75ESiARvp0FlKaXxSG/vqg=; b=n6nno3m0T6TO1S
	/02ju+fstlkFKopHjsAY6JIIJa0eiWKFRrEFm85M2n5JJfg+ZOffIQvB+q1HM6JcENflESyCfHxiI
	J7S1HlWnvgB2Hr9s1WON2qB1rfw9j8PdwRglGwTRgBtVUMAerTS0G/wVagKFiodSg36CNylJj6mwW
	6GhbdfNgbq341DpIO5MCM5SKoOPlkg/xzaBcA3IOzuGEIt1+HnhNEUMqjpd7GJeDgU7/TTkL/iT4h
	hhDHc+S2u0SAw3xOYFxcyuEXRYUW+3nHwGNvCI1/gaY4xk3nHD6GCtLit89OhkZ4jwNGS26eHm5C3
	Rg9W2k57IPBDho7KfB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8TSJ-009TTQ-2E;
	Wed, 29 Nov 2023 22:54:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8TSG-009TSK-08;
	Wed, 29 Nov 2023 22:54:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8B928B83F7C;
	Wed, 29 Nov 2023 22:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A223C433C7;
	Wed, 29 Nov 2023 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701298488;
	bh=CauGVvFZVP32vkOcY5cg2nLN5FTRx/mzqnRb1nHXFlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RC3w4GIHEwQjkkuvoTWz4fw14yQ+ovAGzFRxTkodMdNtrM9xLvm/G6DnafvnzT6i4
	 j2aH6CmQq/zITzVrtKTMeNM4XzbQ6MkR9S40ngp8DIgUvgRdyZKiOolEQgkAxtgAl4
	 uPYAOIMSYsaxlWzfI1yJoDtqOH+w3o8d678Hf96g=
Date: Wed, 29 Nov 2023 14:54:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
 agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129145448.8cea3323a7eb19b8f6c6a18a@linux-foundation.org>
In-Reply-To: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
	<20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
	<CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_145452_229358_6FD01017 
X-CRM114-Status: GOOD (  13.67  )
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

T24gV2VkLCAyOSBOb3YgMjAyMyAyMjozNDoxMyArMDAwMCBJZ25hdCBLb3JjaGFnaW4gPGlnbmF0
QGNsb3VkZmxhcmUuY29tPiB3cm90ZToKCj4gT24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTA6MjPi
gK9QTSBBbmRyZXcgTW9ydG9uCj4gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+
ID4KPiA+IE9uIFdlZCwgMjkgTm92IDIwMjMgMjI6MDQ6MDkgKzAwMDAgSWduYXQgS29yY2hhZ2lu
IDxpZ25hdEBjbG91ZGZsYXJlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gPiBGaXhlczogOTE1MDZmN2U1
ZDIxICgiYXJtNjQva2V4ZWM6IHJlZmFjdG9yIGZvciBrZXJuZWwvS2NvbmZpZy5rZXhlYyIpCj4g
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi42KzogZjhmZjIzNDoga2VybmVsL0tj
b25maWcua2V4ZWM6IGRyb3Agc2VsZWN0IG9mIEtFWEVDIGZvciBDUkFTSF9EVU1QCj4gPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi42Kwo+ID4KPiA+IEkgZG91YnQgaWYgYW55b25l
IGtub3dzIHdoYXQgdGhlIHR3byBhYm92ZSBsaW5lcyBtZWFuLiAgV2hhdCBhcmUgeW91cgo+ID4g
cmVjb21tZW5kYXRpb25zIGZvciB0aGUgbWVyZ2luZyBvZiB0aGlzIHBhdGNoPwo+IAo+IEhtbS4u
LiBJIHdhcyBqdXN0IGZvbGxvd2luZwo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bGF0ZXN0L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1sI29wdGlvbi0xCj4gYW5kIGJh
c2ljYWxseSB3YW50ZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBwYXRjaCBnZXRzIGJhY2twb3J0
ZWQKPiB0b2dldGhlciB3aXRoIGNvbW1pdCBmOGZmMjM0OiBrZXJuZWwvS2NvbmZpZy5rZXhlYzog
ZHJvcCBzZWxlY3Qgb2YKPiBLRVhFQyBmb3IgQ1JBU0hfRFVNUCAodGhleSBzaG91bGQgZ28gdG9n
ZXRoZXIpCgpJIHNlZSwgdGhhbmtzLiAgSSBkb24ndCB0aGluayBJJ3ZlIGV2ZXIgcmVjZWl2ZWQg
YSBwYXRjaCB3aGljaCBkaWQgdGhpcyEKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
