Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B4AC43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2n8pfGQC9Pt8YBtV1pq+lx5DVgWjMH1TIz+l1HAz8/Q=; b=jiukfuQopgGNXroG9bULCp9mUF
	SMec91P3etEDI4Qjp1Wz78YW2hdCdILbq3lCy/j9qNHFx668+chBvBjk4gW6BnI6hhdm5DOETlnHU
	KvzpcIqfmj1c4HKbhBG7+Jt7nMnAzaG5rlka1rmmBBh70GeP/WH7U/aCeX5rHar3R8/SjmZhb+Gux
	KiWAjNh9wmiYInKg/InHqX7f2eS9WSJr3AkQW6saQKT5I80Mmrh8Rye8MkGg7svh7Cdqdmyfi7Kxp
	NxyH5NWWv8BrqXFmjYjqmkMfNo/God4AsXoKX8zLirvUeop4HLgmFD9NkTXlQ/q9oqMDHoORzNOOo
	mXqFgx5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHq-0000000AcPs-49dG;
	Tue, 14 Jul 2026 00:46:14 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHo-0000000AcLl-0J4U
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E0EfcQ2662519;
	Tue, 14 Jul 2026 00:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2n8pfGQC9Pt8YBtV1pq+lx5DVgWjMH1TIz+l1HAz8/Q=; b=
	nueh+2eenoe5+K3TyXknjzABiyZSuV6RQBCURV1CeYC+AbpnkCHYi9qZcFDvsIrP
	nz+8NjW3CppQSLCpP45HZUb7TwEx2TjlsXqA1rgNALKN708a3xEc+/YXHlg+Tj9y
	X7tgiwWUdz+djKr7QxcvIN0VStIwzR9lycabkjvPznYOwYFgieRUT9BMrC1fy0Br
	YrOlJzb5uLktxawAo6oQ/nQHjaz13L6VBhbCNAaW6tnRlUVeVsMK5K4MUYZQw6q/
	CyKhJ/TOeC5V8U/DupuPV//Vlwesewct0BWYjyFUaxETfpFif7kfadmLmw30mx7L
	P12/bUJOtXt5RX6HeGdvgw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed83a00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0hVua033621;
	Tue, 14 Jul 2026 00:46:10 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9gunvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLcH5UtXdQ5pG3Z+HQh/IS21daLjkNwiE8nzsLbyoz6cmzXJnfAQTE/i0viwhZk8/pABejxw3SW15/w4T2MxBzDJeKsnPC6S8RDG1bjSeWsUOwgQW127AG7Rvd362P5T6DkN4HBWIdINMRsro7RLZjSX4d2tT+reYBxSVOMdrRQfhPgQApOZ+u+2A6QdEtk4vp74VOhz1gG0PWC7weVC4dGB+bv32uSQBMZpRLYTivs2FY7vgP4xYZ/4vfemWW7y2Byz3090TyPgA9D577Nwvb7CI/VDEdF+xnShEEowfo69iyfbfDbyleciqcgwwKi8+dzz0QaZ2Xo1HNo7FlXXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n8pfGQC9Pt8YBtV1pq+lx5DVgWjMH1TIz+l1HAz8/Q=;
 b=L7+8ZulGGkXfHlbFUD/iXrGMpExPqHrCozwJQhy2VmAoGNb5ysdvsyxnDcTzShO4xZXBAkrt33e5EkKC9YgPCYuzPAl8PlXXN1pWFKuoGIBhS/g004SumwPpjfA6U+WwSmt2lTLa5ReFstt3B3RLVhqTH8YaAlUvGhiovSqbnVxDK6Itm1EnvgqXewLyqAb0NHuWRs8LKhO/gYsgkptQrL6Y63ThXpGumLDT5vT3lPtgtGLuIpxH7dTmRjVluPjmZoY+r3PJ3glkNV0B/N01dvELk92EyhmsjQq/BENi+fkyIsvn5233v6obijZ1WdYjIU6xb729lpmiD+AoAJD7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n8pfGQC9Pt8YBtV1pq+lx5DVgWjMH1TIz+l1HAz8/Q=;
 b=JiK9gLnya6ZgeU3Rd1q4FU8KgBx3Yks6uBIYfs7InJZL6kyC57jAR7jrtKyZDm/+hzEZ+QmHm+q2dn3D2/jXvxSjIloRPlvRveA2p+X/rN9M5jZeiczqXrZMVv81xUnlPc7JcDb8TAQfLzoCli01WWyD3W4ZYynui8I5Bx2tuuw=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:06 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 7/9] Add PG_INCLUDE_HEAD extension return status
