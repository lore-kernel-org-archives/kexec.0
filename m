Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3BBC61DBD
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 07:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RA9rb+/9mJt2FXiwYO2g9/3ho2icQ8Wzy6J2lZ6Cpxo=; b=pSr7lGtblAx6dtxyKjxVNJg65s
	VDFRGN6URoJf9GUQMadcyt2/B41VY+KpPN4GC2FTBmgfxksTFSGa6q46iW0g3nUW2pTg/qAdOfLS+
	BiNSVgeGQjgG5qKU2GEDH8Lh2fOJZc+UZuXLZl1qmMFYyxOZJBmYfUEd0B39x4hNcyxIMsWGjvvjG
	C9LwlkaOJKaUj4jGRLpnZDu+RjTgB3HPDFqnaxzIOU/Rvy22UYrpmpbgyVayISpk4ufpL7B3EEhgQ
	52KQl8nmNjWicGqO0QgMKUoze25gCVJJ+EjA3/bEbfDCYfBzfDN2bAyqKT4OLQWPEkA69jTK0RTRf
	mHhcrBaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8DE-000000021In-3N7v;
	Wed, 26 Aug 2026 07:38:20 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8D4-000000021H3-2Hqf
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 07:38:14 +0000
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6SWAj3456380;
	Wed, 26 Aug 2026 07:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=RA9rb+/9m
	Jt2FXiwYO2g9/3ho2icQ8Wzy6J2lZ6Cpxo=; b=QdUJb/y3w1nBYFW7aFjgeOb2/
	a4ORMWEZLCP6LfsC+3FAovOz2LymvDX8eAx8asesTcJgMKGFKo6AxR1JD0X7oaTf
	6recdVrNfdpYBJVmLiPo2lnfzmYGyZqbUsZzmEiINTBXImBhLi9m8ZHcmZl+bWy/
	A30TMSXzx9fPRdKSdI9vOmWEurDFMA1j9Ueac9grDploJ41QK4vUE/VbYCjG28Ux
	K9OD5oKa1E7P1FoEHAS988mtTJzXgR5wsCgjcAQUrRFRaGlQboCaPpq+qHemvrsk
	wYg8FRKVuM5t/jja1FpM+dL8DhpK0WTefg+rryE9c09W+meWj+2j9qKsEWz9Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022072.outbound.protection.outlook.com [52.101.48.72])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7100p9a1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 07:35:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjrGC9lZxmLIVfT/hNMLcU76jQA2jKTfJ4AUhjh4PsNayfp/nIZ/cEXb+rooNMRlG1zEcSz9NGwsWG1g/yn7fAbovtnJ9K8GRnDmB75/t27tZ5jfbDaO4EPL4j3py2kZslDV+kw9dhIjQj6mN8QRYWYp4khQ5GdyM7WMPn4/llZvjt1/Yo1YMZW36fUvNCa6dpb11FmS6C3i5P5hnL+aCszNGVc/yU44EvFsOFRg6XQTEN5VgHQcrxLguYgT4YpMKWholjeGcsMbeVtfZscOENWMBWsjPlpq2LxhNd+cA0buyRqsJCQChfyJvEPYqmJL/JfT3p83NfhhesBC3kbbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA9rb+/9mJt2FXiwYO2g9/3ho2icQ8Wzy6J2lZ6Cpxo=;
 b=GZAA0loU+EauWiYQz47pDSXAZ8BfFZj7rLVZsnQlVR25A6jrU37fmozYOa87Qjw95lxNtpMqLLN0hecBActlXjYfxcnBNij87GySMrTAwpSXAPYHqNkJfNn5AFCC8he4PnIYtgZrp0xIYzmaJBxyYL2aklLrF79KjNcsOnmmCdy4sD3RMe4IJst/qahzxvmoRkRErwviY7UaQAdf6pZ4a+VD7jMZnET9D4T+RDcEvo8k7+iL2WwLz49t1+C2dRtNNrtFxf2OKjE0W8k3ZkE1Hl8YzklnBoqSEOQk0nPDd9DO1chjVxPbHmB7ibf0WCoLx6XWm6PYUlvwQGSNCawptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 07:35:43 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 07:35:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] x86/crash: fix kexec_file_load(2) -EINVAL on machines with many possible CPUs
