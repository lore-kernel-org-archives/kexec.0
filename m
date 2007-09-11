Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUwnu-0003Mw-Ha
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 04:52:51 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8B3ruG2020828
	for <kexec@lists.infradead.org>; Mon, 10 Sep 2007 23:53:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8B3qVt8555314
	for <kexec@lists.infradead.org>; Mon, 10 Sep 2007 23:52:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8B3qUDh022731
	for <kexec@lists.infradead.org>; Mon, 10 Sep 2007 23:52:30 -0400
Date: Tue, 11 Sep 2007 09:22:50 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 0/2] vmcoreinfo support for dump filtering #2
Message-ID: <20070911035250.GA5053@in.ibm.com>
References: <20070907175746oomichi@mail.jp.nec.com>
	<20070910113521.755d0433.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070910113521.755d0433.rdunlap@xenotime.net>
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>, Dan Aloni <da-x@monatomic.org>, crash mailing list <crash-utility@redhat.com>

On Mon, Sep 10, 2007 at 11:35:21AM -0700, Randy Dunlap wrote:
> On Fri, 7 Sep 2007 17:57:46 +0900 Ken'ichi Ohmichi wrote:
> 
> > Hi,
> 
> > I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
> > I updated the patches for linux and kexec-tools.
> > 
> > PATCH SET:
> > [1/2] [linux-2.6.22] Add vmcoreinfo
> >   The patch is for linux-2.6.22.
> >   The patch adds the vmcoreinfo data. Its address and size are output
> >   to /sys/kernel/vmcoreinfo.
> > 
> > [2/2] [kexec-tools] Pass vmcoreinfo's address and size
> >   The patch is for kexec-tools-testing-20070330.
> >   (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
> >   kexec command gets the address and size of the vmcoreinfo data from
> >   /sys/kernel/vmcoreinfo, and passes them to the second kernel through
> >   ELF header of /proc/vmcore. When the second kernel is booting, the
> >   kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
> >   segment into /proc/vmcore.
> 
> Hi,
> When using the vmcoreinfo patches, what tool(s) are available for
> analyzing the vmcore (dump) file?  E.g., lkcd or crash or just gdb?
> 
> gdb works for me, but I tried to use crash (4.0-4.6 from
> http://people.redhat.com/anderson/) and crash complained:
> 
> crash: invalid kernel virtual address: 0  type: "cpu_pda entry"
> 
> Should crash work, or does it need to be modified?
> 

Hi Randy,

Crash should just work. It might broken on latest kernel. Copying it
to crash-utility mailing list. Dave will be able to tell us better.

> This is on a 2.6.23-rc3 kernel with vmcoreinfo patches and a dump file
> with -l 31 (dump level 31, omitting all possible pages).
> 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
