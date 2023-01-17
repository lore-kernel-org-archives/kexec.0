Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00672C00A5A
	for <kexec@archiver.kernel.org>; Tue, 17 Jan 2023 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6jQe6Iusjsy/u7kLzBWb9XLeyYeoqiimL2eb7rIKvsw=; b=SjMZccPlV8lRb5yVOwlMcQ3ioj
	ZRI3mBGFf77MEamW+Rb8xuXG2gYva++OjZfq+e1ZN3PWwDjHQENv9J0hvM3Pvo3SfDfJ/0WmcOkvQ
	AVGKrx9cQZh5FN1HXz9zrvmZnHxSycOD6MilPUU19bRfS0NLIf0URwUQEYXuPls2/n6E64abBcz9p
	Z0ocgoHYabxFrGltsk7ojfJKcLxItX9agNUkqdkrLqohezqinXfvaJy4uB2dpwCb1iNWobxIdhW3O
	AtVoXlVfuEwar7klTgdKIbBffLQ+qub4YursduV1GsM+b7cnTaAHR6vqbzFTgVGcdElUqyswlhHun
	TeH4bCEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHuWm-00G6TU-Bo; Tue, 17 Jan 2023 22:34:00 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHuWc-00G6Qo-9m
	for kexec@lists.infradead.org; Tue, 17 Jan 2023 22:33:53 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLwbXl024563;
	Tue, 17 Jan 2023 22:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=vwaQ4TBLzb1BG0irpzKvtNm4OJhwiuHzqczEfjvTsfHKkRGC6aH2FpR/SH2xvGMtJ4Xj
 WaaEWo9hW1xSyaSQT09fREiXnjzZWIWwQCURRUY2aX0yCohStoECWrzFC+dSSCVSScf2
 WlaRM9JiRi7dzF+I1s4IynZS517jQp+dM52ydw/PAiQSRoX0aAsYNsr8zQgmxd1DPTFK
 biuQQcw1KXwsJSUE1A/B+HGxv6jFsBoGfHUCYBBm5P/qsBuU4aTwODSUaMMynDBzvf88
 yGLi0hkvoPVomuAxbn9eeelH1U5oyOnNaxmNLv37v0bO8uhb5xiCwIrgxS+Z2B437Ab2 Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaae7st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jan 2023 22:33:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HM9Se1031048;
	Tue, 17 Jan 2023 22:33:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n647k0ucp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jan 2023 22:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVhxuGKvui25teubT2S01tu9iHOk6w69yYbaSW5TnswHaenQeE7r3ug2QP2uUiOm3dvpoo6+TFO2V8Z4WZ/TQtJb2p04G8m7WNJxyc0OLp/eMJOh7TN5L0QLbWQ+ddhq0uBuKEjHNXDx9kb1hKJ0Gl3jfnDfc/HQguduzYIXYjVzVdiPOs7HmMuYcERow4Xz6JhzgB/A+6J4i6PPvhAzGhPD1ckPC4oF18XDdtkYJoe1ddLNG2V/QeBQcSNPdhRHxceNkGiD67jDRTLYWOMd1MlIMXyLNmTo8GwZOBXP6AJFrFIszMSBXMK8yfPmF8oZlvw+veLaaP9/7LUqz2lZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=GOyTXKAK2bOycc7E8mmSVdyMBxeeAHW+CS7iOFXeE/JTXD1AkAfFXqVoGBWLOpInOlpU82WmR6jEvfZq3Hhno5ikEXw1RATCiPTSPb6E1+HjmtQs+naMfTO3p5RPdmyRWkFSsZe83+N24+AdBxv0gWAyBXmjfccrBveuHy8YYklsLWmJosx3XBfQVFMooUitGVkHj5O5+w4I1LJR0tVkcfjqx2Alo+44Ic79LHi8QMZ1gMBlDal1E2IP9BNfftsk1WzN6GCVAAOvtxa66Zaw/9AvfXUG4aMiEysTPCpMtOKd0LiEGn5xLJ9gWLymrHM17S0jX9I2u+r7HMqpe3AKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=LBkbrIGvo0d4BIzJ7ZnlVOLbN+SXSrnXN8AAto2G3rf9cI2OsNADWyEiySjeh1PmetBbSVttHDMhAisNrrt95gW7JA6iBTbAgB6anfr8clEo37YT1dMN9ByZUAJ9w1iuEgKiQz8t2QHR0jXPKgiLycKyCxe9Fzo9Tp1nsgV1kzM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 22:33:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 22:33:13 +0000
