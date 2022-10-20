Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93525C433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62U95LPnWickZmEvTKAALuWVVk5EqZuXe1pU3D22Zx4=; b=D1Q23uckRoyHZI
	iG2M31Dkc+Ah1SvzXga3UgYQ7DgPwc+7ayCAQ8ia1axg5m6pBzpre0+bVyFkB8ZuQlURBeaSVyLNS
	Q4b7hmjVTSUGZfVZZNZJSF5xCim3+azZ/RTvnXXdmN3AgAWl3iFPTIej7XPDEo8bcGGoBzAMQHfW0
	k14fb1TID6Xe1LYo+X61BPDfjWEQtQAZ21S+a/0C0M18YAtf1P39L8JhY7jw8of7fJQic41Wg1rBr
	vqVPV2NtB6SwJBTITooLUvZruHE6t5MEx5nLJ3ndZ7lTpkU0ShfsRXQDEKL4UM7NTZtCwaFTE1lUu
	8xUS4lgxSzeVJfCJYPdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYyG-000jpi-Sj; Thu, 20 Oct 2022 17:04:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxq-000jbf-DF
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:15 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KH0Okv021011
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7wEKFfI4AP8ac2MApVKDzRsTPN4+sT70dBKFYCuibTI=;
 b=NRj1FBaN5CoIw8bdtRPv7p5GNpegCw/kIfMytfQRG7YFXzsmkU9T8m8apAbCnRaHGYds
 Psj5KlPs+BCIysnmojJ/fvtiIyTn7kODuT5UP7yDYBuMDgAFtCVDEiwF4DcvbKoC5tYi
 bnXcoGZTKUpaR8UkljMwhg7fmVO3VACaXkF24FHwN1hmmU6qS0AcLj+CvyIDRJ/nAMNJ
 Fd9pSmDFbyhBLLlCV3mwbwl6Xn4juIRYoN0E1o1Yj8CQ7mbkjxRwr04P2NrQBKV8p1Nb
 lusE49SdMcCeTIcq32Ych3wOtp+pKZeVxjLhTNuPwt10DLqZd/xx2loUoe33SIZL7wpE lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntj4f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFU17U027411
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjs12c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmLkzeWthusGSj3PTOraPdOcZZ9s7pPbsgVs7ymsbiRzqLqZheffkWDL+bSvRoprkMlvdK6KALWsfxotiICYdT9Vndwxh8enMsX3wOtVRMAZuT+IrH6CPIT6+m6Sgiqbpyl+yOM41aKLsoGIQw7q2t+mVbqLo66ksdYXDdycRD9+8g/6mep8X2UbMIgSxXvl6marnni5tSw+F3RGOfJf0KSenZKGddZgIxb88uXiB7sNpNpdBLF7k+IXIZYQGs4TOQG86o2edZWnNRdKJdSoX5BMlToE7PeBLWlSeaMr6Hin9fEVvy1dONAk0DQbZJCAWjPqUCS0dYaXJH6lk0DGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wEKFfI4AP8ac2MApVKDzRsTPN4+sT70dBKFYCuibTI=;
 b=T/LBtd68yCLHgYpQbFGN3gt8IdF+mw1crTvbbLQncDJueIVJzfCPwdt+ziWAucJhXiHRjuLIel24WNsGL2tgih4UYFiHraQw1VN5eIood63RmRW+ZGVFWbrRVifsFaGd2qNPjdjoMl+vzt6Lyzabhdr1ALsTma59u2PQk9TP6Z/hiq4/YxgDQcOeCrgZB0rb/6EmBk0AbLqfiORTf4UhrmeEMUEONYscKpioFRPZOX3GojH7uoBJvmmF3sQ7hp8yjcJy36oL8/dJfpQw91dcQVp1kLev3sJ9BMr02FWcxSLyyeV/d6QUyfw3/88KfGxyvJVVqmHrUq+IiGk2m5eVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wEKFfI4AP8ac2MApVKDzRsTPN4+sT70dBKFYCuibTI=;
 b=eVbfFfLLoHdNOJA9TLwS1y77BmxFQ4NTH+Uul4swzEdlcf5AUp0OWacJySIAPLPZmwdmGlMgMeCOdyLxNFuhyq1J95NjP7s6lUq7iHeABRpEKKyoJDuR+lt0gRY12HMsrzo+5Icb5pt4VbPSB1gjXnFbu0geQSN/BaEwgXCFihw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:04:09 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:09 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 5/7] crashdump: introduce --elfcorehdrsz option
