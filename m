Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqzig-0002kn-JI
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 06:25:59 +0000
Date: Thu, 12 Dec 2013 14:25:06 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131212062506.GH3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-10-git-send-email-dyoung@redhat.com>
 <20131211222057.GB8863@pd.tnic>
 <20131212030619.GG3751@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131212030619.GG3751@dhcp-16-126.nay.redhat.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

> > > + */
> > > +static int __init map_regions_fixed(void)
> > > +{
> > > +	int i, s, ret = 0;
> > > +	u64 end, systab;
> > > +	unsigned long size;
> > > +	efi_memory_desc_t *md;
> > > +	struct efi_setup_data *data;
> > > +
> > > +	s = sizeof(*data) + nr_efi_runtime_map * sizeof(data->map[0]);
> > > +	data = early_memremap(efi_setup, s);
> > > +	if (!data) {
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > 
> > newline.
> 
> Will remove

misread the comment, there's no new line here. Looks like you want a
new blank line here, ok..

> 
> > 
> > > +	for (i = 0, md = data->map; i < nr_efi_runtime_map; i++, md++) {
> > > +		efi_map_region_fixed(md); /* FIXME: add error handling */
> > > +		size = md->num_pages << PAGE_SHIFT;
> > > +		end = md->phys_addr + size;
> > > +
> > > +		systab = (u64) (unsigned long) efi_phys.systab;
> > > +		if (md->phys_addr <= systab && systab < end) {
> > > +			systab += md->virt_addr - md->phys_addr;
> > > +			efi.systab = (efi_system_table_t *)(unsigned long)systab;
> > > +		}
> > > +		ret = save_runtime_map(md, i);
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
