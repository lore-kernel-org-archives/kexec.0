Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A07DC5479D
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=In5YgAaaJttRZ+UbkJ3ZdTPuKVVV8HTmkHENV6QxP4U=; b=aKaQChDSMLeq4OIgerFLwMksWR
	85uUox8E7O+WBsaI/2UYBzVT/74SehT8MTTVaKpX36rfrwynQ/0o0phbfRXfz8Pe+RtHJYPv5Bwmc
	Xiz/geh9rg3/qeWFs/fwydun71z455tEjx5zJPivpPjzc0svPrHJxuXo/CXOXxQmWCwEUjR08iIaR
	MaQGtaoRM+Rmwcs6ZJ2Q9+yXO2ywNrLLan1Ve4UIS8OOL4w0qkq0zvCQZ/pV8Cff0AAwaF/QZGCx4
	9AExjG1UvRZB0n6lPoAIjdvtWht4M5ZHsF85Unfd1q5GQOOyWxs2GJmXtHcDq3/A2feRQGQ96VE3v
	NiqbX+hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEy1a-003hHy-AZ; Mon, 09 Jan 2023 19:41:38 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEy1S-003hEO-Ru
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 19:41:32 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309JdI2n017393;
	Mon, 9 Jan 2023 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=2wy00NDAhRGfa82AXnMDHI2PGPVRaBNHS64elP4wC3gsVm+1NhMAz+1DYEjR6QLTYYVg
 gKUUaeYJAtWUnQ8ub0xqz8Jv6iil7d25xP6OUXmp/OKzoJM8e9DeBQbBheD2TJ3OtGal
 lAieizZNiA/ROkRQ0KNW9r0srBgtUL5opxUfCD/FIZ3p16U1gbN5PhABmC1s+8MnjcEu
 oKNLvUBCWSEJfe8O4WvjbqQ/wMg7jVjUkku3AirmbGN+hoDLQdmwAweOCzl75iRYHcLD
 3RvakSoQrFvp2qyWoGBP07+RQbInN8eO18lZqjAk/zKWq5k8e5LSN4Io58GB664bqbFi 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0s89807m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jan 2023 19:41:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309In19q004444;
	Mon, 9 Jan 2023 19:40:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6afbf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jan 2023 19:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm5D267VhjkgYDvW9PL4cHF0o37LWNuQCJUbZNyZmqwleTXQkNcBVxcwSkGgAelnwWBLJYdk9MFPlqNmIsVMGIRHYAOs1jYErcEd+gSOvzl2hu7r1TM9vksyAmo3BZvs4hLvrf18avsRJd8YBJwKdvRzQvxfrS4A4N3+qUtguhmTL234oEGsOtDTpqid1FmIlAJBtEsWdM26URwVo/McOAAAijYZEuavYN6QCobEUcDw5QRWD2ntPRKT3tvuj3v6UHjzauyB4T0egXDieFmxpkWXfyEejxvPd/m0PlJ878fstfmxF9i2R6y/YMM4uPZCzJF+pMD8k323OvkH8wcodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=eTPJajZC+rGhbSmnkfmrTIM4sMVSq1OSYfVlXupBvAWjpEsWVOxyOkM2vbYjfJhfPc3C6fwNpmIeee215jfj2lTMXJ+6lQ5JIpt6Nki60iTIhiPZnpXyDMfxtyuHnEuEY9PZ2pArw8EApNgXolL0AjhHHqCG4s3eoJBTPU0ahhXwPXYIy6ezy8s0jo5P/Rkux0PlJ+iwQJtFh9UvzSgztrNinuEl/EpHFfE13YTyXmXadVnGC0cI8ypO1eHkbHlgrqPnQaZ7g3plBJZnhzlDd8fsF7VTHlhNbkTo/M+TyWbt0U6FJrm14KzpwbEb1uNGVqR6NK2ttesVBnEqHeYPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=UTo8ZoaeOa0VtqKZt2w01QOLRBMUtAx7NyPmyJ2lnlH0g/LtSItXDMlqMkQ4Aceae9apv1gtxjhS7m5I/wDz5qRMy6b729DDBIi4BQq08/pjcYaka5SoMElEQVVDsm5SRiTUyEISMnL3b568ctWsmjXECKWCVR4Gum4vNVj6U74=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 19:40:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 19:40:56 +0000
