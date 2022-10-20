Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC03C433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9geoK8LovPwc+pQFs15nNc3vdWHydIhOh731b6ghTs=; b=kahZdxrpDMEfJe
	777qyXLcoOjhvKtRTcm6YtHAlnWpF8Fs/vfRofXEBbwy4X5WF23i5thGH/Jnk7sWEsZJBRavJ+pVf
	85eDNiH67m32VZ9knVauGLvgEvXU124Ln0r1fhLB+U6t2Vy7wKMC63uTzJ49ckRL2XPGORE4/8Zj7
	8wC1Dx6jUEMGbr/ssUKWj45BQDYTWVxRw9mXFJpj50MIeNCZ1SY44OyF7DIfYds/VA/iaM/I9CMYl
	VVIlLskvebsj6BgHfvm0qCfX0NzEDCboJYcFd8G2/OPGv7Cs+1wigGnyeVswqjwQG5O+LfU7yx6ey
	/KIEvCCnZYHdmxrAK2BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxk-000jYc-Vn; Thu, 20 Oct 2022 17:04:09 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxh-000jW9-NN
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:07 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwt29015155
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0tNuhUePoCX5KWiLvHeedt0H4jTzUVj5n62EOy38bKQ=;
 b=K9o38CtOtWLa3JXN1CQHrGyWx7pGvBiuiilOBcqHCHHoBaU7ZHqkJUaG6/U+pK6SahX5
 23MfmYcmVuw00RuyWMfOAG+nQpJUNleVQ/BV6XTX/QtVCoALsQigHIt8J+pv8NWGI3T6
 b+H/Qdp3vDPv6ZsHvp8JKHWCX8iJJndyxSrElp86KXwH4JFlVU+ufWYkk8W44sN/qD0M
 IxzZ6w5oxa/F9TSGsl998I2wz0Yuky7z7OcoYcgGS/oADYozQ3TKGhitmVBl1CSn1Wvd
 G/BY4QZB8UZHv0cPUK+buWHhpWBw3FB7yBHMFxZiLAMaR31FRNkNo00Sk+AEqnuc07HB XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu065r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFRLvF017110
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hua1h5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9xfaGftm2tpMlv0YbJ2SunD5CAe06hpDRcVzs2VVsLGk4ruxWFTmBnP9YYudjVw7+oZ8k4hAZHQRjuNYEDu2SsrSubimBzwAzOqCydxbKG5nJXyJaadE3lBhYlTy3GgdSdLlazSsw/3w+2PKxDMIM+chWk4ZLX8iF9XcFnTGWsFoz0QOp1bWpGjntotRrelvKI0Fw/Hf1f5/QrHpD9QvS/DhAvwyf1ne5egfZNRyvpu0TIcoiTNQszEkk+0aNqT265YJOzd6bywuTC8FDFEMHqJ8VixJfmUTHWpK5w6lMzxFbWPctIvsaqa09NT5mr79of03Elb1LsziGTbJL3ENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tNuhUePoCX5KWiLvHeedt0H4jTzUVj5n62EOy38bKQ=;
 b=G4IqwX6KtTCRNxNpvUXqXouiAqkce/0LkPKyQz5M/STuL5s4qVtWkE/V7onL4G1xvR3atVPALu5mQ5l2u18Tu/OEQcPCeWi4MaOUr0F2a9vHcW3YIijGnOVF1XqAy7hLSQZnKnN7GVshIB1iAUWCZakWKTQ4M7f25dX0GSXGpippqvQFrWyMotdub638UFzAr3DLttpqDkOvR13E0x3V+fEVPXlNqrF2wHuph1TOuecmebZZUwaMFvVMiET7BOngvw8IoOr99WKh+XDMuhb7KyWip3yLRQg8RzXWFjL4wdduvnj/yb84KXZOD8E4zZDT7tr03UE5tY0U4PBqUZIXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tNuhUePoCX5KWiLvHeedt0H4jTzUVj5n62EOy38bKQ=;
 b=HddunkWgvHmOymnpYZSRrsreXhPXwpmkuOcPLd5kpp5nIPuSG+aylYiqOD94ldn9JJBd0TntKcamONRiaRk2X7im5LHCasnvujPbOd9EQu5KggZjd0YXVL+M7kNRuNvzaVxGOUnhl6fvGB296MK+h7W8hOj0P67xEoSY6uXbIpk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:04:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:00 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 2/7] crashdump: exclude elfcorehdr segment from digest for hotplug
