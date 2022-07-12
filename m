Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEDAC43334
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPekvrNpRAh241n9ykRltxOXzAAqwcVcKf2eODlkZc4=; b=CQ1BkOt9JdHw7Pmm/RBd/z56x1
	3Z83CDw3IDmc+HH2r/9+PyJrnY6o2cxQDy6HAIBp8mBxrbWt+DQJmu8KY+rRuqYECAXY3Pa8s4LiO
	YHOZAcM87CUkpT4yJAS/HOh6F4cOPFlr1pvkyfi/uvePATUDSxmH7lGf71RmcaIaklJp31Euc1Lqr
	tAF0zz0OREqEcG6oFl+r3TucFuE5p9XrAlScqEdUkzYeLmDE3W8qJauV1UECSqwerft5CqKMv/EIX
	oaak8tR4FMs27eafo5VzCK2Q7ImvBh/KxfgJYFadekq30xRs1leZEqxqKLqeo8j4MLPXYezuaGwVF
	DojVHCIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBMZm-00EaoI-GZ; Tue, 12 Jul 2022 20:33:46 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBMZj-00EaG0-8L
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 20:33:44 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CKTSat003982;
	Tue, 12 Jul 2022 20:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=zRpgQth4ROPrETDlMYdIwe+ooKNAS9J8njvDtqOmQE8Xe1czvFm+MDPg+IQYu8DBYEIb
 pn47tyiA8KnWgiT+Rc7/sAVWoMtqLrHh/B2xfaF6dVHzCWvtjxNeuGpx+U18u3McD1GW
 Dy3ki+tWzbqjda6tH1+iAjRL07hQdebPoNEfvhsjGjxze91/MCsOkf2GJxphzH7zcwLW
 h7kSf4PzKJqlehcTeQzM335U7JvD6qX7TSdjBG6GFymzD+1uYYH7pWJK2a8iKJE5JHqL
 XcbNuEr5d4m/xccsvQ5EpyAi/G2HsnKQKOzSPA3xuVkYkCP38AzYTF56cahh/czPYQRR /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrg884-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Jul 2022 20:31:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CKBZFT013991;
	Tue, 12 Jul 2022 20:31:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70440s88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Jul 2022 20:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD9wBov/IUdL+Czw+7RTXwN5hHc9fmfO69wQQ+wwvp1ZYkmhZENeKHNtT5V20WaK/zRbEFBDhZFQ+9Wk0ORnu6rRB+o4Gz6UWxWZQEjMe+GaGg2BZ1wQ3Z9097yfsCb7sn4xAJCDqyIANVMGbiRfPiUvlCnoLDNJ3QIx1JvscBqhI3lStmNCiDLvuZqr/Tloq87y65RFGTRoaLlYMNeU4ni4StZppb4dFXM1E+1xzWtxeIii+pFgd2aJBgX1NRY/q3IDIZtbbRXbQa1me51FdXXj/cdUuT88s3HO0knxEKyX5Z8pSz929Z16ItskCzvM39uEBG5S5TJHMa2yjPZAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=aidDdN5FJeBMLOU7t6Q8hRndGuwK+hqGXvvi5h7HGwEsZ6MaUz7C9fAWnW14V7I10245Ty9FWc/wLddOHKWAdctRU5KeIfSFK4BDY19BiqbbhBQ4+KmoRaL/ngQr3CyM07OgrPvaNMBfvmSEagD56Xbvev4vgvVteUdZ8dHbtAzovd2tAi7wMFUQQjx4l6wCehJICwYsaUX3ip+voGrtZtE1kPsLf6yUb9i7N4lhrLwaei1XQ5DncFzsJbJz8VAb0s7QWs0Smnyq6hb+dylqrxRkVEA5AW41Sa81qOB1O4NWgjcQ8FAVHn/puIEG2qExsdytBobGWmwUbr5ky3QwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvii7AsFKlHLHw7x4oCkw0zrJvp6OqeyJeG3nn7LKdk=;
 b=dZZLXf9cfXtYFEzIR7dOICU6Fu6sgZRRlBsOZc0HWYQO4fzT2RFyyqe4mHrwi8+tjdO46rblHNTmtMDISXfaWTbw6jFwLltobtz9SfjQ2hts20YRfAM/bDYV9MIjks+H08xgdyBtXAlB3sGhnHtY+2L09y5GFKB3V3LrPdhN2Nc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 20:31:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:31:19 +0000
