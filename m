Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com> <20200727173014.GL13938@gaia>
 <dd40f6ee-d5bd-1798-e7d6-1fb8ae91dc8b@huawei.com>
 <20200729115851.GC5524@gaia>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <217004f5-dd8e-d04c-038b-c88b132d5495@huawei.com>
Date: Wed, 29 Jul 2020 22:14:32 +0800
MIME-Version: 1.0
In-Reply-To: <20200729115851.GC5524@gaia>
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
Cc: horms@verge.net.au, John.P.donnelly@oracle.com, xiexiuqi@huawei.com, arnd@arndb.de, bhe@redhat.com, corbet@lwn.net, dyoung@redhat.com, bhsharma@redhat.com, guohanjun@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, nsaenzjulienne@suse.de

Hi Catalin,

On 2020/7/29 19:58, Catalin Marinas wrote:
> Hi Chen,
>
> On Wed, Jul 29, 2020 at 11:52:39AM +0800, chenzhou wrote:
>> On 2020/7/28 1:30, Catalin Marinas wrote:
>>> Anyway, there are two series solving slightly different issues with
>>> kdump reservations:
>>>
>>> 1. This series which relaxes the crashkernel= allocation to go anywhere
>>>    in the accessible space while having a dedicated crashkernel=X,low
>>>    option for ZONE_DMA.
>>>
>>> 2. Bhupesh's series [1] forcing crashkernel=X allocations only from
>>>    ZONE_DMA.
>>>
>>> For RPi4 support, we limited ZONE_DMA allocations to the 1st GB.
>>> Existing crashkernel= uses may no longer work, depending on where the
>>> allocation falls. Option (2) above is a quick fix assuming that the
>>> crashkernel reservation is small enough. What's a typical crashkernel
>>> option here? That series is probably more prone to reservation failures.
>>>
>>> Option (1), i.e. this series, doesn't solve the problem raised by
>>> Bhupesh unless one uses the crashkernel=X,low argument. It can actually
>>> make it worse even for ZONE_DMA32 since the allocation can go above 4G
>>> (assuming that we change the ZONE_DMA configuration to only limit it to
>>> 1GB on RPi4).
>>>
>>> I'm more inclined to keep the crashkernel= behaviour to ZONE_DMA
>>> allocations. If this is too small for typical kdump, we can look into
>>> expanding ZONE_DMA to 4G on non-RPi4 hardware (we had patches on the
>>> list). In addition, if Chen thinks allocations above 4G are still needed
>>> or if RPi4 needs a sufficiently large crashkernel=, I'd rather have a
>>> ",high" option to explicitly require such access.
>> Thanks for your reply and exhaustive explanation.
>>
>> In our ARM servers, we need to to reserve a large chunk for kdump(512M
>> or 1G), there is no enough low memory. So we proposed this patch
>> series "support reserving crashkernel above 4G on arm64 kdump" In
>> April 2019.
> Trying to go through the discussions last year, hopefully things get
> clearer.
>
> So prior to the ZONE_DMA change, you still couldn't reserve 1G in the
> first 4GB? It shouldn't be sparsely populated during early boot.
Yes, we prior to the ZONE_DMA change, you still couldn't reserve 1G/512M in the first 4GB.
The memory reported by the bios may be splitted by some "reserved" entries.
Like this:
...
2f126000-2fbfffff : reserved
2fc00000-396affff : System RAM
  30de8000-30de9fff : reserved
  30dec000-30decfff : reserved
  30df2000-30df2fff : reserved
  30e20000-30e4ffff : reserved
  39620000-3968ffff : reserved
396b0000-3974ffff : reserved
39750000-397affff : System RAM
397b0000-398fffff : reserved
39900000-3990ffff : System RAM
  39900000-3990ffff : reserved
