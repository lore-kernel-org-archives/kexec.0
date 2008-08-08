Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRICk-0004mZ-5d
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 02:59:51 +0000
Subject: Re: [PATCH 6/6] kexec jump: fix for ftrace
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080807133805.GD27783@redhat.com>
References: <1218099937.5164.37.camel@caritas-dev.intel.com>
	<20080807133805.GD27783@redhat.com>
Date: Fri, 08 Aug 2008 10:59:31 +0800
Message-Id: <1218164371.22039.20.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Thu, 2008-08-07 at 09:38 -0400, Vivek Goyal wrote:
[...]
> What kind of problem we run into if we don't disable the ftracer?
> 
> I think there are too many #ifdefs now and probably we can at least
> get rid if #ifdef CONFIG_FTRACE thing.
> 
> I think ftracer needs to export the function to enable the tracer
> back (tracer_enable()) so that we don't directly play with ftrace_enabled
> variable. tracer_enable() can be do {} while{0} in case of CONFIG_FTRACE=n
> so that we can get rid of #ifdefs here.

The ftracer issue for kexec is reported by Dhaval Giani and fixed by
Ingo as in following thread:

http://lkml.org/lkml/2008/2/19/175

After some testing, I found that if we enable ftrace before
restore_processor_state(), system will hang. I think maybe ftracer
depends on some processor state that we destroyed during kexec and
restored by restore_processor_state(). So I move save_processor_state()
and restore_processor_state() into machine_kexec() and enable ftrace
after restore_processor_state().

The #ifdef CONFIG_FTRACE should be removed. I think an interface like
irq_save/restore is good for this.

saved_ftrace_enabled = ftrace_save_enabled()
<...>
ftrace_restore_enabled(saved_ftrace_enabled)

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
