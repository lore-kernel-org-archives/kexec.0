Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E789C369B8
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SovsdLYmNZQQn+AX1T/HhC2wN3hrETuP/Ro+w2IBk7I=; b=ogY1Y0ZE9JNk6fwJpFmiQV3V/3
	DncRaIO5U5HiYaE4d1uS5Wtr/9l4lfioGRi6vA0e6HPK5z8iKwNVAmSGXd/B/Xxbpm1OmRr8FWuex
	Fx5LYIoOaVhLLEgN+rPHJoL5Yg97yNvcn23viOgVMT8tI3l8pPibXii1TRJZ/usJrE7TjFHvUQpJW
	A2B1mpWgfTJUyOKD7Dgfqzwi7ZaUDB30AcGuPIF0KS4sLbsWv872PN/m+C+ak/+YfXtNu0yeMACJm
	JAwTNFv/em2wuk2SSwZLyzFcCxlfoECzfw1MMpABvHSLopflWwSjIh7SQN9ILkuy0yJ0CC/vWF/2j
	Y8Sgn+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJR-000000017UL-3AU7;
	Mon, 14 Apr 2025 08:37:05 +0000
Received: from mail-mw2nam10on20625.outbound.protection.outlook.com ([2a01:111:f403:2412::625] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1psN-00000001JXT-3ebs;
	Mon, 07 Apr 2025 17:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDkzL5Ox3lesSeWuaeMMiDAuv9sxEfB0AOPn/77l8zAcse2aZKZxsyozHOaz3XZChKUMqqNPfv24KpeEBei+9zfVwE/k0CDG6rU1+UN1u+LXXQJhLCgzfzISTM2J5ZDtsaT9T10FWESnDInKZ+kBGOEZGh+TYq+bATpciYdddzrLUy3e/TVrVcvcDz1fN98zb1+jT715scrfVdh6W0czso3+QpBjXxMG+zsWbqvrHsQ+/KyoW3C8xObKnWKeOS/XmWlL9LWRY/ODBepiXCAJ+3t69FMdA+JyQd++jN14sbtvdmGJNndnh1iUkDEzc/7kNDzScqwgPsucBd0LVPHMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SovsdLYmNZQQn+AX1T/HhC2wN3hrETuP/Ro+w2IBk7I=;
 b=xrexrhJSKWJOX7nTpimcPGcJCNOnrxOLdQyXeH0oe4/gX/UDSpCPPKLTK27Wn9H4XC7rYKcVl5b1fBQTnrwDkva+8WAK1eB7R8/RM97OwyzZ3LMCPWPA7vr56CVTjZDmwGDmSvx2Bg4Vp4V+yphLJIyhrcCW7gePMgOZ/Gya0o/ookanWYvISeK9cYe5kZjaKWI8rARCJBWnDVPklntjihEnCnA0Fj3lbwDTUbtTp3f5DKex3pZOEGgia20aRRPQCyfmcSSKZbl5HqXRwQzp+34xFztqnk43i+dnQclTWhkiONE5zLFZD8RDI/OoGpzxZ8i7U+2caonAKVbUUWqjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SovsdLYmNZQQn+AX1T/HhC2wN3hrETuP/Ro+w2IBk7I=;
 b=lw7LHgj5p3v3wvv7bSe8FIKvCWe5miFmqWR7tgHAKLl222cwZ5DW60PcfzV5Afzn/1WfnA8CfoeNZjXRkr8EnqAXsLmyGuALKFGoYN1ep3JBc4BDrUH+q/qHeFkgsMnlf+zwPtvYO7TpRVW2IC8jJ9NS9gF37+wF+tVj/wHDuEvbv1npqiSgGyzkRrJHpcZ7/ZCVndc/Aw60IJjIOmNEniOq0WUSxNIRrLU4ylFWqlIHXB8NOHbTA7yUxRjfMcqMh5L/lGJz/hU3TlUuV4ReKOd7ypFg46p53yO/fjzIEke4+u3HibpQT4pOWLfy9g9MPyjdtXLlFl/QTCPtu8a8UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 17:03:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:03:07 +0000
Date: Mon, 7 Apr 2025 14:03:05 -0300
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
Message-ID: <20250407170305.GI1557073@nvidia.com>
References: <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
 <Z_P92UCbNCV0TbiA@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_P92UCbNCV0TbiA@kernel.org>
X-ClientProxiedBy: BN0PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:408:e8::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b02822b-8318-468d-e29f-08dd75f61121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whhFyC1Kh9AfeKBxvHNKheZNYYfhzmf97TaOsTmA3YtHFQUqMR2OLXRiaDkz?=
 =?us-ascii?Q?atUYcx07ibQAzZZ7GpG3EG5qHWJogMwiekROMmWMFHersOeZXIyXMv+0qcTs?=
 =?us-ascii?Q?wwv4EQjD9Js6Y/1oW6rhhCaQXfV4FXCV629dpSYvgfPeebgbaHFrKZNaA6Ze?=
 =?us-ascii?Q?cRMjTRptSTEbQE9rOpiNU0CXsyxMcxwbm3PsNeWJHwYqVXzakBuTGK70bljl?=
 =?us-ascii?Q?umf689emk2tkWg8rb9LRKyItsRZ84DNvJCaYgLph9ooyOrEfxK2SMbIqz+Vl?=
 =?us-ascii?Q?FsaqT+DJhiQ00gvR48VZmwJEHfo4DqdE627kAG5ZIH4MPEUUJgDSPqbOfQVV?=
 =?us-ascii?Q?ZlUCCGD301P/BLC0M3H1EA0eSHaCqIQblf0icj6yCx2LS/3dx15Z1M+HHtAR?=
 =?us-ascii?Q?AQRv2YMPnYXsFWOwyyQApSrg5WMMaLoRfbLVwIdi9fe2chYK6fzj2/pJt3Ak?=
 =?us-ascii?Q?ZfWQTsYLlBU8KhQ/GOQpFwPqHSwd22Ggv8idzqotVivhMdXcjk0DnRf8JhWf?=
 =?us-ascii?Q?KMyoGRy0POiO4WWFxdjFQm4ICfAiAxQq3Arbjp/L32zMDKiKTDsNQbKCiXQX?=
 =?us-ascii?Q?N0KZKg1TxbVzt2APwEMf+93fFCzwegDLJ7Yk7ozTAsUfndMUjTdjMqbJXuDL?=
 =?us-ascii?Q?Sfe+J1KrNPd6/5JVuPrmh51oJjNWZ09B/6JBV9mFGRvulM1v5l5019MSXdim?=
 =?us-ascii?Q?BzIe8gH66jPPyKeYqnKX3bYwZ9Bn0bjVhVEl86/CarBGtSRFzx+JSbzkJ1jg?=
 =?us-ascii?Q?INkal8xDr1jd9kG071sEYWze1A4tCg4kBzcSGuLbsW1hJYr7s6O91jqzTeZd?=
 =?us-ascii?Q?kWkHbfXgf+Ow4hTHU0QoCTtQ/IBSkgWQcAEXueqWZYk4hHsbzDIin2gq8CVd?=
 =?us-ascii?Q?+iLMF7Jdqw9cl5o6ZCQ6GtGqblqAHoDY2T4dhjqu/ldajLiz1c+BcF1f96eE?=
 =?us-ascii?Q?TY71Joz+WoWDi0JmmtuaZiOA0aSz8DW78C6a7dtllRrQEgifIbW/7pjgfyxw?=
 =?us-ascii?Q?zYztpufgSNUKYNcXxwKdN93oT5ZcifXcZ5IagzzfjmtlO7O5IVUjEJDHPOV0?=
 =?us-ascii?Q?q0xqr1rp1liHNO7mXuXOooGBBhLLmHcdy44B8sMFGd9FaQx1CzuVx5UxBJD2?=
 =?us-ascii?Q?Jen8pCLQdwDrOC9du0jRmDd/UiQB3kMw678+DjJnmVXOcN0Xlxjsm6REkqOW?=
 =?us-ascii?Q?am+JV/PDU2IrEonM/IOgHfLlCCtyc/RVrEyZaZu3GlzCWhuT6weR7/1Ts+O5?=
 =?us-ascii?Q?oOpWTRO2XcqZ2gpWcab+2KKT0wOWErbZnRL8WTcS+ykXG3fWeA+Y06cebmFf?=
 =?us-ascii?Q?4oB81Gq0p7dSwEj9DneYc/LBYXTo7+H/Alj5JfN3rKWe7dvq+uOezTkQ8a8c?=
 =?us-ascii?Q?GhuFWM9sl0xXQ5+TgnGp83ja0qPs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FR9qraM0JkXFFVzYxhzg+bK0+QVx2qBmpYs4vn/r3wu2DuR3aSIx2VyRMSzY?=
 =?us-ascii?Q?THDIk96GpvDYBIcOKOFhPVZwb837o3U9mMVC8YO83yBxJD1NwIjzvbbzFQsL?=
 =?us-ascii?Q?x0qQGl7jXfbWY+P+PQLHxubiYzBpxslcj+vhn1DVOZMV9jLeMEzRxAE1uLK7?=
 =?us-ascii?Q?6tn6ttHeQz57/Stwcx4PCGIlt8LEvb7MkbxgJpFu7zhWHD2meVtQTEyrOOhS?=
 =?us-ascii?Q?kNLXhi5KpA8n2mte/FKGOfuoKhGGrpm8czLmSsh9yBUB6jwKTh8rnCVPRuKH?=
 =?us-ascii?Q?QO0o9ddFt3+q6H5KnjqYjFzc6Jj98zPhI3VMKVJFmRF9DMp/kdc+FSdqyOqv?=
 =?us-ascii?Q?D5f/AxDOLV/K12X5+1aE/Lb0LNRIAvCbnPpxgOGPcpJhq7MQ3z270InEf7fy?=
 =?us-ascii?Q?VR3Z38LNWUyIjcbWOOSZ6SU6fiT8dL8gmyqA3muXz+F6CywYt5+XasLcaqsh?=
 =?us-ascii?Q?sU7S4CXj8I3zRWf4F40eWlcMPBjWb/oy5efITkZOUyFdtKHyKWhtG1tlo2xh?=
 =?us-ascii?Q?DK5Ow5Ul/D4bqAgT/JvaUj4PkVEO6rMyxWkdQCmwUF2RDJRTOg+VaFknj6Sb?=
 =?us-ascii?Q?56OPVB2CeEKeWycOx4u8CtGSnH+zVpTHmiOe1zaBdvW6lSL+QBHDY+QVQJDw?=
 =?us-ascii?Q?CZOHQLZH3YCIRMZ+1QPIu8Li7GA9se3OGl1V07RJaxqe0OBR63LcVYVUCnU+?=
 =?us-ascii?Q?DUJRyzyDq1NMO3FIbgTFqmdWtjI3dDUsHP4A5kvndHPKjfemK4c4K7ejCzcq?=
 =?us-ascii?Q?aAGaeReZYTSSfAr6b9RYDF3MPBsvAoCkuKo34oDd6pOiNk7YjBuQZQK3aLUb?=
 =?us-ascii?Q?c6578oXlwO2Vg35fhfzG7DRBHRt8DbXWmVDpICbFoEOTe/Ylksb2HC6YEEBL?=
 =?us-ascii?Q?Jap2UkqkZZ/wDJZ1ssdJjFFnDsJY+donCenb3JIq/dhko1jsUTlMAZ9TMj6u?=
 =?us-ascii?Q?K5aPBx3CpYWI2jLtfabPQkSlqk3gjfwzqdsFaJIXJ45LhWtxUfX+NIYdf2CY?=
 =?us-ascii?Q?Ht9Dp5pcp+7WBWoFb+1AGGwKhTq8BKUSRxgL6WpxCsit0PnNDyWjnBcrFWu9?=
 =?us-ascii?Q?KVdgqzs9uOP/opvvsRTDGTmVOJw04Fsk+pBkVRF4pA9Om3PbqXjpsIdoFXq1?=
 =?us-ascii?Q?sRCwe0rN5T7S9uf1dO9gj96Mpyb6GpXOzKSDT7kvTuDSHXsrN2M5LAWcM8nL?=
 =?us-ascii?Q?Dkx/egFWMGiZ7kHAzyHzlYT15PfOVrnEZfxPNgSGBoooVvIyosO38tH9GAiJ?=
 =?us-ascii?Q?iGW9MxiUFfSaIbiPbC7Ppo9q3O4I2Gnq7WfsokZY6Y0TtGBVhPXeBQnfdB0C?=
 =?us-ascii?Q?QKWTERSLxsURGPeZSp/hG9k4znI3CVkvJzk224oE8fJUL0iZbdZldgixsSPe?=
 =?us-ascii?Q?N+QO5NbLHcyMdGiM4FW1r1DjJGfKwHsFx2p21OoRoGuRMfUS/Hooow1wgh4V?=
 =?us-ascii?Q?hOxqQz67d/uNF0TiylcCFG6/3C8v7lc67e0fx2u9M9djPg2vIBfvx//o8PKX?=
 =?us-ascii?Q?RG2aP/tQmnGYzrjwdQanW/bkEIrvCXxJBPk4R6i0l/t1Tub8KlIDa+9/sQek?=
 =?us-ascii?Q?/FacV9FXrM7uIg0fjZqibFdyc0y7w+r8a6nqonbG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b02822b-8318-468d-e29f-08dd75f61121
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:03:06.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpkovNkFzudeaRlgpzQ8QcNuoIJfVwZgi62wr+FGE0YJclk63yL80dZ3slGaK6ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_100311_917986_7E24D13F 
X-CRM114-Status: GOOD (  21.43  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Mon, Apr 07, 2025 at 07:31:21PM +0300, Mike Rapoport wrote:
> > alloc_pages is a 0 order "folio". vmalloc is an array of 0 order
> > folios (?)
> 
> According to current Matthew's plan [1] vmalloc is misc memory :)

Someday! :)

> Ok, let's stick with memdesc then. Put aside the name it looks like we do
> agree that KHO needs to provide a way to preserve memory allocated from
> buddy along with some of the metadata describing that memory, like order
> for multi-order allocations.

+1

> The issue I see with bitmaps is that there's nothing except the order that
> we can save. And if sometime later we'd have to recreate memdesc for that
> memory, that would mean allocating a correct data structure, i.e. struct
> folio, struct slab, struct vmalloc maybe.

Yes. The caller would have to take care of this using a caller
specific serialization of any memdesc data. Like slab would have to
presumably record the object size and the object allocation bitmap.

> I'm not sure we are going to preserve slabs at least at the foreseeable
> future, but vmalloc seems like something that we'd have to address.

And I suspect vmalloc doesn't need to preserve any memdesc information?
It can all be recreated

> > Also the bitmap scanning to optimize the memblock reserve isn't
> > implemented for xarray.. I don't think this is representative..
> 
> I believe that even with optimization of bitmap scanning maple tree would
> perform much better when the memory is not fragmented. 

Hard to guess, bitmap scanning is not free, especially if there are
lots of zeros, but memory allocating maple tree nodes and locking them
is not free either so who knows where things cross over..

> And when it is fragmented both will need to call memblock_reserve()
> similar number of times and there won't be real difference. Of
> course maple tree will consume much more memory in the worst case.

Yes.

bitmaps are bounded like the comment says, 512K for 16G of memory with
arbitary order 0 fragmentation.

Assuming absolute worst case fragmentation maple tree (@24 bytes per
range, alternating allocated/freed pattern) would require around
50M. Then almost doubled since we have the maple tree and then the
serialized copy.

100Mb vs 512k - I will pick the 512K :)

Jason

