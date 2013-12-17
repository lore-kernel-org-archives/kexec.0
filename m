Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsnvU-0002GL-Hm
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 06:14:42 +0000
Date: Tue, 17 Dec 2013 14:13:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 08/14] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131217061347.GD6751@dhcp-16-126.nay.redhat.com>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-9-git-send-email-dyoung@redhat.com>
 <20131216150929.GA3873@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131216150929.GA3873@console-pimps.org>
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

On 12/16/13 at 03:09pm, Matt Fleming wrote:
> On Mon, 16 Dec, at 05:30:29PM, Dave Young wrote:
> > @@ -899,6 +928,11 @@ void __init efi_enter_virtual_mode(void)
> >  		return;
> >  	}
> >  
> > +#ifdef CONFIG_EFI_RUNTIME_MAP
> > +	efi_runtime_map_setup(efi_runtime_map, nr_efi_runtime_map,
> > +			      boot_params.efi_info.efi_memdesc_size);
> > +#endif
> 
> [...]
> 
> > @@ -167,6 +167,12 @@ static int __init efisubsys_init(void)
> >  		goto err_unregister;
> >  	}
> >  
> > +#ifdef CONFIG_EFI_RUNTIME_MAP
> > +	error = efi_runtime_map_init(efi_kobj);
> > +	if (error)
> > +		goto err_remove_group;
> > +#endif
> 
> [...]
> 
> > @@ -876,4 +876,9 @@ int efivars_sysfs_init(void);
> >  
> >  #endif /* CONFIG_EFI_VARS */
> >  
> > +#ifdef CONFIG_EFI_RUNTIME_MAP
> > +int efi_runtime_map_init(struct kobject *);
> > +void efi_runtime_map_setup(void *, int, u32);
> > +#endif
> 
> I was thinking more along the lines of...

Previously I only call the function conditionally thus there's
compiler warning about "unused function" for the #else

unconditionally call it build will be ok. Will update this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