Date: Thu, 20 Oct 2022 13:03:42 -0400
Message-Id: <20221020170344.1962-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SA9PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:806:28::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a95ba7c-9ae3-4cdf-e8a1-08dab2bd1a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	UZ5aq/bO7z/0n93rxfCRDqx20x7crNF+OxWCUBq8xgeWrHyQ4TpgMehepAV6xSqqpzyBoPCSjAfpt5xunWFenjRihNvmrVGya4rlTKoWNEfxQNQ7OcM3vexHdKLDJNKc3uSRMX3Z7JCymp5JbXgUfHfmCjIWOFsnP72i/izkNj+TmqIJ3lUStZrGEt6p+MwM9niLD9YhMYL8Ky1kNxxP3s5eKZE2hY73WrF5lLJmyPBOVAiCvl1mo9Q786nm0UuG+u6AQS/xZviwUSv7hSYu0FxEdIqwJff/bgXrJoIPHkFF7kBo+4uOrTwshHHXVC9Kk4j3kmT65peHcGaBhJ9FBLxHcjrxhVvQbQIvkt9dbGjHQUjoqv3LxaD5v1GfxFqhrTbOcrEnmYKHGWexD5+s3tWrTnMEw82AjRi8EzYKjgaFHlxP+Q93oC3eyKsWYkIHvwrZoSQOnyet7EYZecvxcjoJP2QLBpZc7Cv+zqnQ+W71jWASL2wHvzI6Vp5wsbjqECHJOlDIi9wF8J5TVPDej5i8H9r+KjBsxMZasVABUpK8itpZSQeNR0uS51F1Ao3G5hbLtAHyIbRbPMZW6MT6GEwDH4pPPEYGbYGMNSxrUc6ycy6CRC9IN2BuWzJ/gRW+RQB5NlDJlelF38Do9eYklWC4JAPzlgzNcrwdyb2L2appYYTx7MfVxNGe6GaouJGAnzOB7ujm+Rgc0ky8Isql9g==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?M64ILLlNub36xIR3dchtkxFjnT2x2nIqIEbgGJtP0bJEQDAQLAlT5Y95R5dW?=
 =?us-ascii?Q?xMT6ab46C3Rj+fgP2TTfc2iDAjbX4or1uZ2z+MFIi8L49WUgXi4NYkn87wzh?=
 =?us-ascii?Q?ierVIjbIMyFxjf79sS1fmnIiFzwlMTzcDaTfkSduyEiQtuRt/Au/it+8v3D4?=
 =?us-ascii?Q?gx+ocwFGK/xGLaDsSSGdXrLCm5MXdCIV9T9o0424nMqQhyurQTF7QL6Tm99c?=
 =?us-ascii?Q?b2tOKqBU+E013AZnVhYEbSVP+sxTguNFrNRyt30ETjw29lXydFfr5cF6usQw?=
 =?us-ascii?Q?0cUdnYlEsK5cF4gn7DpezfTcUNUfEsl8YeGVnOUQ5YI1SLRLOT0Ojc2RI3T2?=
 =?us-ascii?Q?WQBtD0m8coOJ2hhFDCgQouqyBUEF3AGy1zmf64dMh3FG0XHhmdYaZmIxL9Gl?=
 =?us-ascii?Q?lNDgrWp9aSVWE2HmYS53OlXYiBiAgE9snBTfqpFHLvxYn0n9SKA5+IxnkmiI?=
 =?us-ascii?Q?QxenC7hx3lFHV+diuNmXsmAPEO5e88W7tjIdLSeVbCW0CsHbfAeghoeC4cV2?=
 =?us-ascii?Q?/WhzWZk0JoWf+jBngJzek2NNz1zd4vO13PEMc9gwhkrLsWv8b0+fZZO/Wopf?=
 =?us-ascii?Q?RQLAaldMZksnl/82bwJ/yyAkJGwcqvW/OlhMwr+cxzUNZQtmqDsrTLFSGAW7?=
 =?us-ascii?Q?/crEW7HJRL3tif3TTs2ZCsBi2MjIwZr1kdmypusPd8gamAX0PTVj1/HALJxM?=
 =?us-ascii?Q?BNLi8Z7MTQ+d86yWG1GLDLzsmwm03SVUA13UMVFi4DqtiFtXQMNnc/CndIgN?=
 =?us-ascii?Q?Jxxoo96sqloZvgzICEfPQI8g5iCB+dqPCTNw+5cpcp9fFSbsAR5e9m+n/HtA?=
 =?us-ascii?Q?oQHL7tqCVYd5Yez9ZPFliIZuu2yaWNGZYA4w5lsaY1/WTWR/rOkfJX/iCnck?=
 =?us-ascii?Q?XZg9L/eWaCqMr3eSXyk7cOB1B5lH9Wrra73SM+s0R3sB5z+aUkBhHOylVNek?=
 =?us-ascii?Q?LBCz7DtUovFedMmaladA82HHIHYMgEe3Cy0fFkTf8whc5+7hYQSv8dwH/hUV?=
 =?us-ascii?Q?zt9DE0FCfryQcTukXFbAFDqpMARkPG6144xvXgAs8Lmbfc3eZDINGxzyQ5LM?=
 =?us-ascii?Q?99ty9ZL96i/iFjjRk3J6rP8eWWUMA7fMe2AVTHgS8QIUEicRWWQl8sFMxACb?=
 =?us-ascii?Q?kIeofv5qS7DqfDcimmaVEptm8gf5XlOXZvxkKS3gykiXRPSCMdSPUq7WmSZH?=
 =?us-ascii?Q?2+b5HeTB7J4U7xGvmLrTJgzidEHqVWDgmamnRTwaUy9pqVc0fOFCI6fIBxy3?=
 =?us-ascii?Q?X/B2JH9AsqN0MnwPmkQ2qnIG+s9/knOYY5hIcSMYjy3Zbb+UBrrBkYC/wDxe?=
 =?us-ascii?Q?/RvagNoVbAYzdAeBL9rqltcBHK3diirLWsCu/YmzjvcuM5EpJVzFGkL0dMw6?=
 =?us-ascii?Q?h36ni9YyZ3CEoNwnGQSgf2RXve+PW07bZ4nQsn1lWyERjp3irtSJpFvcgZIA?=
 =?us-ascii?Q?dAX2qfYZtZyOOVpcfnzKhSE4qG74ztz7wF272pJTOz7HKN9o09TKWI2zHHLb?=
 =?us-ascii?Q?Mz/xwp0GUaQMlPGGVwYs+f1g4Pbj7TGrM/JbRlep+3DYzG3brAmuMDgKTbEu?=
 =?us-ascii?Q?O9GEeIdAEeTT7AVZo8l68GMLeE8AkHglyDLPd5HceakiOVCvRkqrTcv+CgWs?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a95ba7c-9ae3-4cdf-e8a1-08dab2bd1a72
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:09.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXzTEsVenzbovwqTXuHwdjet/Z5W6e6pzBntGLqHqiCeX3h19+NvMVFSYwYuoepXhpqGuVARaQzOoXjSOH7cpe4BoaYlml0/hbcH49frqHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: mQNj9teKOFMDCg6EUAzZceRGnbOqMikz
X-Proofpoint-GUID: mQNj9teKOFMDCg6EUAzZceRGnbOqMikz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100414_486647_A04397B0 
X-CRM114-Status: GOOD (  23.27  )
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

