Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViEP6-00010F-HZ
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 02:17:32 +0000
Date: Mon, 18 Nov 2013 10:16:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 5/7 v2] export efi runtime memory mapping to sysfs
Message-ID: <20131118021641.GC4025@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082718.185728964@dhcp-16-126.nay.redhat.com>
 <20131113155027.GC17248@console-pimps.org>
 <20131114015047.GD4081@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131114015047.GD4081@dhcp-16-126.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

> > > +/*
> > > + * These are default attributes that are added for every memmap entry.
> > > + */
> > > +static struct attribute *def_attrs[] = {
> > > +	&map_type_attr.attr,
> > > +	&map_phys_addr_attr.attr,
> > > +	&map_virt_addr_attr.attr,
> > > +	&map_num_pages_attr.attr,
> > > +	&map_attribute_attr.attr,
> > > +	NULL
> > > +};
> > 
> > If the UEFI spec ever releases an update for the memory descriptor
> > structure, and bumps 'memmap.desc_version', how are we going to signal
> > the incompatibility to legacy versions of kexec tools?
> 
> Hmm, that is a problem. I will consider to export memmap according to
> what firmware provided with extra desc_version instead of using attrs from kernel
> data structure efi_memory_desc_t
> 

Matt, desc_version is already in boot_params.efi_info, so kexec-tools can get
the version from there. I do not need to export it as another file.

I think for now we do not need worry much about the compatibility issue, do you
think I need add version checking in kexec-tools currently? like below?

if (desc_version != 1) /* current version is 1? */
	error out it is not supported

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
