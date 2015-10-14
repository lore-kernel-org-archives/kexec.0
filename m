Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmCvQ-0004Ot-6I
 for kexec@lists.infradead.org; Wed, 14 Oct 2015 03:40:25 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Wed, 14 Oct 2015 03:39:59 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549BAEA9@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <alpine.DEB.2.11.1510132219480.25029@nanos>
In-Reply-To: <alpine.DEB.2.11.1510132219480.25029@nanos>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Thomas Gleixner' <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> On Fri, 25 Sep 2015, Hidehiro Kawai wrote:
> 
> > This patch introduces new boot option "noextnmi" which disables
> > external NMI.  This option is useful for the dump capture kernel
> > so that an HA application or administrator wouldn't mistakenly
> > shoot down the kernel by NMI.
> >
> > Currently, only x86 supports this option.
> 
> You might add that is can be used for debugging purposes as
> well. External NMIs can be their own source of trouble. :)

Thanks for your comments!  I'll do that.

By the way, I have a pending patch which expands this option like
this:

	apic_extnmi={ bsp | all | none }

If apic_extnmi=all is specified, external NMIs are broadcast to
all CPUs.  This raises the successful rate of kernel panic in the case
where an external NMI to CPU 0 is swallowed by other NMI handlers or
blocked due to hang-up in NMI context.  The patch works without any
problems, but I'm going to drop the feature if it will cause long
discussion.  I'd like to settle this patch set down once.  At least,
I'm going to change this option to apic_extnmi={bsp|none} style for
the future expansion.

How do you think about this?

> > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  Documentation/kernel-parameters.txt |    4 ++++
> >  arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 22a4b68..8bcaccd 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -2379,6 +2379,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  			noexec=on: enable non-executable mappings (default)
> >  			noexec=off: disable non-executable mappings
> >
> > +	noextnmi	[X86]
> > +			Mask external NMI.  This option is useful for a
> > +			dump capture kernel to be shot down by NMI.
> 
> That should read: "...not to be shot down", right?

Yes, you are right.  I'll fix it.

> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
