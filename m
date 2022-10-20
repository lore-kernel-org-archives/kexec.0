Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9931DC4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dk2+Y3YqiRdvZGGk3bNLEDOw6WPhPv+f49wjTd2vH2Q=; b=3+CNmO0sWtOuGu
	4x0N5wJ9E1YCHUIW899dZnPJVu6k1nU/Zrh0B4SWTjAk3GiU6PgbExQsKX0v+ZUn6yCZbLI9/zsuw
	ayn45otC0rgagSQE7EEILkbMG32ioVnJJ9btgtVRkIgFSrlbd6ITAxjd/k5MtPuRTFFwUVyqR5BTC
	v3cHEMfPw511SRhI4CedjkXchiKk/nYRZyPjNUUEhwJuM8348UIW5MGBPvg28B/7h4rXeOBv3GYYw
	2oUyB4AEcdyiNsW/y0rwLqJ0+k+S3c0zBRY/hXML7GlsMdLsSXBGZ9lBEsyXGVEuKF3Eu1/zjJExT
	14zMBIYEGVf3HETEnm4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxw-000jfR-An; Thu, 20 Oct 2022 17:04:20 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxn-000jZd-Jt
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwtau019996
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gCGF7/pctFIlU9uWe2s9c9AkjhM3208WQMEsj5oPpT8=;
 b=qtvL0uXV3x568dXxYC+JZx7iWlTc43aNQ3jsFmjj+gRQd1zAaHGfwskWjcSDpGvQhgjE
 uniE8rKZFZFwxazuE/gIlHKXL5hUUUyg5MpX040D4VZgVzG9SkKTBOAKoCU/KfIGgCHG
 2pIISapur14IP4MMCjFp4MF2FB6/kBHc3d0y6EKMIUqw+M034C5BepuTPwWaZQ+pjd52
 rCi7QLPAdm9KNlyScqNC2yOrJfUaNDPMSFnna6hOiTtqxVir8aP4QpO2ZUyRXycT0g6F
 C6Kd8Ktsk1LloueOVpp1Ju+p/eOYtyznTI1cDd3T+IiF+q1am4aY+/sja9ph9yah9uxE lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3nxrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFSCvh027463
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjs10f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6uO2NGS+9mEI5WbqOjWARbF1t1o21zRUXE+kwPXnY6C5Oc4gqP/N3dPw741ehQYqKM7m+As+Zb4PC9oWsCDItRYBgVq4A3q9sg+o3m129VarAeDiEGQR4XFVqBOvw1lmy69zmQ91gPj2FWoR2tcWYmfjliYqb+Hau4XNpJViYvq5GIBaDkJq5Q3+QHkysQ0nx9Ouh8Id2jC+ls1kRtjH3nHcBGSH/CNLD7dlHjsnSKAj9wZw9Sb8SOlwbLxuO0gaL1f88U133iBXhn78xi4xhWrLAAI4D2UFHozExsEABm+LHkEWyKsTmzf9NGqsQ5R9BZHtezhVcVZc3EpYmDuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCGF7/pctFIlU9uWe2s9c9AkjhM3208WQMEsj5oPpT8=;
 b=EwiVvNcMMztuXEFGX/JzrtQ7PQEy3GLQk/mEeBCEujpRQIHIquwlU7rbkQFnCj5V5B37APe8FUPWdCF4e9EkirRxlbVJ3SvHfO/CVAllX7qelSkz9T5kdiICL8aIAHaVOV1Bpl5FvRlnUReQxeOz+xBQRFkcCba/ma9tK+oYMW+gRQuqEzlK9ksK+gTm92YY91ENhEBw1ZBdfDpZoigloAeD+yKkRG8U1EMubpRAKUUa8cOYVwahhC8OPeQsK4cMgGcbenr2+UWN2qDp6U2uQotT4w1z/oJGy333v0S+TAepEOfQWtOgI06NIVlqLhRZaWmK13cx65SKQp8m0eYSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCGF7/pctFIlU9uWe2s9c9AkjhM3208WQMEsj5oPpT8=;
 b=l8AWaknsZe9o9S6Li2W1+qU0MnpkINLTRSuMYPs7iuw9yH0XbBUQNdAHFcjPn+Nig3OMrx/MDHHjjMiWwOQHNPt/8WQzWGdsWCwDcBhYHVleL9sQocnwiVMUPsh6LKskrVJToA5E0BWBFy/ogNS/29CLVeAUw3O3RLq/HKRSA6c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:04:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:06 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 4/7] kexec: create get_nr_cpus()
