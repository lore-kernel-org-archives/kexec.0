Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0638EC04FFE
	for <kexec@archiver.kernel.org>; Sat, 11 May 2024 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sontts7bmswz3q+6wyZhThWBcOqf8mdU5yDVXulTjvE=; b=R583DDLG8Byt9h
	OrsAw0/R0RcpfPGyyVMrgq65tKLE6iyKsrfqadSlDLqe9+av5Bzsy/pjNUR2/xBlG33uPorFxH9sD
	cO9lah9TB5CXgKtB+O+2GSDiUkEWvvRSSqE8KtCtTuBceLSa12gk/QZmJis+UbsVuPjvqmpzqIxuz
	L0MmNLKAQK1AOFYR0xp0vQjhnqmsOrQLxS1n3drOXWyXiRURU/Q06y4oN87LUq9mSttArdkxANqkX
	nImsCBLQAh5JW1koRk8NAtmIlI/o4mqA8bI/zblg0TX3XY+sFLnfiPlJjEC/5CFU6cEjgQsOJAiNm
	zC7KJX6bAmWQbXR6izog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5jO9-00000007eus-0G6Z;
	Sat, 11 May 2024 09:51:33 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5jO3-00000007erl-2te6;
	Sat, 11 May 2024 09:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715421078;
	bh=0cJX+ofKilB0YeAddG2Rk34Tcb84daQhOHXhdzx0r3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k56XE3N3d4pgs8RXOwLSnRLB27sLWUfITEgcvrDMjZdmJPa/Ir6S6oi9PpE553jPt
	 sb7k+FxSLFp8Odclpb2t4vqVdgVnPhAwWUDBH9QwI80jAM7LA7gxjkMhJ80aDoR2yw
	 DUA3ugAMpnt1Nr9pHpMHzjCRdAMZeTMxIBsCjZb8=
Date: Sat, 11 May 2024 11:51:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Eric Dumazet <edumazet@google.com>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <8d1daa64-3746-46a3-b696-127a70cdf7e7@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
 <202405080959.104A73A914@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202405080959.104A73A914@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_025128_210643_587D38F8 
X-CRM114-Status: GOOD (  20.43  )
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

