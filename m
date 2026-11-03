Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875A606A336
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zy38o0fk;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FcKrv1we
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Pjvtisfj0ShIvEUhY1wqdXjIdnKALWvBB/aKcW/zekM=; b=zy38o0fk++gokjiRqnLZ7+HQ7U
	7VdJlEZZtmlswYs1DGHmCcHEeIjWJCvscGfAWYmTw0yXaVYwQadoXSGy/SFBex6Sw828CB67M5XXp
	H5KbREA2buLu1R08sHQn+8mWOAkxe5cq5kGQgrf4Exu3YsmSSV+psSm+k2Nh0A5v2p79OvamFiPuH
	8f/vvgIZiELOSt4s9PP6iNvW9JgaMFEaXUASZi2NnhQpyU/FokHX0LWK2arsLhdAUCJltZ77pDRff
	G9YBsMSE52lbOQGy7ypVEHgfAg+CMOZWvzs+5jgvFLT1fB00nkHVV2t/hF75tOdopCEXduKQCqe6+
	6Vd8Aveg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHK7-000000036uD-0E9K;
	Tue, 03 Nov 2026 16:25:23 +0000
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHK1-000000036sD-2pIk
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 16:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQCmZpO1w8C+ZgQB2ZiEJIk0ZtEcGOVPzPXn6U86KtZEI9kthOiFUH0Nw3ln4BO5D/zz2DAoGMe9IJviTs2s6SCLb8ye4/75WWs/zYesUGaDnM6dotvRkd/LB8NeCYyvrOKRzpn0VWJSEvbSBE0JW4NBOFEA6errGcarplwbxcxqhAMuZeZE+W4jF/2/nF3edkFuvZyW3reooMBEjK4fgsmJ6WJz+/8cyvGTadwxvqZXC+thhT18RV3p4W17X77yS3NCnJDR2GpJH3WM4macc5821iL1BbamZjvcXc98xSemRgSjcOntJo8Ck0Bc09rDwAtaOPWbgAnUk5QSUY4bnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjvtisfj0ShIvEUhY1wqdXjIdnKALWvBB/aKcW/zekM=;
 b=kDrBI7eCg4iySzmFsUqEoakM4yE+AtS7Wo899pU2dUgf+wc9lAZR/eElF75UABltMNXjEyzKwUf1rFtcZSo0MA1NfupY4oeciG9PLmf1S9K9AlaXMJvuxVUbw5ULaYqMiIAIfxWlBHzOSmsykLlAlPe3ouXH8/eoN9cci6ismee0Uf3G72X75fNGI97tIKH3i9vxmA4SOkSagOxXnoOTE3fVUuXa43Bt79W0dLyOpM6jPqOJSLys0dUyZZ/0UlnorWzF6ypseKremxSVae69U5Tlgo8fwMf46hgOoGM7z7UlSaCuMx08mwv1U+v4FFQqIXEGDt7v1qvUPuoa2Mpy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pjvtisfj0ShIvEUhY1wqdXjIdnKALWvBB/aKcW/zekM=;
 b=FcKrv1weFrU9sJBRNR6566wrUgQUQQXHe2btKi5ykrcnyOMh08jWS9wbhR3daBe/NvaTb1z/7X0JSHkpVkNbUuGuVru6ykkA5AHzuLJyXc2Wwu+mvc3Yif5klwuKYz0G1sgyG8V+azWVKE4TBD+t0/H4E+pow/Emhy8w0a8lSug=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Tue, 3 Nov 2026 16:25:09 +0000
