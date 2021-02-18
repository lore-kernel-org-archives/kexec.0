Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCdvo-00032a-GG
 for kexec@lists.infradead.org; Thu, 18 Feb 2021 07:41:02 +0000
Date: Thu, 18 Feb 2021 15:40:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v14 09/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL
 config
Message-ID: <20210218074047.GA468@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-10-chenzhou10@huawei.com>
 <20210218073104.GI2871@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210218073104.GI2871@MiWiFi-R3L-srv>
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
To: Chen Zhou <chenzhou10@huawei.com>, rppt@kernel.org
Cc: horms@verge.net.au, John.P.donnelly@oracle.com, wangkefeng.wang@huawei.com, arnd@arndb.de, will@kernel.org, corbet@lwn.net, catalin.marinas@arm.com, xiexiuqi@huawei.com, guohanjun@huawei.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, dyoung@redhat.com, kexec@lists.infradead.org, nsaenzjulienne@suse.de

On 02/18/21 at 03:31pm, Baoquan He wrote:
> On 01/30/21 at 03:10pm, Chen Zhou wrote:
> > We make the functions reserve_crashkernel[_low]() as generic for
> > x86 and arm64. Since reserve_crashkernel[_low]() implementations
> > are quite similar on other architectures as well, we can have more
> > users of this later.
> > 
> > So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
> > select this by X86 and ARM64.
> > 
> > Suggested-by: Mike Rapoport <rppt@kernel.org>
> > Suggested-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  arch/Kconfig        | 3 +++
> >  arch/arm64/Kconfig  | 1 +
> >  arch/x86/Kconfig    | 2 ++
> >  kernel/crash_core.c | 7 ++-----
> >  4 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 24862d15f3a3..0ca1ff5bb157 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -24,6 +24,9 @@ config KEXEC_ELF
> >  config HAVE_IMA_KEXEC
> >  	bool
> >  
> > +config ARCH_WANT_RESERVE_CRASH_KERNEL
> > +	bool
> > +
> >  config SET_FS
> >  	bool
> >  
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index f39568b28ec1..09365c7ff469 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -82,6 +82,7 @@ config ARM64
> >  	select ARCH_WANT_FRAME_POINTERS
> >  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> >  	select ARCH_WANT_LD_ORPHAN_WARN
> > +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
> >  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> >  	select ARM_AMBA
> >  	select ARM_ARCH_TIMER
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 21f851179ff0..e6926fcb4a40 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -12,6 +12,7 @@ config X86_32
> >  	depends on !64BIT
> >  	# Options that are inherently 32-bit kernel only:
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> > +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
> >  	select CLKSRC_I8253
> >  	select CLONE_BACKWARDS
> >  	select GENERIC_VDSO_32
> > @@ -28,6 +29,7 @@ config X86_64
> >  	select ARCH_HAS_GIGANTIC_PAGE
> >  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >  	select ARCH_USE_CMPXCHG_LOCKREF
> > +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
> >  	select HAVE_ARCH_SOFT_DIRTY
> >  	select MODULES_USE_ELF_RELA
> >  	select NEED_DMA_MAP_STATE
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 8479be270c0b..2c5783985db5 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -320,9 +320,7 @@ int __init parse_crashkernel_low(char *cmdline,
> >   * --------- Crashkernel reservation ------------------------------
> >   */
> >  
> > -#ifdef CONFIG_KEXEC_CORE
> > -
> > -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> > +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
> >  static int __init reserve_crashkernel_low(void)
> >  {
> >  #ifdef CONFIG_64BIT
> > @@ -450,8 +448,7 @@ void __init reserve_crashkernel(void)
> >  	crashk_res.start = crash_base;
> >  	crashk_res.end   = crash_base + crash_size - 1;
> >  }
> > -#endif
> > -#endif /* CONFIG_KEXEC_CORE */
> > +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
> 
> Why don't you move the dummy reserve_crashkernel() here too?
> 
> #ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
> #ifdef CONFIG_KEXEC_CORE
> ...
>   '...the real crashkernel reservation code...'
> ...
> #else                     
> static void __init reserve_crashkernel(void)
> {
> }                                               
> #endif
> #endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
> 
> Like this, you don't need those two dummy reserve_crashkernel() in x86
> and arm64?

Sorry, I was wrong. It's impossible like this since
CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL is selected only if KEXEC_CORE is
true. Please ignore this comment.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
