Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432C3C5DF94
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h21VkAGZMP/1om2arl4En06T9IBzQRIZYdwAia9quKs=; b=2SDlFmX6a8i7owuT6LT9QvuxIi
	bGiH7h/8YvlkpkoNgoxoZjFUkTNN2upXRxkTnEI+FZ4JSOKH1kN2zB4dsszGuD/axvXNpmUtEV+Si
	q/Mo2Q6TBf/2TXi4bVQ9ihSOg1Dm6ye0uINdGfL5RzKhl2wUgorhNecNbngrSVHuFh8v7D1iEZjHj
	rGVncKukLJz+gei4O6cwJHJFXPIDd3YXeY7v09glBvpDZJLQvIDP4OJemiK2bj8cPMqZ61EZMlpOD
	Us/bSBNeUFBiEsDPPXUxY648j5fNE0iGOrlL2JFTrSdF+qQ6sZrqia0FmISLlGq/RURORTrEL6hLX
	Lg6pP4NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylwx-00000000Jy4-1B3u;
	Tue, 25 Aug 2026 07:52:03 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylws-00000000JxJ-3wrj
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 07:52:02 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2Uqmd458899;
	Tue, 25 Aug 2026 00:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=h21VkAGZMP/1om2arl4En06T9IBzQRIZYdwAia9quKs=; b=
	OSlwPrdCANyNq11PRm6Hmov/3O7zqTf/F3L5ind3sgeDfk7BrLguC/c4QmQv0iDV
	RqqOLWeQk/9+JfhnY4c4wKnQPnap+Ur1opDD7wrjpZd0bac52Iko3V+QFpbwvWHj
	jWIOpp1cIe4c05xDpcTaK72dC6FAOZMBswtw63ZkFMbTnoswv38OodigyxnQXKRK
	23mQ+Z2tXx6s1XFYYtjdZ3ojo6zH/UZgo1E5LsB1YULOfOM8nGE0MF9moeyMQe8a
	jBFKxkWF3n7tyzMttwcFT+swCLt8T1hm/dr316W5Cj1JHgJkUPKLNmnkscdKWFer
	6h/N6b6IwIxKnAMl1lcGUg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020104.outbound.protection.outlook.com [52.101.46.104])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7b9gky6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 00:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEQbp0Xu6wYQ12YuZJvW5nD6slRbEGWMZW5n/iE01iYigHCl3sIiv0Syggv5wK0e2V73OJzWG0QzClP6ETWJyPDXd3YjJaBw3jSiPFwmEYHre1savAdRaV3V4y0SN6NmPOCfhmkfgNbS3KGYPeNgoz4OVP5zSWO05Zxhs7hktAkPLGr/Fu6/qBWtgzCJufRMjFaNgh7vGTOklBwBGDBvdsD9FxiHPOTLWKtuzHjnws57JWHDOgcPzsLEkwJj98ManrYs2ZEk1QMpcQmrC8iYySTrcJZ/K+FmERkNu4sfNjW3jIAxWg9FRe9TJST+t8f+wb8iyKGDm6pZfhea86eRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h21VkAGZMP/1om2arl4En06T9IBzQRIZYdwAia9quKs=;
 b=XS/1BIOvsDzbRqn3A/yCOHPZlvjwcXl7uuzpa3ePt4Ey5Ls0Zzgj57IVq3qXlKMr+m3J/PzA4JGgnwDumfUtkNUSegTdHYHX6hJ8peB6Cii+72J7t20/fS3gkHTnLTBZ7hP+MsegddsAJnTicWBGnNTX2DjDEDIEByvVMsZ5j1cQ3F7EotnX+wBhJoLT08OgJNoksc5brYXkzWU+70Q3ZqUUaUykQe5AMonZkXdpZEUa8AQx1lHdQyYNXV6vesEz093kvVdFxm5nDNb8nJNaF4npisXGzuLeU/oz4pdBqzaEyT6NWXY0qZymMpkDg06JQ9ichQ+U4LfMpm+8Nx8jbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:51:04 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:51:04 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Tue, 25 Aug 2026 10:50:42 +0300
