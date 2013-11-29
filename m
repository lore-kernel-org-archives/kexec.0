Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmKfc-00036a-9a
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 09:47:32 +0000
Date: Fri, 29 Nov 2013 17:46:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131129094652.GK4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131126220448.GB18170@console-pimps.org>
 <20131127045237.GC11852@dhcp-16-126.nay.redhat.com>
 <20131127101747.GC18170@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127101747.GC18170@console-pimps.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/27/13 at 10:17am, Matt Fleming wrote:
> On Wed, 27 Nov, at 12:52:37PM, Dave Young wrote:
> > To make it more readable, I will change them like below:
> > 
> > p = efi_runtime_map;
> > md = efi_setup->map;
> > for (i = 0; i < nr_efi_runtime_map; i++) {
> > 	[...]
> > 	md += 1;
> > }
>  
> Actually, md++ is the canonical way to write this.

Ok.

> 
> > > 
> > > > +		efi_map_region_fixed(md);
> > > > +		size = md->num_pages << PAGE_SHIFT;
> > > > +		end = md->phys_addr + size;
> > > > +
> > > > +		systab = (u64) (unsigned long) efi_phys.systab;
> > > > +		if (md->phys_addr <= systab && systab < end) {
> > > > +			systab += md->virt_addr - md->phys_addr;
> > > > +			efi.systab =
> > > > +				(efi_system_table_t *) (unsigned long) systab;
> > > > +		}
> > > > +		if (efi_runtime_map) {
> > > > +			memcpy(p, md, memmap.desc_size);
> > > > +			p += memmap.desc_size;
> > > > +		}
> > > 
> > > Is this if () needed? Is it possible to enter the loop and have
> > > 'efi_runtime_map' be NULL?
> > 
> > Yes, it is needed. if efi_runtime_map kmalloc fails I only print error, do not
> > return so kernel can still boot, just kexec on efi will not work that has been
> > put in the error message.
>  
> OK. On second thought, is there any way to turn the above code into a
> call to efi_save_runtime_map()? Because you've basically duplicated that
> code and I can definitely envisage the two code paths fragmenting over
> time, e.g. when someone makes changes to one but not the other.

OK, will consider to reuse the function.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
