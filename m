Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258A5D6CFAA
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGYIuGOQTrqVTLgT4dS9zIiXMLES/usiky9mGMsDGoo=; b=QsnfUyT1Rfkb3/83OYcY5JY+Kx
	Zs04XWloHoh81wiUamB8mJdoyjuQG2K7N+RpYHVebfSbdULlkuzzcx9CdnuyXxYJBgjTgebJTS+4J
	Q74ubLsEtpRW+hynB73wVZ0P8EOLx2eeMQSqm2D/fCD/fYl7SV2dardLmopgwTKTgLfiPvkVsUCYd
	q/konZxxrvE4T/KLdjnv7sitoV2IggOQk4HsGOHbg6/x4tls8grTJDrR+7tqWpRitM906JhJFMYb4
	GpqbtrnDZ44rmxz3WJT9FrkUKkP3sUKN2pL3bOqVNF++AJM+4/7ad1e3s52tKXtvvbRTebs/1+vDY
	qDl+40NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj5bN-00000007wo3-2bqu;
	Fri, 23 Jan 2026 01:04:41 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj5bI-00000007wnf-3Otm
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 01:04:40 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MNRbAD330099;
	Fri, 23 Jan 2026 01:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bGYIuGOQTrqVTLgT4d
	S9zIiXMLES/usiky9mGMsDGoo=; b=XdrphF2uA+XWeP/mS3n3sbaSJG9FuPA3Iz
	033I42eyU7c/YP4CV5LfaS1VlMC+C4j/KgxGOZz4+O9BtY6r2wqeB3o11UCHL4ZO
	RhlsYyMA1pyOr/WCBYlN34ojXSkzBx3swDHvoTNnH77YlbTQCQJ3v3VyZnH6iYFF
	9TGHmBmV0aNI5ddIFHndBUzNHGm+YzebtRQ8TrfkcQgpDFdWj6lh3JxdeitWJ6/0
	QSI7Uv5SXgoxnfE1eR24N/Yqso3tc/bZIJuN2+/QVM5L0FNUEvXSa/RJZ3K6Wva3
	zbsxmyPNN/Rg7KE6+SedDm5xk1s4n+N7hFrKDP6RyhdYmpovdz0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd5qg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 01:04:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60N05bGR035770;
	Fri, 23 Jan 2026 01:04:01 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bux4xhrx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 01:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSsGzvhVBnALFhzcwYWtfJs1s0WD8j+QIfyeD6sQkl2zdnKzvheEGSD7yjzWK/VCyRSs/9JiJyRG+0wnve0SfmgmEwP5RDkMNNINgrzQuNz1pm6g7JZJShnyA92ZLAyyeEsMZty+1TEsoXMsKpGW5bZLMWOY5Ma5P0Ex0rTN1QHrwdH/aSHgKzr9zdlLhjTrRd2/JwvdGgKcRW5fByNJL9u7bxTwJxLaeB7uXLiFWx9nfUZV0GddJVSI7ht3mpoohkDgUIOwA5tUs7StRMJQ/bc65zkGKoXuCY+kwFAe5UcPcNMj+XlzL983ujE2kMiaWYGjRQ2C82SAyteWa8TIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGYIuGOQTrqVTLgT4dS9zIiXMLES/usiky9mGMsDGoo=;
 b=V9n9VomyQjlhOv1IDDLPv9ahHQ9ItzTeZmGUREfvedeZAHTU2wIgN64hpVDxlJ0BPAxqe4KhpFiQytLpSEnUAQofrrb7O1A42xmYc1MWVUCunynHhDH2qUOw1Tz19LMEPfR26mVs6vxdxVjIX6sbPxmcBAd7Q9w24jMbrNRcyhApKde3IfMfJeMRKXMp+U+/KROEfWOJcTKR6nkE12Dw4ZuoWMD2lR0zIKbziOIXAg4kaSTvXisMhu7IOtXvoEmobUZsCncv24IhMXpznWI6SQsTRJ5QS/KHnhp8Esq4onV6rMnxcRkCQmjE9EZhEwMednq7W/E2dwBPNI8/OkTo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGYIuGOQTrqVTLgT4dS9zIiXMLES/usiky9mGMsDGoo=;
 b=UKLUd2PNScw7CcO3Gh045y2p+9sy5BZBMfVcUktNyhNtb6d9haBeeJVTP05HJ7wVGmLgBNjQUt0DuBFrPt/kVJFuJEMMk8JV5FKcQEW4Qh13NavRXMzjh0P6BvkuATAT4cHXacgupD4pr9jFirN8mk5m4AhFzzyf4Cya8J1Hzio=
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9) by SA1PR10MB5760.namprd10.prod.outlook.com
 (2603:10b6:806:23f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 00:54:56 +0000
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d]) by PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d%7]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 00:54:55 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v3 6/8] Add page filtering function
In-Reply-To: <20260120025500.25095-7-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
 <20260120025500.25095-7-ltao@redhat.com>
