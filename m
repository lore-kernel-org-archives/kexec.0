Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IBWlo-0004qy-9q
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 10:14:22 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6JEECFM023388
	for <kexec@lists.infradead.org>; Thu, 19 Jul 2007 10:14:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6JEE7UQ174586
	for <kexec@lists.infradead.org>; Thu, 19 Jul 2007 08:14:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6JEDuZc017109
	for <kexec@lists.infradead.org>; Thu, 19 Jul 2007 08:13:56 -0600
Date: Thu, 19 Jul 2007 19:42:48 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070719141248.GA18586@in.ibm.com>
References: <20070716123633.GA10920@in.ibm.com>
	<20070718230740oomichi@mail.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070718230740oomichi@mail.jp.nec.com>
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
Cc: Neil Horman <nhorman@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dan Aloni <da-x@monatomic.org>

On Wed, Jul 18, 2007 at 11:07:40PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> 2007/07/16 18:06:33 +0530, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >On Mon, Jul 16, 2007 at 02:28:54PM +0200, Bernhard Walle wrote:
> >> * Vivek Goyal <vgoyal@in.ibm.com> [2007-07-16 14:25]:
> >> > 
> >> > Ok. Now there seems to be two ways for accessing such info.
> >> > - Through global variables
> >> > - Export through ELF notes.
> >> > 
> >> > Personally, I like the approach taken by Dan Aloni of exporting required
> >> > info through ELF notes. That seems to be more standard in the sense we 
> >> > are not dependent on somebody removing above variable tomorrow.
> >> > 
> >> > Dan, are you planning to put the modified patch for discussions on LKML?
> >> 
> >> You mean the proposal with the makedumpfile-compatible ELF note?
> >> Although I like that idea, I think Ken'ichi Ohmichi was against it.
> >> 
> >
> >Yes, makedumpfile compatible ELF note one. Ken'ichi did not like the idea
> >too much, but I am not sure we discussed his objections in detail. I had
> >also responded with a mail with some of the advantages of ELF note based
> >approach. No response on that.
> 
> Sorry for my delayed response, I took a short vacation.
> 
> I'm not against with the proposal adding PT_NOTE segment to /proc/vmcore.
> I don't like only point that adds the necessary information list
> (some symbols, structures, etc.) for makedumpfile to kernel code.
> 
> The content of mkdfinfo file has been increasing whenever adding
> features and correcting bugs. The content is increasing even now.
> And, the feature addition is done not only for new kernels but also
> for old upstream kernels. When the content of mkdfinfo file is taken 
> into the kernel and fixed, the feature addition in the future is
> remarkably limited. So makedumpfile needs mkdfinfo file outside of
> the kernel.
> 

Well, idea of filtering tool having flexibility to create its own ELF note
and later retrieve it and use it looks good. But at the same time you 
will have to standardize the contents of ELF note. One can not keep on
changing it at will.

> I propose the solution including Dan's, Vivek's and Bernhard's opinions.
> How about the following sequence for distributors ?
> (It is not necessary to rebuild 2nd-kernel initrd even if 1st-kernel changes.
>  A new option "--mkdfinfo" is added to kexec command.)
> 
> * On the kernel building system
>   1. Create the kernel files.
>      # cd linux-2.6.xx
>      # make
>   2. Create the mkdfinfo file from the vmlinux.
>      # makedumpfile -g mkdfinfo-2.6.xx -x vmlinux
>      (OSRELEASE is taken from the vmlinux.)
>   3. Pack the kernel package with the kernel files and the mkdfinfo file.
> 
> * On each system
>   4. Preload 2nd-kernel and the mkdfinfo file.
>      # kexec -p vmlinux-kdump --mkdfinfo=mkdfinfo-2.6.xx ...

Providing first kernel's debug data on commandline while loading second
kernel is little odd but I guess can be lived with.

>      - 2nd-kernel is preloaded.
>      - 1st-kernel's PAGESIZE is taken by sysconf().
>      - The mkdfinfo file and the above PAGESIZE is preloaded
>        into /proc/vmcore's PT_NOTE segment.

>   5. Panic happens, and the system switchs to 2nd-kernel.
>   6. Create a filtered dump file.
>      # makedumpfile -cd31 /proc/vmcore dumpfile
>      (User doesn't need to specify the mkdfinfo file, because the
>       contents of the mkdfinfo file is included into /proc/vmcore.)
> 

Overall proposal looks interesting. But it still requires a debug compiled
vmlinux for one to use filtering. For distros it is probably easy as they
can extract the debug info at build time and ship separate file with kernel
package (/boot/mkdfinfo-2.6.xxx). For people building their custom kernel,
they still need to build vmlinux with debuginfo. Personally, I wished
we could get rid of this requirement. I think may be down the line we can
start exporting it from kenrel once contents of ELF note are well defined.

Thanks
Vivek




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
