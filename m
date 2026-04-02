Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D7D6AB18
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nAN5bptidML2Kt4p1H+2dCrPs2WWQMrrjGezrdlDOhI=; b=iBXT6okXtkQ4zydDP30Fu9AUik
	Trv1AcOsaEOPqEiL0b0+YQpFwOUDAtigPEmDCUXu7HlE6BjgV2i6wkIBfNANq9+UdwCq5UqQuWZ2x
	fKF8o6t4TzOF5Q3oqbHOgqp85KmI2PuusKr4fsg2RRPlAK5rHGLOhnE7ArB9AqXK985omXtRw70eO
	GelZGnEBLNBhslptg38i/OtuqQ8lxnil21/10gAlrPy5xIFUnKoVCZCUBf71wwq7TQkl9nXygb7cm
	971lJtTqhrFFgJ/bYRk75fr7CC1fu94t9fKNYHNLlonAgtkX4hVGOhP7xXb3brLiHOLFwqQDDxJzp
	2ASEIRKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8RVn-00000000wR8-3QrY;
	Thu, 02 Apr 2026 23:31:43 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8RVk-00000000wQb-3gD7
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 23:31:42 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632FBw5L1498964;
	Thu, 2 Apr 2026 23:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nAN5bptidML2Kt4p1H
	+2dCrPs2WWQMrrjGezrdlDOhI=; b=UJCnZGhn7Ic3K/azsJ8+m1BtTPGKsylXGf
	xK7r0SbUpmNjY0wiEcfFcGDcpcSCwdicFC35EzSg+Hu1GCMB4Q4COQMOE1iORWiG
	EQ92ebLIxVxcjr4TeygbPXlXaOYzyYY+i7jkqwy1neJuyjcN1m7URqc/7pcFpa22
	W1PVwZ7NyBE2y4swEXSX8zF/DD0hQE0i5dlJTJO+lZC+HnW3gGcO+MQ1rFTNAhjp
	ryv6O/ToTEOIG4ZsVAWpwpuhfyDwU52UzK32WaiDPzuYT8Lv9f+Bf+TZqMH4oja3
	cKxEo27wR31JAyA1txZn8tI8ws9ybLx7nrNqLQ87WGTvwslrsCow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwhdam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:31:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632L82uO039582;
	Thu, 2 Apr 2026 23:31:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ekwdyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYcu3o0EhDMR1PYtT0v/suKXjwMmj5ypP4Bvn0coMqECFM5YPmNH/ETEABEuSNaQa8rLBnAwguKdVx+QOqS1ZE75OuZr/Wf7L8DmcuxKRbWWMK5ImiEeakxIUn7F8N1lCMcSeWBYJNwwjeip51Yj8C8F8hrZZkLy2INcheo0h5pxwQgoV4YZP3FlOCjN1SNLYqILO1HO0U/lF74bKes7wriPwnRvee6ZobkZWOhERgYF8OHieV9iHUoH2tIFAk1IfWlMCE7FH4XL7AmeCEUqVAflM4MUqehz94DeZCp9yKLapXcCe2j6Hpv5+o1zVz5StOKVOLD6KIdXniFmlYAb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAN5bptidML2Kt4p1H+2dCrPs2WWQMrrjGezrdlDOhI=;
 b=QX7dMeRt67zXNLltTcmd28NINwSBbO0C9fi08y+ahVHhicTRxv0MkvLiIyW2khOi/5pCFtgjW66DgiFDqYk2IwSmOhx9cwEm0ycJiVbpC4rji0aZ76Hp9xjJAh+xhBWbo7U5A9QUk6S/WFRelwwQZRNfdaoSem+hPGcad9ZVuThTpHA5kQReO4/iw7Qrr8SYP69dlrm9DDTCxLGlJUGJBcQ0xrumEhSUbX37V1M4MP+qch17O3hVu3vSI/ym3C11T2gJQ/9uwJRqmSTrNJvASQViwHJ2LqClDScF6/QI4u6YCiXINzljfN8VNEUAqdJmhgqOFihHHOqZ3UoRCxcSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAN5bptidML2Kt4p1H+2dCrPs2WWQMrrjGezrdlDOhI=;
 b=G9AkFJ4uW1qF/wyIwVlbU4WHOPYy7gFZyPFzofSkfrFwzylWayGFyTUBahmr4/UY0aaFkmu32RkFTvYfANAIrSTMkn3IS1M3hhXH4FsFFzx+mhjw7DvflffsB2P/wuXdSdxGBiNlUiIJjy6SBUEeomCo5w3l5TNeMR5MIs6Yuc4=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 23:31:33 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 23:31:33 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 1/7] Reserve sections for makedumpfile
 and extenions
