Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D0C4345F
	for <kexec@archiver.kernel.org>; Sat, 27 Apr 2024 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZdHFFVdj3pGc9hCGxbSqAnUFPpYz5lrC7ClsZXF0ts=; b=0Cfy4lAIl1NzHf
	1A+m7JFF+eceOV4cyXnbwKo27zFiOKTV4p2FdcyxjFW+2SXi20Bz3wBMV5QhCmiO9hN105vy6+rSq
	WlZF4cpYroGvUH+hWqbKt2GoRXL184NHo7R44v0rbZO71frr38XqmYOo4TeddcrZJJW2nYnKs/6Bb
	DU3M6/STTzMNBwhhW592eCswigUI8pOSxgauXjoklIH6tWjD+DWamkQ5ZGN0mrZOnuV7/OsIki6wI
	utEpqg8c/g2IZz5osxPNaiNnfUuex+zHZj9q03TPK58TT+ArlhmeLIzRkqJkKX1HYzIdjoeIR6Apl
	jgd3oXFKoJ8dB3VbuThw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cg5-0000000F4pd-3bMy;
	Sat, 27 Apr 2024 07:40:57 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cg1-0000000F4oB-3mEB;
	Sat, 27 Apr 2024 07:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714203646;
	bh=CzgUKxV1DiRGrX9zQXzZL6Gotui8EXJUqYQ3eQT9fT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEqEbcAYbNH1Cl76LGX0IqteTFz6QZM2G7WkdPY5ve6JFJe7QvQdYePk2UkJVcvTR
	 6u5FIHxh7+/FsU6vrbi0R0NpqVH+T4CvlFrv7BQ8Kzndu1PmGsnulYTnxUn5nJrEUi
	 e3WiuV0em4CHQ+eAmWIJfWacyiMhggB7HEWeZqN8=
Date: Sat, 27 Apr 2024 09:40:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>, 
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
Message-ID: <38a87a0f-02c7-4072-9342-8f6697ea1a17@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
 <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_004054_221187_4F26E3F9 
X-CRM114-Status: GOOD (  18.68  )
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

