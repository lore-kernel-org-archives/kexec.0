Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I9C4m-0000tB-AT
	for kexec@lists.infradead.org; Fri, 13 Jul 2007 04:44:19 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6D3hwkJ024646
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 23:43:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6D3hwGL175406
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 21:43:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6D3hwcr028175
	for <kexec@lists.infradead.org>; Thu, 12 Jul 2007 21:43:58 -0600
Date: Fri, 13 Jul 2007 09:13:58 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070713034358.GA4975@in.ibm.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070710064817.GC5471@in.ibm.com>
	<20070710120904.GB10121@hmsendeavour.rdu.redhat.com>
	<20070710165201.GA7984@localdomain>
	<20070711060726.GA5310@in.ibm.com>
	<20070711073216.GA11757@localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070711073216.GA11757@localdomain>
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
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Wed, Jul 11, 2007 at 10:32:16AM +0300, Dan Aloni wrote:
[..]
> > This implementation looks interesting. No need of debug compiled
> > vmlinux for dump filtering purposes. No run time vmlinux binary modifications
> > as suggested by your previous mails. People can export kernel CONFIG info
> > like PAGESIZE etc with the help of this ELF note and any tool which is
> > processing kernel core file can benifit from this. No guesses required for
> > determining the page size of crashed kernel.
> > 
> > All the info required by dump filtering tool, put it into an ELF note, 
> > pass it to second kernel which appends it to final vmcore. The only concern
> > here again is that type of ELF note is not standard. The contents of 
> > ELF notes will keep on changing over a period of time. For example if a 
> > new memory model evolves. Now everytime this note data changes one shall
> > have to update mkdumpfile and user shall have to newer version. If there
> > are any issues, user will not come to know about the issue during kdump
> > service enablement time, instead it will be detected during dump 
> > capture time. It is too late till then.
> 
> I guess that dump filtering will needed to be tested at least once 
> under various platforms for every major release of the kernel to see 
> if the information exported by the kernel through this elf note is 
> still sufficient. 
> 
> Adding more info to this elf note as needed can be done through a simple 
> patch to the kernel and it can be tested along with mkdumpfile changes 
> even before a major version gets released.
> 
> More things to consider:
> 
>  * Elf note size is currently limited to 1024, we might need a bit more
>    (currently this elf note is in the 900-area).

How about putting all the required info in a structure and then do
sizeof(struct) and reserve that much of memory at compile time for the
note. This will mean there are no hardcodings about the size of the note.

But I guess, one shall have to keep user space kexec-tools in sync to
create a PT_NOTE for that. May be exporting this info in header files to
user space might help.

>  * If we move the generation of the elf note to the boot time instead 
>    of crash time as you suggested, we can also make it viewable as a 
>    virtual file.

That would make sense. In that case, makedumpfile can do some verification
on the exported data and scream if something is not right at kdump service
start time.

>  * We should come up with a standard name for the note (LINUX, or 
>    LINUX-VMCORE, etc).
> 

How about VMCOREINFO?

> > I think we can make OSRELEASE info into a separate ELF note. Something
> > like a note type "UTS_RELEASE". This ELF note type then can also be 
> > reused for appending an ELF note to vmlinux to determine the kernel
> > version.
> 
> Agreed.
> 
> Actually, having a UTS_RELEASE note attached to vmlinux itself is quite 
> easy to implement. All we need is some .s file in the kernel doing 
> something similar to this (inspired by some post made by Ulrich Drepper):
> 
> #include <linux/utsrelease.h>
> 
> 	.section ".note.UTS_RELEASE", "a"
> 	.align 4
> 	.long 1f - 0f		/* name length */
> 	.long 3f - 2f		/* data length */
> 	.long  1		/* note type */
> 0:	.asciz "UTS_RELEASE"	/* uts release */
> 1:	.align 4	
> 2:	.asciz UTS_RELEASE     	/* note data */
> 3:	.align 4		/* pad out section */
> 
> > We don't have to save this info in ELF note format after the crash. This
> > info gets fixed once kernel is booted. I think we should save it in some
> > init routine and not in crash_kexec().
> 
> Agreed.
> 
> > > +extern unsigned char mkdfinfo_data[MAX_NOTE_BYTES];
> > > +extern unsigned int mkdfinfo_size;
> > > +extern unsigned int mkdfinfo_max_size;
> > > +extern note_buf_t mkdfinfo_note;
> > 
> > mkdfinfo does not seem to be very appropriate name. We probably need to have a
> > better name. This all seems to be debug data (symbol info, structure size,
> > offsets of struct members) so how about "debuginfo"?
> 
> 'debuginfo' can be confused with the more standard DWARF debuginfo. 
> How about vmcoreinfo, dumpinfo, debugaux, debugauxinfo, or 
> dumpauxinfo?
> 

To me vmcoreinfo looks like a good name to begin with. As of today vmcore
is the only consumer of the info. We might have to migrate to a more generic
name down the line if consumers of the info pop-up.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
