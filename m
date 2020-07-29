Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Jul 2020 16:20:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20200729152028.GE5524@gaia>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com>
 <20200727173014.GL13938@gaia>
 <dd40f6ee-d5bd-1798-e7d6-1fb8ae91dc8b@huawei.com>
 <20200729115851.GC5524@gaia>
 <217004f5-dd8e-d04c-038b-c88b132d5495@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <217004f5-dd8e-d04c-038b-c88b132d5495@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: horms@verge.net.au, John.P.donnelly@oracle.com, xiexiuqi@huawei.com, arnd@arndb.de, bhe@redhat.com, corbet@lwn.net, dyoung@redhat.com, bhsharma@redhat.com, guohanjun@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, nsaenzjulienne@suse.de

On Wed, Jul 29, 2020 at 10:14:32PM +0800, chenzhou wrote:
> On 2020/7/29 19:58, Catalin Marinas wrote:
> > On Wed, Jul 29, 2020 at 11:52:39AM +0800, chenzhou wrote:
> >> How about like this:
> >> 1. For ZONE_DMA issue, use Bhupesh's solution, keep the crashkernel=
> >>    behaviour to ZONE_DMA allocations.
> >> 2. For this patch series, make the reserve_crashkernel_low() to
> >>    ZONE_DMA allocations.
> > 
> > So you mean rebasing your series on top of Bhupesh's? I guess you can
> > combine the two, I really don't care which way as long as we fix both
> > issues and agree on the crashkernel= semantics. I think with some tweaks
> > we can go with your series alone.
> >
> > IIUC from the x86 code (especially the part you #ifdef'ed out for
> > arm64), if ",low" is not passed (so just standard crashkernel=X), it
> > still allocates sufficient low memory for the swiotlb in ZONE_DMA. The
> > rest can go in a high region. Why can't we do something similar on
> > arm64? Of course, you can keep the ",low" argument for explicit
> > allocation but I don't want to mandate it.
> 
> It is a good idea to combine the two.
> 
> For parameter crashkernel=X, we do like this:
> 1. allocate some low memory in ZONE_DMA(or ZONE_DMA32 if CONFIG_ZONE_DMA=n)
> 2. allocate X size memory in a high region
> 
> ",low" argument can be used to specify the low memory.
> 
> Do i understand correctly?

Yes, although we could follow the x86 approach:

1. Try low (ZONE_DMA for arm64) allocation, fallback to high allocation
   if it fails.

2. If crash_base is outside ZONE_DMA, call reserve_crashkernel_low()
   which either honours the ,low option or allocates some small amount
   in ZONE_DMA.

If at some point we have platforms failing step 2, we'll look at
changing ZONE_DMA to the full 4GB on non-RPi4 platforms.

It looks to me like x86 ignores the ,low option if the first step
managed to get some low memory. Shall we do the same on arm64?

> > So with an implicit ZONE_DMA allocation similar to the x86 one, we
> > probably don't need Bhupesh's series at all. In addition, we can limit
> > crashkernel= to the first 4G with a fall-back to high like x86 (not sure
> > if memblock_find_in_range() is guaranteed to search in ascending order).
> > I don't think we need an explicit ",high" annotation.
> >
> > So with the above, just a crashkernel=1G gives you at least 256MB in
> > ZONE_DMA followed by the rest anywhere, with a preference for
> > ZONE_DMA32. This way we can also keep the reserve_crashkernel_low()
> > mostly intact from x86 (less #ifdef's).
> 
> Yes. We can let crashkernel=X  try to reserve low memory and fall back to use high memory
> if failing to find a low range.

The only question is whether we need to preserve some more ZONE_DMA on
the current system. If for example we pass a crashkernel=512M and some
cma=, we may end up with very little free memory in ZONE_DMA. That's
mostly an issue for RPi4 since other platforms would work with
ZONE_DMA32. We could add a threshold and go for high allocation directly
if the required size is too large.

> About the function reserve_crashkernel_low(), if we put it in arch/arm64, there is some common
> code with x86_64. Some suggestions about this?

If we can use this function almost intact, just move it in a common
place. But if it gets sprinkled with #ifdef CONFIG_ARM64, I'd rather
duplicate it. I'd still prefer to move it to a common place if possible.

You can go a step further and also move the x86 reserve_crashkernel() to
common code. I don't think there a significant difference between arm64
and x86 here. You'd have to define arch-specific specific
CRASH_ADDR_LOW_MAX etc.

Also patches moving code should not have any functional change. The
CRASH_ALIGN change from 16M to 2M on x86 should be a separate patch as
it needs to be acked by the x86 maintainers (IIRC, Ingo only acked the
function move if there was no functional change; CRASH_ALIGN is used for
the start address, not just alignment, on x86).

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
