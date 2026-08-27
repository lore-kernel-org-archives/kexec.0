Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BACAC61DC2
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=155yOOpytCjzHkZuTIFrxAW0AocVmpZD+iYm4JJIsow=; b=xC4bDhvV6xK7qI/MiSi/NNweuE
	n36DCdL1RtnFIGngNG4OB1bOhpJURtorg2wVheozChg+/wPypL4X/KAbhgLHa2SYeo12unbmej9Xo
	qXKQHIM4AQhhuoAdiBaB9m/wBqa+Z0dLitJ7KTN5LR/KpUji3yOnqBaUX2f6Ailb3lOKyb0rFpYzI
	RDQDQihRlIiUxK+bMhVK4QIHzwDvaeQFZqPMdtD5u2TrL6B+I4sBmJ4CbklOvgvELPgnjhF60G9ln
	OtZ8/EewqCHod5R6/KmHsAt9um8GAbQD0d5ZskFfgh8XmEZWwAE57ZHE0AfxdGV/WjOsdmwyzuYBn
	4WEUl6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUF8-00000003WdD-3Ovk;
	Thu, 27 Aug 2026 07:09:46 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUF3-00000003WcL-1k4c
	for kexec@lists.infradead.org;
	Thu, 27 Aug 2026 07:09:46 +0000
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RrT91409476;
	Thu, 27 Aug 2026 00:08:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=155yOOpyt
	CjzHkZuTIFrxAW0AocVmpZD+iYm4JJIsow=; b=MMKBxm25O+i43lq8SJsivwvtb
	IDJfUeg3F8ctP+hb73QVOAbCCz+s4Fq0S9TzCnxwpu9Qd1a9JIDv3AGTJXd6i986
	U8s3apdZxXG3+XZaGWMp7zIvClhHpOd8D1l/zF6IibBta05STOWTxXASQmhPbJad
	VFNAYe8ewURFSPCeScGOkd/MkXfPgWwI6yx6O7yAoZmxiZi5p6Ro94tDjm0z0EBo
	U255KBg9TXR1FN2vOL5JeS8fuaLD6DZj3WJYDl53iqeAVmngJcLgelz5P/I+R14N
	e/rzqiSPeetEO1g4otYZyO1v1tsc988QvEkOJbudY4l817NQHxgd/hzvK7rcg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022128.outbound.protection.outlook.com [40.93.195.128])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gaay2gahh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 00:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLzChwfgg4llTRRnjGMnMJw5i5m24hX+jiDjTDWrsNFIXJbFMcxIq4wbnXyOj1xSmev4nXOx/0R/Y0GEfVVFNJ+lVureHetZ8qbvaPyYgyyitvvJk+CR6j14yXsjuYDYyfkziBKvF+INUnSIsAbnaTK75MWnJQq/KaCaNe1NTDc1OzHeV8SARzzZjEkHb7Y0hy5zFulh+2xxUUtMASpUqpCCyFpPBvVC4FyXx0Y+7lt4zC7j3Dmyz7SvgsaowpIi/dwPQOX4nBmc+y/gvkqbTeFDLw6HW+BSxhhzKofKAhxlgyBJhjstYczJDva7Qo592fZNDnU6drZuF7/EcaOetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=155yOOpytCjzHkZuTIFrxAW0AocVmpZD+iYm4JJIsow=;
 b=DJZ6rcNf8FAt+kxCLbeurepk86xYbEV0MTK/qYWrvjcDkuBgS359+27aQmVkQSKLjMz886pzJ8cwNNew8b5tlNDACeTfFFgevMGyTi6+zwhCqFDFz9mEMQyyuZ0Og8NbvhgYzPHw0BjRINNsM5Rt1artzbbkxBUUSyGd+RPx3/1oby4zWmRMkYoh3Mq++PXEw3vaeDCivpSnX6R9dqAIJ97QTGOzqo2V9vYku0O5LoFEhAfSgiBgzyDC9hi109HMA4gpxDolEmr91Jix8jdUvSRUuzAzSxHGx5MwfPwF7nqZpRd8x99xbE82XrSH2TUs2SvbdjSnxaXj5LM2sV1d2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 07:08:38 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 07:08:38 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] x86/crash: size the elfcorehdr reservation with NR_CPUS