SGkgS2VlcywKCk9uIDIwMjQtMDUtMDggMTA6MTE6MzUrMDAwMCwgS2VlcyBDb29rIHdyb3RlOgo+
IE9uIFdlZCwgQXByIDI0LCAyMDI0IGF0IDA4OjEyOjM0UE0gLTA3MDAsIEpha3ViIEtpY2luc2tp
IHdyb3RlOgo+ID4gT24gVHVlLCAyMyBBcHIgMjAyNCAwOTo1NDozNSArMDIwMCBUaG9tYXMgV2Vp
w59zY2h1aCB3cm90ZToKPiA+ID4gVGhlIHNlcmllcyB3YXMgc3BsaXQgZnJvbSBteSBsYXJnZXIg
c2VyaWVzIHN5c2N0bC1jb25zdCBzZXJpZXMgWzBdLgo+ID4gPiBJdCBvbmx5IGZvY3Vzc2VzIG9u
IHRoZSBwcm9jX2hhbmRsZXJzIGJ1dCBpcyBhbiBpbXBvcnRhbnQgc3RlcCB0byBiZQo+ID4gPiBh
YmxlIHRvIG1vdmUgYWxsIHN0YXRpYyBkZWZpbml0aW9ucyBvZiBjdGxfdGFibGUgaW50byAucm9k
YXRhLgo+ID4gCj4gPiBTcGxpdCB0aGlzIHBlciBzdWJzeXN0ZW0sIHBsZWFzZS4KPiAKPiBJJ3Zl
IGRvbmUgYSBmZXcgcGFpbmZ1bCBBUEkgdHJhbnNpdGlvbnMgYmVmb3JlLCBhbmQgSSBkb24ndCB0
aGluayB0aGUKPiBjb21wbGV4aXR5IG9mIHRoZXNlIGNoYW5nZXMgbmVlZHMgYSBwZXItc3Vic3lz
dGVtIGNvbnN0aWZpY2F0aW9uIHBhc3MuIEkKPiB0aGluayB0aGlzIHNlcmllcyBpcyB0aGUgcmln
aHQgYXBwcm9hY2gsIGJ1dCB0aGF0IHBhdGNoIDExIHdpbGwgbmVlZAo+IGNvb3JkaW5hdGlvbiB3
aXRoIExpbnVzLiBXZSByZWd1bGFybHkgZG8gc3lzdGVtLXdpZGUgcHJvdG90eXBlIGNoYW5nZXMK
PiBsaWtlIHRoaXMgcmlnaHQgYXQgdGhlIGVuZCBvZiB0aGUgbWVyZ2Ugd2luZG93IGJlZm9yZSAt
cmMxIGNvbWVzIG91dC4KClRoYXQgc291bmRzIGdvb2QuCgo+IFRoZSByZXF1aXJlbWVudHMgYXJl
IHByZXR0eSBzaW1wbGU6IGl0IG5lZWRzIHRvIGJlIGEgb2J2aW91cyBjaGFuZ2VzCj4gKHRoaXMg
Y2VydGFpbmx5IGlzKSBhbmQgYXMgY2xvc2UgdG8gMTAwJSBtZWNoYW5pY2FsIGFzIHBvc3NpYmxl
LiBJIHRoaW5rCj4gcGF0Y2ggMTEgZWFzaWx5IHF1YWxpZmllcy4gTGludXMgc2hvdWxkIGJlIGFi
bGUgdG8gcnVuIHRoZSBzYW1lIENvY2NpbmVsbGUKPiBzY3JpcHQgYW5kIGdldCBuZWFybHkgdGhl
IHNhbWUgcmVzdWx0cywgZXRjLiBBbmQgYWxsIHRoZSBvdGhlciBjaGFuZ2VzCj4gbmVlZCB0byBo
YXZlIGxhbmRlZC4gVGhpcyBjaGFuZ2UgYWxzbyBoYXMgbm8gInNpbGVudCBmYWlsdXJlIiBjb25k
aXRpb25zOgo+IGFueXRoaW5nIG1pc21hdGNoZWQgd2lsbCBpbW1lZGlhdGVseSBzdGFuZCBvdXQu
CgpVbmZvcnR1bmF0ZWx5IGNvY2NpbmVsbGUgYWxvbmUgaXMgbm90IHN1ZmZpY2llbnQsIGFzIHNv
bWUgaGVscGVycyB3aXRoCmRpZmZlcmVudCBwcm90b3R5cGVzIGFyZSBjYWxsZWQgYnkgaGFuZGxl
cnMgYW5kIHRoZW1zZWx2ZXMgYXJlIGNhbGxpbmcKaGFuZGxlciBhbmQgdGhlcmVmb3JlIG5lZWQg
dG8gY2hhbmdlIGluIHRoZSBzYW1lIGNvbW1pdC4KQnV0IGlmIEkgYWRkIGEgZGlmZiBmb3IgdGhv
c2Ugb24gdG9wIG9mIHRoZSBjb2NjaW5lbGxlIHNjcmlwdCB0byB0aGUKY2hhbmdlbG9nIGl0IHNo
b3VsZCBiZSBvYnZpb3VzLgoKPiBTbywgaGF2ZSBwYXRjaGVzIDEtMTAgZ28gdmlhIHRoZWlyIHJl
c3BlY3RpdmUgc3Vic3lzdGVtcywgYW5kIG9uY2UgYWxsCj4gb2YgdGhvc2UgYXJlIGluIExpbnVz
J3MgdHJlZSwgc2VuZCBwYXRjaCAxMSBhcyBhIHN0YW5kLWFsb25lIFBSLgoKQWNrLCBJJ2xsIGRv
IHRoYXQgd2l0aCB0aGUgY292ZXIgbGV0dGVyIGluZm9ybWF0aW9uIHJlcXVlc3RlZCBieSBKb2Vs
LgoKPiAoRnJvbSBwYXRjaCAxMSwgaXQgbG9va3MgbGlrZSB0aGUgc2VjY29tcCByZWFkL3dyaXRl
IGZ1bmN0aW9uIGNoYW5nZXMKPiBjb3VsZCBiZSBzcGxpdCBvdXQ/IEknbGwgZG8gdGhhdCBub3cu
Li4pCgpUaGFua3MhCgpUaG9tYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
