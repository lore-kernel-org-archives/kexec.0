Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19054CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UCBpSoWd+DzhR5w/L2qTUePdSLNQuDLLzBvZ0vft3Fw=; b=2JtzFQR5TSZ2ftteAvmMxUxY45
	3VzcoC2AwWuB8/+jfmrRZRgVjCKm/zfV+wWMb29nzsIlmyrkew6l2H8YcQoMU8kafauNSleICUmra
	CQzhy+7WDxlANySX6KoRysj4zAJOVKmowL3EiDvQPBgdfLM+wRJePqGzUEQTc/+37QBTlilQNdTLW
	pR4C4qLcDvtW6rLgwIUvt+Sprio8MTlmXzob/a5RKPRTBt51C5U3rnV7ay5UpXFhNm5FPtAl3qtGp
	/9loBZOC8HStvWf/pvlu+7In3cOF38ipWVc715Y496MGOHSGVyVfZxtJctyOoIaEwOLOmdRr899ep
	3JvX6Bbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzt8-00000009UVu-3J12;
	Fri, 15 May 2026 21:16:06 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzt3-00000009UP2-2yGG
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:16:04 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1354403c610so394523c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879761; x=1779484561; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCBpSoWd+DzhR5w/L2qTUePdSLNQuDLLzBvZ0vft3Fw=;
        b=FzahcbNyQT8iEbsCpt0C03aNM2Wb0rvVQIzSAhfu8sWY2umqzTQ+Fot+5fUwg9GH0I
         yQWu2htZcp7tPIPfkxLVhH+Tca8/F+VnLehJ25aa02+9UIC43NhzOBpePf5pi4i0CIFA
         FGYIuSBh8tM+kC8gKd95/jwhXmCV+26VJfb1vBjHkDYlPDXOQBY2T2wVtO6hKllFauwl
         u5M6ZLbpp9iHRgI6JtCDJ/SYbUNd0/zsRn8XsAS+JMHETuPpA/vM0y5gcEFwYkp9UU2J
         CZIYH8HkkC3MnRvVNJiF7DCwZJtdqQuFt9V0PJoajacd/qa0/37bcv8jwkAKwaac482Y
         Et1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879761; x=1779484561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCBpSoWd+DzhR5w/L2qTUePdSLNQuDLLzBvZ0vft3Fw=;
        b=SMlLHYCm4mN1X+umkSYGpNM59cKBAXIfDrWtFVpe0lBDaEz0BUx5NY3NCTR9fllcoy
         idUeHrafMX3o37IxqNSYpj24ek/Qsg631MWbHV38FXgWRqLSKMZ7sWQNhDwmadmX0t+B
         y+i6QLwhCc/C2KZRzsYkiOejmnJJ5NTJK56fgvlaIdE0wLR++K1a2zZFdL+gLscjob7H
         cQ/2jyDX17wkkn5z1sMDLTzmgRCd0Ext/1/lMkK7ti9WdVXJkiCE9u50fzbCExzVPJ+0
         3VfOFdSO8T0fQb69rAYfb5z0kEOC9f4o15J+ZhfQvOG7/UyaN3haie3bRV5+85DXu1qZ
         LQcg==
X-Forwarded-Encrypted: i=1; AFNElJ+Sy+zIO+6rMEtlm+fM97c2FEwmludFcN1ma2uyCE7fp7RxyVrBfhbaT/lqkV1/Lx/qqy6SXA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ3HjIn5s7nxXvGJCXsSWAocHKuBOXS8Fc0kXtB0IrfPpFZPHO
	83GRinr3EeAwoazMo6AtW4rffijEOBiAfVYal4KjvH2O1Xo1eTG9vRB4
X-Gm-Gg: Acq92OFcUP+zbtgC4J4ZbLkjvRp5tSjNjvMWV6qATi8xrv/CJaK+XXdw+6fV8yIRskE
	1C5QWXQhyz1ZtabkkIYOvqywmBQRcrgteUPT4YD5XsUXbnxwDc1cRFZsWsNgEgaCvWuZhdRJ8si
	kOkVNe4YGCdM7s/bYwuFrhKfsWdBMiFNQTErqtIxU2jaOXzAufFGW5CpB9IsA3VNZKC1PlnxzGc
	CvHlCZnnXZQyAYjOUuCd64ivl0utpI1bGIHbkuwaLSpiVmofD+q8dWStWE1oVCunHEPhpsjqs/3
	6FMBkKrItVaJ+OkerAqsofxV6qBhj4SkA8yEethqqEqmmHgSTZsT+PgU6inaZKJ6n2bCajq+qD3
	AZ658XSWIO9Mm4W8t/CEAvQwrXtwElEHjirX+JpYtLU7qEBVIza6Lh/rpI9ImK73x/oalDVpDVy
	vvX/bxBPNOzziJ4BBwZl9kWsAnlJ8+QSo=