Date: Wed, 26 Aug 2026 10:35:25 +0300
Message-ID: <20260826073527.21487-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PR11MB872716:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c65881-ac75-4869-a5a2-08df0344a2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|10070799003|23010399003|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: jkBeugn6s+ykh3g9M2GTDS0Wsp81dRpcHHIaQHb7SzwbVh4XVvTyD83kCfkGXpCAYGC5oyFrDWFcovEbP5VWxrvXyZxsHb6EVsDejDis/LCKQ9JPVyrhBRXCpERk4i5i7SBHn14GjBo/kzdtk5yUZFltrw1lxS3j7BBWjVXfQurQQDsZucxDNCgWvlgeMwsfDkWNHiEty+baXhpmioBIwkpnari3M9X+CaS/zAQ3dnuP2JXgI/bHDClY8X9MTKm8hKe3Hww5w3VC8aluo3CbUd93yR9gkUYnCimn9uqyvD8tWDnVdqbncJ2iJlgfChjJ9R599QzFoc5OyjAq4BYbmfH9lQj6FbbhI7gm3wzvfShnPQGIndgiAPvxWiCRP9LankoiAHBEYXkU6yP7adf9HwA4/kfTjKm/fH5ZOSc0k0EQX/BdJa4LSrlwgoG5PSXJzK2NF6Icj+agU6pludjc1MdKBsIyGBCvZXET1e5YFMiPT2rHAR7COec9LNZ+0wrl6TDvQjorFQWZDR4Ly6CM510ZA+lOiGOrHhUfQPeh9dPJ5jgmqy7lEwdUO+dPfRwIEx1KWD2dP7jqRqoj/AGFC0oj26FzWje5QZxObFhgrbeEQG7xM47aoGeFxzgqpAvqD4YOXltH5LGMxRwJmjunGnk00MNRpVtrFzRZtdNCztM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(10070799003)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kqGZNDpdKTXXF+MHj02rOmuGxca0vdcaw8rogMFmegWdFZa/4G3n28xNS1/?=
 =?us-ascii?Q?AVaoDdZCEwaOJCv0YXBrJFyPfa2rnmo0P6rwFPFIiW70t/d/csBZ/LNga+78?=
 =?us-ascii?Q?7v/DdOI8BbH0KjFu5maNsitL6CZ2QC+oGggYIiYXVeok0Z2lUMuH7y68rISa?=
 =?us-ascii?Q?V7Jn7+4pOBxdjBsHO6yMeh0Zej7p3sL02UZnHOlIE36DwvLH0v3GwBWT10L0?=
 =?us-ascii?Q?bX/hwsnf20O5RfXE94zKOkUzsNkwRDGU/BfeCno9ozafr9O34fRR9K0831NH?=
 =?us-ascii?Q?SXx1t4lFU2ynENUYdILfSxQUMrYc6fjVaOWbb3BZo3vCPzmdxJbntRPPHxf1?=
 =?us-ascii?Q?bzAwakyMl3nKJ1S+ZJ5GPT4PQXiX8mPVPW1EN7EqLf1pYqzYxFWksxA3GkAG?=
 =?us-ascii?Q?8QHo3qCBkXbZLOv3/s9zwQmoeac9Z4BkH8ao1CsF/weO7AE8Sm5GHHfaisqJ?=
 =?us-ascii?Q?fPD1TFdrGrQ3IPgqjD4zCeOmEmDC9Cw2LBVf5B0fmFtH0iM0/UplN2s8uKc2?=
 =?us-ascii?Q?ccpNpGVmP5fjMpZu23EazSkLjhn58eyP3bdaMGToa6ctj1FSnVEx+dWP68Im?=
 =?us-ascii?Q?NxTA9CKBZBkXD/KdBVECwrHUUtBuUkOWE3WEXxesRB7nSyvQmhYgYfprNEe5?=
 =?us-ascii?Q?DmJB15nd8aipyC2LfB4hhDeyGJTetss4+wyvlC9hCoICWB3cn7QSd5ocQ5BD?=
 =?us-ascii?Q?1lrfoIfyOeedSGGiTJ51WSrtGU0MO5qb8MdMjAZ9FbS9959pjcYfJh+tR7Fi?=
 =?us-ascii?Q?eTyHKR65CaUWrYSUCGNi3z2X3d49cwky7SccQGXLY54VsTzF5eZmC1h6t5ZZ?=
 =?us-ascii?Q?vGUCVQ6hZH+8rg8l7l13HdXEUQX6NJVUm1VEwpcOErWpM6xCwmAcoy7vOjIs?=
 =?us-ascii?Q?twzGlEBySvZ6d+cutKNNPHELmQ7ks8cLs/SJ5TmmZ9xeD6CTzpB6HJeiJrfH?=
 =?us-ascii?Q?An8+B40twbV3SznL/i71EYqC9KZ0RK5iB+K5QjlCSjjFuw0/owdsbumHWhFG?=
 =?us-ascii?Q?kdEskkvjlDur4GY+uMD1nDI0SNVn29nCme1mIywPbfytRm2FzyPswGx4Ett+?=
 =?us-ascii?Q?tALKPZg1YOTwOLw9lcYUv2bhPYgDPdq6gy6isCbYY7ll0hRShA5BVI7YtXmV?=
 =?us-ascii?Q?ipLdsldF+X9v/w24ommxrdxAMOY8epEuetpwdBHARwNxn13q+qyPiaoKq/W2?=
 =?us-ascii?Q?bt3KDqenaRQJtZzP+h7Ch4bHmjNGdqZSC5oCGQ6XKzAG9ZVAhLglSlR91p1R?=
 =?us-ascii?Q?Og9Dhv//djtbilP9ZAeCgYgxdnenUmUqL1aHILTW9Z/rqUE4GRmR+qmx29ra?=
 =?us-ascii?Q?s7gYUyO2bMqBARlIm4xDnjmFrqkW6HXWyLuSKF8mu0Q7q6Qakg+OHc3O8Pr8?=
 =?us-ascii?Q?x+7of5egav+9j/kkPR3OglSCdYkWlJ9LvYMU/ZRsH+5RqzmXPbPAtLaEXBdK?=
 =?us-ascii?Q?aWn2+dSu0c8Csze1LLvw0GXoOMhVUYYdRORkdaqxjNZgpPuNQ+R8hmcoIsbz?=
 =?us-ascii?Q?0loBKREIzoMIXNDZ3H6JAWG8MoXVFrKgJP/NMuJ+mmXQfzgJi+VWBIiesBO8?=
 =?us-ascii?Q?kAaGtZgBIULXwuKiRf1aCbZfdgwFPl1bFON8Ka7WUJitCmUbdPtndBMAsVHD?=
 =?us-ascii?Q?ZGCvr66mKIoiqX9jPPJsLUrGKHN2nibC7hEXhA2jhC7XDlQynBD7u5/ge3/Y?=
 =?us-ascii?Q?TbEhB0tvG5RDHSGQXquk+tl9FrdMgid6Gc2VbjXcgZ+osex6m2sRIixQGhFF?=
 =?us-ascii?Q?wsgBdkeEkGM7I5/12tsbeY3vpmEduyOmHy7VbVuuzZwQlyr9A1NudBD3Jqm0?=
