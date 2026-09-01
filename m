Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3D4C61DD6
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SgJJj1WLLMEPnM3aV21tQft2R57yAx2mllkIyRS8Sr4=; b=ZZN3ZsfdJIkWWJqx0aH+KEnCnI
	wvDq2rVO7yWoGdP6EM1dWqUdS6oMZsxY26hlnn8S3oMxtFfgu7A7Vqw3O7KGJCaazeMC3HX+0wOUm
	AWnWmr8OqCDyHSmtnCeNJdszNAxXK1VaKuDv8XYDW8HSq8+hd0ApGGXp6HzF/fQ4SjmN1x7qWqApH
	GK/G+IHAWVzaFzxrTEvFrv6jwVwtW2tm2T/MlUtsywjgmShDQ9Jj49crr8Gsiw6+cnq0vn0J3mnTu
	4oQmbbqOTEeWKsMG9mXXvs5Es3QA4tlkaCmhCN2Kw+GXt0svvxgoenR8/q9Jzz5mVTBdSHKcaosvS
	aEitnBLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1If2-0000000B5uY-0g6r;
	Tue, 01 Sep 2026 07:12:00 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Iez-0000000B5tu-01wW
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 07:11:59 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179J7I1564660;
	Tue, 1 Sep 2026 00:11:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=SgJJj1WLL
	MEPnM3aV21tQft2R57yAx2mllkIyRS8Sr4=; b=ooO5xFkc+vyVM90sz4o/HiVq6
	GWYRLb165QxN18mgBqKl+P1sS9kT8MJ0LXWSpNf18CMjLWQRIhFVw0980mWhUSPh
	zl1ig1/np+w+mAV7xrQLtPfmfwUtCM3GRNnHDyVaerOcVxXicCM3ocFd4yZHmB9L
	Brs9+orzf755fNpc5hMA6G+vZKeSEW4x3zVJMxjK8p6ccpOewj8ouhRcNOL3cWYl
	VeRr9xG6kDWvktx559qZIJ09nLXq3fdohwD0U0hf1JSF3tEXUO4jxFPE3qHQH7nV
	fYt0GmEvSn1VWaEqf6T6YNwMCInbv64eYbAYeDkpJHBVaHyKGzKyVviX9COLg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gbxxebp2x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 00:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbtbX3fOGwGv3VtEYyCAAOshE5Vbr5YojBmMhYEoURuF69/Dkm6Wi9z9d4hkswZaY52lIN6h+sgxFKepF6NDu0GVmjpp39ky/l1RXxHcSMsbzlScAwYfKPLBPxRzb1pSUsRWaQOIA1CKu3jisj4FRn6Mz0yAdx8diRuJGyzyEwB9CEbeojsM3e4h0DWXBHMV5Cgiydv+fSSk/7vn7jYoT5iyXT8Bv4vlbu5Z6aFBx7gCHYvR7a/flHu8jVl9246Ru0MSwaobDy3w9wzBdJ61Xy+CBdrobXKYUGqkm7DEn1KPThNaUmAtqC1MBOdT7QisC6/wE0v+emzLy1meYgjjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgJJj1WLLMEPnM3aV21tQft2R57yAx2mllkIyRS8Sr4=;
 b=yGy/z1u1nR3YgLibJSu+FX5/qaDM//v6vy1IMOaWhPDwlogNZFsODiVL6OxHvoPWnhgB66YGPmOH20lGH4NhaoG8G9VXz0LJu760W962e/r0i7i7Xcfl56AgBXoMwG3lrGGdd/TxmOkfmRCDXWGAKIYGZEwf+3iZ3m8Q/uM+KM5EQ+MtWX6huWgAGJR8YzlvTC8Oo15svqq9idPcplcy97UX+RdIxx/N87Ow4hYnCA7BfbSTx6L+vgGxq8vxp9zX9lIKHV17xIN+UrDNu7XSBBeDAZt5hF6d47LIvx3ypr/Yy0IhUp1Zn0B7Yh8Vwjp8UvjN68HuB9ZlfU0AtD8i2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:11:06 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:11:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, brads@mainlining.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] x86/crash: size the elfcorehdr reservation with NR_CPUS
