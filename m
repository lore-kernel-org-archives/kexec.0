From: Baoquan He <bhe@redhat.com>
Date: Fri, 6 May 2022 21:16:08 +0800
Subject: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
Message-ID: <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/06/22 at 11:22am, Leizhen (ThunderTown) wrote:
......  
> >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> >>  	if (crash_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >> -	/* Current arm64 boot protocol requires 2MB alignment */
> >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > 
> > I personally like this but let's see how the other thread goes. I guess
> 
> Me too. This fallback complicates code logic more than just a little.
> I'm not sure why someone would rather add fallback than change the bootup
> options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> compatible and extended mode when crashkernel=X fails to reserve memory. And
> the code logic will be much clearer.

The fallback does complicates code, while it was not made at the
beginning, but added later. The original crahskernel=xM can only reserve
low memory under 896M on x86 to be back compatible with the case in which
normal kernel is x86_64, while kdump kernel could be i386. Then customer
complained why crashkernel=xM can't be put anywhere so that they don't
need to know the details of limited low memory and huge high memory fact 
in system.

The implementation of fallback is truly complicated, but its use is
quite simple. And it makes crashkernel reservation setting simple.
Most of users don't need to know crashkernel=,high, ,low things, unless
the crashkernel region is too big. Nobody wants to take away 1G or more
from low memory for kdump just in case bad thing happens, while normal
kernel itself is seriously impacted by limited low memory.

> 
> //parse crashkernel=X		//To simplify the discussion, Ignore [@offset]
> crash_base = memblock_phys_alloc_range()
> if (!crash_base || /* crashkernel=X is not specified */) {
> 	//parse crashkernel=X,[high,low]
> 	//reserve high/low memory
> }
> 
> So that, the following three modes are supported:
> 1) crashkernel=X[@offset]
> 2) crashkernel=X,high crashkernel=X,low
> 3) crashkernel=X[@offset] crashkernel=X,high [crashkernel=Y,low]
> 
> For case 3), try "crashkernel=X[@offset]" first, if it can not work, fallback
> to "crashkernel=X,high crashkernel=X,low". This looks better than the old "crashkernel=X"
> fallback ---- Select a region under 4G first, and fall back to reserve region above 4G.

Don't get it. Aren't they the same?

> 
> Note: when the X of crashkernel=X and crashkernel=X,high are the same, It's equivalent
> to the old "crashkernel=X" fallback.
> 
> > if we want a fallback, it would come just before the check the above:
> > 
> > 	if (!crash_base && crash_max != CRASH_ADDR_HIGH_MAX) {
> > 		/* attempt high allocation with default low */
> > 		if (!crash_low_size)
> > 			crash_low_size = some default;
> > 		crash_max = CRASH_ADDR_LOW_MAX;
> 
> crash_max = CRASH_ADDR_HIGH_MAX; We should fallback to high memory now.
> 
> > 		crash_base = memblock_phys_alloc_range();
> > 	}
> > 
> > Well, I guess we end up with your earlier proposal but I think I
> > understand it better now ;).
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


