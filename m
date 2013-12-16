Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsNbn-0005zy-FN
 for kexec@lists.infradead.org; Mon, 16 Dec 2013 02:08:37 +0000
Date: Mon, 16 Dec 2013 10:00:10 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 10/14] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131216020010.GC3754@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-11-git-send-email-dyoung@redhat.com>
 <20131213160150.GE32329@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131213160150.GE32329@pd.tnic>
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

> > -	print_efi_memmap();
> > +	if (efi_setup) {
> > +		int s;
> > +		struct efi_setup_data *data;
> > +
> > +		s = sizeof(*data) + nr_efi_runtime_map * sizeof(data->map[0]);
> > +		data = early_memremap(efi_setup, s);
> > +		if (!data)
> > +			return;
> > +		print_efi_memmap(data->map, nr_efi_runtime_map,
> > +				 sizeof(data->map[0]));
> > +		early_memunmap(data, s);
> 
> Well, if you call print_efi_memmap() in parse_efi_setup() you can save
> yourself that map/unmaping no?

In parse_efi_setup, I need map twice as well:
  mapping sizeof(struct setup_data) to get the payload len, then mapping
  the data->map again and call print_efi_memmap..

Another where what I print in this patch is same position what non-kexec kernel
does, it looks better that print them only if earlier init is ok. 

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
