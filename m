Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C46C369A8
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcxb1TyYLuc3X7y+lEKBuJZsHzYdnESch1ylf3Y7h3s=; b=cWoOk+0rcNdKvw1xAK6oKacqcz
	JS2YnautnIJAi/neUF2SZ4ibV5HRD6agAnpBag+xs4r4pagu1ztJJjiC9ce0OGMRK3bz+tbvlva/t
	bgwE08wz4OSswBJTKABVmNfqUzjPOqLYR22HIB/c7B97zoglIOZVO4tYPE2ThzKcTx9g9Jhy76YQD
	9+++kQkLl2oP4avkaHsRQ4Zpij0Jpd5WSxE2n0R6t5L3nPVciQNxiWHdkGWQdbfHB5YiM2MaDpgnq
	rtiYVRPjz4N3xM1PnZV97VwgJ6Dkwu1+WvKAHzKVwRsEC7WUkVrIV9I5L4iJtpVSwzd27tm4jhsfq
	ZyM9E1Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl7-0000000BlGX-1UEN;
	Fri, 04 Apr 2025 13:06:57 +0000
Received: from mail-mw2nam12on20621.outbound.protection.outlook.com ([2a01:111:f403:200a::621] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LUs-000000093lB-0gMU;
	Thu, 03 Apr 2025 14:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCGLtNbTuE+7kZxezcvm3MlL6bv0kWJjJU2DPL1gCHTeNM+V5PcxwZiuvr+MHq8Os0kZY0fZqIGLLdPinCt1sHcilK/YEuC3ZfvXGiM8bwCiMNm1XdG1ik9dzbpJWc3g4SLEqsH04YP0NGKXm6g98eWUuxM2r5PE2lsVzydgaT5Jf1P8pCrN9BlfNSPSKM2C+veskwkPklvgSQhf32XM7v+TTTuwRi+BWMwBjXnRXDfTQhW2g6uXduEvyc270Yn6kfGt0wVOfs9iQsjiAMWLumX3kM2BJARWkf4L4duWsLfYbxbj3xl7DibtazkmSYZ7N4KsGvHnMQeGE5AHCSVeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcxb1TyYLuc3X7y+lEKBuJZsHzYdnESch1ylf3Y7h3s=;
 b=qwbebHLhAl7UAqLuZDj6wLF1ncHXH+3XfCm8nWtix4ApRauGxYIB6Afz2t9yaIe8A7Tle3pjQLlafRPsfEvqghsoKQuTAFAucYIsGxtk3L27y7RP6FOvC1gEUSb3+cb7t6XxQZnW9i0PL6dzZLi/6BoGzeDPlyzgWD2fdHtOSFkVLyNrd7RbeXC40AmUf5aCoSCzCCxGnyJGB2MTQbKR8mBdOIpwLh2osxCXUad07wUjVGoL4CFCFaE8nqpk7W/VhqTxbUa6wkYS5oDG3SUVM+Ru1vAuxbvfruOV6F6zrC00XluoT8EXZu/MUl3bznxQIXHdxSYjmVeAK1RD/QWP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcxb1TyYLuc3X7y+lEKBuJZsHzYdnESch1ylf3Y7h3s=;
 b=fs+Rgh/EoICVT9KB/nBIgLZkFc1tQohGlDKZfVOrvViClEHMkuHYmU1wM+dHi54yCB/KS1vghBfkhlZc2K9hzet7ExhJ55D1YqOHWHxPocM3OSFOtrLT07VkeFrp9dB85DtCncuo0DcmRaXNuHp2l0tvSkzfsMdj6PPk7ai8PKQGBPsttjoAVqVGvKZ69BC0ygZUQ8zJubAZOyu68XWcFW4pXD61R4Nz7WUgpzx5zlU8yyOM1ypHXILfF4xh3aAVndI6l7APRguA2ALqXtoLmoAzC2/ibPg31s9jB08bOdS+ij12rtT2LT0CO/YoD0FdeLJQIWbudvMhE547j/Axkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 14:24:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 14:24:39 +0000
Date: Thu, 3 Apr 2025 11:24:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <20250403142438.GF342109@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6UA3C1TPeH_kGL@kernel.org>
X-ClientProxiedBy: BN9PR03CA0580.namprd03.prod.outlook.com
 (2603:10b6:408:10d::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d234a8-7268-4f0f-4f47-08dd72bb44e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gr2t65HNO6lx6QfixVXZJk2k2iXpd0nKd1ivbIrsTpDejgG43EhTdjL88Idp?=
 =?us-ascii?Q?jBP+m/VRAUOTlHFAiDaLRkeAR2HB9vGox1swNM5n20zGDmuESynTW71ZN11J?=
 =?us-ascii?Q?Gw4Wxh06bg8FYnAQvNAgQo1+nUTwhfzWNc6RpCoFXy/nER4NbPey8K6lNjyD?=
 =?us-ascii?Q?HwQDEzT7BNs9iMjHRarg5JLZOb7c7j5xKi6OHK6Li2BAjR6lbLjHRJyDTOIE?=
 =?us-ascii?Q?LXZlKc7DslwooxGyaU8QupPoidFLGfZbqUkVnH5E4utAhOMIxK1hjKYg7lAe?=
 =?us-ascii?Q?25SePoQFKbP/IW4+fTZFuSaWbldh+E95y1AR0Nl51ZiDvGSZqBFsaIyR6HPT?=
 =?us-ascii?Q?7QB6Bxx4FdQYedS33YIIEv7hkMT4khhAKi+WNuTrhPXivms7pcpTs4otFiKI?=
 =?us-ascii?Q?dr45GiRqUw/j8zAZ2hEXLHEVPdFXwJKfPSPi2IUHeSsS4/5etRu1PkZdp8L0?=
 =?us-ascii?Q?urTZ+1eB9j4pyvpETa72uHddHbzcDEzft2XY010cvJx+MmBUY/5QhqNO8VB2?=
 =?us-ascii?Q?aGsq5hYL517hZh09w3Dt/gQ6xmIFihuixFRoBj7tv8p1OWyNpT69S7/pr9/C?=
 =?us-ascii?Q?Ld2iYfL/w1M804UUz0rUYZEgUO/z1Y9DvsMAqOviVNhcoV+z/MVhMuESGfzy?=
 =?us-ascii?Q?JQZD7j51YVtMkzxIFdC2VNKrZGhG+1QH6nlHzbcmOqgqdw4zCHFmEpa7bpt/?=
 =?us-ascii?Q?Bf+r92Kn8KE7WRD6YSrWGX9SshzT+cvIYaaW2X7pmiVRM1k0NMDNo0oOsz6A?=
 =?us-ascii?Q?X2VaM9s66EPSiMHiEonFiAQiiIJvk9wX2nvBhYJ49Iyc59I1Zptva6zycZ2x?=
 =?us-ascii?Q?iHYiA7giDYrx+vPRwrd7vB8/to/F8xkqeKfAfdUd+9C/jJv+6WB+A0KS1scv?=
 =?us-ascii?Q?kqARlUwL2r3IiCtuOenezpwvieH7pYMIKo2InchS0wuqQyFVICnsh49HLp22?=
 =?us-ascii?Q?I5OmbNSeIr9LXvFdfrOiERE/XX9ziawNKi2dO4t8YuiH54sV2YNES/5Xxw/S?=
 =?us-ascii?Q?tE3jUJoONWa7iTzuZhS85hT28UqDBBEkd3U3g6uIl33777vqde6bLU6/exyl?=
 =?us-ascii?Q?tmNYc5RaA4rqlcs9oSKPtGnvWLUn+twtfWQN2PV5wu+iYE/JMtya4x4vsLpC?=
 =?us-ascii?Q?Yve+yYV9RIgG/vEMvCuhEGNUVy0Q47oTKL7SpufhZVsbSaGlG8NgznWV86JU?=
 =?us-ascii?Q?tXNS1W5v+MKOB5lIcLVCDVx5qorEdHYRPnmf+TIqd7VBGs8Or0QVcycqA0qK?=
 =?us-ascii?Q?lbiS+vNKqcZGFspd7cUP7Na/vKAj013jdhI5IdEO1crlnh5NmKIUl7VEJFvB?=
 =?us-ascii?Q?5jg1k72zwrTS6pyRWlzDinxpXax+PxF8LLLaB1xiehq5QLK5ldIOPTCE7cjU?=
 =?us-ascii?Q?NDg8ByWz0YAVexD1aizZd61VHtGu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afP0D4sM78HxXM2rjcp1Vsd+RsRKWOt/qhDkogyiRM10Fc/98uRUYuxT90/d?=
 =?us-ascii?Q?UA32dGGlpGckATSJypHjXa1DhyO8vUMIYKYZys6U1jyqx0N8Jkii4Opibhfa?=
 =?us-ascii?Q?kHPB31zG7gZyChY5hvdWCzIV5YCftBaW8v8PHPMQq0K17+MBLxH+OjKtOELG?=
 =?us-ascii?Q?6vkPBus5OFegcrBQ+Jmqppr4ScvJI5+enM0VR9Ydu1W8gjS64fleIOkoTUzR?=
 =?us-ascii?Q?4FpAxOGD93DAx8c1YDKBAjDIpVKMZasPyW16CzMaz+RI/UUPCqbWLL0Dw9u4?=
 =?us-ascii?Q?uJtsmXo2o1pJ9VvFdoIgWuPKaMJMbyq4LVEGnnoE8QdG3qJgaePlZpeIRvcv?=
 =?us-ascii?Q?8CTR94pPuc3CgKLR51i83hkhF708jzBLNjeAikzwRj8AGWkHC5YkXWTKFiCe?=
 =?us-ascii?Q?0wB0SeA9qRJ9J5lKvo54tQC6+e8sfe+a91OBKN0yU/7s22KFz1ToBdxJ/USE?=
 =?us-ascii?Q?ueAyX4rtooRHfee/flmz/CLOg7thUfnq1IODbchdmW1Hfkp5I/Blj4Th69aw?=
 =?us-ascii?Q?U765jww3AZSMru37VV0XYLHzXeDRDqYYI3PgZu3Hh90eAhCpJbpWszPRMUx7?=
 =?us-ascii?Q?Ud+v349xgBpAfUbqs01fPOdBd6euBFr5Xv2hAOYoglhVxETAWnngJmxgz2yo?=
 =?us-ascii?Q?XChlHytCG8IYjNlonPn8myu7MeE9fW1PjmbZ/h2RgtouzrURPn3jKpwjKpL7?=
 =?us-ascii?Q?K+n2UI11dar/XRHzeFsdtfj3J/og3eG+GLvCc/8gz8v2MaTuiOslUX1PGU/L?=
 =?us-ascii?Q?L8hBSwK2WGkB1MqJW27V5N71tbu43sd6s4tfXbFJ0SAm5nHqCKTTqcPvsDj8?=
 =?us-ascii?Q?xmHz6IqfynszvjBMsDimqB+3PRlAiCzxsQ9/jYhWme3Eo3PNRGIG0G4zRPPH?=
 =?us-ascii?Q?moo8765RST6tgw3LevKEO3/fkz7v6wS3Qaq5XFLeEnyJalyohVdxnAnBvjq2?=
 =?us-ascii?Q?xcnUXxC8x5ZgUITKoxu6vjk4FkZ0qVsI5sv3bi313IdPc+rTK+k0MfwTY1cX?=
 =?us-ascii?Q?VKAhqK8FoGA0uL/bZrQXlx8mO7lmJ9PPWKqpsjoM1J9jl+T8U2QlkKpSsxqM?=
 =?us-ascii?Q?vaddSmSqDM4udIgfHOL7yy+2lgmNMQJrPWj5x8IU0Pg4q/cgtiLb5O4zdUsf?=
 =?us-ascii?Q?S4XgVZIy4XU9pTfueXif8sIkM1Is2N8WaHPeLm28FutmiBLmTcmqV1V9EOK3?=
 =?us-ascii?Q?EGamv6PmOSWBISd1a/JPVY0WlNSj2UsKqp02I9e/Pv32XQGnymeVPVsE75ZR?=
 =?us-ascii?Q?kZiOrJHh1wxdcWciHXSKWOyhelmR3xx636c2riw7a10gfWCyAZsnWREc3qHQ?=
 =?us-ascii?Q?zWKFY8puLVcAV+vQtwNbfJc8vKeLR2EynGygj0+1NIgBO2yYs6Rzk/0gdJSI?=
 =?us-ascii?Q?HSOSnuUTzhyB371yLtHvhvmIG5V3KyQ30q6CbGrtxppiHF9SxOyrTAQPp5Qt?=
 =?us-ascii?Q?MjH6H7uX6GQbcdqgj2cR7DgRHs6RjzIfhtelJz2pa3otT3IhPOoltMcx1NYN?=
 =?us-ascii?Q?4AFwdYnEmhREjgHsYRl/BchupOQl3cR5B9cH4NzJxTxo1zpxgmNWIcItUIa0?=
 =?us-ascii?Q?fvDRqQmN+aq/HHcKu7ljZAYMUq5U+/CcLaKXSig4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d234a8-7268-4f0f-4f47-08dd72bb44e1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 14:24:39.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOwlAhfFenug3nBqT6UtprNPUH6GitiLcWh4mAGunjp5UXjEcb7JI+VIZ9R/v70x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_072446_238202_FE5FADB7 
X-CRM114-Status: GOOD (  17.25  )
X-Mailman-Approved-At: Fri, 04 Apr 2025 06:06:48 -0700
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

On Thu, Apr 03, 2025 at 04:58:27PM +0300, Mike Rapoport wrote:
> On Thu, Apr 03, 2025 at 08:42:09AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 02, 2025 at 07:16:27PM +0000, Pratyush Yadav wrote:
> > > > +int kho_preserve_phys(phys_addr_t phys, size_t size)
> > > > +{
> > > > +	unsigned long pfn = PHYS_PFN(phys), end_pfn = PHYS_PFN(phys + size);
> > > > +	unsigned int order = ilog2(end_pfn - pfn);
> > > 
> > > This caught my eye when playing around with the code. It does not put
> > > any limit on the order, so it can exceed NR_PAGE_ORDERS. Also, when
> > > initializing the page after KHO, we pass the order directly to
> > > prep_compound_page() without sanity checking it. The next kernel might
> > > not support all the orders the current one supports. Perhaps something
> > > to fix?
> > 
> > IMHO we should delete the phys functions until we get a user of them
> 
> The only user of memory tracker in this series uses kho_preserve_phys()

But it really shouldn't. The reserved memory is a completely different
mechanism than buddy allocator preservation. It doesn't even call
kho_restore_phys() those pages, it just feeds the ranges directly to:

+       reserved_mem_add(*p_start, size, name);

The bitmaps should be understood as preserving memory from the buddy
allocator only.

IMHO it should not call kho_preserve_phys() at all.

Jason