Message-ID: <20260825075043.42041-2-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6be61619-adc1-440d-f791-08df027d9d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|52116014|376014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +x9CtpMN6uM0b/3gdrf8xQs0/Sb7hXDXmEChTxYKA3GvuX/+7GvZYvzTFD2SM5vJWD+dCe9vv3Y3+oUEP6ZS+slHb8Acky8s7qD0ulN7jm9DRhPTM+ID9wG82yUCV9gQ7sUIsoDT2YHBhytvJhMhDkgs6ql4BhalGgcevY0oT5U3c9XuPECYD5eyryt0BG8WsfreMlflMxxuxNEi8wCPTsKcEAuPCBmy/dj0A79ugey3oYqSBMPwDtqHCZx9kfTxuvxTiu7YPKw3pKpGMSiMheLXpob74+EsscxrnaM916NuRQGo0urDL7zpf+hJsw7MFJth/ynRArZwUai3uGhVX+WZo1rYZJJtMZC6qJbqp+s2t7QqR4LP7LwHDj27DNW/Vok4wr70PkIW+01q/EmDOoEXO1ccJRB/nJpVu8zJcP/ZMzCECHe7skv1QcOf7stJu3OdN5Ju8ilt7NJXGQKg3avp/witj73H5+MbFgLg0sFoUInKtJktGzQ8NRTUD9z5ClgbyNDccsUIBvJ3po1Grf06CeZkTMypMoyGOJ+V8UQh7GfOlH7kOfwGaFlzbumITAxA2G1A90SNO3EeM/SRcouYxc2Q9B/7zPq16XBcxbv9Uj9YZ+fgxNmUv7irPn4nAJl1lKvK9gyKnI5Y5flbeoIYh4t2YTQd0bLi7Au3JLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RP6mpnVBpkk9fg5+PQV/ruWEQdktu734kSoaV3fKee936CWmMgX3IGGLxg0d?=
 =?us-ascii?Q?5upxvzhJEC6gkY/Yw5JVIMKXog88ZcCFwTZWwxEKqqQRXqaf+oh5e4ETezmc?=
 =?us-ascii?Q?IAlqErEDNQN7Jhlf+cVVfCz4oxXh9HxGEWZiQfmrmLSri4V72+u5ZKbBvUaZ?=
 =?us-ascii?Q?1En2Lb7iCGaw7QGFyRiCZ9D8CFlIUaJauzJTXGWefD1Mt6uxQogIYZObuhC9?=
 =?us-ascii?Q?LZGsNYfsWgqSP9OEYLU7R212GUUMxTkmFadgLfg7TW4GInnYWll0mYuZg5IQ?=
 =?us-ascii?Q?ZrUOE+Alg+MyrXMCAbKfQbsOquCDayR3EKc3FRi6r5Vsqc6QpkMsDl6b/O5G?=
 =?us-ascii?Q?FV110DbDi7va4eWn7GA2b61JobbWao4ZPjYMfQ57tAJyLT0LC0Y/7rtaeFFd?=
 =?us-ascii?Q?+dYuCHfpVwG9Ca9Ef0QlgWa19xEFMuS3m4In1B3sh7LL86p8ZCMExg+0ypSx?=
 =?us-ascii?Q?upqQ3v7gJrJGv+9lCiefHGDB9wlKEX7z1UdSdGckKvfbegAb7eJ8a/qHWvP+?=
 =?us-ascii?Q?mBu7Ct5Ndvp2GUalRk2aGVnNpPJmkiEAWbqGRCqBcq9OeBvQyfXGU4ZbMF0W?=
 =?us-ascii?Q?/2jFtgsHoY1ZRwmeW5uRFLB/hnMdvFmGqOPKEogbiDxgbPEnDxxFzu1W6mAS?=
 =?us-ascii?Q?Lvbfg/93ZCRErjFbTOWCwTIQnuuARPrEFyQW8gj+lkZzbT7X55AbLo/JDcX1?=
 =?us-ascii?Q?ysBo82nCbYLLWqWD7/00wETxlOPM15gwl02kBBkG0R5yo7X3GIqZw/ldNRpy?=
 =?us-ascii?Q?MziOb5FNxzTTIkJUEObxte/YLPWafT0LUSA1lqOI/7aV7UzomeQiUS6FD8Cz?=
 =?us-ascii?Q?YlWAw6HyZt2pzVjqwpKNTinAs3ghFfw9LW+X8PIUzxPz+B8iDjyx/WHuwmer?=
 =?us-ascii?Q?vSStUO8DcEExm1DgJVm1M2baqnDGB9U4UioIqzTazcMcgINVXGnBKDukzCwo?=
 =?us-ascii?Q?boVL3yFwq7fhSyYdsQQyqy9dckXz2HlX5rX6EoFgQRJu9mBNwXdDqbuL3jVb?=
 =?us-ascii?Q?KV9k68sHUps0ONqfpGVl9uT2XW7dph0pR53E1LzalFyCvnRIawoCem3K2oow?=
 =?us-ascii?Q?aP5sYfC4DLGGTvLFEXy03hLPqHpPxO1Hfj6IgaJ60+COVGfGJHZ8fjcm0qQ8?=
 =?us-ascii?Q?GQGqp4EmbuKGHxR1gWTeZB/zjeFNBBy83UZkV9l6etqMjyRh2p3uz9xZWd3t?=
 =?us-ascii?Q?k+dmre/tw86WWPbrpE4/O0OsX96RtqnhrnJNbIWpYducELmCaSK9bECk1Kz7?=
 =?us-ascii?Q?W8zpPezpBgdMDDBKQeg5lD47hgokwmqn0Gl9ZDyBlknyJ2veXkp30wrxbjXv?=
 =?us-ascii?Q?9wjOpx+cbdXBb7b/ina01yEt7zEyvQY/JI+EgZfFDL9IKqKzZNHoVJdKNikG?=
 =?us-ascii?Q?0Y4e7rA2EdbiTtDHM7LkmnDV8/OZerHT9ltLveDTygYHdyUdVQ2AZ5sIF4je?=
 =?us-ascii?Q?nkaQBRPNZLQglD1fcBR6ehKIBVOSEBe8PU88IpZ19TdmO82el/HAH9HgvP4B?=
 =?us-ascii?Q?9wunJuArjAbE/6SPMhQ8zJ6iShSEV7aQbT4E0vvWbnunYknzdyYlvMQaDSTX?=
 =?us-ascii?Q?9HtpyziX0J0JWnbtqnifU3KzF0NTwzBUhiN3nbYuqXiDkNTfNLpeygXjp4JQ?=
 =?us-ascii?Q?fj+8Lif99BoaQhdAPNEDxmQ1BYSpFW1GbQL8NV0/DO8hIfcen/IFhjKtIZv0?=
 =?us-ascii?Q?pVbAEM09D/N/76ZJotNrjbJEcA+q9OZl82knCMtIiGHICAA3rILcesz2ScQ9?=
 =?us-ascii?Q?mRzs+oCxoK+9Vyzyi+jfyxFihN05LDd5NtPoJQBuzYPIQWVgcaL9IMaqVgeH?=
