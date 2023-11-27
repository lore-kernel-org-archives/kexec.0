Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0DC07CA9
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2eF/Avdo3wKW1Dc5EhsYk0isZzJGEbdCFlMFyOu8vkU=; b=geQ36rbuM08G2D
	ICZm1aqAxc38lOP41n6wfPnr8qaq/HICieMfCrGgo0oPuj8dxIexPO5fyYnQKu8pjWT5xEPmCVs59
	vcgOpM+XDtlVJDBw0Boz1jnq3h51SU3eiVf6j1BecwMBtU9NXCB8/Frlx1MokNLt332tnGChqw6W7
	KjWeuXObgsj/1YyDtFd2B7GbPryoFFW9cu8a4odRntBuHD2U5Xv58k1WbTcPeLZ19b6xRHAvSp8eJ
	Lslfc14oLHKdwDSdNQzaNfH8RFEyQqOuUGdUlvWkmzaoSttyZclbgJ14Qocv0n7rL09o93B/Bh6SF
	SZY53uVj0eYLiEpmS3cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7R2l-000a2z-1b;
	Mon, 27 Nov 2023 02:08:15 +0000
Received: from mail-sn1nam02on2071e.outbound.protection.outlook.com ([2a01:111:f400:7ea9::71e] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7R2h-000ZzV-2P
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 02:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBTTPu9M6BBQoaj6daptJRWoEFGfzHaW7hy7SbSLVR4dX1VQGT9Hk98RLfgWKQS+g95B311UwQ/tVOj7lesf30HgOjEGWxvquGiZfxcc486Tjg+AtzYh0kaeVjtHycX7PuFe4Xv9DgWhihSpR57KW5dmh2ee8ifPsdM8eCI6UoGdo6WJA7gvOZc5Tm56Tm4wC5LuHhQCyqXXtSki9o56tg+kXEcGjrKIQ6TS5cqc8ixgXRvc5NTmHHghH3EMV0tRD0Uphuow5r5tQ8Tx2k5lW2CGO6qFxJzpsTJxnthIjznIx55JFZRS6xzMA7Ckf0aizr5nTCW0lvc/ITSH4v8UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJydsXx1Ha46Vgcq4zg6QmrLj2CWYUVkrM2cHsJj6eA=;
 b=dNYREbQ9f8yI4OU4o5pevy2sKPdH4I4qPuxTiRpBiCM32P7B8B6y21DRiC/lgBhioQUUMwHolmI8yYZwqtiPdSo0VLMzK0ysRM889DWvlRE54zU+5/vm6JO4OFC85Y9mivGW1n94zM8ggrvkSkWmZOurnaPZDe7uqXQ4vEzfJFKiaK9k1CggM5ocFqyO5smpte43hjBlNCfS0tzfbiJygO2p4IWn48SPspxEcoyYm4x2DL+IX8321EM//1+M4fADOrEOnuIjwxUYffjqvs0oc0DPEuHV1HmOYjLJ6KHCMFDfapSB0a5E2EZx/4O0MREgYsof0KYoBQ3knp7nF2rdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJydsXx1Ha46Vgcq4zg6QmrLj2CWYUVkrM2cHsJj6eA=;
 b=JpG3MkPZocaNGwT4yTKJy7SZD7DpUnHPE04JgjwgDlMuMXsrQSJY5+PXyfWY2etbG4DV0JeAys455yGzaSo2XgQn8GFkUegoPU+MehY2HuWp/wZ63UAbUxaVq6FQ2D5gYmmLQA3xyaSSrf4C92cqkLL9BN72AMqVBZDjVwgyDq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ0PR01MB6381.prod.exchangelabs.com (2603:10b6:a03:29b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 02:07:53 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Mon, 27 Nov 2023
 02:07:53 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: bhe@redhat.com
Cc: vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP is enabled
Date: Mon, 27 Nov 2023 10:07:27 +0800
Message-Id: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
X-ClientProxiedBy: CY5PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:930:1c::27) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ0PR01MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 10038ec7-0fbb-4b63-932f-08dbeeeda9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMxgxyvz6uOZgWYjWmH7Ih6FBlkViWb/0+eKORhXXm8F/nP1rmY3YX9DVsAlRZst2NkgWdsfFjnt8v5o0ucAPHmOvDtwGLGxpRpH8Gx/aiI+mrCTf7omtTNvFG78MTo1rrwH/1auahrvhcx+Zz4+1FXCQYGrHrI2joKF6aflojtVs48leI9mObNVytMWL4jHg0T8XO84xcXSioOa9kSINvuLccX5YIZwYjpH+34WOY+XpkX48fM8CQdkSLj8siiju46VZwAT+K0A3Fej9irMOLG3t/Tz8d0HVHD1rv6MO3dUKUTbK8cuV8IJshZzBDQuem4v2er4shLkyA5KGvHOb4qDSbivwIDznFAPcC5Jt5tNVQiUbGKYRHZ6jpAuIMUZcoGkGAbQ0ZqZMt5r2UkCzkX3nINpWXS0WGxg6d/Uv4RhrpZcKGaHH9ZF6YN1Q8T/swqrGGxkZ5Dw8Mv51ikvfQaWnE1Gbfh5hbmRRbNCEs2Yn5MiW428A/KuA9BzbVPiTsut5KOB5mi1/J2QIfY12JUBTKcWh9F5wgzHXIMP9i72YH7nMzrHsoRreGe5nEwgDuGqCLbMU1GorUq/SSrK3JtO7XANFkiFt3e26rVlva69XBs38vDNP/g09Xl17nt8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(41300700001)(2906002)(4744005)(8936002)(8676002)(6512007)(2616005)(107886003)(86362001)(52116002)(6506007)(316002)(66476007)(66556008)(38350700005)(66946007)(6916009)(5660300002)(1076003)(478600001)(26005)(6666004)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsoWxVtbugW9vwM2OAnhcIC7g19oRsdv+Vbf6pITwS0iVR1/BxNHFgquqCJf?=
 =?us-ascii?Q?L0br6ynlIwTx2Qp9s4f1ZSHvEqRHZN2uhN66TojNWL3UuWaglgSq7vwv9g3H?=
 =?us-ascii?Q?bRBMl8lycqwxta3lY+wY8Rdsn/oXX24VZNn283jwgs4241UdH3JYS0R1Gn6c?=
 =?us-ascii?Q?Z8UvIp2t0z8BLfyqnuIYHSPC0fyaDf5Ty/6J+pfinkDRcMdyc6jBThNKIe8s?=
 =?us-ascii?Q?AskOowLpIWSPC2WbHeY9dPVDwkl1QAXwqiInhMWNI3p0mvdZOYy+4bVtfkZr?=
 =?us-ascii?Q?c3+8BXjV6aVc74CvAU0enoafNbaVWWUlSxyq7rdC2rIra5Xo5vBLswKQUHnA?=
 =?us-ascii?Q?oH+6f48uMJHuBc4HZMjYKF4W6jfnqWtXdD2Wwq6VILMtdIJFVBhyqa6Jfcxc?=
 =?us-ascii?Q?YUdg7BQiD3CJOAB+8sW15tu+xNgkka8i9kHUHAksHFKzyNjcfg+NH4teu96v?=
 =?us-ascii?Q?8RwU/+zX15cThin/6EHZ282xB1nq0pfEYnI0GluOsaa3nFAwCiWWmSNrOa6b?=
 =?us-ascii?Q?LMq8K4etrw4iwjFztnFH10AEMyaiKKwNXclIqixYrYbQYXyX9+4lxPXQPYiO?=
 =?us-ascii?Q?xvKyGPf4tjxx3nYKbiNPurn2EreLZ9nVpUdMr88S1J6DCf1x57hFRLqbdx1R?=
 =?us-ascii?Q?+dU54Hy2MEW4LDxNenbJHRYVa4WqHTRdhTcOPlrgUSYdJU3jwXbjIt1KqN6t?=
 =?us-ascii?Q?7PcBa/Q7+kTrk6EVCpDvvgWJJsQyMK5fSGqnXXh2S+Quegl4xOoe3ar9vp9p?=
 =?us-ascii?Q?5BUf6aHlftieh/nk0V9LZP/B0gY1VegWWRgtUsktbLdQ8B2UybPvIYcLLfPa?=
 =?us-ascii?Q?M7fdQ1EgHXCAAclRhn6dzr30tw5glWcw8tlG9sHvflK+DU57mHSx7D+WKu2v?=
 =?us-ascii?Q?Q4n0hRVdZXfvgobO3vdNn4UBF4pgQmPoXceuhZzBXOBOhxERfH0idigukJcO?=
 =?us-ascii?Q?/URwRVc8RmQQbEglZE9N+ztSkq8xOGumqedVQmLdFKsNHVEw8lCqRi8c0j33?=
 =?us-ascii?Q?j6moXkYdPlA/6dYMrJYZstQZWeaNkNkQdnV74KL5hthhqrDOM/yu7oiYuUvT?=
 =?us-ascii?Q?PQBnSJqy+PmdPPyN4cDCNVEqjSmOoyX7HwiegBttlQ3ATyUDpZYdEiJKNfgK?=
 =?us-ascii?Q?85uvxvB/sVmUGLqCpeEh6/E8kiOcBHum46Re9erusPHk986aDGtmMwF9vPYk?=
 =?us-ascii?Q?jIZKqehomneh+g46eDz+zchPCghtL+270enwtPRFlenFJF86CbbyZzNdHCOh?=
 =?us-ascii?Q?nYODY86v2e9qGZF/b18zWTF4D0mG10QI6AFnB9sP3ciLgFn1svqpSyH/rSWI?=
 =?us-ascii?Q?Z3qZ6sO36OQrStwfHKpF0BWPQ58nv3rcOTA7KegrhQHOeLXED+i50NbuziQC?=
 =?us-ascii?Q?Kxe7/DkuOP88vh90nbf9QxlBacK4bDGwMIACvQrP02LfXQo3wYS5O2ccvTti?=
 =?us-ascii?Q?S6Y830zEV4MLVds1me2NDT8Jcamz3aP2fDmcAUpWMOrdU+PpoYSes7ymPXgz?=
 =?us-ascii?Q?QxADido+BLazSR/sb/dDbqwowP8WigNSyzRSh/UBMNnIKqPHLsMapF1dDzwI?=
 =?us-ascii?Q?1BFcHPSQKONOk7jmw3JdWKYGAFuGC1nq6l3idX1AQwzgU1KCV9i8n/eQhrXq?=
 =?us-ascii?Q?LFqywBDPvpuBC/hLTRcf2iM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10038ec7-0fbb-4b63-932f-08dbeeeda9e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 02:07:53.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLEWB2YQr7Eeb4pdqVmJM0cFun/CyUm/x4RBGge7PQO6l5QQzGCt0gpJt84OXoJBfaJFzu1L4xC+vbHsdRQUXweuqwNsyOtnqJjHY1OjTPx7tQYbVkt5A/ZY6pmygIT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6381
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_180811_809574_BB763560 
X-CRM114-Status: UNSURE (   8.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
and kernel will not use the "classic sparse" to do the
__pfn_to_page/page_to_pfn.

So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
This makes the user applications (crash, etc) get faster
pfn_to_page/page_to_pfn operations too.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/crash_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..9653c4177191 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(mem_map);
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
+#endif
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL_ARRAY(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
