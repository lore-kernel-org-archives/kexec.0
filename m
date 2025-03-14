Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D79C35FF1
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jC+8ZPUY8ow0nbPzP37bx9HS7zA6yJveEwPZ9316pqU=; b=r8SRjqIe6J3UMXShPI4FD4Yb0k
	SV3tubhcDC219NEMq2suBlMkkW4rHkfDrZQQ3t7h+6HVVv1HFIDHR2Q1PsYPFESwCMTCkZkIz2UE0
	ZyfABRzri+Pqcf0r/7yG/pXc6OdGNxvuPKLzDkAezb5iimULmAxMB5eMtEpnOTKeKs4YBQ8OW214p
	d86AEB0UaCTV8Rb5g1M477aNbC24uedTOuIeaK3wfTAdUCNiB/lOeyoTNVeQNhqhYuTaV3j1EuKV4
	R1D3EIew728QGLOyphGxMfRzl5yqDXiP8BiVx5KgzmwaK4Myona+1mgMnkkO2MhhL8cDBIR5b8g0V
	dvUQ6TAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2Dv-0000000Dpkf-1HvY;
	Fri, 14 Mar 2025 10:25:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2Ax-0000000DpCL-14u2
	for kexec@lists.infradead.org;
	Fri, 14 Mar 2025 10:22:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C19CA5C5F04;
	Fri, 14 Mar 2025 10:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EECBC4CEE3;
	Fri, 14 Mar 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947718;
	bh=qsAR7IGLyouVJD2CjKZ6DJZIqEb+ylyHnejR69obERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sX0bQETV51qG6OQTUObd4PbwaAVsaNvjy85cBJM2BSXtcjas5CRTIh+e9UglawTOO
	 mVqGznot5zNaYJrD6vzXCoL8D8tSBWncc5QkqG4TlChx251E96L5DpOoycoEysmVU6
	 elrem52VxdPA7n1gP92M6NvxlAVvPY/OvEoy6vUFUJxd+CZXi+LDP7lWcRDDNXNfyI
	 1dn2FbJ/ITQjKQ+fNjP0HqK6m8knQpXIjwY30Nyy7couTJjvP4bmS9SEGywl2OFI75
	 euTMKShuh2cP/KBCmIIyaHLmvY+YPC5pWAgIGrRlD9Oqf/o6YvWbYG5rwcMhPaw5Wj
	 JrP16erpInW7w==
Date: Fri, 14 Mar 2025 11:21:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9QDP5NHp-5VupUS@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <Z9K3dcMAgu3cot85@gmail.com>
 <Z9K5TGMvmS1ApBCW@gmail.com>
 <7f36d90ada07281dd0efa4339c991cb2ecec4da2.camel@infradead.org>
 <48dc1e006cbbf1f8af4c9120795a840c601ed172.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48dc1e006cbbf1f8af4c9120795a840c601ed172.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_032159_365974_EC61BCE9 
X-CRM114-Status: GOOD (  15.00  )
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

> On Thu, 2025-03-13 at 19:58 +0000, David Woodhouse wrote:
> > 
> > Reproduced that by going back to x86-64 defconfig. 
> 
> Turns out the unret check doesn't even run unless CONFIG_DEBUG_ENTRY is
> enabled (which enables CONFIG_NOINSTR_VALIDATION and thus runs objtool
> on vmlinux.o). Which is why I didn't see it.
> 
> > vmlinux.o: warning: objtool: exc_handler+0xe: early indirect call
> 
> With Peter's help (thanks), this is fixed by adding VALIDATE_UNRET_END.
> I'll squash this into the next posting:
> 
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -481,6 +481,9 @@ SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
>  SYM_CODE_END(kexec_debug_exc_vectors)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
> +       /* No need for ret mitigations during kexec */
> +       VALIDATE_UNRET_END
> +
>         pushq   %rax
>         pushq   %rbx
>         pushq   %rcx

Great!

I've applied patch #1 back to tip:x86/boot.

I've skipped the -v7 versions of patch #2 and #3 because AFAICS you've 
changed exc_handler already, so a backmerge of this annotation fix 
wouldn't be enough.

Thanks,

	Ingo

