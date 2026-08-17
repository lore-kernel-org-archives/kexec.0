Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8BC5B572
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFLTf893gJsYsOFGbqO6w2Shet0QAckGO99ZOWmGnFA=; b=W06RJVJkAq6q6pgbRzHN/3ET4r
	8WwvVVyGAdpx134bVdfP9gFT/miCKbyuV/jLQcefdGOc2UxA0KhBKx95EZdOEewL473daBQrv9elt
	5MZLCFsxejUbbE2HS23PimLUaAgAJgJgjn36i7fxu+d2UmB3nNrfpjNLkINlPoI5EJ8JTRON4legR
	KE39ZUkLVJVOHwy6Zxwwh2aB00Saa2gWzNzPMkeSio7Jist7ELKNO6qgIPSWdNP9iqt5rt8WEy2Y6
	iT475aEseBAXKtTVx9EiMxhhc49fefJ0Ud/awzPGq+8Hnlgn2r/1DxfAUOqC+RWZFBd2YueznTVWb
	YLGwOT9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww3Xa-00000006lA7-3vcx;
	Mon, 17 Aug 2026 20:02:38 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww3XY-00000006l9f-0Bm4
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 20:02:37 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFhAiU728409;
	Mon, 17 Aug 2026 20:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qFLTf893gJsYsOFGbqO6w2Shet0QAckGO99ZOWmGnFA=; b=
	O32/UFLrb1kSv+Hi+Xblucnl8ik9Jj09TnaSvIboCJ4MkpATq9wr+Kjk2hjG48w4
	QgXp4YaZFNH8EHHICv++34UezMrpDpJRVBxq8gRvwZNi/JfBFiED+ixQ3ac93HEk
	T95/xL27YkGcCqht/O/AasdAaIEFyptpL5r/xefwtTqrz8sBGaJCZwxCaceqZ9ET
	eQHX0DssdnYgvUhQVJpeCsIdyrU/OXjd7u9N/D6I8sGFQ09DHI24kRokalVPT1DU
	+0Gfl9knJXt1WZmg0jDOvBSlyy/eXWlw58ukfdYlqv/yqedgkagowMnxav2wb5m5
	3HE2C/LDlJv3cVjIei0CjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2gns2yrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:02:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJxwMg031860;
	Mon, 17 Aug 2026 20:02:34 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejbpw28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 20:02:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+fCxE9sqH6b09R0ElcgTzi4CPysOcrtAB/e+Rg3sMuyW+1qStm+cI2KgYGEYDyJa898vzrP+IQa5/8y+5emAUcBosESZ4OH3YkjKmaGKNfQT8w5hBz9X4JEGGowgHB1R6bxCLh59HQ9RyvfWfdUOz+5OvpwZ3V+SgJSuRt9GSG7XFiv9sSnOFM/Ca7oFhVy+NLJbn8W2Hab+wfXLN/ixuwJLdCizR4HnP2Cq637JE/1Im9XfUWKYLRqr4KFrPQSIsQe8t5kFWglzKFos1NsHbomDB0ERVPQvUxut4JodgOGsrBNcqhtRfpN7JgGB0V5usEA2RakyphX4l9TO1CiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFLTf893gJsYsOFGbqO6w2Shet0QAckGO99ZOWmGnFA=;
 b=yiR1B63UYVCVRXw/zm+Sh6Bva5ck7DyvN9G0G/ONaRygrY9ZRdToicxaIM3CuwowV1G2FmtPWbArM+a4ly43qRsgjLBfYDkovpTkXJzgbsn99zPoNu6pH5neq85WnMc+SHM/U9WRKNfBWEGvfKNW6VVC9rVU4b1JUzRYS6ObfQXeGqxryTgBr+hthILJoZV1kWDSiHkJ6DejN6bm7+M8dE3AeEZn2vR8dNDd9j57OJ7cs4XAsEYEOVEBgCAw81iDwmhLs6RKB76IDQV1Mf6CdD7dsRnX9VRySwEBSVa9lyOf6It2RY0fQ52AjB8D1G23sZgo74GNVVxzJoC57SgVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFLTf893gJsYsOFGbqO6w2Shet0QAckGO99ZOWmGnFA=;
 b=rJUD1OkiyE3zqysKDouEtgAtEZkEaTtxgc3BZUSWXc6CDySDH1iOE+NHq+KQE1AqvzDnIPO9s8pxEi0fbvD/c1f8lWfsoza8XZEGJKLfiHMV8n2kvaQ9WS56EoTCU++m6W9SjvOUwd7JQbtwlJ5rUikb5uKBX/J/bj9UZNLCTmQ=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DS0PR10MB7978.namprd10.prod.outlook.com (2603:10b6:8:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:02:30 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:02:30 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>,
        Tao Liu <ltao@redhat.com>
Cc: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
 <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
In-Reply-To: <404ed232-6c8e-4112-b13c-6338156476d3@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
 <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
 <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
 <404ed232-6c8e-4112-b13c-6338156476d3@nec.com>
Date: Mon, 17 Aug 2026 13:02:28 -0700
Message-ID: <878q64cy7f.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::27) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DS0PR10MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e42d59a-20c9-4d36-4439-08defc9a781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|3023799007|13003099007|6133799003|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 5ps/Df+YpctToPqWNskD2p/sodUHzjsxl1sqS/I3OLSXKHxQ2H9mSLlxEuDiTxbVrBRrMcr6BVk01nKJ0hackPLeTfWInicDJWSVQqW7GjP6PZxHoEwsGSygoerqf12lFrk0bCx6dRohd3Dm3nkMWEPo25lGessQ2w3UCZTwgrYtWP3sk5xLYErxsJubuXipwrR5WrihzyEW6e3ECs9LcAFvGSeDqsyJjeFdpsY/5pgydLkVuzv+BV+6aats11G7giH7u2uEaY399RJNFVs45gbFhQ4A8I1mT8ZQZyFcT1McatErgndBs5Yo6e1V+4crNtRPuWcrqQlvJp3ShVhthD+cak2RoJYU1JjUzNKSZ7eRKJFP+6rb34VWmICBJpPlRnBe6VRS6gqU0tU2HwJDax4TPwjuXzANvFC4hstDm2s/9QKSnQj0ZjIFiF5cBMGvPbuC8WSKqo2Eq40r9ufsk3r/yBxZpm12reugp2yBuKbviTbAsTe8kJ1q2cJ/R88BIhFisgrSZT3IeJO55WcDkKcKIlz22X6EBufPGIi4MPzqsaOzt1Le/SFgbDJM+Ww2hW0dXkfeBafewL8rlKeSiq4Eo0zMxkcJf9istE7jmuMKn6AKrCQIqsYzXQ7Ndn5U3UkU85IKocYa7vutlMFota2GD0SBu7njHM6x+ymJcWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(3023799007)(13003099007)(6133799003)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExOV29OSk0xUzdxTHlHM1FDYU1SRVRSSHNmUjVpSzNhTDg5VzFZcGNmNFhE?=
 =?utf-8?B?T2FsZE1SOE9lcnRqM0I3a0czb1h3NXFxa0M3d3h5MERJWVVQcVVHY1A3VDFR?=
 =?utf-8?B?eVZrSmlrTHBqb0tZNm9TZ3VvL0E2SmtFSGwwSWZVYmtvOGgwc290cERQMFJX?=
 =?utf-8?B?eG92V2h6cVQ0eVVyeVpFRFNHekViOFVsY1lsUVMra3lseVNHVWFVbEF1WFNG?=
 =?utf-8?B?eVZPcGpGOGJqZ1FtNHFMWUFmRkNMcVNtMHlQc0U0MUhiS3lnQXNaUVdScmZu?=
 =?utf-8?B?UFIvaC9jT3AzUUVRTU0wdVlBTlVGR2ZiMmxqOUVVR0VMUTB1Mm8rejNybHR6?=
 =?utf-8?B?aWtsVkdkeGtNOFhTcW9ybEU1bi9aa2laMjZ1SGlYeFN0WVdDYVlsdmh4djlI?=
 =?utf-8?B?TWhrTnhFdGppZmxvRHN5L3JtQ0xEUm4ramFvMUtyVlk1d3JiMlFCUUFkOUNs?=
 =?utf-8?B?UWdjR2VmQWRzM3M3elFFWjc3S3BMdDJZRWhHdyticWUwandqU3ZJYnJxeWZl?=
 =?utf-8?B?TEo0SGhKZTVJbzZwcktHZk9oZUt5d09nMXNURUJBK254WUkrdnRPOHZnL0FI?=
 =?utf-8?B?UFJBeVUydUtsT28vSXZmSmVWZWVJTkVhVU03S2ppT1NUVG03QW1MbVhoN1NS?=
 =?utf-8?B?a2FxQXplaUxSVElLTG8xUGhXSzdhN3RDaDk2WTlIWWx5a2V5NkVkbVd2OVor?=
 =?utf-8?B?bVBoUHUraWRyc2VQQkk3dWl2b3JtaFB3d1B3OHB3dDFRdGZMeldHeTlwcldC?=
 =?utf-8?B?bmxmTjEzUW9QMmpxNUpIQ3B4b0I0Tkc5aHJEOFdzQnlKU3lYeTdEeXh4QmJC?=
 =?utf-8?B?bkZ2bCs4QlRlVkpOZ3NBZ3Z0cDdmQ21UeVVwYUJXQ2pHTm1LNTFYRDFSWXMw?=
 =?utf-8?B?REpzdFNNUWRCQTZoTks1VzhKU0EwTXcvRE9UdVJpWUR1TDRYRzRuazdjS2du?=
 =?utf-8?B?bFBTOGtRNDE1eFdsUjlBTmN6b0VscmpoczAzd3VPaXkySVI3akJ2OU9pNnlQ?=
 =?utf-8?B?cEMxVXY4V0FzcENtK3hCZFRxZXduVzYzQWorT0NqVHF0dDRtRGZnUWdScFRa?=
 =?utf-8?B?VTBTSCtwUXpHRDNUTGNaMTFvcm1FTHJKSmI1TnZTUHoxM1NrMTRKcXlnRXh5?=
 =?utf-8?B?VkE5M0tJR2E5dUxTRHQ5OHE2YVhDSU5KYjFrcE5hcE5Za2lHOFI4SUN2eW5p?=
 =?utf-8?B?SkhFek1LRlo0RTE3U2huMkkxSzQ0SjdIL1lOVlZjQnRiRTFnTnJmMzNFQ3hz?=
 =?utf-8?B?NnIvTjdwWnNmOG15MnlRalROd3FUQTlFOWRQbnBlUmVBbGpBUmo5ZzNTR0RS?=
 =?utf-8?B?bG1JcjNxZFp2M1VTVVhadHljUjVxVk0zYTFZUlFSNUhHQm50L1o0ZW1CTnV1?=
 =?utf-8?B?SkV6MTErd2Ruc0NqelpnM29mWCttK1BLRDY0N1U5Ym5KS3owZ08xMk80Si9J?=
 =?utf-8?B?K3hkbDNxY2lNbThPemQ1MExyNTlUbGc5Q3JyUzlRM050V09jSTRxQ1phblRv?=
 =?utf-8?B?NGoxeGloTTd4Z3FEcUE2UlJtS0VhYlJmeTNHY1VVTC9VQzdkVnpEYitpc3lm?=
 =?utf-8?B?RXJMTVhWazV3RHp5aFVGdmdCMFEyTmVFV05iR1lQMDBTb1VQU2lTYTFrMkxq?=
 =?utf-8?B?NHVEK0E1aDlZYVV4ei95eFFKSzhMTG9WWkkxeWVaa0xCd0JPYlRUcE84Rmp3?=
 =?utf-8?B?bEo3U2o5Qm5FZUladWxxQURiTmhJRVZtUzlJZjJoU0JadExhaUFDRlRRLy9S?=
 =?utf-8?B?WmJxQzVYY0NwamR3cXFjdmh2cExUNmVJcE1IeG1kQmVkb0lqNEVYbFM2T2dr?=
 =?utf-8?B?a3dvQU9ncExFeUFERllOd05JVy9oazRvMTZpMDRJWHkzMnNxYU0wRk0veGpZ?=
 =?utf-8?B?YTVOdFJBYThmem9lazl3TEdwVGpLSm5xa01JVEJSdlRucVNGVjZxZERnZlRJ?=
 =?utf-8?B?bVZBZytoemsxMnZKVlpCdFNHS1JCVWFlWFU0eG5tcjFicDdXbGVwN1JFSkg4?=
 =?utf-8?B?YkNlalFVWGdZaitDbXhXMGdoNHBvdGFrenBkN3NYZEdleXFWdDJFMFM5Zi9I?=
 =?utf-8?B?NjRSTUhFRkUrTUJ4MFBXcm03bFpVTkZMWEllQit3U2ZUbE9UMkl6Mmh2L0Zy?=
 =?utf-8?B?RFA1Y3Y4R0RQd0d0RkgxRVBFVFNYSFN6bXlJbnpvczAyY3hQQXEyZ09ZQU5O?=
 =?utf-8?B?SndJRnQrWGI5aFIzZEpjcE9zc0lZTEkwVEZrVWpDaC82aHVlNHZNSGJBM2Fo?=
 =?utf-8?B?eDAyVVRaOExqdlM5N2E5NU5nN2x4Q1dubG5DdHk2MWtjdUJRam5XbmZvSXRi?=
 =?utf-8?B?eWJ6ZGZlc2tpUzM4czBMcFMrdnFMN0hEbDlUM0l5bVBqRDhPUmVVUkhHcDVE?=
 =?utf-8?Q?iSKpvTQ8raBmIlwo=3D?=
