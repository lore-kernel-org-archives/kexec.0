Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E3EC4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uMXqg0VOt6r/U5obYGh5gTi2WWAOuzWtVjHtF0bPnaU=; b=bng9ua89Xn+JSg
	E9fAgSMjfxT208OenfLXp5cix9H6eRi9bKSTniU490Rn8skU9I1k1p4LZQWY692spzpKJgN4uZd89
	f/txABhkRcu/Ldujj2hf4ld10Q/gPEJjhRrLzxtwmbxDwW1ErqEs/WDpGwipCS9C9FI/0vVOpI+V4
	ymwmQmANZ8nqQYyEYtZnFTrFDwEjrAc6bDfLuYPFxZywjWm8bRXzAzXZiG1+doElFzef8TTE0nq0h
	ImwQX1zrCYYNEnspz28k0AxWNRghu7uOzMubPLMHDyez/i36OQbOfZ7Ms57s5WXGVjl4Wo5fGAl/j
	Z4xhSSjvVtHtt0GQFMQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxm-000jZA-M4; Thu, 20 Oct 2022 17:04:10 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxh-000jVV-Nn
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:07 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwtlA015167
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GE8TisN5G1MiBI7KSrzZd9kzb4fLy9ewz81CijiOH78=;
 b=TjAqPg5IvZsTh2mWgw1Gx05OGs2oTwEgXW6u23srxvUZzKfcuSXxXJ/Gl6pd2CB+s/NM
 XOCSK9a0lwCPkIUshC1e24y76cJiw62lJ2nUH1R6xFVrSdvFTfPp6Qu2bPDtGP2A1gZ/
 V+G+CsyiXo3tPPPdlrzzpkDlPGeyh2OcHCRhRi0VY8SsOHtNiMe1Exx7NkO5RiSb97mo
 pX9VWaGebCOizwj0RpamrItcE4bhz+SxgE3DUG7PSVWQC4bqEmNOPCfFbCZs3Y6l2rkK
 TELnhGX+RPpZ9uBmNeFp/NnKAp95Z8XTkl8B+ss8SEuGYcQekvkOfjQzjzdZffSqXQUI cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu065qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFN3AL027408
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjs0ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erchd2aHli7NdQuy0pBcK7v0Qqn13R5hzNQx8po+AhB4AhLwhEChJXBrCm1fN1CL3mvsinTuvaPn65lelFB8aamDG3PGzjNbVzFCF7iiTtYvksK8IszeNDSmeexxuFBR70oE/VjmXL0y1FzjjUcXnPKWJD5ZH5DiB6QRqRNVTDbWdQO9XkqtCOoGPaeGzQt7mlU8noRFzrq480jXgQyFrvUmP3rvSoyPpUM6XeI68kyNdhH/JGigt+wwPwUM0w+XW3gG2RLmNtPdm13+cVykP2evHOEA+/GebMhXnbfIfNYb+nlsr0NZrMDWzI2iSK8ZDdh6xLQD49Pp9TiR0SxIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE8TisN5G1MiBI7KSrzZd9kzb4fLy9ewz81CijiOH78=;
 b=WT2ByS3F7sDFh/ftbTt0lPBSgkpQjfSWIth376aOp8imeXzb3KTddGEvLhUkWz/n307qpEZNrKHj6PSguQOtgFOoGWaA/Hk8/dTXJ1mGezbB8zVrOWtMOhCmTSzkOEvjn8NtwrHYOZ+izTbcdJVxTejf1tMJY/Sb4JWId0mlm7vXImLaOsa94A9ow/TO2nWicv44B7W1fOYB/nsKEhbPxCIQjAoHEZmUr5cfQYE8zbq49X1eFGPrG8l2WFyNRFc3wmk4L/cI++xh1SNVISte5yDYKeERlzwutDymMJE8TNBuVg5goVdCx1Q19bbhT0o2PEeRgAu4+f4Kf5vpI1LXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE8TisN5G1MiBI7KSrzZd9kzb4fLy9ewz81CijiOH78=;
 b=KfunwwlBsczVrRVIyc6BAhl514qRY5Y6wSOezhRMZZNugr8sBSSivY7Ajah492md1c2tc/yKWra1WT+HVQ/v9ktzL6Pl6w2SrjILziqHxUIevT8jUPugxGCO2zX59knJaslqUwKOGpBIIO0R1OJ7jYj38yW2rGAnk/jv82VgjUE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:03:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:03:58 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 1/7] crashdump: introduce the --hotplug option
