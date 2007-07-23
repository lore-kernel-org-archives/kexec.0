Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ID0RV-0001Ny-05
	for kexec@lists.infradead.org; Mon, 23 Jul 2007 12:07:30 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6NG7OhU005903
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 12:07:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6NG7DkF208544
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 10:07:24 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6NFwRej018778
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 09:58:27 -0600
Date: Mon, 23 Jul 2007 21:28:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070723155803.GA30193@in.ibm.com>
References: <20070723050147.GA5691@in.ibm.com>
	<20070723204723oomichi@mail.jp.nec.com>
	<20070723130239.GA311@localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070723130239.GA311@localdomain>
Reply-To: vgoyal@in.ibm.com
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
Cc: Don Zickus <dzickus@redhat.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Jul 23, 2007 at 04:02:39PM +0300, Dan Aloni wrote:
> On Mon, Jul 23, 2007 at 08:47:23PM +0900, Ken'ichi Ohmichi wrote:
> > 
> > Hi,
> > 
> > 2007/07/23 10:31:47 +0530, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> [..]
> > >
> > >I am also in favour of a complete kernel based solution. Export required
> > >info from kernel and let kexec-tools parse that info, pass it to second
> > >kernel and it will be appended to vmcore.
> > >
> > >This will put some restrictions on that we can't keep on changing the
> > >format of the info very frequently and some new features might not work
> > >with older kernels. But I guess, kexec-tools can provide an override option
> > >where dump filtering info can be passed on kexec-tools command line (as
> > >suggested by ken'chi). If user passes this info on command line then
> > >kexec-tools will not read the info exported from kernel. This way new
> > >features can be made to work on older kernels. 
> > 
> > That sounds good.
> 
> Note that currently kexec doesn't actually pass the ELF notes themselves
> to the kernel, but only their physical addresses as extracted from /sys. 
> If we want to be able to pass the notes themselves from userspace, a 
> little more trickery will be needed here.
> 

That should be easy. Like so many other segments kexec prepares, one
more segment need to be created and required elf note data needs to be
put in this segment. 

Right now we create a PT_NOTE type ELF header for every cpu. Now we need
to create few more notes to pass on the OS release, config variables and
debug data to second kernel.

Should we create a separate note for passing on kernel config info something
like "linuxconfig" and every note will contain CONFIG_VARIABLE=VALUE string?

Probably something similar can be done for appropriate debugging data 
instead of putting all the info in one ELF note. Breaking the required
info into multiple generic notes will help it to be used in other things
also down the line. Just a thought....

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
