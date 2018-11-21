Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPXSo-0000pJ-5n
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 18:43:03 +0000
Date: Wed, 21 Nov 2018 19:42:32 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181121184232.GB27559@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
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
To: bjorn@helgaas.com
Cc: lijiang@redhat.com, bhe@redhat.com, x86 <x86@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, dyoung@redhat.com, Andrew Morton <akpm@linux-foundation.org>

On Tue, Nov 20, 2018 at 02:43:57PM -0600, Bjorn Helgaas wrote:
> MMCONFIG (aka ECAM) space is described in the ACPI MCFG table.  The
> generic code to read that is in drivers/acpi/pci_mcfg.c (ignore all
> the quirks at the top) and the generic code to use it is
> drivers/pci/ecam.c.

/me saves that for future reference.

> Unfortunately x86 doesn't use any of that generic path.  It uses the
> same MCFG table, but it's parsed in arch/x86/pci/mmconfig-shared.c,
> and the code there checks to ensure the ECAM regions are reserved
> somehow by firmware, e.g., via the e820 table.

As they are on my workstation here, for example:

[    0.552607] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820

vs the "ACPI motherboard resources" reservation thing where it traverses
some PNP devices.

> There's a bunch of grungy device-dependent code there, too, possibly
> to work around firmware defects, or (just as likely) to compensate for
> Linux defects that were *attributed* to firmware.

Nah, latter we simply fix. :-)

> I think you should regard correct MCFG/ECAM usage in the kdump kernel
> as a requirement.  If you don't have ECAM (a) PCI devices won't work
> at all on non-x86 systems that use only ECAM for config access, (b)
> you won't be able to access devices on non-0 segments (granted, there
> aren't very many of these yet, but there will be more in the future),

Ah. don't worry, someone will pop up from the woodwork with the need for
this ;-\

> and (c) you won't be able to access extended config space (addresses
> 0x100-0xfff), which means none of the Extended Capabilities will be
> available (AER, ACS, ATS, etc).

Yap, and this answers my question:

e820__mapped_all() is being called with E820_TYPE_RESERVED down the path
in pci_mmcfg_check_reserved(). Which basically says that we need to
provide all reserved regions in the second kernel so that MMCONFIG works
there.

Thanks a lot Bjorn!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
