Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FDEC433FE
	for <kexec@archiver.kernel.org>; Tue,  1 Nov 2022 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAUejrCYpx2GHqqogjnO2mht/3nIxQPWeTxUZFWkt8I=; b=UCEd6foVZ5K5lZHnapQ26bO0sn
	m1IBC7b+5oOlMOc5S70pIiv8qdlDO7eQJgrp/XHXjlJk+CtlxYXKD2fBbqopkzZlHDBQvHNTbotCH
	Oq9QeHD44lmOWXOz83F3h6uHPSbKcNOxXowgLGSCQ4st5KaFs15WOVqXp21XS9DpRKVKjWToWqLfX
	WXIxR5A6JkIgjyPbaS04e2vKxVcvFH6Fj6V1wS8IeZqoxZcgmjt+fvdKCzVwXtJe67kE7rp8llcMb
	aBPJBQEEnLnjHIHqf549tvejo0vVxsAHLSIlSNfshkc9DysYQ1lrS0Kr21wGqwGwOW+G28+mcgHQv
	wid4xGBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1optSS-005u67-Gz; Tue, 01 Nov 2022 15:45:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1optSL-005u57-G3
	for kexec@lists.infradead.org; Tue, 01 Nov 2022 15:45:39 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1FAv14032287;
	Tue, 1 Nov 2022 15:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rCrICODAudrFesxuP0Bypz7fK2x+yCcul9bJ5XuCZ9c=;
 b=B3U0QWqMeb3GfqOsZFqO82dmIyVzW/RqSdbvaGRKeym85TtqALGRPAHkNER/vskFR8ks
 DbEQHyYCvMCZoIcL11Sh5Y+EpF9BQAbQWrDfi20vsjT+3rBoLXLGMfPbHem3iwyxd1vg
 42bzjRp0JPfUmazCunf6NomAS1Nl7S5DXE4sTckLKDJjmSMyJ83XBS2+e7WfJ0weoljI
 +uWtQbL/bzMPmQZEEZDhgWBx5W66DQHZ9unUuCsnMDSirJCF3KkbaQMUvQypjcu0MQAZ
 Ohk/HIKH6QYNo6bzT5Cp91A7dO9GLRl714UEuP9Olza+V7Pdf88/sQwFumsDN0ZJfBEX 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussq0kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Nov 2022 15:45:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1FbvvS030291;
	Tue, 1 Nov 2022 15:45:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4kede-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Nov 2022 15:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmv2mGq2RFvtirM8mQajub2T8aBEtnCZGJ1/5BeVxkD/7x5gIksLL7BD5hHjZCc5qcCLPH7pZaOGjp+zDlBGlw6q5iRzYGS3JRbwtPSHjngfEDocu4pBwnnCQxTcfJ78RN93gFJgw2FzCMGxj9evbChxB4krAoufDH7JpUm4DtF9z+4J9GcY1QQW/PLkX/FM1nrOT5Uq21dBh6YO9clSpFNGG8mXx5SMN/s7RyBYsZL8jiiV32ChUeSxa+5p+Gs27ST0VKhFqHoAu6xu/2qCV3SIegHEvGAIPTPewEFV3gaEJQmff+N4quIPYs7RoKShZhgp4tvo/HtoHYLqU3XcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCrICODAudrFesxuP0Bypz7fK2x+yCcul9bJ5XuCZ9c=;
 b=FUy6ig0Axs6HWYzD629vNek5668PAfAAZxHvREfG766RGXfbodmVwA1pdSP4nUUbtlk46Dd1uAL8bp4L3cAp7Ksq1igTlL1rJRZ2Bi9G+hlKpeGbI0x4IGiEMP3NstLNWN1N33Cj7GTLw+vHxTh6fIHMMLx1qSLLQGP/FshVWQIA7UCw+eiKWKJJbRpAw0N7G4doFf13dyiP59LsjtXgOsn93YCTzkNsO1msLcE8U6b/k+Sw7FHMaEmFrqbMC9h3J7u+ioZSWraOTIyfXq6Qg0b6XjkaL7Y0tkNAfKbIOjYVHtm6WX7ONqk3lGzQj4WwPd0YPGLW4WC6owlqExWSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCrICODAudrFesxuP0Bypz7fK2x+yCcul9bJ5XuCZ9c=;
 b=hlHekIwRZ6481OqGVRqN4vnSUPlDOYH7w3ogF4vtvLEO0cVHDJFcfBJ1JlIGqFCQ2iW7z02Pf/9DzlmDRduxsQXFOZjsr1/gO7ZrleIn4J2Y1lDbZMCvVYRyYE9vMGZIwxjVMDhIhTwa+M3r4kC7+izZeJK6Us8nk6eeF7B3eGI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 15:45:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:45:10 +0000
