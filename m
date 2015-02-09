Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YKf44-0003NA-94
 for kexec@lists.infradead.org; Mon, 09 Feb 2015 03:31:13 +0000
Date: Mon, 9 Feb 2015 11:29:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
Message-ID: <20150209032914.GB1847@dhcp-16-105.nay.redhat.com>
References: <20150205.175943.381586636.d.hatayama@jp.fujitsu.com>
 <20150209024030.GA1847@dhcp-16-105.nay.redhat.com>
 <20150209.122204.284539162.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150209.122204.284539162.d.hatayama@jp.fujitsu.com>
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
Cc: masami.hiramatsu.pt@hitachi.com, kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org

On 02/09/15 at 12:22pm, HATAYAMA Daisuke wrote:
> Hello,
> 
> From: Baoquan He <bhe@redhat.com>
> Subject: Re: [PATCH] kernel/panic/kexec: fix "crash_kexec_post_notifiers" option issue in oops path
> Date: Mon, 9 Feb 2015 10:40:30 +0800
> 
> > On 02/05/15 at 05:59pm, HATAYAMA Daisuke wrote:
> >> The commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45 introduced
> >> "crash_kexec_post_notifiers" kernel boot option, which toggles
> >> wheather panic() calls crash_kexec() before or after panic_notifiers
> >> and dump kmsg.
> >> 
> >> The problem is that the commit overlooks panic_on_oops kernel boot
> >> option. If it is enabled, crash_kexec() is called directly without
> >> going through panic() in oops path.
> >> 
> >> To fix this issue, this patch adds a check to
> >> "crash_kexec_post_notifiers" in the condition of kexec_should_crash().
> >> 
> >> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> >> ---
> >>  include/linux/kernel.h | 3 +++
> >>  kernel/kexec.c         | 2 ++
> >>  kernel/panic.c         | 2 +-
> >>  3 files changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> >> index 64ce58b..f47379f 100644
> >> --- a/include/linux/kernel.h
> >> +++ b/include/linux/kernel.h
> >> @@ -426,6 +426,9 @@ extern int panic_on_unrecovered_nmi;
> >>  extern int panic_on_io_nmi;
> >>  extern int panic_on_warn;
> >>  extern int sysctl_panic_on_stackoverflow;
> >> +
> >> +extern bool crash_kexec_post_notifiers;
> >> +
> >>  /*
> >>   * Only to be used by arch init code. If the user over-wrote the default
> >>   * CONFIG_PANIC_TIMEOUT, honor it.
> >> diff --git a/kernel/kexec.c b/kernel/kexec.c
> >> index 9a8a01a..0ecf252 100644
> >> --- a/kernel/kexec.c
> >> +++ b/kernel/kexec.c
> >> @@ -84,6 +84,8 @@ struct resource crashk_low_res = {
> >>  
> >>  int kexec_should_crash(struct task_struct *p)
> >>  {
> >> +	if (crash_kexec_post_notifiers)
> >> +		return 0;
> >>  	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
> >>  		return 1;
> > 
> > What if these two conditions !p->pid || is_global_init(p) are satisfied?
> > Seems the behavious is changed.
> > 
> 
> Please further follow do_exit() path. For each condition, there are
> the corresponding panic() calls. In summary:
> 
>   oops_end
>     1) panic() for in_interrupt()
>     2) panic() for panic_on_oops
>     do_exit
>       3) panic() for !p->pid (idle task)
>       exit_notify
>         forget_original_parent
>           find_child_reaper
>             4) panic() for p->pid == 1 (init task)

Yes, all conditions have been covered.

So this patch is necessary, ACK it. Thanks

Acked-by: Baoquan He <bhe@redhat.com>



Thanks
Baoquan

> 
> --
> Thanks.
> HATAYAMA, Daisuke
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
