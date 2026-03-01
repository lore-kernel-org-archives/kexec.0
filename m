Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E6FD0062
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LzGoQjjVuLVg07DDqg0OC2yQOJfh5JTfWXg0SNoeWUs=; b=FGdbjHNPwpMmkwaj5ANW7XIUKw
	VRvsPaGNKhA+pVr6875xwwXbEbTyidYd1cJZlp5pfsTyjJo/jHCSZZZ4QLLIQ9QAj3y/UZYWoXDpW
	mall/w4sOxEGzi0y2iBoc/We7RYJRVd+i2RBo7X/WY3A2Pxt+UZecpI7YTYCa5aBY8QSnwrA7VIip
	s+UATmY6ZX7lv6l9EUHyZQJyv0y5oUIlA8qeiNyf4YcAvxkBzJ5MDH2QhfGdm4uevv/9Xz8Zm37oY
	AxE8ddaYooGhwnrNFpLfVCoA6An1FUcv2eUsyYnoIZXn486sX9haHBXwkRFEyDuJ5ARkfjpuFIu2z
	MSGmqzwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwmLS-0000000BoKB-0Xmj;
	Sun, 01 Mar 2026 19:20:50 +0000
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwmLP-0000000BoJn-26WH
	for kexec@lists.infradead.org;
	Sun, 01 Mar 2026 19:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbpLKb1MnNi4ENWJK92O7bqs6uK/EFsWDEg+T5sSUilABwdabYdTSf7NUB6RaFv5sKZRtoaW42VXcAoTIwlK1n5cdN8g4Cez5cT2IhAyRtpVzeogh0SClIH14uoOQnpJI+6KNgTRa3mwDtZ/gGta0nB8RgftsMuFnkwbmV8FhphqXhixk5NvT+/1vvhrrdNa5kiwAjydg3h7TpQoQdRsVKueCS3ySVuA46J4RdAeBP0WpCQUv7oeNoCe2HlsQHnhl+Sr/+0zpzNfX2iWHsmJz1/yGHwafALCtoqr5JmlzvDBjU7TGupGp2A1IepSsMnUzjLPyz7X2hAstL26LXb3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzGoQjjVuLVg07DDqg0OC2yQOJfh5JTfWXg0SNoeWUs=;
 b=BDJwL+FQil7uqsV/L8anCoh8GXwBA6cNZaye3yMDp8o13nKdwj4XQfcBWgiL2uS4efpiOEi8A8HW+ghNCs5/xyCXV7CfFO99GwhWSjfGQAaJmCJh6o4ewAFxlb2YnasBdzd+5PoZlAD1POJZNixMY2XBEYxQ47hvzN0lp/mUI5JxsXtlv7po/Xq+kaEwGbvYpXPhD/dRMXsOBsP8qFWyrNaRGz2gDrptFQjojsozBH17auU5BVNBG9STPfe1LZ6zwwbACB2jJ50KUOo3j0cCR41PHKngo4sIEq8faieYTS2qs7ijadPeIQmB2WAIiiMkTsbqFdcoG4jffUv2HG2CNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzGoQjjVuLVg07DDqg0OC2yQOJfh5JTfWXg0SNoeWUs=;
 b=AN8AX7n+GCGiXHLFBypRfEdBPXuOaNNm5t1vF7xDUdoXp6o9MgO31fdausmjUQP6ABTTnzM6Y7S6TMR1hE5mTLhRIBCj51HwNOnPgy4bwM+VvOOTvqvaAwfe0WCB3ND+V0vpb372t6bw4HzcfQqT1mcydbCuNXQY2NbYaFfeK4DWP44+lZ6Tr+zeKTJrQq3sehjH1vCrojDLw5y2/NGv7QaNCGtgsPERURL1H6+72BCpCSiXZcUlIWemoBBpk9zfvm3qJ1K1u+6v4VSqM+a0wbNEnngyCNi132XynlD25HXIu9uRibQMiErLHnlQXYKOv4v/wkhdr/rkO1AxI7Kgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sun, 1 Mar
 2026 19:20:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 19:20:36 +0000
