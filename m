Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC8DC4345F
	for <kexec@archiver.kernel.org>; Fri, 19 Apr 2024 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iC17bDBXH9rhf0eA6pbEZ0Ftjty8p1u0/nWneesqCRU=; b=KeTGGgXXkC29g3
	sbXHE4bJU+DBLDH6LwFvEd0PslfxKwPVw1jD5omaIspSyA/VsT2bExowgFzyRxrcvUh4ZoZHfPN3n
	toYaWuL3u+C3F2r7ShVia5DsCqQn8tqHDis474IHpsy+e6AIsfDnWzVJG2Gy0Y1W/DQ/mv0HjSQkA
	2HaH1/CitT1yBKc8gfY0OhTRa8NVbGg9fxmRpr65VorfMy3tXdqkL39R3Fnbi13f574Gwlmi+3BSq
	quQT9gBK0FplS+DxvcH1kGj4kzRatzedcJ6qRhl/y67AwnYyWxZTNeufejzRVncPP3VmZknYMydgL
	M0Ivh4iRGyeKEJMBQwsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoI6-00000005kuU-2E8B;
	Fri, 19 Apr 2024 13:28:34 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoI4-00000005ktj-2Ig0
	for kexec@lists.infradead.org;
	Fri, 19 Apr 2024 13:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533312; x=1745069312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/RG5qBxdULyRKxsA28Wpo5X45cb7aAWaUcDEA+9wmsM=;
  b=Q7GFCHWKOZtvtkO45qNiQd8MptzwfNjFXDzEuJkPE8MzHfTVyDyOgswt
   iVKlq7FZiumr97KpOuY9EcHGiWg2946MqUIxNcW6AQ7NIMEkLBxfxxxgc
   hwGiBYtB/tQTujADPhZ5Ur89XgAKRrdNEve/Ie+PGtqPu+tqmeTIkdDgn
   CwHCxz8bpX3FVqNynWT+MfXGoQaKPK9PufLNQFseHjQUWrh7Yq966upyd
   1mh+IokdCiGtBJWmGdd80lf++bVJMcR9ldKCFogKCwLKv32CUL0iTQcT5
   zZpxFGZltGktJpc+bzyhNKkVLkEAs4KDACSBhQWOBN9XqqmlgdUsNZrY8
   Q==;
X-CSE-ConnectionGUID: 9dr1fni/TQefXbWe8N+lKQ==
X-CSE-MsgGUID: xWaYRaflTam2Bc7hbeCd9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34531949"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34531949"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:28:31 -0700
X-CSE-ConnectionGUID: KtBqwECzQqSH2sV4He1iOg==
X-CSE-MsgGUID: 7j1cWn0ZS+WMSGDgRdQ80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23949961"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 19 Apr 2024 06:28:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B1F50FD; Fri, 19 Apr 2024 16:28:24 +0300 (EEST)
Date: Fri, 19 Apr 2024 16:28:24 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 01/18] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <lmlwekkninlquabuganez5v22yopz5beavlmflcuyyeydceicz@k3v6y3iblid6>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-2-kirill.shutemov@linux.intel.com>
 <20240418160324.GKZiFETI8U1WeaUS7_@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418160324.GKZiFETI8U1WeaUS7_@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_062832_664388_1F83AAEA 
