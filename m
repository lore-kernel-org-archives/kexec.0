Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DF3C61DB6
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IK2tVEXdHC/8PzQA3cP9GhjuJ6Gq5QhfcIartwEmDVs=; b=aV/meXoWc7TAIBM5nSOWNdKJGI
	vaTQ+/s558+lo8F2cKamTMNxTR7YrTe4QlqrQ7ktaNiz4wwAvX38YY4qn2ykqOZuBqqVf/VsIrLH4
	0NdhXR08RfzCDv0laxvcD111/c/Uy9WkZgfZZMjlVQD1HzUS5LSTfkVmpP4XMuAjBfVJLcyiXhqQF
	iCr7G63YC9pohepHRi+7GqfjIWPpebTStVn4LodNcELug4GoypmlqMRNdhn/tw6Dbqm7ibX+/jw6e
	FM4QxB7w/o0eq1vkdOcHxpcuJKELapFc2ofYoL7smfYkQiz2B1fhSDiLtPVN0NkvlBTMQhFFMV8dP
	y28u4yQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylwx-00000000Jxt-0IZJ;
	Tue, 25 Aug 2026 07:52:03 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylwq-00000000Jwq-2A1x
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 07:52:01 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P4GUqo639027;
	Tue, 25 Aug 2026 00:51:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IK2tVEXdHC/8PzQA3cP9GhjuJ6Gq5QhfcIartwEmDVs=; b=
	CviR6DuhGDD3dZDzjFJ2LQMANSSAOAf/TZKzRhOzMmryKAH4t2EM/2r1bOlbuA6e
	Q0c4egqg8nwhOGhe+2KuolqDuHl3GS6UzVu//aUNHUMhAaw+29MBElZBV0wDeBMu
	i+asoUXhStLSH7YQvDZc84UJkxigKDHZ1G5XfoVXlUfNwz6icPQQk3SMimhoE/wN
	CziG1PGWRm/hGeSEnRsFoe5PpOD5R2CkaB8059U+Y+eSjLLmgZteGE2rkik7HpuL
	Vpwhti5KD1y8Dth6gPmFRulCfHRt5TMRW9cL18NUlEej02bhsmkYgbCefmOMbx7K
	gfoo3y99YmFRTv+13TjB8g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020133.outbound.protection.outlook.com [52.101.46.133])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7b9gky6k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 00:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUCj1XVRTyOOWc7tnaHr+3/nYSb9AdVdccjVsD852SXTru4g7Sw6RqZUd7yKzsPQMnbnxBgE5PqkhruIpOTSl0Jl3seHwXXSDOXPuJ/WoOZrtyLhNvDxsZycqy6H3/PFBZQ7+2PmBY9eL2m8xD0zO+VAKlZss4SdScKuVrfN4JhFOlZPzPndCkXOnAdQ5kPutI9uPOAT4ZiQ4vykDdV/kThf0RvyQdRqcJvxnsuFk6WZ4QYCC7G1FWm8NRdW1mUlVbzZkOsNFgjLHYEsMQqm0aBddr9Zr1wtdVvfU2hdXEIg2xqk2UAHAIjCb8SsKPfgXmpQArAK3WNe+9enX1Ogdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK2tVEXdHC/8PzQA3cP9GhjuJ6Gq5QhfcIartwEmDVs=;
 b=m+/QeqnLuYzpErZqND9ETiGH8oSp6IlK/W0/+wgBRVgWaJ8HAPPyK7PAdSdtlHX4IyZPHPtBiefY7Ibx0b1xPdFRvB0iVjMoqH1q6exdHuNomT4pG381BDcCoUdnlb6zIMcvU66y5fv3yjK9UKkYHt+WIGSVkACwItkYIF7zLJaL2yDzFsBXLJ32FHVN7CBofA6hiKn9ghtYTue65h3om8Nq8tQ4puqJXQ2yNTskE/REEM/tcKI9EsYyEJ5yTqB6Tzf7HcF+ETw3IcpGGAhpurXd+c0AXiGdiqPfL821xKJ5VvE6kyY2qTGc7uT44vyLmMuaiIcxUCydR6WMnDn7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:51:09 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:51:09 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing docs
