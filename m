Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aW4IJ-0006HL-PI
 for kexec@lists.infradead.org; Wed, 17 Feb 2016 15:45:37 +0000
Received: by mail-wm0-x235.google.com with SMTP id a4so34077114wme.1
 for <kexec@lists.infradead.org>; Wed, 17 Feb 2016 07:45:13 -0800 (PST)
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH 0/2] ACPI, x86/efi: Remove ACPI BGRT tables for kexec 
Date: Wed, 17 Feb 2016 15:45:08 +0000
Message-Id: <1455723910-16710-1-git-send-email-matt@codeblueprint.co.uk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>

Based on Dave's report that the BGRT image regions are being accessed
on kexec reboot (which by that time contain garbage),

  https://lkml.kernel.org/r/20160127112044.GA2961@dhcp-128-65.nay.redhat.com

the following patches simply delete the table when doing a kexec boot.

This is part of a wider compaign to stop kexec-specific code from
leaking into all parts of arch/x86. Instead of sprinkling "if
(efi_setup)", kexec should be shaping the platform information to more
accurately describe which features are still available, so that
existing drivers work transparently without kexec quirks.

Matt Fleming (2):
  ACPICA: Tables: Add function to remove ACPI tables
  x86/efi: Delete ACPI BGRT when booting via kexec

 arch/x86/include/asm/efi.h    |  1 +
 arch/x86/kernel/setup.c       |  4 +++-
 arch/x86/platform/efi/efi.c   | 38 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |  3 +++
 5 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.6.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