Message-ID: <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
Date: Tue, 1 Nov 2022 10:45:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com> <Y2A4TqyOaPYBu4Hk@zn.tnic>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2A4TqyOaPYBu4Hk@zn.tnic>
X-ClientProxiedBy: MN2PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:208:e8::48) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: a6139aa3-65c7-4bf6-c472-08dabc200e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	S3lxxhuiVVdzG7XkcE3hwVM+hFM+NQvVPOnTl/VTrdMnK+CR8suM3wL9JveHxP4WFRVg1Rl7/cxFY5IWhWVeyQ6BFYu32FTacYSZgxU/WyU7Wn067/oT+HJQPnplUiLaOu+VIAZMP/lat66cmKwlDtEJFTVyQcxxOLv5gYAXBFBhBSnid7duPR30woCgrDeRh1kzfeWGhZwTiSGf5LbzW3U4pOxMV4CFSo4CZwZvPgqiqa8dKj9GusBgJg4XZKSxwJJs1Bp1E5Ne2C94VGtX1+DjWYYMF+PyCIc+B4vlG5ZkXx7TwSFDNRV3EvzBHSjw9DUbd63mSgl6UARzoNWuVXzzVkQ3GsbPn5acicLufmuEnV2FJSlMi08JjaMBd1C5VWUpdeAHIS5/b4dSmmZPIX+sf8a2tXwInTpOcKA+c/9N8pxbR3ZbsnPkFZ58UrpFqdEaAUyCBrG3NF2DIdWDN561j4MhtKJ8UBajIPH+fV2mFKCcEe/MxJ17oPgPtJJrv5DnTj4kdlr1vzrB9gKHHMgfvSuFYS+YSPZDSNcMEEp/oZXUEE8BRVfWXjfEnL2M59Qmtd/IB6ow2O5RzSJFg6tNr1TY2qvZzIcsBS9eZcKrdph7SVISgjIz9FLv+h51mPzW+4CNpmlJH/ifZMekUfocODVLGqrkPb2wjQUibU+Dpfqgs07AtxbLXzqFDQd8FaioU8/jn9R2sAzyIYuyy59buTzcZnVSRZ8a628zOIlVmgEVwxudFcfY34Oa/RWO5XrIXTsg9hlPufGwzkA9DYAc5eFjJOVgSwa0lQvaifr+zImg2EUvZyq8a58rn2//NZfCaWgZvlOOgSTOgcliGw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(7416002)(6916009)(8936002)(66556008)(8676002)(4326008)(6506007)(4744005)(53546011)(36756003)(6512007)(38100700002)(107886003)(5660300002)(66946007)(66476007)(31686004)(316002)(186003)(6666004)(41300700001)(2906002)(86362001)(6486002)(2616005)(966005)(478600001)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?MEJTTW9RdkVBMHVqWkJxNXEvbm9sam1ZQ1NOYWhaVzNSbFlkRU5GUFU1U3l0?=
 =?utf-8?B?Nys3UGhTRWxjOHZqTXo5VDFqM3VpczJ3SkhDdjhhM3ExbnRwYUNTdlhrZFZa?=
 =?utf-8?B?ODB5TWhSWnRWZzU2ZTVEMkVUUmlEQ1VmZDk2U2xKNkFUN1VVWkZ2eFpXQkpH?=
 =?utf-8?B?V1dRdERKWlZncE9VdEtiUE5OcWFlb3dTYzNuclVRdnJxTWRNcXlvNnNtSklq?=
 =?utf-8?B?Vm11TkNlaUlMSlJrRjMvRWIvV2phSGExUjEzQzgvMEkrL3N0ZmRWS2llUmZ4?=
 =?utf-8?B?UjBLdnVWMmY5VVg1RVZPVG9hL3MwckhtQ3JRQkJ1T0FHSklRazAyKzJ1M3NC?=
 =?utf-8?B?OVV5bzRsR1JkNlJpMGRFci9WWXN3SXpMNjhLRnM5dUhtS0ZrZHdtTnBtbm5P?=
 =?utf-8?B?ZE5BR05KNlNaZWFvZlY4YmJoSndhQ3Q2L2s4em1uODRtNGM0TTVWUFlQUnVL?=
 =?utf-8?B?TW84aTFMVFlsay9lSVRrY1g2NFdOZEovcXhGZDViYytwNElpb0VjMzNuTnBI?=
 =?utf-8?B?TEIzMmpPd2xsamFXQWZiNlNsM0hUYVFwVmNvNktsdks4YVZqb0RxdTlHWFA0?=
 =?utf-8?B?b1dhMnpWNUF0QXFJKzZYeWdZaDRjOGQ1aEJpRzBBTGZsSmFhdWY4NCtIM2x2?=
 =?utf-8?B?NDFBWjRnUm9CUWJna3pqdWgwV2FDOTJyRGZyMlFaWS9lQWNFZE95Rndwb2NU?=
 =?utf-8?B?cVA4NmhYVkEweUVHMWtOeWJhQmFMTTlrQk5HZFcwVG1RTXExSDRFaTF6RFRQ?=
 =?utf-8?B?L2IxZ3MwYXpwZGwxamdaSXVCOGllUG1xdTI1TnZUWG1STkY0OVRaTFIxS1F5?=
 =?utf-8?B?Q1VSYmxqY3BJV29LaS9mZXA0UXpzVkRka3MvVUdRemhTb3E2U0VxTmZIeGxE?=
 =?utf-8?B?a3BxYThNa0FvUlFEcis3NmRXMmVSRVpDaDNvN3phM0VtNk5KUVJ5eXRCMFhs?=
 =?utf-8?B?RG5oa0ZCemcrWGhUOUpnc3I5QjZQbEhKUHhQWjMwRlVIMUgxOStpUThYaUJ4?=
 =?utf-8?B?N2R1VW11RFN3em1FUEJ6TFh4VGdKN215UkVma0dyQThPaFZwWjJ2VEFPdFVW?=
 =?utf-8?B?bFhkMi9RWFRtWU9yMER0NGhpSWhtRm9Eak13WXYvWC9FdXFqWjVyNXlDNEhU?=
 =?utf-8?B?cGVLY2haUXRJN2JCYk1iUGZBbUg1ZjVQUDV1dG9EYTRqS0hpak80OU53NGdX?=
 =?utf-8?B?cUNMcDJpRm1wNlJxanNoNlhoN3RMSnVZTmx2T3dneGN3VEtZcmpaTkpOUzZH?=
 =?utf-8?B?NG4ySlZGQzFtMGRJaTZJSTJ2THVNcHpkVm5OTFlvNGo4VlhiclBGdDBMcUV2?=
 =?utf-8?B?ZTJnak9EN2V3NW9mN0I1WE1PZGp5Z3g2L2lNZDBXeEUrZGJTS0FZdkZsRVRT?=
 =?utf-8?B?R1d6b3VaYk40YkU1aEsxdEREdzFpeFEvMUpTeENmeU96VFRQYWxQVEpSV0tC?=
 =?utf-8?B?ZmhyM09tamdFU1RENGZtNUNmYWNQWUQxZDFWL3ZyWnAvVGdLS284SFpoN1pr?=
 =?utf-8?B?NElXNHU3cWk3eFM0MWxwbllGOUVTWlBscXprd1lhSy9kUEx2T1hVSGt6dG9i?=
 =?utf-8?B?Y045RHhCcURlNGo0ejZGUEpEVzdzd3ZNZ0VzUnZFdS92a0RrQk9QbWdQK1dU?=
 =?utf-8?B?UVgwUUtVUDdvRmxVQVVqY25BNTZESFZJOC9zSkEwMnFaei9mY0NzakJCa2l6?=
 =?utf-8?B?S3NmQml1WEFuRDRpcmZablpuQnhkV0NRcnIyZTI5Zk5mQXN5ajlycFdrMTky?=
 =?utf-8?B?RTdnSFlWK1Bqd2tyQkZrSEJJM21uaS9jbG9BWk85YmNOS20xcGRHQXhDSFR0?=
 =?utf-8?B?NWVsTTJ5aXNjOE1EYTVLWFNiSFczZ3ZxRDRSS0l5WEthbm9zM1lBSkVESkcx?=
 =?utf-8?B?QTFLOHd2QXhUZVFJK25lUWxnZkdpRE9VM2JqNi92dFZmVVl2bkY0aWJHZmZD?=
 =?utf-8?B?OGwzMlBzaGZRbWRtQlZEYkxwTWlVOXJ6WlBuODg2RlJDS29wYlNuUUkwVzVP?=
 =?utf-8?B?bkZqYkh5Q2tLYk0yNjJaNjhsM2VZN0VMMzRmSVZERkc1bTBrOXU5YnYwcFlq?=
 =?utf-8?B?WkZlK0k4T1p3TlB4eXlyYms4Q3pUMjRCb3RVMTV5M0dVSE5KYkVvMEdxRXBC?=
 =?utf-8?B?OEllVTkwSDdGcFNoUUtSK0E0VFB4cmtHQks0SzhSaU5Ga1VXNU5XVVZibm1o?=
 =?utf-8?Q?ihODmPaN8JCasUJsNlWuRik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6139aa3-65c7-4bf6-c472-08dabc200e93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 15:45:09.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeWp/xABybCjbA1KxvO8WRJ87e1DjTc4xEWHJiuAQwvrWWEuGKmF6wYrcOn8qmDJLi++VC7/brTJCDdo0z13JsNjEAUxxMJCBd+L+Y8OOTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010119
