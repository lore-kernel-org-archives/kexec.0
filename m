Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A203FCD5BD5
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+a+rBiBDY/EDVtK12QE1VYzCI0bu4b2QVb28OHzTuQ=; b=wtLMPmhvh5mzDlPtqx3OJ9Y5iE
	I9lds9hG1n2UhhztovIwkIhYtPxa4GBMKyCk6rHj8P41zLSYoMAtHzbkdwOdkwTREYOCsPD+YvvEY
	JRhiu4qG0lW70VxxOyyvLeKROYYLptCLiQZHuzVIKyAaAGpkmvBeKqmdbJ98cc2lm0k9CbfOvu9ek
	ph0qN9SUkNOoRus6iaih2vAYHFyrK0LEFfnniCYl3uuS2n+m94otWshR83GSMfDEDJibocEp2O/vm
	IKotJ596DCbmLj+SyxFxfT8GjxaxzDHfYjsHW0qrxUmc6ltzP6NY9Gv2X0yHitLLLmEr9NIrL4moq
	eNxGju6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSfcI-00000006Chm-3uvV;
	Thu, 28 May 2026 18:38:02 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSfcE-00000006Cfo-0c6I
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 18:38:01 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SEIjx0949724;
	Thu, 28 May 2026 18:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=u+a+rBiBDY/EDVtK12
	QE1VYzCI0bu4b2QVb28OHzTuQ=; b=oDjYGvXk7USsxKRKWfj/gVQabcEybbqFEO
	JeXzgPIyTcpoW7ExbAvUWhtf115YiKBhzCQJyxrMLVYAmFqJx+WEjGBSbBYgTNuT
	JqVaGYDocX4wQdyGAo0l2kV1YSxWeCdwMxsom98CA4Fx5zHdriq1HB0nxP1Ii+mV
	Uliz0fMd44Uu8KUaCO9SXdG5C6hMoCofNy9fGQe+VJm7M4usVdGrVKo0zRybnIxS
	0MCxwroKSbiXHp+QDHs+J0S16x3JF/yqGf7/i9G0Rq6D/32LbJqjJ/jelAqG4abn
	o3zfp3FmuhFK9TYb5dH2mRuhDnvQdHrxG7N8cd5anM0n4Wm1wpkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7wm1ftn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 18:37:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64SIZ6Lm010543;
	Thu, 28 May 2026 18:37:54 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjs3b4m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 18:37:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSi1WxIyuNBuui5cTg2s5PSwMKTeGrVxFxA/uYK+ffZz1XMWlAy9oeg37JLoyfVcGYYpqwrVBNMcxlYk9FwrAx4s091pY9rCbZk5rNpiINzMMCjeooun3vIPOvVmQuHjF9IePXa5yidhBu076hfxucPT+JvZMK7uoB5z2lhnaKA4kMbCiPJ3Kqb0vt9K2beaLBcEgn4w6A61YTVG2jxiU5rZ6+iZP3UP/LIOO1Zt4smH0YpFGe2AGh7qoRnCA6md0DWeNvHutMU0vumYWD3YQwpFmkE3AT4YwrAQajQto4Et5SCK7nUjPb/TOMnQIdtj3PkK8auyXBWnnZPNmxjqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+a+rBiBDY/EDVtK12QE1VYzCI0bu4b2QVb28OHzTuQ=;
 b=s9+QnJ5+5D6Nms/tC+rw339/QBr9N1onzP2QLA7kbFIT+Q1dFL0JZHmYEfzxd2yXECkvN22Q/eS6hc/Qa6ls8J2fU+yB40kmT+KaPrNn1va7NldXFaAwjr6Rck5dpYfO7J74efpMzbfwCmoVsc7LgU3W2b7ynGILU9ix2/XIk4Qe1PTiar20t6upp68aJaj/k9Z1OvnVNqBmDVt0DSbnXXgTGJH64Gbe604VgKmNWjRWIWgqfFUN7EYeqCCPKM0OI2tXvrGzvzRv4chTeKV4gNo9u823GNIYUeC3bLWVNiefQRcNI8dEDUBsiJz8pMUytPUIAefSWKGbUkkpyeZ5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+a+rBiBDY/EDVtK12QE1VYzCI0bu4b2QVb28OHzTuQ=;
 b=Rib+R+sXHHRmeFEBSw0g/hCF+TLj7+DpbVzUCo4p/bmueQe70e6LcVXUuOOhLweSjRzo3qGowzBYLxfadr84Djhne3pien6dBMHQAIZkkERXKhO+2CVeoyKB2XV09RtgNKs8m/v7N7SQ9x4N41jK8sr8vTI4HrOKeYLz3OsKL0I=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 28 May
 2026 18:37:51 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 18:37:50 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
