Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E83C282DE
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0cQvAKCp2QBzH5Iqn/xhey3MnO7N7m8c86D0wXyaXo=; b=cEPl78qGbicAgHDGRyZbV9ZoVk
	OyGl1SALX4bCrlTnRYwCpgqDC+CqyTdepO/zwXbX6hEBMlNrNOxsHDsTnu9H5KJzXJpgg7pd54WtN
	kje3i/0R5FPMTLWTyVoX0ZEEUmBz87zIj//hinKkMd2w9dT4gbIM4t6rLaDQpeD0F4aYHuiBifFLB
	TYubsugoi2U3/qW1Nm5NLm+kxM2Wza+/f0pUAYZF+vfoGWZvPqCC6/JIaISEXTW3DQrbSln3WWLeD
	w6+lMQqb18IxqhLqZOTwfVr41bp7m3MMevBbKThmVpLbeUrBd0AH64OdIkWrC+kvaW8xNUWFiqun9
	s00muYjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsgET-0000000AxKj-1YGR;
	Thu, 13 Mar 2025 10:56:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsg4z-0000000AvTy-3Jkn
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 10:46:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 449A55C487D;
	Thu, 13 Mar 2025 10:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A139C4CEDD;
	Thu, 13 Mar 2025 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862780;
	bh=vp6EbvU1rvNWK2KUsT3PKhqiMCwg7EHYtb3O8meg2es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLLh1Bwu+h7c8wLZOnsoo6txJm3UYCHpIXJ4M3GjWJzoDusKCvkROHfDm92bCWiZk
	 co6XAVN2udWnzHSwWRlfmidQtp9AkGR8Yw+zdFPnXgPjfZEmN0BWG4/G24wRHcNYC8
	 WMdQZVB2DlknBVRFFePGftf3dhM7I8/wblddoL1Oz+6iFr3MtMYyljWw/iLgbWL+d0
	 vdSBAs7LkQRcXtgZk/DIfrzNY1HjE/+jLohlQJ9CzrXQ8cI3beFMV4ytO0UNhg3pLi
	 YURe7XMvIDBQ036BDXYWXzXvgOpd2vKFmPUYpkW6A9RCxNiglwwzsCuxpOZ7Okp6dw
	 oV1635hkw4g3w==
Date: Thu, 13 Mar 2025 11:46:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9K3dcMAgu3cot85@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_034621_884567_F5EC5209 
X-CRM114-Status: GOOD (  21.35  )
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> Debugging kexec failures is painful, as anything going wrong in execution
> of the critical relocate_kernel() function tends to just lead to a triple
> fault. Thus leading to *weeks* of my life that I won't get back. Having
> hacked something up for my own use, I figured I should share it...
> 
> Add a trivial exception handler in the relocate_kernel environment which 
> outputs to the early_printk serial console if configured. Currently only 
> 8250-compatible serial ports are supported, but that could be extended.
> 
> I had to hack up QEMU support for a PCI serial port which matches what
> the existing early_printk code can drive, and the *real* 8250_pci driver
> doesn't seem to cope with that setup at all, but whatever... the kexec
> code now drives the same 32-bit stride which is all that earlyprintk
> supports. We can always add more later, if anyone cares.
> 
> Someone who cares might want to bring the i386 version into line with
> this, although the lack of rip-based addressing makes all the PIC code a
> bit harder.
> 
> David Woodhouse (8):
>       x86/kexec: Debugging support: load a GDT
>       x86/kexec: Debugging support: Load an IDT and basic exception entry points
>       x86/kexec: Debugging support: Dump registers on exception
>       x86/kexec: Add 8250 serial port output
>       x86/kexec: Add 8250 MMIO serial port output
>       x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
>       [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
>       [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
> 
>  arch/x86/include/asm/kexec.h         |   7 ++
>  arch/x86/kernel/early_printk.c       |   9 ++
>  arch/x86/kernel/machine_kexec_64.c   |  50 ++++++--
>  arch/x86/kernel/relocate_kernel_64.S | 254 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 308 insertions(+), 12 deletions(-)

I applied the first 3 patches to tip:x86/boot for phased-risk-reduction 
reasons, and because I had some questions and suggestions starting at 
patch #4.

Thanks,

	Ingo

