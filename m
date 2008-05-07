Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga10.intel.com ([192.55.52.92] helo=fmsmga102.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JtnyR-00088p-9m
	for kexec@lists.infradead.org; Wed, 07 May 2008 18:02:39 +0000
Date: Wed, 7 May 2008 10:58:29 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: Reducing the size of kexec util
Message-ID: <20080507175829.GC21888@nlxdcldnl2.cl.intel.com>
References: <20080507171130.GB21888@nlxdcldnl2.cl.intel.com>
	<20080507172836.GC28246@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080507172836.GC28246@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, May 07, 2008 at 01:28:36PM -0400, Neil Horman wrote:
> On Wed, May 07, 2008 at 10:11:30AM -0700, Lombard, David N wrote:
> > The current (20080324) kexec binary on x86 is 135KiB.  While not a
> > problem on a normal distro or runtime environment, it's a chubster
> > in an embedded role.
> > 
> > Has any thought been given to reducing its 'on-disk' footprint?
> > The rather obvious, non-default build-time options to only support
> > specific kernel types and capabilities, jumps to mind.
> > 
> > Beyond build-time options, a Busybox applet would further minimize
> > size, but maintenance would be painful...
> > 
> Busybox is precisely what I use to implement kdump in RHEL at the moment.  Its
> still a bit bloated, since it is meant for enterprise servers, but it makes it
> very easy to customize very small initramfs files for specific purposes.

Hmmm... Don't see a kexec or kdump in busybox-1.10.1.  Is this in git?

What did you do to reduce binary size?  I don't really care about process
size, as I'm not working with memory-constrained systems.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
