Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF8C48BEB
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QsUnkoEU/8ZZKCBQDO1SlrYvj99SlPKm3KXk4YnjqVI=; b=lnOPGty+ykYY0u
	4MhNjHqyLv/eSZoPbloW89xfSxk8l0VYMdyFdqFa4uk2c64s9yrrM60BauTXmG/AQC+e5nqtPRgkD
	0R017ju+i962yREf1mJAHuehBmmu8QafPC7xCHS+Fi8Q9+8NRSxm6dmlmhstDpGoxBm18nM87NXfy
	+VgGg80jG0kk438QrdhTsk4uZWp4D7tk/KynbJ/h0HwJ4xIuMOyLqgi0ozWTlaNlKVR8GLgbC3tQ0
	ECp1wftPAkRsEGOWqfsa6LQoHVoOZqcYdlgzVCvyTZs7gwZ5hRz+lpTGdV4Jvy5mn1pj1UCg/lNmg
	4QxBD3wTxEv4BAmn9QCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNnh-0000000EQdp-0JPK;
	Wed, 14 Feb 2024 22:32:21 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNnT-0000000EQTz-1x0p
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 22:32:15 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELiRJJ022678;
	Wed, 14 Feb 2024 22:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=LywYV7sKOLgcRW6dEU5AQlOwu5jlNOpmyybhEKQBFTU=;
 b=GafnFw2eABZO4lj7v9fXjWJdBUyJKZDU7FdbeU9CvB6420yuZxeKEZh+v2I8qeNffQAE
 NgZs4j7tgGgequMTvhI0U1lg9YAbg14dayb7B0s5DkqhEV253dHbc9HOYf1ORUbYmn5a
 lFIH0mCHjMhOK+y3VVwvm83Vk+XPjp7nJB1MXSmN3LhC6bLypuvkHqEwmqyUweJPD6rj
 T1k5VRMKbwFFGGrsf4Z9oT7I/KZON3AORKBOOEMX0QjT4vMFFVYlTxH4/EmDSdkge5iG
 Pm7PHPtHPmvAdukUxQO3ecQZG8Zu2X2t7k6AQbstXFQyn0q1zJ/YJBo7JFp3gcMdJgw+ bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppghkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EM0KMa000657;
	Wed, 14 Feb 2024 22:31:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVO004281;
	Wed, 14 Feb 2024 22:31:47 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:47 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
Date: Wed, 14 Feb 2024 14:18:47 -0800
Message-Id: <20240214221847.2066632-16-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: jd8QLRG0hZFTbiXK0o9sbVAzU9z96nCn
X-Proofpoint-GUID: jd8QLRG0hZFTbiXK0o9sbVAzU9z96nCn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_143207_618457_8889AA89 
X-CRM114-Status: GOOD (  19.15  )
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

This support allows the DRTM launch to be initiated after an EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress. This has to be
called after the EFI stub does Exit Boot Services.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..4df2cf539194 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,6 +9,7 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/slr_table.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 	return EFI_SUCCESS;
 }
 
+static void efi_secure_launch(struct boot_params *boot_params)
+{
+	struct slr_entry_uefi_config *uefi_config;
+	struct slr_uefi_cfg_entry *uefi_entry;
+	struct slr_entry_dl_info *dlinfo;
+	efi_guid_t guid = SLR_TABLE_GUID;
+	struct slr_table *slrt;
+	u64 memmap_hi;
+	void *table;
+	u8 buf[64] = {0};
+
+	table = get_efi_config_table(guid);
+
+	/*
+	 * The presence of this table indicated a Secure Launch
+	 * is being requested.
+	 */
+	if (!table)
+		return;
+
+	slrt = (struct slr_table *)table;
+
+	if (slrt->magic != SLR_TABLE_MAGIC)
+		return;
+
+	/* Add config information to measure the UEFI memory map */
+	uefi_config = (struct slr_entry_uefi_config *)buf;
+	uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
+	uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
+	uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
+	uefi_config->nr_entries = 1;
+	uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
+	uefi_entry->pcr = 18;
+	uefi_entry->cfg = boot_params->efi_info.efi_memmap;
+	memmap_hi = boot_params->efi_info.efi_memmap_hi;
+	uefi_entry->cfg |= memmap_hi << 32;
+	uefi_entry->size = boot_params->efi_info.efi_memmap_size;
+	memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
+		strlen("Measured UEFI memory map"));
+
+	if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
+		return;
+
+	/* Jump through DL stub to initiate Secure Launch */
+	dlinfo = (struct slr_entry_dl_info *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+
+	asm volatile ("jmp *%%rax"
+		      : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch(boot_params);
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
