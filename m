Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2622C4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wUF4zW8gwyrYkpPshX/F4petAQq+tC3vy31Blxywd54=; b=fBXUoTpl0PzIip
	1VdFISy9DYASOj4qw7bS/eEju1Iao+KmDWTCbLJ97UOKxRfbCeQtmiz57VevKZWf1ZoqeAdyVBdba
	cfyxb8KACr08CD1/aRgUvav+qJdpKR4ww8ZdeCecaVHBasmKNx389u9kJBtyfoCi5La4GHPY/D4sV
	VAktAegVeUFu5wWT4rJlMR0uftffm4GqVSy3fUgOim9lv7AkCcnMvvwzNz6zZ6CCFIKG6FCiimws2
	ZmSUVvsmvCzFsWwapYsp3JNHvu0SPLE2XQyloyYAYnU6SgywRT0+PWV287d5cGmYDhXXRN7peNf4Q
	3f+zrWOY6bSrJM11K/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxp-000jau-87; Thu, 20 Oct 2022 17:04:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxj-000jXU-8U
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:08 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KH0h4r000768
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CT9/f8+Nt4TYwjYxqMKJ8+l+gkNd4Ok/XrHjwZBHcro=;
 b=EPgQ8bHi57yCsBl36ihZXYt5wu4429w0+J2eYg2jdnCkt+MrTelpY3ldnj8e4o8CIJ1F
 AQ7clChmztM0wf3hFc7vVotj70cP9Aawvo+FuZfKElFg/bTYEhkqHe2/jwPYRhtOVSJG
 85XE7+gRDwjhMRHCJopraOLOZ2u8xnp9M68GyzgZexTkadrHDvkv8lEvcjz69bR8L3lm
 UOxOXvZeld9uYH/ZhdD3d5YdpaTtYGZqi7NoV68oOiJFbwAUefN0CdGcfJ1yDpmNsfoQ
 jWK3GvNURlqd6V3bLn+zSp/ObQxTvyRjiO4Rn8zx9tlbgRE4LBhHf71E4d7WkjmrG+85 eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww9c52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFVKQP038604
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr2emxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaGPdW80pzQu+2a9/rJEGWbAEQtAYuTlDRb5VSZf4SjX9CvAUSwGNE0CeG6dWSoqNfFvTJCjLatpxOR9xLAPYPLATv1Wf7R8tRil3myRc198ZEGD5E6oFxXzO6A5LNz0s27B0hwu82mYTId0WrQkUrsfuE24Eh5K4Btvu85fw/sSkFImbHWe3oCU/sJt6ACwW76FqwR0++R1Tt47vrp1hubq8Ks/j6OJ8EyoXUB6M8XwdgbYH0hlf5zcdG3yfR++KpKb9gWp1cOczZ33LHXsF9tB3pKv7qLVhE4ywabu8X23LhMrF8pkiWGXui11vsWBWSFXL3c7xT9dZvtIfzgMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT9/f8+Nt4TYwjYxqMKJ8+l+gkNd4Ok/XrHjwZBHcro=;
 b=cjgbQXXfU/u/Hkxq83EcJNuCcOYLn6t5OulQdYHl8Pn3hCC52ydy85OPFls3OMVjm6UmIrnCAS7BYumAS69VU3ZBhbbK3zWxkEO7J7U1WLA+BXXdFYkPYESzYj697VbTNFa8YNnGlwPADaan9Mih4MAhAGxrZDWG2i4lJvw2Jubf3RTmuvHBxy6vF0Q+M9bInJ+TbisjmGGCY7yKy3J8YY5ijQLzk1zw48Vrvd0Jy32s18l2VySztaQIH+qCDVpND9P6uTfDe92t2yRdyJLLxYmY4l94MiKVu/4DkuQAOQTIlcdpqJcZ9glCKt85ntJ2JzZZvZU4lUv71W0hNNoTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT9/f8+Nt4TYwjYxqMKJ8+l+gkNd4Ok/XrHjwZBHcro=;
 b=xvG4YoJtrQo32xcTWC+6SCPY8hIqx+cx+epjwU8qmmy9MHbqo3DJ0mjujaSNF+zFPS/9LX6p2/0cFICXbva/OtmPF/1+O73vc4MIFZZfEokmEvSoxlXu6Vlf805Bn/WI+MGqt8GIArq2rS3nudVA+ixgn7HSNtkR2Y0cFQXSv/8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:04:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:03 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 3/7] crashdump/x86: identify elfcorehdr segment for hotplug
