Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECE8ECAAA3
	for <kexec@archiver.kernel.org>; Fri, 26 Aug 2022 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XJxcexrjGh3vJIpNjCW/M3iQ1IccGZXoEjmlcmP8Pb0=; b=G7Zn7d7E0/Djv9
	5jnVjK9pTrIk5raXt2yikOrYF2O+jGXCIyVi283yng+UOI0SpbwO1w9qATc6CzRBWsutkJ+P/RZ0p
	d5AHhCC9ChVsKPh4lchFdVCr83B+iqx7bACrph2vyxAFF1IZlkaHmaOw/PkQDL2PaNI9vX79rLLNI
	CMfZuHnMT+/USja+zWwjkJ+azj89c8vluuZPtR7PmsQf7JLiiPzYEwQjNq5l1wsQt1UzvcIxy7jZx
	oDvImD/jFZYKZo1gGWqifXqF10yq6XD01wr1LJTeyJm9HTXeiGZQUR9x4MZMImz2SEmDkuP0rYjo9
	Jo9dTPPIKKf8/U36VjUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdHW-009D5x-HN; Fri, 26 Aug 2022 17:38:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdHT-009D3G-GR
	for kexec@lists.infradead.org; Fri, 26 Aug 2022 17:38:08 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGUOQl006856;
	Fri, 26 Aug 2022 17:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=TAHp6KVp+kMXnvqyy7hwQsABFYutHgvMl9pVsZRWiyU=;
 b=GQoOjUJDYtXuPlBTvC6m36K46SHPg2t1XtNNI0dyjZDQSk50j3N0ui9/1EwRg8HiB4BR
 L8WVv54focfRtoiiTBC72/kFLo2vfiK28tdt6jrBdfhxKaWv9wCxu5tEUothGIBkd6j8
 CHcbri2YQrgI7SHDHiltU+hpC1M8mGKm420FyCUmT43DEZrOWlnXzMtilx298gBSQnUU
 wyXETx0u+1ZKZM+Q5bkWa1dJ1y9AYYe+vKS2uPhauMmB5wUbSUwpO2/NNOtOBJiQN9g2
 jC3wx4FtU3r/c/V54dwY9jsBFfNYGhMkecWWW2JWHmKe8CkhK5/rqfVZFB++hVvp7byn Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w2429ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Aug 2022 17:37:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGmrwm029877;
	Fri, 26 Aug 2022 17:37:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5r4063-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Aug 2022 17:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/ASAFk1vWBFPN2sVrwdOCDk3Bz6jDGaevrg/3pnF9SfIhwW1l7H+42zgReYFInXZbWB3iETFUbRP3gla+MJq+yleBvEtX+g7F8mbmudqoiWsoveSzzM42ck9OS744owEuUAS/ifbHw5Gbl3HDnFZyguA+a8u08m9Lt1QoMpSj/Jy0seLNV1tKpaUelqsY8rx8axy6oTVuBTfiaRTYzJqyz2hlLfDcMzdyoIwUm6t3NjzyP5j8+HMX1G0lXY++l54aVsmHe8Rc+dMHAcik9Kjp/sr52eubjVYv4a86fVatzBiUCBRAGlDK1nqD6mPx2ynvvWgEHB+aq/L4MW7x289Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAHp6KVp+kMXnvqyy7hwQsABFYutHgvMl9pVsZRWiyU=;
 b=itOHFTE8V22RXBVEMG5VOQJoa/E8UD/i+gVpLnuUVKsoCt5/2mrEwyx/aC3TJNZqqiuLUjmcVS+GD0oBdFOaEtKGVZK2EGkjPKc64OX9dBuHWnqah0P9MI8+7Ia4ymbvRztV7lPoId5mtxAgstR2IC1vTVRWPbl2IanQL5YGNUPdv0jIY/SaYgLDariwJwwdtpnjWHCxWU3bY4Fp2YIMgpDvKtbg+/GJ0Fq2VPKhRmlYXhWjXU9uH+BNkiQH8OAgL8yLWsk0B1lSSrBIMWBo/87rHu908ZvflW0POqxNN1BJ1849GmLgGvoUyN3j2hpqW7cd1Ul8+Oj5NnLoVp+vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAHp6KVp+kMXnvqyy7hwQsABFYutHgvMl9pVsZRWiyU=;
 b=nj50Lpuc7W+qgC2/h/Y+XbEPCgu7Te2ufYw9v63S/iI0yVjSq/2iI83htzX8GJ8jZfCDrDhBj7/onehtQUvkikrSyjcnEI108tu1dOQtSjMHSZWiiRMkjQZx9N6B+6PAtccKqoPTBjzgGP1c1xAkxl1oo+Gq0waHCxW0c+Xu6xw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 17:37:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:21 +0000
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
Subject: [PATCH v11 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date: Fri, 26 Aug 2022 13:37:02 -0400
Message-Id: <20220826173704.1895-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
X-ClientProxiedBy: BY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::42) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08bdbe8e-539b-4bc9-0b21-08da8789a18c
X-MS-TrafficTypeDiagnostic: DM4PR10MB6231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/m0LFVAaS3OZ4KVTbBHCcKkCPdEFsq3tzsdTiJdSOH8tn94CjNCQjGXBRhxfAzB9/jBDNwItiHJj3q65vOATEHmmEfxEH7iAY/72WgjKzR3RNr5Y5XYPddGmhkQNosXwg48PWns9oEX8TddKthKLOu7b9hamXzcFqqOpOTR1Y+lW/3o4yjv0H8ONulcBrbHA9Yv8yMpiQPjU+KE63OaXd0xLyR5o2D1N29vaYR2utpjI17WH9iv4fRbVCUUISU8ljbuSu9G99ftflKg3RUAmXJyN1zZCenlOsGMqtS/ZjHmTdG2d6nieKh/rAInzLAoGljRSjuBk97x6RyYrk/CqcICKv3cqJA8VSNm5tf429NYSq1J397+vg9hDaaJvlwJnk//m5nKc25j2r8+RLjYI4FACfTBPS8tHN302WkNOW1Tj1T2nDY2VlcQH5nPnkrBaiLdnbWSi2G55w9DEvyg1XevVY2tJ3pW79XBKUAQ1QDRrfFOrbH4McScfUzC+oYBltIHGH9FS8gBD70UCtvNtCgOhHkY7e5KfIO0b/PbvNNP7F88TWOsghtgkp20XlsGmvGBV7IEw0VGNBKFekdXyyk+SMMrl9mXYaa7yWM2UtjvF72cs1HS7MsNh1cr5FOYf2hA+tnzWtp8upGgICLvBHOl96Yvf5dCJwQp2fNZhJL2dJuWXxdA/ut/7FVoCObhcrcOPvAnYKP60ls1wNNaAdw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(396003)(346002)(36756003)(5660300002)(86362001)(66476007)(2616005)(6666004)(316002)(4326008)(66556008)(66946007)(8676002)(8936002)(83380400001)(7416002)(2906002)(478600001)(38100700002)(6486002)(26005)(41300700001)(6512007)(107886003)(186003)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?pWdSWKpzZ4Wul7MEjDvIO3exqrcnRTeN7TA+yNUZ4HCFQoPDUlIyNH9nbFxg?=
 =?us-ascii?Q?9Mh0HjPHAY5GzMClBfoVqix7wAf2bISM2/JJajqW9xokeJlUU2Qhq6HonS8f?=
 =?us-ascii?Q?ddg67VVKG+aTvWj4atZxYAdmlOEmkop4fAKYEtQMcBgObTbKgZ51K0h3DQrJ?=
 =?us-ascii?Q?8n2k+T3O21J0qUFDW8IMQv4SQIC663U5pLjE6DIHQtnVFwZoz4Ao3nwdp1SU?=
 =?us-ascii?Q?K7Ne9q0GlJXy9emzxmvRBMniOESkt68Y5S+2+DpUfJquk5IlDsbhK3qSPDFU?=
 =?us-ascii?Q?NU8F712p4qj7LWk/cjeMd1yaM+IS1hDiNSr6IqRfQ2m0BVmH+qAB+53JOB/F?=
 =?us-ascii?Q?uXAd+A8uREjN47uO2XMUypi7i11f0PA+tPOps3/+55udIhYlB+/56zky6Lfi?=
 =?us-ascii?Q?bv1qhoxWH5tMX2VNKrLQoZmiyY6xka9TQ0xeT71VtzVCK+Tls1W/reEQd21L?=
 =?us-ascii?Q?24WDVIClhYLEIBOEtgGRhUQN5BUHzdMhqRCx3k0VW7wmJ+5/vcqMwRyySKt/?=
 =?us-ascii?Q?wEXRPD5AbH7hXesDJuGaDEH5B+sFm5aOXlhk5HjtAJii55c1xI40911QWZW3?=
 =?us-ascii?Q?uUk3PJjxY9HTjpDyTCdCPff8hFN64IRBPSBbtONPpPV5AbPFZLG6N7vl/R12?=
 =?us-ascii?Q?2bzCvDer0ZEW7yCBKW0Jeso9ahgBEJ6chiKhz8T6kmaJj85G3bnwCARzYbX7?=
 =?us-ascii?Q?MiOXnsiIvwMKeiZ/4A6EHVSc3p5hihfEATcBFiQnUjDRNkuMntMMt4UaO6qs?=
 =?us-ascii?Q?v7uYtzrd3wO9kby2sVYeHdmmUfrVca5lwWwejdDI9gB87HfeVNReW0FNTwkc?=
 =?us-ascii?Q?ACCUnsSeIeGyJ9LsZa2EoI2F70isn8bXtx/zy5CCUkfvmM1ttzpc9AmpC20P?=
 =?us-ascii?Q?uRvEil6OPg4aP+XqOqG/KqerzpZS2TUv2zGGPh6+iIfzG5j8UszkXzqz7w8t?=
 =?us-ascii?Q?XN+H5Lti328doWskE4sTmMgVdcdBvRD6n//iBjqoah0GfDNvexdIlmC4XTbd?=
 =?us-ascii?Q?pGAQJPM3aJNzmbqHUIFBZv66rhwccsKfdgcz0JbwqrPbkcNvdC9hw0ldxcXl?=
 =?us-ascii?Q?ehWpjf3kwJqWnVDLl5KBEMmdw1N5yjWEgSngcm84muBoA9+X8CR8lfazHJMZ?=
 =?us-ascii?Q?bEEsZbjgEo4URXWNB3irt2QRFXfto9WP7ZowiQ0BOb5ssEOEuPbBU/t4Vd3i?=
 =?us-ascii?Q?vczUTn8uJg3VfsSnhXOdydHiv6v5z7zB6UDyO0G1kUUkSp2VijwsTJiokvs0?=
 =?us-ascii?Q?1HBp+wv15xMVlmWLTuROGjBdSXb+C7LWZWC78LgvA0YIHRrLBiSwefBe2i5M?=
 =?us-ascii?Q?jyoHI/VU2fujm7fR48XR8NJktPhChGFSsLPr3mx74AsGimURpvreeHv9QPk9?=
 =?us-ascii?Q?nkeqR/G+aM4KMQQ4dfuaW449jtYzxLePPFluPXHbBgoxUnQpv0iENZQypb60?=
 =?us-ascii?Q?ZH34zwVeBhuMt0ep1QG+ZiGuM1m3irFJOrnkheAQg0VwWcu08KkK6WUp86fc?=
 =?us-ascii?Q?ITPpr8i70bVAEP0piQlE+U6ctWZ30gxjRpBu8Fjo43HaADR3Er33e9hgMaMM?=
 =?us-ascii?Q?tNJ3Gw9lhAkvAEr3Mp7NTWvWzb8qaPdMNRj3ZE9cdvX6jmOJn6hqRsnULOH0?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bdbe8e-539b-4bc9-0b21-08da8789a18c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:21.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s630yDGSY7J0pHzZYFwiwskVfy5qh/JpEO+fsJuma8oAnGHijVAkvLDVH8LwVRpYw+HV9OfMGeP3qVyE5WFzOcuIUNIdqQ8bqpfsU9IsWcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: 66RU685OCkcjErD3CnqXAVxh6Bix4rgD
X-Proofpoint-GUID: 66RU685OCkcjErD3CnqXAVxh6Bix4rgD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_103807_568449_129607C7 
X-CRM114-Status: GOOD (  18.54  )
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

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 455150205ded..2f84a221b370 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -681,6 +686,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 		/* Flag to differentiate between normal load and hotplug */
 		image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_handle_hotplug_event(image, hp_action);
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