T24gMjAyNC0wNC0yNSAwOToxMDoyNyswMDAwLCBUaG9tYXMgV2Vpw59zY2h1aCB3cm90ZToKPiBP
biAyMDI0LTA0LTI0IDIwOjEyOjM0KzAwMDAsIEpha3ViIEtpY2luc2tpIHdyb3RlOgo+ID4gT24g
VHVlLCAyMyBBcHIgMjAyNCAwOTo1NDozNSArMDIwMCBUaG9tYXMgV2Vpw59zY2h1aCB3cm90ZToK
PiA+ID4gVGhlIHNlcmllcyB3YXMgc3BsaXQgZnJvbSBteSBsYXJnZXIgc2VyaWVzIHN5c2N0bC1j
b25zdCBzZXJpZXMgWzBdLgo+ID4gPiBJdCBvbmx5IGZvY3Vzc2VzIG9uIHRoZSBwcm9jX2hhbmRs
ZXJzIGJ1dCBpcyBhbiBpbXBvcnRhbnQgc3RlcCB0byBiZQo+ID4gPiBhYmxlIHRvIG1vdmUgYWxs
IHN0YXRpYyBkZWZpbml0aW9ucyBvZiBjdGxfdGFibGUgaW50byAucm9kYXRhLgo+ID4gCj4gPiBT
cGxpdCB0aGlzIHBlciBzdWJzeXN0ZW0sIHBsZWFzZS4KPiAKPiBVbmZvcnR1bmF0ZWx5IHRoaXMg
d291bGQgaW50cm9kdWNlIGFuIGVub3Jtb3VzIGFtb3VudCBvZiBjb2RlIGNodXJuLgo+IAo+IFRo
ZSBmdW5jdGlvbiBwcm90b3R5cGVzIGZvciBlYWNoIGNhbGxiYWNrIGhhdmUgdG8gc3RheSBjb25z
aXN0ZW50Lgo+IFNvIGEgYW5vdGhlciBjYWxsYmFjayBtZW1iZXIgKCJwcm9jX2hhbmRsZXJfbmV3
IikgaXMgbmVlZGVkIGFuZCB1c2Vycwo+IHdvdWxkIGJlIG1pZ3JhdGVkIHRvIGl0IGdyYWR1YWxs
eS4KPiAKPiBCdXQgdGhlbiAqYWxsKiBkZWZpbml0aW9ucyBvZiAic3RydWN0IGN0bF90YWJsZSIg
dGhyb3VnaG91dCB0aGUgdHJlZSBuZWVkIHRvCj4gYmUgdG91Y2hlZC4KPiBJbiBjb250cmFzdCwg
dGhlIHByb3Bvc2VkIHNlcmllcyBvbmx5IG5lZWRzIHRvIGNoYW5nZSB0aGUgaGFuZGxlcgo+IGlt
cGxlbWVudGF0aW9ucywgbm90IHRoZWlyIHVzYWdlIHNpdGVzLgo+IAo+IFRoZXJlIGFyZSBtYW55
LCBtYW55IG1vcmUgdXNhZ2Ugc2l0ZXMgdGhhbiBoYW5kbGVyIGltcGxlbWVudGF0aW9ucy4KPiAK
PiBFc3BlY2lhbGx5LCBhcyB0aGUgbWFqb3JpdHkgb2Ygc3lzY3RsIHRhYmxlcyB1c2UgdGhlIHN0
YW5kYXJkIGhhbmRsZXJzCj4gKHByb2NfZG9zdHJpbmcsIHByb2NfZG9ib29sLCAuLi4pIGFuZCBh
cmUgbm90IGFmZmVjdGVkIGJ5IHRoZSBwcm9wb3NlZAo+IGFwcm9hY2ggYXQgYWxsLgo+IAo+IEFu
ZCB0aGVuIHdlIHdvdWxkIGhhdmUgaW50cm9kdWNlZCBhIG5ldyBoYW5kbGVyIG5hbWUgInByb2Nf
aGFuZGxlcl9uZXciCj4gYW5kIG1heWJlIGhhdmUgdG8gZG8gdGhlIHdob2xlIHRoaW5nIGFnYWlu
IHRvIHJlbmFtZSBpdCBiYWNrIHRvCj4gdGhlIG9yaWdpbmFsIGFuZCB3ZWxsLWtub3duICJwcm9j
X2hhbmRsZXIiLgoKVGhpcyBhcHJvYWNoIGNvdWxkIGJlIG9wdGltaXplZCBieSBvbmx5IG1pZ3Jh
dGluZyB0aGUgdXNhZ2VzIG9mIHRoZQpjdXN0b20gaGFuZGxlciBpbXBsZW1lbnRhdGlvbnMgdG8g
InByb2NfaGFuZGxlcl9uZXciLgpBZnRlciB0aGlzIHdlIGNvdWxkIG1vdmUgb3ZlciB0aGUgY29y
ZSBoYW5kbGVycyBhbmQgInByb2NfaGFuZGxlciIgaW4Kb25lIHNtYWxsIHBhdGNoIHRoYXQgZG9l
cyBub3QgbmVlZCB0byB0b3VjaCB0aGUgdXNhZ2VzIHNpdGVzLgoKQWZ0ZXJ3YXJkcyBhbGwgbm9u
LWNvcmUgdXNhZ2VzIHdvdWxkIGJlIG1pZ3JhdGVkIGJhY2sgZnJvbQoicHJvY19oYW5kbGVyX25l
dyIgdG8gInByb2NfaGFuZGxlciIgYW5kIHRoZSBfbmV3IHZhcmlhbnQgY291bGQgYmUKZHJvcHBl
ZCBhZ2Fpbi4KCkl0IHdvdWxkIHN0aWxsIGJlIG1vcmUgdGhhbiB0d2ljZSB0aGUgY2h1cm4gb2Yg
bXkgY3VycmVudCBwYXRjaC4KQW5kIHRoZXNlIHBhdGNoZXMgd291bGQgYmUgbW9yZSBjb21wbGV4
IHRoYW4gdGhlIGN1cnJlbnQKImp1c3QgYWRkIGEgYnVuY2ggb2YgY29uc3RzLCBub3RoaW5nIGVs
c2UiLgoKUGVyc29uYWxseSBJIHN0aWxsIHByZWZlciB0aGUgb3JpZ2luYWwgYXByb2FjaC4KCgpU
aG9tYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