Date: Thu, 20 Oct 2022 13:03:40 -0400
Message-Id: <20221020170344.1962-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN1PR12CA0096.namprd12.prod.outlook.com
 (2603:10b6:802:21::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 231b72e5-90f0-4e31-cbc4-08dab2bd1734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	C98zdJ3H01Or+FCjGzNuz77LliFKd5d1SoNOi5qTmYuhy8iuVV+Jln6PZj4mlsNGsRJ1HMzneR2iavNG0w66xuU88nW99BOFmvGBYVNOgDQ6aeKkyH6QHhqH0m9nUiYvKrkQemGtoVX1d5iI55BAdKGIBqvvt/nIC8IjNEUwuxvBLATUmfEH5Y39lCTH8s5FzmVfJc+GRdtOfQ86hwtCjsykPsca44vA/svyjU6+DJTHdsM0rqEUstgjBEslfObQtXMucOpQ75Fc8vXY1mIL9D4c8G7D9foqGSrhxBVWEgNSV3mLj7SGzaRi0eoXpUyNtxNNCzQpsAWOUiX/eipe4l/b82rKZGzwnkTsza9UWWdOgwcPdvkMrafvqmoKWNJ1XC3HRNkEiRt62svl/Fq8K/gGDpc/sW/FgbDIsXW+JkbIUuhfG1lChIYnerljCg4TPqshlyu+K1nTPk+xLjnzwdRZkG2ISNFthedquFthwHT0xqSs7PoQyJaD/cGJxqYFr4obT7hl1HYcgTOj39Z2yO3I8Ptz8wNuo9kCDGyOPA+HVFVClW4hvMSYcYGNrjrKetfiVRPkVNTgG5V8puzKmSubeVI7XX2uV1NN0TUjzEakS86IhBe78reF982brSBZddNbdtXJNCbj6dfOtoNjyzEs9TLTyQQ8HggCTwcI5MQGaekru+kQlvsRbastL2cMUrUD1AEo9h+EM+JO7Bz9lA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?2ojO7jC3lgoV0dBdLaz3w0i5o1MxOTcHkZPnp6L+gehtYp84a78GrnnBZAai?=
 =?us-ascii?Q?+rBUl0pd1uwlO51Cz7Ce0xWQkbeD+GEl4xRZbr+vcKPs8JtgOMRLFcET1jGi?=
 =?us-ascii?Q?kBpPSDu0RYPdDlkxVHfWi9ULqCnCuYEV+dZa1Js2AC6RLQ34ZlKeVpwLvwZ+?=
 =?us-ascii?Q?KxDoBGW5Ksfn9prHtY37ROiip/RWqTQ7hnid75Ojk/rulgt2agLnkOZNpXLc?=
 =?us-ascii?Q?31YMVkPCFVw3XCfPMffmC6nbOXqbUAXvv63UdQ4vkdbhzaBH7vm6as63bUpy?=
 =?us-ascii?Q?8ghm0OX0GIb/0ff+Yq94Twl6RO9OymAVtZwNdZYa00nJWfnQ22YgD/EC+eFc?=
 =?us-ascii?Q?YP1q7C2xNEbCi2qT33ffjOHLVttXgvQo/BUirTaTFdhmt7KmuVbSVQP5sFmG?=
 =?us-ascii?Q?1Vhj0UUcsx1gNwQJWdv3bnIlSZvchTEyfwLV2bytpRb51rFsVF/ryE232ICp?=
 =?us-ascii?Q?aR9rbyXBVMpb50HKlo/5vrExRE8PFOIrT5muV9P/q/NmRC+lUQljU+PRz42/?=
 =?us-ascii?Q?lymR+aDxXOaLTIADJpEVQMlVLlHihAdF9wZ+FzscwQd3VOyuy+efgwJ3+kd1?=
 =?us-ascii?Q?7AhVX6AzY54RVflWRzWuLYZYjk+o8NV+cicdIyqPSxqFVe7uQX8XdRRO15o+?=
 =?us-ascii?Q?+bfKziL87XEB4EhNr3XoQ1HMopfEOtSJxhQAejIWF+MrFRFGOkbGzPb8Fdis?=
 =?us-ascii?Q?TPEzxB7GZm5ROhoel9gYpwJ9G222dVo/R+7GbdSjfoBgC2byQfoLZBXVl4mC?=
 =?us-ascii?Q?hB3LGwJZ6CErZVvDcAa4gq640GNtAJHHzsFAbEQcLiMVYbh2x664xInJ0YLO?=
 =?us-ascii?Q?R+ehYTNHd9TQbxMFvxnNGHy+dxZan2dXW/QLOyF0nYw7SY1Un69y6do2ZTh5?=
 =?us-ascii?Q?9tKENX/ujbXkCQGUX+iCF7DjJe2fQJB3N5ByZ/UTKKgjC8k6tFbZ36bc+bPg?=
 =?us-ascii?Q?BifRpmR+yRHcg3EMeIfdHuN3wRUXsuGz0LOE+1nHWN7BErUTy7bKqHoqA9j9?=
 =?us-ascii?Q?dVsc9Dhnag10vjd84eg5dqTumcC3QMyAC12IwfeUAPA/7JxO0pOELUqbPqD+?=
 =?us-ascii?Q?YYs/CSkJBrSQ0ixqwAgvjapeYXxWTfUd5cutVJF1hEcImoL2LR+2mV+s5i+x?=
 =?us-ascii?Q?3tQNpxy0gOSXjC7lYSJn+eRax9VEND/DGEHJl+M/yOqz7ElMi8Jb6fOeBCmJ?=
 =?us-ascii?Q?QoOvlABortIA4LCEx5DdgkC6wVS6chYtdBWd5+G3Tg/STMJHTvaHS2kUSMFy?=
 =?us-ascii?Q?sYuAEE1DGwLOwuf+g9qW3gD+B3SZNeppaIiygrxZ5cQPWWCahEnOCwD2JtCl?=
 =?us-ascii?Q?s7qZaLY9RcpGqElm4IJ0HL9WzHP9BqNOIy0u0dcxkFW4B36bYgDUia5QB7YY?=
 =?us-ascii?Q?LeF9TuYg3vHsWMcSP89EzTwR4GRv40PwCWBkSp9nsnnVt9q4hRHM0N9lb2b/?=
 =?us-ascii?Q?o1cMPHr3YBozxtT1sAdgoeAfT23nfeDHh7ps5aDGNc2aTwnj/S0GYPqhyGRJ?=
 =?us-ascii?Q?BfBt95k7/pKK9kDCeFI+wtneMLTFHxdsOzf6BOMa0eZtkDMKDkcTt8ClqgeJ?=
 =?us-ascii?Q?nJ1wo92xmDpTFNnCj2xlz1yib9xUV/ITTC1LaFZ3tRhCvCCoI7svMZF9AfDM?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b72e5-90f0-4e31-cbc4-08dab2bd1734
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:03.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsyE1BNCIb9DgPH1iu+I8eHGQiLw/vnCY2c/FML/xFsoP9JkQvjJh74DjMGZNEm9hr64rzZc3+LPXJgV1X8a1iuhbIS/+qpCYJa1XXJr4/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=908 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200101
X-Proofpoint-GUID: -geFoKGPyv-GA-UmNW7NqzQFGMRSYvZZ
X-Proofpoint-ORIG-GUID: -geFoKGPyv-GA-UmNW7NqzQFGMRSYvZZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100407_344932_0D325AB7 
X-CRM114-Status: GOOD (  16.88  )
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

Identify and record the elfcorehdr buffer so that it can be
excluded from the purgatory checksum/digest if --hotplug is
in effect.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index df1f24c..cb86ca7 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -956,6 +956,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	} else {
 		memsz = bufsz;
 	}
+
+	/* Record the location of the elfcorehdr for hotplug handling */
+	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
