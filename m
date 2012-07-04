Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gh0-f177.google.com ([209.85.160.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmR39-0006Mz-OE
 for kexec@lists.infradead.org; Wed, 04 Jul 2012 14:59:28 +0000
Received: by ghbf11 with SMTP id f11so7068689ghb.36
 for <kexec@lists.infradead.org>; Wed, 04 Jul 2012 07:59:10 -0700 (PDT)
Date: Wed, 4 Jul 2012 07:52:45 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill
 VMCSINFO
Message-ID: <20120704145245.GF23020@kroah.com>
References: <4FF413D2.4030006@cn.fujitsu.com> <4FF4155F.6070508@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FF4155F.6070508@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, Avi Kivity <avi@redhat.com>, ebiederm@xmission.com

On Wed, Jul 04, 2012 at 06:05:19PM +0800, Yanfei Zhang wrote:
> +int vmcs_sysfs_add(struct device *dev)
> +{
> +	return sysfs_create_group(&dev->kobj, &vmcs_attr_group);
> +}
> +
> +void vmcs_sysfs_remove(struct device *dev)
> +{
> +	sysfs_remove_group(&dev->kobj, &vmcs_attr_group);
> +}

Why are these "add" and "remove" functions here?  Shouldn't you just
write the lines out where you call them instead, as they are only called
once.

And does this race with adding new cpus to the system (is the uevent
being sent to userspace before the attributes are added?)  If so, please
fix that.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
