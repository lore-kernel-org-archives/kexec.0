Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D5AE7F13D
	for <kexec@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zk91L88uzQwuwzthbz3I84Dw4jZrMYlc0bVcywJNq6M=; b=2vrnGdGOiDKMd5w3NJe3Ywlsde
	rGpG18fF9rjIY7rik3BfHh3WP6pHtc0TD3DLsy7BtftSEZvgIDHzYVSNVK2a8M+ecWI/nZCG//1TJ
	7E0vHGy/Hvk7VSyONjkFEHnXgnL8tYl7fnGuIAsvH7sNL+UFW50apkG0tB6Uf6v+LIoQ2n7tDKvEi
	sL+O8sXQHQtIuLOWGtbaEPhAOhyJDnr169Z4Tv/2W0KC9q53Y/3qEQGBX6uqYq52v/mM+NYn12IYN
	dOGS4UCCqW2tT08acoRZYaveubCZclz2LEIAojLfmRNCETBM2fc+lnltQsdaMYoXFnkVwGJFgVere
	qhm5fMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlG0F-00H4qA-18;
	Tue, 26 Sep 2023 21:53:59 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlG0C-00H4o3-1C
	for kexec@lists.infradead.org;
	Tue, 26 Sep 2023 21:53:57 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLTWHS022703;
	Tue, 26 Sep 2023 21:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zdNVJMg7eCaURzWLNwlAOUKQPjJyWG5hBG3DkuupHhM=;
 b=LHuo2FTgdsf3QQrHvOUtArGgGk8cTO9fYo0BmybG+Sjz/av2VSuInT1N1S142rY2+3eh
 SCJbbM+5AuWie3+kcgOlziBEUFc/HACrShIw4Ab3ehE9jJNl3rsquvnYylSZ9IDim2ls
 dc1cHUrgCWUUdnEPObQN5f4dv6OXqsfuJSo7t1XsBsBCPl3TQbtSdmBxZR6Kt3OOAeI0
 cvLAu35lGD9wwRFbN8R3NnV68ZNHvPrDXgfcaDXCTlLY4dtXsv7H7Q1tCeRYZIl/0lVt
 8zTAs9wf0gyo8vcmnU74uD2vFY2UJQcJJg4ISWNNxL3ZjyPUDCFlVCybZE5lNTTRRz28 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbfxyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Sep 2023 21:53:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QL3WZI034946;
	Tue, 26 Sep 2023 21:53:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf7383r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Sep 2023 21:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1j84Cg0OW1SLJDucGPRUZMNYeCKLr4yxzpZ0TodwGAg8w1EhcwkX98ZSSDnz77iEeJpZAIcKhu+rzAhMWWgn0p4OVVnjTKKQqkgQKt26JdjMWbGFImH2yEWg7dBiuZnLdDEKC8KngPIBUGVVLUuTarmEg8ARI5RcjaOOh+2If2QmY6x6aiRB4IaD9SH3jDI+V6VFTHgze6bIukBDPo03rgewnqIStiN5ecIP+pxALKppeQ11oOzzZY3GRZDvhMYAkXk62zmvGug8jumxTnQaL086Kn7T71pCQ2GT/hUKhhjoc9l0xcqooBSaY/bjgWFV5ywHQt90G2HKqjqYgQnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdNVJMg7eCaURzWLNwlAOUKQPjJyWG5hBG3DkuupHhM=;
 b=B6WK1slmLTnPhQDUcfh3vs891lMwxUm+KsqpD0vS9N0bWS9szIPyU/jC4zT0CKyVZ6WVQ5BZPBWod6UtQ9e5URq5wVRqcDmvqZhU2Qs5OHw+SZDONtvdSo/Q6aB4vDla8P5upI6t8kiHUxhxKbxhSUNunjQaJ1Tl9Vdd9Ki1jktsXi9u9oXnYekiwRoF1WSNrzC9tU4MPfUNpVey3r0miqU98P1kMSY7ia0qCqCqd1tCdctG9iHsh7CGLTBFsvHNUrWys7zj5BUkGXXf9KDldQuCCsnD8ow41cVTPjpwnvbhrUnmu5D3DVZsa15QYu5mEFUr0aWHHYC71IOUPzpSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdNVJMg7eCaURzWLNwlAOUKQPjJyWG5hBG3DkuupHhM=;
 b=0EBRJe3PXDntyjAj4bZkDdfyaqV+izVu4lmWLmwkl88svZtzXYClRKIfwbP+2tdL/vqlQdbaQ59KZd4+pEf92kFVco9NUUApAm4IGi2tSa+uZnMggv2o/RjOx5Wg5PBBYbqzaZvM1B0VL0T0l3sO1mqN1NjmmUZ/Hd5nZHMkMo8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 26 Sep
 2023 21:53:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:53:41 +0000
