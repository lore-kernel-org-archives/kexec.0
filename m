Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB07CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITX009Mytt5jrzpaB69jrYQkzTS8F85vru4y0rnidOg=; b=1HJzAIQEqT0BQW+Je2n25u9edg
	doX1I/jw5ZwqYmI8ImYzcONcmcjcZosbH028jVE3NvMH0BBQKjvPJFaQNOPwa/6VEyUnz/G7CoGXp
	eIm2bVIv8L9ohiDZxeksPiDF1lNCEZ9y5FoNAX8O1Cs1hWBoQTh52yteRxy/s1XGqaEPvPsdgBMF3
	EltU4skRnril/GRNs3VKl+le9O7vtfRszZaO40qFll502J++iE/ax4dPOfIRaQEa347OnqgvTWsPt
	vAV7Eys31TfHVg1tzEg/FvW+/7sHK5iUV2qgJZ+kkbdDOgOEB3NoCsAgoJcCC0hcYusVpYw6JurvU
	kYcKBoKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAYG-0000000BhbA-2Bpm;
	Fri, 12 Jun 2026 22:40:36 +0000
Received: from mx0b-00273201.pphosted.com ([67.231.152.164])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAY3-0000000BhJx-3T0F
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 22:40:34 +0000
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLlk7E4185831;
	Fri, 12 Jun 2026 15:40:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS03102026;
	 bh=ITX009Mytt5jrzpaB69jrYQkzTS8F85vru4y0rnidOg=; b=a66mUEiaPFJo
	nmhMMoMdYPmykitDoBg+afON/Eqfn4Q8/AmXojcqEOOfgteFnF9Mj1OvqB25CbES
	lLUHN6in8ssd8c5ybQ3FXkikOheSNpctxNQ+vrIieTl5bwGu7znlRl4+nczzi9no
	4W+cgyXpKb+AAMfGalQ4mngqADz+X2m+T0fkb/euo10YCNtGAjmoVHxvMFKfhe8s
	IsG5Lq+Y3GpaA9RuyUQ85wWsQvYJQSj1Y2+MCb67m/XWK3hUj/671DcnzWkgwYJf
	UkozT3W8PflRUuoIGLAcn1EtjasOKMaIHY+Lf1d7u+Y9EX1761wsvPr4BKTsp24O
	fFAQSMwLFw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4ergw2axux-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKK8Nk6PwkN23nZyu3COUDRNNru8N53VTwWQIjIe10N/tCyC4FGmqrPgIywT1KPEojH/I0b8GkT7OTwNM9Eu4GdEMFuGLUlg8DslejRGlse0qPrOz+oedsmVxuPegPspGgtNW8QpF4mNdCTZJGxEzXW+yP4KdWJqrd8r7gT99TzE4qIIM2PkWD6tZCLl8SwPKulzjwffNenW5ZSPLHu0h29j1txSKzJWThcJ824Ym4TmJyiRd4kQtsGawBiQzAuSybZ8lfwjQRKzyuIPpBnf0MnaezQUbbUGBaYiI1as4TeUJe7K53zncVcBW+Ygxip0DiU5GpGrh3qMmzy9SbUH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ITX009Mytt5jrzpaB69jrYQkzTS8F85vru4y0rnidOg=;
 b=C5r9V69ovZ02nkNnXWhgojAFgSNQdoGL3IxmZ9F3p1mAv060tIJ6f9RK+mIjpOzhLyNtDcZZz5ed6/l7Akc8aV0SzMXqbl0jhaOQ0840vASmBf1FKbWY+SJq5dZjVmYqp9EGCKRha6WB/yrzA+7HCb9g6WXy5jvy/ejLRkrfZ3HF7Sy1DVY4FgSJxumSbvkNEpHZnmalqk8355XizepZOBqLulUcZ+Z+pt3GUAWOAwisZEw/O6f++7EZtDcQI7Q08lhgp4fZb8+cmw0Sguu2o1otwUnzUJvX36WqUK6V/DINqdVN67Qnrm961QqNo8VMlFJYCdMIW6aJbj0mcpSomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=amazon.com smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITX009Mytt5jrzpaB69jrYQkzTS8F85vru4y0rnidOg=;
 b=NKyV2HaijiqjVXGxhkmAFQ1T6yghTmFBR4sZtSXbbqWhwWCrum6iJdVXuEW+RxzWkVZMoGqUQspvIdHv5H08T4v46nPgxAdp4L0plsAnwXndOgzxqIG8lwcaB1xL/eYPfTIeOT4JhWeM9VfnkuKeTc/mEnN1eck2Xfz8maJP9YA=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by DS1PR05MB10614.namprd05.prod.outlook.com (2603:10b6:8:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 22:40:18 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::61) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 22:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=juniper.net;