X-MS-Exchange-AntiSpam-MessageData-1: JYXFfl+BZCDF/ws71TxulD+ySCjfGhsFGqI=
X-Exchange-RoutingPolicyChecked: jt+WIcFJDmq5a3u72HafWDMjIwfbIXbYmdUOGXQZmnexsaOc093Xb9wVxZi7HvmFWQG2+lDu2XnKYswKSWUjFEH8WRPIpqqxAKtwj7LS7UJq/7jZdipf95c+BwotD8jGvuTZVYTrvsoCjqupKlX/BQdOwjzYPLGOOzm6UA8AxnkAxmpByR8ET9qLfSJ6s9LluRI3gNBplKBnvCHk3Dsb8e5+JVelPJTdPbtyMFE0jT/o+b+/mvXUZdXTEuQv/Bq9r8J4jwHLfboFu980bBCC7Fx1P4SBNQokG6lk9I9FDjmRcjGrQfd4RfA5TEmbEir5a8Uh8fsBUaE55Wtson1CeA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c65881-ac75-4869-a5a2-08df0344a2a0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:35:43.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veK+8gHU8jQJD1nEqZzenn1Px2UL3jMSnRls+eJeNQYa4LcyFyTsm+lApN6LukHBCv6IzJLuy98M3lWSswzqg0oRl2YSGU+IEFMxGFx4uZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB872716
X-Proofpoint-GUID: 4GCNeAoPvIFRlz4sxwoV-FMDka37GfiZ
X-Authority-Analysis: v=2.4 cv=UaJhjqSN c=1 sm=1 tr=0 ts=6a8e9752 cx=c_pps
 a=hro4gVXncoUBxB/Amc69HA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=mVmBt1QLOPhGqFDPXwUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 4GCNeAoPvIFRlz4sxwoV-FMDka37GfiZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX7e4Ath/7+GTJ
 pwQuQxdjfx7PzIR19da0jOJPFDOojIgNVHAYvhNDLzC8rODeRDVHCsnKxAfmRsO9jH9Du0KOUue
 NMknrBD3iyLPuTsrZtPDH1Lg9n8I/LPu2kqbNjuED7CzuXdMQCDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX/JaCVThqbDE1
 nCcsG1cfot0cV2Gh7CaDOhZaWFnUuvw301jsdmV0eZTvyDqn9f5AtTYlLhjmYpk9UTPjJcLa1GB
 8bcyu4txWf2Dc0fr53cFcNyfh8Qd5OD0SJU1qN0RYDaxRseKiwzZ2chgJs3Vnz5ANnxOa2WlZPd
 oaLXv9yZ5cipzBxuNk25z+CDCcTl0R7u7urxGAlq55aAMffCZ7ZxW1yD+cEIhXsgqdx9AFhrzL1
 zMJm7ptKjaFFaUgw69HEJ/hLdE7bFb8D5MsA5AM54yVzKNZ5suJ/6BYP59eptmaV5s5XG6mxPME
 4r1PsfFInOl0JJ1nvrXfnQjk70IelfJpW3NmIfUVi4Gl5oOc4GyxgezK9FHsJNWfYGL+pvkrKsh
 bAb9AwiMush+k7v6EW06iE8lZYUz8yDyFg2QSPXSkgE/j5LblqT1Rt+eJeNTjgJ8vT6/pEp3kw7
 PgwOxqJLr8REuChOoEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_003811_307202_47D841F9 
