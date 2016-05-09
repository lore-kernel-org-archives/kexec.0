Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x229.google.com ([2607:f8b0:400e:c03::229])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aznIt-0006iv-Al
 for kexec@lists.infradead.org; Mon, 09 May 2016 15:41:04 +0000
Received: by mail-pa0-x229.google.com with SMTP id r5so75704286pag.1
 for <kexec@lists.infradead.org>; Mon, 09 May 2016 08:40:42 -0700 (PDT)
Subject: Re: [PATCH] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
References: <1456408291-29559-1-git-send-email-minyard@acm.org>
 <5720AEDC.3080409@acm.org> <20160509051724.GA2460@x1.redhat.com>
 <57307E53.4060300@acm.org> <20160509142953.GA2978@x1>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <5730AF76.3000608@mvista.com>
Date: Mon, 9 May 2016 10:40:38 -0500
MIME-Version: 1.0
In-Reply-To: <20160509142953.GA2978@x1>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On 05/09/2016 09:29 AM, Baoquan He wrote:
> On 05/09/16 at 07:10am, Corey Minyard wrote:
>> On 05/09/2016 12:18 AM, Baoquan He wrote:
>>> Hi Corey,
>>>
>>> I am trying to review this patch now, and these fixes contained are very
>>> great. Just several concerns are added in inline comment.
>>>
>>> By the way, did you run this in your side?
>> Yes, I tested on x86, x86_64, ARM and MIPS.
>>
>> Comments inline...
> That's awesome. I will have a try too.
>
>>>>> diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
>>>>> index 9b9b454..e5bbd8d 100644
>>>>> --- a/Documentation/kdump/gdbmacros.txt
>>>>> +++ b/Documentation/kdump/gdbmacros.txt
>>>>> @@ -15,14 +15,14 @@
>>>>>   define bttnobp
>>>>>   	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
>>>>> -	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
>>>>> +	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
>>> This is a quite nice fix.
>>>
>>>>>   	set $init_t=&init_task
>>>>>   	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
>>>>>   	while ($next_t != $init_t)
>>>>>   		set $next_t=(struct task_struct *)$next_t
>>>>>   		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
>>>>>   		printf "===================\n"
>>>>> -		set var $stackp = $next_t.thread.esp
>>>>> +		set var $stackp = $next_t.thread.sp
>>>>>   		set var $stack_top = ($stackp & ~4095) + 4096
> Missed one place here. Currently the kernel stack is decided by
> THREAD_SIZE since the definition:
>
> union thread_union {
>          struct thread_info thread_info;
>          unsigned long stack[THREAD_SIZE/sizeof(long)];
> };
>
> Should we get the top and bottom of stack according to this now?
>
> Correct me if I was wrong.

I think you are correct.  We should use something like:

    set var $stack_top = ($stackp & ~(sizeof(thread_union) - 1)) +
    sizeof(thread_union)

Is this what you are suggesting?

-corey

>
> Thanks
> Baoquan
>
>>>>>   		while ($stackp < $stack_top)
>>>>> @@ -31,12 +31,12 @@ define bttnobp
>>>>>   			end
>>>>>   			set $stackp += 4
>>>>>   		end


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
