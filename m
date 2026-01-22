Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40FBC44508
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19Ky9lVhh/QV+/7LmE7qiyr2M/u5GZnwNgyP62obzuM=; b=iWq6c7vuogKvCzzeyG11jJK83G
	Z3Zvx/ZxMsZR69jyN/6AzsMFFasmsSHKtNFN8yUnpNv7bOgbmsHugbQjdoGxsZy6e7vIyeYZtIdQ2
	dv0dxm2DIYbaGchIh9q6BRejHTDxf128uDyUi2uc5WtZY2s5+2VNPf7LX/un4/lATSR4GHRikfTr+
	g3n5sY377uDsd9B2RFRLzk00aU7Nlj8H5Yq8CQLDm7jfeFgmtgkYNNyTVND6cF5tBO/btr5ItbdkE
	Zgn7SOjWsRb4xDbbym6K4qr6J6TRMo03GUA3GaAgcAGjnj9UAEWPqettxtLf1gqxeevw2Proh9kI8
	2UdHm9Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viiux-00000006EAV-01HS;
	Thu, 22 Jan 2026 00:51:23 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viiut-00000006E9n-0hS6
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 00:51:21 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LHUdXv421477;
	Thu, 22 Jan 2026 00:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=19Ky9lVhh/QV+/7LmE
	7qiyr2M/u5GZnwNgyP62obzuM=; b=eTDNXZPef3wWk8/qllNXEXwmAYShJUnbRn
	FFcZLOWB7l+94wQwZTBU23SF1Fa4Z9E4FrJ6ro4/wPSr71PwTpDaSh8Yf3lnZ7dF
	+m9qnI9XGX0NFuFAncaxF25m3PBzarFFLWEwjLD48a5Pci7m+JVTuDWvcil6C4/2
	BVQdY6PhwX/3Qjeyg0+g2n0PwoCpsy1kLkYYY8LcAOVctCVIW2q0lhGV7j4d81Fj
	bBjviI6JyrinqkF0KkaOhmheDMzyyctItGiB19i1f9KD9tOE6dPO24dfdGk5P5wB
	uqJ53oqq+VwBSUvnaV4MAmp7T4Bpyfcj5B8xX9lorXIaB6QvZxOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcuhva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 00:51:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M0gAlj018914;
	Thu, 22 Jan 2026 00:51:08 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrsx2xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 00:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur0daN+nvHizAJZiflgkWj952/siY/5MYbF19ff08UnDDvUaRgS9Lgi+wowm0vLynTrFZ9uKj+zAO3orxG/Y0csSMpHuN8oV2wV4WJQDU8YslxWi0XKpbJxrLcYIJe2ggtr80cn+UpwLe5MDc+SnDES33z7qDn28oVMRKaFBhhMzwedEUnZfrWnUYE0N6D/BGbN0LFiWGJiyfJtXhnBOvlLInGe7R8rcXtOwPcqHkYnlhx/zSd16f/F0jz8uOosgVWGQxbQ/apgPFgLVHCJmZuFW8y399DbASLfS0R6U5vM7SXIiQsbmSGw1i4a54bcqyTajeO6ozW3TW4A11sCVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Ky9lVhh/QV+/7LmE7qiyr2M/u5GZnwNgyP62obzuM=;
 b=kOqHow36SMiuRIJ1RgwdaDPJH7XiSLAzStf4TPl7gx2iTK05hmkndWqJ5Vpm5imJ5ogq68x+mfNmFYYHP1adeWv3dONpaJXjIbdzrYbJ8knEiTUEHk/PnFAbJU5fUfFV2Cdg6f8kDnRsqajiAEGDIoj3KkNd4da2z0x9/0J4XZ4w5tiUu46BTyt17qQyOEnez//DzevA+ebwUOKr1gp5BY99fP5JWvgAiVJoK4nIIfrOOWqVinB56XQlReUIL2i1n2aropOfsVVlkjRG5DDhVY9Wi3eOq9k/3y8K4K1O0ctRT1W/6W5wVU0mFIq7YIC1t+4y8BCwKxZ+9p2+dwxCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19Ky9lVhh/QV+/7LmE7qiyr2M/u5GZnwNgyP62obzuM=;
 b=NC+/CqU8xnFPJo7CdKFJcmpfPZAnYgae3pNtbYgKDYM9ew/5pFRyfM3JYoKFLLg8q99xv+EUdAWFTL1gEm/I4NyKJ/sThJgh+yd2tmVAFizJQB3pB1DgSpVvFGxTN9LmbuPXlTDvlyTdpghV+bbAsN9PTkXIoE/EsTp1M/RS4g0=
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9) by PH7PR10MB5832.namprd10.prod.outlook.com
 (2603:10b6:510:126::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 00:51:06 +0000
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d]) by PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d%7]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 00:51:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
In-Reply-To: <20260120025500.25095-6-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
 <20260120025500.25095-6-ltao@redhat.com>
