Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625E7D6AB1A
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGsIBkyUHCmO18ofLLhnivCbbEo4ei3rblSIwaipQnE=; b=Oi+I6Dzo+JkN2eSlnETIRPwGia
	JRfKNwGiIVSDOQ2ZzIFfLf4lyvxOCnb9cvJFsLCmQWHc+dXNYisEMOqgExXBb7WYc9mX6yWC63g0n
	GnRjgc8fXteujfGHn5O9pIjYpacDLx6RJLKCVa3eXVZ90JAauaersh9eX46G6IrV/XVvsLxlI25/E
	Gpsq9JnF9U/LC9Zt3YDnZAY/HfjKTNBxK19Al3sR+4r4x2FJmLNraxtaznM0Or0iUIziXFr95DHOA
	vYn2vv+ZBs+5Y/rq7nzeKXs3hRDCjAXqYq3N8NqaMuN5jwnrVU5Ktxh8lhIdyvu+3ra0M7H80j3KU
	ApeR++pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8SDI-00000000y7E-47Ik;
	Fri, 03 Apr 2026 00:16:40 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8SDE-00000000y6t-1IH1
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 00:16:37 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Nt1LR3408690;
	Fri, 3 Apr 2026 00:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HGsIBkyUHCmO18ofLL
	hnivCbbEo4ei3rblSIwaipQnE=; b=IocygpdSyTm5/sF/E14lvAOZHnU1E1+8yW
	J3HemLK3utXtmfB2ok1o1o24mUPdy2kU1X8sEpoSbRRmRJUKs13S+pFPY6T/kTUQ
	F0yWQYbd6IGzMdf3jVv1/fZxjBPW0CUjshK6aeUUm17mlluCOdWnr10fBuy/ZvqB
	lU9neDX27ZgmszsRwfWNUImd4LC7PCDWf9XupLScVgfzXebxDGB2trWB9cNiRcvB
	F1GN+XHTsKR+tBPeBYtCXQHgk13o93s6kMYubeEwGl5Tl8+qkTvCJcEO4GQSs2Oa
	sdmF+kG7ZNG1dk+Xtbc5LPNmn5G+Ts6bL5H1tLvTIMSTYQaAbInA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66kr1cdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 00:16:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632LE7F1021139;
	Fri, 3 Apr 2026 00:16:32 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65edkjyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 00:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n74TLMtgZgF8BZ89HQUbunuzkyTZXh+r4QSwtIy8T7jpzZW6OnegwPUCRIwUokm9uOeXtE/8zhBRmbsvRt0sP7n7yeAA7bx+1p5ttjcOJ5SwBIlXnc4G+0FgHp2CEn9rxWGKlt8u/PN3RmpZoxaFrOCNnnbXWsFQ5bhQ3CeBszRw/wcXG8YNgZWEjx4aL3vW/OhU0bx9UBdHpSwYxEwTaLg2W62LTCrRkTZA5noVUcvXYvGR0h6wyV6zO6dJOEojlbndbsTtdDE3y2ikZdvJpXm+BIRZ9zl1cEb7oisF96VO++/AICtwOyhZtn5PsMQ2z/SiFmPhxwIuQ74Kk9wjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGsIBkyUHCmO18ofLLhnivCbbEo4ei3rblSIwaipQnE=;
 b=VsVDwfRmV09sUtGjfFMHMvVa/9PFE2uss+VV9LUvCJgoIi30TN62VJiSBnwUBgiYrsKsvkoXVpYDyVBzjZZCzacVBglmVmNHU0kLWUq9/BLERnfKZiTaawotQdS3ckyJnpaguVktK3D6iYnwlYBkfRaXfNNbRljQgIMbupxR3MVJs8ZSTfRqJlJy7S+/P83V37s37wUfp3/7xRvAw3GDdOmmnhGbH6C9mElv+j/LQtySI6+DBmU93faz6vARFQoZAS+DwmTgPd9lmKype//t+sFXawdsbu9xl5CiqH3ujvD3XHB09zqErgkvX+GFYH4bE171sZg4j/3xU3NMO41yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGsIBkyUHCmO18ofLLhnivCbbEo4ei3rblSIwaipQnE=;
 b=jS5UjeU+L+1tpeY3LaUufGyUODcHx6WMYPxtIs0Rgv4c9UxjSCfE0tkcF9xmNkltyfUiKycC7jOnxMVJtElwN7zjv/p4tSDWvVOqSbUBQWU68XtzhwM3Xjcm77cxdT8QToWsTbnsKBkbNM2icdWs2n2din47tPfIGYXZBsaHjcM=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA0PR10MB7325.namprd10.prod.outlook.com (2603:10b6:208:407::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 00:16:29 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 00:16:28 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 7/7] Filter amdgpu mm pages
