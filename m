Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTmgw-0001LF-HS
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 07:29:03 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C539AC07E3
 for <kexec@lists.infradead.org>; Fri,  6 Mar 2015 16:28:35 +0900 (JST)
Date: Fri, 06 Mar 2015 16:28:00 +0900 (JST)
Message-Id: <20150306.162800.178319103.d.hatayama@jp.fujitsu.com>
Subject: Re: [RESEND PATCH] kernel/panic/kexec: fix
 "crash_kexec_post_notifiers" option issue in oops path
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20150305222204.GD22336@redhat.com>
References: <20150304.175648.86711471.d.hatayama@jp.fujitsu.com>
 <20150305221930.GC22336@redhat.com>
 <20150305222204.GD22336@redhat.com>
Mime-Version: 1.0
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
To: vgoyal@redhat.com
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hidehiro.kawai.ez@hitachi.com, ebiederm@xmission.com, masami.hiramatsu.pt@hitachi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RESEND PATCH] kernel/panic/kexec: fix "crash_kexec_post_notifiers" option issue in oops path
Date: Thu, 5 Mar 2015 17:22:04 -0500

> On Thu, Mar 05, 2015 at 05:19:30PM -0500, Vivek Goyal wrote:
>> On Wed, Mar 04, 2015 at 05:56:48PM +0900, HATAYAMA Daisuke wrote:
>> > The commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45 introduced
>> > "crash_kexec_post_notifiers" kernel boot option, which toggles
>> > wheather panic() calls crash_kexec() before or after panic_notifiers
>> > and dump kmsg.
>> > 
>> > The problem is that the commit overlooks panic_on_oops kernel boot
>> > option. If it is enabled, crash_kexec() is called directly without
>> > going through panic() in oops path.
>> > 
>> > To fix this issue, this patch adds a check to
>> > "crash_kexec_post_notifiers" in the condition of kexec_should_crash().
>> > 
>> > Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> > Acked-by: Baoquan He <bhe@redhat.com>
>> > Tested-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
>> > ---
>> >  include/linux/kernel.h | 3 +++
>> >  kernel/kexec.c         | 2 ++
>> >  kernel/panic.c         | 2 +-
>> >  3 files changed, 6 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> > index 64ce58b..f47379f 100644
>> > --- a/include/linux/kernel.h
>> > +++ b/include/linux/kernel.h
>> > @@ -426,6 +426,9 @@ extern int panic_on_unrecovered_nmi;
>> >  extern int panic_on_io_nmi;
>> >  extern int panic_on_warn;
>> >  extern int sysctl_panic_on_stackoverflow;
>> > +
>> > +extern bool crash_kexec_post_notifiers;
>> > +
>> >  /*
>> >   * Only to be used by arch init code. If the user over-wrote the default
>> >   * CONFIG_PANIC_TIMEOUT, honor it.
>> > diff --git a/kernel/kexec.c b/kernel/kexec.c
>> > index 9a8a01a..0ecf252 100644
>> > --- a/kernel/kexec.c
>> > +++ b/kernel/kexec.c
>> > @@ -84,6 +84,8 @@ struct resource crashk_low_res = {
>> >  
>> >  int kexec_should_crash(struct task_struct *p)
>> >  {
>> > +	if (crash_kexec_post_notifiers)
>> > +		return 0;
>> 
>> This is little confusing. So if crash_kexec_post_notifiers is set but
>> panic_on_oops is not set, still we will return?
>> 
>> Should we do this only if panic_on_oops is set? IOW, how about following
>> 
>> 	if (panic_on_oops && crash_kexec_post_notifiers)
>> 		return 0;
>> 
>> And then also put a comment explaining the rationale.
> 
> Ok, I went through the previous version of patch and discussion there
> which says that all the 4 conditions lead to panic. So putting above
> code should be fine.
> 
> Can you please atleast put a comment here to explain it as it was not
> obvious. Just mention that all the checks below lead to panic hence
> if user wants to run panic notifiers then don't run crash_kexec() yet.
> It will be run after panic notifiers.
> 

Thanks for your reviewing.

Yes, I'll put such new comment in the patch of next version.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