Message-ID: <cd0f60ef-9c1a-69c4-2971-df5b2c43cc21@oracle.com>
Date: Tue, 12 Jul 2022 15:31:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
 <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
 <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
X-ClientProxiedBy: DM6PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:5:100::49) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c429e62-b8aa-4ad6-f3d2-08da644579f1
X-MS-TrafficTypeDiagnostic: PH7PR10MB6036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	IjsnCB0dq4M6bPuQ3LuDgnkBRrHcwNtsn6a7VO8etPznbfNKYPStrbd9cMTRtrToc97u/3iAKKrBCrv4wdYGExs4Mzi4wF+OS0+TDPz3BlRBNSRSPGQgJb7Bhmot2Yeu2VdVxz8xBDy0oawGb8Hu1/8uC4gOsN45VsHhdSkpI0g2eKGQx5L2qRoxFwgFB6PRzGOzxUP2YEplqj3eQy7qepCOnkGj1d752aWnlaAJG1jD7c31ODErWucVttwGYYAEvZcjNyuUn+yDxwwVLoNsB/8g2H7BgbfoWZCAKYJCGasRYjPpqLneS7w5w9JbeHIO0q5wSCrEO0JyzUbiLBVFBVqveLGH0zaWq+LeLY56xDPJZqu164Ysy9CZJKfGXI+OmPEVcM7fOFif4iNW4JFWZUcZqntfDONMp0/X38XECAwtDoNM3B2MdDKk35pqUTIfOjtohCqvyykBrHfr+rfHkgiVBMal39voQP+13Lbb/iVbkacOEs+PMAcdKxrFPqtWwdmjJLj2XZf1mQxqxjri4WX6Mp8wuszibqD/F8xtjg+sGJnCkLcGYJp3g1JXZ0ixjuq0g4JgdsoOqJqlFQlc55drsDAdcNKMi3i4rs3U9QzMcum0qH70yQ63MgwXUW8g5fXezAB2Jg1IW41qmRvt+0nK6O9fw8fNGtXzAiT1yDFfNCiBhnOLyBTB5+zP8YV9Yg6Bp+zp4yG7hw0vcwvyn8+sIDORJGea1nmVIOcHqxDpIFEmz3FMOiHT8erDlTt1OqYUtyDoBHqGaspn1cVfCwdNBzk3kGwBhim4yO+XbmaRI3yToWR27Crg+Hk75CsNAASzr/Wcr5sKdE+dLVY44w==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(366004)(376002)(6666004)(6506007)(41300700001)(66946007)(478600001)(66476007)(316002)(6486002)(53546011)(6916009)(31686004)(8936002)(8676002)(2906002)(66556008)(7416002)(4326008)(5660300002)(107886003)(36756003)(86362001)(186003)(31696002)(6512007)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dUE4QWZpeGtiUm0vczh6NElnYllweiswZk9mdEF3QUpxNDJ6RWZSQjFUZHFs?=
 =?utf-8?B?OU43blNmdmJFaU1NZHJTb2xXaUpHbEVMamJmcnl3SjV2QXdNRlluU2hvODRZ?=
 =?utf-8?B?Y3BKSStEeDU2M0ZZQXduVVpRL1dYSGhqYm5OaXhualByVlBFbS9TREx4eFdZ?=
 =?utf-8?B?UlZjcXhESUZxVDdlNUptSG1qd0txR05kZlFXN0tTOVJHeXQ4eTNMUTBNdW00?=
 =?utf-8?B?Q2VQMWRZekVwK2tqTkZORThXR1FPR1NXRUFkUlgzQWExbFJkNkNuQUlYRDlM?=
 =?utf-8?B?RWdDZXZJWTVjOHVHeVlBWnBEZkc0WjNiTENaMEVnT1dTZWhuMHZyOER0eDZq?=
 =?utf-8?B?bVFGY3BqWUJrRmsrV0RxSDBycEhHcTVSQStwNjV5V0RPaFlhK3JQbUZKcEQy?=
 =?utf-8?B?M3FObkUxUEJmR0xKSDdiYTVQQjZJZkVQaGpXbStteTVpbUhOSWNiMDhVdjlJ?=
 =?utf-8?B?RFgxVkUwaWlaMWU5OThIRURMZjc0L2M1Vm5sUmJOTTBObVpkQWVYY1NyUm1r?=
 =?utf-8?B?Mmhqd1YxNXZ0R2xaSTNnVk9BZ3AwaklRSnEzUllSMHkvUi9LbWREcjB6aFpN?=
 =?utf-8?B?U3NPNEVnRE41RTU5KzdiK2l6cjczNUdiQ3g3UzdqTjZ4OU1hYlovSWs5RUxa?=
 =?utf-8?B?THVnTEEyNjMvMmhSVG9Oc3lpZCs5L0lBczR3UEw5M2ZLNEM3YWJQUVgrWXlr?=
 =?utf-8?B?aUJQdUx1ZTNiT2JOaThOd20vSW1pTkl2aUNNRWZLYS9oUlRuM0tiUmh3SnIr?=
 =?utf-8?B?NFdHR1FiZENzOTZMZFUxekd0ODZlbDhlUGJSbC9RbVJHSWM4OXgxMkM2bDVE?=
 =?utf-8?B?N2FqWm1KVk9KeFhpUWpkbmZMRjBUckNqSEpqaUJreGVhcmRqdG4yZTVqUGhB?=
 =?utf-8?B?Y1R2Ym1sRWpWRjRBb3NkSGxTMWZITDk1RkR4N0pnQ2Q0YTJqbURtUXAySHV2?=
 =?utf-8?B?WlBCRWpoT3c4MjF1a0dseU80dnNaZjJ1MFhscGxpMlRJNHlTTWliZysyaHBJ?=
 =?utf-8?B?QnR2cVBjUUFkUmlITnhaTkNGeXZhT2ppZmcvQmx3RU45dHgyMXd5ekxpREpD?=
 =?utf-8?B?alZ3cXlNK2l1NHFuMmE4eENHMENFTjVnMUVUWWZoUklqTkI0T0kzM0F1dXZ4?=
 =?utf-8?B?NjllSGs0RWVQazdVem53VEZtM1JIVGtodjU0a0pBY2xPSXhuMVc2OFpGa3RZ?=
 =?utf-8?B?TlhBWHo3MGFYNTRqUFpWZTIzK2d6VC9TUm1TVmdDOURRZm9lMGV3Uk1CNUQ5?=
 =?utf-8?B?MFJVcmNPRlFQT0Z6MDBSdjNBZzRUeWtSaUdhRUpKSTA1bjlVVUhFVG5lQWlm?=
 =?utf-8?B?Vyt0ZmlXVTlaRHVCUmpYa1FZajFIY3QrT3VHZjJFVEttN3FTYjg0blZGRitK?=
 =?utf-8?B?bWJleklvOVU5NTBUN1RleTNXVS8vU2lJbkxEQ053K2x2aTZXNzN0QkptR2VD?=
 =?utf-8?B?bW1QaEpmQ0NGU0xmVmZaWVc3K0VHS1VjSG5nalJ1bXJoSlBteXBQaC8wWDVr?=
 =?utf-8?B?Sy85NVhNTW9zVkwrVzF0alNvRkFzV0padjJxMFFmMXhsYVNuRnNSczk0Q2U4?=
 =?utf-8?B?dmY2bE1NRmM4UERXY0pacVk2VGRnWUM4M0ZScU5WSjJCMmZzdUtyWXcwaGYz?=
 =?utf-8?B?WUhMNUFMZzFucDRuRHV5TGNrWkVNdEdXcXlWVVErc2dlajYzZFFLcThUTDNP?=
 =?utf-8?B?WmNkZGhrSkszVmJJREhPV0w2ZEJ5NDMrUGNMQzBtU3l3OWNFeEpRTjdnM3RZ?=
 =?utf-8?B?TnVROC9vbm5JeGZKYjY5ait2c2RjVlkzaWhJL29jSlVNaG0walVtQ29pbERh?=
 =?utf-8?B?bjVVN2FXM0VXek53WWpDRjNOT2xYY2dNOE5DKzE1YjlJdjhQQW5QbS9YVkFK?=
 =?utf-8?B?SFN6ZTBQSFBxamVYOU9KaGdsVVlxQi9WOGRka0RsVDRqWWJQQjBvMGxoQXB4?=
 =?utf-8?B?M0d4dGZPSk85WUtmQmxFdWpNRDhkcTNQODgrRDhRVnFDUVZUSjVtMG9XcU5w?=
 =?utf-8?B?UTdRNTZNcXZUc2dPNzh0WmJsYlc5cHV0bVNnN21JLzZHY3oyOURNaUFzWkQ4?=
 =?utf-8?B?SDVDM3MrcHArVkwvNHZvT2g4S1l0TEIwMlc1L0lmcHRXbWhCUTc3Zy85TnNH?=
 =?utf-8?B?NEc0REViK3lqMWdjS2hwK2tqaFk1SzZtNnllY09pd09SZEdkKzdJUUVkMFlG?=
 =?utf-8?Q?k8InSFyXgJIXBprP7lMO5ek=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c429e62-b8aa-4ad6-f3d2-08da644579f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 20:31:19.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS4UjpIWAdApcFol1eQRadWJlGSZBKnm/AEdfShrK2dRXcL3bSxqSEa7CLuuv8LXAsu5mETS2/vFs/v5cVvZ5szL0HqeVN0nWDYl5Q2p74s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120082