Date: Wed, 21 Jan 2026 16:51:03 -0800
Message-ID: <87ikcuv5ag.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::29) To PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF654CF2C22:EE_|PH7PR10MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7ea71c-3cb3-4f10-3446-08de595052c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vj3Dr/8PPK9xZc8VB5SgJi25hEjbPCiyXXfSlgwWD3/Xw9AcjyHpp4EPOsCK?=
 =?us-ascii?Q?XfqU5WCxoTYDosLAvQ2NDvRW83Kjel/KU7xZbbPznQEHTCvQ2s3Ooa4ryBiM?=
 =?us-ascii?Q?J781pB1f/6tlNB4JUQi7gsn6+gUxzhM9XYs9yUxvACzW+z0H0V4zHTfzDRCY?=
 =?us-ascii?Q?sWflI5RzHBYufQWqOd51ajM7ly4561jl5Pq4+JfDKcIKHMO21b5Ykrm5TFgi?=
 =?us-ascii?Q?d39mu1fSaxnRB8BgVZHYzYuS1n90quxcFO6G+0FzqeXi4qSYSIa6AFNYW9DI?=
 =?us-ascii?Q?+ve8vef4/FYbqGKp9LSwlEbbxIRdfvqYcBp0uUJfqM2NsJENRFdm4RdrDsaw?=
 =?us-ascii?Q?dXDjc5wO7OEDYgGdxlEf9EZ/AV8+8XCmZy07WOCzt/wiJNbnBpaAJpMZCP6i?=
 =?us-ascii?Q?ddF0xrzl9n9ji755kePINXI/AUCQSMSrmvgLCtzQj+Ci8qOz+2IDXwESocEw?=
 =?us-ascii?Q?/koAh7P2Yg30RlMG78kNH2sQYaBTFyuBPwJVAKZQVQLuKeUOtyk86cXq6Z4y?=
 =?us-ascii?Q?g47jUdo3VNDnsaQF1k5rsc0DPQTooXumvbj1nR1XQ4Ez5Id4wG3VlvYAbBF9?=
 =?us-ascii?Q?a0u5qGsMed47CLIAfRnSY3wS5QnkU7c1/ela4zRnroh5RpZ8H921aHEVyoiv?=
 =?us-ascii?Q?Jqe2Ir9ZjqjuwdbKFyALVnEnWDhzKG4H+h8neQPA9vAHyMlp17ucBSNjVhfV?=
 =?us-ascii?Q?QMT5hA06fbiWFY0kywDqFLPK3WFiYAEGBXORyXiK18DFprIhAlifjpo43frV?=
 =?us-ascii?Q?KYVvBUFokmu/X4AQSaQdDDLtDXZ+snA9pZAMsB4E99gItZrkp9uDosMcXn/r?=
 =?us-ascii?Q?4TYczD3BnsTsWxKYhNSaXqbMu+wn20+hkpTW0bQtXdQDGfoaILFhCkgHbE+c?=
 =?us-ascii?Q?kDw8NvIGDhEsnVcka3e5HN+BRkbWb2z2m9DjRT0UkUiWW3qdbV+feucLjbUa?=
 =?us-ascii?Q?Fxv7rGOdWNbz1D5pA7Cr8Drh8e3xXt/GmCk/G3+rBTfHhgaEQwyAiC71baRb?=
 =?us-ascii?Q?F5E4sH81GvZkVYRIvCU2n5KOdI15m6tEu7OHEjg+aE0nfz939A9MpPJbPioc?=
 =?us-ascii?Q?aRf36JnF1UXT9WISFR/06NFq2yn0hyn6nSVZJVmq5jgZyi0Wqca9EFLgiPAX?=
 =?us-ascii?Q?xwyAZlkawie0BnRX4rDB1CI21dCSEWzAkMYLtz4raQ5TOQCmJrVuJra2AgPx?=
 =?us-ascii?Q?YbDNG2KR3JwYeNG1ThxvjHiVfkp3JrW0V8Q0cguPppprMwUJoVfFBjafV/oX?=
 =?us-ascii?Q?qUI2Bx4LAkSqCwVwjksN0EoLcIIUxyj4wCJAPqzBjQmkAWmxXWpW2EGiuMnV?=
 =?us-ascii?Q?KqtLOZAg+tGohcAAdXC7gVsaAheRJ5lLwhwNpjwAIzAGG2oOrsma7hiIfNvv?=
 =?us-ascii?Q?BxPYYcFZgbLa2GNeG5JUbo4nJUEV/Z4OMHauGvl2+EnSiA3ENf88SRpvRu5g?=
 =?us-ascii?Q?7MZlY7Ya/YA1LhthtU7RT3xwgde2ppSTGOf+wfFjO1soLoU0+euyBJ5j3sQ8?=
 =?us-ascii?Q?IupxO5GRBoJEVnI0h3T1MvsVqmP58HErssmlC7RyZ25ldRVFyzlTqXYI9JjP?=
 =?us-ascii?Q?pz1KvPCwQItXDI97MqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF654CF2C22.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ht0lrvygv6SahpchvVrR/AXT6je8gTawdbiiAd3sdokhGNkg/9EPfmfshsOV?=
 =?us-ascii?Q?+3NxZ3/sAn5gnsiryysEBCwc/qKjNcsZWjWdOQJr4nCi9Nwzcb6yIKAPD9UJ?=
 =?us-ascii?Q?/Uq0LVx98ZZHlPGEm0LQoqZlxmVZhmmkjPfi25FRmqruUS7PBRZ5wgxV5U5F?=
 =?us-ascii?Q?8k6oGMlSpfblCtLj+Rj5JURtARcFX9tinNzp6+z7n5pwzf0VCQQPfKW1LDfS?=
 =?us-ascii?Q?qM9viUnFMxUkArQ7W1gKaLhrXPgPrHC0V9bCll2+Fw1OkZb/8Ok6aC+TbNR2?=
 =?us-ascii?Q?YxLEN1Sjo6/GaaYmGTjd+Ll6XQ+1szIM32m8TztC0FT7hOgUpPASbstD9MDn?=
 =?us-ascii?Q?5zhnEs2sDL9S2fsGBSSYshiChNFfmNdp1ZkGqf/yvo5kHFYSXGX5JOPme/gv?=
 =?us-ascii?Q?PrqPMsYsUxoTiG1c45a9BW+fYq8KcJzZ0w4y9hzepbpzAomX0olWTyAP7DOa?=
 =?us-ascii?Q?c+VxttPAsEoZjbkGkX9+YeYj0Q1BISsIQ3jrTLoyWBn+I26pjmaxD9mDP3X5?=
 =?us-ascii?Q?2c65Pqv1ub1R76c8LLu/GKuiuusdc0dXNU9c13pVv+r/EBH0sKrz1zQ0JG5i?=
 =?us-ascii?Q?hwhD/zjusfT7/qd5vITFPY2KaD0r2+1rXriNawfRWcpwKIz8fKD3OM3OXv01?=
 =?us-ascii?Q?8KzaCpKo2dkOcTvrWPhgDA6O4J88DTVvdLSLP0pnhQRygk9ACmV5WrNwb6vm?=
 =?us-ascii?Q?l9Wff0hM8usDwIqvXrUIPP/2h3pnq2+KkjcQVm+yGV7fS5qV/P92BgLX2oh7?=
 =?us-ascii?Q?zqvjwa83UIf7JKcOe1cA8W3xmatkDf6p74N6xK7gIbe0DBE62Ucsxtiaor5P?=
 =?us-ascii?Q?5VmPe80aLxU8v55W9zOsHvVOb7kPzWrP0cI8TRx8j3hnN97RwIW7rPxDJgDg?=
 =?us-ascii?Q?ywa7M3DVJKMmMt4/qdpLwIM4MPmkJmt71IaZ+Ymi7yU3Ko8aeUkcI6pdcJiF?=
 =?us-ascii?Q?tjEZHD4lyrerFDLDewEMJz1jNXGJZLW61/n781xtijH37biYBH5+a4dC/o3P?=
 =?us-ascii?Q?c/z4aHw2R8WjKD8aSDqBcMpxrYNNDRiJcRL6ILGVhGxcs2OeunxBPBd4IIVU?=
 =?us-ascii?Q?kQTulIpsP/8oGVh1hoqWrhOBNqMhiBoMFaKlMVBCBAPmRGpXm98RB71aTwTl?=
 =?us-ascii?Q?q0j2UTnuNtdnkm5koBvQMSzXzV8XmCUZQmoRTGXg+kxOhH5nlYFWOa/JW/tO?=
 =?us-ascii?Q?EMSjrKZig9yJ9OhNQc+iAcaq99ma+Vfmk7Dv7tpgSAfIMRFeSZpndiZKG5Mn?=
 =?us-ascii?Q?6K8goEYv8ORUMtJgg4NQefDan5RLgZ3Cks8FPIG18b2d/RgjduX2P3Lmbs6b?=
 =?us-ascii?Q?jpZkz3far/ZiAko7RKGn5QLEOL+zbewMMhg7yd5j6JGK4o2V6oxuIaYzufkE?=
 =?us-ascii?Q?9XqM63MqfKcnBfUUFIh+jgXsn3LVcq7ZaUsQ5LRgd37PAuvoEIR/o6rBgj2J?=
 =?us-ascii?Q?aqt/5uMvz1eBSgYJJaCzPFVQyHqTANa4vJrLmF8xaSJkeK0c3wsCOeU1nNWS?=
 =?us-ascii?Q?Rakau+gm7bLhgLXfqxtJMJJKip59VuS9ZU1n59PwNqaQeMStdK6sVrS0a1oH?=
 =?us-ascii?Q?xAzKsvYnb4kmiU4fdAYmF/yLAK3RelnAITHSr/1dIhdYWH80//rKg2VDOxTx?=
 =?us-ascii?Q?bjIG9MjBkgGb0pe17CjEm3bPx2EtrGMo/fjpl6kQjOGLLvidavrOlm7RpIHT?=
 =?us-ascii?Q?5R8NJ3vdjBE4vnvCaPUuh+sw0/iV3j1eiW6yTn563aR8nE8I6R0KyvrUz8nE?=
 =?us-ascii?Q?R2/RZrIff+NAh662FcRs+sNWedzVX9M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nMIpG7/iCuS4YTEjwI40WPv9y1vxp8hXsq0SDUeD/JSSwNrzdciM+GAk/pAQsnRlM5UaELdoET/jaUBlTmwNqh7MjWOW0gWGfyTFrQuZvgmmfJwl9EvSkM2y9WdmgeqtSa0/yosss86KNYzO3MnGG/5ca4mooXzwVMSnuPBnlE+ZEC67nbdJTk8ReUsE4/4cOEmcW9mHemG55ji792a5iPGi9pqApcinaRGEuDl6pbOzPR2z0jG55cXWoVszv7/4xUdEmh8che4UP02ep0Gf5QJpn0jR6XPZBBrqRC1XAS5w6C4hc6fBkKIi0YbD22V95ZkkSiSc1mZdh0XI6Qoyf3U8kLZ0FHljoDRBZX480iV3IoGoOnmvBskasRlUl3DjCSb0hPnZMKggP72afsHg1Cko2e3MQSb+bLCNIJWEbgKgPePgtUA72XIDA6xYlKfxmPAXsM1cw54zOE9TVRwVrPn9q1rWG3Fp0wNIufknIkwTOURXa51jQnopZRRolWtTxJE+qvywHtaupKG0CpUP3P2sHI3RP59mEibvQEJQSQ1p92MTlw+vI0XMDwnP7hlrlPtLDD1QhDerKNE5UCpHIp1L+g5kU2dpCbRTndVNJnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7ea71c-3cb3-4f10-3446-08de595052c5
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF654CF2C22.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 00:51:05.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi2ccM51t4Yi9EA7aNL9cjdLJViNMm+juXsKCgEmx/7byFuB4P08ofRNvAjVfzoFjPbPPmUHf6tGIDlgjdM7iztZhPEunOszT4qvbA/uLls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601220004
X-Proofpoint-ORIG-GUID: fR2gB9zMyRGJW2ZQBZRtW2vTI8ujZBby
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=6971747d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8
 a=-7q0UOGCHc56799MWW8A:9 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDAwNCBTYWx0ZWRfX0/CZj38vtNI/
 0l4x3dwpWUI6ABvoNuNKF+70hB4rXuZH5EDHEFZyD7GLotLPBgIz2m/In7KwF06AdjRe8aIb/ms
 JarWn6FTVeiZz+2x9PZlUZ5XUX1NpnP1VimJcQXdyGUBhriYNILPcj7BtH4ztpAOP2TKQ2gQx4/
 /joBcoi6y22eMOy0ciXKgU9blAgkM4OiZVkP9AnU1IxVHCRx+4Vm9RsKROxNAhBZjuadX4f7THc
 jxOoaMfk9EBytsVH1CuPoy1nshtWtALD4aKEEP+NF4g0yUzV7xK/hq6NvY3Jfq+DdCrQYdl436p
 5G1jgCt4PuBsNnRGRuzjLmUdPGlrDqoL5DByEjTTy6X/0xPbP1H8cKClzDBgRPeon6DwKndYs+x
 jqTwzDgRJLbN+i6MZd14mdoRQsSmXWYzwwBFAOKcKhP/w4vGwGbyvpPpXJZsAtuNQQpAJnP2fcN
 A6+ELnJlLWiP/jHxNx1V99Lc9PrxPx386Dg3RnX0=
