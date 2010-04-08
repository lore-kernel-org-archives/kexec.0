Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nzuzf-0004EO-4p
	for kexec@lists.infradead.org; Thu, 08 Apr 2010 16:54:15 +0000
Date: Thu, 8 Apr 2010 12:54:06 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: /sbin/kexec became zero size... Anyone else?
Message-ID: <20100408165406.GC16868@hmsreliant.think-freely.org>
References: <48D17183.7030002@sgi.com> <20080923075202.GA20108@verge.net.au>
	<48D91C4E.5030704@sgi.com>
	<20080923174113.GC20638@hmsendeavour.rdu.redhat.com>
	<48D95253.10400@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48D95253.10400@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Tue, Sep 23, 2008 at 01:32:19PM -0700, Jay Lan wrote:
> Neil Horman wrote:
> > On Tue, Sep 23, 2008 at 09:41:50AM -0700, Jay Lan wrote:
> >> Simon Horman wrote:
> >>> On Wed, Sep 17, 2008 at 02:07:15PM -0700, Jay Lan wrote:
> >>>> Hi,
> >>>>
> >>>> My root disk was populated with sles10sp2, but the kernel was
> >>>> 2.6.27-rc5 and /sbin/kexec was built from 2.0.0 version.
> >>>>
> >>>> Many times when kdump kernel failed early i found  after reboot that
> >>>> /sbin/kexec became zero size. There was no warning on executing
> >>>> '/etc/init.d/kdump start' when /sbin/kexec is zero size. I have
> >>>> no idea when and how that happened.
> >>>>
> >>>> Has anyone else seen this problem?
> >>> Is it possible that this is caused by filesystem corruption?
> >> I found the problems, which i can not reliably reproduce, happened
> >> when i ran into kdump kernel boot failure (yet not every time.)
> >> What puzzled me was why only /sbin/kexec was affected.
> >>
> > This is why most kdump implementations capture vmcore from an initramfs, since
> > a crash means that you may not be able to trust the integrity of the filesystems
> > that were mounted before the panic.
> > 
> > 
> >> I can not explain what caused it (otherwise i would be able to
> >> reproduce it) and do not know where my finger should point to. ;)
> >> The good news is since i fixed the kernel boot problem it has not
> >> happened any more.
> >>
> >> The distros probably can add a check against zero-sized kexec
> >> in /etc/init.d/kdump script though.
> >>
> > Theres really not a need to.  Filesystems can be corrupted by crashes, thats why
> > we capture cores from the initrd.  We need to be able to trust the rest of the
> > system to scan filesystems and do their best to recover when filsystems loose
> > data.
> 
> Hi Neil,
> 
> Which rhel release starts doing this?
> 
> Thanks,
>  - jay
> 
Its always been that way.
Neil

> 
> > 
> > Regards
> > Neil
> >  
> >> Thanks,
> >>  - jay
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
