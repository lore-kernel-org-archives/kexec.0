Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmKdF-00030j-AH
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 09:45:05 +0000
Date: Fri, 29 Nov 2013 17:44:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 10/12] x86: export x86 boot_params to sysfs
Message-ID: <20131129094419.GJ4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-11-git-send-email-dyoung@redhat.com>
 <20131127112022.GE18170@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127112022.GE18170@console-pimps.org>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/27/13 at 11:20am, Matt Fleming wrote:
> On Tue, 26 Nov, at 01:57:55PM, Dave Young wrote:
> > +Users:
> > +		Kexec Mailing List <kexec@lists.infradead.org>
> 
> "Kexec" please.

Will change

> 
> > +static ssize_t version_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> 
> This is pretty strange indentation. Usually we prefer to line up the
> arguments like you've done elsewhere in this file.

Ok.

> 
> > +{
> > +	return sprintf(buf, "0x%04x\n", boot_params.hdr.version);
> > +}
> > +
> > +static struct kobj_attribute boot_params_version_attr = __ATTR_RO(version);
> > +
> > +static ssize_t boot_params_data_read(struct file *fp, struct kobject *kobj,
> > +				     struct bin_attribute *bin_attr,
> > +				     char *buf, loff_t off, size_t count)
> > +{
> > +	memcpy(buf, (void *)&boot_params + off, count);
> > +	return count;
> > +}
> 
> Don't we need some checks here to ensure we don't read past the end of
> boot_params?

The size was added below, so I would assume file read will not beyond the
file size:
.size = sizeof(boot_params),

> 
> > +static ssize_t type_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> 
> More whacky indentation.

Will fix

> 
> > +static int __init create_setup_data_node(struct kobject *parent,
> > +					struct kobject **kobjp, int nr)
> 
> Funky indentation.

Will fix

Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
