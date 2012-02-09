Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rvdhv-0002vq-44
 for kexec@lists.infradead.org; Thu, 09 Feb 2012 23:47:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2] x86,
 kdump: No need to disable ioapic/lapic in crash path
References: <1328824421-11068-1-git-send-email-dzickus@redhat.com>
Date: Thu, 09 Feb 2012 15:49:43 -0800
In-Reply-To: <1328824421-11068-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Thu, 9 Feb 2012 16:53:41 -0500")
Message-ID: <m1k43v5zzc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>


The code and the testing look good, and it has long been desirable to
get rid of this code and reduce the complexity of the kexec on panic
path.

Ingo, Peter, Thomas if one of you could pick this up that would be
wonderful.


Don Zickus <dzickus@redhat.com> writes:

> A customer of ours noticed when their machine crashed, kdump did not
> work but hung instead.  Using their firmware dumping solution they
> grabbed a vmcore and decoded the stacks on the cpus.  What they
> noticed seemed to be a rare deadlock with the ioapic_lock.



[snip]
> I tested kdump on an Ivy Bridge platform, a Pentium4 and an old athlon that
> did not have an ioapic.  All three were successful.
>
> I also tested using lkdtm that would use jprobes to panic the system when
> entering do_IRQ.  The idea was to see how the system reacted with an
> interrupt pending in the second kernel.  My core2 quad successfully kdump'd
> 3 times in a row with no issues.
>
> v2: removed the disable lapic code too
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Don Zickus <dzickus@redhat.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  arch/x86/kernel/crash.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

[snip]

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