X-Exchange-RoutingPolicyChecked: rJ8XUsBrsVkIP+GoiOFFfHseWmRv1mhtPe9PrsA51wUQT24b/M9sZRJhoyi/mcXIku773XhUSvMdSVzUxgY9gZhcfqCL7pAkasasR6Lun+HxWiDWtg5b/iyEZN+YJzRlUeq7Pf6+hBicujvHIcGzh3ZiBl6pRwLbg+S0XCSegU5BxIXk1vSxMNM7cK6q+KPHqtAaXrTt/MCc59bAbjFmZV40hiKv9+s9AiVry1sOTYoEtWmEELDldAE/SIS/2gD929tQkEtcpvd1P9rkwvixOeEec8XgYVMZ+27g7E90Fm4HWT6OL1g7mPS/MJoWA6HwD402ch6mix4REREVCdSxMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XzohV2Zoosvanrm9kVYxvgEqoh1cErVQDng+vVsAb9N2UW0SoNs4HLyH+V2LVp1qsnQkfE3F4DNEZ3+Lq7huRC9JnhlQVCvidIg+e+qJVRLrkBK6O5h2lXzmhHcvFe6h7sfwJNTqqQuvvhXHuegzXs/Y+RduKBaEMttZRxk2LgQRT5btucVcblCFdPtwnPQgvnWWCDpE9BkbyYBF5GI0nqLUribXOys3myC4eFXtsl5dCReoJ9/iXLAxW9FoT/iNg2E40D5QFzus6ph9i9czeBdPbO+dZ4c/mVWG2YDiWYbPKFErN9ihD5KFuuPQUTKuHg662IhUz0bEr3fE9WELt51oyo4THDA2nyl9cjDhZ2/QkeZTb5ZSijc5EDjrguFrqpZpIzLYSdfWIMgodceumcK1Hnep7m9eYvh8+GaV9j3OR2EmZtG/SvpYQe7jE3fYW9LE0BQiWqaw+Cusg+wLk6kHdTRQPRbaG1V7VF+UAa0WCWj9iC+9tjXIh7MxQVBhOJjXmnuGJ4ZXycKYxkJxBC5Z4OpFe8gvMxVfDv/l80dz1nIKXdzgCJqfg63RuF0DuPKqQ8Q4XATkc3fBJqAxXiNNfusmtk+p+5dGhiQ0vmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e42d59a-20c9-4d36-4439-08defc9a781c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:02:30.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYz4g8M5kk0HufUIaa2tcmcl/BsZrpFiL0f/F/yMFnlsGrBe+FTcW/NveWTl99Y3HJZbFk0biUOjpTHWzsn65NcioYzHQEriiD9ypvWVFOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608170153
X-Proofpoint-GUID: BQpgcSYzEb3xtwqhnpUFgHsHitGYpC2t
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX1fmiGhwWXJgw
 2LAysywfwG8IjAM2D5gIb8vPlKrSm8soZXTYCIVHh5eUZl83UKNw3QNkx3PstCNFLaZ6zsLRA+H
 +H6rxbsfUaK+nbDNUmsATB2Hkm1dku/y9qaZ3r37IJp2+7qrjUIC
