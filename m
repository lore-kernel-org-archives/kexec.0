Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I9CIQ-0001pr-QC
	for kexec@lists.infradead.org; Thu, 12 Jul 2007 23:58:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6D2sStY002448
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 22:54:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6D3wGKS523502
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 23:58:16 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6D3wG6Q007648
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 23:58:16 -0400
Date: Fri, 13 Jul 2007 09:28:25 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070713035825.GB4975@in.ibm.com>
References: <20070711073216.GA11757@localdomain>
	<20070711224304oomichi@mail.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070711224304oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, linux-kernel@vger.kernel.org

On Wed, Jul 11, 2007 at 10:43:04PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi Dan,
> 
> 2007/07/11 10:32:16 +0300, Dan Aloni <da-x@monatomic.org> wrote:
> >> This implementation looks interesting. No need of debug compiled
> >> vmlinux for dump filtering purposes. No run time vmlinux binary modifications
> >> as suggested by your previous mails. People can export kernel CONFIG info
> >> like PAGESIZE etc with the help of this ELF note and any tool which is
> >> processing kernel core file can benifit from this. No guesses required for
> >> determining the page size of crashed kernel.
> >> 
> >> All the info required by dump filtering tool, put it into an ELF note, 
> >> pass it to second kernel which appends it to final vmcore. The only concern
> >> here again is that type of ELF note is not standard. The contents of 
> >> ELF notes will keep on changing over a period of time. For example if a 
> >> new memory model evolves. Now everytime this note data changes one shall
> >> have to update mkdumpfile and user shall have to newer version. If there
> >> are any issues, user will not come to know about the issue during kdump
> >> service enablement time, instead it will be detected during dump 
> >> capture time. It is too late till then.
> >
> >I guess that dump filtering will needed to be tested at least once 
> >under various platforms for every major release of the kernel to see 
> >if the information exported by the kernel through this elf note is 
> >still sufficient. 
> >
> >Adding more info to this elf note as needed can be done through a simple 
> >patch to the kernel and it can be tested along with mkdumpfile changes 
> >even before a major version gets released.
> 
> As Vivek said, I think it is not a good idea that both kernel's code and
> makedumpfile's code should be changed when makedumpfile needs more debug
> information (ex. To extend the supported CPU architectures. To fix some
> machine-specific problems, etc.).
> Also it is difficult to change the list of necessary items in kernel,
> because we should be careful about CPU architecture, linux version, and
> memory model. makedumpfile needs the following items, and those existence
> depends on CPU architecture, linux version, and memory model. If we don't
> be careful about them, the kernel building may fail.
> I think it is not a good idea that each items are defined by ifdef, it
> is too complex.
> 

Hi Ken'ichi,

This approach seems to have advantages also. For example, now one will not
require a kernel debuginfo file to configure kdump with dump filtering.
I think having to have a debug info file is a big restriction.

Now vmcore ELF note contain all the data rquired to filter core dump and
there will be no need to parse DWARF debuginfo and makedumpfile code will be
smaller and simpler.

Given the fact that more and more architectures are supporting multiple
page sizes. Now one can also export relevant kernel CONFIG variables
through this ELF note. makedumpfile's job will be simpler. You don't have
to make any guesses about various config options like page size.

This approach will make second kernel truly independent of first kernel.
Currently, if first kernel changes one shall have to regenerate the 
initrd for second kenrel. Hence in a sense, second kernel is dependent on
first kernel. Now kernel will export all the required data for dump filtering
so one does not have to rebuild the seond kernel initrd even if first kernel
changes.

I think overall the approach of exporting right info from kernel should 
help. Only thing is that we shall have to manage the ELF note better in
terms of making it more generic.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