Date: Thu, 20 Oct 2022 13:03:39 -0400
Message-Id: <20221020170344.1962-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e248ddf-aa51-493f-e93e-08dab2bd1597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	JWGnIRDVEYEVIC0dI6hHE5Rb4T+CaQ817nb+ilZtAkbOiwPpWOMK5x7fTXQGYdoMdjTKjLWrYDtZ5uEFIDbozNI+KddypUX1xQ0oz15W09Q2LxCPcHpJ142hyUkOZ8WnDVqBq2gUDoF1afoby3cqkad+l94KPw0/OZUuqWgU3BfQjHqehxYbXRkYFURHE41d9/1JDSEf17IBWfzOEmBJhJqvsXhcf0ccEH7rqrPEd3RkwRdfZIzqNP+oX1wnCxqhSpmpndKKzo0QYq16YbFL4YL+ziZLyQT5AUsMFihbskP+1EJ0Yto7+RCcCvcB9ff0odBComF8Oaqf4DbRW19oUwaY6yDjyv2BBQzbCF6gLyZC3RmT1cyeJGHLoKaDxNV2hzm1z3Lbop8crnpahj+PASuEiSOe5C6f00kXFsm78GkCj1W59GWnBc8X6y6DNCTlTLf5RWPcw/HQwIEh1e4CwTcw9M7usviNhvGWd/Cl7ZRPvDsDKS+v9/jrPJdS4vJIYCHKCOImC2cfOVJJ5koPGGSa938uyeMQEICtuXH4Elr/5NSL5XLZPEOCDCMXmNR29KnzecSapWwD4g1XMXSi+XgRm2oY+uTLb0w88GNSi31Hjj/cCYCk8OMG+Nhf+BO44NySrT5N1VVuV1eec+xWKr2p6lAd+BsaVtgirhaij1f1ShhM7HmgSAIA0qSRkjMv0pXiy6Pveny+ZVe7+Qc/PQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?XbkmcQB9KkSzrWdczWPivpCMHx3L9rltkatNuCAdMXoIcLlyEN8AyFYAFQrV?=
 =?us-ascii?Q?fziFiJsGStE3OxrJknfp++K4IxDySTVQleMS/tq7X7D4Swybj8F5euq0BtmD?=
 =?us-ascii?Q?A6f+gmU4w3xb7pT7vLrQXSPLpt46/+8HBCblRsx6Wy37c2I1ww7ypLrqbrZR?=
 =?us-ascii?Q?30mEzpHhEZ1MKoCal2oj7otVmtu8T5kMhZUvR0LsQOH76ouT1nWnfENAjjn4?=
 =?us-ascii?Q?1I88g5mDvY7Uw87jFjPJVcbgqIvXWbS1WrAV1cy9QcpC0vKYlbt5CN6STZ2+?=
 =?us-ascii?Q?Ysluj+jzosPIEEykuqvb7iaclQTHe3c3dwhPr0BLUb4ScyDF4QK5RzC1kxvG?=
 =?us-ascii?Q?ADep0H/IUkDIeFMCii63KUPFw0WbaxVBGoR69fgUtaDxdIsmHsnFb6CxgTu6?=
 =?us-ascii?Q?0SjwMat/GvuyZnA9SqLZlpmi4GZ5ZJrgMUfA1hLEwio//uMY0RMcU6TUOa7A?=
 =?us-ascii?Q?6CY5Pj8VxYvS+mHH9IupIvvdcliRLOsXCGmB2NHp8dSpL9W9heZ4Az9jFLh9?=
 =?us-ascii?Q?3anxKK5/PrOt15Qjm/uF8uFkd38+gQfYExkEMwXqATpkPL3Q7NgZHW9Rr3Tl?=
 =?us-ascii?Q?vNmhmOl23Vu3UwKPK20gYpKCW7gpbIvIe7LfifxV/leeNIs/Lu3oy199Vmb8?=
 =?us-ascii?Q?6tK57tfM59Vxn7qjeyJ2bjY1q9PITZNi351UsWMcJqMKygLt3chK2AkXL1o5?=
 =?us-ascii?Q?+x10y3odfIrJ7mOxHsodyQzh9SKLHx5kkP46GUCSMSgiCPuFfEO2oOjEmRvB?=
 =?us-ascii?Q?mp+bX+U4ZESPL/CBskhGsaCXK1GX0O2fHG5/wxaMLaMWLprwtDBZ9Im6cKMK?=
 =?us-ascii?Q?0q9MgC+8DiBvX7JMLkFF2XlNu7Pn9HmrzFDCZaHu2DqyyB+JGYWUFPFPOjCK?=
 =?us-ascii?Q?wlQmfYzzgsTLAfchT0E1//rZDsG+sB0yc7aIP6wrmHMfF9Xnbq2l08Zu1BQs?=
 =?us-ascii?Q?VPgvxZ4jrxvkxP8PqIaGIazD53hFtffu8glv+iVTdMyk+Q6iKiNl7G5rmw0w?=
 =?us-ascii?Q?3tYBTrnT7S8F+1rJCb4w//bx7jLHSYM82PHXu45DyQojhfUOSfeoIL9u3J3W?=
 =?us-ascii?Q?Z2QzKV0O4muMF6GcOUSvpML3I39Z//amvufhmvUAQjSKqfCE+5pBN8qc/C3f?=
 =?us-ascii?Q?MUsTuESRepegCN7puLbfZihxaF6Gmik1JII2BklaGdu7BcR5PTBZfw0HTixf?=
 =?us-ascii?Q?Cz2XMbo8Nc0BsNEB+IpVqJzu6uO38KWxQoMs2n8Tb1tamhP84N2PZ5wb5/RA?=
 =?us-ascii?Q?xkys95FD7YcDOZCvBroV3FNBgQR6T1MPxZMrdWLn+L93D+0VklJy2QpRSCEz?=
 =?us-ascii?Q?ZbwHLU9E1iGjInoQXcfORwWjMDGy+bz0E6bzeXprzqKe0Sh9JSIDQxca8g2M?=
 =?us-ascii?Q?KM56Z9J0v3FxzwMCpjO2Ioji5kHg92rqE3HgffQzdghc90j/tfjGcXdK1+Rf?=
 =?us-ascii?Q?5kkp+U39YJAmGvj/CWAQOYBsa4vKrNu7gbZBvt4rZBhy8nkT/CHiy2B3IDV5?=
 =?us-ascii?Q?hBQl4VMvjsANI6qQ9HEwS6ILNsjLgUC8O2CyyIMSLAnewFL6WHNMukXl1YqG?=
 =?us-ascii?Q?sX2W3Ivp7QUhvWjLplR4ZTLkxWc74rjVSIXUB2nR2hpJ0JtExlKWUsiN4ZQz?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e248ddf-aa51-493f-e93e-08dab2bd1597
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:00.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cguZgHZjp7sU99As4qR/qRRy/jkIYoa8Di35uwp9DI9h1p2VnwpuZdOUu5hXvs/VtKpKVO0Sr7y7c1EKSOJ0dNIelEHYaAf0emEM7OB0mOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: mqu7URjJl9Yrs0wLNi9CfmiIV9e6Z9GU
X-Proofpoint-GUID: mqu7URjJl9Yrs0wLNi9CfmiIV9e6Z9GU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100405_898336_0A1E9A26 
X-CRM114-Status: GOOD (  20.12  )
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

To allow modification of the elfcorehdr by the kernel, in
response to hot un/plug events, the buffer containing the
elfcorehdr must be excluded from the purgatory checksum/digest.

To do so, the address of the elfcorehdr is stored in info->elfcorehdr,
and the buffer is excluded from the checksum if the --hotplug option
is in effect.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 9 +++++++++
 kexec/kexec.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1276726..90f2e71 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -673,6 +673,15 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+
+		/* Do not include the elfcorehdr in the checksum, if hotplug
+		 * support is enabled. The elfcorehdr is modified upon
+		 * hotplug changes, and would fail checksum at crash time.
+		 */
+		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
+			continue;
+		}
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 7f7936d..9a26065 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -169,6 +169,7 @@ struct kexec_info {
 	int command_line_len;
 
 	int skip_checks;
+	unsigned long elfcorehdr;
 };
 
 struct arch_map_entry {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