Date: Tue,  1 Sep 2026 10:10:39 +0300
Message-ID: <20260901071041.16311-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0079.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba4c841-d400-4193-fe03-08df07f8304e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|23010399003|52116014|1800799024|376014|7416014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iY1vhbAwIxzGYNBY8Jrbj3Nt8eeizVu6tlhPBa8VEgaYnykGAIpI1g22LEaidPHxyxF76ASJnowMR7++HnT1bZfJSYsYSZaGwQr5yZju7lz4ow57owi7KvlsxNktQSQx7KidPEXV/D2zfpOnJJHpxWnEOGFByidieTsAfUnZPZ0RJpEm4OJwVbZMs9VyyAu5KhsUu8WhUZert/6ZU+vFnx0mvxSHob6+cGaFEl/C1IPLANnWUYOiEjPnGn9CX60ESdqb2BTLokO33NLf90ZDUlgS/6zZJfEtVC2xzAaEB5e3zh3Fm0Ff79mRqmvazdAli1dQBjwGsNGo+Qvn/sD9mO1CmhHw3dJ6DNxyySlygHxqGozyVhVZ2A4sxU0fUULKVaa3UvcDUyVqxG4TsK9ifCrlbE/aC9aM3RJLkXs6oTt9Pz97A6D4zZguwBADkzXqCqT5s50fIFpEmEUnvqNQORzvhreXnXz8XTNdTnIYUToIFC5TKrkZ2TmKaAqWeO87cMA9o3ae7mgiKKdr76zTXbUgDRcXar+3yh5kTI6JStulfdK2OLnXSdYC1ZvpRvtfe22lP2p3Q7utywo6r0eV8WGKf9GH6GzTeLQ3u3/mlzNg5rekwVBtoSs31tq7xfRA2COUz1+a9qgN4EgsVm90wKLsNhZafbFjvtgztJKHquE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(52116014)(1800799024)(376014)(7416014)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9xJJBj+d7hbhnd9sEmt3Y5ZLyzfsoxILZsYSEvYPNclYFTyR06Zp4JWXVnE?=
 =?us-ascii?Q?79Gnw00HOOqX0j7W4CjBIuyaPg2pCd9uXPAQ0WbcgT4Ww2NK6ruNqsdmTJXp?=
 =?us-ascii?Q?1I8umrYxyc+h8Vy+bf3omWkzoytE4AVHg6OxRdq2Xn7IjfmtvjU8BM5gpQMV?=
 =?us-ascii?Q?fIM9FAPbDFS4fhBC3zbcvgptEmFG/4GHhXtVmowIl4/WHToNzqJ0rz8ESPfX?=
 =?us-ascii?Q?ck/J7QAlIYfAoC2u1Fpx3pQXyLH2KXDu3cANrYnblzsdUEkAF3N8Qk3Y9xik?=
 =?us-ascii?Q?4iAUCKEM9bn8z17YJfWN2O2A0T2QTwZLpHdVSVb9X0JmqfexaBlMyw+6Ur2n?=
 =?us-ascii?Q?D7FIPiTKFDv2tLRV1XBTNJkAGnh4cOpxKua+qM0L472N9dKJM+IH6FeE8roM?=
 =?us-ascii?Q?VAPWJJ74TFh80vyuQiUKT3IRx6ipnO5Z0RlX+GphPijrpNLQqAm9o6SyyYAM?=
 =?us-ascii?Q?nwMkAk023StM/L6/j9qtn6MUl/cuIKYOtuOx1xVnyjhiiLVOkPHtRf8ys/8c?=
 =?us-ascii?Q?h8R+ZCgWyDY4F8IyEo58aFDfOTDZxKLpupuB88DYamMZYCWwAWrT18meKzOd?=
 =?us-ascii?Q?hUOF99bLsZMKVNS0IQvNiV2n5euA14uuHOLHta9liNZnj4CIXkvLowD2LhxM?=
 =?us-ascii?Q?M238iCeSshdN61HjiBO7c2NGfuV8WSmun40XaaDgcC9fIUxVMNfZE/9MSH+4?=
 =?us-ascii?Q?ssFXEMeuHPGM0U6G0vP71TCo7EQeKxW433XLXSEaIJtv2uGwy8of1OHm3CJd?=
 =?us-ascii?Q?+JnnpEeg41jHmKqgJutgfn3Gf+cXrCVgk5MygGg08YCXbGeEx7R0oRjfLZA0?=
 =?us-ascii?Q?doABzjjSGOkEMZiAM+9FKR15wTZYZ6nrWRbJCH/Sk/tX2clrG5c+pf4iO7vI?=
 =?us-ascii?Q?nFSpW45nK2ohPg5NptdSqhrjWyv4A+AuBjBcCQ4VyKLMzYbTl7yzn8axPQNi?=
 =?us-ascii?Q?51RZMNBrc3LE/G/JaibQQJiak0d6csD92VtkAAxSy75ro0DXuimuTtfo0lU8?=
 =?us-ascii?Q?+zTMvKH/vzM0qQp9yoHjS/SHWEcmSIb/kCnT9GXXOywCU/liLKRYzgKXz8To?=
 =?us-ascii?Q?GZvB3fUXPF4GgmMOGs7pRE8B/54e5gWfD9qXBbggCKTyq0gINtygm5AlUh3k?=
 =?us-ascii?Q?bYYC0QpvWxy7GoQqPCGJ/qJhUwhGZhL7Pb1jKEGqfZsAAuIXedic1AobaAIJ?=
 =?us-ascii?Q?9+pXEfYi/6fMRKGMMri7UVuVpbqK6gtpT+PbssR922SSUKaFad46MJiKAlMZ?=
 =?us-ascii?Q?Gu2jJo2JFh77uoMFKnT/YSqvB2EMuOCd957e64TDhpHB8UVSF9mPOaeGtmBr?=
 =?us-ascii?Q?tGYtYH9twkj3fRXcDY83ENeaCi1uET34r3dsYjU+mCEF2UnkNpw7DNLV2G8W?=
 =?us-ascii?Q?DiATdENV8HHP2GQDChL3h/q7jRrzzXE46IbGp7Ec4lY+Eh/4V87E0uTCrio9?=
 =?us-ascii?Q?cgzSRSRlntBzp9UcrNFkn9cxE+kv8Oz/c3V+tSxTJqeDWCwZyO1elsTs04oR?=
 =?us-ascii?Q?UVIukCiHthvg05R+QXaq7lo5q00hCoHac6Dv5azm5B2ylij3RJXo7a5eUhyb?=
 =?us-ascii?Q?y87/etL4hu8X3olRr9ilEY0Nb1N1PvLXtwVdyXhzFgCyR/34v1W0Tvi/iyXL?=
 =?us-ascii?Q?7M8gA0dERfcPpJx6ViWR+Q8vXyVaGnjb+iZ4+uCPShfva0fpLUYx4EGh9nvA?=
 =?us-ascii?Q?aYHFoPNs5s40NFlY+ZLBQIdcchdMe9EBXb4V+2ZKjm9eXZ6qczMmSC+oE4W/?=
 =?us-ascii?Q?NYNwJWHrk1cbJLD7kABFPut+6Nf2QuzFd62BV1xi/sfmrv20qpG0FowMdFQ1?=
