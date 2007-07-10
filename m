Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8HCp-00024u-Dr
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 11:00:49 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6ADuvjq021546
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 09:56:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AF0ePp520522
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 11:00:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AF0dsh012086
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 11:00:39 -0400
Date: Tue, 10 Jul 2007 20:30:37 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710150037.GB10216@in.ibm.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070709092154.GA19705@suse.de>
	<20070709114131.GA18750@localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070709114131.GA18750@localdomain>
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
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Mon, Jul 09, 2007 at 02:41:31PM +0300, Dan Aloni wrote:
> 
> I don't think it would add much complexity to build process as it 
> is now, just like the other tools that transparently do post-linking 
> modifications. As far as the developer is concerned, there's just
> the vmlinux and/or bzImage files that get emitted at the end.
> 
> > > Then inside initramfs of the first kernel, a small 
> > > util will modify the vmlinux file of the kdump kernel before it
> > > gets loaded so that another special file appearing as 
> > > /proc/vmcore.info under the kdump kernel will present the same
> > > info. 
> > 
> > Where do you get the info from? If you're in the kdump initrd,
> > then the kdump kernel is already loaded. Do you want to attach the
> > info from the crashed kernel to the initrd of the kdump kernel?
> 
> Not exactly. Let me describe the procedure in greater detail.
> Basically, it would go like this:
> 
> 1. <normal bootloader boot>
> 2. <normal initramfs>
> 3. embed_configfile /proc/kcore.info /vmlinux-kdump
> 4. kexec -l vmlinux-kdump <....>
> 5. <boot continues>
> 6. <crash>
> 7. <kdump kernel boot>
> 8. <kdump initramfs runs>
> 9. makedumpfile -i /proc/vmcore.info <....>
> 
> NOTES:
> ** in step 3 embed_configfile modifies vmlinux-kdump in place, 
>    copying /proc/kcore.info into the data section of the vmlinux-kdump 
>    at certain symbol (e.g. 'char core_info[0x1000]').
> ** in step 9 that data section variable (e.g. core_info) which was 
>    originally holds the content of /proc/kcore.info is being presented 
>    as /proc/vmcore.info for the util to use.
> 
> To complete the picture, at the final build stage of vmlinux we 
> would have this:
> 
> makedumpfile -g vmlinux.configfile -x vmlinuxx
> embed_configfile vmlinux.configfile vmlinux
> rm vmlinux.configfile
> 

Are you planning to move makedumpfile utility in kernel source three then
for this command to run? Output of "makedumpfile -g" is pretty non-standard
and very customized for filtering. At the same time, this will only work
if first kernel was compiled with debug info. (I think makedumpfile
retrieves all the structure member offset info from .debuginfo seciton).

I am still thinking that why can't we change initrd building process
(Be it mkinitrd or mkdumprd depending on distriution). Whole idea is
that while building an initrd/initramfs for the first kernel, one will
ask user for kdump kernel (if user wishes to load kdump kenrel through
initrd) and then it will generate kdump kenrel's initrd and pack into
first kernel's initrd.

So steps would look something like this.

- mkinitrd takes second kernel's vmlinux as argument
- mkinitrd runs "makedumpfile -g" on debug version of first kernel's vmlinux.
- mkinitrd generates the initramfs for kdump kernel and packs output
  of "makedumpfile -g" into that.
- mkinitrd packs statically linked kexec, kdump kernel vmlinux/bzImage,
  and kdump kernel initramfs into first kernel's initramfs.

This will save us from doing any changes to kernel build process and
also avoid any run time updation of vmlinux code. Exporting a particular
non-standard output through proc interfaces does not seem to be a very good
idea (/proc/kcore.info or /proc/vmcore.info)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