Date: Thu, 27 Aug 2026 10:08:20 +0300
Message-ID: <20260827070822.12651-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: b978ec12-8374-413e-d9d6-08df040a045d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Z4mwF6eo4v2k017EODzwZ6MUn+KdvRCTutX/GxIwNmIjahVhudEvPesdUo9jcrgyMsbPkPNG762SAbRIduvVUU5S70dNgTTjZFrnGwhjFmcR4eCqthtPETQ2tTTcRhA4AUIw5j04RhLbqymjv2yZ31icdd1hu68W0SYt+KZQVhAsD0bKvOWPXwTR2K9/1pWvOwMUaqteAqXUfQ1Ii/pzrsPdD+xjvAX74mPkbEKEh9yIK6eNCrnJ9drLX1laY7KFycVVXaFulgHWyxjDJJ8l7fbmpipbyG7YRFtTpcd7qgBcE5ZHzzIWWgW5lWur4qLLdLASoMritbOCNAWL4480x+6nqlDMt6RwI/0RcFE002C4xbd5a2vbrT8IW+Q8r8z4ZkC4HuqCLry9A0MKFu16yDTdkLT1KwRCKKgmu4KeC2F73aIFF1L6I9hIyD6GnOwXsrFe7FPwYIlCDMUqJnKS3+N7eiePeCLvYodynJcCDiBwzmihlwL0iE0QSbqh7T+FYb42k9vRUq3TxpePr2ekY8BY0W2zca/2uiaXKUxW556h+cQFRBAAmPD5MnxwRhG69xGfZG4A6P9Wx8RR09BVpXS0SkAUeoFz79D4SztRR/p/t6u0LV3mK0LrdyOYbNePJOwJdLLEhyzJSj1Bi0HUwYNV+legIx3iR8Sb9jFDPpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYiycbdjuRFz4ykt8Z27d4Gou6JfCa6MjFFHzQRCnhPMdrhK8E6CZ9LdlqpQ?=
 =?us-ascii?Q?OZKP3JJvIcnsIqBBpLi352i8hnsyHEyyAF3B1Qobma7l1L7AfOv0dqbazGU/?=
 =?us-ascii?Q?tab/C0F02+ofnk6Cf1hS5qgfgMgGTuUyMdE9T5vRqwl18+GNZN0DDGqbxJcy?=
 =?us-ascii?Q?V/Z05CxlazxoBzdoEb4gx32pMqMDpIDtM3unDXpN+fqZi6qFvAcOg22PRYq8?=
 =?us-ascii?Q?iq0+sKP5Dz2Fyy79ytB6snSNgyEm9x2S0Eo2R4C372dW4AZHj2quXsbwoen4?=
 =?us-ascii?Q?XxdAjUG0lHi7RhRvgj7oR0vKoTI0Z+VBcL6xyik9lbqXQ4dtz4+UGaO8BUE9?=
 =?us-ascii?Q?K5lPB2POinPdCnsd8GwLLSH6AR7SAdgCs6HWGCtJWNbEZ/bJURsUMtikl2IO?=
 =?us-ascii?Q?Ow6mEDSbqpL9ysCpuUEWsM8ooDxijDNf2/3WZfzC1sVG76YN1xNLFEh7cQRE?=
 =?us-ascii?Q?yPBETlNJk1e3ezBNp4tSdSESq0stDB+Lhh4rwQnWHtcm5r2C2R10vle3OZ/7?=
 =?us-ascii?Q?MbzQjScyZL2gvUCpLCSCP2HJNvVqHI7lponnznlwJ013uviTZf/UQ6NK80l9?=
 =?us-ascii?Q?rowNTSBSjri4+9Aux0Geau3p45USGE21Hg+Iol7Rs3tcev5MXD2wYjy4eOlp?=
 =?us-ascii?Q?eUahycEJk6lvEMSNMpYINA3j+25DrMUYhLafTxxZDNNa5sJ6coe0rUQdamGf?=
 =?us-ascii?Q?qYEkZ8aqKWZy7aAycNbHfe+MpDU7q7nlUREF7qftgZqhntY5KlX8f48tFvji?=
 =?us-ascii?Q?j/4+otUuntICdEqv8Db3AXly/wnNaubmgTzTP/aCVSjDH7i5xJJ+5zz279Y0?=
 =?us-ascii?Q?L/Qa5RbB/jZmwN+GT6DF/4hF4r6Xgsrenqk1TRhqo9j+EQxs2HVIuwhvzYp2?=
 =?us-ascii?Q?z8XWAP2tnmeyOgFb8liK4nrkO4Y6VbBSzai5w8X1dJCt0u8lsrgqStUDjaHE?=
 =?us-ascii?Q?i/P0tcvQqAby9H7labEvrg55f0B0SA7PUkWlkIuK88rHX5JPhsJ41vf7ElYT?=
 =?us-ascii?Q?afwL44qYlBs4cOTMuJt5QfWvGSqruoUmvr5GCkhFlisAVjR6Woo9YhXeqjVq?=
 =?us-ascii?Q?hhNPNwpeBxYe34YP/iAgQuk0cr7m+mEkY+T0l9jeV4CDQlvrR+FbBYhgPefh?=
 =?us-ascii?Q?l/4gsjkXmqcmK7DTh6ZIePCIsTn9Am4gOeegSFfR/KskZ1NgbCz4fAsKsd3e?=
 =?us-ascii?Q?WOKHM3HtDZaD8Ye6q8YFOG8ZGLxdHuwHnKgULfoeVCv4ftPF/81UWowmWTA7?=
 =?us-ascii?Q?ECBhHZ4Y44InRtW01AxB9NBtBaEIEiZVVKSNhmC27DfDDCJIZQNiGTaHggLA?=
 =?us-ascii?Q?7isdSeelc7s23VDC7PLstRGFYFao+xduNYqRK63YyHy3kgWu4fjGwxlL8gHz?=
 =?us-ascii?Q?q7CPzrYLSpd7Yut0uejDIlQ1jyekTW3WZF51/BtVa595DOMudDjRXzQowGGG?=
 =?us-ascii?Q?/hroLNRzf/T0il5i89je8JXeNe0ThmgYDwkrn1bmDjP4gojiYqgJyE/oU+Ie?=
 =?us-ascii?Q?s35oznF+utBGf8K5+4wyPcB4ZBcdK8HceqvDrYnkDcl8z9LjCiAsTvixXwnR?=
 =?us-ascii?Q?NPB3bhnvREN1dCk12utDBHEgRmEhpJaomfLvprL8eAxk8JXVnNNWi3407+id?=
 =?us-ascii?Q?o1cSYCi3HzUcY6scZTPY/Hj+x426lGscupWtSoxVCPYMbH2X4GLlZulCbpCH?=
 =?us-ascii?Q?3qEPJ8AQEZlhVhUYTBwSo3MOoJ62NYRUeBN5480bNG6qyO7xQjItojs3SenF?=
 =?us-ascii?Q?i/smXJSDC26JN7WfG+jF1kWcLBqEpA92U+73LXSsdRKxdhKYJlGXmFVz4oLv?=
