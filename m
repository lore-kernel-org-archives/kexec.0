Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cPJrX-0005Rb-OI
 for kexec@lists.infradead.org; Fri, 06 Jan 2017 02:02:37 +0000
Date: Fri, 6 Jan 2017 10:02:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 1/5] crash: move crashkernel parsing and vmcore
 related code under CONFIG_CRASH_CORE
Message-ID: <20170106020203.GA2863@dhcp-128-65.nay.redhat.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363734065.11570.16982557619253687714.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <148363734065.11570.16982557619253687714.stgit@hbathini.in.ibm.com>
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

Hi Hari

Thanks for the update.

On 01/05/17 at 10:59pm, Hari Bathini wrote:
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
> Changes from v3:
> * Renamed log_buf_kexec_setup()to log_buf_vmcoreinfo_setup() instead of
>   log_buf_crash_setup().
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

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
