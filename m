Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound.mse2.exchange.ms ([69.25.50.247]
	helo=mse2fe1.mse2.exchange.ms)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JmeHm-00006F-Hl
	for kexec@lists.infradead.org; Fri, 18 Apr 2008 00:17:02 +0000
Message-ID: <4807E877.8000404@bluelane.com>
Date: Thu, 17 Apr 2008 17:16:55 -0700
From: Piet Delaney <pdelaney@bluelane.com>
MIME-Version: 1.0
Subject: Accessing Thread Information in kernel crash dumps with ddd+gdb
Reply-To: pdelaney@bluelane.com
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
To: Alexander Nyberg <alexn@telia.com>, V Srivatsa <vatsa@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>
Cc: Bernhard Kaindl <bk@suse.de>, Andrew Morton <akpm@osdl.org>, Castor Fu <Castor.Fu@3PAR.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Milind Dumbare <jhumo2002@yahoo.com>, "Amit S. Kale" <amitkale@linsyssoft.com>, kexec@lists.infradead.org, Andrew Cagney <ac131313@cygnus.com>, Bernhard Walle <bwalle@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jason Wessel <jason.wessel@windriver.com>, Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>, Joel Brobecker <brobecker@adacore.com>, Daniel Jacobowitz <drow@false.org>

Hey Guys:

I've been using kgdb for a while with our 2.6.12 and now 2.6.16 kernel
as well as kdump/kexec with our 2.6.16 kernel. I'm a bit disappointed
with the visibility of local variables on the threads/tasks not currently
running on CPUs. Both crash, and the gdb macros that you guys wrote,
show the most important stuff but I'd prefer to be able to see everything
with gdb/ddd as I can with kgdb; including all local variables and formal
parameters at each stack frame.

A long time ago I used gdb on SunOS 4.1.4 and use to simply set $fp
and $sp from the saved information in the U-block to view a process.
I wish gdb would allow be to run your macros, btt for example, and extract
the stackp from task.thread.esp assign it temporally to $sp for the 
current task,
do the backtrace command and see everything. Changing $sp and $fp for a 
while
like I use to do with gdb on SunOS 4.1.4 and then using ddd+gdb to 
browse the
stack formals and locals would be nice. Just doing a 'set write on' 
isn't sufficient,
gdb wants a process and I can't see to satisfy it with simply setting 
the current
thread.

I was wondering if any of you guys have been thinking of anything like this
and had and hacks or ideas on how to see the locals and formals for all 
tasks.

One thought I had was a minor hack of the kexec code to do something 
like your gdb macros
and walk thru the task list and then append a ELF Notes, like done by 
crash_save_this_cpu(),
for each task. I have no idea if gdb has a limit on the number of 
elf_prstatus structures
that can be provided. I suppose I'd leave it a KEXEC config variable to 
enable this, as
some would argue that it's not as save as simply saving the regs for the 
active CPUs.
This would leave 'info threads' with gdb similar to 'ps' with crash and 
virtually identical
to the experience with kgdb.

-piet

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
