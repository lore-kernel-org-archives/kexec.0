Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39992C61DC7
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b306KNw8I7V/iCqeI+v055BscVd4lNuX80J6Cg2veoA=; b=z8zTHm3OF9jdqgrjP3xrkm4IB0
	cI5jcXyfYbsDzRKY0BmleIDEALxoqXilnuPW+QyPmPH4ANAn9A/37Deq+Cx0oAynLWPReARhGiaRB
	MoWP5eNzP7BiVGTSlN4+J+KLyBBOMF/94t31JPEN6kUzGyR4Gn7evRXzd8KMSgyexed8Hrg+k4oLx
	hRHBsD0zRxVU24Joo6aVALr/W3K/CI1LkMuOnWShF5/kArO+xS1Bf4lQ7KYTFd4pLpDRzrAO0xl/P
	fYuWYoXxFBCW8uHOL2OsqUmT0QM0HF5fXX6EjVq/RoW8zP7cDQ8P9xSWFF6aunp6h3W7J+tK6NcwK
	t08BDYjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8DF-000000021J7-15o4;
	Wed, 26 Aug 2026 07:38:21 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8D4-000000021H2-2T6d
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 07:38:14 +0000
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6SNku2870396;
	Wed, 26 Aug 2026 07:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=b306KNw8I7V/iCqeI+v055BscVd4lNuX80J6Cg2veoA=; b=
	TzOcySAZftNtTgpjaGDoG0zqEoRe9TP2n9RDhaKjzlp3MDUfAwkmIOdtmofzdbOC
	YMkE4YYN5XwJPZHstiMn10R0xBSuYng01REWQ+2yvLhwdEZOWFmRfGRraOjchKZq
	aIQJkFaoP/K2Lx10FMXd5ec/5yhtAW2PUKjO+kSd5tbtYt71kv4UvJw9Z4f2bZoG
	ZsOHEK3hPXVoknT/2h4nsgjpAA/A/BEcaKfM4dRNVgayzN5QyuA7EXCuPfPNsZby
	FDAYE/2Wwq413PypjZ4/uQpxHDLk3IhPfSLfyemeplzQNKOMVrEcit0uuzp7PAYB
	6CKZXVEUtkiNijTYTLLC3Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020139.outbound.protection.outlook.com [40.93.198.139])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g72r6x59j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 07:35:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDZrcgci7ZPHrcYJZaCe/2ZnZv7hXMjmSbCr+6Zsl2DnW3glmtmA+CHPcmt6TGiaq55a1eky7ymnkx5wdzYLvRoa8poRfJIbmQMn6jiREzX3L5uAIB8pRJH3eI82u1emvQekRqDz03AknhYIzDAoZgOjWNTkVWN0X4PPV3WtVbU+KAh6O9256XwAgpmdjsgk8cSVXw5kY2vf44wwC4CQQ28e2g4JuRQomy5v+s5C7JjSMGtmoFfQgmAiWSdQ+1DsyDKRZavcW2rGOlqBN+pxAAexDINCL+irslxXMc7zYWItvwZNL5N612gwDxjUjpRI2PTxihfCYekY7P/WfMCHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b306KNw8I7V/iCqeI+v055BscVd4lNuX80J6Cg2veoA=;
 b=x9pLKhGRKbkjD/N2/T1b09KmCt5QfQp2kvUXNW/OttaZUxl1gEzmqekd+NmpWppaQV59QWENstPn8u1MPhYd0VsExppuAg1WFUkOBcq9awzDtC1Z4fYTgfFYr0PfH9IdD0P4F4EdZm/BGLtfesHbYcGbxq5iX7/1mw/WfG1WlbWJFZZMQ1lyCQNVZhH2SGN7RtnT3cLl4NwirAq6zaCjit91ED/RxAc4y9gkCx87MQybD4YKRJ7BPTE5Nxc/FSKwi1ZUcb5EuoEgLwCujvq9mv1S50Cs2wjek71dfo4GJTX8sl8QvkqY+3z6j6Uk0kshDmR9PDeNzTroUnggJY4A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 07:35:53 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 07:35:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing docs
