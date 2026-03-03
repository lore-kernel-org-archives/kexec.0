Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65128EDEBF7
	for <kexec@archiver.kernel.org>; Tue,  3 Mar 2026 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=av6TNz3h9+F+nLpoUjThEWhhirWL3ChPArkBtRnQKcc=; b=fH9MlU5xTGD2cLEoh+b80I5OYL
	yLT7h7GpfAdH41zRwA8mBu9eMET3hLBQ3nkow7Vyr/UEYvFMmSpEN43r/e901RryWP5744v3QX/XC
	qHu/L2xOnbz1TONa3o8/CeAynUUlG0pw9kc6QE0SI6Lo9LT188jwEmcEENr+JcNhQj0h+hjMwUFKC
	PbVBvs0zDrel1mA5kSpDcp8eN6XQwmNhFqXHfyJ1m99z49OPUArhBGIVw3KPEebxOpJFPkteYMv3v
	rfHfNkxuFgThXvHKWo/UceLnYw7xhG8el2nESGrOZPMUN+CYi5oJ80aCMaFJO3MSw1xvvTZ92j3Qm
	YQ2CHSEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxZZK-0000000G7OV-3rkK;
	Tue, 03 Mar 2026 23:54:26 +0000
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxZZH-0000000G7O6-3tY8
	for kexec@lists.infradead.org;
	Tue, 03 Mar 2026 23:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfYJfRTvLFjtBbebxD/PhgbqF6yqsLlHOxGSO20QvrhGEhXKt9Fv9cGymBoYWw2ZN0h56dezPjbQrgbCCy8E8d9hS5g1whtWCxqqv0CaV/7Mcm8xh0EHseJZ3tQq23ByrhHWm1RKugOCCwN7X36EcdlfjTvuMPss4VO6/LOD++Mx5M8oNG7clw2dYdSLMTRkF8g2WQ/Dmvec8ONx9xaZCSDXwCpTYPz9oQ69Mb6TJLEM5r2fOBr9WZ+M2U84ue6vufXNH51Do8BUrmustVfaXoRwruPmVuOJd8WngY95N9mG7+oQUhcIOa86w1+jT/fcFYsiq+Km5kqzkjSuM2OqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av6TNz3h9+F+nLpoUjThEWhhirWL3ChPArkBtRnQKcc=;
 b=GHbgq2myZizRhWEsg7pWRW7+LlgHKCnVQX49o50Xh/Qw63U8zAPKWd6b0yZm0CxXxj30K7f6FmT9gDjCUd2ZrHAloofVgnNWK/cRIUSuGySrvFna+KRN+eZL/IukQt+JsqdJU3opEeChXIbtA76okYllJa6oNhPdJp56NrhJ8aTvUTMqGAZKyCdSnaIA2MV8esQo43kZnKaaFgd3Ui3plWDwqjEPgGvdusikmgpCka+PvdSU6cf94Ttm2LvHIh1N0M9XNRWATRx5qjcvGi/pdIWlqu56emDjswC3q/34o4AChFgtFFDA3XDIPtx2N6rvilArRb64nwn4MCtC+TNgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av6TNz3h9+F+nLpoUjThEWhhirWL3ChPArkBtRnQKcc=;
 b=Q4Ve2gg+bfE/IapvNPkghXS3G7B/UpZpUuwQVnrIU2k/ku6VYJZDese/QVDRH48C/txAM5VuTIDEaFpKcm/pXUh1JLh6dSwfXm3/7Kuhs0PEKRLlOu/qN4L7UTPjUKPdf5MB4GmEIITm34VQlxt25JXX/lXBHMFbpL2eKr1of4aGSb3WF7AOrts427YRSL2eWiA7RddI0O3mwc1isOfp+VkpcRJQ6ygiPjBrLJeTqCgU/Dsw9EF7ugpgs1vNN99JdifycD705o0TaEjpyO811H9QTKlf82JulNPEMqzqP8ERQivejnLGBgJyQh5fvREtH0N/8MrIrlLTfwMNRDBjsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 23:54:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 23:54:15 +0000
