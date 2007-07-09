Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I80B1-0008AS-9K
	for kexec@lists.infradead.org; Mon, 09 Jul 2007 21:49:48 +0100
Date: Mon, 9 Jul 2007 22:49:38 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070709204938.GA21663@suse.de>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070709092154.GA19705@suse.de>
	<20070709114131.GA18750@localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070709114131.GA18750@localdomain>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

* Dan Aloni <da-x@monatomic.org> [2007-07-09 13:41]:
> > > A patch that I am working on will make it possible to integrate
> > > the output of 'makedumpinfo -g' into vmlinux as the final build
> > > stage of the kernel. This information will be presented itself
> > > as /proc/kcore.info for the first kernel throughout its entire
> > > execution.
> > 
> > That sounds good. But I doubt that kernel developers like the idea of
> > needing another utility in the build process ...
> 
> I don't think it would add much complexity to build process as it 
> is now, just like the other tools that transparently do post-linking 
> modifications. As far as the developer is concerned, there's just
> the vmlinux and/or bzImage files that get emitted at the end.

I didn't complain about the complexity but about the requirement of an
additional tool. However, I think it will be configurable.

> > > Then inside initramfs of the first kernel, a small 
> > > util will modify the vmlinux file of the kdump kernel before it
> > > gets loaded so that another special file appearing as 
> > > /proc/vmcore.info under the kdump kernel will present the same
> > > info. 
> > 
> > Where do you get the info from? If you're in the kdump initrd,
> > then the kdump kernel is already loaded. Do you want to attach the
> > info from the crashed kernel to the initrd of the kdump kernel?
> 
> Not exactly. Let me describe the procedure in greater detail.
> Basically, it would go like this:
> 
> 1. <normal bootloader boot>
> 2. <normal initramfs>
> 3. embed_configfile /proc/kcore.info /vmlinux-kdump
> 4. kexec -l vmlinux-kdump <....>
> 5. <boot continues>
> 6. <crash>
> 7. <kdump kernel boot>
> 8. <kdump initramfs runs>
> 9. makedumpfile -i /proc/vmcore.info <....>

I don't see why an additional tool would be needed here. kexec already
modifies symbols, so why not adding the functionality into kexec? The
advantage would be that there's no on-disk modification necessary.

Another issue: Some parameters of makedumpfile (currently the page
size) are read from the running system. If you build the configuration
file while building the kernel, you always have the .config which
contains the page size. So it would be possible to extend the
makedumpfile utility to read that parts from a .config, and that would
remove a dependency that page size of the running kernel matches the
page size of the building kernel. On IA64, that's not always the case.

> BTW I think there could be a confusion between makedumpfile's 
> CONFIGFILE and the .config file, so we should pick a different 
> name for it...

Aggreed. Your suggestion? :)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
