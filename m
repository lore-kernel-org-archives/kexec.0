Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED2C83F2E
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OGFrLoIVnRQgyEOc0Y1VmBtaPyME+w30y+9wLTPFoo=; b=JRA2uwboeGluvXI2bkA6ASzql9
	Qb1fLR8MCCYLDMtIrN47h8LKguJRYf4BI/+ewuAhL0nNRHjY9C8Us54/ISiZNF+brKvA3byowBytW
	lJ+2auii4c0/1/98P4QSpuV4Lwf9P6MImpxep9RGR8FT67XxzUrQdK6YVNOpt/nD8caV3jz/H+wrb
	E9fhse6NqrFD6BxDdt6PnTVZkflRcz+BYSENHd7R96PfOdr2Ju/X1Hg7k6p7DkcBjv28bkLHXzIfO
	rv7XGjIWotAv1S5yj3Wtvn4fTiHzvfjiKjhwECf8F4MHiVNx6K6jKVLqHdIImKrEururte0s/UEVz
	XJfMIFrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgvh-00000002aLY-3njh;
	Thu, 29 Aug 2024 15:19:21 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgve-00000002aK3-45MG
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 15:19:21 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDsZU3018957;
	Thu, 29 Aug 2024 15:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AsVYIf2io2+dZ+MOOUMTKrbszUsfsiZ1mX6nRXXCaok=; b=
	Ez4Niy1bUw9qFt/pNlk1CIjMKSaYTdo+JQUN4Czyqff6FYjLg0OAi411029FqUqc
	tetafOTeKzrEokuuxquuaL+E73cuZNBV7B9xP1CC3FKvFrFZG6Yzjbafu5jJd//o
	oLXRMlC7gBTi/X6f1c77W2yXUcJMpxWCgGgdtNeKSqsLXrsb+c3Ucrt4qWTR4yFX
	NCVZ2hi5v6/mPfg31OmMgK9XmgRrXfHJ+sxDhEawWw2zxYjQ7x68eRU81XbH3Qgh
	WcISAkKxv2OFCgkdbek0QECRkN/QQ442GCy06Fai+LEd9DgdBgl0qsz8F8Lg5s3L
	PPLmBGsx1oBKZY0myB+6qA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugvg73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:13:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEZHMR034802;
	Thu, 29 Aug 2024 15:13:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw4jr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRwBTSGQ+z0RlX/rwtpffTgcqzE1shQWGx8S4yXELa3k2vknfTBbFXcXNfbKasZ6dLIbpaqOcCrRX43+NeWspV+wpI0KtIOzAWEtEh34ZykBZffJBZrs50KIF/V4FMUa2OLKZlaiMX1k3kVnf9oDxqCITYZVKFYNJ/1+nwDVzfZcHA/njkC/AvCrd61FMAfZ7GKpnGr5jE8DsNC9JjR1efVDYqKa1MOIGBh/078S6DASdQ58T0KQMg+d2/Xu/dO0MdmWccRmg2rOTPmeCAaKffBeZ4+ux+QCfzFkLyWxAIkGVdOffBilbiPKsVWH/gdgQ4kNgG6Lk2fJNXzCG2ru2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsVYIf2io2+dZ+MOOUMTKrbszUsfsiZ1mX6nRXXCaok=;
 b=rGYCow625eu7XO24v4uLoyjC9uoIvETOsldoCjdg9oLIOhX/+rly2WLHJZo2AMoWcu67kWOiAqn9wbHlk/yv6DtaymmizdjLMIuGiEBA/6CB8BGBNnl8Pf0OqHKgosjANxAx6kFVgdD5rCqZzHBlGtXSjG5OWNe87ymEA+GOVI4X8msvvOe6FNXVjW+x0qXM+xat3eadOX/q/sZTWq5r7LYNHuOiE9XebvDTbh30VDHIHkTj1H3CqpqZN3AqR1jc6k1TgA8mg4YkyP5I/U1XbUAGx8LxxiqHsmie8Q+/agwM5NGkP0BwJifPaDfBa72u17K8/eKpit41+O6jrA+HNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsVYIf2io2+dZ+MOOUMTKrbszUsfsiZ1mX6nRXXCaok=;
 b=KYvN/lKCtPgySmiTNb8OcoxmEqR7lk5UGyrgCgLS/Z3a91lsAAAlx8bMNGTVo5GFqsy/dhVIXIQFYCy5sVzpyWh9lv3bXSFlRhUNC92XRgVS5czZHraT7Z8kpFd7Q7YGdKXiHvdf1361Ev1cLzpBCJvda789o54UXzFVjsSub9w=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB7712.namprd10.prod.outlook.com (2603:10b6:806:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 15:13:39 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%7]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:13:39 +0000
