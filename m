Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E8BCC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yK9+EU47WgXpa6AFc4NPyVj0xg2vd3T10orPPJkQIoU=; b=41zMpTnLoYVKx7R4J6cNSYSOoQ
	/vXVn0P/nkGQe1cHe+FsC6zKD2fzhS91iTv+aAcLk+QOx0xhQHCFF+WvNUmvpR89cE90bNBQ0FeUc
	LGU/Oy1SkOpGKd4hAIt1W2BaXF1v+HdB9zgh+TAawRgLjv7qFCanuSV096WaeOMiAR1duvL1Jxllb
	iB6JbBGPwrP10YjeCDCVTCD0JeJLwFSTnUJjnMsGj3Wzbuejel21sw01cdap6drupDSPnxmQROpKK
	lno091Pr5eCw6wc7CIE+EK3nx4gacAQh22VEa6nezfRCjuHctsufybU3tQyO27kqZ+ucVjzY5C4Av
	MUzWqWHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0Qb-0000000FmY5-1iDL;
	Wed, 14 Oct 2026 14:58:01 +0000
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0QY-0000000FmX7-2pHt
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 14:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab5cx+6iqq/JdAAMVbP8dPtvqjHzyez/IxaNd1yE3fWOGvyQ9hABqNJGAeUJxbDGa9kdf8RPBydQUsMit3bIhRXuUNIhcm2LDrj3Y7k038uhWCzZs9nsvalNfx8qWBFJCpta/C+Wg7FUoqYVeialHhXcv0oXeZ+2YtqNyNR3frNkbTOX5rEqw04h5jwjIksfHEx4PaKhgQlzMHetTWOg1UpYwZNfP7ZQZWEkY5NQuFNrwcV5S5zRaOXU41WyKQj6uAFBeXe/VBN6FUOUPtgMWgGfTVqhb/3A2yRE5qxX3ci0v4v2lLFDhJBBoWA5eKS8/2pvVAdwzaLJTaIRra/FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK9+EU47WgXpa6AFc4NPyVj0xg2vd3T10orPPJkQIoU=;
 b=qSA4Mt2OXjv56nzGyQ9oJ9BZK0yAJZNyPW4ufOHyw82jIA02HTGn8tcniwgoGpu3sOMe4sQIN4qXbh+0vPwyzDzOKlaStLLGdgAmI3vM95wTO20BIVgcUH0CtUlkE78TiQAin2gL2W/ksifbxBDwI+TS5rH2GIvnYqcMObeRKpFoEKABqclA68XvUURTAC30QclQwaYFc0agrYbKbkwB3TJW/WeD6XQkjAK+MZthjt7f8CGx+Hj2KgNgppMTuPBAo8An4pfoufCik2aYDD8OrbxN9Bc0hMPWHPfS9hLurDsSYkafDyL5QDt7pwaghKXrwwbVOXoaoXURZY6mVjLxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK9+EU47WgXpa6AFc4NPyVj0xg2vd3T10orPPJkQIoU=;
 b=Bni1sKPRs+UlUlMzxiWb5T+1bBdVZ45qCqYX/pzLCPtCFNpiN508QNA0Hr7mcHldAOXvRSopMx0+PU9m5xHr5I0GSAhUDIXCqQdsg+x9olS0f9HOEs/dP7+WAcTfB/PcnjnZKTmqCPIbF/+3+hP8paV/k3DYI6VRMHSN+wZ9lHw=
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 14:57:51 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::21) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 14:57:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 14:57:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 09:57:43 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 09:57:39 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <baoquan.he@linux.dev>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <graf@amazon.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [RFC PATCH 0/2] kexec,mm/cma: do not run the next kernel from a fixed-base CMA area
Date: Wed, 14 Oct 2026 20:27:29 +0530
Message-ID: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcb3540-7c3d-4acd-31b6-08df2a038449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|6133799003|18002099003|10067099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gUNMOGhE6gsY4EPAkgdIxjBNC/bKfsYvQYjuB3mgAwcRdWY/DEuF/EBADARPOCGAjVxdPPYyelavS8whAl2dXlwbi8x/of1Apo41N4RPDjIJsCtYndN1Vr9r7vKsw6MWR7dQGDUwRzOq6iz00FdrRFuQk+YO6R9LEIDbndJ+V7RnLxsdihqUigfTPLgGSoce/8CqKxj6y5al68Hd0/W25sB+V/tKosqMurIGP3w7lN2F/FjwaUNYjorWFgYDYFlX2i+QlagoLK+PGlNP1LA8t4DVGUBAMt5SWbchCaV7OPsbTt23GQoVU2sTJ0zgZ+bX4yr2JsooVIiW0Y/JTfkIktwlf53greGq1WY7kEAPZBUEqRJ//S0ChyPMOxhrxMAT3q3F8L1LGP79kYfJ56O4JeUxBWU2MNzScgLuRRaPCgKp1FjVCJlPlO7UgbBqByt/VNHx86JG+b8ulxsc3YkV0DABBt1Ze1TEgo0Mp/0BhyF9TdzbOhsm25XwanMzhiW4RbclFBJEcc4cWYDOeUlgECH7pIksq4SGzfjB55F9/Omrocy793qdKyExEqaIJxKBODvf7oMrsyiegE3FRqSFZrxMaFZ5gRnewUtFAFWh8Wsh4q1hKnIWxGvVTIqHCwuQ5LDZsmqaYjquudpgIt+VgWDlBtFKgMA7HDaEgGZ9RHiNSGw7RvGqQgEp1z3h4kP98D2W6nGOBSOBHO4TuC7zGpZmuRBNjQnOwDTAgbEK5o5u37sCvvizFdlWg0syej0/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(10067099003)(921020)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I/jjoHaWgPV0sV3PQGefDxDeesfbXVccU/9QzPryR+IYVJs33x6xKny81UsZP1E5hmZhTNFIQQgVj2N8XK4GJbepZxX4taVYGQYt/Z37b6WZDVDXvYkz21a6BYBcIxvOzKW3tSFtJE8WL/w9Iumz4ujBt6++rSTYj7X1ealVAKaUtPQZuv7eAYEVQbGDcCsIQZeqAv9H10Mw8kv6YmycCRdVhMcH5SFAAsPIwGyScWXk9p4HX1iDw7KkjZWJwsE0Uy3RV5N2bKykQF03VObPzp4CwcaYbdP5Dls9goQnPBEGWn6qRmqVFq5BrA4tg3jPtuSqYnUYnwJlTVs98ZcKKKaFtnCZa4pqrg+lAEFoGZnR5lVSTPHX4Ou28lNSpOiu7h6ESwHP5IBreEVjJo1KjYEM2xa9N63PL9lQL/tTeGk4ofO5cNJtGKorvUscuTRV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:57:50.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb3540-7c3d-4acd-31b6-08df2a038449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_075758_721703_20C39BDB 
X-CRM114-Status: GOOD (  19.76  )
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