X-Proofpoint-ORIG-GUID: BQpgcSYzEb3xtwqhnpUFgHsHitGYpC2t
X-Authority-Analysis: v=2.4 cv=a8UAM0SF c=1 sm=1 tr=0 ts=6a8368da cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8
 a=nrACCIEEAAAA:8 a=FArEk4ds7UEXzyOeHKwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX5FqH447hSP26
 BRyG64qYJWsNKu3/RbBhvLA3wOOIKpa/b7j04yKV068PuYNzzlr5CjEA9uBeUGZuGLlAdnzB7W8
 D6m+NwSYIpvDlhD9eZlwsjA3KTECyPTSjJ7lFFeoAoiR0HfaGDiaX9mFF5qdOMDyrDjW45VIz7w
 Em3cp3OGDnepHvjos6XXD4+Jp2Ol+j1+oR16WIZUpPtXksnPxoptgV4i9ZT+E/0dLMHFLUKYnGR
 ND41IIaFjVQjhXEu9Sm10L1eCLPjFwRWCMGz71YnmauKiiSTvDKFOF2MB4EzSt8KToIMyszuqzv
 HCW/WdyZUM0I4JXZ+wmcbw4ZSmffWQnj16aauBLMD5iT+y8Rb4+FeEQUAvTMg/FAD0rK0hUsMTS
 zCHWelLdT5FVjW/jDyS171CtnMQb5TKhvbzsQ0HFYNdwsTVU549oLRKE63nFI2NIa17eXRMzicj
 8s6jfugKm2azI6yW6eQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_130236_099675_F4ABBAB2 
