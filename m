Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6D2C433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IkS3zM4YQQmeHmhKhhJ74UAdMqcnil8edn0kTOLU53M=; b=lwETVrBClalNZ8VJF5WcneyFob
	bwvsfuQS/es6w31Ph0jAsvBpHHiO8TKi4AulmVZ6bOfsDh3IpcwJ4+3VjuDieIiigyKl8OevnFzLN
	vcZcMSEQ4YLN+Q30lABBkanQcD+rLA5F5y6+yLhq5QIQqXnlI3USf47ordSJ7IVi+c6OpGGzBviSG
	dauuUq1TKk/HU3Qu/nNm+AFrCm7ffzm8WqcNvL5y56ngWCdWgmNVH6NiVmXZkiYG8YbcsUdpDn6np
	edURazgOyCGf/gBOYgXX4lE+RoDDLqQNaDYVbTHghxugx3BNZLkF749w5t8GugqyhdM/tku6wNXnL
	iLHdUDuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oieWi-008g9R-Lq; Wed, 12 Oct 2022 16:24:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oieWg-008g7q-HX
	for kexec@lists.infradead.org; Wed, 12 Oct 2022 16:24:11 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGBqTx020692;
	Wed, 12 Oct 2022 16:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xaYltWjuVLJxdhsQRYyNl2NwaeBJNJ0l2Mfqc0OEp4o=;
 b=bpx/gTxrZanUhUchOzk9C8gOtrBx9/ib8K0y4FOXJUqG0iBnLNqMATZQc/Ac67nQj7rb
 L/jtUQ3bWCIPxfx1yy1/EX+e6bIW++2SaZee2O+jqsrnruZBaSqFUbrOqg+IFkt8cFpY
 3+D4A5QgQoTk8knMH3wLBUCJrSDSSDj0VgjWPuEBpfdS6ymiGY9qqM02wHgVnUTOInkJ
 GMvMiFTmhhGO8b/1Os765DK3sIsDx8W9WLLcIW5ySgkW/Sf4yodbPhjUVsEyiOtlZSKD
 w9U0MzqHoHP5MjZYYRuzg0XZ5YvPtMMk14MH4yO/G5XfTATf6MN/u1d+o1RqfXX+P29z Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30ttagqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Oct 2022 16:23:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CFW0q5008590;
	Wed, 12 Oct 2022 16:23:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn51d7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Oct 2022 16:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwFixisxoiFfv0SJb4YUfwUtrIOB3Tqhd4uBd4yQG7/lsaIDWcZ3qjaPMgRUdqhlCetYx1mTWRUiq0gYzJqpR6xW1pihsz+eSPpNz2ZTbwlD2Gir9lCsazAPjyPbdQRpR/zFktJJT6tOCFwfKryo4TVnyGSCz3wMM4a/iCRDkfdU2HewNWaE2cnHrp0cBuH5N2UDZKM175Z0R6FGcnU4ugJiRUJ37QT3xGd07RkoWyXiyHCM4F7yUeoX0/0wC/fsT213VfbduKcv60LJ+9YFfo0xSJ/6Kn/8coTByuYW1Z8yGyTXNr9GhGH/loQSxLkOSiSiNqQHYqt7Z70zyFRwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaYltWjuVLJxdhsQRYyNl2NwaeBJNJ0l2Mfqc0OEp4o=;
 b=TZeHmwCAv82SoaiF39Zz1ZvAjmbWhXOKpIty0yLyYI/kwPVQz4XSWCLMR1xD8hxQiC6I8gDde6CR7cZMg8XMW/r0sPiWUQxnlR8e2j0N6GPxxoXPWeFD3CN4cIazvtLBTSalXP7/KscGj1B3mz1H74/fA2/eRYV8nO/j7fWGYDEXOQP9PVKyzDbQBjLm4ZpMccB7KDIRHpe76qavi1S6t9SCm6Su5DCJZ5U3k/+kkHMi08+XxcLH2QqJZ0WS8hMe5zidY6Qxq+yhVMNP3y8etYg79qvxJkioh7qcmAk3i9rHzw7itR78J9XZ4R6bPURroCcoX9yyba5SaGhN309nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaYltWjuVLJxdhsQRYyNl2NwaeBJNJ0l2Mfqc0OEp4o=;
 b=uaZX3HvW00ijK2QDK5HVbVJ9+pwXJpx458+4XjVHrFxq2m16kCxt+aoh94eyfbapaGMfZQWOOhxX35nhaG4i1KtmdarAvYBQrsV+XDNOqCon4aLnpJhkLyqlSpfOEXZwuNdZHiJRgrbX5Ni5vrUMpcxVycrO/aWq6IGthK+zDhs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 16:23:44 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 16:23:44 +0000
