Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b2H4r-0001O0-TH
 for kexec@lists.infradead.org; Mon, 16 May 2016 11:52:51 +0000
Received: by mail-pf0-x241.google.com with SMTP id 145so15509791pfz.1
 for <kexec@lists.infradead.org>; Mon, 16 May 2016 04:52:29 -0700 (PDT)
Subject: Re: [PATCH v2] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
References: <1462926655-9390-1-git-send-email-minyard@acm.org>
 <20160516093249.GE7214@x1.redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <5739B478.5010205@acm.org>
Date: Mon, 16 May 2016 06:52:24 -0500
MIME-Version: 1.0
In-Reply-To: <20160516093249.GE7214@x1.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: minyard@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On 05/16/2016 04:32 AM, Baoquan He wrote:
> On 05/10/16 at 07:30pm, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Lots of little changes needed to be made to clean these up, remove the
>> four byte pointer assumption and traverse the pid queue properly.
>> Also consolidate the traceback code into a single function instead
>> of having three copies of it.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Hi Corey,
>
> Today I tried gdbmacro.txt and found dmesg doesn't work. I tested it
> on the latest 4.6.0 kernel. And I directly copy /proc/vmcore out
> and use gdb to open it by below command"
>
> gdb vmlinux /var/crash/vmcore --"gdbmacros.txt"
>
> All macro functions work well except of dmesg since code inside refer to
> the deprecated variable like "log_end" and "logged_chars". But these
> have been changed since this commit:
>
> commit 7ff9554bb578ba02166071d2d487b7fc7d860d62
> Author: Kay Sievers <kay@vrfy.org>
> Date:   Thu May 3 02:29:13 2012 +0200
>
>      printk: convert byte-buffer to variable-length record buffer
>
> So invoking dmesg will cause an error message printing out:
>
> (gdb) dmesg
> No symbol "log_end" in current context.

Yes, I was actually aware of that, but that's a different issue and I
hadn't thought about it much.

-corey

