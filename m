Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F9DCD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ntLZn8TMGd3PHLnBKkDEQbv/8k6arjDrCPqMLn2sYo=; b=tgqkAClOCCTjbXQNr0Th0v82WB
	bEyDBmE1/tQPW5/zCF0G6tjnowRcxo6DENNxOFQiUHPi9wc/GXAiEhytom5XKkR3PtLuzsJj4ex1t
	iB+1+zLIPSrXiqUEUak7rrz20oGSQPhrLbdvu2N1sF+doStjnXl/nQUJwLFTbusCi7kpd8CLnfi7l
	bOlXDRJwoTtoxfiUFgO5KI0KgN5y16JyG3AJ6yTyiVmxJNra/kIL9rKc0CDwIbttGckJt1dBJgFTC
	zw2DerQfdOyI9THyqIqcTWsVCACknjq4gTpNwve6cQ8KnSEkPdcRx9h54z00dNjT1OjSixW+MZ9A8
	xZjo9hiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAYD-0000000BhWa-0n1F;
	Fri, 12 Jun 2026 22:40:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAYC-0000000BhUd-1Qii
	for kexec@bombadil.infradead.org;
	Fri, 12 Jun 2026 22:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4ntLZn8TMGd3PHLnBKkDEQbv/8k6arjDrCPqMLn2sYo=; b=JFym2FuIW19omv+cxnviywasNZ
	PDgGPkzdvfHqke47PPxaY3MguJEagzUsLvH25yEhMiV7Pxjvdxu/QNxJ3SuwwipgoU/a+NgqrAR02
	+TAojpHx75sKlgCF9G1ODe/3nFbAknGc+n6+6wj7VPGLJEprUfRu62+10twm6J5u81yJhAxV7Hc7g
	xCu8M0vzrZQ+yFoE/XGyaso1zSVoG2nGvejmPuvOI2yMm+Q3C45RPzZSmrZq2pooN4BUi8lI6KdeP
	C3e3MCteMy+DitI2c74t72BRB3LFRaTPEtCZKKo5r1qXH1bAc2fAw2dx2rsLG6JbpwggOZMZ3KhRO
	eL2aM4mQ==;
Received: from mx0b-00273201.pphosted.com ([67.231.152.164])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYAY8-00000006wov-2jCC
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 22:40:31 +0000
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLipxO106351;
	Fri, 12 Jun 2026 15:40:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS03102026;
	 bh=4ntLZn8TMGd3PHLnBKkDEQbv/8k6arjDrCPqMLn2sYo=; b=Di8JbAOVlSfx
	jE67bRua0QwtkcLc8ctZM43P8/1RN7HXniVC6MNsqrL9XlmdeyeyBqhS8Ny8Nmlf
	cFJOdf6Nf9FY/0tEXtPE7fxdn2hNJKpHjuWgsIbvJnpgo6Dsclo7cn14JC+qe7gq
	W32D83vIQ1L/bpfm7cZL2FT9tT+K8KzQgpAE3Wdaqpwc65VCJI38NJ1g4laSio3I
	Del/i/kFeyxbJyYQMt1uB8LjRmMLIA6Q3uxA4sYdO8piLZ1CWjhcWBIc4O5sLr8D
	A7hJR0X8Cft6AjnBUzpHV57/85fgAxT65VwiX3gdxgu4Wjkie2TQSonvWW/Ce949
	ailwiBKUTQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4erkdn2720-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHfAffNL37cIdoxAMD1bhNF6Hj4Njzya8USrrdjht1WE3fRUHDWyNNzqUOIB1fqG2SaLZziyhxe5gHyEomrJUt4WMTSM0oruC3M250Zh13tQrDVSrYNJ/MZO6zIsYJaM4eKj191Y1FvdzZPNgYbT5V2DQTOB6g0w1Xt0jWOA6+XN7pkI69wv7kAa1wP3JXINY5n/y50aTaF57ofv65fng0dy1RIwM3uarzXThta2veTsdCzXbAeS2Py+6fvF+kb0GqsnQkuNkQ3N2O0HxiPPEFUcTpHDxrDpESzNln4R5Pfgth5U+fnaLoMOFnx37jY1LQR+xCSGglYm/Odlx/HJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4ntLZn8TMGd3PHLnBKkDEQbv/8k6arjDrCPqMLn2sYo=;
 b=t+Q160V3z+E/sTlKSbUc5us9Gvs/9kfT8jCSkYmjqzKcDQ+lkLCgkdsURQm0OrX/xxhPPQTVRWtanV3XptSpFPE5J386PRpVhP1j2nAy32xummZJ2W8Wogg63KBFfxleXtajUmJfyqWl7o8mG5jt9nHWFJY7SlQpr7MYYRkju6wbw36rMbh/P7Or9JxxdJYFER4mQG0EGCH8CY0pw2A1iselsxFuartZsdPL3pDCTqE9OTUefDiIihBz49agDbndoEPUflbmzlljZf+QA8/3gC53eP9WPldL9SkNp1lQynY1Q+gU/if3piqJfc8fyhnTf1nYVU/zpK1jjPrjez2RZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=amazon.com smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ntLZn8TMGd3PHLnBKkDEQbv/8k6arjDrCPqMLn2sYo=;
 b=b/yYZ0b0mnb3eRQtvou3kUienHyIVHb7hEhVX9XWGQzAtC97QknCBaHCi++qsqD6GDbaI/n1w5XfZ1k/qI0tFkicyNu9tag88Mr5vPZa8kfwHS2YDuv5X/IBIiULoVzR8CRHaO9F8jn4w/I9qNF6hw+ZKT+RBDwmjCB58VnRuww=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by SN4PR05MB999000.namprd05.prod.outlook.com (2603:10b6:806:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Fri, 12 Jun
 2026 22:40:19 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::57) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Fri,
 12 Jun 2026 22:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=juniper.net;
