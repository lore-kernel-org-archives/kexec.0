Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F18C433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTHMP6QkTmQ/8Jp5O2GCBr3v9bbX9AgSliKIx7rIyd0=; b=1nr7XXtpjpi4u4K76xq/fDNQcB
	kRn+hmAIUg7WlnWgZpY8RI9+WeWgPQQ2c6YLfiJ1ZMSyd6R11/XceCH7YIrme4N9M2J3jvZ1dnDO2
	oXX2FRIT1UGFysUPzmwQyd0OMEBJyRCDGnuWjdvS+wJdbUNdk0gu9xBSDaG9kwqUy0fv9UwwU/4XL
	YGi6yy8bUt8G7RIGzEneaxnorEg6sxwrgDN8dF/Tq69/QhbeHZEZcoe/Qo8GRrryRJhyyBvJxYzyG
	ZWcUk7EHtOfPwbyMCG++QFJuNzdfKK8+VbUO9w1faKbzmwew1X7apBrr8TY4OhSH/esldM8lIxu+N
	XznhfGGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oieUP-008fFb-W9; Wed, 12 Oct 2022 16:21:50 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oieUN-008fD7-JX
	for kexec@lists.infradead.org; Wed, 12 Oct 2022 16:21:49 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CFu40V013190;
	Wed, 12 Oct 2022 16:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ng3VAXsO0+uKTJvgr5A1gsaFED761TFqqXZSUjldDYY=;
 b=JNxyD+xjDdtbVQClp9GSw9YDPhOm2DJQh5A+5HN0bDvhS2aSPBbL56O9/q2v95y+CniK
 W0RpikSCOQodfBam+DS/qW4hLQsJ9dZPPhe4RRL7b3zU1y7P8Dgnkwnq2ZMKR322aHcr
 sX1u5G2koWrlbbhza9oyLlATEhYG/bTN7PWJnh6khL9ehOwwkqTeShWatrKVM8foCV5S
 LkFHflsxTxSt6MyS+sz5Cgo6lAsRhYYvLR8m1btgu3vNMBdrg6MqNH/VQHAzKv3SNsFI
 q9RPTwe9PcjmCt+S/VODRd5QBSL9sydFMkTluXJp1LjgBkm2Zzdk7GUE/YPlU8mq3EgA YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1jnfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Oct 2022 16:21:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CFRDrx002785;
	Wed, 12 Oct 2022 16:21:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn587hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Oct 2022 16:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnPTXsrCrbj6o6DMEvVxsGPsaBPB8BbV9oZ0CL6oJNCj1i1zwoKNil5h+K53WzoYEn/7lZdpy3oYeEfWeOrgBV9eE5Yb4ijhPmQiekPQo7aZdI3AA1j7O4tlh8vrt2mFbES27ZCh7/zNotnW2MOn3pXPE84R2YItYTDuwMvtMUE6Ae+su8T/XpIFZKTEUduiNSmarpuKm5RoZoIn4gaIh31O0dRgzJR532TMCSJKRCm8CLOdmEyxEYOnFxf12YJI833IpZ/+I345TGJbJwhGGnl83F6kdJ5CfIiZjaLe1gUfGlQYUMXdTbF+AU8a1Ud4XW6h4eLvIqiwdIuilZlAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng3VAXsO0+uKTJvgr5A1gsaFED761TFqqXZSUjldDYY=;
 b=ZHaB8U3zzU9Uu1KXityyU7sd5tculOKE0iLnzmGAOfjYETyYYclXDdAilt0A1HsFfWKsii3pqViN5LIhHjsufTXVZY1zDT6vuxSCHT/iVxhHcuuF64djnOCnWucrXGWbNhxZ/ACptkpi4LZVoD13FwBXUKEw2E35kOsRYktfRiKA9uPP1t+iNcZ2bnODgJHz/XnXt6V75nn6iwWQW7d0tFN1AGbx3A4FjppPnieOl1WQC1/rSL1eU1PWTy6KqGa0zKmnIGLaw08RrDJJVYJ8LJIiwoSEO39a/G1zYZmTamTCbRzYtFnLLDULvJWBY8GqCdZmYhEiw4s8ptkWpKMK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng3VAXsO0+uKTJvgr5A1gsaFED761TFqqXZSUjldDYY=;
 b=S9kXRniiSehDvZuqf7tkbhOUz/anO8fNW+uZAeUG2Y+JBbeYA9j6thSOXilPaLTibyI7EVw8XF3MxIz2/De32VeZBlIboV18x4WAf7AecMIQZb2xIy2TzfZUev4CcDHO8NL69cEb32JzW/3ACsrQUsBXzNCik1huMQD0L1Qb8AY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 16:21:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 16:21:07 +0000