X-MS-Exchange-AntiSpam-MessageData-1: 7qWdsXvrRe9+2BFaW7mHwNDK/pROSfBVma4=
X-Exchange-RoutingPolicyChecked: KlWx9+OguaMFT1aYxWwojF5IgzOrLKFrRc2g8dLAqyF7TF+KX4SJX9DhCb/dyevVKPrKfhlvnVcbbAZzAH/ZDaEJtK1j4LtAViuj1jDJZQyu/kDULOryEzhSkcCK0K4DZ7lxkD4vLJ/ViLYVspac+bYCnYnRAgcFn7x9tg/qq7rnnIJsOMVEztmTz6RloKZUT+AgetwJwavfTVPUiv0lqOLT05xwUgI3t03c9Rte2UOPNPnuNxNoeXPuxURVP1jv1uQL8VD4hC0A5VAvzi7mk3kCr7NXjCkDpFYQh25im11lWtAxmlMefITWL7fW6gunGgFnTZ6UcdcirBoTSylbnA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be61619-adc1-440d-f791-08df027d9d75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:51:04.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScKY2Fsi7Q/xEho7oi/6qxhTZCrGxGfJtqmxTJrsb0IH+CpAdlESY2ui3+2V5uK55zvvnQOeKFeHI7fuEb2MTzeP73A8wJ8wHiJZENp9Jng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-Proofpoint-ORIG-GUID: qnV3ZPlG_NlukSnbZjP-Ncr0rIeU7Xpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX/iFh6IRDzi3P
 M0f/0U4TpXZYM2RclF2Z7p93nJcmoH0WGgPrQmPpQCNpVs5CgaulqGzWuJxHi0mMDDhHvTOy7BF
 5DYOo0rrBwer6k1S3j/J5oKbCPXVq4RCIBO37ndoWrfT4/UMn6L6UfEAhlxAt97gsH4Ibh4n1u8
 RKxpNADFhF54wSazyZgQO0GWZngCIHixMzn3YvkJ0FNKudLU8jlNRNg3r/BAdUVSpV12x1A0/63
 eWdpDEXQK2df8CpL4Wbo1T6nnxikRqvZNTM7C+eYMhkIpFtg6Od2NufdOI/Adk3eVgr16ha+QiJ
 z01P3ct3ufKUlzQhzQfKyHJ+N0I4AulC7DMnmh5bpQl7XdRgFZsiazk6ozLZo/fMl+eUsedmVCW
 349QxfhVrYFNQFPD4kdTVwFCGTqmwZ0vRlSN4v+YMad6DoM1326hPaLu0swhtSEOp5bLJEVgC6E
 jG91u6CtN+X+y4XFotQ==
X-Authority-Analysis: v=2.4 cv=LtaiDHdc c=1 sm=1 tr=0 ts=6a8d496a cx=c_pps
 a=y/6OeRevqtbd3HODipuDjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=P6zNO2psS7vM0yeUzwoA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-GUID: qnV3ZPlG_NlukSnbZjP-Ncr0rIeU7Xpx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX2Wp3AkKvfhjV
 6ED2x2oKlCFGPTPuidTqOVHVJIAqIr+v5m5Lw+SplTQRv91oehn0XZjMUhbXnE8ufFYA0rQhs05
 D5k6gQ8iVRoz7jR6EG2M0FZr4dVlxyoJwXQyERYQJabOrg3chVRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_005158_986427_34BDCAEA 
