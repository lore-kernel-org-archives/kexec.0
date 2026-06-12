Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84442CD98CF
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=768aiSaD8qp/+8FBSphowofdnyJOj4rUT+FPsKuLAms=; b=C+a6iKD67do6XzuewTtH/bQ24X
	SgDI4oxcrQKgCEbivT7ADAPisqLNzDeAExpPltJlA4AzqxOG2fQQ8GiJOyrRtW1fCS2K8J0NjQAfS
	vLdxPMW/uZgpJHHKB5hmnVFTlueEfXpaS8gb8tDE765KjI0lUoDNHa6rrclhi5h3wF0EoEoDhkdvt
	5JrBN/7ylSLdpuCLl3TXe524SE/bN8NcRRohkZUW2g9b/aeFkRvvslSMLtrGy8H9VvoCx+FYRnwf9
	JRjqRGWGb7iL2cg22bIn9XsDPLuIrnwzTVDLzt1rhZWVbFOcA4Wp0c3wQXA2eV8P7ewYAH4ASuuSt
	mmqTXesg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAYB-0000000BhUl-3JAa;
	Fri, 12 Jun 2026 22:40:31 +0000
Received: from mx0a-00273201.pphosted.com ([208.84.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAY1-0000000BhGO-1FAR
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 22:40:30 +0000
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLj72Y330444;
	Fri, 12 Jun 2026 15:40:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS03102026;
	 bh=768aiSaD8qp/+8FBSphowofdnyJOj4rUT+FPsKuLAms=; b=eIMH87UhLv8m
	LgVjqmrnyuANIUtcK0ofIKRFYDBNRsWl8XqxAUD2ep0+lbrVXw6k6714s0M2sOPQ
	1aFamUQnCN/yQoz5DcjC/9qCNy7xE1V9GcF65Qn2CdPWlk2i7Pw7itZbKsKrkUkF
	Ur/9rSTOekCfhNVJ49IymBCm2xj3HTID5gs2hmN3LX+NaZr34+RRHJvx2b1CvAdU
	RTgmNvBNZbnmNzeWUEDWAOb4kRC0wnU9J3EtSwtkEIVuQbAV4xGmE6jz0FQmYWqn
	AgHCq7VC17ebytP5LfL1iRjEOS9UWVsdanxquYgsBiwoXqNjgLhz5QdoZgcEjxZe
	oYMoc4YjWw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 4erkd8a8xy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqIk+FeU57y+rz4AjLpEHKIwxx/yhbriGkfPSuKlE/ZNDalhN05d0FAlydYHQDV/MqEOBT1P63kBYjv8ms5c5FSCONpagflVYSHxs0s1EYSHqJCNt8S8S9M2nionK3+P9Efkf4mFuQWrXxxYvsBKUrk4ATzA1qBzHu9V88T0xp6rqvHYeQvw9gAK5WE+r10f6W4A0kGfek+oN0dy3/kiN16CWepmck4PWIOEE8TAjh1QzNRwdknculW3Gv3/+wC/lKmswGF35LoAxNYMRTtQsu57OXESufhkmEA7+v14nqa7uUfmVwUKdgnz9Zy6Fgg+XjLj4upgKkTFh/7IUR9aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=768aiSaD8qp/+8FBSphowofdnyJOj4rUT+FPsKuLAms=;
 b=lGsUwoHCf1yA1VVtc3Yfz8Nc8snsHan4xwy3oevFf0UaDJZfWjm+jncMydqC6NljnSsVCBw74DtMUci+azk98nPzHJ8mQlrB+zL6F/IKtDsD3GOi9bvH0Xc+Uw2Tl4VujQ0Wksd/DZ6nZQ/3OICwiomdPKNFgzoZU3a6VOJgb7Vtu+5FzotBQPbU/KvsEDzLDqyTc+EwDmVFjPb3Ag+IwtD/IAQh/LWqkrXxFUQA2Lc6mDDnZJvFACCqWLzenPykbyFAKiyvJghrR/pjZrVpTJBy+NzWH0m+jBTJEGmxgOIwzJrFwqHMgEdo2N0NVlKomOG3TIFnO2nBHAs3i9F3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=amazon.com smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=768aiSaD8qp/+8FBSphowofdnyJOj4rUT+FPsKuLAms=;
 b=PM9PZC4x73LbFS8LY6jwf3lzFIpenEEDkAh/V69R8Q4baS8i4ZRUniL+ceJ00OOWs1wivlmqCA7Hq+bKTB2W5NiqdOTuDS67oSux9mI/ZwA5g7guw8r6vd0o9+o5uGN7rArQxDjdVEc5A+ey0ImybL57WNZhJ5FApnq79T1Td8Y=
Received: from BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::8)
 by PH7PR05MB10413.namprd05.prod.outlook.com (2603:10b6:510:2e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.8; Fri, 12 Jun
 2026 22:40:17 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::66) by BY1P220CA0046.outlook.office365.com
 (2603:10b6:a03:59e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 22:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=juniper.net;
Received: from juniper.net (66.129.239.14) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 22:40:17 +0000
Received: from p-exchfe-eqx-03.jnpr.net (10.104.9.50) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:16 -0700
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-03.jnpr.net (10.104.9.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:16 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 15:40:16 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv057d.juniper.net [10.46.0.146])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 65CMe5ra013001;
	Fri, 12 Jun 2026 15:40:15 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: <kexec@lists.infradead.org>
CC: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
        Brian Mak
	<makb@juniper.net>
Subject: [PATCH 1/3] kexec: Add support for disabling usage of CMA
Date: Fri, 12 Jun 2026 15:39:43 -0700
Message-ID: <20260612223945.1400554-2-makb@juniper.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612223945.1400554-1-makb@juniper.net>
References: <20260612223945.1400554-1-makb@juniper.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH7PR05MB10413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0566bd5c-5487-4227-7ed8-08dec8d39374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pyYr2fU5y1HOmMX/EaIGWyLLB/al8FfY30XG33/0W3k3bh55MOKpXRwm7Rl0L/7pbVSxHR/OCVZcJRwJGZMq866M8+Lb3HxkVr+KIlao4JADvdN1ZfXhImbS4lnWJM3y77OLQkglTOzpDbieeYm85jgV9Ud8FlanKKAvjpMNJdKNR0sZ6Ht7CM8zT1nHAxrLBktGiGRmHFO2xq79T/ne0hS8x127gMjLRmjE9P6vOXZE9TslTZKo1JnpE+QFJajWg/WCrq2t85rJvhcYjxP0iGbVE3z/PrNjAta0DP8bpGs7nB3cFE+WmdVL8WdajruSaLCXCLGYKWgUyovBJgSPw5NfrPy7S83878UzlF4e64sMhFw5PY3AeNnA74iDVB0Zj8fQJkpDWvcNMMGsPQgGT1P8faPxAb/foTpHJ6KQZP9pdFQ6GgaLTbxzP5bKXEZP6ZcMEILf1gE9zc7070CMAQ+BSipVusu+EI9FJiXB2RiB1qS5SZgxDV9H1zmIgV2dF4eqtpwGVsaqsQbqPduuCI13IyMTjK6pCFuDG1mswMnk+pngzOkwOgB/Ca0RqhTgroM3mHLqVucr7mZjRYpKxefJk6NAUa1JawMP7aUm1Z60XjBUSMeufaVWMONbenb9FsFwN0mCIMxosOYLuuYxd6H+il1r7eYys9t+FEILImm7YlAe7ewGR+C1k1oWPvivHHUfxvthDQ6mPr/IlGQU/kxvM7VTCt3Z7kSlqHyaxc4=
X-Forefront-Antispam-Report: CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /bNzG0RaM1tbKx3lGWTkDN8NfRBS0gx5ZCzMJ+uABtyhcQXx5EZ64K6PqUg8BQyA2c7JS8sf6nTd8bg6hPr2ffYLk4RUIzWhhVZqL9oJcyy8dS+r4pJ9VpwMsE40+b9EfwzBNBGZJalfhgqWitrJqTcUvqX5qDkMUBfhRc1K7pr5DAr3SqVU6CTOcvgQaQniLiAu9DClg/XwsplsmzGFhY8Via59wlaz3aakxXhramXRO6fdQlFKygTLC67O5hNFVLljArnrox5rXiYS8u1SU5OXHDYnT7OBJ3qVHv49io1yHAveEjItsKI+HpBMSlvNHoirlV3IRerJLwdXgIt6zWLzVlRvDGd4s7LQSGVkV+aU3AgZuB3yMTn0QF7P+9box+2fobKAJFu4Dd+oGPS5P2GZJhjBX3IzboWzTYBayQaLECPXtqw923SAKEhLB45O
X-Exchange-RoutingPolicyChecked: ea8+LTy8UToeUREUv7x21ysmkAh3KxysjQvhjgCHz5yDtAP2VJgIAseBwjh+Ljeek1c0xGYl6+t1MatXfVMtS1JX7pVLmwStc1yNH4IxLSkB94/IuF1r7IKbuzkdMd7HEVK0jlE+nkupgvrsYRFR4Mq8U2y/TgUsFa5WtwCtZTuBLcTIOb8QCCOuynvyj6/U6YKczSKpE4HQUoLo9St1tvopHFITzcEW+O65W99WGCy74M3oG+VQYxRcjCwKBRvmOjJGxcQs+tx4M7/o+MqUMp1GlGAT3CJ8ZqsuMltIb298FzxdMQWgbcs1tj9AjFQBJWYPOqZzsTfPtFtHcvpYHg==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:40:17.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0566bd5c-5487-4227-7ed8-08dec8d39374
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB10413
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfXzsHJ66Md+MNt
 aQ2+o0W7QH+ESCWn/1BOc5b/xzk0i6l0WbyQsxCE/Olviu6E7wvPAqkls86MvRizUdRS3k8RhXl
 tlhUCoH3epPiWB3APTEymc4MSisXZsJ7TTbxQwWOthCGhXII0J8H
X-Proofpoint-GUID: tUgf6GF7ZnrsvK_G63z-yO0NSpUEAHWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX0v97+wIOvTqZ
 03Xoo+84AM8Ib9WoS0Q1MUpSevVIJ2FIy7MJtMvTojfDa+Mvzi3eQQCoXrqSfSZvCFLUqTA0jES
 eQfZ5r/++igTXKlztfN92gs7B0DJAiEmlrdnop6vUG7LQLky1SY5NRjLhgwufGNrbI4Anhie5zd
 sRHYIkJo8+fKdBmjJvnFPuFXId3NvaB56xAjVHqaMh3e9cSdAnMVlxl0azb3o5+X0KTggsXdFQh
 tmxuycdpz6IM2oywchAOfLWNnIuPfM0izQJUR56X0rwhaib3qp75bfpk7pyxi0DVCeDhMIZ18YN
 qScHCV3hYdSt/sp7XZvFSMzopCSI0w0+wYlADX1VMTCT0oSsSe+ZAv6py2/4XJIfdju7PyzLXUM
 JsDPREtuqaBdccMtA/P5Mph7U0bGeaVHoVXf2d+8MF6wugghbaToRQfZKGPXo8vmDsHhq3USgDA
 ysScwl39AODUj6HqQgw==
X-Authority-Analysis: v=2.4 cv=FcsHAp+6 c=1 sm=1 tr=0 ts=6a2c8ad3 cx=c_pps
 a=M+4CHf8fKMkYOwSYEMZyZQ==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=8vlvHv4eveIrSVLlmQuz:22 a=OUXY8nFuAAAA:8 a=jTqfUqTawgy3QhtM01EA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: tUgf6GF7ZnrsvK_G63z-yO0NSpUEAHWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_154021_395748_A1070DF5 
X-CRM114-Status: GOOD (  14.12  )
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

Add support for disabling the use of CMA for placing kexec payloads.
This is done via the --no-cma flag.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 kexec/kexec-syscall.h | 1 +
 kexec/kexec.c         | 4 ++++
 kexec/kexec.h         | 8 +++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index b60804f..77e6b81 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -128,6 +128,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
+#define KEXEC_FILE_NO_CMA	0x00000010
 
 /* These values match the ELF architecture values. 
  * Unless there is a good reason that should continue to be the case.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 4a49ad4..ccdf4cd 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1102,6 +1102,7 @@ void usage(void)
 	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
 	       "                      hot add/remove events, avoiding the need to reload\n"
 	       "                      kdump kernel on online/offline events.\n"
+	       " --no-cma             Don't use CMA for placing kexec payloads.\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
@@ -1675,6 +1676,9 @@ int main(int argc, char *argv[])
 		case OPT_HOTPLUG:
 			do_hotplug = 1;
 			break;
+		case OPT_NO_CMA:
+			kexec_file_flags |= KEXEC_FILE_NO_CMA;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index d0bccb5..a1edc1e 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -234,8 +234,9 @@ extern int file_types;
 #define OPT_PRINT_CKR_SIZE	262
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
-#define OPT_HOTPLUG		        265
-#define OPT_MAX		266
+#define OPT_HOTPLUG		265
+#define OPT_NO_CMA		266
+#define OPT_MAX		267
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -262,7 +263,8 @@ extern int file_types;
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
-	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
+	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
+	{ "no-cma",		0, 0, OPT_NO_CMA }, \
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
-- 
2.34.1


