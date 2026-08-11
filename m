Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E7C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsAxR/wBCb92UrIdfygCWWHNE8eP3Fi9GSwHviDiZ2o=; b=eJfQkACvM54o/YKIvTQ5VTxsQx
	VB05Sq8QRubBsH8VZdZt4LUf/LGSvO9gVEMKzerAzayLrolMyzIt8iE8gwnF1eXPlXb4GE5+Q4Xe3
	1qCDoJM0PxLgow5I+57Oixl4+VJXNmpAgwAN3L81ywHv3U8FOp76lL/xOvbK/h+Al29YCOfcoNXx+
	SdcqPeCDSqk5CEa8P2+GE3YBkpvVwUfOq5/vhX6caMtDbpvk+eX0dwimL5o89IRBREemw3865de0X
	iIqco8YcNvxvJlGWfDFnR0/yqb2JcIhZm39/QdKdptoXCdYG47Pn5/Y9Da0QX8QETvMSUy2TbvA4j
	n7npavEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtsBM-0000000EqER-2Udu;
	Tue, 11 Aug 2026 19:30:40 +0000
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtsBK-0000000EqDW-0Gty;
	Tue, 11 Aug 2026 19:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwNcpRC0uw8lWfJWpF2+YEJn6+rl5kac/zWY2Abp+jK4yRJwQHM+05ELeLnIdxzl756a8WzADducLQ+qMxpmHivZxPNghOCtDypQIB3rIj0RofZCGNwE2CaZX85pwzAP03heiy6vKfB0lm4vQ8SaJPZdU4bUmwZ/4fuDewwFnejvh5HkxxwNhlKzf7B1K2udYL506645i4TPNP3E7zeO7yPeabBhAEPNTCDTG3xN2GiK/PsY+QHIBBj0iYrhmFIiCY8c7sT7mi3wa5Qc9NAAR2WL6r9/+HNeVfyAA7y+9mjhHRueF5MbKRAbsJ2ZXcIcCrbfs973EK99aikTk9EQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsAxR/wBCb92UrIdfygCWWHNE8eP3Fi9GSwHviDiZ2o=;
 b=LSWCznSDrpuwM1aQuJIQmBvrDPTMjo8ekC25zPdBIIHCODCx7T0VpVaknRvlR29pWG6rSiHr3pH6w9NbdoPuH/JBC8owkSQiCV8MVjTC9+usgjlbepLqLeEM957rQIb0SPNQFL5U59MBYgIKWfmyFah82Sc+DevjVDrwVAgUHznwL8Qm3px4lbOxXf40NNj2lrabW7cueoAjvtnrPgx50xK8kdSrAVWb/OGFlpn5Rqwr1/0bM4+beNiPTzAThc8JADBGoZ63draFBHr6dTW4sPs4ZEMfcTf2Q7Rxr3DEr6p8Uy3jyUoZ7cFHvj6ZA6V5t7l7hn1pZvTUYFXTP9rO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsAxR/wBCb92UrIdfygCWWHNE8eP3Fi9GSwHviDiZ2o=;
 b=pENBEZZjmQzI9PFooQDdHD466OTOYv9P4R+BcOkWbQBuscB0buSonYE8c9b6YCLm0Etm2DVbO+QCi6/4E3pY4fe3Pt4MIdZuXE8qKMiGERk5WUpQsYMID7ErH1VnAwviMpkN0puzO4ZKuVM/nO47b3qT0MoZx2LYybCInFiDa7vG1hjYq54FsixV3dX98QDj76i1Fx3A2WdlEtV7XIB9DR/I2NKuyGs+VKsq+kjZ3qUwewLuhi391+qTWviZwb9XTczKFuehyyo6Vj29YXqPq3iDDz7Guipq2ZiFIhIQJn/aSCSZ4UC72GZOCbprHgb4lZ183iyiHFySxLVk7B7UNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA5PR12MB999277.namprd12.prod.outlook.com (2603:10b6:208:608::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 19:30:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 19:30:32 +0000
Date: Tue, 11 Aug 2026 16:30:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, will@kernel.org,
	changyuanl@google.com, Alexander Graf <graf@amazon.com>,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org
Subject: Re: QNS: ARM64: Cache coherency while doing Kexec for KHO
Message-ID: <20260811193031.GA638489@nvidia.com>
References: <9huzldaczcr4.fsf@tarunix.c.googlers.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9huzldaczcr4.fsf@tarunix.c.googlers.com>
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA5PR12MB999277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2136d4b9-056f-4ac2-fdfd-08def7df0243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LDoedUxvYqBp+xQIGZw2kDgkufPZAWTEbeHvS8LMLkPBhHx/n699/Dy5myvx9KKn64h6/lMWw37R8YUEH/vAeB8fBu/A0LJdWy6+2L1VYqRaPNUUSvMMMu9vyClA5IChZcbAc3yXFyvRifu9wHSFmgOvQGVB7XuUiJSC6qPWIIebgR8NdKXEpum3N/eM1tYzL09D9h/RoPX5t4JdKEXxHLLFmvZVSle3JQArAg3mNJD1Jp8iV3SGQzpbHxe15At7cvQr9psZCXTq4IWyCHLtLA55bCxd4f+kNDtiDsgRFHDkhntvx30IWN3cEIsZNPhuvvwniOQUY8kXuSwzAZOOkyIM2a+9uN3mxlFKE6N0hWobsM4w+eB1yxA2O6j4KrkLkcD/d0f3L0i1Nat8XJrv8XNG17fyXEXrXr42Hd6LobjjQzVJGIdkEolNydm5gXfiiMJ+1GsCGwYI1X5AYOJxjZbOjg/CkUEH6JbE2KWTekVvZXxYOXnSbgKXXEx1WyRwaeX6QBc8SUNO4+wXEqPi0vO5v5a0VR0o424zZB5bqF7lY1wZde/7e6sZDqHBVHG6M8k/zqY5gt3xiyWdnWvIIRMN2u9DfOQ7TslpibSi9OdWo31MhvjAlH8jAgIeSZq4rrFLsrDinYvUIj84olh4Svtf3x4TqjtIfNtcXgwjd0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6qhV7HOhUm3rz3vjkg0JXw42Airx7nAiOf/0aVu8bvVLJV2G4aarrKtapvT?=
 =?us-ascii?Q?I9n+6pp11JsuOwaqwGDggjZdWEb8ZjLCVD3XF5d2mDG+srpxkGnrW/qzCuZM?=
 =?us-ascii?Q?QfqaVP7V5zPeUwUPfaFirp+zsQsKaASwsG50VPXFOrWSppVdcx+DHjgv6xxF?=
 =?us-ascii?Q?tWobfB65jTDGxh19qN/RM/OSL8/Nbvmh4ZLOkwPAn/LIjhImhuAWKjrMFZiO?=
 =?us-ascii?Q?nj0Oys5V8YyaNnHIJr5rS1CNhgoiUD/3XJ4S/Mc96RQSzmyBb4DyVJLpLgF4?=
 =?us-ascii?Q?8Uua0ka3HWZeG0yKl3chhQPGu/ygYO42e/aHGfCUTmMFWCoyg2mNx1NExcrI?=
 =?us-ascii?Q?EsR1oz0FVU3cmUt3QgBVb6zdq5v3i3yszBFs9YUKa1v0EXOnyco0zUVlacTY?=
 =?us-ascii?Q?wkAsIJXgWFBQ5DzYzm1zbymEVQ00pkrWFlRuyNWAKda2IRLfjlmC8S3F05fJ?=
 =?us-ascii?Q?UzheJjVXbgsHKeGzim43Wq2AC57f/9HzuyzaCvMdpy6QUy32+M2QlzTa1L4z?=
 =?us-ascii?Q?f7S6YRcLcsSG4xHZCry47UxTtsi2t4pJqFS+3X0+XKobp80EiBXqymjd+hqi?=
 =?us-ascii?Q?glhDgxT7lF2HJFT8/qrJ7INWD+5F+S25Nfk1YcrDZe2R81Ie2+PLORPRAuC5?=
 =?us-ascii?Q?axf8yV5/VsJYaj4K21R8BPPlRNMn/K8LuI3SPrW1B9t95ims4KJu4CVodxWv?=
 =?us-ascii?Q?pwil4XZy3e/jKUoS7b7xDjnMRMXVAAYFoXMZAkniRAlaDWimnUk8TintR4Yl?=
 =?us-ascii?Q?ukOqNCobLdVupCLA2gPCK5RuKT/dCJeToGGrKUmT90VnY45sdH0qAD1IGXfg?=
 =?us-ascii?Q?YPfIb/PW9Qclw74ayAz27Ld4iO9enEttyMEZnzLrG5LUfLl1Vcdi6mTmlimj?=
 =?us-ascii?Q?zUAgenR17FRwEF6WqL2soB8qzCgKVAAJXmmLmniDV80LnGfXhyRVPYO6ON+q?=
 =?us-ascii?Q?cAVxHT227gE+lSe0HjLiBROoZiS1OLZhb72iJqekc9foCQEkMzp3RxfylgFe?=
 =?us-ascii?Q?v7cUm/FJfmw+J2C3fOr1Bsl9gQH6G++L5N4JygiXDfKF/H7pwWbc4ZjlFXYt?=
 =?us-ascii?Q?pZx587/FtYE2gq2fKK9ImkBkfAFWiLj/DiDZ0GQdoGWepdhgcApywums45Bw?=
 =?us-ascii?Q?aPnCQxsKLCCWB6EZ2moR7YFZ782XNAISgVOFTAYXGCfTlNeueruSeibAoS3A?=
 =?us-ascii?Q?lZ3LA1RhKzrgTp3YDXJrr50V59dSAVywWEwSQ0zoLI5EDN0AOXSs+RHpJ1x7?=
 =?us-ascii?Q?XxFVDM4MpAqQMNvGjv1SHZ7nxtzHMP+uGFA8Mt0J2Q5tGG26/4a0K9iUdSxp?=
 =?us-ascii?Q?FAAVkJpRbXRJXmKSt6SOXjBrDFqGR+H+ESD0osBL0nLg9pvBl4U7suGhfO8e?=
 =?us-ascii?Q?ZGRTiVU/X8WNgAFwKw2t+5vUomFAQx0Rw7VbNIEhFJX926m4FWeXnvqEGbAt?=
 =?us-ascii?Q?Jf5ySYXE26Tj+/4BAivnHYSNy0x9EjDlZ38pa+9pDRD2PTDiiB7NPwHHqHkT?=
 =?us-ascii?Q?pxjsOF9JyMCailo+E8NMiHmnPHrzhYclGj4A3R0zpBAabThiOh57Xv/9S/7I?=
 =?us-ascii?Q?GBlCF9IgR6gVNwy95rSXZnMcsTVVOfkwd4RQGIknW6j8aqEiMv/6Kneylosh?=
 =?us-ascii?Q?SFy+ZP4UhGwmZP5+4fkcTIeeChTNpc6PBrj4CK7iui431D3HcXldDVDfdx83?=
 =?us-ascii?Q?6awPRASySLHu/kCSIJ8de5uChCmYnYaTVX8vT7OpKwNjgqh3PYQ3ugDIMFqZ?=
 =?us-ascii?Q?9gx74ttqSA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2136d4b9-056f-4ac2-fdfd-08def7df0243
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:30:32.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BCSrmo6O9G0Si9ax2f+64vuJFm18BCP9KeXlCo8LlO8ESf8ylg1bAazmevDQLXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999277
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_123038_109316_7241B922 
X-CRM114-Status: GOOD (  16.94  )
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

On Tue, Aug 11, 2026 at 07:19:11PM +0000, tarunsahu@google.com wrote:
> 
> Hi,
> 
> I have a question regarding cache maintenance for Kernel Handover (KHO)
> preserved memory across kexec reboots on arm64.
> 
> During kexec, all other CPUs gets hot-unplugged where they flush all
> of their caches so there will be no issues with any KHO data preserved
> having caches on these CPUs.
> 
> But CPU0 still has not been flushed its D-cache (Is this correct?) and
> it will only do flushing for specific area by kexec_segment_flush().
> 
> So for KHO preserved memory, if its caches still marked dirty on CPU0
> they will not be flushed?
> 
> Is my understanding correct? or AM I missing something?
> Also if this true, This will be a problem?
> 
> PS: Pardon my less knowledge on ARM64 cache coherency.

Yes, I think what you outline is correct, but I don't think it is a
problem.

As long as the CPU cache implementation is physically tagged and
everything kexec runs during boot with paging and caching disabled is
flushed it should be fine.

Once the new kernel comes up and installs a page table with cachable
attributes everything will still be consistent from the CPU's
perspective.

Anything in the new kernel that needs forced coherence, like DMA, will
be doing flushes anyhow.

Jason

