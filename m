Return-path: <kexec-bounces@lists.infradead.org>
Received: from mail0.lsil.com ([147.145.40.20])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IcMUJ-0008Mj-8B
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 15:43:15 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: kdump info request
Date: Mon, 1 Oct 2007 08:35:28 -0600
Message-ID: <9738BCBE884FDB42801FAD8A7769C26501B7F450@NAMAIL1.ad.lsil.com>
In-Reply-To: <20070922113553.6898978d.rdunlap@xenotime.net>
References: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com><20070919035337.GA7068@in.ibm.com><9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com><20070919042840.GB7068@in.ibm.com><9738BCBE884FDB42801FAD8A7769C26501B2C4DA@NAMAIL1.ad.lsil.com><20070921041506.GB6156@in.ibm.com><9738BCBE884FDB42801FAD8A7769C26501B2C8D3@NAMAIL1.ad.lsil.com>
	<20070922113553.6898978d.rdunlap@xenotime.net>
From: "Mukker, Atul" <Atul.Mukker@lsi.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, vgoyal@in.ibm.com, "Moore,
	Eric" <Eric.Moore@lsi.com>

Hello Randy,

I tried this today but did not succeed :-( Can you please see the logs
appended below and point out what I might be doing wrong? This is on a
Red Hat 5 system.

Thanks
-Atul

+++++++++++
Sample code
+++++++++++
#include <linux/init.h>
#include <linux/version.h>
#include <linux/module.h>

MODULE_AUTHOR("LSI Corporation");
MODULE_VERSION("1.0");
MODULE_DESCRIPTION("Kernel Command Line");
MODULE_LICENSE("GPL");

static int __init cline_init(void)
{
	printk("enter module:[%s]\n", saved_command_line);
	return 0;
}

static void __exit cline_exit(void)
{
	printk("exit module.\n");
}

module_init(cline_init);
module_exit(cline_exit);

++++++++
Makefile
++++++++
obj-m	+= cline.o

+++++++++
Build log
+++++++++

make: Entering directory `/usr/src/kernels/2.6.18-8.el5-i686'
  LD
/usr/src/kernels/2.6.18-8.el5-i686/drivers/scsi/cline/built-in.o
  CC [M]  /usr/src/kernels/2.6.18-8.el5-i686/drivers/scsi/cline/cline.o
  Building modules, stage 2.
  MODPOST
WARNING: "saved_command_line"
[/usr/src/kernels/2.6.18-8.el5-i686/drivers/scsi/cline/cline.ko]
undefined!
  CC
/usr/src/kernels/2.6.18-8.el5-i686/drivers/scsi/cline/cline.mod.o
  LD [M]  /usr/src/kernels/2.6.18-8.el5-i686/drivers/scsi/cline/cline.ko
make: Leaving directory `/usr/src/kernels/2.6.18-8.el5-i686'


-----Original Message-----
From: Randy Dunlap [mailto:rdunlap@xenotime.net] 
Sent: Saturday, September 22, 2007 2:36 PM
To: Mukker, Atul
Cc: vgoyal@in.ibm.com; Moore, Eric; Kexec Mailing List
Subject: Re: kdump info request

On Fri, 21 Sep 2007 06:48:01 -0600 Mukker, Atul wrote:

> One more question, and hopefully I will not bug you further on this
:-)
> 
> How exactly do you parse the kernel parameters? I thought it would be
> plain simple, but seems like the command line string is not available
to
> SCSI driver like ours, or I am missing something?

#include <linux/init.h>  // for extern of 'saved_command_line' pointer.

and use calls to any functions in lib/cmdline.c or write your
own functions.  Should be fairly simple to scan for a fixed string
of "elfcorehdr=".
You don't care about the variable parameters.. or do you?


> Thanks
> -Atul 
> 
> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@in.ibm.com] 
> Sent: Friday, September 21, 2007 12:15 AM
> To: Mukker, Atul
> Cc: Kexec Mailing List; Moore, Eric
> Subject: Re: kdump info request
> 
> On Wed, Sep 19, 2007 at 07:26:19AM -0600, Mukker, Atul wrote:
> [..]
> > > 
> > > If we could somehow determine that we are being called in context
of
> > capture kernel, we can dynamically lower driver memory requirement
(at
> > cost of lower IO throughout of-course, which is ok for this brief
> > context).
> > 
> > You can parse the command line and look for presence of elfcorehdr=
> > option.
> > This is internally appended to command line by kexec tools to tell
> > capture
> > kernel the address of ELF core headers.
> > 
> > 
> > [AM] Is this a standard way? Doesn't look like one. According to
> > kernel-parameters.txt, kexec would "generally" pass this option to
> > kernel command line. Can we look at "struct resource crashk_res" and
> > check if start and end member have different value, which indicates
> > capture kernel?
> > 
> 
> Well, nobody else so far has had such requirements so can't say if
this
> is standard way. But this is the best way I can think of so far.
> 
> Using crashk_res will not work. Not all users will use kdump and will
> not
> reserve any memory for capture kernel. In that case crashk_res will be

> zero for start and end and you don't want to trim down the
functionality
> of your driver.
> 
> > What's the memory allocation requirement of current RAID driver? How
> > much
> > memory you are reserving for capture kernel? Are you already seeing
> the
> > memory allocation failure?
> > 
> > [AM] Our normal runtime memory is about 20MB. For the test beds, we
> use
> > "crashkernel=192M@16M". We have not yet seen the allocation failure
> but
> > we would like to build the fallback mechanism if it does fail under
> > capture kernel. Only if we are not able to get the normal runtime
> > memory, we plan to switch to a lower memory model.
> > 
> 
> 20MB is huge. I agree that it is a good idea to bring it down for
> capture
> kernel if performance is not significantly impacted.
> 
> > I feel until and unless memory requirements are huge, we should not
> > compromise with IO throughput. Capability to save the dump to disk
as
> > fast
> > as possible to reduce the down time is also an important
> consideration.
> > 
> > [AM] We believe our normal runtime memory requirement is
significant.
> > Also, even with the lower memory, there would not be a noticeable
dump
> > time difference since lot of memory is for supporting multiple
> > outstanding commands in driver's raid core and other raid
operations,
> > which will not be running under capture kernel. Thanks again for
your
> > feedback.
> > 
> 
> Makes sense.
> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code
***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
