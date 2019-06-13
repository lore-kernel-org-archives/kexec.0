Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
Date: Thu, 13 Jun 2019 19:27:40 +0800
MIME-Version: 1.0
In-Reply-To: <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, akpm@linux-foundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org



On 2019/6/6 0:32, James Morse wrote:
> Hi!
> 
> On 07/05/2019 04:50, Chen Zhou wrote:
>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>> are requierd, capture kernel will boot failure because of no low memory.
> 
>> When crashkernel is reserved above 4G in memory, kernel should reserve
>> some amount of low memory for swiotlb and some DMA buffers. So there may
>> be two crash kernel regions, one is below 4G, the other is above 4G.
> 
> This is a good argument for supporting the 'crashkernel=...,low' version.
> What is the 'crashkernel=...,high' version for?
> 
> Wouldn't it be simpler to relax the ARCH_LOW_ADDRESS_LIMIT if we see 'crashkernel=...,low'
> in the kernel cmdline?
> 
> I don't see what the 'crashkernel=...,high' variant is giving us, it just complicates the
> flow of reserve_crashkernel().
> 
> If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel() we could
> use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
> memblock_end_of_DRAM().
> I think this is a simpler change that gives you what you want.

According to your suggestions, we should do like this:
1. call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
2. mark the low region as 'nomap'
3. use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
memblock_end_of_DRAM()
4. rename crashk_low_res as "Crash kernel (low)" for arm64
5. add an 'linux,low-memory-range' node in DT

Do i understand correctly?

> 
> 
>> Then
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
> 
> Won't this break if your kdump kernel doesn't know what the extra parameters are?
> Or if it expects two ranges, but only gets one? These DT properties should be treated as
> ABI between kernel versions, we can't really change it like this.
> 
> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
> think the simplest thing to do is to add an 'linux,low-memory-range' that we
> memblock_add() after memblock_cap_memory_range() has been called.
> If its missing, or the new kernel doesn't know what its for, everything keeps working.
> 
> 
>> Besides, we need to modify kexec-tools:
>>   arm64: support more than one crash kernel regions(see [1])
> 
>> I post this patch series about one month ago. The previous changes and
>> discussions can be retrived from:
> 
> Ah, this wasn't obvious as you've stopped numbering the series. Please label the next one
> 'v6' so that we can describe this as 'v5'. (duplicate numbering would be even more confusing!)
> 
ok.

> 
> Thanks,
> 
> James
> 
> .
> 

Thanks,
Chen Zhou


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
