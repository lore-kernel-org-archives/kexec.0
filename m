Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A350FCD98CF
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9HkJ0K7uzUBITeLqVGhaWVQp+WCT+ww7FytE1TzOrLk=; b=yibgtWEZ4IIB++eqhr2VCIp2yS
	lX2eyL7l/kvyKjtZxv5ajWBiSw4V1UYQDJbCMhOZjLY8vwFevbiY+SCVp7dTdVbtSdt5j1Qq8rC6Q
	RYESyiKicKEMLPxiZnxgHCY6PHFfq2BtnxQNPQtYAVwpnDpo3fhrIUHYmpGlT0UmYOy4WuweXosW/
	1eHxbBGely5RzWdmTg892y9tklf5P2XRTZZfFEdX8Vmoonz1bnw1zTNua+5d1/hkZM6o5XccFYqJC
	EwKw6JNnTiI3HYSiMzbqIImCR2ehZNhAnMDjPizfw295/R9grMF4Nb4oiEidHcFhFjpU5Xc4DoxmI
	zhcZYSUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAXy-0000000BhC8-0MbU;
	Fri, 12 Jun 2026 22:40:18 +0000
Received: from mx0b-00273201.pphosted.com ([67.231.152.164])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYAXs-0000000Bh4D-3wN8
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 22:40:16 +0000
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLmjEB106363;
	Fri, 12 Jun 2026 15:40:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS03102026; bh=9HkJ0K7uzUBITeLqVGha
	WVQp+WCT+ww7FytE1TzOrLk=; b=LCOAA9L/W5q9ePsBPZ4TwwvE0TrWz2QYiMOG
	d84y0387v/dQ+JsC+bcFODd/1x1GBCPDp3CHRT+gs9mwS65sm4YbdGHwcS6AqXfS
	uAVoxqqulDZOmOuOS82n+vUUbKX6eZTuy7i/KjVfbQxfeSlPw6bPjvk4C/Q+lLDF
	lTsb8heZl1BKjNrwTjD2mLLj3UpdojUx7zku1t83BdL8rW1jzxgTCu1wt54j4KJ2
	P28In7ArrZKiRAD2Fuh4OdidfncWf6W6K3RiyhT87t7rtJN6n2h/zAWBtLiSdznh
	QJUVPjzMeFlfqrFY75aNFNYbXfYrAdkigFvQIFFhGU66pJYXbA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4erkdn271e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1gRvThKMFEGlvJn5sZCrJs6CfEn+LCJcMHxuZe4hqrdatlVVx2lgEvk2W2xPY562R5pn5rubNAYx0Wsk6p68T9AXF8a/heZv7NcGsUb6zwFX8C3fEZs8u3G2/4Z2tTt9kYnBPSLXqRqtkj6fCGtv4rwqBU9KKesyQAELsa7h0N2oaafCh2AL7sChUVsMY6a5Ct+atXANe+L4r/ZviJ6WGM1JdGPKnpz5/HLdS2LA6xQ/O3BodFH3xA8k6w8XZO97J5snFR8AX49liyqY/I1LoM/h3TZKBahDEjgJNBt5hKTl61lY/FagH15wmfECHisdHfoOCqiBORfKAGmSgJvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9HkJ0K7uzUBITeLqVGhaWVQp+WCT+ww7FytE1TzOrLk=;
 b=ViPP0SFKpXwYdcvhiqkulZIv/TxGsWVHt+asfEVMzMsOnD+vB6FZQdtJajiM7Sy5WYpvUUwWYPCYyZmEZwbMrDfXfVV4uKVs1hBsrHEYEMVUzOfhDK7RHAbMiHcslBaoglzfh+OSp0jASycdLqZreepzL/D5g5qDEUC3A2+DFESw7WOwvWOsnWeKftt8kU1B6GJ+vtldFmdUJrRHsj8YCEsOreMDQ74JgabTn0Y+l+sObvCUGyvhil5wN2R6k+8xBurtrb6015QSLjNU45vN9Dg3BlvBz05nWDvpd9Y7wu+D0GdGwA+6LA+NMB87ZodVb2BBDGAIMn/MD20E30Uvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=amazon.com smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HkJ0K7uzUBITeLqVGhaWVQp+WCT+ww7FytE1TzOrLk=;
 b=F7Zg8fnhcUFJYAsV45XVOclJFZyvkLnK1XQp5QW9iutuuTQsT1iab3T9aG/iELrKLn3wioZmBeEwuBEel7J7i8LcyMdnXpTcQQGUB4cEq4JbAVwMVTFI7nF04SdKkHve2GeV1KT8CauHs8pVhw1bbLqxNmGPcipD/uTwEYa6rKU=