Date: Thu, 28 May 2026 11:37:48 -0700
Message-ID: <87o6hzpegz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:510:33d::6) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: fc81dad4-2980-40d6-e211-08debce83888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|13003099007|6133799003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: dBZPDV3ETVmLiJZoO7XLlYgDRi57GEpyuf1uYyy4ch2U88bE6XPcF4Ghujvpoiw0Vy5eMyFTG5Qs5NNt9/7/N73cJfwDivpY2c9H1lPd7YlDKhSzHnslVE0p4oOnm1KsoLO347C0F3sdJP1BIuLCaYJE8QhnoCYI5xtVa/R4XRQR66jAvd1alvDtJqXr2R1lcN3bEn4TllcqZt6Nq4LzcL9Ov2UJK/Bhluz+WKIlUxCNQrM8u7aGm8pjgFPsh0BND03gLWnFSImVynW9N+ZWDslTNeguEPkw48yG1/5erYTBQf+41zWM+AmcOZ2O+30oSfttrcZdCKgMbNOvsEBNUxrr4mnKXYVDa7pAaR3b8pZibI86Czo3bKEp2o7dLwEURVeKnBYnHa2v9uZnthr384r0Ts14fhr3SOOMUC6l7xu3FSpLzJ7eSsDGeJZ3qwTKbyltJ9XxtF4TA7ASsaU07ptkmf+JEEXGapxmrdXwGYOn5gXUi510UcnBPkcOD4v0zBBX0ZQdraT6s1FzNm2KKzTOu0Dfh2ZbfbdQeWl52FtviEuy51QOh/jSVDb5bqJtDcwq9Me1HGrzo6kd2qewN5mY1s47BuzOuLmlKrBfhCoINjmV5vWYh6koa5YfljOQxbi70XBNiBM9Mtdzw0+ZDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(13003099007)(6133799003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dR/3d1zWkEJiJgc1Gz6RHn3b2X34uH8u6bnSeLJn26Myt3IiFMVrPSIPNt5p?=
 =?us-ascii?Q?TmLF/bMnMWMm992+xThUJbzpNbUuxLZrPpjnK4JhCY7Gwtlyg3XIB19JfLJX?=
 =?us-ascii?Q?qSgUfAQopMjQgoBxIn0lTxYP06L9oGAlS3FJW3a9zg3imvggxG/6XtVzXslC?=
 =?us-ascii?Q?1x7OpkSjn4qMUazeAzv8TrAZ2/bWRlAp1DJ3fzWz9EdzbDxx/HtK4eOjELsc?=
 =?us-ascii?Q?+ys8TCJ66vBzmJuqJiRYq2N0Was/rrr/0TezcpPlscPMJchmVYpGdNRrFkHE?=
 =?us-ascii?Q?uv/OF5r2pyQAQXc/Gl7vD/unp3V7ehtMRDj0wFzNRg2qVTV76Y14WLY26Tkh?=
 =?us-ascii?Q?KeZd3ccklXNIhD43Biw7VU3gsQw3MeWY7ldo1OJ6WMSDepxgdiOuTGds7fwr?=
 =?us-ascii?Q?mPwt3tujuGxx2eSQmyFpcQVV8X/M9ZPtUoOtXV6eiFQi9ibosrmeZJYW45+X?=
 =?us-ascii?Q?ohhxMzrh3nOxkAFefaulWN/kGn3GwsEX9Pi90sIsXhHFAcVXE+EkCKpKf8jd?=
 =?us-ascii?Q?43EXjKv/GUHzbuWv83V/geghmjgvfbOAej3te6mV8cRf6cFEI/DIBdymrpqZ?=
 =?us-ascii?Q?hBxt3c5rh43wBoboK+JspNIIE3mAI4KTWU2sjSMy2bPdvAKtZTn/MiUY40CP?=
 =?us-ascii?Q?05kaNQFuHrfru4sgWC53eyB9rOyGC+Ok27TqZgZpZoNyLEw3/OI+X260lvbQ?=
 =?us-ascii?Q?kztcqwgDH1RIFkTkuGO2/63Lkc2+19W9wD946Z94G5PpbSS4Kkr9T39XSsJq?=
 =?us-ascii?Q?wRW2k8sntNqNk8oCkGakF33d35PZ1JV/hGLOoroBFKg7ioYf0Ri2Sd7Pps50?=
 =?us-ascii?Q?Lt6M8WJ99vbbEXHRqEgOHg2Yrm3DAj8ZwpHgKqk2RnYdXqCBIap7SdvkNZSU?=
 =?us-ascii?Q?NfYn63s5w1hgf7X11dAV64yuJokooLZeUiGkNiFuvd/06sKY/d9GYieiTjT9?=
 =?us-ascii?Q?/ZygtjWGgs18y4kyrSboBko+ESXxjE1wlCbo8oVoINo+8C3E5ddwNen1WciM?=
 =?us-ascii?Q?q7F7q/K3Kvj3c1N0Ial8yoel53rTCd7bGR0x11Ldqyr5W3lr7NdCLXMUhRQB?=
 =?us-ascii?Q?RaSFuKOKZxb3FLigi+sGEd/KBX+mWCtcU4EltSW4V9SP8MSjTTVxRVvqWpYS?=
 =?us-ascii?Q?QitjpGBaVl3HZJYtYdovdVH2pG4RU79UwJqMytKpXLCucRknpXVpip7WKzXz?=
 =?us-ascii?Q?OG+pK3VUSxweVZZoXcjo3GRLdgLo6wRGYAujzP7TdNLVjU/ZOHXS0/g+9UbF?=
 =?us-ascii?Q?Clu/u5ztcFaIBoJh+y7q0fgNIuiD2iuAwRfLcLnpz6MVlRFe/LVwMfXh4Jgw?=
 =?us-ascii?Q?r1mqSTeWJGHtCZP53//Rb2y6rRl0HTlyk5SHxztbCcX1K9M972yY+d6+RtWy?=
 =?us-ascii?Q?OCHFT9WN4digrfszUtpttNb8ZvJ85F/nEGwJfpGnv8grNIhR1MVspnIaS9jA?=
 =?us-ascii?Q?e6LhGfHIJKOvbvWN0j7INXKBzZ7iRV/5Gh8FhPWNgp/hnYZk3zz2hLTQWR1G?=
 =?us-ascii?Q?f1yRob4MP9r8Xc1CQnIZ8iTxC67JcGCUtRhxX63DWtEwM3rxmEi2GVVNvavZ?=
 =?us-ascii?Q?m66ksVaNx9qdWW1QLhVYJ5udo0pyHpFbRGmocn3QzrWnxWyc5F8mznTX+zUA?=
 =?us-ascii?Q?xZMedlKYRx3I8u1Kn5XCUrIvG08fRo9uHxuD9NwcLHn82ooeti9LPH9kaXsw?=
 =?us-ascii?Q?aLOZ/xtr4n99LQQnzfS/9fz7ZHMo8+iympac97M9hkU0O9gq7YVpLlArxBWB?=
 =?us-ascii?Q?ODgkTw9B3w9l901QHstUJC4SVdti814=3D?=
X-Exchange-RoutingPolicyChecked: q+3ky3EHPhBXEagv2oBcBAu0IEFo4qP9qQ0yTUt3Vfl0hC332yetJW17Q5cV9Te19qQihkQB2vaHZmSEr/io7Fv3RCyyFpRczaokak4Hz9ouaUBkg3Qb1j7zR62FCi3kEH1xwacBbHlNe/kuQeJNqve+bkLg7Fdf/ay6dPS2En7p4YHrecA0Xyxwqd/208SfQlllON0kBcgwU8B4Yzi3oqOr2+5DymtYqPkxab4BQQMfqlWyhZ5inGlJ5LBhn6gFQFC2yHsQf1fYqyUpPD6wGBxZ2iNdnvn8RwXNSjV7aBJljROFueSn+k93EDsq9iPN5faYQ2kYGM3CCB3D7ubjGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +E5k9hdwBwc6ehPJEkixg9p0jisQT1ci47oCE+Jr7sELmwTFfw6fEEEiegIAlseDa36HBDBNNECAo1vPPv7AmAlK3h+KP20J5iiFAfMxX20cBIAua+AH6tdjzCD1saw7F9Gga/06jaueJ1lmjcP44+NovbciYW3uBF3wnxtIEnnRJOgTk27JNMNCovSv88yrpl+Mz6BRYOVxDC6Gy0zioaMyynuymJk5dmpjK2AnQC+AZW/2Gmb67RKi/cujq4WEa7XKa0hzyFEjuK1J3texsh1GUiFdbUzTTS0cExwrxiCdyyg6o6J2EXw4VzaRvfKvcx5oO7/6QsfGy01yTDmXjhmcl3OjLLNKXtQ6DqwY9LWUxZyQZ50Ak5lTKEmJOek1gzZC7jB3GPaFYz2nDbZmLiHrhbt24UxOyjsFSdy96GJHWBEg4OEbfhiXxwQhs7x8F3Z+jCvuop45Tj4+e0Njv4OaHIAvb147j11cWOFQlgTT/AmlWfinsANiLA4NoNsS22KqsTJOVbXepbUJHzPHdi2DEvCOc/6iseplGOQYhwqmpT0j+8/jMFUXqIK21yRN5S2svhI9UAAQ63XQ+aRAjnC8lDbhSpjUPPjf6WjWIk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc81dad4-2980-40d6-e211-08debce83888
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:50.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj8+hJVpls2iLjrPgbIAFKg+S3RmVFpqLEkx8F9FpdAFjT0IrdYO87vbCASG1KkG7UwnpoQnq5h/XWsY9folK5mmHTGDTzWK82zBTxkxcVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605280187
X-Authority-Analysis: v=2.4 cv=d7LFDxjE c=1 sm=1 tr=0 ts=6a188b83 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=CutJqHQRXc6J1B7h_V8A:9
X-Proofpoint-ORIG-GUID: G8uKPCUCfDNlNpZLl1GsMpTqVH7G7YCq
X-Proofpoint-GUID: G8uKPCUCfDNlNpZLl1GsMpTqVH7G7YCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4NyBTYWx0ZWRfX4KFFn/APZdBq
 EB8lc294ANV459tHpdFIJHjIlqvdKKEyoK4+9FePsLnl9/YBhmN+BHdZ2oKXghc+AF0ET6BX41I
 hR9Y37SPNEAxgxAtJcBPv9XLbGF6JZ+rG44FRgf6XjhHp/CS3VD0CNQv39vZU9OEnYn5k9pzBC7
 QY1CAtTMTkdrc3110y7CIqjMgzwzhafToNuPR8ZDEIGRIhjZkrny3GWYZXFko2scNQSMiz+iTeS
 j5PclhMV/XavLeVYDGn8FThDpLlHcaIg+zCrHtiYx5LsuNFxkVoxByU8ECAJdW/EGuSj+VWDCdu
 dWqEoV697/CkwkUiwvb4836mEzImi/22KVcJwtZRPWlUPj/QC0wOD3tjwV1UT9GIP0EdC5Hz9RR
 PODFCqhhh0fAY6PrFgPu1T6VI0y4OyGbNRzd+W0K7RT63XG0a+KAAYgwX2t6fqy9jIU9GR7Je9X
 I2Nl2qmqSeBzm1tvGpg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_113758_488657_955016B0 
X-CRM114-Status: GOOD (  24.56  )
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

Tao Liu <ltao@redhat.com> writes:
> A) This patchset will introduce the following features to makedumpfile:
>
>   1) Add .so extension support to makedumpfile
>   2) Enable btf and kallsyms for symbol type and address resolving.
>
> B) The purpose of the features are:
>
>   1) Currently makedumpfile filters mm pages based on page flags, because flags
>      can help to determine one page's usage. But this page-flag-checking method
>      lacks of flexibility in certain cases, e.g. if we want to filter those mm
>      pages occupied by GPU during vmcore dumping due to:
>
>      a) GPU may be taking a large memory and contains sensitive data;
>      b) GPU mm pages have no relations to kernel crash and useless for vmcore
>         analysis.
>
>      But there is no GPU mm page specific flags, and apparently we don't need
>      to create one just for kdump use. A programmable filtering tool is more
>      suitable for such cases. In addition, different GPU vendors may use
>      different ways for mm pages allocating, programmable filtering is better
>      than hard coding these GPU specific logics into makedumpfile in this case.
>
>   2) Currently makedumpfile already contains a programmable filtering tool, aka
>      eppic script, which allows user to write customized code for data erasing.
>      However it has the following drawbacks:
>
>      a) cannot do mm page filtering.
>      b) need to access to debuginfo of both kernel and modules, which is not
>         applicable in the 2nd kernel.
>      c) eppic library has memory leaks which are not all resolved [1]. This
>         is not acceptable in 2nd kernel.
>
>      makedumpfile need to resolve the dwarf data from debuginfo, to get symbols
>      types and addresses. In recent kernel there are dwarf alternatives such
>      as btf/kallsyms which can be used for this purpose. And btf/kallsyms info
>      are already packed within vmcore, so we can use it directly.
>
>   With these, this patchset introduces makedumpfile extensions, which is based
>   on btf/kallsyms symbol resolving, and is programmable for mm page filtering.
>   The following section shows its usage and performance, please note the tests
>   are performed in 1st kernel.
>
>   3) Compile and run makedumpfile extensions:
>
>   $ make LINKTYPE=dynamic USELZO=on USESNAPPY=on USEZSTD=on EXTENSION=on
>   $ make extensions
>   
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
>     /tmp/extension.out --extension amdgpu_filter.so
>     Loaded extension: ./extensions/amdgpu_filter.so
>     makedumpfile Completed.
>         User time (seconds): 5.08
>         System time (seconds): 0.84
>         Percent of CPU this job got: 99%
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
>         Maximum resident set size (kbytes): 17360
>         ...
>  
>      To contrast with eppic script of v2 [2]:
>
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
>     /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c   
>     makedumpfile Completed.
>         User time (seconds): 8.23
>         System time (seconds): 0.88
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
>         Maximum resident set size (kbytes): 57128
>         ...
>
>   -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
>   -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
>   -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025-06-10-18:03:12/vmcore
>
> C) Discussion:
>
>   1) GPU types: Currently only tested with amdgpu's mm page filtering, others
>      are not tested.
>   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc64.
>      rhel8.x is not supported, others are not tested.
>
> D) Testing:
>
>      If you don't want to create your vmcore, you can find a vmcore which I
>      created with amdgpu mm pages unfiltered [3], the amdgpu mm pages are
>      allocated by program [4]. You can use the vmcore in 1st kernel to filter
>      the amdgpu mm pages by the previous performance testing cmdline. To
>      verify the pages are filtered in crash:
>
>      Unfiltered:
>      crash> search -c "!QAZXSW@#EDC"
>      ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>      ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>      crash> rd ffff96b7fa800000
>      ffff96b7fa800000:  405753585a415121                    !QAZXSW@
>      crash> rd ffff96b87c800000
>      ffff96b87c800000:  405753585a415121                    !QAZXSW@
>
>      Filtered:
>      crash> search -c "!QAZXSW@#EDC"
>      crash> rd ffff96b7fa800000
>      rd: page excluded: kernel virtual address: ffff96b7fa800000  type: "64-bit KVADDR"
>      crash> rd ffff96b87c800000
>      rd: page excluded: kernel virtual address: ffff96b87c800000  type: "64-bit KVADDR"
>
> [1]: https://github.com/lucchouina/eppic/pull/32
> [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
> [3]: https://people.redhat.com/~ltao/core/vmcore
> [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
>
> v5 -> v4:
>
> 1) Add "make EXTENSION=on" switch to customize the extension feature.
> 2) Clean up macros within btf_info.h.
> 3) Updated doc and a sample extension to demo the extension usage.
> 4) Use MSG()/ERRMSG() rather than fprintf().
> 5) Add return value check for readmem().
> 6) Allow "makedumpfile -d 1 --extension ext.so" to enter extension.
> 7) The patches are organized as follows:
>
>     --- <customization specific> ---
>     9. Add amdgpu mm pages filtering extension
>
>     --- <code should be merged> ---
>     8. Doc: Add --extension option to makedumpfile manual
>     7. Add sample extension as an example reference
>     6. Add makedumpfile extensions support
>     5. Implement kernel module's btf resolving
>     4. Implement kernel module's kallsyms resolving
>     3. Implement kernel btf resolving
>     2. Implement kernel kallsyms resolving
>     1. Reserve sections for makedumpfile and extenions
>
>     Patch 9 is customization specific, merging depends on the strategy of
>     maintenance.
>     Patch 1 ~ 8 are common code which should be merged with makedumpfile.

