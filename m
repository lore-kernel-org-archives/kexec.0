Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B59E82CBD
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cE+uWgVdSAYq37NN2mZ81hDlwZHSoEBU3HD9gLjLQs=; b=STFBg5ynwE4H2w
	ctXJX3fu7fuu8XEyacmu9Mg9LZ8BqMunmtB6Uq4Gsoy2y6X8CMxEaZAj5hK1H/gdmKu1TkJlDIn6Y
	EDoiINm/ypMynIrbEmOpqBOy6JfvuL2rXFdlrSiJcgGTBp2Ix1krSVWtP230N2rqobIYPtiu4KSYs
	+rV1rwgzlt1pOlGl4CNEXkyqLbP36H8xnX67LoHG0nz0zAMsN3u/OTLphAsT5T25IJxe4ABwQYhQH
	NwdAnhrx2VelSUuRHI96UNf+Omly8mL1c3QaUcZh6FVtJQDDlTMVIc9iib5ZdOESJI1QKPBUiDVqp
	8qt1LYah2BpuvQmhNIYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ16-001YdM-27;
	Wed, 27 Sep 2023 18:12:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ13-001Yc7-1b
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:06 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGxJx1002671
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VvR2ZjvXjR5vdGbJRuTs2bLtVHI4f06AfrBz5V+977Q=;
 b=VDSjTen7wYzCzHd79nPglex/r3N0V75Y82hSDrNivGGF9VOciYqPn7EpImqftGcXBWZA
 TZgBbBRzF3jASbv+pWHnoGcLH2uFzqpmZ7XV+QH4ieYqumhcFrTwH5++TH9k0uGrpzRj
 FkJ4sWOnnc73CFPloIno3nd3zKvix4cFeQ/wfZDHG1gEWJZ5Mm8iU43JPH9ilVAtz/i4
 YkZMRn7dL0XFxVIxiOKd1ta5yCYMkA5B2OxSZZtuSlMBmMpLYRetHY5zeONQKHOQK1sT
 1liQ57GoC2tovNl+FtPZN1/xNlyBl5TXA8IDgYqtQy84uLhB9OWwHXq0zCKKxr2JQcP3 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3t9uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHAoBQ030618
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf88syy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+NBcsRZUgD9ZImBNWwN8icrSR4haVPtMCN37R6rYF0PzRtSbz/QZGqqC/Cop5wPWxD4mVnhiZMsjBOxDaReYqBBR9k8XwXlDqqtx5bzuoihbgaYdAULzgcl/Z3xL4Hr7FWu90iRx8X8fkSXmgSJD24s6VCKZQOntkkEVUqerTWAOZhrhvC7Baq7K+cL4aj+NxSIPib4D+icnLnoRPVUQxjyos6nUHiZApVNd9YGMQeFf2HdknB1KI01SrVQwp5yGz+CWorZelZY0ol0tUInExyefN3akYxqoB6OVwbrCIuEVJUyHYursxWnxKspps/GNLrhwnW02xw75fp+poiRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvR2ZjvXjR5vdGbJRuTs2bLtVHI4f06AfrBz5V+977Q=;
 b=Py7mC9VL1oN6PsKurd7MQuNEFY6gyNUgSmU0umSPiRkILT8xQ87oHuXTw83wVg/4pHHb25rMfa05YeGtD7XbENmDt2YHYIn+N0QGstwu/tiNunG8ClxCGdpP0cxUBvWQdMenXX9c2mfLo49cMJQ/57OQ9ZjoBjxRyTodZpJf5SJtmKTRvpRoaUhXCDDlOZ9KCBarQeogUFLqCiiocSCUin6NAD7MQin/hrK2aHQdFx37nHF7u8hx+B4yqZeejqzzlxC+1MYb63RCMvVJdYypIZgo5CCHVUJMz9LFhVxltYjY7+nXSCeG8DzSoOnzxq1OtRp6apTza/R4avWJ2RhHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvR2ZjvXjR5vdGbJRuTs2bLtVHI4f06AfrBz5V+977Q=;
 b=geqw9VKx/zJ8og9lpYh1rexhqVcgSpeDcc1A56RKgyjjK2KJs4aujjJMvCUfupFWq2dWjd03APi7ZwmfbsbZ+bxxxyqreiV5Glz6md7ev1u610iCrUD8q18g3pAqE40NJIj1I651HkC/KO/Z8sd0VW+Udd0YnNk6Gfh75VA1MeM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 18:12:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:12:01 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 4/6] crashdump: exclude elfcorehdr segment from digest for hotplug
