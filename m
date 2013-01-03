Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <50E5E967.3020805@wwwdotorg.org>
Date: Thu, 03 Jan 2013 13:26:15 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
In-Reply-To: <20130103122100.GN2631@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@nvidia.com>, Will Deacon <will.deacon@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Eric Biederman <ebiederm@xmission.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/03/2013 05:21 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 03, 2013 at 12:02:59PM +0000, Will Deacon wrote:
>> You need the smp_send_stop call in order to send the cpu_kill (looks like
>> tegra needs die and then kill). So you really need hotplug support as well
>> as suspend for this to do much (if not, the secondaries end up spinning
>> with interrupts disabled which is probably the best we can do anyway).
>>
>> We could add SUSPEND as a KEXEC dependency if SMP (we already have HOTPLUG
>> there) if you like?
> 
> Or we could look into bringing in the code to do this when KEXEC is
> enabled - which would mean an amount of restructuring of the Kconfig
> files.

I'm not sure if any of this thread means we should hold off on this
patch, or just that the Kconfig could/should be enhanced later?

One thing I did just notice with my patch: disable_nonboot_cpus() ends
up being called twice for the poweroff path:

[   30.461847] Disabling non-boot CPUs ...
[   30.478797] CPU1: shutdown
[   30.492104] Power down.
[   30.494578] Disabling non-boot CPUs ...

Is this worth worrying about?

It's because kernel_power_off() calls disable_nonboot_cpus() then
machine_shutdown() which also calls disable_nonboot_cpus().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
