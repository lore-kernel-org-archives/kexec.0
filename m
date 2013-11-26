Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlEiL-0005wY-Ol
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 09:13:50 +0000
Date: Tue, 26 Nov 2013 17:13:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 05/12] efi: export more efi table variable to sysfs
Message-ID: <20131126091301.GB10899@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-6-git-send-email-dyoung@redhat.com>
 <20131126085035.GC20917@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131126085035.GC20917@pd.tnic>
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

On 11/26/13 at 09:50am, Borislav Petkov wrote:
> On Tue, Nov 26, 2013 at 01:57:50PM +0800, Dave Young wrote:
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 2e2fbde..5d85956 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -32,6 +32,9 @@ struct efi __read_mostly efi = {
> >  	.hcdp       = EFI_INVALID_TABLE_ADDR,
> >  	.uga        = EFI_INVALID_TABLE_ADDR,
> >  	.uv_systab  = EFI_INVALID_TABLE_ADDR,
> > +	.fw_vendor  = EFI_INVALID_TABLE_ADDR,
> > +	.runtime    = EFI_INVALID_TABLE_ADDR,
> > +	.config_table  = EFI_INVALID_TABLE_ADDR,
> 
> See what I mean with alignment?

Yes, I see. As for this segment I would not like change the previous code
just because of this reason

> 
> Now this config_table thing sticks out and completely destroys the
> balance in the universe.
> 
> :-)
> 
> >  };
> >  EXPORT_SYMBOL(efi);
> >  
> > @@ -71,13 +74,54 @@ static ssize_t systab_show(struct kobject *kobj,
> >  static struct kobj_attribute efi_attr_systab =
> >  			__ATTR(systab, 0400, systab_show, NULL);
> >  
> > +static ssize_t fw_vendor_show(struct kobject *kobj,
> > +				struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "0x%lx\n", efi.fw_vendor);
> > +}
> > +
> > +static ssize_t runtime_show(struct kobject *kobj,
> > +				struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "0x%lx\n", efi.runtime);
> > +}
> > +
> > +static ssize_t config_table_show(struct kobject *kobj,
> > +				struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "0x%lx\n", efi.config_table);
> > +}
> 
> Those are sooo similar, it's like the macro SHOW writes itself.

Ok, will add a macro for the above functions..

Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
