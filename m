Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6FBC00140
	for <kexec@archiver.kernel.org>; Wed, 10 Aug 2022 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Date:CC:To:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iu0v0cKLjcm3/G3f4YQfu71kGq4raM/43ClW2ZDfUkE=; b=MmXI7jZ6G6qCz2
	j11TphSvVs4xGM+RXJ4eQec/ZpqvgMOhARDlaH4zKqdsnmjBWQ/tZCw3rGxEOVubRU3ZzwGvZwje5
	i57wxdr9bNq3+4RxAz9xElbTnx+osWF52W6HEvBM1ciLP3omsjl3pPN5MVUwsYVLU1Znq17wxu5Pc
	t1XMIjdnWueoxevIeZ/n18F5UkEtCOq068HFb8upmm0YgIJ1td9ZY4/bBteKQbZw8xHU2Nsr736ir
	UZEUOk9r+I7r4osv2T7P+SDBXJi7UIcS2Fg/F7v0lCrGOc0ln/M+rMBGOK2kVHoW9w63G/xkMD16K
	j+R08ZKccFR7X7rQY67w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlED-00Bru6-Ur; Wed, 10 Aug 2022 12:54:29 +0000
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlE6-00Brs4-K5
	for kexec@lists.infradead.org; Wed, 10 Aug 2022 12:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgcGeA2TvHhdixR94LM74B9ZzSU+/p82mECUV/1g7sN1379Ntdc1nVn4/LDW49GWk6liEsuM/sNJsxkr1+D8rXbuMQxkCQsEe8cw6v8us9m6w9pje4U1/MXOB4d4bwHzeiMgkNcDFnzRIx2KNI8TA6gIi2k10oPbvhaJfCb/xSs4zYnn0/WL+/fptdeaGnLdELEnDtr3G1KhpqzHKBVXuwC+ssnkeiLdXad5x2kzLkU049Td9SDEpHrzIQ0fPIDkpNzIUB/t+StWx3sA9OqRitR2Wk7NahQEvxtje0alfYt74Vo1pZGaqKCOnWWdpTd7FD2Mg9por+jJ6oCZ3oDRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6aygzDeOBoPBrkxaTan/UAIo3YvZ/TI4aNV/mxsS60=;
 b=hOxl0+XkUT6wCm4WjgrIM8vIxgtkUVFhhg5EdwWOqvWbuiDBY+aEgY1uZhIYoX+0xZBw0SE8ZAPIV461gfkblVnddGBMKvAEqt+k4vE0m2H64J23vRG2hyhEXE5QLKUrZRwQRjd2BDZvQoee/GwZycuDQ483BESKmqtwWGRr/3pmb7cWAia6vfQJ53EL9FjkA8PXP/kIb5Rd1tDFG5eTKRjRvrMCM/6yQk2HdNAVdOzFTO7WF6PbIctV46wpPHzY+t+swwPBY3vkEA+YZkPHMDXIuc8dvRmIsdh9qpY061qvFtFJ5ftQD3gLJNwkYxZf1sLFcI1/kCMgXY69AcrZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.136.252.176) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=stryker.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=stryker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stryker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6aygzDeOBoPBrkxaTan/UAIo3YvZ/TI4aNV/mxsS60=;
 b=lHeh1ercXUQYs4HqOZquGtXWj0jT/Cz0sjNzf0UzFJrzI4tN/sv8oDIK1QJV0nWVBIJZ+4GJN/kuIoKXCDy88UZzIMksguc8IRgdQBxVJG2VvsMhxIAQZuDRVjQS0PMrpDUQjNCLvIfCFz8gCDaAvcSLwTaaau8a+hRQR01uvG2z5QXZHVWIqZaCb+y+IxHtYPcDws+jMYn8uszw+FGoWku6TAkBuiMgZpAylsnEfO5uGhykffHjqw3/IA9YLAOgStlxKEd3yNV6UItnb/L2RWcSCuUImBfmxSvby5piuinni4CAs1IMbLHTu/R5ebRE6oreWFp5cbgtOd1mcvtcyw==
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by DM5PR01MB2363.prod.exchangelabs.com (2603:10b6:3:40::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Wed, 10 Aug 2022 12:54:17 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f8) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Wed, 10 Aug 2022 12:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.136.252.176)
 smtp.mailfrom=stryker.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=stryker.com;