In-Reply-To: <20260317150743.69590-8-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-8-ltao@redhat.com>
Date: Thu, 02 Apr 2026 17:16:27 -0700
Message-ID: <87o6k0ew4k.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA0PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4cc8c2-cae5-460c-bc54-08de9116402b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gLFZl8NMTs8lUybo86ACqtCHgEiI1hcvX+6NvxIht898MZdBIaExINpsskoNaY/memV+6kJ/4+RhgP/a2A92a/XgRqUF7Ey4QTjpKCjvlmLrFY6Qc/zD0zfNVRcBiy1oAoacDbit2cu8hgZ2CGTQigXY30MyDOyfE2OfS/OxC/YKJaBML9B+YVW9TQPLw2De3/L3ax6xZq2RpnG2HdmELr9lDa4qW5aeYy9RjRMoJ2rznUHwA3Ls52Svx0zNiVONkeu3ITi7K+KF/6wmwvbn05sMsMYlyqovTi1Y7al/xATSwUDB6J7GC2bVENLOFQh6IzzdWEXgOwCeDNU/ZfQ5KMX3mb2qcqskQrGKJFTHKVEkWyrKGMVOvjUOLBnFJHChGDMHYvgJ8E2rqtWRREFwvyQ9uJ9K0fnY8JqJoIZ5W1wD1HNAUUi5AAbzbS38FdQ5gSRB/i5Ab6w2HQPDgRTddtWy+DLSrBNMqqaSG+dJuKw6/ofKrfDhWdNe6cCcBGc4hnz/vLHQLTo4NVjVQZp9DKLb6NFvBbLJB5Zy3xgNCniDzuTS4arP4pK20pKqbcG7Kwsy4bzsgGsjxBDvY8vTG2b5d0k5dXxfApZYCNN0IZgDh5SYQexBZiOFZq/xuP7tShugK9EuZJ5BPsPSKcZrqcJZG0kxhPE8SMGMxVODUZow/XVRlK2tPLJ7N0fMD1kxotbZYxCVAs7LIpH2X//cBhoMu+qGxd2rW1utEbQo+Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?icKC2+qZPvB2wtU1Q2PfFJTpawlm2jf1hOi8H2l8QUv78iZtx7jyDPCIjyZe?=
 =?us-ascii?Q?dO7fxOtI+gicB4oFi7VdzsBf6YI7x3DUrV5b03/Djy+UA/q4FyQp7P8RKx4y?=
 =?us-ascii?Q?0hMVhrsVAIc6ScX33J7vK9jTiC2nl3Su6udFIFuxjo2UGtjOGTQ0ebMb0egt?=
 =?us-ascii?Q?JHihMJAo9rAUujxLdIua4UyAKdRNGGRUGDHSEm8iWM17cSoYKrVpcVpuAIGH?=
 =?us-ascii?Q?gHQBSHT0y6KjdaX6IqY1/jWDOk/pIwO5m6SbttxQK60E4R3yPy4XCit/PYya?=
 =?us-ascii?Q?8jwx66SIkfcNTNVF6j4CIXkL5nAeOX+j7cQZspmpOD+EQ8QY/BxfF4F8WxLK?=
 =?us-ascii?Q?j895m3vrhXV7w5aoZtEWVoTZjQg13UpUCoht6PWvWw0VaLAabCkWN7FvwWfr?=
 =?us-ascii?Q?NXur8hNpzyke3vd9tJxQ2b5u0agJuyg6OanSLQW9SpbY0ib6fGjUFJMzfxcd?=
 =?us-ascii?Q?4Cp8JgD+PYF9BCMC4CZJr1PMY6CcqkEgsIl0xkhxuEt0u/XKNxLA9It38Mu/?=
 =?us-ascii?Q?5wMtGmzjr+lVfcUTxeOalJYF46x8pRmk+u2eWgOHQIVbokCSR7H1cXOFU3vF?=
 =?us-ascii?Q?u9FkCs52wIF0XWlHSO3W4MHpoACDSzbND+v+CWqWxQmTBhu/0qSqcOAPfd8t?=
 =?us-ascii?Q?Yyfkvb4eET8mO+4SnAA6ScsMRWV6GKWjd/ds4nr7tGiAo9+Gu60QK8AJ6cJE?=
 =?us-ascii?Q?Yx0QvtWefN8rHBQiAWnxkwBq/zUWbP53uBxQxdpPT/5+QFsPeStWjWcBNpkk?=
 =?us-ascii?Q?dFniAQaJ47kzvhVpBH0Spe+dkQFv/SUj3KtndjwzlJuTiYDm4Q54bqte1MON?=
 =?us-ascii?Q?I0cUKBk+qD8vR54cnLyDoEFD+7y6cUOs1KklYebMbNsUM3qeq84umAosAV+X?=
 =?us-ascii?Q?JeI8VIWFZOrpc6d+SCIIgkqEgNshq30cqC3z1XPPpl65AF4q0KWSBfsaalP9?=
 =?us-ascii?Q?VBz6zSFVpttvNCVRkWYN1vzRQA3DJyzNupc0Bn7n3biIOIfXvuOy8TAq9P0K?=
 =?us-ascii?Q?LS0RljmTRiN0sRqle1W8i3+4G7MBQ3qou3Mvcc/FVI86hfd+jZz0InBD5s5+?=
 =?us-ascii?Q?sJvXW99JvCMmffB7JGI9GU2tXAYQH98wLuvtfATdz94A4Alyt5DAHqI7cz0H?=
 =?us-ascii?Q?qkHaJ/xGknYTgrL3zfVlPNQQ81v+OwcanWGU5N6nXu9C9QsQWpOPl3UMNyoB?=
 =?us-ascii?Q?2ZmMQ7Fp3e3baYP9D74OWswnzaGzhCcMVLmxjOrkI7TEqzNePOai2ajKyz49?=
 =?us-ascii?Q?ZW3PzdQnwSokb3c3oW501aE9YY9ONS987WBrksd2z+jgxb9CTxY4bJzcZ7NR?=
 =?us-ascii?Q?6FNL7xsgZTWgv+pGB6FrXX4tOiI2YvTpDvXkGOLKHCJKlNdmj0QPcdbkrSbP?=
 =?us-ascii?Q?nCDKdCBUMvBzVp2BPFm/DGZ+yHx6//fS7Rnlh2OlywOTR/FpawJTaUqfbzbR?=
 =?us-ascii?Q?XqCNJlNx8PMwLtSJhbZvhfN+vrIs8yyL0HlvMSWGZb0S+YksLmIghc6Oufb+?=
 =?us-ascii?Q?aWt7LBCLwIzsvOsdGoC8HN/BHqv8gPtH/sfvxrReI1jx3fPSsrylxkGOksfo?=
 =?us-ascii?Q?aEsiYYIZ2GsiW5s3asXtj8BoBRU6oR8FUy5yeaQ4C7gMVqDGyJ9CnUKLFhRn?=
 =?us-ascii?Q?IS61PizSPf1Ne2Jp1FWO4G8BY9LEVGGUZF2cUNLGYI+nAffxxthO8RcUdIa7?=
 =?us-ascii?Q?Nzk+sH2yRBzBjQCoADPLbKrA85zMbdhMi3HRFlr/iCWuMEhqyLg5VcHpfYDU?=
 =?us-ascii?Q?IiNAuotLq01L9PdUZS9SsN5o5BkyCEg=3D?=
