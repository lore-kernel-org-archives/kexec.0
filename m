Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4AFC282EC
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcs1r5lExcQ2+N1cHXuzwPsja81gy91Sl6aiQCeKgOs=; b=5BwgoJW+03YQBWS1vmwMK6UV5O
	1uYTw+xHtjvihCQZniGN2KRHoao3USvSHWkRMIaSAvi/PrOQ+PRTdoUH7qVOaios9JlVUbuuQIpsf
	5zyQ2Jc3+2fnNUrtqJlrJFYZ0oD4hvPmTlY+Po4wdofjPrANjJZWMpQuIcZERFXbDQDb9VqNfof33
	yyLAELMH1h18ZeFvveHAHekkMbzUKdB0dIF0a6/y1s3tpc9hfkdGBsX+ETz7rEWhLAgqETwhV+EvC
	edC4ygqHJovHr4W7djt+7AyfthU0HCYkIYZAd5NDQXxTRd8hStnTxXNS3K4fOkD843N8I43mksSE+
	MTUEPXcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuKeA-00000004Fsy-1MFB;
	Tue, 18 Mar 2025 00:17:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuKe8-00000004Fs6-1xho
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 00:17:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EBF31A48E1E;
	Tue, 18 Mar 2025 00:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C63C4CEE3;
	Tue, 18 Mar 2025 00:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742257047;
	bh=ilTqUgoJ9BEMCciAl8Q1ZAI+r6rC2qfPQ3ckpNm9Nb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0sRRK4JcoDNftM5pE/Wu12IXxKsmc+62rtuit13aMh4UlbbVi7zO9RCqXFtzEL3S
	 JPOFGVdgcS8NydfE4SvXhwTvnePoTmYfP0g84d51pLNMlKxwwza07A5iPtmW9MC54k
	 5P8PKkLpdAZ65xsYmX1BLsR39Gu67yi4XES1mTkTYtTuFF6j+LfCNDFf8rDPwDbcqw
	 tK3wIvaMuaWKECnVkFRLumaJPULv+zeUQhJnrtd+uL/GXFGEdDyi0sI9x5TtfhRPWM
	 voQs6+LVLC1gMgwAJJer4jD2+1ZVtm6K3hzNb7dz6J/hq6RwL3qaGhCag6LjgdTFs2
	 nqR+HiBQUchNA==
Date: Mon, 17 Mar 2025 17:17:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_171728_560652_136821D8 
X-CRM114-Status: GOOD (  10.20  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Mar 17, 2025 at 12:40:14PM +0000, David Woodhouse wrote:
> On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
> > 
> > IIRC, the reasons were the patched alternative, and also you wanted to
> > disassemble (but note that's still possible with gdb).
> 
> It's meaningful output from 'objdump -S' that I miss. But OK.

FYI, this works:

  objdump -Srw -j .data..relocate_kernel vmlinux.o

-- 
Josh