Received: from juniper.net (66.129.239.14) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 22:40:19 +0000
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:19 -0700
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:19 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 15:40:19 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv057d.juniper.net [10.46.0.146])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 65CMe5rc013001;
	Fri, 12 Jun 2026 15:40:18 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: <kexec@lists.infradead.org>
CC: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
        Brian Mak
	<makb@juniper.net>
Subject: [PATCH 3/3] kexec: Add kexec_file_load debug print
Date: Fri, 12 Jun 2026 15:39:45 -0700
Message-ID: <20260612223945.1400554-4-makb@juniper.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612223945.1400554-1-makb@juniper.net>
References: <20260612223945.1400554-1-makb@juniper.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SN4PR05MB999000:EE_
X-MS-Office365-Filtering-Correlation-Id: a071b953-811f-41e1-3178-08dec8d394f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sJVbvArh4YB2z/Zmjo5CTzkNrHVLpCEhOug7Ug8LcrhD6dNS4KEzYLJfhPxmGjAlJWLM2V4ndyLwm6H2YdI3Yt7S3sBHS0ugBWQgToxij4z3am+onGttDjr8j1jZfoiKVWQgEHeR9DGKImnbv9FqIho03CGIZ8S7OuNUh7lTrx3xi+p9QffQcf7r3GmgCAUMABL4zVkCNO0dlUNLTUEXy9rWI9CjNaQnW2+nAjKF0YE0v9sb1D73/0tL/prlZ5ubcQQg9Vgl/ARZp5wBMtXI8/ojDjB/KAgOE9qxvua9BSoE8qqzFG7BxFI+JLYkxKmIjKAuY8aolFqV+nWbAkOqRcPBxowNBoE3nK7/aNi1ahHPecM3DuoEQh42fMlJqLQgYTN/PISjouKnnzqb6UNpuYBtlNqQw9f1rUG0aHXV5OaUV4U9I8J/haE23dKfybzyRoprqf8Ax0MYE7k3wx2iMzcoLuVpBEYLZhi3NAYJgi8p1ArGDS26aTy0VDC5PGBjFopWShhkdRrKw7fdrxnvEt29JcEB3Erz9t4D3Sc4zRS2YL8hgn1s0qYSE4j/1WI4j+sU1CiCtQ7xz8A0/BRb+x9vV61danmsmKQ5NcQ21Uo/K6MnF5FOfil10VzMwKdycHO9EkM/IIcemoWIaUgnfV6cXD98F2cyz8Ne0K0o6j9MBDyE67PsVc5gg1MDjL1ukSxpYVdqvD8NTTcb/m1BvPFuKJ5dL+S3lSY3m3vIXjk=
X-Forefront-Antispam-Report: CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iHy2tzxW9HX1hpapNs/0JpVDgWQkQNNDFeRGeVXjUCi1VqGmfgYBab6xaRwr85ACBBmeMFjqQaJHcM42vVlNIdFz7w4txaTGMxfxXS0ur0uG53YE0fbKTj7QjZeWXJeTK/HTc4SoyXMn5ocG51fa0TIn3i/wuk10nFq1NSMtIr/aXTtr1n0MC0YYWVnALp2chod0FPGxcTzrybNxh/t5Zqrjn3Cmft7cgIP5RTXWMHJzyvicQcFfuPc18hSE8N0UG8U0rYv/552dyuoGJ5HZI1fZM7paLb2h++CGNvMvgPdUsIeRs/zSeN/ncgYYMkx69WfZnGhyqJyAdOS+61hWq0mi3Ro7jYbrgwbWMEB5sWBptYKGXkFEj47nQg4xFBzwpUFG9Y70VzrSuKBya6G5fBuVewbwdesuakhtYVhMp3lqKEKjPFDC6VgEUfasBFPr
X-Exchange-RoutingPolicyChecked: l+T3NINeshoob2u+X90jT5Sr405oO+h7L1slxvV8JWMGdjRDkXQYxT8Y1kjkVggUfkt8Py9RxCu4EmKk1+BUBnm4qsSCE2hrb/OBOqwYeyvBZrqTNVWyFbptUzj4kYS960lnIbltN8633NMkamcgy1MekiDQ0dig1wdR5C126V2aKLXIyHoEDu0QFSUPckUO7+hBZTGARa5ZaBH1Gn1kYBXRFWOU/15nnvsQN82EMrrE54zC5HBq9b5RDEuQGWLpSvGSn9jEVPcd+8KT4FvXePaCzgF9mhNeWyXcrcyQPHeFb0jeuq0NiHSAcC9exZFFrwpo2xBXal+YotUXy6VqUw==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:40:19.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a071b953-811f-41e1-3178-08dec8d394f7
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR05MB999000
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX9ibPB96F2px9
 zTxgfA9khSSNxx1V/EjW/eyp4JBTH4RLRD94CbDJKO51by8Mr/8olpmVeYhy9fxqVeelNDswUrx
 5yJG//7ofjS0DMmucxKzrPwmagGyp6j7t7SLS1YBvJiLE6KKO6uW
