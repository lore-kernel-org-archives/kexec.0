Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JQwSe-0005oU-Kj
	for kexec@lists.infradead.org; Mon, 18 Feb 2008 03:14:33 +0000
Date: Mon, 18 Feb 2008 12:14:20 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Kexec command line length
Message-ID: <20080218031418.GC7057@verge.net.au>
References: <20080129154104.GA12219@redhat.com> <20080129181701.GB535@suse.de>
	<20080129195753.GB21530@hmsreliant.think-freely.org>
	<20080130205323.GA15415@redhat.com>
	<20080130205947.GA5660@hmsendeavour.rdu.redhat.com>
	<20080130210815.GB15415@redhat.com>
	<20080130211834.GC5660@hmsendeavour.rdu.redhat.com>
	<20080130214551.GC15415@redhat.com>
	<20080131071625.GA11164@suse.de>
	<20080212211157.GB1862@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080212211157.GB1862@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org

On Tue, Feb 12, 2008 at 04:11:57PM -0500, Neil Horman wrote:
> On Thu, Jan 31, 2008 at 08:16:25AM +0100, Bernhard Walle wrote:
> > * Vivek Goyal <vgoyal@redhat.com> [2008-01-30 22:45]:
> > > 
> > > No. 2.04 is really old. As per boot.txt, it was introduced in 2.6.14.
> > > 
> > > Anyway, thinking about it more, Large command lines were introduced in
> > > 2.6.21 kernel (for both i386 and x86_64). cmdline_size was introduced
> > > in 2.6.22 (for both i386 and x86_64). So how about following test
> > > condition for both the arch.
> > > 
> > > if (boot_protocol >= 2.06)
> > > 	error message based on cmdline_size field
> > > else
> > > 	Warn user if command line is more than 256 but continue to work.
> > >   	Let the user know that it is not known if kernel being loaded
> > > 	supports command line size greater than 256. Command line will
> > > 	be truncated by destination kernel if it does not support large
> > > 	command lines. User is taking a chance
> > 
> > Yes, I also think that's sufficient.
> > 
> > 
> >         Bernhard
> > 
> So, has anyone heard out of Simon?  I've noted that he hasn't updated the git
> tree for kexec-tools nor has he posted to the list is almost 3 weeks.  Anyone
> know if he's ok?  Simon, if you're out there, give us a shout! :)

Hi All,

sorry to be quiet. I've been travling + other modes of busy.

I won't pretend to be an expert on the x86 boot protocol,
but this patch does look clean to me.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
