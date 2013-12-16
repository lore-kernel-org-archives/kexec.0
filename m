Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsWQq-00006T-Os
 for kexec@lists.infradead.org; Mon, 16 Dec 2013 11:33:55 +0000
Date: Mon, 16 Dec 2013 12:33:24 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 10/14] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131216113324.GB4922@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-11-git-send-email-dyoung@redhat.com>
 <20131213160150.GE32329@pd.tnic>
 <20131216020010.GC3754@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131216020010.GC3754@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, Dec 16, 2013 at 10:00:10AM +0800, Dave Young wrote:
> > > -	print_efi_memmap();
> > > +	if (efi_setup) {
> > > +		int s;
> > > +		struct efi_setup_data *data;
> > > +
> > > +		s = sizeof(*data) + nr_efi_runtime_map * sizeof(data->map[0]);
> > > +		data = early_memremap(efi_setup, s);
> > > +		if (!data)
> > > +			return;
> > > +		print_efi_memmap(data->map, nr_efi_runtime_map,
> > > +				 sizeof(data->map[0]));
> > > +		early_memunmap(data, s);
> > 
> > Well, if you call print_efi_memmap() in parse_efi_setup() you can save
> > yourself that map/unmaping no?
> 
> In parse_efi_setup, I need map twice as well:

Well, your v6 has a something completely different:

void __init parse_efi_setup(u64 phys_addr)
{
        efi_setup = phys_addr;
}

There's no mapping at all anymore. So please redo your reply against v6.

> Another where what I print in this patch is same position what
> non-kexec kernel does, it looks better that print them only if earlier
> init is ok.

-ENOPARSE.

All I'm saying is, if you're going to memremap/memunmap efi_setup,
then do it once in efi_setup_init() as you do already and call
print_efi_memmap from there - no need to do work twice for no reason.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