X-Exchange-RoutingPolicyChecked: fiYe1lwvHPTicamazGljQOIiAVxYE4zlMTbgVrQOJksJwSypMRrM/44gUwor6Nu+h/0CjspAWwn737laky/1Gsi9LMDywCfCeIQde53YWxtELUaQ7VMdfsQUfcp41qo9olcHytvj9j7bVjfUwLzLSe+8GvUxelf2KIfxyPqgVrGCPMKWI54GULh73V7w0R9XmE9S8HTw+DHUteA55kYbepDAJuc66n5i3if+Pj9itgk9zoZJ/ncWRARVNIa1rLL/GBWKELdD3X6zFNMqPKqjtohQd7G1uRzI6XsZNDfru5pcZKRHwkzhyn3eplaxMcqgb8dwGt6rFg7pebql+/UIzw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qrhl1mnDqCOOZl6MD9OfWVijdiztLJy4TpzaOOHAfJ8pmzgnI6v2Q0pTwP/EJRZRqfp1AmJ/eB6B+kWZXEjvgPi8NImHDri6DsG2FPHmDxjutuT61mS9zEjspJQWquB+yyulJJEGiM3+bULq6te2FeJPIJbLJD/1/9pqwWLsg5wNnYq7ZTin/meNBlf5kCv1RvomydzQsGZYL5OOUFRfRVwasDc44Ia+fVPPFsYri5y867i4cP2s8AfkC+jy9nnyXtXea1+xscz41jqqyJfXJNKJ+7RHOujYFqGnSx2mgGlZEp8l4/x370hDmtrKQWqcsJHAwksowgYpAz1/CQ5sj2KRT0/Ye1Xx1O2UICM9GPw2ZfMeQSWE49I8TaU8cxnftQGplJEby1ASEYqGuMJ7fxJOS7SwiiuPQLKfrEBOsH372nDdSoI1ZZf/erY9xypwGMSeXz3OylB+QztiKXscRw2y4FTso79Kf3q/HO3vMomLDx62R6wsdq1HpCfUkDuo2JuPvfh/2Ln2gTxbfQBj2nnqqRgpc2lPHb3AXJp2HacrDUpRxxXOLzKT8pajgUs02ttxQsoPXtZzwv31PJgmJuTwlCFJIypVs8PD5uPYYoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4cc8c2-cae5-460c-bc54-08de9116402b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 00:16:28.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB2NNc4kzGL3GgX3dUv7wwhvXkaI7m4pHpMkTq+NLLyn+b9VFjWfS+1WXE8Y4C2ermv7cN362ZcPWE7oX9hXUqfwEAqDCJz+mdrxpGAGEps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604030000
X-Authority-Analysis: v=2.4 cv=PqaergM3 c=1 sm=1 tr=0 ts=69cf06e1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=WvygIjtJFpeTYWtQsQAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMCBTYWx0ZWRfXzChuIleifY5R
 QkCNiAc+smyrsMt0Tp2tAFM8BXVmdSN9UquaW7f6DcNljHrPezq1CbIPdpFDA/gF9+GaCEXe2iR
 p6z08lvH9xxGr0xsXFhjnWn3OdSCjzKO9tsv2z474rbxliP6z4+hoibL5SOrE33rVTe7jUVM1J9
 8c6QRNFm1nZ0N9/z05kRp1dttiH0UV2ZySVIBGPnGblWxrVaY24W53xW2DvQBkety8hDXpHgqXH
 BRm76hFaKP8oOwJhDbEUVLDqRPE6HraTfCcAsPsN+fFtsIl4eo/2Zyzshfkj4vyNSOsIf3odDmB
 Ay//SB2VUKbaDLcoBDRlMD24g9C+xAAqJmJetklWFJYtm7HWaF+406FCBEo/5fvAWRXH/l5tH04
 o8KsDw08ssuuTFlmVhr8AopjAzWqLu7um6pdEXltIcJ8eFZaTBg72Y5G3v1x33OLvXVnEj6FF6E
 W41EqMPOX9CkNZlMcwA==
