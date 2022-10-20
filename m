Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA231C433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AhB0KArLc9+KP8ucqbbCf4dZMknad+OsI3GQOvbT+HM=; b=40gaPR0Aw4JCmR
	Nm7ZSXPsRgNZBY016Wdz6wV/RPq01Se4J1x8CeqPkjLTk5sdy3Xuflv24r0pFcwl/WDlGUzrfjn9H
	dD5NN1rLMoAH/ws8g758R8Pz0BoRhA38BHoY+p9GCyogSikhedm7wOU/kxOs0rXf6EzH11j84F/dy
	cFRWYM7ySGAb9Hkxy/MWIyeOqkIVIYxiui4XRH/+RVe0NEa3NWQ/wk0JAinajLDpakWZssXdiGMUr
	WfjQdmxUM2Zkyn1HHZUNEIMKmZrxvKCe1vPTHvLTh5RpekrglVnEvLk89L7Gh/3qswij15erboOoD
	7BuruF4jGjpE0gFNmqqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYyQ-000jtw-G8; Thu, 20 Oct 2022 17:04:50 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxt-000jd4-P1
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:19 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwtJT020000
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DwT5hJd1u9gICNkZH53txSsSL6JXd9askVTMLGAtBSQ=;
 b=oGLFiDRBNHcpAM/fqBBAiptM68t/6f8dw4RtePrecST3cixrCZg2Dqs/pTzANOjYUQpm
 iC3CkwASv38Pfb5hZx0lmKqa4pilw0llPkl6vY5DxjAepNjjAC3anoF5C/0PqF6yh/DT
 5igVjesjLI9WZZN60e1gVzcXWUAy3ObMLwowoJ8E9Rj37OIyD3FRJ5mozf2J1OrJXmEu
 ERnWA75ckAWmIuEReor4niLULZqK2Rg0x0VmsTmoLdZANzGFUG/VTcMGm/r33YM7bQGs
 waEafjxgOabEVfTmczoqMyXhX2F5JD7gnYykw0IkeBnAVROyCIk5nNNEwpf29cWazFaD MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3nxry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFS15Z027412
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjs159-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBnCDEld8rEql04+UXLs15k09xE6ctAbpEjP7Gfoi7DYVp8P6pQ2Cs6e12Fui2LH9f8oK30lwWnLtpSD6NHsjWN8tKQQ1E5IKwI5Luow0deXbaVxuFP8wHGbTLi670c3iqltJpzQlHMkEOe8EZxFtXUYLfMuWsO7A4vcWZjpEiHKy4GISyOEIMMgNxJ3cUuS4E05tuBRECDRkHNh8wEiau5P28gRNgni2ss+fflsCoXdZ0e+gme6BT6gVa7XAN9k4sJB+vX8g11cuA2hqS/6hQXR0gu+S7HSH/2xNmLNfAztPKt5i3gN2t/f5NbIJVB6rZJiPZKVopIqyIoF/6rsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwT5hJd1u9gICNkZH53txSsSL6JXd9askVTMLGAtBSQ=;
 b=U7FtI9zmuzaNk/a8bbsDph2fTLjyuHJBlWQVnnGV1RQ8A1WzflXuyRFooK2VW5r7WOd9chpmDbFv5ZithSwo6viN4BUHK8AP/kPcIAssriRkqNyboMUcggGZmtlUGHUWeqerVLO6lqKZQrPmSOp6iMnmvrKQCV3ssKyJaSR5LpJnt2CN5J647lM+5oj+YGYLWDkfxd0bCr0eihUejJ1Jg9ER6Fr0cz4sMsyGiHLWldFmbwZ7DuiqjnqCpTxIXW/qeoa8PyuFOhwi06qPR86pQ3e1Rf3dO10Qr2cI2lb5AjEC0i92f3Vq3nURFIQCEQVm7SNTbrAUkQVracczwRCFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwT5hJd1u9gICNkZH53txSsSL6JXd9askVTMLGAtBSQ=;
 b=XsQ0c+f8rawW78z/irqbKvnGq8rSZrHOjnq5nf4gyLXWkCXRGXKi2113747/7RLEpR+A3Nmu136qzJqpWZ7AL59GbIj1LMnkBKRr3lMfeIqHAiO7f+Jg0aJJJQNDI6L9kCNVsHeY5qTLfUm4td87ZCwb9zz9B8nR8dj4luKR2OY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 17:04:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:14 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 7/7] crashdump/x86: utilize get_elfcorehdrsz()