Date: Wed, 26 Aug 2026 10:35:27 +0300
Message-ID: <20260826073527.21487-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826073527.21487-1-ionut.nechita@windriver.com>
References: <20260826073527.21487-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PR11MB872716:EE_
X-MS-Office365-Filtering-Correlation-Id: 2093dcd6-fa68-42a0-c91f-08df0344a8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|10070799003|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L3jfKvOluvq9RnXgIOxP1lS7/Nnh5FfVeWJ0G+jR//4zlZwaAKI14lE2VIjdtV88RIcR+yi7NgOPwjuPjFT/35QBvT0+kSzGFmaDpQtoVpTvYlde7VPFQPdB4dAptG4lSjqZfK8OZVJpzKSuJLpRsj3bznx/9Lr+QJqQASUAaUwFq7+wwJPeD43fgr34BI0wUhGwTXNDqdN2uj/Q6wMSqEoCrY2BhtQ7jsPBljPuHCiPBgVxJD14tywEMi1j8l2LdWQcbYc8rIGZzc6vtu0v7fYG3iuOEBeMc0Ve9sEJNSIdCprt1MgcrMZj+fL+KriuIqQ2enUXWEWArfwNGAbpP3w3Z52aXNE2CBeMw+oQYpgpTFU3MYoBll9PRgytVHdCp2gmDwXJOks/mQNguTLGao5bkGuzVLDSidhvqC69pQKXCsX94NbaeCxVOMBbwQpL2hlTFhJMSD8nQJxYIFdGYnYwCA0PXMpA5OUbm4z/eS+pfZWWkkJUU9HDxjqX+U2K4XPVQKfWSfrPREsqQ2vPoeAZCU13IaWdv+ruHPRsdsNow39TMdCJETjs8sXgunX8pmE3NIF6ceFULg3i6ek9qWvL3tXC5t6/0NU5P18Klubf2P05QATTy/wCHWBB8UHbJtDAPPECBreAH4UsLQES3qXyl/KZGOT5tyQ9Oo+BniI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(10070799003)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jp544GYg50wfAMc9if7/y7nvDEvoYIF8v3IUkTFJDuNP17/1rAAlDC9u65GN?=
 =?us-ascii?Q?bZY3SEYh89NEoUih4tmreqrpXcUfZMOhtn1eaeZubPhG/Je7z9L444I3xwOM?=
 =?us-ascii?Q?CFah/omMRpZGJV0DZ5QDmpE+T0/4udgBLa9YSYMuHc9c/MoaCoPGlyKEDLHp?=
 =?us-ascii?Q?/sI3W8uE2/03bFxHoYSBWfK6SwK1j1Yk1G4JALY7biWa4mWKQzHaEK7qpbus?=
 =?us-ascii?Q?UgNs6oPkITlyVpsXrB44Npee8JYY4BhVS1W4IegpWichhsIpM5kq78vNsdep?=
 =?us-ascii?Q?Swb3dqbaZ24fvmQ2aYkfIPwijZ+xAxeJIepslMcvc25q9X9yFLRj81MGmjMf?=
 =?us-ascii?Q?H4FOxmfvGQ4vrkQD75APWPWhjhXG2uLSMx/FEC3TMVv/M+meC6EWup3jEGUb?=
 =?us-ascii?Q?pjbatkhMMkNAcZSeHczDhus7YoyAQ6b2ATqvJiO+MEGLvXHGs8qCDCNbtrAK?=
 =?us-ascii?Q?ubOlrNJjrRo/WF+C4yDaZSlLRVWhLZbZ2Dt8oLhdsPiN4zzLjQWJfH8+tqo8?=
 =?us-ascii?Q?rDgqiXccbfeo0d7G4xyRjfjlfcakRzXZDOtaPjvNOlh+3w0aNXqfPjTIm8Zw?=
 =?us-ascii?Q?eL5T6woeBDRls1qbzEEug78eneDibPpF8PcOLwUOIKWgUgQcNW++XepAsK1l?=
 =?us-ascii?Q?sG+CX71queRe0xipIKJIBthpkDFmzUogBo1QavuE8usFFp67nXk0TBX/WlMp?=
 =?us-ascii?Q?LSG6zTKHzZsdAli0TotZxH6HSrhtGEWGMIPiD9Zf/a4E3Xs6ntTLhHSVgj2b?=
 =?us-ascii?Q?rkJnehBww/CURiq45PkB6PQ4DTTRjo6G8OkvIae2DNqGNtuD6v9ubQayDME5?=
 =?us-ascii?Q?DZNxbANrC1i3JLkVUcNUhgwAaEp2wlVcb4W0YhMrfkZEeiNbnVmjRvWKv+QO?=
 =?us-ascii?Q?irZj1byil6I/G7aLPTBBLrfHTkXtLhnUOvZDZH4D2yOLE29mjl5YKkQmjpOn?=
 =?us-ascii?Q?sv9ywN/8N3X8K2U5xialQusBnO9unjPj85omwyARXrcrWkuWVlLhnj9jW3m7?=
 =?us-ascii?Q?NLJHJh0AZ05HUkPc/kf7yZWKAbOaggqn/cPG2gAGouYP0QeWMO3l+0HZbdBR?=
 =?us-ascii?Q?dODHZlvfJyVT4UQeZzFKRAdOqStzEhNHxgOSRUsATQBjbK0IBSTX4ozA7LbL?=
 =?us-ascii?Q?hrQtmrxAVHFexqSWKRwdmKDDXFcSsshwgrV8c+LZOnXRFtbA1Bk/VylMCA+C?=
 =?us-ascii?Q?SSkJZX6buVBo7wZkye9ZbriQ13gZHPABqK00/BO0twUdDLlx8VOQOTzl5Meg?=
 =?us-ascii?Q?oNwOGPA0Hfq/oP0bRjd3MovVPyzKf519w2maZsHjOnqNx3m2gn/6oGTxw9Gl?=
 =?us-ascii?Q?MGHELOCJc9YyNaoVwErvs8KB2sLWwlSu01iOEd8ajYv1+Pf1RpmqvIZKMquk?=
 =?us-ascii?Q?HQltFQDTIJ6lUi+uVNxvYF5pm1tCPDImmuC5iqji7BqEwoP808Oyu1Er4r5m?=
 =?us-ascii?Q?laWFGNnf0MYFJzYCm5p2zMthWMkqJb3ETMHuuLdYN7ZAfCvX2D9yagBoqNN4?=
 =?us-ascii?Q?VWkDDs2+fsagRoSLPDVc3gHcxH19T/PZL+FdLLFPBikZUGn9oXwqkXIMAX5C?=
 =?us-ascii?Q?l7xOmT8KjLxmkiV68jua21ajAURRJ2/eoo8MRlAuf3LHx4mIosooOUF8CB+m?=
 =?us-ascii?Q?4MCsgtVVIWlH9hf91/Lov504N4896NrvJNJlNHjXY+xay9pJD5apPBHlCMxC?=
 =?us-ascii?Q?uq/rGQPNyJzvJLcVf3nF7rsq2FmJtmaEapN8jKZAOg8QkSRxZiYiNrm2/71O?=
 =?us-ascii?Q?AGec6KGqbUZDssIExjJ0bNArNdLmfvQE5B6NEgdP8WTxV5gkz+nb+5uCuXm3?=