X-Proofpoint-ORIG-GUID: n0qlQtpYmEkwqnt7VgbneauUCg1nwwhG
X-Proofpoint-GUID: n0qlQtpYmEkwqnt7VgbneauUCg1nwwhG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_171636_484178_87FFDD72 
X-CRM114-Status: GOOD (  22.47  )
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

> This patch will introduce maple_tree & amdgpu mm page filtering extension,
> those mm pages allocated to amdgpu will be discarded from vmcore, in order
> to shrink vmcore size since mm pages allocated to amdgpu are useless to kernel
> crash and may contain sensitive data.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  extensions/Makefile        |   4 +-
>  extensions/amdgpu_filter.c | 190 +++++++++++++++++++++++
>  extensions/maple_tree.c    | 307 +++++++++++++++++++++++++++++++++++++
>  extensions/maple_tree.h    |   6 +
>  4 files changed, 506 insertions(+), 1 deletion(-)
>  create mode 100644 extensions/amdgpu_filter.c
>  create mode 100644 extensions/maple_tree.c
>  create mode 100644 extensions/maple_tree.h
>
> diff --git a/extensions/Makefile b/extensions/Makefile
> index b8bbfbc..55b789b 100644
> --- a/extensions/Makefile
> +++ b/extensions/Makefile
> @@ -1,8 +1,10 @@
>  CC ?= gcc
> -CONTRIB_SO :=
> +CONTRIB_SO := amdgpu_filter.so
>  
>  all: $(CONTRIB_SO)
>  
> +amdgpu_filter.so: maple_tree.c
> +
>  $(CONTRIB_SO): %.so: %.c
>  	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
>  
> diff --git a/extensions/amdgpu_filter.c b/extensions/amdgpu_filter.c
> new file mode 100644
> index 0000000..3a1e9f2
> --- /dev/null
> +++ b/extensions/amdgpu_filter.c
> @@ -0,0 +1,190 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "maple_tree.h"
> +#include "../makedumpfile.h"
> +#include "../btf_info.h"
> +#include "../kallsyms.h"
> +#include "../extension.h"
> +
> +/*
> + * These syms/types are must-have for the extension.
> +*/
> +INIT_KERN_STRUCT_MEMBER(task_struct, tasks);
> +INIT_KERN_STRUCT_MEMBER(task_struct, mm);
> +INIT_KERN_STRUCT_MEMBER(mm_struct, mm_mt);
> +INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_ops);
> +INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_private_data);
> +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_buffer_object, ttm);
> +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, pages);
> +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, num_pages);
> +INIT_KERN_STRUCT(page);
> +
> +INIT_KERN_SYM(init_task);
> +INIT_KERN_SYM(vmemmap_base);
> +INIT_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
> +
> +struct ft_page_info {
> +	unsigned long pfn;
> +	unsigned long num;
> +	struct ft_page_info *next;
> +};
> +
> +static struct ft_page_info *ft_head_discard = NULL;
> +
> +static void update_filter_pages_info(unsigned long pfn, unsigned long num)
> +{
> +	struct ft_page_info *p, **ft_head;
> +	struct ft_page_info *new_p = malloc(sizeof(struct ft_page_info));
> +
> +	ft_head = &ft_head_discard;
> +
> +	if (!new_p) {
> +		fprintf(stderr, "%s: Can't allocate memory for ft_page_info\n",
> +			__func__);
> +		return;
> +	}
> +	new_p->pfn = pfn;
> +	new_p->num = num;
> +	new_p->next = NULL;
> +
> +	if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
> +		new_p->next = (*ft_head);
> +		(*ft_head) = new_p;
> +		return;
> +	}
> +
> +	p = (*ft_head);
> +	while (p->next != NULL && p->next->pfn < new_p->pfn) {
> +		p = p->next;
> +	}
> +
> +	new_p->next = p->next;
> +	p->next = new_p;
> +}
> +
> +static int filter_page(unsigned long pfn, struct ft_page_info **p)
> +{
> +	struct ft_page_info *ft_head = ft_head_discard;
> +
> +	if (ft_head == NULL)
> +		return PG_UNDECID;
> +
> +	if (*p == NULL)
> +		*p = ft_head;
> +
> +	/* The gap before 1st block */
> +	if (pfn >= 0 && pfn < ft_head->pfn)
> +		return PG_UNDECID;
> +
> +	/* Handle 1~(n-1) blocks and following gaps */
> +	while ((*p)->next) {
> +		if (pfn >= (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
> +			return PG_EXCLUDE; // hit the block
> +		if (pfn >= (*p)->pfn + (*p)->num && pfn < (*p)->next->pfn)
> +			return PG_UNDECID; // the gap after the block
> +		*p = (*p)->next;
> +	}
> +
> +	/* The last block and gap */
> +	if (pfn >= (*p)->pfn + (*p)->num)
> +		return PG_UNDECID;
> +	else
> +		return PG_EXCLUDE;
> +}
> +
> +static void do_cleanup(struct ft_page_info **ft_head)
> +{
> +	struct ft_page_info *p, *p_tmp;
> +
> +	for (p = *ft_head; p;) {
> +		p_tmp = p;
> +		p = p->next;
> +		free(p_tmp);
> +	}
> +	*ft_head = NULL;
> +}
> +
> +#define KERN_MEMBER_OFF(S, M) \
> +	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> +#define MOD_MEMBER_OFF(MOD, S, M) \
> +	GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
> +
> +static void gather_amdgpu_mm_range_info(void)
> +{
> +	uint64_t init_task, list, list_offset, amdgpu_gem_vm_ops;
> +	uint64_t mm, vm_ops, tbo, ttm, num_pages, pages, pfn, vmemmap_base;
> +	int array_len;
> +	unsigned long *array_out;
> +	init_task = GET_KERN_SYM(init_task);
> +	amdgpu_gem_vm_ops = GET_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
> +
> +	list = init_task + KERN_MEMBER_OFF(task_struct, tasks);
> +
> +	do {
> +		readmem(VADDR, list - KERN_MEMBER_OFF(task_struct, tasks) + 
> +				KERN_MEMBER_OFF(task_struct, mm),
> +			&mm, sizeof(uint64_t));
> +		if (!mm) {
> +			list = next_list(list);
> +			continue;
> +		}
> +
> +		array_out = mt_dump(mm + KERN_MEMBER_OFF(mm_struct, mm_mt), &array_len);
> +		if (!array_out)
> +			return;
> +
> +		for (int i = 0; i < array_len; i++) {
> +			num_pages = 0;
> +			readmem(VADDR, array_out[i] + KERN_MEMBER_OFF(vm_area_struct, vm_ops),
> +				&vm_ops, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_ops));
> +			if (vm_ops == amdgpu_gem_vm_ops) {
> +				readmem(VADDR, array_out[i] +
> +					KERN_MEMBER_OFF(vm_area_struct, vm_private_data),
> +					&tbo, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_private_data));
> +				readmem(VADDR, tbo + MOD_MEMBER_OFF(amdgpu, ttm_buffer_object, ttm),
> +					&ttm, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_buffer_object, ttm));
> +				if (ttm) {
> +					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, num_pages),
> +						&num_pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, num_pages));
> +					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, pages),
> +						&pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, pages));

