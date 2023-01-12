Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72285C61DB3
	for <kexec@archiver.kernel.org>; Thu, 12 Jan 2023 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7tMGVdm/eBrVBtvHZ9MJu3lzrPI3Js8OKkWqRceGW8=; b=Zk/xIGfguEc+ntq4DSzCJ/qTC7
	+7JvLof90J+d9lJGbmsCK/TZS1bYAgbKOykl+SnMWtFziyvH3p+gbnP6i+/LBZ5zFcX4QWU5Y7QUv
	um6PucqGyFCJ1W0RMmONIkK85tM8rRauo1VdjdiQwhwk7W84dFXrWmVU3PXcCuC2a8+CFuZ72bbNQ
	AanHWVXEJSQ71oiNoFlDq/MlOZ0Lhh97/JfCoD613GYPHudPebwJp+60nm7CcaXv31eabmA65tGVb
	o+q+Y2f4wEy843SRW0I5KIiIO6CbwhmRLpmZ9UJJE1TgOWizOR+HMHvVfSdMa3mgliM8blSTrO7LB
	Q+JyT/+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1J5-00G1Bx-8u; Thu, 12 Jan 2023 17:24:03 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1Iy-00G19r-SR
	for kexec@lists.infradead.org; Thu, 12 Jan 2023 17:23:58 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CGxUBv006522;
	Thu, 12 Jan 2023 17:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=ffUnrpRE7c0He9V03rX5bDpPpBuOdtRZ467gYTB6fgbskLXER3J7u/UCfG0/sIIIuwbI
 uA+g5g38wAASnjHzvuz05gaDIqqIaQ5k0Xfltq1SjWXmu9k3rdN7FalU6AwBrKq+TPeJ
 qWmkIYJMP1k10meXWfgTQ47IQP+QWDHvZ26qy3K2qfV1Hjt+tm+Lkuq8b7X9yPgqQRoZ
 waBuNctHCbYlsxk0mNZG96DaxnD5VXojT2Dwrfog+GGTO2JLoz1XQa4hj6wCbSFjEAwQ
 qK4Q6vkiJEBn9xPy/DD3XnC1g1BHhl8p//yaVdlHDFksu2cxqHjHnPGdCr5hqs8GpcWV Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22x02bjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jan 2023 17:23:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CFlMhR034199;
	Thu, 12 Jan 2023 17:23:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4grjhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jan 2023 17:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcgJcsd9PpAis35unY8JqmV9IUBmitl7xrSCeXjcST90k/R3pungrSVKNVMl/gIitZXzVpsY/NsGXaJWohnxLZ0yFG+Kh/+K+QQTq76s0ljrn2WI6mj/xnGnALAdqJ8BxVNTsSKMQ37iz/h1W3CSGju36RjZOFIxJUWxVg0mOKp4VKsxaj98ulD4GrrlWRKO6JKsZtWjhlY5lcCfYrg8fj+turVw7XCr0buh9DYExYDPKoW39X6GdiBYxKT8OYJrcBDcvyC6VaOHu7/znDQr6ptXcbcxMmt8QUQIO2AdM3qFQooDQcLYdFy6cydEf1ahrKQ1hiJdT6oqa3mezefogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=T627gUn7B/Ifua58PcntFWkwrx5kCbP/o98YyCQzKSRn5Vlf8P6X1rLqRT3nvlLPEo5i99zZFAYLymMiedK1XBni3MlizaSqAWBKMPG9MUJLon19agPRKZd0kT4odtX29zvohu2sfgvoJcTPLJoh6gZKJP4b8HeWsVf6tPxvhXLcp7z1bmy908sc2WZqTFDZc5InfH9/IduXduU9S5V1YkME4qIY67PGXeZpm7wDGkOlJXtRo4Fy9MXYMa1Gb2azRPrKtQO0XmZdDNAaNCDFOGFlQJ5CTsmx+l+MDpW2FG0l2edlY38TI7xx2+sozOz5hQ/fwNBzAS9hTuIucpZKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=tyZGqRdVabESkQGxzKEEA2n8YJu323igtLvv0Fk/HzmnyxKGB+GFrukF1riCFwv+18qvzYuAIrlweVjBQp6WY+Yd8GOuTnq1ojoOvrZEfxZATLWofCMcGINBq25rrizhxp47QdC4VyQPn3c3EwGUAHneii3dxka41tTpjL9mxpM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 17:23:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 17:23:23 +0000
