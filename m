Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmJna-0001rt-DB
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 08:51:42 +0000
Date: Fri, 29 Nov 2013 16:50:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 08/12] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131129085050.GF4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-9-git-send-email-dyoung@redhat.com>
 <20131127102701.GD18170@console-pimps.org>
 <20131127142726.GE32267@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127142726.GE32267@pd.tnic>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/27/13 at 03:27pm, Borislav Petkov wrote:
> On Wed, Nov 27, 2013 at 10:27:01AM +0000, Matt Fleming wrote:
> > Heh, you can probably already guess what I'm going to say here...
> 
> I guessed :-)
> 
> > How about using a single function to dump the memory ranges irrespective
> > of whether the memory map comes from 'memmap' or 'esdata'? e.g.
> > something along the lines of,
> > 
> > 	if (esdata)
> > 		print_efi_memmap(esdata->map, nr_efi_runtime_map,
> > 				 sizeof(esdata->map[0]));
> > 	else
> > 		print_efi_memmap(memmap.map, memmap.nr_map,
> > 				 memmap.desc_size);
> 
> And while you're at it:
> 
> WARNING: quoted string split across lines
> #19: FILE: arch/x86/platform/efi/efi.c:443:
> +               pr_info("mem%02u: type=%u, attr=0x%llx, "
> +                       "range=[0x%016llx-0x%016llx) (%lluMB)\n",

I see the warnings, because it's originally in print_efi_memmap so I just keep
new function same. Anyway after switching to use one function there will be
no such warning.

> 
> 
> Btw, do we really want to dump the same map again in the second kernel?

It's for debugging purpose, I think it's helpful.

Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
