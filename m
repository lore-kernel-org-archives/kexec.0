Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775D2C36000
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5Jz1u+9vSfzaFy2SPIyzvAcb5YkrDx/rF/2ZGoxHQs=; b=uk78ptTY/ZNvpIjc+agAwRmyJa
	OXNUpoT7axVrTK2JkQUJfgou1fjFIkRepffNlX0dQWXalnVc2b6eVWEm2iHhogo3ohp274x+hm8GK
	XahosKCc8H1HAYSZmqksMI+hWrHKPq9BN5TsMtNc5eaF/p9+oh7OIfbWfflfe9Hz1mREEmB33bAeR
	X/wbgMWSbJ2Hqt0atMBOJ7iBmeSIcZ707CMGWcnkJ648UgVKESFfqhyd+pxXPrOeJr+qmBuJGVRLK
	hDvqzumWPtZIPzQ4E5ga/lG4ybkpAuLja1+mtf2BXV0fEkmT9FAZW1jY63Mf4El8wHHMW7oG3XhiR
	xOymVFcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvEx7-0000000C6eq-0hk5;
	Thu, 20 Mar 2025 12:24:49 +0000
Received: from mail-co1nam11on2060b.outbound.protection.outlook.com ([2a01:111:f403:2416::60b] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvEvW-0000000C6HL-3xUj
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 12:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXEHA+uyR9cr9ANHf/1M5lXDGcY3THwYwi+U5Hdz3QCoUyCC9mhSlV8qRLHRtYWN+oRsgirkLtINuw3pPiBr+jqlrwzm6anUOioBBYYHLztmYMkpczcT3x0cfW63rOR7d0FyzI2FTqfFx6NJ2ZHLN53qU9ZcxAxj4Oc2GpsjqRMtALpR2RLWn0Zsm4dz8RmJGj1G2hqfkBs2/lvYMe7KW0uvXf1oPwayakuqZ/jBCWchlyq0M6FM5k2AVRPzEKdl8IYk0ODR/kaXf+5t7AbnB3Ert7F9j/K1N506E5sT+O67R/Oj6rxL/ax7QHhfH+S7X00N9ePc8jwhNiEIRZLeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Jz1u+9vSfzaFy2SPIyzvAcb5YkrDx/rF/2ZGoxHQs=;
 b=lSyGuPEig9/3JgWIZqjfHKAvMWeR4ixr2hmsRX9QMYgYaFXDeTy+wXSNFbcf2EIJ6NCdSIbq3xHwX+0hcT2Al70fCbCYygYE6q6NE34nXc0i6Fky72uXgealmKMXYQSGkNAey6wOIorUOqrFvC9qg2GVZHbXLAGCJEVNKdSB01zBuCScNaLWmcZzYn0VcnoVsTXYa/722TfgBP+juD939G6SQFlHIIPkZErmqtRZr7SsZDvU3rZMastov6q3+Hur9PtO+Gd5QD7SNV8giW0BtgnshQXAvjnxyQKxG6kgRBYu/hE0mGWeRz4g3ZgTWhWFUaXSJ60Ewa/kDUW38Ugxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Jz1u+9vSfzaFy2SPIyzvAcb5YkrDx/rF/2ZGoxHQs=;
 b=DOWWN6q+sLLesgIP5iB24NHJWwX/AxHjGJKkdGeAhHqPdGZiaxJdOYZoLCdUjoYSPcxLA3B4XKcF2ZgwEiTecfCIcEMGNIHYUVLYHfodrJ0jKCj7O0mbMrHDYw7knj2YhpeAdETad6fW+PeFLrCBlW/xrzhD5HIWEgx2JQLyiYoHKPHEduTF7LCrFrGI/2WhZzgzUrmOuIX03P3KPtib1n+59M+wY2CtWnEfqmwLlW7mjaoNqlDrfKRY2y8HxOdv5gONIRMpxBtpYSMfvlGpl7UGcOzIIUOZwKqWK7KI+CjuW9zDZTiJKPJJ9gjjlEIg4AvtqFXMiuS/fWeezcouYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 12:23:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:23:04 +0000
Date: Thu, 20 Mar 2025 09:23:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Rientjes <rientjes@google.com>, Alexander Graf <graf@amazon.com>,
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
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from March 10, 2025
Message-ID: <20250320122303.GT9311@nvidia.com>
References: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
 <20250317172255.GO9311@nvidia.com>
 <755e80a2-60a7-4a04-9eb2-714e89ea34c5@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755e80a2-60a7-4a04-9eb2-714e89ea34c5@app.fastmail.com>
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: c34ca44c-d8ae-459b-99ca-08dd67a9f6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ocneb08w9Bq3dsPNGFZQa3qO7y8nnTlOH5GRyvdOyxEMLIUJAMqgzUDR3y0M?=
 =?us-ascii?Q?sl+/RnQ2DHAPg+DAcLJfiNnsLpNakGdcL4QeekyM2hALZDy5m3PVNHyso/sU?=
 =?us-ascii?Q?Dcq5LRC+vdGdoHa2svemxkodpLtQJ2AyAqE4FohZZ4z6NOXQgdYj28dp8Yjc?=
 =?us-ascii?Q?/H2Kst7MYl1G9YOtCx6SBBP66pcjsJ+qOWB0HorSDgdiIAmuWY40LCgnGATv?=
 =?us-ascii?Q?JaFOsNQT4UXGgXsZ5I3avWqBFiUojMpMZHotz+s3oZNoQnpRVGO8+SIELcdZ?=
 =?us-ascii?Q?z5dgCQGtVMMkm4GJe2LcbCUxQHYsR0uE+JFJZlIV8Rix1cZOk85jW8Qcf2L2?=
 =?us-ascii?Q?uMtIxW/0s5Cz9c9rTMESspvPH33BZn4So7MXoMW9bdV4IU8s/B7jwME7Wz3b?=
 =?us-ascii?Q?irlFYpaZ+Cx6fkp1AbaYFg2VjVpNHjAFovuCAk7bGNe+wO3untesYfVM4PtG?=
 =?us-ascii?Q?3XL7MX/hKYXsdCHwx+bX0mPnnBq8lIhKXThMeBnW/7orjSSDyAPEAf9/vQj2?=
 =?us-ascii?Q?lOfXKusxa9tIGimAcvCtcY/yWVTyPWQ0SCi8EWXq5B4leZYwcM2RIW34qTtW?=
 =?us-ascii?Q?TBps40uC83zM8vlGdOV7NrJsDSQGjqL6x1ZBUBH3081l0WUkMP83G/Wi7dNx?=
 =?us-ascii?Q?461yw/GpyZodJOCHrQFcnda3EMYsPe/2KC834Y7bnvBY6SII5cgxEs8yx5ST?=
 =?us-ascii?Q?BhIkqw7tWF0WhDM1uU9zylEZp9+7r1EtWbkjeWH0oPBE89WP21IGYFB422x9?=
 =?us-ascii?Q?ANTffn1SF0aeugp7gtVNhOWVyZHXrv4OD9NsBe3NiTJWqc26PS6p+7aGibBq?=
 =?us-ascii?Q?CphVWz/Se5MSYdtXGRIa1aihoutmwGWYCkoEeNYT/qhAAGed1lYQOAIq7vVD?=
 =?us-ascii?Q?xN0D8ZcxNIPyFrLsV/xW/ZVzCMmXPQDkPeQ61XUrD/PhxSLebPakYAqz3eRi?=
 =?us-ascii?Q?n3+kmeuCPqupOPQ0PN3PHp9wmduQP0azoiFBkikV+NWJvtaTTMi4MKYEqbN5?=
 =?us-ascii?Q?1/j30a1dzZ5FlOTSs+Gy3Q2QDS+JVhHqJkW4qmoLHovg2oCLfArLJFcqtfYg?=
 =?us-ascii?Q?3HarcaXQaRWO3UMpNf3VxFyYkBVEjIXadR4WCmvrbrXz3ortxYSalZXcFMKq?=
 =?us-ascii?Q?VdB8I+fbljF/ZBtw1Az/USyU98D12yHiZ5twmpze3OEZ18DbmNOWYDb3G3+h?=
 =?us-ascii?Q?VSSuD1YDTrPW/f6OgCXau407k52fSLQ1/61Vyabc5kx865pOZ1C1i3xyq8ET?=
 =?us-ascii?Q?/Y5tK8bJoiRlorHvC06ae9nkzucA+0puMvhjIQOPWLVaJFoygycqbfHmh0Gk?=
 =?us-ascii?Q?0G/5oBCgM3hyR7DcmzaEut6VBFGZTdzpqsyVhHT5U+VptrwwMbeRj8vnKiU9?=
 =?us-ascii?Q?aGY1sGYU89H+l1+Go8XYUUH1VIAk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGSlxT/1Wz2lt7T91N+LrYCf6TzWszlN5q1i2yguWNZcN6GWvLWSPdi0GEId?=
 =?us-ascii?Q?/r8lqQIxAD2wkfVnREXis6RkJHq/hIWUjEbDE8Fee7WbgIaJHIFfhw3c6y5u?=
 =?us-ascii?Q?2lq9zGHlZiKrZtbMnte1XuQ9wizQK75DChtS8uDmKcc7Y7zm0AF8ltmPX12h?=
 =?us-ascii?Q?BGpCOq5w3R4J18a7GmxBpq2rYKa6bAgIz8sNuxvoVtmYktTrJfeS4JOAptL5?=
 =?us-ascii?Q?zp/cGJwnt4iPhWPyhuQuGGj8IcmlhE4bBTBpubJNdIxKoK614rShjOOVmcH+?=
 =?us-ascii?Q?dAO3NSM4ZJsd+d1yvVA37X1V/6MjC7q9gEhgrblbO0g8NQYVWryKaHBJEC7C?=
 =?us-ascii?Q?z6CxktF77JsyL3bRpp9wen8P94J8eDx6g9UDvtjgxIm7IuKbxM4XBaNo0a3n?=
 =?us-ascii?Q?UfiTF45HeTOACS4C1+Wpds+qr8+6YUAqFllPeK1ex5CLPb9qSRpGp4PZ5CcO?=
 =?us-ascii?Q?0SikxE8BTR0bmti/+LCMUQeyUgQLqwCzhSaUoMhTo+lDdCjqe+5W3dGD5VRR?=
 =?us-ascii?Q?ajlXrPRY/vZ+/Sw3zRgX82NqeSnxi63XNQ+w45mNC84g0u1R22M+iVlo88rR?=
 =?us-ascii?Q?EdadoyHmi7RQKHyUUd5EKc4XxaRUkxDZAMbYtGbeGPe2ry4y2zNgXEC5PT38?=
 =?us-ascii?Q?ubaEMA3vgH1mR2rEyQAwaPf/ltJteR85EmthjD/xq+nQitLbiJV3CnnMMawH?=
 =?us-ascii?Q?vXLiBD+vLehqyd9rT7t38VBRihHdJyMMGt4pTkl8JAgOqy5Y66zzGzGdHJKV?=
 =?us-ascii?Q?UAGoQh7StxPmZBeVKu5aYTC2ne8qYzjqbor5024LNFOtpTBiyLXG+mdQdiSy?=
 =?us-ascii?Q?XJIBDyduD4aS5Psn+RfjGmYGZTARvgqI9y7+ZqCezzdMXXM6YWUB6Qo2ruLn?=
 =?us-ascii?Q?LCT4E5gb1FrZ6rfYd+Gu1sKu8RMAd9XAUpWuwJVH7VEzqMzYeBq9O5WgE0Ax?=
 =?us-ascii?Q?X4LXtS/cCGhRrEAzle4DkcQvWIy4+wPUO+HwYW4LgjLl222EFnu5NzJQ71ak?=
 =?us-ascii?Q?NBdWoqt5GTt+Zk8s4SrCMSDoFpMejAdXUgyEv+SnaBrurk2p/m7Pj1slGUYz?=
 =?us-ascii?Q?YH4/nt4CCrbDy5cG5a4gBA3MSl+YygR+mUdyJ+fysbqyh3v/FEh6eNuVeUxK?=
 =?us-ascii?Q?q2t5FWfJAXrPM2moYHUe9QPab4avjxooN966scNbEILVMIe4kT0vmkAS+6r9?=
 =?us-ascii?Q?fJLzQw70RMpG46erCRHwiDuxquG2yrpkqfGNAMk8RSOu9cUcdcGPmJB9MTXo?=
 =?us-ascii?Q?npES3m8uV+BEw2BKHnfxZtaawnlDg5BlbISxF1+Dj51DFXVuvDKmWKFgnoEc?=
 =?us-ascii?Q?WSjGNZD4lzfzbhswpCWIHJeTKJH1ZYEbeEJ4GCqEKf7TDhy/jpGJj6oX6VB2?=
 =?us-ascii?Q?qBfItPSaV2nK019AfDcYvo5yzjZNjWwg12EArB2nTHHTJ3FdDWA9btwrDpZJ?=
 =?us-ascii?Q?rmmA9bAFqBfcDePWB6LeARBGh8QTgw1z8zUVb6KfIlW0OT84njHpu5xhmxgV?=
 =?us-ascii?Q?Dk36+tGS04U2qqv91Qt+GhRaRwqF9cAyKR0g154mBoGv4U+DXPxeusrXj7GS?=
 =?us-ascii?Q?OaHGWUjIAprEvWXeOAlMYH+cXIpf3c1OyIFhA+zi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ca44c-d8ae-459b-99ca-08dd67a9f6c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:23:04.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zhMerbzuPR40ZrAuy2wD/rKlR6YM88h5/1Z08lQzR9DhjekJ/Tgkt2XBPXeP6hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_052310_989026_1E8EFC59 
X-CRM114-Status: GOOD (  13.44  )
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


> I didn't mean the exact flags value, but the ability to have
> per-folio flags. The exact bits and their meaning would of course
> need to be part of the ABI. Shmem uses the dirty and uptodate flags
> to track some state on the folios, and the flags can affect it's
> behavior (lazily zeroing out falloc-ed pages for example). I am
> assuming other FD types or drivers might also want to store
> per-folio information. Having KHO core provide this facility can
> avoid duplicating the logic in each subsystem.

For something simple like shmem I'd probably just suggest a side car bitmap
array or something?

The trouble with trying to feed flags through the xarray thing is that
the memory holding that pfn data across the kexec is not itself
preserved memory so it is all blown away once the allocator starts.

Any data that needs to be preserved further has to be copied into the
frozen struct page, which is pretty limiting in terms of what you
could preserve. A few bits could maybe work out but not alot of data.

> For FDBox, it is certainly possible. In the current patch version,
> deserialization happens on boot so it can't be done, but in later
> versions I want to give userspace control on when to deserialize. So
> whichever context triggers that gets charged. 

Yeah, I think allowing userspace to sequence the deserialize is
important.

Jason

