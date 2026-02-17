Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456CFE68140
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j4A53eO8aaanQ6ygp53jr6CDnyXo0/FyyAuhKBZ5z/E=; b=zRs8oemmhAT4bE5E2ip1JtLngK
	+7u0pbnxnFq2HV3JZjMi3Ngucbcy66Csh81MHQcc9IhJUITu+/+NZjtEFGtHYGStmexECp1wtbq79
	ZnwMTau1XAXYVlktHu6TV9Dp+6j3k6hwcKOvNoXTZ+T/QMEU467dBHoJ0so1vQqoHNrhKDde4lTIZ
	c2bZOtDk0gJAiVWeIlUjhw4/77spMHpFxSLaZ+c/ljiHQ+U6o7q+KoYIkJhfySj+Lg6pxo5wUQKs/
	8bjRbkHwzIEhucRjSjYREgAPJtzyjRTBeovgKryaKznn/Nu7NVVCQOcmel8JtNMFFWc5xD8K4luhS
	vJF2/j7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsG5F-00000007oP4-3yv1;
	Tue, 17 Feb 2026 08:05:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsG5D-00000007oOY-2BGd
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 08:05:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771315521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=j4A53eO8aaanQ6ygp53jr6CDnyXo0/FyyAuhKBZ5z/E=;
	b=HHSfJJM3udToiFcoVxlqW7P+hLZXFeF7DWuv2Ziad1g9+P6lM0K7/7ir3IoaeLGnUR26tV
	ra5jboTPPIUw13oN0J9wGp9ARl8xY/iX3fxRh3yuRx2RBWPoBTx8ju+/gfYZ4lgZX+lCPz
	1orsqfcSTiSodU3ampSfTVSNGDWXCdw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-E9ebRdzKNZyQE7MxqXtdWg-1; Tue,
 17 Feb 2026 03:03:43 -0500
X-MC-Unique: E9ebRdzKNZyQE7MxqXtdWg-1
X-Mimecast-MFC-AGG-ID: E9ebRdzKNZyQE7MxqXtdWg_1771315422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA24B1955D88;
	Tue, 17 Feb 2026 08:03:41 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60F03180058F;
	Tue, 17 Feb 2026 08:03:36 +0000 (UTC)
Date: Tue, 17 Feb 2026 16:04:14 +0800
From: Dave Young <dyoung@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org
Subject: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Message-ID: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ogOMqc0J-qCnh-Qk9uyqgc_fwvfFD0VHL7yz2fUMvQM_1771315422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_000523_636150_3B6FBC8F 
X-CRM114-Status: GOOD (  13.46  )
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

Kernel panic occurs during a kexec reboot when EFI runtime services
are not enabled in the first kernel. The issue is that the second
kernel cannot find the ACPI RSDP address during boot.

In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
However, kernel decompression has moved to the EFI stub for EFI boot.
Therefore, the x86 EFI stub must also be updated to store the
acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
can find it.

(Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
reboot will still utilize the legacy decompressor path, so the original
code remains functional though some cleanups can be done later.)

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-x86/drivers/firmware/efi/libstub/x86-stub.c
===================================================================
--- linux-x86.orig/drivers/firmware/efi/libstub/x86-stub.c
+++ linux-x86/drivers/firmware/efi/libstub/x86-stub.c
@@ -484,6 +484,22 @@ static void setup_quirks(struct boot_par
 	}
 }
 
+static void setup_acpi_rsdp(struct boot_params *boot_params)
+{
+	u64 rsdp_addr;
+
+	/*
+	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
+	 * ACPI_TABLE_GUID because it has more features.
+	 */
+	rsdp_addr = (u64)get_efi_config_table(ACPI_20_TABLE_GUID);
+	if (!rsdp_addr)
+		rsdp_addr = (u64)get_efi_config_table(ACPI_TABLE_GUID);
+
+	if (rsdp_addr)
+		boot_params->acpi_rsdp_addr = rsdp_addr;
+}
+
 static void setup_graphics(struct boot_params *boot_params)
 {
 	struct screen_info *si = memset(&boot_params->screen_info, 0, sizeof(*si));
@@ -1017,6 +1033,8 @@ void __noreturn efi_stub_entry(efi_handl
 
 	setup_graphics(boot_params);
 
+	setup_acpi_rsdp(boot_params);
+
 	setup_efi_pci(boot_params);
 
 	setup_quirks(boot_params);


