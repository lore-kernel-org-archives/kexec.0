Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQY7N-0006JK-Pu
 for kexec@lists.infradead.org; Tue, 14 May 2019 14:09:23 +0000
Received: by mail-wr1-x441.google.com with SMTP id w12so19419037wrp.2
 for <kexec@lists.infradead.org>; Tue, 14 May 2019 07:09:21 -0700 (PDT)
Date: Tue, 14 May 2019 16:09:16 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514140916.GA90245@gmail.com>
References: <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
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
Cc: x86@kernel.org, kasong@redhat.com, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, fanc.fnst@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de


* Dave Young <dyoung@redhat.com> wrote:

> On 05/14/19 at 01:38pm, Peter Zijlstra wrote:
> > On Tue, May 14, 2019 at 04:48:41PM +0800, Dave Young wrote:
> > 
> > > > I did some tests on the laptop,  thing is:
> > > > 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
> > > >    on latest Linus master branch, everything works fine.
> > > > 
> > > > 2. build and test the tip/next-merge-window branch, kernel hangs early
> > > > without output, (both 1st boot and kexec boot)
> > > 
> > > Update about 2.  It should be not early rsdp related, I got the boot log
> > > Since can not reproduce with Linus master branch it may have been fixed.
> > 
> > Nothing was changed here since PTI.
> > 
> > > [    0.685374][    T1] rcu: Hierarchical SRCU implementation.
> > > [    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
> > > [    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
> > > [    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
> > > [    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
> > 
> > > [    0.687328][    T1] Call Trace:
> > > [    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
> > > [    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
> > > [    0.687328][    T1]  x86_pmu_event_init+0x39/0x220
> > 
> > The DS buffers are special in that they're part of cpu_entrt_area. If
> > this comes apart it might mean your pagetables are dodgy.
> 
> Hmm, it seems caused by some WIP branch patches, I suspect below:
> commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
> x86/paravirt: Standardize 'insn_buff' variable names

This commit had a bug which I fixed - could you try the latest -tip?

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
