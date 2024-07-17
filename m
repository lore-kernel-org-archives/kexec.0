Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC44C41513
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+4k9kIHe8xlKfXyz7toRsErfDTeSOS4XP7Q2g15im6I=; b=gEO0QvfOsdy6x4
	VAhdTL9IjY4ntbs0dt8lkD7MhC94Fy7z/3nyaBCjJwroOtU09SNyT2mP1KJiY7yEt3cF2czmDioCH
	w26fOtjGEXEZPBppTUFy8g2vlO774QJkqBXQHH9ywsXMR7rntlE5FZyqPm7F9fArwGiZBMjd1hlvI
	Nlq4e7phktp2JgX6khVmX+5BDaoC6XWdvwLSlLyTg4UPs4x2fkv8j2iHtZZUnS/Yz3x9p3dZwTlD3
	njWpcrqVBwJsXaR0W3/9KZvicM0SD5JWf/tD0IR67RxbI2d5YtwkUnLWD4hv0ZotQgq8/NmAZs7Ai
	Mjn9/ul6qdJ+md+tk5cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCG9-0000000Eysw-1QAS;
	Wed, 17 Jul 2024 21:32:25 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCG6-0000000EysL-2oVI
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 21:32:23 +0000
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HDaBoL025060;
	Wed, 17 Jul 2024 21:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pps0720; bh=AEHglC0ER
	2F2UT1A2l5u2EFWiKzkYSHcBmHpYY1hFJQ=; b=HpijY0CBnnYL6mrCmUVcxphF4
	vX1tR53y0XsXxotZa9UEPDvKtk7rz0djZza0gFm46HQogRVis4J6FS8wGxA7rzxL
	aDAMRZtit/Wk3/ZLAtpJjn87ZWdImFUzbJIkqjHG/YOX6xhrtK1XF8HgUE2hhtAW
	35KupU+JuqGpx9kVRf8xXDunoADPe2RFFFuoOdbXxh60nujiYW2zXk79qxzt3HdU
	cArUt6cgss9yl/9briaBr3sfkbLiX9l3x2lnZb8sWCVdJgh92F93+aJQ6+Ppb947
	lmm398phhWzCJktBxxJsG5V9BiLWRfa36yONZ4fIFbjuvmkKMpEzO6m0itjgw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 40dwf02w6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 21:31:26 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B9F088059E3;
	Wed, 17 Jul 2024 21:31:24 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 5730780478F;
	Wed, 17 Jul 2024 21:31:22 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 3C152300BB4CB; Wed, 17 Jul 2024 16:31:21 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v3 1/2] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Wed, 17 Jul 2024 16:31:20 -0500
Message-Id: <20240717213121.3064030-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717213121.3064030-1-steve.wahl@hpe.com>
References: <20240717213121.3064030-1-steve.wahl@hpe.com>
MIME-Version: 1.0
X-Proofpoint-GUID: VoHJkPaaSpjVEq-jCxqVNjto46UGH-jy
X-Proofpoint-ORIG-GUID: VoHJkPaaSpjVEq-jCxqVNjto46UGH-jy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_16,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170162
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_143222_722982_B8730722 
X-CRM114-Status: GOOD (  23.35  )
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

From: Tao Liu <ltao@redhat.com>

A kexec kernel boot failure is sometimes observed on AMD CPUs due to
an unmapped EFI config table array.  This can be seen when "nogbpages"
is on the kernel command line, and has been observed as a full BIOS
reboot rather than a successful kexec.

This was also the cause of reported regressions attributed to Commit
7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
should be mapped.") which was subsequently reverted.

To avoid this page fault, explicitly include the EFI config table
array in the kexec identity map.

Further explanation:

The following 2 commits caused the EFI config table array to be
accessed when enabling sev at kernel startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

This is in the code that examines whether SEV should be enabled or
not, so it can even affect systems that are not SEV capable.

This may result in a page fault if the EFI config table array's
address is unmapped. Since the page fault occurs before the new kernel
establishes its own identity map and page fault routines, it is
unrecoverable and kexec fails.

Most often, this problem is not seen because the EFI config table
array gets included in the map by the luck of being placed at a memory
address close enough to other memory areas that *are* included in the
map created by kexec.

Both the "nogbpages" command line option and the "use gpbages only
where full GB page should be mapped" patch greatly reduce the chance
of being included in the map by luck, which is why the problem
appears.

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
---

Version 3: Do not rename map_efi_systab to map_efi_tables, and don't add
'config table' to the comments, per Ard Biesheuvel request.

 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17b..9c9ac606893e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -87,6 +88,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
