Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3H75-0006aw-Er
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 07:11:48 +0000
Date: Wed, 26 Apr 2017 15:11:14 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 2/3] powerpc/fadump: Use the correct
 VMCOREINFO_NOTE_SIZE for phdr
Message-ID: <20170426071114.GC5381@dhcp-128-65.nay.redhat.com>
References: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
 <1492688374-27903-2-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1492688374-27903-2-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

Ccing ppc list
On 04/20/17 at 07:39pm, Xunlei Pang wrote:
> vmcoreinfo_max_size stands for the vmcoreinfo_data, the
> correct one we should use is vmcoreinfo_note whose total
> size is VMCOREINFO_NOTE_SIZE.
> 
> Like explained in commit 77019967f06b ("kdump: fix exported
> size of vmcoreinfo note"), it should not affect the actual
> function, but we better fix it, also this change should be
> safe and backward compatible.
> 
> After this, we can get rid of variable vmcoreinfo_max_size,
> let's use the corresponding macros directly, fewer variables
> means more safety for vmcoreinfo operation.
> 
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
> v3->v4:
> -Rebased on the latest linux-next
> 
>  arch/powerpc/kernel/fadump.c | 3 +--
>  include/linux/crash_core.h   | 1 -
>  kernel/crash_core.c          | 3 +--
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 466569e..7bd6cd0 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -893,8 +893,7 @@ static int fadump_create_elfcore_headers(char *bufp)
>  
>  	phdr->p_paddr	= fadump_relocate(paddr_vmcoreinfo_note());
>  	phdr->p_offset	= phdr->p_paddr;
> -	phdr->p_memsz	= vmcoreinfo_max_size;
> -	phdr->p_filesz	= vmcoreinfo_max_size;
> +	phdr->p_memsz	= phdr->p_filesz = VMCOREINFO_NOTE_SIZE;
>  
>  	/* Increment number of program headers. */
>  	(elf->e_phnum)++;
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index ba283a2..7d6bc7b 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -55,7 +55,6 @@
>  
>  extern u32 *vmcoreinfo_note;
>  extern size_t vmcoreinfo_size;
> -extern size_t vmcoreinfo_max_size;
>  
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 0321f04..43cdb00 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -16,7 +16,6 @@
>  /* vmcoreinfo stuff */
>  static unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> -size_t vmcoreinfo_max_size = VMCOREINFO_BYTES;
>  u32 *vmcoreinfo_note;
>  
>  /*
> @@ -343,7 +342,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	r = vscnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
>  
> -	r = min(r, vmcoreinfo_max_size - vmcoreinfo_size);
> +	r = min(r, VMCOREINFO_BYTES - vmcoreinfo_size);
>  
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>  
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
