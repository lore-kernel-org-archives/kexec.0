Return-path: <kexec-bounces@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IcQUb-0003H9-CA
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 19:59:47 +0100
Message-ID: <4701448D.7070208@redhat.com>
Date: Mon, 01 Oct 2007 15:03:41 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>	<46FD03CD.9060404@windriver.com>
	<sjmve9uj3d2.fsf@pgpdev.ihtfp.org>	<46FD1B6A.3000500@windriver.com>	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>	<46FD2CFB.9010404@windriver.com>
	<46FD75E1.3090602@bluelane.com>	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>	<sjm641uid1x.fsf@pgpdev.ihtfp.org>	<m11wcibbpq.fsf@ebiederm.dsl.xmission.com>	<20070930053813.GC16593@in.ibm.com>
	<4700F79F.5080502@redhat.com> <sjmve9qekug.fsf@pgpdev.ihtfp.org>
In-Reply-To: <sjmve9qekug.fsf@pgpdev.ihtfp.org>
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
To: Derek Atkins <warlord@MIT.EDU>
Cc: kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

Derek Atkins wrote:
> Dave Anderson <anderson@redhat.com> writes:
> 
> 
>>>Hi Eric and others,
>>>
>>>I think we might be running into the issues because i386, FC7 relocatable
>>>kernel has been compiled for 16MB physical address but effectively it
>>>runs at 4MB physical address. So kernel does not run at compiled address
>>>and any kind of debugging tools reading symbol address from System.map
>>>or rom vmlinux will fail as run time symbol addresses are different.
>>>
>>>/proc/kallsyms should help though. This is one problem with shift in run
>>>time virtual address while relocating the kernel. We should be running kernel
>>>at compiled address to be able to debug it. Or enable any tools to parse
>>>/proc/kallsyms to read the shift in symbol addresses and adjust accordingly.
>>>
>>>Thanks
>>>Vivek
>>
>>Right, crash was updated in version 4.0-4.5 to allow the use
>>of /proc/kallsyms as an alternative to the System.map file,
>>as well as adding a new --reloc command line argument.  After
>>bringing up the vmlinux file in gdb (with the "wrong" addresses),
>>all of the minimal_symbol data structures in the gdb module are
>>back-patched with the /proc/kallsyms values:
>>
>> http://people.redhat.com/anderson/crash.changelog.html#4_0_4_5
>>
>>It seems the benefit of configuring the kernel that way is debatable,
>>and I will do all I can to convince the RHEL-6 and beyond kernel
>>maintainers from doing it that way in the future.  But Fedora goes
>>its own way.  Seems totally lame to issue a bogus System.map file
>>though...
> 
> 
> Well, this is kgdb, so "/proc/kallsyms" is on the target machine,
> not the host machine.  So, 'gdb' cannot read /proc/kallsyms, because,
> well, it's not local.

Well, you could just grab a copy of it, although I don't know what
gdb alone would be able to do with it...

> 
> However, I AM building my own kernel -- so I can certainly reconfigure
> it as necessary.  What do I need to do to reconfigure my kernel to
> run at the same place it was built for?  I.e., what's changing the
> runtime from 16M to 4M and how do I make it consistent?
> 
> Thanks!

Configure the kernel with CONFIG_PHYSICAL_START less than
or equal to CONFIG_PHYSICAL_ALIGN.  Upon rebuilding my FC7
kernel with CONFIG_PHYSICAL_START changed from 16MB to 1MB,
with CONFIG_PHYSICAL_ALIGN left at 4MB, i.e.:

   CONFIG_PHYSICAL_START=0x100000
   CONFIG_PHYSICAL_ALIGN=0x400000

The kernel gets compiled for, and runs at, a 4MB physical address:

   $ nm -Bn vmlinux | grep "^c04"
   c0400000 T _text
   c0400000 T startup_32
   c0401000 T startup_32_smp
   c0401080 t checkCPUtype
   c0401101 t is486
   ...

Setting both of them to 0x400000 also works.

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
