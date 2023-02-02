Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DBC636D3
	for <kexec@archiver.kernel.org>; Thu,  2 Feb 2023 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:To:From:Subject:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwQJumPIdcN6G1ilpET2qxITeb/CCxIi7SxJGkBqXT8=; b=NkFUwwDWe27WL08Im825hrj2yA
	bbT3MTO6866ASY8bjFCxeX4dgGJxwTjOXtATl7awyktawOgdnzZRykHcT+pPLgQxeNABCelF8GxI7
	rPyEuul8ShqDJTMCxtfapIQSKO5qgePh1jHMlT084MjyigN18Ctv3KXns5jw5uaOd25stgnhlRKwu
	iEKUg3l9AQD0C7X6hq2c5PTTCNEejF/vRMwmfqW9no/WaryPTDCbnoiqxhz5m+7maPBQ8QSujO750
	Kv5ccp/DmN+U4kD+RQDpGWAVBkHnkvZ1cMegRBkps+RjcyncyecMYyVBuNU4dBLZG5RAvZyRFKBrt
	cggExdoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNgiO-00HCmU-J5; Thu, 02 Feb 2023 21:01:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNgiL-00HCkg-7T
	for kexec@lists.infradead.org; Thu, 02 Feb 2023 21:01:51 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IE0LR024301;
	Thu, 2 Feb 2023 21:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FTHJtMKo3qeOUWeWmZjJ5BPwmq+IDvi4Ma04HY7s7ZU=;
 b=yd1HH6ihi/PkdbIKSatmxzAvCEAVcqgquSscUwbBl+xFw99ZBVw131/yU5BO1j7zQ3jR
 dCfp3KOuteZN4agrmG+U8IXgR6IICDKkk9T9UfDO2aZXfS+3lMyEvDP5InjLckK26daR
 tICeXxmh4ikoRrPfxtJZ3lzZ0kJEn4elKVNzkoE66mpxzm8+0OBLeanUy2yapT2WAQ8R
 EW0NW6q4hKE/nTyaUPSuTqDVHt4sCuUW3rtxoW0FwNq5k4X1ijnYXNlDUFVnYNJ8Crlu
 6jkS2DOq9lktcnpdjJf1DcOwXK4cmywXfxsR+U7xghTTre3QHrRS3LsNp6uJio6un13b pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hky0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Feb 2023 21:01:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312JODuX002451;
	Thu, 2 Feb 2023 21:01:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5g6ykg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Feb 2023 21:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMbreUQmVDfE6bGVhpo7Yu68HTJO3xbXGGS9Zp4G72rA93F5EnV/5bZNkF9hu6S+j4CWSKwvktyjF4JdpKYMPAnUjYcHwh/xtcm/6/ovgh87ZaTKI7JARWlp8L6edVBE/fCR+nQVRP60wyYUh1r3VNeLxoy1ddbn7yu7A5AUU+xlugF7Hgtf73e9Fq4gl77J4Z44KIZLWMt8ozyeaAsYn4PJrytqrphRZm6I+/yRlpc0C10lDRoKl6zxXmT7zNGeb54istEylpn8L2CIJDJTaRxyjHD2RJqlM3W4iXHK4n50G18+VrV+kUwjoAadxRvK2x3RsSOx+qJXAIt4PHc33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTHJtMKo3qeOUWeWmZjJ5BPwmq+IDvi4Ma04HY7s7ZU=;
 b=WP6R2oR1qbiK5RabOsvzSdXZzvhmFQ72N95jB8299ftL3x9MTxWZ502FARAeUQbLVKvm7yve35pa9KVUHAliYplIuqfSeIjcTuaZ3wMr77MQ4LWCoSl7V6VdGNQzLJT5eErrgrJYPeUqZqLs7sfMVYrPYi4kU5ioSTbtF7VJOhxMyRL384eL9cCwH5qd3cQ6aiagh4p5jthBc0288XiWahFWFCFyZUdCIO/JL9sqxSocn9tHzPxPMBAsAfgwjOyDhEzz2fa6fsNKXMkJXiW9MKTdOl9Mxa2Qiw2SYDsZV9TjCQFJ+r/arw17/Wi0iOD/ZaiHuN5txE2jDA9KXV4hDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTHJtMKo3qeOUWeWmZjJ5BPwmq+IDvi4Ma04HY7s7ZU=;
 b=kniEcPoq4nC/+CzUNfU9kVbUq+TfuIDvWcltrdfFATXrlbaDHXfabjyw5+U2layDC5RihubWSba6Iqiy+VJL/WPcAh0MflLYLtmPMgvvJsEzHnzVUZ2XJ0qGX01feg9NrcIpFo2nwdVcMQMAtqEP5P71VJXkU5tb2Qy2SdCkdBs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 21:01:34 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 21:01:34 +0000