Date: Thu, 20 Oct 2022 13:03:41 -0400
Message-Id: <20221020170344.1962-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: fd38ae3a-a1cc-4d96-69ce-08dab2bd18c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	HxOJZw7kn92veLrwmLxusOSUhUydyZlYrtmqrWS/JDCk4tl26DxfbLE8rELaA3O+F4RrHSIOyfcIkzjUSbutSugK3PZ9QSjqMFQLWsY2UHK35b2u2VxlfUL7uARM5QDmxeKIPYctDohzrsKY0snL2C3aK/vNZ2CjA7CE5SrBAuwm91GYlIbFJerHgm/tGqOSHYcPP4ChPp0+h1KA+NyM5wep3kH648xMDTRgz7+xgNtX6wegrD/cU7dujbPcS5BF23tqYsRI8yvHPjMeD10/JXiGjFnyNlKLsdgBN8LuO/wYBxg/jJH+qWEoeZMii4NqQCKgb+O5m7973LjFpt6tznEm6yJUGnNHOh6KrQMQaLUaltggwxrECH9ZwhQj1SxTnb0APgTCBRCDo3ZfC204BcOq794o2G9pbGKZVvRi7CbBkYhek+JZuAPNlb4+PMU3aM8Vd0QVGz3H/H3cOzphL+hPRUBvqTH0NyV7pdM9loMjJoosuXIPOgMWnJeTDE1dIhFzOIv2Sve7tC4QFCTsuDPOKael2ve7E24ZKtusx28tq+u70amyzzWG0T+wnnQau+2nbpS6LgO5GF053PNhfywbcb6e94sA0TMBF0YIYJNAsRcWWctz2MW+Ii1OWkuq5ZTVQJ8Hn2O1y0HyYmsKAFqVby2QzyeScPC2SCqFGYpuN6FcmnWa0bsXX97tYcanKilGDH5Uytn8+MLWKY02BA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?kY/9coHCHqA/S1f3sYHvC+/w6X1C5ME1n7i7435cLnT2dV+Y0Tox6wU//Paq?=
 =?us-ascii?Q?jwe+I8oyNz6cjKlnu/gTV94ShE0ne3+2wxU+MOpAwB7a0IRymvTihdma4tWG?=
 =?us-ascii?Q?nEiJZZirekphSMcBPmu3OXBKQffrUMK9JwNhV1eqWrD1vDPBt9H5EGviOtTd?=
 =?us-ascii?Q?KtUjUe+wqmnhHhW1lDhx1wHrc1D4IZ2VbgfOAyDuSlsRFFz2ofLhP85cbM64?=
 =?us-ascii?Q?ZuUjQsIB87plWMm3Slw5gPHY2CG3Ztcs2P+xdoo991tcE48VmlsFSq7kiJXo?=
 =?us-ascii?Q?BL5/NasrLGpWJ4T0UPiY2nRyUdmdK1TuSHhgms1/RckOLdZ240L45NKl3ZuJ?=
 =?us-ascii?Q?dmQUjt8ihjNaLqRWXAUDRbm9ouUeJxH3W+iE0MP5VWbBuvdAaQgilT/5GpEV?=
 =?us-ascii?Q?XDQM287WYin1Lg0OLZ4ieeT0eJ68vC6JxxBLc59InHxZYhFhap52zDDBy6wK?=
 =?us-ascii?Q?ajnobj0RRukosyK1H5/VT9+Vs5Wmpx5Vo61tDT9Jl1UvNFZJOKgoAP7c0M2p?=
 =?us-ascii?Q?gblUjMUfJJaaAmW39KjudaQr+jEQYg9F4CtO0BFsB35TC6TLQAGiQxNSQmKy?=
 =?us-ascii?Q?KJma91q//MLOQmG65q+lb+O1GltoWcIyEgICTjIdTp5sO4ttM5gwLAAkePSI?=
 =?us-ascii?Q?hEzeeyNdmZHKJ8Vt4lneIe0OCTJTM0W3vhLWOpC3NZ9R0sirzsk/M2XkMWRU?=
 =?us-ascii?Q?8egv30rAGicAcHbQqnd783y1ek+/5oLh2WVghD/3GWXhXeeUb7nPFLudlOsD?=
 =?us-ascii?Q?WF4AoajKdfYdzlrPZFJytSkrggwYF0urUbq2q7lUUYjnM7MOI9ueOJp25cE6?=
 =?us-ascii?Q?4fusOAaaTZxI55ADFYTD2+pT6fhAudisl8Dic3xs1yOO9aKEuoFe4CIaSSAm?=
 =?us-ascii?Q?WjK8Bw0HJlrhtqfpbvAOFdW5Edn+mM/H2bG6MEqbcjhXV0jXVkytJFbo/WQm?=
 =?us-ascii?Q?MRlYdOn2p/7U82qxEjeX8jIxI4NwBfrElA/BSEyEKuWzyV+mH3H5EXHrjJbE?=
 =?us-ascii?Q?ITBIJ1RGLqz/LZ+/JZZDJI4mPbTpDiEMiE4a/LJt0p1BCYd7ZHHinrFBtP7M?=
 =?us-ascii?Q?R3a2NvfPsND04IQVUULuNYLYxP8MEr5byXHA34k02o7HbIuvEJZ5nH2mBFqW?=
 =?us-ascii?Q?tSZFaNQriTwV2BDrRAheALlljo2vVPNe2jsaBXwpsVWlUdI0SJjpeiQnngUT?=
 =?us-ascii?Q?5ywt8zsMnx3W9JvdfjSl+1Fb5BUw9NOWP04R7aKTOkpbUiCfJ1HSSHVAZgTD?=
 =?us-ascii?Q?4rZb9Ai2shP6e2erC9edO4x4blyiYs+I/BLmTpEa0x0AmQgTM+imZiixVpPo?=
 =?us-ascii?Q?LxeshH983rbg4RmmpJUdLCHlq6tk06FsI98Nq3f6/dDjfWTLMoYKfPScw9Tm?=
 =?us-ascii?Q?IS2qKXaFhbgUZEF5Vbkgm860b9h1dK6f+vqyV8tDGqHpFm2/Hd1dGHdOVIED?=
 =?us-ascii?Q?EVUq/m7phkle4Wk8xmavntdG7LWfTMB3B5GvOMSuEGKOR/P9Fzm68YMeK0ia?=
 =?us-ascii?Q?3sLNsXXhY+nQmd5aQZAxxfP3FZMWKc51Tymot/TKwi6n1mW1+DeAE/Q9ANHS?=
 =?us-ascii?Q?S9wUB+z+sjCbxNojNn65eTrRERGk/rX6QlEDQBr9onXdvkScItKcQ1cxipVy?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd38ae3a-a1cc-4d96-69ce-08dab2bd18c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:06.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPmi3DD2t/na0Lu+TzuskkxaXrdt44rw6Lm0tl+jRPyOk2vhrzYAz/dcTE4PRRc+MtukY/r3Cy6yW7QSPGoD1GpH/g69Twf4w3NPXc6y9VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: sasOFRb8qdRp-338GUoyEV-Fggf9iPri
