Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77398C5CFC1
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YEmsvC46BpHK4SwRw6QXjZ4AWqaxscJrhDsoHd3ooWA=; b=W+a377w+05J5/7sOiO+Fs4uvNi
	dzylJ+5QDAe7Eh9eZumQARl5NE5qi9f5C5rZLg96wXtO9sZdGevuwYVvHIDzouQMx2B62wktFLjI4
	kfEormV0rIavKA9XAx3EQjiMcgYQEazRFikFKVGh+cH7/jMt9C6e6lKI0u3wqcfvFvzEL4r58t4Vt
	DFdN3iM6mn67eJ09dVegyAg8IEl350POkAS1I7qScRmSmXbaTEYYBSQ0B7WwGTPoMxNVkUb78ctmE
	Ynwqh9sCW6eQJ4ozLIBLynm0rof7tfiv6gPfLE9l6h7hmbVxp3aSc+fJXRgzjAUn68grNJ/Mo1mIK
	dAywHfiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuqma-00000002dOB-13jg;
	Fri, 14 Aug 2026 12:13:08 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuqmS-00000002dNA-1Let
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 12:13:04 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbp433337081;
	Fri, 14 Aug 2026 05:11:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YEmsvC46BpHK4SwRw6QXjZ4AWqaxscJrhDsoHd3ooWA=; b=
	rmbXntDFtJscJNdyiAU5w3g79FUpC4IuiGThrNRJysu6ovc33apWfvXrd51R3z4N
	4QG976UBvEnjcjejL2itdnnpKSdvp/lgpm6wbPGSPCfZPlF9m47yKXQ8SiGdZ4Kb
	A3ZAglcTilGI1xZlYy7WZBJnAJFIS/xIVBt+4nrW9WlkZsyCyvxGsFqFU3o1pmzK
	A7RwlroPkSSVTtHZDXhL012DRF8H2H6i4A9neEkwM9ROpvipaaLaXSfT1nwTdgA3
	S7L+jhixsUxwNtoYaOWBm2Pb30Y06A/GLFHrBHAr7AXCcNZS6/TIYRq421j9kJaB
	ycKu5/b3YFRfejxglYf9+A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021136.outbound.protection.outlook.com [52.101.57.136])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fysggf37c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 05:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNb15lhxxTP3c0Jes6sdSXPuD3QUVEJ7sPCMnscRlNxiqVqaUksF1u1p8/xm0SIa318k6PNx8WL4K28uaRUBeYz5Y9NZwaJsWcB198YyQgpH5vX3sgFMchckat/a9XXxorA1NANEq2MIaguz3OhPZ7EoW537rl0pa0zwU50Zp5C3ke8qn7gRIjPMRdUAc3wYP45t3BNFsfEXjYrx11xKDFMl4u6oP2eHaBUknp7FjakVJhG8F/PLLbXaMsB/xZ8oReSXJUkmBwU/Ma5VomhXSQ1jiDuu/mShqJrIYwk2asIFSfluItcsfHqzZZFFbHqKtC+V0QLhhSej/ruMJRXxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEmsvC46BpHK4SwRw6QXjZ4AWqaxscJrhDsoHd3ooWA=;
 b=YEJXltbdvNQLQaypQCrPrupbB0i3ywsSWkGn+YVZ20FgY7agNiA2wFrWFa/m0RTT250b6wyusjLPgxD/pWFaJefhKwFoZcteo3VlGVaLXnm1jh1bUovFRhuZ8r8lPJP1AurROnzsNE8cXE0AYfC5xEc7ux/ba+ivFshbIltmau4422kgj+dBJ8TWkr1AtFIj43hlYSijoSOL5KO/T7tuYHEKuySgWjzRAkBBUZiU9+aEiItJ9Pvd8zhkQMyZS+x4IugDYsaTkO4Nj8A0o/w0Wbl8I1cdm4iZ2ZMa3OhTZ4JiCzRPg+H1NXxmBhCyFM/LtoqZMdEF3LnYVU0joTtofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by EAYPR11MB9948.namprd11.prod.outlook.com (2603:10b6:303:2d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 12:11:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 12:11:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ruanjinjie@huawei.com
Cc: x86@kernel.org, kexec@lists.infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, bhe@redhat.com, hbathini@linux.ibm.com,
        eric.devolder@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Fri, 14 Aug 2026 15:11:48 +0300
Message-ID: <20260814121148.250162-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <56cd995e-d5d2-4779-9dd5-f85948876205@huawei.com>
References: <56cd995e-d5d2-4779-9dd5-f85948876205@huawei.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|EAYPR11MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: 54281c08-0a44-407e-0d8c-08def9fd35f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|52116014|366016|23010399003|1800799024|11063799006|22082099003|18002099003|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: XUJKX+0o1gPByK6O3+3TN4rhdjov9Q+BlaKIhjKUrDAvD8P2O+XugJzS7LcSiUsfpb+rHYGEa35dIaM8O52/OYQ/mhjEZ9XNHr9Rgbv2i8ft9aUdp8j+0UqEqgNZi/+acpkgXRC2EvR9FVuvV5sUUX3ALCr2Mu05pvnFczO//bl+suZ1tIbeVPLixLPEAcxcBFz4DPart/TsnN+3RlmIezMgWFBtQnOBiTfI3GmF2Zlxnqa7vIpR4HRabEFptONiBo+FfsElR/yTdv805dZ9foEHND+jg7prFYNjkoPXjQsDurS4JT01NQLHTzeAuLzcXuTu+adDACteXVwfZ5CAEIEvCqHFHLhrkJhW702BIEc3zj5Nfgm3GqOmy6mvkjSjoVvk30dKO7gHdPHcQh3Sk9NGVyMnfdZYWYK6WXdcpflJIva//UTiN4wd9aw26+C0MQTYesDvkInYfzJRPqtKh+UQuOk9ffvfzzBOkvnixCODZJtr6CubNckN8Sr2rkIbdMXntx1zQfyawXeI+I+KJuiYuuOxgCofcj0OD7bGT2jtZjK1TxSFQS7e+wo4l48G5F2vSVEBUwEcF1kR3y9+TTOThX6/HWmZ08BpCKcCvQU+byXsq9W+fWEBVdwfWwHpUgbZU+bVkQ9Y46hXshSdBKMyHxrbNpNt9vGs/9KfPrZ/aZ9j5fcuW4m9FEX7Rk1914faGvDfrMNiKMyfErI1+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKrxvShSSzYZyrhrXmB/X+rnh79bNaGoaiiumUwOlvxDfqkhliSnzKGLGn+F?=
 =?us-ascii?Q?/n+7861up0RLQmPhoZA+5I6XpTtQQaDwgmTw5owy95TV2dm/s7z1yXi3Go+J?=
 =?us-ascii?Q?JZ55EISGbAM7ce1rs3/3DCFwTSwlMm91ewSDEA/CXZfyvNfYxk3q9QLDNJth?=
 =?us-ascii?Q?8YS64Y/zTlzoqEXJPtwEQ8OFS0sstPf6mcCgxJ0OpGFGSuPziQ2j4p1Qb5fZ?=
 =?us-ascii?Q?WfVgFKQbF8qtmDfPio6E3Q+sDKGMKZKZb2gjZ24Yz/d/XwB0iEPvxRTzpIhl?=
 =?us-ascii?Q?dkR9JZ/q0SB1A3l3fnxvdW8EU4czg+5fDHeNslyaP7WHnory+8r80urG7qFH?=
 =?us-ascii?Q?gNJiPnrxHsem2/Jp0RHJiyzPWNAi+1Q9CoDuLS/sekUVWuehNauHd9LJtrjD?=
 =?us-ascii?Q?xrR1yrb47iwGW3rtJHYGI9wGl6JUzHzRhpAA8ZUTdZMBDDPUDiBYqh6j8rDG?=
 =?us-ascii?Q?iKFUERMcAOfTvACQOuCyyxiC5mQZORZ8URrEBa7Hf+/yQO1nCbG8CW65rZy6?=
 =?us-ascii?Q?HATf55B0J9jEtPhiuSmVU5a7Bp2s/TgLX5SynMypxkg/DdGmhfLKQQ1sG/8c?=
 =?us-ascii?Q?jycD2mlgfUqo5Wd0iJp0vs2E1TfDMXcFkZBaeub2rw3crGedLqDSPHkarloP?=
 =?us-ascii?Q?OBcVYOZW8lJdmIGrwSQjIiNlUZpka61UXOq0UitcFWxoBR081V0BeY5Vqthu?=
 =?us-ascii?Q?FaISkF2nJZ2mbKlXAf6oKCOzSO0Poq9BOSUNCsS4KFLsNyIFGJ0y9FkIrAVz?=
 =?us-ascii?Q?tYh1K+QUJmY+Zx3wSeUDH8JGhZaPsNbG3F7p1sU0Wl8yoWg5zIKwWcG4aGXO?=
 =?us-ascii?Q?HtSXNyj+S0UMSlNz0CSDI9u/RWHNAoOClAYtYAq9MAprOH4tqe/AYIFJCiVf?=
 =?us-ascii?Q?mJKEzKKq4va/giWGZSwq6n7bycj9WEjoxAO8wKpkMZPpP0W19M8BtJM7Ot5D?=
 =?us-ascii?Q?L5cfOnFxwa8DtdMIbulX3Tso8Su1hw3RdIQOQuyBiZhb9172+WRHnRaefukr?=
 =?us-ascii?Q?pea6C4zkOUPEMSdYqXFiDYVSzj1rT+p6QAQ1He1ccVgch6mv7bQkwMTXMrjt?=
 =?us-ascii?Q?OM5U5mZZODKeVOn2D0DmQVbmb1XRPTgZg2Z/KjfLH15C/Gf7HngpipILO7zR?=
 =?us-ascii?Q?YtKxYlpsYk24fJ74LJVfsJ+YphTt/g+NBqe4AjbhprI+9YJqMa9zh9X+vET/?=
 =?us-ascii?Q?DajzqYyFfCZqwztTFc1fY7g+3CbwbKO7rLNIGLjyYx2CfUg1CCiPScgfXzzr?=
 =?us-ascii?Q?Xez6BUR0OpKOC6jTGvH9uUtjufQd/jL908LgoLrLJ/dNagPT9ZIL6e5WLDhQ?=
 =?us-ascii?Q?i8aD3TR4u6R3873p40zKTGpUbdQIRBl34ITntUvrIk4GmPvWxdg1NqfHKksY?=
 =?us-ascii?Q?hAugfDF1OKfTTzxj3JvkcP6nGsifX3g/o8+GyBOCTdwWAGGoUYenqGbPxFHH?=
 =?us-ascii?Q?QJk8Ic5BjC0F6xNXfHhj52bfmPFz/HbRsDr/BIPw+f95fagW9lZ+ZEc2K/vz?=
 =?us-ascii?Q?Ty0Xxr1RraO7MBUPq4a3wkiaE6wZrpt10yjeyKhSGuTOkiudehhjyb4aFK5L?=
 =?us-ascii?Q?GCK6YHeRG2fRmy32xinMEPBg05JPkAjVyn4JHUkc0YHs1xCUxJcWHjEn7KRw?=
 =?us-ascii?Q?3ctbG4brSZ7mc0OQfHatlNEYO7dD/gLzKqljtHZmZya4/f//5wxrniYZCSfE?=
 =?us-ascii?Q?s/h2ktQOQXYhXf5Lfm58RPhaQznaDhwYYBX0HSyd2LiBZ6N8rPbyijwylFbz?=
 =?us-ascii?Q?HMA1K53CL8Q9daUKwL1yVdrycZ7AkW4=3D?=
X-Exchange-RoutingPolicyChecked: OuuSZHOcYpWs1CBIHGdQuNKiX6nGWMfHI6JXJTNoAVMTsq5vU1aCOwpGClanPiwJm9jONU5GtFnZaS3K/KZBvO/oxTL5EfgiSuwPAfMWRNF69xU1clVqEoP3Fa1L9St1OHpCKdr8yNBkKILmdpUbGj4yzsRHDqUgcYn99ehgP+KhU7mpMMOAswPTb8ReXLu7VP3H+aZjQyj7cbrMx/+1HCQKPe/GLMAvGzmjw6rhQaBBP3Jrh1yghzN9R5P9mn3w0uHeeszEQuGVYnjy4dRqOwCeSfQAsvuYhCkeBhbzl4UCcLT/pQ/WKWUXmyeQwqvSccwz99vkyLxfyrnaLMAI6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54281c08-0a44-407e-0d8c-08def9fd35f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:11:47.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdY3uGDjYssZ4gLMj3dOonb6G/OFUNnRhbOHRcfvv02NY8bHSiKIR5RDKvdpiTrnVhT/bVxd4CnCfMzNsCZkUb/EOUPKTUiscpBTv3tsLW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9948
X-Proofpoint-GUID: -s8v4SV7wKb4DUlkwvSQRjF1_ujc7IAy
X-Authority-Analysis: v=2.4 cv=fr3sol4f c=1 sm=1 tr=0 ts=6a7f0608 cx=c_pps
 a=CD5Oxrp/7hNmC2JdByD5IA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=i0EeH86SAAAA:8
 a=7048XM8uD6TGIRSs7V8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MyBTYWx0ZWRfX7w3Nc2AaZZcu
 wh3Z+Qu/YTschPmFgZMcdi29af0htYtCqlGKf2iCPhkKLx9RCB/ZX7LLpwMuMADodDdtpuT0fEV
 Fpc5PMujpO6Nh54pHAWIVNeOwrVMqv+gO4N2DWhbmkUv4eaNvrjIb9YbgGapJ5vJ4zq0HaTuMRf
 6GcQtwK2pVUrMQTZ3kVFfgiMwtmTu4cJvusNy5oAQQ5i8sqJxeNfeTeN4F2RMm6rkPeSVdmfMGm
 LsBt+13uzwSBhNvronmOGPjdgHU10pa06bYnedGQly3YX1uR9pR9mlIK/55pkxtU0jrU2Ke/sOI
 4d94djL8kA5qR4RmGWAOK+97fNlqBg0OpMK04gXVgrcZr8xfoLAn9yh7Zb117tE36uxxbzOb6Qb
 xBCnu14AnqUIa4mhWST1MBP04fupOp0CPVhmNkxZ8na033Z4hfMoOSS7aHKmqi35mc0V6Jbujha
 2dVUIiwxmehVJkw0VEg==
X-Proofpoint-ORIG-GUID: -s8v4SV7wKb4DUlkwvSQRjF1_ujc7IAy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MyBTYWx0ZWRfX6jt7yIEdJMcN
 dDOI2meTNxkoF+cmE2Zos2Cbf56ZGQa96gdm5rUh12VYWKnn3D7pM4AXxTsG6NOJiMkCuesBedp
 fvVZVtcXtTqtzyjkTEQdOo05nv+0sK1d6jHVwvjC1Zhuzzv/8KC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_051300_402892_9D717F3D 
X-CRM114-Status: GOOD (  13.08  )
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

On Fri, 14 Aug 2026 10:05:59 +0800, Jinjie Ruan wrote:
> Could we just use num_possible_cpus()?
>
> Either way, I think it's okay.
>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

Thanks for the review!

We could -- num_possible_cpus() is fixed after boot and bounded by
CONFIG_NR_CPUS, so it would give an exact (and slightly tighter)
reservation, and it matches what crash_prepare_elf64_headers() actually
iterates over (for_each_possible_cpu()).

I kept CONFIG_NR_CPUS on purpose, though:

  - It is the minimal fix for a Fixes:-tagged, stable-bound bug, and it
    just swaps the wrong compile-time constant (CONFIG_NR_CPUS_DEFAULT)
    for the correct compile-time upper bound (CONFIG_NR_CPUS), which
    keeps the change trivial to reason about and to backport.

  - It keeps the reservation expression homogeneous: in both branches
    the terms (2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES) are
    all compile-time constants; mixing in a runtime value would be
    inconsistent with the neighbouring CRASH_MAX_MEMORY_RANGES term,
    which is also a compile-time bound rather than the actual number of
    memory ranges.

If you'd prefer the num_possible_cpus() variant I am happy to respin,
but otherwise I will keep v1 as-is and carry your Reviewed-by.

Thanks,
Ionut

