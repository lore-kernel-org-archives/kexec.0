Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD42C5DF9D
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxwu5gs78rfvYK+a10mxJc8DypuoPL+TpC6Urw8uqC4=; b=tWZqRluMVgefBTGMHLwe8/88Yu
	8wS0svLzWno/jgiWo8iIUhWOYgp9CdcDsHyQXbUwIEKgR08oSRGXYaX2SXUw+Z68MsewB0ED8Xnmm
	8Ygbre/DDk91WeyjOO7NGQPaxLe8pD6GGxLL9dU6zOQ0v9QCbH/MQlX8Kmr2hfkHs0jWllSSj+Np/
	6RRE7nD2a7kNG39fZ5sboZ/unvTZjQH53EagLDoPDTgEtOVNtxIuOSHDtYX98F17/b4vT5haBOOdw
	B3ko5uubim4D8rvSGQUu8hmjA1O0atP3jgPJqyBfc7W4KdRt79zyYazWevIaNnj7g3yHUdO1v85Ja
	x9UI+slQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUFA-00000003WdL-3jIU;
	Thu, 27 Aug 2026 07:09:48 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUF3-00000003WcJ-3fUz
	for kexec@lists.infradead.org;
	Thu, 27 Aug 2026 07:09:46 +0000
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6SHiF1410480;
	Thu, 27 Aug 2026 00:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=nxwu5gs78rfvYK+a10mxJc8DypuoPL+TpC6Urw8uqC4=; b=
	OB8VkUrj4n3h6fed9Ik7ZHh6DRBhRXpjRDMfWmqKBK9AVVfDPL5BrLA0+2UW1Glm
	2lt/W/B5rJv+zCq1OzT5EyRHN/jgEGiQWwP+3iwoEppXeBqD8Yod3DcGME7nW6qf
	S01SnsJeBS0+ztd/VIhaWMJ+pPzD3QONX73X8XVJ9udo7I3Usy0BwOhF7P4kgm3t
	ABY7TSiDG6l4XSajcs8jQ6cS3oEsiiLQqOL+EAs9MyYN+ygfAzm5qVPAkS+HO7lf
	zXM7SteF58oMYpxcGpY1S/Bimmkqs+dgk6lnA3sc6N/GRMQ43fUJkTCpoFivRhl9
	62dhJC9WIZut0SGM0dZKLQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022076.outbound.protection.outlook.com [40.93.195.76])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gaay2gahj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 00:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS7rktqCyxlUXyLi7EfgZki4+r2NI0zTVacnB8V2pcyLDX8IK98LZo5ygalzY5a+mQ2tZA9gf7tEfJf5hpfzx/kxuKncKFKPHAyqzZaCsNoZYy9ljJYd1+y6Z2o0eRPKn+aIfQj/uMwBLuaPRVOZM0oTFw2FZeDEcIGQxoj6gYeymwE9PJj4l+KYXBZXDXhoBDuV8eft5QkNRFWTlv85i8Z/ewjdg6Ws29Na94PyJbjESUAin6E2oI9s1RQ7hjLXBpQKPwZxqPUoXNJl9oYB2p1XGHijw8BbPnRjWyViR62sikfx3O5yP5XG7bAJXp9AlxwhO93qSV+4sAKhfg+XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxwu5gs78rfvYK+a10mxJc8DypuoPL+TpC6Urw8uqC4=;
 b=pgbCsIrvcR3hXK7heO/fN/oS/sxTH/VD+CA3VianpkOAtemzud6AA8xUOkADG3zr9pTxbS3lKp9SSYNKPcnGnYAG58pHFZhXzLMgCmmUnDy/X79VlNCZpCUsY2S0r2vXNhHHs+K2tuTwZ319WaxAHU/wxO9w7fSQr/Uqrc8MV9S4TCN9bJjR8bKvsEi5neKHakq2E/jy9aRm62tCNtfqe+xdW80N8pT8k75wePaXIVqMETSt8+n4I1R2lWI3Vedj/e+BAFh2irCzD3Vln5lWvUnjytiqOWW4+QD3EnXYgyp/KrakbBp4hFEjXHLE3nSmhKw3Ev0WmH1jxWzXYKNClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 07:08:47 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 07:08:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing docs
