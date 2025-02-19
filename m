Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5609C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tiw1uzBO6Z7iE7rrpV8RZ0KTH2cyQwd8yq3WE4KKFas=; b=afl5xtYVsDIpzqdXa3ihfqtQAh
	K0dTVpszJMH8TtwXiiQNQW1+z3Me7ENGClTmAio99j63tgMM5oNFYBaNNAeuqMoPt1n0e/AIaah+s
	AzE4ESd9cS1T3w3pWZf9aQfQ+8LvZUzIYD7PEoyeJyZ6JocLfGRPNLqQ6Yij7pQfqP5uZxBB+WGek
	tcxmx8yo4KH5XJmQlWh6juym6y3iLgxiqX7HVat2AKbWqRolB3RgdAPWXaLJxCJJOtENEFsARjh4q
	s+vUScGX/th+qEQghbpKBclxelEbgpJjAtnkJKPh34GKkcNFt+myWOYxjL3Q1i+tsVKohDeYZIF7J
	WHLyoe8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkkDL-0000000Cyw1-1Gjs;
	Wed, 19 Feb 2025 13:34:11 +0000
Received: from mail-bn8nam11on20620.outbound.protection.outlook.com ([2a01:111:f403:2414::620] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkkAy-0000000CyBa-2K8j
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 13:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/9p/E+zSK81ub6bipwhF1IfthaH2tzGkvG3CD2o4IH8DztNktw7uQG3GErqkdRaie5zpwmL+pEyMVnLxYW61IEyhN8AJbk2glPbEu4SSctXdnMXTpKOu265fYGFdr9wpyDyyHzNM5p7X6FJm8Plq31hI/CAMkehG2t9deHlT/B4xxC5Jq2i7PnHOT+Eq3VyfwdscN9/mRIC1vZ0CbgavqWvz12DGbsmQsm+UttQOgeIryypWV9awGA4EYOJ4foTx3Vx9YOHKm4clGqE+eBUyx4Jmh2fwkL3GGqkyDZUgUhO4yGVeX7DIR2ky7IqFO/br1LC0R2nlvxhIxHDPI6UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tiw1uzBO6Z7iE7rrpV8RZ0KTH2cyQwd8yq3WE4KKFas=;
 b=MYDKdjhquidM8xH6R0wzQPJM1XtF0GfUOlp24GrwjozKU3I0+fWx7/IzekUTjnpz5/uLdJwC7mjbcR/et/cqGq0ubqXvjYua+urqf/87/jhfcUTBVNtqJBAHVJz/DgXT7+ja+L8Cv4n5I2oALtPNMBQEY5jiae+GS4U8JW4EUtw16d13bqPxi2M/M3rn9kOzi1xWe1kU40GFEOmXOSkQk4uWwBg6f6JgDD0Atw0+TfwhLP/9ymIMsMbIgka4LGjDaqvT5+m1URlpexRKGRgUrjt9YeNn02UfbM6tYvGqxNzm69vaWYrrcoL2SlwQI1k/rD7F2MzYP2oXjqYPSmf6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tiw1uzBO6Z7iE7rrpV8RZ0KTH2cyQwd8yq3WE4KKFas=;
 b=q/Dq+TqvDuUFZ2VTIe6kDhvIKlYVUbXDyUGckyMccfU7LfF3/Maku/CeC7LMUnuxytna8VAvauAERcqUAHkgDKynf/LOgqsd4g7gVh9qcfb6UAEys+eMyaJtMJMC/DWoVFnbM1Xxp5Up/PaohuWYYS/eo9kWKk1p8XIhXa4qyGipjvzTMhntggwnXxJ4gKx2lymd3jgUqjmoKlPcRsSJO/r2nwAQmh8p1+WZwVTcQ4v+RaBP9jsln9dDpmvQPgutuGD2xgdtnhTjQ/UUzhR2C4LU3aY8LgpJrzgmVvhfma57zNvVhjr6NAtgqbfgsVh43TXKh5DF85xel2zWKZZgNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Wed, 19 Feb
 2025 13:31:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 13:31:37 +0000
Date: Wed, 19 Feb 2025 09:31:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Frank van der Linden <fvdl@google.com>,
	James Gowans <jgowans@amazon.com>,
	Junaid Shahid <junaids@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pasha Tatashin <tatashin@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from February 10, 2025
Message-ID: <20250219133135.GM4183890@nvidia.com>
References: <dc1ee0c3-d3e7-4284-6329-346b8cea68b5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1ee0c3-d3e7-4284-6329-346b8cea68b5@google.com>
X-ClientProxiedBy: BN9PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:408:fb::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c4b4d2-ebcb-4831-a8c5-08dd50e9bbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hn3NA6sDdsNB4HpMj3syfmIU4hrfJmk4P2NXECU6l+qnc/pOuPsX8EUs5mNT?=
 =?us-ascii?Q?EJNvSxdVNwRncwOs6rYjfR5GcHV1TXdMczxx/si73qmAMMIXmmS/QLvdRQ0O?=
 =?us-ascii?Q?E8hZhx4ujI//7+7PsgCrCFKiLquIBMeS584WPJ51IuGQLgFrQsQqlH9zSBF0?=
 =?us-ascii?Q?aLpDp+YVsl5RSnm6qO2IPp7/Mdy5sig36kGcPFPPE/tev30+72S9kXsRjUn5?=
 =?us-ascii?Q?pfpHb6jpjToxn6vAZO2EtMT6kRpOvOWzpsUsFMj+xkRKTYP8TkGck+VmfWWM?=
 =?us-ascii?Q?20SYYqshO9kbVmp10a9tb5qwKPd/6KBP7uwiRxgIqjy8qn31WDaNNzBfzjQ6?=
 =?us-ascii?Q?/cnhP5T9hP0c5bjn/2ex3hvDP6mcE5OzwFDahgsXrC+81x0yUUE4zNsVuiUQ?=
 =?us-ascii?Q?wfPOskriXSqx28gzqgcFYZfoLwpd3ixBMz8PlskIR2dk2f7cxSuh72AlAj0o?=
 =?us-ascii?Q?wNcfhi0c5qwzPMbWbPp23Onynitf9+18/jItM4wb1D0c2KPf51w4+/ZWl9M4?=
 =?us-ascii?Q?JHIp3iPP7kUkR0Kl7+LiDkcOSlRytdJc+Y56axwRJLSlGInpu3QvE7PX0yxp?=
 =?us-ascii?Q?8xHyUXemCRsYWttWb3ZuuBgAxalzuI9g9sfxcnpVrd1ar8D925EBM4fseRxM?=
 =?us-ascii?Q?FOXoLVS44SC+pySbOWcFgi49IV1IlI6Z5DS2OwSmGhMbPdM39UZ+9fKED81j?=
 =?us-ascii?Q?LjGKm7FfoN6+lrvtN3OglWZBKPHyO/qizxiJ7HXyfdsLGw3Cz/s07Wv6O/Uh?=
 =?us-ascii?Q?wfK4U8oFXaoJyKvHT4hfNe4cGo6Yhgvte8gM4ZeWl3PKVNERV8zUfjUtYU1E?=
 =?us-ascii?Q?aa24aEcvPtikQq3aoxoG9Azzt0I63HN6y1qcbYsyNfhcEQpKf885zrkeS/R7?=
 =?us-ascii?Q?NS3Db4fFq2DV1QbVYWyW3qh9eo5j14ZUuMkMKtpDZFW03RFxCcEkfMY7Jv2n?=
 =?us-ascii?Q?R5Imbi0sdR6O145QjAJAwY9CbnFBuxit28SagoPmD9x1stPAng6TByBvpypO?=
 =?us-ascii?Q?HYU45JlkvMDUN/gnLSQyY101IgNqMsmFsD6xjyVBCspAofMyPjbpi6B6up04?=
 =?us-ascii?Q?6uBl3iCJnzVLy66CPnvFrd/aeBR2ojmeiRKRLY0gWF0hnuvYTvlDD/HLu1uo?=
 =?us-ascii?Q?1QAIg0idHzHOySmDT4rJN3vhsEEEk8V7IpFoZXQQ1ZeQLP8AtMlyNwNbE/rb?=
 =?us-ascii?Q?rEH82lNODnWFbCZJGwuuN97qVLiCpq18RQxcsbb/mdlTbnrMN34u7ycR5Wxq?=
 =?us-ascii?Q?WpmF7ONG4Fs1H5V0Liu1BzgG+IsTZ7ZRUsaIxnlZ8QHObPZJpYf8V6rG9MAA?=
 =?us-ascii?Q?ue5MQkFMYPLLRLc4p5rPca56l+DHoDrVOE9NyPdjoJrvGnJUw1t3fYuljcYM?=
 =?us-ascii?Q?ppYNvjXc+HikXFWtAcYc9IDy5BNg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cfz2z5vTmFD9OtIpsMsw4l0dA+/ZJCirtcLAzPAAJu2FXK9w6yHUNjIdpZju?=
 =?us-ascii?Q?qR5nRZGU4mf8tTVpsiZH29HixTWrs2mD6IQfthPOR3B42ZP1nQSPvpKZm27h?=
 =?us-ascii?Q?f8W7O/Y9fvQ3dZtv6h823hxACaRyuO4RfAM8vKpLltTsaBDdvBlT1LOmo5pp?=
 =?us-ascii?Q?hkGOBa3Hk075dTvJ84SijvPwxnvA649EQ8QaFpCbx+0Ap5bxzP1WMRfhVkC6?=
 =?us-ascii?Q?79uMakgJhizFr3wZ2MDfJDU5gjzc0QjoYxGOnM/edOE8F9PBpJ2N2Iip3buw?=
 =?us-ascii?Q?8k2k5qOUkYFImrUCwMTQr6H5CHQp/lh87QDQl1SiP0g4u6kIhXAsLY+5YBro?=
 =?us-ascii?Q?iIFR29sikBiIwG2yUaXsfj6MzwcWyzJnptCxa42wtGNuLJ4sDhbWiHZ5UCzl?=
 =?us-ascii?Q?PQPBPT3kzXBBO7pFWeHAxOCjOqrbvMlGZdyJN48esDHXXgqJfq6UxG4teNqB?=
 =?us-ascii?Q?bqmetabJXDfCyaEG02JMkgn/OqMOGp5fbxR1TYEwCKt/xes0zAJY6nF1Dh5Y?=
 =?us-ascii?Q?LdL4onsnVtd2KRitvB1gjDcfgsV1rguvXSpN5HVrcIdSI/zPrGj8V68L425m?=
 =?us-ascii?Q?oxMIK5rJdPsyaPSU28q6ggZHfqjNpcsArrfMV/yjXnyN0bInjwA5Wt0jXvrB?=
 =?us-ascii?Q?oJUqsVgqEkUzLbsbQHZKbXgoMr1eR2WY0zH4lEskXg63CwXbDlJWCsKlLgJT?=
 =?us-ascii?Q?2WfNKjt9E7jYzXajKxr6/ejtSGUI6L8w5z0eeAkFxsLYnAMP0L2TKDWgDDHS?=
 =?us-ascii?Q?A7B+Ly9opdfeWkmaywPJdQg2SLK6ZvijvEKKAVab9iAl/t2NbMuyiry1l1fr?=
 =?us-ascii?Q?nz+OGejwa1IqduEAwu711Kr5HGkPYhl8pGlU0tvmEc4uPcEif3l14TLihgN8?=
 =?us-ascii?Q?AyypyVdq72Y2I8WPoUHAAO3pYscRB7347hIskYyAxFAWV94nYjd7wP0Wtjuv?=
 =?us-ascii?Q?Hw/xTtQgobwLc30PtFeY5PfNz5B6yXHMtalyPM97pyz/h81VnbJN+M5z6Lgx?=
 =?us-ascii?Q?nsAyFYyJTipmI1gHp+Xx5t7hJzQTdNRjxw/a6odMLF4AQ9lVxY8FlGMx+5sJ?=
 =?us-ascii?Q?5O+gLcX5uEjjg7uRKkzzjrWlBkmwyMK/F+ColimAJIYttfXudl7haz2iVY5q?=
 =?us-ascii?Q?ATXOQPmWW0twT92X4Qc2zp1UN2MU1qkvodd4h+/jyU/VXkk5JENGrqSkX1s/?=
 =?us-ascii?Q?P7vwTre4qb6nNYSNrBOlqO7hkO+jZwIFuFkETZq9/pu3RZHW3cmrUNrC2x60?=
 =?us-ascii?Q?JGU/p2srP9o4mdFCOkKTcKTKK3SvphixW7Q0VQsEaXOE8yJN7SIEEVIhxMNg?=
 =?us-ascii?Q?fB5VXo3xeeat9kFz1q6c2y+ZopPz+1LTmPgXTttX3gSw8u//K+jNWT3tSeWY?=
 =?us-ascii?Q?oCSiVWF2/lE160dCssa3kHOMwyNzXobNVekslp18WWLZ7CiMJshJgSJBF+1s?=
 =?us-ascii?Q?Egoyf/an/+XH89XIFRzWgAIj7CUYBBSFYbJFxequvMdsXM5lUQ81leAIAlGo?=
 =?us-ascii?Q?SW+RCXaR97v9x/c3S+IUi9o18ZY1efCsPP6SR2KdT85n67LjZbprURPIXs42?=
 =?us-ascii?Q?xK169q2YecVnw5x2dnjl8XYdrTobRJEKYIgRBMzm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c4b4d2-ebcb-4831-a8c5-08dd50e9bbf5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:31:36.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf3x/pw3XhUc9CENUSvAaPyk2N2SwjC8NIT8ZlJy3EDVOUTvHL41tZSJyVgQ98hS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_053144_603752_79FC01A5 
X-CRM114-Status: UNSURE (   9.58  )
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

On Tue, Feb 18, 2025 at 08:04:47PM -0800, David Rientjes wrote:

>  - the future of guestmemfs and what it becomes, including alignment so
>    prototyping can be done

IMHO we need a generic FDBOX sort of filesystem and the ability to put
guestmemfd, memfd and hugetlbfs (fd) into it. This would completely
replace the need for a special memory-only filesystem.

Most of it should be doable with the folio preservation bitmap scheme
I showed in the v5 thread and is not particularly special.

Ie for a memfd you take all the folios under it, preserve them in the
bitmap, store the folio phys_addr_t's in a linked list of 4k chunks
and put the top of the linked list in the FDBOX for that memfd.

>  - establishing an FSM for all of the various states that are agreed upon
>    with common language (when memory mappings can happen, what is
>    disallowed at certain stages)

I think this is very important, along with explanations where people
expect work to be performed.

Jason

