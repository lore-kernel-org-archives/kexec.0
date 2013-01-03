Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 3 Jan 2013 11:08:52 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Message-ID: <20130103180852.GA7114@obsidianresearch.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Boyd <sboyd@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Eric Biederman <ebiederm@xmission.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 03, 2013 at 12:21:00PM +0000, Russell King - ARM Linux wrote:

> This means we could have KEXEC select PM_SLEEP_SMP (and maybe PM_SLEEP) as
> required, rather than bringing in the entire suspend support just to have
> working kexec.
> 
> However, how many platforms don't have suspend support enabled?

I was looking into something similar to this for Kirkwood - my
interest was in getting kexec to work, which means it needs to call
the hibernation callbacks in the drivers prior to execing, otherwise
there is a fairly high chance DMA will corrupt the kexec target.

So this means the code needs the suspend support, however Kirkwood
doesn't have any support for ARM_CPU_SUSPEND, which blocks enabling
suspend at all for that platform. I was looking at moving the 'depends
on CPU_..' from ARCH_SUSPEND_POSSIBLE to ARM_CPU_SUSPEND, which seemed
to do the trick for kirkwood but I didn't study every possibility..

Regards,
Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
