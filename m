Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Jun 2016 10:20:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v20 00/14] arm64 kexec kernel patches
Message-ID: <20160629092049.GA2522@e104818-lin.cambridge.arm.com>
References: <cover.1466702804.git.geoff@infradead.org>
 <20160627170039.GD6847@e104818-lin.cambridge.arm.com>
 <20160629005414.GC20774@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160629005414.GC20774@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Geoff Levand <geoff@infradead.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jun 29, 2016 at 09:54:15AM +0900, AKASHI Takahiro wrote:
> On Mon, Jun 27, 2016 at 06:00:39PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 23, 2016 at 05:54:47PM +0000, Geoff Levand wrote:
> > > AKASHI Takahiro (7):
> > >       arm64: kdump: reserve memory for crash dump kernel
> > >       arm64: limit memory regions based on DT property, usable-memory
> > >       arm64: kdump: implement machine_crash_shutdown()
> > >       arm64: kdump: add kdump support
> > >       arm64: kdump: add VMCOREINFO's for user-space coredump tools
> > >       arm64: kdump: enable kdump in the arm64 defconfig
> > >       arm64: kdump: update a kernel doc
> > > 
> > > Geoff Levand (4):
> > >       arm64: Add back cpu reset routines
> > >       arm64/kexec: Add core kexec support
> > >       arm64/kexec: Enable kexec in the arm64 defconfig
> > >       arm64/kexec: Add pr_debug output
> > > 
> > > James Morse (3):
> > >       arm64: hibernate: Don't hibernate on systems with stuck CPUs
> > >       arm64: smp: Add function to determine if cpus are stuck in the kernel
> > >       Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec
> > 
> > I dropped patch 1 (hibernate), cherry-picked patch 2 from mainline
> > ("cpus stuck in the kernel", already pushed by Will to 4.7-rc5) and
> > merged patches 3-6, with the amendments that James mentioned.
> > 
> > The kdump patches, including the "Documentation" one from James require
> > more review, testing and acks by the corresponding maintainers (kdump,
> > DT).
> 
> I see what you mean, but even for Geoff's kexec part, the maintainer
> (Eric) have not given his ack.

I just assumed he won't object ;). The only generic change is the
KEXEC_ARCH_AARCH64 in the uapi/linux/kexec.h file and the value chosen
matches EM_AARCH64.

The kdump patches make such changes to Documentation and I would like
those acked by the kdump and DT maintainers.

Pratyush Anand also had comments on the kdump patches in v19, so it's
fair to wait for him to complete the reviewing of the latest series.

> > You also don't seem to have added a s-o-b for those patches (since
> > you are submitting them; unless you plan to let Akashi-san submit them
> > in the future).
> 
> Basically Geoff has not reviewed nor tested kdump part, and
> so I'm not sure that adding his s-o-b is appropriate.

It is appropriate. See the "Developer's Certificate of Origin" in
Documentation/SubmittingPatches. A s-o-b from Geoff doesn't necessarily
mean that he reviewed the patches but that he has the right to pass them
on under the open source license indicated in the file (and AFAICT it is
legally binding but IANAL).

> Anyhow, I will post my future version of kdump by myself as kexec has
> been queued in for-next/core.

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
