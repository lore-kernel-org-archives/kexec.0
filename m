Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 6 Apr 2016 14:57:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] ARM: kexec: fix crashkernel= handling
Message-ID: <20160406065720.GA9157@dhcp-128-65.nay.redhat.com>
References: <E1akqb5-0002LZ-1f@rmk-PC.arm.linux.org.uk>
 <20160330014638.GA6993@dhcp-128-65.nay.redhat.com>
 <20160330123922.GA11351@dhcppc0.redhat.com>
 <20160330130530.GH19428@n2100.arm.linux.org.uk>
 <20160330132708.GC32738@redhat.com>
 <20160401132535.GP19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160401132535.GP19428@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, linux-arm-kernel@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 04/01/16 at 02:25pm, Russell King - ARM Linux wrote:

[snip]

> Well, if we want to remove it, we then need to sort out a method of
> specifying a limit on the address - where platforms physical memory
> bridges the 4GB CPU-accessible limit, the crashkernel region must be
> allocated below that so that it is boot-time accessible.
> 
> Some patches also have boot-time only aliases of RAM, with the normal
> alias above 4GB (eg, TI Keystone2) where the running view of RAM is
> at 0x800000000, but it has a non-coherent boot alias at 0x80000000.
> 
> I've patches which resolve some of the issues there, and making that
> change would make this patch dependent on those changes.  So, I
> recommend that this patch remains as-is for the time being, and this
> issue is addressed in a later patch after the Keystone2 idmap_to_phys()
> patches, similar to:
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 0a12fcf1aff6..74781e6d4e87 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -962,7 +962,6 @@ late_initcall(init_machine_late);
>   * zImage relocating below the reserved region.
>   */
>  #define CRASH_ALIGN	(128 << 20)
> -#define CRASH_ADDR_MAX	(PHYS_OFFSET + (512 << 20))
>  
>  static inline unsigned long long get_total_mem(void)
>  {
> @@ -992,7 +991,8 @@ static void __init reserve_crashkernel(void)
>  		return;
>  
>  	if (crash_base <= 0) {
> -		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_MAX,
> +		unsigned long long crash_max = idmap_to_phys((u32)~0);
> +		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
>  						    crash_size, CRASH_ALIGN);
>  		if (!crash_base) {
>  			pr_err("crashkernel reservation failed - No suitable area found.\n");
> 
> Right now, I don't want to tie this facility to TI Keystone2 support
> as what this patch is doing is something that the ARM kexec support
> should have been doing since it was first introduced, so folk may
> want to backport this change to stable trees.

Is it possible for PHYS_OFFSET + (512 << 20) be larger than 4G assume that phys_addr_t is 32bit, if so it can be trunked to a small value then
the max will be wrong?

Otherwise I think use it temprarily is fine.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
