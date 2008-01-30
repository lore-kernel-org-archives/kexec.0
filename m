Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JKKAK-0000Y7-Ta
	for kexec@lists.infradead.org; Wed, 30 Jan 2008 21:08:23 +0000
Date: Wed, 30 Jan 2008 16:08:15 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080130210815.GB15415@redhat.com>
References: <20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
	<20080128212910.GA21889@suse.de>
	<20080129010122.GA11935@hmsreliant.think-freely.org>
	<20080129154104.GA12219@redhat.com> <20080129181701.GB535@suse.de>
	<20080129195753.GB21530@hmsreliant.think-freely.org>
	<20080130205323.GA15415@redhat.com>
	<20080130205947.GA5660@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080130205947.GA5660@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

On Wed, Jan 30, 2008 at 03:59:47PM -0500, Neil Horman wrote:
> On Wed, Jan 30, 2008 at 03:53:23PM -0500, Vivek Goyal wrote:
> > On Tue, Jan 29, 2008 at 02:57:53PM -0500, Neil Horman wrote:
> > > 
> > > Ok, I've got a new patch here.  In response to Bernhard and Viveks concerns,
> > > I've added a few checks.  Bernhard, thank you for digging into the history of
> > > the addition of the 2048 byte command line.  As I understand what you've posted
> > > heres what we need to capture:
> > > 
> > > On X86:
> > > 	Boot loader version >= 2.06
> > > 		error if cmdline_len > setup_header.cmdline_size
> > > 	2.05 > Boot loader version > 2.06
> > > 		warn if cmdline_len > 255
> > > 	Boot loader version < 2.05
> > > 		error if cmdline_len > 255
> > > 
> > > on X86_64:
> > > 	Boot loader version >= 2.04
> > > 		error if cmdline_len > setup_header.cmdline_size
> > 
> > cmdline_size was introduced only in version 2.06. So this will run
> > into trouble on x86_64 version 2.04 and 2.05, isn't it?
> > 
> Then how did version 2.04 on x86_64 determine its maximum command line length?
> Or did it just assume a max length of 2048 bytes?

I think it just did not tell. There was no way for a kernel bzImage to
tell boot-loader what's the supported command line size is (Pre 2.06).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