Message-ID: <98330007-d07e-4124-a26a-0ffb3d50a773@oracle.com>
Date: Thu, 29 Aug 2024 08:13:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Ard Biesheuvel <ardb@kernel.org>, Jonathan McDowell <noodles@earth.li>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org, oe-kbuild-all@lists.linux.dev,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com>
 <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
 <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com> <ZtB2bP1Mx3zTr9e5@earth.li>
 <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3d0594-6473-410b-9066-08dcc83d2973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkxnSHdBR0N3bE1nS1dscWpZWlZoV3d2dTdIcmsxeVZ0ckFsanBtdnRxbWNp?=
 =?utf-8?B?QTBMM2VHQnlCbXRNU3RiWHdiNW8xMUJReXFwdmx2Z0NVbGRvRzlBNmlNSE91?=
 =?utf-8?B?akYwMGcrdXByVmVENERRNENDcHZ5NC8vSVYwcHZvT2cxZzI5Z2d4dFBoTkIv?=
 =?utf-8?B?RU9jZmo2TDJyNnBoMjk0MlVmN2I1MWdEWHl4eTRkMU5ReGNYWE9iakFJRDZr?=
 =?utf-8?B?My9pZjF3cHhSaStVeUk4YU5rNTdxZUlvUTllN3NMODRmNmpiVkhpK3Awbk1P?=
 =?utf-8?B?SWhHQXI5aGU0KzhadStPVUwzeGllRHk4aDdMMjQwN3ljUTcvLzVSVFhoY2lU?=
 =?utf-8?B?SFJrRUtCbVNYNzdWenJPR1FOYUI0aTJuYWhBNjNwSUdlRTdKaW1pU0JpclE2?=
 =?utf-8?B?a2J6WkVVZUJ3ek9RdUhBZ05UMWtaWCtZWFZxbHQrUlRWbC9uK2FPMStab0lC?=
 =?utf-8?B?WkV1K3BZdnJzeXl4ejU4RjlsSkZ3MWM1VWxYTXEzdjl5Wk1LZDNTeFpOWG9D?=
 =?utf-8?B?c3Y2dE9FNy9DYVNnWW9Lb21UOVVNMk5NUDRvVUMvYVRuVjRsNDhsTjdZcnUw?=
 =?utf-8?B?SU5kTzFacm5Ga3h2QnlwbmVHQklBY3dubzNVMDZoNzZIRGFXSEkvUHZmc3ZH?=
 =?utf-8?B?Sk5VU1grRjZZSUpWNnFwVXNlbmNjZWwxUm93emQ0UE5VeWh6b0F6YU0rOFRX?=
 =?utf-8?B?bE5LWExCMnNQYmdiMHUrQVM4aG9aZjB5T3BLeGppa2JYa1JtcnZhZVJYM0tx?=
 =?utf-8?B?RnQyQ01tRjk1Z2treld5UVNQaFVzbmdEWFNHaDdsODM1YUdkS0RzeXltYlFS?=
 =?utf-8?B?cDFrSitobjJselNCVlB3ODdVMWNIdkdaSnFzR2NSaUFuVnJIT1duNVo3My9G?=
 =?utf-8?B?S1JXS3J6ekxWN255aUxrODhuNE1ZdXE3YXdBaVBCTEpzVXB4amNINE5TcnYr?=
 =?utf-8?B?NEpTaEVVc2VIZ2hXMDUzcXlVYkh1QmZFaDlwVStEMVZ2NmhFVzBxZ1Vubllh?=
 =?utf-8?B?dWZnTGprcVFUSkYvbEpLN1BxdWZ4VkpkUUhITndEQjM0YlJjNTk1ZXJRYzRW?=
 =?utf-8?B?YXpVcThXWTA0SWNRcG41dmpIY3BIc3dNS0RsRGV6WlRkcEN2REJDdEw3blcr?=
 =?utf-8?B?VVZ2alZrcTV6MDlESzY0a2s2ZmJJL0lNcVQzd25uRlRwZXpma0pRaUNVTmNm?=
 =?utf-8?B?S0VEY1AvM01JMmt4QTRKZWZsSHBPYWJiM0xSQXUyWTRqMGp3Kzc3NUlodDMx?=
 =?utf-8?B?QW9YMnVBWFZOKzl6M0dudjlTRzRlRllUSzY2allQdFcrcmxRVWd0SmRCWHZz?=
 =?utf-8?B?OHVXTDRnZnZldXJKRk95L2V4bzhGNGdzdzR2OEhEVExkQk5YbzY5MGxhWlND?=
 =?utf-8?B?ajVSQ0VuYjc3QW40MzlnZ1FmbDZhMGMxaVEzbjBrcno2M0ZMNVhFdFZvOS9w?=
 =?utf-8?B?VmJQSDJrazA0eTNzcGpyei9abnMvMk9DdXRwNlNsU1EzOXpieng5RXVIZXNI?=
 =?utf-8?B?amVlbHFWdWdscUVacmtqdmFETEUxZStWNlFRRVdWa0crdm4xUmhJOWxHYXdx?=
 =?utf-8?B?emlWZU1YQWdaaUFVbGZEeEd4ZTgxYzIyUFU0dVg5MktwTWtTWllZTTd6WFhJ?=
 =?utf-8?B?NTl0Z2tnV1R6b0tLajIwVkhCdVB4YVpxdmwzVTVkMVZ2VEUzV0Y0UUVPWVdw?=
 =?utf-8?B?Q1dYU1pVV1c4NzBOYWo1UUxuSXV6RG5DcEN5YVUzelIwR1V0c1gwRXlIREJC?=
 =?utf-8?Q?Jgb/XQu/oyTH7N2qWHP2imhD/wSd/82tWSWTw67?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZqZmNSMjFURWdpT1dCUWlKd2o1Q1RZa1prZGFoL3puVlVJSE1Vb3hTYm9U?=
 =?utf-8?B?cmw5a0UyUm5xeElBb2JTbjdUMFpBckkwSGVSdlZzWllsSkV2M1hlZnRFQzlS?=
 =?utf-8?B?T0tWWjFZQ3RsMlVEQm52Rm5tMUZGQWJwQXJFR29EUWVsZFRLZFVDZDZPNlZZ?=
 =?utf-8?B?SnpKNXE5cjZNQmdhM1FLdzV1YUUwdi85ZE1PcHV6Qm55MTJqZWdlVjJKalFL?=
 =?utf-8?B?Y2RVSC85MkNhMTFmRHhza0lBd3VPa2JDNU5hZ0xXUTIvUW1acC9mOWR1QTZQ?=
 =?utf-8?B?QmQ5cVdIYkNleDRWM3JmdXZTZjFibDRwYi9ZSWJ1ZmtlY3dNMzA2UHVpVVFC?=
 =?utf-8?B?c0wxUDlxVTlqWm9zNDFRZWFlRGR0dU9HTTBwNTAvNlJBbGxGbjdOd1dtME5o?=
 =?utf-8?B?U3Y5SXJrMVVTbGNHdHE3cEVJTXZ6YkRlZ2FGc2drOHd5NElHRktocjdOeTlJ?=
 =?utf-8?B?TUtUV3FyYXZvKzFNc2J6VlRzcHdIZ3IrUVFJZEVPNlpHaUVBWUVvM0tubzZj?=
 =?utf-8?B?UTlFQWdVNXZIcE5OejJSdDl4aEVuQnhZQWZKcVh2Z2J1TW5YbXMvSlJRbWYz?=
 =?utf-8?B?eW5QdWtoMDUzbXB4Vk5jVlo5N2VYR1kwNWh6Y3dOd2pPS0FzOTREWktZckNP?=
 =?utf-8?B?LzlWUnQxSGVqTWRhK3J5elM3WUdXTVhEYWdHdmtmWjNDVXZrR3kyNkNPM2RE?=
 =?utf-8?B?QU9zSjhRZGFBdlA5NDVBY1g2b1NVVXB0Q0ZQLzJ3dnVTMmhlbTB4QzdrRFlq?=
 =?utf-8?B?UGpSVDFkeFE2ZFZnU3ZKb3JyQzJtaytVWHYvM1VpR09KQ3ZkYkZEMzBiM25m?=
 =?utf-8?B?VngvcmRxWjJEQ1Noa2ZaUTJZR0RVenN0SkxiYjduZVlMUjdCaGxUVEVIcEZs?=
 =?utf-8?B?Y0VSbjN1bHAwRWpXZzFhTHRDcWxOdGh5VktMNXRaNGpudnBSZExSTXNBRHFQ?=
 =?utf-8?B?eFlJeGhrQzhLS1ZsYVR1OWpIRkJic2VYbkgzcEJ4Z1hLclpwV0VWMmEvZDJZ?=
 =?utf-8?B?SytDL1QrcFE1eCtIM3Z4Q0hWNlhuMHltYWtveCtxYk1EZFhvUE4xMnZmZ054?=
 =?utf-8?B?UUt0MUx6YXMzU2xENVp6NGdOOTdvRENBRXNGcDNhdkdNZFhJaXcvZFdYcXVq?=
 =?utf-8?B?blpxaWhFcXovNVdPN1lJOVFaNmxEVjg4NkZZMURBT2xackVmYVN3eUJBcW80?=
 =?utf-8?B?MUtYdmh2T1dSUytac0xIemgxQ09URVhrdW05aDBZVHZaR0NsYlV6T0hsbGJU?=
 =?utf-8?B?WWxpVStYY3pEN2o0UlIyY0FWaVFPVk5RcjU0Q3FMZnBnMjdSckRsYTQ4K1JI?=
 =?utf-8?B?dnl6cHNjZGlvNkQzMnZ6VkdxVE9YKzUzbkFURnMwby9hRDZ2ZmJWOUZSQXda?=
 =?utf-8?B?elFuT1M3d2tTMlFxZzJJcGVKN0VuUDUwRmhHN1J2Q3V2YXJLaFF1OFJUUUdV?=
 =?utf-8?B?QVJMNHhnT2xZRnM4VlVjU2h5QWlGczBzUk0rdmJVQnd0VTJEaDA4WmZZcWlZ?=
 =?utf-8?B?enN1MXVuM1BXTmhDU3IzTlU5Z2RQWkpldVVWSEYrTWRJdlowaXkrYWVuYmRX?=
 =?utf-8?B?VDhhUDlLR0ozZlh1emRPSVltalhOdTlIVW9QNlZmVXZVbnczaGMxeDlaOTd4?=
 =?utf-8?B?UWlmSnhFbWxUOTVQNUFTQjM2MkVrK3BRRDBWdDc4WHZTa2x5eDBqYUx5UU4y?=
 =?utf-8?B?MSs0RVEzR0s2S2xkdGltYytxaVY5bm84a1lvN2dlN1VmcElSQ2hKOVVhUXV5?=
 =?utf-8?B?RlEwVTVMdWNpTjh0TWUrbUdZbnpVNmxUNk4xald4VVNKR21Memt4a3dMZ1Ar?=
 =?utf-8?B?a3o2RTlBTUpka1UwdjVZSHRTMzRpcmNDZkYzUVlDWE1uVUdUZjVWU3cvS1hY?=
 =?utf-8?B?SjdHS3RMbnF5WXZ6ZlRjWmdteWlTL2puenlwL1BpSlVFRC9XY21nNDFBMjRS?=
 =?utf-8?B?QnBFdHFJREJqZ1F6eWhXTEQxL0NGNEdHNnJueDlXTzdaVVhLeEhrS1RQd1hW?=
 =?utf-8?B?WWxNSHVFc2s2b3FURjRaUWtBQWNIaEZCSnYrUkp4dkx2dW9jRXh1ektiR3Bt?=
 =?utf-8?B?RFE4UjRGOTJ4ZUtKYnJFcG9kdUtWeVI3aUdIczc5aGp1cTVranFRS0tHaEgw?=
 =?utf-8?B?Qkthb05mZWtJVGNYakoySVhRV2VoTTFkNlg3UkhPNTQ1dFpMZmxoQ3ljekRF?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wf6d4LBdwoOVKYFZh3lXjmA9rFKyZO3mCMmpag771v3zVU4srI4QbjA7hDaVB1obEbtWKeXuTmoBp8qPwLlsdmfHx743XUMSNILjvH1K2WHa7bNHac/Vot/SZfp2GAoR88O1zJklsCfyfXpXJpHsCblaxDnrmVPMnZF2YvJnXcwbi4fPaE53y8URAdDD0omWDc08bwiJ8X4yu8FN371qjMK/s3hGZgcjA15lz+F8v4jD6dmfWblYmTFRXSzCbyixFksNxx6M12wsJYjIWKZBzj7HpnkIe5hL9sw6kM8d6sMoAFHzxBZDW8LCmpcl4GiyrRwcPVE+xY7tO/8L4BV8hu+9zcrjnlG0aqMUUPcXxE7lRCLi1htkJPJgiLfr1nIyK7gqamE3N+CK0wEpbYUtegzeI3ZuVfBZWziPTKgnaWmgv/bhhanBasioZH3Jftshf21F/P3KLkqEJmV2YzwigSAPuGYtyEI4+VbaAySVWahId5ehRJTyBz5LrEVZkfX6525Upr8bMpqg0GOXOQx/5YUnkc+Al0gxNZ5uHMm6F9DsnFiCHMRtQvVCdjrPqqnUbjmwUK64M7mORXNLTuxEiLa8eP3oqqYxaoWv74DAINo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3d0594-6473-410b-9066-08dcc83d2973
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:13:39.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH5PXKMs/cKnxPkHlu5ltOrKWlza3RRw+Wss36RJBfRj9oYCLO53wGXHY/iZmOaCoIhjuZObDS/7aJnWonKZwLxTPeWNlbP0NptQYmTYLMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290106
X-Proofpoint-GUID: x7lqoKg2ZUs0_VDtEQJnyrXVvScCsW5p
X-Proofpoint-ORIG-GUID: x7lqoKg2ZUs0_VDtEQJnyrXVvScCsW5p
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_081919_155319_597CFFEA 
X-CRM114-Status: GOOD (  14.35  )
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