Message-ID: <c83da0ea-8b1a-ffab-6968-acb2e488ff59@oracle.com>
Date: Wed, 12 Oct 2022 11:23:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
 <915f05fd-dbbc-e012-e3d2-e40ca13d4728@oracle.com>
 <ba047d83-d2e7-761f-7777-b7194411a8dc@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ba047d83-d2e7-761f-7777-b7194411a8dc@linux.ibm.com>
X-ClientProxiedBy: SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: a55f5060-f898-463b-d28a-08daac6e21e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	j97OnPq21Tq4XtV35Vhr9jzKOZQm6VF6kwJksK6z4E/7LuEYFUXjVO5g/Lh4LFffd7MuLrApKTvqFHCh6aLANX+07j47wzh+rWBTPzw33pKddRrm4oWbZ3cQ6HRxH6mxOY2NOspl0qggRJI0m1dSqrYH4dYKQ1V535ZbpCvjWt/x7gFoa9C48DzMnyNro8Euorw4hjZBbYFMA1f+R6frSuQVL5ZgU1XrfnaFB07665beUN9whB5HDoJ596pgTQP3mTZUZcwVp7NJvGlHnpVPxx3SwpqCuKyJ1DEJQ1f+OR4zZXK6+yFUkz3sxtEYn3VGo+4a3O423ONsZMJ/X3GOvAPWCXmWW/NpHew/5mSm00LckSnWgV79gk8eflnwp3lOqver51JI+k66JodwxU7WEfCXGZTtJa/lHxokJPN6uz9NFsMA/Ek9JWgNs3KcaAImVsu42Q6EjM4aayGSk6ATXG1PChy29TWlQWEkwxPutbtLEk2LhtCLol1F3R5h83NxI7k9IbZjeUlhwRinfhy5RtuuZdUI+ya2JbF9r6SYqg0oe1IqVxqYhZTyOkLMHWbX/9CtXY7roCwvqU/VOfNNOG6JvJ5PKfjS7NiGXa/vZntIqcOQExKUGZ8aEq+IUFsx72CVLJfevuGKIddqQgy+MESENqNBf4sdRJsQsUl+0XLG1yZtrk1TILSZreELAyoZGeD2ymVOS8l/TtKsfPSUxEuF9mR/KyQ/N8kNritszoCtt1HbzeAoJ89elWkPjV4m8lFOCNsKSEVVMDY9Eyu9ivAdueqR0wK8Ph1N3VYOKIs=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(41300700001)(8676002)(31686004)(316002)(4326008)(2906002)(8936002)(66476007)(66556008)(5660300002)(66946007)(110136005)(7416002)(86362001)(31696002)(38100700002)(6486002)(478600001)(107886003)(6666004)(53546011)(6506007)(36756003)(83380400001)(2616005)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QUx0bkhGK20zZk4zbUR1QmFrK3RNUDY0RXZpR21TRGtSK25YMXJCMUIreVVu?=
 =?utf-8?B?cytvTHJJRXlObkZCRnpBZ1JWVFJjNGVtU1JOelhMMmNVVUVaVUhpcGtpS3Ix?=
 =?utf-8?B?ZGxNZlkrUTMvUkpaZ09SSm1rRTZMVzRiVWVTdU1jdjBaQk4xWTJ0V2lqc3hk?=
 =?utf-8?B?bjMzV3ZCVStXRHAzMmk0bThpYThvdUpRdTBVK2I5NGdabGxIYXJOenRTM1Uv?=
 =?utf-8?B?STdVMU80Njd2RmZlUjJBckJSekI0RUhNWFFaWTZaRlZ6S1Q0SENTU2c1YjBF?=
 =?utf-8?B?d0J4aWJmWFBhYzZDcXkyZUEyNXZ0dTEza0FSL3dQUzE4UUZlL3pVMVZNUmhj?=
 =?utf-8?B?SHo2Z2FkazdkSUNYeXpLVk9ZakFTSUs5akpFVi83WWd1SHNSUVMxV1o0QldJ?=
 =?utf-8?B?UjRQQVNUanJxUCtaaklORUwza2cwMHVIbGFqRDV5UE4ydkhJNkxWZ0Qrempz?=
 =?utf-8?B?MGN4R2Z4Z2QzeWlvRmJIVXdKdlZ4VFJHYWI5NXlETVp6VFlmSTdwRWhlbFhm?=
 =?utf-8?B?S0VqZXRtRE1oRTFXNGE0RGNkWHkvWmRWZExneDlqK2libkJOa2Z6T0hlY3d4?=
 =?utf-8?B?OHhwbk9Fc2RLWEsreEFLaXFvTDFEWXhkSnNhVGdqQ3VBTXB1V1hCaE9FRXdI?=
 =?utf-8?B?SktaR0ZsZGY1UVFRc3pIYmxPc0JUVVlSb0JUWW92bi9uT0dSTi8vMWNuSDhn?=
 =?utf-8?B?OGFQRkpMeE5mcEJ1OGJFMWlpbzJHb1ZJbk5JNTBqYmhoaUhUMVQ0YTR3d25Y?=
 =?utf-8?B?M1ZmRGNvSGp2Y2lOTHZGeXRqWFZZeXhzaUJ6NmU3QjB1U2wxSWRFTFdYc3lj?=
 =?utf-8?B?OENFMDVVNmhZYlhuV0F3VmNVTElZN2xaWHUrakRWTXpaZEMyaFJKSDViTjBQ?=
 =?utf-8?B?M1d5UmdiV0tNR0dQRko1aFQzSXZXZHdyaUtjRmgxT0FNU3dTSGNFYmZTMlpu?=
 =?utf-8?B?Tk9RQ0lwYmUrQjRCQ2o2eDBtdHlXK3NmSVFScFlQNDg2Q2VjS2JwbGRXS3RT?=
 =?utf-8?B?TkxuaEtkWVlnUFBKODUrZzFjbXVIc0wwRTkveitoZVUzakd0UkNhZ1JGazhE?=
 =?utf-8?B?UUlxbUdyb2IrNmR5cGNtdFpDMXFsRkw4ZWNjSDJsZC9jOTdHSUc1ZnQxNVQy?=
 =?utf-8?B?ckN4bG44dGhaOTkzSmZwY1IxUW93dDAxWFJpTmY4NnlMODFuSDR3RzdodGhs?=
 =?utf-8?B?L0JEb2p2b1NoV3h5cWs1cUh4L3ZycU9uVDVXdUl4UHp2d1dtLzVHWlRsL2la?=
 =?utf-8?B?ZHV0UThRUkptTTc0NzJLaDkyQ3M2Nmx3QXRiTWV0YWpkazN5MEIvZVo4bS9x?=
 =?utf-8?B?UEhKcnRRY2FqcWNyQksxMmYrWFUwV1ZTRU9KZm5Ra0FpM09CQUtoaUJLY1pM?=
 =?utf-8?B?NnhSYWVsTTNJdG1YZmRzQ25WYStBSGtwMVNzdE11Ym1VSmVTKzFEcmJmWjRW?=
 =?utf-8?B?QjdKMG5RZEk1STZLVnFnV3doYXhLbkhMRTJiNFFtb3dXZStmaG0wQTVFaUdS?=
 =?utf-8?B?STJmS3I1YXJNNmhqMDdySlNmRCtRc2dwbDlQMzZpdHFwNlVicTFERkpmNWpN?=
 =?utf-8?B?bUxnQWVDa0VXRzZKcmdacnBqUkkvNGhIS1dWUitWcmF0MTFjMUp4U2hEdkNp?=
 =?utf-8?B?Z3B1a3VOci9ZQTB1TU9HeUwvMi9CbWx1TUNTeHUyT0ZNQzJiaVZZU0V6OXhE?=
 =?utf-8?B?VkhQV0RzeUtZb2tpamRwU1ZsN2IyY285R0VuNWVkOE1EYlpDRVpPZ0VPQ01W?=
 =?utf-8?B?QlJpVU40c1huVmdMUHhxN2ZqdUhZdUVBak1jZEZoZ3JGTTFJemFPLy9QOS9V?=
 =?utf-8?B?SHFXaWpOSjNnaXViMEUzaHI1aEtqb1ZIUG5LZUdKRUdYdVhEYUFySUQ4cnMr?=
 =?utf-8?B?OUxtMy9tTG9FZTFCTWxhTmt0RHNuZDJlcXZYN3Y0UUJobS9hTk1mZUsvWmdO?=
 =?utf-8?B?V2tMQlNYNkRwM2F6L3VhZWxQQkJQRFR2VHZFdmtyU1dyV2wrVHZEY0ZVUk9D?=
 =?utf-8?B?S2hRR05TdzJ0ZU5CNDVoYzZvWmVGSVhsK3UvZnBiR2xNUnBkWC83SFV4VXZY?=
 =?utf-8?B?c1l5SVpwaStNMkdMM2dHejRCb2RIbmp4Q09WMTBHb1hNODlQT2l5MXJJRjhY?=
 =?utf-8?B?ZitOYUhoUzFMRFE5QkJoVDBYUFFmMnVBc0loeGZQbE95UFpDTnFmWmtCQkpN?=
 =?utf-8?Q?tJHQFYyRK+XoSxiX0EaCVN8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55f5060-f898-463b-d28a-08daac6e21e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 16:23:44.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw7ztLWwS08ZzGmM/XwuiehEoK0wc63wQzlEksidQiXA9edYrmkl5jPHrebkFbIFV6HCEkINgHojnlFiV+UXMbhUdKi0Dw61PTYL9Jd9efk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120107