Date: Tue, 3 Mar 2026 19:54:14 -0400
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
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <20260303235414.GJ972761@nvidia.com>
References: <20260129212510.967611-4-dmatlack@google.com>
 <20260225224746.GA3714478@bhelgaas>
 <aZ-Dqi782aafiE_-@google.com>
 <20260226144057.GA5933@nvidia.com>
 <20260227090449.2a23d06d@shazbot.org>
 <20260301192236.GQ5933@nvidia.com>
 <CALzav=eJ63gitLatAerrjEc+o3VXcRor3XwA7_o2PmKYnMwCuA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=eJ63gitLatAerrjEc+o3VXcRor3XwA7_o2PmKYnMwCuA@mail.gmail.com>
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 54738d48-11cd-4eb5-991f-08de79802d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: okBrQKGgWtJjPI7NIGonl25FbYVhND3sf2luRH2o88CL/GfvVOLDtlzGq/Pt6nChAYvUWWP1/Q3ka3J36G2HbDoshj0NJQkaODNC7JGMHOB0EvKNP1PMcyHI0OewZaU/5BGCB6bWHDqqaMolmLtnS1TcT/ZyfQEtX1k1o8k2E2RoMkFBxt9ijzf+jsPhYNLXPHxajvrUWosGUyoXNvGBk2ADHDWMwOL3Lm5lRjzMWF7ZDw1uNty8S78AOhlpVqBz9j0KOHuIVkyZTluHaPGZp2/LZilBTM2s9LE46fzdU5D+DsqBXhUFTG3Oux20RrFd4vM+sKMm3RpW2/f8xDiyn+qusBKh+hYl1Yyb/oUztpJxVLwlrOp//0H/EBaAKQ3idlDg73J1SyNKCrpEnTo7E3NsQSNe70ASTbdpayY8KsU/7YCh+kj1KHFBPJQQNgM3p2qfs72636Mi4gAeOup2fBOaBsVocy8Qg/I4/u7IWYGCT7gw/9TciwNsfmXo+kYpdAlbmknJ/QAXodmU/DS4paRye0W/tbbCod87elAh7ixd633e7jvpoNdfXwerU54SmZT8IhIJIwsDTO2rKqqiPp+ksbZ4mVcvg5LOgFr3Gce41Pv8LTyBKCRShVFzCdq5gVKF8gefI5cx7b0lNdqF7isVR/Rqm6tAP3rx1I2oIublWbru1yAF9oY/xGS0CTYO3HqQ4v7VTM3/fZl+/YgjjOE+giHSeP8oIm5Rb1XN4XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVbVOKVseOfUonbB4QofY6DPsh1TrWr77x81ie2cCethAEgfAwK6U6njKyxD?=
 =?us-ascii?Q?8FaF50yr2ZYDlOH31BkhiW8BO1tTVgshHJzq/l9TawFl6lSYaUL5mr2m2Y3D?=
 =?us-ascii?Q?d6JIrXPBnQpGeXoquJduYzwBrIcHt7KljaWIIV8+OXNKLeD0uNgeExg84inH?=
 =?us-ascii?Q?72cMnxkP5iFvrpAxyZ84yB3CfWSLywISc/f0J6Ck0yQBkoXBHZCZ1izTRIoG?=
 =?us-ascii?Q?5OubA/rD2KTqZBHTRK2+ucc/IX/KsY6TMU1wgMwugYXUh3cR6i6VS0SQgbNW?=
 =?us-ascii?Q?utJYorCJI5SNJX8MNkewbE53JP2Ao+I9wdGCw+oRFPLANJAg4MQbuhfAdMRx?=
 =?us-ascii?Q?HgBBE8HP33BaQr6LjTuaPPo5+tL1tqA77/PG2iC5obofeJ+DcU/TgKKZWjKw?=
 =?us-ascii?Q?LqK1ZwnWqf4Dx1/ngtf8XGXEsEkRYE1C3aNt9gGGG6hOLPNMmZGTXRoHDzM4?=
 =?us-ascii?Q?7AMK8/ZF9qwh/IF564K48CJn5EdorIXJF5MQyWolT9Gl1ZjutTyEocIVfek/?=
 =?us-ascii?Q?yrw6TL+Fvit0RfLA2mv4rGoY8dFPrTfQWixZacTZmPLi4WgkSRswFGlkn3Zk?=
 =?us-ascii?Q?741+/dQqAJ7QIiHtqdg7LIlZiq7RakD3/XYeDmt4Sh1dE9k9i56WXUwAQ1KB?=
 =?us-ascii?Q?zo8O7ItaBUQ+YobiYxtjzBtaOyeDZ4xHBPkIVHseDkpAXzmLgyHPuWCleLhm?=
 =?us-ascii?Q?VSzwBBj8yAt3QO4iZdKIoXxlw5VzewOokoxiLHovZGtGYp791cB1GxaG5VUk?=
 =?us-ascii?Q?sMII3d6zeb02RAejVwqvZjPDTaS9xhxuZKfvoypcOQhoWuFXeNtldXP49vxG?=
 =?us-ascii?Q?vAKKSHq0onzTmg3rwI/KExk57t7NtOH65CQyRNXOgfGLj7au8HuJsYWChzQN?=
 =?us-ascii?Q?6WDDm68lLep0DdLth+jzZMJzo93rzDi80rlUwlzUWcPpHBo+xSB0xK5WiX2i?=
 =?us-ascii?Q?mGFKN4TnL6y6riaFXSDz56jaf9hb5vGGjjy6Q0Rj7EmZ+SSw8kiDAhEYkfJ9?=
 =?us-ascii?Q?dHi4JWtu7jATaOm7sPqq3O+uphgNbX5/Y0EMdx3pD7ZwEe6C7WXcTN88PrO5?=
 =?us-ascii?Q?Edpifwom8XhCdUPhQPYtZL4QB0IV2PRw1qUFfGAMcOkfAtBnVcmccvxONMeN?=
 =?us-ascii?Q?x7xIQruLedDwXexXhc/DtgBdyX8bi1LTqykVZW0zc4cdwPuKa3uE59abf5J6?=
 =?us-ascii?Q?JMkTdCpFrAxnx7yMYa2+OBqC2plV9dd1ft95eN0Ht2qOdtQP8NHEX3YgvT6y?=
 =?us-ascii?Q?Wa0COiOXOkSHD2Ooe09EKDQ2Le7a+1L53PYP7zd0K3ho2EomZ/5/XkUyWm30?=
 =?us-ascii?Q?CuqHIBp+Cy45lqcgf2tKWblbCmp5fn2IGgfsBA9NlpR6Z1bwgq7uQgxPJIyy?=
 =?us-ascii?Q?GC+dEZqlf+6/PL3Bz0Nw2DgnJtAlhloCcgtXrO+jltJUz60yGa5nZgBTssw+?=
 =?us-ascii?Q?xOtzvhXuDpY7mF4G5RCGNIh8cnM0ecl343Oyl60MOwHILiEonO2x2wHEYWKH?=
 =?us-ascii?Q?xy05GQYHPysZhuFMTGnC9t2u7+jAjKN51fWQmMa3jct/ehBcSE4gasTrpmig?=
 =?us-ascii?Q?EkaamjkUHIpKsrM0p9vVOWPf3vpehltD8pwxCaiK13YS29SV9Tdu3+W1QVED?=
 =?us-ascii?Q?w395tRT0eUzi+XYxs+R6TIvcdQDmUBHatZ9eqgLgLS/aGrywXyXMp2tfb5Pt?=
 =?us-ascii?Q?45A32Sy47X2jw2tHdLFTdfG1bvbuWRjy6X/l2H8/ykGZR/SNYEbu31C5frT0?=
 =?us-ascii?Q?NqLHVH2WBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54738d48-11cd-4eb5-991f-08de79802d33
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 23:54:15.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDpav5BvCf/dgpll4PpjhakdpvxfTMBW9PemVOL9DYD6FGqJ0GCm5JdBIaWpXNpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_155423_992025_E9225DBC 
X-CRM114-Status: UNSURE (   6.69  )
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

On Mon, Mar 02, 2026 at 10:14:29AM -0800, David Matlack wrote:

> I'll look into this but will probably defer it to a future series. We
> need several more pieces in place until we are ready to support
> traffic to/from preserved devices during the Live Update.

Even traffic directed to the IOMMU is sensitive to the ACS flags and
they can't be changed..

Jason

