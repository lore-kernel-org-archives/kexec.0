Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I7pRa-0003hx-Rw
	for kexec@lists.infradead.org; Mon, 09 Jul 2007 05:22:12 -0400
Date: Mon, 9 Jul 2007 11:21:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070709092154.GA19705@suse.de>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070706145804.GA31409@localdomain>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dan Aloni <da-x@monatomic.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hello,

* Dan Aloni <da-x@monatomic.org> [2007-07-06 16:58]:
> 
> Redhat has a makedumpinfo util which they intend to use as slim
> kernel-version-independent utility on kdump rootfs in order to
> save /proc/vmcore in a compact manner.

I think you mean makedumpfile, don't you?

> A patch that I am working on will make it possible to integrate
> the output of 'makedumpinfo -g' into vmlinux as the final build
> stage of the kernel. This information will be presented itself
> as /proc/kcore.info for the first kernel throughout its entire
> execution.

That sounds good. But I doubt that kernel developers like the idea of
needing another utility in the build process ...

> Then inside initramfs of the first kernel, a small 
> util will modify the vmlinux file of the kdump kernel before it
> gets loaded so that another special file appearing as 
> /proc/vmcore.info under the kdump kernel will present the same
> info. 

Where do you get the info from? If you're in the kdump initrd,
then the kdump kernel is already loaded. Do you want to attach the
info from the crashed kernel to the initrd of the kdump kernel?



Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
