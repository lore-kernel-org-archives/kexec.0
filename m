Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 15 Apr 2015 13:49:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
Message-ID: <20150415124913.GF2866@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
 <20150408130520.GB5977@leverpostej> <552605CD.7000704@linaro.org>
 <20150409150244.GG9648@leverpostej> <55276A7E.1080508@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55276A7E.1080508@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "geoff@infradead.org" <geoff@infradead.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

> > What I don't understand is why we can't move the init and tear-down
> > functions into kvm_arch_hardware_enable/disable(). They seem to be for
> > precisely what you are implementing, with the only difference being the
> > time that they are called.
> 
> I don't know, neither. I just followed the discussions between Marc and Geoff,
> and their conclusion. I guessed that *refactoring* might be more complicated than
> expected.
> 
> FYI, I gave a quick try to kvm_arch_hardware_enable() approach by removing
> cpu_init_hyp_mode() from init_hyp_mode() and putting it into kvm_arch_hardware_enable(),
> and it seems to work, at least, in my environment:
>     boot => start a kvm guest => kexec reboot => start a kvm guest

That sounds pretty convincing to me, assuming you wired the teardown
intp kvm_arch_hardware_disable() ?

> > Either I'm missing something, or we can simply implement the existing
> > hooks. I assume I'm missing something.
> 
> Marc, Geoff, any comments?
> 
> 
> >>>> +static struct notifier_block kvm_reboot_nb = {
> >>>> +	.notifier_call		= kvm_reboot_notify,
> >>>> +	.next			= NULL,
> >>>> +	.priority		= 0, /* FIXME */
> >>>
> >>> It would be helpful for the comment to explain why this is wrong, and
> >>> what needs fixing.
> >>
> >> Thank for reminding me of this.
> >>
> >> *priority* enforces a calling order of registered hook functions.
> >> If some hook returns NOTIFY_STOP_MASK, subsequent hooks won't be called.
> >> (Nevertheless, reboot sequence will go ahead. See kernel_restart_prepare()/
> >> notifier_call_chain().)
> >>
> >> So we should make sure that kvm_reboot_notify() be called
> >> 1) after any hook functions which may depend on kvm, and
> >
> > Which hooks depend on KVM?
> 
> I think I answered this question below:
>  >> But how can we guarantee this and determine a priority of kvm_reboot_notify()?
>  >> Looking into all the occurrences of register_reboot_notifier(),
>  >> 1) => nothing
>  >> 2) => virt/kvm/kvm_main.c (priority: 0)
>  >> 3) => drivers/cpufreq/s32416-cpufreq.c (priority: 0)
>  >>        drivers/cpufreq/s5pv210-cpufreq.c (priority: 0)
>  >>
>  >> So a priority higher than zero might be safe and better, but exactly what?
>  >> Some hooks use "INT_MAX."

I can't see anything listed which has a dependency on KVM.

The KVM notifier would be superseded by
kvm_arch_hardware_{disable,enable}, and the cpufreq instances don't seem
to have any relationship to KVM.

Other architectures use kvm_arch_hardware_{enable,disable}(), so I
imagine the core KVM code has no problem with the ordering of these.

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
