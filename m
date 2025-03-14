Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B13C282EC
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1K0VBuqd4wPOUK46Hze2/kNs3ONQzRwmuIpApLZmXc=; b=uW/6lpS19OQvQ7OQU0XHEM2OKU
	DaSQbbakNkJL5dMGCMTHbtLSzbW/hmkutsGtBXZcjhIInFJNGiNiTRN+whqVEdeEIUaVk5QSbg76x
	1olWdTW4n5RdM1Oegw3nVXCS4QsYEInR+pJz7uYlnDj6CL2SEQ2mfYJRgX8Ehzg86KHMwCxhyUFhc
	Jdo/DfH4F1FUQyQjIJkzeLfe+HsWkegHJqtmib6/nNmnaQcLHTwzY0LFzhoGldS67fKTJbOacYYAA
	PZOby0RlRhA1i+eDGlVMi84q16fNqgMMzyTuI+vX/HwwFK+l+McSzCczIxo6OgJYnub6hXXm+Dtnn
	WDpR3ubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9Sp-0000000EyzT-3cy8;
	Fri, 14 Mar 2025 18:08:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9DN-0000000EwSn-22zl
	for kexec@lists.infradead.org;
	Fri, 14 Mar 2025 17:52:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 622665C4A31;
	Fri, 14 Mar 2025 17:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66CCC4CEE3;
	Fri, 14 Mar 2025 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974775;
	bh=5g8HVlEZNBZf95r55n45O6hgoNz0UUSUIU9ZhFx25DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POkAVb8U62Loy7N6T3lCrkfQxTNhGrLfAYVnSbSFHz08vRAvlkHmDn9omL1T5YJvw
	 +2vIlLjsYRmWUSkDlp6fp9Dlt7NfkXa427L3Es/QFetlbitu1S5szwcdiPabQh7z6T
	 PW3R9G82ujHmdQVnzmaghWjhTMXHEan9tiVw22XfUgTx7rrPN76OcEVNPgzphhYnzv
	 WwJVdI5Be4C7qUVXbec7o0BLkmXNTPvpIUwEr/P850OSWxkzwqXuv+JMAmdCouZfqj
	 QyN4RCyRuwHV+nX85g+J9lu/M9NCywGo2+tc+wAc7BdRdTWoP46HmC0tSQygh+OEMJ
	 X70Yxoo33CArw==
Date: Fri, 14 Mar 2025 10:52:53 -0700
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
Message-ID: <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_105257_575555_AFA7D6B8 
X-CRM114-Status: GOOD (  13.96  )
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

On Fri, Mar 14, 2025 at 05:23:15PM +0000, David Woodhouse wrote:
> ISTR this version is OK with Clang and CONFIG_CFI_CLANG but with GCC I
> get this:
> 
> vmlinux.o: warning: objtool: relocate_kernel+0x69: unsupported stack register modification
> 
>         /* setup a new stack at the end of the physical control page */
>         lea     PAGE_SIZE(%rsi), %rsp
>   79:   48 8d a6 00 10 00 00    lea    0x1000(%rsi),%rsp
> 
> 
> Maybe the answer is to put the UNWIND_HINT_FUNC into #ifdef
> CONFIG_CFI_CLANG but that seems wrong.

The UNWIND_HINT_FUNC definitely looks wrong, why would Clang need it?

> I'll have another look at putting it in the data section, and see if I
> can remember why I didn't want to do that before (and if that's still
> relevant now).

IIRC, the reasons were the patched alternative, and also you wanted to
disassemble (but note that's still possible with gdb).

Here was a patch to make it work:

  https://lore.kernel.org/20241218212326.44qff3i5n6cxuu5d@jpoimboe

-- 
Josh