Are these pages guaranteed to be contiguous?
If not, you're applying the page filter rule based on just the first
element of the pages array.
If they are guaranteed contiguous, maybe a comment would be helpful?

Thanks,
Stephen

> +					readmem(VADDR, pages, &pages, sizeof(unsigned long));
> +					readmem(VADDR, GET_KERN_SYM(vmemmap_base),
> +						&vmemmap_base, sizeof(unsigned long));
> +					pfn = (pages - vmemmap_base) / GET_KERN_STRUCT_SSIZE(page);
> +					update_filter_pages_info(pfn, num_pages);
> +				}
> +			}
> +		}
> +
> +		free(array_out);
> +		list = next_list(list);
> +	} while (list != init_task + KERN_MEMBER_OFF(task_struct, tasks));
> +
> +	return;
> +}
> +
> +/* Extension callback when makedumpfile do page filtering */
> +int extension_callback(unsigned long pfn, const void *pcache)
> +{
> +	struct ft_page_info *cur = NULL;
> +
> +	return filter_page(pfn, &cur);
> +}
> +
> +/* Entry of extension */
> +void extension_init(void)
> +{
> +	if (!maple_init()) {
> +		goto out;
> +	}
> +	gather_amdgpu_mm_range_info();
> +out:
> +	return;
> +}
> +
> +__attribute__((destructor))
> +void extension_cleanup(void)
> +{
> +	do_cleanup(&ft_head_discard);
> +}
> diff --git a/extensions/maple_tree.c b/extensions/maple_tree.c
> new file mode 100644
> index 0000000..e367940
> --- /dev/null
> +++ b/extensions/maple_tree.c
> @@ -0,0 +1,307 @@
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include "../btf_info.h"
> +#include "../kallsyms.h"
> +#include "../makedumpfile.h"
> +
> +static unsigned char mt_slots[4] = {0};
> +static unsigned char mt_pivots[4] = {0};
> +static unsigned long mt_max[4] = {0};
> +
> +INIT_OPT_KERN_SYM(mt_slots);
> +INIT_OPT_KERN_SYM(mt_pivots);
> +
> +INIT_OPT_KERN_STRUCT(maple_tree);
> +INIT_OPT_KERN_STRUCT(maple_node);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_tree, ma_root);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, ma64);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, mr64);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, slot);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, pivot);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, slot);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, pivot);
> +INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, slot);
> +
> +#define MEMBER_OFF(S, M) \
> +	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> +
> +#define MAPLE_BUFSIZE			512
> +
> +enum {
> +	maple_dense_enum,
> +	maple_leaf_64_enum,
> +	maple_range_64_enum,
> +	maple_arange_64_enum,
> +};
> +
> +#define MAPLE_NODE_MASK			255UL
> +#define MAPLE_NODE_TYPE_MASK		0x0F
> +#define MAPLE_NODE_TYPE_SHIFT		0x03
> +#define XA_ZERO_ENTRY			xa_mk_internal(257)
> +
> +static unsigned long xa_mk_internal(unsigned long v)
> +{
> +	return (v << 2) | 2;
> +}
> +
> +static bool xa_is_internal(unsigned long entry)
> +{
> +	return (entry & 3) == 2;
> +}
> +
> +static bool xa_is_node(unsigned long entry)
> +{
> +	return xa_is_internal(entry) && entry > 4096;
> +}
> +
> +static bool xa_is_value(unsigned long entry)
> +{
> +	return entry & 1;
> +}
> +
> +static bool xa_is_zero(unsigned long entry)
> +{
> +	return entry == XA_ZERO_ENTRY;
> +}
> +
> +static unsigned long xa_to_internal(unsigned long entry)
> +{
> +	return entry >> 2;
> +}
> +
> +static unsigned long xa_to_value(unsigned long entry)
> +{
> +	return entry >> 1;
> +}
> +
> +static unsigned long mte_to_node(unsigned long entry)
> +{
> +        return entry & ~MAPLE_NODE_MASK;
> +}
> +
> +static unsigned long mte_node_type(unsigned long maple_enode_entry)
> +{
> +	return (maple_enode_entry >> MAPLE_NODE_TYPE_SHIFT) &
> +		MAPLE_NODE_TYPE_MASK;
> +}
> +
> +static unsigned long mt_slot(void **slots, unsigned char offset)
> +{
> +       return (unsigned long)slots[offset];
> +}
> +
> +static bool ma_is_leaf(unsigned long type)
> +{
> +	return type < maple_range_64_enum;
> +}
> +
> +static bool mte_is_leaf(unsigned long maple_enode_entry)
> +{
> +       return ma_is_leaf(mte_node_type(maple_enode_entry));
> +}
> +
> +static void mt_dump_entry(unsigned long entry, unsigned long min,
> +			unsigned long max, unsigned int depth,
> +			unsigned long **array_out, int *array_len,
> +			int *array_cap)
> +{
> +	if (entry == 0)
> +		return;
> +
> +	add_to_arr((void ***)array_out, array_len, array_cap, (void *)entry);
> +}
> +
> +static void mt_dump_node(unsigned long entry, unsigned long min,
> +			unsigned long max, unsigned int depth,
> +			unsigned long **array_out, int *array_len,
> +			int *array_cap);
> +
> +static void mt_dump_range64(unsigned long entry, unsigned long min,
> +			unsigned long max, unsigned int depth,
> +			unsigned long **array_out, int *array_len,
> +			int *array_cap)
> +{
> +	unsigned long maple_node_m_node = mte_to_node(entry);
> +	char node_buf[MAPLE_BUFSIZE];
> +	bool leaf = mte_is_leaf(entry);
> +	unsigned long first = min, last;
> +	int i;
> +	char *mr64_buf;
> +
> +	readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
> +	mr64_buf = node_buf + MEMBER_OFF(maple_node, mr64);
> +
> +	for (i = 0; i < mt_slots[maple_range_64_enum]; i++) {
> +		last = max;
> +
> +		if (i < (mt_slots[maple_range_64_enum] - 1))
> +			last = ULONG(mr64_buf + MEMBER_OFF(maple_range_64, pivot) +
> +				     sizeof(ulong) * i);
> +
> +		else if (!VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, slot) +
> +			  sizeof(void *) * i) &&
> +			 max != mt_max[mte_node_type(entry)])
> +			break;
> +		if (last == 0 && i > 0)
> +			break;
> +		if (leaf)
> +			mt_dump_entry(mt_slot((void **)(mr64_buf +
> +						      MEMBER_OFF(maple_range_64, slot)), i),
> +				first, last, depth + 1, array_out, array_len, array_cap);
> +		else if (VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, slot) +
> +				  sizeof(void *) * i)) {
> +			mt_dump_node(mt_slot((void **)(mr64_buf +
> +						     MEMBER_OFF(maple_range_64, slot)), i),
> +				first, last, depth + 1, array_out, array_len, array_cap);
> +		}
> +
> +		if (last == max)
> +			break;
> +		if (last > max) {
> +			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
> +				mr64_buf, last, max, i);
> +			break;
> +		}
> +		first = last + 1;
> +	}
> +}
> +
> +static void mt_dump_arange64(unsigned long entry, unsigned long min,
> +			unsigned long max, unsigned int depth,
> +			unsigned long **array_out, int *array_len,
> +			int *array_cap)
> +{
> +	unsigned long maple_node_m_node = mte_to_node(entry);
> +	char node_buf[MAPLE_BUFSIZE];
> +	unsigned long first = min, last;
> +	int i;
> +	char *ma64_buf;
> +
> +	readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
> +	ma64_buf = node_buf + MEMBER_OFF(maple_node, ma64);
> +
> +	for (i = 0; i < mt_slots[maple_arange_64_enum]; i++) {
> +		last = max;
> +
> +		if (i < (mt_slots[maple_arange_64_enum] - 1))
> +			last = ULONG(ma64_buf + MEMBER_OFF(maple_arange_64, pivot) +
> +				     sizeof(void *) * i);
> +		else if (!VOID_PTR(ma64_buf + MEMBER_OFF(maple_arange_64, slot) +
> +				   sizeof(void *) * i))
> +			break;
> +		if (last == 0 && i > 0)
> +			break;
> +
> +		if (ULONG(ma64_buf + MEMBER_OFF(maple_arange_64, slot) + sizeof(void *) * i))
> +			mt_dump_node(mt_slot((void **)(ma64_buf +
> +						      MEMBER_OFF(maple_arange_64, slot)), i),
> +				first, last, depth + 1, array_out, array_len, array_cap);
> +
> +		if (last == max)
> +			break;
> +		if (last > max) {
> +			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
> +				ma64_buf, last, max, i);
> +			break;
> +		}
> +		first = last + 1;
> +	}
> +}
> +
> +static void mt_dump_node(unsigned long entry, unsigned long min,
> +			unsigned long max, unsigned int depth,
> +			unsigned long **array_out, int *array_len,
> +			int *array_cap)
> +{
> +	unsigned long maple_node = mte_to_node(entry);
> +	unsigned long type = mte_node_type(entry);
> +	int i;
> +	char node_buf[MAPLE_BUFSIZE];
> +
> +	readmem(VADDR, maple_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
> +
> +	switch (type) {
> +	case maple_dense_enum:
> +		for (i = 0; i < mt_slots[maple_dense_enum]; i++) {
> +			if (min + i > max)
> +				printf("OUT OF RANGE: ");
> +			mt_dump_entry(mt_slot((void **)(node_buf + MEMBER_OFF(maple_node, slot)), i),
> +				min + i, min + i, depth, array_out, array_len, array_cap);
> +		}
> +		break;
> +	case maple_leaf_64_enum:
> +	case maple_range_64_enum:
> +		mt_dump_range64(entry, min, max, depth, array_out, array_len, array_cap);
> +		break;
> +	case maple_arange_64_enum:
> +		mt_dump_arange64(entry, min, max, depth, array_out, array_len, array_cap);
> +		break;
> +	default:
> +		printf(" UNKNOWN TYPE\n");
> +	}	
> +}
> +
> +unsigned long *mt_dump(unsigned long mt, int *array_len)
> +{
> +	char tree_buf[MAPLE_BUFSIZE];
> +	unsigned long entry;
> +	unsigned long *array_out = NULL;
> +	int array_cap = 0;
> +	*array_len = 0;
> +
> +	readmem(VADDR, mt, tree_buf, GET_KERN_STRUCT_SSIZE(maple_tree));
> +	entry = ULONG(tree_buf + MEMBER_OFF(maple_tree, ma_root));
> +
> +	if (xa_is_node(entry))
> +		mt_dump_node(entry, 0, mt_max[mte_node_type(entry)], 0,
> +				&array_out, array_len, &array_cap);
> +	else if (entry)
> +		mt_dump_entry(entry, 0, 0, 0, &array_out, array_len, &array_cap);
> +	else
> +		printf("(empty)\n");
> +
> +	return array_out;
> +}
> +
> +bool maple_init(void)
> +{
> +	unsigned long mt_slots_ptr;
> +	unsigned long mt_pivots_ptr;
> +
> +	if (!KERN_SYM_EXIST(mt_slots) ||
> +	    !KERN_SYM_EXIST(mt_pivots) ||
> +	    !KERN_STRUCT_EXIST(maple_tree) ||
> +	    !KERN_STRUCT_EXIST(maple_node) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_tree, ma_root) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_node, ma64) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_node, mr64) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_node, slot) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, pivot) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, slot) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, pivot) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, slot)) {
> +		printf("%s: Missing required maple tree syms/types\n",
> +			__func__);
> +		return false;
> +	}
> +
> +	mt_slots_ptr = GET_KERN_SYM(mt_slots);
> +	mt_pivots_ptr = GET_KERN_SYM(mt_pivots);
> +
> +	if (GET_KERN_STRUCT_SSIZE(maple_tree) > MAPLE_BUFSIZE ||
> +	    GET_KERN_STRUCT_SSIZE(maple_node) > MAPLE_BUFSIZE) {
> +		printf("%s: MAPLE_BUFSIZE should be larger than maple_node/tree struct\n",
> +			__func__);
> +		return false;
> +	}
> +
> +	readmem(VADDR, mt_slots_ptr, mt_slots, sizeof(mt_slots));
> +	readmem(VADDR, mt_pivots_ptr, mt_pivots, sizeof(mt_pivots));
> +
> +	mt_max[maple_dense_enum]           = mt_slots[maple_dense_enum];
> +	mt_max[maple_leaf_64_enum]         = ULONG_MAX;
> +	mt_max[maple_range_64_enum]        = ULONG_MAX;
> +	mt_max[maple_arange_64_enum]       = ULONG_MAX;
> +
> +	return true;
> +}
> \ No newline at end of file
> diff --git a/extensions/maple_tree.h b/extensions/maple_tree.h
> new file mode 100644
> index 0000000..c96624c
> --- /dev/null
> +++ b/extensions/maple_tree.h
> @@ -0,0 +1,6 @@
> +#ifndef _MAPLE_TREE_H
> +#define _MAPLE_TREE_H
> +#include <stdbool.h>
> +unsigned long *mt_dump(unsigned long mt, int *array_len);
> +bool maple_init(void);
> +#endif /* _MAPLE_TREE_H */
> \ No newline at end of file
> -- 
> 2.47.0

