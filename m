From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 27 Apr 2022 13:32:32 +0100
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
Message-ID: <Ymk34NsIFqUgfk3b@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Apr 27, 2022 at 02:54:52PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/27 2:02, Catalin Marinas wrote:
> > On Thu, Apr 14, 2022 at 07:57:16PM +0800, Zhen Lei wrote:
> >>  /*
> >>   * reserve_crashkernel() - reserves memory for crash kernel
> >>   *
> >>   * This function reserves memory area given in "crashkernel=" kernel command
> >>   * line parameter. The memory reserved is used by dump capture kernel when
> >>   * primary kernel is crashing.
> >> + *
> >> + * NOTE: Reservation of crashkernel,low is special since its existence
> >> + * is not independent, need rely on the existence of crashkernel,high.
> >> + * Here, four cases of crashkernel low memory reservation are summarized:
> >> + * 1) crashkernel=Y,low is specified explicitly, the size of crashkernel low
> >> + *    memory takes Y;
> >> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
> >> + *    take the default crashkernel low memory size;
> >> + * 3) crashkernel=X is specified, while fallback to get a memory region
> >> + *    in high memory, take the default crashkernel low memory size;
> >> + * 4) crashkernel='invalid value',low is specified, failed the whole
> >> + *    crashkernel reservation and bail out.
> > 
> > Following the x86 behaviour made sense when we were tried to get that
> > code generic. Now that we moved the logic under arch/arm64, we can
> > diverge a bit. I lost track of the original (v1/v2) proposal but I
> > wonder whether we still need the fallback to high for crashkernel=Y.
> 
> I don't think anyone has raised this demand yet! If it weren't for the
> fact that crashkernel=X appeared earlier, it would probably have been
> enough for a combination of crashkernel=X,high and crashkernel=Y,low.
> 
> In fact, I also tend not to support "fallback to high for crashkernel=Y".
> I took over this from Chen Zhou. In the absence of any objection, I had
> to inherit. Now that you've brought it up, I'm happy to delete it.
> Supporting this feature complicates the code logic a lot. The point is,
> it's not fully backwards compatible yet. For example, someone may want
> crashkernel=3G to report failure, but the the new support make it work.

BTW, prior to v20, this patch had this line:

	crashk_low_res.name = "Crash kernel (low)";

I can't find it anymore. Do the kexec tools need to distinguish between
low and high or they can cope with multiple "Crash kernel" entries?

> > Maybe simpler, no fallbacks:
> > 
> > 	crashkernel=Y - keep the current behaviour, ignore high,low
> > 	crashkernel=Y,high - allocate above ZONE_DMA
> > 	crashkernel=Y,low - allocate within ZONE_DMA
> > 
> > From your proposal, the difference is that the Y,high option won't
> > have any default ZONE_DMA fallback, one would have to explicitly pass
> > the Y,low option if needed.
> 
> I agree with you. Now we don't need code generic, so there is no need to
> carry the historical burden of other ARCHs. arm64 does not need to delve
> into that empirical value(the default size of crash low memory).
> 
> > Just a thought, maybe it makes the code simpler. But I'm open to
> > discussion if there are good arguments for the proposed (x86-like)
> > behaviour. One argument could be for crashkernel=Y to fall back to high
> > if distros don't want to bother with high/low settings.
> 
> I think distros should take precedence over "crashkernel=Y,high". After all,
> ZONE_DMA memory is more valuable than high memory.

My point is whether an admin configuring the kernel command line needs
to know the layout of ZONE_DMA etc. to figure out how much to pass in
high and low. The fallbacks in this case have some value but they also
complicate the code logic. The 4GB limit does not always make sense
either for some platforms (RPi4 has a ZONE_DMA limit of 1GB).

I think one could always pass a default command line like:

	crashkernel=1G,high crashkernel=128M,low

without much knowledge of the SoC memory layout.

Another option is to only introduce crashkernel=Y,low and, when that is
passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
'high' option at all:

	crashkernel=1G				- all within ZONE_DMA
	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
						  1G above ZONE_DMA

If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
the 'low' option.

-- 
Catalin

