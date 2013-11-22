Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjhL5-000561-16
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 03:23:28 +0000
Date: Fri, 22 Nov 2013 10:45:06 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 9/9 v3] x86: export x86 boot_params to sysfs
Message-ID: <20131122024506.GB3874@dhcp-16-126.nay.redhat.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061757.030007746@dhcp-16-126.nay.redhat.com>
 <20131121164554.GB15083@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121164554.GB15083@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/21/13 at 08:45am, Greg KH wrote:
> > +static struct kobj_attribute boot_params_version_attr =
> > +	__ATTR(version, S_IRUGO, boot_params_version_show, NULL);
> 
> __ATTR_RO() please.

Will do

> 
> > +static struct kobj_attribute type_attr =
> > +		__ATTR(type, S_IRUGO, setup_data_type_show, NULL);
> 
> __ATTR_RO() here too.

Will do

[snip]
> > +
> > +	ret = get_setup_data_size(nr, &size);
> > +	if (ret)
> > +		goto out_kobj;
> > +
> > +	data_attr.size = size;
> > +	ret = sysfs_create_bin_file(kobj, &data_attr);
> > +	if (ret)
> > +		goto out_file;
> > +	*kobjp = kobj;
> 
> You just raced with userspace (creating and announcing the kobject and
> then, afterward, at some later point in time, created the sysfs files.
> Please use the groups option to create the files properly before
> announcing the kobject to userspace.

Will do

[snip]
> > +		goto out_boot_params_kobj;
> > +	ret = sysfs_create_bin_file(boot_params_kobj,
> > +				      &boot_params_data_attr);
> > +	if (ret)
> > +		goto out_create_file;
> > +
> > +	ret = create_setup_data_nodes(boot_params_kobj);
> > +	if (ret)
> > +		goto out_create_bin;
> > +
> > +	return 0;
> 
> Same race condition here as well.  Use a groups structure please.
> 

Will use group attributes

Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