Date: Thu, 22 Jan 2026 16:54:53 -0800
Message-ID: <87fr7xup0i.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::13) To PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF654CF2C22:EE_|SA1PR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: e63b7519-5145-48e9-ecb4-08de5a1a0636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QLTqWhLL1azr2yGpbrHf2hyfZ0fRnukb10gh+MGcyakNVX7CarFsB/C69kKD?=
 =?us-ascii?Q?OH55Xt5icrBvBOIg/jf6vd1wg1P9zLCFTHQ45qSl6j13XinfNf1xdnkp16AL?=
 =?us-ascii?Q?iBQCYN6yskHJjVXhXTp5gxPZ2MsllN1p3xbakmL3Jyvo+ts5FHYN6I7MnXP7?=
 =?us-ascii?Q?96/I8qaTvZ9Gclg4KNDVsRW9m633/5db65nOLv0aHsfbrVSPGdsAo2T+ZGZE?=
 =?us-ascii?Q?LmQqbLMcdAJiBr4kwFdm66BdBUy/OTOA4MDfDxH27f/nAx9CispEIzBm6Ru2?=
 =?us-ascii?Q?D01CYcQQZ582Qn/6KUQpV4J/UYhcqnTlIaLhg1SMWVmpXcgGppj4ecwu6utC?=
 =?us-ascii?Q?rWLfn7xj3r2tKFMPorPZVngmmWXLlrcWetY5JjEemdAHbVlkxzldiyl65dox?=
 =?us-ascii?Q?plE/Be2ADthPtJolZ+hnDWYAayzuXudDD7dleNQkQ6tghCfb+77WLkf65J9q?=
 =?us-ascii?Q?PwuYky26v1ZOhhM1C9IxcZD+8kSAImzBMZitzsRq7suoGGsgxESmOIa2ZCrM?=
 =?us-ascii?Q?4hC10YgjUdp9wqOiDQCzxrPxjeQrBFkBmQZraYs3hoYFfSBCUFrGo7I83fmG?=
 =?us-ascii?Q?WrD9Gp9EDb69nuMWifZnXMghd5iUaNOcBg4gOgKdmozYarumzRl3ptLFE/di?=
 =?us-ascii?Q?6dcPeU+tgPe5OsnbileWV/CDqnOuMN0rtq3xGp1wTNP0JUxjv9ZeNXhaZP1/?=
 =?us-ascii?Q?1/uyvcT8AVzROauSJLjH6VbGGi37u2MoflvGF5Wbz4QpbsKi7+0mPyEcQNiB?=
 =?us-ascii?Q?NixO2rJ2nfM37JoefPkCRuK89nucFWJdxf+GsQvpSPhiuZB0PB50v1sy5Gfc?=
 =?us-ascii?Q?acv2ZEvJ7xO3+fL0O0QFXj4eHBUDzoHmjUKK6h9s7ETTBv7755BOzU6JjedH?=
 =?us-ascii?Q?+gfkQ/Ch6mHXRk0K8ChDgGp7i6v0FlgzG7F0Zw43dtkcff3MTTv8gHz/LvAo?=
 =?us-ascii?Q?glI56668jF8kk0O/ilIRIDYQaNmYO96IEML+4a5znREYHlfm13jqRfqnBUtZ?=
 =?us-ascii?Q?m7uRVGtHft6gyjhnbFuGpHoouhFL9TSCZPzIZ5VV9/qf/wb8fCw/3WGn20sU?=
 =?us-ascii?Q?tz6CXP6/fysD9tNM8ooo4+eihaJFPX6a93GfPNX/sU6cZIh5JQf9xlJ39dsN?=
 =?us-ascii?Q?K69X1jvaZagaxztX7Q/Rrwp6g3zDYcMHlBh6+uH3Z5AcNDxcVHzNLO0WIfNM?=
 =?us-ascii?Q?Se9MUY467Zmlaw/RbqpJLQlIBH8B9rWV/hZizekeKenkCQHAu3ICfUBOyVMX?=
 =?us-ascii?Q?oaNusUbF6k/0NQ8Gd0QvK2GaMVt/bFkVvbQijLMEjrgWt+9tmJBz6JcshZuI?=
 =?us-ascii?Q?kbIWXuNbHXNcyhszNq2+/Pai2ymk4JDsxRmS5SH6A74foCqZKzsaWtAm8YiH?=
 =?us-ascii?Q?3p31xxoM3nC1R4E1dT/iFEgf0dqBvIb3SV134d187GDST+EvYBcdCvorDO6H?=
 =?us-ascii?Q?HrsFVwd8OmueM5B9qYw34X7Mf3WEoGg98dJTegnDYBaMbzOTrYeoaK92HINy?=
 =?us-ascii?Q?aob99wz2o2h5KjqJu8t8YWAbPgZ1GHS1M9UjWjM9iHnQeQ1vZTLulAZ9HmGk?=
 =?us-ascii?Q?sQJmdHe9zhVmXvfTF/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF654CF2C22.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NxuyAPuYjr6cKTg1FqvP5abHF/W88NroPOiDrHA8NYAOI6mMk9pNWw5KUybW?=
 =?us-ascii?Q?bUTsZApaNxuV2+P0b+oHqWevut98Ol4Ce58PbNEh9X1fu+p7mjAasZIweNcC?=
 =?us-ascii?Q?YXesFdiFLLmvTKPHWd1Bpu0BY38M3VWpA3coJnh2JEAyWXFIczTbJspxyk+P?=
 =?us-ascii?Q?fUzU+YBKaayYoE7Ivc4DalThVUvrKhwbLIpNJzFSQE/tw/DH473E7zmyU6kN?=
 =?us-ascii?Q?Hpgmqp8IgP4xJ4ytclh289FRg8TlRIvfKJZfCWuSrKLZBWegnjOfAshEu7Px?=
 =?us-ascii?Q?A5elra1pPX6RHyU/7L7p9Fuuif+h6e8FsiWl3OxVL028SjJMm6fes6VHoM3C?=
 =?us-ascii?Q?SGcZlufiGKZ/zdasmiVXs/BR4KM9MoZd+huV1c91MuMCLtRzUfMnLr9OK4I+?=
 =?us-ascii?Q?0Lbd741pqNdU3am5Kg1727/eYkBJ1Xlw77AHh7aBQxWnF7GuarBQCQbTcQfC?=
 =?us-ascii?Q?lYkVuS5LXsGD1QSLrijWNtRdTrLCUbIsuwDXhU19sv7BXnSyCKfGoRM0zUby?=
 =?us-ascii?Q?Gr9RQBQsWz3XpB2PZ0klMd5gCEkzFkYwr65XeGIE+VUejM2oYcHd2kB8L3Mi?=
 =?us-ascii?Q?OPq7wpVWTLUcm9/3wmGGf6pMwVhGX9W4sno6CkW1Tfgu8t7lFw/4MR1D2Mku?=
 =?us-ascii?Q?claOlzTG6s7nm3jZ1+pLE9iwZgL70dZceJbQzHbk17uzxRr7320v/oKcd4hu?=
 =?us-ascii?Q?/g5XoGfLgoe0KI/MRGWR+csuUc0jWFWdFPTbQbmK+OKpA99cHmmSUeX0xzQw?=
 =?us-ascii?Q?V3fyH8FjVLX8JJjhY6OHFOhZoiXciDw+gJdQ4QkdyDUqhSP7ST9syFBf7V2J?=
 =?us-ascii?Q?RxZG5UdV5XiOnM8BW2v2b5My5ui2TjXYhb7Cc/OsYvUiCduvsL44BE5lC3kv?=
 =?us-ascii?Q?LyXn9os2LH+hgjpLuwfkUuOhsblj1v4BAHSg6JxQiK0erQ4rB2du2veoGRtE?=
 =?us-ascii?Q?uNgw3adRdexZUJBvEMOncx1yt+aKPxym8HgxK8XoEO56v28uzyzLhR+fbvnU?=
 =?us-ascii?Q?xaHQ3QYT35Alx4pMpveu6UwgDgNXqLtCEYxMSOlCZTamnoSNtFpAGao24mCY?=
 =?us-ascii?Q?HyUc6M/miPgedgpNMj4JEeXpHTCDZgG+SPGOANOD08u8qS1+2udoB85Iww1t?=
 =?us-ascii?Q?tcAGPzJicUNXpPNOdOybeAZkEDSu2aK9cV0JuZCUP17F35Kwx9+uMnJv3ZRq?=
 =?us-ascii?Q?c8OKJVr4seYXQtpMnuJ1EN1qUYyHudPKVKGWqSdLILkNAWuyp4vTk55UfkyW?=
 =?us-ascii?Q?q6idPaAlD344skCp3MFbYjCAl9OoxHb2vkKrWesaUkzYmY+ZbKMZ6/ThDdly?=
 =?us-ascii?Q?c8TcWv1u6vqho9yvWYA1u9vLEHMm4haQXSuvoxcjmPAGZinmw8xzfvIzkLcw?=
 =?us-ascii?Q?zw6nTc+wKXCGroG2X3XltUE1YM8WqtmduKuHUL86Q+4qppci5+CcHVMI8M+K?=
 =?us-ascii?Q?jZem56whQvMpEO2HWNrcgfKZ2vjW9olUT7IC8G9r0KTpzEqm60rxDNUiyDn5?=
 =?us-ascii?Q?r7ESQtYd/KVqGZiq0d7vnxcE1HWWypZIhIfmAGVCBoByoFJFfZ5z129KSlkQ?=
 =?us-ascii?Q?zTECIhTrgCBU2wz6uEjd/AkCX/DH/UvvrY3SuZHqfEcWd5n/055mS1kb3s8p?=
 =?us-ascii?Q?U6G8VDoEURNX8nVSnVA3/tCwBxvj4+7S1s/K49A8kJb1HnFqP5s1Zd+IdXsx?=
 =?us-ascii?Q?jFZzCklH6Z7EU1LuH2c3WRYXHvxE+T84xjnOcaM11Kdwpv+zPIOzuUKzZz+6?=
 =?us-ascii?Q?Jd/j84GNp3sm5a5GzQLEaHx5tlg9Oik=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FP0038GumCxiFpJ+KuYeSM/91ZCBSG6FX+ox8o/YblzDxyMTQhQOyeJozoo6zA5Xa1LQ2NZeLuN1qppn7FULn8ysEjC92boQDSTrLlxRsjYQ5mfMLzUz0E7ozmMJ+NkUkPEDtGkIfHJqTWw3kDzWvmjutntWrmFMjIxhBgtiE50bwwvkUCvux1d1FM7eVxLmJa5kXrllu1B604CTpC4/K9gsGXv3v0W7Pfzs1l4rK27aC3xi8wohGEZtScRLTDHbK3fWDFe4FWGbCtBZuV+CsOgEX1vH9l/lXE8kBVPoKUOj6pS1z7iQtPykrYjmnOAhqL2wFaJk+z/PlmKZHVOuaYjZ1DXuKfw+IzgqXbdMrwhha9Du7ndWBz6ewSSCS8hxBbu3zilA5PQYuWyYpPXSOJ1jE7RU8413pKiJAHIfibgpJshcnNgjS7OymwFl7HEsUad7J4OR0hkzfPEk+r3wRlWAxP0ZgC1FiCQvW/drUj/sGNzYS68rMKqIZTHbDvWfVltaLqwlWsr5Z5U+Wp5yDxbBQU4sW9xbB1xFOvqTO8xECGPNXeWewV5RX09seKGNIa2xloHVmCHCgPUfjd/tF6J21Y6scBalyxyJ/U8b2HA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63b7519-5145-48e9-ecb4-08de5a1a0636
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF654CF2C22.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 00:54:55.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cme5mVqAuaeCUat2JEKI22VAwbgA8PZSHbZmbvlbUxy+KkSqsl6JLS6jxcix5tCDkkBZpCEMwBt4DUkgLCxA1AhoY0G3uvrGj8eKjKJV3rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230005
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=6972c902 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=nzJzsZH0OtD7SrQ-5kIA:9
X-Proofpoint-ORIG-GUID: P_lVxxlPUEAgLoNQ34VaH9IkW4-LNoMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAwNSBTYWx0ZWRfX4QpulIUeImH0
 pBZm/DOkEE/TkBVglr1Ud+WY6M9ecmpn9i4yqMt528nINPLZ9y4CGj6vf9rRLPk3ubmchA09fyV
 tePyVDJlAUKEXi5Fbbhlac5vFKu20pZAt5UvOIiRCAoS+/3S9W/G5Khx1cPKKW/FMk7/5Vhv/1J
 +QL611ES4rSHpgQxlXTC2ZAyiFqj08ny71Dd+ITpKYwZqfYeDvqzy23igGQtfSVxX+t62BoDkQ0
 /YqpdRB8+NJbWboUDq5TfWkjUgpWHY9JYPCGyur91nireMze1UQpjfIaOXUHRHAy0o1wAA04xXI
 ZItA5S2I2JpZFValHbpBAz4DFbvGkLLRkEd56wGs/vvSMZE43iX9+r6zDzU9SNfJEGH/W6hpSYB
 4uo+MIlxYXhCypOAwPve6h/6UACW4fhKlcsj7Ves3gj0fDpO0HjEzYvlLorsiNr3xnirvvZFJ8H
 weT1UsDE+N9gag+54Vg==