Hi Tao,

Just to be thorough, I did re-read the code of each patch, in addition
to reviewing the diff from v4 to v5.

I've also re-based my userspace stack extension on this new version.
I think it is ready to go.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Thanks,
Stephen

> Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@redhat.com/
> Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@redhat.com/
> Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
> Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/
>
> Tao Liu (9):
>   Reserve sections for makedumpfile and extenions
>   Implement kernel kallsyms resolving
>   Implement kernel btf resolving
>   Implement kernel module's kallsyms resolving
>   Implement kernel module's btf resolving
>   Add makedumpfile extensions support
>   Add sample extension as an example reference
>   Doc: Add --extension option to makedumpfile manual
>   Add amdgpu mm pages filtering extension
>
>  Makefile                   |  15 +-
>  README                     |   6 +
>  btf_info.c                 | 375 +++++++++++++++++++++++++
>  btf_info.h                 |  77 ++++++
>  extension.c                | 338 ++++++++++++++++++++++
>  extension.h                |  16 ++
>  extensions/Makefile        |  13 +
>  extensions/amdgpu_filter.c | 221 +++++++++++++++
>  extensions/maple_tree.c    | 328 ++++++++++++++++++++++
>  extensions/maple_tree.h    |   7 +
>  extensions/sample.c        |  69 +++++
>  kallsyms.c                 | 554 +++++++++++++++++++++++++++++++++++++
>  kallsyms.h                 |  87 ++++++
>  makedumpfile.8.in          |  11 +-
>  makedumpfile.c             |  44 ++-
>  makedumpfile.h             |  12 +
>  makedumpfile.ld            |  16 ++
>  17 files changed, 2180 insertions(+), 9 deletions(-)
>  create mode 100644 btf_info.c
>  create mode 100644 btf_info.h
>  create mode 100644 extension.c
>  create mode 100644 extension.h
>  create mode 100644 extensions/Makefile
>  create mode 100644 extensions/amdgpu_filter.c
>  create mode 100644 extensions/maple_tree.c
>  create mode 100644 extensions/maple_tree.h
>  create mode 100644 extensions/sample.c
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>  create mode 100644 makedumpfile.ld
>
> -- 
> 2.47.0

