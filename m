Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound.mse2.exchange.ms ([69.25.50.247]
	helo=mse2fe1.mse2.exchange.ms)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jmxkg-0001JW-AG
	for kexec@lists.infradead.org; Fri, 18 Apr 2008 21:04:10 +0000
Message-ID: <48090CC3.20108@bluelane.com>
Date: Fri, 18 Apr 2008 14:04:03 -0700
From: Piet Delaney <pdelaney@bluelane.com>
MIME-Version: 1.0
Subject: Re: Accessing Thread Information in kernel crash dumps with ddd+gdb
References: <4807E877.8000404@bluelane.com> <20080418141028.GB1983@redhat.com>
In-Reply-To: <20080418141028.GB1983@redhat.com>
Reply-To: pdelaney@bluelane.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1256237562=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bernhard Kaindl <bk@suse.de>, Andrew Morton <akpm@osdl.org>, V Srivatsa <vatsa@in.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Milind Dumbare <jhumo2002@yahoo.com>, "Amit S. Kale" <amitkale@linsyssoft.com>, Jason Wessel <jason.wessel@windriver.com>, kexec@lists.infradead.org, Andrew Cagney <ac131313@cygnus.com>, Bernhard Walle <bwalle@suse.de>, George Anzinger <george@mvista.com>, Randy Dunlap <rdunlap@xenotime.net>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Maneesh Soni <maneesh@in.ibm.com>, Castor Fu <Castor.Fu@3PAR.com>, Alexander Nyberg <alexn@telia.com>, Joel Brobecker <brobecker@adacore.com>, Daniel Jacobowitz <drow@false.org>

This is a multi-part message in MIME format.
--===============1256237562==
Content-Type: multipart/alternative;
	boundary="------------070908020702030802000608"

This is a multi-part message in MIME format.
--------------070908020702030802000608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vivek Goyal wrote:

>On Thu, Apr 17, 2008 at 05:16:55PM -0700, Piet Delaney wrote:
>  
>

I was thinking over lunch that the largest risk to whacking
the task list might be a stack overflows. Perhaps a list of crash
notes could be maintained with the allocation/freeing of the
task structures. With the notes being so small it might not
be too bad just to allocate an array based on some configurable
maximum. Being able to dump say up to 1000 task notes would
be more that sufficient for our systems. The wasted memory
of allocating more memory than actually needed would be a
small cost to ensure well debugged kernels.

-piet

>>Hey Guys:
>>
>>I've been using kgdb for a while with our 2.6.12 and now 2.6.16 kernel
>>as well as kdump/kexec with our 2.6.16 kernel. I'm a bit disappointed
>>with the visibility of local variables on the threads/tasks not currently
>>running on CPUs. Both crash, and the gdb macros that you guys wrote,
>>show the most important stuff but I'd prefer to be able to see everything
>>with gdb/ddd as I can with kgdb; including all local variables and formal
>>parameters at each stack frame.
>>
>>A long time ago I used gdb on SunOS 4.1.4 and use to simply set $fp
>>and $sp from the saved information in the U-block to view a process.
>>I wish gdb would allow be to run your macros, btt for example, and extract
>>the stackp from task.thread.esp assign it temporally to $sp for the 
>>current task,
>>do the backtrace command and see everything. Changing $sp and $fp for a 
>>while
>>like I use to do with gdb on SunOS 4.1.4 and then using ddd+gdb to 
>>browse the
>>stack formals and locals would be nice. Just doing a 'set write on' 
>>isn't sufficient,
>>gdb wants a process and I can't see to satisfy it with simply setting 
>>the current
>>thread.
>>
>>I was wondering if any of you guys have been thinking of anything like this
>>and had and hacks or ideas on how to see the locals and formals for all 
>>tasks.
>>
>>One thought I had was a minor hack of the kexec code to do something 
>>like your gdb macros
>>and walk thru the task list and then append a ELF Notes, like done by 
>>crash_save_this_cpu(),
>>for each task. I have no idea if gdb has a limit on the number of 
>>elf_prstatus structures
>>that can be provided. I suppose I'd leave it a KEXEC config variable to 
>>enable this, as
>>some would argue that it's not as save as simply saving the regs for the 
>>active CPUs.
>>This would leave 'info threads' with gdb similar to 'ps' with crash and 
>>virtually identical
>>to the experience with kgdb.
>>    
>>
>
>IIUC, you are suggesting that we create elf notes even for non-active
>tasks in vmcore. We should not be doing that.
>
>- It is not safe to traverse through task list after system has crashed.
>- We reserve the memory for elf notes at system boot. At that time we
>  have no idea how many task system will have at the time of crash.
>
>I think following can be a way forward for your requirement.
>
>- Either gdb should provide a SunOS kind of facility where one can 
>  provide stack pointer and switch the task context. ( I don't know
>  if there is already a way to do that).
>
>- Or one can write a user space tool, which parses original vmcore,
>  walks through task list, prepare elf notes for all the tasks and emit
>  a new vmcore which is fetched to gdb.
>
>Thanks
>Vivek
>  
>


--------------070908020702030802000608
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=us-ascii" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Vivek Goyal wrote:
<blockquote cite="mid20080418141028.GB1983@redhat.com" type="cite">
  <pre wrap="">On Thu, Apr 17, 2008 at 05:16:55PM -0700, Piet Delaney wrote:
  </pre>
</blockquote>
<br>
I was thinking over lunch that the largest risk to whacking<br>
the task list might be a stack overflows. Perhaps a list of crash<br>
notes could be maintained with the allocation/freeing of the<br>
task structures. With the notes being so small it might not<br>
be too bad just to allocate an array based on some configurable<br>
maximum. Being able to dump say up to 1000 task notes would<br>
be more that sufficient for our systems. The wasted memory<br>
of allocating more memory than actually needed would be a <br>
small cost to ensure well debugged kernels.<br>
<br>
-piet<br>
<br>
<blockquote cite="mid20080418141028.GB1983@redhat.com" type="cite">
  <blockquote type="cite">
    <pre wrap="">Hey Guys:

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
    </pre>
  </blockquote>
  <pre wrap=""><!---->
IIUC, you are suggesting that we create elf notes even for non-active
tasks in vmcore. We should not be doing that.

- It is not safe to traverse through task list after system has crashed.
- We reserve the memory for elf notes at system boot. At that time we
  have no idea how many task system will have at the time of crash.

I think following can be a way forward for your requirement.

- Either gdb should provide a SunOS kind of facility where one can 
  provide stack pointer and switch the task context. ( I don't know
  if there is already a way to do that).

- Or one can write a user space tool, which parses original vmcore,
  walks through task list, prepare elf notes for all the tasks and emit
  a new vmcore which is fetched to gdb.

Thanks
Vivek
  </pre>
</blockquote>
<br>
</body>
</html>

--------------070908020702030802000608--


--===============1256237562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1256237562==--

