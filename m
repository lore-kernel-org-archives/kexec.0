Return-path: <kexec-bounces@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IcLN5-0007OL-4O
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 14:31:41 +0100
Message-ID: <4700F79F.5080502@redhat.com>
Date: Mon, 01 Oct 2007 09:35:27 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org> <46FD03CD.9060404@windriver.com>
	<sjmve9uj3d2.fsf@pgpdev.ihtfp.org> <46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
	<sjm641uid1x.fsf@pgpdev.ihtfp.org>
	<m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
	<20070930053813.GC16593@in.ibm.com>
In-Reply-To: <20070930053813.GC16593@in.ibm.com>
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
To: vgoyal@in.ibm.com
Cc: Derek Atkins <warlord@MIT.EDU>, kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

Vivek Goyal wrote:
> On Fri, Sep 28, 2007 at 05:40:33PM -0600, Eric W. Biederman wrote:
> 
>>Derek Atkins <warlord@MIT.EDU> writes:
>>
>>
>>>Well, gdb agrees with System.map, so I'm sure that gdb itself is
>>>okay.  It's certainly possible that that the kgdb stub is weird,
>>>but /proc/kallsyms doesn't match System.map, and THAT'S what's
>>>confusing me most of all.
>>
>>Ok.  So we must have a relocatable kernel that figures it has been
>>relocated.  Interesting.  
>>
>>What is your bootloader?
>>What is your kernel version?
>>What is your kernel config?
>>
>>The only time I would expect to see what you are seeing is if
>>you are debugging the kdump kernel, which doesn't sound like
>>the case.
>>
>>If we actually have a truly offset kernel then while things
>>may not be perfect this is at least expected.  I don't think
>>I have heard of anyone handling this case very well.
>>
> 
> 
> Hi Eric and others,
> 
> I think we might be running into the issues because i386, FC7 relocatable
> kernel has been compiled for 16MB physical address but effectively it
> runs at 4MB physical address. So kernel does not run at compiled address
> and any kind of debugging tools reading symbol address from System.map
> or rom vmlinux will fail as run time symbol addresses are different.
> 
> /proc/kallsyms should help though. This is one problem with shift in run
> time virtual address while relocating the kernel. We should be running kernel
> at compiled address to be able to debug it. Or enable any tools to parse
> /proc/kallsyms to read the shift in symbol addresses and adjust accordingly.
> 
> Thanks
> Vivek

Right, crash was updated in version 4.0-4.5 to allow the use
of /proc/kallsyms as an alternative to the System.map file,
as well as adding a new --reloc command line argument.  After
bringing up the vmlinux file in gdb (with the "wrong" addresses),
all of the minimal_symbol data structures in the gdb module are
back-patched with the /proc/kallsyms values:

  http://people.redhat.com/anderson/crash.changelog.html#4_0_4_5

It seems the benefit of configuring the kernel that way is debatable,
and I will do all I can to convince the RHEL-6 and beyond kernel
maintainers from doing it that way in the future.  But Fedora goes
its own way.  Seems totally lame to issue a bogus System.map file
though...

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
