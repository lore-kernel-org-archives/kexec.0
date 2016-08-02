Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUaaG-0001VI-WC
 for kexec@lists.infradead.org; Tue, 02 Aug 2016 14:22:20 +0000
Date: Tue, 2 Aug 2016 22:21:52 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2 0/3] Fix dump-capture kernel hangs with notsc
Message-ID: <20160802142152.GC3663@x1.redhat.com>
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1470033660.7811.99.camel@localhost>
 <87twf4xvpd.fsf@x220.int.ebiederm.org>
 <1470123720.2274.53.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470123720.2274.53.camel@localhost>
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "xpang@redhat.com" <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Cao,
 Jin" <caoj.fnst@cn.fujitsu.com>, "mingo@redhat.com" <mingo@redhat.com>, "kernel@kyup.com" <kernel@kyup.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "Izumi, Taku" <izumi.taku@jp.fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 08/02/16 at 07:45am, Wei, Jiangang wrote:
> Hi Eric,
> 
> Thanks for your reply firstly.
> 
> On Mon, 2016-08-01 at 12:09 -0500, Eric W. Biederman wrote:
> > "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com> writes:
> > 
> > > Ping ...
> > > May I ask for some community attention to this series?
> > > I purpose is fixing  the dump-capture kernel hangs in
> > > calibrate_delay_converge() while specifying notsc.
> > 
> > Did you not see my reply to patch 3/3?
> 
> Yes, I read your email and made a reply
> (https://lkml.org/lkml/2016/7/26/112) . I put forward several questions
> in that letter, but no feedback...
> 
> > 
> > The short version of my feedback is that you seem to be fixing a case
> > that should not exist.  So the good fix is to skip completely past
> > virtual wire mode and into full apic mode as soon as possible.
> 
> I am afraid that there are some disagreements between us.
> 
> 1)  The case that dump-capture kernel boot up with the disabled APIC is
> very real, and the bug can be reproduced 100%.  I want to emphasize that
> there is no guarantee of the interrupt mode of APIC and status of local
> APIC, Especially for the dump-capture kernel that won't through the BIOS
> phrase. That's why I do more check in init_bsp_APIC(), not only depends
> on the MP tables which be generated before the first kernel boots up.
> 
> Make a point here, The BIOS must disable interrupts to all processors
> and set the APICs to the system initial state before giving control to
> the operating system. That means APICs won't be reset to initial state
> without BIOS phrase.
> 
> 2)  Your proposal (switch into full apic mode as soon as possible) seems
> to contradict the Intel Spec, "An MP operating system is booted under
> either one of the two PC/AT-compatible modes. Later the operating system
> switches to Symmetric I/O Mode **as it enters multiprocessor mode**."
> And in other words, the BSP should be in PIC mode or Virtual wire mode
> in startup stage.

Well, Eric has clearly told hardware-reduced ACPI platform doesn't have
legacy mode irq. It only has APIC mode. The quotation from MP spec is
very old.

I check code and think now you should investigate the current
implementation, see if APIC mode can be enabled as soon as possible.
Though it can't, detailed explanation need be given to convince people.

> 
> 3)  The apic initialization codes maybe need a overhaul, but it goes out
> the scope of this patch. I focus on fixing kdump failure with notsc. And
> the apic initialization codes has no modification for a long time and
> can be regard as stable.  Overhaul of it increases the chances of
> hitting a bug.
> If there's anything wrong with my understanding, please point out.
> 
> Thanks,
> wei
> > 
> > For a subset of cases the code already supports that.
> > 
> > Eric
> > 
> > 
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