Message-ID: <3c85676b-ded2-3941-6c57-5b11397cdd81@oracle.com>
Date: Mon, 9 Jan 2023 13:40:50 -0600
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
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: d91e8227-234b-4ee9-3447-08daf2796cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	12da7uQgNMaWzRoCwn2HQkZvLwVJGnisqguyhe1xclpor4a+K9C/jsRnB4kNhxdc4MN8PNCUR3aZfa2eiBGx7l5hVp6LztXWDjP1GATdMbogSzsWURDJtMtEnJzmSwRPQ4e+8ALfJmm9RFExFRiplJpw5kr0yq+J9sgmnl5Lp+LVYNEZj1P7SYzr7BAw+dDu04qiSMjxpMPW6CXY4iXaWgeRsksO7Z9/5ETsms+m5dWoUlskctIzuj/ngSQPmka5FtEGQds08KLukfA6c0IEEnpYC85+0y41iXk/DWavfUY3bUGKm9XJWiB6hKxa2Cu/ef7zSjUJketK4rKpX3r8i0RorMA8ppfoUt9pZnbFT8Vxh/wrsonHurSe8piYPEuAOqGrsexbqPpd6NMsfssnKSqXx/dFp3MtQicFjqjWcqng2gLKOzzRZivTJxG9bGNbS5t5MLXRF4t4lN2Y6hP7YR8/5j9BndeQxG3CFR6h6zXMR0aGeyytDwTiAk88g9njcaN5/Icfd6W/KkmWV0EmWKh1ZeaKBLIL++kq7FRlyp+/xsJjg2eOP5027espA7HebW/v7UEqRLZEBgffYoPNjuuOmyQvcvQXubNcD7VS5Fg9yU8MhX15yc2pQm050PBgflvcZGlJdD71eCBMaAKewI4regwgIwCoCK69VUApNl1qrhR8QXiUjCda+x4B4WCVNtDMRGjH+iZR+LGbpy0+D1MRR7WAEN/aDfBvaFIV0OY=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(31686004)(86362001)(8676002)(66946007)(66556008)(8936002)(4326008)(2906002)(66476007)(5660300002)(7416002)(38100700002)(31696002)(83380400001)(478600001)(316002)(6486002)(41300700001)(53546011)(2616005)(6512007)(186003)(6506007)(6666004)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?djJmSktUYk50N1ZBL3d3SDZpUmlleFRjRlpRTGxYanlxa0RoZEVzYVpYcFdS?=
 =?utf-8?B?YnMyZjBOM2ZUTlhaTEIxMlc2ZGtGR0QvOU9US1p2UWo1NXYva1dkanpQMHNL?=
 =?utf-8?B?NlVUeDdkTjdWTTczMWIyMVZZNzkxc2d1SWxtQTVWWmdoUzZWdGpCaUZXSjlo?=
 =?utf-8?B?dFpyREhXcEVuYVZkaHliaWtBV1ZqdnBxdk1uZ1VKb21ZbjdUSUhaRHl4TWNK?=
 =?utf-8?B?bkVPOFgwTnI3cVE4RFVOM3FmMm1ydERwYVB3TjUvK3JKRTlTWTBjU0doNFRT?=
 =?utf-8?B?eXZQTklES0JQWHU1SnRPd2lqdEVZTjJQWnBwb3psY3ZxWi9zd0ZiSHJuaWtT?=
 =?utf-8?B?bm5BZmZDL0lKcStELzRMT2lseGkzNTF3SE1yUXo2Zlk0bkZCZkZWais4WFFa?=
 =?utf-8?B?RnVUWWdUcXFGZjl6ZGh3V3JmdkhGOWZhUERENGtzNFR3L0RzOXRkSnBPVWlT?=
 =?utf-8?B?Sk5hK0paSU1ETWVuN1hEQkRsTmQzRG43dGZlNDRqbEtuVm1LbWZtL2lXaTNR?=
 =?utf-8?B?ZXJyNkwvemlqY0ZnUDJ1WjVqRU5UY3J1d3hhbGVldUloSldLa3hIQUc2YXBD?=
 =?utf-8?B?dFdvQUJiSWM3TGw5ZHpReFBwcWxJSktMa3laWUowU2R2VHpUMGlTVlIxVGJM?=
 =?utf-8?B?SWJEVlBFcWRvOWFwdXhmYXhHdVhTUGV2aldyL0hxUFVKVnZGcjFhNW04Nktn?=
 =?utf-8?B?UDk0VHNHSzRvM01LOFE3ZG9SODhhWXlsSUR3WHIzVG5aZlhDcmJjWlNobFkx?=
 =?utf-8?B?Q0cvelhUM0RpUERxcGZFSDgxTjU3V2VYRjdIQUFUK2JpbnhzMnR0OERKL1dK?=
 =?utf-8?B?MU43bFVFZ2JIT09LN2t4cW9ieklHZ1lzeEd6TzJWQk8zd3lQemlwSFI3L21s?=
 =?utf-8?B?RmNmNlVkMS9yUnlHK051YThpa1dweDdrRzhHT0c5Q3VYcDJkYlMxQldyWFp6?=
 =?utf-8?B?ZkVzaU5FNTYzcVhzSXlyQzJHbzVyemZZQXJESm1uZmRBMlJCcjJuVzd2WU9I?=
 =?utf-8?B?WUFFRzA0Q0puSnVUVGFPY3ZuWjJHZmNLcGpsWEx1V2tNWXB5clpLVTFDdDJz?=
 =?utf-8?B?WCsyeDZScndRSTlhbm1Yd1BsSVNLM2E5QjZ2QTJqY2dJRU1MSlZ1SCsyUGZr?=
 =?utf-8?B?UlBBcGFqNzl6UHg0dkYyeWVKQ2xQM3ZmbmNmYVE5RnI3cFVGQzZRd0oxUEUy?=
 =?utf-8?B?cVREN3k3eU5hQ1gxZ2NOc2hxMldBcVJCbGE0bGlMd0dUMTBUWmR2T25rUnpO?=
 =?utf-8?B?OUhDWFBzc29lZklBNzRqUXd1OXgyaVVST1A5WGllVUlsdGFRQmQybWNyOHIx?=
 =?utf-8?B?ZW53b3RHQ1BjcUZvS09ic2pYMEI0VDlpbk4rdHJxUHczdjB5bHAvS0gxZHd6?=
 =?utf-8?B?VjdYelJRQk5BSVAzb2NLbXdkYndpTXdPSkcrMEZrbXhsN0xHV0V6QnZvbkwx?=
 =?utf-8?B?NHd6K1VBQ0xlblRIVXo2aHhoNmtpQWNHZ0lFdk14MlY0aStaY0hOWW1vMjYx?=
 =?utf-8?B?UjlrQm00ekd1UDVyM2ExZVcvYVJCYU0rTWFCeFk2L21hZEdta0VSVWgydCty?=
 =?utf-8?B?N1pTSG5GN1RyOXpDTkNKN0FBQ09yRmVNbTZaQlgreDdNSWt2Z3ppb293WEM3?=
 =?utf-8?B?d0pmYmlPcVNWL1ZNQ0hqTUhXQjVDaE5FRzY4K1dOVWVCMXBlWGh5eEk0TWg2?=
 =?utf-8?B?eFFPUnNRL2hLakR2a0xHMkxncFNFWDhlYkpUcTdmQmVhd2RBTm9RSkFJUlEv?=
 =?utf-8?B?K1gvMWFuc2tsV3RIdnppMVVnaXFCZHBLRmRZMjB0V0J6NGtULzlucnN6WVRz?=
 =?utf-8?B?Q3ZxWU1ZeUZ2K29SYlBrMzcyUXlqa3NWNlJJWUxwSHFqczIyUkx3ZWdJc2J4?=
 =?utf-8?B?Mis2SUIxTC93SldVMEpsSEtmakcvcjdWa241WmRvZXJZNlRVUnh0VUdZeitT?=
 =?utf-8?B?eTFpc1FRdVdQMEgycWFJeTVRV0M4eGpSdnBtVFdVOVRZNE5DcUZPY01rY1ZB?=
 =?utf-8?B?U0NUdVlNUnRNQXIza1U4UEFOdmhUWlBJRlNwZHhkSWZWRWZLN09BUlF2aXlO?=
 =?utf-8?B?K0VyRlh0UFhNK3E1MWY4aVorL1dpMVNBbFgxNitNY3djTklvS3ZaQ1VqblVw?=
 =?utf-8?B?U0hOS0o2dE9uYTY1TnlmajhHc1VVeThWVDg1bTJub290NEZQeTJVN1ZEUDJx?=
 =?utf-8?Q?oDN/fJeFR6/1B1lnCAGsk7c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?UzcwdWpUdHFybmdUYnVRYTMzZU1ZeDJCQkJGbmNJdVlwUENERmNzdWprMUxI?=
 =?utf-8?B?c3dzZnRzT0t1Tk5qNDgwbk9FcHp1NkF5VzJvQi9HdDE4RDFCMzRZQ1BLWUdO?=
 =?utf-8?B?RGFUbWozcmdIbnh0MnVHc2paaE9UVStDZytiQUZuV0hDYWVBL0dwTFlTMk1l?=
 =?utf-8?B?QWZEK3FQTGozOC9MV1FjTm1IVG84Vm9DVEVGU1F6SUlUSEtvaENra21IaUE0?=
 =?utf-8?B?K1o3YWExTjJZczc5Rk03UVNoQWc3RWdQV3lXd3huMEY3NEhrY3hxQ2Z6VHlS?=
 =?utf-8?B?NGZEMURkaGFFemswSThrenBaSURHaGxQSi9Lc0NUMi91VWJHZGVtQVJCd3VX?=
 =?utf-8?B?eSs1OUE1N1FrVnVMb240aUpZemI1dThncHYxQ3Y5TmVLWml6YjJWekc1eHN3?=
 =?utf-8?B?R0dwek1Ub2NGaGZKRERPK2kvaUZkSWEzQlZBUnk4TEJCcHY1emx1L1pTUXFh?=
 =?utf-8?B?U2FtT2pqNUxkYXcvUU9KTmdrcnNBVWllcm9WTFFiRDVBYURZbDVvcCtOdXRQ?=
 =?utf-8?B?S3VFcXVOclp1OXV2b1FDU0FCb0dRSnRQZTYxczZVdkpDQXBDK1BiNlowSnI2?=
 =?utf-8?B?bHFXeGI0c1dpOUY4STQzY1FiempYQW5ZUlh0d3pRNVhkeDNKVnIvSUFaUGNN?=
 =?utf-8?B?RkdIK2tqcUk5ZDY3NnUzKy9BU3NXN0pCbDNnZE5NanZiNDh1S1l3Yi9MOUtq?=
 =?utf-8?B?U1RONFBHR0d4MkRGdStrQldYb2h5OWJFc0EvWTJzdnY5UitsbjlmSmFKKzJ0?=
 =?utf-8?B?OEJlOTJzMWRWR290Q29UeDlISkVOaDZ3YkFrOXp1M0Y1dkgrWDUxUG1XbnFi?=
 =?utf-8?B?YmcxMjlOYm1QcUZOeWhJUEhVdVVHNkU3cDRlV3lMdlJQdGFKancxRENDa3Nn?=
 =?utf-8?B?WDBSMEN2eVNTKzVub0djeWdSSFV2N21XdUpkTis2TUhFZVh1R1NJdzhYODFD?=
 =?utf-8?B?bDlYVWE3TU9pWFE3cFIzaWpQVWpWWE1zQUxIcTl3VVJRM0hMWmV3Q2FJS0tN?=
 =?utf-8?B?R1VaMTRnSmpCdFAxNUYzbjRLRGV1OW83LytlbU4wc0M0RkVTMkNqZ09ROFo4?=
 =?utf-8?B?ZC82UjdIQkk1b0prRlJEK0FIVjZaUWpLN3dhblRDYWI5c21HU3lSblB3K01Q?=
 =?utf-8?B?U0hWWkhFTDB4MVpzQ2I2MlJmVjRVZnI2OTFGRkVyUDV3MmdvOWJzWW1IVjBo?=
 =?utf-8?B?azRHemdSUGpIRGRSSEpQVU5xZUxDOU1KTXR1eENraHV5Z0hyei9Wd3BLUDly?=
 =?utf-8?B?aEhucTJVRU9TN2dRenlDeldwaW5vZmhzUUhWNmwvTnBUam10RCsxek16T0tG?=
 =?utf-8?B?TElXZnR2bnNCUHQ1ayt6YnVoSEgyQWVwekZ2bjN3WWlqVnNFWjFQQlBCSnBs?=
 =?utf-8?B?aDB5RXZuRGdiQ3M0ckNNQVFtK3J4c3ljVHpMY0JRVzh5bVozeUZ1b3F0MHRi?=
 =?utf-8?B?Z1d3dE54SEdiNWI5eE9LR3l6ajE1TUprVDhuUU93WXJKbk1RYktMM0VDMGNN?=
 =?utf-8?B?S0hxV3hEbTF1QUpNZ280cGswMmwybDhTLzFZdFpuMnI1TitiRk1rVkhhOEdF?=
 =?utf-8?Q?ZzqCu52tpjHRZIRpJFDXVHNLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91e8227-234b-4ee9-3447-08daf2796cbf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:40:56.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwZicrE/MvOQYRaDEiczxOIIgBcbQGRLCxTN6rcts/a6axklxy57VX3mG1REjoNjrBBJHW7uU00Gfx49ed1Ucv++wpFBPFrpmZfptVnEiyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_13,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090139
X-Proofpoint-GUID: -jMecQXlOjIf2XybcQx6dBaTXvtVkgxu
X-Proofpoint-ORIG-GUID: -jMecQXlOjIf2XybcQx6dBaTXvtVkgxu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_114131_078632_CB3A621E 
X-CRM114-Status: GOOD (  24.90  )
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
aXNhYmxlZC4KPiAKPiBUaGFua3MsCj4gU291cmFiaCBKYWluClRoYW5rcyBTb3VyYWJoLCBJJ2xs
IGxvb2sgaW50byB0aGlzIGZ1cnRoZXIuCmVyaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