X-MS-Exchange-AntiSpam-MessageData-1: i5xIXW8w1MaUuIF6lmW1Csdr9yeUhIdwnEI=
X-Exchange-RoutingPolicyChecked: zCUVEIB9mGxd5oWs0VfB7BXAXmdHKdmjkSx4fQvxbc4DJADjsdhOd066FPsKoXQ/e/PQCSYverFBRDCaSxcR0ylK/0+efbciECqeIUyKawElloskFApNh3R8lneg88TW0tsPZEpPenIhQyof0EhxEuJ1Cxb/JgPHMdQfnm9KJ5ZN8AvAm4EngBHWcT5REDjLcp4wlCD+LREJ1Bm+W98ou0dmd8xnkm+9TJWhZqaEnvLKa99Lq55IkqITOdSf6rnXrK+FWDZXDVdXOTDkE4nQJe7MEzuVPb0N3VNcTUC1QN4dOSgd2FQJACH33N6+B9Al4q1HqSBK9feNlpg+RYbibA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4c841-d400-4193-fe03-08df07f8304e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:11:05.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/JAzgoGTrlDQhxd7SfB34iHi1BEXrgRSzfDYQuELYLnafSixjYkzw7uG1vsi7VfL2Gap/+AEZ+RVofn6ZDwUaZ3hJCozeT8JIAJ28+9jHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfX2XH+EzNFoiG4
 LsZQIs6h/m9BaRhJjjXa3og+fj0Y4cBjfNLZZQjBmGTyaEA9YHFBUKDqLecCXyO8oxtOag+BTSq
 Lf9I549afHFY+06MJ/nOLOG6yK4cWYhd0NHU9KMvtZppfTZpEVpDbVCmklwJK45O9N2UvDmw6uN
 CnM1llAFvyhlA5CaKW/O+0voc65QWZ5DcNOsfILGGEKqgm9gm8sOGERydNdPOQUASROgAhATnzG
 nwFV4YKYZTcN9rwijjHGO5tQB/dmuurwuaAwidHDaKFHQCvqQLegNL8dre7jpSQHDzZHIYFCWau
 lkqLnenpQqc/obtm6TXf/lgfNnpzwxMK2PFmCqh1zxOJwtgxoZ3JS1XJ52wJCL/F+wFsYEglun4
 mxUW7CP6bxqWYQrNQnWHZpLPJX9ysHy2CmyFlmaoau9WqU1ziuNUbdaSemHkT5+M2k8S163ZSMi
 2jAhQtx4sEJutfClwFQ==
