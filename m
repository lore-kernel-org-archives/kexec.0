Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1422305839.21823.11.camel@infradead.org>
Subject: Re: [PATCH 0/8] arm64 kexec kernel patches V7
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 26 Jan 2015 12:57:19 -0800
In-Reply-To: <20150126174414.GF14048@e104818-lin.cambridge.arm.com>
References: <cover.1415926876.git.geoff@infradead.orgg>
 <cover.1421449714.git.geoff@infradead.org>
 <20150126174414.GF14048@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, Deepak Saxena <dsaxena@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Catalin,


On Mon, 2015-01-26 at 17:44 +0000, Catalin Marinas wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > This series adds the core support for kexec re-boots on arm64.  This v7 of the
> > series is mainly just a rebase to the latest arm64 for-next/core branch
> > (v3.19-rc4), and a few very minor changes requested for v6.
> 
> I haven't looked at the series in detail before, so some of my comments
> may have already been discussed.
> 
> > Several things are known to have problems on kexec re-boot:
> > 
> > spin-table
> 
> I think that's not too bad, for complete kexec support (SMP->SMP) we can
> require some CPU unplug mechanism and PSCI is one of them.
> 
> > FIX: Upgrade system firmware to provide PSCI enable method support or add
> > missing spin-table support to the kernel.
> 
> What's the missing spin-table support?

I had a working spin-table implementation, but I have not kept that
up to date.  It is somewhat complicated, and it requires a mechanism
to return the secondary CPUs to the spin table code.  As Mark
mentioned, that mechanism would need to be decided on.  I don't plan
to put any more work into spin-table support.

Just for anyone interested, my old spin-table support patches are in
this branch:

https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/log/?h=spin-table

> 
> > ACPI
> > ----
> > 
> > PROBLEM: The kernel for ACPI based systems does not export a device tree to the
> > standard user space location of 'proc/device-tree'.  Current applications
> > expect to access device tree information from this standard location.
> > 
> > WORK-AROUND: Disable ACPI in firmware, OR pass 'acpi=off' on the first stage
> > kernel command line, OR pass a user specified DTB using the kexec --dtb option.
> > 
> > FIX: FIX: An interface to expose a binary device tree to user space has been
> > proposed.  User kexec utilities will need to be updated to add support for this
> > new interface.
> 
> So the fix here is to boot the second stage kernel with dtb, which means
> that we mandate the existence of a DT file for any ACPI system. Are
> there plans to make the kexec'ed kernel reuse the ACPI tables?

As Grant mentioned, the dtb the UEFI stub creates and passes to the first
stage kernel is what is passed to the second stage kernel.  The second
stage kernel uses that to setup its ACPI support.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