Message-ID: <f81a50ad-ecd3-8866-2307-b9ef52f0f77a@oracle.com>
Date: Thu, 2 Feb 2023 15:01:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 4/8] crash: add phdr for possible CPUs in elfcorehdr
Content-Language: en-US
From: Eric DeVolder <eric.devolder@oracle.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
 <20230201063841.965316-5-sourabhjain@linux.ibm.com>
 <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
In-Reply-To: <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: c96a5168-6f79-449e-50b0-08db0560aa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ZuszZ+t4idd724nf/EuIZjd1z42bOriioSb2vAcU/DRtRV0MtaQB3VuZSr3lC1cCVFSJz2DYIjxtPmQY2M0tjn7eRZUny5NFMWmlywPsfLDlKfNGaXWj9j5WuSA8HGNKXS7qdlT/orJTzp4MLvWq9qTXzZcJncEyJL+PQDjngNmgj/R4Ple9RE3/WUFVnZNZlAAoRVcQuU1czy4Hr5aZ0bj4ydYlP24Ep7lHCcDG3WgDeGOVIxCK5JfBo/+muz8i8PGjkUBskUDmGMob+LlZSerC4gA0qxjIbrCwYUfvLlqOaLTrgxdzaGyFGq01OBGpOrbM40dsFEhKQuio4oRNTKKqm5qXzwz64Sru9FoBBXoOWaeQ+ZFzzsHdwLZBmXSkfT+fUlGIKUPZenjdoN64zhyWLochLC9adAQegPg0z4Ep594j/eTEkJW5RYylBOIy4r8DoSLOeu6iYgw9iLOACXP7SmHR6UjJ/vXzUb3H65N+4L9VI5XyNG0/WxLwTYTZXqt47gpYX88DHFaGujPJgKzTUNZwO5sA4wU7vGrgCEZtvUo2m0dJZvfcRvg6q030HojjrDdFtJxnTjOOALG9xT00KiJu0fIZrUJr3RMimxqweF7tjW2etIIlRG1Gv4NtAn07kcKQlGTMkiQjGeNXwOW/5Wf+PkaZhMASH76SM+jaXf0zbiAloVx/eDzYwNrWkjlxMEvijMOgJNLHdsKp6rwX/PMg1U9BsnMUo4/2EaM=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(83380400001)(31686004)(36756003)(38100700002)(6512007)(2616005)(31696002)(6506007)(316002)(66946007)(5660300002)(478600001)(66476007)(53546011)(8676002)(6666004)(186003)(2906002)(6486002)(41300700001)(8936002)(66556008)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?UTZDblgwWHpacmlpZ0E4NC83Z0kwemxJYXI0bFlWb3B3MlZxV2VDRmxCUWtz?=
 =?utf-8?B?WWRFMDljRkpWeFNZNXpUaTIzV3ZxZXRIQWJlVmxvZkkxV2tLQnZqam5qbnNF?=
 =?utf-8?B?UFpFRlhiVHVnTENmZ2xYOGhrelZZYjhNZ0Q4RHdDUUozRTZPWVUzdzhTWFBT?=
 =?utf-8?B?czYrOWNyK2VtVVd3SHdQL2hwUGU2NmdEMitSaVJmbWJhK1NzSDY5a2dRRGUz?=
 =?utf-8?B?SkJXOU5HeThGOEUxNUwrMHBVNTAzdTFWZ3ZTWW0zVm9NWjN2OHJvcFNKYVBB?=
 =?utf-8?B?OGRCcGd5emN3WDhYV3FpaU85TjRna3hVVUNBU2g3M21zNVRObURJUlp4U1Fn?=
 =?utf-8?B?Vkd6UmphM1J5eis1aW5KMUNyWmJsR3NyNXY1UHNhZGRZYzBJQkZtTUpkb3lX?=
 =?utf-8?B?UXlXOHRNb1c4Wm9JamxVcW1UYUswdkVkdGQxOFN2eDJNdVZtTjhGWE5jVGQy?=
 =?utf-8?B?M3k3bFRjT1MvWkxkYkpPcHNYRXJIZHptbUR1Z3Z6cmhDNklDVFc0L281ZkNN?=
 =?utf-8?B?V0NRWTdPOVFDZjhheitFK1B5OFRzRVFxbmNFbFFPSkVMd253VHN2eGgvbkZH?=
 =?utf-8?B?MG5Db3FaOHFLZ2cxazRJcDdYODZzNnNLL3lkWWprdHdjNWZJRmcxRHk4V0RG?=
 =?utf-8?B?YllVQWVFNDBzRXYvOU5iZy9maXVZNTB5Zi81Z3VHSUVCVTB6MytEenI3cE9l?=
 =?utf-8?B?eS9wSDRFT0ZwdUFNdFVzM0t4UkgzbVAvUUM4UE5WN0pwRVlhNVZ5VmQ2WlY4?=
 =?utf-8?B?THI2bVpXU2FYRDIybERmanBCWGgyTVlmNUY0OWNKNldxMjlIN2FiMmo0Sm9r?=
 =?utf-8?B?ZnVTbDlWK1BnSkVyR0pqUmkyUElteUhnOXBqWW1JZkIxYnBGL1ZyNklBU2Zi?=
 =?utf-8?B?ZE5JMHRkR29leWdMUW9Lc2VWZ1VKeGV6MjJscytGN3RDa0ZLOGNscUxYODZl?=
 =?utf-8?B?WHNvcmxtcFBZYi9HWkdobCtTQ0lvQVNnSFFZdkpVUWV1QzRkVHpNWnJwRGxs?=
 =?utf-8?B?T1F1TUx5NjFUL094NHZZTUltSGRLQ3BQd1JXOGR5TkxpMnM3MHBlaVQ1NVBq?=
 =?utf-8?B?WWJHRTBvdlRrdzNDSEpQWG1oU0UwcjhxR0F5dlVxNWdlOHAvT0lyMEdzcTAr?=
 =?utf-8?B?N3FrK2c5V2gvQ2pKTGhLR2Fxc3ZQMEt0S05JL2NUamJjK1pFMFhKRW1jay9Q?=
 =?utf-8?B?MnovUXRxcUk2dzZOYVN1TWpvNEsxMnZUQVpzNS9oZmptcGNZbXUwTUlSOGRq?=
 =?utf-8?B?Y0U4bDZuLzJHSVhMRExuSDAyN25sUmh6OUtocngydFlxU0pQVU5pZ242dFJ5?=
 =?utf-8?B?QzFsa1p5OUtFVDNCSHNHUHU5aEExQ0I0bDRxOUdDeVphdjJIcGExM0hFVGRv?=
 =?utf-8?B?MnVxZkYvZzRQSUZDeGpOTlVTQW1pb1k3dHppT2JZSHVzNDhURkRIZ2JLalVj?=
 =?utf-8?B?dituUjF4eFM1b05HSFM3QTUxYTNIRlBiMHA1NW0rcUNVU1AzRjZNNmUwYXNw?=
 =?utf-8?B?Sm9PTDIyVFA4bjFvNVN5UWUrWU1zd0ZMWlFlcklIWTNHT2NMMlJzTzZha3Na?=
 =?utf-8?B?STF3Nkg2RmIyaS9hZGJuUVMxWjM4bVBjYkVRdE90Nk8yZE9IODlvMlRveFFC?=
 =?utf-8?B?TzBZbUx0b25jY0x0RmZ2OTNUQ2RwOFVrUGVXOGllU2UwY0lBNWRYWlRmRDcv?=
 =?utf-8?B?ekdoZFJUT0grREFaZ0Z4b1hqL1hoV1NjRVh6elVkdEt0dkhBZ0lRYSt2MVdi?=
 =?utf-8?B?Uk9tZ3RheW45aHB0bFpVeVBvakRwdzhKdG5XZXlqbUdKSHVGM3hGdEQrS0xY?=
 =?utf-8?B?Yzc5a25uM3JJbW9EK1FxdFFkWERKQng0eVl3NzZPSllad3hnYVNkK1d0NnVC?=
 =?utf-8?B?b2V3TkpDWlpBNVg4T0hTeFRmRHFuWVlua3cyeVQxUER3aWg2UFV0QVdqcUhy?=
 =?utf-8?B?d09uNm94TFE0YTYrTnZobzBjTCtoN0ZQTnBHUUFhWkN1QjR4RjZhT2RPWXlU?=
 =?utf-8?B?a0VvaGt5ZU9RNjVrYXFFaitrNDBTdWltSEVibENUVlJkVEovS05jZzloVm44?=
 =?utf-8?B?OTM5azFKbmV6TER6VWF4RWJZQU5LZ21jNndPVmtFcFBJdUpFZjZZZEN1UzV5?=
 =?utf-8?B?em1JQWNPRWdnaXZxTGJQUGN3Q2ZMNFNxUkgrbVl6dGpBMHJvbUExbUxFc2ha?=
 =?utf-8?Q?YThkUuR2Fe18mmNn1mtV3wc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?SlVtZXRZK0t3L2N1N1RoY2J5QmJlZEZOb0xhZ08ra0lkUWJsRXd3aEx2VDI1?=
 =?utf-8?B?ZVJoVXFBajFIdE5HaENUSVQ0Qzh2VlJCVHdQSUFyZzJxbk1wNUY2c2VsREt5?=
 =?utf-8?B?dWJqZXpWMzQ4bTZPSEpsK3QwcGtTZVBFdDZscDBTTi9IeHQ4TmlURDFRbkdC?=
 =?utf-8?B?NjRxczJpMm5XaUJVMzFPaHRBcGhHemdEamJ6TTJtalRWV1dUVWNzYlp0TEZG?=
 =?utf-8?B?Z0VDWDd4a2FFcmZQZm1hazhSRlFGM3hpUFU0WXJlVXNVNFVNcnk0cjVxVVFQ?=
 =?utf-8?B?VjU0QTJkUHhFVkZMdU9aaGV5RWhuR1FHc2dNOFpsRTAzNE9Cbjc2dnRQQlNQ?=
 =?utf-8?B?Y3RNanp6bmx3Y2V3L0J2eFYzMitFK2RickVxU21SNnZOdUMraVpGTXFPaisy?=
 =?utf-8?B?c2FTZXpwbXJXaUV6MmJaQXYyZStLR2d4andzRXFqNmpiS1UyZXhoRFdGQStu?=
 =?utf-8?B?NUQ5Nks5cVZBTHk2MlJFOXZHVTVvSnZxRFZNaGp5Q3BnMjliYVdzKzIrLzRX?=
 =?utf-8?B?WWU1S3BLMEpSOWV1dmVIN3NBSFpOMWNFUjBhRmNyRDlNcjRlb3NvMFB6R1Bs?=
 =?utf-8?B?dGRDaTdkalRnNklCTVdhbDMzSm5tU2MzU2Y3SXlsVFBBY2REbG9oWnlCZXRI?=
 =?utf-8?B?aTFSaEdzaThjdzVRMGwyR3NMWFVieXJKUysySVZQMVZYMTBnQjU2cE54VGZK?=
 =?utf-8?B?ek5aZFJCRjZsVHpQRmhFYnh4QVdMc25ZeUsyTWhkeUtZa09jMGZsV1htOTFo?=
 =?utf-8?B?a2xVMmUyS3ovSXVyMHp0Y1l6a0RpTStkUUZyZXhEQ1pZSnV4dzJZU2NZNXVL?=
 =?utf-8?B?c1JFaHFyTXdTcFVpaGNJckpkMmRGQ3lsMitUWHBUbEpDWVM0TkFzY1FRSGYr?=
 =?utf-8?B?anFQaWRJRXRBSzVCbmtONHJ3aTY0SEg5WW50a1pZSXVGRHFhSDdpdFpTYWty?=
 =?utf-8?B?Y1pleVZpbU1RTjh5MVBTKy8yU1dPYTZWMFFNeXQ0SFlQcUVVR2pzRTdvT3JC?=
 =?utf-8?B?eE9wK29oTTV0bUNreXpGTjREVlVpZk8wbW1FcysrWDQ5Q2Y4M2RoRWJaSXVH?=
 =?utf-8?B?NXpxUEc1VWE5N1dybXN0V2VLUlo2RExsMXE5eHVuN0Fhc2ZpMjh4cFVTNE5U?=
 =?utf-8?B?WUFubUpkMi9JZFVMQWM0aTR1QlNTMGlwNEtBbmdQbEdsZy91WWxSanNTbG1U?=
 =?utf-8?B?QWlwcEVsOE5JdG9IZEJzVm45S2Q2ek5BekhSaENHa1czakZGSGRvZDVSc0gz?=
 =?utf-8?B?SVRBME94eFhwdGZlUCtkakl4OSsrTFR1NVdJUGU5V3o3RGdSUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96a5168-6f79-449e-50b0-08db0560aa9d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:01:34.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRBJcyTemA1e1l7DvTERWzCRe9Yg6rDBCuHdi84msGPyzlozU/D4xIZKutrjkIKHr0wV6TuBNm6EcQ9Vr8RoFYG2SoXo/rkhK3STmZsLF84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020185
