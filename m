Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YL6FO-0003Rz-Qm
 for kexec@lists.infradead.org; Tue, 10 Feb 2015 08:32:43 +0000
Message-ID: <54D9C211.8010000@hitachi.com>
Date: Tue, 10 Feb 2015 17:32:17 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
References: <20150205.175943.381586636.d.hatayama@jp.fujitsu.com>
 <20150209024030.GA1847@dhcp-16-105.nay.redhat.com>
 <20150209.122204.284539162.d.hatayama@jp.fujitsu.com>
 <20150209032914.GB1847@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20150209032914.GB1847@dhcp-16-105.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, masami.hiramatsu.pt@hitachi.com, vgoyal@redhat.com

Hello,

(2015/02/09 12:29), Baoquan He wrote:> On 02/09/15 at 12:22pm, HATAYAMA Daisuke wrote:
>> From: Baoquan He <bhe@redhat.com>
>>> On 02/05/15 at 05:59pm, HATAYAMA Daisuke wrote:
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index 9a8a01a..0ecf252 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -84,6 +84,8 @@ struct resource crashk_low_res = {
>>>>  
>>>>  int kexec_should_crash(struct task_struct *p)
>>>>  {
>>>> +	if (crash_kexec_post_notifiers)
>>>> +		return 0;
>>>>  	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
>>>>  		return 1;
>>>
>>> What if these two conditions !p->pid || is_global_init(p) are satisfied?
>>> Seems the behavious is changed.
>>>
>>
>> Please further follow do_exit() path. For each condition, there are
>> the corresponding panic() calls. In summary:
>>
>>   oops_end
>>     1) panic() for in_interrupt()
>>     2) panic() for panic_on_oops
>>     do_exit
>>       3) panic() for !p->pid (idle task)
>>       exit_notify
>>         forget_original_parent
>>           find_child_reaper
>>             4) panic() for p->pid == 1 (init task)
> 
> Yes, all conditions have been covered.
> 
> So this patch is necessary, ACK it. Thanks
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for the patch!
I tested it in following cases on x86_64 and it worked well;
my panic notifier was called, then 2nd kernel booted.

- Null pointer dereference in each context of
  - hard IRQ
  - pid == 0
  - pid == 1
  - others with panic_on_oops=1
- Zero-divide in the context of normal process
  (panic_on_oops=1)

Tested-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>

-- 
Hidehiro Kawai
Hitachi, Yokohama Research Laboratory



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
