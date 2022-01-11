From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:06:37 -0600
Subject: [PATCH v19 06/13] kexec: move crashk[_low]_res to crash_core
 module
In-Reply-To: <20211228132612.1860-7-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-7-thunder.leizhen@huawei.com>
Message-ID: <f376978b-095c-7ddd-54b4-1d6d91b3a00f@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Move the definition and declaration of global variable crashk[_low]_res
> from kexec module to crash_core module, in preparation of adding generic
> reserve_crashkernel_mem[_low]() to crash_core.c, the latter refers to
> variable crashk[_low]_res. Due to the config KEXEC automatically selects
> CRASH_CORE, and the header crash_core.h is included by kexec.h, so there
> is no functional change.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h |  4 ++++
>   include/linux/kexec.h      |  4 ----
>   kernel/crash_core.c        | 16 ++++++++++++++++
>   kernel/kexec_core.c        | 17 -----------------
>   4 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 598fd55d83c169e..f5437c9c9411fce 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -73,6 +73,10 @@ extern unsigned char *vmcoreinfo_data;
>   extern size_t vmcoreinfo_size;
>   extern u32 *vmcoreinfo_note;
>   
> +/* Location of a reserved region to hold the crash kernel. */
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len);
>   void final_note(Elf_Word *buf);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729e1e..47e784d66ea8645 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -350,10 +350,6 @@ extern int kexec_load_disabled;
>   #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
>   				 KEXEC_FILE_NO_INITRAMFS)
>   
> -/* Location of a reserved region to hold the crash kernel.
> - */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>   extern note_buf_t __percpu *crash_notes;
>   
>   /* flag to track if kexec reboot is in progress */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b7d024eb464d0ae..686d8a65e12a337 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -22,6 +22,22 @@ u32 *vmcoreinfo_note;
>   /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>   static unsigned char *vmcoreinfo_data_safecopy;
>   
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>   /*
>    * parsing the "crashkernel" commandline
>    *
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5a5d192a89ac307..1e0d4909bbb6b77 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -54,23 +54,6 @@ note_buf_t __percpu *crash_notes;
>   /* Flag to indicate we are going to kexec a new kernel */
>   bool kexec_in_progress = false;
>   
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>   int kexec_should_crash(struct task_struct *p)
>   {
>   	/*