Date: Thu, 20 Oct 2022 13:03:44 -0400
Message-Id: <20221020170344.1962-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d50936b-86d6-4dff-f381-08dab2bd1dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	revsccOEff4Rl7mtiuCdAnayT4lyW4wiSBf4uqnaC9U6S6g2wOwJd1WiyVag6pxoAs8jwEnHd6rGA1aIoBqIF9VruXqfDNyG2h/qKySmOYknNmjYti+Hw78U9TOXO+PcNlLCWJo7vKr37x+keOJ1hUAjvNcjVJnI9z8f0yyGC2mAisHwUbfFaBEzvrWV9Ai3EnX6hNCSQNj4guTC54G5x8u2K4WJusC7IyOrKrIwsFKsZ3D1AghhhLkR9QuaCSfoL/Ry6VUndtiRvb6loWOw+W4dy18QBEz8ivUJqxrSmX3kXnE1UvczdEv0bk9F7Mg7fRMNn1LcWeclXejuQqEqW1Uhwf5WEZvfvVrUAPBHwNG8XN02+bGwgGhjv6JnXyGGWRWvgxTNVf9IOZgOLww3ei4RA4OzkYUvOA9bdL9Prv44PFwcdLnLNSIZN+fiKOsek1jS3/Bqsz0dTT93e3OkhLcCwi0PnCAMVilLGoxrtTiCZ6TwDR1baHmYE7VtxFvek4qngkmoTSIAtHJG9S4cyNqBPQpIgK714N1AAeunKD05emhsEag8Rh/bbqczQlfHpxTREMl9uALOKF7q5aJdmJJFv9roOthgLjpRW/Zs2g1Ht/GjPzKIiW1C0ROH9KAAk6DGSxRsd3LwhuiI4ZxOgyWMHVA/mTd1U4jt4PN3m/FnrzLLjZeYZSeJHSsijapycfErusJod7dAslzm4SycTw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(6916009)(1076003)(316002)(2616005)(186003)(36756003)(6506007)(4326008)(8936002)(4744005)(26005)(66476007)(41300700001)(6512007)(2906002)(6666004)(107886003)(66946007)(66556008)(8676002)(5660300002)(86362001)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?8A9hsDpJgEAnhoiPPnkrCCsijDzY74Z86k/orNgCdrsEr3evQf1piwUlZmXD?=
 =?us-ascii?Q?chc6FTwfyhZSPuWE28kJvkDXZG9DZSIYFfgWny2T0MQCfSrQ7nI6rLcCeGpk?=
 =?us-ascii?Q?xehHiJbQb2HiXndncPiYSsjviPQABRaRHlsFa8jwRGcy7AJuLTqUz1g0KcP2?=
 =?us-ascii?Q?iE5z3He/tFtJ7RO46NJw1vw5IqKFt7W9K6BnXTPkaaB+eBxpn1L8DTn7wo0Z?=
 =?us-ascii?Q?MFJhnW0qeiWPxfisDaJQdL2Sc5rcVVocEVcnLohts2B8bNGRpIQiBr2eyREr?=
 =?us-ascii?Q?AjOviwbICCPLdgA8PZu1YZtYXpyVKaLwg4i0uPCX28tmKW9PSN02mrg+dUOy?=
 =?us-ascii?Q?JHTsxGNcW8mvNp+BH+e2MtPUrPKn/1eHgob+7VPGmlQcy+9LVXZ/ieEP0ZGC?=
 =?us-ascii?Q?LExv3P76z8v/Qbe8tH0LPUpkRC0B1f49b0ZzdgkRDsKmW7NjNDWV4SQYSV6B?=
 =?us-ascii?Q?ItDmTGBlFuCxeABCfD3Jt/FyDhxQQzbF3P+x/P3guiI2N9LhRZz2Ztf/87OY?=
 =?us-ascii?Q?yUEtAiNWwGJv48iNiz1F+/Xo0a46aWzDUxIDWyMtXKek8dkbylojZxaOgAR8?=
 =?us-ascii?Q?0pZL2ldROzrG/cIvuoI3uqXwcuNpk5X/mNx+aBjHc9UnLOpL/zEkqAqgkPh6?=
 =?us-ascii?Q?L4Vt+APS6CC/PbU5/dali7XN5F13jbq+MM7EUNpLciwyo1NZlemObtqx6ESC?=
 =?us-ascii?Q?xcWSRaApILC366JC0+GQjVBSa0pL+Iu5VcZpwNFGYuXbPA+zpdsW14pSxjXA?=
 =?us-ascii?Q?0+qGKWxdHq5NzvkZAvv9Ncjq0yp9XKBDa6iZ4PLUgBm/sAvETQIA+jajJJK5?=
 =?us-ascii?Q?OJUYv1m+/KREZn6OqUGu4/WEGhN/NOPTmT1iTCKr48q+k1vHHKMcfDaLU1K0?=
 =?us-ascii?Q?L+Atth4WYq/6UYy2nIZtJQNdyEsD5qYnf1NPKt1cxeroDqhKuAkBqffl/dMz?=
 =?us-ascii?Q?Xj9NOrtyCj2bHRwMAI6gbD9zMTfMZS3PwfoqUHYBaXhhcqD2g3zHtoPvhFIw?=
 =?us-ascii?Q?wKiIWM/vh9lnJCMg26GL+ifyc32l20lwAizHcNzDbb2Yj2JJVMS9E6oX3yqR?=
 =?us-ascii?Q?1xLnAngzg1G07DxIIAuBOD2g0CvlIEf2fAkX508nC6uobtr/DbxbNwKwcMWZ?=
 =?us-ascii?Q?K2Ka5snxoUsFr1CqoLmJitya65wxL4ERBTCflaknZczpdMV9TWZ40Q76HNqK?=
 =?us-ascii?Q?8F7KgvpyATU/8D6CHWG3zNqIMk+f1WIexgUL2jIY27jyJapxlB+sAQe2BVUl?=
 =?us-ascii?Q?G2CmnHDA4rGH28iyFUTtocN3ViA/f4zmhxm6YKr8sylKvSOZ3WeaFlT1+7/L?=
 =?us-ascii?Q?ulLxlfVn5HDUWw2leNnrjvdrk/a+IH1cDX/A98yFDCMUNhXl9mBR0oOid//a?=
 =?us-ascii?Q?fWv093zsUO+YM8pXmk4Ka0hHQ1bHHCFd8XujISCmEO+/DY8gu5wq9K0U+957?=
 =?us-ascii?Q?EjILlStGfcpLnId8lMQZ9jKDqzytg+CAVXzzuzWIGSRIpVwdglufsGZ7HLCH?=
 =?us-ascii?Q?bFMWSC3kCg3mHevtorndyUakXwBy33KT+fWaIO+EVVXXMzArx3Dm+yGU8p9u?=
 =?us-ascii?Q?/PUVuchpovSxyj/dMXAs7KUAn5FimIijx5tgx4iEKRBA2kis1dGUGXiVMK5v?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d50936b-86d6-4dff-f381-08dab2bd1dbd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:14.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OVbP7ambVsEbyE0rTZW2Ku4cQRZgK6LGYekfEjaZbuM4UFECF6EF+iwo60a938Bnvj5NEeInRLBeqf7UraD2wrDWZP2lCGrpx1LGPmmwzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: a1jbOGvJiOrXa0DUPy4D4Yxce2TCMrIE
X-Proofpoint-GUID: a1jbOGvJiOrXa0DUPy4D4Yxce2TCMrIE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100418_005792_0F7EA723 
X-CRM114-Status: GOOD (  16.44  )
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

Call get_elfcorehdrsz() to obtain the size of the elfcorehdr
buffer.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index cb86ca7..29d4ba5 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -957,6 +957,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		memsz = bufsz;
 	}
 
+	/* Adjust size of buffer according to hotplug and user */
+	sz = get_elfcorehdrsz(&elf_info, bufsz, CRASH_MAX_MEMORY_RANGES);
+	if (sz > memsz)
+		memsz = sz;
+	memsz = _ALIGN(memsz, align);
+
 	/* Record the location of the elfcorehdr for hotplug handling */
 	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