Received: from MW1PEPF0001888E.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::36) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 16:25:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888E.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:25:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:24:57 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 10:24:52 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <ljs@kernel.org>, <liam@infradead.org>,
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>, <kexec@lists.infradead.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 2/4] of: reserved_mem: keep the reservation when node_init returns -EBUSY
Date: Tue, 3 Nov 2026 21:54:27 +0530
Message-ID: <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888E:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1ee63c-3c51-45d5-0de9-08df39c70717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|921020|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261022115727099003|261102123227099003|261021121427099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P9wd7HB4gYRUgbfcn7PlGa9tGGWjmu7k7sHcL6iaBoH3vU1jYT1tEkabULr3w+zmntT1hm368I7v8oIC7k6tvnI7YbdirRhy/S8sr9+Z3f8XUGAeznnEVvxajZaRSAaAUzCgkgP1ybjyegY0WC4KFKkpHZcBMyIFVAnCqUVcZZ9BBDREtFiesmEa/Im8QSFPVGegj0szTsgsGit1h4QxmgsOJ6xdyGWAq7HI+Q8tb+vEoxKSZBGg8TrSA7p0Q5toeq47U03BN9TL5B7SZtuG+udgDZz3yv+RNE67YpT9oh9MQVNKDKMJatyqIfMleXnjgh/YzAzdYRvdKbjc47Khj4HCRXjChP/l5a9DtC/xEWHW8gQuE6oeiAUpwTeNjxh8z9unzRwIQDTJ0NTB2OnnyahQzEZ3pFk74NwWj08SrmO+rQDUSv6N9/f5sVUQ2pT02DDF8gZsS6EcIwQRlT95IkZGsitHlhCL82XdjVLcQ9T+BKPsgPSWAQ1tISnQtFmcckO/+cqXxEXKsU4lobgnJpUbHnm+E5gsfxOOHrOnUAoWCyDNkCi8HoUkARXhnbNsXCsm3h5OmDbXImtaaB/meJ60DV7SX5gAWjZ6/fJtSkul0oMQ/uWtbAKjHyMp5BgOJ5se0kebrqJX/dD53U5w2RiIHaQ+hSpy7Vq2IIxCgGBrDcchWJydaGSy/UX3nNfEUkVLdH5OVjACHjLYiWfr1jBQwLZeb0XO6eXRWZeYCSeh3t9sbxRDfOa2ljl9NboA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261022115727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: epOc018vOFBmUnxxl2d/BTdrKnAy7mD01BGD4uZ8zb7VmxcOdmQ/Q9mxTSb/mKs7+qjAbZ7Wal+MTRP79qjtbiZcenSNbXVR71Z2jk84piNQWRumdx5ZMxdz5yZ7BNxNfAOnkB3XaWUuf9BvM0/ecIMAK4jL9R9zu8dzX5JhWDHQV/iXmRmXVKi6KCQpa4sudSb8cu/jmHz3Q7F641SelpGsvjowba1C/9UPrJALtCVBHdn+3hXJtaAOTVr3g1lgjPeiA34+4dDKWdu7DVEqps4qIePzAs3QNNhhvPAIpBJpjoI4obIMDENOsCC8ERDfM6KULaKylae/CvfE4aZorRs+EeYlhn2+OXhC1QibwBVxLs4SuF0oxlVYkq06z7a3TbsoxFEMqMYomvYRWr4JHXv5QPq+kSducKD0t1xQBcnzLzlaZdhcZe8FmCitDmUi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:25:08.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ee63c-3c51-45d5-0de9-08df39c70717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_082517_718563_FEE3688D 
X-CRM114-Status: GOOD (  16.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fdt_init_reserved_mem_node() treats any error from a region's init function
as "this node is unusable" and calls memblock_phys_free() on the whole
range, although the range was reserved earlier during the FDT scan by code
unrelated to that init function. Give -EBUSY the meaning "cannot be used as
described, but must stay reserved" and skip the release for it. Nothing
returns -EBUSY from node_init today. The next patch does, to refuse a CMA
pool overlapping the kernel image, which without this would free
[_text, _end) rather than protect it.

Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes since RFC:
- New patch
---
 drivers/of/of_reserved_mem.c    | 14 ++++++++++++++
 include/linux/of_reserved_mem.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0fd1683cba01..d67a2b3a4d44 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -621,6 +621,20 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 
 	err = __reserved_mem_init_node(rmem, node);
 	if (err != 0 && err != -ENODEV) {
+		/*
+		 * The region was reserved before its init function ran, so it
+		 * is not ours to release. -EBUSY says the init function is
+		 * declining it for a reason that outlives this node; freeing
+		 * it would hand the range to the page allocator even though
+		 * something else still owns it.
+		 */
+		if (err == -EBUSY) {
+			pr_info("node %s init failed, keeping reservation\n",
+				rmem->name);
+			rmem->name = NULL;
+			return;
+		}
+
 		pr_info("node %s compatible matching fail\n", rmem->name);
 		rmem->name = NULL;
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 49da515859f2..4bf32f80785c 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -21,6 +21,11 @@ struct reserved_mem_ops {
 	int	(*node_validate)(unsigned long fdt_node, phys_addr_t *align);
 	int	(*node_fixup)(unsigned long fdt_node, phys_addr_t base,
 			      phys_addr_t size);
+	/*
+	 * Returns 0 on success, -ENODEV if the node is not handled by these
+	 * ops, or -EBUSY if the region cannot be used but must stay reserved.
+	 * Any other error releases the region.
+	 */
 	int	(*node_init)(unsigned long fdt_node, struct reserved_mem *rmem);
 	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
-- 
2.44.4