X-CRM114-Status: GOOD (  16.08  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)	<k-hagio-ab@n=
ec.com> writes:
> Hi Tao,
>
> On 2026/08/11 15:11, Tao Liu wrote:
>
>>>>>> and Tao, please check if your extension can be rebased on this
>>>>>> patchset.  and also if you agree the extension list, please provide
>>>>>> the information.
>>=20
>> I have checked my extension to rebase on this patchset. The result is:
>>=20
>> 1) Rebase fails, but only due to conflicts within extensions/Makefile.
>> These are small issues which would be very easy to fix.
>> 2) Once 1 is fixed, after compile, my extension can work as expected.
>> However this is a coincidence.  Because my extension takes callback
>> as:
>>=20
>> int extension_callback(unsigned long pfn, const void *pcache)
>> {
>>          struct ft_page_info *cur =3D NULL;
>>          return filter_page(pfn, &cur);
>> }
>>=20
>> But this patchset changed the callback into:
>> run_extension_callback(unsigned long pfn, const void *pcache, const
>> struct pginfo *i)
>>=20
>> My extension works because it only takes pfn as parameter, and the
>> handle_cbs[i]->cb() doesn't check function parameters. However, I
>> don't think it is a major issue, once the modification on extension.c
>> merged upstream, I can adjust the function signature of mine
>> accordingly.
>
> Thank you for checking.  My main concern was the change in behavior,=20
> particularly with compound pages.  If your extension works well after=20
> some adjustments, that's good to hear.  I will merge the patch set later.
>
>>=20
>>>>>
>>>>> Sure, I will check for the rebase. In the meantime, will the
>>>>> extensions to be maintained in one repo (e.g. makedumpfile extensions
>>>>> repo, so everyone can PR to it), or they are maintained in each of
>>>>> individual repos, and link them under
>>>>> https://github.com/makedumpfile/makedumpfile/wiki#extensions?
>>>>
>>>> I am open to either. I would be willing to co-maintain an extensions
>>>> repository with Tao, for example at github.com/makedumpfile/extensions=
,
>>>> so that there is a common place to contribute. That is, if this
>>>> arrangement would work for all?
>>>>
>>>> If we did create a common repository, I think we'd want to set up some
>>>> expectations on the quality & maintenance. EG, some may be marked as
>>>> "maintained" with a maintainer and a scope of maintenance (supported
>>>> kernel versions, supported architectures, etc), and others as
>>>> "unmaintained", where we just make sure that they build & run with
>>>> makedumpfile, but don't validate their behavior on specific kernels or
>>>> architectures.
>>>>
>>>> On the other hand, if it's preferable to stay separate, then I'm happy
>>>> to find another place to maintain the userstack & elfheader extensions=
.
>>>
>>> I was thinking of separate repositories.  A single repository would be
>>> fine, but for now I have no plans to create one within the makedumpfile
>>> organization.
>>>
>>> (Looking back at crash extensions, some become obsolete quickly or
>>> have very specific functionality, making it difficult for anyone
>>> other than the original author to maintain.  For this reason, I think
>>> it is best for the authors themselves to manage them.)
>>=20
>> Understood, extensions are designed to address one specific issue, and
>> is easy to get outdated when makedumpfile/crash utility keeping
>> following up the latest kernel, but extensions are often left behind
>> due to low usage. Let's go with maintainling the extensions by each
>> authors seperately and link them into
>> https://github.com/makedumpfile/makedumpfile/wiki#extensions
>
> Thank you for your understanding.  for now, please let me know the=20
> information of your extension once it's ready.

Hi Kazu, Tao,

I am working on creating a Github repository for this within the Oracle
Github organization for our extensions. This tends to take a while for
approvals. May I share the extension URL when it is available? In the
meantime, you could use the URL of this patch series (or the v2), which
I'll send once we resolve the discussion on Patch 4.

Thanks,
Stephen