Date: Sun, 1 Mar 2026 15:20:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <20260301192035.GP5933@nvidia.com>
References: <20260129212510.967611-3-dmatlack@google.com>
 <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com>
 <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
 <20260227112501.465e2a86@shazbot.org>
 <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
 <20260227152330.1b2b0ebb@shazbot.org>
 <CALzav=fq-3J4WFD-uNd5zJ_Fx2sHGv0vL+EtpV7WvGO8ddG5mw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=fq-3J4WFD-uNd5zJ_Fx2sHGv0vL+EtpV7WvGO8ddG5mw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0299.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: f6dc39bf-57f8-4d90-3def-08de77c79d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: scI7q79XCmKUUG2WYnVtpr22CHDv3B4Pc8pEKjpTbLlPBRwAsadB4MeGLrISUczKlArtMtp+ABhRabS+12uIbfIXVGWk4LNl05OBVLHG11WsN9KACcQqL1EBpUYyvuwUo7fGNmGVjrpyYxVvOPp88fW1aBaLNlp7lXHdcRT0DRsNxwG5L/cQU/3siRWspItMBUU3xPHYHCtEioDDjpgSnhtzKfp4Lb2Qtn+4VutvLoyqDuT2HdmeHsKqZGhVqDQo0QxjeVcqY/5lgSH15wa04zdB3Dy7PpYterLcVo42XDv/YjDgVfS0W9Rw5FkSzfv547YHGUPc3tFPyMcly/zz/6xunrJ6WPwh4QIO/EA4Of9/mzf3TCIrHDHMnQofv4+AiHMO1DAIDkHHbtOQ3fNEJ5YP/6cXQnkrpCNt/DOddANlyl9iIT1xBKOIbU6AjxQ+x2y2efbVbQxvEk2w4ZaWCWOtmNi9jo5vKhqiyOEB6FgFxqw1Vuo1wo4LH8LQTg1VuWDhqkrhly93EAqcnWrm2niicesjI08WND/8nuMhgwRmkeIdI/fgTvx4XNLcrnEV2gC07tM/iUrpSShE4DOxypQ9IAQdzuzRdlu55lgAEZBr8kcYccdwVcooAsfpB2kcwICGuOG1bzziDO7N+/yA8uyTwJltgjNWbLtOKivnPrCFc5XPjIMl3MSEJS4NE0Jao0mbZKISHZ8e3VEm+EJzfvPKoP4HMqTZ3nHOXsnDBAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8AnPmQBrmYrmxJMEjVWkFLMHIVhvsztFAYrj1UoeptiuQQ8kN9UWKndBGr1?=
 =?us-ascii?Q?Q9Bij7WZhpB8tqSS0K1JceVuqC587q1GUBLn4rUd5eGU7cIwFVM5HivxjrZP?=
 =?us-ascii?Q?s50egfNXbRJSmy7kXP6TVk92AkAt9x80yXpwxZgVn1xW8XH1PZWgwAasbn6b?=
 =?us-ascii?Q?bCNTSV53uk1bFMZiiCc0y5wbKjhgaWqZ1eb2lHAUZx+cNH/jSqROqMlac1a3?=
 =?us-ascii?Q?A5DDblL5KF+F9stL+XCB0Yu0J0uqv8IorfakNqbz/MvNV1TKOTPs5W4y6JJR?=
 =?us-ascii?Q?3M2HVz7hGDw+RKmz3B6FP9ltR0u8YImEDLk68k8fMSF5A4kZkhU0EvLuXR1X?=
 =?us-ascii?Q?pv1Pi79/X0wyDICeyXZsqahif0l/BnHJp8dIaMzBaTuhfi9DDXywJ0H6+QA1?=
 =?us-ascii?Q?qbCp/jrSYKiCT1eO8gqIXgqW2lI5Tefz0JcA0S8Z+FDMxZDQbpFFsbxMoD2V?=
 =?us-ascii?Q?VMOzqzm7AtG8yqeWjnil+pjyOoSL1r/nx93PUQIgBRN84S7sOsY5m6f3oTqy?=
 =?us-ascii?Q?pQuZ6j90CWL3NpwDF+d9QwsKcXsCXHKwsDVUC4gomAj1qf4/pOwnmEhCjDsT?=
 =?us-ascii?Q?QbRpDC7B7SyPUBDkHiwmOIwIkNpSuiFydBW5px3U7FuyU0345DfhNZUJF0IU?=
 =?us-ascii?Q?Cxtq++xKZjSfNFvvNSKqm3WHFiReVtlQILrjvovUfMl63X2v9N5/sRCBhOhE?=
 =?us-ascii?Q?031FqtyGEWI3fi/vjaqL+MG5z5q3UwfdDrX5pcHbjqhq40KXeixRHwdrYHmr?=
 =?us-ascii?Q?jY7ug9m7hig1LMAqH736AAIbM+8e+zYx0aPcxKP2cEbrwF489TXidmRG9b5U?=
 =?us-ascii?Q?R50fYTr4qgkhcq8lLvVzQVd1IGTvMI5hhIhQwVYeSGy03CBZ8KvW6stzWGU6?=
 =?us-ascii?Q?3CYRw3lxe1SUBPNGk/AUqNJzXnjjDc1aps+y9SvmZqW7b9Cb/3XJv/T5brQR?=
 =?us-ascii?Q?kXX2gid/vmIXHnX+SXhmTzSBBSfc1ivYhwWKaMJpRme2oZ9xL8SizWalY01E?=
 =?us-ascii?Q?sVFHWiCa8LCVoTpa1fl25j1IjitbO+ByfxiCIcQuID9Dn67G5++fGML/BD0J?=
 =?us-ascii?Q?n+YwMOiy/EUzU/oUuPMjoLhU2XSj67tprEx8hfwFrT72M2Evm6+giBvI+S3H?=
 =?us-ascii?Q?0AlRtWvcMGjyo07eVYfWy9Kg8wT4Yiauuw48m/me6Hw0pwffm75lDm8rtGNO?=
 =?us-ascii?Q?ebqhVa7HnUI8dqOSFHe25l0zWK2/bQmPVP5UMEoPHhNVASJYH3lZDEP8p2Co?=
 =?us-ascii?Q?sS+SfW0NmOi55JeCyLLZZuOD0HEq+0kWiJ12W1E1LFFFZOIu+8fZBwjNlbIV?=
 =?us-ascii?Q?w8dG2i2Z1Bn6hJCccSJ31p4E9ZwfVTvCD3orOgJeSdkSn0ppaWZIzJBoORqK?=
 =?us-ascii?Q?ExHsnY+a6Rw4MyOEyoGPN210sjxEuo8PUFkbD886BlZqhuBQuA0KiWPIZnsC?=
 =?us-ascii?Q?9dupOhFUK9YqPypecLoiPS9jC3mawQHZfWSVFgqCiNg+siY15RhwaXJj3r0R?=
 =?us-ascii?Q?vL4OskOuvGk8Owq9yUwy45c0+e2lsb3M2H0AHfBMzcd8fj5MDitweO0we7VQ?=
 =?us-ascii?Q?zsr+AEy6+INzhNbxm06ngzLxC1AvrxuUUkxl+Kio4TfRHcDzyp5ReJSVenEb?=
 =?us-ascii?Q?eEInuigs2drNrnGva46lspWSx3FDbMOb3l0OpZsnkptk8+BAUpbUz52/mPI9?=
 =?us-ascii?Q?Wy9kDJ9o94bTdU8Fprd+Bc8XzqHmdTS2Zj4W0pX42YYRs9F4pw+rXqdQ5KR/?=
 =?us-ascii?Q?cYAcKHhzkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc39bf-57f8-4d90-3def-08de77c79d8c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 19:20:36.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09t5yMlKlWxicNXNiXcB6WNSdQiIoHCJS7ZDHDudkwY0/7Dai+cdOMFvSkGH1WpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_112047_547529_C12C9B40 
X-CRM114-Status: GOOD (  17.01  )
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

On Fri, Feb 27, 2026 at 02:35:42PM -0800, David Matlack wrote:
> > Live migration support, it's the primary use case currently where we
> > have vfio-pci variant drivers on VFs communicating with in-kernel PF
> > drivers.  Thanks,
> 
> I see so you're saying if those users wanted Live Update support and
> we didn't do (3), they would have to give up their Live Migration
> support. So that would be additional motivation to do (3).
> 
> Jason, does this change your mind about whether (3) is worth doing, or
> whether it should be prioritized over (2)?

No, not at all. Live migration of VFIO devices has turned into a
valuable but niche feature. This live update is a different niche
feature. I don't see an issue with making them exclusive as the
starting point.

I think people will eventually be interested in having live update as
an option on otherwise live migration capable hypervisors, but that
brings a whole other set of problems that are hard to solve..

> software with minimal impact to the VM. Live Update really shines in
> scenarios where Live Migraiton is untenable, since host upgrades
> require VM terminations. 

Yes, exactly. It is more important to bring a new capability than to
optimize something existing.

Jason

