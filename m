Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C36CD1284
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U/6QGnCXpIUQfOlP9tfcCiQs8bpQtxWqZS8yl3AxCnU=; b=uWG/9HSP0JxHy8
	w6Vbiw8IH0lYzUnjqgncjlTTrdQtFeAi0w1loM6b3wUe5AneWXjuNNbWtDbQbFhaMAM7H9hY3fa8U
	mfuuLXuMvwyqAivHjEqs6dDU3aexorl/hSpIlNrHPQMEoqBVyJK2jP07p0AtKq3P/hdgat9sJizif
	SLDJSUPcs6g86xMrWqZr36nF0QhP3JzjgoqPbHPI3RNegLGIHgOTP7CAl5Bm/nMpcBtevhQsXwa7I
	AIyljirOXkYfAEYwgEPUsGAoXoaBv3/wB9V1Ds9TqCTOw+BwsZHcnTwtaAqN0JyM8JCYUi7AZq6hB
	xOrT0b8RVDyWu1784TAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWF8-00000004Xme-07n5;
	Thu, 04 Apr 2024 23:11:38 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWF4-00000004Xkn-3lwu
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 23:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaIh5fyQjEfd2NXuJqVTgNkP7xCEwa7XAfPcMsHcSmvVyq/uukEvgRls8p1zFJ8a7za3H1QapFL7zamu9Z4oAh5LWzAtgQekfM7mxF7gDqELM/rElGLjoX11LGpJgXpTx9iYnzUW0FCVlRBPmOXe9z2lwsGIyNER04/j626lpn9084Ctc6cv8UpK8kI/Z5CIgEZryuLXGfHbKBXsFaIQYtMIPCytlk7sZ7+mfVt7ZGX0eMtPbkIKanKjEuv/4aBC7FwCHAODg5/bsfvbBSj0XFNDcQjnYSseuAMDnLzYrevG8tuPVWqKuIdB4Yd6X7lUxCosnGTnFxLFhSxVmGe4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trvYSFLaRPdH8VKwEKLxjJFoGOzAtIS45QiGq0D9va4=;
 b=UQFEJQZl5PP2yC6tg1kvCIqqkd4DKvqSFJJyYAcJ7dnfvDpckRZSWrrbq38chfuhTP1otNavRWh6HFBeXx7gEBIvsLtW60nHVlRhsW53EK+/z8ClHvu9mqx0oG+2Sh6YKcqMR5NdQdCmAZQUM/y/ashYVWsMJIMIDzaq1UB3CBs9e/LAABDN5gvukLwfdrjkJIwF0Ip5mNGlanf+g1ys8N8M/UwfiZcZQjIcH+12UCkjNFOBZLaOGCsD4+oH73VI74cgmDgfZad4zfLjB3QI5n9AP4rvhKMWf1XoMsJxQjEwb83IFNlOJe6ahdzYbuqNgXyB6v7XvoH/C6+FXjCqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trvYSFLaRPdH8VKwEKLxjJFoGOzAtIS45QiGq0D9va4=;
 b=xa8pWMm+qfEXfdgqbKVrYUM2RsKlWPDrb21/f/fJnt8eONE4LrpLLlpJPTAy7RLQ3TlytZ3z20pjOXNzuIFsJiYT1n2F198OwoVimRMExe3Y8C2fbhpzh2XMx+EjTW7OoYwjqnNc3KyseqPEc7R2X3Ufz4aGKHLN1aJn7S9+GdI=
Received: from MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 23:11:29 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::5a) by MW4P222CA0022.outlook.office365.com
 (2603:10b6:303:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 23:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:11:28 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:11:26 -0500
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
Subject: [PATCH v3 2/4] x86/sev: add sev_es_enabled() function.
Date: Thu, 4 Apr 2024 23:11:16 +0000
Message-ID: <e14edff1b22705de6b66f4cbde5df3dc68eb10c1.1712270976.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712270975.git.ashish.kalra@amd.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com> <cover.1712270975.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c5147e-08b5-4796-a974-08dc54fc8f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhjRTfJXajoxvffyErRYbX8tZa6wcQ7F4I9JOB+XLYW54ZOj67QnLAnFcCQoaLbtNQ4XGb2FFPN3Xkf1FlaknGjc1OU5ujwj6GxvQhfUnSxL3RxBlymdGUuF/JcVdyK2AsDNE9XyHLGyektsXkIgst97FCA4ze8oOu41d77+CuOE42nHqkzJ7tyvYE/uTeeOAHwPdnLkujFBjmwdxHvMroXFzTEWbCapubOoghdZ/baVa8IEGYhfRICU9v22IUnFcd2AWT2ZvGeDgap+BNDnMbD90x6wbpPYNJkoAHnRISrgLux3UVQTMBiq5kW4Ui++v6CLnVg31/Fju5PX+S7uPOfu2mLgXJxE3SuVPNFPMF8zjpnYxzbF+t+ubQENqflpZl40CVhV8CcMkssf1zglvmbmfaR/dnkoOWzc4E3TM8VNuaX9xhjAQP/2R0NxBFsns+lf3s9P1AYPb/L1DrPps876haoCavYLf22T2/Y5dJDDYBoh1ioo69WVCDu7FXxyMSNlfl2sZ/4IYbVQM5mjAzv991Jk8Ltrt+MGS3gnILWk3/RKG0Xd3q+8DGt8EE1JNXbD0g0+Wfuw28MXsdvycydHREQ0x3vAtzwP08Sy0FfcKLTy3TnybFjSYJjrAa1I/hD53HFZYpS5KEGqzGcpWfVG4JKwoNvVQILLLyU5mvwvmyiaVnQxwqm8N5YYU6FnU07j6znKBj9wM2R4+JBZhb04RBCTY9iw5sjCgoA8LfIsN7/y80TgnnzYClWVFqYj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:28.8140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c5147e-08b5-4796-a974-08dc54fc8f2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_161134_966996_AACDFF26 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
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

Add sev_es_enabled() function to detect if SEV-ES
support is enabled.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/boot/compressed/sev.c | 5 +++++
 arch/x86/boot/compressed/sev.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ec71846d28c9..4ae4cc51e6b8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -134,6 +134,11 @@ bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+bool sev_es_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+}
+
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
 	u64 val;
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a981b09..5008c80e66e6 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -11,11 +11,13 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 bool sev_snp_enabled(void);
+bool sev_es_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 
 #else
 
 static inline bool sev_snp_enabled(void) { return false; }
+static inline bool sev_es_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 
 #endif
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