In-Reply-To: <20260317150743.69590-2-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-2-ltao@redhat.com>
Date: Thu, 02 Apr 2026 16:31:31 -0700
Message-ID: <875x69ey7g.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::20) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 923f1b19-e64a-41ef-56cd-08de910ff9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UxV++4PJe7DAsKP4bmH+JbcUGtwrw7qKhb+8AFbCEAwWa1alWSiazbhpaNUgzbjEz1Q7ovC7bx71qZaSz7fxDsauwO88X8XVlGmcV6xmrR0+ntXFoqtNBpp5PY+N4OpJGWNJhGaxyIofpizgLAn7F70ntSUwZkMlebiPh/MD1vL16h7NcVwjeiMemp8mnvKxVF5lAX69kXCdPczFueQ7S4+ztN29uWLiuAJ/RRzT8MbF9cQlo0XtoBtZPeCOEnuQxrn9RydGVoQD9sMpa9piMAlcxuOqEd5uHx6Vbx6o6NNOW7Rm9xaWWax93q+xJqsL1VS83H/n69JlxNKl6hOaJhpl9OlLANt3PjTE9g5HHpfGBn8zzx5HGkKxXrUTAu2I9lGUiUgOiDewCLvs8DKHYIltzItP022B4ioc4yaSgChm23YYxX7RPHyrNifgRubpZwYyB5XzHyTp8WQDF4ICxF/ZeYzkTpIlqvnS3TA45Vlz/ZEsqvWkQuP82H6xyuRs9jfw7qy2e6510SSRbqEQwDvpBe0Urva20reZUhHsGnxkC3uppLgBIMVkY/0RKABgv0Hp6yxPTZx2GEgomeGnxYmQ6/RiiHvXdNPpbOEskTAwbSUjD9Zj45fyd+LGV85zdEw70lnWxOBQwTwgi4cJbxIPQQ2D5GrDIQyKZasebYSUYVkfCmYqj7p72gYUHxcsCVhiydDXx36X2IuIkxyRUCqFTwHIybk9qy7EEWwKlg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BTDEZt3zNW+N7zgLnKERrkm7jh7PADEgBxpPmrZLynSRdWtE26Ol7MP9QHk8?=
 =?us-ascii?Q?VlAjOE/86wBV/gMIQSXGQBr9vGha+wPlrObZeBOt2++H4GFp8FEWMypxGsox?=
 =?us-ascii?Q?pIPsBYIQckAHiBXCLBftyaue8mUByjvmuR+ldL0qH4ZMsZ+PKDWDoZ7LIxvC?=
 =?us-ascii?Q?5Puxx+LYk/mSc6I8bBStrnpGTt3YpBPBhFXu98hKRfi92gEMjSj0m3fYHFaV?=
 =?us-ascii?Q?HL3eL7tbBKRDe4c+pHmN20xEt5UNHoIRMsEb8c5afUVnN6L4XGHrQ9C+rGZH?=
 =?us-ascii?Q?runc/EVOHeqfRkgfctpo60m9mOmzooixNGLAo0qF1UxIQWwy2l20MUiGABfz?=
 =?us-ascii?Q?SMJH3HoZLh156ZBwMB+DJp8JJQSOBtKGXIF506077s54UGH2vQffjfJERpt+?=
 =?us-ascii?Q?obxysKVpbMXJ2TJM8lFj2vB5yAnIK3mREv3ITaKk6JibpdGWpjf4Ki7iUr3f?=
 =?us-ascii?Q?1BeA66X7gOhzZs5YkZNoaoU/dG+2tTWi6IRV6vxD/LF71V1iqEWfxGfu1r+l?=
 =?us-ascii?Q?2prCIoXG4gwzuTpsvINZJQDXrhxJD1tICQmYVZIYIzVmwsVmP6MP7nr3Xna7?=
 =?us-ascii?Q?eQ/Lmzbjz9t6OW1hgedWtaBiJejLunyGn6DwZR5iOjH6JDkhkSWKNpgPJRQu?=
 =?us-ascii?Q?elAuYrW0zxWLNiJlbbND6Fe6L31U9b3usYNNPdyFQlL/NI/+spQe7sKkv/Do?=
 =?us-ascii?Q?B6SCWO9g6oFQY7vM7rv9c2xOw2BPm5Uef1KFEKA24mS0O6iwD34G+kt7lr1s?=
 =?us-ascii?Q?Rk7qIwz5cFC1dJsrTF0WztfedsejUFtf8dUcsIzf3TjVQhYhoNmQ/UAD+Q8b?=
 =?us-ascii?Q?NQkIyISzrFy6/XTnK+BZW/MJO3NXn7gxoznNoSSfbi7cS0ZX48XpjLOYBOt1?=
 =?us-ascii?Q?ZwpyU1ioIafmqClvou8oFhrTIlQMArhX8e21C75PACHpE/FK48xsM4iHtHI4?=
 =?us-ascii?Q?jf52zVZ6rgNR5wjKU/HoDb2tQkZVdRdgnmruaRNbuo9GyNyB13jGGDmZavPw?=
 =?us-ascii?Q?SZkH3WZ0Hd2+qEf1cZdekNCbfcsIaDHOXsn4H0gzUb9A0FgPS7oP2qcXUzur?=
 =?us-ascii?Q?SchXPGsdq3RJ+sxBxX6gQ8tW5kRb8bOo2ycEXi+gbZ1rfq55sgz60S5HLpsl?=
 =?us-ascii?Q?FOPMjX17HwU23g7O2PIPxdMzOgz8mKGCxD+A8YSv796Us+f6Z/2XkCm4aX9R?=
 =?us-ascii?Q?+v0wbv5bV8w1rPv8SR+O1Y+6Np72omsWyGDXKqzhRebAhjtrCP/yq9Yyfw44?=
 =?us-ascii?Q?VskjNR2iOjfLBp0GSooWumFhOGHtChxsHThCr3thTKGOtfgW8+n1GDyh7Z7t?=
 =?us-ascii?Q?RmeqwCT8ks24tsPbXYzclGhPSq21Ch8wnTSagoZoz0ZD/HSUgzpVSARHtyvJ?=
 =?us-ascii?Q?yynJingHngb/ICBlIBcD2xYNWTTHJKs8xRmWt1auzXrTQbwmE8nSQvlUpymH?=
 =?us-ascii?Q?UYiRpfUGmxHWjgJTqH7k9vQoXzE3xZsvD5YIWS2K+Y/Nb4qcRUGerVvRkPEA?=
 =?us-ascii?Q?u8mIi1v8UZPBJRuG9o2woEA5SARGSWcxiP8ljFMBL4sGRFjhyceOyQl3Egid?=
 =?us-ascii?Q?QIseYmm9P+u2bl38uAUkls7zv+0T9Gw63wkI3PEfHOugNHbLTIzCmc6QY7II?=
 =?us-ascii?Q?l+5aB707psU0q1WuZU24mUWv/EGKe9T4uDs8GqOmcMQsRcWb3TBDjkDwjHQ3?=
 =?us-ascii?Q?xFJAW2A8sd3lLT48ky7YVQ5Z0D7ZRMyWBnkIU6241tO1GDZ5lgN91f7F7UMt?=
 =?us-ascii?Q?R0F8V5kDUmTxOUP6IZGjifslMA37urw=3D?=
