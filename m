Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2001:470:1f0b:db:abcd:42:0:1])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmGSJ-0004mA-D7
 for kexec@lists.infradead.org; Wed, 14 Oct 2015 07:26:36 +0000
Date: Wed, 14 Oct 2015 09:25:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
In-Reply-To: <04EAB7311EE43145B2D3536183D1A844549BAEA9@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <alpine.DEB.2.11.1510140924370.25029@nanos>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <alpine.DEB.2.11.1510132219480.25029@nanos>
 <04EAB7311EE43145B2D3536183D1A844549BAEA9@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1300212950-1444807519=:25029"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?ISO-2022-JP?Q?=1B$B2O9g1Q9=28=1B=28J_=2F_KAWAI=1B$B!$=1B=28JHIDEHIRO?= <hidehiro.kawai.ez@hitachi.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?ISO-2022-JP?Q?=1B$BJ=3F=3E=3E2mL&=1B=28J_=2F_HIRAMATU=1B$B!$=1B=28JMASAMI?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1300212950-1444807519=:25029
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2015, 河合英宏 / KAWAI，HIDEHIRO wrote:
> > On Fri, 25 Sep 2015, Hidehiro Kawai wrote:
> > 
> > > This patch introduces new boot option "noextnmi" which disables
> > > external NMI.  This option is useful for the dump capture kernel
> > > so that an HA application or administrator wouldn't mistakenly
> > > shoot down the kernel by NMI.
> > >
> > > Currently, only x86 supports this option.
> > 
> > You might add that is can be used for debugging purposes as
> > well. External NMIs can be their own source of trouble. :)
> 
> Thanks for your comments!  I'll do that.
> 
> By the way, I have a pending patch which expands this option like
> this:
> 
> 	apic_extnmi={ bsp | all | none }
> 
> If apic_extnmi=all is specified, external NMIs are broadcast to
> all CPUs.  This raises the successful rate of kernel panic in the case
> where an external NMI to CPU 0 is swallowed by other NMI handlers or
> blocked due to hang-up in NMI context.  The patch works without any
> problems, but I'm going to drop the feature if it will cause long
> discussion.  I'd like to settle this patch set down once.  At least,
> I'm going to change this option to apic_extnmi={bsp|none} style for
> the future expansion.
> 
> How do you think about this?

Do it right away with all three variants. They make a lot of sense to
me.
 
Thanks,

	tglx
--8323329-1300212950-1444807519=:25029
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--8323329-1300212950-1444807519=:25029--