On 8/29/24 6:28 AM, Ard Biesheuvel wrote:
> On Thu, 29 Aug 2024 at 15:24, Jonathan McDowell <noodles@earth.li> wrote:
>>
>> On Wed, Aug 28, 2024 at 01:19:16PM -0700, ross.philipson@oracle.com wrote:
>>> On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
>>>> On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
>>>>>
>>>>> Hi Ross,
>>>>>
>>>>> kernel test robot noticed the following build warnings:
>>>>>
>>>>> [auto build test WARNING on tip/x86/core]
>>>>> [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
>>>>> [cannot apply to herbert-crypto-2.6/master next-20240828]
>>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>>> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
>>>>>
>>>>> url:    https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
>>>>> base:   tip/x86/core
>>>>> patch link:    https://urldefense.com/v3/__https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIzWfs1XZ$
>>>>> patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
>>>>> config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
>>>>
>>>>
>>>> This is a i386 32-bit build, which makes no sense: this stuff should
>>>> just declare 'depends on 64BIT'
>>>
>>> Our config entry already has 'depends on X86_64' which in turn depends on
>>> 64BIT. I would think that would be enough. Do you think it needs an explicit
>>> 'depends on 64BIT' in our entry as well?
>>
>> The error is in x86-stub.c, which is pre-existing and compiled for 32
>> bit as well, so you need more than a "depends" here.
>>
> 
> Ugh, that means this is my fault - apologies. Replacing the #ifdef
> with IS_ENABLED() makes the code visible to the 32-bit compiler, even
> though the code is disregarded.
> 
> I'd still prefer IS_ENABLED(), but this would require the code in
> question to live in a separate compilation unit (which depends on
> CONFIG_SECURE_LAUNCH). If that is too fiddly, feel free to bring back
> the #ifdef CONFIG_SECURE_LAUNCH here (and retain my R-b)

Thanks to both of you for the followup.

If there was a very large amount of new code here, I would consider 
making a separate compilation unit. I can't really say if this is a 
wider issue with the the EFI libstub code but if it ware broken up 
later, it would make sense to move our bits to where 64bit only code lives.

Given that it is a small block of code though, I am inclined to just go 
back to #ifdef's for now.

Thanks
Ross

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