Message-ID: <bec2e406-bd4f-e845-6216-31c74619819b@oracle.com>
Date: Wed, 12 Oct 2022 11:20:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
        bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, sourabhjain@linux.ibm.com,
        linux-mm@kvack.org
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com> <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com> <YzcqE1RVtPcuLlxN@zn.tnic>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YzcqE1RVtPcuLlxN@zn.tnic>
X-ClientProxiedBy: SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b97eb0d-d4c2-46ca-822d-08daac6dc415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	C72z+qYE0MFJWOtak8V2rMs1+mPWRrOkKpW6U2ZjiIvYFuh3h3O36aiKRk72W7YdiqqsMq40+ml1CIIFpY8gN/yAoeFgoT/y42uvkWEOulJIzH26dsT3q22mTNjjxQRfT4f/nsy9KrZ4lA8SQWRfiCWQWIDNoNBz3O7XgSApGl2ZiIH6zwdLpAKn2Jlo6AQwIMhwY8ZId7s3ppns1YKoAq/Znt7Y2duyzojeQBOP5SLponm1pA2nJylc99F3TRfEHL/6iR+FNa036E68Sda3+5q9QvL0/nExEZP5PSTiXjLK5e5xksEeG+JkwhKAeFEUV5tjxUUAZUu96qJ0Jth2ju3DXQq9oFrkhpWdl6rECsTaHt6sKemAZgcgbHCPKY9dKfCo3fvWILpMF9l+gf6rF/JCA+c1/kdfIyspZgvcYJ4r53YQ+nVWVogbo09/KHM5YTbs3c4cIlWOOA/+CmZQuWJgZSk3MAXVdGL/WdkfCqPCUszxTuZUmiO69+RiBBf7XqkOpgZ6z4EypewJ2kV2NvXcYYMgsnlHHyraFk9cWvL2EwPPIzSyO4voxibCozoH3hx6r341/olfkZFTsHdWTk9J48WXGiNdU8rKCPfimrM32JB//wMPqmfIyAKIHa8m+NuUbT98cRB1ei2QsFoYEJ6jmEZbhwCHpPLFs6KkUfXJ48aNRPCSIZVB0fEyPDeGa74gab6GD8X8zyWJY5OM4K4nVd2hA6eKHzO5ZayP/V1o/S4LyqDDQ7erYKVAE86EMQpiQcqNoV0X8oLqz3KDVia51BAntm4DJWD1oeWK6gYydsrvnIfMSql8tLFxmp1hxSy91Pzsmk6NH9dOw0pIxEuU73RDIUXGIHgp79SJrnA=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(41300700001)(8676002)(31686004)(316002)(4326008)(2906002)(8936002)(66476007)(66556008)(5660300002)(66946007)(54906003)(7416002)(6916009)(86362001)(31696002)(966005)(38100700002)(6486002)(478600001)(6666004)(53546011)(6506007)(36756003)(83380400001)(2616005)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?ZnpMRHl2NFF4UzJUUnMyeHBmTVdibE5wd1EwcjROZXg4d2lhZ1lxK1laUTE4?=
 =?utf-8?B?QkJqQUtVaVo4M0RIMHR0SXFVNDk1bW4rK2x6NjkvSmFsN1JWWlZQWGFia29n?=
 =?utf-8?B?NWRwcmhMaEVVS01QelBGTmVudHNVRlJZSEI2cG9VZUpkd3daSUQ1dGlUWjY0?=
 =?utf-8?B?bUgyQ3pYQjN5OUJVM1VORHZBeTVhWDIyTUZGL0ViRS94M2ZCeVVtbkxEYkJw?=
 =?utf-8?B?V1hDRGQ2cUwyN3hLa0dxT2dVYjdMS0JCTGtPQ1FNQUhkZ0FHcE4wVVY3ajA1?=
 =?utf-8?B?NWpmWE5NNFB5NU9oK3BjZHRYSmQ5bDFhS1E1ZHpPQ1dWN3JLMnMyVG44ZjlJ?=
 =?utf-8?B?RlRjSDBFMTVTbk9OSGNUdjRmQTM0SGxFNkVtZXpTYzFvK2lpakVQVmlJQWZh?=
 =?utf-8?B?YlVHY2daZHUxdXdJWUZDNWpBU1ZTQk96RzZ3S1lyM3drWGxQT0FneUQyOG94?=
 =?utf-8?B?TnVMUWRNS3NiYW1zcmF6UHNTTUNrN1BOOEdUd1JQLzRGdFBDNllpUDc2YTd6?=
 =?utf-8?B?UW1yeUlLR3dWZjIrTVg3R3JlaXM2cE5ITXRHNW16aVJTOTZHczh6NVFLUkEr?=
 =?utf-8?B?N2h0N0ppYkg3SG5WMHY1MlFGV0t1L2R4NUJjZ2QvZmF3N0h4Sjl5QUhKQnVR?=
 =?utf-8?B?UVVhWGhEdytCdWpiSjZsMlg5WHRnK1ZHU1kxK3FFbllyOUxHNFRZZmFDMkIx?=
 =?utf-8?B?VEdmeS96Q0VxOExRWTNLWUZDcEg4RTJ6Y2wyRTEvcGl2TjNxVHlhZTRUd1o0?=
 =?utf-8?B?aG9pRGMxenc5OExOemtzKy9qVkZLaDVRTDRhVjJCNEhRSXpWRWIxbUh6ZHQx?=
 =?utf-8?B?YlRMNldZckZYZisrVnpCODZqbUxaTVp3WFNVak1qbFBoVExIdldxODB0bTR6?=
 =?utf-8?B?dTZWUlVYekNGR2NtR1dhUEgxbTB2ZEluT0pTS2xYUUpBZmdHN2xybVRLNVVB?=
 =?utf-8?B?K3ptc2pFWjZ6eDJVZjRBamtOS0FEdXBsTzBWMnlIWGxlWlZNbTdUUnEyUVlM?=
 =?utf-8?B?NGlRNmdXWnUxS2U2M3l2WDRyN0dIRVFPMGxYQmdHcXRqSVd1MXBidXQvRHlo?=
 =?utf-8?B?Z2owK21sN2ZocFlwMTVhaDJzNWdVVzloZCtreHN1Rzl6SXJzTUZpMEQxUU90?=
 =?utf-8?B?cVdxTHdoRlJiZHd5Y2I3Rk4yTkJaUVRzc1BuVVNMd2FmVy8xNld5UHFKQ3Bm?=
 =?utf-8?B?Umpwd1NaRWtVRzlsUjBPRmdPNHpKejZPTzFaMWFsMTIwaHFhOVl4cWRtYUYy?=
 =?utf-8?B?bVRTRXdpNXJTcU83aDMrNjdoRkJzZXduVkVzbDhWUGpTbGNFRHdFUDJ6S0RH?=
 =?utf-8?B?ZHp6c0EwK0N6SVhIV2todmQ3dHVJMUd4OXB2SDZUVkZORmZRcU1VTHptbVQv?=
 =?utf-8?B?WGNsV2RtWVQ1cVZ0YlVveUVLMnVwaDF5a3RyQ2pQU3ZXblRMOTdremRQK1Iy?=
 =?utf-8?B?dlpmQzB1YWxHQXNzaUJBUm5uVEE1NEYrM0YyRzh6YmlKL3p6cnhoaUdET3R1?=
 =?utf-8?B?NFpHRDE3TW1Pdk1QTTB0bDVwMnQzM0pyQVQ1Uk14Nk5pc0JkdksvYU5HTGQw?=
 =?utf-8?B?cFRCWlRUWWhtaWRldW41Q2ZuWWRQcUU5SkRHbStnbis4VldrUTc5d0plTkVI?=
 =?utf-8?B?cFlKdTcwcGwxcm4vck1Wd1dwbTJQSG40Qzk2cmQydXl1WTRDVkJ3enJISFFs?=
 =?utf-8?B?VzByemgrNysveU5IUUMxaWg4NzJ4YmJCaFFOUlNRZktLRGRrMXFSeUJuV0Nq?=
 =?utf-8?B?NFdsOU1LZzRzaUpUbEM3UkIxV0NGa0pkK1RidVUwYkFnRlVmVmFhRU9WT0to?=
 =?utf-8?B?amN2MHBqcDRMTERIQlluZ1NYZ2tTRFR1RkNVWm9rcFpFWjdTWEFDcFRUa3Q2?=
 =?utf-8?B?TlB2TldWdzQxTUZPNlp3VVdpTlFRUDFKTkpxeG5wbTVNQ2wrajY2b0djQnI4?=
 =?utf-8?B?azExYkJYd2NKektoYTZ3cHUwUURMWkVPMjZRQmN1VUlIRjRiQ3RaUHNoVXlP?=
 =?utf-8?B?amhrclp2Tzh1aklqcVJ0aHdRWEp2TVFFRkU5bzc3RmlsZ3NySkdLYmlOMUZM?=
 =?utf-8?B?Z1VLRzRjQkJJOVkyOGdyZENYcC9PNlEvQW9PcEovV1BESUhRMnNkaW5maUFi?=
 =?utf-8?B?NUhpMUxVL3VQYkp5SThrL3NIOXppY3ZsSy9WTTkyZ1hwRWZhVXFPMWQ5QStV?=
 =?utf-8?Q?d14tGdUFXzk/8o/TLgAo/J0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b97eb0d-d4c2-46ca-822d-08daac6dc415
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 16:21:06.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkEtKTF6s+0Wlg2kPve8BLHDh/JnJZDBjDb5YLVvUQvrttPOH5EcxQdv6kRkZzFf1b6jIRPxw7Wo2T9akqksEsI1Wn2aPw9FIpD75m9hf7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120107
X-Proofpoint-GUID: d3-zhV6X5axdykHatmMef_ZScNslnxew
X-Proofpoint-ORIG-GUID: d3-zhV6X5axdykHatmMef_ZScNslnxew
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_092147_764624_FAD33F63 
X-CRM114-Status: GOOD (  28.48  )
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



