Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F8C00140
	for <kexec@archiver.kernel.org>; Fri, 12 Aug 2022 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7ssD+jnUC4Bo+2BMe28gr+B5vGC0vCIPPYdGKViQSE=; b=zenWcfR//6O67jR227YD4Adv3v
	wKgJqJkc8jvds0gvsoUaK/4TRJPfc5pReRc8LNzxG9YmjzJLodiHU1ReBV7cLILqk2DXAgp1VY2i4
	uKhnJIyjxTv1To++/RYQTn2GDbYNvTsHgptwz+OvOJWKYkTNp0rRmXEgLsahW3rjvAHYFlPP9OmT/
	eXIX+FQaxj2iu6cLzNbFpW9C5J2RalGnAijegd4Kf4NI7NyQ6u2djyYPhoESQBi5o6SWFCtdfF15Y
	hXFyivklFt2bHQWDonbZYxP/kP7JMiO8NBaLg7M6bciIoWKgyiyZzdKKLfqkXqTKcX/z0Oja/udcz
	cKd39X3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMc9Q-00DYl1-7v; Fri, 12 Aug 2022 21:25:04 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMc9N-00DYch-8A
	for kexec@lists.infradead.org; Fri, 12 Aug 2022 21:25:03 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CKOCOO006840;
	Fri, 12 Aug 2022 21:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6kmNHkqeS+HxsDskjjSfTTZjtOXZYTwTdCRMwG6p/oM=;
 b=nWcc0Z6ggYeobbc5qIhS+KffOVYWi04ClPGfbgEU3MZL7Hx+CTc1o1UJ7w9y64LpBoAM
 /ZBEp0+c/Czeu7HgfID2Sr/9lr780SgO4bqp43d73zIUcpiUFtRHUBesQMB4HynrzirZ
 engvYYujZX0uX5i/k3ConGUsUwqrlVyzn+MWV932NZtEglHiGgPHQYP+z8yCTPX9O1hQ
 +iO2cyOzPLSCK1bIopkQGbT3GoJlnrYJJLAyy+h+5XMQI5EfjnVsNCAKm91HyKtKMBg4
 p9643T71CiTSHZVMWx1NGg1Czefk/qcPsC44zMk3kMP4nYGLEO4OP+FkULOajfLbVTxN xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgrb3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Aug 2022 21:23:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27CIautr004946;
	Fri, 12 Aug 2022 21:23:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkysyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Aug 2022 21:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elOG17E379IHLaH0n31URgWn2wsf1HcfVMX8RDJ2sCQdWyCTsGzus8lY7N3fh0omlMGSma/qphyvW4KsHGiUzvglvL5BEzHHGHr2evFXFEolwJLp/L1/GBeFxmWiKAMB/JLQz0oqr1qr+kiU/PrwiYr/rsAnKtKSI/4QwiJJHAB+OcnQDjVcnDCOXaK5kjOlQXnarnebvSv37qPwIBN0V3yqZV7wzWjzOwwVIz3MlUHzmeRxhgLUL2LMnJAh7dkRTGNUbITuFlNmvjZUs9/zelrPQmUryebYbId/DZS7ZH/+iSmtBGoAkN8MfeRVIDCC4xdh/odShdgg+n7VYGSj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kmNHkqeS+HxsDskjjSfTTZjtOXZYTwTdCRMwG6p/oM=;
 b=RNyg2teDv907yrxZNnyIHzPGb6HZc6cYHry6BvyJFZrpZ5H8RWxx/yTnXjoSwhpslwtyiJ4WdoN/pkXLJcFWt9PQy71nbWG70+UnYokVo2L0G68mwQB/l0I2qtv7cLww95eWRHY5mYZLVlv4dRhAcFSzXIbF004JSxtoyLR8MbiLSRE40h5iSfWaDG9BruQf/wkG0iAQ88Vezgt2TcnZLZe/E9drVsCUel2TVqkmQdgeQXuFRNvA21Sennls8VNSq/Eyd2r+NCvh9C8bAxa3Pnpw5WqFYOC44DhRw+4gbHc0/Iq5Z7FWiOXDrDRwGB7qmJ3n8/nsYkTOWzvQ0pxABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kmNHkqeS+HxsDskjjSfTTZjtOXZYTwTdCRMwG6p/oM=;
 b=Q006Bv5I0yBsQdoEJGm5wGKm039AvUF4Si6Ne5oFXyxziDu28RHwuajsjgNmXPBamn0SeEekoiR4+BDixcaepT+rsvs1wmCHL1XRwwl1EqNuE26jVMmVkSEZ2nHCWIDCPk4H4mwC6LfUbKEP8DwxOGxhO9H/KUAYiMXtnxoWznQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3273.namprd10.prod.outlook.com (2603:10b6:5:1a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 21:23:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 21:23:28 +0000
Message-ID: <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
Date: Fri, 12 Aug 2022 16:23:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
 <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
X-ClientProxiedBy: SA9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a35b4d7-fb0d-4046-91b1-08da7ca8e5e5
X-MS-TrafficTypeDiagnostic: DM6PR10MB3273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	QXst933Kg6MWSvaNfncEwbpXNkhawGmXzNnknqVqEzZyy8Mfpnn1qkKcfZkkUaSHSTmxGfuGoi9Y9D1bFcP5L5uYOlb+z+tL99iIeC8HnNfnhk9ouHfMM9zvIFNNPDQRlHvxetOSEUF1cMdc89ORnpK7jlu6ruElukZ+JJFxcaKn3xnZ2rw1OFsyLAjaooriNGKTvsw16+FtUTkgy9InChH78ejFTIX6e2Mh2Pb+nRzD941VcykWS02y8QiGC6Of0YT2Wzcoi9r1z38wh8TOKZLKf2Wy39Lf/uWvXfZz3f5o5mIev4tyz0EfrEBNPJaT2r/EvL+nyKpeUiESNxiM17kkwndHj4pGN/RXaggWawMysfzV67VNrhbBvQwtgo8bZpDWZKm3CrLYU9njbFVGHROYe7ublLczVBYFey4rNIjewXYVfk7ej/pW6EYmcXTsbhhBVM1VJLkI+DLN3AQy4gyUcwUXQX14jERaQWerBZQ2T0J5e9el8b587uwv3kW0HZUM549jcWiFfko847Q0xuFE6RObVVfkWJsn1uW1M54T/7zZXEAtUK2inqGUe3Oh+MWxeD7bEW9198GJPNXkAkNgNZt564YMpDuqpNAQxFVEqvUQ3O1HDUGHYESBsxz5uCs2THYB1rTdRybS/Cz2YhAhJvqpWVZUVuTf4t9n2AH3LNqTWCvRf3dT9TwrDUrlI6Cdy6n+PV+zA96f7xH3T5TNVv/ThlQXhYegkzwub83Tba9gStt/DU8BJh75ehcyVdv+2Caff305FVkg58MIg7gFDoooaKPNe8FYqkrlqRheIAxHRKOiIFnWKiuoMEEYQkiaQvEDjAeMoBfGWB8sKg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(376002)(396003)(66476007)(5660300002)(8676002)(66556008)(6916009)(66946007)(7416002)(8936002)(2906002)(316002)(4326008)(31696002)(6486002)(41300700001)(86362001)(478600001)(6512007)(36756003)(6666004)(53546011)(83380400001)(107886003)(6506007)(31686004)(186003)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QjNIeEphOUpzRWxRMzNUeDl3TzdiMHhRSHk5WU1sWENvOWlNVHNsNjduZTIw?=
 =?utf-8?B?Tnk0LzhWZnpFR1piUXpvc3VQcGRPeTBWeGxNUys1QjRxTEZENmpyb2Z2UUNW?=
 =?utf-8?B?RmlqUFJaYSs3M3VPcC9DSEtaYmxjaXJYVWMyM1IzdnJFUncyMlVxdnVXZDZy?=
 =?utf-8?B?N2hOR1ozbXJ2UEpIOFU4Y3YrSTFyZ1NOWVp2dDF5M3U2Z0lrQk1uSHh4Z2Rl?=
 =?utf-8?B?THN2NW5qODh4R1BGNVpaS1RPU0pNSmFvL3BZN05RVFdmSWpWY2RvU1hMMGhK?=
 =?utf-8?B?NkxxME4xMTU2aTNjUDNvTTBlNnRhd2kzTm1WVU9NRGtSdWQ2N2NINUEvUjB4?=
 =?utf-8?B?NXMxNFQ5dkZ4NC9XSGU5bFNZelMyQ0hzT0JscmRRc0tiVHErajRaQ3o2cWhq?=
 =?utf-8?B?UElRSzFvSExxcDc2REhiYjZxeGVaV0VVSnhrckRva1VQNis0eWJ4YnJ0OXVI?=
 =?utf-8?B?ajE3RVNQODE5aUlMQXlpZFMwS3NKTmlHbkFlbFNyUXphQjhFZEhMVVppN3Ra?=
 =?utf-8?B?ZmIrTmlhSjFHS0tTSk00anJNYjY1cDlOd0Z3MGJIVmpGcCt4aEZsMVVIRHlQ?=
 =?utf-8?B?anhNL01tVTBpTlBvNE1mek0wOGJCd3NIdDl1OG9HQ1Z1RUU0Ry9xQkZqRWdS?=
 =?utf-8?B?UHZVSzdmY1g0eXZsMUt5SGM2SHpwZzU4WUlScmx5R1QyWFpIQVVHeEpRK0tJ?=
 =?utf-8?B?MW03WUpPSkZMVVFSWFRHTjdKbXhROUJGZWw4L2RHdlA2RlhJT1dSajRCMFlL?=
 =?utf-8?B?UFgzNDh5alUxTjRGTGtEZmtiY0xscEFnNzVKM21rZFRPZXRKTFd5bDkzYlQy?=
 =?utf-8?B?ZGdSK1orTWJlOXQrM1l5YjVtWUIwOGdLamJDbEllc21OSE9wK2trcXk1NnJM?=
 =?utf-8?B?MGgyS1pGZ29SWU5jZkUybDIzaW5CaE1WaUd5cVBVVXhtejFxa0ttbXI1VGx1?=
 =?utf-8?B?dEFUYzlFNDFaNVZIdXhiNHcrUmJJbHMvaDdkelhXeml4STBrTlpMcEpaV1hs?=
 =?utf-8?B?NnA2MjBrazA3SXB3ZWhabE1DNElQSTA2WmdaZXFLY2Raa1dGNEpCZVNxaVRt?=
 =?utf-8?B?NGhzbUkzTlVnUlFNaCt4Rlg5Zkw3dXJPVGk1RldEWkhZVEQ5MDIxRkNzZTNR?=
 =?utf-8?B?QXpiUVNBMDZLVEVxcHRiSG1ONGpTSHZzd0x2N3U3T2s3YmlDam9XRGxYUXp5?=
 =?utf-8?B?aHVjbHpGaGhnU3BnMVRyS21MUnlkMW1zMzRNb28xT2NMR0xoOG81TXNwbWZy?=
 =?utf-8?B?YnpLL0cybEkvUHlNMGlBOWh5a0s0cUFRTUNDRGM1bnNRZytGbS9BcDZhYW1t?=
 =?utf-8?B?RE9jYytKblcvWDVvMGhyZzZlY3NreVBWL3VscVBBZnVVc1AwMjR3bVp3bHhT?=
 =?utf-8?B?Rlc3T1dFQ2hBd256ZmZZNWxlSTE2bi8vN0xUdHlPVmpqaVlpb1p1aUs2Um9s?=
 =?utf-8?B?ZCsrelVpQlhEeUJNcERkN1VzVko1S2s0MVdhY3lFN0JzbHp3SjFvbUQycUQ3?=
 =?utf-8?B?NU1DVDJDUzJFRVJnRWQ0NWZxeW1EVUQyakg0VTloc1N5RFM3TzNKSllsTHlO?=
 =?utf-8?B?N0hCN1R2VzNyRkkzbUNzZ1lZWnBRc1lDSlNZeGRHelFVWUpjb0pKUXFvbVdm?=
 =?utf-8?B?V1VlYzNzNVF6YkxiUG5MYlRnOENYWldZZHE5UlhScHhmV1k3YTM4cnExUkNP?=
 =?utf-8?B?Vy8reW9sTFVIdy9HWFRjZXJZbGVBK2VBWi9tVDVXYTBMQWZRRzlocEZIQUFt?=
 =?utf-8?B?NWdSUlFJQWdSSmdLbmZaSklGSnNZNG56cUpJR2I5dndOR2lwQ0hMSi9kNFdQ?=
 =?utf-8?B?bGZmSitCTHFNSENIS3RmNjk5dlE1eENUSndseVBzOGVKT0FCK3UxVnBWUUd2?=
 =?utf-8?B?L0J5bis0a0dpZmg1bDZEYmNMRE1ld2hmZGlrT0s4TkFRbnNKdFlNSnRLTEV4?=
 =?utf-8?B?ZGhjWER0MFBYMWtJczN1UHFGci9EWDEvRit6SUluWlE5NXlKUDRCbHAzL0My?=
 =?utf-8?B?R2doRk1MSGNmWERtT2V0anlXWVhpcWtWdjVJKys0TE1SWlIzUzJoZ1IwV0Rq?=
 =?utf-8?B?SnZnRXQrQ05tUWxkU3pXVXIwU3diaXFZYit3THpWWjF2NWhkSVdwSlZDcjNx?=
 =?utf-8?B?eUVNZmNxZmFrWHZTOTdNZmQ2Uk1KUGxSY1BFQ0NsbkNUK3RzK3R0RHVGaExH?=
 =?utf-8?Q?gcjR3WwB8UQVSFf4pJytCZE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a35b4d7-fb0d-4046-91b1-08da7ca8e5e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:23:28.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtLC3xXRLVtw9k/ewl3IszVRQEO19asj7sX24EbG7DyYzcul8winRa2NpUSGR+7rciHITJeiGnFI2KC0Gd11LPtfU4+1fa5Uzkz2eAyCwgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120057
X-Proofpoint-GUID: 1IXlxam1LYLNbAA1zSJm06loF3qvGJX6
X-Proofpoint-ORIG-GUID: 1IXlxam1LYLNbAA1zSJm06loF3qvGJX6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_142501_308448_251C33F6 
X-CRM114-Status: GOOD (  26.16  )
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



On 8/12/22 04:46, Baoquan He wrote:
> On 08/08/22 at 10:18am, Eric DeVolder wrote:
>>
>>
>> On 8/7/22 22:25, Baoquan He wrote:
>>> Hi Eric,
>>>
>>> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
>>>> The use of __weak is being eliminated within kexec sources.
>>>> The technique uses macros mapped onto inline functions in
>>>> order to replace __weak.
>>>>
>>>> This patchset was using __weak and so in order to replace
>>>> __weak, this patch introduces arch/*/asm/crash.h, patterned
>>>> after how kexec is moving away from __weak and to the macro
>>>> definitions.
>>>
>>> Are you going to replace __weak in kexec of arll ARCHes? I don't see
>>> your point why all these empty header files are introduced. Wondering
>>> what's impacted if not adding these empty files?
>>
>> Hi Baoquan,
>> In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
>> I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
> 
> I am sorry, Eric, it looks not so good. I understand you want to pattern
> asm/kexe.h, but we need consider reality. Introducing a dozen of empty
> header file and not being able to tell when they will be filled doesn't
> make sense.
> 
> Includig <asm/crash.h> where needed is much simpler. I doubt if your way
> can pass other reviewers' line. Can you reconsider?

If I include <asm/crash.h> where needed, which is kernel/crash_core.c, then the other archs will 
fail build if that file doesn't exist. A couple of options, which do you think is better to pursue?

- use asm/kexec.h instead of asm/crash.h; it appears all the architectures already have this file in 
place

- go ahead and put the appropriate crash macros/inline functions into each arch asm/crash.h so that 
the files are not just empty, and leave the use of asm/crash.h

Or perhaps you see a better alternative?

Thanks!
eric


> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 77f5f3591760..b0577bdcc491 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -15,6 +15,7 @@
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
> +#include <asm/crash.h>
>   
>   #include <crypto/sha1.h>
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