> Thanks
> Baoquan
>
>> ---
>>
>> Changes since v1:
>>
>> Rename btthreadstruct to btthreadstack
>>
>> Use sizeof(union thread_union) for the stack size instead of a hardcoded
>> 4096.
>>
>>   Documentation/kdump/gdbmacros.txt | 96 ++++++++++++++++++---------------------
>>   1 file changed, 44 insertions(+), 52 deletions(-)
>>
>> diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
>> index 9b9b454..35f6a98 100644
>> --- a/Documentation/kdump/gdbmacros.txt
>> +++ b/Documentation/kdump/gdbmacros.txt
>> @@ -15,15 +15,16 @@
>>   
>>   define bttnobp
>>   	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>> -	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
>> +	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
>>   	set $init_t=&init_task
>>   	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>> +	set var $stacksize = sizeof(union thread_union)
>>   	while ($next_t != $init_t)
>>   		set $next_t=(struct task_struct *)$next_t
>>   		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
>>   		printf "===================\n"
>> -		set var $stackp = $next_t.thread.esp
>> -		set var $stack_top = ($stackp & ~4095) + 4096
>> +		set var $stackp = $next_t.thread.sp
>> +		set var $stack_top = ($stackp & ~($stacksize - 1)) + $stacksize
>>   
>>   		while ($stackp < $stack_top)
>>   			if (*($stackp) > _stext && *($stackp) < _sinittext)
>> @@ -31,13 +32,13 @@ define bttnobp
>>   			end
>>   			set $stackp += 4
>>   		end
>> -		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
>> +		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
>>   		while ($next_th != $next_t)
>>   			set $next_th=(struct task_struct *)$next_th
>>   			printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
>>   			printf "===================\n"
>> -			set var $stackp = $next_t.thread.esp
>> -			set var $stack_top = ($stackp & ~4095) + 4096
>> +			set var $stackp = $next_t.thread.sp
>> +			set var $stack_top = ($stackp & ~($stacksize - 1)) + stacksize
>>   
>>   			while ($stackp < $stack_top)
>>   				if (*($stackp) > _stext && *($stackp) < _sinittext)
>> @@ -45,7 +46,7 @@ define bttnobp
>>   				end
>>   				set $stackp += 4
>>   			end
>> -			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
>> +			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
>>   		end
>>   		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
>>   	end
>> @@ -54,42 +55,44 @@ document bttnobp
>>   	dump all thread stack traces on a kernel compiled with !CONFIG_FRAME_POINTER
>>   end
>>   
>> +define btthreadstack
>> +	set var $pid_task = $arg0
>> +
>> +	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
>> +	printf "task struct: "
>> +	print $pid_task
>> +	printf "===================\n"
>> +	set var $stackp = $pid_task.thread.sp
>> +	set var $stacksize = sizeof(union thread_union)
>> +	set var $stack_top = ($stackp & ~($stacksize - 1)) + $stacksize
>> +	set var $stack_bot = ($stackp & ~($stacksize - 1))
>> +
>> +	set $stackp = *((unsigned long *) $stackp)
>> +	while (($stackp < $stack_top) && ($stackp > $stack_bot))
>> +		set var $addr = *(((unsigned long *) $stackp) + 1)
>> +		info symbol $addr
>> +		set $stackp = *((unsigned long *) $stackp)
>> +	end
>> +end
>> +document btthreadstack
>> +	 dump a thread stack using the given task structure pointer
>> +end
>> +
>> +
>>   define btt
>>   	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>> -	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
>> +	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
>>   	set $init_t=&init_task
>>   	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>>   	while ($next_t != $init_t)
>>   		set $next_t=(struct task_struct *)$next_t
>> -		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
>> -		printf "===================\n"
>> -		set var $stackp = $next_t.thread.esp
>> -		set var $stack_top = ($stackp & ~4095) + 4096
>> -		set var $stack_bot = ($stackp & ~4095)
>> -
>> -		set $stackp = *($stackp)
>> -		while (($stackp < $stack_top) && ($stackp > $stack_bot))
>> -			set var $addr = *($stackp + 4)
>> -			info symbol $addr
>> -			set $stackp = *($stackp)
>> -		end
>> +		btthreadstack $next_t
>>   
>> -		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
>> +		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
>>   		while ($next_th != $next_t)
>>   			set $next_th=(struct task_struct *)$next_th
>> -			printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
>> -			printf "===================\n"
>> -			set var $stackp = $next_t.thread.esp
>> -			set var $stack_top = ($stackp & ~4095) + 4096
>> -			set var $stack_bot = ($stackp & ~4095)
>> -
>> -			set $stackp = *($stackp)
>> -			while (($stackp < $stack_top) && ($stackp > $stack_bot))
>> -				set var $addr = *($stackp + 4)
>> -				info symbol $addr
>> -				set $stackp = *($stackp)
>> -			end
>> -			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
>> +			btthreadstack $next_th
>> +			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
>>   		end
>>   		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
>>   	end
>> @@ -101,7 +104,7 @@ end
>>   define btpid
>>   	set var $pid = $arg0
>>   	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>> -	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
>> +	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
>>   	set $init_t=&init_task
>>   	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>>   	set var $pid_task = 0
>> @@ -113,29 +116,18 @@ define btpid
>>   			set $pid_task = $next_t
>>   		end
>>   
>> -		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
>> +		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
>>   		while ($next_th != $next_t)
>>   			set $next_th=(struct task_struct *)$next_th
>>   			if ($next_th.pid == $pid)
>>   				set $pid_task = $next_th
>>   			end
>> -			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
>> +			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
>>   		end
>>   		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
>>   	end
>>   
>> -	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
>> -	printf "===================\n"
>> -	set var $stackp = $pid_task.thread.esp
>> -	set var $stack_top = ($stackp & ~4095) + 4096
>> -	set var $stack_bot = ($stackp & ~4095)
>> -
>> -	set $stackp = *($stackp)
>> -	while (($stackp < $stack_top) && ($stackp > $stack_bot))
>> -		set var $addr = *($stackp + 4)
>> -		info symbol $addr
>> -		set $stackp = *($stackp)
>> -	end
>> +	btthreadstack $pid_task
>>   end
>>   document btpid
>>   	backtrace of pid
>> @@ -145,7 +137,7 @@ end
>>   define trapinfo
>>   	set var $pid = $arg0
>>   	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>> -	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
>> +	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
>>   	set $init_t=&init_task
>>   	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>>   	set var $pid_task = 0
>> @@ -157,13 +149,13 @@ define trapinfo
>>   			set $pid_task = $next_t
>>   		end
>>   
>> -		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
>> +		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
>>   		while ($next_th != $next_t)
>>   			set $next_th=(struct task_struct *)$next_th
>>   			if ($next_th.pid == $pid)
>>   				set $pid_task = $next_th
>>   			end
>> -			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
>> +			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
>>   		end
>>   		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
>>   	end
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
