Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B24C43334
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ij9wM3YhovAlaPWLXBVqkPvlWqlfM8Wbhn5mqA678Pg=; b=jgFBA//i3ioAtH
	rS7fee1+g/GtzzofkJ7P8hVcmvuA4hzQFo38guXhBheZcTqVGa3tAy9RGcMlkUZfybiimaZthxsiR
	MTL3YYXGnVFN50GSown5IePJHZl6w5HOZrrdqQdjpC/SEeENNfgnzTb35MmKo1vOHZzZRmTthC9an
	A3dmxpCdABqq8BrVLjB62QqXpo1ij6utfUkLP+sTCc9JvRnA10ZXbR+jBXR4NnIB93KnMdF5YSn0u
	/Fa/vCrudfhvTlsYTAgrqHbQm06TAtl7rkezAxo+hIQuvEO3WfbCKJZyMjdLLeL+qffvBDpv3zIkV
	rxBtcPVckDC/t85lx5rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0sma-0067rO-Fe; Mon, 13 Jun 2022 22:43:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0smW-0067pR-Na
	for kexec@lists.infradead.org; Mon, 13 Jun 2022 22:43:38 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdgFY014531;
	Mon, 13 Jun 2022 22:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mh1fG8/n+xNyI4tlLEwqNvilXyMdCwrUYP8VBQjGBKM=;
 b=HSNvMIedX0Sx1GUngSQV3OD2Z5j+zV8owC8GGbkKvR6NlYbiV+n1Em0C+WmHGFFk4RvG
 nnJR/qxxZpsEmJ8v8bQgA9nu/K85rt8ccpVwPcdH2yscMcLWjjsPrwNfEr4cBGbgXpjV
 u4VER/iIF+LqLd4pqYUDJQep6gnZR0VYm2ZLdkp/OpkoOrVAEH4mO+6BxCFUcE5yECP2
 g0cviZJXCVswd17ZLY9g4NDeSDkYfUE5wb+tq9gfVK4hucBOKT+8I+BZaoeodmJzKyUo
 O1Yj/ri/HsJ6sXEZTz+rxP4yl6nIi3j16kRRwpHX/0Q7ZZViCGkScfQx+bm7Eg6u9ORg lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktcaef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jun 2022 22:43:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMeh0c014916;
	Mon, 13 Jun 2022 22:43:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r3yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jun 2022 22:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGCF4Xk+DIMpIvezRgOvc/Z7YsqYgcZnyimFt/AEAZ2BBTxtenEXO1QZzPjpVcn/+IWXZDh6++6nhqaqLaIuXxucV3ccTrUbXeVhA5gft4QY9oSRpYWtuAo14HBuUe3jU7/i4GDWEyhqLHh/6GYQ6UtqUcuTgZjQLe6L1zXt+IsCaScOE2IOF0YCpIVKaoxDu9V4MarEJsGtwB/NMNjmGA/OFeuXza1zXTlKcExfqCSu74xzIaRbq1j5Z7lZ7eqwlt2uPA+7feI9dyqHw0MIeYhkocg8jwf6lRBiiQ0W/CWJWj55xlD3EubxiEI8bUNo+mSOoXk+HKtcnR9YkA2yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh1fG8/n+xNyI4tlLEwqNvilXyMdCwrUYP8VBQjGBKM=;
 b=RV4/s65jItAI0XIbr3L6A+3bOOerPSDPfV8Qoo8Rj2jdE1Tol3RhHsrKbGy9CZZS9BLapA2v0XOhSgAML2g/iE1RkhkRSLvU10gMiy4I14xio5z0cikWbMhh+odbeJGE9Gojy1DH54vPSoiALbFJssjn8uFTR8bxeK38O0J/owY0eVVzBNtEdUnT03lKra2dwhDi8e3H+QHV9lQcRcFXziKbNKz7oDWkf1rn/pXso9Bw3mZJMIz7sD9NxeQeuSou1Wj7vvav4bNsqYPDijy9GEbGdqbdScfNrKUbQSeqPNI+7u20feYUXxhgG2eZqrNOKadnRuqMYIf8TWbLLDNVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh1fG8/n+xNyI4tlLEwqNvilXyMdCwrUYP8VBQjGBKM=;
 b=ROLReazxo6arBsvM9xdTW/91xR7T2v06vyGyscNJ/EWZYanJGna/0H/j8hXa48PU06atdyMQvh/jU+ohgjjz/0UwwUrQEi3lmN917Sa5C0IIIeN5TxSpXZwvWyfkHrA/tvxDXxFNj5bZRfnIH9ajqvI9P7JCyitTvLNVGiV40OQ=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:03 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:03 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v9 1/7] crash: move crash_prepare_elf64_headers
