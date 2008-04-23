Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Joe8v-0002U9-DJ
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 12:32:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <47FF190B.6030406@ah.jp.nec.com>
	<20080411210751.e4a468b2.akpm@linux-foundation.org>
	<20080414134622.GB6941@redhat.com>
	<20080414144228.GD1193@hmsendeavour.rdu.redhat.com>
	<20080414145323.GE6941@redhat.com>
	<20080414160146.GE1193@hmsendeavour.rdu.redhat.com>
	<20080414123311.01d537b4.akpm@linux-foundation.org>
	<4806E0BA.3020209@ah.jp.nec.com>
Date: Wed, 23 Apr 2008 05:31:59 -0700
In-Reply-To: <4806E0BA.3020209@ah.jp.nec.com> (Takenori Nagano's message of
	"Thu, 17 Apr 2008 14:31:38 +0900")
Message-ID: <m18wz4rbuo.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add new notifier function ,take3
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: nickpiggin@yahoo.com.au, Neil Horman <nhorman@redhat.com>, k-miyoshi@cb.jp.nec.com, greg@kroah.com, bwalle@suse.de, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net, ebiederm@xmission.com, kaos@ocs.com.au, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

Takenori Nagano <t-nagano@ah.jp.nec.com> writes:

> Hi,
>
> The one of the reason why I want this functionality is managing RAS
> tool behavior for postmotem actions, initially from kdb invocation.
> (I used kdb for debugging and crash analysis very useful in lkcd days,
> but it is "want" and it is not "must" today ;-))

Ok.  I have not heard any reason here why a break point at panic
or inside of panic is not useful.

> The other postmotem action is disabling hardware watchdog.
> Watch dog handler would stop keepalive heartbeat when system panics
> and we must disable hardware watchdog as soon as possible, since 2nd
> kernel startup takes some time (10 or 100? secs) and there may be
> miss-firing window. But currently we have no chance to do anything
> before crash_exec().

The transition time from one kernel to the next should be under 1 sec.
After that you are talking time for the drivers to initialize.
Although sha256 over the kdump kernel and it's ramdisk may slow things
down a little more for lots of data.

If the concern is of petting a watchdog to keep the system from
rebooting getting the kernel to initialize the watchdogs quickly
appears to be the correct answer.

> And thinking about a clustering software. If the system encounter
> the panic, system must notify standby node. But... :-(


If the concern is to notify another system of the crash quickly.
I see no reason why very early in the second kernel or perhaps
even in the purgatory code in kexec we can not do this.  If the
code is to hairy to do there then the code is likely to be
too hairy to do reliably when the system panics.

> I am interested in pre-dump scripts Neil mentioned. I think it can
> resolve some of our requirements. I will try it.

> For quick invocation of kdump, I partially agree with the idea of
> "kdump should be invoked as soon as system panic, since we can not
> trust broken kernels", but we would like to have some choise what
> to do on panic (and if notifier is controllable by my patch,
> you can still call kdump first)
>
> Anyway, completely broken kernel can not call kdump or any other
> mechanism  ;-P  and I feel it is somewhat matter of degree.

Yes.  Completely broken kernels may not recognize they have a problem.

It is the design goal of the kexec on panic path to work with as much
of kernel broken as possible.

Additionally reviewing and testing that code is extremely difficult,
because it is the one piece of code in the kernel where debugging
tools are not available.  Putting random tunable code on that path
hugely reduces it's maintainability.

Further for all of the cases I have seen there is only one correct
action to take, things do not need to be tunable.  So a generally
tunable interface appears to be a design mistake.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
