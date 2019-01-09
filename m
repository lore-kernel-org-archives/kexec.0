Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh7ms-0006o9-Fy
 for kexec@lists.infradead.org; Wed, 09 Jan 2019 06:56:28 +0000
Received: by mail-it1-f193.google.com with SMTP id b5so9567669iti.2
 for <kexec@lists.infradead.org>; Tue, 08 Jan 2019 22:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20190109064302.26780-1-kasong@redhat.com>
In-Reply-To: <20190109064302.26780-1-kasong@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 9 Jan 2019 14:56:14 +0800
Message-ID: <CACPcB9eB19F+FDBOypwKK1co+nA-GCpW2ophcwva9AL5Qq+jhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, kexec_file_load: Don't setup EFI info if EFI
 runtime is not enabled
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org

CCing more people

On Wed, Jan 9, 2019 at 2:45 PM Kairui Song <kasong@redhat.com> wrote:
>
> Currenly with "efi=noruntime" in kernel command line, calling
> kexec_file_load will raise below problem:
>
> [   97.967067] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [   97.967894] #PF error: [normal kernel read fault]
> ...
> [   97.980456] Call Trace:
> [   97.980724]  efi_runtime_map_copy+0x28/0x30
> [   97.981267]  bzImage64_load+0x688/0x872
> [   97.981794]  arch_kexec_kernel_image_load+0x6d/0x70
> [   97.982441]  kimage_file_alloc_init+0x13e/0x220
> [   97.983035]  __x64_sys_kexec_file_load+0x144/0x290
> [   97.983586]  do_syscall_64+0x55/0x1a0
> [   97.983962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> When efi runtime is not enabled, efi memmap is not mapped, so just skip
> EFI info setup.
>
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 0d5efa34f359..53917a3ebf94 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>         struct efi_info *current_ei = &boot_params.efi_info;
>         struct efi_info *ei = &params->efi_info;
>
> +       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +               return 0;
> +
>         if (!current_ei->efi_memmap_size)
>                 return 0;
>
> --
> 2.20.1
>


-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
