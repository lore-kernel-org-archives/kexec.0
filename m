Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AAAE7C4EC
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBGecWr2HembVEcqPPAD9k4m8ymx131jr5f1LrsMx6k=; b=40k/fEXY2DlO18YuJE3GFN6XXF
	XmZa9QEvmn/eaTBd79uMzCktpDAYqxGmdLHr4oQbifpg5FgFziradHcVdLcbv9QEHKcgpqZlqq6rE
	FAVWh6bYxK8Jt9G+3U0kJI1H+7LXVSfFA5BmMZ9mwzr8SP5mGLIWcfmt5cA9EyHplt7mHHsxzIEMR
	lmZYd6okD2IYXX4guBW9burhIJ4S4eQLA1uOUXzFpdiX2Mm00MT0vvv9gvkbDUthKMIQlstdewPcL
	S6wkS9V5eADLlnGkfuBv1Lb83eKrXw+Oto5V47shSul6TkNWZqyb12+NKmgstjTI7Nl/gFRbspe7D
	V/uf50+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo6Xt-000gfw-26;
	Wed, 04 Oct 2023 18:24:29 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo6Xr-000gfX-1F
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 18:24:28 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIxK6027949;
	Wed, 4 Oct 2023 18:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2AjO5/bdLYlnJ0b6PJyUj6mdR0EXkNQKH93ahLa8mK0=;
 b=1w8AYQHfFZQ/4J5zI8xHBz9NM5SW8QoL2+yCaHFdip7ycsKLtz6/+aREz/cbczvJU3y1
 vUm748aePjdanA20R2w58UaiFjQdwC8KAiY6LkmOyYhs/mzH/g6mi3DVrnkUQf5P8B4F
 ukDW0r3YvlpaN8/NwRmx5+4tj3nujYWewIvhOb4XfOmChQopvHNaJo8bZOIQm/HIdTRl
 sxftDbR8wXQmnJOjSE7fXvdLeD003WZOz49BhENXmWo8hfAn1+7eKPyxn7f6sPtIbvhc
 g8mlW1ey4yh4oQpiTtUE0Vw0QY7LmAokgh1rvzR2DSN0/Gye13XPWDnwDnmQvhHdt6Hz sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbynvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Oct 2023 18:24:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394HxK1I010517;
	Wed, 4 Oct 2023 18:24:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3thcx5rwk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Oct 2023 18:24:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leITl1y4Flw4wHLhOJ1W9vd9jhgCbc87SYxFezf3A1xMSABpAPp+dOa7H8wJ4K72FlbzsqElzKtSAZohq4dtsdvTDOxjyPJI9sk/g306x+GmCtbkULeRcCGf/RV3ApO8yq1AUsPOJoRyv4pANEXsBJuYxsO4kDYyAv19bv+VVr64FTpHb9XLIKaPVAwoSXFapcxwzfB+6fOGiKgVugIkAdE8hlpcXUApARBz7lytXP9uIfLxBOXxIupqsD7aCVUYbRXkYFMAnmNZmYqBcbVUMeKQ4KRiatD/m0LRD4Sj6X7BiW9a4+rSSVXCbslj2PEkJBzDCqJ4eCLIsP1PU+NyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AjO5/bdLYlnJ0b6PJyUj6mdR0EXkNQKH93ahLa8mK0=;
 b=GjVvQF9fq9oLYH7hFjcZgzgWUAh/bbRVCA27DiRzI4zyPeD9LNhE3OzURZSR41larvphElaudB2d942ptv9QfPBoNzpxuAbJmORtV74p2lKQjLRC8MVLG3zTQUDkU3pIZkVUzMxuYSm1yJRAklE90yp/sUk/vt4SY635s/yV/BwqQmU+q5/OuHMy8R68vi7rCsVjP0JFYjFrQRSiLhNxGIyX3ZV5Fe0DHQG2jYN8OkepGU+BCzlxziEIQovy9d1tNTknlgt2z9Xr9RN6gsMixbhvonnJLLNjdqkwGVkOQ1+8W0OaSHeVSpkhIpVmCukfD27p15MVP34TEqzAKLFu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AjO5/bdLYlnJ0b6PJyUj6mdR0EXkNQKH93ahLa8mK0=;
 b=TrLzznIOw9JLBwPq0W7GFarv2zQ/Ziyy4xB8JBpASbJvOLiJHS0Z32XrInL20ettogBo7Xs9yRBP6ODtWbklnp3bxPiAHrHc8hh+0JNUQbFwQa/so9AVhhBiVqJ9McNGbf78xgRt0CKBXWgH3ozb1OnKXsGtIflTZy6mZgaHEBA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB7595.namprd10.prod.outlook.com (2603:10b6:806:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 18:24:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 18:24:17 +0000
Message-ID: <f90c9a07-ccb1-ac4b-fba5-80dd07db0ed0@oracle.com>
Date: Wed, 4 Oct 2023 13:23:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/6] crashdump: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, boris.ostrovsky@oracle.com
References: <20230927181136.2627-1-eric.devolder@oracle.com>
 <ZR1Vzik09c89PEMK@kernel.org>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZR1Vzik09c89PEMK@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 451c0732-1f46-4216-97ec-08dbc5071da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kcOfq1s5HKENb3nsF/LdYsDlzd6Prgzz82k4B8NOSdZC3ppR9CRFSv/abgFD1ybPg3o++8TrntyV0JKW+pQKTKTZogF7TzMCCzWcFvZiTiZIqmA7hw8Riwj1x+b79onJJvwUGJKbgc+GvEn3gnll9I2KK++VAEfOZThffcwZd4S1cvp+4Szs7plKImXbms8J5J9TqlBB65KbYy+8CrQf0HLmjd/vHr81s30tA4snpphkymrNNg7YZqNsvgZ7EeOmNuxGaKjsytmt2lgNLbB51yzagFru30w5uBo4FyEEODlw7e1Ne+DArqUo6yyWMxmzFl5YVqiUH+We950/XudyT/YvWNvaiqkX2gsHpeEay1/Ju+/phN/qS9BnXYXlD4ebE2vnnEBhHDd3K/7+ZNjL2qanJ+noEn5yPP9dCsIa/miZGy8SxXibiqMxakbejvXv+PDROnSDANDY14Jhnxsw+L0Uz/88ylNB2VPDQEV9zpzFR7tNKTFoarhN9VHeBrckbwpvzf1ArY3WyrRDI0PEFLop8EAQZn5WOmJdCzWNf9LWjTRNg4vEaUvtgE4S2TmIjKli9zEQyqIfVfpQfOXnUtcG3n/HbyHXXlH9nVCmJwMJjiF/COkooaFaIWJfh7JqX1w/Q3zpztCJRNfhImyQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(107886003)(6512007)(53546011)(2616005)(6506007)(478600001)(83380400001)(26005)(5660300002)(6486002)(966005)(4326008)(8936002)(2906002)(41300700001)(6916009)(66476007)(66556008)(66946007)(316002)(36756003)(38100700002)(31696002)(86362001)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3R3QW1lS1NkbGRxSG1HbTJwS1pXVlBkdFNLdytSNWRabi8yS3BWMVN5Y0s5?=
 =?utf-8?B?TnJxZmJRVnk4Kzg5WG1MczZNc0x4RmxaU0VGRXFDQlR6TE9QUEV4Q2JzQ2FF?=
 =?utf-8?B?M0dURWpBbTBtODZqb2Y0R2dKZUtrU2JkbUhMOWVOWGlBSUpWWlhKNU9peGti?=
 =?utf-8?B?N3NaYnc5a09yK1VzM2dkUlNsblMzQTJ4bFJrVU1DRmhYZXRXU3NPU21sSncr?=
 =?utf-8?B?S1ZPakxDdkducStCdWRqLys1Um4vb00rSjFTd2p3N2pHMmtsQ3Qwd2hWcXpZ?=
 =?utf-8?B?VXlTeERrb3NyOVRnZHU1WGVBWVI1bVc3S0hTc2VNODJUeGhybEgwSHhGTjkx?=
 =?utf-8?B?MzhMd0Juc1IycHBRcHp2aUhMN21jL29iQWNxd1IwWWJYUGpyOG5sbDlNSWxt?=
 =?utf-8?B?MzdRUXVub3ZZMGJKaU04OUlYRFRKM0UxRGxmRWtNbzlaNEVYRFFiTjdNenUz?=
 =?utf-8?B?dEhFWmt0SU9EZjdhTGMwQ1R1RUlpbXhlSHdYZ0RYWGVUc2lnQlpXSWFnSzNE?=
 =?utf-8?B?b09nUXFSaFNROFoyZEsrSlZOL2o1MHhMTUlWSndlUnZGbUp4UmN6R0grQnEr?=
 =?utf-8?B?eUJqaEZ4WnNkaXByejM4a093ODVZSXNOK2o1S3FDdEFzZnJsb3NkUy9wYzEy?=
 =?utf-8?B?S0NSZ2N2NCsvY2RHQnk4YnVyT0lWQnRZSjZqZXh3OExseG1mdjRHZ0JUWmJu?=
 =?utf-8?B?OWlzRVJrU01hSVFxZDdaWStRSXhLVzdxWlg3TWlpYS9jRnB1SjlGMmNDYklx?=
 =?utf-8?B?N3NtUWgzOENaTHZDZVh0MkQ0SUx3Y3ZGbnkyV2NVUE9YbmtXRWxtQ3RMTzY1?=
 =?utf-8?B?U0hnNytHT25zMFpSY2lMWElleXg2TThzTnFtcDkrV1h0enVvNE9leUVmZDB5?=
 =?utf-8?B?SkFQWER3eEVyUEcyaDNPbjlhNmlvRStTRUdOK3ZzVC9nZ0VKaExjSUlySjlk?=
 =?utf-8?B?NXQremtuZnB3blIra0pFbFAwaHAwUzhWUGlUMkF4V2drbU9WZWxKSFovMjFr?=
 =?utf-8?B?cExlaXRhT3NUQS9iTCsxODgzWGI1RkE1VTF0ZE55ZERMWXNzeWlxMnJxSWtp?=
 =?utf-8?B?bm82T3FOcEdPSzlnRDhFcmFhekh0b04xL2hqTXZvdDJTY2MxT3NTWmJIQktV?=
 =?utf-8?B?WERRQ0hQSWpmVzBUVE9KbmRDMnZkeExLZERZcENXQWJjQ0tZUTNSWHd4aGxP?=
 =?utf-8?B?N1ZRTFIyd3ZncUlJWmVGZTNlSTUyN0ZUY1lUSit1dnlTMWJEVmdFK01VcVdF?=
 =?utf-8?B?amtnWUxTNUs2S0hxb1J0Uk9pR2MyK0JYanBZUE9GbSs2WU1SdElzdm1JNVJx?=
 =?utf-8?B?MmpDbmNSejBETDB3MUNYeG1nVGFFbThxdEp0MGVrTXVGc1pnK3krMS9FWGFX?=
 =?utf-8?B?bW1WQ0xEN2RISlovRE5Ub3VzU2xyYTIvdkU0WDg2cTNmVnd6djNiKzRLODNu?=
 =?utf-8?B?R2RMT0U1UXJSeDRlVEFsQWQ1TmpTMDhSemFMZ3ZZYkFPVjR5OUJZZWlDUkw0?=
 =?utf-8?B?cnhqN2M4di9zY0svRWZxaHZvcWw5RE5lQm5qb3pPOWo5YkNJQXFBcFFQRE80?=
 =?utf-8?B?NHN4bFZUK2pWZllKdjNQdnZDS2poZGJ3NnRkTVhpdFlpWnFuczNHWTI0Nk9M?=
 =?utf-8?B?eXpOeXJFMU4rK2JkeEE4M1ZjWHRNVjBMRE5HUTdRaERPaUZQbjRTWTllVXhm?=
 =?utf-8?B?cUZ2em5lSUVhMUkycms1UUZVclhDRENObDVjcDhYck9qNk1UWEorOFJKbGlU?=
 =?utf-8?B?cVJLQXhuVkRJS1BqTVJ3RjI0RE0wTnJEUFI4ZExXM0trT0FKOG04OFdnL1ZI?=
 =?utf-8?B?MVQ0QWdsSTMxSU9XU29FTVdQMzJvNjVTejFvRkRaUGNnMkZtbVNodHREaXJG?=
 =?utf-8?B?M0dRbjFaYWlJQy9LYUJpU3lCQXFRRE04SjdENU02NDdQMS94SHdvcmhGVitp?=
 =?utf-8?B?QmYvZW9SS1oxUUJRbFpRU3RITFVtdkxtc0lGZ1VISHUrckpsRnN5b2cvUzJ1?=
 =?utf-8?B?YitvNlNScnF4S212R05IM3BJZDQyTGIzNzdqWE9wU1FNTXcybjJiSVdnaW4y?=
 =?utf-8?B?WnZ5UUhNR0NxZlJLSU0rVTZTOEJWeFd2UFJXK1B1eGt3UU43OGRtL3V6VEdv?=
 =?utf-8?B?dVV5dE92U0R3THYzaVppSW9NVTBpcmxicHlhZTJBTitVMTZoVkhMZXdhZDlE?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tyoG6zh1Z1PqNkZi9iqXmSdq5fpuZHHf1CKmprWFu8Bp1fihgDUN8bDGUIQxmDBBl/dwq1ha+HWH9Bpo615aLIKKhyZqhyzK/qqxVK+UrLfAPXUBGzhcT/aWyc9IYlWtR0yudc2W4c6Kocs46w9q+89kfe/W6ZFW8UzYjYqf21ckAZwIx11Ub308abfLRwo2ydJaDWGYBIt6dlBtRJ6RtxEYiSCeUT9GzI69k3i9jlb2LH78wR6zUd6UnBil/r/n5xb4W3qvTkJtU20KM+2fY1ZI8Gi5RVot9n0pKvBWeG3ak1VJv1NNlzT/80D5IAxObMi2rrWA8tZSVmQkyc1jW4jPDNFQpG2dEINkbNzGmSSNOO9+mlvj8QS9ZgM41dMRzVyhSb4yQT+ylgY7zUsZPygO0u/inxSYCalVPvesc+te44uvnbmIMwUnuTPHGW/E92FB8USTbDzxklsRXYVl6pdkSNwqi4KQsaFvTRFbRxNwPHWmLodbj6z4o8DjGP3Kf8CaCgtiio8k1LrwricMFsTVLZ7TZs0NdMqA3dY5O7/gdZqrmm3rI/IPMmaqHlrDyLKuMzNg27jYwOjsPdw8MuM17BJgHlTQfay3Tbh16yl5IffKewn8asqf2ZDJLAX7qAAE7NEIIMIAFrDvP0Jheeemhrl6AzogLykS/X4c918UccEfgVYpVAWJHuj8aYEXrMblDB53ZkGagE4iE3QLdz1sHnbkagoDV+KhAbi59Pdr8tgz7zUqcUjpDR9d8zieF+4u3/y6khx0KyWMtzPttywDuiYcRsq20XJoz5FK6AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c0732-1f46-4216-97ec-08dbc5071da4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:24:17.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igwFgyjEd1p1IAOZx6tPFlPoOWt6TuP7s2VoeJh4sYTxKFzuD/cbn8YlWl634+dPSZIkbfVYo8PDqB1gH/l9l5/qX++8Zd1ZGeswOnco6aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040134
