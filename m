Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjgrB-0004j2-RT
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 02:52:34 +0000
Date: Fri, 22 Nov 2013 10:51:40 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 5/9 v3] efi: export more efi table variable to sysfs
Message-ID: <20131122025140.GD3874@dhcp-16-126.nay.redhat.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.887381332@dhcp-16-126.nay.redhat.com>
 <20131121164224.GA15083@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121164224.GA15083@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

> > +
> > +	if (efi.config_table != EFI_INVALID_TABLE_ADDR) {
> > +		error = sysfs_create_file(efi_kobj,
> > +					&efi_attr_config_table.attr);
> > +		if (error) {
> > +			pr_err("efi: Sysfs attribute %s export failed with error %d.\n",
> > +				efi_attr_config_table.attr.name, error);
> > +			goto err_remove_runtime;
> > +		}
> > +	}
> 
> You don't need to do this "if SOMETHING then create the file", just use
> the "is_visible" attribute in the group to do this as a callback to
> determine this when the group is registered.

I did not know the is_visible before, thanks for the hint, will use it

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