Message-ID: <9b55fc08-f8be-b9ab-fb81-06c4cf846772@oracle.com>
Date: Tue, 17 Jan 2023 16:33:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
From: Eric DeVolder <eric.devolder@oracle.com>
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
 <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
X-ClientProxiedBy: SN6PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:805:66::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a32529-2da6-4022-603f-08daf8dad14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3H+24+vImoZLmmAIzg6UpVhxGMqM2/sUX9/l5cFYDLKj3sZkwgNz4ogL5jIpesydqFzTZ+i3+UnDSZEiXA4YDVyh4yfdSKciXcKUzDpQmFRPtiNhdjZksirpLb2sB2jHIKSxYm87aFmnG82cFFbiK+VMJ5aoovoKBowKLKrt09xJWgEN38QfgbRV276jDsSB8oXQ4NyhRDatEYu0IUpyQ0MLS8fgCYLnHPqFEHMAt7uDhCku2yJgeZc1EIKUTD8JU0ZUU3zGjmWh2N9bbei3dyPOYce8iFPxsXwWO523fgPy8Wh8u5MSK+sqPMZ9ZbBmHCdfD2KMcrU6VggMFMsCkcX4zCuPQRko472mFkh2kqZkxJTuJCNWsT8xz9aBk66Y10xHr3YWm5OkCS0UmGA46u/lc/76TStc0LLJiZ/1V6IHXD4hcEukII4nY8MAOgAx0+Nb/SRTgAFDcoeIFs4dGF6ro6BGbgXxjalRjyz0c3s2JcL4VnFNHf1qG/ws6UovPzmaUcrXObCFxxVM1PkXQIbamBAKvBX8xvZt49pjeIVQ0bDhlzy48SnC01wQIsC/TZcevCBJQDBeyRaXTef4a9laIYcmVQTuWkrERLu4P5Cp2IYs4L+IOLNMeQq4ZG9jrck2v/ZszOwLV8VV25rehhRV/iC7cTFkwmLKouvXZMJ5eOMxmAaBgyv7rrZlejJi+SWzPYB/IkiAAWW8axIZaXK8o4IM9NJCaTS8SAczffs=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(86362001)(31696002)(36756003)(6512007)(66946007)(8676002)(186003)(2616005)(53546011)(4326008)(66476007)(66556008)(41300700001)(83380400001)(6506007)(316002)(478600001)(6666004)(6486002)(2906002)(7416002)(107886003)(5660300002)(8936002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cVR4N20vNTVncElmTVpyZFhXMDlqeDFoV3ZjNldYTDFHOU5Gd0NUWXdBMEtP?=
 =?utf-8?B?TE1EcUJwWmNwSkdkYUhxWkFoenYwZVV0R245M2VaaTdYMWxScDNiQ2Vid2Vj?=
 =?utf-8?B?LzR1NWoxL0VySGkwY01mV0tEeGZnMS9xVXJTa0pTb2FVejFZc1dKMVZkcS8v?=
 =?utf-8?B?R291bG5mdzYxVGR6UXBQTTFOUy9oK3pTTmYzM1FXNmwrMzhqMWEvbVhMWTB6?=
 =?utf-8?B?UTF2S1lPNjcrRUFIbGRicXpyVkU1cUpEaStqMjB1dFNlWldrNUZLMHhMTjQr?=
 =?utf-8?B?UDlMSWFTendNL2NENG5EckdUUGVOd2ppaHMwM2xYby9QeXBzZHZrZnA5OWkr?=
 =?utf-8?B?RUVNeGRPcHNCZDBPTGk2Rmk0dk9ua3h3Q29pME1LNjIyUmNqQldLbm5mMmow?=
 =?utf-8?B?NG5YcjJLTmNBWW5rWk9aVVBrd0JyOFQ1dlBURjIxLzhKOEtRVWExSjdocmdO?=
 =?utf-8?B?cjVKTTlHeWdiTlVJMDh3aUJ4c3ZsOFBJOHVIQ2FSUkExd3pRN2tiUmptZEJW?=
 =?utf-8?B?c2Z5RzhEdXRsS2ZCdG04MVNlQ3dZU3NiOFAzNU1aM0QxM0E1T0RMQ1kwSm9z?=
 =?utf-8?B?bnBYUzdWSDU2U1Z4U3M4azN2NnlsOFdmN2NxbW4vZkg3ZnFERTlGZnFrSEpX?=
 =?utf-8?B?MDc0YjBOQ0p4WVIyOEZGdkkzU2crcDFtMEVmWEprRWw1QjRDMzY3bnAxa295?=
 =?utf-8?B?OUQzY3BhcWJ0bjFzRTdpdEl6Y2VpZzBwZkZoeHNXT3RqWHNnVXQraldxOExX?=
 =?utf-8?B?VXVQL0VkSnE0MkJFSXdpd0VKYS91VkZOcWgwQjlkNnhDc1FNR3BweTJQOWkw?=
 =?utf-8?B?MEVWdXFXQWpuRHJoWjEwOUt4SVlUc3dzSHBwdGVnWE5VZ3dsNDU2MlhCRGdo?=
 =?utf-8?B?TGJGam5OWjByR1FGYjFLYzlIVkpQTjVOei9ySUNHcWRiU3BhQ2krV2R2bXov?=
 =?utf-8?B?VWtWZHdiaG81ZDZWY25zcEZ5S3U0WnN2Y1luRmpYM1JUbEZkMHJ5WXZJZEZv?=
 =?utf-8?B?QVdxRW5aalpNamFwcUpwdEFNcnRUN0xXbFhTSURnYUtmS2FoOW5ZVFc3TWtI?=
 =?utf-8?B?ZDZLNjdNZzB3TGxpbE1kanNzRmxkcFNsTnpMRFFHR1ZjVlliRXhKWng4Mmtx?=
 =?utf-8?B?RFFYSG94UGg2dU9FSDd3M1Y4QURGemllN0x2ak8zazloUGQ5bDgvRHBoY2VP?=
 =?utf-8?B?anRKR3c5K1QxdGo0YTZSd0ZITUZSR3hqMUN0ZWNoVE1nNmxYL01LSVFRcGg1?=
 =?utf-8?B?THR5TGRmT1g4ZktJS01aUGtmZ3FLOEk2WHJQY3RBdkM1TFIrYnd3REF4eEpn?=
 =?utf-8?B?MDFWbVJhTEJGT1NIekJ2Y2tEeTc1ZFdRMHdYRTdoM21NclBDak9PbksxZFRs?=
 =?utf-8?B?TU9FWlJOc004dXF4a1NwS2pJVlJXUXpVK1NBSTRSOUV5MVI5U1dNSjBESFIy?=
 =?utf-8?B?OFN4dUN6UG9Gc1ptdi96anB4UXZVWVB3R2o3ODRCRDVQNDROL0pRSWVmR05j?=
 =?utf-8?B?ZWhNRVo1MGkwa1lhM2lIbENKellxVlFJck1GRGNpeVNPOGRoWmxMRklHbDFV?=
 =?utf-8?B?c1crZVNobGZxbkxYdllwMUtVc29lUUhuSEs4MHdvQzRjc2dXVGlRWXdlai9s?=
 =?utf-8?B?aHJ1bXZEa20zRERraTMvR1A1azArbzd0WjNHWkZwamROSjdFT3JmVHBiUUlR?=
 =?utf-8?B?dXFUZ1Rod1d1dVY3a2gzWUNTUjRVa01ZYVo0ajR4YUd5WExrc0ZDTnhrMnFS?=
 =?utf-8?B?dFdhZzlvMVVKNWZIYzhRZFVjYW9SUnhBb3FsRWFIWXB4U0dHZEJjUXlmWXhj?=
 =?utf-8?B?WGN4U1BLdkk4Qm5aaVMzNGhvczY2ak5yeS9ZQW8xem1EQmwrVjd6S0MzUW5F?=
 =?utf-8?B?NitWRFBPMklTVDEwNm9hbHUvVzM1dnNhM2d4QWNlRTFQMUpVNGMwREl4OU1Z?=
 =?utf-8?B?Sk5mZC9RenJ4bE9Oc3E1ZDkvbjhhWVgrTUt5akNFemQ1SStpN1FwNnhXZ09t?=
 =?utf-8?B?dy9sVzZldzU1L0ZVUGZZN2JKRW5yeDJua2l4SlhwMTYyOTZlSnU4NlFKT1py?=
 =?utf-8?B?TjJxWFV3Q3NvODQvQmdpbFlhaEFtTXA2OUFGTzVnRSt0QVRjdlN0dzJOL3Nx?=
 =?utf-8?B?UzBybFNyT1lRdGc5MWtLOThGMUZ0Ty9nWnVVMllTQi9qbVhta3BBelNFYTlO?=
 =?utf-8?Q?bxsYK+1/mA60jUN7wDRtF90=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?UVBPNGsvVmxvdVFvVVlWWEMvcWRMYjVEVFZsL0xXb2RLTWliUkxieFFmUUJo?=
 =?utf-8?B?T2dvcHpGa1hOY3QxWENBRThJVHVNbXRSVTZkdHpWMWlrbG5mVmU1Y1JoN2p0?=
 =?utf-8?B?SnNpbVBFcFlpbmVtR1ltWFVQVlNTS0p0NTRYaEhQM1luekF3RXB5YVBYTU1V?=
 =?utf-8?B?OTNpdlJoTldYSzJac21FSUJaYWRqbGdBOWVhby9UODB6elhQSjRMTUJFRW4y?=
 =?utf-8?B?bG52V2pBR2pWcWJLbnFZd2o4WVM2SG5yQ0hsbmhMSGUyb2phd2F2ZUdCemNY?=
 =?utf-8?B?S0o4a1Frb2dlTFNoaVdpZ1hBQWdlNVdKL2pIV2lQeXpNRlBRRFZIVnNSNVZv?=
 =?utf-8?B?YitkWkRFN2lyaVpMRjg2dmxUYTAxNHhkaDQ2QjlMYVA4c0VDQVNwSmpnTDJy?=
 =?utf-8?B?U01hdGxLWDBuK1o2MW4xTTg2N21WVHgyWVBjd1dlbUh6Q2dYNTUvbldGYU1w?=
 =?utf-8?B?dU1NbVFiUHFhTmovcEhZbHdrYVFieTZUR1Npdjl6U0JDU0QyNXJTS1J2L0Y4?=
 =?utf-8?B?dHhtNVFZV0d5aXpkV2kzYnA5bmt6dTZheVpwZHNUV0hwUzRPNitRdEQrdWpK?=
 =?utf-8?B?c0F3WStIVFR2alc1ZG1BQ3JPMjhGbFcyVUlJWEwvd0g0Vm51VDViaVo4L0dX?=
 =?utf-8?B?YTVnSkVVeXBhSWxjTGlUL1ZqRXJFN2tDcG1jblByM3pLVnhJVTltS0RCUVQ2?=
 =?utf-8?B?amhMVktJV1Fyc3lqR3RzdkthU3dERkptL213dUZLaXJrcTZxMW5qbVNpOVNN?=
 =?utf-8?B?bkk3R1VKRk40elVEN2ZCN29UVytybDE1RS9kZGtveUppelBzZFBaUlEzM3gr?=
 =?utf-8?B?MjhFUU5XTlkyb2svUlIvbzhhSWlTaGw4L2o0MHJxcG1Mb081TmFiZ1E1OS84?=
 =?utf-8?B?ckk4NUVZbFF2NVpqS3VCR0VHZkVQWTNtd1VYQVE4M29wZU90MHJSb2lBblM4?=
 =?utf-8?B?bit2THNnbHlxODNua1N6Ulp4MXRzU1FwOWtXVlk1eFhPSG0yaEJoNzAzZlpV?=
 =?utf-8?B?RCtqaXpEUlY5S0RuZFNHbHlRVnZGR2hCMGFJaXRnb3ArZlFCK1ZjWGZFRGt3?=
 =?utf-8?B?RlJ5SGlmU1dYZWxRZEpGZ2tGZnpDMXBGSG03WHgyRXRJOUllVEE2Z28vM3NE?=
 =?utf-8?B?TW1YdTBxeWdmMVA0V3pxMWlEa3pJYXEwTUs4K0thUU9tbVErd2VBTGtCYW9n?=
 =?utf-8?B?dE0wZlphb091ZklFM25DM1dQRmN5QzZUeHdhRTRlYTN1ZXBhc2s2YlhKVHJr?=
 =?utf-8?B?RmJCazlMT2lnN094L1luYnBBWHV1MkJQaEpjZDhGUG5MTlVXUEp4WlhORVhi?=
 =?utf-8?B?WGJHOXlPVWVyclFvZ29pVWpyc2JoMUxGMWRvdkVmM1hSYnFlRFE1eHZ6bHIw?=
 =?utf-8?B?d3cyNjJLMWdGT1J2Sjh0UFF1QzFpelh4QVhhUGlOWGR6U3BITDg3MnVYVVlI?=
 =?utf-8?B?aEFDQXBzTkM0c3pjNTFYalBNc3JUUDFsaWJUMkYzU2FUUVN1a1F2emZ3M2VN?=
 =?utf-8?B?djZWbkZDcXZMNWs3aU82ZkNHSDZkVlByM05UK1FmOStBOHBkc1JRK3JMeGd0?=
 =?utf-8?Q?1ZRmWcY5zGSu2V6zFS+DX+T2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a32529-2da6-4022-603f-08daf8dad14e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 22:33:13.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfIXJtZIn7QaEYaxIaPSwxIUpVgEzt6p/lLUWv8XBrUD/LeC4/LLFSYrksSLXFN1uRMLa+vfLQVGK5y9QqqTYxvc81XcHThO3ytyIUlA7Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170180
X-Proofpoint-GUID: caZ5HGp8ZI6yCUCYfVSXZk-tY61NYThI
X-Proofpoint-ORIG-GUID: caZ5HGp8ZI6yCUCYfVSXZk-tY61NYThI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_143350_358508_F267E54D 
X-CRM114-Status: GOOD (  20.97  )
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

CgpPbiAxLzEyLzIzIDExOjIzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+IAo+IAo+IE9uIDEvOC8y
MyAyMzowNSwgU291cmFiaCBKYWluIHdyb3RlOgo+Pgo+PiBPbiAwOS8xMi8yMiAyMTowNiwgRXJp
YyBEZVZvbGRlciB3cm90ZToKPj4+IEF0IHRoZSBvdXRjb21lIG9mIHRoaXMgcGF0Y2ggc2V0LCB0
aGUgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkKPj4+IGlzIHV0aWxpemVkIG9uIGJvdGgg
dGhlIGtleGVjX2ZpbGVfbG9hZCgpIGFuZCBrZXhlY19sb2FkKCkgcGF0aHMuIEFzCj4+PiBzdWNo
LCBuZWVkIHRvIG1vdmUgdGhpcyBmdW5jdGlvbiBvdXQgb2Yga2V4ZWNfZmlsZS5jIGFuZCBpbnRv
IGEKPj4+IGNvbW1vbiBsb2NhdGlvbiBjcmFzaF9jb3JlLmMuCj4+Pgo+Pj4gTm8gZnVuY3Rpb25h
bGl0eSBjaGFuZ2UuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBEZVZvbGRlciA8ZXJpYy5k
ZXZvbGRlckBvcmFjbGUuY29tPgo+Pj4gQWNrZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPgo+Pj4gLS0tCj4+PiDCoCBrZXJuZWwvY3Jhc2hfY29yZS5jIHwgMTAwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCBrZXJuZWwva2V4ZWNfZmls
ZS5jIHzCoCA5OSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA5OSBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9j
b3JlLmMKPj4+IGluZGV4IGEwZWI0ZDVjZjU1Ny4uNDZjMTYwZDE0MDQ1IDEwMDY0NAo+Pj4gLS0t
IGEva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4g
QEAgLTEwLDYgKzEwLDcgQEAKPj4+IMKgICNpbmNsdWRlIDxsaW51eC91dHNuYW1lLmg+Cj4+PiDC
oCAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3NpemVz
Lmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2tleGVjLmg+Cj4+PiDCoCAjaW5jbHVkZSA8YXNtL3Bh
Z2UuaD4KPj4+IMKgICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KPj4+IEBAIC0zMTQsNiArMzE1
LDEwNSBAQCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9jcmFzaGtlcm5lbF9kdW1teShjaGFyICph
cmcpCj4+PiDCoCB9Cj4+PiDCoCBlYXJseV9wYXJhbSgiY3Jhc2hrZXJuZWwiLCBwYXJzZV9jcmFz
aGtlcm5lbF9kdW1teSk7Cj4+PiAraW50IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycyhzdHJ1
Y3QgY3Jhc2hfbWVtICptZW0sIGludCBuZWVkX2tlcm5lbF9tYXAsCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdm9pZCAqKmFkZHIsIHVuc2lnbmVkIGxvbmcgKnN6KQo+Pj4gK3sKPj4+
ICvCoMKgwqAgRWxmNjRfRWhkciAqZWhkcjsKPj4+ICvCoMKgwqAgRWxmNjRfUGhkciAqcGhkcjsK
Pj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBucl9jcHVzID0gbnVtX3Bvc3NpYmxlX2NwdXMoKSwg
bnJfcGhkciwgZWxmX3N6Owo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBjaGFyICpidWY7Cj4+PiArwqDC
oMKgIHVuc2lnbmVkIGludCBjcHUsIGk7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbG9uZyBu
b3Rlc19hZGRyOwo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIG1zdGFydCwgbWVuZDsKPj4+ICsK
Pj4+ICvCoMKgwqAgLyogZXh0cmEgcGhkciBmb3Igdm1jb3JlaW5mbyBFTEYgbm90ZSAqLwo+Pj4g
K8KgwqDCoCBucl9waGRyID0gbnJfY3B1cyArIDE7Cj4+PiArwqDCoMKgIG5yX3BoZHIgKz0gbWVt
LT5ucl9yYW5nZXM7Cj4+PiArCj4+PiArwqDCoMKgIC8qCj4+PiArwqDCoMKgwqAgKiBrZXhlYy10
b29scyBjcmVhdGVzIGFuIGV4dHJhIFBUX0xPQUQgcGhkciBmb3Iga2VybmVsIHRleHQgbWFwcGlu
Zwo+Pj4gK8KgwqDCoMKgICogYXJlYSAoZm9yIGV4YW1wbGUsIGZmZmZmZmZmODAwMDAwMDAgLSBm
ZmZmZmZmZmEwMDAwMDAwIG9uIHg4Nl82NCkuCj4+PiArwqDCoMKgwqAgKiBJIHRoaW5rIHRoaXMg
aXMgcmVxdWlyZWQgYnkgdG9vbHMgbGlrZSBnZGIuIFNvIHNhbWUgcGh5c2ljYWwKPj4+ICvCoMKg
wqDCoCAqIG1lbW9yeSB3aWxsIGJlIG1hcHBlZCBpbiB0d28gRUxGIGhlYWRlcnMuIE9uZSB3aWxs
IGNvbnRhaW4ga2VybmVsCj4+PiArwqDCoMKgwqAgKiB0ZXh0IHZpcnR1YWwgYWRkcmVzc2VzIGFu
ZCBvdGhlciB3aWxsIGhhdmUgX192YShwaHlzaWNhbCkgYWRkcmVzc2VzLgo+Pj4gK8KgwqDCoMKg
ICovCj4+PiArCj4+PiArwqDCoMKgIG5yX3BoZHIrKzsKPj4+ICvCoMKgwqAgZWxmX3N6ID0gc2l6
ZW9mKEVsZjY0X0VoZHIpICsgbnJfcGhkciAqIHNpemVvZihFbGY2NF9QaGRyKTsKPj4+ICvCoMKg
wqAgZWxmX3N6ID0gQUxJR04oZWxmX3N6LCBFTEZfQ09SRV9IRUFERVJfQUxJR04pOwo+PiBTZWVt
cyBsaWtlIGFib3ZlIGZ1bmN0aW9uIGlzIG91dCBvZiBDT05GSUdfS0VYRUNfRklMRSBidXQgc29t
ZSBvZiB0aGUKPj4gc3RydWN0dXJlL2F0dHJpYnV0ZXMgbGlrZSBjcmFzaF9tZW0gYW5kwqBFTEZf
Q09SRV9IRUFERVJfQUxJR04gYXJlCj4+IHN0aWxsIGRlZmluZWQgdW5kZXIgQ09ORklHX0tFWEVD
X0ZJTEUgKGxvb2sgZm9yIGluY2x1ZGUvbGludXgva2V4ZWMuaCkuCj4+Cj4+IFRoaXMgbGVhZHMg
dG8ga2VybmVsIGJ1aWxkIGlzc3VlIHdoZW4gQ09ORklHX0tFWEVDX0ZJTEUgaXMgZGlzYWJsZWQu
Cj4+Cj4+IFRoYW5rcywKPj4gU291cmFiaCBKYWluCj4gCj4gQWZ0ZXIgbG9va2luZyBpbnRvIHRo
aXMgZm9yIGEgYml0LCB0byBhbGxvdyBob3RwbHVnIHdpdGhvdXQga2V4ZWNfZmlsZSB3b3VsZCBy
ZXF1aXJlIHF1aXRlIGEgYml0IG9mIAo+IGNvZGUgbW92ZW1lbnQuIFdoeT8gQmVjYXVzZSBob3Rw
bHVnIGlzIGJhc2ljYWxseSBidWlsdCBvbiB0b3Agb2YgKHBhcnQgb2YpIHRoZSBpbmZyYXN0cnVj
dHVyZSB0aGF0IAo+IHdhcyBuZWVkZWQgZm9yIGtleGVjX2ZpbGUuCj4gCj4gSSdkIGJlIGluY2xp
bmVkIHRvIHN1Z2dlc3QgdGhhdCBLRVhFQ19GSUxFIGJlIGEgcmVxdWlyZWQgZGVwZW5kZW5jeSBm
b3IgQ1JBU0hfSE9UUExVRywgaWU6Cj4gCj4gIMKgY29uZmlnIENSQVNIX0hPVFBMVUcKPiAgwqDC
oMKgwqDCoMKgwqAgYm9vbCAiVXBkYXRlIHRoZSBjcmFzaCBlbGZjb3JlaGRyIG9uIHN5c3RlbSBj
b25maWd1cmF0aW9uIGNoYW5nZXMiCj4gIMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQgbgo+IC3CoMKg
wqDCoMKgwqAgZGVwZW5kcyBvbiBDUkFTSF9EVU1QICYmIChIT1RQTFVHX0NQVSB8fCBNRU1PUllf
SE9UUExVRykKPiArwqDCoMKgwqDCoMKgIGRlcGVuZHMgb24gQ1JBU0hfRFVNUCAmJiBLRVhFQ19G
SUxFICYmIChIT1RQTFVHX0NQVSB8fCBNRU1PUllfSE9UUExVRykKPiAKPiAKPiBJZiB0aGF0IGlz
bid0IGZlYXNpYmxlLCB0aGVuIGl0IHdvdWxkIGFwcGVhciBxdWl0ZSBhIGJpdCBvZiBzdXJnZXJ5
IGlzIG5lZWRlZCB0byBwcm9wZXJseSBzZXBhcmF0ZSAKPiBvdXQgdGhlIGl0ZW1zIGhvdHBsdWcg
bmVlZHMgZnJvbSBrZXhlY19maWxlLgo+IAo+IFRob3VnaHRzPwo+IGVyaWMKCkkgY29tcGxldGVk
IHRoZSBjaGFuZ2VzIG5lY2Vzc2FyeSB0byBtb3ZlIGNvZGUgYXJvdW5kIHRvIGFsbG93IHRoaXMg
dG8gd29yayBvdXRzaWRlIG9mIEtFWEVDX0ZJTEU7IAppbiB0aGUgZW5kIGl0IHdhc24ndCB0b28g
YmFkLiBJJ2xsIGluY2x1ZGUgdGhlc2UgY2hhbmdlcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLgplcmlj
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