X-Proofpoint-GUID: mgJd8uOwFaRqSesg-CVGAKhoXY7mJDYh
X-Proofpoint-ORIG-GUID: mgJd8uOwFaRqSesg-CVGAKhoXY7mJDYh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_092410_713761_51B79D37 
X-CRM114-Status: GOOD (  18.15  )
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

CgpPbiAxMC8xMS8yMiAyMzo1NSwgU291cmFiaCBKYWluIHdyb3RlOgo+IAo+Pj4+Pj4gSWYga21h
cF9sb2NhbF9wYWdlKCkgd29ya3MgZm9yIGFsbCBhcmNocywgdGhlbiBJJ20gaGFwcHkgdG8gZHJv
cCB0aGVzZQo+Pj4+Pj4gYXJjaF8gdmFyaWFudHMgYW5kIHVzZSBpdCBkaXJlY3RseS4KPj4+Pj4K
Pj4+Pj4gWWVzLCBwbHMgZG8uCj4+Pj4KPj4+PiBJJ2xsIGNoZWNrIHdpdGggU291cmFiaCB0byBz
ZWUgaWYgUFBDIGNhbiB3b3JrIHdpdGgga21hcF9sb2NhbF9wYWdlKCkuCj4+PiBJIHRoaW5rIGtt
YXBfbG9jYWxfcGFnZSBkbyBzdXBwb3J0IG9uwqAgUG93ZXJQQy4gQnV0IGNhbiB5b3UgZXhwbGFp
biB3aHkgd2UgbmVlZCB0aGlzCj4+PiBmdW5jdGlvbiBoZXJlLCBhcmVuJ3QgdGhlIHJlc2VydmUg
bWVtb3J5IGFscmVhZHkgYXZhaWxhYmxlIHRvIHVzZT8KPj4KPj4gT24geDg2LCBhdHRlbXB0cyB0
byBhY2Nlc3MgdGhlIGVsZmNvcmVoZHIgd2l0aG91dCBtYXBwaW5nIGl0IGRpZCBub3Qgd29yayAo
cmVzdWx0ZWQKPj4gaW4gYSBmYXVsdCkuCj4+Cj4+IExldCBtZSBrbm93IGlmIHVzaW5nIGttYXBf
bG9jYWxfcGFnZSgpIGluIHBsYWNlIG9mIF9fdmEoKSBpbiBhcmNoX21hcF9jcmFzaF9wYWdlcygp
Lgo+PiBJZiBpdCBkb2VzLCB0aGVuIEkgY2FuIGVsaW1pbmF0ZSBhcmNoX3VuL21hcF9jcmFzaF9w
YWdlcygpIGFuZCB1c2Uga21hcF9sb2NhbF9wYWdlKCkKPj4gZGlyZWN0bHkuCj4gSGVsbG8gRXJp
YywKPiAKPiBBdGxlYXN0IG9uIHBwYzY0IHdlIGhhdmUgZGlyZWN0IG1hcHBpbmcgYXZhaWxhYmxl
IGFuZCBoZW5jZSBqdXN0IGJ5IGRvaW5nIHBhZ2Ugc2hpZnQKPiBvbiBwaHlzaWNhbCBhZGRyZXNz
IChfX3ZhKSB3ZSBjYW4gZ2V0IHZhbGlkIHZpcnR1YWwgYWRkcmVzcyBvbiBwb3dlcnBjLiBJbiBz
aG9ydCB3ZSBkb24ndAo+IGhhdmUgdG8gZ2VuZXJhdGUgbWFwcGluZyBhZ2FpbiB0byBhY2Nlc3Mg
cmVzZXJ2ZWQgcmVnaW9uLgo+IAo+IFJlZ2FyZGxlc3MgbGV0J3MgZ28gd2l0aCBrZHVtcF9sb2Nh
bF9wYWdlIEFQSSwgaXQgaXMgc3VwcG9ydGVkIG9uIHBvd2VycGMuCj4gCj4gVGhhbmtzLAo+IFNv
dXJhYmggSmFpbgoKT2ssIEkgd2lsbCBnbyB0aGF0IHJvdXRlLgpUaGFua3MhCmVyaWMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
