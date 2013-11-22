Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjgz4-0004rr-Hu
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 03:00:44 +0000
Date: Fri, 22 Nov 2013 10:59:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 2/9 v3] efi: add a wrapper function efi_map_region_fixed
Message-ID: <20131122025944.GF3874@dhcp-16-126.nay.redhat.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061753.223578092@dhcp-16-126.nay.redhat.com>
 <20131121163947.GL26009@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121163947.GL26009@pd.tnic>
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

> >  }
> >  
> > +/*
> > + * kexec kernel will use efi_map_region_fixed to map efi
> > + * runtime memory ranges. md->virt_addr is the original virtual
> > + * address which had been mapped in kexec 1st kernel.
> > + */
> 
> Why not stretch this comment to the full 80 cols?

Since stretch them to 80 cols I still need 3 lines so I want the
length to be more close to the length of context code lines, so
It looks better to my eys :)

I can change to 80 cols as you said below, thanks.

> 
> /*
>  * kexec kernel will use efi_map_region_fixed to map efi runtime memory ranges.
>  * md->virt_addr is the original virtual address which had been mapped in kexec
>  * 1st kernel.
>  */
> 

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
