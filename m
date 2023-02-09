Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBB8C636D6
	for <kexec@archiver.kernel.org>; Thu,  9 Feb 2023 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LwjRZZewhK7Hn4w/xWY7B6DcI8x8L+X8NsPiM77M4w=; b=4mgAE3wZfLgjGJqewIVcH0DzNo
	FWKNlXqNRUbNAJ+6p+0x5imlvtf++GP7xmL8wfv4TpESxo0x81JHfgaOw9pbHmgBrkoD7vK3UzV8j
	uAIMY8wNWG9ZjDPr68yiM3KlASfBqv1LXqF2OMz7hUy7HF30wcgIp32tCmX/tMXzzJyknD3bdt26Y
	p/pdhraX0Z7u38tgCPJOqJreZFY9gYRPBh2bViOTr/iAOP5rQnQR/CI3TxDPfVY+Zl9jbZLXY2kmi
	LW1qMePSyANE5Qp1sgj8pTyFw2Dok2bPkPKHI9vToRvxQj8ygGELYVVp0UIvKNtCWvjiJLucOaui7
	CpZDn/eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQCmc-0031u9-Hy; Thu, 09 Feb 2023 19:40:38 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQCma-0031sx-73
	for kexec@lists.infradead.org; Thu, 09 Feb 2023 19:40:38 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319IxIVw001067;
	Thu, 9 Feb 2023 19:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=Novz9Yau9aBlDUJADr9/UI7VR5Vjr/dvBm+DKJUQh05S/BzApstzoX1Iz4gvLuCYld8G
 DX/yxBucc/AxS57yWs1yFKeyuaUrsj+7sMCtIEBhOg6z0AtPCc0SKWd2/fN65jL2B2OH
 1O1Nn1gSxDLMqfiQnMXYKFstSG21C5K43Fq0+JRv4+SeCYkQ8BR4FKJvqa6m8em6/g8g
 SA4hDGuALrRLIuhXkLQk9gKyMB7XpJEoFfpTSjH/McLHXk3VAmgEjgFzGfbiZn51vR86
 h6bCVtWOnVtXZky6qZna4X84I4eBZ01AgLvgIJiaqCP42xWuCvWSUFWYCpuXL3pgeh4C 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nknfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Feb 2023 19:40:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319ISNmc013665;
	Thu, 9 Feb 2023 19:40:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt99w51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Feb 2023 19:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEtjkfeZGU7eRqB5O4Xujg8W28e8h3NM5xzZE5orXg7TZ1sFP5BAVE9HXL7DUxkP/5IYhAne/7ESJeG5eMsiQ03aHoFNEzGHd0UbIAUl+xpHl8quYUA2e207EFauDWyRdI41v2sUnptVcnytwT2TAsdPh/lr/PqMNHzgP1k5KsJBQrHiivS7L7ykcjsV8a7upDM1oGCu405wiyviQwtcvhZdhJ0shr/LsMv+/pVj2P8Voso46ybvL9QH2PUiyDMkT+KkXk07hDERL+GWFM+PwCB0FGGYHiuifYYPC9de/yKKvFdYG5tIJWqMDCqYj6FSE/8HoqBh3sfg/f5lSsqbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=KxHXGq6PIeIXPRStDV94TwnVpx4vgL1MIuSJdP63xIHDzeJ1puFU8ZIW2SpJSDiT1NEDQbhz0IZpFi0veGbOrvlQdkT5R85Ow/QnalonYrOoa4yd2yhPNyP36u0pcSxH+ytmkhwBiwGeFu2rFumIxntxyhZm9vEBOxpWepLmQu3hbwqZ6GoFtMW5M9bMIMzXWNRj7Fn3+zaEuZJvwRdTeUP7cGC/x5ee+2hWDgWWAia2WwxX1qXhuS+X9vxmBx3AsuoeXya+jmQhey20aVziallAAuC+XKAXd9pONKJC1Q5cdwJr6BUyOFZSi0SS29Oqk/lIFz8HrnG3YDqRPyNPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=UGEwW4j+ok5++hLkVAZ+Ylvb64ELJfWKnw7lvhwfPM+bWGXyptxMCtjF6kPTFoxYeMne4HSpwhXXvFLMHjg8Dqot90bFciRG4dfmQnxQI9LGYmuDkP+kDJwW54CNF5BwyXcm8R/Maioa+dohT9HsJ2j/Ap+SH0Gl+5lflONv6E4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 19:39:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 19:39:59 +0000
