Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8Y29-0005Wn-78
	for kexec@lists.infradead.org; Wed, 11 Jul 2007 04:58:56 -0400
Date: Wed, 11 Jul 2007 10:58:10 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070711085810.GB23466@suse.de>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070710064817.GC5471@in.ibm.com>
	<20070710120904.GB10121@hmsendeavour.rdu.redhat.com>
	<20070710165201.GA7984@localdomain>
	<20070711060726.GA5310@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070711060726.GA5310@in.ibm.com>
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
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Dan Aloni <da-x@monatomic.org>, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-11 08:07]:
> On Tue, Jul 10, 2007 at 07:52:01PM +0300, Dan Aloni wrote:
> > On Tue, Jul 10, 2007 at 08:09:04AM -0400, Neil Horman wrote:
> > > On Tue, Jul 10, 2007 at 12:18:17PM +0530, Vivek Goyal wrote:
> > > > On Fri, Jul 06, 2007 at 05:58:04PM +0300, Dan Aloni wrote:
> > > > > On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> > > > > > Hello,
> > [...]
> > > > > It contains enough information in order to make a compact kernel
> > > > > dump (makedumpinfo needs to go over the struct page arrays). As
> > > > > you see, it also contains the kernel version.
> > > > > 
> > > > 
> > > > But this will not solve Bernhard's problem where looking at a vmcore
> > > > he wants to know which vmlinux (kernel version with time stamp) has
> > > > generated this vmcore. So adding a ELF NOTE should help.
> > > > 
> > > I think an ELF note would be a fine idea.
> > 
> > Okay, so here's an implemenation.
> > 
> > See the attached proof-of-concept patches to the kernel-side kexec and 
> > kexec-tools (might need some cleanup though). Next to follow, a patch 
> > to makedumpfile. With these patches a new "LINUX" elf note generated 
> > by the kernel in the format that makedumpfile expects and is being 
> > passed on by the kexec util to the kdump kernel.
> > 
> > As a bonus, with this patch you don't even have to compile the kernel 
> > with debug information in order for the filtering to work.
> > 
> 
> This implementation looks interesting. No need of debug compiled
> vmlinux for dump filtering purposes. No run time vmlinux binary modifications
> as suggested by your previous mails. People can export kernel CONFIG info
> like PAGESIZE etc with the help of this ELF note and any tool which is
> processing kernel core file can benifit from this. No guesses required for
> determining the page size of crashed kernel.

I also like way of implementing it. :)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
