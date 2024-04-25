Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ACDC4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GEdPmRifr2qlcN/cRfyVgiKGrCZ8l2BqGPe9EFPAEt8=; b=VecGRRux9WvjvV
	w8SI/FU65JW7CuiElB6DzJCTVXb8b07c9fEFWtGi7Lz2fR/+BkylpP/Y9B+rl1OG0mr02lCkl+mw8
	6w6w0wu7h9aXQZXfD6EIIS66jE3i3hrSIOUV80PE55TddlzL1CGYQJLDac8kQogW8QyB54+gfce4H
	HfFi6XJ9zkg7RUdJgr6c4jcNn1XHS3MLMAMI0yzLE6Xin1y5z7BgnIZ8UWebt5QE0WVCFZRfM9X3L
	pPQac3y42jCYzs3k9BwuiyPd1JBxdwq66yjr0KBR1to7QNe29gaaoyBzUCZ8+5oQpd0oUhKeqMLPQ
	z0X77a0KBfTPmS1adfVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rztFd-00000007E2T-2Ioi;
	Thu, 25 Apr 2024 07:10:37 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rztFZ-00000007E03-1wFH;
	Thu, 25 Apr 2024 07:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714029027;
	bh=rmNCwj/QZXocvFu/SV+UsAbq1yc1Onrw5e/MM6tpI4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmasBUphC0hDmcDselWsqNDchcFNLbtyyIXYaTEfQv4BLOsVbY80KeyHb5BvHn9uV
	 mXfX+53b9fklgAHnv4JHOlIL0SSIIXm5AmCALLJVlcCrmQacW/Cc+9xB5aBl8A7Dwb
	 B9LRLV8RKBn3hp3tvoCofURazzoY7NMe3hrGTd84=
Date: Thu, 25 Apr 2024 09:10:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424201234.3cc2b509@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_001034_092992_1A64BE48 
X-CRM114-Status: GOOD (  10.80  )
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

T24gMjAyNC0wNC0yNCAyMDoxMjozNCswMDAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToKPiBPbiBU
dWUsIDIzIEFwciAyMDI0IDA5OjU0OjM1ICswMjAwIFRob21hcyBXZWnDn3NjaHVoIHdyb3RlOgo+
ID4gVGhlIHNlcmllcyB3YXMgc3BsaXQgZnJvbSBteSBsYXJnZXIgc2VyaWVzIHN5c2N0bC1jb25z
dCBzZXJpZXMgWzBdLgo+ID4gSXQgb25seSBmb2N1c3NlcyBvbiB0aGUgcHJvY19oYW5kbGVycyBi
dXQgaXMgYW4gaW1wb3J0YW50IHN0ZXAgdG8gYmUKPiA+IGFibGUgdG8gbW92ZSBhbGwgc3RhdGlj
IGRlZmluaXRpb25zIG9mIGN0bF90YWJsZSBpbnRvIC5yb2RhdGEuCj4gCj4gU3BsaXQgdGhpcyBw
ZXIgc3Vic3lzdGVtLCBwbGVhc2UuCgpVbmZvcnR1bmF0ZWx5IHRoaXMgd291bGQgaW50cm9kdWNl
IGFuIGVub3Jtb3VzIGFtb3VudCBvZiBjb2RlIGNodXJuLgoKVGhlIGZ1bmN0aW9uIHByb3RvdHlw
ZXMgZm9yIGVhY2ggY2FsbGJhY2sgaGF2ZSB0byBzdGF5IGNvbnNpc3RlbnQuClNvIGEgYW5vdGhl
ciBjYWxsYmFjayBtZW1iZXIgKCJwcm9jX2hhbmRsZXJfbmV3IikgaXMgbmVlZGVkIGFuZCB1c2Vy
cwp3b3VsZCBiZSBtaWdyYXRlZCB0byBpdCBncmFkdWFsbHkuCgpCdXQgdGhlbiAqYWxsKiBkZWZp
bml0aW9ucyBvZiAic3RydWN0IGN0bF90YWJsZSIgdGhyb3VnaG91dCB0aGUgdHJlZSBuZWVkIHRv
CmJlIHRvdWNoZWQuCkluIGNvbnRyYXN0LCB0aGUgcHJvcG9zZWQgc2VyaWVzIG9ubHkgbmVlZHMg
dG8gY2hhbmdlIHRoZSBoYW5kbGVyCmltcGxlbWVudGF0aW9ucywgbm90IHRoZWlyIHVzYWdlIHNp
dGVzLgoKVGhlcmUgYXJlIG1hbnksIG1hbnkgbW9yZSB1c2FnZSBzaXRlcyB0aGFuIGhhbmRsZXIg
aW1wbGVtZW50YXRpb25zLgoKRXNwZWNpYWxseSwgYXMgdGhlIG1ham9yaXR5IG9mIHN5c2N0bCB0
YWJsZXMgdXNlIHRoZSBzdGFuZGFyZCBoYW5kbGVycwoocHJvY19kb3N0cmluZywgcHJvY19kb2Jv
b2wsIC4uLikgYW5kIGFyZSBub3QgYWZmZWN0ZWQgYnkgdGhlIHByb3Bvc2VkCmFwcm9hY2ggYXQg
YWxsLgoKQW5kIHRoZW4gd2Ugd291bGQgaGF2ZSBpbnRyb2R1Y2VkIGEgbmV3IGhhbmRsZXIgbmFt
ZSAicHJvY19oYW5kbGVyX25ldyIKYW5kIG1heWJlIGhhdmUgdG8gZG8gdGhlIHdob2xlIHRoaW5n
IGFnYWluIHRvIHJlbmFtZSBpdCBiYWNrIHRvCnRoZSBvcmlnaW5hbCBhbmQgd2VsbC1rbm93biAi
cHJvY19oYW5kbGVyIi4KCgpPZiBjb3Vyc2UgaWYgc29tZWJvZHkgaGFzIGEgYmV0dGVyIGFwcm9h
Y2gsIEknbSBhbGwgZWFycy4KCgpUaG9tYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
