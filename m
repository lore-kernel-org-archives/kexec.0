Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoePG-0004pk-9y
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 12:49:02 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <480F1957.2070609@ah.jp.nec.com>
Date: Wed, 23 Apr 2008 05:48:53 -0700
In-Reply-To: <480F1957.2070609@ah.jp.nec.com> (Takenori Nagano's message of
	"Wed, 23 Apr 2008 20:11:19 +0900")
Message-ID: <m1wsmoohxm.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] add new notifier function ,take4
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
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, k-miyoshi@cb.jp.nec.com, greg@kroah.com, bwalle@suse.de, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

Takenori Nagano <t-nagano@ah.jp.nec.com> writes:

> Hi,
>
> changelog take3 -> take4
>
> - Rebased 2.6.25-mm1
> - Add a document
> - Add kdump on panic_notifier
>
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by control
> files.
>
> And, third patch moves crash_kexec() to panic_notifier. It helps us to do
> something before taking a crash dump. It's useful for some RAS tools developer.
> If you want to use it, you have to set config option DUMP_ON_PANIC_NOTIFIER to
> Y. Default value of DUMP_ON_PANIC_NOTIFIER is N.
> If you set DUMP_ON_PANIC_NOTIFIER to N, kdump has no difference before.

NAK.

Reasonable alternatives have been suggested.  No rebuttal has been given.
Just buggy patches with insufficient description of what you are doing
and why.

I am tired of seeing the same patch come up again and again without even
all of the easy problems that are pointed out addressed, much less the
design issues considered or addressed.

I see no evidence that we need this mechanism to achieve any of
the goals proposed.

This mechanism drastically reduces the maintainability of the
kexec on panic code as it makes the code path indiscoverable
and thus unreviewable.

This mechanism gives an unnecessary and confusing policy control
to users when we should be able to auto-tune based on the situation.

CONFIGURABILITY IS BAD in this context.

I think this entire approach is a BAD IDEA.  Please go back to
the drawing board.  Please describe the specific problems you
are trying to solve and why the existing mechanisms can not be
made to work and we can work with you.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
