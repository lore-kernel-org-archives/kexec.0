Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563B1D12676
	for <kexec@archiver.kernel.org>; Tue,  2 Dec 2025 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBYHousOYH+ypGeaxsrqqzJJ3a1Vssr3fiXOiTxwmOI=; b=gss7cKdikDqUrI487tckThT9Mf
	KkNS8M8XMW5m3bSuBBOiticT7Cj17RHHu0Cg4dgZXKt9t5qEEEhM823x5CT8Y+EG7lCZJWhBvExNz
	+IXfuhjxi7yBBMAs7yvTWIAo1/CiW+cWtzX+yXCWUTkxlaS2cjglSag0CJj5pTNVpW3mJAZ9WvAib
	vkYPWVNQ7FdV+UD8g/JS42m0Qpzw7cG6DKfwKR3j0pu21gmmKvvUYaDOc2pvlVOYrPYiEE/j2HJt+
	y3kUgNPAnxtfLMlNa/XrUm13i1+9nNbMjEcc2RuzxQw3SfUjdAGz6o2HZlrL04FENbc+rMijlwMuN
	b9t61fHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQYQG-00000005rxL-0nBQ;
	Tue, 02 Dec 2025 22:00:36 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQYQ8-00000005rwR-17pw
	for kexec@lists.infradead.org;
	Tue, 02 Dec 2025 22:00:34 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2LCLP11139901;
	Tue, 2 Dec 2025 22:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZBYHousOYH+ypGeaxs
	rqqzJJ3a1Vssr3fiXOiTxwmOI=; b=BIdfxk0mtWEVSyA+s1+oT/5/0Y0hhzLyqH
	reiESAfp9k6atFsJ7ksAjTcdJvbLYhT2+WEKtjXlqdBKO6/eixN8byRBcCyn7Zb8
	LjQCjgIbrVMRfXxo5yAe6AIuPsvjHfy1oweh1rYBSBk4zcr8FEjANC88v4PEaTl4
	A/NQIk6mO8ICsk4jAQ99RkfWw4Q4FsnDIdtt5++dKyRUcfgwjSwz8DR76RwLJmoT
	OoB4/pq7mGfroXsAZX/MF25sRkoA+vsAjvwkxPcyHnqe7hadW9HpmVzwb6m7nfT3
	PLIuFNIUAeEokrdDSo2M5Y+Jy8On1u3zJrmU+hOHD3ieTPf4BG4g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7u7v1x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 22:00:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2LF161015102;
	Tue, 2 Dec 2025 22:00:23 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq99x5vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 22:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElrPpaBnq3zdPcPg6frCTHjqGh+xDO2nHe/wXzKFWKqc6+GBYFo1z9WQ0FY5vf7Ddr8ZJhRBfYSc9sZ0DCai+HNMH1HC8nb4oElBSN5nmmadq600fkeKCzfX/DnnKk0VDlAHAHCg8L6aj5Exhov/GU652rXrxKgVu226rV0124aULc9AoPrlnVVqyqPcH5KeKES9W/q/mrDO/L+moYjFm/8B8GLpyjQXBofv17Tr9sNwWQgEVi/PMKa+FoFjcMiagBRtwIPXLFn0hRsLU1JBvjMabjL00Vh6y7kMnFw0NL21yutuBYHCdmvzYaJ9K/0C4UGBOK5KLNnbB4SfI6/yXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBYHousOYH+ypGeaxsrqqzJJ3a1Vssr3fiXOiTxwmOI=;
 b=w1qOWfoVAnaHjAOKXaox7ZYpa7arkbNLELZ97lHce4OLuf79MUDP5sGsKeT63VvLx7C0FXl2gsHIXwygLhJ1OjAyxaeYJrmuIG6ZKgxp8ipkslycN/DvRIUGGyNgTGbK6UwDi4VcecizrP8gyip1l8XOS6fL/r/997tnfloYGQ5h41CqAJFbjqeBUWSnsaRUtaOLB51CdFM6dx9JVmmFqXMeTq8bKc0PkpTCSshu9Kv8jkd6BOZ9VnrZjRreyD1MsyeLk9f9dg2kyCD3HMzQkUN3ffmIjgGfHqp6rUoilkSD5GKV+i0ydtRfYqPgfkuZAhWP4SP/0EDSNHyl8DQcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBYHousOYH+ypGeaxsrqqzJJ3a1Vssr3fiXOiTxwmOI=;
 b=rtcKeAatl54YXvUK/0fynyrblNeEMkd07nLQabDjikqj0W9g7nix3Q7E9QlUNOEgcdeADlPHJTPwO+otphkq6vx9BZvky/UMLMiyPwoOeSbdHF3VRe3DRAeDBZKtdLixEMYeebnyjMiSkwN7kOSF6BNXh21hBytVrX/4rlQ7+Mo=
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9) by CH3PR10MB7259.namprd10.prod.outlook.com
 (2603:10b6:610:12a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 22:00:19 +0000
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d]) by PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 22:00:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v2][makedumpfile 08/14] Implement kernel btf resolving
In-Reply-To: <20251020222410.8235-9-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-9-ltao@redhat.com>
Date: Tue, 02 Dec 2025 14:00:15 -0800
Message-ID: <87bjkgilxs.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF654CF2C22:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d8c88c-4e09-4eba-e359-08de31ee2e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Os83qpHaY9ah2qlpTEBv7FCzfQ5hUY5VMBwUhz88cE7bbeIZguYnHPgpr6oU?=
 =?us-ascii?Q?bPjFitSyjRTCr8o+tWPSl/6NK7V2jdynKJNYXgplkf9JLcODJM5qwyEqqty/?=
 =?us-ascii?Q?NxR7ULrBA8HxbrGKm6KC/HPRuGXhgCmTA0dsPARdp9Bxpeus2r2jp43D/T7a?=
 =?us-ascii?Q?OIWphRY+0iV8rm84uENIVF22ndQshP6YPThVZlLpelfVqW64OL6O/Uj4QnOX?=
 =?us-ascii?Q?+cR6cfPUN9B822MZ4mITZxEoSo7JDGmTlMg8Rxv3Wuigqne7YL8TfI3i3UHG?=
 =?us-ascii?Q?PHx1y7DHREiqUyQbnp4A05HyDSbQT00tZYBBXCx0E08D/Dj5GSg8wf3dDSbn?=
 =?us-ascii?Q?46Sjje9mLpJZPg/518tkx8mq8egy9ocozi3RywI8sUgp13kwImOZBsaEH9LX?=
 =?us-ascii?Q?g6oajFWlpnkyGLpLIIta6+huJw7VZP0yK3T5RJlM9aTIOrmSwC0CYW552q00?=
 =?us-ascii?Q?QCb71mN5sndTEeJ6nsvMNdT9gIkLqXjP/C+fLyRYLzOelcdfHnwRsYTkjrAD?=
 =?us-ascii?Q?yqwuG4vK1/PtALqcRe9tFO8Yk6fBoCFSUCR4wwqTiOguK9NankwOqb938o5u?=
 =?us-ascii?Q?5jV7YDD7dsbp7ThjKIZynQEnVkXwgHsQQ/0iAK2rz7V5xsHgUnp9GAcKhp1e?=
 =?us-ascii?Q?DfbZTwVO51lnVTFC78wj3Do12ZvLgRxU1h2Ofh6625yWlNkoEZl8nY7hEhDl?=
 =?us-ascii?Q?62z6hsTo5AEBE/C7GFhUsZxPLDDR07G89X1DVOG5r0I8PbrmnNKr5l+7zIU2?=
 =?us-ascii?Q?2XMStk7V51xwzfzrkfOBXkF6SzF1yEW/RUSAG/b89D7B+pNRflkzCuR7Zaq6?=
 =?us-ascii?Q?zpKZePEv/WDkGKHQUqVSpH0XUfydM/oAqw0EopjOjE2XjsSrqXeltoaAHlbI?=
 =?us-ascii?Q?DzEDNad+I37RsVbKPhZmA+y1MIASONSQKtNlALkDGasfIEpIhDBBtGua2c0n?=
 =?us-ascii?Q?IuDERD4hS0M7YSNuj+6evx15hMca0s+CXGzLLEG6nC61XBPxHPrZmf9dYoBz?=
 =?us-ascii?Q?O8oCyvGMYRQdFi4HizxR9ts8YK9NgFaslWk+0lYWWCkj8E4/tu4uS+9BBO07?=
 =?us-ascii?Q?IBC6XKsAUM9klAkFLcQi8ZZLGxPyE/Ca0Bi+2ScRRRAhgU+gzIt3WXGJKozr?=
 =?us-ascii?Q?ZFThVKdHD4WYLjpWtDt598TUqyFnXagCSyf++pPQs8FvxRfc30QceAugAXBZ?=
 =?us-ascii?Q?jIX3AFLPmNcb/Cies3W+FfGDRehwH5Jqwqlx4vBdA4stanynBwHDHBQmkyU8?=
 =?us-ascii?Q?R3ZhBvQBVEQpts/UIQB6jOdrYxzXBYUo+rPeU1HZWsRD4FHM32fuK4Hrq9Sr?=
 =?us-ascii?Q?NCpH9/tccreuu2fB7KWN+/bpZXn5OB1e5g9S6TtXbjfeBfaWE8WWoSnM//YQ?=
 =?us-ascii?Q?hvM5k9KWAVS7orIEm/aawX6tCBU7BhJjBCfGxiZf2TKKmr0M0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF654CF2C22.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVKtGtZZ93yKooiOaPyLJUdKiKUd1XPin6453kEFANRWOPcTi69LIHpVE5X2?=
 =?us-ascii?Q?J6ZruOLhs2Y0kVhV0VZsS52PROLHZ0vkHIGa+Lplykj0Pn3zY9i8pBgwV7Ct?=
 =?us-ascii?Q?exfzbjMIbzvQVqmzKilpDD64LRWqSYyz7WoUghl6AztgMj4oRJzEBd4PNtOD?=
 =?us-ascii?Q?LK5jsxUFwA6XhmnuqnBI59CMu3/b4xlYG5aRYzd86w4QM3bSXBfC2fCfqFwT?=
 =?us-ascii?Q?jYYHQ2BEwpfBdEJYuE7WZSeXPWXxYRGlMpheTYjB5alVYo55PE2rwtuBuQAj?=
 =?us-ascii?Q?unlNdg0BsvuM3ZGT5VViTEecaF+/wmZ4yKhLFYkG1abcyrl+dQLKIfvqmmV8?=
 =?us-ascii?Q?rri8Nm2VJqU4Q63/kCP189XP8cHB0ECXUpAJKMkDHIzfu+08UXaMNgI//enf?=
 =?us-ascii?Q?n9OEzVEFD5YYdioQPnKY8UvaDgMnYecK35cDEzl6zl6uRPtNSzsr/hH7nkrd?=
 =?us-ascii?Q?EkhMTP9hMvjd/kYnfrqgYLiXnz+9SPs/GWFRUXocmRfi3cEEgAmUYb6K7gqa?=
 =?us-ascii?Q?plrKSVrXizt/ZkRCPjUcwZZeIugfCIcnXNFPftWc6mzIFRkEhD+7iurvYonW?=
 =?us-ascii?Q?BsgTH9651uRbZDu/yPnBo8meZ1Qg9qlv3A/bwmFIc+5f/TXl6K4UpcvOx5pm?=
 =?us-ascii?Q?UU6uXy7VmcEX81juTtFrC4MzNFYcuhHuBSIWOD8qjiJ5gE5M1a/CLiZ6Xby6?=
 =?us-ascii?Q?zdZWrvLz01XOBpYPOZKTmy4tYHERyK2zWRj6+PmPDH1fqR4U0mxxSXlO0WRp?=
 =?us-ascii?Q?WfUO3iTFqPSEyaiJEKW/zW+fwBNAA+DcX7i3APeRzxFyYaVMIL3HvxM67TPf?=
 =?us-ascii?Q?9oMx3NyiPuce+sum0tr7jkesYhH0DrwiogjXCoSW1LlGUMnBEXYA8STHs+MY?=
 =?us-ascii?Q?1o1ur6ai2ziaIvRP47VHByx0Ua0xUnq+j5HdXEg+3+gOhoYhhXA25okWUdmJ?=
 =?us-ascii?Q?lHM9xmWCU3/doyLjgWwRDM/H+Kw9f1YRzXX18i6fn2mvtejWveBOLD9Be7UK?=
 =?us-ascii?Q?+kxq1Qtq1623T0Rv55PP83U38BnzNCamoRhDJsR9Vkv0pn2lz0XJqNjSZa04?=
 =?us-ascii?Q?NJT6m/e63BpTR7+WDAyJ7Bai0YIu9oQpuwkCnG8pbAjt0Nog7G2hlrvCQGip?=
 =?us-ascii?Q?0dxaIo05qTqhz+f6/AsMFDYznss09kQmaQWXepb2UY7egWeZjjP/YBK5q3cs?=
 =?us-ascii?Q?qBFbPd8zi00dpS/5C/srnAYLQ3dQs5IQODHvcSH3fw6yK7vEUrJ/cXwKEjrl?=
 =?us-ascii?Q?0V3zQ5dR+HwX0o67QULGWVSOxVI3UPsosA+PF/b0FkaSbgVUi8iBzIQR8H+U?=
 =?us-ascii?Q?DGktcXvfIAi+xswqiEIyamViy7XGFnRh1Ln2n93OKiVZlvMBhBU3oaM1+ay/?=
 =?us-ascii?Q?RYZ19IF/+ty4ZcG/FI7SHKQfZ6PRFqcVmvxKiABg+r4LHTCkQV35KSMaWXOX?=
 =?us-ascii?Q?Md3kzrXJz66VEpc/6INtLkPRMNScwQI8tPDXaMm0s0JX0fNJpeyenS3+K2qV?=
 =?us-ascii?Q?YnyuYf4GBrztFBfjKIHol+8d0uCOrrOi/V415uPQFZ/9YxB0nkUQl8oURduS?=
 =?us-ascii?Q?RVkx16x0UisRxMT24TwRqopKV6LnlhJqgFJTFbDF+ctYyRlHQxEiADxinZNN?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zpGXbb3fNE2ZZnBbYIFDkSRvg+hLhmXZtFA2sP/E+TyfYk07og0ty8fyqd3DAn2LJICgc1YMR8IhOhirqFmuZnL5zZqyZHRFPIiLhcCVYLsQzS/FH1fJMFukFY7UpGsWWgXzn2hFJeBIK7ApHjNYF8x+NBSsC+OoGOWXJ0pXu7z3/SiuRHgIMsVqF60PFl1vBA2p0n/L6jC7TX5zqqYhT5uQmHyr6gX7x5rq068rB6ASkGrpHml3ottMc7PLUxxGJHR7xwWSwoQZ35YUYFb2ECHjRXpMbl/ydEhUc6UfGlSHXofy89s8OVSbMRepFtZZREb3R+5na+NIHTwxflAI9Zp0tPoN8aLEEhOWYvvejuJcA+iyH9Tnl+E2x9atxbYrOFfgJgSY7bE8rRHONHq69BlnRPoDcWlL6eukV6nSlL4LWZ7kA7zpUkZwEnON2uYdSJmtff9Wyxd5+j6WenqvazfkzjrdizK2b7LD8srqohNTYSI6wJEYCAUdMwJ6DVJP/NkAD1CYNel/XKciIY8zI9GudkunNGle/H6tdVI76HxVCnqRsXV/Y56QLsHkCP+R6Z8WOSQV8CkOhK84YEz2Og68R7GA3o7ujynH0O4/3XU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d8c88c-4e09-4eba-e359-08de31ee2e01
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF654CF2C22.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 22:00:18.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8wSisZ/h73LfK39dtp3LuZPFKW9XdsO1U2UUtPhgp8NQtxPuHdHTA4U0uPCt5jiOkkScz9JDNC2oyCZ6IwrlyVW0HFexKH1uYuFWm9HPFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020173
X-Authority-Analysis: v=2.4 cv=Rfqdyltv c=1 sm=1 tr=0 ts=692f6178 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=ClGCBGz3AAAA:8 a=wgg2BEyZ2iTeYXawGT0A:9 a=ptG3bdoYgGIE1gkVOjHY:22
X-Proofpoint-GUID: iGOKK2jutXwYDr91MEi0Pc4wZ_AA9rI1
X-Proofpoint-ORIG-GUID: iGOKK2jutXwYDr91MEi0Pc4wZ_AA9rI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE3NCBTYWx0ZWRfX0gOrYhxyVj1T
 cEox8H1rQrg2z89jzdGIBCmf9JtMDyeUnBD3Xtn30AhFDQaHu4B46TxKVb/B1zSRb40PMNgC+gR
 Kkr6XyyolMHTQaWh6J03p0Eb6RyA5Dz4Hs1VNt9v1/5Wv3CcGhQg/MqB5SblmY8jl7FKkPtvtEf
 lVC10uSWixK065aAfDQNMwAwCUQligNNQuivfscF1x8v1gWzGgpskESAeMKUxaB4RhuSrAIpcE7
 X+tMHEsH8P/6Y1taEHkyckJdu3tua4aXOniG5I89JWjTUfZJx9BQJA/1yGuUQlE8eue3MChr5Cf
 KHL0Pyf/x69WyiCGBEy1Fxz5Yk1TGq+DOhfgLfy5xBJ2MYOPBl1SKNZeqCLs5ZkXn63wotbmO7y
 Kd3gIss9WDAFtoACLMZKqXj/0HXGmg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_140028_976286_18FCF2A8 