Date: Mon, 13 Jul 2026 17:45:40 -0700
Message-ID: <20260714004550.3698175-8-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:510:174::17) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8778ee08-5c43-44ce-6f2c-08dee141499b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: oKCLNKPF5oAUS/jS0SfMUrQMNCQOZ046nh9xOmq1JsM2Eq/sYOMo9eoJP8ltxirrjdk4EVfH7eKC3dqKnEukEGiVcbWzrUrz8Rm2Bi/ihCkv95QLXIWyZELfb9dE+fstfXBwCPNQxjPVUKcLcARRlpp3rj3OSIwgKQ47R0yNChTWLl8rxVYcAFlUH1SzvgIia5G2s4jzLhIwAyMWlFxc3K/1cvNzhPMhJV1BP2qCyp40IgIUdtK6nqkXmmG1rH0V6lH/xG9q52JUpJ6NKgabxcBe4lCO98y5Os9GjmwBJOZBFTUrzMGRdlus631UVkR6MwGmfR6Z+9ueN3k5cO88ve2Hj3t/H1ukd0PFK4yd6JyMibuAZDThN38D0TWDN8UoumoOpmBpfwcXl1qkTF83+t/FWVbQqWE6+XRCKWoGCFsEQE5TPm5kv5jJHxxiDCMwNpxRzWXKg/fiKUTlZY3UGUMTAj+aaB0xdOUGUkilE7FWQkrZ9Hg8O3wMkLVOHTthHyYFsKbbl6BVU36LjLrpuR+UFcQvx6704L0alZ0Z7rO/Sdf9ge7/dodyJD+y+GArBCeJu4yoR8vyzQqcgBhGkm7WdQPXRiC219Uq62dBsysoSrbN8PKW1sZwvVrTbac6CmWCNFx3eam6ZWDU0tF1Q9Xqt5IRGqeWy6l//cE7VS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v7rcax8MeZpb2SEiC6XlXJ+FLzcAfJCdjwRl/h2f6pNBA+xjqRnFBNrGQt9h?=
 =?us-ascii?Q?6SztXCTcSMqIu6rxtSsTu91WlzYMMt93TSsNauVYwOvi8NhA2Tq5UyHRYm94?=
 =?us-ascii?Q?PjZ92sSocIfEL/GB8Bj3U+DTCUwaQe2wjSD01wE4l3Plu+03vz0oiFprLIFN?=
 =?us-ascii?Q?iDCHj086Sgg1frU75/JONjK3C54dC/L3Dg9avYUhqcjGe8YDPnyTSnVgmId3?=
 =?us-ascii?Q?kxC+17oED69jYjCJAfRguzrFdp5Um0lHkl9dzjMIP+uSuvLCZ4Yizu37Oviy?=
 =?us-ascii?Q?ZXW0qXhkn4UzZ7fhumU0x/C867+jth8W2kDw2sXNnhKgwAQJ/HCxeu01D+e7?=
 =?us-ascii?Q?xQNHAx+V3DcjVruzA6J1lZpY6djGsgbEfFb/G8htgGU9LZM/PfBtNtrQzNHt?=
 =?us-ascii?Q?YZTlyN1mZlc0CwgK0oQTMJruUqSKbp+cDcDISwyXy/99aIR4wABhO0C/I/XO?=
 =?us-ascii?Q?njPqSX78hYBfXuzEUeQovy7em50e03rU7hYPN0vWsDF4hDBy/3GxnnMsHUen?=
 =?us-ascii?Q?62Qg1lLZQK7Sen4hVWRjgf7oN+DjigDOZBHDFuaQHlpd+jrguypYBmkIGKN/?=
 =?us-ascii?Q?y6zAjyhN6iiLqMzTlMMt0CnWzhB6QGC6zjvucOxaobZTjx8bxJ2dMRNHuPPK?=
 =?us-ascii?Q?aNU7YFXR8cFvU9q5KAECGFjtsb2XNNvpGzP0uYPc/UDi+FO0T8PJb+A6qXnJ?=
 =?us-ascii?Q?K4mlJEfO+ETXJOr2Bx4+B7iOLq2P6eA4JbV1R5/cU1HYlHswcIxsvmN6N7y3?=
 =?us-ascii?Q?q8wNUd5YOD3nv0cbrfw36PzPfplhn21S7uW2u93xV5UwWuGxFrFVFkSUfjbr?=
 =?us-ascii?Q?1ovzO4T1ZiO1cWcTx2XHkWsBB028wjpCPzKUma+Ttno8qGuZIAQc+g4N/PEA?=
 =?us-ascii?Q?nZDSBhjuWGNzR1PW8l7/0A3YWhEZHP8emEEnmYzHBCnrMi7SnbDPTPHPwZ4S?=
 =?us-ascii?Q?/I9J0xZBrkymKVVuBVcCt1xPEfnlJebPPRiIiCoQwjq5kkzbG3fdCk4qgMJU?=
 =?us-ascii?Q?l+FJFKbwXaQKbtjWJlQdn/hwJ6OMuer7uepGLjs7++TsLm/OIfY4fJgd1Ct9?=
 =?us-ascii?Q?F7B9bMJEbhQFdzgrLnLC9i4XoaWuRHjc9VHkSj2I0cucB2oOmG6zHvojiC9W?=
 =?us-ascii?Q?49Hs/uF6mV7bGla/Z07ofZRlk4iiEwJ2CznWOle5r+8fTilXHrttMna3fHlZ?=
 =?us-ascii?Q?toQjbSq77ByOgiNaax+O6Ja/mj9Am+J/oxS1mRinTsfN/qR8kcapQzp4dNFc?=
 =?us-ascii?Q?KtM/hNHSJni2+/rv6eggoejzeF7WusaE1g73dU9iYRYznbakfmTrDLTyqmmr?=
 =?us-ascii?Q?xctrEjSrowCRTsd9jNeYL1wGYo2F/bZhV24TeC9WbDo9XZk5qVv2O592+vfX?=
 =?us-ascii?Q?Uv4IiQgr96QDV417pK9d3t+xPK/XJlbsHM+dJ3LrpMdLoX8E8mRKkKsyQ6UB?=
 =?us-ascii?Q?l/CIyXEuiDqIBMLZnPW2Hd6tyxi65LBkMuD/WHR17IAUqQ+Ks/9jX7I5m2nQ?=
 =?us-ascii?Q?joNwyL8UF4MqVGSUFtA5UiLu32NSOVQC5GpcMzKno+DZQTaY1EV2X/oeyR4b?=
 =?us-ascii?Q?WA/OStKRRwIasC0YqR0M4FoTZifFmcTDohKKuDexWOnDKOxCESyoXFUM/40N?=
 =?us-ascii?Q?99CcpiiMHRFMZUdQ8SpwoInzkY1i10JEsOeR5ZYpS0QEOl+QSToLzy+YQP+l?=
 =?us-ascii?Q?iRyeZ8i62vAMz1IcOkLTthQeNOiJaQduTAMAYG42l9ZjqS5ApPvqpVd/9/tC?=
 =?us-ascii?Q?zOhfXZ6KAbAzwGqEdzl7yJI1TCxN5Mg=3D?=
