Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JnRJO-0007UA-8a
	for kexec@lists.infradead.org; Sun, 20 Apr 2008 04:37:58 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <4807E877.8000404@bluelane.com> <20080418141028.GB1983@redhat.com>
	<4808FF6C.7040604@bluelane.com>
Date: Sat, 19 Apr 2008 21:37:35 -0700
In-Reply-To: <4808FF6C.7040604@bluelane.com> (Piet Delaney's message of "Fri, 
	18 Apr 2008 13:07:08 -0700")
Message-ID: <m1prslrvjk.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Accessing Thread Information in kernel crash dumps with ddd+gdb
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pdelaney@bluelane.com
Cc: Bernhard Kaindl <bk@suse.de>, Andrew Morton <akpm@osdl.org>, V Srivatsa <vatsa@in.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Milind Dumbare <jhumo2002@yahoo.com>, "Amit S. Kale" <amitkale@linsyssoft.com>, Jason Wessel <jason.wessel@windriver.com>, kexec@lists.infradead.org, Andrew Cagney <ac131313@cygnus.com>, Bernhard Walle <bwalle@suse.de>, George Anzinger <george@mvista.com>, Randy Dunlap <rdunlap@xenotime.net>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Joel Brobecker <brobecker@adacore.com>, Ingo Molnar <mingo@elte.hu>, Maneesh Soni <maneesh@in.ibm.com>, Castor Fu <Castor.Fu@3PAR.com>, Alexander Nyberg <alexn@telia.com>, Vivek Goyal <vgoyal@redhat.com>, Daniel Jacobowitz <drow@false.org>

Piet Delaney <pdelaney@bluelane.com> writes:

> I agree it's not 100% safe, but for many developers it's a risk
> worth taking. For example we make a lot of changes in the
> TCP/IP stack for implementing a proxy for filtering network
> traffic. Virtually all bugs are ones we make in the networking
> code and having a precise view of each stack would be helpful.
> It's extremely unlikely that the task structures have been whacked
> in our case; and likely for many other developers.

Kernel crash dumps in development?
Relying on debuggers in kernel development?

There is something that smells horribly like the debug it until
it works version of code development instead of stopping and
understanding what the code does.

> How about reserving memory with each task structure for the
> ELF notes? 

Doesn't fly we need to know where the memory is before the kernel
crashes.  You have just required the task list walker you are
trying to avoid be present to gather up your ELF notes.  If you
need the walker anyway there is no point in generating the notes
a priori.

> With Solaris I reserved a page for each CPU to be
> able to store the register windows during a stack overflow so
> I could map it in during the stack overflow. It's not unreasonable
> to allocate the space with the task; especially if it's a kernel
> config option. If no one used it we could remove it and go for
> an alternate approach.

In some sense we have already been where you are suggesting.  Having
a nice crash dump facility in the kernel proved to fail to capture
crash dumps in real world failure scenarios.

>     I think following can be a way forward for your requirement.
>
>     - Either gdb should provide a SunOS kind of facility where one can
>       provide stack pointer and switch the task context. ( I don't know
>       if there is already a way to do that).
>
>
>
> I'll talk on the gdb mailing list about it. Perhaps we could
> initially get it in as a developer maintance function to allow
> the registers to be changed for a thread in a core dump.
>
>
>     - Or one can write a user space tool, which parses original vmcore,
>       walks through task list, prepare elf notes for all the tasks and emit
>       a new vmcore which is fetched to gdb.
>
>
>
> Sounds difficult. I was talking to Dave Anderson about having
> crash provide task info to his embedded gdb process but he
> wasn't supportive of that approach.
>
> Having a peace of code that has to walk thru the task list and
> modify the elf notes seems a lot harder than just having the kernel
> do it. More code that has to be maintained. 

Totally Wrong.

It is critical that the kexec on panic code path remains as small
as possible to maintain reliability.

Doing just about anything elsewhere is less work then on that code
path because we need to assume just about any part of the kernel
is busted and wrong.

Further there is no significant benefit (except possibly the code being
more visible to kernel developers) to doing the work in the kernel.
If that is a real concern placing a debug utility in the kernel source
that finds the task list and walks it should provide the same benefit.

Debuggers do have perfect information about the structure layouts,
as normal dwarf2 debugging information can record it.

So forget the notion of doing this on the kexec on panic code path
and see if you can make one of one of Vivek's ideas fly.  If nothing
is busted walking the task list is just a stupid linked list walk
easy, and not at all fatal if you get it wrong in user space, and
easy to fix.  A mysterious failure that takes weeks of work if you
are not perfectly paranoid in the kexec on panic code path.


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