Received: from SJ0PR13CA0158.namprd13.prod.outlook.com (2603:10b6:a03:2c7::13)
 by PH0PR05MB998601.namprd05.prod.outlook.com (2603:10b6:510:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 22:40:07 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::64) by SJ0PR13CA0158.outlook.office365.com
 (2603:10b6:a03:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 12
 Jun 2026 22:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=juniper.net;
Received: from juniper.net (66.129.239.14) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 22:40:07 +0000
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 15:40:07 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 15:40:07 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv057d.juniper.net [10.46.0.146])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 65CMe5rZ013001;
	Fri, 12 Jun 2026 15:40:06 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: <kexec@lists.infradead.org>
CC: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
        Brian Mak
	<makb@juniper.net>
Subject: [PATCH 0/3] kexec-tools: Add new KEXEC_FILE flags
Date: Fri, 12 Jun 2026 15:39:42 -0700
Message-ID: <20260612223945.1400554-1-makb@juniper.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH0PR05MB998601:EE_
X-MS-Office365-Filtering-Correlation-Id: f065d3cf-4e94-43bd-6c07-08dec8d38dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NZlKW3ihwv8ONHGQBDmlKeutZ4CyIq3+dNf/zy+/iJ3TnLjmkA6GldS838WrMnP8FXP1DpgcXmNZ4GNKBP84KuMoswfnlQDfuMPl6J1ek3R2HQUvpHHc60uUVtEhlBqK4e4dphJVYF68O4G9bKzsRKxmH73+nx/Eagvyp4d34C/G65lwNLWDnc10DbxcY6SN0TdRAhCm4wY9Gx+1cygDJ+cmEovK4IVs0OLSp3WiaIes4EQxRiNrfXhyUmOq5GZ890CZRcbhr0m8lZqLFL4re7F6wGtwRrId6cKYhhgRYNvtfiOZZ9C17YFrZa6EpYRoTwPusipzBM9GaCzgMCZ3ojhjGf7leI/8NO/qdoLMFeGwgjbx/JWeL3pjrBLnJUP1KE1YwwgNgw4ACg+Ol+s/DJ1gtBm2ejgTQP2fRqPpaqJTHwf3AIpJATWRSG4TLdgVv3w9NFEuSVlqb8uL4XBNPmprAOUIOZMWwUMkr1UdOBY2Yx9LmptGRajYydEnBqSq9YB3WJ4POXVezfKmivet2JqUax0U8qrS3F+4Xlk5yJ/d1SjjUAwtpAArTACuZ+GPxc4BQL8xA3QKYCRnB9aRTwE3ucp0PVDSf19ZppxoV5m2R98TCix8OxTpM0wny11Kfe97wWa94Dh8lI/uK0UJqurkYnjVCd7OrnQa60tQd/BAMwC1jqA1bUMFkG9UDwsMEq56GzK+9VaoN3AyFHkcso7rNcobS1QG6HIqra5e2vc=
X-Forefront-Antispam-Report: CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gkgC1WUfJb+CAJo6CsTC/ea2oZAXBND5r2Nl/9YWm9NDktYiVYF2hKnYSZcBIp04GRTe9hnr4XdHew/IRJhtgtayE7jgc5ThY+oEw0q0CGoydk41CNpeVrpp29eJLzgjH4md8X9NdaFOmmSTElYeZwgn4LavzknNF7DFuEWMuRfTCkPAujf+W2QW8WtOEZlyT1M7fk/TmQet7I2oAIFOBYjVU2SaK84Z7j/4QP4NZmEdLQXGcVWjt8Nm0fLOz2CaVtmDLxhTAAebgZIi5M94A+lyfn47CTWaODE1yDnDvxJ8vfsFRSGom/WnGNOrCpdoHmkpsqroTDrdjIEGhbSP5fCejkLBx617KAwpgMhwH/p/hchnsS9AMPYZ9TkwXQOBNC30EkBMs2e9OpyPBlF3pjjku5odQhIYc/2mUuzc+/PPI909cbZp8RU7VEkwRO1e
X-Exchange-RoutingPolicyChecked: mCRPBvmURfQLy7LJR/1xxfr57jPxr2E29sUlM3Qa2w4AKMoVVTcL+vjz2hBSr7uSnIcHf3c5rZYghk4qHkbDYhXimoQQPMIY+ToAH2Hf/1XTCJeoiEqqKw3vW7yoNdKUl7tquSCVLdpZoIJ2V9hdsMbd0LLiQxKtcUshiVh1D9POLs+LshIoGspUHnZW3GhPTicHjc6UA3iqpw69eWV6I3locWhQDILdKLjlUz5rpT4zLfGzdK7XCaGwmAynuBVsHech3zJzPc/8wEAeg0lGEriKRA+P5puwxRT2MOyit3cZ0j8xyxovAZFkDTURff0WsUc22nB5nx0mo/wJ0upZQg==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:40:07.4824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f065d3cf-4e94-43bd-6c07-08dec8d38dbf
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB998601
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX1viP0f3Y2FBD
 3sEP8mW2uiA7blOb9jNKb0k/+iGj7YR84Cnzlhq7WFD3kJ9/HDY9bO1+8RtY7or7mOOKGPBAczQ
 cjebg3dExy4E868jmQfFc4yfLE/8NZR9bAcZ9C7+4az2YeucYkhe