X-MS-Exchange-AntiSpam-MessageData-1: I5QOzwKC/EnlnxT4/34nrRpQKf8N4lcKgwU=
X-Exchange-RoutingPolicyChecked: EPfBv+tp/ZQMH7EuN6ac9K/zAnVMWTCHGaEcz0U1t7kBtwert7Qr40w8hV8EQMOr4iRq43eWfy4xNyjzNmQitKO0bk3hl/47t365ATuMHp0ve6r0ELYZYNTGZ1THNrzLcoZPzIWTx6tlv8DWL+HKpJ3iDj+NqdONZqOoj1a87zntkeqJOnoBRAH3Sukx9WNjClp4f5HI0YPECdSyE2sODZy1S1RBzPkzcZtN/6bRfcB/ANPug55TKo6adWGTlc35Yf6EhoQcAtk6HbhPO1ZwX1Obk1PxOx0mHNF+p34XHs3zblQto46kva0qvzZUYrjhxL7Mo7zrA7qZD7ZGFP8EvQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2093dcd6-fa68-42a0-c91f-08df0344a8c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:35:53.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRPNUG7S6xo63gD51k9kJv0PFauttFZywik3N2XgNTFAQyZ/LCTirMUVOukMbMNRdij1kaiZcD5qDKheLwl996OOIvI5XIQUZ3aq085s0Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB872716
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX0kfPBQ3A3vMT
 uMH5oqRcXsZ6ZyqQOOFlLZw/NK13KW8mZl/JLkbdg9Q+uLC8lMX5vGkOqrmjaP/r6dSUC2YAHoN
 QT7hZ+mLgFHrvdZpOClEvK5jO+HQ2bC+LYDwG5GAh/YnIram/aOP
