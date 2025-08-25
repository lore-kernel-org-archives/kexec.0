Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73087CA0EFA
	for <kexec@archiver.kernel.org>; Mon, 25 Aug 2025 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XgvMGIoWHc4776YEjG+OF6tSd5s6eUizTv0SG8/eZ2Q=; b=RQS+x48BgsWTMi7kl0z55aUjXk
	6teT2mkAsealFxOPj2u2Tpt9kZOLAw2gbf7sRmxLQ+cdYhMii9JAPtg4GL9J8Dkjay2LRkxZDloEw
	y0kDWlMVRvN/HkS2yI74p1ATOd8WeB9ezswnKOJbX6pzcOOyV7rgS+CxiyHyuftaPsGl1ouhRIyMC
	aB3d9psmJQEgtrJv1AGsa2z7w8MVdB/R0XeuyZgv/4L/ivwsAZfF76GelMb66SuezhGW2FtrG2v9y
	XeHlYysvcanlScseuKk/dOIjWbPHKGaH5HFriyizccIkRfGc8RCEt9qK7exiQHFmnY2TvECQ9BpqU
	3EEacxHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYes-00000008L5c-2OHn;
	Mon, 25 Aug 2025 14:58:54 +0000
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqWOB-00000007vfA-1w5G
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 12:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR6BKUtMySvgvoAz8H9yhZ7O2WJjfuMn5KyQ2f8uIs9JA3A40yHHtYusAejCoWEEo1dzNRVqwHFMa0nLNpJx+gPgoPzXcEU9mtHqqYp4lfZsTzVFuCOgph0Y39G3uo9RI5eir8dMBF8RltbNTKbHoyOvk2vFTl2sH5oKcmRZYQw650ei8soqH+ReGBCECDUd18X47EwC82ezE8olM9MZO9pGVzeQ8g7hpPVpL2QOFiUyxo0L88ZexwdNuRoi3sqwZ6yCXzBfh/yAXrNY9ad7wSJLfbwmgpcAQVBX0xCnT/ZEjfq8wBXHccDKBng7OYba7G6bLQp9lgh4T/T2M3i2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgvMGIoWHc4776YEjG+OF6tSd5s6eUizTv0SG8/eZ2Q=;
 b=XJOnFEJQzvACdqUB6Rnmrl0N4lHdbBhbVGT49bUwsVDQgm+roAXsr0+GnEM5b55oOTxjxQZofF8Qlh4vX/8OwZM8ZXIBINwuCknZwRt7IR3iGkY3p7fTrB3fm0W56Xt8aT20UDGf27RHf78xLnmj8wqdIG1bOPP2HtWwA43ZpyrYu0Koo0rBlWAXF4lswtUvj07lzr+Skni3cjCNk/z/5TVa7h47XLrOYouXt62Wakk6c2kgyMnHPz7K1hGXiEOxTx+1qropy5g7litHHbyeJmvh0UO6dJqUTiYXha3wm2smJ6K5Ogm6N25jsG0FFPWNmHSylCBCcI/gr6Oww1aELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgvMGIoWHc4776YEjG+OF6tSd5s6eUizTv0SG8/eZ2Q=;
 b=K2wUK5Ah+RayGjypW5h+nwg4/CpyEkEDhLY8gfV6lPKBVMnIQt0eq2h6JdVpCHU5vKW4cwo+4Chl32LZs8L/osksvhE+xLt7GSDS5aCpAay2Jy1oIZjkNxJAYkaeZKJk5SVtUQ56SM33WDj2cKECmVajaJVWuk3pLIqP0GJ968mc3pnx4iD97hVvC4T9ATuHZjVtKN421ox/SMv/PPW292HWiNKoKKGABgSCMI4MC85USQnG59MC9rtR279SGV7h4IvLOYJ9LchIFD2v/38YbHqHFDl3wYIGIQ9oMr6Yj5ewJCcwxX6L/6Yta2+sNqeC0i78AnukanO+C3tIsxh/sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE1PPFAAD10C5E4.apcprd06.prod.outlook.com (2603:1096:108:1::425) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 25 Aug
 2025 12:33:19 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:33:19 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Steven Chen <chenste@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	kexec@lists.infradead.org (open list:KEXEC),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] kexec_core: Remove redundant 0 value initialization