On 9/30/22 12:40, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 12:11:26PM -0500, Eric DeVolder wrote:
>> There is of course a way to enumerate the memory regions in use on the
>> machine, that is not what this code needs. In order to compute the maximum
>> buffer size needed (this buffer size is computed once), the count of the
>> maximum number of memory regions possible (even if not currently in use) is
>> what is needed.
> 
> Isn't that max number documented somewhere in memory hotplug docs?
> 
> Because then you don't need that Kconfig item either. Imagine you're a
> distro kernel distributor and you want crash to work on all machines
> your kernel works.
> 
> So you go and set that number to max. And that would be the 99% of the
> kernel configs out there.
> 
> Which means, you can just set it to max without a Kconfig item.
> 
>> Oh, that would be an error of haste on my part. This should be:
>>    depends on CRASH_DUMP && MEMORY_HOTPLUG
> 
> You need a Kconfig item which enables all this gunk as MEMORY_HOTPLUG is
> not a omnipresent feature. And that Kconfig item should depend on the
> other Kconfig items of the technology you need.

I once had CONFIG_CRASH_HOTPLUG, but you disagreed.

https://lore.kernel.org/lkml/Ylgot+LUDQl+G%2F5N@zn.tnic/

 From there I simply went with

  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

which route do you prefer?

Thanks!
eric

> 
>> Baoquan pointed me to:
>>
>> https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/
> 
> In that thread says:
> 
> "- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>    Retain the function prototype for those and move the weak
>    implementation into the header as a static inline for other
>    architectures."
> 
> So yes, that's even better.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