X-Exchange-RoutingPolicyChecked: swNpmAHg8HdCDooXHrqcukwjf5mq68kb1I9vnqbIbCf3cFv9BnG2LEDf5N7qHl0Lt4Ho5TC/+lJZbjcnNzOKX8v1Ia5QweXvjTT9rkZdW0iiDXID8QHBEXrIzOXaH1tZ0TyDsSmQZ71Kwlau9nYgDOXthy1/S0FWp6nVrYWwrxskch5EDugANzMTMQOvGiiE+f0sm1BSNS7RS2hIsXRHX53fj26kYthH2NTJtwAvEww+UydkeguMO5BFk5WwZ/K/Obka8Vy96Lp/Nl+u/Eqrzhn9iakvtGs/UNejDl/UDvlzyFGmJcxtxFmRK+ahf3pKv2dwzs/E36K41NTd76JcGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9EzrfbxiUSpO/n3sULqk13cyaPFWfG3qUzjTo5hjGIJt3AzVYea0v3BFFWC2k/dedZ2P63NrgdBvH1uNpZB/JEQKkRMbH7FWObv2qTfNJS1zl8ryPv7eP8hR1b/3W6GWPqXGR3defqtThaNowDPb2EHWCUchgMnyvUV5H9Go36oKV/qOnRy4aN8QmQz/KiSpFN3KjJGPuWMr3PDBCv5I4rKeerpGc7vyFqX5V0Ryo52kYmOfAKwoGHlIiIKjrD4NOuyMmV8G/ZWqZiQI7p2nehC/gT4xkbT1lSnP5qmwEQ5VoGv8H9QGHVlnIj9pVR6ocKfpQMfm3D8ge2ZfYG7j/dJEQDjcmZSPqeiJITVTqL1E2HCGAhZBxgFq84qcwudIHsbkptmoM8wfJ1GMiYXHAoqjpcw92DiZ5OWTgIOCI05xTbGBdMsl0IyVWbYW71+X4HD30N5lMdZ2FWoZtYVZxMXK27rEpg46F8P4OnKTtsX+z7CRZ1jYw2iHCGAkZrQfWjNbYypMTgkKJDLUknZ7oHHsrXLwdjZm18gWdQqnVF5NasSDkvYU5mKljeik40xxE5rFJexLTJ0SI/F1u8UvKoJWIXWXwfkj9k0D4BwSXsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923f1b19-e64a-41ef-56cd-08de910ff9c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 23:31:33.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJTmNzw7z72wbvYoYuOAuUk3QGAo+oQ4ppeFVjvKXVlyjXSkqVrAkvHKTNuIu4UKgkBqvE6aQdUuVsQb4JnVcGNHxAuDEY4rEZBEhKsk2ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2604020210
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMCBTYWx0ZWRfX87sZS7GoBfoF
 vxRBu2w/PtUsgie1Ykx5Zk/lXWXnSJyv50aP7gx7oSvEg20YwSb2EGpu9IINr3p++aDLicTF4N9
 InESRNcKazDGIpS4q+qFy/U+d5CsFG9i7jGdDPhqd90WWYPUIhJJ3oMFRCzcTheK8L/uT02CZsA
 IvmSVSRZdmJuMMiq7xku8xMUkiFyzkGcG40CC2TCobkxJDEfXd0ZtQkkMvrkPIIHXmX3QoOQyTS
 I1jQ3o+CJ7UAptR4dZAe6b+nbX/CeYiulnCSOkMPib6qsHZYUZeBXsd1MgmucGI1Q1Ky8fc9Vlf
 gMMGynhsZ6s6CJ/U9RDMaFp+VwmE8ubdJTVXPgqtZ33XWXIXs88AvAyKUldhlry5X347HaNDL6V
 BXd5DkROSx6k4Qmj5Yj2yzdwVc8aHGHpMJitLSRIPNYbu0/Lu+S5TEbZM0KL6+HVHLKoU+CBMIW
 vlAX9RHAOKetaE5+IdHxCFJKVnSvL1qfBa2tid6c=
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69cefc5a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=dPx6R2Yw8r53PyULBc4A:9 cc=ntf awl=host:12292
X-Proofpoint-ORIG-GUID: rhUQzKbhHJFRVHcg_vJn2XkVpucj4bRD
X-Proofpoint-GUID: rhUQzKbhHJFRVHcg_vJn2XkVpucj4bRD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_163140_945615_D9B0ED6E 
X-CRM114-Status: GOOD (  20.42  )
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

