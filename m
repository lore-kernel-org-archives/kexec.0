Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JP2Qo-0005WN-Oc
	for kexec@lists.infradead.org; Tue, 12 Feb 2008 21:12:53 +0000
Date: Tue, 12 Feb 2008 16:11:57 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080212211157.GB1862@hmsreliant.think-freely.org>
References: <20080129010122.GA11935@hmsreliant.think-freely.org>
	<20080129154104.GA12219@redhat.com> <20080129181701.GB535@suse.de>
	<20080129195753.GB21530@hmsreliant.think-freely.org>
	<20080130205323.GA15415@redhat.com>
	<20080130205947.GA5660@hmsendeavour.rdu.redhat.com>
	<20080130210815.GB15415@redhat.com>
	<20080130211834.GC5660@hmsendeavour.rdu.redhat.com>
	<20080130214551.GC15415@redhat.com>
	<20080131071625.GA11164@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080131071625.GA11164@suse.de>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

On Thu, Jan 31, 2008 at 08:16:25AM +0100, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@redhat.com> [2008-01-30 22:45]:
> > 
> > No. 2.04 is really old. As per boot.txt, it was introduced in 2.6.14.
> > 
> > Anyway, thinking about it more, Large command lines were introduced in
> > 2.6.21 kernel (for both i386 and x86_64). cmdline_size was introduced
> > in 2.6.22 (for both i386 and x86_64). So how about following test
> > condition for both the arch.
> > 
> > if (boot_protocol >= 2.06)
> > 	error message based on cmdline_size field
> > else
> > 	Warn user if command line is more than 256 but continue to work.
> >   	Let the user know that it is not known if kernel being loaded
> > 	supports command line size greater than 256. Command line will
> > 	be truncated by destination kernel if it does not support large
> > 	command lines. User is taking a chance
> 
> Yes, I also think that's sufficient.
> 
> 
>         Bernhard
> 
So, has anyone heard out of Simon?  I've noted that he hasn't updated the git
tree for kexec-tools nor has he posted to the list is almost 3 weeks.  Anyone
know if he's ok?  Simon, if you're out there, give us a shout! :)

Thanks & Regards
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