Message-ID: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
Date: Thu, 12 Jan 2023 11:23:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: cd931f00-b151-4950-2e92-08daf4c1b54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Oy0e97TtdWHyeye7mU7jukcJZUzQEYKvCA04luACz3RbvkJlHMczPZZBGvLICo2Tp3LRocPX7Y4pfYZ1X6KGs0UsnlBmkzGhhaskCZsAKvxKWjOt6kcFymoX7HWvhXLuD6VMI9COR+9M0cFRaMf9XbwDqfEi6kYLr00/HADxQjz9oXDnq5VRJyhcfdEK7l5u3B66DD0l6JSNuiRWxG3PoKTKaVHaN48K5cIn0/nUx+bkvzkKjKieDLaw84DfDulXPDAIqbImtn0m+jHZSqNoQgfehmaNGGacDo7ijIsHIeJIP0C7OZi8kMSbvKIYj/dePQ+sto5NYT+HrLIu2jPXiIlFzQ8v+4X/IH8gh2w0pUwihiqI/2ibdkRohEOYlqotVAAb/TpzuRGPOVt66ce4AqdC3g4qBO2pbW5/DF5HPnHi3ecq4rxhIsxPOHE1ry6tQ9Z+fXG+g2miaiYdJI19UOeFqac8cb0HFqD+KcmLQnfwQmSjeaSHMXv8OX5I3WlfwOCG9UeusD3WVj1HxUXHV20/02yIql3KbqHrxrYIb3mLUeC1KwCx9/AMSKNS5lofH/SlcQISi4jjCAwz9nOXkP/7bTO/PGzoGgbvQtZ1teMgs1rW8gX0lDykpqhnsISnuyWiJKXdEW3UNPooof8izTqAKGnslpDfFi2WG+49LMQfdjwb7FcmhnxgEn0wbMS1fKeuBtfqjW0vQy3TO1Awxy05FFl7VSc6g5L6DmPFYHU=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(31686004)(2906002)(4326008)(5660300002)(6486002)(36756003)(86362001)(31696002)(8936002)(7416002)(41300700001)(66476007)(66556008)(8676002)(66946007)(38100700002)(316002)(53546011)(6506007)(83380400001)(2616005)(6512007)(6666004)(107886003)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Y0JxbCtiUER1ekFQQTlnRmhWUEtYWHJDUGt3OGQ5WE9xdHJjK0o0VTZxVEF2?=
 =?utf-8?B?QzkwcU4veFp1MEtnQk5pVTJoKytwS0xwSTJBYUorbkgxNkJYWXN3dEs5ZDhV?=
 =?utf-8?B?Z3hSaEVnWGlNbmZuZkkrRlJmdUFyY1hpWDFYVDdtUURTb2x0bHY3ZWYwVWVS?=
 =?utf-8?B?NUtCWUd6WWNvV0VOeVROQWJzUHRLQ0dCS2ZDZk45aFd2SHZrRWhNbk50VjJp?=
 =?utf-8?B?M2lVL2h2STVzVDI1d2hvVGJmOVg2ZXcyZzMrZDNwZ2NaN2lnTUJ2NkN4M3VL?=
 =?utf-8?B?bjdqbUllOGN5b0REY012ZHpUK1ZkamRTcDR4MWttTXNBVDhqK2NKN3drV3Fy?=
 =?utf-8?B?RWlvdlZ2MmpabndnV0dUQ1RNdkplWlBZdS9sT0JTa0Z4Q2pDRm9VSjhGaDEy?=
 =?utf-8?B?eU1JQ25zcGpYS3BJVE1oTnhuY283U3Q2bUpJcnVMRkNWR3VwQnNqWGlzeUpq?=
 =?utf-8?B?Z1lVZXlxU0tMaEJFMGRPU3JhdlB4L0ppZnBJZ2d2bnUxbjNBUU92VmNhZ3NC?=
 =?utf-8?B?M3FyQTFQWGtNWGk2bmhpMzUvREpEYlR2bGJjc1BLd29Id2ttbDhyRmcvc0Zw?=
 =?utf-8?B?SGJ3UFlJRTFGcmpaTzZOdG5YUVNZTDQvdERqKys0bEd6ci9YNkxOUDJBZCtv?=
 =?utf-8?B?cHcyeWt5WmxWSUZZS2NNRnJWVm5aVldkMEJiMUx2NnI5U3lpQm1BSHhUWGlP?=
 =?utf-8?B?RHJkeGJQNDNwTzN5T2h0blVGYmdqMHAwQ1h2bHNUQkZnb2R1Tmxqbm41ZWor?=
 =?utf-8?B?QTlzenAwclJ2RS9xMnRCclpCMnE1eElCNUFrVExlRW1HaDh3RWhJa3dPZThQ?=
 =?utf-8?B?elc3R3NKeGZJeWVkVVZ2Q2w4Q2FJVjJKcU9hcG00bitpSExWS2NYVkhLK29X?=
 =?utf-8?B?M0hxRUJ5cG5LTG5xWFdNalJVN1lRWStkUnNETFJuVWtCM2hqRHRjeHNqejlk?=
 =?utf-8?B?MzNIcDR3U3cxSGV4b1N2dlR5amN4SlV0bC95OXdkTzdqN3RmNkVzRjY4cktK?=
 =?utf-8?B?UG95QnNxTjNBZStmS0RGK05ZL01jQUtxN0ZpdUdEWXlTUFJGY21VenpVYlNp?=
 =?utf-8?B?V1VoN0xKREtUV0lFYUF3ZVhRM3JBSXdFdlhidUthUldkYW9BYkJwR3NOTmlZ?=
 =?utf-8?B?OGJNWWJUcTRjWlFqb0RQcjBYbGhDRE9NditYQUtCbUR0QTBsZ2Q4eXZBOGhY?=
 =?utf-8?B?eEhSWmFpWjlTNStzZ2RnVEo1bUpLcmdlbTFtMG9hSWNhbytZVzNkVTJFQldT?=
 =?utf-8?B?RTdHbGNGcWtHUmh1NzhrdWJkdS9QTlVyWWJsZDFucm9lNEM2L1Fia01qdXRv?=
 =?utf-8?B?ZzBQQlIrcUFwM3NIbjNLKzhKT2Zub0dKTjEzSlNvblo4U0c1VFpIN0J2WFlH?=
 =?utf-8?B?Y05lS3Y4cHBaSlJaK0pRRG41UldkeXJsc21wVHJqVjN1enpEeUt5M1diSFpT?=
 =?utf-8?B?L3ZoelZLRDRpbGs1REhLVDdaNXZsUndsT3pMV1RiNWFOSTlUVnU0dmdsVEFJ?=
 =?utf-8?B?YnlwL1lNWUdDQTlsdlJaaTY4dXZ0cWdyWC9US2w4elpKRU9WZ29qSVlaK1pj?=
 =?utf-8?B?V3hBSTNhTnFUZlA5RGxBRXpIM2VsK0JibjVvSTZ2cjdkS0h5Z2paR09sWlJX?=
 =?utf-8?B?SytIZkFic0RPSlJSZUxTendLWm5TSzhITVorenlxdk15SHgxakNKWm5hRlE1?=
 =?utf-8?B?ck1pOUlwa0ZjaWJEWnhJMWwyVUFFMlY5MmhEamkrbkRjZ2cyRExVVW9hS3dy?=
 =?utf-8?B?L1dnbnhZVTVzMHNvampOL25KMXpyWlRQRk0rZENpWmdNdlNCVXJQTy8xd00w?=
 =?utf-8?B?eElGSXNxQTZOc1orQUlDZ3ZGTURZanQ0NjVEZW9RNU1OYlNkelk3czJKdDk0?=
 =?utf-8?B?enA4Q0ZFOWRYcWtZWitmaHdMOE5sNzRublNER2QveExOdUNZR3ArcjBVOXRQ?=
 =?utf-8?B?WGluZ2JsQitQK2xtTHhOZ2I0VVkzRUhYQlA0THZ5cnJqZEFRN0ovakFkUGRM?=
 =?utf-8?B?cFh5MitOdXZONzQ3Rk1Cemo5OE5GeW1VM0twa1lWOHhzcGxmcmxwY0ZNTGlG?=
 =?utf-8?B?dStobHVuUTl3aGVqWSt0ZzVjTmVkZEVGd3k1V25oL21GVWUramJyZDFtaTZw?=
 =?utf-8?B?TkxVUGhrYzVudHE0VTUrajJ5L3FrbmxuQmtubFdad2hRaFlKR3JCWU1yTWNn?=
 =?utf-8?Q?D+wu3TUi4G6Tz59t6sKVFaU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?R1hxL2EvVGxrQWJDei9oZ1JqWCtVUEJ5WEs3bkxHUm5FOVBOM0dXUWJ0Rjdu?=
 =?utf-8?B?OHlDVkFIaGQ3eXNuemdoeVIrRkZlRTl4cTVWclVxU3loRXVpVElQRzdTTk9X?=
 =?utf-8?B?cGxpbWU1bk4zMWltZHc3VWNlSG9NTkFtbW9sRUJMOHF4WG1WY1pROWJFZFB4?=
 =?utf-8?B?My9kZDlDdVV2YlFRZk5XRXd0ais5UkNHRThMZm9xVk5TdjRMeXQ3c3RSSWF3?=
 =?utf-8?B?NWxtWlJvalF6aFRIRFU0MlZDcjFkOFVDc01taVlKRWlmdE40ZXlHb3djS0hD?=
 =?utf-8?B?Z2Z3VFE3SzRxZUJaMWlxVTlxQ2ljQS9Hc2xiZElhYmdRSWU5ajk0RHBqTjd5?=
 =?utf-8?B?V3ozNkNNcGhieDhlQ1dMTUJkQmVuNStDV3JZb3ZlM2c4bE5TRW9UY0NWWUdR?=
 =?utf-8?B?WTFoMFc1T1QzMFNvRyttUWc1QTg4MzhVN1NDZWZ2WStDRUhRc28wcXRCaUpZ?=
 =?utf-8?B?dG5SOW4xeE1HM24vYTdubzh0WlhkTnVaK0VDNk9FUVZYN1Z2WithRlVrdHYv?=
 =?utf-8?B?TVhBSFA0cEpIYWpIVHQ2RG9KUTIrbjFYaWpWNTltdmF1dnc5M0R3TXNxTEE4?=
 =?utf-8?B?U09PSDJTVnpNWEFnTG5ITENXOWl5YWlSakMvOVVoT241UW1CSEhwQWRLSkEx?=
 =?utf-8?B?SGZITFdLVmc5dUlUYlNNTGtjN0Z3aU80RTJZbWFRbFlCY2NCZFJIZXNuVGwx?=
 =?utf-8?B?NFN1bUt4emd0MVBJMnhyTUUwNGR1cWNDTkhlZjR6dmFUb1FIcE9qa2tpekVK?=
 =?utf-8?B?dlhuWWl6dG1CN2s1QTVwa3dWTzliWkdsVG9GdGxJb3Q0ak5NbjlMYTh2VzhD?=
 =?utf-8?B?cE5GYUdMalNjN0VsbkRFZmQxMll1NUFWUGxSakRoRXhMUmtsdFZza3VpYlVs?=
 =?utf-8?B?cllob0Ryc2Ryb1F1SW5RTjRmL2F0cEdzZ2MyM2lSTCswR3lkTXZCKytSSGZq?=
 =?utf-8?B?bDhUZXRJN21nakY1cnVTQlovbFE0UmFjdzJPdnZWR0l6TDF4dEpqZ3FsalBL?=
 =?utf-8?B?RmkyRlJrNHIydzczQmY4OTBLY1B0ckRPNEF1VE9aNkpiamtZSnZnWVU2R2pi?=
 =?utf-8?B?azc0Qm5icUczWjRNSDhZUUNaN1VxS0s4eURFYmRrbTl4Zm1YSlJscHFpOUFs?=
 =?utf-8?B?QmdCbG5xNDJVaHk1dFlVMU13RjZiVEljS3o5T3N3SWxZWlZpZk9JRkJheEFY?=
 =?utf-8?B?VEM4bEt6ZnRXWVpVRVljaVdVWENRL251b25GYlRWV2YwdFJiYjdBTGpRRlVH?=
 =?utf-8?B?MmZ6ZWwyQTNva2VaNkI1R0MxQ0hXdDEzVlc0ZWJTVzdWUW1kelNxcE5xbExL?=
 =?utf-8?B?UFlTVGFwL2kxZFJiVy9oZEJVNVE4MEswS3hzN1cxUks0VWd3ZkpsNDBZR0xr?=
 =?utf-8?B?enBIMXd6VldMUFphNUtXM2RGeUpPbTBzaThRcDhjY21Wc3ArUzROWVJsSHdI?=
 =?utf-8?B?MjdLS0JNaGRVTVQ0ZUE0TzA1eVBvdXNtendjN1E0eDVRd3dUbklINWdsRUlm?=
 =?utf-8?B?VFZwbGR6dmtidVAxNlNsTmZtOWpCeStESXFKSDZhM0crcTh3U010VVhmbm9Q?=
 =?utf-8?Q?cNUupbqGtWKLoJzuulXU7igF0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd931f00-b151-4950-2e92-08daf4c1b54d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 17:23:23.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epYOvlu29za8OyFLSDRebYVOtVS9222mfyR0CBg/eXAUceeFDHB/8CGH8nUAhgvflKvJ3bJxJkExQhX6FTJstoLaOMreCbiq3smMfyDGiTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120126
