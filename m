Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF69C4345F
	for <kexec@archiver.kernel.org>; Mon, 29 Apr 2024 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ArjFlmanOOefFLS5OfjytwT+shss1CXbhXIyQzTbixY=; b=sOa4YIpGrIBR3b
	ECJxXY4f3bKAYCVJOJkcbdS9nOiVhrDxYdNtpYfKWJNAO8nFgEIEeg9wareJfnuXmaCHil+TttMYj
	Nccc5pdUYeg+kWF6ZKh8E0USfOF5mz2z5TawvVjhZlFi5a1IJrxHefxZ8YAQCztL9Uh6SZJRx5RdE
	q6xXGY40wTfi0TEc3+WIgLK6RS0owEHn7AxA0TKfceus6YcSOMjvEALDzmZpHMpfh9Cxcno3A3WJa
	lk6ArViFS4MZfW8ffLWzHEpH4HV1Y4zJCf+azNTG5PesuiDBUXGSceXYlpsuKwWSHZWdy0oU4x6CY
	MfEvobwbFEQzPy1ubI6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1SOk-00000003D7H-3QBu;
	Mon, 29 Apr 2024 14:54:30 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1SOh-00000003D67-3TO3
	for kexec@lists.infradead.org;
	Mon, 29 Apr 2024 14:54:29 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B335D40E016B;
	Mon, 29 Apr 2024 14:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3XVfKGstbIKd; Mon, 29 Apr 2024 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714402459; bh=/OGKprZdYSootanFbGT+iAmhKwb8pptaRzuZ0S3c60k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZORcMHjzGCl+zJPL/bWqyORvPswFKKMXZ4Qkxok344k6zGoSeJ/TuomgqjSut4YJI
	 DIEyj9pDjnCXYyAAlMFzaJzF6oHVB1FgzjltTOelnOKErr1lhmPIX3RPq+HDmrz92C
	 bsx6t5hBSDFgHwTp+IOgocsFKkjI81tMH7O0i8i05r7Y9hNZ41kWht7dH5v44RTTLD
	 yLTPPKCR0U3YyB7t2L+UJEzyQ1Sv3KT3h68oFbK1nY55c68Rsv7YH9Nsg8U6QkTyw1
	 Hifqk+Duo66bpVmksfda6WkGhnXW5ZADpc2GiKXcANcig6ywCwGyosZyzCfkofu+KE
	 Fb/Qqq4UuwJLGzc7WhfUnKIJwYOXflUTfINnX1xvYDIt/6z9V3s4LXMassdmY2NjcK
	 ovMt0ygI/bLDesptnxCgsQE7p5zxprV8u7PllMqCK0mV/jTNoJB9esy3TDmBuh+isM
	 sg7pXPEX8WUZBkgfEi6iAjR75YDXHOyru1SUNTZCRCI7gEksg5QmCFkzCaLTz8i5WS
	 DU0c5Re8AhkI7qrte+Ai8CHrbXNxiv60WKxfsbivbH4v9KFzq57xIt7C36+o9sk6i+
	 gDBsb5FeZZhxWbHBmeASqC1QfttFXH08TxxAKehBf7xV5yqRdWYm8rqAImQdGRrXMK
	 g2HO5+ta+4tre3sRqqsGiQtg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D13D40E00B2;
	Mon, 29 Apr 2024 14:53:52 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:53:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Message-ID: <20240429145351.GIZi-0fzy7H_UpEJ5w@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
 <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
 <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_075428_041855_D2C8856E 
X-CRM114-Status: GOOD (  13.86  )
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

