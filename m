Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2066CC43334
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJb5IjFEd2QwlRxj5MA7XzxscfSRrd/awLdOxhmCifk=; b=bDm2UYkLBXdJ/e2+jUmnsVtOQB
	v2uq3CX5DZfaoTO0DmNOrHInJ+3fSxEcKbdhfyUnJEC65L/lUfSmiVzvwRif9WQ845xzN0Moy3EPL
	GSEFoTnf6ndO29PpRYl9GPgN07G0VkhPqyZzy+ZMAIaYmd1mirntUxdVlTNIUX19uk2wmTrBqxk+f
	1f0YIaoTrNLP30N9Cuc/ZZRy/R89XjbUH1BO6IHGdS7rFuOLosakw6NIgrKDIeTsO0f+65bIvCMvv
	khpBN60sDNumHjUTmmenS61/vIS0Cr+vv3L09FHE3rWuZRGVxHHD0d3XNJq+VhxunKjd4RUxDcazi
	FNvSCNvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9RGZ-00G9G4-6K; Thu, 07 Jul 2022 13:09:59 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9R3c-00G5Wh-2l
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 12:56:37 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267C9QN7003283;
	Thu, 7 Jul 2022 12:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=FpLzWiJ2fp/RFRXmNRUuc7u9kzoKQB21K4icXntg8lYaSuDva6hpHLpaNPX0ETJclFLs
 OiBbeTxMqv6HUWlqPxy7Xw34m8i+GAlJtWX54MV2d0akV5zMj8FiqftiENYJexuBdHT1
 Uv4O7IHNaumUNFjIgtlpbzoUrwqM0kNQCjaFOfjb4yO4fcSdbnvgi1DneWJ0C895pDOU
 VZE3x5nZux6D4eq/z26vXu4D/P9a/dLx+IDV76ljviV4YG+miEEbRQLaiLWssdJciE6C
 MTctk3b77Ha3rBNG8/KGtgst/Ls29UiTnWpOL/FrN0KAef0nmjA21lAezv5QKtl8jjOv GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubycu9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Jul 2022 12:56:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267CtLBo020006;
	Thu, 7 Jul 2022 12:56:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6xx2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Jul 2022 12:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/bome66/hLaQjVC0m02A8qgWasTptKr9/03cAYRhyFrKXPHOoIU3TWE9INsVPLrHCbdrB2yklVzpVU+IJxaYQRBrChNFi99sWDj122SQ/vC+mz+W7QrsbH1qqCy9uqNP9ll7I+ihybkWuvTchaRlL3T8614pXDblkNOqdQSXYExO1SuxLXEoqSkcb4fUTNFUXabnTsCL8v9uDc4bJDObZlfW8b4+kmwoGkKQ2lpKGYnsId+AV02dO965AYb6HgdCkUrGPNlLuacVGawejpFNwDIAhdprQc7aqPC8lt3PiBxANmKZzdWbqsHb5V8QujLXDd7kX8Hwn8IzSl3KXCcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=b83re8AP3lESSPOb6JTgIfkS3KGyijxopSUxtkStJLVAPUB++5U/ncryF/CMGPehRGjvswieA66rSzwSdfAJg6qsk87felYKSEaYOevBXLGPSwP+1m3E/yRTBB301aBoRs7SJv9YsaZrUWxG+JST/xshdUYwM+BSUHLWgmBLZBptGTgksjPtnYkSIhcvC0HyPOsNTGGv5VMLAGTlv6Z8dt6oKH0SC9xWUvaQrbL+zDt9YOxT+wsDzJxhtaLVUGD57EuDB4eB5r7XxJCAP048/FLXpEjAmCZD41m55rYl26WjztK4yCkxomwcdOtqbmMjmky/CYehHMZTBIvZySZHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=y7b4baxF7873RmgJtTQKe1n6QArstCBnnyx1fOQaGjTjjLNDmzPEavsH0oftOFinOUkoHtLcPPjnDzdhN3L8ez2LFNmN35iCQs8iIB8lCFnjpeWU8jKgug6BkCNNKgLwLMwJ1jgpYGwjQy4Ezj+Ff8F5j/jXUohOUuTxK/JEU/g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 12:56:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:56:00 +0000
