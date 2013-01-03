Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TqjtK-0004H1-GY
 for kexec@lists.infradead.org; Thu, 03 Jan 2013 12:27:23 +0000
Date: Thu, 3 Jan 2013 12:21:00 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Message-ID: <20130103122100.GN2631@n2100.arm.linux.org.uk>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130103120259.GB5193@mudshark.cambridge.arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Boyd <sboyd@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 03, 2013 at 12:02:59PM +0000, Will Deacon wrote:
> You need the smp_send_stop call in order to send the cpu_kill (looks like
> tegra needs die and then kill). So you really need hotplug support as well
> as suspend for this to do much (if not, the secondaries end up spinning
> with interrupts disabled which is probably the best we can do anyway).
> 
> We could add SUSPEND as a KEXEC dependency if SMP (we already have HOTPLUG
> there) if you like?

Or we could look into bringing in the code to do this when KEXEC is
enabled - which would mean an amount of restructuring of the Kconfig
files.

In other words, go from this:

config SUSPEND
        bool "Suspend to RAM and standby"
        depends on ARCH_SUSPEND_POSSIBLE
        default y

config HIBERNATE_CALLBACKS
        bool

config PM_SLEEP
        def_bool y
        depends on SUSPEND || HIBERNATE_CALLBACKS

config PM_SLEEP_SMP
        def_bool y
        depends on SMP
        depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
        depends on PM_SLEEP
        select HOTPLUG
        select HOTPLUG_CPU

to:

config SUSPEND
	bool...
	depends on ARCH_SUSPEND_POSSIBLE
	default y
	select PM_SLEEP

config HIBERNATE_CALLBACKS
	bool
	select PM_SLEEP

config PM_SLEEP
	bool
	select PM_SLEEP_SMP if SMP && (ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE)

config PM_SLEEP_SMP
	bool
        select HOTPLUG
        select HOTPLUG_CPU

This means we could have KEXEC select PM_SLEEP_SMP (and maybe PM_SLEEP) as
required, rather than bringing in the entire suspend support just to have
working kexec.

However, how many platforms don't have suspend support enabled?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