Received: from juniper.net (66.129.239.14) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 22:40:18 +0000
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:18 -0700
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:18 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 15:40:17 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv057d.juniper.net [10.46.0.146])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 65CMe5rb013001;
	Fri, 12 Jun 2026 15:40:17 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: <kexec@lists.infradead.org>
CC: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
        Brian Mak
	<makb@juniper.net>
Subject: [PATCH 2/3] kexec: Add DTB carryover support on x86
Date: Fri, 12 Jun 2026 15:39:44 -0700
Message-ID: <20260612223945.1400554-3-makb@juniper.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612223945.1400554-1-makb@juniper.net>
References: <20260612223945.1400554-1-makb@juniper.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS1PR05MB10614:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a1ea92-bb92-49bb-011c-08dec8d39451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4e1blXxQdK0ydfc7m5mNTUfdqD6byCdC3wyk2WP1rr7Bqk7/R4ReDo9cDFohtBx1uQeFsPWf8o7vGOIk7hWJOXZaQDhINktpBkdOxuB7rZaNaKC5VOFvrVwe/dNy9xhBPyKFxgC3SstS0pCsopjqmulhxtuh0jmlchrCK015u42rqyrVEJsA4wesHF6pVCPoIrBf/ogVKZlE4FYJ8jgDCWkumsDrdp5UogIe7Gl1odwAvidPdFctHfzOGtRbWpG+r6hD8rVYTsqAc0xp+3bXLC0Frx8lLRMfAkDkB9KZLD3dp/jmxjuzNZuU7FSoFt7cqTd0iM3vl3HF+rCaxjjHTxFUNnMg7BtBazn1sk7EkDKSQ8IpXVmZFRcaiCWf+BrZ5mWsPiNV3Sc/1ZFTbrCK2S7xexXUl+HOxBaTC4LYULW51Qr0ZS6qzTcx5JFcvykuMwOGtp4Hh5v8TrFrCoQQUCwpF15z0wTvQmE7qkRar4AlcnlDCMz58wmRHXp/2dO8bQhe8wGe/RsPw+gHY9nGNBXX2TYohDJf/mVKNEUJhOOaUVNgcpqn0smBDBwD0Gc8nmp8FKU+yOyPai5qEoz9qRf3KARqN9CojDvwKNEKP+9DB19wijAz9jTdZl89I7StZh1ZnXQ3gKxfjwtcI6i1s2xVSdBX8w/uNNP+LZ1OrSlQiEIrNiUUU9+MXDxLm6EnPeXjVEtM18K/+IZNxe+u7GdVHNnI3nmMUh1frgTbzzA=
X-Forefront-Antispam-Report: CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yAPN7pbqtWgGqcWEDqGtoWRhcE5Et9J5S6OJInxUY/JTJLW7pakm/dbre8N0JDY49jAIrO8miVLGSQ3z1NVOKW/zIkkfNUyAydr+mpL70vifg8qGw8PAlOG/wpHW6EGU+cQJU2CeQxbDmqbiZElDjIOh0HAkb/iaI6JEDLN5DQTmTUl1uDlwWGet02xdhFFXgnZXoq1aiKSmEbQ8uHgVANv/5o5JwMsDaQ+6NfgL581RKFbif4aJhst90g6Bgkw/lLjPOXpSVVVZDb3lOmSajbTCuLyc9Uprg2SfJEGLd3wm7fkyqjD/UnE7hex9UFIkYmUmlMOFoG8rRMwho5aLFp5M9l6FtPGsl7mc4cs2J/ORRMzbEEG2piJXyXAhnjjxQLU18gQcbNKgCSXueSG40mOYy9cLbbdG9lP3rgE1YU5IDQqHTaICehyNBQVRh0xS
X-Exchange-RoutingPolicyChecked: qzAL15nJ2O2vVv7ik3MW2tilttmlrjGkCsXnLjQUhpBZ32n7hEIlvBmPP5B0IP6dc30YRmFZtvYeXPvrdt9ybGDaeo9QZhpfDtxxfO1MMsr5EQ6tjpUG8aun4BHmCmhQoMvtXCLVXjbWKh60GRptjvo34YGtoM36ikD8JTR2ahalQYzD6nsKFxRNsP/oshphjtc9YjEISbMa/gWfl5uDpR8MpvRHL6E/jAYQ/7eUQWXKUzUEfj8OhxN3WscPHkI6ELk0bFjC770YHJ53aVpSH9BhA0k8/mmL2yVLQpqaedBuAT41xrp4shkq1SIU7vg/VHWZocs90LOx4qB3+ZBkQA==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:40:18.5031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a1ea92-bb92-49bb-011c-08dec8d39451
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR05MB10614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX1DhtaVdVQsYh
 leYYnMdUHFKTt1yBnysvLH8G5lBBReZSHH7RMcS2zh8oIABpcz7JAiElCyumPeeSimBwxEcyTCM
 sQxj3JCZOqGpsFWgK229L2y4QtVAOS67zQGfmrqJZcI8QpGdHuYh4v/lGS3EFIpg8FLwhyoB+dV
 xij0T+c51rU23rGwieBoOkHHZrx4uzT285FMTkUElVq/UOLdlCgDexX0G+kVDGvg6YVQFqdsE9l
 TA8h3xYc0StMq49gr0Vm8wo0ZH7GgB0l7kuunvsKNKcklM63XpcoBdsNo+FxdLBM9uhIQluL2jO
 Qciheb4til5YhHCcE4wmk3bjWm+T8yIQ4HMfJASHEXseRM6lENVt9eFrbye5EU5aYzJK0GgTlK7
 S2FYw8nzn01pIboRD7OtWDdzOAj3TVe/k95u7+ANXhbvMu1Fp6EhU6+zKFADrTuEkvn6+Aq/nz3
 eiRkF3p69DJWnJxnLKg==