X-CRM114-Status: GOOD (  21.34  )
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

kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
even though the classic kexec_load(2) path succeeds on the same machine.

With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
it can be updated in place on CPU/memory hotplug.  On the
!CONFIG_MEMORY_HOTPLUG path, crash_load_segments() sizes that
reservation as:

	ret = crash_prepare_headers(..., &kbuf.bufsz, &pnum);
	...
	pnum += 2 + CONFIG_NR_CPUS_DEFAULT;

The value that lands in @pnum is crash_prepare_headers()'s
@nr_mem_ranges out parameter, i.e. cmem->nr_ranges - the number of
memory ranges only, not a phdr count.  The header that
crash_prepare_elf64_headers() actually builds adds one phdr per
*possible* CPU on top of those ranges:

	nr_phdr = nr_cpus + 1;		/* + vmcoreinfo */
	nr_phdr += mem->nr_ranges;
	nr_phdr++;			/* + kernel text map */

So the reservation covers

	nr_ranges + 2 + CONFIG_NR_CPUS_DEFAULT

phdrs while the buffer holds

	nr_ranges + 2 + num_possible_cpus()

phdrs, and the buffer exceeds the reservation by

	(num_possible_cpus() - CONFIG_NR_CPUS_DEFAULT) * sizeof(Elf64_Phdr)

bytes as soon as num_possible_cpus() grows past CONFIG_NR_CPUS_DEFAULT.
num_possible_cpus() is bounded by CONFIG_NR_CPUS, not by
CONFIG_NR_CPUS_DEFAULT, so this is reachable on any config that raises
CONFIG_NR_CPUS above the arch default without CONFIG_MAXSMP.

crash_prepare_elf64_headers() rounds bufsz up to ELF_CORE_HEADER_ALIGN
and kexec_add_buffer() rounds memsz up to PAGE_SIZE (both 4096), so the
excess is invisible until it outgrows that padding.  Once it does,
sanity_check_segment_list() rejects the image:

	if (image->segment[i].bufsz > image->segment[i].memsz)
		return -EINVAL;

kexec_load(2) is unaffected because user space builds the elfcorehdr
without the hotplug over-allocation.

Observed on a single-socket Xeon 6776P (144 possible CPUs) running a
PREEMPT_RT kernel with:

	# CONFIG_MAXSMP is not set
	# CONFIG_MEMORY_HOTPLUG is not set
	CONFIG_NR_CPUS_RANGE_BEGIN=2
	CONFIG_NR_CPUS_RANGE_END=512
	CONFIG_NR_CPUS_DEFAULT=64
	CONFIG_NR_CPUS=256

At 144 possible CPUs the buffer exceeds the reservation by
(144 - 64) * 56 = 4480 bytes.  That is more than the 4096 bytes of page
padding, so the overflow is guaranteed and kexec -p -s fails with
"kexec_file_load failed: Invalid argument".  Reducing the possible CPU
count to 72 leaves an excess of (72 - 64) * 56 = 448 bytes, which the
page rounding still absorbs, and the load succeeds - confirming the
reservation is the limiting factor.

Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
of num_possible_cpus(), so the reservation always covers the header that
is actually generated.

The CONFIG_MEMORY_HOTPLUG=y path discards @pnum and reserves
2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES phdrs
instead.  With the default CONFIG_CRASH_MAX_MEMORY_RANGES=8192 the
memory range allowance dwarfs the CPU shortfall, so that path does not
fail in practice; it is switched to CONFIG_NR_CPUS as well for
consistency and to stay correct for small CONFIG_CRASH_MAX_MEMORY_RANGES
values.

This does not change the reservation for defconfig-like builds, since
CONFIG_NR_CPUS defaults to CONFIG_NR_CPUS_DEFAULT.  Only configs that
raise CONFIG_NR_CPUS reserve more, and the worst case is bounded by the
top of the range (CONFIG_NR_CPUS=8192 with CONFIG_CPUMASK_OFFSTACK=y),
which is exactly what CONFIG_MAXSMP already reserves today.

Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 arch/x86/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc..e6f23933a6df 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
 	 * maximum CPUs and maximum memory ranges.
 	 */
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
 	else
-		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+		pnum += 2 + CONFIG_NR_CPUS;
 
 	if (pnum < (unsigned long)PN_XNUM) {
 		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
@@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned int sz;
 
 	/* kernel_map, VMCOREINFO and maximum CPUs */
-	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	sz = 2 + CONFIG_NR_CPUS;
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
 	sz *= sizeof(Elf64_Phdr);

base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
-- 
2.55.0