X-Proofpoint-GUID: P_lVxxlPUEAgLoNQ34VaH9IkW4-LNoMX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_170437_425784_9BC46FBC 
X-CRM114-Status: GOOD (  24.93  )
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

Tao Liu <ltao@redhat.com> writes:
> pfn and num is the data which extensions give to makedumpfile for mm page
> filtering. Since makedumpfile will iterate the pfn in an ascending order in
> __exclude_unnecessary_pages(), pfn and num are stored within ft_page_info linked
> lists and organized in an ascending order by pfn, so if one pfn
> is hit by one list, the next pfn is most likely to be hit either by
> this list again, or the one follows, so a cur variable is used for saving
> the current list position to speedup the pfn checking process.

I'm wondering about the trade-off for using a linked list versus an
array. Using the linked list, we are forced to maintain the sorted
order as we construct the list, which is an O(N^2) insertion sort.

If instead we used an array, we could sort it with qsort() once, at the
end. Then we could merge any overlapping ranges. Lookup could be
implemented cheaply with bsearch(), and we could continue to use the
optimization where we maintain a "cur" pointer.  I believe the overall
runtime complexity of the array approach would be O(N*log(N)) without
requiring hand-implementing anything too complex, compared to O(N^2).

Depending on the number of pages (and how fragmented they are), this
may or may not be an issue.