X-MS-Exchange-AntiSpam-MessageData-1: JlxG3sNOo53/bRQ+u7D2lhXSDtfLKuQ8frM=
X-Exchange-RoutingPolicyChecked: a9Al9lorf6EFNH1VPNB+JnjSjW+MgMaeTVf+GhbA7AIjVhXyPS2YfLD2HSEMnWkuAa0OkemBkCiuKuS8Jd3dWUT2gtXL14VNND8FfKBIQ+nenwWdzz20VtqGZ61to7cezisMOcdHFCIOVtFOzapRQpShfHQi0kV0cmKuFY1RaKtEDMD2j1XqZfZsVd3p0G5m7Qa/uPhNtbImCLECcRkFDP9QvRonnvAEWqH5b0y1FBwvMj9ZmanN9NAOXEmxU1JW38mE7yec22aVcnae8J57Prbo9xK6EZfZD+8C4v3u2uP2+PW3VtMawyclQCY+W7qGmfYkg8kXCzl6AuOYWRTK0Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b978ec12-8374-413e-d9d6-08df040a045d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:08:38.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hTnIaWItAF7fmoKbYxN19ImGBKZARAwa4hdOGMHgLQDbMq1yX0z/Em0TtzFzt+hFzNfe9ShbiYgiYAtsLDLzY3SCMJRvRYzTDvvfvr8/cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-Authority-Analysis: v=2.4 cv=EKU2FVZC c=1 sm=1 tr=0 ts=6a8fe27b cx=c_pps
 a=+WkigaN7fx4UYWmYucrQAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=YMjXlfINYBOlg6WvXvoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX1vhPEZS8cgzn
 dov6cprPwy4fKX3eAWqVOu4Luk9MEasvl9Ri6oxZtunXxLVhad0qgPqDuzxpjR6I0XAHFDSz7b4
 mp4cGenCi6qWHBUFazjKqGsHIRSB/dThBk9E63THYGaoCYcgR68J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX+MbH2hCDIdZo
 zi01YvIJw4OUJIRAaVQ3czDtBxN69HIWQlUxT5GhnALX1R8bPgKT5dF4vVNW3PkcCxgYZe+TzZ5
 H65JHQONa7AtAlj6a8s7va4QaOC3HegoDiQdfQbsJRAtBhuL8bqX9f1MhHM7VWNvzUrFP6WKn4B
 Iy8Na98J9+EyzGf5LofUFQLfbXfLCWN4s5c6cf4JSfUL6T7shSJ+g1/q2UrAzs0X+er/X3ML4PU
 jgFFrj1Fp3uRtlly/a1X6XqUP0GFihpzEQtQkmILvY/0RZXE1jlsvydB+gbhrkhRZ1gm6HYcLgg
 yjEhp7kvJwNVn5ndIHtSSm0SX1W4olfdi6NWGE2QfRz1cMdrcUvPwwB/UjHf4+4jjwT8PP6c/iZ
 uoUNA6jNbZftCr8ZtjJH2fZBtpvkmiMHURGF9vWbxzTWD4v5KqmY3mPeD5abmsG3OYpFD/CDs/c
 kXlqKFZg47odjzjTblg==