X-Received: by 2002:a05:7022:1a85:b0:12d:d972:b96e with SMTP id a92af1059eb24-1350542e8e5mr2758254c88.20.1778879760953;
        Fri, 15 May 2026 14:16:00 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm11529163c88.0.2026.05.15.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:16:00 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 38/38] x86/boot: Legacy boot DRTM support for Secure Launch
Date: Fri, 15 May 2026 14:14:10 -0700
Message-ID: <20260515211410.31440-39-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141601_779780_C1F3EAC7 
X-CRM114-Status: GOOD (  26.06  )
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

From: Ard Biesheuvel <ardb@kernel.org>

Implement Secure Launch D-RTM of the decompressed kernel via a
callback interface exposed by the Secure Launch Resource Table (SLRT), a
reference to which is added to struct boot_params.

This permits a boot loader to set up the Secure Launch, allow the
decompressor to execute up to the point where it would otherwise boot the
core kernel, and at that point, perform the Dynamic Launch Event in a
architecture/vendor specific manner. This is similar to how EFI boot
achieves this, using a EFI protocol exposed by the boot loader.

This requires that the decompressor unpacks the kernel into the buffer that
it was started from itself, and so physical KASLR needs to be omitted
(although the boot loader is free to place the decompressor at any
suitably aligned locations in system memory, and so it can perform the
physical randomization itself).

It also relies on the demand paging logic in the decompressor, to ensure
that the SLRT and the entry point it describes are callable, at least to
the extent that allows the callback code to re-establish its own
execution environment.

Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 Documentation/arch/x86/zero-page.rst  |  1 +
 arch/x86/boot/compressed/misc.c       | 51 ++++++++++++++++++++++++---
 arch/x86/boot/compressed/pgtable_64.c |  7 ++++
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
index 45aa9cceb4f1..dd98b467929c 100644
--- a/Documentation/arch/x86/zero-page.rst
+++ b/Documentation/arch/x86/zero-page.rst
@@ -20,6 +20,7 @@ Offset/Size	Proto	Name			Meaning
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
 070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
+078/008		ALL	slr_table_addr		Physical address of Secure Launch Resource Table
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e3b5177bfa6f..eaaface4cd7d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -17,6 +17,7 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <linux/slr_table.h>
 
 /*
  * WARNING!!
@@ -391,6 +392,36 @@ static void early_sev_detect(void)
 		lines = cols = 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+static void sl_initiate_launch(unsigned long table, unsigned long base)
+{
+	struct slr_table *slrt = (void *)table;
+	struct slr_entry_dl_info *dl_info;
+	struct slr_setup_dlme dlme;
+	dl_launch_func launch_fn;
+
+	dlme.dlme_base = base;
+	dlme.dlme_header_offset = mle_header_offset;
+	dlme.dlme_table = 0;
+
+	if (!slrt)
+		return;
+
+	dl_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+	if (!dl_info)
+		return;
+
+	launch_fn = (void *)dl_info->dl_launch;
+
+	/* Do the Dynamic Launch Event */
+	launch_fn(&dl_info->bl_context, &dlme);
+}
+#else
+static inline void sl_initiate_launch(unsigned long table, unsigned long base)
+{
+}
+#endif
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -491,10 +522,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	debug_putaddr(trampoline_32bit);
 #endif
 
-	choose_random_location((unsigned long)input_data, input_len,
-				(unsigned long *)&output,
-				needed_size,
-				&virt_addr);
+	/*
+	 * When doing a secure launch, the actual launch will be initiated by
+	 * jumping back to the bootloader. Omit physical KASLR in that case, to
+	 * avoid trampling on its code or data inadvertently.
+	 */
+	if (!boot_params_ptr->slr_table_addr)
+		choose_random_location((unsigned long)input_data, input_len,
+				       (unsigned long *)&output,
+				       needed_size, &virt_addr);
 
 	/* Validate memory location choices. */
 	if ((unsigned long)output & (MIN_KERNEL_ALIGN - 1))
@@ -528,6 +564,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	debug_puthex(entry_offset);
 	debug_putstr(").\n");
 
+	/*
+	 * Secure Launch involves calling back into the bootloader, so this
+	 * needs to happen before disabling exception handling, to ensure that
+	 * the entry point will be mapped on demand if needed.
+	 */
+	sl_initiate_launch(boot_params_ptr->slr_table_addr, (unsigned long)output);
+
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 3e9d651da73e..f82094669ac0 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -124,6 +124,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 
 	l5_required = !cmdline_find_option_bool("no5lvl");
 
+	/*
+	 * Don't change the number of levels when doing a Secure Launch. The
+	 * Secure Launch stub will take care of that if needed.
+	 */
+	if (bp->slr_table_addr)
+		l5_required = l5_enabled;
+
 	if (l5_required) {
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 8155fa899f50..bc2ef37096af 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -121,7 +121,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 slr_table_addr;				/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
-- 
2.47.3


