Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KWQOI-00052P-4D
	for kexec@lists.infradead.org; Fri, 22 Aug 2008 06:44:58 +0000
Date: Fri, 22 Aug 2008 08:44:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Memory needed for a kdump kernel has been bloated
Message-ID: <20080822084454.176006c4@kopernikus.site>
In-Reply-To: <48ADD768.4040506@sgi.com>
References: <48ADD177.6040201@sgi.com>
	<20080821224119.4d93da1c@kopernikus.site>
	<48ADD768.4040506@sgi.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

* Jay Lan <jlan@sgi.com> [2008-08-21 14:00]:
>
> Bernhard Walle wrote:
> > * Jay Lan <jlan@sgi.com> [2008-08-21 13:35]:
> >> 2) the kdump kernel tried to add disk /dev/sdb when it is not even
> >>    in /etc/fstab. I think only the system disk and the disk where
> >>    we want to save the vmcore to should be needed.
> > 
> > But what has that to do with the kernel? What do you mean with "add
> > disk"? Mount? Load driver? That's up to initrd and/or system
> > configuration ...
> 
> Hmm, it would be great if there is a way we can initialize only the
> needed disk. "add_disk" was called from sd_probe:
>    add_disk <-
>      sd_probe <-
>      driver_probe_device <-
>      __device_attach <-
>      bus_for_each_drv <-
>      ...
> 
> So the solution might need come from initrd or a device driver? Maybe
> we can use a new system configuration item. But it can save a lot of
> memory if we do not need to initialize those devices.

Hm ..., I guess all disks share the same driver in your setup. I think
that's not possible with current infrastructure ... but maybe someone
has an idea.

But in general I like the idea. That would also help on other
platforms with a huge amount of disks. :-)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

"Make everything as simple as possible, but not simpler."
        -- Albert Einstein

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