X-Proofpoint-GUID: fR2gB9zMyRGJW2ZQBZRtW2vTI8ujZBby
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_165119_759001_06F2471C 
X-CRM114-Status: GOOD (  22.95  )
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

Hi Tao,

This series looks really great -- I'm excited to see the switch to
native .so extensions instead of epicc. I've applied the series locally
and I'll rebuild my userspace stack inclusion feature based on it, to
try it out myself.

In the meantime, I'll share some of my feedback on the patches (though
I'm not a makedumpfile developer). This seems like the most important
patch in terms of design, so I'll start here.

Tao Liu <ltao@redhat.com> writes:
> This patch will add .so extension support to makedumpfile, similar to crash
> extension to crash utility. Currently only "/usr/lib64/makedumpfile/extensions"
> and "./extensions" are searched for extensions. Once found, kallsyms and btf
> will be initialized so all extensions can benifit from it (Currently makedumpfile
> doesn't use these info, we can move the kallsyms/btf init code else where later
> if makedumpfile needs them).
>
> The makedumpfile extension is to help users to customize mm page filtering upon
> traditional mm page flag filtering, without make code modification on makedumpfile
> itself.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  Makefile            |  7 +++-
>  extension.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  extensions/Makefile | 10 ++++++
>  makedumpfile.c      |  4 +++
>  4 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 extension.c
>  create mode 100644 extensions/Makefile
>
> diff --git a/Makefile b/Makefile
> index f3f4da8..7e29220 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
>  endif
>  
>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c extension.c
>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
> @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
>  
>  clean:
>  	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
> +	$(MAKE) -C extensions clean
>  
>  install:
>  	install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
> @@ -135,3 +136,7 @@ install:
>  	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
>  	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile/makedumpfile.conf.sample
>  	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts/ $(VPATH)eppic_scripts/*
> +
> +.PHONY: extensions
> +extensions:
> +	$(MAKE) -C extensions CC=$(CC)
> \ No newline at end of file
> diff --git a/extension.c b/extension.c
> new file mode 100644
> index 0000000..6ee7f4e
> --- /dev/null
> +++ b/extension.c
> @@ -0,0 +1,82 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <dirent.h>
> +#include <dlfcn.h>
> +#include <stdbool.h>
> +#include "kallsyms.h"
> +#include "btf_info.h"
> +
> +static const char *dirs[] = {
> +	"/usr/lib64/makedumpfile/extensions",
> +	"./extensions",
> +};
> +
> +/* Will only init once */
> +static bool init_kallsyms_btf(void)
> +{
> +	static bool ret = false;
> +	static bool has_inited = false;
> +
> +	if (has_inited)
> +		goto out;
> +	if (!init_kernel_kallsyms())
> +		goto out;
> +	if (!init_kernel_btf())
> +		goto out;
> +	if (!init_module_kallsyms())
> +		goto out;
> +	if (!init_module_btf())
> +		goto out;
> +	ret = true;

I feel it would be good practice to load as little information as is
necessary for the task. If "amdgpu" module is required, then load kernel
kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no module
debuginfo is required, then just the kernel would suffice.

This would reduce memory usage and runtime, though I don't know if it
would show up in profiling. The main benefit could be reliability: by
handling less data, there are fewer chances to hit an error.

> +out:
> +	has_inited = true;
> +	return ret;
> +}
> +
> +static void cleanup_kallsyms_btf(void)
> +{
> +	cleanup_kallsyms();
> +	cleanup_btf();
> +}
> +
> +void run_extensions(void)
> +{
> +	DIR *dir;
> +	struct dirent *entry;
> +	size_t len;
> +	int i;
> +	void *handle;
> +	char path[512];
> +
> +	for (i = 0; i < sizeof(dirs) / sizeof(char *); i++) {
> +		if ((dir = opendir(dirs[i])) != NULL)
> +			break;
> +	}
> +
> +	if (!dir || i >= sizeof(dirs) / sizeof(char *))
> +		/* No extensions found */
> +		return;

It could be confusing that makedumpfile would behave differently with
the same command-line arguments depending on the presence or absence of
these extensions on the filesystem.

I think it may fit users' expectations better if they are required to
specify extensions on the command line. Then we could load them by
searching each directory in order. This allows:

(a) more expected behavior
(b) multiple extensions can exist without all being enabled, thus more
    flexibility
(c) extensions can be present in the local "extensions/" directory, or
    in the system directory

> +	while ((entry = readdir(dir)) != NULL) {
> +		len = strlen(entry->d_name);
> +		if (len > 3 && strcmp(entry->d_name + len - 3, ".so") == 0) {
> +			/* Will only init when .so exist */
> +			if (!init_kallsyms_btf())
> +				goto out;
> +
> +			snprintf(path, sizeof(path), "%s/%s", dirs[i], entry->d_name);
> +			handle = dlopen(path, RTLD_NOW);
> +			if (!handle) {
> +				fprintf(stderr, "%s: Failed to load %s: %s\n",
> +					__func__, path, dlerror());
> +				continue;
> +			}
> +			printf("Loaded extension: %s\n", path);
> +			dlclose(handle);

Using the constructor/destructor of the shared object is clever! But we
lose some flexibility: by the time the dlopen() returns, the constructor
has executed and the plugin has thus executed.

What if we instead use dlsym() to load some symbols from the DSO? In
particular, I think it would be useful if extensions could declare a
list of symbols and a list of structure information which they are
interested in receiving. We could use these lists to know which
kernel/module kallsyms & BTF we should load. We could even load the
information into the local variables of the extension, so the extension
would not need to manually load it.

Of course this is more complex, but the benefit is:

1. Extensions can be written more simply, and would not need to manually
load each symbol & type.
2. We could eliminate the hash tables for kallsyms & BTF, and eliminate
the loading of unnecessary module information. Instead, we'd just
populate the symbol addresses, struct offsets, and type sizes directly
into the local variables which request them.

Again, while I don't want to prematurely optimize -- it's good to avoid
loading unnecessary information. I hope I've described my idea well. I
would be happy to work on an implementation of it based on your patches
here, if you're interested.

Thanks,
Stephen

> +		}
> +	}
> +out:
> +	closedir(dir);
> +	cleanup_kallsyms_btf();
> +}
> \ No newline at end of file
> diff --git a/extensions/Makefile b/extensions/Makefile
> new file mode 100644
> index 0000000..afbc61e
> --- /dev/null
> +++ b/extensions/Makefile
> @@ -0,0 +1,10 @@
> +CC ?= gcc
> +CONTRIB_SO :=
> +
> +all: $(CONTRIB_SO)
> +
> +$(CONTRIB_SO): %.so: %.c
> +	$(CC) -O2 -g -fPIC -shared -o $@ $^
> +
> +clean:
> +	rm -f $(CONTRIB_SO)
> diff --git a/makedumpfile.c b/makedumpfile.c
> index dba3628..ca8ed8a 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -10847,6 +10847,8 @@ update_dump_level(void)
>  	}
>  }
>  
> +void run_extensions(void);
> +
>  int
>  create_dumpfile(void)
>  {
> @@ -10884,6 +10886,8 @@ retry:
>  	if (info->flag_refiltering)
>  		update_dump_level();
>  
> +	run_extensions();
> +
>  	if ((info->name_filterconfig || info->name_eppic_config)
>  			&& !gather_filter_info())
>  		return FALSE;
> -- 
> 2.47.0