X-Exchange-RoutingPolicyChecked: lbNkxUMHSmPoNr8pGDB391IjeKhfENBLdYOVJKt0W60qte4Lmt8oE9mVgltj3bpTeiSaJq6hhbmrB1SZpth2xbFJZFN2+96nuZrvWSweUYFmj1TLLZcPns1P8X4wcLdZqyDi/eg5ki6o8dtUyGp4js8SSjpJ/EtioO1K/vLN5wiJ9Ezei2ke1YN2RjauZLEE+LspEKJ+VsAmak0A+kZrgwNu2YdAlIELBbTv8sSWTiip6hUU7OU2tMey4a3k+XuPnkHu7ao8e+dhBFLaGYUF15IjvQDHcsSGgB0COJzDuCDlmeQQX5/6MzGNuRLuHHVy7HfzKjUOrM6e+Ol26dhswQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GqSb6tLj3MRySi+6V4CfO7OVZ7mi2WjYYTqPDEdDSwxcUO9rR2DSbuK8+QEcP2CbwgH3qqddWR64sW0iu1C/+RHukU4TAOlEfLv7wJ4hA0xz6yZA7gEJQOlscm7z9X2Yv8V/5OA0GJFm2qvI6muD7Eug4MZdUE9Hjm/SISx0knRjqM3QPFIYpD9ubc12xyDb+bBY+AQDHMcbzRz/SACF/5nEc/D6xxl01D7uSWxXZlYu/Rn2wJhdFN1JpFIlkWohEdDjUfPIBwfNVNj4+K/8nEgyQB+yORIqSUEtv8J5QiEkaNeYpNog+VNDzHQAnTPpBET39EgDdTSL9F3bOvCQHxOTVbKtRuFLPxX0X1Nl6Ls5jUbwSxB6xso7GZSW297Cs4Sy9vAuHAHUy3SL5ecNeOcMpDeEe1FM/AlpOYvMQLtlNkB39wyWzNl6ZjM9yZy39LQ9gCno3QwgUbRMelLoKq/rETxHDW0iP26G4XEVSxSq4HBMLzaw9Ia55/s4BJSPBgZh/xcYzGLOPHBY/wn7eGfVVoCLc6k+QhOuYXHEsbo77/t8Xn6gq+x3jY/3xZsfGXbTM0SlKD06SYUmn1jKNIxiLHhRVXfFM6KoI7mz/Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8778ee08-5c43-44ce-6f2c-08dee141499b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:05.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjK7/5rLtBDClUoWghM9eqWaj8ISwzyGIWDUalYoqNy+nF4nei0qnwB+aX2HeS6wzf4F0g04L72l4zzM6I+RHxYxFq/qc7qUhVkm+7efZLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140005
X-Proofpoint-GUID: yikrcSwnttDGD2WBcT2ml68GN5oUmR6E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX7FAVzy8uOpeN
 mFzC6BnCA4hyk3TRae6e8bNtHFi7lZ+Ai+/Js4IjJo6Qr/VOC+w9apdTdiX9U+N05/x4Nb1K9Uw
 7SqSOzeF+Z3e1FvB2lyaec4rOvLZ3djX3hKds+OasPGqtmCqHlU7
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a5586d3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=p7GVx6YdatGSdFStzZwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221
X-Proofpoint-ORIG-GUID: yikrcSwnttDGD2WBcT2ml68GN5oUmR6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX4RINmRyfcnOH
 n51Pxk0UtWloAalg91ieR6FvH9bB5q5EBTzFCOxzoM7vkE+ZTyUrZCjYRv3LM5N8otkYRoFH0/7
 Wj2+a6etDmY/e1qIJ6fiB+0eVzRWEUX4oPkX9PRYr/vJKC/ee4ngD8DVEqFiggyahwUsITf6zxj
 DsfGLpfkWz9OWOlibt2wf4Dqmm0t7zlui1qmVWP2aFGNaip29QmvPBhaEj4qPoU4PHppijQWoUQ
 96Q9/TDl1JLy6FJMrOydI6AixTnfAU76cps+rsEA43VTqvkZzIMnHES33bXv9FFtjFUUiFg4bR7
 /ocT61ItGxaq+OUzEqfAnNed34hCIK+2oBoNeMTpSUxpwS2W+QrR+NZmZCE3zoKV9KG9MCkny1O
 QxpZOVt3HK20yj2PGU+9iAwJPoHZ269JTNAojleqTXp+wB/yweKo5DwX4CkemUOrQx7/0FoPg2o
 5l9Aqn/7MIE/cyxF5dDNFLa/j1vyVNZxFZ0RYclQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174612_236748_62347E53 
