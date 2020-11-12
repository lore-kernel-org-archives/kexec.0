Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 12 Nov 2020 10:25:09 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v13 6/8] arm64: kdump: reimplement crashkernel=X
Message-ID: <20201112082509.GL4758@kernel.org>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-7-chenzhou10@huawei.com>
 <20201111015926.GD24747@MiWiFi-R3L-srv>
 <23389389-2855-50fd-25b7-4f7d4246bf0c@huawei.com>
 <20201111135448.GF8486@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111135448.GF8486@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, chenzhou <chenzhou10@huawei.com>, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Wed, Nov 11, 2020 at 09:54:48PM +0800, Baoquan He wrote:
> On 11/11/20 at 09:27pm, chenzhou wrote:
> > Hi Baoquan,
> ...
> > >>  #ifdef CONFIG_CRASH_DUMP
> > >>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> > >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > >> index 1c0f3e02f731..c55cee290bbb 100644
> > >> --- a/arch/arm64/mm/mmu.c
> > >> +++ b/arch/arm64/mm/mmu.c
> > >> @@ -488,6 +488,10 @@ static void __init map_mem(pgd_t *pgdp)
> > >>  	 */
> > >>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > >>  #ifdef CONFIG_KEXEC_CORE
> > >> +	if (crashk_low_res.end)
> > >> +		memblock_mark_nomap(crashk_low_res.start,
> > >> +				    resource_size(&crashk_low_res));
> > >> +
> > >>  	if (crashk_res.end)
> > >>  		memblock_mark_nomap(crashk_res.start,
> > >>  				    resource_size(&crashk_res));
> > >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > >> index d39892bdb9ae..cdef7d8c91a6 100644
> > >> --- a/kernel/crash_core.c
> > >> +++ b/kernel/crash_core.c
> > >> @@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
> > >>  
> > >>  int __init reserve_crashkernel_low(void)
> > >>  {
> > >> -#ifdef CONFIG_X86_64
> > >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> > > Not very sure if a CONFIG_64BIT checking is better.
> > If doing like this, there may be some compiling errors for other 64-bit kernel, such as mips.
> > >
> > >>  	unsigned long long base, low_base = 0, low_size = 0;
> > >>  	unsigned long low_mem_limit;
> > >>  	int ret;
> > >> @@ -362,12 +362,14 @@ int __init reserve_crashkernel_low(void)
> > >>  
> > >>  	crashk_low_res.start = low_base;
> > >>  	crashk_low_res.end   = low_base + low_size - 1;
> > >> +#ifdef CONFIG_X86_64
> > >>  	insert_resource(&iomem_resource, &crashk_low_res);
> > >> +#endif
> > >>  #endif
> > >>  	return 0;
> > >>  }
> > >>  
> > >> -#ifdef CONFIG_X86
> > >> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> > > Should we make this weak default so that we can remove the ARCH config?
> > The same as above, some arch may not support kdump, in that case,  compiling errors occur.
> 
> OK, not sure if other people have better idea, oterwise, we can leave with it. 
> Thanks for telling.

I think it would be better to have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
in arch/Kconfig and select this by X86 and ARM64.

Since reserve_crashkernel() implementations are quite similart on other
architectures as well, we can have more users of this later.

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