X-CRM114-Status: GOOD (  22.46  )
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
> This patch will parse kernel's btf data. The data can be located via
> __start_BTF and __stop_BTF symbols which have been resolved by kallsyms of
> the previous patch.
>
> The btf data is organized as follows: each one of kernel modules, including
> vmlinux itself, will have a btf_file struct describing its btf data, and
> holding an array of struct name_entry. By given the btf type id, we can resolve
> its name_entry fast by array index. In addition, name_entry can also be
> organized in hash table. So given a type name, we can also resolve its
> name_entry in a fast speed. In other words, both btf type id and btf
> type name can we get it resolved fast. Once we get the name_entry structure of
> the btf type, we can resolve its member/size etc easily.
>
> Since all name_entry array starting from index 0, which cannot identify a btf
> type globally. So a uniq id is used, its value is accumulated by the location
> of the btf_file within btf_file_array and total quantity of btf types within
> each btf_file.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Hi Tao,

I haven't read this patch in detail, but I wanted to ask if you had any
particular reason to avoid using libbpf for parsing the BTF?

For my implementation of BTF parsing for drgn I was not aware of it, so
I did the parsing entirely manually, similar to this. But for my recent
attempt[1] at adding BTF support to makedumpfile (unaware of this patch), I
used libbpf and found that it did reduce the amount of required code by
a lot. These are specific functions I found useful:

- btf__new() -> returns a "struct btf *" for use with the library
- btf__type_by_id() -> returns the "struct btf_type *". Then, the
  linux/btf.h header provides several inline functions to work with it:
  - btf_members(), btf_vlen()
  - btf_member_bit_offset()
- btf__pointer_size()
- btf__name_by_offset() -> returns the name for a string offset
- btf__find_by_name() & btf__find_by_name_kind() -> looks up a type by
  name. Note that this does a linear search, so your hash table approach
  is better for random lookups.
- btf__resolve_size()

So with libbpf, the only thing you'd really need to implement is
resolving member offsets (supporting anonyomus structs, recursively,
etc), and a hash table for string lookups, if you feel it's necessary.
For module BTF, btf__new_split() is available as well.

Thanks,
Stephen

[1]: https://github.com/brenns10/makedumpfile/commit/98129399a3a10ae72408bc4aaec2485f7d220626#diff-e1e6bd59ae956df7d2d42ad3580bd3c04da533f1b90827a04e2cc27bbf24b2a7

> ---
>  Makefile |   2 +-
>  btf.c    | 798 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  btf.h    | 175 ++++++++++++
>  3 files changed, 974 insertions(+), 1 deletion(-)
>  create mode 100644 btf.c
>  create mode 100644 btf.h
>
> diff --git a/Makefile b/Makefile
> index 2bb17f9..fbc9f5b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
>  endif
>  
>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf.c
>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
> diff --git a/btf.c b/btf.c
> new file mode 100644
> index 0000000..ba376cf
> --- /dev/null
> +++ b/btf.c
> @@ -0,0 +1,775 @@
> +#include "btf.h"
> +#include <stdio.h>
> +#include <assert.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <libelf.h>
> +#include <gelf.h>
> +#include <dirent.h>
> +#include "kallsyms.h"
> +#include "makedumpfile.h"
> +
> +// btf_files_array[0] must be kernel itself
> +// btf_files_array[1..] are kernel modules
> +static struct btf_file **btf_files_array = NULL;
> +static int btf_files_array_index = 0;
> +
> +static inline uint16_t btf_vlen(uint32_t info)
> +{
> +	return info & 0xFFFF;
> +}
> +
> +static inline uint32_t btf_kind_flag(uint32_t info)
> +{
> +	return info & (1 << 31);
> +}
> +
> +static inline uint32_t btf_member_bit_offset(uint32_t value)
> +{
> +	return value & 0xffffff;
> +}
> +
> +static inline uint32_t btf_member_bitfield_size(uint32_t value)
> +{
> +	return value >> 24;
> +}
> +
> +static struct btf_type *btf_next(struct btf_type *tp)
> +{
> +	uintptr_t next = (uintptr_t)&tp[1];
> +
> +	switch (btf_kind(tp->info)) {
> +	case BTF_KIND_INT:
> +		next += sizeof(uint32_t);
> +		break;
> +
> +	case BTF_KIND_ARRAY:
> +		next += sizeof(struct btf_array);
> +		break;
> +
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +		next += btf_vlen(tp->info) * sizeof(struct btf_member);
> +		break;
> +
> +	case BTF_KIND_ENUM:
> +		next += btf_vlen(tp->info) * sizeof(struct btf_enum);
> +		break;
> +
> +	case BTF_KIND_FUNC_PROTO:
> +		next += btf_vlen(tp->info) * sizeof(struct btf_param);
> +		break;
> +
> +	case BTF_KIND_VAR:
> +		next += sizeof(struct btf_var);
> +		break;
> +
> +	case BTF_KIND_DATASEC:
> +		next += btf_vlen(tp->info) * sizeof(struct btf_var_secinfo);
> +		break;
> +
> +	case BTF_KIND_DECL_TAG:
> +		next += sizeof(struct btf_decl_tag);
> +		break;
> +
> +	case BTF_KIND_ENUM64:
> +		next += btf_vlen(tp->info) * sizeof(struct btf_enum64);
> +		break;
> +
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_FUNC:
> +	case BTF_KIND_FLOAT:
> +	case BTF_KIND_TYPE_TAG:
> +		break; // no extra data
> +
> +	default:
> +		__builtin_unreachable();
> +	}
> +	return (struct btf_type *)next;
> +}
> +
> +#define NAME_HASH 512
> +static struct name_entry *name_hash_table[NAME_HASH] = {0};
> +
> +static void *get_name_entry_next(void *entry)
> +{
> +	return ((struct name_entry *)entry)->name_hash_next;
> +}
> +
> +static void set_name_entry_next(void *entry, void *next)
> +{
> +	((struct name_entry *)entry)->name_hash_next = next;
> +}
> +
> +static void name_hash_install(struct name_entry *en)
> +{
> +	hash_install((void **)name_hash_table, NAME_HASH, en, en->name,
> +			get_name_entry_next, set_name_entry_next);
> +}
> +
> +static unsigned int name_hash_index(char *name)
> +{
> +	return hash_index(name, NAME_HASH);
> +}
> +
> +int read_file_at_offset(char *f, int f_off, int r_size, void *buf)
> +{
> +	int got = 0;
> +	int r, fd, ret = -1;
> +
> +	fd = open(f, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "%s: Failed to open file %s\n", __func__, f);
> +		goto out;
> +	}
> +
> +	while (got < r_size) {
> +		r = pread(fd, buf + got, r_size - got, f_off + got);
> +		if (r < 0) {
> +			fprintf(stderr, "%s: Failed to read file %s\n", __func__, f);
> +			goto clean_fd;
> +		}
> +		got += r;
> +	}
> +	ret = got;
> +
> +clean_fd:
> +	close(fd);
> +out:
> +	return ret;
> +}
> +
> +static char *get_str_by_name_off(struct btf_file *bf, uint32_t name_off)
> +{
> +	struct btf_file *bf_vmlinux = btf_files_array[0];
> +
> +	if (bf != bf_vmlinux && name_off >= bf_vmlinux->str_cache_len)
> +		return bf->str_cache + name_off - bf_vmlinux->str_cache_len;
> +	else
> +		return bf_vmlinux->str_cache + name_off;
> +}
> +
> +int get_btf_type_by_type_id(struct btf_file *bf_in, uint32_t id_in,
> +			    struct btf_type *bt_out, struct name_entry **en_out)
> +{
> +	struct name_entry *en;
> +	struct btf_file *bf_vmlinux = btf_files_array[0];
> +
> +	if (bf_in != bf_vmlinux && id_in > bf_vmlinux->array_len) {
> +		en = bf_in->array[id_in - bf_vmlinux->array_len - 1];
> +	} else {
> +		en = bf_vmlinux->array[id_in - 1];
> +	}
> +	if (en_out)
> +		*en_out = en;
> +	return read_file_at_offset(en->bf->file_name,
> +		en->btf_type_offset + en->bf->types_data_offset,
> +		sizeof(*bt_out), bt_out);
> +}
> +
> +/*
> +* Parse the btf data and install elements into hashtable and array for quick
> +* reference.
> +*/
> +static int parse_btf_data(char *file_path, char *data_start, uint32_t data_len)
> +{
> +	struct btf_header *hdr = (struct btf_header *)data_start;
> +	struct btf_file *bf = NULL;
> +	void *type_start;
> +	char *str_start;
> +	struct btf_type *tp;
> +	struct name_entry *en;
> +	int i, j, scale;
> +
> +	/* We do some check first */
> +	if (hdr->magic != BTF_MAGIC) {
> +		fprintf(stderr, "%s: Invalid BTF magic in %s\n",
> +			__func__, file_path);
> +		goto out;
> +	}
> +	if (hdr->hdr_len != sizeof(*hdr)) {
> +		fprintf(stderr, "%s: Invalid BTF header length in %s\n",
> +			__func__, file_path);
> +		goto out;
> +	}
> +	if (hdr->hdr_len + hdr->str_off + hdr->str_len > data_len) {
> +		fprintf(stderr, "%s: String section exceeds data length in %s\n",
> +			__func__, file_path);
> +		goto out;
> +	}
> +	if (hdr->hdr_len + hdr->type_off + hdr->type_len > data_len) {
> +		fprintf(stderr, "%s: Type section exceeds data length in %s\n",
> +			__func__, file_path);
> +		goto out;
> +	}
> +
> +	/* Let's start parsing */
> +	bf = (struct btf_file *)malloc(sizeof(*bf));
> +	if (!bf)
> +		goto no_mem;
> +	memset(bf, 0, sizeof(*bf));
> +
> +	/* Enlarge array when reach power of 2 */
> +	btf_files_array[btf_files_array_index++] = bf;
> +	if ((btf_files_array_index & (btf_files_array_index - 1)) == 0) {
> +		struct btf_file **tmp = (struct btf_file **)reallocarray(btf_files_array,
> +						btf_files_array_index << 1,
> +						sizeof(struct btf_file *));
> +		if (!tmp)
> +			goto no_mem;
> +		btf_files_array = tmp;
> +	}
> +
> +	type_start = data_start + hdr->hdr_len + hdr->type_off;
> +	str_start = data_start + hdr->hdr_len + hdr->str_off;
> +
> +	bf->str_cache = malloc(hdr->str_len);
> +	if (!bf->str_cache)
> +		goto no_mem;
> +	memcpy(bf->str_cache, str_start, hdr->str_len);
> +    	bf->str_cache_len = hdr->str_len;
> +
> +	bf->array_len = 64;
> +	bf->array = (struct name_entry **)calloc(bf->array_len,
> +			sizeof(struct name_entry *));
> +	if (!bf->array)
> +		goto no_mem;
> +
> +	bf->file_name = strdup(file_path);
> +	if (!bf->file_name)
> +		goto no_mem;
> +	bf->types_data_offset = (char *)type_start - data_start;
> +
> +	for (tp = (struct btf_type *)type_start, i = 0;
> +	     (void *)tp < type_start + hdr->type_len;
> +	     tp = btf_next(tp), i++) {
> +		en = (struct name_entry *)malloc(sizeof(struct name_entry));
> +		if (!en) {
> +			bf->array_len = i;
> +			goto no_mem;
> +		}
> +		memset(en, 0, sizeof(struct name_entry));
> +
> +		en->btf_type_offset = (void *)tp - type_start;
> +		en->id = i + 1;
> +		en->bf = bf;
> +		if (tp->name_off) {
> +			en->name = get_str_by_name_off(bf, tp->name_off);
> +			if (en->name[0])
> +				name_hash_install(en);
> +		}
> +		bf->array[i] = en;
> +
> +		/* Now deal with sub elements which also have a name */
> +		if (btf_kind(tp->info) == BTF_KIND_ENUM ||
> +		    btf_kind(tp->info) == BTF_KIND_ENUM64) {
> +			scale = btf_kind(tp->info) == BTF_KIND_ENUM ?
> +				sizeof(struct btf_enum) : sizeof(struct btf_enum64);
> +			for (j = 0; j < btf_vlen(tp->info); j++) {
> +				en = (struct name_entry *)malloc(sizeof(struct name_entry));
> +				if (!en) {
> +					bf->array_len = i + 1;
> +					goto no_mem;
> +				}
> +				memset(en, 0, sizeof(struct name_entry));
> +				en->id = 0;
> +				en->p_id = i + 1;
> +				en->p_id += btf_files_array_index == 1 ?
> +					0 : btf_files_array[0]->array_len;
> +				en->bf = bf;
> +				en->name = get_str_by_name_off(bf,
> +					*(uint32_t *)((char *)&tp[1] + j * scale));
> +				// printf("%s\n", en->name);
> +				name_hash_install(en);
> +			}
> +		}
> +
> +		/* Enlarge array when over 3/4 */
> +		if (i > (bf->array_len >> 2) * 3) {
> +			struct name_entry **tmp = (struct name_entry **)reallocarray(bf->array,
> +				bf->array_len << 1, sizeof(struct name_entry *));
> +			if (!tmp)
> +				goto no_mem;
> +			bf->array = tmp;
> +			bf->array_len <<= 1;
> +		}
> +	}
> +	bf->array_len = i;
> +	return 0;
> +no_mem:
> +	/* All the memory free will be dealed later. */
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	return -1;
> +}
> +
> +/* 
> + * Used by search_name_by_cond() for searching specific type:
> + * such as struct/union/typedef
> + */
> +static bool is_type(struct name_entry *sp, void *data_in, void *data_out)
> +{
> +	struct btf_type *bt = (struct btf_type *)data_out;
> +	int type = *(int *)data_in;
> +	if (sp->id) {
> +		read_file_at_offset(sp->bf->file_name,
> +			sp->btf_type_offset + sp->bf->types_data_offset,
> +			sizeof(*bt), bt);
> +		return btf_kind(bt->info) == type;
> +	}
> +	return false;
> +}
> +
> +static struct name_entry *search_name_by_cond(char *name,
> +			bool (*fn)(struct name_entry *, void *, void *),
> +			void *data_in, void *data_out)
> +{
> +	unsigned int index;
> +	struct name_entry *sp;
> +
> +	index = name_hash_index(name);
> +	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
> +		if (!strcmp(name, sp->name) && fn(sp, data_in, data_out)) {
> +			return sp;
> +		}
> +	}
> +	return sp;
> +}
> +
> +// caller should prepare bt
> +void resolve_typedef(struct name_entry *en_in, struct name_entry **en_out,
> +		     struct btf_type *bt)
> +{
> +	uint32_t id;
> +	struct name_entry *en;
> +
> +	read_file_at_offset(en_in->bf->file_name,
> +		en_in->btf_type_offset + en_in->bf->types_data_offset,
> +		sizeof(*bt), bt);
> +	if (btf_kind(bt->info) == BTF_KIND_TYPEDEF) {
> +		id = bt->type;
> +		get_btf_type_by_type_id(en_in->bf, id, bt, &en);
> +		return resolve_typedef(en, en_out, bt);
> +	} else {
> +		*en_out = en_in;
> +	}
> +}
> +
> +struct cond_args {
> +	int index;
> +	char *name;
> +};
> +
> +static bool cond(struct cond_args *c1, struct cond_args *c2)
> +{
> +	if (c1->name && c2->name)
> +		/* Check if the member name is what we want */
> +		return !strcmp(c1->name, c2->name);
> +	else
> +		/* Check if the member index is what we want */
> +		return c1->index == c2->index;
> +}
> +
> +static bool get_internal_member_info(struct name_entry *en, int base_position,
> +				     int *global_index, struct cond_args *tar_arg,
> +				     struct member_info *mi, bool initial_dive)
> +{
> +	struct btf_type bt, sub_bt;
> +	int member_num;
> +	char *member_array_buf = NULL;
> +	int i;
> +	struct btf_member *bm;
> +	struct btf_array *ba;
> +	int bm_position;
> +	struct name_entry *sub_en;
> +	bool res;
> +	struct cond_args cur_arg = {0};
> +
> +	read_file_at_offset(en->bf->file_name,
> +		en->btf_type_offset + en->bf->types_data_offset,
> +		sizeof(bt), &bt); // this struct 
> +	if (initial_dive ||
> +	    ((!en->name || en->name[0] == '\0') &&
> +	     ((btf_kind(bt.info) == BTF_KIND_STRUCT) ||
> +	      (btf_kind(bt.info) == BTF_KIND_UNION)))) {
> +		/* anonymous struct/union, dive into */
> +		member_num = btf_vlen(bt.info);
> +		member_array_buf = calloc(member_num, sizeof(struct btf_member));
> +		if (!member_array_buf) {
> +			fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +			return false;
> +		}
> +		read_file_at_offset(en->bf->file_name,
> +			en->btf_type_offset + en->bf->types_data_offset + sizeof(bt),
> +			member_num *sizeof(struct btf_member), member_array_buf);
> +		for (i = 0, bm = (struct btf_member *)member_array_buf;
> +		i < member_num; i++) {
> +			if (btf_kind_flag(bt.info)) {
> +				bm_position = base_position +
> +					btf_member_bit_offset(bm[i].offset);
> +				mi->bits = btf_member_bitfield_size(bm[i].offset);
> +			} else {
> +				bm_position = base_position +
> +					bm[i].offset;
> +			}
> +			mi->sname = get_str_by_name_off(en->bf, bm[i].name_off);
> +			get_btf_type_by_type_id(en->bf, bm[i].type,
> +						&sub_bt, &sub_en);
> +			// Dive into this member
> +			res = get_internal_member_info(sub_en, bm_position, global_index,
> +						tar_arg, mi, false);
> +			if (res) {
> +				free(member_array_buf);
> +				return res;
> +			}			
> +		}
> +		free(member_array_buf);
> +		return false;
> +	}
> +
> +	cur_arg.index = *global_index;
> +	cur_arg.name = mi->sname;
> +	if (cond(&cur_arg, tar_arg)) {
> +		mi->bit_pos = base_position;
> +		resolve_typedef(en, &sub_en, &bt);
> +		mi->uniq_id = id_to_uniq_id(sub_en->id, sub_en->bf);
> +		if (btf_kind(bt.info) == BTF_KIND_PTR) {
> +			/* 
> +			 * BUG? No pointer size in btf,
> +			 * 32bit btf target on 64bit machine
> +			 */
> +			mi->size = sizeof(void *);
> +			mi->type = "char *";
> +		} else if (btf_kind(bt.info) == BTF_KIND_ARRAY) {
> +			en = sub_en;
> +			ba = (struct btf_array *)malloc(sizeof(struct btf_array));
> +			if (!ba) {
> +				fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +				return false;
> +			}
> +			read_file_at_offset(en->bf->file_name,
> +				en->btf_type_offset + en->bf->types_data_offset + sizeof(bt),
> +				sizeof(struct btf_array), ba);
> +			mi->size = ba->nelems; // array elements
> +			get_btf_type_by_type_id(en->bf, ba->type, &sub_bt, &sub_en);
> +			resolve_typedef(sub_en, &en, &bt);
> +			free(ba);
> +			mi->size *= bt.size; // element size
> +			mi->type = NULL; // "char [64]? Leave it NULL for now"
> +		} else {
> +			mi->size = bt.size;
> +			mi->type = get_str_by_name_off(sub_en->bf, bt.name_off);
> +		}
> +		return true;
> +	} else {
> +		(*global_index)++;
> +		return false;
> +	}
> +}
> +
> +static bool get_member_info_by_index(struct name_entry *en, int target_index,
> +				     struct member_info *mi)
> +{
> +	int g_index = 1;
> +	struct cond_args args = {0};
> +	args.index = target_index;
> +	memset(mi, 0, sizeof(*mi));
> +	return get_internal_member_info(en, 0, &g_index, &args, mi, true);
> +}
> +
> +static bool get_member_info_by_member_name(struct name_entry *en, char *member_name,
> +					   struct member_info *mi)
> +{
> +	int g_index = 1;
> +	struct cond_args args = {0};
> +	args.name = member_name;
> +	memset(mi, 0, sizeof(*mi));
> +	return get_internal_member_info(en, 0, &g_index, &args, mi, true);
> +}
> +
> +/* 
> + * Entry for query struct members
> + * Return: struct size, mi_out: member details
> + */
> +uint32_t get_struct_member_by_name(char *struct_name, char *member_name,
> +				   struct member_info *mi_out)
> +{
> +	struct name_entry *en;
> +	struct btf_type bt = {0};
> +	int type = BTF_KIND_STRUCT;
> +
> +	en = search_name_by_cond(struct_name, is_type, (void *)&type, (void *)&bt);
> +	if (!en)
> +		goto out;	
> +	if (get_member_info_by_member_name(en, member_name, mi_out))
> +		return bt.size;
> +out:
> +	return 0;
> +}
> +
> +/* 
> + * Entry for query type members, similar as above
> + * Return: found-the-type, mi_out: member details
> + */
> +static uint32_t uniq_id_to_id(uint32_t, struct btf_file **);
> +bool get_type_member_by_index(uint64_t type_uniq_id, int member_index,
> +			      struct member_info *mi_out)
> +{
> +	uint32_t id;
> +	struct btf_file *bf;
> +
> +	id = uniq_id_to_id((uint32_t)type_uniq_id, &bf);
> +	return get_member_info_by_index(bf->array[id - 1], member_index, mi_out);
> +}
> +
> +uint32_t id_to_uniq_id(uint32_t id, struct btf_file *bf)
> +{
> +	int i;
> +	uint32_t uniq_id = 0;
> +	for (i = 0; i < btf_files_array_index; i++) {
> +		if (btf_files_array[i] != bf)
> +			uniq_id += btf_files_array[i]->array_len;
> +		else
> +			return id + uniq_id;
> +	}
> +	__builtin_unreachable();
> +	assert(false);
> +}
> +
> +static uint32_t uniq_id_to_id(uint32_t uid, struct btf_file **bf)
> +{
> +	int i;
> +	
> +	for (i = 0; i < btf_files_array_index; i++) {
> +		if (uid > btf_files_array[i]->array_len) {
> +			uid -= btf_files_array[i]->array_len;
> +		} else {
> +			if (bf)
> +				*bf = btf_files_array[i];
> +			return uid;
> +		}
> +
> +	}
> +	__builtin_unreachable();
> +	assert(false);
> +}
> +
> +// api for eppic
> +uint32_t get_type_size_by_name(char *type_name, int type, uint32_t *uniq_id)
> +{
> +	struct name_entry *en;
> +	struct btf_type bt = {0};
> +
> +	en = search_name_by_cond(type_name, is_type, (void *)&type, (void *)&bt);
> +	if (!en)
> +		goto out;
> +	if (uniq_id)
> +		*uniq_id = id_to_uniq_id(en->id, en->bf);
> +	return bt.size;
> +out:
> +	return 0;	
> +}
> +
> +// Caller should prepare bt_out
> +struct name_entry *get_en_by_uniq_id(uint32_t uniq_id, struct btf_type *bt_out)
> +{
> +	uint32_t id;
> +	struct btf_file *bf;
> +	struct name_entry *en;
> +	struct name_entry *en_sub;
> +
> +	id = uniq_id_to_id((uint32_t)uniq_id, &bf);
> +	en = bf->array[id - 1];
> +	resolve_typedef(en, &en_sub, bt_out);
> +	return en_sub;
> +}
> +
> +/* Deal with btf file */
> +static int btf_file_init(int fd)
> +{
> +	struct stat f_stat;
> +	char *buf = NULL;
> +	char proc_path[32];
> +	char real_path[512];
> +	int ret = -1;
> +
> +	memset(real_path, 0, sizeof(real_path));
> +	if (fstat(fd, &f_stat) < 0) {
> +		fprintf(stderr, "%s: fstat fail!\n", __func__);
> +		goto out;
> +	}
> +	buf = malloc(f_stat.st_size);
> +	if (!buf) {
> +		fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +		goto out;
> +	}
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
> +	readlink(proc_path, real_path, sizeof(real_path) - 1);
> +	if (read_file_at_offset(real_path, 0, f_stat.st_size, buf) < 0)
> +		goto out;
> +
> +	ret = parse_btf_data(real_path, buf, f_stat.st_size);
> +out:
> +	if (buf)
> +		free(buf);
> +	return ret;
> +}
> +
> +/* Deal with elf file which contains .BTF section */
> +static int elf_file_init(int fd)
> +{
> +	char proc_path[32];
> +	char real_path[512];
> +	Elf *elf = NULL;
> +	Elf_Scn *scn = NULL;
> +	size_t shstrndx;
> +	GElf_Shdr shdr;
> +	Elf_Data *data = NULL;
> +	char *str, *databuf = NULL;
> +	int ret = -1;
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
> +	readlink(proc_path, real_path, sizeof(real_path) - 1);
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE)
> +		goto elf_err;
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (!elf || elf_getshdrstrndx(elf, &shstrndx))
> +		goto elf_err;
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		if (!gelf_getshdr(scn, &shdr))
> +			continue;
> +		str = elf_strptr(elf, shstrndx, shdr.sh_name);
> +		if (!strcmp(str, ".BTF"))
> +			break;
> +	}
> +	if (!scn) {
> +		fprintf(stderr, "%s: No .BTF found in %s!\n", __func__, real_path);
> +		goto out;
> +	}
> +
> +	data = elf_rawdata(scn, data);
> +	databuf = malloc(data->d_size);
> +	if (!databuf) {
> +		fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +		goto out;
> +	}
> +	memcpy(databuf, data->d_buf, data->d_size);
> +	elf_end(elf);
> +	elf = NULL;
> +	ret = parse_btf_data(real_path, databuf, data->d_size);
> +	goto out;
> +
> +elf_err:
> +	fprintf(stderr, "%s: elf error in %s!\n", __func__, real_path);
> +out:
> +	if (databuf)
> +		free(databuf);
> +	if (elf)
> +		elf_end(elf);
> +	return ret;
> +}
> +
> +/*
> + * Entry for parse btf file and elf file.
> + */
> +static int file_init(char *name)
> +{
> +	int fd = 0, ret = -1;
> +	char buf[4] = {0};
> +
> +	/* Will be enlarged automatically */
> +	if (!btf_files_array) {
> +		btf_files_array = calloc(1, sizeof(struct btf_file *));
> +		if (!btf_files_array) {
> +			fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +			goto out;
> +		}
> +	}
> +	
> +	fd = open(name, O_RDONLY);
> +	if (read_file_at_offset(name, 0, sizeof(buf), buf) < 0)
> +		goto out;
> +	if (*(u_int16_t *)&buf == BTF_MAGIC) {
> +		ret = btf_file_init(fd);
> +	} else if (*(u_int32_t *)&buf == (((u_int32_t)ELFMAG0 << 24) | 
> +					  ((u_int32_t)ELFMAG1 << 16) |
> +					  ((u_int32_t)ELFMAG2 << 8)  |
> +					  ((u_int32_t)ELFMAG3 << 0))) {
> +		ret = elf_file_init(fd);
> +	} else {
> +		__builtin_unreachable();
> +	}
> +
> +out:
> +	if (fd)
> +		close(fd);
> +	return ret;
> +}
> +
> +/* For pure buffer data, wrap it as a file, and handover to file_init() */
> +char temp[] = "/tmp/btf_XXXXXX";
> +static int init_btf_from_buf(char *mod_name, char *buf, int size)
> +{
> +	int fd;
> +	char name_buf[64];
> +	int w, got = 0;
> +	static char *temp_dir = NULL;
> +
> +	if (!temp_dir)
> +		temp_dir = mkdtemp(temp);
> +	snprintf(name_buf, sizeof(name_buf), "%s/%s", temp_dir, mod_name);
> +	fd = open(name_buf, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
> +	if (fd < 0) {
> +		fprintf(stderr, "%s: open fail in %s!\n", __func__, name_buf);
> +		return -1;
> +	}
> +
> +	while (got < size) {
> +		w = pwrite(fd, buf + got, size - got, got);
> +		if (w < 0) {
> +			fprintf(stderr, "%s: pwrite fail in %s!\n", __func__, name_buf);
> +			return -1;
> +		}
> +		got += w;
> +	}
> +	close(fd);
> +	return file_init(name_buf);
> +}
> +
> +int init_kernel_btf(void)
> +{
> +	uint64_t size;
> +	char *buf;
> +	int ret;
> +
> +	uint64_t start_btf = get_kallsyms_value_by_name("__start_BTF");
> +	uint64_t stop_btf = get_kallsyms_value_by_name("__stop_BTF");
> +	if (!start_btf || !stop_btf) {
> +		fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n", __func__);
> +		return -1;
> +	}
> +
> +	size = stop_btf - start_btf;
> +	buf = (char *)malloc(size);
> +	if (!buf) {
> +		fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +		return -1;
> +	}
> +	readmem(VADDR, start_btf, buf, size);
> +	ret = init_btf_from_buf("vmlinux", buf, size);
> +	free(buf);
> +
> +	return ret;
> +}
> +
> diff --git a/btf.h b/btf.h
> new file mode 100644
> index 0000000..424e9e0
> --- /dev/null
> +++ b/btf.h
> @@ -0,0 +1,175 @@
> +#ifndef _BTF_H
> +#define _BTF_H
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +typedef uint8_t  __u8;
> +typedef uint16_t __u16;
> +typedef uint32_t __u32;
> +typedef int32_t __s32;
> +
> +#define BTF_MAGIC	0xeb9f
> +
> +enum {
> +	BTF_KIND_UNKN		= 0,	/* Unknown	*/
> +	BTF_KIND_INT		= 1,	/* Integer	*/
> +	BTF_KIND_PTR		= 2,	/* Pointer	*/
> +	BTF_KIND_ARRAY		= 3,	/* Array	*/
> +	BTF_KIND_STRUCT		= 4,	/* Struct	*/
> +	BTF_KIND_UNION		= 5,	/* Union	*/
> +	BTF_KIND_ENUM		= 6,	/* Enumeration	*/
> +	BTF_KIND_FWD		= 7,	/* Forward	*/
> +	BTF_KIND_TYPEDEF	= 8,	/* Typedef	*/
> +	BTF_KIND_VOLATILE	= 9,	/* Volatile	*/
> +	BTF_KIND_CONST		= 10,	/* Const	*/
> +	BTF_KIND_RESTRICT	= 11,	/* Restrict	*/
> +	BTF_KIND_FUNC		= 12,	/* Function	*/
> +	BTF_KIND_FUNC_PROTO	= 13,	/* Function Proto	*/
> +	BTF_KIND_VAR		= 14,	/* Variable	*/
> +	BTF_KIND_DATASEC	= 15,	/* Section	*/
> +	BTF_KIND_FLOAT		= 16,	/* Floating point	*/
> +	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
> +	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
> +	BTF_KIND_ENUM64	= 19,	/* Enumeration up to 64-bit values */
> +
> +	NR_BTF_KINDS,
> +	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
> +};
> +
> +struct btf_type {
> +	__u32 name_off;
> +
> +	/* "info" bits arrangement
> +	 * bits  0-15: vlen (e.g. # of struct's members)
> +	 * bits 16-23: unused
> +	 * bits 24-27: kind (e.g. int, ptr, array...etc)
> +	 * bits 28-30: unused
> +	 * bit     31: kind_flag, currently used by
> +	 *             struct, union and fwd
> +	 */
> +	__u32 info;
> +
> +	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
> +	 * "size" tells the size of the type it is describing.
> +	 *
> +	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> +	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
> +	 * "type" is a type_id referring to another type.
> +	 */
> +	union {
> +		__u32 size;
> +		__u32 type;
> +	};
> +};
> +
> +struct btf_header {
> +	__u16	magic;
> +	__u8	version;
> +	__u8	flags;
> +	__u32	hdr_len;
> +
> +	/* All offsets are in bytes relative to the end of this header */
> +	__u32	type_off;	/* offset of type section	*/
> +	__u32	type_len;	/* length of type section	*/
> +	__u32	str_off;	/* offset of string section	*/
> +	__u32	str_len;	/* length of string section	*/
> +};
> +
> +struct btf_array {
> +	__u32	type;
> +	__u32	index_type;
> +	__u32	nelems;
> +};
> +
> +struct btf_member {
> +	__u32	name_off;
> +	__u32	type;
> +	/* If the type info kind_flag is set, the btf_member offset
> +	 * contains both member bitfield size and bit offset. The
> +	 * bitfield size is set for bitfield members. If the type
> +	 * info kind_flag is not set, the offset contains only bit
> +	 * offset.
> +	 */
> +	__u32	offset;
> +};
> +
> +struct btf_enum {
> +	__u32	name_off;
> +	__s32	val;
> +};
> +
> +struct btf_enum64 {
> +	__u32   name_off;
> +	__u32   val_lo32;
> +	__u32   val_hi32;
> +};
> +
> +struct btf_param {
> +	__u32	name_off;
> +	__u32	type;
> +};
> +
> +struct btf_var {
> +	__u32	linkage;
> +};
> +
> +struct btf_var_secinfo {
> +	__u32	type;
> +	__u32	offset;
> +	__u32	size;
> +};
> +
> +struct btf_decl_tag {
> +	__s32   component_idx;
> +};
> +
> +/*************************************/
> +struct btf_file {
> +	char *file_name;
> +	char *str_cache;
> +	uint32_t str_cache_len;
> +	uint32_t types_data_offset;
> +	uint32_t array_len;
> +	struct name_entry **array;
> +};
> +
> +struct name_entry {
> +	union {
> +		uint32_t btf_type_offset;
> +		uint32_t p_id;
> +	};
> +
> +	uint32_t id;
> +	char *name;
> +	struct btf_file *bf;
> +	struct name_entry *name_hash_next;
> +};
> +
> +struct member_info {
> +	char *sname;	// member name
> +	char *type;	// member type: int, long etc
> +	uint32_t bit_pos;	// member position in bits
> +	uint32_t bits;	// member width in bits
> +	uint32_t size;	// member size in bytes
> +	int uniq_id;	// uniq_id of btf
> +};
> +
> +/*************************************/
> +
> +int read_file_at_offset(char *, int, int, void *);
> +int init_kernel_btf(void);
> +uint32_t get_struct_member_by_name(char *, char *, struct member_info *);
> +bool get_type_member_by_index(uint64_t, int, struct member_info *);
> +uint32_t get_type_size_by_name(char *, int, uint32_t *);
> +struct name_entry *get_en_by_uniq_id(uint32_t, struct btf_type *);
> +void resolve_typedef(struct name_entry *, struct name_entry **, struct btf_type *);
> +int get_btf_type_by_type_id(struct btf_file *, uint32_t,
> +			    struct btf_type *, struct name_entry **);
> +uint32_t id_to_uniq_id(uint32_t, struct btf_file *);
> +
> +static inline uint32_t btf_kind(uint32_t info)
> +{
> +	return (info & 0x1F000000) >> 24;
> +}
> +
> +#endif /* _BTF_H */
> -- 
> 2.47.0