Message-ID: <11bebd5e-8183-d7a7-6acc-53b00a6cc2d5@oracle.com>
Date: Tue, 26 Sep 2023 16:53:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        vschneid@redhat.com, sourabhjain@linux.ibm.com
References: <20230926120905.392903-1-bhe@redhat.com>
 <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
X-ClientProxiedBy: SJ0PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CO1PR10MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8766de10-dcc9-46c2-83d4-08dbbedb0bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKtzA6MwhLo00j2OVmTCoQ+ryuxieNgNyZbsoCnsSWq3ngJMpkBdIP1px5yEcz2WIE5YI+iFrSnrMqLDkifHHk4yzDyQ//dXqQqD9SLZ2MXEmeCo/z6c3C44ndy+EJ6tzxK6X8RKjbxZ15Vs7zdNQeUB5FSTIpg+jR3eFg9z5I72G41gzjPj3Ps1a2xh66UE4dts6W7LT/eiqliUIY3Z2DnSwlIrK52+cAkrLkPWcC/hfkD54CCN/P+YaOcWmOrpGGImQrExerzQmYaL0zmMeYhF6dUxjlpawVVQ6eCgG/fVjjawPlrXlgQIB3JwQBolEhSB5UB5NQ8xfiQQOWUUq7BumbdmTXniWRONS7ikaqyekpUzFceYYxq6LfDdAs7M5oheBK6jY+1MKmjmDonpFxPu3S/wlgYsXck+8rybWBLxaRwfqTOAOrA+eawSWfsp0X4xqN2FGB/SiqojhS6RS6FMbzpwcXPNqxwWz+Ui+bbqUHz+wvL5TW7gIlZ9mPt/FQmChhof0Y06XpxH2ycvG/orSMCEwQBh5jvOtdc5jdn/v684XVdFo81PF7AxfMzZMRsEo1LjqtyG55C+Nt4fbdBKyiypa3aX+B4HoZJLp1SBeb/lBxUjpvlifF9D6zoO6uQS8f7bYOiaT3BY5RfW6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(31686004)(31696002)(4744005)(2906002)(5660300002)(6666004)(83380400001)(8676002)(8936002)(6486002)(6506007)(41300700001)(66556008)(66476007)(66946007)(4326008)(26005)(38100700002)(53546011)(478600001)(6512007)(110136005)(36756003)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZoRzNia0JLNm9NdU1KZjhiTmFpbXByTW9wa3h4c0hVdXQxb253RkZodkhy?=
 =?utf-8?B?S0E5UE55OGMxdDNVYXlhQTVGNnI1TVF4SG9NbGJkb1pTeW5ub1JYVjhTMk9F?=
 =?utf-8?B?RDB0RGw3bVh6T2JmSVlBTUF3YlBSS29JMFdWMFRnWWhNWm41bEtQQTN1MitF?=
 =?utf-8?B?MkZlOHhJa2dEdnZDM1pPa0l1Wld0dnRmTERzR3o1R2V2NGNTeFhrTlo1dVFP?=
 =?utf-8?B?QWhabVM3cjY4ckFNbDUvVkV4TzFpdFljVW9YMTJsZTlKRk9VdENiNFRvVWgz?=
 =?utf-8?B?dWVpVDdtc2JEQVF0aXhacUdsdjVWdmVVL2tnbE02dGlESUVkN0ZsVzl3RXRW?=
 =?utf-8?B?N3I0bG5PUktCOUtJOE8xMGZic3JxNzU0UHNDYjdUNjk4T09xSTBNSDFYTnFE?=
 =?utf-8?B?TW5uT2V3NzhSRk5QTko0WlFsYzVpdDA0UzJxSW5HWlRKb0lySE9zUm5IOGRo?=
 =?utf-8?B?b3k2ZVYvbHVJZzArMURjZUhSMlJvNmFWL2wwVmVNRnRyK2JiSno2K1RWaStW?=
 =?utf-8?B?VjF0c3A3ekFBMExsbm1IL3p6dnBsVEw0OTNza0NHcVR0ZDI5RTlhdzlIc3ZR?=
 =?utf-8?B?V1Q4VU55cHZzdVRydkgxbjJ1U29ZOVd0SDJtV3N5UFFvalBQM0hsMi91enJE?=
 =?utf-8?B?UWVZK3Q2cVdCd0EzT0gvenAyOFNUbHYreTFOUFhyY3REaHBIN1RORzA2Q0o2?=
 =?utf-8?B?LzdRbGdIa1BINFlLYmVTVGhDT0c2ZUlkMkJvVEhCZXozNEZCOXBzdnhqQVlV?=
 =?utf-8?B?SlZ5MkgwV0w2cm9nVXdzbVBodkxhUkRaN3Q5VE5rSTZFQ3k0UVdIQnUwcThv?=
 =?utf-8?B?QS96eFp0ZmgwYURzMFBxd0F1NGpkN3E4MzRZOU1XOXNIQjF3OVR0UG8zMGlq?=
 =?utf-8?B?eGlpbmYxbThTdzQ0Qnpvd2l2S3Q2ZGtrV2dFRU44aFQ4aUJKRk5ZYkFMQmFp?=
 =?utf-8?B?SDAvSVkxNC9nRjN4YWl5NDZXT2FZMGh3VzlTNFQ3VVc4R3ExTnRORWNjVDEr?=
 =?utf-8?B?NHBPZVBaZk5lZHFSR3dlSUZDVGYzbERLL0YzSWhJWDJOblVmbDlNUjh6ajQ0?=
 =?utf-8?B?ZXBMNDA3NjlxbEFnK3BxYUxTQWRkeDRWWWtlc1NrdlYyTzVTaWJiYzFDS0Zl?=
 =?utf-8?B?OEF1QnFZVXlsOTB4RittN1FoT3RvNnJHbFlMVkszUE50Q0RGS0x4ZEIyTExo?=
 =?utf-8?B?c3RmRFZidmNNMkxQZ1Zoc1dhdTIyM2twbHBFZ2U0aWFPWUcrWDZENzhhMjg5?=
 =?utf-8?B?YkxKd3hsc1pWWWdOaWp0amQzd2VNQnlVMUhlWllwQ0ViSXV1bTZnOGV5SnE2?=
 =?utf-8?B?SUlBOVNWL3hvZGszYjJuTkJsQ0JSQUFONGF3bDl5THh3Y3NLY0R6OU9HNkI3?=
 =?utf-8?B?aGNzNGdBYVQvY3NtVHVwS2VzWTQxTGZXM3FIU2FmNS8yK0RUbW81NXZyREtj?=
 =?utf-8?B?S2JsT3dmVXM5U1NubzRMMnJiRmdyU2o1QTdvdWI0OFowOGgyays3REFZVHBs?=
 =?utf-8?B?Mkx6Y0h2dUdtRDNBY3k1NUJxa1ptMHkxZzMwRWI2VWcyQnAyNkU1bHdYODM2?=
 =?utf-8?B?bm8wK29Rem9xeWxySUdUTDd0aVhtdkJ3d05nRHJ2VkNpTlQrYldZMDN0TWNL?=
 =?utf-8?B?Q1A4a25CWGlUYmxyZGhOREhEa05JNDhjaXhPclZiVlhQekRtamY5MlV2cEpI?=
 =?utf-8?B?c2ZLeC80eDFIQzZscEE5SDVkdmVpZUZjT2VHVnJaaSt6c041NEJWSFJhZTh6?=
 =?utf-8?B?VGJjNTFxVG1hblJwaml6cVZaZUZva0J2Zm9renBDN1pSbDF3Y1pUZXkvL3E2?=
 =?utf-8?B?aXl4cjl0WEkwN2M5WkY1NmFER1lRWFhBRkJOWDRyaFNsUDRIdVBUOGpJQXBz?=
 =?utf-8?B?U3RPZDRVT2F3djlieUp1QWowb1A4ak0zcXIzczhrUy96cEVSeE9YZk95amVE?=
 =?utf-8?B?UUxwajNHckszSFJ4b2hQY3JLV2RjMHA0SEo5cmE2Ly9nakNtclhGVnZEdGtY?=
 =?utf-8?B?Qkh0dDQ4VVFNMWlPNkZDZmMvRXZ0OGhQb1Q0ZFRKRWJPVFo1VHlMWGxZcTBJ?=
 =?utf-8?B?N3EzNWNyV2VtSUM3Y1VOVlhyRVRxSGFRU2R4Ym5MS2swUlVpekFvaGlRMWdt?=
 =?utf-8?B?anZvK0xkM2p1c0dBN3hGckl1SEcrTEZLb3pyekwvRFRjOWVPK2JRcktaYWZa?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UXgzaWVkNU5nUGhXOCtzMDVEQVJnbVdlWHAweVZOK3pEV0poTjE2cHNvdDE1?=
 =?utf-8?B?OStuNExaeWQrMmsxVHV6amQwVDZoSjFINUR2YXgrWlB4ODNpWmtrYkJ1dlB6?=
 =?utf-8?B?WTBINlhwdGtVZXBHNHVKTDhhc21JSWNhc2djc1BOcTBIaWNPa0FFNTJLeTZl?=
 =?utf-8?B?T25ETDNGTWJtMW5rQU83c2hYckJ3M3RYZHpzZnZ6YkZwSElVeWs2dWx3N0Vx?=
 =?utf-8?B?NnM3VXJqeFhXQWpEQXNPenpHMGpXckw5SlZoeTZTVlZWSTROOUxOd0czeFNx?=
 =?utf-8?B?VHFkd2U4b1FZQzJackhZeGs2MzBaWDFEa2tLVllORHBQU01uZGFaTU93TXJ6?=
 =?utf-8?B?bGpIeVlVd0VZRy8zYVVYUVdYOCtGUUtoanppMzUrb0Q0anl4cUVkbmdnNU1k?=
 =?utf-8?B?T3ZsNWtrY2JCR3FkTmlCNWo0K1RGZkhCVUZ5VkkvNzAwVUFBUlBqc21VbGJR?=
 =?utf-8?B?U1JQV2NibndYZndvNmhzb2hjbW1nd1l4WWU3NzVva0lSRFV0N0g3OS9xeWM5?=
 =?utf-8?B?RmRQaXIyRzBYazVzVHZSWlA1SGFGMUVWbjEveStMMjQxemRGejB5aVFzYit5?=
 =?utf-8?B?SE5PdDFxMTFFUU5kcmNuQkh5Z0Jaak9pQnVlWG5TRFNCdU5zM2dIbDhMY25S?=
 =?utf-8?B?VHAwaEtkRGMxeXV4UGZMNG1JQlhVMFNZQmJlQW5ZN3VibWpXOFJJWkZNSHhD?=
 =?utf-8?B?QkVqMWZOZC9EZTd3WFJLQXpBL0RwMEtEQW43clo0TFBDK2h1Wi9KMVM1Ulh2?=
 =?utf-8?B?bm1DYjM1eE9Uc29lSTlLQit2OE4wa3l6R2VjMGxoTHJEdTZvVzlTR2gvYWtT?=
 =?utf-8?B?WUdXakp6dHd1YUJNZWxwNEoranR1dXhGemdLSEpSak5CbWgzNk5FajNNTWdH?=
 =?utf-8?B?aUJsUVMzWlBYUzVieDQ2b2pGOTIrZTYzaFZvaHVPVUhubVJDS3UwaGhUWmZ3?=
 =?utf-8?B?aXk4Q3F3L1h3aTJyQ1hxemltbmQyeDdYbWRrVERSRUswb2F3cFNuUkVnZ3E2?=
 =?utf-8?B?Tml1YkZFdks0Y1c4eE1TWGMvb0EvMVNKY1NkQXlmaWxRanJTem9mcWVPWUJn?=
 =?utf-8?B?cGd4SExLYnlTQmwvenNOaHhpM09WTzMvUjhnYkc2cEVaV1hCNFcvM2s1ejFC?=
 =?utf-8?B?RTJFMzdxNmlRSDFiWVBBTkVnMTIzK2NQK2VlL05MVEEra2pMbjE4NjdWME9r?=
 =?utf-8?B?Z1cxT1RoZHNJd3pSSHNZdnFEWm5HcmViTHJzSitOZWoyME52cWZyOFRYQ2sy?=
 =?utf-8?Q?Vh+/sWxArFoQKZ3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8766de10-dcc9-46c2-83d4-08dbbedb0bcf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:41.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycaRNP/5agAqDySsZ5HSVnjWeWt5V0ktw46+cxX5qv/DGlD0657gqLLXyyJhowSYKRDdalTVsqJeiB2ALXZn7q47XQrja7z7hRqaTTNsnyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260188
X-Proofpoint-GUID: kfvIc9ej-6FuAyD635VmBslXfGshArW5
X-Proofpoint-ORIG-GUID: kfvIc9ej-6FuAyD635VmBslXfGshArW5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_145356_463210_B2E879D0 
X-CRM114-Status: GOOD (  14.24  )
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



On 9/26/23 15:50, Andrew Morton wrote:
> On Tue, 26 Sep 2023 20:09:05 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
>> Eric reported that handling corresponding crash hotplug event can be
>> failed easily when many memory hotplug event are notified in a short
>> period. They failed because failing to take __kexec_lock.
> 
> I'm assuming that this failure is sufficiently likely so as to  justify a -stable
> backport of the fix.   Please let me know if this is incorrect.

Andrew,
Correct, this is sufficiently likely to happen.
Thanks,
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