X-Authority-Analysis: v=2.4 cv=BJaDalQG c=1 sm=1 tr=0 ts=6a967a8e cx=c_pps
 a=MVTdNaybHAW3nHwJGrV5wQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=jcFIXsoQAAAA:8 a=t7CeM3EgAAAA:8 a=OuZLqq7tAAAA:8 a=tbGmHg6jYLPFn9dp6zMA:9
 a=M1-Q_cRM6PFdmZSamPpU:22 a=FdTzh2GWekK77mhwV6Dw:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfX9goD8N9lCzil
 TsjlBvm+GpSu/XCPSlzNHrJfMzXxjLVJ09MX4sanjcFf9dXEG4KMqEB+Gim4kn0tAh+tqNo9tT0
 bcnQ2Zsyu+YrMEjnB3W5mBp/OjQZDk1djJogN3IjtbdyJhqg6/NJ
X-Proofpoint-ORIG-GUID: KKJhMr1v6s5WFFgARu7WpmSrVVXBcETi
X-Proofpoint-GUID: KKJhMr1v6s5WFFgARu7WpmSrVVXBcETi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_001157_050539_4E954B9F 
X-CRM114-Status: GOOD (  10.72  )
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

Based on linux-next (next-20260831, base-commit 89c07d98716a1).

Changes since v4:
- Bradley Morgan's tags now use his new address, brads@mainlining.org,
  as he asked on the v4 thread.  His change of address was announced
  from the old one in [1] and he says the mailmap patch is already out.
- Rebased from next-20260826 onto next-20260831.  No code changes; the
  diff is byte-identical to v2, v3 and v4.

[1] https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

v1: https://lore.kernel.org/lkml/20260812170433.533845-1-ionut.nechita@windriver.com/
v2: https://lore.kernel.org/lkml/20260825075043.42041-1-ionut.nechita@windriver.com/
v3: https://lore.kernel.org/lkml/20260826073527.21487-1-ionut.nechita@windriver.com/
v4: https://lore.kernel.org/lkml/20260827070822.12651-1-ionut.nechita@windriver.com/

Ionut Nechita (2):
  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
    CONFIG_NR_CPUS_DEFAULT
  crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing
    docs

 arch/x86/kernel/crash.c | 6 +++---
 kernel/Kconfig.kexec    | 2 +-
 kernel/crash_core.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
--
2.55.0


