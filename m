Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D95CD1284
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ggqsjy9PFzNX7damOK77mgqThz5evALkNKfimVFAOAo=; b=eznJHCpMd4A1M+
	pU9s2RNuJzRwChWr0pKTB0GgzzpTR77lS8DU/cUBPH/11NzULMSe6JGSSgU/i0BZRXXwvMNYg8arj
	Y1W4+4Q/3b1aJ5kqXKAYpHXMlgAB7Zu0IgRcYw4/hUgranFk/jVMHBPewc09JPwq0aMVmT9xMXGM1
	jXlO7rPq4Z895K7oOtlTF1GygxrZ5p9Cg77oGepUo6FTH+NUXiGHx49GR5HV9iY9iuzn8ZlF9wIuw
	YsrNsZkoJ+px0wAkNyq+YP6UfYq/UUq7gq7pRWc8lPWyfeQWKVN2ILhky69fUqz5QflZ3hiJAU4Wy
	mivxP14hnXRWPpoGzDDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWFL-00000004Xu8-1gLY;
	Thu, 04 Apr 2024 23:11:51 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWFI-00000004Xri-11Fj
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 23:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk7YTyPwagNLY87Ne0bpZu/1hpXeAvL3sHk21OZx8ugXe3kPEqFsCrZmMK8mPOfyhwRpaIzV5SAwHzGGnUisGk4dVHxvaYqS/zlUWjXB9RJ+u7RMpBCzujl1xJWSvylIkSW+yRplsgHoc9Kgd9AC/5utbrntpGGUrfWeFRSlxkFBfUQA5tC2V8sckBnBhN/LuePER8W5XOsZLJJzrkIPtseOupKUfcgoiW2VQKXysC7v7NijhaWZa0i7ie0kcaD+zT9OcX3IMxLKx89MYXSQalc4vHF/HNartPknSES8OO3+S+Z6TLnqykBKo/CtI+y0HyQC9kIlZgfkXzG0H/5I2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuJLmiJCuKYv3wZ3trwzzFudM6kzyFcz8ixqVB+ZMHw=;
 b=jLlqjGQselHMj+wxLBLzizlJAPvxG8x3Bp06A/QyDTN8/kDN1RzD87gl9RxZM+shmJJR3F16XK9vA6d07XMZ4HSRNjhf9FmTzSLFH2JxBDz5l1RvNyR8tdL8aE00jaySMhm6o+5UmDkWnmnDgFaIluGXLpiW1vZu9Vy+JI1ZpYUXQKLdV5QopHfSSG7q4sHzHvOCLvRGjWO//AMZHC7NNuaby+invnMIG3w8ICxAoylZkSP8Ea2tH1oLBibyr6wGgaSBmsL8pPdqeay0R08QQnUa1W7q5+39BvGBzsP0YTXu2hdHbLvxraDCgtClDJgs0IilhZFLo6lknXxnl1jqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuJLmiJCuKYv3wZ3trwzzFudM6kzyFcz8ixqVB+ZMHw=;
 b=olgq5bH5P+EsfZI4m4NKOF9a6qOK0rxbVxishCXBn3X7ERv1+mLO+mfvGaGIH5ZHHIa77tTwVSf2nDUQ3PCcsM5TpjELc3jy6F3tz1HbkeE+rPoUDPdfeW+Fo9pYva5P/R93q7dOPoZQr2LqCPNpNjCUiDALvKgWpHyiPm0pL2s=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 23:11:43 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 23:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:11:43 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:11:41 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Thu, 4 Apr 2024 23:11:32 +0000
Message-ID: <1027427fafa350a41234f5061c8c48fc77c58326.1712270976.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712270975.git.ashish.kalra@amd.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com> <cover.1712270975.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a8799-0c0b-4058-4d26-08dc54fc97d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmZXZHfXzY9AugVggxEAWz2PF33czLQQUOBnw3Yihz4Dl5XF7PXADSSdI9Ut1Cb7hn9bfswpjXp0Mq/R6godFX3lcRqYU8h5VgVFp/f/7VMexvlIMeKbzE1Dpywcj5y4IYjVJwfqvfLtbeB23RmUyvQ1EjnD+kjTykjQe7QDErodwXVuC1XXqDFh0Psb7jYKR6lei6gUh05Ouxzg/0F/LzVHgk9L3PAMbTVu07evIrR9kM5GZicpgm2CpjfRv3S22aPlo9kJR5Yc8KUQ8iw8+m8X5hidEHUlXZmIII463L61NJo9xWZCdKnDGq9di4ptSlMnObIZze8Zoh4pYsqbJcCGW2cZcTUXpW/onrSzr8Ve88iLxUpHAD9w3F5EHhCkkPiRx/SNjwCS/sfELJN0RThVO2djXYRIqOoRo0EFEjOQ6pkcROlwWD63KP7GtJaju4tkrRfDbjFwjcS9uLQGJYknWCcQyKqv7aYlPrERSf73Jy1MwFjLhAyxhEnIiUS58XRGTDqyS51IyPsIfOscYYfUj0XN3tHp1FJFENNqqQdGs3/CvMlaXWgOwBdnBDM0TsVSRUgm47b9K2LyVwNSllSt+rAKw5RbTls7bPd+knmzws8egIchG+ZE5kF6/Oor+KOIfJp6UlA345XKbxQsqmP3gdLGx31ymPbl8gk4EY3jnaV0HS9IxKKO8cczoKRpqI2oQy3nb3+fNSQRHpFN820c8fJnkBBic2+1eXWHgAw9/LUrnQfXp1aA7Kss8F4x
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:43.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a8799-0c0b-4058-4d26-08dc54fc97d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_161148_369519_81BE8270 
X-CRM114-Status: GOOD (  13.89  )
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

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM during kernel decompressor
causes guest termination as boot stage2 #VC handler for
SEV-ES/SNP systems does not support MMIO handling.

This issue is observed with SEV-ES/SNP guest kexec as
kexec -c adds screen_info to the boot parameters
passed to the kexec kernel, which causes console output to
be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is
preferable to get the console output only on serial, hence,
skip accessing video RAM during decompressor stage to
prevent guest termination.

Serial console output during decompressor stage works as
boot stage2 #VC handler already supports handling port I/O.

Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/boot/compressed/misc.c | 6 ++++--
 arch/x86/boot/compressed/misc.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..47b4db200e1f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!sev_es_enabled()) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..3c12ca987554 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -37,6 +37,7 @@
 #include <asm/desc_defs.h>
 
 #include "tdx.h"
+#include "sev.h"
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