X-Proofpoint-ORIG-GUID: 6YH0a6BKo4cIbrqRvGQ_g6bGZaE22NJp
X-Proofpoint-GUID: 6YH0a6BKo4cIbrqRvGQ_g6bGZaE22NJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_000941_500643_5FD34A9D 
X-CRM114-Status: GOOD (  13.49  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

The x86 crash code sizes the elfcorehdr reservation with
CONFIG_NR_CPUS_DEFAULT, which is a Kconfig default and not an upper
bound.  The header itself carries one phdr per possible CPU, so the
reservation is too small whenever NR_CPUS exceeds NR_CPUS_DEFAULT.

Patch 1 sizes it with CONFIG_NR_CPUS instead.  Patch 2 fixes the two
comments that still name NR_CPUS_DEFAULT.

Based on linux-next (next-20260826, base-commit f82a5da2f0496).

Changes since v3:
- Patch 1/2: cut the changelog down to what Dave Hansen suggested.  I
  kept one sentence he had dropped - that kexec_file_load(2) fails with
  -EINVAL - because that is the failure this was reported for and what
  the Fixes: tag addresses; the silent kexec_load(2) truncation is the
  other half.  Happy to trim further if that is still too much.
- Patch 2/2: changelog trimmed the same way.
- No code changes; the diff is byte-identical to v2 and v3.
- Rebased from next-20260825 onto next-20260826.

Reviewers: the code has not moved since v2, so I carried the tags again.

Reproducer, for the archive - single-socket Xeon 6776P, PREEMPT_RT, with
CONFIG_NR_CPUS_DEFAULT=64, CONFIG_NR_CPUS=256, CONFIG_MAXSMP and
CONFIG_MEMORY_HOTPLUG off, CONFIG_CRASH_MAX_MEMORY_RANGES=8192:

- 144 possible CPUs: the buffer overshoots the reservation by
  (144 - 64) * 56 = 4480 bytes, more than the 4096 bytes of page
  padding, and 'kexec -p -s' fails with
  "kexec_file_load failed: Invalid argument"
- 72 possible CPUs (reduced via firmware): the overshoot is
  (72 - 64) * 56 = 448 bytes, still absorbed by the page rounding, and
  the load succeeds

The two follow-ups Sourabh Jain raised on the v2 thread - the
add_segment_phys_virt() bufsz truncation in kexec-tools, and having
crash_load_segments() skip the kbuf.memsz update when the prepared
buffer is already larger - are still deliberately out of scope here.

v1: https://lore.kernel.org/lkml/20260812170433.533845-1-ionut.nechita@windriver.com/
v2: https://lore.kernel.org/lkml/20260825075043.42041-1-ionut.nechita@windriver.com/
v3: https://lore.kernel.org/lkml/20260826073527.21487-1-ionut.nechita@windriver.com/

Ionut Nechita (2):
  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
    CONFIG_NR_CPUS_DEFAULT
  crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing
    docs

 arch/x86/kernel/crash.c | 6 +++---
 kernel/Kconfig.kexec    | 2 +-
 kernel/crash_core.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
--
2.55.0