X-Proofpoint-ORIG-GUID: wYcvTWfr8UvU5j11gcrArgH60-TWzcYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIxNiBTYWx0ZWRfX/wLF0x9zsrFJ
 ew76E3ui/AeglZAPUuRxX1z7cCFy1s+HERiRVC0JpP6l+TyBdYnhQVS4WENTnBvjTrGsgEskm34
 IXjyXMoulMyZhpePwerdWyGOG2weOelgY3BlALhjJ8zzIsD+KWd/7GdYWFvmXL71i4hjV9c1z2L
 ZorJdIf0zYAEwQFOQ6nH0xb6hc/ciAKWR0VQAPP2S3+8HxQLDlqy/e+wZs07P5d3Y+xmCV8Z4Fd
 QdYzppI/JnMDmA7I7DhcVB2FMnimDt2BzHHbWAI0QuOG29lolEu6HimvFSt7yvl7N+UZ62QX1/V
 wduxPBCWm+D/OddT5mxdEMV2HJ0D5Lrs6JfeDZeMqxLH9DfI+xWI4Mejf9/QT27kdR4eb0ocfIf
 foxhUxfuwVZ577ZyHMHqOk20RBLmjGAuVYZPiH7suAikKEkcwO763TyUyt4gb6ExjN0j+BxzvES
 mHNuNiau5ANQPAnDY3A==
X-Proofpoint-GUID: wYcvTWfr8UvU5j11gcrArgH60-TWzcYc
X-Authority-Analysis: v=2.4 cv=ZvPd7d7G c=1 sm=1 tr=0 ts=6a2c8ac9 cx=c_pps
 a=vMZ8N8iCC09X6dpNzQs02g==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=kT44gYg0zFKYNBFEzlFE:22 a=3faxXdAzTQvJ_3AARtQA:9 a=zZCYzV9kfG8A:10
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
X-CRM114-CacheID: sfid-20260612_154013_292108_AEA4B78B 
X-CRM114-Status: GOOD (  13.06  )
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

Hi all,

I realized I forgot to raise a patch series for adding the new kexec_file flags.
Apologies for the delay on this.

This series adds support for the KEXEC_FILE_NO_CMA and KEXEC_FILE_FORCE_DTB
flags, which are used by the --no-cma and --force-dtb options respectively.

I also saw that there's no debug print for the flags passed to kexec_file_load,
so I added a print for that as well, which was useful for me to verify these
patches.

Please let me know if there's any questions or comments.

Thanks,
Brian

Brian Mak (3):
  kexec: Add support for disabling usage of CMA
  kexec: Add DTB carryover support on x86
  kexec: Add kexec_file_load debug print

 kexec/kexec-syscall.h |  2 ++
 kexec/kexec.c         | 10 ++++++++++
 kexec/kexec.h         | 10 +++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)


base-commit: f75be9241accb7a75e98998040933b9f3b988ac5
-- 
2.34.1