X-CRM114-Status: GOOD (  18.71  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

On x86 with CONFIG_CRASH_HOTPLUG=y and CONFIG_MEMORY_HOTPLUG=n, the
crash elfcorehdr segment is reserved for

    nr_mem_ranges + 2 + CONFIG_NR_CPUS_DEFAULT

program headers, while the header that crash_prepare_elf64_headers()
actually builds carries

    nr_mem_ranges + 2 + num_possible_cpus()

of them.  num_possible_cpus() is bounded by CONFIG_NR_CPUS, not by
CONFIG_NR_CPUS_DEFAULT, so on configs that raise CONFIG_NR_CPUS above
the arch default without MAXSMP the header outgrows its reservation once
the excess exceeds the page padding, and kexec_file_load(2) is rejected
by sanity_check_segment_list() with -EINVAL.

Patch 1 reserves the elfcorehdr for CONFIG_NR_CPUS, the compile-time
upper bound of num_possible_cpus(), so the reservation always covers the
header that is actually generated.  It also fixes the same shortfall in
arch_crash_get_elfcorehdr_size(), which feeds
/sys/kernel/crash_elfcorehdr_size and therefore the kexec_load(2) path.

Patch 2 is a documentation-only follow-up requested during v1 review: it
updates the two remaining places that still name NR_CPUS_DEFAULT when
describing the elfcorehdr sizing (the comment above
crash_handle_hotplug_event() and the CRASH_MAX_MEMORY_RANGES help text).

Based on linux-next (next-20260825, base-commit a8406e6c0b79b).

Verified on a single-socket Xeon 6776P running a PREEMPT_RT kernel with:

    # CONFIG_MAXSMP is not set
    # CONFIG_MEMORY_HOTPLUG is not set
    CONFIG_NR_CPUS_RANGE_BEGIN=2
    CONFIG_NR_CPUS_RANGE_END=512
    CONFIG_NR_CPUS_DEFAULT=64
    CONFIG_NR_CPUS=256
    CONFIG_CRASH_MAX_MEMORY_RANGES=8192

- 144 possible CPUs: excess is (144 - 64) * 56 = 4480 bytes, more than
  the 4096 bytes of page padding, so 'kexec -p -s' fails with
  "kexec_file_load failed: Invalid argument"
- 72 possible CPUs (reduced via firmware): excess is (72 - 64) * 56 =
  448 bytes, still absorbed by the page rounding, and the load succeeds

Changes since v2:
- No code changes.  The diff is byte-identical to v2; only the patch 1/2
  changelog and the collected tags differ.
- Patch 1/2: corrected the claim that kexec_load(2) is "unaffected".
  As Sourabh Jain pointed out, with crash hotplug enabled kexec-tools
  sizes the elfcorehdr segment from /sys/kernel/crash_elfcorehdr_size in
  load_crashdump_segments(), i.e. from arch_crash_get_elfcorehdr_size(),
  which uses the same CONFIG_NR_CPUS_DEFAULT; add_segment_phys_virt()
  then clamps bufsz to memsz.  So that path does not fail the load, it
  silently truncates the elfcorehdr, which shows up later as a bad dump.
  Switching arch_crash_get_elfcorehdr_size() to CONFIG_NR_CPUS - which
  this patch already did - fixes that path as well.  The changelog now
  says so instead of claiming immunity.
- Patch 1/2: picked up Reviewed-by from Sourabh Jain and Acked-by from
  Baoquan He.
- Patch 2/2: picked up Reviewed-by from Bradley Morgan.
- Both patches: added an Assisted-by: LLM trailer, per
  Documentation/process/coding-assistants.rst.  An LLM was used for the
  root cause analysis and the changelog wording; the bug itself was
  found and reproduced on real hardware, the fix was reviewed by me, and
  the Signed-off-by is mine.  This should have been present in v1 and
  v2, and was not - my oversight.
- Rebased from next-20260824 onto next-20260825.

The two further issues Sourabh raised on the v2 thread - the
add_segment_phys_virt() bufsz truncation in kexec-tools, and having
crash_load_segments() skip the kbuf.memsz update when the prepared
buffer is already larger than the statically computed size - are
deliberately left out of this series and are worth handling separately,
as he suggested.

On the num_possible_cpus() alternative raised by Jinjie in v1: it would
give a tighter reservation and powerpc's arch_crash_get_elfcorehdr_size()
already does exactly that.  I kept CONFIG_NR_CPUS here because it is the
minimal, easy-to-backport fix - it just swaps the wrong compile-time
constant for the correct compile-time upper bound.  I am happy to respin
with num_possible_cpus() if maintainers prefer that.

v1: https://lore.kernel.org/lkml/20260812170433.533845-1-ionut.nechita@windriver.com/
v2: https://lore.kernel.org/lkml/20260825075043.42041-1-ionut.nechita@windriver.com/

Ionut Nechita (2):
  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
    CONFIG_NR_CPUS_DEFAULT
  crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing
    docs

 arch/x86/kernel/crash.c | 6 +++---
 kernel/Kconfig.kexec    | 2 +-
 kernel/crash_core.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: a8406e6c0b793ce0788019683837c40855b55995
--
2.55.0