X-Proofpoint-ORIG-GUID: pwbI4Flidt0W4fVFKczE_Ad6H3wXfh55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX5w0SEtsHGkSG
 TYDSxt2rjDyKW/xEM+FjqKs2VkQZ8kpLpF7dNRML1aE7aaWj1G2jMzkbgRRYB1tunav2XPsDpJO
 tHqMzq825xOzTjBulGNgM4n6zxblGhF8E5xK0lAuTRKWKSd2XqnkYoEZCai7q5GOcV/rOarbvfD
 GRA140SXDuRbfvCIlMTc/GpOQXiAL/aI7C/fwcXsW4Sqd9bJvm9K1WAt1qmG06D1Bgrrh996PJZ
 Vvjak0cMEkEsjbpaXyoILE/VwXAYTLTZDCdbVsVlgyZjhPNAjqmrzMascdsj0bDXvSNufYrc2YQ
 UgFlZtXOeKJ3fX2SrpzkCUP6nXz/3etD2dGXtFvjsmaKPP4W2q1sNSpfu15UL1TjQMah5mu7vgA
 2VRwLiXld+d2bnz0hvSFQFuNxwte9jlfKpkk9RzIi05MInBAU14S/0rLrv1HNFJfLxWf0CAUaw5
 BLK9VJMlv+wrPp+qggg==
X-Proofpoint-GUID: pwbI4Flidt0W4fVFKczE_Ad6H3wXfh55
X-Authority-Analysis: v=2.4 cv=RLiD2Yi+ c=1 sm=1 tr=0 ts=6a8e975b cx=c_pps
 a=dNw5gGrGfw7lLk+3QxxirQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=AyFJ6eo5uNYZnhLCzmoA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_003811_387778_4028E5C9 
X-CRM114-Status: GOOD (  14.53  )
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

The elfcorehdr over-allocation for crash hotplug is now computed from
CONFIG_NR_CPUS rather than CONFIG_NR_CPUS_DEFAULT, but two pieces of
documentation still name the old symbol: the comment above
crash_handle_hotplug_event() and the CRASH_MAX_MEMORY_RANGES help text.

Update both so they describe what the code actually does and do not
mislead people sizing CRASH_MAX_MEMORY_RANGES.

Documentation only, no functional change.

Suggested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Bradley Morgan <include@grrlz.net>
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 kernel/Kconfig.kexec | 2 +-
 kernel/crash_core.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..a97ed9605602 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -167,7 +167,7 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory regions that the elfcorehdr buffer/segment can accommodate.
 	  These regions are obtained via walk_system_ram_res(); eg. the
 	  'System RAM' entries in /proc/iomem.
-	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  This value is combined with NR_CPUS and multiplied by
 	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
 	  segment size.
 	  The value 8192, for example, covers a (sparsely populated) 1TiB system
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..d0bd2d0cf899 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -648,7 +648,7 @@ int crash_check_hotplug_support(void)
  * new list of CPUs and memory. To make changes to the elfcorehdr, it
  * should be large enough to permit a growing number of CPU and Memory
  * resources. One can estimate the elfcorehdr memory size based on
- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
  * excluded from SHA verification by default if the architecture
  * supports crash hotplug.
  */
-- 
2.55.0


