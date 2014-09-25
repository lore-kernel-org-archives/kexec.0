Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411604682.6001.178.camel@smoke>
Subject: Re: [PATCH 08/13] arm64: Use cpu_ops for smp_stop
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 24 Sep 2014 17:24:42 -0700
In-Reply-To: <20140915190616.GC14191@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <36ad9302497338a34cc7174a72a2ac99ceb16fdb.1410302383.git.geoff@infradead.org>
 <20140915190616.GC14191@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Mark,

On Mon, 2014-09-15 at 20:06 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Tue, Sep 09, 2014 at 11:49:05PM +0100, Geoff Levand wrote:
> > The current implementation of ipi_cpu_stop() is just a tight infinite loop
> > around cpu_relax().  This infinite loop implementation is OK if the machine
> > will soon do a poweroff, but it doesn't have any mechanism to allow a CPU
> > to be brought back on-line, nor is it compatible with kexec re-boot.
> 
> I don't see why we should use this when we have disable_nonboot_cpus.

I decided to use disable_nonboot_cpus, so this patch is no longer
needed.  I'll put the rework of disable_nonboot_cpus to not depend on
CONFIG_PM_SLEEP_SMP on my todo list.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
