Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VuuyV-000721-Uj
 for kexec@lists.infradead.org; Mon, 23 Dec 2013 02:10:33 +0000
Date: Mon, 23 Dec 2013 10:09:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 09/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131223020958.GB3760@dhcp-16-126.nay.redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <1387533742-18018-10-git-send-email-dyoung@redhat.com>
 <20131221160416.GD29501@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131221160416.GD29501@console-pimps.org>
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
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On 12/21/13 at 04:06pm, Matt Fleming wrote:
> On Fri, 20 Dec, at 06:02:19PM, Dave Young wrote:
> > @@ -133,6 +133,19 @@ extern void efi_sync_low_kernel_mappings(void);
> >  extern void efi_setup_page_tables(void);
> >  extern void __init old_map_region(efi_memory_desc_t *md);
> >  
> > +struct efi_setup_data {
> > +	u64 fw_vendor;
> > +	u64 runtime;
> > +	u64 tables;
> > +	u64 smbios;
> > +	u64 reserved[8];
> > +	efi_memory_desc_t map[0];
> > +};
> 
> [...]
> 
> > +static void get_nr_runtime_map(void)
> > +{
> > +	if (!efi_setup)
> > +		return;
> > +
> > +	nr_efi_runtime_map = (efi_data_len - sizeof(struct efi_setup_data)) /
> > +			     sizeof(efi_memory_desc_t);
> > +}
> 
> Do we actually need the 'map' entry in efi_setup_data now that you're
> passing it via efi_info (which is much better approach!)? Also, we don't
> need the global nr_efi_runtime_map or efi_runtime_map variables now,
> right?

The map is still necessary because we need store the map somewhere and pass
the physicall address to kexec kernel. Passing them in setup_data is the
only better way currently...

In efi_info there's only an entry for the map physical address, the original
map area is not valid any more.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
