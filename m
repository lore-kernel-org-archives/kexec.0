Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2957AE7717D
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2Zf4tIrd29R5J2r7yftRc3B6Er8KImJJX9HlIEJ1iU=; b=1BbMO0PaF+IdEItpQc/tDa91jb
	xYAgS9gq6v/no5PAmQAgXPJVSh9D0iAmcLayUlj3FsYHb+saaABmCOPoxKZYjQMgXQ+HsUKswHBAo
	4Gaqp3AepKgCsC0X0GHbWcFl8o3IORah+OaPagutIN4/Q7bhOWjuTsI/jehGygCW9KWZqXIJqfDBR
	zHDtyGizBjuV3Z4RxxC1D0CUqaGhuKC6z53ciHym5fP54OC+pbHzZUvSTHUZiLu/q6D6x9QsU6i3R
	6FNQhoAVsvzYNGbYIsVD3eaFBK4qgrUTysSqUbXDu2oGyyCaQUfbZQabWLuLgKSChP5wf8sLej6Nj
	0tTjfuug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLYFi-0000000Ggqk-2dZA;
	Thu, 12 Dec 2024 01:44:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLYFe-0000000Ggq4-0vU2
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 01:44:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5C70D5C687A;
	Thu, 12 Dec 2024 01:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5EEC4CED2;
	Thu, 12 Dec 2024 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733967864;
	bh=34vk6AEt+sQ+WlXMU2daDueKQ3iZvBQUNASg9c9mZCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dL8TQ+GGYSGiOYTO3ti9GFhqBl6GdZSyHfRMQxVaI4S9arYXMR5OlJxcNLJHpd8c9
	 cmwUoWG0B1V5MHJNEfbzhnmRZ6EfSrnV3DIHGwtBLaLyNXPfbTpL+QfvCvuP70tiAQ
	 Wyq3KGygkjL5pAHn7suGi/F1PvYCjeg1rx9VCja/h+NzOP2rxhRjvh1/6o40CZw9q/
	 CMXwFf1/gwKHwbX8xEhYRFJRzRH+5PEe0P7OnL0uPYUptWC7PBVW8/V7dLMf0YQV2S
	 F5pW3wCIpltmF9FBCbFzDQZbsFW8dvpAI2qNCn3VRWPEFLXarBYqV9ZTks/yZ+qK0G
	 GiPYvr0PDNtvQ==
Date: Wed, 11 Dec 2024 18:44:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
Message-ID: <20241212014418.GA532802@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205153343.3275139-14-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_174426_352036_2AE13629 
X-CRM114-Status: GOOD (  24.23  )
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

Hi David,

On Thu, Dec 05, 2024 at 03:05:19PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> All writes to the page now happen before it gets marked as executable
> (or after it's already switched to the identmap page tables where it's
> OK to be RWX).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c9fd60f8f806..9232ad1562c8 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
>  
> -	set_memory_x((unsigned long)control_page, 1);
> +	set_memory_rox((unsigned long)control_page, 1);
>  
>  	return 0;
>  }
> @@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
>  	void *control_page = page_address(image->control_code_page);
>  
>  	set_memory_nx((unsigned long)control_page, 1);
> +	set_memory_rw((unsigned long)control_page, 1);
>  
>  	free_transition_pgtable(image);
>  }
> -- 
> 2.47.0
> 

I just bisected a change in behavior that I see in to this change in
-next as commit 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as
ROX instead of RWX"). I usually kexec my machines by running:

  # kexec --load /boot/vmlinuz-linux --initrd /boot/initramfs-linux.img --reuse-cmdline

  # systemctl kexec

to cleanly shutdown userspace then kexec into the new kernel after
installing it via the package manager. After this change, I get sent to
systemd-boot after running 'systemctl kexec', which selects the default
entry, my distribution kernel.

I just see:

  [  OK  ] Reached target Reboot via kexec.
  BdsDxe: loading Boot0007 "Linux Boot Manager" from HD(1,GPT,4B5AFD80-5EC7-47FC-83EA-7EC88ACB15A7,0x800,0x200000)/\EFI\systemd\systemd-bootx64.efi
  BdsDxe: starting Boot0007 "Linux Boot Manager" from HD(1,GPT,4B5AFD80-5EC7-47FC-83EA-7EC88ACB15A7,0x800,0x200000)/\EFI\systemd\systemd-bootx64.efi

then the systemd-boot menu in QEMU when reproducing this there.

Is this expected? If not, I am happy to provide any information or test
patches as necessary.

Cheers,
Nathan

# bad: [91e71d606356e50f238d7a87aacdee4abc427f07] Add linux-next specific files for 20241211
# good: [7cb1b466315004af98f6ba6c2546bb713ca3c237] Merge tag 'locking_urgent_for_v6.13_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start '91e71d606356e50f238d7a87aacdee4abc427f07' '7cb1b466315004af98f6ba6c2546bb713ca3c237'
# good: [9bad64b10df19351b07b2b93048635b5f8ead706] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 9bad64b10df19351b07b2b93048635b5f8ead706
# good: [bbc8183219f75fe643d317bd335742adf512e7e1] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good bbc8183219f75fe643d317bd335742adf512e7e1
# bad: [0628a859f2df1bda9b05393f4eb931fa41c81296] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
git bisect bad 0628a859f2df1bda9b05393f4eb931fa41c81296
# good: [c768ae7d664f116d55257647d7c60e4980b3f740] Merge branch 'next' of git://github.com/cschaufler/smack-next
git bisect good c768ae7d664f116d55257647d7c60e4980b3f740
# bad: [93a9ff8f5de55d40ab01b36227307b9e1aa61f16] Merge branch into tip/master: 'x86/boot'
git bisect bad 93a9ff8f5de55d40ab01b36227307b9e1aa61f16
# good: [72f64caa52d11b73c0b886aafaa3f549b49a3b84] Merge branch into tip/master: 'perf/core'
git bisect good 72f64caa52d11b73c0b886aafaa3f549b49a3b84
# good: [2a77e4be12cb58bbf774e7c717c8bb80e128b7a4] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
git bisect good 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
# good: [4b5bc2ec9a239bce261ffeafdd63571134102323] x86/kexec: Allocate PGD for x86_64 transition page tables separately
git bisect good 4b5bc2ec9a239bce261ffeafdd63571134102323
# good: [b7155dfd4999211247cce40be2665c71235ab094] x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
git bisect good b7155dfd4999211247cce40be2665c71235ab094
# bad: [a3eaa2be7004ed7ce5cf8939c660e44a15fc3665] x86/sysfs: Constify 'struct bin_attribute'
git bisect bad a3eaa2be7004ed7ce5cf8939c660e44a15fc3665
# bad: [5a82223e0743fb36bcb99657772513739d1a9936] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
git bisect bad 5a82223e0743fb36bcb99657772513739d1a9936
# good: [93e489ad7a4694bb2fe8110f5012f85bd3eee65a] x86/kexec: Clean up register usage in relocate_kernel()
git bisect good 93e489ad7a4694bb2fe8110f5012f85bd3eee65a
# first bad commit: [5a82223e0743fb36bcb99657772513739d1a9936] x86/kexec: Mark relocate_kernel page as ROX instead of RWX