...
>
>> I introduce parameters "crashkernel=X,[high,low]" as x86_64 does in earlier versions.
>> Suggested by James, to simplify, we call reserve_crashkernel_low() at the beginning of
>> reserve_crashkernel() and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low()
>> allocated something.
>> That is, just the parameter "crashkernel=X,low" is ok and i deleted "crashkernel=X,high".
> The problem I see is that with your patches we diverge from x86
> behaviour (and the arm64 behaviour prior to the ZONE_DMA reduction) as
> we now require that crashkernel=X,low is always passed if you want
> something in ZONE_DMA (and you do want, otherwise the crashdump kernel
> fails to boot).
>
> My main requirement is that crashkernel=X, without any suffix, still
> works which I don't think is guaranteed with your patches (well,
> ignoring RPi4 ZONE_DMA). Bhupesh's series is a quick fix but doesn't
> solve your large allocation requirements (that may have worked prior to
> the ZONE_DMA change).
The main purpose of this series is to solve the large allocation requirements.
Before the DMA_ZONE, both the original crashkernel=X and large allocation with my  patches
work well.

With the DMA_ZONE, both the original crashkernel=X and large allocation with my  patches
may fail to boot. Both need to think about the DMA_ZONE.

>
>> After the ZONE_DMA introduced in December 2019, the issue occurred as
>> you said above. In fact, we didn't have RPi4 machine.
> You don't even need to have a RPi4 machine, ZONE_DMA has been set to 1GB
> unconditionally. And while we could move it back to 4GB on non-RPi4
> hardware, I'd rather have a solution that fixes kdump for RPi4 as well.
>
>> Originally, i suggested to fix this based on this patch series and
>> used the dedicated option.
>>
>> According to your clarify, for typical kdump, there are other
>> solutions. In this case, "keep the crashkernel= behaviour to ZONE_DMA
>> allocations" looks much better.
>>
>> How about like this:
>> 1. For ZONE_DMA issue, use Bhupesh's solution, keep the crashkernel=
>>    behaviour to ZONE_DMA allocations.
>> 2. For this patch series, make the reserve_crashkernel_low() to
>>    ZONE_DMA allocations.
> So you mean rebasing your series on top of Bhupesh's? I guess you can
> combine the two, I really don't care which way as long as we fix both
> issues and agree on the crashkernel= semantics. I think with some tweaks
> we can go with your series alone.
>
> IIUC from the x86 code (especially the part you #ifdef'ed out for
> arm64), if ",low" is not passed (so just standard crashkernel=X), it
> still allocates sufficient low memory for the swiotlb in ZONE_DMA. The
> rest can go in a high region. Why can't we do something similar on
> arm64? Of course, you can keep the ",low" argument for explicit
> allocation but I don't want to mandate it.
It is a good idea to combine the two.

For parameter crashkernel=X, we do like this:
1. allocate some low memory in ZONE_DMA(or ZONE_DMA32 if CONFIG_ZONE_DMA=n)
2. allocate X size memory in a high region

",low" argument can be used to specify the low memory.

Do i understand correctly?
>
> So with an implicit ZONE_DMA allocation similar to the x86 one, we
> probably don't need Bhupesh's series at all. In addition, we can limit
> crashkernel= to the first 4G with a fall-back to high like x86 (not sure
> if memblock_find_in_range() is guaranteed to search in ascending order).
> I don't think we need an explicit ",high" annotation.
>
> So with the above, just a crashkernel=1G gives you at least 256MB in
> ZONE_DMA followed by the rest anywhere, with a preference for
> ZONE_DMA32. This way we can also keep the reserve_crashkernel_low()
> mostly intact from x86 (less #ifdef's).
>
> Do I miss anything?
Yes. We can let crashkernel=X  try to reserve low memory and fall back to use high memory
if failing to find a low range.

About the function reserve_crashkernel_low(), if we put it in arch/arm64, there is some common
code with x86_64. Some suggestions about this?

Thanks,
Chen Zhou
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
