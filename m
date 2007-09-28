Return-path: <kexec-bounces@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IbPVv-0001sD-4z
	for kexec@lists.infradead.org; Sat, 29 Sep 2007 00:44:56 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>
	<46FD03CD.9060404@windriver.com> <sjmve9uj3d2.fsf@pgpdev.ihtfp.org>
	<46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
	<sjm641uid1x.fsf@pgpdev.ihtfp.org>
Date: Fri, 28 Sep 2007 17:40:33 -0600
In-Reply-To: <sjm641uid1x.fsf@pgpdev.ihtfp.org> (Derek Atkins's message of
	"Fri, 28 Sep 2007 19:29:46 -0400")
Message-ID: <m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
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
To: Derek Atkins <warlord@MIT.EDU>
Cc: kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

Derek Atkins <warlord@MIT.EDU> writes:

> Well, gdb agrees with System.map, so I'm sure that gdb itself is
> okay.  It's certainly possible that that the kgdb stub is weird,
> but /proc/kallsyms doesn't match System.map, and THAT'S what's
> confusing me most of all.

Ok.  So we must have a relocatable kernel that figures it has been
relocated.  Interesting.  

What is your bootloader?
What is your kernel version?
What is your kernel config?

The only time I would expect to see what you are seeing is if
you are debugging the kdump kernel, which doesn't sound like
the case.

If we actually have a truly offset kernel then while things
may not be perfect this is at least expected.  I don't think
I have heard of anyone handling this case very well.

> Which was how long ago?  ;)

Long enough ago that I don't remember when ;)

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
