Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24029C0218A
	for <kexec@archiver.kernel.org>; Tue, 28 Jan 2025 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7uGPDiM/aT21JK8Udc8cgfvM3p7HgJwTb2VLlWtFODk=; b=C2LwSSwLkwXKdkv27GvfBm/r2Z
	cRIaWYUjidYbIINFErulvds6YXGZdKYkQ9akRnHwQ7z1sAn0SlFVIO8iSo80diZo1cskMyEJzyHlC
	BvXirwFl9h/jn659kP7NqLzQTBj8sGfy/JD8bsyD9H4/fBfeYqJcXOWi9CBXdBmdB5yglYA+rVYdH
	RN97zZA0AmTelQ5CIfqQzPJytk+iGGEN75fk0DniPat83qkCvTKhN/kCmodhnS4DxEB/x7j6zYWIG
	G9pqAY7Cc0V5kPFKdL4mVjvDwJ9qEbF5OpGvfh0Qne8c0G6zVcRRIxN2sw8aVMcTGH0ld4YR65Urh
	WsPC59yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tclhn-00000004yKl-3sMp;
	Tue, 28 Jan 2025 13:32:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tclhl-00000004yKM-1dmt
	for kexec@lists.infradead.org;
	Tue, 28 Jan 2025 13:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738071155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7uGPDiM/aT21JK8Udc8cgfvM3p7HgJwTb2VLlWtFODk=;
	b=Wjx3g6jKFDqhYQ8sgAB6YfZQyKj7wok01RIthU6neQp4twW/EqPoF0HkInvodV6rm8Ukeb
	tgk/DRyiRzTHkcZqfGjGpGYA8r3EpLh76VM5ksY3voZKRvGg69GlKoXt73OmEJQo0mU44+
	+VHxZgdECDNSr4V9t9+VKj7tct/vbOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-kvesU07HPAmL6V3NHYGJtg-1; Tue,
 28 Jan 2025 08:32:31 -0500
X-MC-Unique: kvesU07HPAmL6V3NHYGJtg-1
X-Mimecast-MFC-AGG-ID: kvesU07HPAmL6V3NHYGJtg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 090C61800A11;
	Tue, 28 Jan 2025 13:32:24 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E1E919560A3;
	Tue, 28 Jan 2025 13:32:16 +0000 (UTC)
Date: Tue, 28 Jan 2025 21:32:31 +0800
From: Dave Young <dyoung@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
	kexec@lists.infradead.org
Subject: [PATCH] x86/kexec: export e820_table_kexec to sysfs
Message-ID: <Z5jcb1GKhLvH8kDc@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_053237_502018_CF749670 
X-CRM114-Status: GOOD (  23.33  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Previously the e820_table_kexec was exported to sysfs since kexec-tools uses
the memmap entries to prepare the e820 table for the new kernel.

Commit[1] introduced e820_table_firmware and changed the behavior to export
the firmware table instead.  Originally kexec_file_load and kexec_load
both use e820_table_kexec. Since the sysfs exported entries are from
e820_table_firmware people now need to tune both tables for kexec.

Restore the old behavior so kexec_load and kexec_file_load work with only
one table update.  The e820_table_firmware is used by hibernation kernel
code and it works without the sysfs exporting. Also remove the sev
e820_table_firmware updating code.

Also update the code comments here and drop the comments about setup_data
reservation since it is not needed any more after commit [2].

[1]: commit 12df216c61c8 ("x86/boot/e820: Introduce the bootloader provided e820_table_firmware[] table")
[2]: commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table for setup_data")

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c  |   20 ++++++++++----------
 arch/x86/virt/svm/sev.c |    1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

Index: linux/arch/x86/kernel/e820.c
===================================================================
--- linux.orig/arch/x86/kernel/e820.c	2025-01-28 11:27:02.372171910 +0800
+++ linux/arch/x86/kernel/e820.c	2025-01-28 20:36:00.031075385 +0800
@@ -28,18 +28,13 @@
  *   the first 128 E820 memory entries in boot_params.e820_table and the remaining
  *   (if any) entries of the SETUP_E820_EXT nodes. We use this to:
  *
- *       - inform the user about the firmware's notion of memory layout
- *         via /sys/firmware/memmap
- *
  *       - the hibernation code uses it to generate a kernel-independent CRC32
  *         checksum of the physical memory layout of a system.
  *
  * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
  *   passed to us by the bootloader - the major difference between
- *   e820_table_firmware[] and this one is that, the latter marks the setup_data
- *   list created by the EFI boot stub as reserved, so that kexec can reuse the
- *   setup_data information in the second kernel. Besides, e820_table_kexec[]
- *   might also be modified by the kexec itself to fake a mptable.
+ *   e820_table_firmware[] and this one is that e820_table_kexec[]
+ *   might be modified by the kexec itself to fake a mptable.
  *   We use this to:
  *
  *       - kexec, which is a bootloader in disguise, uses the original E820
@@ -47,6 +42,11 @@
  *         can have a restricted E820 map while the kexec()-ed kexec-kernel
  *         can have access to full memory - etc.
  *
+ *         Export the memory layout via /sys/firmware/memmap. kexec-tools uses
+ *         the entries to create an E820 table for kexec kernel.
+ *
+ *         kexec_file_load in-kernel code uses the table for kexec kernel.
+ *
  * - 'e820_table': this is the main E820 table that is massaged by the
  *   low level x86 platform code, or modified by boot parameters, before
  *   passed on to higher level MM layers.
@@ -1176,9 +1176,9 @@
 		res++;
 	}
 
-	/* Expose the bootloader-provided memory layout to the sysfs. */
-	for (i = 0; i < e820_table_firmware->nr_entries; i++) {
-		struct e820_entry *entry = e820_table_firmware->entries + i;
+	/* Expose the kexec e820 table to the sysfs. */
+	for (i = 0; i < e820_table_kexec->nr_entries; i++) {
+		struct e820_entry *entry = e820_table_kexec->entries + i;
 
 		firmware_map_add_early(entry->addr, entry->addr + entry->size, e820_type_to_string(entry));
 	}
Index: linux/arch/x86/virt/svm/sev.c
===================================================================
--- linux.orig/arch/x86/virt/svm/sev.c	2025-01-28 20:21:32.253078107 +0800
+++ linux/arch/x86/virt/svm/sev.c	2025-01-28 20:23:19.653201528 +0800
@@ -198,7 +198,6 @@
 		pr_info("Reserving start/end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
 		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		if (!memblock_is_region_reserved(pa, PMD_SIZE))
 			memblock_reserve(pa, PMD_SIZE);
 	}


