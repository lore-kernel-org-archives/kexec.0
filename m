Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5EDC4345F
	for <kexec@archiver.kernel.org>; Mon, 15 Apr 2024 23:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vCzeowyUXeUM4wdOCssnu1cGyOvyg5fDRxAhk8AAnVw=; b=SOyRPyInMr9eNC
	hY9cULgi+y+VUUUyhYIoHKKFYat7EWnMtmnSMWW5ve2DWfYZpDBnv547u9zIE++hXgDyEpe+AEwnK
	f2zEjAesPDieXILS6j514kX95PKesPnpMSZLPiwF5zgxeWXb7akX3MNGby/4jAOndVGqw5U2cOsdq
	3HPZv4ZdDbdvB5JwFdh+Jt1O8utVEZGTPlDAjacdS9OE0f4vg5hKLjoM4yUEe9dzo28Y8yzZLwgfy
	n5ShohfJaRM3EhUWOiMxZb7zct/bKbIKyMWziH7jnm3Wdx2e3azaZt1henvEOwNmwXcLe7fbjz6/L
	DVIG7o3pLrwBq9dPG5rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwVfm-0000000AAWE-1aU5;
	Mon, 15 Apr 2024 23:23:38 +0000
Received: from mail-sn1nam02on20620.outbound.protection.outlook.com ([2a01:111:f400:7ea9::620] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwVfj-0000000AATr-1HfH
	for kexec@lists.infradead.org;
	Mon, 15 Apr 2024 23:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZHcLuNyPmMFVpS60MYBh4LmH/n3f9HO83EfTWfynSlzg5HvBEWYKZZdS280W1ZHf4O4JB06jXwtPIqw1XO5wn4t1ZRGK7NKVGQZSZqNpxHBPElc1d9F9wF4Rwy2NGHsMs05cIIJM+ZTsqN5m1VFKkL+ZPi2uXVV01/Y9P5j9a/XRknEuHveWSHM4UbZgbgdVOAeTweDhQnoD4lTcOiWFnZD+bz+4H37+9sDGYxok4Zt5jY5vVldmQFxbDGS0Ej/438pYN9zvP1SVrO+aJ0D8BfE58oYjzbFu7wBxEevNMPmH582tb+jyEqWmK8DQBJIvclFE9jES3ffWPcxzE8UPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=HoamId4ljSljEEi3MumwuAEx6ckiw0OTxD+HIp/LC8psW0Cr6tfRoVEluRaIx8twI8QxCaXVamXdzLiSwbdbdy20DDsB5qbIXIBU5AMFoTvKqth11duWQMksPHNb5KJ5Vdh7HMEhr79/IsBEoOY5gt42wa6UK4PAVJztd3nOyPufQt+gsaKG6deesSiFXA4Xl+9D1ccDfRnA56dVywHZ/KrvR2nZBIQq+IRGeTN5HpBb5JQ6NDB/ixyG6WUm8liBIih/zaNqqdOwMqjkrudqlW+DUVO/Hlc84C2IhU7GmO3W5AOIfJU8iDyPshdQJLrtHROPOp/LEA6k5tU2kaXkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=BylLhAqgN3qGUpWq1cCRpnuUFp8Ur59PEw4AOlui0lmtjtZ2TsdqyW99AVWeX4A7kaYdTDK3NM4lLSUlS9wD4txWIfS0cBzJymUT5ebUGiQlkZdoquDMd2WKJ9wM9erFjYSugKsrSC6nS2NkZAn+5bpX1McSYKWyWETSGEjlVq4=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:23:28 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::9f) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 23:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 23:23:28 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 18:23:27 -0500
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
Subject: [PATCH v5 2/3] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Mon, 15 Apr 2024 23:23:13 +0000
Message-ID: <1398c689a345b3d1751f4c06b5a9356738a296e7.1713222642.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713222642.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1713222642.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 22102a8b-3319-425f-f1da-08dc5da30e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rjcWVyHr5jNwmMM6Z/dUAMTfrxeSuTnclDbZTTuubGgMCGFDuxK+QEfyj6owEFc/v+D5i7VHkEWYrtcGuv0sbsvaGXG9z9c8c3yDexCqAgivpTElPDOfbwgJraW43682eHrD0tgy/paQMJq1d2vhbu7TpFs/dSmArSqs119CN6v0KG4+S8oOXgFq8Kqre3dZh9+5gO5+lfdgQGoaNbaoqnFybZZgsMU0hpuoDc1Y28Cxtu7yQg0/GZ+RCzZxBY9kOddrnaDPAAh8o4DLOnP96a5+qWY418j+hau65Fu278nnIurbvGUIYe2wmaWr50GvGfZ/GneEQ/S0o2BPLXQ6Uh6MjU7bgoLfa2dfw0fkDYI2eA3ZfCmFkH7f7Q74z7ITsqaR/y2dLpH8VsamA2hnbFbTensQCo2vM5LYpLqS27pYdgh3DG+XsiQDurxd6E/4vl80hpQq50XyfqsdYSwcVlNNJvNMkXD1L3SpGFKD2pqYsIe8g/vP69KKLpjIAy6qUInUv0X2MKrV4oAm2WdcTFjtZXL5gj2ajyAQw56mbYMgD2IW/NG2Y9KMN/QPhFgRIzEFAcjJABv/UOs8WthtyZiZvYEOfpQMzudn5HgBOfi0Yiu/iiztTWtAPi+5U9d4dgT/W9MfLfecwoHqph8SoJSzCsQd9ccu3jQJTkZVNney7dQeJ6oJQJlifSZ/OcKlLeZybO85Lcxdv1Aq3JfrbM3lYTPtIXVIutCp/SPre0CcINcQv/v3674mOWVBUhO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:23:28.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22102a8b-3319-425f-f1da-08dc5da30e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_162335_397267_4F881790 
X-CRM114-Status: GOOD (  11.33  )
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..3b9f96b3dbcc 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
