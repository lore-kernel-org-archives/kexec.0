Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh1ts-00Ayye-Oa
 for kexec@lists.infradead.org; Thu, 13 May 2021 03:20:38 +0000
Date: Thu, 13 May 2021 11:20:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] firmware/efi: Tell memblock about EFI reservations
Message-ID: <20210513031958.GD45898@dhcp-128-65.nay.redhat.com>
References: <20210429133533.1750721-1-maz@kernel.org>
 <20210429133533.1750721-2-maz@kernel.org>
 <YJBHZFMhBL4z0445@epycbox.lan>
MIME-Version: 1.0
In-Reply-To: <YJBHZFMhBL4z0445@epycbox.lan>
Content-Disposition: inline
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
To: Moritz Fischer <mdf@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

On 05/03/21 at 11:56am, Moritz Fischer wrote:
> Marc,
> 
> On Thu, Apr 29, 2021 at 02:35:32PM +0100, Marc Zyngier wrote:
> > kexec_load_file() relies on the memblock infrastructure to avoid
> > stamping over regions of memory that are essential to the survival
> > of the system.
> > 
> > However, nobody seems to agree how to flag these regions as reserved,
> > and (for example) EFI only publishes its reservations in /proc/iomem
> > for the benefit of the traditional, userspace based kexec tool.
> > 
> > On arm64 platforms with GICv3, this can result in the payload being
> > placed at the location of the LPI tables. Shock, horror!
> > 
> > Let's augment the EFI reservation code with a memblock_reserve() call,
> > protecting our dear tables from the secondary kernel invasion.
> > 
> > At some point, someone will have to go and figure out a way to unify
> > these multiple reservation trees, because sprinkling random reservation
> > calls is only a temporary workaround.
> > 
> 
> Feel free to add (and/or):
> 
> Reported-by: Moritz Fischer <mdf@kernel.org>
> Tested-by: Moritz Fischer <mdf@kernel.org>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/firmware/efi/efi.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 4b7ee3fa9224..026b02f5f7d8 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -896,11 +896,25 @@ static int __init efi_memreserve_map_root(void)
> >  static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
> >  {
> >  	struct resource *res, *parent;
> > +	int ret;
> >  
> >  	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
> >  	if (!res)
> >  		return -ENOMEM;
> >  
> > +	/*
> > +	 * Given that efi_mem_reserve_iomem() can be called at any
> > +	 * time, only call memblock_reserve() if the architecture
> > +	 * keeps the infrastructure around.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > +		ret = memblock_reserve(addr, size);
> > +		if (ret) {
> > +			kfree(res);
> > +			return ret;
> > +		}
> > +	}
> > +

If you go with memblock, it would be better to handle it separately from
the iomem?

> >  	res->name	= "reserved";
> >  	res->flags	= IORESOURCE_MEM;
> >  	res->start	= addr;
> > @@ -908,7 +922,14 @@ static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
> >  
> >  	/* we expect a conflict with a 'System RAM' region */
> >  	parent = request_resource_conflict(&iomem_resource, res);
> > -	return parent ? request_resource(parent, res) : 0;
> > +	ret = parent ? request_resource(parent, res) : 0;
> > +	if (ret) {
> > +		kfree(res);
> > +		if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> > +			memblock_free(addr, size);
> > +	}
> > +
> > +	return ret;

It looks odd to free memblock when reqeust resource fails, they are not
relavant?

> >  }
> >  
> >  int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
> > -- 
> > 2.29.2
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> Thanks,
> Moritz
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