Date: Mon, 25 Aug 2025 20:33:05 +0800
Message-Id: <20250825123307.306634-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE1PPFAAD10C5E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b558ac6-5d39-4ef3-aa81-08dde3d39256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WjLFGobbhM0IX0uWSGLZ0NBa/ujwbxvVzstyjHBtONqXm0K+Vt+MD5gvd22P?=
 =?us-ascii?Q?MaQqbpgo2tyIU31qN2OKW6npl/lRF4pBnpmptCiYonQuh8e3qbsgu4vbYClP?=
 =?us-ascii?Q?p8bBquOJvjJEkvVLG9DhZYejZATJ41fmWYB0zAnX8sW2hJSQo+ZO5KuOBcbQ?=
 =?us-ascii?Q?SXlmt2/J79hSrev4AwuLqOfmBFP3kHLfwjYMLejY0qpV5zZ4h6dKpvf0jxqH?=
 =?us-ascii?Q?YqK2yM4QacRQq/ZEpYcZZlL99oU4dezIfu2OyvgGwfdATphYxk7+bJer/fnv?=
 =?us-ascii?Q?Yj0UFInDJA9xH5rPHLNYBRR9L69H2w6VYqEVTomkEGTQTSUo46aA+c9m+RrM?=
 =?us-ascii?Q?cYJ/oqU34IsbQjhPvZN0f/uGut8FhP0uPSXzhBbxkn/tPKCSnZ3XUF1oyUCN?=
 =?us-ascii?Q?pJjOsQDdJmDonkj5BiY7091g25DkZrexb0GMkXsOwAW3ea7DUiEYiggc4RTo?=
 =?us-ascii?Q?5uATR6GNH3vi1duF87cssR2HCK71ardoup5s7CZYT6eYp8pEn/hrNzA6JZ0N?=
 =?us-ascii?Q?Twp9zlb5wk8qKh7fvnpzQhAy+95o4JfsiECzqn+swGE0QmOJJPr2DpoAeJOs?=
 =?us-ascii?Q?4otdlnYpzr6NB854chhE/fdl8VBdzJiqGhUJ31rc8kmrQ6JXQ5Y40EbwzWY1?=
 =?us-ascii?Q?yu1XLJlIyPjeJczGGM9hp8Bj/U/2Ue+7SRdMeqJgCOb4SFiu3FlP/QxkYKLK?=
 =?us-ascii?Q?YeS0otc7bs5SmZaD5pHVzl4RgUJPYeYWU3bI29jTbeQapKnmihnYb8gMsZw5?=
 =?us-ascii?Q?qbJAjE44ncHENDe7iwksjRLGcmgtibZNFpfuAtOHDf/3lxf2ixdFzi+8aRj+?=
 =?us-ascii?Q?uwApC/CXohkEl9cyclZzor8A33Ey/Xn5oc/ZUTOUuCM8YGouzuGw9ziJm9vd?=
 =?us-ascii?Q?Ug0VW/3AMAZ4e2WELSmMu9uxNKdhMUmtw9fASPtGS+gQRyez7kbRm/zT83E/?=
 =?us-ascii?Q?3HDK9IIQhsIBgfRVESlgAYrndPzX3DjpX9MDeLrLPpNCQS0GMSfYt5sm9lgj?=
 =?us-ascii?Q?Xx9YinCqWQsHXHVjg/EiIoavqM1QysgBO06iOGyLfJeug6JiHWWbT1CUY7ld?=
 =?us-ascii?Q?ogAGILSLbamyar8RIWZoQ9cnv8DriqVtr9ITZglVHmlfXrD+1DkBh9PJATuR?=
 =?us-ascii?Q?iJI2PWxp1Gv7v2aUbZLoBHCGA1Do7C9Z74LdZrVq9oLWPy1EmZV4E3/ZtXFr?=
 =?us-ascii?Q?pJrbNWwDqvlekDgFfNJh3/ctUswc5GbL4CXZuyGjBVR0sSbpR7kD4pehOobq?=
 =?us-ascii?Q?vlIuGsDnadhldfPmWRXzICZEfVXUNsGBKRZgd7GPddojAR8S32tnoV0t/3Sw?=
 =?us-ascii?Q?NY0tCthB68Jbr50CXEXPef/zUIrc2hOD8PskG4zcFmloC5zHSsaerpT1eT94?=
 =?us-ascii?Q?akNvXwSSW3qmMJKO21u9hFfefyViM5fR4D9dwNF7QYH1YSyClfBkF/cJFi17?=
 =?us-ascii?Q?Bi4qT8DEwoufOjoT2whSJAH97+Q+8kz6/d59joAEXAnRy/7kDl2+iDzsY7fT?=
 =?us-ascii?Q?xvmy6Jp7tBvvqck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaIWCc5nuNKjBxfrlRvk0JmcgAMy8HvC4jEBNTn41kkwxUkp5URAzeUgGyEn?=
 =?us-ascii?Q?WmIxSlCnUV23l6lHHA7Orv6U1UXQkilXZLiqyLgyQd/uQONi014wOX8i31zT?=
 =?us-ascii?Q?hB2fL6CZzWkwmFBqnvk83tA1Faon/nbt9xE2vuYLBTHZCrZsD3ypAVU0BNl+?=
 =?us-ascii?Q?q7+P9M4KzWZYotj+sqwjrH5az9C/g3FX3cCUJaJG5/E5yWyV+Ri4Z8UliDmN?=
 =?us-ascii?Q?HKwuNOHh58v6MoVpGRSj3VMEgY5ZYkQ5R8/u2vdM8kK6dkRp1Fo9tK8LIDRN?=
 =?us-ascii?Q?PwH053C9+ko3PFFYnYAdqQjSpJhXUa/Db8EcfPzMdU1Eix6j5zVhs2/BisIo?=
 =?us-ascii?Q?vPWvuV1r9jw4lGVinvyXxqbIRy4P/PRU8CwLNztqH5G/kD0izAUI54v8iS5m?=
 =?us-ascii?Q?3WleDKY1KoxXpWSmFNNWuWp0RmZ4MENcKrBMBnZ03lhy3w/SNR7B8MpUS/55?=
 =?us-ascii?Q?sxgmiz2Okohom4AIp17jU0rpqQwi1RfLBzLEXWXUdc5tNDz8Wim56nMK8VdU?=
 =?us-ascii?Q?a8wwEufQASY8ii473oFWCvjTuLVkgGTIFYunpVfM1lBQl45NH3dXvYLFsk1k?=
 =?us-ascii?Q?oQolSag5xier2geucoZ+plWXYa7O9HmIfDQXzKrxmoxH5d6Pnw4Y58J9l29S?=
 =?us-ascii?Q?DLKHuG1PFnYRCIAZFWwJT8oBzYIyBNZgNP5tEmwz6QLn+G7o7UenRElA8HnF?=
 =?us-ascii?Q?Yv3h3Pkf6ODf4y3G8hFzaG9woUSJ2OfxydQbsYMNtexSPHQo5TjCuuIqAoRQ?=
 =?us-ascii?Q?TjQjUgFFmYWYkTNH88KiY6/NHHHbsvB8/GlsQv9lU342ks/2ulprOBD40eDV?=
 =?us-ascii?Q?xL6vuWV/BnzmTabWi5YDIo2PdoTJrmc35mzK8sncWQF3kE6m9o9tTWpIIvuq?=
 =?us-ascii?Q?klwg/ZE8FIrELNV/9K7L/aOehB6cAuQeU4JxvfriN4aWw8xsodykKC/087aM?=
 =?us-ascii?Q?HBnANhjAvcZn+FjHdE/Gzl637IqKIFdl9J8vrscJhKKVtiiGzHQLROb0VGcd?=
 =?us-ascii?Q?h1mOPv5vPlWoVOFjgEgKHgLXj+vN7NrOIGtKYntHypjGnNUtRhqGGknnmlEO?=
 =?us-ascii?Q?dy+bT15byjK3g5HEzyeHg10due4uFMNEBXOF5408yDqrPHs1N44f1vL4OLV6?=
 =?us-ascii?Q?mQt+AlOm83ReypXHEcaRUXr+8Q7nvEDL49BKu8xXEgG/P6V7cXck7OIaKB53?=
 =?us-ascii?Q?zPAAGcIfSyu4zQZq69k5xjC6Dslp+tgr6Ayqx95aRlz2iXPgtm26cWLLSXHQ?=
 =?us-ascii?Q?Jh1Bv4dPllhzCrgHx8a+mN2suNW8El2wwN3lpNy8qPv+NVQVKdncP/d73G7R?=
 =?us-ascii?Q?jtzmu8FX8T2rRhsjVhMOisXD3WRrrgBF9KzXjB62+ilGrWlFGiezP9eryDsS?=
 =?us-ascii?Q?WhtArZpoLLqV1GVLHpRAdhl+ua+E8YM9GG7uBXzLHGLczbSXA+9J2m/TkYZW?=
 =?us-ascii?Q?+OJwSNih3JcgdA7LrQHGzqd3V+3X2C4EsZEScf66NydAjpqB4hqj2oVWG7yL?=
 =?us-ascii?Q?DBEL7lkHwx1ZHEdFYhCp/4a0CoeZwZ/VK4gl4HUVtKLqb40CvM4pPImuOgCg?=
 =?us-ascii?Q?+wJxido4dmxAd2b7EMowDhdXUcc4sp5RwM9+cXh1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b558ac6-5d39-4ef3-aa81-08dde3d39256
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:33:19.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N6PwMl4aIPss2Tl+mHefJmQziBjXME7t9zaioKH81NF4VCxUdDbSFN5wg2bk1EtQZqCu+JzKs6IbsOYvSoDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFAAD10C5E4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_053331_501258_21B81A5A 
X-CRM114-Status: UNSURE (   8.15  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The kimage struct is already zeroed by kzalloc(). It's redundant to
initialize image->head to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 kernel/kexec_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..fa00b239c5d9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -233,7 +233,6 @@ struct kimage *do_kimage_alloc_init(void)
 	if (!image)
 		return NULL;
 
-	image->head = 0;
 	image->entry = &image->head;
 	image->last_entry = &image->head;
 	image->control_page = ~0; /* By default this does not apply */
-- 
2.34.1