Since commit 07d24902977e ("kexec: enable CMA based contiguous
allocation"), kexec_locate_mem_hole() tries kexec_alloc_contig() before
the memblock hole search. On success the CMA address becomes the final
destination of the next kernel rather than a staging buffer, so the
image is run in place instead of being copied during the hot phase.

That is unsafe when the default CMA area has a fixed base. CMA
allocation state is purely runtime: the outgoing kernel marks the pages
busy in its own bitmap, but that bitmap is not carried across kexec.
The incoming kernel builds its CMA areas afresh from the same device
tree, which describes the pool's extent - the one thing both kernels
agree on exactly - and has no way to learn that part of the pool holds
the image it is executing from. cma_activate_area() hands the area to
init_cma_reserved_pageblock(), which clears PageReserved on every page
and frees them into MIGRATE_CMA, overriding the memblock_reserve() of
[_text, _end) the architecture installed.

On a VEK385 (arm64, three device-tree CMA pools, 14 GiB total) this
reproduces within ~300ms of /sbin/init starting, as a copy-on-write
fault writing to the read-only linear alias of .text after kernel text
had been handed out as a movable page:

  Unable to handle kernel write to read-only memory at virtual address ffff00084030c000
  Call trace:
   copy_page+0x48/0xc4 (P)
   copy_user_highpage+0x14/0x30
   __handle_mm_fault+0x318/0x1340

Patch 1 is the fix. It records whether an area was placed at an address
CMA chose or one dictated from outside, and refuses the latter for the
kexec payload, leaving kexec_locate_mem_hole() to fall back to the
memblock hole search as it did before CMA placement existed. Areas
placed by __cma_declare_contiguous_nid() without a fixed base are still
used, because the next kernel repeats that search against its own
memblock state and so cannot land on the same extent. "cma=nn" keeps
working and "cma=nn@ss" does not, which is the intended distinction.

Patch 2 adds a check in cma_init_reserved_mem() so that a caller passing
a base overlapping the kernel image is refused rather than silently
corrupting it. It is hardening rather than the fix, and deliberately
carries no Fixes: tag - see the open question below.

Open question for patch 2
=========================
Returning an error is not sufficient on its own for a device-tree pool.
fdt_init_reserved_mem_node() responds to an error from a non-nomap
region by calling memblock_phys_free() on the whole range, which drops
the kernel image's own reservation along with it, so the pages are still
released - as plain free memory instead of MIGRATE_CMA. powerpc's
fadump_cma_init() is the one caller that keeps its reservation on
failure and is therefore fully protected.

Should of_reserved_mem avoid freeing a region whose node_init failed, or
should cma_init_reserved_mem() signal this case differently? I have left
patch 2 as a diagnostic and a second line of defence behind patch 1
rather than guess at the right answer. Patch 1 stands on its own and
does not depend on how patch 2 is resolved.

Testing
=======
With patch 1 applied, kexec_file_load() on the VEK385 declines the
default pool (4 GiB at 0x800000000) and places the Image through the
memblock search at 0x9c00000 size 0x1de0000. The kernel that boots from
it reports its image as [0x09c00000-0x0b9e0000] and 14680064K
cma-reserved, i.e. all three pools present and none of them overlapping
the running kernel. Both segments report being copied rather than run in
place. Without patch 1, the payload is placed inside the default pool
and the trace above follows.


Radhey Shyam Pandey (2):
  kexec: do not place the next kernel in a fixed-address CMA area
  mm/cma: reject CMA areas that overlap the kernel image

 include/linux/cma.h | 10 ++++++++++
 kernel/kexec_file.c | 12 ++++++++++++
 mm/cma.c            | 39 +++++++++++++++++++++++++++++++++++++++
 mm/cma.h            |  2 ++
 4 files changed, 63 insertions(+)


base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
-- 
2.43.0