Date: Thu, 27 Aug 2026 10:08:22 +0300
Message-ID: <20260827070822.12651-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827070822.12651-1-ionut.nechita@windriver.com>
References: <20260827070822.12651-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecf3af3-03c9-485e-3419-08df040a09cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bpfT3KxFvNi/7DtBiXP13LHl601mP9lvqHyxz7bEQ9+R4wrEc9QIB87mKCN+VLUeyjJ+HhAWx2w/fwIVYiDh6s5NvrTyqL0kHu2n4K3yZ0w8b46teeLjvmANI7iEGfngQAqHRLNap42X/PeuqerZDnVUbKf1zoIIf2vWZs3OmtvEF0/vauaIfTkNHblDZZTkJypzMaN56i8l9bu5wVq5DcXIBfAJtZ9+f0Sq416ywYbXEhjmMvQ9/GYzWfIuO3rm+lJvrH4uE0Yr/wD7ax0sibT/MpTP3dTHILtdheqHKtfsFbuH42yMUweqIPh9fJ+lhjp1VyqHStrgMXnURk4HVbDIoXfbM5OV/IusYzsO+BoceYWtaRjot/JUOxf/j5n5m7wnodAmS06XjxniswggmQ8WkIt+F2EVVgip2GOanLBPyo29Is0uJ29JaBbWQ8WG94BXZb+Br3/CPeqVyKSubNwDnpUS5ea597xiWYxM+3I1CnBDnFv4cgl4SmuyQkyNNhZa4kx0c1Wy6ZA+L4DlXRWV0jMjgKOrpFRrA71DvhHGZ4d39HyVz2M/ZqwFfS8GlwsS3hFTPJkUQhLWbXh0jasLIwZp5Onhw2rd0mswRRVAk6UP5wyXdQawpNLTcf8RfivPetLn8/m+E8itvQPz663vqSOorXrJUmfJ/YHh9t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3H++jBKgawjLxbSXYRgOWrLqnI7kf/DLfJZmX5ZFIklNZyyfFTK/s7ISdRd?=
 =?us-ascii?Q?xj+1U8gBQyOVnPhZMjSuvvlx+GfTEVMllyNUBynQXzH0pjeWFGfu85rp7mfo?=
 =?us-ascii?Q?KlU6qtjriZTm6spX7dMWH7bkWVJ5A8ctrzLWuVQV3r7i3kMJzmn7SCU3vBEX?=
 =?us-ascii?Q?Y3LxSrk9BA/9Thif9bnq0xwcqEIdk9l4EayAmTpBo7BtxKWFtZW7j/4csKqy?=
 =?us-ascii?Q?wQ//fw3rhxl7Tt0hScCDfoAnlnQM6fYOEAHFUmnnYeU1vpQng0jGABZyj+vU?=
 =?us-ascii?Q?RNNa3T7VWg8iMms8umnJrRL+aM3wukWlDp/cGVCeU1zem6ltIXxS0HM2mck8?=
 =?us-ascii?Q?c1i1qHx/n/w5BCz8GsEn9+iQwxPBkD1r0Z/FU2agKDLM7rfnKkteHjGUluy2?=
 =?us-ascii?Q?BLDy9Io7Lrcw05F1sWlrrz2747sVUldADrNDDnb7lVk9nA9noaGpL/H+UlVo?=
 =?us-ascii?Q?7Cptbv7p+SmwhiESHiGuU0+2gMQw41TDY/HKtVOx43/Z6MdKpeaF92al0m8V?=
 =?us-ascii?Q?bSH9mTIYrGl05dgSpPkBNtmuaXStBDm6q+/m2nLSM8hztoWxbPBAVpRSgY8Q?=
 =?us-ascii?Q?Gjkbm32Dhezn7fikJsC63rmDQtMDBYHkY3iyPrsEcQud91j3rARYqj4di275?=
 =?us-ascii?Q?AFhxPn4Tnj7AdSKWtAz70pL6Y+prVF+YS2o+DrwhJbmDMCke0eqcAZXhyMHx?=
 =?us-ascii?Q?WxmAyNw07qYxX42IW/geIwtc84R9LzGsKYIGyjQ776EMk+f1GBDs8409GGhj?=
 =?us-ascii?Q?uQRNkd9p9wpamgoUQWyDxG0ivRY0pOYgzOTZ4u/VauSko5jCx4mG4+2/9zBd?=
 =?us-ascii?Q?+4GrXaPUDkIyQ6/eTyAAt3WQMpHwsofy3ONBOd2k2fx9nQbMlwe/kdAeBaTN?=
 =?us-ascii?Q?ock5oFC86s8pyh31uv38LZevoJpELN11ygw0+SaCzKfoZGZW+MYoo2VjLyzm?=
 =?us-ascii?Q?gkDlMiT5iOCt63OTTEDDoQ+1D0KPyy3n6bSGXIdiFWluU+VEwyqhcUVWPYJK?=
 =?us-ascii?Q?M4e/NziiegUqneM5VZVC6RMLAczNGpaNy3u+Ed5WanBDGyTRVlljZ3A+VuqA?=
 =?us-ascii?Q?CBANuU3PG41t+Q9JayL8oo3qSGCzEbeYPB0AscCVUJr+YXAOnMLRq7Xo3A+s?=
 =?us-ascii?Q?45/y2twf1pl5cagdcL+ja+wV+eC6MOn7sSLtsHbuhxeorSxW5eTIDEVB4RVP?=
 =?us-ascii?Q?LpD1sVjZXfmErBzzyC60hhJfS1NiBDDmumcgcpQCdzo9Qxdc+3pfJqSKBHQP?=
 =?us-ascii?Q?NHf8usD41Rvw56o0DDEOrhdFMWTQZ19j/Fdn+EPUKmbA6Er66IRjGSQU178l?=
 =?us-ascii?Q?7V2oj2qOHVRgn93DQ7YaW4rj83pJ6G+7CWP4NN3YgTfLPVxGfialSawkLxWB?=
 =?us-ascii?Q?RJMfPHDJ9mxetWf2dr7kRk8/6D6GIT/686ZtLBxjrP0I+FtVMhoikGNOfw4Z?=
 =?us-ascii?Q?F6CMPCmss6tuq5W5xyxTno58L6pOSzwejXJSssXQ64VDLecbJqbX4Fq9XcTm?=
 =?us-ascii?Q?sadSD7e2y+B65dozfqY9WcL5igR6gc9bIQK/9CDm+jA2ZKMNYS6TCguEBCgR?=
 =?us-ascii?Q?c4ZDj7tfq06KvRxctWBArAbvKm6VQmiWdxz2OgmuDeXLs0z8cpjXu8DOHgDS?=
 =?us-ascii?Q?upfCRIBJwlGzTDTHvELc51UuDOfKzen5+MlUsX5eXQmcuhrXiBCaa7tHDzjR?=
 =?us-ascii?Q?rmnIQgUsbK35pFb/hIW/C2h7RpG5VHidC6dOMiKbYrsox65lEedOndl44Cld?=
 =?us-ascii?Q?+W+MFGvHFoMPQRAvVLTnd6IeOb9GJiBV+7fLIt/6x7Kv+4OYB9n8sPy+vihY?=