X-Proofpoint-ORIG-GUID: MQgK3V9VBXlJJowj1Oq8xg48BBRbhaLD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX+Vrp76RBW/B4
 gdV6jEzkBfVvDQscAZ9dbfVb46saWerGomMQX0Ih0Ycxfy4XtWDeM3z4nG4YkWwvzVtgZkSPz/W
 HDLHtq4u9cHmPrXNaJHwuyyLJ2dklnZcxO6PtakROQ0GFpsCsAIr
X-Proofpoint-GUID: MQgK3V9VBXlJJowj1Oq8xg48BBRbhaLD
X-Authority-Analysis: v=2.4 cv=RZ2gzVtv c=1 sm=1 tr=0 ts=6a2c8ad5 cx=c_pps
 a=G+edI3GLQse3gACT8XNfSw==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=iQHEN9yVhjWw7-rk4WGD:22 a=OUXY8nFuAAAA:8 a=jTqfUqTawgy3QhtM01EA:9
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_154024_042503_5028A5A8 
X-CRM114-Status: GOOD (  14.91  )
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

Add support for forcing the carryover of the current boot's device tree
blob on x86. This is enabled via the --force-dtb flag.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 kexec/kexec-syscall.h | 1 +
 kexec/kexec.c         | 5 +++++
 kexec/kexec.h         | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 77e6b81..d66bd82 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -129,6 +129,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
 #define KEXEC_FILE_NO_CMA	0x00000010
+#define KEXEC_FILE_FORCE_DTB	0x00000020
 
 /* These values match the ELF architecture values. 
  * Unless there is a good reason that should continue to be the case.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index ccdf4cd..acf9699 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1103,6 +1103,8 @@ void usage(void)
 	       "                      hot add/remove events, avoiding the need to reload\n"
 	       "                      kdump kernel on online/offline events.\n"
 	       " --no-cma             Don't use CMA for placing kexec payloads.\n"
+	       " --force-dtb          Carry over the current boot's device tree blob (x86\n"
+	       "                      only, this is forced on ARM64 and PPC).\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
@@ -1679,6 +1681,9 @@ int main(int argc, char *argv[])
 		case OPT_NO_CMA:
 			kexec_file_flags |= KEXEC_FILE_NO_CMA;
 			break;
+		case OPT_FORCE_DTB:
+			kexec_file_flags |= KEXEC_FILE_FORCE_DTB;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index a1edc1e..1489ec3 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -236,7 +236,8 @@ extern int file_types;
 #define OPT_EXEC_LIVE_UPDATE	264
 #define OPT_HOTPLUG		265
 #define OPT_NO_CMA		266
-#define OPT_MAX		267
+#define OPT_FORCE_DTB		267
+#define OPT_MAX		268
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -265,6 +266,7 @@ extern int file_types;
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
 	{ "no-cma",		0, 0, OPT_NO_CMA }, \
+	{ "force-dtb",		0, 0, OPT_FORCE_DTB }, \
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
-- 
2.34.1