X-Proofpoint-GUID: aZlvufYvYwct8NawUK5BM1k867jQy5LB
X-Proofpoint-ORIG-GUID: aZlvufYvYwct8NawUK5BM1k867jQy5LB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_130149_582173_66A3B89D 
X-CRM114-Status: GOOD (  30.50  )
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
Cc: ldufour@linux.ibm.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzIvMjMgMDk6MzcsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4gCj4gCj4gT24gMi8xLzIz
IDAwOjM4LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IE9uIGFyY2hpdGVjdHVyZXMgbGlrZSBQb3dl
clBDIHRoZSBjcmFzaCBub3RlcyBhcmUgYXZhaWxhYmxlIGZvciBhbGwKPj4gcG9zc2libGUgQ1BV
cy4gU28gbGV0J3MgcG9wdWxhdGUgdGhlIGVsZmNvcmVoZHIgZm9yIGFsbCBwb3NzaWJsZQo+PiBD
UFVzIGhhdmluZyBjcmFzaCBub3RlcyB0byBhdm9pZCB1cGRhdGluZyBlbGZjb3JlaGRyIGR1cmlu
ZyBpbi1rZXJuZWwKPj4gY3Jhc2ggdXBkYXRlIG9uIENQVSBob3RwbHVnIGV2ZW50cy4KPj4KPj4g
VGhlIHNpbWlsYXIgdGVjaG5pcXVlIGlzIHVzZWQgaW4ga2V4ZWMtdG9vbCBmb3Iga2V4ZWNfbG9h
ZCBjYXNlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxp
bnV4LmlibS5jb20+Cj4+IC0tLQo+PiDCoCBrZXJuZWwvY3Jhc2hfY29yZS5jIHwgOSArKysrKyst
LS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29y
ZS5jCj4+IGluZGV4IDM3YzU5NDg1OGZkNTEuLjg5OGQ4ZDJmZTJlMmUgMTAwNjQ0Cj4+IC0tLSBh
L2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+PiBAQCAt
MzY0LDggKzM2NCw4IEBAIGludCBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoc3RydWN0IGtp
bWFnZSAqaW1hZ2UsIHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwKPj4gwqDCoMKgwqDCoCBlaGRyLT5l
X2Voc2l6ZSA9IHNpemVvZihFbGY2NF9FaGRyKTsKPj4gwqDCoMKgwqDCoCBlaGRyLT5lX3BoZW50
c2l6ZSA9IHNpemVvZihFbGY2NF9QaGRyKTsKPj4gLcKgwqDCoCAvKiBQcmVwYXJlIG9uZSBwaGRy
IG9mIHR5cGUgUFRfTk9URSBmb3IgZWFjaCBwcmVzZW50IENQVSAqLwo+PiAtwqDCoMKgIGZvcl9l
YWNoX3ByZXNlbnRfY3B1KGNwdSkgewo+PiArwqDCoMKgIC8qIFByZXBhcmUgb25lIHBoZHIgb2Yg
dHlwZSBQVF9OT1RFIGZvciBwb3NzaWJsZSBDUFUgd2l0aCBjcmFzaCBub3RlLiAqLwo+PiArwqDC
oMKgIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsKPiAKPiBTb3VyYWJoLAo+IFRob21hcyBH
bGVpeG5lciBpcyBzdWdnZXN0aW5nIG1vdmluZyBhd2F5IGZyb20gZm9yX2VhY2hfcHJlc2VudF9j
cHUoKSB0byBmb3JfZWFjaF9vbmxpbmVfY3B1KCkuIAo+IFVzaW5nIGZvcl9lYWNoX29ubGluZV9j
cHUoKSBpcyBnb2luZyB0byB0aGUgbWluaW11bSBudW1iZXIgb2YgbmVlZGVkLCB3aGVyZWFzIHlv
dXIgYXBwcm9hY2ggb2YgCj4gZm9yX2VhY2hfcG9zc2libGVfY3B1KCkgd291bGQgYmUgdG8gdGhl
IG1heGltdW0gbnVtYmVyIG5lZWRlZC4KPiAKPiBXaGF0IHdvdWxkIGJlIHRoZSByYW1pZmljYXRp
b25zIHRvIHBwYyBmb3IgbW92aW5nIHRvd2FyZHMgZm9yX2VhY2hfb25saW5lX2NwdSgpPwo+IAo+
IEluIG15IG5leHQgcGF0Y2ggc2VyaWVzLCBJIGhhdmUgZmluYWxseSBmaWd1cmVkIG91dCBob3cg
dG8gdXNlIGNwdWhwIGZyYW1ld29yayB0byB3aGVyZSBpdCBpcyAKPiBwb3NzaWJsZSB0byB1c2Ug
Zm9yX2VhY2hfb25saW5lX2NwdSgpIGhlcmUsIGJ1dCB0aGF0IGlzIGF0IG9kZHMgd2l0aCB5b3Vy
IGNoYW5nZXMgaGVyZS4KPiAKPiBUaGFua3MsCj4gZXJpYwo+IAo+IApXaXRob3V0IGtub3dpbmcg
dGhlIHJhbWlmaWNhdGlvbnMgb2YgY2hhbmdpbmcgdG8gZm9yX2VhY2hfb25saW5lX2NwdSgpLCBJ
IGN1cnJlbnRseSBhbQp1c2luZyB0aGUgZm9sbG93aW5nOgoKZGlmZiAtLWdpdCBhL2tlcm5lbC9j
cmFzaF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCmluZGV4IGUxYTM0MzBmMDZmNC4uYTAx
OWI2OTFkOTc0IDEwMDY0NAotLS0gYS9rZXJuZWwvY3Jhc2hfY29yZS5jCisrKyBiL2tlcm5lbC9j
cmFzaF9jb3JlLmMKQEAgLTM2Niw2ICszNjYsOSBAQCBpbnQgY3Jhc2hfcHJlcGFyZV9lbGY2NF9o
ZWFkZXJzKHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwgaW50IG4KCiAgICAgLyogUHJlcGFyZSBvbmUg
cGhkciBvZiB0eXBlIFBUX05PVEUgZm9yIGVhY2ggcHJlc2VudCBDUFUgKi8KICAgICBmb3JfZWFj
aF9wcmVzZW50X2NwdShjcHUpIHsKKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQ1JBU0hf
SE9UUExVRykpIHsKKyAgICAgICAgICAgaWYgKCFjcHVfb25saW5lKGNwdSkpIGNvbnRpbnVlOwor
ICAgICAgIH0KICAgICAgICAgcGhkci0+cF90eXBlID0gUFRfTk9URTsKICAgICAgICAgbm90ZXNf
YWRkciA9IHBlcl9jcHVfcHRyX3RvX3BoeXMocGVyX2NwdV9wdHIoY3Jhc2hfbm90ZXMsIGNwdSkp
OwogICAgICAgICBwaGRyLT5wX29mZnNldCA9IHBoZHItPnBfcGFkZHIgPSBub3Rlc19hZGRyOwoK
VGhvbWFzIHBvaW50cyBvdXQgdGhhdCB0aGUgYWJvdmUgY2FuIGJlIHNpbXBseSB0aGUgZm9yX2Vh
Y2hfb25saW5lX2NwdSgpLCBidXQgYWdhaW4KSSdtIG5vdCBzdXJlIGhvdyB0aGF0IGltcGFjdHMg
cHBjLCB3aGljaCBhcHBlYXJzIHRvIGxheW91dCBhbGwgcG9zc2libGUgY3B1cyByYXRoZXIKdGhh
biBqdXN0IG9ubGluZSBvbmVzLiBIb3cgYXJlIHByZXNlbnQgYnV0IG5vdCBvbmxpbmUgY3B1cyBo
YW5kbGVkIGJ5IGNyYXNoIGFuYWx5c2lzCnV0aWxpdHk/CmVyaWMKCj4gCj4+IMKgICNpZmRlZiBD
T05GSUdfQ1JBU0hfSE9UUExVRwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VOQUJMRUQo
Q09ORklHX0hPVFBMVUdfQ1BVKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBT
a2lwIHRoZSBzb29uLXRvLWJlIG9mZmxpbmVkIGNwdSAqLwo+PiBAQCAtMzczLDggKzM3MywxMSBA
QCBpbnQgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKHN0cnVjdCBraW1hZ2UgKmltYWdlLCBz
dHJ1Y3QgY3Jhc2hfbWVtICptZW0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29udGludWU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgICNlbmRpZgo+PiAtwqDC
oMKgwqDCoMKgwqAgcGhkci0+cF90eXBlID0gUFRfTk9URTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IG5vdGVzX2FkZHIgPSBwZXJfY3B1X3B0cl90b19waHlzKHBlcl9jcHVfcHRyKGNyYXNoX25vdGVz
LCBjcHUpKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghbm90ZXNfYWRkcikKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIHBoZHItPnBf
dHlwZSA9IFBUX05PVEU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwaGRyLT5wX29mZnNldCA9IHBo
ZHItPnBfcGFkZHIgPSBub3Rlc19hZGRyOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGhkci0+cF9m
aWxlc3ogPSBwaGRyLT5wX21lbXN6ID0gc2l6ZW9mKG5vdGVfYnVmX3QpOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgKGVoZHItPmVfcGhudW0pKys7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
