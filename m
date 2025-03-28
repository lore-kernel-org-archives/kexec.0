Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF08C36010
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n63MBMO8ycvR7NnvzwMuiQGDIst8YBLAqb7bLqAnvdo=; b=MHIEW8rioRUToc5L1p/oe4ABZx
	vGvytw0VUuVqwFLxynH9HHuF09nPfEV0eO5FZoOjTTfo9FzcXCcAQEIVIpuLl1xdL0WVJLWxtKZd3
	+1qjgAkptECyRYZspK/WyBBF6yCSwPvzZXm9cgzpbdnsu2jV9sAjTruj3/0si6B/BtzxdT/UhZuZb
	ln8sLq368tYhLu9cVBI2XTEowjLYEpCr9XxmRttgiIRD5qyMbdpex9fvFq4zqjapeukjQ2Y1J63oV
	fQtQd4Kj73MJsblFBnGWdHc38O6IouZvgPcl0qzlKgctBJSUDrTe9zG7xRGBXZSr0gO1KgqGjgw9u
	/x3ccDjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl1-0000000Bl9Q-0mFK;
	Fri, 04 Apr 2025 13:06:51 +0000
Received: from mail-co1nam11on2062f.outbound.protection.outlook.com ([2a01:111:f403:2416::62f] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty9Dc-0000000DLrw-0yu4;
	Fri, 28 Mar 2025 12:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NehrQkrXrjxz4JSIwF4VM3InmZGAGs6osG/ZAWDg7ECDuPtndTWgeRbctdRAT2s8KIyyWzC9KnxwuG+XmPZv275k34RHSW8b/BBrWyUYLQQ/2bkZN540sCQA+c8+w5Pzv2c82WmhCTRHaFAkm61qqQdT9rIBxZ5dpiPwyHm2XyRrjbOC0j94nkvIPAWqNAx6jWOaE5io33vo5GUBRrQI19Y8Nr69BOVngP1cW9lzi1wfZsPKZFIwJuO2Mp04tKJSBuO2r41qoeVGh+qyKoKZK4PEfJkCnXoBPucCSG9E1xbHcZHasfpq3iX5TGWb38Uhmx0UPihcEhhaSfIiqtAENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n63MBMO8ycvR7NnvzwMuiQGDIst8YBLAqb7bLqAnvdo=;
 b=YLjZQ4cPVrK16ChVtFKZEjEl61bZuWidSzy5WSsPmn71e6JfVfvJvY6j/pT+JMz3M1Ny2h5/CgDclNFaRZeol/t68C9rn1H8gzymHw3k4E16mvGr4GkIwwLuGAYanGKDNEsL8rv/Hg1vgmXRxfpTXkqCPtUyu/NvTsT3CnPIf0yQUT1z2ykm4EJMGSO3o+SFUNiXxeNf994oZp6iAFVYgYGpOzuqm5xpXLx7jhiKIgfD9L5S6r/uay/iS+RK0VjE7T4cbsgjhElsJA87KbVicKafai6HU/2Nbat/dvSbOoo6aDZzLqekck0N6U9mRPrANF5E9PHw6uACo4WM4za3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n63MBMO8ycvR7NnvzwMuiQGDIst8YBLAqb7bLqAnvdo=;
 b=TmioXojdJ6QTAGEicpHBnx4d1fWWKGPB+kCoepZOAWDjm3fQOVVjH0HLL25JN9/0xN75W/HI5ODm8XJ0aQOQF1k4siOGNt83ZFlrik+uijwkCqz6BdTn09oevyfbeQHgIajoUCKmPxnbxta1/anGGpqGXAPmmjk2/+X3rhWEIEdvBeZa+5OVCyztOfWP+4j++wglYZYQf1H2w0zfWETPkI66QhX2CQb/9UUebKv2rYI7sC4nTq4Mg0gxkVdWC70F5QpwY02l9iA1LqfLYSRJ0ULNdXxrWqLPeRfSnxb4mcDb2hUsAV85BVMV2pukDixmUrkPAlUyS4N/60fRkbqRRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 12:53:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 12:53:46 +0000
Date: Fri, 28 Mar 2025 09:53:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	robh+dt@kernel.org, robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <20250328125345.GA10839@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs0y0wqrdsq.fsf@amazon.de>
 <Z+VTHs0lp4TSA9L9@nvidia.com>
 <mafs0tt7eqt6f.fsf@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0tt7eqt6f.fsf@amazon.de>
X-ClientProxiedBy: BN0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:408:142::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d0e49c-a993-4cbf-854f-08dd6df793fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kb2bA6A5Dw+MTnYJngrPqpXo5MF4f5K9b3tmhEBU/LA7a79lZPANR9KlCoIu?=
 =?us-ascii?Q?opWVNVA28bVH3iHl65YXaPnG2s81RSk7eKPckOr9cs+1LdBLkASsb49rSThy?=
 =?us-ascii?Q?V8uwjsWl5/yE+e0ZdF6TUQt+Or3+onQ8ir/ABsYBIW6brIawxAh2XL1YzFaJ?=
 =?us-ascii?Q?Yz/dnWcExq+oiQmXwvd9qpSykGCdGaNotO+tU5OPWqYEgukdfmM4re62pQra?=
 =?us-ascii?Q?R4A555Vjek/lLPt0QUB0xVK+ff6ixFHbp7L9BX503ZabRD0Y7ygS9UYJRwwG?=
 =?us-ascii?Q?AgmWjDEj89F3DhUUmwJ2DdFjsMRi8phV8QxhCuXNDilFNYoX2sRNCgIVKfKk?=
 =?us-ascii?Q?ieMy0A8l+FGGqcU528oULCqopHALMUvkX/d0m+Bv8KNiedFgWBRb9t+Jaotj?=
 =?us-ascii?Q?uop36HY+LJw3FRo8KmNCozr6qVS7EWelZJo6BdzQ3GDAk40pCSw7U8x9+oW0?=
 =?us-ascii?Q?OIyv9vN9XNnoPQmi9cft4E1tN6qVk/+DGl+P2rGgqJOkkgM6RLU/rxkxbs2M?=
 =?us-ascii?Q?suPrZzvflUuVrFeGFzICjSr3mLhljuZK9QgBXRdjbBXvkm/sR3+zBJW5dXXq?=
 =?us-ascii?Q?SwiPh5OYpw34PXr4Adbe0aLf1V9Cn8RbISAv5mojdGJ16Cv0BtTP0GWoZb0v?=
 =?us-ascii?Q?JHsTHqwgXZT1Vmnrlw4k/GICrKnf8uTS5YNKV7Bcdjx6OexQ4iTrpPU3RnFu?=
 =?us-ascii?Q?WuKYuOFZVy4jJ0ggV+yQsySyhmDB8W5TKHC9Pm3kZ5MKPr707kWIYZaiSeSn?=
 =?us-ascii?Q?ZuirPl0ljNINsRQuNR6dJPrTuswynMbXUC7cC2H3c217xBcrd0uI/5fzOYsC?=
 =?us-ascii?Q?tJgeB0V3D2wJ2fdVeecJLleAlGmtcKShMhThFCdHOAIEO/THuDTeQo3zzYcY?=
 =?us-ascii?Q?nWJpg2DTKc7EzB89oK7zE4+/ElUU8behZerluQnlnjn813qyNd5CqJsdG7lV?=
 =?us-ascii?Q?amvklm3Tk0y6pFP5fcUS37PM08EAYkFrMzmRTUmm1Dou7jOPzJxgN9a8760q?=
 =?us-ascii?Q?f+h48pJ423a5POpZOe/DaZNLESPXU0JaS2w0P8qq02IOyqhShsWKSgI1j7ar?=
 =?us-ascii?Q?y7zkqVrthS9Us+Lf5M/PzuCDdvoNiBIRNGBN/928b+4M2TA8DcOAnBHFfXc+?=
 =?us-ascii?Q?qTPPN9g8hbdVLvkLihAvvxEtT1BzIiZZbO7rhjDHgOznRFf46vzPin8kQ9h/?=
 =?us-ascii?Q?HZEolnoeGeBxg3fOigerVxZLEJDfutFtUItS17q3v+IGoADUkB+C1p2YmE1Z?=
 =?us-ascii?Q?A3IgQoWpcyFdaFr/ksQrimvmYZMDbLKdgPgsM9AAC9G/1O4urSYhpZmMpngD?=
 =?us-ascii?Q?GzJa9B9phk33t2oznFs3tS5SkGLGVf5kvXCeP43zxygGDoV+Wm0QB75Ksaem?=
 =?us-ascii?Q?VdsD5nh2bedvgCNIlb7D3H6euj2Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1Idz+p1dEQFiRwa2FG+EqKnkp6tmByMveMaGtDKbIGEtEEUv+kIjHUsrRTt?=
 =?us-ascii?Q?Db10P4iJzExr6LJpZ/1xUINCLV+7vHdeIDh9rMoyEXJ33GAoOfKr0QCUNtFq?=
 =?us-ascii?Q?xJMpv0ajYcOxxBHyHOo6L5KYENsUeMj0OiuO08vWy8m5YdjbwW2SmeDIWjwy?=
 =?us-ascii?Q?IWmMdiOASjBd6imvxlYxpYlF4ZHvbpLcs0lhkAMsPON0bJJ+mZqPyAWPHlco?=
 =?us-ascii?Q?ETtHwinFF6NF+382WkyJFxKnGnqWmV6MMiI8Z4jD061PGpTVdBLhg62NjjqT?=
 =?us-ascii?Q?FB7dvD0pB9Vj7PvUMhZOjNa4UTosagS7pjaiWj2Xef4qkamDUjSsdYiXhunu?=
 =?us-ascii?Q?4arqo8Wy/FMQBCiz+TgWpHVHN5voKV1x4rjiAxBPIOPCEDy9f5gQumVlkCEl?=
 =?us-ascii?Q?RwywtTrJnPPV2vFbEp1wk9fq74RUTvMYP7QkUvfITWnyY/O1qBAlsGZ+DEbv?=
 =?us-ascii?Q?melOUTG5A+2A1BbxBTtLk/WGh6n2na8viNMORJKI3I9+Jsr67+wZbMYy2L82?=
 =?us-ascii?Q?rAU9AUkIdeCWBe1qCpz7sZABniLarbR0MzKrsI5cG9iObS0Xrbh7+c77z0Oj?=
 =?us-ascii?Q?yWf71lQUeUdpenJDu1gC8rwY4Ss3IHzm3EmesggyDOVkACcZLjbCcqJWLbDU?=
 =?us-ascii?Q?cM/bgdMtmpEnDtKQ/yD1J/v2aLDrHMEwdsdkfz50CmHn0bLVZxDfyIh39E8J?=
 =?us-ascii?Q?B39LSGNTrI30AcAhOg4WWVfAig1AUtMWzhVAC8uNHba/TxalotChsRKAszpK?=
 =?us-ascii?Q?/rBTpDOE04HdWZ3bmOR//7QVaWH7j8w+spLG2b1WE0vAW/MOcbSoslQKvLs4?=
 =?us-ascii?Q?Tf3IJAKXDgR7IB1E5ZlRo7hjelhXycFiAq7C5SEbq9lW5Dhbbp2xnXK8I7eT?=
 =?us-ascii?Q?bmCsYVDZFjlIA41MQO1Ign9Gj/sG+iMXRtjr5IzxGf2dgaU0xNLVtzo1OIVM?=
 =?us-ascii?Q?LudBMrVYfSjjxjoLcRhAIxGV6ofPc53STCfJMQJqaYGNmerGKbM9P3uaZiIN?=
 =?us-ascii?Q?DivQy2q6l8qvKEjDl1f1KuWMEliCn16M1j8TIL/8EAFXz1K4QH6axSIzBVix?=
 =?us-ascii?Q?7rcmeHp6gIDOCi8v97BpDPRwnxREoZR58Ow+mMMBDkGj41U/9MW1d9I5cgyW?=
 =?us-ascii?Q?yPmWMfV1/CZL2YVq/fSphM4orhTLsL1Xw+LpabVt4+41S9Q28l9NdrnucrSG?=
 =?us-ascii?Q?K/LQGExPWhTpl68Uu7TJYH4l2sXEF7nxq3H0/mfONxwygzl8PPu0VoHuFWxg?=
 =?us-ascii?Q?KMgS0P5U6VODpmT9kwchlmhexBOwS4sdV96xFIakABUIWcPpsIWUd611DdpJ?=
 =?us-ascii?Q?erYxro/k5YhzdgO+rzcbih8iXJ4oKBVb0udCeKW2Ck1TqUBaxMLwsBU3hv7u?=
 =?us-ascii?Q?eb4TmFdoXSvtxE2S4cLAukbfJcs+4WpmpUMPU+MN8f5Qt/vCQAuhYVQNG7XC?=
 =?us-ascii?Q?L7MtbUAGcFDiXRYQpWwV8TwFbWjrKCfQrzE8IEdwi/Ohj54ir/0OY1TOJB3B?=
 =?us-ascii?Q?ypOCWJk3lTP/OpohPfQHCp94QfVPl9XQfUuqSQXFNT/5pE+gPtS2lqHqKLNp?=
 =?us-ascii?Q?tfCxNbqQOeMHLZWNl4HrbBDNwxD8o/g460TWLvkE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d0e49c-a993-4cbf-854f-08dd6df793fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 12:53:46.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcQbqeOc5Xme5p8rWKyecWNOUmSZpCbctRfO61FqSWwhZy9Zk629a8JW+2PB1bmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_055352_268253_783EC770 
X-CRM114-Status: GOOD (  10.68  )
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

On Thu, Mar 27, 2025 at 05:28:40PM +0000, Pratyush Yadav wrote:
> > Otherwise we are going to be spending months just polishing this one
> > patch without any actual data on where the performance issues and hot
> > spots actually are.
> 
> The memblock_reserve side we can optimize later, I agree. But the memory
> preservation format is ABI 

I think the agreement was that nothing is ABI at this point..

> and I think that is worth spending a little
> more time on. And I don't think it should be that much more complex than
> the current format.

Maybe!

Jason