Message-ID: <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
Date: Thu, 7 Jul 2022 07:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
X-ClientProxiedBy: SN6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:805:66::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e6c365-3a3a-42ee-033c-08da60180ab5
X-MS-TrafficTypeDiagnostic: CH2PR10MB4133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	S3FuVcSGVR4BRu1S+euT/oZu2qlA3zpucsp1xz8e0bFA0las/6MF+4GkY2lzy/IXIt11rXSlTrgtNCy3wWQPMI9Yrv/mRE+zlqjPAz6OWMGQOgSi2ckMqkwVas4WKtBNdn1FmwY0/UaQ45WSq530txONfqNEKs98S0xUIgMaE3muE6VGSLK4vY7IopidYz3gStA2PN/fXWI+vEBG1fJH08onSeXQTl4yBrRUPlJ0ve9+xkRV7YIedFS6Mz4FKFP4TFOX878bbgkKUWRAl2L7Sfdle/KJ1rAw109cX0RrT2LPfE+JlYBZbGYQCpB2zW8TD33HYgA+rfgoRoF8M/NevSqLFcA94nhvGEQ/MXyB6SvBP3Yl9tK0XKPUyetzogmKf8fbHAS/ukVYaoIr+Y8s0sFFYKoAADFRmYaXTj3AqC3eKUYVlSRzPbg7mkprAkf4mRWfEA83Hav5rYFO36kugJeRaWzH/QfC1p8MM143SNzigERRkOyxiwjfTBSkit8+KFv4ocVwCdQdkHcTarJoYumEppMGI39o09Z2u70E2opqlw9sMFkgzhcheWBSBWJABVBOGPYzEY79Tq/K11rveoX10q5DgPZ8z4++2a9ziHCGWufAjqLdIaEqz9LqBqIul4dH3oiCbHPstI4iQ8ULzrMAnstTQwhyjwjpnqa5BFJjHt2P5d4r3wSqakfv+jV0G2jSmsY9NKb/uU7nXg9D4dUYDMYdjhuzwyshhfVHF5cy/cZ1lwndbmsz57fKVGt9BunMY39LriVyjcAqqz2TJc2O8n5LM7IF9iKpSEAapOUKfxHnAz5k0fl4nnhZ/eZoVzywmHzeSowFdgPvX6wRmA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(366004)(136003)(66476007)(4326008)(6512007)(66556008)(66946007)(7416002)(478600001)(83380400001)(5660300002)(6486002)(2906002)(41300700001)(2616005)(8936002)(107886003)(8676002)(186003)(316002)(6506007)(36756003)(31686004)(38100700002)(53546011)(31696002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TWY2ZzFkTWFhQ253T0dvRnNhckFvNVV1WUp6dWZGWTcrZGN4Z05mMnFUY2Rn?=
 =?utf-8?B?bVZCZFBzUFc2OE9NMzF3TERnOVlkRlFqdmoxamlZYjZrWWZOWG5uQlBTUWdr?=
 =?utf-8?B?NEpEcnBqRWU5SmQxaDVOY3pPdlhTb0ZVbHAvOGVzMWR6a3lFUTRxVE42b28y?=
 =?utf-8?B?MkdveHM3ZlcyTHRIZGk5TUhCWS9keHVRNUNjanVCNTM0Yk9mcithQkdvMnhy?=
 =?utf-8?B?NU1ZSkhSaU9la1VsMFNoYkdidWc3RXFQUUJFczZUOHFZbUNQWVBUUXI5M1B5?=
 =?utf-8?B?THkydHkvZHU5MUkxWHVWaE1kdmU5eFVOanE3VXhtYmtscEJkNGxVUHplSEVE?=
 =?utf-8?B?dkJFNm5hcHJvK0lVblB2L0V6aEVsT0dPaUEwT2VUU3phVFhKNW5zcVFka2JO?=
 =?utf-8?B?L21WM2djNlo0Y0tiWTYvbHMyeW5ZVlFEYjkvNWJNaENIeG9aalFVWFNUMmJl?=
 =?utf-8?B?S3F3RmpmTS8vL1lzUk1TZTYwWnVJS1M3VG1GaFdqblIvRkNqNUk3aVBKRWEv?=
 =?utf-8?B?MnZ1cVA3SWRxeTRiQTZzd0g2MTFWUllLSGVsYnY3L1lsM0gxbVd6SUs3cWdZ?=
 =?utf-8?B?Z0E1R1Q0UGxnLy9wM2tqMzNoZWJWSXNrTjR0NUt2aWh1YVhjN0FGWjNoNVRB?=
 =?utf-8?B?UnZNTVl6ZEp5ZTBMcEdURkZSK2xFb3BLUjlRVFVpL2tsajU5RDdaRlZKeXF4?=
 =?utf-8?B?ZGRGRS9peUIwaVVmdjhrWnBTRkhBcWtmY1h2Z1U3dmFZNkFaWE9zWEVGQXRi?=
 =?utf-8?B?Q2NHaTFiUXZkMUora3Bkb0ZzNk41TTh4aGx3M0hXVlBXZWNnejZBak9ZU2ZB?=
 =?utf-8?B?d1FQYjBYTnhMNkE1cThIbWd2L3pSZFdoYVVjZjZJMlhxSmc3cVRsWWZ1Ykll?=
 =?utf-8?B?SHRzb004VUVVY1QvdFJtUVNaaWgxSE9QcUtqOWxmWXZzQmNsMmgrQTJWMFNB?=
 =?utf-8?B?MHg4bHRPUm5sVU1PemdpaXBPQjBjcHZtOVFQUlI2RFlpajErSlFVc21xWUFP?=
 =?utf-8?B?eXdtY3hHVERCb2x6TFlGd0VuazhPcVRmQjdHTnd3V0s0TXJETnFRQUF6K29Q?=
 =?utf-8?B?VTFjcmlmbWhFS1F6blB0U0dxK25acVdqTE5BSmlzV1RXZHdMUE4wajFNNTB6?=
 =?utf-8?B?K3N4UVpHV0FuVHJQUVVBbHpuT1RpeWJBdTAzczRhNVNkODF2YTJWSHpiWXhN?=
 =?utf-8?B?b3Jhc0U5d0g3aHFiajZwK2toR0ltNDJKUlNUY3EzMmxQTU53dnpXSEswWll2?=
 =?utf-8?B?S3lKVmxvem1ReHEzRHZYTndvZDFLREMrM2FsUCs1b3BTL1hiVXF6ZngvdGpH?=
 =?utf-8?B?S3ZyNGlCYVk1dTZZQTJwbUJGOU0yV2t1NXljM25sK29MRFZGMUp6R2dXQVRL?=
 =?utf-8?B?eE5OS2g1YWp2a3NycWJjcG02WTR2RVBJcTMva0xWNWJFZEIydVVNUCsxVEgw?=
 =?utf-8?B?eDZIVEhFdkdLQjcwcGx6YzQ4bDJSQ1orUGhObmFRRmRwVysyWjk5UHUwcTZj?=
 =?utf-8?B?NFhhYjlZdDhhc2JXYU41UmdIOUdJYjNYb0c5OGI0eWFQWUswYzJUd1oxS0VK?=
 =?utf-8?B?a3FaYzlXa1IzK2JwZkhlc0R0WFgvcldNN2pNazNOVlNZdWhsVjNmUkNmR1dO?=
 =?utf-8?B?cWhBVU1DRU5BZHNvVVlGMGd4WStIYUp1eEE3c1NMc3BRNDNnNkVpT0pMRldI?=
 =?utf-8?B?cEJVTGlzUktnNERCbTNtTWQwblNyZDIwMWp2c3h5VHFmeW9GamFhOW81dlBy?=
 =?utf-8?B?bHZTN2xFVHBDRWZkOWU3azA3YmhKb2Uvb3U2b091YzB6L1NtV3FaNFNja2RP?=
 =?utf-8?B?M2swRnFmS0hOR3hiU2drMkhpK040ZEpVUGRsa3RhTEQ3dCtmTlNvQXBHNXND?=
 =?utf-8?B?SEVoSnpyQVQ1TGdCcEJwZkFKaEtEN291aGhuenRHbkZGTW1pbmhRUDBDWVdL?=
 =?utf-8?B?ZG1ma2lYQmRRMXBDcnhaRFZqU1BlWFZuRTNVdmpGL3ZaQ0JGSHlYc2RYRTZQ?=
 =?utf-8?B?dUNqYWlZWXdvd0RWZHF0MFBjcmtYSHVyL1hyekxTUkkwa1FEY0NqOWt5cFkx?=
 =?utf-8?B?V2VvY3gwbi8ya0E4cVgrSmdUOFdHNEtYc2tObVNsUm1Bai8rVG03eFpkTS9m?=
 =?utf-8?B?ZWdmNjFVRmZSeGl3L2tYc3l0TzBXZm42bDlDeWU5eGFYcnc2alhjU2xWTlhB?=
 =?utf-8?Q?8pnrBXdV0Cn74VMnJlMP8jw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e6c365-3a3a-42ee-033c-08da60180ab5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:56:00.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3wQyvQehqdD8U6DDPV8wNPfc/r89qgN+TX2WNVFhsCbOPLoBJIxWX1vzqRzPtdp/5M8LkfMayEKjeViW2RVxufTEmybsJqx7hRJKZk8vDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_09:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070052
X-Proofpoint-GUID: OogTfvsNkn7Svi56CKYSxhuDoV9_B92y
X-Proofpoint-ORIG-GUID: OogTfvsNkn7Svi56CKYSxhuDoV9_B92y
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_055636_184355_2FF57662 
X-CRM114-Status: GOOD (  26.50  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiA2LzIwLzIyIDAwOjA2LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gSGVsbG8gRXJpYywKPiAK
PiBPbiAxNC8wNi8yMiAwNDoxMiwgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4gRm9yIHg4Nl82NCwg
d2hlbiBDUFUgb3IgbWVtb3J5IGlzIGhvdCB1bi9wbHVnZ2VkLCB0aGUgY3Jhc2gKPj4gZWxmY29y
ZWhkciwgd2hpY2ggZGVzY3JpYmVzIHRoZSBDUFVzIGFuZCBtZW1vcnkgaW4gdGhlIHN5c3RlbSwK
Pj4gbXVzdCBhbHNvIGJlIHVwZGF0ZWQuCj4+Cj4+IFdoZW4gbG9hZGluZyB0aGUgY3Jhc2gga2Vy
bmVsIHZpYSBrZXhlY19sb2FkIG9yIGtleGVjX2ZpbGVfbG9hZCwKPj4gdGhlIGVsZmNvcmVoZHIg
aXMgaWRlbnRpZmllZCBhdCBydW4gdGltZSBpbgo+PiBjcmFzaF9jb3JlOmhhbmRsZV9ob3RwbHVn
X2V2ZW50KCkuCj4+Cj4+IFRvIHVwZGF0ZSB0aGUgZWxmY29yZWhkciBmb3IgeDg2XzY0LCBhIG5l
dyBlbGZjb3JlaGRyIG11c3QgYmUKPj4gZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBDUFVz
IGFuZCBtZW1vcnkuIFRoZSBuZXcgZWxmY29yZWhkcgo+PiBpcyBwcmVwYXJlZCBpbnRvIGEgYnVm
ZmVyLCBhbmQgdGhlbiBpbnN0YWxsZWQgb3ZlciB0aGUgdG9wIG9mCj4+IHRoZSBleGlzdGluZyBl
bGZjb3JlaGRyLgo+Pgo+PiBJbiB0aGUgcGF0Y2ggJ2tleGVjOiBleGNsdWRlIGVsZmNvcmVoZHIg
ZnJvbSB0aGUgc2VnbWVudCBkaWdlc3QnCj4+IHRoZSBuZWVkIHRvIHVwZGF0ZSBwdXJnYXRvcnkg
ZHVlIHRvIHRoZSBjaGFuZ2UgaW4gZWxmY29yZWhkciB3YXMKPj4gZWxpbWluYXRlZC7CoCBBcyBh
IHJlc3VsdCwgbm8gY2hhbmdlcyB0byBwdXJnYXRvcnkgb3IgYm9vdF9wYXJhbXMKPj4gKGFzIHRo
ZSBlbGZjb3JlaGRyPSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlciBwb2ludGVyCj4+IHJl
bWFpbnMgdW5jaGFuZ2VkIGFuZCBjb3JyZWN0KSBhcmUgbmVlZGVkLCBqdXN0IGVsZmNvcmVoZHIu
Cj4+Cj4+IFRvIGFjY29tbW9kYXRlIGEgZ3Jvd2luZyBudW1iZXIgb2YgcmVzb3VyY2VzIHZpYSBo
b3RwbHVnLCB0aGUKPj4gZWxmY29yZWhkciBzZWdtZW50IG11c3QgYmUgc3VmZmljaWVudGx5IGxh
cmdlIGVub3VnaCB0byBhY2NvbW1vZGF0ZQo+PiBjaGFuZ2VzLCBzZWUgdGhlIENSQVNIX01BWF9N
RU1PUllfUkFOR0VTIGNvbmZpZ3VyZSBpdGVtLgo+Pgo+PiBXaXRoIHRoaXMgY2hhbmdlLCBjcmFz
aCBob3RwbHVnIGZvciBrZXhlY19maWxlX2xvYWQgc3lzY2FsbAo+PiBpcyBzdXBwb3J0ZWQuIFRo
ZSBrZXhlY19sb2FkIGlzIGFsc28gc3VwcG9ydGVkLCBidXQgYWxzbwo+PiByZXF1aXJlcyBhIGNv
cnJlc3BvbmRpbmcgY2hhbmdlIHRvIHVzZXJzcGFjZSBrZXhlYy10b29scy4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBEZVZvbGRlciA8ZXJpYy5kZXZvbGRlckBvcmFjbGUuY29tPgo+PiAtLS0K
Pj4gwqAgYXJjaC94ODYvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgIHzCoCAxMSArKysrCj4+IMKgIGFy
Y2gveDg2L2tlcm5lbC9jcmFzaC5jIHwgMTE2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMjcgaW5zZXJ0aW9ucygrKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvS2NvbmZpZyBiL2FyY2gveDg2L0tjb25maWcKPj4gaW5k
ZXggNzYyYTBiNmFiOGI2Li5lOWVlY2ZmM2I5N2QgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L0tj
b25maWcKPj4gKysrIGIvYXJjaC94ODYvS2NvbmZpZwo+PiBAQCAtMjA4Miw2ICsyMDgyLDE3IEBA
IGNvbmZpZyBDUkFTSF9EVU1QCj4+IMKgwqDCoMKgwqDCoMKgIChDT05GSUdfUkVMT0NBVEFCTEU9
eSkuCj4+IMKgwqDCoMKgwqDCoMKgIEZvciBtb3JlIGRldGFpbHMgc2VlIERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUva2R1bXAva2R1bXAucnN0Cj4+ICtjb25maWcgQ1JBU0hfTUFYX01FTU9SWV9S
QU5HRVMKPj4gK8KgwqDCoCBkZXBlbmRzIG9uIENSQVNIX0RVTVAgJiYgS0VYRUNfRklMRSAmJiAo
SE9UUExVR19DUFUgfHwgTUVNT1JZX0hPVFBMVUcpCj4+ICvCoMKgwqAgaW50Cj4+ICvCoMKgwqAg
ZGVmYXVsdCAzMjc2OAo+PiArwqDCoMKgIGhlbHAKPj4gK8KgwqDCoMKgwqAgRm9yIHRoZSBrZXhl
Y19maWxlX2xvYWQgcGF0aCwgc3BlY2lmeSB0aGUgbWF4aW11bSBudW1iZXIgb2YKPj4gK8KgwqDC
oMKgwqAgbWVtb3J5IHJlZ2lvbnMsIGVnLiBhcyByZXByZXNlbnRlZCBieSB0aGUgJ1N5c3RlbSBS
QU0nIGVudHJpZXMKPj4gK8KgwqDCoMKgwqAgaW4gL3Byb2MvaW9tZW0sIHRoYXQgdGhlIGVsZmNv
cmVoZHIgYnVmZmVyL3NlZ21lbnQgY2FuIGFjY29tbW9kYXRlLgo+PiArwqDCoMKgwqDCoCBUaGlz
IHZhbHVlIGlzIGNvbWJpbmVkIHdpdGggTlJfQ1BVUyBhbmQgbXVsdGlwbGllZCBieSBFbGY2NF9Q
aGRyCj4+ICvCoMKgwqDCoMKgIHNpemUgdG8gZGV0ZXJtaW5lIHRoZSBmaW5hbCBidWZmZXIgc2l6
ZS4KPj4gKwo+PiDCoCBjb25maWcgS0VYRUNfSlVNUAo+PiDCoMKgwqDCoMKgIGJvb2wgImtleGVj
IGp1bXAiCj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBLRVhFQyAmJiBISUJFUk5BVElPTgo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYwo+PiBpbmRleCA5ZGI0MWNjZThkOTcuLmI5Y2RmN2EwZDg2OCAxMDA2NDQKPj4gLS0tIGEv
YXJjaC94ODYva2VybmVsL2NyYXNoLmMKPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMK
Pj4gQEAgLTI1LDYgKzI1LDcgQEAKPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPj4gwqAg
I2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL3By
b2Nlc3Nvci5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL2hhcmRpcnEuaD4KPj4gQEAgLTM5OCw3ICsz
OTksMTcgQEAgaW50IGNyYXNoX2xvYWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+
IMKgwqDCoMKgwqAgaW1hZ2UtPmVsZl9oZWFkZXJzID0ga2J1Zi5idWZmZXI7Cj4+IMKgwqDCoMKg
wqAgaW1hZ2UtPmVsZl9oZWFkZXJzX3N6ID0ga2J1Zi5idWZzejsKPj4gKyNpZiBkZWZpbmVkKENP
TkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBMVUcpCj4+ICvC
oMKgwqAgLyogRW5zdXJlIGVsZmNvcmVoZHIgc2VnbWVudCBsYXJnZSBlbm91Z2ggZm9yIGhvdHBs
dWcgY2hhbmdlcyAqLwo+PiArwqDCoMKgIGtidWYubWVtc3ogPSAoQ09ORklHX05SX0NQVVNfREVG
QVVMVCArIENPTkZJR19DUkFTSF9NQVhfTUVNT1JZX1JBTkdFUykgKiBzaXplb2YoRWxmNjRfUGhk
cik7Cj4+ICvCoMKgwqAgLyogRm9yIG1hcmtpbmcgYXMgdXNhYmxlIHRvIGNyYXNoIGtlcm5lbCAq
Lwo+PiArwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYubWVtc3o7Cj4+ICvCoMKg
wqAgLyogUmVjb3JkIHRoZSBpbmRleCBvZiB0aGUgZWxmY29yZWhkciBzZWdtZW50ICovCj4+ICvC
oMKgwqAgaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXggPSBpbWFnZS0+bnJfc2VnbWVudHM7Cj4+ICvC
oMKgwqAgaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXhfdmFsaWQgPSB0cnVlOwo+PiArI2Vsc2UKPj4g
wqDCoMKgwqDCoCBrYnVmLm1lbXN6ID0ga2J1Zi5idWZzejsKPj4gKyNlbmRpZgo+PiDCoMKgwqDC
oMKgIGtidWYuYnVmX2FsaWduID0gRUxGX0NPUkVfSEVBREVSX0FMSUdOOwo+PiDCoMKgwqDCoMKg
IGtidWYubWVtID0gS0VYRUNfQlVGX01FTV9VTktOT1dOOwo+PiDCoMKgwqDCoMKgIHJldCA9IGtl
eGVjX2FkZF9idWZmZXIoJmtidWYpOwo+PiBAQCAtNDEzLDMgKzQyNCwxMDggQEAgaW50IGNyYXNo
X2xvYWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+IMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsKPj4gwqAgfQo+PiDCoCAjZW5kaWYgLyogQ09ORklHX0tFWEVDX0ZJTEUgKi8KPj4gKwo+
PiArI2lmIGRlZmluZWQoQ09ORklHX0hPVFBMVUdfQ1BVKSB8fCBkZWZpbmVkKENPTkZJR19NRU1P
UllfSE9UUExVRykKPj4gK2ludCBjcmFzaF9ob3RwbHVnX3N1cHBvcnQodm9pZCkgeyByZXR1cm4g
MTsgfQo+PiArdm9pZCAqYXJjaF9tYXBfY3Jhc2hfcGFnZXModW5zaWduZWQgbG9uZyBwYWRkciwg
dW5zaWduZWQgbG9uZyBzaXplKQo+PiArewo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIE5P
VEU6IFRoZSBhZGRyZXNzZXMgYW5kIHNpemVzIHBhc3NlZCB0byB0aGlzIHJvdXRpbmUgaGF2ZQo+
PiArwqDCoMKgwqAgKiBhbHJlYWR5IGJlZW4gZnVsbHkgYWxpZ25lZCBvbiBwYWdlIGJvdW5kYXJp
ZXMuIFRoZXJlIGlzIG5vCj4+ICvCoMKgwqDCoCAqIG5lZWQgZm9yIG1hc3NhZ2luZyB0aGUgYWRk
cmVzcyBvciBzaXplLgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCB2b2lkICpwdHIgPSBOVUxM
Owo+PiArCj4+ICvCoMKgwqAgLyogTk9URTogcmVxdWlyZXMgYXJjaF9rZXhlY19bdW5dcHJvdGVj
dF9jcmFzaGtyZXMoKSBmb3Igd3JpdGUgYWNjZXNzICovCj4+ICvCoMKgwqAgaWYgKHNpemUgPiAw
KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBh
ZGRyID4+IFBBR0VfU0hJRlQpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBwdHIgPSBrbWFwKHBh
Z2UpOwo+PiArwqDCoMKgIH0KPj4gKwo+PiArwqDCoMKgIHJldHVybiBwdHI7Cj4+ICt9Cj4+ICsK
Pj4gK3ZvaWQgYXJjaF91bm1hcF9jcmFzaF9wYWdlcyh2b2lkICoqcHRyKQo+PiArewo+PiArwqDC
oMKgIGlmIChwdHIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICgqcHRyKQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBrdW5tYXAoKnB0cik7Cj4+ICvCoMKgwqDCoMKgwqDCoCAqcHRyID0gTlVM
TDsKPj4gK8KgwqDCoCB9Cj4+ICt9Cj4gCj4gQXJlbid0IGFyY2ggd2lsbCBoYXZlIGJ1aWxkIGlz
c3VlIGlmIGFyY2hfW3VuXW1hcF9jcmFzaF9wYWdlcyBtZXRob2RzIGFyZSBub3QgZGVmaW5lZD8K
U291cmFiaCwKWWVzLCB5b3UgYXJlIGNvcnJlY3QuIEknbGwgYWRkIF9fd2VhayB2ZXJzaW9ucyBv
ZiBlYWNoIGluIGNyYXNoX2NvcmUuYyBpbiB0aGUgbmV4dCBwYXRjaC4KVGhhbmtzIQpFcmljCgo+
IAo+IFRoYW5rcywKPiBTb3VyYWJoIEphaW4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
