Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE18C48BC3
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ydob83Uw86PT3E3CEzZEts5uyTzGjWCxHzTcQgokhG8=; b=o1598vO9O7CMVQ
	3wn+8rr8B1J8GPPSik7smsI3qNVkzpRC2mtB/BKnZ53dn96Z1ZqGYeuRIIAY4FJnUWTmPAphxnA0c
	lt7Uacnmv9yerxS+uNIXjnQigIwQpK+YfHuoYqhX3RH/8dQ1I39FTaGr3mEfjehIx3hTLOkxpYD7G
	Otn5gOGbtPQgB3ZlrTweBQVkcsSeRPZxDQvGA6T9a14jNBXW5f3AfNvqCBj7++Dg2/bIhvi2w29tR
	+37oDR+jTXHbRF0YQVU4/Gm5WP4lqc+Ir00TcCWRjecVzjRw6zar6FcrDE5KpBFh3VxXOBpq4PTA7
	Nv4XxntxT4vgaCq3kjjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEmN-0000000Cj49-0nKO;
	Tue, 20 Feb 2024 01:18:39 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEmJ-0000000Cizz-40vD
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 01:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGHRIn2qMCanjuTmPfZTHblsAvU0ghKNaff/bpIWTT+eVFOonmU0/TOijkEqHsRDM+PRPIanh38uzJW/CEUGsmaJ4cAUYYnicYpgzolXZ5S39Vk+Eo2o8hNTRJ5bCpBmVM1Y61xZJlvfI1YRAZkDk0JUu1nZHo7UglyRgMlCBQBw0AczQ5tHFHQVSw6Uf6suuTkNppPEWTBEw1m8Ag/rjjKT73b8/ICZNk7facdDr9JIY2mvgsorlA3teXslR9JLByG5bXFkjl7Zxyjt9DLha+g2oYRcQMG5Uy/Hkifvu5PAUKV2WPROeYI32IOUgscnCIHoJt7whWFNlJTmvyIPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/U6sJ0OclzZik6cJmIyKjIWV08AkF1TdBBhLs9duZU=;
 b=aFd4t6SjjZeHT7pc7W7J6RnibyIasRkk4BJnLtrcnPDSQ/D4WUAzNMvhpObvtUuHdKO9VRzERrnODWinUh9qi5epfE0p7bV9SYX08s+MNcl9gZNN+mOsgSNwctQzCqLMZDYG1RX+p4EaXG/S6dmKPpVqf2808zlucYKJCkIpzW/tufQ9/GrfaodkabHUTSPbNTB5KSOwvZ4vv0ZAr0ReE4PDc0oYKOb+z7Pbo5FjPqIQSFgpsozBfSywh00cM7RrjlvVS5c9KgOvfHBSVHDfA++a18U3xEsDbrQKtsaEb9+K8p0vOxx0tinTvlIK+5t0aqRVvZHk/Dywnsu92QTZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/U6sJ0OclzZik6cJmIyKjIWV08AkF1TdBBhLs9duZU=;
 b=iUmFNhDUxPVlyI1A6HviYsEBje214q2BKUVKhK180jvnuMSQBokP8xgCBE+nN1jPAeHRL+7j/Z1crSPWTl81NbeTb+BJXAE9r9FjPuSA2YpmW6qCqfRg3EEm1sciacTgxQwQq8HUnNPS4jGj7FiBgyG04MvPy4jESrpeXfY5d8E=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 01:18:22 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::36) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 01:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Tue, 20 Feb 2024 01:18:22 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:18:20 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <jroedel@suse.de>,
	<ashwin.kamat@broadcom.com>
Subject: [PATCH 0/2] x86/snp: Add kexec support
Date: Tue, 20 Feb 2024 01:18:10 +0000
Message-ID: <cover.1708390906.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7703b4ea-04ec-4a23-31d6-08dc31b1d46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5aW9yopBz87tOv1frRg3BrZkBJRyGlftrn1zom3K6Joeclk1yANloL4GQXhAlcpzD7AXyUTjqvwJ68U+/tGCTo1yITdD1pD6S7oand2XtWRfHCnWzHwhGEzmQ19Gj/Thvst5sREhgKEcTG90dcgW32DjgVDesQjTUEfjeFONOSr7foGI+Nm7qQ1+/ew2wFOnq9aH7DJMlcUyRy3rATUklPIUp4X4O0imlyb2sVMRMohAuMjuXMKQxa85UUAWEi4zJrDkTcW8PnrmGAJ1R3HPUxgQySwGf7kXb/jiCv9ul1O2Jc6mDWYFLeqQ6Cc/g18kv6Nd/bZRddinfvupqw0+i9fc0CT+eO3z/stg2f5a6ZZHCG6LF5X9TWRakQuDRLxtEkWvZb8ybfjm8Sn5PvmNauqFBcgal3Fb3wHHFq3j9j4lII48/VJaBCG0gx4rIYBodCuRUa+5w10uTijrdYoN1XOADkG8J28dGHP1PAXY60wyDBuTjJsFx5cUyFIgFhCppiDGsVrI1VIyAWf8ggt2icP3How65QkpSNAOiEpV5iW5KxmR9iXXbtvHkNYuCHfgj5IECFWAR1Hgus8v7CgaFf7jOl1BiW45jd8L7TEQ8Errd9mxNqAVzUW55FYgBUfELvXs7bNPMEsYdnjRyQjMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:18:22.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7703b4ea-04ec-4a23-31d6-08dc31b1d46f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_171836_030611_B5A7F76B 
X-CRM114-Status: UNSURE (   8.86  )
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

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires [1] for chained guest kexec to work correctly.

[1]: https://lore.kernel.org/lkml/20240219225451.787816-1-Ashish.Kalra@amd.com/

Ashish Kalra (2):
  x86/mm: Do not zap PMD entry mapping unaccepted memory table during
    kdump.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   8 ++
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 211 ++++++++++++++++++++++++++++++
 arch/x86/mm/init_64.c             |   4 +-
 arch/x86/mm/mem_encrypt_amd.c     |  18 ++-
 6 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