Received-SPF: Pass (protection.outlook.com: domain of stryker.com designates
 64.136.252.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.136.252.176; helo=kzoex10b.strykercorp.com; pr=C
Received: from kzoex10b.strykercorp.com (64.136.252.176) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 12:54:17 +0000
Received: from bldsmtp01.strykercorp.com (10.50.110.114) by
 kzoex10b.strykercorp.com (10.60.0.53) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Aug 2022 08:53:37 -0400
Received: from bldwoapp11 ([192.168.131.10]) by bldsmtp01.strykercorp.com with
 Microsoft SMTPSVC(8.5.9600.16384);	 Wed, 10 Aug 2022 06:53:33 -0600
MIME-Version: 1.0
From: <noreply@stryker.com>
To: <wos@stryker.com>
CC: <kexec@lists.infradead.org>
Date: Wed, 10 Aug 2022 20:53:33 +0800
Subject: Der Preisverfall von Bitcoin macht Sie zum Millionar
Message-ID: <BLDSMTP01PpPku04koK0014b2d7@bldsmtp01.strykercorp.com>
X-OriginalArrivalTime: 10 Aug 2022 12:53:33.0788 (UTC) FILETIME=[330D01C0:01D8ACB8]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f470006d-3fce-4f94-c861-08da7acf6f7a
X-MS-TrafficTypeDiagnostic: DM5PR01MB2363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	aYRIpPRE6TsfUQ+3Ypxfu86/u+vlJeDRyXf7RBuYmfgmovITBdue+m7n/N1EePp5er8UNQ8YhuBm+dzP0A1stzRJfPJqoVPoyyuEpSPoC4M7oMxA3+qlbCCQhtNoFU4cQYSmefX10rp4UmaGsYisHhBDdHsw8JLd8V7raQf8T14kyORtJnirHaSK6WmQN4QSC/wtwMFIOVUaeEDql3evNnNK4LI6VTiXlOC9m6p3yi8O7UYWX/Lbw/ebvawDDQ1+ED4hxmv7S9hKRiYUfBJjDV8I5wggr2RBBfU4E2/uTCfv7V0FPjnjwsEvC41PkamtNHK25xK9ezlNF0cwFXg95Nkbf72J8iDJw7WKoxA8ZjvrHch/ITBxKFw4UoPvv8L0CjUXPalXRibcfims0w4t3+ok9TvA5KvYAS87ILHTVZNfJs3ZU/gDwlEh+SVLO/6MBdbp9vXy61PBn8EhvSu4qgUquXEQrCMUxqdZoffb0bht56oyjas0T7+hgeP2xsL9/JQ1UNVcVRJO2U02IHLIgxlm+raEBBkcQGvwLGC6ZRUuuDGwUvNeWLcvqKTGROkGxRlugTbmSyzbYJygXSxYAAskSy7ezf/jz0dFZrRF9daJPzp6lW6Ec1QgzjCzhk3UURpxxzZp/wChY0NO8k3DaTj12u2IhGEKHfnQuPqsEF/R0n4wgQNAeG9YiQ3oQ2+BG5Z5GSZJ/OS07Do0Bjvrdns2tn+W9fT84KjXV3oh7tx1B8hHnLg2Owji4oyivx7w7S96jUGgBIg7FxS8KbiUdfcHGO7M97wLYtiSCPW0JBfLwkKnv3sz9nC8eHLxm60RoDYikm2Zz+uxkAcgHn8HIw==
X-Forefront-Antispam-Report: 	CIP:64.136.252.176;CTRY:US;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:kzoex10b.strykercorp.com;PTR:ip176-252-136-64.static.ctstelecom.net;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(40470700004)(81166007)(356005)(36860700001)(26005)(9686003)(558084003)(86362001)(66574015)(47076005)(336012)(186003)(6636002)(2876002)(966005)(478600001)(41300700001)(316002)(5660300002)(4326008)(70586007)(70206006)(8676002)(6862004)(82740400003)(8936002)(40460700003)(2906002)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: stryker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 12:54:17.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f470006d-3fce-4f94-c861-08da7acf6f7a
X-MS-Exchange-CrossTenant-Id: 4e9dbbfb-394a-4583-8810-53f81f819e3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4e9dbbfb-394a-4583-8810-53f81f819e3b;Ip=[64.136.252.176];Helo=[kzoex10b.strykercorp.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2363
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_055422_891030_F710F507 
X-CRM114-Status: UNSURE (   2.55  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RGVyIFByZWlzdmVyZmFsbCB2b24gQml0Y29pbiBtYWNodCBTaWUgenVtIE1pbGxpb25hciBodHRw
czovL3RlbGVncmEucGgvUGFzc2l2ZXMtRWlua29tbWVuLXVuZC03NTAwMDAwLUV1cm8tYXVmLUty
eXB0b3fQk8KkaHJ1bmctNzE0NDc1LTA4LTA5DQpGb2xsb3cgdGhpcyBsaW5rIHRvIHJlYWQgb3Vy
IFByaXZhY3kgU3RhdGVtZW50PGh0dHBzOi8vd3d3LnN0cnlrZXIuY29tL2NvbnRlbnQvc3RyeWtl
ci9nYi9lbi9sZWdhbC9nbG9iYWwtcG9saWN5LXN0YXRlbWVudC5odG1sLz4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
