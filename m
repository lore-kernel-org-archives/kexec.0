Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53EBC61DC2
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCG64dwi1MN0yrpnCKz5e49MLtLMFPfFKUlcsavbwek=; b=4GcWL/2Da+0f+MeqXBWLtp3j9v
	eMuOljGvAWfG9noBezGjz+8jVdtNWfa6D5HPWH8sjAFBxJ2r0gmXjdviZZjjcT3eHIUufYXAweZGl
	LHkMwqtNfa3NiUufXGpLEkimomyA5QQhFPH0fm+Eracu56Kfcgp6R153emXsUXUQjsH9sUzz4VfwF
	m+FPlHdb7zOHMKGQmHgjaDmbWKZokyg90vEIyVR5S3XGkBLn4HPRL6hvYak8TBnZWpeWqzF4OPTCT
	HpcIEqmBHqkwL50RkrMSjWChhXfJfuOmBe28xVXSeoSAVcqLSKLj7hlpemnbL388JQEmOymlVsMon
	nXXnRuDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8D8-000000021Hw-2hVX;
	Wed, 26 Aug 2026 07:38:14 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8D1-000000021Gc-2ZrS
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 07:38:12 +0000
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RrDI3455286;
	Wed, 26 Aug 2026 07:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fCG64dwi1MN0yrpnCKz5e49MLtLMFPfFKUlcsavbwek=; b=
	oKmmyztqr712zB5W2CMJfZwZ55oMU1ZUfxyCar/kE2xK3JsnU5ebTrpP2XvFiSFz
	ggpyO0IuGTXtb4btQQ9sxUzytHotrz2FpgtV4+8xksgSGgflXvWqN1Ldw0W4rWMF
	3wlrQEUjKzyiu+GGrFkx+rVSoSjlikTJYmMqowZKHsoVFEKZRK0XSmdvBnFeGcyJ
	4yKM91eofMp4lgLxf0Stxf//cdlqIZz5MHAbxvp1l6Q3gtjvQ4pAjdP2N5tyJltC
	uE7p5P15wjsbGJSP/C2giAx7iLyHuwrlNhX9VZEvUP4+9V6ndTKspSMBjly/u1JT
	gQHAOLuedMh4P/k0Kk2tdg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022132.outbound.protection.outlook.com [52.101.48.132])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7100p9a3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 07:35:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnjvIT3yBOGu/Fi9rdFHAcyAtLUjhelIH6fYlBst0JwCajB3twjtfDcGUPr82xsQjtKyYovz8lPrmwRncHin6W+J/QvAussZW+GD4CyBhsmgO1Pq5qsd3Ao+Sx8P+bUR+AWerk+nFADtEavrRDurEdKM0+L2RkziY/7Fa2XXfGS6xYknIO5OPpWMcrWgFuqgJSvsziASj6wyWMy0PDe6s9ouW4DPwqcmfvq/wBgWGW5l+Hh/bCq68yCSL/k2PmAB45kma1r+CJnC3dwXozzfZJ3rftwD2rkUexMHkwKJ4xtk3zAgXjkurKRjI35LwTi43SK38FOF4PB9urA67Cff0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCG64dwi1MN0yrpnCKz5e49MLtLMFPfFKUlcsavbwek=;
 b=yAl/6oaLsHyurN8NVwgK7wCYnh1I6/NDXBtatf6P3JdoTC0eg6UDj5IjvTH1Bck9x+4qsrBvi808sUfjDuwcIiN+iGYmRGItIHQ/viO1ZYbb5pGKkufcby8jF3wbzV4V31j7Io5pmb2Tsmq/PKrj79ggEtimW2YC3y/hT0b9dBJbLPEu7NfDvNPDmQ+e/GncowUQIUI0bB52kShdPac8Ugx+1/NCfnV5EGtXB5t/KsxBH4Wz6TxYsAdX0CeTFMy6cAfV+4/hAtOVbWion+TY/dcrzwZExZo5Qeg9Q5kvVU+4Lbca4L+vrbJNfJye3oiUz0y+5F+6nVL3GanNEF0Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 07:35:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 07:35:48 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Wed, 26 Aug 2026 10:35:26 +0300