Date: Mon, 13 Jun 2022 18:42:34 -0400
Message-Id: <20220613224240.79400-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3134a9ef-71f1-41a5-fe6f-08da4d8e1381
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: 	<MN2PR10MB3824B21467A04AC3A73513C397AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	PEyE8L9URV4phGAEq5cUpRUrZ6hRwp1o+SBSIVsSMoonyB4amp6bs/rIUjgKZSyyjoh4CY9iIZiU7xIIvyEXfm/FxB/8uemjaKsYCp6hqm8iXMxTpHsCy9jGct/zsDTVTb3fn1Kq4xsOR9BFWbDW1ojC7gjV7OpgPA62tjzFcJyAklLYmHHWo2qEE6R/LgaU/fVTRl9RonSXTn3EgmIlzGO7IY6ERUyE7646IvIYQHA6MeV3E3zcL8UhVDfXlgJ7DTOKW0PMF0r9ifQJjZDTe/R+3WKCVoouMrrfVUP2l7iuHMGSHdmBIoEKm5vHRbkkEG/omDzd2VxoxDjs3QxHtSX+dqhj578GVIcocLvEX81duJWETrh1mOKeb/VGbnxPVbrNZLysnWfYB92b2wZy0rk5lmyqTMZmwmhaxyVVGLkU2SQUvRh9/uz9+PWl8qRx6Tho0Ap2tL3fgME/LbqXkfPQNMiHGFpbX2jUw14evk5vD06tTtLnIQ2FIjS6YivYhQT+yHfbUhvcNVvpTZcoanh8O4xLwA+lp0Uj9daDxLFMCyklHMi2CW50Ri2tKauxCtwmr7Q1HhYjEqir+6H9JCxyd6uon42KurWeLHPCXEdThKTvnUoOUzjmQZJBUW9z2ec2z5zNTmj9WLwV2jrmeW1sPM7hnps6x4qV+B4NCdiUK0VslB1c7mJb3oSqLWyUMezcN8dIDPkrLkdYwC8H9Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?iUiVbBYLvQqokSrSs9yZ9qsx4lActIos67tXLKwI9vnNDSfKh7Ylw2qJb9r0?=
 =?us-ascii?Q?MoLut2eSjskY4yfQTywB9m7zREq+cKGjkMpWsKjSqP8uDaGDdzYrRCFP/wdy?=
 =?us-ascii?Q?1Qfg0LDaawpZxfr1FplXRNeeUgb8wepX2onIZcJBA9XB/YmjzNtirOjd6u7D?=
 =?us-ascii?Q?LxnoFgGboDtqJRCwDoDKYRqnvpd7NGEQIHxHvilSlZPf/Tj8kZtxxjc7xqvF?=
 =?us-ascii?Q?4kIZCLuoTRH/mhk4b1CWqyhfsNbagt+BcatZCcra7LpiK7xUzJydaJSc9u+b?=
 =?us-ascii?Q?5dDY/OVQ0RVgUM7jt2mEoIqMMwgUB7fiejeqZjP0ZLluMvUKp7SSL7LWMvwb?=
 =?us-ascii?Q?jVJc+N8H88l60ohglyM9Vf5T7BXXvJ0O0fZWH5VI42hmkZU+DrlmIyu35gga?=
 =?us-ascii?Q?ZbQJF9YKboz/rsXS0gW0bVx7J0RTOlv2KuAXOaUfoEAxi2RijAZlXlqFUjmk?=
 =?us-ascii?Q?MEos+50kKncD2oXNo91iZdqgH96vBoX6EpB6YPksOZ+geeD501/eYrQ9IrYP?=
 =?us-ascii?Q?v8aWfB4noOIQNZRNMgKWHda9KTeLfpHEMmtCT6y+Sh31sqa3+CrRaQF729wq?=
 =?us-ascii?Q?HEvbwab87nID9EkhS9nw4+MR/a6zXPPHCOm8UrYQsvSqOOC9QGCTeH1a427q?=
 =?us-ascii?Q?5z1/nTHxGNSHHRm4xeTlf8/XyxwVBWy7Q8+rSz9l5lq208PMDfqgkR5cNHWs?=
 =?us-ascii?Q?utmItPJKfrIeWkSHRTaSUFaOb6gJJuma052jSoIZjBJp084hM0Kq9uMcWdYa?=
 =?us-ascii?Q?2bWfeVfJgDrhz/E2GeurBrHFss2b12SSkA6LxrjopTvRJwSVGkOdmDXMdtYm?=
 =?us-ascii?Q?71/4nmPLdvU8VDQH6yQ3oJ4wi1BFV5BakGg5YpmULBbB4yduzX9Q12wDyhJd?=
 =?us-ascii?Q?BYNH3VPDDoMrPaDIGake/BcyeXoCLry9XsUQ0a6mkCCkV3AoBebbb7NNr0dT?=
 =?us-ascii?Q?t10B8zdLwHgGrlASkneJMYhABthFznxgqLLuSlfdBTWuZmqehEaVxslP0WdW?=
 =?us-ascii?Q?/LBj8TWgAXyMAw4TfHMsPQo5FwaTYFRi7R8M6uRmyXIc4L3QyNRfQ2YEZjDL?=
 =?us-ascii?Q?LMXwjMKd76HIACJs/UBCKBw62k6RzuFN5GblPV8Jgyqzdw0YSiZKbFb43p9D?=
 =?us-ascii?Q?oXFXoBVCAPPX0lZx4Yc25kzgskBBwSLTYajFUUCSrtwhtEzHnsZUCPBfuy2q?=
 =?us-ascii?Q?ci4pUwg8jg31FLHqkVbYbgCJTVcrHPhjnz0i9jBFIFNKrfcFqu6NlG/mnL61?=
 =?us-ascii?Q?Z44VqNoVnNKpZRsSmPh6Pafk5Gm7W9BDImSm9DJGaahSSe3ix0JtlogVxXWI?=
 =?us-ascii?Q?1bqHXtVeU/UrLKfb05ZXOzyyQ208zxT2P45Jmo0C04hvbCMVp6WI/URrzQ6e?=
 =?us-ascii?Q?OVcGaTLoczOmCl3jgm1T9vrXphlThKpiK0wk8SnEsEeI4S+nT973gJyLTHD4?=
 =?us-ascii?Q?tdxwmNqcu3CPe1SyIPd6a99yqt4NzYwYu7xfGBZjWQ/m75AHn3m3VGckq6b4?=
 =?us-ascii?Q?6H347vrWqfDBUrRMaj9GqLNScQaa9R2pIm96P4Pzx2wHg2NdYELNzpz5BJJ8?=
 =?us-ascii?Q?B/jdQCjbW+EzY11f/sQ7QD6Ah/lH/YLDFCVsy2/k7MB1oqEouVncEL9Pfix1?=
 =?us-ascii?Q?Y0yWJk1ObDyzAk3ron88h8ntaerY8YCF1zb1znucw1FOvaphdeh2LDQpnKQq?=
 =?us-ascii?Q?xynSF1xH+Dna7Zsh/QJJqKUhfVRhHMRI3ZM1+WEis55fw19kCuUcurwZXb0v?=
 =?us-ascii?Q?spo/XwQ0e9lvNqeTDph73uBOQm/PJaE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3134a9ef-71f1-41a5-fe6f-08da4d8e1381
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:03.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qENCZXkS8PMFpWxWzGDJHQc5d7p7x+EzhyteqQ2QGyIGmzjWNkivJsgGaZ09bIpGAoNz59+ljbsMKC7eLzdM/XdlZEExKIidzSFnXXYatrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: OKd8yVE59zDVfx-Y837P-waPArmwaCIT
X-Proofpoint-ORIG-GUID: OKd8yVE59zDVfx-Y837P-waPArmwaCIT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_154336_804600_E9A93DD3 
X-CRM114-Status: GOOD (  24.82  )
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

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load and kexec_load paths. As
such, need to move this function out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c |  99 -------------------------------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4d57c03714f4..85058fdce308 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -305,6 +306,105 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..7adf883c091c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1259,102 +1259,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	mem->nr_ranges++;
 	return 0;
 }
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
