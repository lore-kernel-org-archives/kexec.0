Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <50ECB49C.7010609@wwwdotorg.org>
Date: Tue, 08 Jan 2013 17:06:52 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
In-Reply-To: <87ehhxahd1.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Stephen Warren <swarren@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/06/2013 06:53 PM, Eric W. Biederman wrote:
...
> Yes.  On x86 we have had the generic equivalent of disable_nonboot_cpus
> in the machine_shutdown for a long time.

It looks like the x86 implementation does a bit more than
disable_nonboot_cpus():

disable_nonboot_cpus():
	find first cpu in online cpu mask
	disable everything else

x86's machine_shutdown():
	default to rebooting on cpu 0
	if user specified a different cpu, override default
	bring that cpu online
	disable everything else

So, x86 always kexec's on a specific CPU, whereas if we use
disable_nonboot_cpus() on ARM, we'll end up kexec'ing on whichever is
the first online CPU, which might not be the actual boot CPU, and can vary.

On Tegra this doesn't (currently?) matter since CPU 0 can't be taken
offline due to our CPU hotplug driver disallowing it. But, perhaps other
SoCs or future Tegra versions don't/won't have this restriction, so the
difference will be material.

Should the x86 code be lifted into the implementation of
disable_nonboot_cpus()?

For the record, here's what I can tell about what the various
arch-specific machine_shutdown() do:

ARM, ARM64: calls smp_send_stop()
  -> disable_nonboot_cpus() would be correct

IA64: shuts down all CPUs except the current one
  -> disable_nonboot_cpus() would be correct

Microblaze: nothing (but no SMP support?)
  -> disable_nonboot_cpus() would be irrelevant, but fine

MIPS: machine-specific:
  Cavium Octeon: Shuts down CPUs, waits until num_online_cpus()==1
    Not sure which CPU isn't shut down though; the current one?
  Others: Nothing (but at least some have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

PPC: machine-specific
  Only implementations either aren't for SMP, or do nothing (but
presumably many have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

SH: smp_send_stop()
  -> disable_nonboot_cpus() would be correct

S390: nothing (but appears to have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

Tile: nothing (but bans kexec unless no SMP or only 1 CPU online)
  -> disable_nonboot_cpus() would be irrelevant, but fine, and perhaps
even allow removal of the kexec ban for SMP?

So at least I don't see anything that would particularly indicate that
having the kexec generic/core code call disable_nonboot_cpus() would
cause problems; many architectures have done something like that
themselves. That said, it certainly would cause some behavioural
differences on some big platforms like PPC...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