Date: Wed, 27 Sep 2023 14:11:34 -0400
Message-Id: <20230927181136.2627-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::33) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eed73dc-d90f-45ab-6000-08dbbf853f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m20jFU52qnN5e7c/kGzLm0ct3yYPpU/8oo3vht+dl+Mvdrue75cPaWucKjopZBOkb7CfzV0jnBaE/SiVbQegY1iUoNxsD1vO+ODFkwwdfkKjCka1hWnQBODXgPxmsLmN7FWReSDQuFmfQS/XY8GvD+Xvkt1hZBxsF3DcfjU05XwUWMipvGAoUMS0IctqbtxCPv1+0U0P1LdaX/IkKe/ET5iULIWc+lbOnfuLp9sOHKhJMk4TSMJPFxXB+2PRiuFOs3dEXyYlaWeIHD/AsADngwsEDAAgulhpliz+b8OArzBtaRf3MACRFqMmIadpV/Npmz7j9aY/lKIhqPbzbNED8/MSz32ZEzj3AztmwtEZvDQ6zkh0c/IKlHlSWamL/upwkYhiHP8t423gZtR3hWP9oEnbAC/cy3uQR2HMo0kuzPHIPuoM0qAWUW3t70gG6++5ifovLe8bW+ZhYGBNz/t/qlGoAFiJXndHsgyHgAXPYJj7ydQpasDx4h26tqjRgtUptB8UVvpy7SO4W2ws+oeZN4Of1EMLq9ZDrqWnmXXtTdpeX11GCOuvpfRhH47HHJP2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(107886003)(1076003)(2616005)(6506007)(6512007)(6916009)(26005)(8936002)(2906002)(6666004)(5660300002)(36756003)(4326008)(316002)(8676002)(86362001)(66556008)(66946007)(41300700001)(66476007)(38100700002)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?peKFS68ZPmfpFKTMAlHA2XLqZR7C1V8YxsLvtcGz8He97Yq1RkkP735spE92?=
 =?us-ascii?Q?c468GVMiOQfuC4CIkyef8/rw4kvKmxy57cb2Bdrq6hEW/eA8XHxx9+XH66Yq?=
 =?us-ascii?Q?ySAwXyYB8yng0EDDxC9FtvJi3Vk/1xhBGd+COqbbpXNifKlXMkvujUOl/Oo2?=
 =?us-ascii?Q?s60UZl25l8cjU47FVdws2RHhIz0KCECdurRP6lLdb976Bn2E4EBUmOAPjz4V?=
 =?us-ascii?Q?w1ana+LetcHIJoj8tb4EhlfOlNdDZpbjkueCbr/eMPVbTHG44bcp31SVwqeg?=
 =?us-ascii?Q?obxXUjFJyC1i+oHIu0P+vyGeatFKtQ7J+X9bsmJ2j9mHzQxHzjyD/vnRJR0D?=
 =?us-ascii?Q?bQ4ltH+SQ8Wi2cQk2fXHjMMiDmjlOszR/RL5nGW075tCI33Rlfo6mLSWh/ie?=
 =?us-ascii?Q?Lw3ftzgN9Todf/mtbmC1jwTnwWzyJI/nzaGmIaqc+GNAYLBRGJg8nKxi+0lm?=
 =?us-ascii?Q?sEfNNzlgKADDWyCTJPorICZkDcnFlW9UaEn+ypwnNHF4VONFFrD7TpJfE3Xn?=
 =?us-ascii?Q?8zpkvdoEtFz2Kd1vFGqIDiRTD0A/zK+P9dUE0hmita/3wA72RIzgA0Tof8hP?=
 =?us-ascii?Q?ArC6J4J+A5Z7yyrSj4Pu7b1UMkx/2mvCNDVcGgBJv2r0lDlfPrYQbp418/Dd?=
 =?us-ascii?Q?OI78M3gPw0y20l5iogecYoMTo3fZqC6va1TfEht0ox/71MEnZwyNfImb5gkk?=
 =?us-ascii?Q?5a5avGWpG4t3BRQrxiJUdFm6vkIPtAACK0U9cMcmBCkNYUs+Q3XMx9F+csqW?=
 =?us-ascii?Q?BTlmsgwAkkBdtWjVMz5U1AyNvfNtHqfdlGl8ohGFB9H0kalG3f0HCpTZGp2A?=
 =?us-ascii?Q?Rdd96QDmXIzCZfT8JKtBXD/tGsbvxLko1c5jpMpRVBHG12oyEgb8EIzaB1yO?=
 =?us-ascii?Q?ErsJkJFuBvA/35F61KQP+/uR7uTDmajYnEq5VDwWev8dNglBOcxpb+89D3Jd?=
 =?us-ascii?Q?hwMG9A8f830p8NG0EZ6HGrf2rtaqfh6pKNoLla5X2oppyUvt0/fGRWBK/NkG?=
 =?us-ascii?Q?SZJvxIl3CnOE1Q317LDCwW6oEuLFk9c+nc2MVci2FbYuo2r0enKZbrcA+/LP?=
 =?us-ascii?Q?fSKZouw7bAznAK/MsIox7S5sRufNyKb7XDm5BwnxrNNYDRPin+bxy9WTAfTy?=
 =?us-ascii?Q?2spER4ptOJdShON4UNucGp1q79hTQnZI5wGVS3VJTkx477zyje7pqtPNWm6Y?=
 =?us-ascii?Q?p9Du7IjMN4/e9vygC8b9c3SvdlcJkhWtzGW0Mfx+FDL6XvIqHAFWivZsagzh?=
 =?us-ascii?Q?LoIckMY3L9WGl9ba+K4Xy6y8wh27P2EE6mS87lH6b7hMQ5lk8cb99qvKWyjk?=
 =?us-ascii?Q?+O7wpZCliD2VkB6DqjudkcS5CQLz8z2iiGzpdIy7UPeS42cAw0cNrO2HCRY/?=
 =?us-ascii?Q?NAqmF11ZGOtGX+nrUUpt+qmZGi+djr1eOISdM+uKvQ1xeZnpSd0DS8nHWOd6?=
 =?us-ascii?Q?p/iRFkLGrhZCVcTcLVJyEbVKimjjYZF9k14hl9zTCoYZYEZLsgRq1Z424mRC?=
 =?us-ascii?Q?Q638fHuGDuHsJpkDe8lqhggoRcUARjN3/T5PsqZ+iZ+Tn4htenb3SuFUyFU2?=
 =?us-ascii?Q?XGKyjiq9ghsbMan33FxH3WnL0OPARWPpOVGQeIiJtcsOeeXtTdFFzWdjelfx?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ldzYpBpbg9NrytXSIJ0vy+/aOijGXDtdzUB5Ept7mT2PBrUFYQIxx28m7erXpCvdwOqnk/Lr9yHE1YCtJH1csIfZlFmeMlo68MlojhASGyN4vkH6Ge/ps16DRVxZnygW9pj0YYoSBHvOuE8TvTAcJesfjJ6o6Yd2l3yqlpzTGF6sx7gTzFxOlcxVCt77BHUx09J0m40oQKB6XOA/azpNT0v2cpWpT6TLeOqimiK376vt5xYydlJ7fBU/MrxtuQqxiz0BD/JVTl9mFd1Edhof/9+Hz6LGOntFN0PoNBLlwpPz+RbMN+BOSffYM9yKDZenEEJ2TJmhq3v55KYUZzK54us/Ve64FWjm3N/zhVVxN/SQv77zo2blRRP8eiBwFCyTl6n7Fxgh0uLabI9gTGK9IImdAegIyuDvwzeLFAYuwWQPVUiykJv99BOVhIX06SI9LzNppOsO+G9+OTgviqdzfgE9yBYMemBO2DKkVZLbv5o7H5Ys3J98y1iHBXWaufBEU5+qe2KhnOWJcn+oButhsCWk/Wv5JGdFbMn8IiUk7MT0e3bXjrvXyd/umE4oKBTiHNUaM/2o/OC4Ok3NbtZLQNGVfWszUbLjX9aymBdwZixYoEgxyJz+uKiOCjO7USN5xTaiqTmfU5lD+mksgbk6klWSCOQ1nQAR0fULH9C/pW8aSZnyKk0OvvDTzGkdOhZJETWcr0PbqJT3Gw96k/7/jWV0k0MgUwcbmktKP5XKwld7acEiOn+5uMyaRjG9xSJlNxGoGGmnZcxbDBFo3ghVfg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed73dc-d90f-45ab-6000-08dbbf853f34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:12:01.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtSoBiiVRTrOnNEaUfM/AqMTmYr6xcrXSGSts5Zgc0g/LVy66qtPwy4RV+lHLZt0K9wfogN3KmCYsYV65eHxWT/NSELC3Jp1QVVcJgTyvBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-ORIG-GUID: OBpfVxgewJtpHrXkwcx0SsY202hXY6kF
X-Proofpoint-GUID: OBpfVxgewJtpHrXkwcx0SsY202hXY6kF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111205_651797_07E138D1 
X-CRM114-Status: GOOD (  19.41  )
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

To allow direct modification of the elfcorehdr by the kernel, in
response to CPU and memory hot un/plug and/or online/offline events,
the buffer containing the elfcorehdr must be excluded from the
purgatory checksum/digest.

If the elfcorehdr is not excluded from the purgatory checksum/digest,
then at panic time, the checksum/digest check fails (due to the
elfcorehdr having been modified), and the kdump capture kernel does
not start.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 8 ++++++++
 kexec/kexec.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0207608..fdb4c98 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -689,6 +689,14 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+
+		/* Don't include elfcorehdr in the checksum, if hotplug
+		 * support enabled.
+		 */
+		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
+			continue;
+		}
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 487f707..1004aff 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -170,6 +170,7 @@ struct kexec_info {
 	int command_line_len;
 
 	int skip_checks;
+	unsigned long elfcorehdr;
 };
 
 struct arch_map_entry {
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
