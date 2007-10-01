Return-path: <kexec-bounces@lists.infradead.org>
Received: from mail.ihtfp.org ([204.107.200.6])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IcQG3-00032E-6H
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 19:44:46 +0100
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>
	<46FD03CD.9060404@windriver.com> <sjmve9uj3d2.fsf@pgpdev.ihtfp.org>
	<46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
	<sjm641uid1x.fsf@pgpdev.ihtfp.org>
	<m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
	<20070930053813.GC16593@in.ibm.com> <4700F79F.5080502@redhat.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: Mon, 01 Oct 2007 14:44:06 -0400
In-Reply-To: <4700F79F.5080502@redhat.com> (Dave Anderson's message of "Mon\,
	01 Oct 2007 09\:35\:27 -0400")
Message-ID: <sjmve9qekug.fsf@pgpdev.ihtfp.org>
MIME-Version: 1.0
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
To: Dave Anderson <anderson@redhat.com>
Cc: kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

Dave Anderson <anderson@redhat.com> writes:

>> Hi Eric and others,
>>
>> I think we might be running into the issues because i386, FC7 relocatable
>> kernel has been compiled for 16MB physical address but effectively it
>> runs at 4MB physical address. So kernel does not run at compiled address
>> and any kind of debugging tools reading symbol address from System.map
>> or rom vmlinux will fail as run time symbol addresses are different.
>>
>> /proc/kallsyms should help though. This is one problem with shift in run
>> time virtual address while relocating the kernel. We should be running kernel
>> at compiled address to be able to debug it. Or enable any tools to parse
>> /proc/kallsyms to read the shift in symbol addresses and adjust accordingly.
>>
>> Thanks
>> Vivek
>
> Right, crash was updated in version 4.0-4.5 to allow the use
> of /proc/kallsyms as an alternative to the System.map file,
> as well as adding a new --reloc command line argument.  After
> bringing up the vmlinux file in gdb (with the "wrong" addresses),
> all of the minimal_symbol data structures in the gdb module are
> back-patched with the /proc/kallsyms values:
>
>  http://people.redhat.com/anderson/crash.changelog.html#4_0_4_5
>
> It seems the benefit of configuring the kernel that way is debatable,
> and I will do all I can to convince the RHEL-6 and beyond kernel
> maintainers from doing it that way in the future.  But Fedora goes
> its own way.  Seems totally lame to issue a bogus System.map file
> though...

Well, this is kgdb, so "/proc/kallsyms" is on the target machine,
not the host machine.  So, 'gdb' cannot read /proc/kallsyms, because,
well, it's not local.

However, I AM building my own kernel -- so I can certainly reconfigure
it as necessary.  What do I need to do to reconfigure my kernel to
run at the same place it was built for?  I.e., what's changing the
runtime from 16M to 4M and how do I make it consistent?

Thanks!

> Dave

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