Date: Tue, 25 Aug 2026 10:50:43 +0300
Message-ID: <20260825075043.42041-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825075043.42041-1-ionut.nechita@windriver.com>
References: <20260825075043.42041-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::20) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: f1549a68-34d4-46eb-37ee-08df027da07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|52116014|376014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pf2OgSToDKRVpfOoZ9tDvp2r9BhGuLnk8xF948DRc3AlJNikCIxTXYtlF2b5cDmglehLdtxcsuRjMGKjoQU4Im2q+8/IJ6mrjy+2MDkGjP5XE0rfPofYBY/5WI0JLLuFUpq/7eRZo4XyZ91Gs6uCktRAsdCD8z3r/cju/CfWf7j53LE7+2HfT+4sOwDR0pD8mx69IxryWpxFmpiZW5u/s5xh1Ya57wZ5XXGOolfx2unKINjRCQ9ETkupMjcjSZ4pGDnl54E4oVgBcXeDNSsDy2H3wMGsApwH5qEFPV6zSlimq6MYrh3O4o0tlPmvRZmW7sz+xnd7uqnHkJG3dJ/hG3Rpjd/WbHdVOdZLFOD8dKuhDPzKZPveVxoEVQz2iCIxpuqd8Y+bVfcoCu9LrxNqQvDx1vbWO3jaxPk/zeuaQMHxFQGsZWXwBZmfYH+DAy2LLYrIZ0/6UYHxCqBR+kmmpWcUG+2Iyu1fd8KrTrv1vQfzjyi/h+QlJh6ecx16Gl+PwRK2SDfDEN0wIYeY297X8c0cB2MRVMeBmGLbAH0qNMBladS0vhrm3GqUQ0NKN+m4LvYwJMiMfh1VmjyP3IeReQU3cGvvbdTUwOyh2s3RrbBBdiHehvEJGDhjpdWkrjdepr+bKp4aaCVsUa63s2cg4D159gPlaibHeM9iF10q2yQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6nPWdbz+T1f1wJiC07PpbiD5NWf8NkpUfnqxHOBDmnlM2NUv4el0VZz5Pe8?=
 =?us-ascii?Q?QxJBaCv58/2Rt49uZTbVl/1WM6bFDItycKEizu8H4fkx3oSeWjE3KYfVhDuA?=
 =?us-ascii?Q?l9ONKHpNk54k0qAXKy+8+AzN55fLqEw1GUvhVKE8cyH/TytrGLhpYRXfmdbx?=
 =?us-ascii?Q?Jmr7BZIK8DIZoenbEI+Yb0uwwBffFp5Pf8EhfJiz+i1opUSFLVtcyscQy9ZZ?=
 =?us-ascii?Q?TOY6u5uKOnSLmPOzp8sDWY3bzGfr4LkbLABVgqgLpoKCtuitOHvNAJkU3AOI?=
 =?us-ascii?Q?s0yMVJ4iM+pql1TMXK6TcwF+RCw2a78Do96YU9gkUj+Qy+d+Jk08j3WY1nKG?=
 =?us-ascii?Q?N0PVxvQqpvZP8P37fOh2gxjGOxY7sB7s9o1nyiDGRhiBWXzYmv2A1gx8HmK1?=
 =?us-ascii?Q?exiTnE5CEXg8dDIgLck//BMce+u9e0z8701xVfDWVcEAU/s0jGbKa6O1+92V?=
 =?us-ascii?Q?gIk2tUqLoZwD8/WrvTkmvc7I79rRVlbiKCUrOKZaHLC2j64epHtvYYriEAlq?=
 =?us-ascii?Q?kmMe/Llu/T7aMvoRrVtQLk1NoD250A3Pcm8ciNra037Jf1RBPu1lbz/ZEXeQ?=
 =?us-ascii?Q?iOawWDyXnFMdNZbdtS1gamRrg2HOZ9SXswkZyAKvufgPneN9P8VwM/1BFdD0?=
 =?us-ascii?Q?aUwZWHiAkZUEAN0vSQlqeexDRgi30WnYkx5aJSnJcXJUnlxiMqfvU2uXAQj5?=
 =?us-ascii?Q?CXdtZTnbTpRPa5PRS8QOPyEXQTI15cK7WAB/J9W/7vbpT2hyeyxHBOZkOOk6?=
 =?us-ascii?Q?7bH7dyeds2PP+MSUc5sbyq+1kV3Szonsw2HhPeS6PPqv5P3nZGCkfmj035lV?=
 =?us-ascii?Q?3U7Iupc7sn0khTPLhpZ6K4tvDIYtUMWFdVlvSrjruIjPGGlU3/vZ8590j0vN?=
 =?us-ascii?Q?EWQERgvByB0aK4YmhmAWtv+37IYGPbYdsi61B4UuCZsjNROujHZ5pgD57Di3?=
 =?us-ascii?Q?LnGhJokLtly3ee09gTj2q+CRSpdtDoxRNdr28ePLsb3c9n1n4BLOZxf10x+e?=
 =?us-ascii?Q?FF9T2/6iUsAhHKXHm5n02G6y/MFgWKpWUlCNHVMe0QgAkU2AUuTj9S3DpqyG?=
 =?us-ascii?Q?WoKNtJjhWbXYCmpQ3yeLgcbGqvc+cp4A13B2zfQ0xYioi0RaI3qEwVCs8suS?=
 =?us-ascii?Q?ZK3MBr1+uUWi+oh81r9LS/0xNmBWT8FBOq1yDKYP3BZdBZ3rzSxRURNnSI4N?=
 =?us-ascii?Q?hbK/Ujlz+058STEtrv9UcEeatuDGj4u1vS+KBZDQd+B4PvfX16ijc8SKV7Om?=
 =?us-ascii?Q?pKfHKUO++5oeDLnkCKU7CgwxRc/cIVYjkKNPZcalDdJASVPtFul34zVG722j?=
 =?us-ascii?Q?QZlZhPFeTbsZa2SH7CkT5uPq2eBEAsw+GtANJ1HGbt3j0k3f/KpnjM71zc7z?=
 =?us-ascii?Q?fKxs7RXOcFwpoEoPOORUt1iyfXdR4DqDTrPWYWP9OTQ3eZM3ZJcQStWKnf6I?=
 =?us-ascii?Q?qto3oEPhZj7o+tgH3PlnDXfvNFYdxPa7ScURmgSI2WJpBUSyuns1iNTPvB7H?=
 =?us-ascii?Q?yB6bsvRA4f21odXAvPXBWAyhzBfMoPl5Tp27znHyJo+NXHiNWybOT3WiTCO+?=
 =?us-ascii?Q?iZtUQDqsdEnf/9LofoYYURMLZ20J4lssK9BdS9RZnly95s73jIsLZTyw7ltc?=
 =?us-ascii?Q?SxGF5Mtp5qB4hxxwo+y7w0dEdRyZjLRSt7JOy6oWoQ7uEvSNdF+WezQN5cSy?=
 =?us-ascii?Q?ihyRExyFaqB86bPRkkjyJlGexITYXzaYpBjDcLnfWQvlni43ZUIaWDHkHcK7?=
 =?us-ascii?Q?lsQ0PxvgusMZJCkfHD5Ukf42lFVDcbbq3yw1IcZpHVvxfwFNCpB/nDEaPTat?=