X-Proofpoint-GUID: V_h3860ZDoKeeaqv1OcQAe93gI2dksIo
X-Proofpoint-ORIG-GUID: V_h3860ZDoKeeaqv1OcQAe93gI2dksIo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_112427_451673_83B63098 
X-CRM114-Status: GOOD (  28.37  )
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



On 10/4/23 07:08, Simon Horman wrote:
> On Wed, Sep 27, 2023 at 02:11:30PM -0400, Eric DeVolder wrote:
>> When the kdump service is loaded, if a CPU or memory is hot
>> un/plugged, the crash elfcorehdr, which describes the CPUs and memory
>> in the system, must also be updated, else the resulting vmcore is
>> inaccurate (eg. missing either CPU context or memory regions).
>>
>> The current solution utilizes udev (eg. RHEL /usr/lib/udev/rules.d/
>> 98-kexec.rules) to initiate an unload-then-reload of the *entire* kdump
>> image (eg. kernel, initrd, boot_params, purgatory and elfcorehdr) by
>> the userspace kexec utility. This occurrs just so the elfcorehdr can
>> be updated with the latest list of CPUs and memory regions. In a
>> previous post I have outlined the significant performance problems
>> related to offloading this activity to userspace.
>>
>> With the Linux kernel 6.6 commit below, the kernel now has the ability
>> to directly modify the elfcorehdr, eliminating the need to
>> unload-then-reload the entire kdump image when CPU or memory is hot
>> un/plugged or on/offlined.
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6
>> 8b4b6f307d155475cce541f2aee938032ed22e
>>
>> This kexec-tools patch series is for supporting hotplug with the
>> kexec_load() syscall; the kernel directly supports hotplug for the
>> kexec_file_load() syscall, requiring no userspace help.
>>
>> There are two basic obstacles/requirements for the kexec-tools to
>> overcome in order to support kernel hotplug rewriting of the
>> elfcorehdr.
>>
>> First, the buffer containing the elfcorehdr must be excluded from the
>> purgatory checksum/digest, which is computed at load time. Otherwise
>> kernel run-time changes to the elfcorehdr, as a result of hot un/plug,
>> would result in the checksum failing (specifically in purgatory at
>> panic kernel boot time), and kdump capture kernel failing to start.
>> To let the kernel know it is okay to modify the elfcorehdr, kexec
>> sets the KEXEC_UPDATE_ELFCOREHDR flag.
>>
>> NOTE: The kernel specifically does *NOT* attempt to recompute the
>> checksum/digest as that would ultimately require patching the in-
>> memory purgatory image with the updated checksum. As that purgatory
>> image is already fully linked, it is binary blob containing no ELF
>> information which would allow it to be re-linked or patched. Thus
>> excluding the elfcorehdr from the checksum/digests avoids all these
>> problems.
>>
>> Second, the size of the elfcorehdr buffer must be large enough
>> to accomodate growth of the number of CPUs and/or memory regions.
>>
>> To satisfy the first requirement, this patch series introduces the
>> --hotplug option to indicate to kexec-tools that kexec should exclude
>> the elfcorehdr buffer from the purgatory checksum/digest calculation
>> and set the KEXEC_UPDATE_ELFCOREHDR flag.
>>
>> To satisfy the second requirement, the size is obtained from the
>> /sys/kernel/crash_elfcorehdr_size node (new with the kernel series
>> cited above).
>>
>> To use this feature with kexec_load() syscall, invoke kexec with:
>>
>>   kexec -c --hotplug ...
>>
>> Thanks!
>> eric
> 
> Thanks Eric,
> 
> applied.

Excellent, thank you!
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