X-CRM114-Status: GOOD (  38.15  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Apr 18, 2024 at 06:03:24PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:53PM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> > index fc17b3f136fe..8c7329c88a75 100644
> > --- a/arch/x86/kernel/acpi/Makefile
> > +++ b/arch/x86/kernel/acpi/Makefile
> > @@ -1,11 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -obj-$(CONFIG_ACPI)		+= boot.o
> > -obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
> > -obj-$(CONFIG_ACPI_APEI)		+= apei.o
> > -obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
> > +obj-$(CONFIG_ACPI)			+= boot.o
> > +obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
> > +obj-$(CONFIG_ACPI_APEI)			+= apei.o
> > +obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> > +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
> 
> If you drop the "_X86" from the config symbol, you won't have to
> re-align them. And the other config symbols don't have to have "_X86" in
> them either because this is all in arch/x86/.

Okay, fair enough. Updated patch is below.

From b020800f89ea4fce8f3698bd4ef290bba8f40b37 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 1 Sep 2023 15:42:55 +0300
Subject: [PATCHv10.1 01/18] x86/acpi: Extract ACPI MADT wakeup code into a separate file

In order to prepare for the expansion of support for the ACPI MADT
wakeup method, move the relevant code into a separate file.

Introduce a new configuration option to clearly indicate dependencies
without the use of ifdefs.

There have been no functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/Kconfig                   |  7 +++
 arch/x86/include/asm/acpi.h        |  5 ++
 arch/x86/kernel/acpi/Makefile      |  1 +
 arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
 arch/x86/kernel/acpi/madt_wakeup.c | 82 ++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 85 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2dac256b6e8d..723cd5285781 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1116,6 +1116,13 @@ config X86_LOCAL_APIC
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 
+config ACPI_MADT_WAKEUP
+	def_bool y
+	depends on X86_64
+	depends on ACPI
+	depends on SMP
+	depends on X86_LOCAL_APIC
+
 config X86_IO_APIC
 	def_bool y
 	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index f896eed4516c..2625b915ae7f 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -76,6 +76,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
 
 #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
 
+union acpi_subtable_headers;
+
+int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+			      const unsigned long end);
+
 /*
  * Check if the CPU can handle C2 and deeper
  */
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index fc17b3f136fe..2feba7257665 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
+obj-$(CONFIG_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y				+= cstate.o
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4bf82dbd2a6b..9f4618dcd704 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -67,13 +67,6 @@ static bool has_lapic_cpus __initdata;
 static bool acpi_support_online_capable;
 #endif
 
-#ifdef CONFIG_X86_64
-/* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
-/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
-#endif
-
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -341,60 +334,6 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 
 	return 0;
 }
-
-#ifdef CONFIG_X86_64
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
-{
-	/*
-	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
-	 *
-	 * Wakeup of secondary CPUs is fully serialized in the core code.
-	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
-	 */
-	if (!acpi_mp_wake_mailbox) {
-		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
-						sizeof(*acpi_mp_wake_mailbox),
-						MEMREMAP_WB);
-	}
-
-	/*
-	 * Mailbox memory is shared between the firmware and OS. Firmware will
-	 * listen on mailbox command address, and once it receives the wakeup
-	 * command, the CPU associated with the given apicid will be booted.
-	 *
-	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
-	 * firmware before the wakeup command is visible.  smp_store_release()
-	 * ensures ordering and visibility.
-	 */
-	acpi_mp_wake_mailbox->apic_id	    = apicid;
-	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
-	smp_store_release(&acpi_mp_wake_mailbox->command,
-			  ACPI_MP_WAKE_COMMAND_WAKEUP);
-
-	/*
-	 * Wait for the CPU to wake up.
-	 *
-	 * The CPU being woken up is essentially in a spin loop waiting to be
-	 * woken up. It should not take long for it wake up and acknowledge by
-	 * zeroing out ->command.
-	 *
-	 * ACPI specification doesn't provide any guidance on how long kernel
-	 * has to wait for a wake up acknowledgement. It also doesn't provide
-	 * a way to cancel a wake up request if it takes too long.
-	 *
-	 * In TDX environment, the VMM has control over how long it takes to
-	 * wake up secondary. It can postpone scheduling secondary vCPU
-	 * indefinitely. Giving up on wake up request and reporting error opens
-	 * possible attack vector for VMM: it can wake up a secondary CPU when
-	 * kernel doesn't expect it. Wait until positive result of the wake up
-	 * request.
-	 */
-	while (READ_ONCE(acpi_mp_wake_mailbox->command))
-		cpu_relax();
-
-	return 0;
-}
-#endif /* CONFIG_X86_64 */
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1124,29 +1063,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
-
-#ifdef CONFIG_X86_64
-static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
-				     const unsigned long end)
-{
-	struct acpi_madt_multiproc_wakeup *mp_wake;
-
-	if (!IS_ENABLED(CONFIG_SMP))
-		return -ENODEV;
-
-	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
-	if (BAD_MADT_ENTRY(mp_wake, end))
-		return -EINVAL;
-
-	acpi_table_print_madt_entry(&header->common);
-
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
-
-	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
-
-	return 0;
-}
-#endif				/* CONFIG_X86_64 */
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1343,7 +1259,7 @@ static void __init acpi_process_madt(void)
 				smp_found_config = 1;
 			}
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_ACPI_MADT_WAKEUP
 			/*
 			 * Parse MADT MP Wake entry.
 			 */
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
new file mode 100644
index 000000000000..7f164d38bd0b
--- /dev/null
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <asm/apic.h>
+#include <asm/barrier.h>
+#include <asm/processor.h>
+
+/* Physical address of the Multiprocessor Wakeup Structure mailbox */
+static u64 acpi_mp_wake_mailbox_paddr;
+
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
+{
+	/*
+	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
+	 *
+	 * Wakeup of secondary CPUs is fully serialized in the core code.
+	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
+	 */
+	if (!acpi_mp_wake_mailbox) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * Mailbox memory is shared between the firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, the CPU associated with the given apicid will be booted.
+	 *
+	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
+	 * firmware before the wakeup command is visible.  smp_store_release()
+	 * ensures ordering and visibility.
+	 */
+	acpi_mp_wake_mailbox->apic_id	    = apicid;
+	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * Wait for the CPU to wake up.
+	 *
+	 * The CPU being woken up is essentially in a spin loop waiting to be
+	 * woken up. It should not take long for it wake up and acknowledge by
+	 * zeroing out ->command.
+	 *
+	 * ACPI specification doesn't provide any guidance on how long kernel
+	 * has to wait for a wake up acknowledgment. It also doesn't provide
+	 * a way to cancel a wake up request if it takes too long.
+	 *
+	 * In TDX environment, the VMM has control over how long it takes to
+	 * wake up secondary. It can postpone scheduling secondary vCPU
+	 * indefinitely. Giving up on wake up request and reporting error opens
+	 * possible attack vector for VMM: it can wake up a secondary CPU when
+	 * kernel doesn't expect it. Wait until positive result of the wake up
+	 * request.
+	 */
+	while (READ_ONCE(acpi_mp_wake_mailbox->command))
+		cpu_relax();
+
+	return 0;
+}
+
+int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+			      const unsigned long end)
+{
+	struct acpi_madt_multiproc_wakeup *mp_wake;
+
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+
+	return 0;
+}
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
