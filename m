From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 6 May 2022 18:45:10 +0100
Subject: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
 <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
Message-ID: <YnVept85UJCaZp6p@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, May 06, 2022 at 09:16:08PM +0800, Baoquan He wrote:
> On 05/06/22 at 11:22am, Leizhen (ThunderTown) wrote:
> ......  
> > >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> > >>  	if (crash_base)
> > >>  		crash_max = crash_base + crash_size;
> > >>  
> > >> -	/* Current arm64 boot protocol requires 2MB alignment */
> > >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > >>  					       crash_base, crash_max);
> > >>  	if (!crash_base) {
> > >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > > 
> > > I personally like this but let's see how the other thread goes. I guess
> > 
> > Me too. This fallback complicates code logic more than just a little.
> > I'm not sure why someone would rather add fallback than change the bootup
> > options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> > compatible and extended mode when crashkernel=X fails to reserve memory. And
> > the code logic will be much clearer.
> 
> The fallback does complicates code, while it was not made at the
> beginning, but added later. The original crahskernel=xM can only reserve
> low memory under 896M on x86 to be back compatible with the case in which
> normal kernel is x86_64, while kdump kernel could be i386. Then customer
> complained why crashkernel=xM can't be put anywhere so that they don't
> need to know the details of limited low memory and huge high memory fact 
> in system.
> 
> The implementation of fallback is truly complicated, but its use is
> quite simple. And it makes crashkernel reservation setting simple.
> Most of users don't need to know crashkernel=,high, ,low things, unless
> the crashkernel region is too big. Nobody wants to take away 1G or more
> from low memory for kdump just in case bad thing happens, while normal
> kernel itself is seriously impacted by limited low memory.

IIUC, that's exactly what happens even on x86, it may take away a
significant chunk of the low memory. Let's say we have 1.2GB of 'low'
memory (below 4GB) on an arm64 platform. A crashkernel=1G would succeed
in a low allocation, pretty much affecting the whole system. It would
only fall back to 'high' _if_ you pass something like crashkernel=1.2G
so that the low allocation fails. So if I got this right, I find the
fall-back from crashkernel=X pretty useless, we shouldn't even try it.

It makes more sense if crashkernel=X,high is a hint to attempt a high
allocation first with a default low (overridden by a ,low option) or
even fall-back to low if there's no memory above 4GB.

Could you please have a look at Zhen Lei's latest series without any
fall-backs? I'd like to queue that if you are happy with it. We can then
look at adding some fall-back options on top.

IMO, we should only aim for:

	crashkernel=X		ZONE_DMA allocation, no fall-back
	crashkernel=X,high	hint for high allocation, small default
				low, fall back to low if alloc fails
	crashkernel=X,low	control the default low allocation, only
				high is passed

With the above, I'd expect admins to just go for crashkernel=X,high on
modern hardware with up to date kexec tools and it does the right thing.
The crashkernel=X can lead to unexpected results if it eats up all the
low memory. Let's say this option is for backwards compatibility only.

Thanks.

-- 
Catalin