T24gTW9uLCBBcHIgMjksIDIwMjQgYXQgMDU6Mjk6MjNQTSArMDMwMCwgS2lyaWxsIEEuIFNodXRl
bW92IHdyb3RlOgo+IEhtLiBJIGNvbnNpZGVyZWQgdGhlIHNlbnRlbmNlIHRvIGJlIGluIGltcGVy
YXRpdmUgbW9vZCBhbHJlYWR5LiBJIGd1ZXNzIEkKPiBkb24ndCBmdWxseSB1bmRlcnN0YW5kIHdo
YXQgaW1wZXJhdGl2ZSBtb29kIGlzLiBXaWxsIGZpeC4KClRoaXM6CgpodHRwczovL2VuLndpa2lw
ZWRpYS5vcmcvd2lraS9JbXBlcmF0aXZlX21vb2QKCmJ1dCBiYXNpY2FsbHkgdGhlIHNlbnRlbmNl
IGlzIGEgY29tbWFuZC4KCj4gWW91IGFyZSByaWdodCwgSSBkaWRuJ3QgcnVuIGdldF9tYWludGFp
bmVyLnBsIHRoaXMgdGltZS4gSSBuZXZlciBnb3QgaXQKPiBpbnRlZ3JhdGVkIHByb3Blcmx5IGlu
dG8gbXkgd29ya2Zsb3cuIEhvdyBkbyB5b3UgdXNlIGl0PyBJcyBpdCBwYXJ0IG9mCj4gJ2dpdCBz
ZW5kLWVtYWlsJyBob29rcyBvciBkbyB5b3UgZG8gaXQgbWFudWFsbHkgc29tZWhvdy4KClNvIHdo
YXQgSSBkbyBhZnRlciB0aGUgd2hvbGUgc2V0IGlzIGFwcGxpZWQsIGlzOgoKZ2l0IGRpZmYgSEVB
RH48TlVNPi4uIHwgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsCgp3aGVyZSA8TlVNPiBpcyB0
aGUgbnVtYmVyIG9mIHBhdGNoZXMgd2hpY2ggYmVsb25nIHRvIHRoZSBzZXJpZXMuCgpJT1csIHlv
dSBnZXQgYSBmdWxsIGRpZmYgb2YgdGhlIHNldCBhbmQgeW91IHJ1biB0aGF0IGRpZmYgdGhyb3Vn
aApnZXRfbWFpbnRhaW5lci5wbC4KCkl0J2xsIGdpdmUgeW91IGEgd2hvbGUgbG90IG9mIHBlb3Bs
ZSBidXQgeW91IGNhbiBnbyB0aHJvdWdoIHRoYXQgbGlzdAphbmQgcHJ1bmUgaXQgdG8gdGhlIHBl
b3BsZSB3aG8gYXJlIHJlYWxseSByZWxldmFudCBmb3IgdGhlIHNldC4KCkFuZCB0aGVuIHlvdSBk
bwoKZ2l0IHNlbmQtZW1haWwgLS1jYy1jbWQ9Y2NjbWQuc2ggLi4uCgphbmQgdGhhdCBzY3JpcHQg
c2ltcGx5IGVjaG9lcyBhICJDYzogPG5hbWU+IiBvbmUgcGVyIGxpbmUuIFRoYXQgaXMsIGlmCnRo
ZXJlIGFyZSBhIGxvdCBvZiBwZW9wbGUgdG8gQ2MuIElmIHRoZXJlIGFyZSBvbmx5IDEtM2lzaCBv
ciBzbywgeW91IGNhbgpzdXBwbHkgZWFjaCB3aXRoIHRoZSAiLS1jYyIgb3B0aW9uIHRvIGdpdC1z
ZW5kLWVtYWlsLgoKQW55d2F5LCB0aGlzIGlzIHdoYXQgSSBkby4gU29tZW9uZSBoYXMgcHJvYmFi
bHkgYSBsb3QgYmV0dGVyIGZsb3cgdGhvLgoKPiBJIGRvbid0IGZlZWwgSSBjYW4gdHJ1c3QgdGhl
IHNjcmlwdCB0byBkbyBUaGUgUmlnaHQgVGhpbmfihKIgYWxsIHRoZSB0aW1lCj4gdG8gcHV0IGlu
dG8gbXkgaG9va3MuIEkgZXhwZWN0IGl0IHRvIGJsb3cgdXAgb24gdHJlZS13aWRlIHBhdGNoZXMg
Zm9yCj4gaW5zdGFuY2UuCgpZZWFoLCBub3QgZXZlbiBnb2luZyB0aGVyZS4gOi0pCgpIVEguCgot
LSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90
Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
