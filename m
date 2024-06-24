Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1E9C30653
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=07iTsFwufDw3BFZNZ7Xi1OpsyK9CQC9ePG1N0EgQCt8=; b=0pa77P9UzYdFCq
	sm+AH7RNDtvX3pZ/h9x8STqhpenRS0kv9lQVGd53wMz5PkWLKBha87QLTJ8ekr3TQQ1jl2kPyaQNI
	oS8YuqNpo9cI9RNGVjBAa/VLoHJe9iVNKHmZ2UmNRH0GgNr3KCI3bo9ESD7xyT/bkB0P1tjfsIdcS
	0Q8HcM1fZKreH1U5z+UGDpaFmGmLpbznbxr82VIzUlLY3UBnxCheaSSkp8oR8otnbPA9h528goJkF
	aQ+7LlDJgFZq6jikluNLC7yhJWxdHDwbKJ4KTJ8AojfzIlnauMuzS/0XWycq8a9LPswQOQ6U3sNKs
	5gr0CqkKBkfzmxV6tM+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoKL-00000000Gop-1BP9;
	Mon, 24 Jun 2024 18:22:05 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoKI-00000000GmC-17lA
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 18:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv7jiPPZ47tEu6Whkgbl/Y85HSyCe2EM2hwuxAV2LEIEF2X+qfynUagCAnxQXbXaoS3JkOvUOWpCB0z9RNOfEs1dG0pZYnirCq8PQY2X/UwTR9eoblIsskLSCA+k/sY/G90Z72QBvkds/lic+Z3Ytoik2bXtjk0K/6jABJA8Cp4XUPdkPrIAHE5V14h6+F4AYYOfi9n2hg6QO6j+bDQOfFOCvalgfVDwJaJsL0C/XyD84vosJmYhpqBAk8WVy3GRtx8QEdC3aT0yvHvtwvaBRK/asXOyYbZ7w0+tiH7K/oiAibCpUvergkcR0BOEgYg4nBVcF+WmkBHcHjD+9jLKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=RNualZnek7ASHTIqSnvpAPIw5ye+kRnh7qjbOYGl6axhVmOkUdlHMcx9Bi2XeIOhgtu/7EuYjWbnr3XrwEz6dZywXeXkrjPXgeEWuSstDzpfdtQvqyeHUUe6SMSQQV2UrUO/ZPDp4CVeeUH1+7A5y9wzAd2ldrGwy5FVW3CAXrIEBqLgtFRU3at36Pwoolgdjbh6v3sSSeXfGL9kOEz7jD8R7jVjgHgutAceaPvVstirN3P8L+hTARSk1HK4EaixX617zWsGHY5T/ZBCqIi6AWhg9pCQKU/h460uhgeQScL2FfqbN4PC/+wI60iyDn6weV5DOsJk2Bqgy+XUCW/BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=GEyGoHcE9EO4U+zCdASwJsncnX19LQtDaKec9cWEk1vcbZ01bMTAFjFHfxhYZjUKM99cYaMSEVyVUPSKbXDMfgkKnmK5ULLkwImO+80DGfpIQgWuN5I5BeeHN42G+rD4Q0sFx6/oDY//SKUZF++J7gHTTQ/NZbm+1iJ+ACAm4KA=
Received: from SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 24 Jun
 2024 18:21:55 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::f) by SN6PR16CA0045.outlook.office365.com
 (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 18:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 18:21:55 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 13:21:53 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/2] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Mon, 24 Jun 2024 18:21:44 +0000