Message-ID: <20260826073527.21487-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826073527.21487-1-ionut.nechita@windriver.com>
References: <20260826073527.21487-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PR11MB872716:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c64f44-c23a-4e84-9fe0-08df0344a5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|10070799003|23010399003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tj2eZmiWI9Drinp4OpDy+zWyX4C6DYhS1VsQe6jeFN3m4L46fylpUQBoXe1JECMWFqtSgmHkPIsUswIFdStZK6qJsPg7hVjsKVdre+bW+WNCz25kA4mf5x+Ipuoalrns8jIVvOZeRa5+RWa2geX/Wn/BqOzRnJz9P6qBK0CpolitonmN8E/nOmQQCBs52MPHLO6wJX9Hzi482Umt7qUkjw4XR6Um314U/fXSi0fupdqkZPz66U2JWZgsmW/4c0aRUj6elsiNhjQc7kFJBj+10mAMto7NiBkPORD8ZB1PFbIGMmOYHZBj8OtKa8zpM0O5df5DkkD1PS7mKJxWcNBTaSm/nTuIRxejUJIHpv5n1A8RoLuQJtWipxiUMwrU09N5THlQqiS85YYnL6BPfJPV2GFQrGQIEwUG2GLigDHVxTcnEFzjwYmMJyVPiAOpaMK89sYyaBTpWgf67/VhEyE+epLmbrepduhamCRsFLVKAulhZK/YzcOdJmfD/X6NPSTAlb9vjY23i30zfgaIQpbif1ZgH5WfplHHFR4O3z3q4j1IY5NMBRWS3GJ685m4qmUOlYMWCgpidYtHuFFlBzkg9/SQ009HqFS9bBpHKcQH85Inna0M2npwiO9g/yaDvUv5JEKNqLJu8xR5pxVKEh/Vf9PWl0Hrsr6ExJ2454qv5d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(10070799003)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bRmjDUsggi6hWoEjS36TkowFy3a1bURwkNOjqDDQajJ4i43E/qQ29ae1YsS?=
 =?us-ascii?Q?EUkHNidKbqFUt8ao8yMEzCCMkVcdytIyRRPj86aJ6+82VzW8qZGNf0Hw7EOR?=
 =?us-ascii?Q?ZIL+DI6i/nOYth45UMG2zRFUVTrlzpV941/pqM99tdlV9pL0PxgTvDsTZ7vK?=
 =?us-ascii?Q?tYq597GUufbBnKg9vMrZJg556CBjeO/NBUzkHbs9cpEipXF2Otir5s08epxa?=
 =?us-ascii?Q?Ox9qFRvOaH38y+BdjI5JpCqF3GDrjg/8Lf+1nLZYNImasNTWP5a6+OLdH4pz?=
 =?us-ascii?Q?JL+NNmEglV2ugLBXfJqffKa+MYNqgbZJBNZfsz77SoyL53AmhXEj5+HqrZ5A?=
 =?us-ascii?Q?6IPAQrrF8ftkGuGVppZ1cDaTaFJlD32oDE4SegLgN0qgfqstjTnHOik2h4tM?=
 =?us-ascii?Q?YwJYR/ykurkSq7zhEjAivjSOQ04fovwqz/DGff12bfZMxOLqx3u/i0fcyMsv?=
 =?us-ascii?Q?P70HmL+qiYw4EsGV8AQohrpW0uaqAQnjlVem3Qv1bLLgatVbbvKoPuGCW1Da?=
 =?us-ascii?Q?6PB8xoa0duA0VXQXRz1DA4QbLPniVJa9dSr0QQytGPQnP1U2A2T/OVU5hgpD?=
 =?us-ascii?Q?ZHebd5E3HMhqNhzDfUBlGb3Z2+5E6DP05jYu1UBDkzLDjFBnduDr7IEPJKXN?=
 =?us-ascii?Q?rsbZphv3gd2/+XrCLe7MvUw5waTCm8IheIbQcMbAjV62l5J2Styjdlv1Gdkf?=
 =?us-ascii?Q?xNjbz8fUZUXsKj+KzpVSMurZ/3zlQb3WvZFESCRILKUvIC/pPZckM5v+Spes?=
 =?us-ascii?Q?gGQ1o+VAKt5MFg4Erhjm06gNi8ul/GbDVgUyWBU/HxucnlwG2LNHGAk9GaU3?=
 =?us-ascii?Q?pWh+14586b0aejQ1GWEiHj+Bt1A9XRVv1FYa2QBy4jlGTVHAJvhJA/EvaYBo?=
 =?us-ascii?Q?3ZrnKWRNyByeZnZ1CD4CJvCo82FgS1IE0Ra9IIf+r/+QmwzZKpHYczt57yNo?=
 =?us-ascii?Q?DDrQUmQedchip1sWORSKVdViNq4NmSF+VYh2N/PGoQjmPdkeyQr3sDT9IjNv?=
 =?us-ascii?Q?MmQU4A0Dr+xPmpT/HuccoFZ05rVR6c9OFrDCMHL15nEViXJQfUPMj5TwLJLF?=
 =?us-ascii?Q?1XBWutgfxMyv4gynhIZTLJNuXps9aQkIcpg5AT2U0+Qkj9ITrn0BucSWZWhq?=
 =?us-ascii?Q?J7Xg2IFO6u/TEq2uowWiPT8zoxw7k2SY6V6VsRrLckS+O2IS1GrTKzRDgLC+?=
 =?us-ascii?Q?s8MkTPo399blZbCje5dp+phlBd9HOSt1vYal7mEfujInO2HmimvS2WrI4Nrz?=
 =?us-ascii?Q?nubKRoCHDWDDZJzyjEokkeRhJ0+gf44R/N+LmrJb/xqBE5jVRrCf1kSVtzXg?=
 =?us-ascii?Q?1VdShmCBrqxDWbAaWGTlQRiskYpiMQDag23yc68cs5bPU2tD97CC01WP7HYJ?=
 =?us-ascii?Q?PFGwQKjcHweYWqYnHcP+GP6OXFvBzdXLeed/kOnlGdKxhNeJM4rkPVHeT3N+?=
 =?us-ascii?Q?AsBi2ark14uE7KdBZWGWLzs8qpm4384K5+quRIxySHQz2jQMUxzhvhRnreRD?=
 =?us-ascii?Q?JzyAia+fyk/DilYzVbhmj6zRZkH7RGxCfunXZhSy139M6PLrKUzleG+leJl4?=
 =?us-ascii?Q?BfCvLVvElaNYpSazNHkXsiZhBI1QyBgo4tJlaH0gVpFYhctp5Twq5GK8HQVc?=
 =?us-ascii?Q?5du0YF22pCFMm6qrEOvNMAP7GPCwh9A7SviuDFqdnzQlKEmfb7McFV5j0ybv?=
 =?us-ascii?Q?z2fzTlog11j8tiR6WOOBn9M/Ssyker4RyNoDZd0TLoIGjGsAyXpplo3JTa/U?=
 =?us-ascii?Q?Ck6dM7Gciw/M4vB7ZC0aigLvIRYpxGDcb3qk/zpn6qQDYl69U6krrv13vkp1?=
