Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA71C5AD49
	for <kexec@archiver.kernel.org>; Mon,  2 Jun 2025 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ddg5O6tDSFcEbZXZWakX7Lv0p4h8L9lENEh5tzboXM=; b=KfsTuGhPjkPpGDCOus7qZzORve
	tSpOlDzqvFONS7EiRFDwIFJeOpJBegLA50GIRvUPlCoQTwbPbUQzfZRJacOLlc73ewOhPAD6AjaLA
	2Ol9Gfs+R3TP2Lf9zBGxsServN+BzwxY3tFnDpYjFwtV+Y6NrEQ2nie/6iMnAB2PkhB9YrZhb8l2W
	9CxTWIssi26JUdsc7CHZPLQar+UuvUyEldiKpj+OtN16/suEX/x/p5khMv0srCFmiVYKh7v2Zn7G5
	LxCKl0/yxlXO1azhBmt3bLrLO8SuWgMZPhizzomjMTh4ZqmSBjRbbUEWF/sDytMSPcZcezfX/5u/0
	K5C7kKEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4wi-00000007RAp-0BRx;
	Mon, 02 Jun 2025 13:11:20 +0000
Received: from mail-bn8nam04on2062b.outbound.protection.outlook.com ([2a01:111:f403:2408::62b] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4wd-00000007R9d-1iBo
	for kexec@lists.infradead.org;
	Mon, 02 Jun 2025 13:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjyJG+53osyAcALo89hGgUmQOq4FtaN8kMS4HsgYpoocH8r0Taj+SG+HXdv0u3JOYOYoGD0ywdrkiAZrag9YmvlphKjFEZ5aqsCUMgIZ93ApH/9ZMQyAl8tVNO6gzx8V3dAyIQEgdj3PIEfs3UZw7akPejEgatQUxOGxTt7e0uTCSBmioATNEUq4V2lFfD1QkCFd0B64L1JL65R/QZeVjgkpQUA7M17JAhbX1t2fAvCIFGIRdkdaHXWKjl1Kf7sL7J+VORemWoPjD3bvkd+llhAonJHZL3FoiRcz8qYcbauQdAsMiPjLoIPUepNMWTSiDBpbcWlP/xTlMxy6W+KQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ddg5O6tDSFcEbZXZWakX7Lv0p4h8L9lENEh5tzboXM=;
 b=zQU+ZYB8/X7/mpJDBuhExPgynS/dG7d5OjuNSkolUZ4HHZtDbsqXMBrtUTob/lpU2DiwttpGiOHcVV1VwnWXwjl2EI1UPPvFul8YVvVc1EgarCp6jVW7IoLsPqPWFvNHR52S6Gj5KQBn3ajqLUfATkkHHTqGJ87TvnKcJLdEvjF/W1mw8TLGE3bs8PT1zjQZ/T77xiUVP5sNtcrqIOVUeHHEjHSYa8pj55hetlDMDKxCs39joYqXQZpIN24bBHKlib6XKtxErNqL7WL3gxtOuxQ0GZ4ciTtMP4FC+AOV9xMKHk2VPjEhKNSGehfm/0EGkeHLcMUslChxvILYFuU9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ddg5O6tDSFcEbZXZWakX7Lv0p4h8L9lENEh5tzboXM=;
 b=fr3OMuE3sxvh+PraQdrLkal1MD5w5M2XaNI7CEmO7gLz4Te+ZZFloXqLraiLexWzJl1DPZNgcZGcvQZ20q5HfwdBqreAtLxnBADvZKitckpbkY43QRIU5t+JUfXnnSsFUXsv784+n4qFuMZ1gRZH4yxsgFUuhaAcpBWjkVhC28HGBLXxiilgy8/rmkhfj6RUX2jTVaPrxTU+wqkTNOUX0NcEGN50qpjT19vea0vOmlJnus4V9RnJIlj1zu9vMbQI+B8Qwy9cPUeqjcMeFO1wldYiepaI6AxgyZiyOKF2irNVXiLkJrQG260+vgZ/0pFzjZZnhHA3VjKUoOpdjbyI+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 13:11:03 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8769.033; Mon, 2 Jun 2025
 13:11:02 +0000
Date: Mon, 2 Jun 2025 10:11:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Matlack <dmatlack@google.com>,
	Frank van der Linden <fvdl@google.com>,
	James Gowans <jgowans@amazon.com>,
	Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pasha Tatashin <tatashin@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from May 19, 2025
Message-ID: <20250602131100.GA233377@nvidia.com>
References: <958b2ec3-f5f1-b714-1256-1b06dcf7470f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958b2ec3-f5f1-b714-1256-1b06dcf7470f@google.com>
X-ClientProxiedBy: BN9PR03CA0456.namprd03.prod.outlook.com
 (2603:10b6:408:139::11) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: f27154c5-78de-4e0e-a62a-08dda1d6ec82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3K90HIqCV63LS4lKYydMq097+5SkFZqy+6gBvo2wj8E9MRs6jD9EVPNJjEO6?=
 =?us-ascii?Q?JAaMYxD+8GjZ+kCunlEmcsmRmYaHLBq/a+V7jZXhrDEsjHlwdk6+lU7gAZTq?=
 =?us-ascii?Q?AzwdeR/pCIQVak7hjRgSmUamdRHjp36cDgebZba3534ECjbZpLbLtenkAXee?=
 =?us-ascii?Q?JzmLj5jVcpt0P/WrcIKFKFMMx8vwKFnJat0pkN6EJpGvQTkP8AobR9gAfAmt?=
 =?us-ascii?Q?o303+t5bJ8D3E8C5lCwAsHboOxOVq7TAa8j5JwqmCaKJwvrvRBF9Prna0mWR?=
 =?us-ascii?Q?PAIXGWOs3qDo5KKRIfhZ3x4yx6yvf5h3o0m2YcDBVDetEH/11fkL4l3P5aUb?=
 =?us-ascii?Q?ABud9oWxvYJrb++WsxlXjGeat53LmBru8LSM2SjOsBFcg0UeASvPh56pacBK?=
 =?us-ascii?Q?jX2bmKo7qSS7PGkHVs4T0l7a714KPlfAHbsOQNNaZL1y6IbKeWMhs+vf8sGo?=
 =?us-ascii?Q?Gdf8sOcgLsZOAQ4UPzjV5DIJBIBxslSoP1Pu8z1Zn0hpup510BLYAJ3+xoHg?=
 =?us-ascii?Q?d1dqd4aAMq0tAAtjpFZPA7XBzGAHOwBo+xwqtgU3oe1KO+cG8vldIZRy7oAU?=
 =?us-ascii?Q?FJocMm1YLPlUshRj6TJd6Ohmr5xd/0L46MnP0qxQRIMnoIwmT8WXk+9Dv2ih?=
 =?us-ascii?Q?qkPXpFX41BbVNA706eqj23mAxsRxVKuhTtLp26LrOn0IIesgbTA8bnPfMukx?=
 =?us-ascii?Q?8prmnDLjH+B4Efk3a1Z6zKE3F6Hs9abgCt85QK/HulxOuPQiVNGEP5chUyB5?=
 =?us-ascii?Q?05vli0JwkZ9Oxdpa3oPYQhg8S249tidxnAwdsfi+gdlhbOSe3cbbjQAKVn60?=
 =?us-ascii?Q?j6MYYvaI43Thv0YXk+LNh03von9jzQA6zNiUe/khEq9QI+dJbYTSeLbPxMhF?=
 =?us-ascii?Q?iR+Uu6YjXVrWipZLPFwjhFL4wICQ0mPouolQnPCKGQ36V2yufbdiRUV5x3ZR?=
 =?us-ascii?Q?3vy4OgBE2Cl1XU5paeBcooO9y2XS8apcww1tf5JsIec4ZbzacmVb5hIbgO4I?=
 =?us-ascii?Q?6TaUkceN7wOzLFzk6qxNt6Fn9xm/rcnUOBsczgmaOwN1wU7LaWG1BenK1cRB?=
 =?us-ascii?Q?Yd1SwBUUnuV5SiR808us8w4SegotM0JcAqhLfCFRaEUxYbBIOiN0PGWHPF7K?=
 =?us-ascii?Q?vTsEv9Hi5vNAaE3H/53JrMRRJXWa/v4zQUoru1NgDk9sLdI5sfAeYdHJ65+9?=
 =?us-ascii?Q?GPVcBHznOvWQ9mtOXCEWLPQG9kfcQTNRJ/Lw7kG/MaljPvvd0Puqd8E8y3op?=
 =?us-ascii?Q?diJQsjXtffZLmL4S/PIwCjQHMbmSLWpPXzHoKIK0pB54f6TIaXHT5UCsPiU3?=
 =?us-ascii?Q?Cctu/EwZnE9GROjc2GfFfGAjcYF6qz8SiR/KvkY48GfoNLGjBAYAvcli4hcU?=
 =?us-ascii?Q?s187KHBXaLPXYHTnS8xA7Ihx8B+BdJ99SteKSPODAsq4gX/9lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5pTAgQTu0nOEYAsh7Lt4fz5XiXKb4k1KShuxAML7ZXvbkqwJ5Xb1U5wZ8Zj?=
 =?us-ascii?Q?ZPD4rOx8aq4akNcIXZDcu1/9p/bFX/Nl4TdIYADyaqr1NdBJBb33QJO6iHXM?=
 =?us-ascii?Q?itLI9to2kXaJHd2HcuQde8XXROSKRy4Wne7bo1CrlfnVz14E7qwrlw50qlE6?=
 =?us-ascii?Q?ky1t77twT1Pp5TjgVEG047YN+qG2H++CivfP6fTwRPzig5US3m2OMhmZdrvP?=
 =?us-ascii?Q?wD1kgxH7Zv6D5GLC0w3E4fakCrqks/SBmeE1vcZ4geKV5rokijMWE/Fkibkc?=
 =?us-ascii?Q?yI0m8Ki6Uv5tTk7zp/ZULjAROSOean485QZJRBHyGiOeLrEty4ivgyI10wdv?=
 =?us-ascii?Q?sI4xPeJDptq02eIF8aBq1UrR/NTjQ8X2r1PoF2H8F4s1Ty17/7/i5jbqpaSb?=
 =?us-ascii?Q?YObsMADuYyRX5RpFfvbhovboGVT4iSQknk39kbPNoTipjEUtIDvZWChqZ1mi?=
 =?us-ascii?Q?3/f7sLnU/4kXFgCp8HAAw4/onBCcpWXRokYkvo4mLMoWVeMoE8jPKP2AXrJa?=
 =?us-ascii?Q?yVQthe4sz5srHvX5qLZxMxg2Y79SeNa6RM8CVBfye+B43rMFA1exNkwoCHKr?=
 =?us-ascii?Q?RR+VH4eQDvtZfkrft9E9SiDz8T4bEvGHzqa9BHXDuIzEfaDS0OWaeRJKIxJQ?=
 =?us-ascii?Q?NMBaZIX3svyfXFGZpgsy5b0fyeaeQVNreyAjSM90fEf6SGhdPakVJoqjLX8n?=
 =?us-ascii?Q?wQdjPm8fnZOd2bY7b3h4lAeGpB7Tz3omFWjuexYxeJVoZrwf4zt5WH6c2kR4?=
 =?us-ascii?Q?Zlc9Q3aVMkj9NMgId79NOJ/llHh889l7UfxmpAEEtbQeYG0Fnt6ulJCgYceR?=
 =?us-ascii?Q?C7nl6btby85GOcpIUG7lNmzncoJFhGA2cJYnO5ehIDP3ISZ84mVK+zxOGIn0?=
 =?us-ascii?Q?jx+NE+0d2kNlN+ydwW5CW7EefVcoMZ8pQxazWfIvl/PC/9wH8q/tIaxFU6oD?=
 =?us-ascii?Q?rFmRfOoP367FM6xZHbboQtmRLymxcJlBwidZYeTmZ+AUHNwfJwEUzkzMMjvb?=
 =?us-ascii?Q?09n++YjStO4mMLwp0Wowp57X+IjI7a2jlMyENkA2FgXwxdtM9qlmZIRpzXsZ?=
 =?us-ascii?Q?9PP70qmpvtPy55PKLhcrzZa6pgBLuHfs9qPNCXoRw3sZrTBr7XdxZSWxCGCn?=
 =?us-ascii?Q?YYMOQjw/0xHhOmkcRHhOshEynPDWTmbIrtsl8Oaq/qPH7kHplmiEI4eSZ9zM?=
 =?us-ascii?Q?rZB4r1XBL2G5NveJFm78B8ztDkjXhEI9VwzF3ycxFxZwmx+PeCS64p7Rci6Q?=
 =?us-ascii?Q?a/LMD/gRJESFI/8yPaoOvTS8GLdpe0xMygONbPAaBssn1+oI+k4wPCtePpa+?=
 =?us-ascii?Q?tx2tRytZky1WVXFzJMJrGwgSvInxHHYiL6T+EVW8jfw5XZ0r3/uIz/DQWiar?=
 =?us-ascii?Q?Vtr5meQ/922NeDXmGu0G8K/icLxmHslJ2wO5lgto5g8z3Z5u8taIYyXTNxSn?=
 =?us-ascii?Q?M6XC18vhbtUfWog0N8/IrDOVNUdD/JixTU1OeMfZXBR7FpFO2xxdSyGrWWGv?=
 =?us-ascii?Q?sVMS6dNZZ13BpqJC0dT/jgsLokEsRUfROLXSTgbWlO+s/KyE8FA1XgeF86zm?=
 =?us-ascii?Q?lQSi6i9PBwlJ+ubuaFY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27154c5-78de-4e0e-a62a-08dda1d6ec82
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:11:02.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91wrzt7ghSZ9H+VuIriDHMHAppaWvLy8rrXx4R5magDlUuc/kRoJXA3YlCUZyQqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_061115_448863_3F7B7AF7 
X-CRM114-Status: UNSURE (   7.46  )
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

On Sat, May 31, 2025 at 08:16:14PM -0700, David Rientjes wrote:
> Pratyush asked about the relationship between KHO and LUO.  Pasha noted
> that KHO provides a state machine and in RFC v2 of LUO, LUO can drive KHO
> which makes the KHO debugfs interface optional.  KHO activate will cause
> LUO to switch to the prepared phase, for example.  /dev/liveupdate
> continues to be the preferred mechanism.  Think of KHO as preserving state
> across kexec whereas LUO provides the state machine.

IMHO LUO should superceed the statemachine in KHO and it's
debugfs. Just remove all the KHO stuff here. We don't need two things..

Jason

