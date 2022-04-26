From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 26 Apr 2022 19:02:46 +0100
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <20220414115720.1887-6-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
Message-ID: <YmgzxsrrMlCDYsWp@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Apr 14, 2022 at 07:57:16PM +0800, Zhen Lei wrote:
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
>   * This function reserves memory area given in "crashkernel=" kernel command
>   * line parameter. The memory reserved is used by dump capture kernel when
>   * primary kernel is crashing.
> + *
> + * NOTE: Reservation of crashkernel,low is special since its existence
> + * is not independent, need rely on the existence of crashkernel,high.
> + * Here, four cases of crashkernel low memory reservation are summarized:
> + * 1) crashkernel=Y,low is specified explicitly, the size of crashkernel low
> + *    memory takes Y;
> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
> + *    take the default crashkernel low memory size;
> + * 3) crashkernel=X is specified, while fallback to get a memory region
> + *    in high memory, take the default crashkernel low memory size;
> + * 4) crashkernel='invalid value',low is specified, failed the whole
> + *    crashkernel reservation and bail out.

Following the x86 behaviour made sense when we were tried to get that
code generic. Now that we moved the logic under arch/arm64, we can
diverge a bit. I lost track of the original (v1/v2) proposal but I
wonder whether we still need the fallback to high for crashkernel=Y.
Maybe simpler, no fallbacks:

	crashkernel=Y - keep the current behaviour, ignore high,low
	crashkernel=Y,high - allocate above ZONE_DMA
	crashkernel=Y,low - allocate within ZONE_DMA

From your proposal, the difference is that the Y,high option won't
have any default ZONE_DMA fallback, one would have to explicitly pass
the Y,low option if needed.

Just a thought, maybe it makes the code simpler. But I'm open to
discussion if there are good arguments for the proposed (x86-like)
behaviour. One argument could be for crashkernel=Y to fall back to high
if distros don't want to bother with high/low settings.

Another thing I may have asked in the past, what happens if we run a new
kernel with these patches with old kexec user tools. I suspect the
crashkernel=Y with the fallback to high will confuse the tools.

BTW, please separate the NO_BLOCK_MAPPINGS optimisations from the
crashkernel above 4G. Let's get the crashkernel reservations sorted
first, it's been around for too long.

Thanks.

-- 
Catalin