X-Proofpoint-GUID: NABIIOeQtep1iKYOm2ZBCSLLYrd89BBI
X-Proofpoint-ORIG-GUID: NABIIOeQtep1iKYOm2ZBCSLLYrd89BBI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_133343_442759_7431DA66 
X-CRM114-Status: GOOD (  19.84  )
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

CgpPbiA3LzExLzIyIDA0OjU3LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9uIDA3LzA3LzIyIGF0IDA3
OjU1YW0sIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDYvMjAvMjIgMDA6MDYsIFNv
dXJhYmggSmFpbiB3cm90ZToKPj4+IEhlbGxvIEVyaWMsCj4+Pgo+Pj4gT24gMTQvMDYvMjIgMDQ6
MTIsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Pj4gRm9yIHg4Nl82NCwgd2hlbiBDUFUgb3IgbWVt
b3J5IGlzIGhvdCB1bi9wbHVnZ2VkLCB0aGUgY3Jhc2gKPj4+PiBlbGZjb3JlaGRyLCB3aGljaCBk
ZXNjcmliZXMgdGhlIENQVXMgYW5kIG1lbW9yeSBpbiB0aGUgc3lzdGVtLAo+Pj4+IG11c3QgYWxz
byBiZSB1cGRhdGVkLgo+Pj4+Cj4+Pj4gV2hlbiBsb2FkaW5nIHRoZSBjcmFzaCBrZXJuZWwgdmlh
IGtleGVjX2xvYWQgb3Iga2V4ZWNfZmlsZV9sb2FkLAo+Pj4+IHRoZSBlbGZjb3JlaGRyIGlzIGlk
ZW50aWZpZWQgYXQgcnVuIHRpbWUgaW4KPj4+PiBjcmFzaF9jb3JlOmhhbmRsZV9ob3RwbHVnX2V2
ZW50KCkuCj4+Pj4KPj4+PiBUbyB1cGRhdGUgdGhlIGVsZmNvcmVoZHIgZm9yIHg4Nl82NCwgYSBu
ZXcgZWxmY29yZWhkciBtdXN0IGJlCj4+Pj4gZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBD
UFVzIGFuZCBtZW1vcnkuIFRoZSBuZXcgZWxmY29yZWhkcgo+Pj4+IGlzIHByZXBhcmVkIGludG8g
YSBidWZmZXIsIGFuZCB0aGVuIGluc3RhbGxlZCBvdmVyIHRoZSB0b3Agb2YKPj4+PiB0aGUgZXhp
c3RpbmcgZWxmY29yZWhkci4KPj4+Pgo+Pj4+IEluIHRoZSBwYXRjaCAna2V4ZWM6IGV4Y2x1ZGUg
ZWxmY29yZWhkciBmcm9tIHRoZSBzZWdtZW50IGRpZ2VzdCcKPj4+PiB0aGUgbmVlZCB0byB1cGRh
dGUgcHVyZ2F0b3J5IGR1ZSB0byB0aGUgY2hhbmdlIGluIGVsZmNvcmVoZHIgd2FzCj4+Pj4gZWxp
bWluYXRlZC7CoCBBcyBhIHJlc3VsdCwgbm8gY2hhbmdlcyB0byBwdXJnYXRvcnkgb3IgYm9vdF9w
YXJhbXMKPj4+PiAoYXMgdGhlIGVsZmNvcmVoZHI9IGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1l
dGVyIHBvaW50ZXIKPj4+PiByZW1haW5zIHVuY2hhbmdlZCBhbmQgY29ycmVjdCkgYXJlIG5lZWRl
ZCwganVzdCBlbGZjb3JlaGRyLgo+Pj4+Cj4+Pj4gVG8gYWNjb21tb2RhdGUgYSBncm93aW5nIG51
bWJlciBvZiByZXNvdXJjZXMgdmlhIGhvdHBsdWcsIHRoZQo+Pj4+IGVsZmNvcmVoZHIgc2VnbWVu
dCBtdXN0IGJlIHN1ZmZpY2llbnRseSBsYXJnZSBlbm91Z2ggdG8gYWNjb21tb2RhdGUKPj4+PiBj
aGFuZ2VzLCBzZWUgdGhlIENSQVNIX01BWF9NRU1PUllfUkFOR0VTIGNvbmZpZ3VyZSBpdGVtLgo+
Pj4+Cj4+Pj4gV2l0aCB0aGlzIGNoYW5nZSwgY3Jhc2ggaG90cGx1ZyBmb3Iga2V4ZWNfZmlsZV9s
b2FkIHN5c2NhbGwKPj4+PiBpcyBzdXBwb3J0ZWQuIFRoZSBrZXhlY19sb2FkIGlzIGFsc28gc3Vw
cG9ydGVkLCBidXQgYWxzbwo+Pj4+IHJlcXVpcmVzIGEgY29ycmVzcG9uZGluZyBjaGFuZ2UgdG8g
dXNlcnNwYWNlIGtleGVjLXRvb2xzLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBEZVZv
bGRlciA8ZXJpYy5kZXZvbGRlckBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+ICDCoCBhcmNoL3g4
Ni9LY29uZmlnwqDCoMKgwqDCoMKgwqAgfMKgIDExICsrKysKPj4+PiAgwqAgYXJjaC94ODYva2Vy
bmVsL2NyYXNoLmMgfCAxMTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+Pj4+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvS2NvbmZpZyBiL2FyY2gveDg2L0tjb25maWcKPj4+PiBpbmRl
eCA3NjJhMGI2YWI4YjYuLmU5ZWVjZmYzYjk3ZCAxMDA2NDQKPj4+PiAtLS0gYS9hcmNoL3g4Ni9L
Y29uZmlnCj4+Pj4gKysrIGIvYXJjaC94ODYvS2NvbmZpZwo+Pj4+IEBAIC0yMDgyLDYgKzIwODIs
MTcgQEAgY29uZmlnIENSQVNIX0RVTVAKPj4+PiAgwqDCoMKgwqDCoMKgwqAgKENPTkZJR19SRUxP
Q0FUQUJMRT15KS4KPj4+PiAgwqDCoMKgwqDCoMKgwqAgRm9yIG1vcmUgZGV0YWlscyBzZWUgRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVtcC5yc3QKPj4+PiArY29uZmlnIENSQVNI
X01BWF9NRU1PUllfUkFOR0VTCj4+Pj4gK8KgwqDCoCBkZXBlbmRzIG9uIENSQVNIX0RVTVAgJiYg
S0VYRUNfRklMRSAmJiAoSE9UUExVR19DUFUgfHwgTUVNT1JZX0hPVFBMVUcpCj4+Pj4gK8KgwqDC
oCBpbnQKPj4+PiArwqDCoMKgIGRlZmF1bHQgMzI3NjgKPj4+PiArwqDCoMKgIGhlbHAKPj4+PiAr
wqDCoMKgwqDCoCBGb3IgdGhlIGtleGVjX2ZpbGVfbG9hZCBwYXRoLCBzcGVjaWZ5IHRoZSBtYXhp
bXVtIG51bWJlciBvZgo+Pj4+ICvCoMKgwqDCoMKgIG1lbW9yeSByZWdpb25zLCBlZy4gYXMgcmVw
cmVzZW50ZWQgYnkgdGhlICdTeXN0ZW0gUkFNJyBlbnRyaWVzCj4+Pj4gK8KgwqDCoMKgwqAgaW4g
L3Byb2MvaW9tZW0sIHRoYXQgdGhlIGVsZmNvcmVoZHIgYnVmZmVyL3NlZ21lbnQgY2FuIGFjY29t
bW9kYXRlLgo+Pj4+ICvCoMKgwqDCoMKgIFRoaXMgdmFsdWUgaXMgY29tYmluZWQgd2l0aCBOUl9D
UFVTIGFuZCBtdWx0aXBsaWVkIGJ5IEVsZjY0X1BoZHIKPj4+PiArwqDCoMKgwqDCoCBzaXplIHRv
IGRldGVybWluZSB0aGUgZmluYWwgYnVmZmVyIHNpemUuCj4+Pj4gKwo+Pj4+ICDCoCBjb25maWcg
S0VYRUNfSlVNUAo+Pj4+ICDCoMKgwqDCoMKgIGJvb2wgImtleGVjIGp1bXAiCj4+Pj4gIMKgwqDC
oMKgwqAgZGVwZW5kcyBvbiBLRVhFQyAmJiBISUJFUk5BVElPTgo+Pj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+Pj4gaW5k
ZXggOWRiNDFjY2U4ZDk3Li5iOWNkZjdhMGQ4NjggMTAwNjQ0Cj4+Pj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL2NyYXNoLmMKPj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+Pj4+IEBA
IC0yNSw2ICsyNSw3IEBACj4+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+Pj4gIMKg
ICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+Cj4+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9tZW1i
bG9jay5oPgo+Pj4+ICsjaW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPgo+Pj4+ICDCoCAjaW5jbHVk
ZSA8YXNtL3Byb2Nlc3Nvci5oPgo+Pj4+ICDCoCAjaW5jbHVkZSA8YXNtL2hhcmRpcnEuaD4KPj4+
PiBAQCAtMzk4LDcgKzM5OSwxNyBAQCBpbnQgY3Jhc2hfbG9hZF9zZWdtZW50cyhzdHJ1Y3Qga2lt
YWdlICppbWFnZSkKPj4+PiAgwqDCoMKgwqDCoCBpbWFnZS0+ZWxmX2hlYWRlcnMgPSBrYnVmLmJ1
ZmZlcjsKPj4+PiAgwqDCoMKgwqDCoCBpbWFnZS0+ZWxmX2hlYWRlcnNfc3ogPSBrYnVmLmJ1ZnN6
Owo+Pj4+ICsjaWYgZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpIHx8IGRlZmluZWQoQ09ORklH
X01FTU9SWV9IT1RQTFVHKQo+Pj4+ICvCoMKgwqAgLyogRW5zdXJlIGVsZmNvcmVoZHIgc2VnbWVu
dCBsYXJnZSBlbm91Z2ggZm9yIGhvdHBsdWcgY2hhbmdlcyAqLwo+Pj4+ICvCoMKgwqAga2J1Zi5t
ZW1zeiA9IChDT05GSUdfTlJfQ1BVU19ERUZBVUxUICsgQ09ORklHX0NSQVNIX01BWF9NRU1PUllf
UkFOR0VTKSAqIHNpemVvZihFbGY2NF9QaGRyKTsKPj4+PiArwqDCoMKgIC8qIEZvciBtYXJraW5n
IGFzIHVzYWJsZSB0byBjcmFzaCBrZXJuZWwgKi8KPj4+PiArwqDCoMKgIGltYWdlLT5lbGZfaGVh
ZGVyc19zeiA9IGtidWYubWVtc3o7Cj4+Pj4gK8KgwqDCoCAvKiBSZWNvcmQgdGhlIGluZGV4IG9m
IHRoZSBlbGZjb3JlaGRyIHNlZ21lbnQgKi8KPj4+PiArwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRy
X2luZGV4ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+Pj4+ICvCoMKgwqAgaW1hZ2UtPmVsZmNvcmVo
ZHJfaW5kZXhfdmFsaWQgPSB0cnVlOwo+Pj4+ICsjZWxzZQo+Pj4+ICDCoMKgwqDCoMKgIGtidWYu
bWVtc3ogPSBrYnVmLmJ1ZnN6Owo+Pj4+ICsjZW5kaWYKPj4+PiAgwqDCoMKgwqDCoCBrYnVmLmJ1
Zl9hbGlnbiA9IEVMRl9DT1JFX0hFQURFUl9BTElHTjsKPj4+PiAgwqDCoMKgwqDCoCBrYnVmLm1l
bSA9IEtFWEVDX0JVRl9NRU1fVU5LTk9XTjsKPj4+PiAgwqDCoMKgwqDCoCByZXQgPSBrZXhlY19h
ZGRfYnVmZmVyKCZrYnVmKTsKPj4+PiBAQCAtNDEzLDMgKzQyNCwxMDggQEAgaW50IGNyYXNoX2xv
YWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+Pj4gIMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsKPj4+PiAgwqAgfQo+Pj4+ICDCoCAjZW5kaWYgLyogQ09ORklHX0tFWEVDX0ZJTEUgKi8K
Pj4+PiArCj4+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChD
T05GSUdfTUVNT1JZX0hPVFBMVUcpCj4+Pj4gK2ludCBjcmFzaF9ob3RwbHVnX3N1cHBvcnQodm9p
ZCkgeyByZXR1cm4gMTsgfQo+Pj4+ICt2b2lkICphcmNoX21hcF9jcmFzaF9wYWdlcyh1bnNpZ25l
ZCBsb25nIHBhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpCj4+Pj4gK3sKPj4+PiArwqDCoMKgIC8q
Cj4+Pj4gK8KgwqDCoMKgICogTk9URTogVGhlIGFkZHJlc3NlcyBhbmQgc2l6ZXMgcGFzc2VkIHRv
IHRoaXMgcm91dGluZSBoYXZlCj4+Pj4gK8KgwqDCoMKgICogYWxyZWFkeSBiZWVuIGZ1bGx5IGFs
aWduZWQgb24gcGFnZSBib3VuZGFyaWVzLiBUaGVyZSBpcyBubwo+Pj4+ICvCoMKgwqDCoCAqIG5l
ZWQgZm9yIG1hc3NhZ2luZyB0aGUgYWRkcmVzcyBvciBzaXplLgo+Pj4+ICvCoMKgwqDCoCAqLwo+
Pj4+ICvCoMKgwqAgdm9pZCAqcHRyID0gTlVMTDsKPj4+PiArCj4+Pj4gK8KgwqDCoCAvKiBOT1RF
OiByZXF1aXJlcyBhcmNoX2tleGVjX1t1bl1wcm90ZWN0X2NyYXNoa3JlcygpIGZvciB3cml0ZSBh
Y2Nlc3MgKi8KPj4+PiArwqDCoMKgIGlmIChzaXplID4gMCkgewo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBhZGRyID4+IFBBR0VfU0hJRlQpOwo+
Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcHRyID0ga21hcChwYWdlKTsKPj4+PiArwqDCoMKg
IH0KPj4+PiArCj4+Pj4gK8KgwqDCoCByZXR1cm4gcHRyOwo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+ICt2
b2lkIGFyY2hfdW5tYXBfY3Jhc2hfcGFnZXModm9pZCAqKnB0cikKPj4+PiArewo+Pj4+ICvCoMKg
wqAgaWYgKHB0cikgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoKnB0cikKPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBrdW5tYXAoKnB0cik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgICpwdHIg
PSBOVUxMOwo+Pj4+ICvCoMKgwqAgfQo+Pj4+ICt9Cj4+Pgo+Pj4gQXJlbid0IGFyY2ggd2lsbCBo
YXZlIGJ1aWxkIGlzc3VlIGlmIGFyY2hfW3VuXW1hcF9jcmFzaF9wYWdlcyBtZXRob2RzIGFyZSBu
b3QgZGVmaW5lZD8KPj4gU291cmFiaCwKPj4gWWVzLCB5b3UgYXJlIGNvcnJlY3QuIEknbGwgYWRk
IF9fd2VhayB2ZXJzaW9ucyBvZiBlYWNoIGluIGNyYXNoX2NvcmUuYyBpbiB0aGUgbmV4dCBwYXRj
aC4KPiAKPiBKdXN0IGEgcmVtaW5kZXIsIF9fd2VhayBpcyBkZXByZWNhdGVkIGFuZCBoYXMgYmVl
biBjbGVhbmVkIHVwIGluCj4ga2VybmVsL2tleGVjKi5jIGluIGJlbG93IHBhdGNoLgo+IAo+IFtQ
QVRDSCAwLzJdIGtleGVjOiBEcm9wIF9fd2VhayBhdHRyaWJ1dGVzIGZyb20gZnVuY3Rpb25zCj4g
CkJhb3F1YW4sClRoYW5rcyBmb3IgdGhlIHBvaW50ZXIhIEkgaGF2ZSBjb3JyZWN0ZWQgdGhpcyBj
b2RlIHRvIGRvIGF3YXkgd2l0aCBfX3dlYWsgYW5kIHVzZSB0aGUgc3R5bGUgCnByZXNlbnRlZCBp
biB0aGUga2V4ZWMgcGF0Y2guCkVyaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
