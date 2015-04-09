Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 9 Apr 2015 16:02:44 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
Message-ID: <20150409150244.GG9648@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
 <20150408130520.GB5977@leverpostej> <552605CD.7000704@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <552605CD.7000704@linaro.org>
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

On Thu, Apr 09, 2015 at 05:53:33AM +0100, AKASHI Takahiro wrote:
> Mark,
> 
> On 04/08/2015 10:05 PM, Mark Rutland wrote:
> > On Thu, Apr 02, 2015 at 06:40:13AM +0100, AKASHI Takahiro wrote:
> >> The current kvm implementation keeps EL2 vector table installed even
> >> when the system is shut down. This prevents kexec from putting the system
> >> with kvm back into EL2 when starting a new kernel.
> >>
> >> This patch resolves this issue by calling a cpu tear-down function via
> >> reboot notifier, kvm_reboot_notify(), which is invoked by
> >> kernel_restart_prepare() in kernel_kexec().
> >> While kvm has a generic hook, kvm_reboot(), we can't use it here because
> >> a cpu teardown function will not be invoked, under current implementation,
> >> if no guest vm has been created by kvm_create_vm().
> >> Please note that kvm_usage_count is zero in this case.
> >>
> >> We'd better, in the future, implement cpu hotplug support and put the
> >> arch-specific initialization into kvm_arch_hardware_enable/disable().
> >> This way, we would be able to revert this patch.
> >
> > Why can't we use kvm_arch_hardware_enable/disable() currently?
> 
> IIUC, kvm will call kvm_arch_hardware_enable() iff a new guest is being
> created *and* cpus have not been initialized yet. kvm_usage_count==0
> indicates this. Similarly, kvm will call kvm_arch_hardware_disable() whenever
> a guest is being terminated (i.e. kvm_usage_count != 0).
> Therefore if kvm_arch_hardware_enable/disable() also handle EL2 vector table
> initialization, we don't have to have any particular operations, as my patch
> does, for kexec case.
> (a long-term solution)
> 
> Since arm64 doesn't implement kvm_arch_hardware_enable() (I don't know why),
> I'm trying to fix the problem by adding a minimum tear-down function, kvm_cpu_reset,
> and invoking it via a reboot hook.
> (an interim fix)

What I don't understand is why we can't move the init and tear-down
functions into kvm_arch_hardware_enable/disable(). They seem to be for
precisely what you are implementing, with the only difference being the
time that they are called.

Either I'm missing something, or we can simply implement the existing
hooks. I assume I'm missing something.

> >> +static struct notifier_block kvm_reboot_nb = {
> >> +	.notifier_call		= kvm_reboot_notify,
> >> +	.next			= NULL,
> >> +	.priority		= 0, /* FIXME */
> >
> > It would be helpful for the comment to explain why this is wrong, and
> > what needs fixing.
> 
> Thank for reminding me of this.
> 
> *priority* enforces a calling order of registered hook functions.
> If some hook returns NOTIFY_STOP_MASK, subsequent hooks won't be called.
> (Nevertheless, reboot sequence will go ahead. See kernel_restart_prepare()/
> notifier_call_chain().)
> 
> So we should make sure that kvm_reboot_notify() be called
> 1) after any hook functions which may depend on kvm, and

Which hooks depend on KVM?

> 2) before any hook functions which kvm may depend on, and

Which other hooks does KVM depend on?

> 3) before any hook functions that may return NOTIFY_STOP_MASK

I think this would be solved by using kvm_arch_hardware_enable/disable.
As far as I can tell, the VMs would be destroyed earlier (and hence KVM
disabled) before we got to the final teardown.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