X-MS-Exchange-AntiSpam-MessageData-1: FeyV4Kl6V4XnepkmpX3bzNHXMQ9CSiZGlfg=
X-Exchange-RoutingPolicyChecked: UbG4DDpaRF5yeVejn+fN2tgwsr0UceM4FYFSmr3Sf4KZ2IYSYOR+JZzKg9XEFIYSYQxYpecq3usYkKO38kOhDIL/HCtywDgwU6T9yvLh5S/mKe2xVzIa72yN+6agrx/ZTBfOHxzAW8ROeiep3cn4QLJ0EPioF8ApYG/h9bRjK56y9bf+/+0NCzRvz9dkzAVijG82UpurQc659CKwOyxnkvCsLINsjb6Don+bPJt5+Xq854sy0b0yyFuczoxrcrgW2dQsVj9F3g3U6Xymx4qzJvruaKJPjHZbFDTJGT2BmG5JB52LX6aQYxdc3no4CK+TmTQBtk+poRvtDFyrBGUU6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecf3af3-03c9-485e-3419-08df040a09cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:08:47.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWAD00mmBYuGxlB8Fln7UfwsDJ/Blb0fn+yp4Wp1RsdJsEqShsB6WOTOvwi4W0ceHIOcFwo2c6MbBFXZsy0apzw833DffZjmdKRgUgP2dQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-Authority-Analysis: v=2.4 cv=EKU2FVZC c=1 sm=1 tr=0 ts=6a8fe281 cx=c_pps
 a=eCb8aTw/9lghk0zZp47djg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=RxAQHiabxDEV-jkcklAA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX9TEupQlHhC0e
 RqfqZpusyr6Bb60h+PF0sf8o44keGx76/Us4/VKmaF//aqeUyeedup5SBpj1W3ygnp+2flMtNF/
 TwHxRiGw+op8Q9VvQa8u7YXwL59CTWfd2lrx2wri004fbbKhFHba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfXxYTpdzPo7uCQ
 EL/nWNmGtmvkzMxV3Ju/iKhEIWfMHuv7BCkOMa4/JuUHFgOawpGFBWH0yaYhXPdPhBkoYSgUduK
 Ol6bLAlMr51bo6qz8B9jqcCkdeAxCa+5+kRQapEzDoybToNApzhjbxf/ZLzB4O5c5FPXOfso4Y9
 bG0YTwmdjRLcr+fpp7gEfDaKALszdKz/ryElxrh/8Shb4bZRUtLdSAQE0LAF6M5De7ItgA+O413
 lw0leXHESeiox4tkAmCUTd5EtMifi/6ndeHuc0eDTu2rGZoZEzv01hiYqwrDv/D/x5xxd3ZWb3Q
 YYBzAcTYuivBlstMNS18CS04SvxnNPny2rfkZ6q/yqS+YrYp0mu+Ilfwln3+O0Qe+rmxD3M4jde
 rbHyQUtvb6pino1oZ3FmhSsANs9A/urN7mXaw8kYG2I46MJskyW9ye5qhScBHSxxopCwP3CT1UE
 +S1rRcHO8sDqWPKX7Fg==