Date: Thu, 20 Oct 2022 13:03:38 -0400
Message-Id: <20221020170344.1962-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0080a63b-24b9-4656-5c95-08dab2bd1447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	kLAl41WTRPQT7ZW2WYFc3GysyCGFnhMVtUrKkFPPBVJ11GA74BKpjBzytvnNWBcdGweTejc3zxv+KXMmoDfU5M711WXW3/xgLfPw412haROAep8koZysjt95Qo+FWFekmiuAyeWtBOuYuLQdgOQ7OjrDDMHnOl5C13qmtkl3505EOllTPTWqbhH6FpwWfTmgoXyzPyrJK3xLg9y+FkJDOXw5J4/6paW4SYBXQglx3HvVkcBeLOZmT2ZAJWbVAfB8dZYjlfAlMjkKGKbgnDEd+aiva/3oF2LY2lxegnKJyoeCPuhx/dKy3vrcGD3oGKHP/AuR/KFYV2b+xdBqJUVZZEiKI28iXpLiQVU0x+cC7yHMc33CLbjChIvrGvkrLZ8/NfVPJFX+Pq3l6FJVkSkRapelHNxlddVMyShg0Cy8aGce33KwnXbouBBuxMD+oITm+CT8ZvFIY7JnSM5wPE2QekC3TmiUGBa5RGFRpMEq7vcMD6g2QmP8D87Y+Lrsfz5pNGf5gu4H4l9Ii/++GtxfIXwsPpK5h26QYRR8PoAlQhZCDtSgNj2lgmVJjBt/UITk3ANLK+BZDAd9Jz+L3BtQ8c9B5I5xrXL92cM35p8EuTPJhjX7vCxtbhqWxgK/H81FmknIw7/d/j2Cm4oiffX14OVtJUuyjBvE2DNby/5geps0NFOTqUnZ1JiGnP2okH0jSXt+bBnQU3eF6ehY404GXw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?KGOF6bvmdqmXVl0EhT+2BgsMfgDdg0RbeJ5crKV2R7UkW9ENRULju6cSTEsF?=
 =?us-ascii?Q?QgKkjtDc+vvfiacW8e3CmE9NMvmXfX8N7oWOWJpOHB6jAbSZSFQOAgkmjy0j?=
 =?us-ascii?Q?p9WVfZXzzy52WLELHQKqwti5zbI5CFqChpLaiNZaZTIRVM/YDHHyQ9bUUgRQ?=
 =?us-ascii?Q?TObvQghPT+MYQyolwKD8yU9Hz7X0Sh+M20Py7YfMAQMK1npo5CSh2spwgzVW?=
 =?us-ascii?Q?fM5EoCDwKUg5wp9ma+A28p3XSxbto0S6OB3Rzr0ESdngJZfPYb23tbpTm+y8?=
 =?us-ascii?Q?LPyQLVZQavngfdZsFrb5Bre/wXGShZ0pEOxk9aCdfv+Fq6tt37chnNQvVKoC?=
 =?us-ascii?Q?/dKaAriRy6dyNiVq6pN+BtYrusISbDSyR7I/x+JDOHz+OxjZfDlYlGPnSmpf?=
 =?us-ascii?Q?dATlDfSxLk5yYxDpKDX/0nJkxUwg0YyqQQaidh81bHk8RNXwN7754PukFEw2?=
 =?us-ascii?Q?7Qi2vk9oROgeSAK5XzLBHtuioouCU4JtM22GzsAzR26dMvTwsLYt1BoXRNpR?=
 =?us-ascii?Q?cwsHLJNogz5POIJ3wIgSNI+bUXm/RSBKyPZvh9+f8e/TXeDOD9K5bCTwMB+m?=
 =?us-ascii?Q?hPZpe/A2sqMRAoJ/uTnkm348EUHxliqbbmtEP7xn++uLg5PET7ZVeuOK+XgK?=
 =?us-ascii?Q?k5pmLnq+jzfYmCnoMbbiP/ucxyRHjlKevQ+N2WEt3FjdvnziUWvi+fmd4kgD?=
 =?us-ascii?Q?G5ZF5aDNVz4cvdvKskRlZKpG111IBS/469JL6ajIndh72x/KGSJddGDY0w6g?=
 =?us-ascii?Q?XfhRN1HpnFuTSZdGxPKifjdZvBeJgQmp5fVWBBL6xX3NEoVylunmC619By4i?=
 =?us-ascii?Q?TNPH0QRz2wWpMsdqnBrmER3m203axQT0RBE1U7pY9uuw3Q4wirjk4YhAs64Q?=
 =?us-ascii?Q?5Q8Y9i1ibF/R3f9Kk9/uVqHTZx2a+7pNVUgZBm0wIesuItBM9pC8z3+pAQNT?=
 =?us-ascii?Q?WFQf19P1qRz+s08P/kwOFhLRgDTR8AZacV/St7OOkispvb8II0DW/0xS0XKm?=
 =?us-ascii?Q?Iqlnx6BNnBgp8bhGO1Lq7t7eQBZHTeuAhR3Zsrsi1q0R0y3quKehQyACtnFA?=
 =?us-ascii?Q?4WXcs4HhPB35iL3eISHxsCoJfSzE9nt/jcv1xjlR6tV5j1AMNkEVlHTRAS4r?=
 =?us-ascii?Q?v8FWrTbD1Xn9xwN+nk6uCvKSXMF2uNSTTNvzOHtdgEnbprR6arAD59CaT9LM?=
 =?us-ascii?Q?1485vX10Hdx18CpYkBrLg84Qi6D0ZdD3Xh2vR13H/IFX1L6fU19aY4xVpNOR?=
 =?us-ascii?Q?adQGAUzWpyPNg8pwP4jhfUv2A3rNrHSGMPznb3UIsPbct0bVRirZBeMJ5T8M?=
 =?us-ascii?Q?zvqiq65t/N4wkY4LLPbV0yoiZ0YohbJuRTnKDoq5UL/hdWyO4BZVFB4jtAZu?=
 =?us-ascii?Q?MgldwsnhnZsoA4/owy3ZHvjqu1/paWS+tD8ehN/XzpYjCA+LBTZWy/46bWHG?=
 =?us-ascii?Q?IyPvSHkPEm894gcNmVEy4bAK2v/cH+L51b2Wo1wUZpve5HORJ+IrkUXlM8Nm?=
 =?us-ascii?Q?SgfZAk9aIRBh6JBlfLKODijvJiKiADtFavwxdURNGZ8gT+kAQNaIpjutXxef?=
 =?us-ascii?Q?9A3DiZ16rb0pE+k9aUpGe8I520mgaLB1G3jEjre3Zg9JjGhkUz7rcFMVR5bZ?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0080a63b-24b9-4656-5c95-08dab2bd1447
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:03:58.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4djlXOs1WWQiXl+QDfLhgxqffoYIi9Cm+8DVX31imB9n6Zkr4LkKKPwBXxk87mn+yGq2tHWw8YUvWOT8F+YGWBTCoayyYDUORMF/BOrCnCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: zobiV7GiI9Zt9aDO32bOQoi-VkCJ0Rj_
X-Proofpoint-GUID: zobiV7GiI9Zt9aDO32bOQoi-VkCJ0Rj_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100405_917143_20D44A97 
X-CRM114-Status: GOOD (  24.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This change introduces the --hotplug option which is to indicate
that kernel changes to the elfcorehdr, in response to hot un/plug
events, can occur.

Beginning with Linux kernel v6.x (FIX!), the kernel can modify
the elfcorehdr in response to hotplug changes to cpus and memory.
As such, the buffer containing the elfcorehdr must be excluded
from the purgatory checksum/digest; otherwise kernel changes to
the elfcorehdr as a result of hotplug would result in the checksum
failing at panic kernel boot time, and kdump fail.

This option excludes the elfcorehdr buffer from the purgatory
checksum/digest so that kernel changes to the elfcorehdr can occur.

This option is only meaningful for kexec_load syscall. For the
kexec_file_load syscall, this option is a no-op as the kernel
handles all the kexec memory segments appropriately.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 6 ++++++
 kexec/kexec.h | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0e92d96..1276726 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -62,6 +62,7 @@ static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
+int do_hotplug = 0;
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
@@ -1057,6 +1058,8 @@ void usage(void)
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
+	       " --hotplug            Enable kernel modification of the elfcorehdr, in\n"
+	       "                      response to hot un/plug changes to CPUs and memory\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
@@ -1565,6 +1568,9 @@ int main(int argc, char *argv[])
 		case OPT_PRINT_CKR_SIZE:
 			print_crashkernel_region_size();
 			return 0;
+		case OPT_HOTPLUG:
+			do_hotplug = 1;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..7f7936d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -231,7 +231,8 @@ extern int file_types;
 #define OPT_PRINT_CKR_SIZE	262
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
-#define OPT_MAX			265
+#define OPT_HOTPLUG		265
+#define OPT_MAX			266
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -258,6 +259,8 @@ extern int file_types;
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
+	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
+
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
@@ -292,6 +295,8 @@ extern void arch_reuse_initrd(void);
 
 extern int ifdown(void);
 
+extern int do_hotplug;
+
 extern char purgatory[];
 extern size_t purgatory_size;
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