In my testing for userspace tasks, the number of pages retained can be
on the order of ~100k. However -- my use case can't really use a list of
PFNs, which I'll explain below. So my use case doesn't really matter too
much here -- maybe your use case has relatively few page ranges, so the
cost of O(N^2) is not bad.

So I guess I don't have a strong preference - but it's worth
considering.

> In addition, 2 ft_page_info linked list chains are used, one for mm page
> discarding and the other for page keeping.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  erase_info.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  erase_info.h   | 12 +++++++
>  makedumpfile.c | 28 ++++++++++++---
>  3 files changed, 134 insertions(+), 4 deletions(-)
>
> diff --git a/erase_info.c b/erase_info.c
> index b67d1d0..8838bea 100644
> --- a/erase_info.c
> +++ b/erase_info.c
> @@ -2466,3 +2466,101 @@ get_size_eraseinfo(void)
>  	return size_eraseinfo;
>  }
>  
> +/* Pages to be discarded */
> +static struct ft_page_info *ft_head_discard = NULL;
> +/* Pages to be keeped */
> +static struct ft_page_info *ft_head_keep = NULL;
> +
> +/*
> + * Insert the ft_page_info blocks into ft_head by ascending pfn.
> + */
> +bool
> +update_filter_pages_info(unsigned long pfn, unsigned long num, bool to_discard)
> +{
> +	struct ft_page_info *p, **ft_head;
> +	struct ft_page_info *new_p = malloc(sizeof(struct ft_page_info));
> +
> +	ft_head = to_discard ? &ft_head_discard : &ft_head_keep;
> +
> +	if (!new_p) {
> +		ERRMSG("Can't allocate memory for ft_page_info at %lx\n", pfn);
> +		return false;
> +	}
> +	new_p->pfn = pfn;
> +	new_p->num = num;
> +	new_p->next = NULL;
> +
> +	if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
> +		new_p->next = (*ft_head);
> +		(*ft_head) = new_p;
> +		return true;
> +	}
> +
> +	p = (*ft_head);
> +	while (p->next != NULL && p->next->pfn < new_p->pfn) {
> +		p = p->next;
> +	}
> +
> +	new_p->next = p->next;
> +	p->next = new_p;

