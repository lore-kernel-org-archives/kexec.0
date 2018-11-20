Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f67.google.com ([209.85.166.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPCvZ-0002Pv-8E
 for kexec@lists.infradead.org; Tue, 20 Nov 2018 20:47:23 +0000
Received: by mail-io1-f67.google.com with SMTP id s22so2403767ioc.8
 for <kexec@lists.infradead.org>; Tue, 20 Nov 2018 12:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
In-Reply-To: <20181115103959.GB26448@zn.tnic>
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 20 Nov 2018 14:43:57 -0600
Message-ID: <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: bjorn@helgaas.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: bp@alien8.de
Cc: lijiang@redhat.com, bhe@redhat.com, x86 <x86@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, dyoung@redhat.com, Andrew Morton <akpm@linux-foundation.org>

On Thu, Nov 15, 2018 at 4:40 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + Bjorn.
>
> On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
> > At present, the upstream kernel does not pass the e820 reserved ranges to the
> > second kernel, which might cause two problems:
> >
> > The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> > the reserved region otherwise it falls back to legacy mode, which might lead to
> > the hot-plug device could not be recognized in kdump kernel.
>
> Well, this still doesn't explain it fully. Let's look at a box:
>
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable
>
> this one has 8 reserved regions. Does that mean that we need to pass
> them *all* 8 to the second kernel so that MMCONFIG works?
>
> Or is it only one reserved region which is needed for MMCONFIG?
>
> Bjorn, do you know what the detection logic should be to map the correct
> reserved region (or regions) for MMCONFIG?

MMCONFIG (aka ECAM) space is described in the ACPI MCFG table.  The
generic code to read that is in drivers/acpi/pci_mcfg.c (ignore all
the quirks at the top) and the generic code to use it is
drivers/pci/ecam.c.

Unfortunately x86 doesn't use any of that generic path.  It uses the
same MCFG table, but it's parsed in arch/x86/pci/mmconfig-shared.c,
and the code there checks to ensure the ECAM regions are reserved
somehow by firmware, e.g., via the e820 table.  There's a bunch of
grungy device-dependent code there, too, possibly to work around
firmware defects, or (just as likely) to compensate for Linux defects
that were *attributed* to firmware.

I think you should regard correct MCFG/ECAM usage in the kdump kernel
as a requirement.  If you don't have ECAM (a) PCI devices won't work
at all on non-x86 systems that use only ECAM for config access, (b)
you won't be able to access devices on non-0 segments (granted, there
aren't very many of these yet, but there will be more in the future),
and (c) you won't be able to access extended config space (addresses
0x100-0xfff), which means none of the Extended Capabilities will be
available (AER, ACS, ATS, etc).

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