X-Proofpoint-ORIG-GUID: yriurGQv_cBnnwMWAD9cQjCg4Re7V9_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX9HrDlo63fHdS
 gKjci4S/pIrZeP1tTQ/n2jNRV6JuSFD3anTiRji9kQFrf72xp6/+bvd+tozLZMaxY+eKFRK7m83
 gdsRo3jnI3TrfVhbqrGDIckFw5Ix38VIOX1yCqPEIjrQutZlkfnJvHd4RoA1M9cwFYEWnOHGjmv
 xStp3Avdln5quqAH23vip0aksGgDi1yjI+fVZwSEWq4BDXXl6O31xccDumacIAKD4N8o0Aooyte
 OJHKfYD4sTZ3dvQUxW7L+PxCxsn0wNM4kcGQTfzD1XlZcLjVnVdySsy9viXJdJOgxg3wFDvyXIp
 bvf31kA654vR2+imRYsskIprE8i7bmrut/UpuoeeHcgbeIWJSc60HGuCv2INKpXU0ZohhgEFu8d
 w8wrg/5ZgeKRUvki4cMt930dYkOIJYpdFUnvzg5cKCmX3N5/sexd07zthq5pAHYZD3rs+c50Zit
 Fu2LS3sbPSy4zGQm1lw==
X-Proofpoint-GUID: yriurGQv_cBnnwMWAD9cQjCg4Re7V9_A
X-Authority-Analysis: v=2.4 cv=ZvPd7d7G c=1 sm=1 tr=0 ts=6a2c8ad6 cx=c_pps
 a=U2ki1QFzN2iGT7kcnsve6g==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=kT44gYg0zFKYNBFEzlFE:22 a=OUXY8nFuAAAA:8 a=Ghu307BjlnDyF8Lx2msA:9
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_234029_273614_052E57EF 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

Add a debug print before kexec_file_load to print the flags passed to
the syscall.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 kexec/kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index acf9699..58cab57 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1422,6 +1422,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	if (info.initrd_fd == -1)
 		info.kexec_flags |= KEXEC_FILE_NO_INITRAMFS;
 
+	dbgprintf("kexec_file_load: flags = 0x%lx\n", info.kexec_flags);
 	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line_len,
 			info.command_line, info.kexec_flags);
 	if (ret != 0) {
-- 
2.34.1