X-Proofpoint-ORIG-GUID: WeynHoEzripbAU1xQRYQcyk3jkTOUVDc
X-Proofpoint-GUID: WeynHoEzripbAU1xQRYQcyk3jkTOUVDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_000941_919739_2E90D3A7 
X-CRM114-Status: GOOD (  14.07  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

The elfcorehdr reservation is now sized with NR_CPUS, but two comments
still name NR_CPUS_DEFAULT: the one above crash_handle_hotplug_event()
and the CRASH_MAX_MEMORY_RANGES help text.

Update both.  Documentation only, no functional change.

Suggested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Bradley Morgan <include@grrlz.net>
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 kernel/Kconfig.kexec | 2 +-
 kernel/crash_core.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..a97ed9605602 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -167,7 +167,7 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory regions that the elfcorehdr buffer/segment can accommodate.
 	  These regions are obtained via walk_system_ram_res(); eg. the
 	  'System RAM' entries in /proc/iomem.
-	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  This value is combined with NR_CPUS and multiplied by
 	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
 	  segment size.
 	  The value 8192, for example, covers a (sparsely populated) 1TiB system
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..d0bd2d0cf899 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -648,7 +648,7 @@ int crash_check_hotplug_support(void)
  * new list of CPUs and memory. To make changes to the elfcorehdr, it
  * should be large enough to permit a growing number of CPU and Memory
  * resources. One can estimate the elfcorehdr memory size based on
- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
  * excluded from SHA verification by default if the architecture
  * supports crash hotplug.
  */
-- 
2.55.0