It might be wise to defensively handle the case of overlapping
PFN ranges by merging them.

> +	return true;
> +}
> +
> +/*
> + * Check if the pfn hit ft_page_info block.
> + *
> + * pfn and ft_head are in ascending order, so save the current ft_page_info
> + * block into **p because it is likely to hit again next time.
> + */
> +bool
> +filter_page(unsigned long pfn, struct ft_page_info **p, bool handle_discard)
> +{
> +	struct ft_page_info *ft_head;
> +
> +	ft_head = handle_discard ? ft_head_discard : ft_head_keep;
> +
> +	if (ft_head == NULL)
> +		return false;
> +
> +	if (*p == NULL)
> +		*p = ft_head;
> +
> +	/* The gap before 1st block */
> +	if (pfn >= 0 && pfn < ft_head->pfn)
> +		return false;
> +
> +	/* Handle 1~(n-1) blocks and following gaps */
> +	while ((*p)->next) {
> +		if (pfn >= (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
> +			return true; // hit the block
> +		if (pfn >= (*p)->pfn + (*p)->num && pfn < (*p)->next->pfn)
> +			return false; // the gap after the block
> +		*p = (*p)->next;
> +	}
> +
> +	/* The last block and gap */
> +	if (pfn >= (*p)->pfn + (*p)->num)
> +		return false;
> +	else
> +		return true;
> +}
> +
> +static void
> +do_cleanup(struct ft_page_info **ft_head)
> +{
> +	struct ft_page_info *p, *p_tmp;
> +
> +	for (p = *ft_head; p;) {
> +		p_tmp = p;
> +		p = p->next;
> +		free(p_tmp);
> +	}
> +	*ft_head = NULL;
> +}
> +
> +void
> +cleanup_filter_pages_info(void)
> +{
> +	do_cleanup(&ft_head_discard);
> +	do_cleanup(&ft_head_keep);
> +}
> diff --git a/erase_info.h b/erase_info.h
> index b363a40..6c60706 100644
> --- a/erase_info.h
> +++ b/erase_info.h
> @@ -20,6 +20,7 @@
>  #define _ERASE_INFO_H
>  
>  #define MAX_SIZE_STR_LEN (26)
> +#include <stdbool.h>
>  
>  /*
>   * Erase information, original symbol expressions.
> @@ -65,5 +66,16 @@ void filter_data_buffer_parallel(unsigned char *buf, unsigned long long paddr,
>  unsigned long get_size_eraseinfo(void);
>  int update_filter_info_raw(unsigned long long, int, int);
>  
> +bool update_filter_pages_info(unsigned long, unsigned long, bool);
> +
> +struct ft_page_info {
> +	unsigned long pfn;
> +	unsigned long num;
> +	struct ft_page_info *next;
> +} __attribute__((packed));
> +
> +bool filter_page(unsigned long, struct ft_page_info **p, bool handle_discard);
> +void cleanup_filter_pages_info(void);
> +
>  #endif /* _ERASE_INFO_H */
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ca8ed8a..ebac8da 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -102,6 +102,7 @@ mdf_pfn_t pfn_free;
>  mdf_pfn_t pfn_hwpoison;
>  mdf_pfn_t pfn_offline;
>  mdf_pfn_t pfn_elf_excluded;
> +mdf_pfn_t pfn_extension;
>  
>  mdf_pfn_t num_dumped;
>  
> @@ -6459,6 +6460,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  	unsigned int order_offset, dtor_offset;
>  	unsigned long flags, mapping, private = 0;
>  	unsigned long compound_dtor, compound_head = 0;
> +	struct ft_page_info *cur_discard = NULL;
> +	struct ft_page_info *cur_keep = NULL;
>  
>  	/*
>  	 * If a multi-page exclusion is pending, do it first
> @@ -6495,6 +6498,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		if (info->flag_cyclic && !is_cyclic_region(pfn, cycle))
>  			continue;
>  
> +		/*
> +		 * Keep pages that specified by user via
> +		 * makedumpfile extensions
> +		 */
> +		if (filter_page(pfn, &cur_keep, false))
> +			continue;
> +

It makes sense to allow plugins to enumerate a list of PFNs to override
and include. I like that - it's simple enough. But it's not flexible
enough for my use case with userspace stacks :(

The userspace stack region is an anon_vma. My plugin can enumerate the
anon_vmas that it wants to save, but it's prohibitively expensive and
complex to enumerate the list of pages associated with each anon_vma. We
would need to do a page table walk for each process.

There's a simpler way: from the struct page mapping and index fields,
it's possible to determine which anon_vma the page is associated with,
and what index it has within the VMA. And from this, we can make the
determination of whether to include a page or not. This is what I had
implemented in this patch:

https://github.com/brenns10/makedumpfile/commit/1c0a828ef80962480f771915c2d494272721b659#diff-2593512d7ec329b34b1ca5686a7b6b073d0ca636df8ff20fea04684da2c8e063R6692-R12150

So, I wonder if it makes sense to allow a plugin to register a callback
to be called here, so the plugin can make the more complex decision?
This would keep the logic outside of the core makedumpfile code, but
allow the necessary flexibility.

Something like:

if (plugin_keep_page_callback && plugin_keep_page_callback(pfn, pcache))
    continue;

And then the extension system could allow an extension to register that
callback. It would need to keep the extension loaded for the duration of
the execution of makedumpfile (rather than calling dlclose()
immediately).

What do you think about this? I'm happy to implement this part of it
separate from your patch series -- you could simply drop the stuff
related to page inclusion, and I can add the necessary pieces when I
submit my extension patches.

Thanks,
Stephen

>  		/*
>  		 * Exclude the memory hole.
>  		 */
> @@ -6687,6 +6697,14 @@ check_order:
>  		else if (isOffline(flags, _mapcount)) {
>  			pfn_counter = &pfn_offline;
>  		}
> +		/*
> +		 * Exclude pages that specified by user via
> +		 * makedumpfile extensions
> +		 */
> +		else if (filter_page(pfn, &cur_discard, true)) {
> +			nr_pages = 1;
> +			pfn_counter = &pfn_extension;
> +		}
>  		/*
>  		 * Unexcludable page
>  		 */
> @@ -6748,6 +6766,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
>  		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map, NULL);
>  		print_execution_time(PROGRESS_UNN_PAGES, &ts_start);
>  	}
> +	cleanup_filter_pages_info();
>  
>  	return TRUE;
>  }
> @@ -8234,7 +8253,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  	 */
>  	if (info->flag_cyclic) {
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
> -		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
> +		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
>  		pfn_memhole = info->max_mapnr;
>  	}
>  
> @@ -9579,7 +9598,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  		 * Reset counter for debug message.
>  		 */
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
> -		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
> +		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
>  		pfn_memhole = info->max_mapnr;
>  
>  		/*
> @@ -10528,7 +10547,7 @@ print_report(void)
>  	pfn_original = info->max_mapnr - pfn_memhole;
>  
>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
> -	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> +	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
>  
>  	REPORT_MSG("\n");
>  	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
> @@ -10544,6 +10563,7 @@ print_report(void)
>  	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
>  	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
>  	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
> +	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
>  	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>  	    pfn_original - pfn_excluded);
>  
> @@ -10584,7 +10604,7 @@ print_mem_usage(void)
>  	pfn_original = info->max_mapnr - pfn_memhole;
>  
>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
> -	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> +	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
>  	shrinking = (pfn_original - pfn_excluded) * 100;
>  	shrinking = shrinking / pfn_original;
>  	total_size = info->page_size * pfn_original;
> -- 
> 2.47.0

