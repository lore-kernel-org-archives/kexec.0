Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v16 08/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL
 config
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-9-thunder.leizhen@huawei.com> <YbDmxIPdk7TKIKAU@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <092fd3d7-240a-da47-f252-c3c570cb8389@huawei.com>
Date: Thu, 9 Dec 2021 10:06:23 +0800
MIME-Version: 1.0
In-Reply-To: <YbDmxIPdk7TKIKAU@arm.com>
Content-Language: en-US
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>



On 2021/12/9 1:09, Catalin Marinas wrote:
> On Tue, Nov 23, 2021 at 08:46:43PM +0800, Zhen Lei wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 26b8ed11639da46..19256aa924c3b2c 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -24,6 +24,9 @@ config KEXEC_ELF
>>  config HAVE_IMA_KEXEC
>>  	bool
>>  
>> +config ARCH_WANT_RESERVE_CRASH_KERNEL
>> +	bool
>> +
>>  config SET_FS
>>  	bool
>>  
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index c4207cf9bb17ffb..4b99efa36da3793 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -95,6 +95,7 @@ config ARM64
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>  	select ARCH_WANT_LD_ORPHAN_WARN
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select ARCH_WANTS_NO_INSTR
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>  	select ARM_AMBA
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7399327d1eff79d..528034b4276ecf8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -12,6 +12,7 @@ config X86_32
>>  	depends on !64BIT
>>  	# Options that are inherently 32-bit kernel only:
>>  	select ARCH_WANT_IPC_PARSE_VERSION
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select CLKSRC_I8253
>>  	select CLONE_BACKWARDS
>>  	select GENERIC_VDSO_32
>> @@ -28,6 +29,7 @@ config X86_64
>>  	select ARCH_HAS_GIGANTIC_PAGE
>>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select HAVE_ARCH_SOFT_DIRTY
>>  	select MODULES_USE_ELF_RELA
>>  	select NEED_DMA_MAP_STATE
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 4dc2643fcbccf99..b23cfc0ca8905fd 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -321,9 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
>>   * --------- Crashkernel reservation ------------------------------
>>   */
>>  
>> -#ifdef CONFIG_KEXEC_CORE
>> -
>> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>> +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
>>  static int __init reserve_crashkernel_low(void)
>>  {
>>  #ifdef CONFIG_64BIT
>> @@ -451,8 +449,7 @@ void __init reserve_crashkernel(void)
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end   = crash_base + crash_size - 1;
>>  }
>> -#endif
>> -#endif /* CONFIG_KEXEC_CORE */
>> +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
> 
> Nitpick mostly but it may simplify the patches if the x86, arch/Kconfig
> and crash_core.c changes here could be moved to patch 5. The remaining
> select for arm64 should be moved to patch 7 and drop the #if change in
> that patch.
> 
> This way we can keep the x86 patches on a separate branch.

That's a good suggestion. I will do it.

> 
> Thanks.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