X-Proofpoint-GUID: sasOFRb8qdRp-338GUoyEV-Fggf9iPri
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100411_821729_43BC83E7 
X-CRM114-Status: GOOD (  19.98  )
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

From existing code, create function get_nr_cpus(). This function,
will be referenced from multiple locations.

No functional changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/crashdump-elf.c |  6 +-----
 kexec/crashdump.h     |  1 -
 kexec/kexec-xen.h     |  1 +
 kexec/kexec.c         | 11 +++++++++++
 kexec/kexec.h         |  2 ++
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index b8bb686..5e29f7a 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
 	long int count_cpu;
 
-	if (xen_present())
-		nr_cpus = xen_get_nr_phys_cpus();
-	else
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
+	nr_cpus = get_nr_cpus();
 	if (nr_cpus < 0) {
 		return -1;
 	}
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 18bd691..28d3278 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
 			   unsigned long long paddr);
 
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
-int xen_get_nr_phys_cpus(void);
 int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
 int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
 
diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
index 70fb576..f54a2dd 100644
--- a/kexec/kexec-xen.h
+++ b/kexec/kexec-xen.h
@@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
 #endif
 
 int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
+int xen_get_nr_phys_cpus(void);
 
 #endif /* KEXEC_XEN_H */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 90f2e71..d2379cb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -490,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
 	return 0;
 }
 
+long int get_nr_cpus(void)
+{
+	long int nr_cpus;
+
+	if (xen_present())
+		nr_cpus = xen_get_nr_phys_cpus();
+	else
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	return nr_cpus;
+}
+
 static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
 {
 	char *buf;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9a26065..9675e79 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -294,6 +294,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	int buf_end, int phys);
 extern void arch_reuse_initrd(void);
 
+extern long int get_nr_cpus(void);
+
 extern int ifdown(void);
 
 extern int do_hotplug;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