Message-ID: <d38e9fb0c74e2688f866b0dcc39e417b4c302c7f.1719251730.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719251730.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719251730.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4c3273-6331-4090-d624-08dc947a8760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6zf0uf4eqiO6oT4m7D6VdCagUpUIvkJYk3Nkfrw1MNW3Ng+U7ProZjYyd5lz?=
 =?us-ascii?Q?G0r2o+FS3GkuLMCa+wPN7jmgcVi6/OGnHcH3EqjMOmn07DO3E+3WlMJdKpPa?=
 =?us-ascii?Q?hN2b8lW6bjmjBKG/plvR+CmSKj86mzgxd+IkMKEYcW21eJUMYzgnVlF732W+?=
 =?us-ascii?Q?ufsYvwJzz+5I1r6FxQ/FjnlqpZ8tHC1LDWUz5NAGW3/5piUGxC+GbD5Zim3V?=
 =?us-ascii?Q?JIx4ARy8nCFhKymbWlchxls8Gnln4X29B6FasUFMH8ryJ7NOgpStjpo9cVKa?=
 =?us-ascii?Q?GprKxcLTs4ifXxxZ860/7nISIlIt0No2Vmz8Uf6hlF0asbUHdl6l6bRSikdw?=
 =?us-ascii?Q?rWYcc092MezBG2LpyTrqrJadZh8I3zjtrS+pkVbc2zhI3sK6mr//t2hcmcmV?=
 =?us-ascii?Q?0t6y1pZpzcV4ikHMu8rI70BHLqrANry8nWj9Hg5sgcnQokfRKiRglNfqV4AQ?=
 =?us-ascii?Q?ZMcPlW8jwBByLspPrFe5/iwFr/bZxJDLJ6BvnWec++BPwErLin3mTNCFNc25?=
 =?us-ascii?Q?tYqeUZSdeoqplD/4AeI7KQDklfI4IkG+RKIJtXBWBrY071KZS6ni8zm8t+8F?=
 =?us-ascii?Q?oPzb0hNB5V8dluKffVIny3KFuMhA4wOlWVcqpaZDh2lK9+bNiWLxaKucRjFb?=
 =?us-ascii?Q?GzwhLYaBcRIxfeakkS5Em6HJJGwVkiI/42q49+Vc7pU+BnhTBkOHaCyC3nrf?=
 =?us-ascii?Q?k6pga7I2lapWF688Qls7kYgu03JV8Dzqiwx/DBfSntTVtQMf9AOZ2zMZ7WkU?=
 =?us-ascii?Q?kN5GO9OT+UJMGA5/EVi+uwJ2GRiHM1bncx1aveyRwDgbwM0DRR4u3MnxsxdH?=
 =?us-ascii?Q?dCiH006tyZT9FiL46/SRz8rbcAAtme9HCV8Dv7guypTbE0PWhwOoWWBFAXIw?=
 =?us-ascii?Q?VFdmDhJseRULTD95ALX9H/UyO+eWd7VQ7wk5mkdUdhB0neNPAmomOF8EFKhW?=
 =?us-ascii?Q?wM2T8Womm+gnwhzhzApr6tqMPgBCUN38WXHPDAlMeBF9mqPAFFsqPh0WC/ke?=
 =?us-ascii?Q?lGYPEzzvqxeX2pBLLd5f1HItgl0sF50wFjGx8XCVa6K4Tr3LB7l3p24siDdF?=
 =?us-ascii?Q?0J/CbcutLTupnYpDWnNTHRDfxycB5WiEXGffPTVdVymA8FWjkucbGHm3avSe?=
 =?us-ascii?Q?w658PLXa+UKSVaDK//hD9EiYUaYcb2CqM8xM0MfUNVcqqKrEUsQIHfXgiFmZ?=
 =?us-ascii?Q?i5Kzygd12aP0pXj78EdaDui54Emtd3J7mZAwldFn5vJbRuj5RFTbqrWjPjQw?=
 =?us-ascii?Q?yimPKuN7jYQ5wMVQ34V/HmmlGY3f8XEFs/m9q2mX8XnSZfRagDTJZ/o2jKnt?=
 =?us-ascii?Q?SQ71rwbp5DSonfQnZvI7EAVOKXRZBV8yF4tV3MTy5rKSDtPoU5DXAS+e4JwQ?=
 =?us-ascii?Q?6GRXmeQnx7J8Ye6l8AdeCzw1t3TdXb4kZZtCP0yJ70vsU/KYUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:21:55.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c3273-6331-4090-d624-08dc947a8760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_112202_390297_7995C625 
X-CRM114-Status: GOOD (  13.04  )
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

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..826b4d5cb1f0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