Message-ID: <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
Date: Thu, 9 Feb 2023 13:39:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
X-ClientProxiedBy: DS7PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 708d116f-fbbd-4e95-6068-08db0ad56d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ctnCwCBed602O+ZAtBRzHHt4oVosmrM/V+YfvVmsfl72I25NQpN1YgF3st+V9Qv3Z1vkmEIl1I7fXiaqGtfL3D//VAadu+wLB7yTdCjqPqOwcbcNkR6nXFhRFJVeBhtv3ZaEey6oZsY182ygUcuol3Z79uDla/EAp1caO5Sp14xSAX07Yk3mLEQI4pZM1QMHh3piTRp2DJRwb5yoGwx1Kdy5L5X9PoA3hvg73lsQ5DJTEJCedbAf0UxReI2CUJzla+8qSDCDgo9BECTv723P88g8ZUKGuk7pp2GRRvteMS3gFQ3rAhqaBq4jPBDBjQTvnxOJXXg9M7oJ7nkfeMUnPmsqG7rjwivJQ9mr4rlVwkeStTPrvXbSUFL/ZFw0p2DcMTOPvPQ1JKHO1pz6ntupVbetC877ZDALqAMcoPBH8cPq/OEIqViM60rawK3Fyw8aiiXYdhkfagy+JSp8GhtGMO+oaTpmFh8E3O3l2kWiTNC6N9ahwHeq4jBcphYNlM3gJ5eNMRSwaKQugqrtIgSanX6Sh2vWHIAXLpcPHVkJkBUzPGwYehQU+YocBxly+mHY29WNsmF2BZaEiJvMvfEhOjudm3xdtWkRqLKJI/pvMDDBazhL7xd7J4qYpHc4ibGq1F6S41VmtBYdBrBLBuo5nY6sD7ezLd8WbOX+cMGwGUPdwHOocN0nIrebWttvaRzmi1HsLNJmNIPm5NhhMpeycqUezIs4UUW1syL4yq9zdjg=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(84040400005)(451199018)(38100700002)(31686004)(110136005)(316002)(6486002)(83380400001)(6512007)(186003)(478600001)(66556008)(66476007)(66946007)(8936002)(2906002)(7416002)(53546011)(36756003)(5660300002)(8676002)(4326008)(86362001)(6506007)(107886003)(2616005)(31696002)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?ZkozYVdSa3dFWEtzQzQvdjEzTm5qQjFTTm9uVmg0RENXUXhCMkZEdmYzeGNR?=
 =?utf-8?B?RDNQdHpDWVRZOGRGMEo4K0Vyc1lYS1dIMDJxcW15dU9oYktZV3Bjd3RaRENv?=
 =?utf-8?B?Wkt5cDE1S3NNZnc2MnBrak9uOGJKYkUzVy95N3Q3d0RsL3BnTlBFVkFxczNj?=
 =?utf-8?B?KzNGUGlHSVc2UnUwcUJSdmRvSmlOUVFaZDNxOGpDTkk2TkMzUXhkWWxCb0xI?=
 =?utf-8?B?T2FQZ3dVTVFjdElra2YwLzdZbTRzWXZxKy8vcG1hYlVnUFZCNk9qaXBLNXFy?=
 =?utf-8?B?UHhZVmFLY1FSNTZubmxhUit6WWZvNjlxUWVZU2NqVkpqYmJBSVNaVHZneFNU?=
 =?utf-8?B?WHpML0FWanZjTFBXMzdxMkJnL3hOOFZudEY0R0pVczFvSXNodFEyUG1xL3ls?=
 =?utf-8?B?VU05UnVMdDgxUUYzUmRKRjhIOXZxWm1wSGsvRnM1cjIxMkVjK0loWXdsY2NZ?=
 =?utf-8?B?MG5QT2FPMTRoUkVRQjN5MEJoYzlQQ2hjVW5RSWdDMXBLdDJWZWc2bjRUSjY2?=
 =?utf-8?B?a2NDWW1lU29XMHBmTmp5ZFFYblVuWlNwRXlBb01RRWNYVnBsY2txdHBiNnpZ?=
 =?utf-8?B?NFNzQVNNaTVsOGlvNVFiR2JadTRGcmhaTG9KdU9FMVBxbVkyWE8vVFFRRUsr?=
 =?utf-8?B?Tmp2T0E1bTd1L25DSDNaN3p3VVBqeUxCaW8rS3NwWGpzTm1CcHJ4K28wRU12?=
 =?utf-8?B?Z1RyaUlTYUg5V0U2T1dtWkZxWTVRSzB0bWZpbG5JcGdmSkRNOWp2UGVjNSs4?=
 =?utf-8?B?REtiN256ZWlJekdxRFdwd3BER1NPRmFaWkcrd0x2YlJ1cWFXUFo5aWxFVWF2?=
 =?utf-8?B?L2dRNS92M1hSNWtDR21xNjdyZTFEUEFWMWhma2ZvZlUrcGhCeEdWbHlwUk91?=
 =?utf-8?B?cU1DajNKMVBPUkY0MmpPVmNHZUEzYjNLUUIyaFJ2eXlIZ1E2Q3NQYUIvakJH?=
 =?utf-8?B?ajQ4VnAwd0NWYVZVN0FqNVZVUnBGWkFiVFFGMWtjNjR3VVMrUmNoM1V2SXdM?=
 =?utf-8?B?NDhRMCtTY3I1MDVSbTNJQ09BTkx2WTJXczNFMTBqRmhHcFo5ZTNMdlVwMktj?=
 =?utf-8?B?b2txRDc3TGZCdWJTOENwOUZTb242QkRnbWxobjI4aFQyMnJjaE5aaHJlcHFz?=
 =?utf-8?B?T1lhS0MxWGJRbkQ0YkRrVi9ZTm9ROTNNWjFlVmNuTmVkZVZhS0ZJenVGVVNR?=
 =?utf-8?B?eExBQ2M4aUJ6VlhncHNTSEh1TU1TaTFaQm5FdmNlTUIvbFJiZ212UjJLZHRP?=
 =?utf-8?B?VEt0ODh0ajV4RHVxWXA5TkJoaTV6QlFSc0NpbFIyVFRsanNzak1BbEhIVjFk?=
 =?utf-8?B?cUZ4TVAzaFM2SC9TeTdlUjV2OHJLRlhSZVdkMmZ2Q3JKUk9iM0IvaGFYdDlF?=
 =?utf-8?B?QVlJUmV0bGRtYVRUWnROTzZRZC94cVNnZ21oWVFzY0J6SFhhNzZyZFU4c1hM?=
 =?utf-8?B?N0J1ak9vNzdXZTZLOFRIVS8relhGM0MrODVKbCtOVTZxZm1TZFphZUtGSGw1?=
 =?utf-8?B?c01vdFc1Y0YzMG9HMlB6R0lCWTUyWENXTFdCdk9NNzluaDNMbEFqMFRSa05I?=
 =?utf-8?B?WWs0MEl2UXBnSXcrYVUwb0RjT2lGWGx3aTcvaGNUcThTcHh5R0ZIcXNJSnAv?=
 =?utf-8?B?OXMwZGRhdUdDY0VzL0xrWkdjUEhIdDFqWkZzMVpTL29uMmVMSkVYdWFVMitm?=
 =?utf-8?B?VmVGbTAwZUkvZzQwaTVQbVI0azdvR1ZFMUN5aERQVnpTaWNjMWVDc1pnbjBj?=
 =?utf-8?B?T04yWXFGalgwaDFWMUIwcDZiMm03NnczQVNkRTFzbjhmMG5FMDJ1VkoyWlR0?=
 =?utf-8?B?UVlSOWxnbHRZaW0rUDQ0RG5Qek9kUW1USUo1TUFHeHBnQmNINWI3RnZYMWxt?=
 =?utf-8?B?Uzh0bGt4NGt1YklNTDQ5UktMRDEvd1JNcFdMdmcwV2RTZzVvVk5WZkFvMTdI?=
 =?utf-8?B?YnFLdkM0clM5bUVCUlV2N1h0MVhJYXFVc1NsZjRpTmdmb1VRUFQzRHBtTlFD?=
 =?utf-8?B?OU5BMU9qU1REd0k1YVpZUXBQS2hxZ0RkWjc0WitlOXZvazhZbmdHbmQ1cklV?=
 =?utf-8?B?Um9GRTNudUFRaFlCV25RWUlTSGo4QVhQejBkLytkSkRCVnVJU1RDR3k1L2o4?=
 =?utf-8?B?QnhtK0pkYnc1WHZ1STdkNGRsTGUzT2JseTM4N1NjQUVlZW03M1BSY3I2VDN5?=
 =?utf-8?Q?Bv26q/xKXjytV/LGvEn7Pr4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?d0JLZkJWYkJuSWNiMnB0U2FBSVp4ZElheHV1UTFzekhJUXFzUnQ1N0R2aEhZ?=
 =?utf-8?B?Y21aR2JtS2ROQlBXTlNpd1dSSE83SUxqTnl0ZHpubVREa2dOZDlhVGlGQ1c2?=
 =?utf-8?B?NTBmT1N4M3VJbUNhYWFESW5MeXA1bm1YV0x2VGFRcmpsK05wVWZVSXF1ajZx?=
 =?utf-8?B?U2t2azZZZ0dqNExWb1VwK0plK2xwKzFETWxOdHZXYlhvcFpuMThKaE9QZXAz?=
 =?utf-8?B?akgwWkdkMFNYNmxaM2M2VnV1WjdoRllnTWdEcnpOZHlIOVR6eU90cG5xZWRI?=
 =?utf-8?B?UWdaQkR1VHhCaWZvem9JTEVTanVqQzAwV2JFTmpxSVdBL0dhejY0dzhkY2ZM?=
 =?utf-8?B?NDZCZzVCZkJEYWR6RzMvTDBPeklqSlRMNkh3b2Fnd1k0bDFUTk42aWlMVXE2?=
 =?utf-8?B?N0FVVkplbEJIY1hxWHoydW1KOGFSc1hmTUtQZHQzUTRYY2VnTUUxMmhmUjMx?=
 =?utf-8?B?dVdQNHpBTlJqdTdqRVlLcHZwSCsxUm1BT2ZHbURZVXBDRzZ2SE9STm94VldF?=
 =?utf-8?B?d0dyL1lWVnVSdmFVTnRvMVNCck9laFBvM2MvVEJvL1hhTmQrNjJ2WlNwbXBa?=
 =?utf-8?B?cEh1TUxuQ25xZjFKMjlXakJndThudGljRVd5b3N5cUw5SG41MnE5TU81MWp0?=
 =?utf-8?B?OTBGTlI1K2gzUThmcHUxMzFIakd5NnQ1K1BlN0VPZTA4Um5ydFZwNXJwUFlU?=
 =?utf-8?B?QUJEVnEwMzZFd1UwVG51T2VLSm1obmErSmZLRk5ueCtiUDNPdTh0eEt1UUJw?=
 =?utf-8?B?L3dValRaakU2ZnFaZDRjcXJXNzJJSm9nSHIzTTRLam1zUVZVelRBMlM5YkNM?=
 =?utf-8?B?eXJaZjNFN28xWWVEOXgzOCtsYUR0QStITjA0UGU4VG95by80c1dVR3N1V3pj?=
 =?utf-8?B?aHNkaGZtU0pxQTUxaG1TMTBYV3J0bEJFT056QmFYcU5tZ09nYm9vaXp4NEsz?=
 =?utf-8?B?NC91TUlBL1hvYlV3Q1dWQTNLdFcvdnU1OURCT1hoTWlqSlhyVVZodGVocmZU?=
 =?utf-8?B?dzcxejBaVnhlNGRTeldLRHg4Y1JoNFZlbXlUTHAzS1dFZEZTYzk3L0JFb3VD?=
 =?utf-8?B?cjJ2c2FYZm90MnovTHNwbVNoL3pyam03MGdjbkNMS0FadTNtNWEzNUgvK0Q0?=
 =?utf-8?B?V0lkWlVvQVdKWW11V1krSTBobU43ektESG5CK2RlZENxZ0NwTTZxNmpwazI5?=
 =?utf-8?B?Ri9vRjVmdjJhS1VqUXJOSnZCL1c0Q3V1YjFZYktueFdCYjBOeGZLb2JsUi9o?=
 =?utf-8?B?RU0zV2RsMHNkbG94cGhuWEZudjNyN2ZBOWYzcUE1ejlKV0w2RnkyWjdyNXZZ?=
 =?utf-8?B?UjZpSzF4ekRhcGI3NE5sVHp3OUhzYU9kUjMxM21XYjQ5cE5qcjFFWks0d2k2?=
 =?utf-8?B?YjgrelA5TG8xWTlwLzNTRG9ja1lmU2xkSWUrL0dRQllaTDBNbnhiTTZ2QkZG?=
 =?utf-8?B?dUc5eUNYTGdWZFlZSm1GUDk0UzIxbXhSMEt1THd5NVVwWEs0TmM3OHBMS1E4?=
 =?utf-8?B?UklLcEx1a3pJMWd4cE5mS3ZMQU4ya09IWmJ5Z0N1UFRTOG45bGxzaC9GRXp6?=
 =?utf-8?Q?iZxTJ3XUtyiOs00sXnAabkxYY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708d116f-fbbd-4e95-6068-08db0ad56d8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:39:59.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VngembZ7PtdY9kwmHXKslcEN9wtuhZcUjlCylwuOkawaaW86TDEeqQAArMg1NZnEAvNK25UOD72a9pVSfkUUkqrd3ZFanZFkJPoSciKFYJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090182