X-CRM114-Status: GOOD (  15.79  )
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

This allows an extension to request that only the head page of a
compound page be included in the dump.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extension.c    | 2 +-
 extension.h    | 7 ++++---
 makedumpfile.c | 9 +++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/extension.c b/extension.c
index 9b29f0c..a7360d0 100644
--- a/extension.c
+++ b/extension.c
@@ -314,7 +314,7 @@ int run_extension_callback(unsigned long pfn, const void *pcache, const struct p
 	for (int i = 0; i < handle_cbs_len; i++) {
 		if (handle_cbs[i]->cb) {
 			result = handle_cbs[i]->cb(pfn, pcache, inf);
-			if (result == PG_INCLUDE) {
+			if (result == PG_INCLUDE || result == PG_INCLUDE_HEAD) {
 				ret = result;
 				goto out;
 			} else if (result == PG_EXCLUDE) {
diff --git a/extension.h b/extension.h
index 22af9a6..3edfbeb 100644
--- a/extension.h
+++ b/extension.h
@@ -4,9 +4,10 @@
 
 struct pginfo;
 enum {
-	PG_INCLUDE,	// Exntesion will keep the page
-	PG_EXCLUDE,	// Exntesion will discard the page
-	PG_UNDECID,	// Exntesion makes no decision
+	PG_INCLUDE,		// Extension will keep the full page
+	PG_INCLUDE_HEAD,	// Extension will keep just the head page
+	PG_EXCLUDE,		// Extension will discard the full page
+	PG_UNDECID,		// Extension makes no decision
 };
 int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i);
 void init_extensions(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index f277360..69abb17 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6667,6 +6667,15 @@ check_order:
 			 * retained by an extension. */
 			num_extension_retained += nr_pages;
 			continue;
+		} else if (filter_pg == PG_INCLUDE_HEAD) {
+			num_extension_retained += 1;
+			if (nr_pages == 1)
+				continue;
+
+			/* FALL THROUGH and exclude tail pages */
+			pfn++;
+			mem_map += SIZE(page);
+			nr_pages--;
 		}
 
 		/*
-- 
2.47.3