X-MS-Exchange-AntiSpam-MessageData-1: IZJ20uh63KnSpQnywI2fab3iYKbVTujXI9s=
X-Exchange-RoutingPolicyChecked: 1EAmqVqez/nTDfhW056zdOdSeL5G7ze5Bj/nJlxS46PfBGl2jTIIhmNIy552oBD7jXZgAg23d1Zkd3NGDm1fHlSq4f9xjDd7maMJM+hl6Rn9uEVLpgSTNLZD/BdjnBYrJBzwBxZ5S72Zv2a0acXq+IZi+bMGfwHik4vHBqvVLTjpYr9xqfiSq5B90x6lhx5sMgJ6kq4WgI4O8JaLB5HpvTt8SDJOnfIbNLwSdmeMs0H6wL9SYQSZhC0z5xX3zMd+O29Hz8KXTwP6awOt6b8QbMSPk99t28qNv7APYbjhOim55F/1XlTYcN3/dmJAUEhMO6ImcIX3Sdqe8CZSDAAfEA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1549a68-34d4-46eb-37ee-08df027da07a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:51:09.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKHXFDqWIXkg2Lk/rpJkHNbawtGmXGGOnPzf44yvOcTs8zxnR1Jt/EO52iZzwASZXrgHeXkRPFH3L1I6HGBJ9m25g6qGmvkLvatQgvjHV60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-Proofpoint-ORIG-GUID: 0BKN_MnZcKr9dPrcYp1sWpbfz2vtFd0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX7tkbwdX2JySv
 mD4Rduwrejch4Xy8/NUXU+FOF6TOUfNBehR6LL2pNMDbLz3l5cINlYrmzYAXMRU/xh4/6CHkXSD
 r9g7eWnpFRQF4H3jd853HtxriUQKyc5g8EOsj0pKfQhIUi5kofWAyYhtDGN4KHXvTM5zNxQ2EVg
 hUh/+nNs9fTijpLDBl1/E9CKpkrqH8mQglT0tBp0jibvmzGL8OS8w1pweeI/Ih+zpg3Gw7m2r/l
 nHv4Jb9CKZhXknjaYMzYpiJmbC96hfiypJdSTYu5TRKSJrUCN+y0fYsN6qRyy/9cZTCrUiuzlCu
 nhossI50u52othb4A8achdCiWNwfOnGgc5lf3DzobTX8wkAREtBei5cIlZ2t9UcoNf4DMZmOWCU
 VsSrkJZcnrDa9JHzS/COf+Jhd0JALBEp9BlqFXkfkBhVXhwbp8K00Ev/2/NTMUfXyWHZ+TZOH0B
 yztDMynGqp5n0v57DDA==
X-Authority-Analysis: v=2.4 cv=LtaiDHdc c=1 sm=1 tr=0 ts=6a8d4970 cx=c_pps
 a=/64aUU06laRl6xO2iYKDkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=AyFJ6eo5uNYZnhLCzmoA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-GUID: 0BKN_MnZcKr9dPrcYp1sWpbfz2vtFd0b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX3N5oOw3ogwCM
 dkv3lhVagAa93yoIG1qCzKls9VpSvJZX5Yhhk5eDW3hsXwEYC+L09nnULmk2NcMBdIYeI5rt6Ny
 xvfWH+5rjmavpofC1nwJqCcl6Bs5YwaS2SnmVheCLO0MkhW1ZFGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_005156_604191_08852D5A 
X-CRM114-Status: GOOD (  15.16  )
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

The elfcorehdr over-allocation for crash hotplug is now computed from
CONFIG_NR_CPUS rather than CONFIG_NR_CPUS_DEFAULT, but two pieces of
documentation still name the old symbol: the comment above
crash_handle_hotplug_event() and the CRASH_MAX_MEMORY_RANGES help text.

Update both so they describe what the code actually does and do not
mislead people sizing CRASH_MAX_MEMORY_RANGES.

Documentation only, no functional change.

Suggested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
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


