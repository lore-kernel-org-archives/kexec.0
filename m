Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D1CC79F80
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WisfPxbQJQ7TDJJHqC8qQmgkAFnmwETL6QTYfMAUrN4=; b=s3OSMHgEQt0aKbuFg2rFFqDyse
	I1q7sX9Q9+l7gfh2iOqJKpM0SN8ILA6O11QK9dLkvHub44eq5PYnayfvohGB5FiZfJDr781zYxDVr
	IycPbf5rGBgZbdtQ5HxVJv3MKH02h2OGykl7MjaZtMrlGd16hPaOAswMZqzMRF90GjfzlLlZrgiqg
	JA+8FL0on3nm1vCXgeRK/R/RSNI1PyKCWRTz8/0GIr5SgKx6WMQI8yzpwcHDiy5qN4SCOqGg0IY+i
	Symi3ZRSXg6D9QaGBHSvgHCUdbGEi2s+1vxNG/F+qnC2AYRDbYimHm/DVIyfeSwmGFLzu26PR2DbR
	vDFTByvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WLg-00000002ecz-1z9A;
	Fri, 04 Sep 2026 16:01:04 +0000
Received: from mail-eastus2azon11011050.outbound.protection.outlook.com ([52.101.57.50] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WL7-00000002eEp-1z0F;
	Fri, 04 Sep 2026 16:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7zR96oJc1JwWXQbSclXfqcTceTTZa6mxDPVM+CZdkIqJ13Z7PGcWil7nXemsbieCmqGW35GU0U4/RHyikSYRUTLLlkqHv0U7DE19C/iC2o+NQtim/YbcKZG2tw5T3MnH6wIIBGsV7iIu4trg01H7sS1aIkaTi27jMpaGhPk6+Axj/vwjJz62YwAquQHKVb2ryWnCXpSsrrTqoHsAKzLTvu87sXMGonycNS/ctgpOnfQLGhSiktKko6AxU4q7Eg3ubgkblqVySQgfBpkBbH3OAM03Fupv2Osup1ip5upZDCjZIxfMfAC5tmKSv8mgQvAXJTSvfIa8mkeqrpanCoXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WisfPxbQJQ7TDJJHqC8qQmgkAFnmwETL6QTYfMAUrN4=;
 b=h+xMXZIpNxYSXA6TgDhUO7xEjthNu6WUYFduwHv0E9aTF8PgZ07F+dcUjoe8Iimx/x8J8mhtGp+G00XePpKdEmNvkO4z2rKggI/1ImWhQLePg37tK2xlbotmfCY2D1G4zo58/Vd2J/xhaboraW4II0J9GMcxWQ4IpL2J4HBSdMmlxfO1PlUPsUPI+gsEb8hHPci4sklfLNJK/kH6AzYwRM47KgD6yqiA3pentgWZobrd2PhzMcQvtcoYGAbpdBvDS3hhIsUVsxb19+ugoAlghz/5OFAl/j7OdS7t6NXg7Uym11T//PuQMCYlkyiorJPsc6NJcStibEGWHo4RmTI0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WisfPxbQJQ7TDJJHqC8qQmgkAFnmwETL6QTYfMAUrN4=;
 b=gvWW3BhICwoQ4/ReEXGlyVNT1C2iCeTmnDYNdlt2kFQe/4/0izgW4ksKo8cxOpE3NzjtFy6xP5K2KN4M0hlQ667WuWhgcI3BWkJ/EgQsHx597W74jrlQzKDJB8Evgy6S5Ojo/hzsK5oT4TbH1fmlG+cAf0uL6OZ0CrVtApWDiyFkQ797C5hLry8WkAB71ReXsDu9IOXET96E0ZiPV1zR/q7oeAAtTkfRFe0VhYTt+Wj4Tr/nBCh4d6pcP6urIOdeXNjihwCkqKyE18PFkpikwYPhaflcB90SNlFzrqoj9VtR0INuzHQaisbtYhtoW5nbm2t7IYhXl5k03dh3rZfraA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:00:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:00:11 +0000
Date: Fri, 4 Sep 2026 13:00:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Logan Odell <loganodell@google.com>
Cc: arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org,
	pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org,
	pbonzini@redhat.com, maz@kernel.org, oupton@kernel.org,
	seanjc@google.com, bhelgaas@google.com, alex@shazbot.org,
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <20260904160009.GV4157646@nvidia.com>
References: <20260903023452.721732-1-loganodell@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903023452.721732-1-loganodell@google.com>
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa9b40b-c6ce-401b-5f7c-08df0a9d999a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c1F5s7/JCC6wWnKfOceMxpvxGfhciNBegPTQUfHiHL6vdTVr90mbs40Jt8X7/cTHsglFxz/pP/BQEKTV2d/QF/LCOjvspiPsYoh5PP7m8QcfmeNReKq+FLnbDU86YqC2/zqm0cryA9ITOrjfuVpr7k8HHbxEagx90XP/NbhO543i9Eaaf7o/O0CyTdVmYTMXZ5OqlS8hUjoGW9C9QkTYGnymAgZKR1KS62mbRzIRwPDPPnRTFHI5J9RVqDb9CIlpFuPZnEvLsC79xgAjgKU8+ITNb1zttBZWg25xmyXkeEKPBOZQHqJ+Ukm8XBnf5PLD/2PYeXKiw70fvVscdkXWP51e81kt8gh8cR8ADpuk+xSaL4+2kSEaiYLw/TT0GpDMgkhgbZ+hFdJDow8J06PtlY7O0ovGEZg7FQugPhDukqC7Kp2ZlJ0VuHsExxGxiJAlE2EnQAqykUiGg65Edvts7HO7C6lJZk1UUcKLTrN3t0PR8HeUqrMp0FVtf9VrOU8cSKROYzuGKsSUjRDTiVTA2QFj++QJZRNTmFfwlJ2o3PH0/JYySXxG7F4LTtWtozZstQqDmE4S6rdkBE6VwrXtjZ8aMxvUDBplspdLg/GcPx3mFCcFC4scHI6N9S5Gl5qN27j/HgqCkyaKZDyJvluPRjVHlocBbRJMR52+HJas1Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xV5sl24cOng/+JXfKVV+LpvyukxPrPvydPS/6gUXIv8OPVUoFbSED6nAKr6U?=
 =?us-ascii?Q?ig3NhsIPud/LTHR44SHYWQ5ezyu99GAzvgHT+5gItsXZ4n4P5hDrhhhSJjzw?=
 =?us-ascii?Q?F5RM8icwxbLQequ1f3QXcU1t6OzwjfTBFkAGnUW31B76c7+rZ4BEjcqVJcCh?=
 =?us-ascii?Q?MW+IjMKVBIdxC7J1XSccQEILKba4a51OhK6tFQqzJrwTR//HnvlBn42jkAxN?=
 =?us-ascii?Q?se5C1kljO1CS/ZYW4SM3Z5xXXoDAJw2iwm0qrBFf/fuxRrPZ/lA7P5HFCWSs?=
 =?us-ascii?Q?9kLaBl+Cz+KJT0WACsw/bmWlnome3lDytqxkXtekzoRY6SCb/wGxRqGByBGw?=
 =?us-ascii?Q?cTOnLa1O30aJS6yCxkM4tVnOhi2r1Ks/p593fjRMUedZoiqesmKs0PuhgXY/?=
 =?us-ascii?Q?TlNQ5ST9ohavmeStTg0C5P8gomlqmEGmbTx8GrR3pXt/YyCdtMNKjgsB3U2a?=
 =?us-ascii?Q?Y/cySKJqYmPgx1VItcpP3WxnRv3rnyZgqiFHV9jtb/aaRM+cXFeJ2m/Iicb9?=
 =?us-ascii?Q?eSeQHjcgf8Ho6q3zbh64P1dJMKMn8velA5hwJcsjSVtpKfossGjy6tQuH7Lp?=
 =?us-ascii?Q?e2RPBeFOHzbkUjYEGRjr6g5n+KEMRLdc5VKr0TgejbNsfbZBkPhRzfTNASq9?=
 =?us-ascii?Q?ZiLWAOutMFSXW/gIJXfxL8XaGQZ3eDhf9zImq2cUj2/4vM/yUfC7DK4uOASw?=
 =?us-ascii?Q?UBovpc9VHielk5AJfJbvEJS0zLWGhi2g8Opvr3TUeVLgRJOIWHny72a8Vgfh?=
 =?us-ascii?Q?VPDFJHvBXcYLYg92JlPKFWcTAqzoDg+o6f9o2OpyI1TZxegrvWYzjhsUuueL?=
 =?us-ascii?Q?oYNJNup/qOt6iN1wvV3e+zZEHHykYKncqUflCs1YIfz1MS/ilkI+SbZ+iZna?=
 =?us-ascii?Q?Ubh860vrgetZeYadBmidAG1oQ71QOQS5kdopI09ira3HzCk9We+QSHdX/nSm?=
 =?us-ascii?Q?Uul62+VSfo4w8K3R+lj1oUYUvtn6GiKzGV9gvouWeVszdlQrJAO4BfnWWg1D?=
 =?us-ascii?Q?C1wRBuzpAlrvMESJ39YwxXCUawHaHf2e/6Hql5Xh3eoMtlcR1sJRu6EH6Fhy?=
 =?us-ascii?Q?HcYnOAI3zXHd3MiFZJsoePbtGGxrusaJd4S49TQKAEMGahwiy812+n+DfrHx?=
 =?us-ascii?Q?XWevVpwJzTwcFDX1SE401Bcu4faYOgBZ73RtEzledDBSQ6KX8hVma02Wlo41?=
 =?us-ascii?Q?C/x+v6qlKtOXXQ12pFspnTXiaN8uLX4w1yfD8KEm9yRkzstgp1TQbLprv/pi?=
 =?us-ascii?Q?exScVHGVpT6/Qs1f9EsLKL3srJvW6qgSnzWJCshVHONBz4206BpmNGQV8sBb?=
 =?us-ascii?Q?JZR01urlOqkuYrZdaiZYXXNXOpm3ey/xo5u92sY4q6eOh+psBzE3USq4+yU7?=
 =?us-ascii?Q?wtBq/av3ZsecegOOAXwvop40IWxNfBV5S1E8W+gS6MENOvwcreVlsDndmPuu?=
 =?us-ascii?Q?f7gRRoNA3lpA1qvVQk/pQUDimVo78OJVozp8gwY3/KwKALfH0vlcbSt4S1fI?=
 =?us-ascii?Q?8b/GYswBpPg1b6UxEXFKd36fHveuP4/xLRHIsVvSwFzdu9qDEqyDpCScsaDP?=
 =?us-ascii?Q?aTTNmYE9tyXQkzLgjVheELag0z+tyfHmzkwUIZV1hYljypL1MvKvv4o0PsAJ?=
 =?us-ascii?Q?lWb7nSzA+12aiBGKlcBUDLl1iOhxP/eU96hmpK+6BuUgztKNUYmJ9J9u0f57?=
 =?us-ascii?Q?xpbQfmtrnx4ZsHJKvTAiDs/ocsQ3wd8gd54iwLC5tw4EedA5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa9b40b-c6ce-401b-5f7c-08df0a9d999a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:00:11.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWdojgZNSskNuyGNN+ISFbG6xbEC5yT8H16EoHvt4xWi+RHq5Wshm8JQxguaRiwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_090033_396867_FBCF1EE1 
X-CRM114-Status: GOOD (  11.39  )
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

On Wed, Sep 02, 2026 at 07:34:49PM -0700, Logan Odell wrote:
> We're including maintainers from all subsystems that currently is or
> will be expected to participate in live update to ensure alignment on
> the path forward for compatibility.
> 
> Currently, Live Update Orchestrator (LUO) and its file handlers rely on
> monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
> validate ABI compatibility across kexec live updates. Any modification
> to serialized structures requires bumping the version string, which
> strictly breaks compatibility between adjacent kernels even when changes
> are additive, backwards-compatible, or optional.

That was the intention, I aruged strongly that upstream does not want
to maintain a CSP matrix of endless kernel version combinations. That
is far too much work to push on maintainers. Upstream would do much
less, maybe only same-version, depending.

> This RFC series transitions LUO and subsystem file handlers to use
> granular feature bitmasks instead of compatibility strings. We replace
> the compatibility string with a header structure that includes some
> reserved space to define the features that are included after the
> feature.

The compatability string is only a small part of it, you also need a
serializing ABI that can handle some random mixmash of these
features. Ie the various TLV schemes that were all proposed. What is
the plan here?

Jason

