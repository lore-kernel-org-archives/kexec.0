Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8VMK-00031q-At
	for kexec@lists.infradead.org; Wed, 11 Jul 2007 02:07:34 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6B53afJ002570
	for <kexec@lists.infradead.org>; Wed, 11 Jul 2007 01:03:36 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6B67Knu166164
	for <kexec@lists.infradead.org>; Wed, 11 Jul 2007 02:07:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6B67KOM011982
	for <kexec@lists.infradead.org>; Wed, 11 Jul 2007 02:07:20 -0400
Date: Wed, 11 Jul 2007 11:37:26 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070711060726.GA5310@in.ibm.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070710064817.GC5471@in.ibm.com>
	<20070710120904.GB10121@hmsendeavour.rdu.redhat.com>
	<20070710165201.GA7984@localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710165201.GA7984@localdomain>
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

On Tue, Jul 10, 2007 at 07:52:01PM +0300, Dan Aloni wrote:
> On Tue, Jul 10, 2007 at 08:09:04AM -0400, Neil Horman wrote:
> > On Tue, Jul 10, 2007 at 12:18:17PM +0530, Vivek Goyal wrote:
> > > On Fri, Jul 06, 2007 at 05:58:04PM +0300, Dan Aloni wrote:
> > > > On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> > > > > Hello,
> [...]
> > > > It contains enough information in order to make a compact kernel
> > > > dump (makedumpinfo needs to go over the struct page arrays). As
> > > > you see, it also contains the kernel version.
> > > > 
> > > 
> > > But this will not solve Bernhard's problem where looking at a vmcore
> > > he wants to know which vmlinux (kernel version with time stamp) has
> > > generated this vmcore. So adding a ELF NOTE should help.
> > > 
> > I think an ELF note would be a fine idea.
> 
> Okay, so here's an implemenation.
> 
> See the attached proof-of-concept patches to the kernel-side kexec and 
> kexec-tools (might need some cleanup though). Next to follow, a patch 
> to makedumpfile. With these patches a new "LINUX" elf note generated 
> by the kernel in the format that makedumpfile expects and is being 
> passed on by the kexec util to the kdump kernel.
> 
> As a bonus, with this patch you don't even have to compile the kernel 
> with debug information in order for the filtering to work.
> 

This implementation looks interesting. No need of debug compiled
vmlinux for dump filtering purposes. No run time vmlinux binary modifications
as suggested by your previous mails. People can export kernel CONFIG info
like PAGESIZE etc with the help of this ELF note and any tool which is
processing kernel core file can benifit from this. No guesses required for
determining the page size of crashed kernel.

All the info required by dump filtering tool, put it into an ELF note, 
pass it to second kernel which appends it to final vmcore. The only concern
here again is that type of ELF note is not standard. The contents of 
ELF notes will keep on changing over a period of time. For example if a 
new memory model evolves. Now everytime this note data changes one shall
have to update mkdumpfile and user shall have to newer version. If there
are any issues, user will not come to know about the issue during kdump
service enablement time, instead it will be detected during dump 
capture time. It is too late till then.

I think we can make OSRELEASE info into a separate ELF note. Something
like a note type "UTS_RELEASE". This ELF note type then can also be 
reused for appending an ELF note to vmlinux to determine the kernel
version.
 

> As Vivek mentioned in another mail, the output of makedumpfile is not
> really a standard. However, I believe we should start making standards
> where no standard exists. :)
> 
> -- 
> Dan Aloni
> XIV LTD, http://www.xivstorage.com
> da-x (at) monatomic.org, dan (at) xiv.co.il

> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8c2c7fc..a0412ce 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -121,6 +121,8 @@ extern struct page *kimage_alloc_control_pages(struct kimage *image,
>  extern void crash_kexec(struct pt_regs *);
>  int kexec_should_crash(struct task_struct *);
>  void crash_save_cpu(struct pt_regs *regs, int cpu);
> +void crash_save_mkdfinfo(void);
> +

We don't have to save this info in ELF note format after the crash. This
info gets fixed once kernel is booted. I think we should save it in some
init routine and not in crash_kexec().

>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
> 
> @@ -153,7 +155,10 @@ extern struct kimage *kexec_crash_image;
>  extern struct resource crashk_res;
>  typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
>  extern note_buf_t *crash_notes;
> -
> +extern unsigned char mkdfinfo_data[MAX_NOTE_BYTES];
> +extern unsigned int mkdfinfo_size;
> +extern unsigned int mkdfinfo_max_size;
> +extern note_buf_t mkdfinfo_note;

mkdfinfo does not seem to be very appropriate name. We probably need to have a
better name. This all seems to be debug data (symbol info, structure size,
offsets of struct members) so how about "debuginfo"?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
