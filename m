Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VabOi-00007t-IL
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 01:13:37 +0000
Date: Mon, 28 Oct 2013 09:12:54 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 4/4] Passing efi related data via setup_data
Message-ID: <20131028011253.GB4397@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
 <20131028003726.GF849@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028003726.GF849@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

Hi, Simon

Thanks for review.

> > +	int has_efi = 0;
> 
> The indentation of the line below is inconsistent with the line above.

Will fix

> 
> > +
> > +        has_efi = access("/sys/firmware/efi/systab", F_OK);
> > +        if (has_efi < 0)
> > +                return;
> > +
> > +	esd = malloc(sizeof(struct efi_setup_data));
> > +	if (!esd)
> > +		return;
> 
> This function appears to leak esd.

I left the error handling after testing but later forgot to add them.
Will fix

> 
> > +	memset(esd, 0, sizeof(struct efi_setup_data));
> > +	get_efi_value(esd);
> > +	nr_maps = get_efi_runtime_map(&esd);
> > +	size = nr_maps * sizeof(struct efi_mem_descriptor) + sizeof(struct efi_setup_data);
> > +	sd = malloc(sizeof(struct setup_data) + size);
> > +	if (!sd) {
> > +		free(esd);
> > +		return;
> > +	}
> 
> This function appears to leak sd.

Will fix

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
