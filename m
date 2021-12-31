Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
 <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com> <Yc2MprJJsm7LagGc@zn.tnic>
 <7a703955-cd1c-e074-17dd-a9155aa7690a@huawei.com>
 <207b6257-22bc-c9fe-6206-4096d8e0d276@huawei.com>
Message-ID: <e8ff0399-6cd0-8606-3aab-6b7b8e741ed9@huawei.com>
Date: Fri, 31 Dec 2021 20:29:51 +0800
MIME-Version: 1.0
In-Reply-To: <207b6257-22bc-c9fe-6206-4096d8e0d276@huawei.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>



On 2021/12/31 17:22, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/30 19:08, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/12/30 18:40, Borislav Petkov wrote:
>>> On Thu, Dec 30, 2021 at 06:14:59PM +0800, Leizhen (ThunderTown) wrote:
>>>>
>>>> Hi, Dave, Baoquan, Borislav:
>>>>   What do you think about the introduction of parse_crashkernel_high_low()? If everyone
>>>> doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
>>>> patches, see below. If there's any objection, I still strongly recommend removing the
>>>> parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().
>>>>
>>>> How about splitting __parse_crashkernel() into two parts? One for parsing
>>>> "crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
>>>> suffixes in the future. So the parameter requirements are clear at the lowest level.
>>>
>>> First of all, please do not top post!
>>>
>>> Now, I already explained to you what I'd like to see:
>>>
>>> https://lore.kernel.org/r/Ycs3kpZD/vpoo1AX@zn.tnic
>>>
>>> yet you still don't get it.
>>>
>>> So let me make myself clear: in its current form, this is not really an
>>> improvement so for all x86 changes:
>>>
>>> NAKed-by: Borislav Petkov <bp@suse.de>
> 
> Hi Borislav:
>   I'm sorry to bother you again. Do you mind if I make the following changes?
> I can't stand so many comments appearing twice. Even if the size needs to be
> changed in the future, mode "low_size = CRASH_LOW_SIZE_MIN + <increment>" can
> be used for adaptation without affecting other architectures.

I rethink it, the default value of default_nslabs is IO_TLB_DEFAULT_SIZE=64M.
The value of default_nslabs can only be changed by swiotlb_adjust_size() and
bootup command line option "swiotlb=". Currently, swiotlb_adjust_size() is
invoked only on x86, so I can just ignore it on arm64. Then, 64M is much
smaller than 256M, the first kernel works fine with the default 64M on arm64,
and I don't think the second kernel needs to grow to 256M. Therefore, I think
swiotlb_adjust_size() is probably a pseudo requirement for arm64.

So I will directly use 256M on arm64. If anyone gets into trouble, he/she can
add it back. Besides, there is also "crashkernel=Y,low" can be used.

> 
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index e04f5e6eb33f453..da485ee51a9929e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -428,16 +428,7 @@ static int __init reserve_crashkernel_low(void)
>         /* crashkernel=Y,low */
>         ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
>         if (ret) {
> -               /*
> -                * two parts from kernel/dma/swiotlb.c:
> -                * -swiotlb size: user-specified with swiotlb= or default.
> -                *
> -                * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> -                * to 8M for other buffers that may need to stay low too. Also
> -                * make sure we allocate enough extra low memory so that we
> -                * don't run out of DMA buffers for 32-bit devices.
> -                */
> -               low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +               low_size = CRASH_LOW_SIZE_MIN;
>         } else {
>                 /* passed with crashkernel=0,low ? */
>                 if (!low_size)
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..c85b15814312b7e 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -69,6 +69,17 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  #define VMCOREINFO_CONFIG(name) \
>         vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
> 
> +/*
> + * two parts from kernel/dma/swiotlb.c:
> + * -swiotlb size: user-specified with swiotlb= or default.
> + *
> + * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> + * to 8M for other buffers that may need to stay low too. Also
> + * make sure we allocate enough extra low memory so that we
> + * don't run out of DMA buffers for 32-bit devices.
> + */
> +#define CRASH_LOW_SIZE_MIN     max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
>  extern unsigned char *vmcoreinfo_data;
>  extern size_t vmcoreinfo_size;
>  extern u32 *vmcoreinfo_note;
> 
> 
>>>
>>
>> OK, thanks for your immediate reply, so I can take less detours.
>>
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