Tao Liu <ltao@redhat.com> writes:
> This patch makes preparation for btf/kallsyms support of
> makedumpfile and extensions. Any needed kernel symbols/types
> will be reserved within a special section, .init_ksyms for
> kallsyms symbols and .init_ktypes for kernel types. During
> makedumpfile kallsyms/btf initialization, those missing info
> will be resolved. A makedumpfile.ld script is introduced for the
> purpose.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

As I mentioned before, I don't think this patch is strictly necessary.
If we rename the sections to avoid the "." at the start of the names,
then the compiler should automatically provide the start and stop
symbols. But that said, there's nothing wrong with doing it this way,
and it is a bit more explicit, so I see the value in keeping it.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  Makefile        |  2 +-
>  makedumpfile.ld | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 makedumpfile.ld
>
> diff --git a/Makefile b/Makefile
> index 05ab5f2..15a4ba0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
>  	$(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=.c)
>  
>  makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
> -	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,-T,makedumpfile.ld -o $@ $< $(LIBS)
>  	@sed -e "s/@DATE@/$(DATE)/" \
>  	     -e "s/@VERSION@/$(VERSION)/" \
>  	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
> diff --git a/makedumpfile.ld b/makedumpfile.ld
> new file mode 100644
> index 0000000..231a162
> --- /dev/null
> +++ b/makedumpfile.ld
> @@ -0,0 +1,15 @@
> +SECTIONS
> +{
> +	.init_ksyms ALIGN(8) : {
> +		__start_init_ksyms = .;
> +		KEEP(*(.init_ksyms*))
> +		__stop_init_ksyms = .;
> +	}
> +
> +	.init_ktypes ALIGN(8) : {
> +		__start_init_ktypes = .;
> +		KEEP(*(.init_ktypes*))
> +		__stop_init_ktypes = .;
> +	}
> +}
> +INSERT AFTER .data;
> \ No newline at end of file
> -- 
> 2.47.0