X-Proofpoint-ORIG-GUID: 1s80tL9bTgpUcoG9mFb_79EryPpA_sMS
X-Proofpoint-GUID: 1s80tL9bTgpUcoG9mFb_79EryPpA_sMS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_084537_663219_D806DFD0 
X-CRM114-Status: GOOD (  18.57  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 10/31/22 16:04, Borislav Petkov wrote:
> On Mon, Oct 31, 2022 at 03:36:04PM -0400, Eric DeVolder wrote:
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> What happened to that here:
> 
> https://lore.kernel.org/r/Y1e85gqB3kzlx7qL@zn.tnic
> 
> ?
> 

When I was evaluating the suggestions, I realized that that particular ifdiffery was now used in 
only 3 locations, twice in kernel/crash_core.c and once in x86 crash.c.

With that realization, and the fact that we just jettisoned CONFIG_CRASH_MAX_MEMORY_RANGES for a 
#define, it seemed that there wasn't a compelling need to replace the HOTPLUG_CPU || MEMORY_HOTPLUG 
with a new CRASH_HOTPLUG Kconfig item.

As I'm re-reading that message, I suspect now the preference is to just to strike this ifdiffery 
line in this file and have the code always present?

If the preference is actually for CRASH_HOTPLUG, then let me know.

Thanks!
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
