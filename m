Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNF4K-0001Hb-Mj
 for kexec@lists.infradead.org; Thu, 15 Nov 2018 10:40:18 +0000
Date: Thu, 15 Nov 2018 11:39:59 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181115103959.GB26448@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
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
To: lijiang <lijiang@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

+ Bjorn.

On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
> At present, the upstream kernel does not pass the e820 reserved ranges to the
> second kernel, which might cause two problems:
> 
> The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> the reserved region otherwise it falls back to legacy mode, which might lead to
> the hot-plug device could not be recognized in kdump kernel.

Well, this still doesn't explain it fully. Let's look at a box:

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable

this one has 8 reserved regions. Does that mean that we need to pass
them *all* 8 to the second kernel so that MMCONFIG works?

Or is it only one reserved region which is needed for MMCONFIG?

Bjorn, do you know what the detection logic should be to map the correct
reserved region (or regions) for MMCONFIG?

Now, even if we don't map that reserved region and MMCONFIG falls back
to legacy mode, why is that a problem for the kdump kernel? Why does
the kdump kernel need the hotplug device? What would be the use case?
Hotplug a SATA drive to store the memory dump to it ... or?

> Another one is that the e820 reserved ranges do not setup in kdump kernel, which
> could cause kdump can't work in some machines. To know more information, please
> refer to the [PATCH 2/2 v6] patch log.

Yah, I still don't understand *why* we need the reserved ranges in the
second kernel. Once we've figured out the *why* we can look at the *how*.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
