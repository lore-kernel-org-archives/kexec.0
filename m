Return-path: <kexec-bounces@lists.infradead.org>
Received: from mail.ihtfp.org ([204.107.200.6])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IcRzw-0004cS-D4
	for kexec@lists.infradead.org; Mon, 01 Oct 2007 21:36:15 +0100
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
	<sjmve9qekug.fsf@pgpdev.ihtfp.org> <4701448D.7070208@redhat.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: Mon, 01 Oct 2007 16:35:37 -0400
In-Reply-To: <4701448D.7070208@redhat.com> (Dave Anderson's message of "Mon\,
	01 Oct 2007 15\:03\:41 -0400")
Message-ID: <sjmk5q6efom.fsf@pgpdev.ihtfp.org>
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
Cc: kgdb-bugreport@lists.sourceforge.net, vgoyal@in.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jason Wessel <jason.wessel@windriver.com>

Dave,

Dave Anderson <anderson@redhat.com> writes:

> Configure the kernel with CONFIG_PHYSICAL_START less than
> or equal to CONFIG_PHYSICAL_ALIGN.  Upon rebuilding my FC7
> kernel with CONFIG_PHYSICAL_START changed from 16MB to 1MB,
> with CONFIG_PHYSICAL_ALIGN left at 4MB, i.e.:
>
>    CONFIG_PHYSICAL_START=0x100000
>    CONFIG_PHYSICAL_ALIGN=0x400000
>
> The kernel gets compiled for, and runs at, a 4MB physical address:
>
>    $ nm -Bn vmlinux | grep "^c04"
>    c0400000 T _text
>    c0400000 T startup_32
>    c0401000 T startup_32_smp
>    c0401080 t checkCPUtype
>    c0401101 t is486
>    ...
>
> Setting both of them to 0x400000 also works.

Indeed, it does.  Thank you.  Once I changed this, the new kernel
works great and the symbols map properly.  yay.   Now on to your
regularly-schedule debugging.  :)

Thank you, Dave!

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