This option provides a means for tuning the size of the elfcorehdr
buffer segment.

The motivation for this option is that a maximum-sized elfcorehdr
can be several MiB, whereas a typical just-large-enough tends to be
several KiB. This order of magnitude difference may be unpalatable
for some users, and so this option allows the size to be dialed in.

See patch "crashdump: create get_elfcorehdrsz()" for more info.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 11 +++++++++++
 kexec/kexec.h |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d2379cb..5a54c07 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -63,6 +63,7 @@ static unsigned long kexec_flags = 0;
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
 int do_hotplug = 0;
+unsigned long long elfcorehdrsz = 0;
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
@@ -1080,6 +1081,7 @@ void usage(void)
 	       "                      0 if not.\n"
 	       " --hotplug            Enable kernel modification of the elfcorehdr, in\n"
 	       "                      response to hot un/plug changes to CPUs and memory\n"
+	       " --elfcorehdrsz       Specify the size of the elfcorehdr buffer segment\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
@@ -1591,6 +1593,15 @@ int main(int argc, char *argv[])
 		case OPT_HOTPLUG:
 			do_hotplug = 1;
 			break;
+		case OPT_ELFCOREHDRSZ:
+			elfcorehdrsz = strtoul(optarg, &endptr, 0);
+			if (*endptr) {
+				fprintf(stderr,
+					"Bad option value in --elfcorehdrsz=%s\n", optarg);
+				usage();
+				return 1;
+			}
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9675e79..ae55d2d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -233,7 +233,8 @@ extern int file_types;
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
 #define OPT_HOTPLUG		265
-#define OPT_MAX			266
+#define OPT_ELFCOREHDRSZ	266
+#define OPT_MAX			267
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -261,6 +262,7 @@ extern int file_types;
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
+	{ "elfcorehdrsz",	1, 0, OPT_ELFCOREHDRSZ }, \
 
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
@@ -299,6 +301,7 @@ extern long int get_nr_cpus(void);
 extern int ifdown(void);
 
 extern int do_hotplug;
+extern unsigned long long elfcorehdrsz;
 
 extern char purgatory[];
 extern size_t purgatory_size;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
