Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqvkf-0007ZH-PW
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 02:11:46 +0000
Date: Thu, 12 Dec 2013 10:10:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131212021057.GC3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-10-git-send-email-dyoung@redhat.com>
 <20131211121352.GB29980@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211121352.GB29980@console-pimps.org>
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

On 12/11/13 at 12:13pm, Matt Fleming wrote:
> On Mon, 09 Dec, at 05:42:22PM, Dave Young wrote:
> > Add a new setup_data type SETUP_EFI for kexec use.
> > Passing the saved fw_vendor, runtime, config tables and efi runtime mappings.
> > 
> > When entering virtual mode, directly mapping the efi runtime ragions which
> > we passed in previously. And skip the step to call SetVirtualAddressMap.
> > 
> > Specially for HP z420 workstation we need save the smbios physical address.
> > The kernel boot sequence proceeds in the following order.  Step 2
> > requires efi.smbios to be the physical address.  However, I found that on
> > HP z420 EFI system table has a virtual address of SMBIOS in step 1.  Hence,
> > we need set it back to the physical address with the smbios in
> > efi_setup_data.  (When it is still the physical address, it simply sets
> > the same value.)
> > 
> > 1. efi_init() - Set efi.smbios from EFI system table
> > 2. dmi_scan_machine() - Temporary map efi.smbios to access SMBIOS table
> > 3. efi_enter_virtual_mode() - Map EFI ranges
> > 
> > Tested on ovmf+qemu, lenovo thinkpad, a dell laptop and an
> > HP z420 workstation.
> > 
> > v2: refresh based on previous patch changes, code cleanup.
> > v3: use ioremap instead of phys_to_virt for efi_setup
> > v5: improve some code structure per comments from Matt
> >     Boris: improve code structure, spell fix, etc.
> >     Improve changelog from Toshi.
> >     change the variable efi_setup to the physical address of efi setup_data
> >     instead of the ioremapped virt address
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/include/asm/efi.h            |  11 ++
> >  arch/x86/include/uapi/asm/bootparam.h |   1 +
> >  arch/x86/kernel/setup.c               |   3 +
> >  arch/x86/platform/efi/efi.c           | 195 ++++++++++++++++++++++++++++++----
> >  4 files changed, 187 insertions(+), 23 deletions(-)
> 
> [...]
> 
> > @@ -115,6 +116,25 @@ static int __init setup_storage_paranoia(char *arg)
> >  }
> >  early_param("efi_no_storage_paranoia", setup_storage_paranoia);
> >  
> > +void __init parse_efi_setup(u64 phys_addr)
> > +{
> > +	struct setup_data *sd;
> > +
> > +	if (!efi_enabled(EFI_64BIT)) {
> > +		pr_warn("SETUP_EFI not supported on 32-bit\n");
> > +		return;
> > +	}
> > +
> > +	sd = early_memremap(phys_addr, sizeof(struct setup_data));
> > +	if (!sd) {
> > +		pr_warn("efi: early_memremap setup_data failed\n");
> 
> You shouldn't need the "efi:" prefix in the message.

Hmm, remove efi: looks better, will update.

> 
> > @@ -676,6 +766,8 @@ void __init efi_init(void)
> >  		efi.systab->hdr.revision >> 16,
> >  		efi.systab->hdr.revision & 0xffff, vendor);
> >  
> > +	efi_reuse_config(efi.systab->tables, efi.systab->nr_tables);
> > +
> 
> Please check the return value.

I missed this one, will update.

> 
> >  	if (efi_config_init(arch_tables))
> >  		return;
> >  
> > @@ -886,6 +978,50 @@ out_krealloc:
> >  }
> >  
> >  /*
> > + * Map efi regions which was passed via setup_data. The virt_addr is a fixed
> > + * addr which was used in first kernel in case kexec boot.
> > + */
> > +static int __init map_regions_fixed(void)
> > +{
> > +	int i, s, ret = 0;
> > +	u64 end, systab;
> > +	unsigned long size;
> > +	efi_memory_desc_t *md;
> > +	struct efi_setup_data *data;
> > +
> > +	s = sizeof(*data) + nr_efi_runtime_map * sizeof(data->map[0]);
> > +	data = early_memremap(efi_setup, s);
> > +	if (!data) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	for (i = 0, md = data->map; i < nr_efi_runtime_map; i++, md++) {
> > +		efi_map_region_fixed(md); /* FIXME: add error handling */
> 
> Oops. Please fix this ;-)

Have discussed this with Boris, he will take care of this after he added
error handling in his __map_region function.

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