X-Proofpoint-ORIG-GUID: K00GkrcJuxRvu5tsPR_eN84w5NWozRbG
X-Proofpoint-GUID: K00GkrcJuxRvu5tsPR_eN84w5NWozRbG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_092356_962768_37AF2155 
X-CRM114-Status: GOOD (  25.32  )
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

CgpPbiAxLzgvMjMgMjM6MDUsIFNvdXJhYmggSmFpbiB3cm90ZToKPiAKPiBPbiAwOS8xMi8yMiAy
MTowNiwgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4gQXQgdGhlIG91dGNvbWUgb2YgdGhpcyBwYXRj
aCBzZXQsIHRoZSBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKQo+PiBpcyB1dGlsaXplZCBv
biBib3RoIHRoZSBrZXhlY19maWxlX2xvYWQoKSBhbmQga2V4ZWNfbG9hZCgpIHBhdGhzLiBBcwo+
PiBzdWNoLCBuZWVkIHRvIG1vdmUgdGhpcyBmdW5jdGlvbiBvdXQgb2Yga2V4ZWNfZmlsZS5jIGFu
ZCBpbnRvIGEKPj4gY29tbW9uIGxvY2F0aW9uIGNyYXNoX2NvcmUuYy4KPj4KPj4gTm8gZnVuY3Rp
b25hbGl0eSBjaGFuZ2UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgRGVWb2xkZXIgPGVyaWMu
ZGV2b2xkZXJAb3JhY2xlLmNvbT4KPj4gQWNrZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPgo+PiAtLS0KPj4gwqAga2VybmVsL2NyYXNoX2NvcmUuYyB8IDEwMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCBrZXJuZWwva2V4ZWNfZmlsZS5j
IHzCoCA5OSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IMKg
IDIgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDk5IGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMK
Pj4gaW5kZXggYTBlYjRkNWNmNTU3Li40NmMxNjBkMTQwNDUgMTAwNjQ0Cj4+IC0tLSBhL2tlcm5l
bC9jcmFzaF9jb3JlLmMKPj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+PiBAQCAtMTAsNiAr
MTAsNyBAQAo+PiDCoCAjaW5jbHVkZSA8bGludXgvdXRzbmFtZS5oPgo+PiDCoCAjaW5jbHVkZSA8
bGludXgvdm1hbGxvYy5oPgo+PiDCoCAjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4KPj4gKyNpbmNs
dWRlIDxsaW51eC9rZXhlYy5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4KPj4gwqAgI2lu
Y2x1ZGUgPGFzbS9zZWN0aW9ucy5oPgo+PiBAQCAtMzE0LDYgKzMxNSwxMDUgQEAgc3RhdGljIGlu
dCBfX2luaXQgcGFyc2VfY3Jhc2hrZXJuZWxfZHVtbXkoY2hhciAqYXJnKQo+PiDCoCB9Cj4+IMKg
IGVhcmx5X3BhcmFtKCJjcmFzaGtlcm5lbCIsIHBhcnNlX2NyYXNoa2VybmVsX2R1bW15KTsKPj4g
K2ludCBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoc3RydWN0IGNyYXNoX21lbSAqbWVtLCBp
bnQgbmVlZF9rZXJuZWxfbWFwLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAq
KmFkZHIsIHVuc2lnbmVkIGxvbmcgKnN6KQo+PiArewo+PiArwqDCoMKgIEVsZjY0X0VoZHIgKmVo
ZHI7Cj4+ICvCoMKgwqAgRWxmNjRfUGhkciAqcGhkcjsKPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25n
IG5yX2NwdXMgPSBudW1fcG9zc2libGVfY3B1cygpLCBucl9waGRyLCBlbGZfc3o7Cj4+ICvCoMKg
wqAgdW5zaWduZWQgY2hhciAqYnVmOwo+PiArwqDCoMKgIHVuc2lnbmVkIGludCBjcHUsIGk7Cj4+
ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBsb25nIG5vdGVzX2FkZHI7Cj4+ICvCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBtc3RhcnQsIG1lbmQ7Cj4+ICsKPj4gK8KgwqDCoCAvKiBleHRyYSBwaGRyIGZvciB2
bWNvcmVpbmZvIEVMRiBub3RlICovCj4+ICvCoMKgwqAgbnJfcGhkciA9IG5yX2NwdXMgKyAxOwo+
PiArwqDCoMKgIG5yX3BoZHIgKz0gbWVtLT5ucl9yYW5nZXM7Cj4+ICsKPj4gK8KgwqDCoCAvKgo+
PiArwqDCoMKgwqAgKiBrZXhlYy10b29scyBjcmVhdGVzIGFuIGV4dHJhIFBUX0xPQUQgcGhkciBm
b3Iga2VybmVsIHRleHQgbWFwcGluZwo+PiArwqDCoMKgwqAgKiBhcmVhIChmb3IgZXhhbXBsZSwg
ZmZmZmZmZmY4MDAwMDAwMCAtIGZmZmZmZmZmYTAwMDAwMDAgb24geDg2XzY0KS4KPj4gK8KgwqDC
oMKgICogSSB0aGluayB0aGlzIGlzIHJlcXVpcmVkIGJ5IHRvb2xzIGxpa2UgZ2RiLiBTbyBzYW1l
IHBoeXNpY2FsCj4+ICvCoMKgwqDCoCAqIG1lbW9yeSB3aWxsIGJlIG1hcHBlZCBpbiB0d28gRUxG
IGhlYWRlcnMuIE9uZSB3aWxsIGNvbnRhaW4ga2VybmVsCj4+ICvCoMKgwqDCoCAqIHRleHQgdmly
dHVhbCBhZGRyZXNzZXMgYW5kIG90aGVyIHdpbGwgaGF2ZSBfX3ZhKHBoeXNpY2FsKSBhZGRyZXNz
ZXMuCj4+ICvCoMKgwqDCoCAqLwo+PiArCj4+ICvCoMKgwqAgbnJfcGhkcisrOwo+PiArwqDCoMKg
IGVsZl9zeiA9IHNpemVvZihFbGY2NF9FaGRyKSArIG5yX3BoZHIgKiBzaXplb2YoRWxmNjRfUGhk
cik7Cj4+ICvCoMKgwqAgZWxmX3N6ID0gQUxJR04oZWxmX3N6LCBFTEZfQ09SRV9IRUFERVJfQUxJ
R04pOwo+IFNlZW1zIGxpa2UgYWJvdmUgZnVuY3Rpb24gaXMgb3V0IG9mIENPTkZJR19LRVhFQ19G
SUxFIGJ1dCBzb21lIG9mIHRoZQo+IHN0cnVjdHVyZS9hdHRyaWJ1dGVzIGxpa2UgY3Jhc2hfbWVt
IGFuZMKgRUxGX0NPUkVfSEVBREVSX0FMSUdOIGFyZQo+IHN0aWxsIGRlZmluZWQgdW5kZXIgQ09O
RklHX0tFWEVDX0ZJTEUgKGxvb2sgZm9yIGluY2x1ZGUvbGludXgva2V4ZWMuaCkuCj4gCj4gVGhp
cyBsZWFkcyB0byBrZXJuZWwgYnVpbGQgaXNzdWUgd2hlbiBDT05GSUdfS0VYRUNfRklMRSBpcyBk
aXNhYmxlZC4KPiAKPiBUaGFua3MsCj4gU291cmFiaCBKYWluCgpBZnRlciBsb29raW5nIGludG8g
dGhpcyBmb3IgYSBiaXQsIHRvIGFsbG93IGhvdHBsdWcgd2l0aG91dCBrZXhlY19maWxlIHdvdWxk
IHJlcXVpcmUgcXVpdGUgYSBiaXQgb2YgCmNvZGUgbW92ZW1lbnQuIFdoeT8gQmVjYXVzZSBob3Rw
bHVnIGlzIGJhc2ljYWxseSBidWlsdCBvbiB0b3Agb2YgKHBhcnQgb2YpIHRoZSBpbmZyYXN0cnVj
dHVyZSB0aGF0IAp3YXMgbmVlZGVkIGZvciBrZXhlY19maWxlLgoKSSdkIGJlIGluY2xpbmVkIHRv
IHN1Z2dlc3QgdGhhdCBLRVhFQ19GSUxFIGJlIGEgcmVxdWlyZWQgZGVwZW5kZW5jeSBmb3IgQ1JB
U0hfSE9UUExVRywgaWU6CgogIGNvbmZpZyBDUkFTSF9IT1RQTFVHCiAgICAgICAgIGJvb2wgIlVw
ZGF0ZSB0aGUgY3Jhc2ggZWxmY29yZWhkciBvbiBzeXN0ZW0gY29uZmlndXJhdGlvbiBjaGFuZ2Vz
IgogICAgICAgICBkZWZhdWx0IG4KLSAgICAgICBkZXBlbmRzIG9uIENSQVNIX0RVTVAgJiYgKEhP
VFBMVUdfQ1BVIHx8IE1FTU9SWV9IT1RQTFVHKQorICAgICAgIGRlcGVuZHMgb24gQ1JBU0hfRFVN
UCAmJiBLRVhFQ19GSUxFICYmIChIT1RQTFVHX0NQVSB8fCBNRU1PUllfSE9UUExVRykKCgpJZiB0
aGF0IGlzbid0IGZlYXNpYmxlLCB0aGVuIGl0IHdvdWxkIGFwcGVhciBxdWl0ZSBhIGJpdCBvZiBz
dXJnZXJ5IGlzIG5lZWRlZCB0byBwcm9wZXJseSBzZXBhcmF0ZSAKb3V0IHRoZSBpdGVtcyBob3Rw
bHVnIG5lZWRzIGZyb20ga2V4ZWNfZmlsZS4KClRob3VnaHRzPwplcmljCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