X-MS-Exchange-AntiSpam-MessageData-1: MF4BS3kR/AF23XykyqNtHyk2gSLsjSLTHGo=
X-Exchange-RoutingPolicyChecked: SYmEPQHUBQWgNRf7GXhj8BU745Lf1JRj7cFuedOmhP07nPph/WuQ1BMFOE9opdaLABc1FOhGLy9sVq50YbhTGuk42ELRYeXoh4wzvpGsFzxlMmoagtPZdFUWVdySNW61V0vkY9suJsfLwk1XiWPt3p6qnH9gaq3Lr9h4jTV8MeESnK/FQsv+Rr6ozz2QCZTO8Fj0wDLsfWNFbgMjQTI5jEH6HE8zLv9NKt/YavjjUZrT8OPyfe4fkQ0u1SgTokimysKDagsbDIRdL1soU88n/fIDP93qNKaLU4t6r73JSHz3+LBEqCBtTocgOCiwapaeyvGSMbrZZcKYvMXsOFakrg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c64f44-c23a-4e84-9fe0-08df0344a5c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:35:48.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNCpfv9xK4SNp/nOVNS/8ZLde4kn9PtXtXVMCk1B6SX4eXHEaxNENh7g1HAS8E3CQ1mznLKUouMLcnjOAsPIn7EanBPVVSL4ZxwTPybOd5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB872716
X-Proofpoint-GUID: Ija85SvoXc2BiKUfisQeibR8HPlwat9i
X-Authority-Analysis: v=2.4 cv=UaJhjqSN c=1 sm=1 tr=0 ts=6a8e9756 cx=c_pps
 a=D7hViFZnkHkNtnby+5Sw9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=VnNF1IyMAAAA:8 a=6Y6P09mxew2hH-a0A74A:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-ORIG-GUID: Ija85SvoXc2BiKUfisQeibR8HPlwat9i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX5uuklawXh+A0
 js1xdwQN+Vb/Ak2vxJtsicHwghdpwXqAZ+ZBjtqzSG6Xfr/O1+SDd/GTZkbLnIqmgCFeuhwQBjw
 xtc76DYUorXtO1GEOmsn0zZovoIJj3Wji29E7OYHmQe9Xr6SLvV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfXwZ0ESw4xINFC
 RKPmSg/BnGVN2ESjSXBjh9WkXA0uMjPgulD2f64z1dO2nAPoC4ij0vzBQehfS8L56Lv1XbziEsQ
 FFTJrNCKddrWDOPHP89UNh1iXGAZ1U8jo5gm9JLWYHdmXM1UX8EKG6/i+H/gKXORZ0YyNYv367H
 KerGfIk524y9/098/Mmz9h0ayeMHCz0pP+vWLwge/xFv9g3vMZ3RvcPxlLS250Yy6D53idwjv0K
 3sDqPYZ+lr8z0VHyvIqJaC67EunNFiJxOCHw05J+lk++Y7mE3rPsE3P/81KZOsDa/Rm+BBrOMQB
 o4jBkikNoxysDNWVxmCmxIc880B3VSCauCx8V+US6htBsZ4bfvd+aZ8UpcLMwHZCUpWVRwQ6E1s
 Zurhosk8LahKqx/0U5Z/3xZUHjP0jRVPRAFQnYoTmrrfxL0quUASrcahuieAL6/xf7VGT4lFy0E
 uNC38sLHV8bm0Z/wkOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_003808_166683_57FAAA58 
X-CRM114-Status: GOOD (  20.83  )
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
machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT.

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

kexec_load(2) does not report an error on the same machine, but it is
not unaffected either.  With crash hotplug enabled, kexec-tools sizes
the elfcorehdr segment from /sys/kernel/crash_elfcorehdr_size in
load_crashdump_segments(), i.e. from arch_crash_get_elfcorehdr_size(),
which derives its answer from the very same CONFIG_NR_CPUS_DEFAULT.
add_segment_phys_virt() then clamps the buffer to that segment:

	if (bufsz > memsz) {
		bufsz = memsz;
	}

so on the kexec_load(2) path the undersized reservation silently
truncates the elfcorehdr instead of failing the load, which surfaces
later as a bad or unusable dump rather than as a load failure.
Switching arch_crash_get_elfcorehdr_size() to CONFIG_NR_CPUS below fixes
that path as well.

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
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
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

base-commit: a8406e6c0b793ce0788019683837c40855b55995
-- 
2.55.0


