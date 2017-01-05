Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cP1NP-0003ol-HX
 for kexec@lists.infradead.org; Thu, 05 Jan 2017 06:18:16 +0000
Date: Thu, 5 Jan 2017 14:17:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/5] crash: move crashkernel parsing and vmcore
 related code under CONFIG_CRASH_CORE
Message-ID: <20170105061745.GA9679@dhcp-128-65.nay.redhat.com>
References: <148336637462.25358.5151364413645288219.stgit@hbathini.in.ibm.com>
 <148336641471.25358.1234744226675502511.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <148336641471.25358.1234744226675502511.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com

Hi, Hari

On 01/02/17 at 07:43pm, Hari Bathini wrote:
> Traditionally, kdump is used to save vmcore in case of a crash. Some
> architectures like powerpc can save vmcore using architecture specific
> support instead of kexec/kdump mechanism. Such architecture specific
> support also needs to reserve memory, to be used by dump capture kernel.
> crashkernel parameter can be a reused, for memory reservation, by such
> architecture specific infrastructure.
> 
> But currently, code related to vmcoreinfo and parsing of crashkernel
> parameter is built under CONFIG_KEXEC_CORE. This patch introduces
> CONFIG_CRASH_CORE and moves the above mentioned code under this config,
> allowing code reuse without dependency on CONFIG_KEXEC. There is no
> functional change with this patch.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
> 
> Changes from v2:
> * Used CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE at
>   appropriate places in printk and ksysfs.
> 
> 
>  arch/Kconfig               |    4 
>  include/linux/crash_core.h |   65 ++++++
>  include/linux/kexec.h      |   57 ------
>  include/linux/printk.h     |    4 
>  kernel/Makefile            |    1 
>  kernel/crash_core.c        |  445 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_core.c        |  404 ----------------------------------------
>  kernel/ksysfs.c            |    8 +
>  kernel/printk/printk.c     |    6 -
>  9 files changed, 531 insertions(+), 463 deletions(-)
>  create mode 100644 include/linux/crash_core.h
>  create mode 100644 kernel/crash_core.c
> 

[snip]

>  #ifndef CONFIG_TINY_RCU
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 8b26964..d0dfebd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -32,7 +32,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/memblock.h>
>  #include <linux/syscalls.h>
> -#include <linux/kexec.h>
> +#include <linux/crash_core.h>
>  #include <linux/kdb.h>
>  #include <linux/ratelimit.h>
>  #include <linux/kmsg_dump.h>
> @@ -951,7 +951,7 @@ const struct file_operations kmsg_fops = {
>  	.release = devkmsg_release,
>  };
>  
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_CORE
>  /*
>   * This appends the listed symbols to /proc/vmcore
>   *
> @@ -960,7 +960,7 @@ const struct file_operations kmsg_fops = {
>   * symbols are specifically used so that utilities can access and extract the
>   * dmesg log from a vmcore file after a crash.
>   */
> -void log_buf_kexec_setup(void)
> +void log_buf_crash_setup(void)

I can not think of any better name about the CONFIG_CRASH_CORE though I
feel it is not excellent so personally I can live with it.

But for this function name log_buf_crash_setup is too general, I can not get
what it is doing from the name, how about change it to log_buf_vmcoreinfo_setup

>  {
>  	VMCOREINFO_SYMBOL(log_buf);
>  	VMCOREINFO_SYMBOL(log_buf_len);
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
