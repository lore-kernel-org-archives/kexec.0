Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1422647304.21823.31.camel@infradead.org>
Subject: Re: [PATCH 7/8] arm64/kexec: Add checks for KVM
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 30 Jan 2015 11:48:24 -0800
In-Reply-To: <54CB206D.7040705@linaro.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
 <20150126191942.GQ23313@leverpostej> <54CA041C.6020403@linaro.org>
 <54CA12A1.8090508@arm.com> <20150129184747.GV17721@leverpostej>
 <54CB206D.7040705@linaro.org>
Mime-Version: 1.0
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Takahiro.

On Fri, 2015-01-30 at 15:10 +0900, AKASHI Takahiro wrote:
> Initially, I thought that we would define kvm_arch_exit() and call it
> somewhere in the middle of kexec path (no idea yet).
> But Geoff suggested me to implement a new hvc call, HVC_CPU_SHUTDOWN(??),
> and make it called via cpu_notifier(CPU_DYING_FROZEN) initiated by
> machine_shutdown() from kernel_kexec().

As an initial implementation we can hook into the CPU_DYING_FROZEN
notifier sent to hyp_init_cpu_notify().  The longer term solution
should use kvm_arch_hardware_enable() and kvm_arch_hardware_disable().

The calls to cpu_notifier(CPU_DYING_FROZEN) are part of cpu hot
plug, and independent of kexec.  If someone were to add spin-table
cpu un-plug, then it would be used for that also.  It seems we should
be able to test without kexec by using cpu hot plug.

To tear down KVM you need to get back to hyp mode, and hence
the need for HVC_CPU_SHUTDOWN.  The sequence I envisioned would
be like this:

cpu_notifier(CPU_DYING_FROZEN)
 -> kvm_cpu_shutdown() 
    prepare for hvc
    -> HVC_CPU_SHUTDOWN
       now in hyp mode, do KVM tear down, restore default exception vectors

Once the default exception vectors are restored soft_restart()
can then execute the cpu_reset routine in EL2.

Some notes are here for those with access:  https://cards.linaro.org/browse/KWG-611

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
