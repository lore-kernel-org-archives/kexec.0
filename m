Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL6zC-0006YV-JJ
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 15:47:15 +0000
Date: Wed, 23 Sep 2020 11:48:25 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200923154825.GC7635@char.us.oracle.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>, Tianyu Lani <Tianyu.Lan@microsoft.com>, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Wed, Sep 23, 2020 at 10:43:29AM +0800, Dave Young wrote:
> + more people who may care about this param 

Paarty time!!

(See below, didn't snip any comments)
> On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
> > Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
> > 
> > > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> > >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> > >> 
> > >> > crash_kexec_post_notifiers enables running various panic notifier
> > >> > before kdump kernel booting. This increases risks of kdump failure.
> > >> > It is well documented in kernel-parameters.txt. We do not suggest
> > >> > people to enable it together with kdump unless he/she is really sure.
> > >> > This is also not suggested to be enabled by default when users are
> > >> > not aware in distributions.
> > >> > 
> > >> > But unfortunately it is enabled by default in systemd, see below
> > >> > discussions in a systemd report, we can not convince systemd to change
> > >> > it:
> > >> > https://github.com/systemd/systemd/issues/16661
> > >> > 
> > >> > Actually we have got reports about kdump kernel hangs in both s390x
> > >> > and powerpcle cases caused by the systemd change,  also some x86 cases
> > >> > could also be caused by the same (although that is in Hyper-V code
> > >> > instead of systemd, that need to be addressed separately).
> > >
> > > Perhaps it may be better to fix the issus on s390x and PowerPC as well?
> > >
> > >> > 
> > >> > Thus to avoid the auto enablement here just disable the param writable
> > >> > permission in sysfs.
> > >> > 
> > >> 
> > >> Well.  I don't think this is at all a desirable way of resolving a
> > >> disagreement with the systemd developers
> > >> 
> > >> At the above github address I'm seeing "ryncsn added a commit to
> > >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> > >> enable crash_kexec_post_notifiers by default".  So didn't that address
> > >> the issue?
> > >
> > > It does in systemd, but there is a strong interest in making this on
> > > by default.
> > 
> > There is also a strong interest in removing this code entirely from the
> > kernel.
> 
> Added Hyper-V people and people who created the param, it is below
> commit, I also want to remove it if possible, let's see how people
> think, but the least way should be to disable the auto setting in both systemd
> and kernel:
> 
>     commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
>     Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>     Date:   Fri Jun 6 14:37:07 2014 -0700
>     
>         kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
>     
>         Add a "crash_kexec_post_notifiers" boot option to run kdump after
>         running panic_notifiers and dump kmsg.  This can help rare situations
>         where kdump fails because of unstable crashed kernel or hardware failure
>         (memory corruption on critical data/code), or the 2nd kernel is already
>         broken by the 1st kernel (it's a broken behavior, but who can guarantee
>         that the "crashed" kernel works correctly?).
>     
>         Usage: add "crash_kexec_post_notifiers" to kernel boot option.
>     
>         Note that this actually increases risks of the failure of kdump.  This
>         option should be set only if you worry about the rare case of kdump
>         failure rather than increasing the chance of success.


If this is such risky knob that leads to bugs where folks are backing away
from with disgust in their faces - then perhaps the only way to go about
this is - limit the exposure to known working situations on firmware
that we can control?

That is enable only a subset of post notifiers which determine if they
are OK running if the conditions are blessed?

I think that would satisfy the conditions where you have to to deal with unsavory
bugs that end up on your plate - and aren't fun because there is no
way to fixing it -  but at the same time allowing multiple ways to save the crash?

Please don't take away something that is quite useful in the field. Can we
hammer out something that will remove your pain points?
> 
> > 
> > This failure is a case in point.
> > 
> > I think I am at my I told you so point.  This is what all of the testing
> > over all the years has said.  Leaving functionality to the peculiarities
> > of firmware when you don't have to, and can actually control what is
> > going on doesn't work.
> > 
> > Eric
> > 
> > 
> 
> Thanks
> Dave
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