X-Proofpoint-ORIG-GUID: S-NKUl-2dekd8sojXnMk1nMwDPs4Qu5V
X-Proofpoint-GUID: S-NKUl-2dekd8sojXnMk1nMwDPs4Qu5V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_114036_276893_E1CB100A 
X-CRM114-Status: GOOD (  20.59  )
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

CgpPbiAyLzkvMjMgMTI6NDMsIFNvdXJhYmggSmFpbiB3cm90ZToKPiBIZWxsbyBFcmljLAo+IAo+
IE9uIDA5LzAyLzIzIDIzOjAxLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyLzgv
MjMgMDc6NDQsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4+IEVyaWMhCj4+Pgo+Pj4gT24gVHVl
LCBGZWIgMDcgMjAyMyBhdCAxMToyMywgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4+PiBPbiAyLzEv
MjMgMDU6MzMsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4+Pgo+Pj4+IFNvIG15IGxhdGVzdCBz
b2x1dGlvbiBpcyBpbnRyb2R1Y2UgdHdvIG5ldyBDUFVIUCBzdGF0ZXMsIENQVUhQX0FQX0VMRkNP
UkVIRFJfT05MSU5FCj4+Pj4gZm9yIG9ubGluaW5nIGFuZCBDUFVIUF9CUF9FTEZDT1JFSERSX09G
RkxJTkUgZm9yIG9mZmxpbmluZy4gSSdtIG9wZW4gdG8gYmV0dGVyIG5hbWVzLgo+Pj4+Cj4+Pj4g
VGhlIENQVUhQX0FQX0VMRkNPUkVIRFJfT05MSU5FIG5lZWRzIHRvIGJlIHBsYWNlZCBhZnRlciBD
UFVIUF9CUklOR1VQX0NQVS4gTXkKPj4+PiBhdHRlbXB0cyBhdCBsb2NhdGluZyB0aGlzIHN0YXRl
IGZhaWxlZCB3aGVuIGluc2lkZSB0aGUgU1RBUlRJTkcgc2VjdGlvbiwgc28gSSBsb2NhdGVkCj4+
Pj4gdGhpcyBqdXN0IGluc2lkZSB0aGUgT05MSU5FIHNlY3RvaW4uIFRoZSBjcmFzaCBob3RwbHVn
IGhhbmRsZXIgaXMgcmVnaXN0ZXJlZCBvbgo+Pj4+IHRoaXMgc3RhdGUgYXMgdGhlIGNhbGxiYWNr
IGZvciB0aGUgLnN0YXJ0dXAgbWV0aG9kLgo+Pj4+Cj4+Pj4gVGhlIENQVUhQX0JQX0VMRkNPUkVI
RFJfT0ZGTElORSBuZWVkcyB0byBiZSBwbGFjZWQgYmVmb3JlIENQVUhQX1RFQVJET1dOX0NQVSwg
YW5kIEkKPj4+PiBwbGFjZWQgaXQgYXQgdGhlIGVuZCBvZiB0aGUgUFJFUEFSRSBzZWN0aW9uLiBU
aGlzIGNyYXNoIGhvdHBsdWcgaGFuZGxlciBpcyBhbHNvCj4+Pj4gcmVnaXN0ZXJlZCBvbiB0aGlz
IHN0YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC50ZWFyZG93biBtZXRob2QuCj4+Pgo+Pj4g
VEJILCB0aGF0J3Mgc3RpbGwgb3ZlcmVuZ2luZWVyZWQuIFNvbWV0aGluZyBsaWtlIHRoaXM6Cj4+
Pgo+Pj4gYm9vbCBjcHVfaXNfYWxpdmUodW5zaWduZWQgaW50IGNwdSkKPj4+IHsKPj4+IMKgwqDC
oMKgc3RydWN0IGNwdWhwX2NwdV9zdGF0ZSAqc3QgPSBwZXJfY3B1X3B0cigmY3B1aHBfc3RhdGUs
IGNwdSk7Cj4+Pgo+Pj4gwqDCoMKgwqByZXR1cm4gZGF0YV9yYWNlKHN0LT5zdGF0ZSkgPD0gQ1BV
SFBfQVBfSURMRV9ERUFEOwo+Pj4gfQo+Pj4KPj4+IGFuZCB1c2UgdGhpcyB0byBxdWVyeSB0aGUg
YWN0dWFsIHN0YXRlIGF0IGNyYXNoIHRpbWUuIFRoYXQgc3BhcmVzIGFsbAo+Pj4gdGhvc2UgY2Fs
bGJhY2sgaGV1cmlzdGljcy4KPj4+Cj4+Pj4gSSdtIG1ha2luZyBteSB3YXkgdGhvdWdoIHBlcmNw
dSBjcmFzaF9ub3RlcywgZWxmY29yZWhkciwgdm1jb3JlaW5mbywKPj4+PiBtYWtlZHVtcGZpbGUg
YW5kICh0aGUgY29uc3VtZXIgb2YgaXQgYWxsKSB0aGUgdXNlcnNwYWNlIGNyYXNoIHV0aWxpdHks
Cj4+Pj4gaW4gb3JkZXIgdG8gdW5kZXJzdGFuZCB0aGUgaW1wYWN0IG9mIG1vdmluZyBmcm9tIGZv
cl9lYWNoX3ByZXNlbnRfY3B1KCkKPj4+PiB0byBmb3JfZWFjaF9vbmxpbmVfY3B1KCkuCj4+Pgo+
Pj4gSXMgdGhlIHBhY2tpbmcgYWN0dWFsbHkgd29ydGggdGhlIHRyb3VibGU/IFdoYXQncyB0aGUg
YWN0dWFsIHdpbj8KPj4+Cj4+PiBUaGFua3MsCj4+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB0Z2x4
Cj4+Pgo+Pj4KPj4KPj4gVGhvbWFzLAo+PiBJJ3ZlIGludmVzdGlnYXRlZCB0aGUgcGFzc2luZyBv
ZiBjcmFzaCBub3RlcyB0aHJvdWdoIHRoZSB2bWNvcmUuIFdoYXQgSSd2ZSBsZWFybmVkIGlzIHRo
YXQ6Cj4+Cj4+IC0gbGludXgvZnMvcHJvYy92bWNvcmUuYyAod2hpY2ggbWFrZWR1bXBmaWxlIHJl
ZmVyZW5jZXMgdG8gZG8gaXRzIGpvYikgZG9lcwo+PiDCoCBub3QgY2FyZSB3aGF0IHRoZSBjb250
ZW50cyBvZiBjcHUgUFRfTk9URVMgYXJlLCBidXQgaXQgZG9lcyBjb2FsZXNjZSB0aGVtIHRvZ2V0
aGVyLgo+Pgo+PiAtIG1ha2VkdW1wZmlsZSB3aWxsIGNvdW50IHRoZSBudW1iZXIgb2YgY3B1IFBU
X05PVEVTIGluIG9yZGVyIHRvIGRldGVybWluZSBpdHMKPj4gwqAgbnJfY3B1cyB2YXJpYWJsZSwg
d2hpY2ggaXMgcmVwb3J0ZWQgaW4gYSBoZWFkZXIsIGJ1dCBvdGhlcndpc2UgdW51c2VkIChleGNl
cHQKPj4gwqAgZm9yIHNhZHVtcCBtZXRob2QpLgo+Pgo+PiAtIHRoZSBjcmFzaCB1dGlsaXR5LCBm
b3IgdGhlIHB1cnBvc2VzIG9mIGRldGVybWluaW5nIHRoZSBjcHVzLCBkb2VzIG5vdCBhcHBlYXIg
dG8KPj4gwqAgcmVmZXJlbmNlIHRoZSBlbGZjb3JlaGRyIFBUX05PVEVzLiBJbnN0ZWFkIGl0IGxv
Y2F0ZXMgdGhlIHZhcmlvdXMKPj4gwqAgY3B1X1twb3NzaWJsZXxwcmVzZW50fG9ubGluZV1fbWFz
ayBhbmQgY29tcHV0ZXMgbnJfY3B1cyBmcm9tIHRoYXQsIGFuZCBhbHNvIG9mCj4+IMKgIGNvdXJz
ZSB3aGljaCBhcmUgb25saW5lLiBJbiBhZGRpdGlvbiwgd2hlbiBjcmFzaCBkb2VzIHJlZmVyZW5j
ZSB0aGUgY3B1IFBUX05PVEUsCj4+IMKgIHRvIGdldCBpdHMgcHJzdGF0dXMsIGl0IGRvZXMgc28g
YnkgdXNpbmcgYSBwZXJjcHUgdGVjaG5pcXVlIGRpcmVjdGx5IGluIHRoZSB2bWNvcmUKPj4gwqAg
aW1hZ2UgbWVtb3J5LCBub3QgdmlhIHRoZSBFTEYgc3RydWN0dXJlLiBTYWlkIGRpZmZlcmVudGx5
LCBpdCBhcHBlYXJzIHRvIG1lIHRoYXQKPj4gwqAgY3Jhc2ggdXRpbGl0eSBkb2Vzbid0IHJlbHkg
b24gdGhlIEVMRiBQVF9OT1RFcyBmb3IgY3B1czsgcmF0aGVyIGl0IG9idGFpbnMgdGhlbQo+PiDC
oCB2aWEga2VybmVsIGNwdW1hc2tzIGFuZCB0aGUgbWVtb3J5IHdpdGhpbiB0aGUgdm1jb3JlLgo+
Pgo+PiBXaXRoIHRoaXMgdW5kZXJzdGFuZGluZywgSSBkaWQgc29tZSB0ZXN0aW5nLiBQZXJoYXBz
IHRoZSBtb3N0IHRlbGxpbmcgdGVzdCB3YXMgdGhhdCBJCj4+IGNoYW5nZWQgdGhlIG51bWJlciBv
ZiBjcHUgUFRfTk9URXMgZW1pdHRlZCBpbiB0aGUgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJz
KCkgdG8ganVzdCAxLAo+PiBob3QgcGx1Z2dlZCBzb21lIGNwdXMsIHRoZW4gYWxzbyB0b29rIGEg
ZmV3IG9mZmxpbmUgc3BhcnNlbHkgdmlhIGNoY3B1LCB0aGVuIGdlbmVyYXRlZCBhCj4+IHZtY29y
ZS4gVGhlIGNyYXNoIHV0aWxpdHkgaGFkIG5vIHByb2JsZW0gbG9hZGluZyB0aGUgdm1jb3JlLCBp
dCByZXBvcnRlZCB0aGUgcHJvcGVyIG51bWJlcgo+PiBvZiBjcHVzIGFuZCB0aGUgbnVtYmVyIG9m
ZmxpbmUgKGRlc3BpdGUgb25seSBvbmUgY3B1IFBUX05PVEUpLCBhbmQgY2hhbmdpbmcgdG8gYSBk
aWZmZXJlbnQKPj4gY3B1IHZpYSAnc2V0IC1jIDMwJyBhbmQgdGhlIGJhY2t0cmFjZSB3YXMgY29t
cGxldGVseSB2YWxpZC4KPj4KPj4gTXkgdGFrZSBhd2F5IGlzIHRoYXQgY3Jhc2ggdXRpbGl0eSBk
b2VzIG5vdCByZWx5IHVwb24gRUxGIGNwdSBQVF9OT1RFcywgaXQgb2J0YWlucyB0aGUKPj4gY3B1
IGluZm9ybWF0aW9uIGRpcmVjdGx5IGZyb20ga2VybmVsIGRhdGEgc3RydWN0dXJlcy4gUGVyaGFw
cyBhdCBvbmUgdGltZSBjcmFzaCByZWxpZWQKPj4gdXBvbiB0aGUgRUxGIGluZm9ybWF0aW9uLCBi
dXQgbm8gbW9yZS4gKFBlcmhhcHMgdGhlcmUgYXJlIG90aGVyIGNyYXNoIGR1bXAgYW5hbHl6ZXJz
Cj4+IHRoYXQgbWlnaHQgcmVseSBvbiB0aGUgRUxGIGluZm8/KQo+Pgo+PiBTbywgYWxsIHRoaXMg
dG8gc2F5IHRoYXQgSSBzZWUgbm8gbmVlZCB0byBjaGFuZ2UgY3Jhc2hfcHJlcGFyZV9lbGY2NF9o
ZWFkZXJzKCkuIFRoZXJlCj4+IGlzIG5vIGNvbXBlbGxpbmcgcmVhc29uIHRvIG1vdmUgYXdheSBm
cm9tIGZvcl9lYWNoX3ByZXNlbnRfY3B1KCksIG9yIG1vZGlmeSB0aGUgbGlzdCBmb3IKPj4gb25s
aW5lL29mZmxpbmUuCj4+Cj4+IFdoaWNoIHRoZW4gbGVhdmVzIHRoZSB0b3BpYyBvZiB0aGUgY3B1
aHAgc3RhdGUgb24gd2hpY2ggdG8gcmVnaXN0ZXIuIFBlcmhhcHMgcmV2ZXJ0aW5nCj4+IGJhY2sg
dG8gdGhlIHVzZSBvZiBDUFVIUF9CUF9QUkVQQVJFX0RZTiBpcyB0aGUgcmlnaHQgYW5zd2VyLiBU
aGVyZSBkb2VzIG5vdCBhcHBlYXIgdG8KPj4gYmUgYSBjb21wZWxsaW5nIG5lZWQgdG8gYWNjdXJh
dGVseSB0cmFjayB3aGV0aGVyIHRoZSBjcHUgd2VudCBvbmxpbmUvb2ZmbGluZSBmb3IgdGhlCj4+
IHB1cnBvc2VzIG9mIGNyZWF0aW5nIHRoZSBlbGZjb3JlaGRyLCBhcyB1bHRpbWF0ZWx5IHRoZSBj
cmFzaCB1dGlsaXR5IHB1bGxzIHRoYXQgZnJvbQo+PiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzLCBu
b3QgdGhlIGVsZmNvcmVoZHIuCj4+Cj4+IEkgdGhpbmsgdGhpcyBpcyB3aGF0IFNvdXJhYmggaGFz
IGtub3duIGFuZCBoYXMgYmVlbiBhZHZvY2F0aW5nIGZvciBhbiBvcHRpbWl6YXRpb24KPj4gcGF0
aCB0aGF0IGFsbG93cyBub3QgcmVnZW5lcmF0aW5nIHRoZSBlbGZjb3JlaGRyIG9uIGNwdSBjaGFu
Z2VzIChiZWNhdXNlIGFsbCB0aGUgcGVyY3B1Cj4+IHN0cnVjdHMgYXJlIGFsbCBsYWlkIG91dCku
IEkgZG8gdGhpbmsgaXQgYmVzdCB0byBsZWF2ZSB0aGF0IGFzIGFuIGFyY2ggY2hvaWNlLgo+IAo+
IFNpbmNlIHRoaW5ncyBhcmUgY2xlYXIgb24gaG93IHRoZSBQVF9OT1RFUyBhcmUgY29uc3VtZWQg
aW4ga2R1bXAga2VybmVsIFtmcy9wcm9jL3ZtY29yZS5jXSwKPiBtYWtlZHVtcGZpbGUsIGFuZCBj
cmFzaCB0b29sIEkgbmVlZCB5b3VyIG9waW5pb24gb24gdGhpczoKPiAKPiBEbyB3ZSByZWFsbHkg
bmVlZCB0byByZWdlbmVyYXRlIGVsZmNvcmVoZHIgZm9yIENQVSBob3RwbHVnIGV2ZW50cz8KPiBJ
ZiB5ZXMsIGNhbiB5b3UgcGxlYXNlIGxpc3QgdGhlIGVsZmNvcmVoZHIgY29tcG9uZW50cyB0aGF0
IGNoYW5nZXMgZHVlIHRvIENQVSBob3RwbHVnLgpEdWUgdG8gdGhlIHVzZSBvZiBmb3JfZWFjaF9w
cmVzZW50X2NwdSgpLCBpdCBpcyBwb3NzaWJsZSBmb3IgdGhlIG51bWJlciBvZiBjcHUgUFRfTk9U
RXMKdG8gZmx1Y3R1YXRlIGFzIGNwdXMgYXJlIHVuL3BsdWdnZWQuIE9ubGluaW5nL29mZmxpbmlu
ZyBvZiBjcHVzIGRvZXMgbm90IGltcGFjdCB0aGUKbnVtYmVyIG9mIGNwdSBQVF9OT1RFcyAoYXMg
dGhlIGNwdXMgYXJlIHN0aWxsIHByZXNlbnQpLgoKPiAKPiAgRnJvbSB3aGF0IEkgdW5kZXJzdG9v
ZCwgY3Jhc2ggbm90ZXMgYXJlIHByZXBhcmVkIGZvciBwb3NzaWJsZSBDUFVzIGFzIHN5c3RlbSBi
b290cyBhbmQKPiBjb3VsZCBiZSB1c2VkIHRvIGNyZWF0ZSBhIFBUX05PVEUgc2VjdGlvbiBmb3Ig
ZWFjaCBwb3NzaWJsZSBDUFUgd2hpbGUgZ2VuZXJhdGluZyB0aGUgZWxmY29yZWhkcgo+IGR1cmlu
ZyB0aGUga2R1bXAga2VybmVsIGxvYWQuCj4gCj4gTm93IG9uY2UgdGhlIGVsZmNvcmVoZHIgaXMg
bG9hZGVkIHdpdGggUFRfTk9URXMgZm9yIGV2ZXJ5IHBvc3NpYmxlIENQVSB0aGVyZSBpcyBubyBu
ZWVkIHRvCj4gcmVnZW5lcmF0ZSBpdCBmb3IgQ1BVIGhvdHBsdWcgZXZlbnRzLiBPciBkbyB3ZT8K
CkZvciBvbmxpbmluZy9vZmZsaW5pbmcgb2YgY3B1cywgdGhlcmUgaXMgbm8gbmVlZCB0byByZWdl
bmVyYXRlIHRoZSBlbGZjb3JlaGRyLiBIb3dldmVyLApmb3IgYWN0dWFsIGhvdCB1bi9wbHVnIG9m
IGNwdXMsIHRoZSBhbnN3ZXIgaXMgeWVzIGR1ZSB0byBmb3JfZWFjaF9wcmVzZW50X2NwdSgpLiBU
aGUKY2F2ZWF0IGhlcmUgb2YgY291cnNlIGlzIHRoYXQgaWYgY3Jhc2ggdXRpbGl0eSBpcyB0aGUg
b25seSBjb3JlZHVtcCBhbmFseXplciBvZiBjb25jZXJuLAp0aGVuIGl0IGRvZXNuJ3QgY2FyZSBh
Ym91dCB0aGVzZSBjcHUgUFRfTk9URXMgYW5kIHRoZXJlIHdvdWxkIGJlIG5vIG5lZWQgdG8gcmUt
Z2VuZXJhdGUgdGhlbS4KCkFsc28sIEknbSBub3Qgc3VyZSBpZiBBUk0gY3B1IGhvdHBsdWcsIHdo
aWNoIGlzIGp1c3Qgbm93IGNvbWluZyBpbnRvIG1haW5zdHJlYW0sIGltcGFjdHMKYW55IG9mIHRo
aXMuCgpQZXJoYXBzIHRoZSBvbmUgaXRlbSB0aGF0IG1pZ2h0IGhlbHAgaGVyZSBpcyB0byBkaXN0
aW5ndWlzaCBiZXR3ZWVuIGFjdHVhbCBob3QgdW4vcGx1ZyBvZgpjcHVzLCB2ZXJzdXMgb25saW5p
bmcvb2ZmbGluaW5nLiBBdCB0aGUgbW9tZW50LCBJIGNhbiBub3QgZGlzdGluZ3Vpc2ggYmV0d2Vl
biBhIGhvdCBwbHVnCmV2ZW50IGFuZCBhbiBvbmxpbmUgZXZlbnQgKGFuZCB1bnBsdWcvb2ZmbGlu
ZSkuIElmIHRob3NlIHdlcmUgZGlzdGluZ3Vpc2hhYmxlLCB0aGVuIHdlCmNvdWxkIG9ubHkgcmVn
ZW5lcmF0ZSBvbiB1bi9wbHVnIGV2ZW50cy4KCk9yIHBlcmhhcHMgbW92aW5nIHRvIGZvcl9lYWNo
X3Bvc3NpYmxlX2NwdSgpIGlzIHRoZSBiZXR0ZXIgY2hvaWNlPwoKZXJpYwoKCj4gCj4gVGhhbmtz
LAo+IFNvdXJhYmggSmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
