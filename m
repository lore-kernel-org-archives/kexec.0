Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <a9d017d0-82d3-3e5f-4af2-4c611393106d@redhat.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <bf4050c5-cfb7-fd69-4892-1e0b65861d34@huawei.com>
Date: Thu, 16 May 2019 11:19:05 +0800
MIME-Version: 1.0
In-Reply-To: <a9d017d0-82d3-3e5f-4af2-4c611393106d@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org, rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com
Cc: wangkefeng.wang@huawei.com, takahiro.akashi@linaro.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, horms@verge.net.au, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi Bhupesh,

On 2019/5/15 13:06, Bhupesh Sharma wrote:
> +Cc kexec-list.
> 
> Hi Chen,
> 
> I think we are still in the quiet period of the merge cycle, but this is a change which will be useful for systems like HPE Apollo where we are looking at reserving crashkernel across a larger range.
> 
> Some comments inline and in respective patch threads..
> 
> On 05/07/2019 09:20 AM, Chen Zhou wrote:
>> This patch series enable reserving crashkernel on high memory in arm64.
> 
> Please fix the patch subject, it should be v5.
> Also please Cc the kexec-list (kexec@lists.infradead.org) for future versions to allow wider review of the patchset.
> 
>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>> are requierd, capture kernel will boot failure because of no low memory.
> 
> ... ^^ required
> 
> s/capture kernel will boot failure because of no low memory./capture kernel boot will fail because there is no low memory available for allocation.
> 
>> When crashkernel is reserved above 4G in memory, kernel should reserve
>> some amount of low memory for swiotlb and some DMA buffers. So there may
>> be two crash kernel regions, one is below 4G, the other is above 4G. Then
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
> 
> Please use consistent naming for the second kernel, better to use crash dump kernel.
> 
> I have tested this on my HPE Apollo machine and with crashkernel=886M,high syntax, I can get the board to reserve a larger memory range for the crashkernel (i.e. 886M):
> 
> # dmesg | grep -i crash
> [    0.000000] kexec_core: Reserving 256MB of low memory at 3560MB for crashkernel (System low RAM: 2029MB)
> [    0.000000] crashkernel reserved: 0x0000000bc5a00000 - 0x0000000bfd000000 (886 MB)
> 
> kexec/kdump can also work also work fine on the board.
> 
> So, with the changes suggested in this cover letter and individual patches, please feel free to add:
> 
> Reviewed-and-Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
> 
> Thanks,
> Bhupesh
> 

Thanks for you review and test. I will fix these later.

Thanks,
Chen Zhou

>> Besides, we need to modify kexec-tools:
>>    arm64: support more than one crash kernel regions(see [1])
>>
>> I post this patch series about one month ago. The previous changes and
>> discussions can be retrived from:
>>
>> Changes since [v4]
>> - reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>
>> Changes since [v3]
>> - Add memblock_cap_memory_ranges back for multiple ranges.
>> - Fix some compiling warnings.
>>
>> Changes since [v2]
>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>>    two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>>    patch.
>>
>> Changes since [v1]:
>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>>    in fdt_enforce_memory_region().
>>    There are at most two crash kernel regions, for two crash kernel regions
>>    case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>>    and then remove the memory range in the middle.
>>
>> [1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
>> [v1]: https://lkml.org/lkml/2019/4/2/1174
>> [v2]: https://lkml.org/lkml/2019/4/9/86
>> [v3]: https://lkml.org/lkml/2019/4/9/306
>> [v4]: https://lkml.org/lkml/2019/4/15/273
>>
>> Chen Zhou (3):
>>    x86: kdump: move reserve_crashkernel_low() into kexec_core.c
>>    arm64: kdump: support reserving crashkernel above 4G
>>    kdump: update Documentation about crashkernel on arm64
>>
>> Mike Rapoport (1):
>>    memblock: extend memblock_cap_memory_range to multiple ranges
>>
>>   Documentation/admin-guide/kernel-parameters.txt |  6 +--
>>   arch/arm64/include/asm/kexec.h                  |  3 ++
>>   arch/arm64/kernel/setup.c                       |  3 ++
>>   arch/arm64/mm/init.c                            | 72 +++++++++++++++++++------
>>   arch/x86/include/asm/kexec.h                    |  3 ++
>>   arch/x86/kernel/setup.c                         | 66 +++--------------------
>>   include/linux/kexec.h                           |  5 ++
>>   include/linux/memblock.h                        |  2 +-
>>   kernel/kexec_core.c                             | 56 +++++++++++++++++++
>>   mm/memblock.c                                   | 44 +++++++--------
>>   10 files changed, 157 insertions(+), 103 deletions(-)
>>
> 
> 
> .
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
