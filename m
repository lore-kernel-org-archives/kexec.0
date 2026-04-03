Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B4FD6AB1B
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7pT92kzoLt4m1Dt7nsLCwFrnnAk82rz+mVt0YCCSNmI=; b=4UWWnb9r1cdESnbVU1VpXXpQHT
	nXX1WSaYr/mUcLxLUBbSb6IcKhROOT0EMZ/O8KFDNxct1/QLM5Tz+azm+uaFaicmmtaJ1n+rPVoNf
	wDhWK5rIB8mObAM4sjDCvlvoqIyur5ek8rb1JWftrAJz6YL+rC32HPLjiHterFyxZAhxivOk1vC4p
	zUoXFMEcb7F4idwrlFopXHfCiLQigHXfqgoJWv7vKY3x9pRZiryn7Ym8jiky/j5wn8oLab9yFtEoA
	dUL79njJiID9dUi1ZD6aHXY2XvNeb2rE+xnrdb6jc5HepscFJhLcmyMashSG2BqRsw0K7XmI12OSJ
	yqgfZAMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8S8g-00000000xx0-0REY;
	Fri, 03 Apr 2026 00:11:54 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8S8c-00000000xwd-3Vlj
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 00:11:52 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632FBnXg001795;
	Fri, 3 Apr 2026 00:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7pT92kzoLt4m1Dt7ns
	LCwFrnnAk82rz+mVt0YCCSNmI=; b=H3cPT2NdWxuCXa6KsWXKFq3hxj6kPZY+8U
	UMOmorMWENIOVVv7rvQwuTEkcLyoct1VDIyVwW5UBSSnP0ifsqqzQvF9PFZloRYg
	7clqoIPjgZKKgx+463tNdTFk2RumY8b9PCM3Ff56GtpYPxcI30qH6I/bZLR/81Y9
	m+ROEJWZzfdHPysNn1bvdr6MzHPcLx6KR71nTRw29NW+VOKJ/xQi1cEOozgAfJek
	GF+T5xWmAWHBLpfNj4e1pgydFWvvZfGVxIPMv6TW9UEZUvtaSFrgCYecttNYutJM
	bak47FMs4b8rrvHe/O7eqWPj7pRFjL03AC/Lfk2paw0NNLf+VBhQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d671b1ewn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 00:11:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632LP1pD029039;
	Fri, 3 Apr 2026 00:11:47 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65edbdgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 00:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJiqaua5JslCpA5T5EBiA7FxU7vfvbNaB7UQQxqt1mQMHklEyDsBdwwxPh/n0gwp+8ZOoENvFJwMLIclsKHG6TwRjW2w+2dETyj5M8DMYPoRjuJH88Q8JaMyBthd/plBhGag4MRszUIJlkmQDIpU3D/YDZTjer+q0aNoo3tSd26bHcgZVsjHxJZEbjHbLUxFSGC9krPhmNuZVlv+rPSQHEuISZVqjU/YDcq/uSTjnTZ/isE6GIKNJvlsDKM5+kBZVGLrFsLjzXm1/DTVKuRRqYgPXv4vG0QWA2nmGuuXmn/NbqPnzkoYPsbF5geJrSll6Q75KYyoZUZ0L0aWAAoiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pT92kzoLt4m1Dt7nsLCwFrnnAk82rz+mVt0YCCSNmI=;
 b=lA/d5gZLmrhh+uta0EkjCPH64MVh06f3Bm7iAmleww2c64IH0rAPQEV6M5iyUt806C+pG8f4xcg84UZtNxqCOR29MEhB1yVtcHO5wbaiR4fMWt/OY+TiXMWbAAzOxlMk2pcTEVqEgfq+0vPgOrDo+rvqOYcWJHLmyuU5VX8yn4nqkarKrOaSbtU/iJS08+SK0AocGXvLWadIqXl+89Jdh2abj6U6xuVmi/VhQO7Jeu+U+4xJxiJDGQ6XhtMGtCsxuv6B2xXn3o445k6DOikvMDhYIiY5kn/9jK7BXuqlnjtzmwK3/NhlQy3KWbmeuqV952j34u8OOg1Iwz3EtnOSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pT92kzoLt4m1Dt7nsLCwFrnnAk82rz+mVt0YCCSNmI=;
 b=NzLhbcMfasR+dwpaD1mNRb2YuI5Lkk4Z6g6WKnp75nn/Hh3Kd+FAc9zLtkDSJMIXrQLjWfDtHXhUxAuk2MAwMiWKMLJ9ATUo5AmZNTqbeIJKd0wgeEjxBY1e6BnfVHLFs+qVTH8SF7iztNY/Asm0Pwjo/c1VZFDvZVGwrS/d0bU=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 00:11:44 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 00:11:44 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 6/7] Add makedumpfile extensions support
In-Reply-To: <20260317150743.69590-7-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-7-ltao@redhat.com>
Date: Thu, 02 Apr 2026 17:11:43 -0700
Message-ID: <87qzowewcg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f0b493-e6f8-4ba6-bb5b-08de911596da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: UqBUvzk+vfSF0dxicJoB3U3JTHQG8CscZO8awocGYsGZZ95ewnerlVe+UutT8tSpMrYFtHP+sqn0x2rRUVV7/2cGuzcokoKfU3f27sHkL3j1cGf0nhtTiveFOSg7ln9aTjcA9fEmdz0UDurITP3bjGuPd/wli8Nzmsv3LSeu6W82BAG1bs8swcRlQAHgO11RM2SkJq5X/WL+nCw7CgaaRHzeT2qF75PAwcArOFT39Z7H1O3egZ1m2M3OE4s+9L9R9fgPHZyJAJ765KDQIi161kANAfnd6vsI9ujThsBpNSH6waoggxLbGvoDWEt23PpPyP5wesiCD+Urxnon9uQz8EbZcToLejf0o0ePlZsxiYPLzc9TbuVhNeQky/tXmDS76vWFOLe6ZEDX1rqA5g1X4mm7Jxf6CNnCvB2Z3J59IXES+IAufElqpnjt7IeJLdFOfTcFMC2WxcZs7T5O74PFEjYpuxJUi5vPeNmOesnq+ELQ8qN+WkqYoq6739akbM3YAU3p//U4krJIMw7tpGjT3AkmraHhKB0ynsN2RklYj4O3O4d4Um9/t3PbzbSm2Ju6tIOfCO7joht50VQUPV3bO05dlZhdTNAFE0HfMXrbt5OgbWf1Q+/h1jm6+wfnMUN1x+j6YfVpejH6Ls9jbqMEsbA68pS9hSJubYxEllmTFXV/pbSY8WuBK7bEttUcx+yW1852MDab0rBvKndOckJ6A7t+vu9rp9fI0QrI546u9fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJew+lZ8Y4HBXDmImGQknLeAkbbNQ1bnNOkxWqyDTcvUondbFZYqBcRq4+Nk?=
 =?us-ascii?Q?HLFh/nsQJgxrRet4WgwWO6lPxYxLrVX/SGG9k9JSKsmJEBh+3yjhUbjitwiz?=
 =?us-ascii?Q?XVPaY4cJBbD9nSxhb+ruYEptTJVNHRMby/KUCgCk9GU+uGugtjobcagVXOP+?=
 =?us-ascii?Q?12C1m2uQTOKzNKdZn8Gbj1KK3Jkafb8HoVkzkyhK9huO9G7aE4PtEM9BWAn6?=
 =?us-ascii?Q?VtRxydgWnfb4SiyL0qYJn9UAIGjjAh1GIQNYLN2+XCrKY3DDwAq/xh8auxiw?=
 =?us-ascii?Q?njbbO7ynBWWpliKLokDuorqf/9eC5ngWXxNIJaITSgYmnJVnDwL+K316bOzx?=
 =?us-ascii?Q?JWfiFBIfxEU+w+edI3I7pmRPJxCibgQNfGmYFMkdbxeq8S4fp0alvabBzYkF?=
 =?us-ascii?Q?dCj/FsRp7bouVwGuuABTWdIqfiaP09RMhABCezUU/ZvBiC5D41nShCzO4+Ql?=
 =?us-ascii?Q?q2fa97nqaOKIccV7wgY93vAqO/OvJxx8j2ndbBICM5fm0SuTjBzgz5gBu11H?=
 =?us-ascii?Q?fRPv+Xk/CJt5TiX2rfFx1EytJjNvOtUmDCcjTGJxSQOwDKISocJlweJazDPN?=
 =?us-ascii?Q?y48EW/jWiWVD4NTiJnMH/pB26jfZamp3lR8+HH6SQyvtkrGrs0ln+ZMzg+VC?=
 =?us-ascii?Q?GcsvL5iXxAE21daPLPdQDoFxee5469fDOHEGkciFYnKJk1gk5IzFDbuOlxlr?=
 =?us-ascii?Q?Y6pX9oG1kn4akNZrbqs7AkdeHo9Uqn1EB48+Xm/njmGgzVOStiWYKcsSQZVh?=
 =?us-ascii?Q?TeXgHVB6GSrzqzOtQSWuOYOcDOcOMToS1DH8XzIrVkH5f0ho7ulnI6aKH6S+?=
 =?us-ascii?Q?bALhGMOo99R0Els7l0faVcRYRkYcuviyl6LA5giI6Gh4SjnvljW5PgWpQ1TF?=
 =?us-ascii?Q?HxLyATjFlIgiqRZGZdaXiGXcgsT0jFfHgPOQ+WzH2yYEm3lGld0xq2YxVHsA?=
 =?us-ascii?Q?agl6rnOsDrGW1WCFSiHSLjowJq4K+AjjKUP5ffUVBSOWKM/1+hhjDVzkWjJm?=
 =?us-ascii?Q?9dOGzw4RZh/SP0jtW8XO7unTWlj8gTjU28u7YT2lRnsr+1PzYmtpRron5YBY?=
 =?us-ascii?Q?2nwN5HF9IcV0GGHlb8BqEwfY2FbGAi1bzKbQQvNEM0xiJ7afe/Kg3yCYLpRG?=
 =?us-ascii?Q?A/BCrNSYAXiD2zoadzifoxmMMN1ji6CRyPsUfCZucwzHf+lZsDfHRw2jr19u?=
 =?us-ascii?Q?7uA8gqQPn/Cmq7pfX9TZmEdjnQNO/xLUl8MAHzjfvReVdaLtCzMh44OVhVLg?=
 =?us-ascii?Q?wdvZIi+H4YwzMm8HxI/ANjDtSTcqvvht25ymnkRSlKHvHuDRBubEz2M1RVuG?=
 =?us-ascii?Q?CRil2MeipbCfDwwfFCZhz9XJr2qKg6KoIt3B43esZBBr2Ug+uNrYLVZUo7+P?=
 =?us-ascii?Q?U8vNnIp0RRutVI+S42+auL/NPUwD/O3sR2X2jDCSTdhL9y9LwUJ/YEKlOCG8?=
 =?us-ascii?Q?KjFVS90KWaKQ++0kVf/G12YeMqWbX5Xo1YgqGcv7l2v4l4c0ePBuH9QWgTpb?=
 =?us-ascii?Q?nuGtfcNPm3y76zHLjdsRILryqlZ4CDqDYbg0Vj9jEGpvXu+ix+B8x7HJar/Y?=
 =?us-ascii?Q?MxJTQ5BCF6QpI6EF9ch41ktQjXBpirEtnJ8uAJksKahWHtD8TtnpVZf55I3y?=
 =?us-ascii?Q?O2oLESyWBS1LHdYsMLAwZvt6F6hw2IWSEEk78jo2ZfUi8LpNODlgCD9PU1Py?=
 =?us-ascii?Q?tTE49c0F/ONSAO/50hF5H6O1z4LAMwTMctNXvNl5KDGWJYCaJ2XnYJPsFObX?=
 =?us-ascii?Q?qmmxyG7MMuzd/sPZ2UFLqX5XwGbig7U=3D?=
X-Exchange-RoutingPolicyChecked: mr8WpfOgfWQPaHUzeqOio5csqRvccEh++8KOMNR5JwY6s2OPGGZMgl3Dk+GFqtrAMHMaI0ghRrpjjgZnL0ALl0CBsjCKsrk3J7qINVF/E+Dcw4y6hGn+yvPyMGQ/5W108wW3aiVT9bF++qdDD2e+coZRBBcnGvVwpaaV/QVs/nFCSHFOTN1LMp8Ss65L+n0n8tz4gGsb1dB6nN71INmqAANUBp9nhyxYuWKznKvGd1CXuPbY+N+VyaA5GOBxcFXQUZ8vKyIrddW9Ba1BDbYQNo4f8u0lzWHtP4irUdg+/K3rofcpll48CQK71CjmLc9Z3ktM2fEa8mGgr1FHfr5JWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mV2lXX07kgXZNL5MpnGYjLiBdjXTLUy/VcYSbp+LaP21KAMLaFpfTyGXBCFc28WhDVFuHor+JxQKEGOu7z7KTcyX6gZOPDcB1rKPiNFjY2WNplldh2KBRybzHoa3avrt6tlZQha9r8L9IFdUBUGQyJBeN4K9ewaCtDb61v9/zNn6O050UmZbtAuMCkGvXBdfHadOjPGJHDlvIOc+8MkhmZcInwtdVVvUL9K0UL9Y+mS8UQveNDVrkFcV4rL3t+H6L2jt1E1Bltu1+Ow6fSYYbCAkFAkSuQskUeVhgOFwolNHsq5WbNd+BAjmj8BmQg2S6vq590HhmN76KeTASkdFZ9OsfdO9jAwrHq+GxvvAe4oyvxNfXsqTd2cnlYZrW0ySb3bFPhvSgWA98va8a59tqJmxvmcsPWjuOG02x2XO/5abEXRJxO64bWQbPRejqIVwPCQRkfSxahUYDKL2ac53bXh9+yFtWDJ4btmB/IaE01YLHl/S/9lGg4EtutUQZwD7El/AA7V/620TW0dQ8lIsUsIuogNogFHNDQ1hA4TUmY1HvLisj5Pfp5Mx2O05KPpYZfKt4jJBWrn7iDyqyUGsYlgByQ+RW62J3NTi5YRld8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f0b493-e6f8-4ba6-bb5b-08de911596da
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 00:11:44.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU3PWIQSNsjhqYhVKO795vHOOAooou2SxSE2yiBSj8pdB8f3eb7H+Hn0hJNwOEq+RZjzE7vvGKo9Qe0JCH7+zPlvwkvw6USwy0ve2iZIq/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2604020215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMCBTYWx0ZWRfXy6a5YMo6rDjm
 CrfXDPZhdHBwzva1eZh37CW2zNvmYcdSca5QsafoJpMld9b4IpRXwv8Tv5nPVrXVki1ZgOjHMy2
 bppv0jClizwbbAjbRAIysZNCqUsn11AH8nofCFjxNDaPMFhD8QiaFbrvDmERLrrjWl91nD/UpR6
 U4c+2C/TFWPDBJuN7aQGtlX2euud8zj97bHVmxZEReCGsyXOKVvWZ2WoO+cJHNxsAWMgTlKCBlc
 IO7lJvArm6LgL41GApWPkwtzyAMWmk42etj5DokdNPFEQO/PK+i+u73ODT5u693rjiWvx1jn2MR
 wgQAovqDZGo4ylFscFH7dSysHVpDMdvWu96pObz6GDF+CwWX7IZb6nnN71XIx2oufAZIrtQ79Uh
 D4/JbynOFSjGOr3XtIUCH1PywlfwNXc4k6wSq3O386yfEM13EyyWDWStmjOZvaZ9Qo5H1PV0rQJ
 dQtmEp9rpevQtL1Ez2Q==
X-Authority-Analysis: v=2.4 cv=PJkCOPqC c=1 sm=1 tr=0 ts=69cf05c3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=J4g-ftlP-bLRchfvFSYA:9
X-Proofpoint-GUID: iyISki3wkmihb1JA554FXiefRPfqIfLf
X-Proofpoint-ORIG-GUID: iyISki3wkmihb1JA554FXiefRPfqIfLf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_171151_007477_D3A9EC91 
X-CRM114-Status: GOOD (  23.82  )
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
> The extensions can be specified by makedumpfile cmdline parameter as
> "--extension", followed by extension's filename or absolute path. If
> filename is give, then "./extenisons" and "/usr/lib64/makedumpfile/extensions/"
> will be searched.
>
> The procedures of extensions are as follows:
>
> Step 0: Every extensions will declare which kernel symbol/types they needed
> during programming. This info will be stored within .init_ksyms/ktypes section.
> Also extension will have a callback function for makedumpfile to call.
>
> Step 1: Register .init_ksyms and .init_ktypes sections of makedumpfile
> itself and extension's .so files, then tell kallsyms/btf subcomponent that which
> kernel symbols/types will be resolved. And callbacks are also registered.
>
> Step 2: Init kernel/module's btf/kallsyms on demand. Any un-needed kenrel
> modules will be skipped.
>
> Step 3: During btf/kallsyms parsing, the needed info will be filled. For
> syms/types which are defined via INIT_OPT(...) macro, these are optinal
> syms/types, it won't fail at parsing step if any are missing, instead, they
> need to be checked within extension_init() of each extensions; For         
> syms/types which defined via INIT_(...) macro, these are must-have syms/types,
> if any missing, the extension will fail at this step and as a result
> this extension will be skipped.
>
> After this step, required kernel symbol value and kernel types size/offset
> are resolved, the extensions are ready to go.
>
> Step 4: When makedumpfile doing page filtering, in addition to its
> original filtering mechanism, it will call extensions callbacks for advice
> whether the page should be included/excluded.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  Makefile            |   7 +-
>  extension.c         | 300 ++++++++++++++++++++++++++++++++++++++++++++
>  extension.h         |  12 ++
>  extensions/Makefile |  10 ++
>  makedumpfile.c      |  38 +++++-
>  makedumpfile.h      |   2 +

I think the manual page will need updating with this change.
Documentation updates could probably be done in a separate patch, though.

>  6 files changed, 363 insertions(+), 6 deletions(-)
>  create mode 100644 extension.c
>  create mode 100644 extension.h
>  create mode 100644 extensions/Makefile
>
> diff --git a/Makefile b/Makefile
> index 320677d..1bb67d9 100644
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
> index 0000000..35e2756
> --- /dev/null
> +++ b/extension.c
> @@ -0,0 +1,300 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <dirent.h>
> +#include <dlfcn.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include "kallsyms.h"
> +#include "btf_info.h"
> +#include "extension.h"
> +
> +typedef int (*callback_fn)(unsigned long, const void *);
> +
> +struct extension_handle_cb {
> +	void *handle;
> +	callback_fn cb;
> +};
> +
> +/* Extension .so extension_handle_cb array */
> +static struct extension_handle_cb **handle_cbs = NULL;
> +static int handle_cbs_len = 0;
> +static int handle_cbs_cap = 0;
> +
> +/* Extension option array */
> +static char **extension_opts = NULL;
> +static int extension_opts_len = 0;
> +static int extension_opts_cap = 0;
> +
> +static const char *dirs[] = {
> +	"/usr/lib64/makedumpfile/extensions/",
> +	"./extensions/",
> +};
> +
> +void add_extension_opts(char *opt)
> +{
> +	if (!add_to_arr((void ***)&extension_opts, &extension_opts_len,
> +			&extension_opts_cap, opt))
> +		/*
> +		 * If fail, print error info and skip the extension.
> +		*/
> +		 fprintf(stderr, "%s: Fail to add extension %s\n", __func__, opt);
> +}
> +
> +static bool init_kallsyms_btf(void)
> +{
> +	int count;
> +	bool ret = false;
> +	/* We will load module's btf/kallsyms on demand */
> +	bool init_ksyms_module = false;
> +	bool init_ktypes_module = false;
> +
> +	if (check_ksyms_require_modname("vmlinux", &count)) {
> +		if (!init_kernel_kallsyms())
> +			goto out;
> +		if (count >= 2)
> +			init_ksyms_module = true;
> +	}
> +	if (check_ktypes_require_modname("vmlinux", &count)) {
> +		if (!init_kernel_btf())
> +			goto out;
> +		if (count >= 2)
> +			init_ktypes_module = true;
> +	}
> +	if (init_ksyms_module && !init_module_kallsyms())
> +		goto out;
> +	if (init_ktypes_module && !init_module_btf())
> +		goto out;	
> +	ret = true;
> +out:
> +	return ret;
> +}
> +
> +static void cleanup_kallsyms_btf(void)
> +{
> +	cleanup_kallsyms();
> +	cleanup_btf();
> +}
> +
> +static void load_extensions(void)
> +{
> +	char path[512];
> +	int len, i, j;
> +	void *handle;
> +	struct extension_handle_cb *ehc;
> +
> +	for (i = 0; i < extension_opts_len; i++) {
> +		handle = NULL;
> +		if (!extension_opts[i])
> +			continue;
> +		if ((len = strlen(extension_opts[i])) <= 3 ||
> +		    (strcmp(extension_opts[i] + len - 3, ".so") != 0)) {
> +			fprintf(stderr, "%s: Skip invalid extension: %s\n",
> +				__func__, extension_opts[i]);
> +			continue;
> +		}
> +
> +		if (extension_opts[i][0] == '/') {
> +			/* Path & filename */
> +			snprintf(path, sizeof(path), "%s", extension_opts[i]);
> +			handle = dlopen(path, RTLD_NOW);
> +			if (!handle) {
> +				fprintf(stderr, "%s: Failed to load %s\n",
> +					__func__, dlerror());
> +				continue;
> +			}
> +		} else {
> +			/* Only filename */
> +			for (j = 0; j < sizeof(dirs) / sizeof(char *); j++) {
> +				snprintf(path, sizeof(path), "%s", dirs[j]);
> +				len = strlen(path);
> +				snprintf(path + len, sizeof(path) - len, "%s",
> +					extension_opts[i]);
> +				if (access(path, F_OK) == 0) {
> +					handle = dlopen(path, RTLD_NOW);
> +					if (handle)
> +						break;
> +					else
> +						fprintf(stderr, "%s: Failed to load %s\n",
> +							__func__, dlerror());					
> +				}
> +			}
> +			if (!handle && j >= sizeof(dirs) / sizeof(char *)) {
> +				fprintf(stderr, "%s: Not found %s\n",
> +					__func__, extension_opts[i]);
> +				continue;				
> +			}
> +		}
> +
> +		if (dlsym(handle, "extension_init") == NULL) {
> +			fprintf(stderr, "%s: Skip extension %s: No extension_init()\n",
> +				__func__, path);
> +			dlclose(handle);
> +			continue;
> +		}
> +
> +		if ((ehc = malloc(sizeof(struct extension_handle_cb))) == NULL) {
> +			fprintf(stderr, "%s: Skip extension %s: No memory\n",
> +				__func__, path);
> +			dlclose(handle);
> +			continue;			
> +		}
> +
> +		ehc->handle = handle;
> +		ehc->cb = dlsym(handle, "extension_callback");
> +
> +		if (!add_to_arr((void ***)&handle_cbs, &handle_cbs_len, &handle_cbs_cap, ehc)) {
> +			fprintf(stderr, "%s: Failed to load %s\n", __func__,
> +				extension_opts[i]);
> +			free(ehc);
> +			dlclose(handle);
> +			continue;
> +		}
> +		printf("Loaded extension: %s\n", path);
> +	}
> +}
> +
> +static bool register_extension_sections(void)
> +{
> +	char *start, *stop;
> +	int i;
> +	bool ret = false;
> +
> +	for (i = 0; i < handle_cbs_len; i++) {
> +		start = dlsym(handle_cbs[i]->handle, "__start_init_ksyms");
> +		stop = dlsym(handle_cbs[i]->handle, "__stop_init_ksyms");
> +		if (!register_ksym_section(start, stop))
> +			goto out;
> +
> +		start = dlsym(handle_cbs[i]->handle, "__start_init_ktypes");
> +		stop = dlsym(handle_cbs[i]->handle, "__stop_init_ktypes");
> +		if (!register_ktype_section(start, stop))
> +			goto out;
> +	}
> +	ret = true;
> +out:
> +	return ret;
> +}
> +
> +void cleanup_extensions(void)
> +{
> +	for (int i = 0; i < handle_cbs_len; i++) {
> +		dlclose(handle_cbs[i]->handle);
> +		free(handle_cbs[i]);
> +	}
> +	if (handle_cbs) {
> +		free(handle_cbs);
> +		handle_cbs = NULL;
> +	}
> +	handle_cbs_len = 0;
> +	handle_cbs_cap = 0;
> +	if (extension_opts) {
> +		free(extension_opts);
> +		extension_opts = NULL;
> +	}
> +	extension_opts_len = 0;
> +	extension_opts_cap = 0;
> +
> +	cleanup_kallsyms_btf();
> +}
> +
> +static bool check_required_ksyms_all_resolved(void *handle)
> +{
> +	char *start, *stop;
> +	struct ksym_info **p;
> +	bool ret = true;
> +
> +	start = dlsym(handle, "__start_init_ksyms");
> +	stop = dlsym(handle, "__stop_init_ksyms");
> +
> +	for (p = (struct ksym_info **)start;
> +	     p < (struct ksym_info **)stop;
> +	     p++) {
> +		if ((*p)->sym_required && !SYM_EXIST(*p)) {
> +			ret = false;
> +			fprintf(stderr, "Symbol %s in %s not found\n",
> +				(*p)->symname, (*p)->modname);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static bool check_required_ktypes_all_resolved(void *handle)
> +{
> +	char *start, *stop;
> +	struct ktype_info **p;
> +	bool ret = true;
> +
> +	start = dlsym(handle, "__start_init_ktypes");
> +	stop = dlsym(handle, "__stop_init_ktypes");
> +
> +	for (p = (struct ktype_info **)start;
> +	     p < (struct ktype_info **)stop;
> +	     p++) {
> +		if (!TYPE_EXIST(*p)) {
> +			if ((*p)->member_required) {
> +				ret = false;
> +				fprintf(stderr, "Member %s of struct %s in %s not found\n",
> +					(*p)->member_name, (*p)->struct_name, (*p)->modname);
> +			} else if ((*p)->struct_required) {
> +				ret = false;
> +				fprintf(stderr, "Struct %s in %s not found\n",
> +					(*p)->struct_name, (*p)->modname);
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static bool extension_runnable(void *handle)
> +{
> +	return check_required_ksyms_all_resolved(handle) &&
> +		check_required_ktypes_all_resolved(handle);
> +}
> +
> +void init_extensions(void)
> +{
> +	/* Entry of extension init */
> +	void (*init)(void);
> +
> +	load_extensions();
> +	if (!register_extension_sections())
> +		goto fail;
> +	if (!init_kallsyms_btf()) 
> +		goto fail;
> +	for (int i = 0; i < handle_cbs_len; i++) {
> +		if (extension_runnable(handle_cbs[i]->handle)) {
> +			init = dlsym(handle_cbs[i]->handle, "extension_init");
> +			init();
> +		} else {
> +			fprintf(stderr, "%s: Skip %dth extension\n",
> +				__func__, i + 1);
> +		}
> +	}
> +	return;
> +fail:
> +	fprintf(stderr, "%s: fail & skip all extensions\n", __func__);
> +	cleanup_extensions();
> +}
> +
> +int run_extension_callback(unsigned long pfn, const void *pcache)
> +{
> +	int result;
> +	int ret = PG_UNDECID;
> +
> +	for (int i = 0; i < handle_cbs_len; i++) {
> +		if (handle_cbs[i]->cb) {
> +			result = handle_cbs[i]->cb(pfn, pcache);
> +			if (result == PG_INCLUDE) {
> +				ret = result;
> +				goto out;
> +			} else if (result == PG_EXCLUDE) {
> +				ret = result;
> +			}
> +		}
> +	}
> +out:
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/extension.h b/extension.h
> new file mode 100644
> index 0000000..dc5902e
> --- /dev/null
> +++ b/extension.h
> @@ -0,0 +1,12 @@
> +#ifndef _EXTENSION_H
> +#define _EXTENSION_H
> +
> +enum {
> +	PG_INCLUDE,	// Exntesion will keep the page
> +	PG_EXCLUDE,	// Exntesion will discard the page
> +	PG_UNDECID,	// Exntesion makes no decision
> +};
> +int run_extension_callback(unsigned long pfn, const void *pcache);
> +void init_extensions(void);
> +void cleanup_extensions(void);
> +#endif /* _EXTENSION_H */
> \ No newline at end of file
> diff --git a/extensions/Makefile b/extensions/Makefile
> new file mode 100644
> index 0000000..b8bbfbc
> --- /dev/null
> +++ b/extensions/Makefile
> @@ -0,0 +1,10 @@
> +CC ?= gcc
> +CONTRIB_SO :=
> +
> +all: $(CONTRIB_SO)
> +
> +$(CONTRIB_SO): %.so: %.c
> +	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
> +
> +clean:
> +	rm -f $(CONTRIB_SO)
> \ No newline at end of file
> diff --git a/makedumpfile.c b/makedumpfile.c
> index dba3628..ef7468f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -28,6 +28,7 @@
>  #include <assert.h>
>  #include <zlib.h>
>  #include "kallsyms.h"
> +#include "extension.h"
>  
>  struct symbol_table	symbol_table;
>  struct size_table	size_table;
> @@ -102,6 +103,7 @@ mdf_pfn_t pfn_free;
>  mdf_pfn_t pfn_hwpoison;
>  mdf_pfn_t pfn_offline;
>  mdf_pfn_t pfn_elf_excluded;
> +mdf_pfn_t pfn_extension;
>  
>  mdf_pfn_t num_dumped;
>  
> @@ -6459,6 +6461,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  	unsigned int order_offset, dtor_offset;
>  	unsigned long flags, mapping, private = 0;
>  	unsigned long compound_dtor, compound_head = 0;
> +	int filter_pg;
>  
>  	/*
>  	 * If a multi-page exclusion is pending, do it first
> @@ -6531,6 +6534,14 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  			pfn_read_end   = pfn + pfn_mm - 1;
>  		}
>  
> +		/*
> +		 * Include pages that specified by user via
> +		 * makedumpfile extensions
> +		 */
> +		filter_pg = run_extension_callback(pfn, pcache);
> +		if (filter_pg == PG_INCLUDE)
> +			continue;
> +
>  		flags   = ULONG(pcache + OFFSET(page.flags));
>  		_count  = UINT(pcache + OFFSET(page._refcount));
>  		mapping = ULONG(pcache + OFFSET(page.mapping));
> @@ -6687,6 +6698,14 @@ check_order:
>  		else if (isOffline(flags, _mapcount)) {
>  			pfn_counter = &pfn_offline;
>  		}
> +		/*
> +		 * Exclude pages that specified by user via
> +		 * makedumpfile extensions
> +		 */
> +		else if (filter_pg == PG_EXCLUDE) {
> +			nr_pages = 1;
> +			pfn_counter = &pfn_extension;
> +		}
>  		/*
>  		 * Unexcludable page
>  		 */
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
> @@ -10878,6 +10898,7 @@ create_dumpfile(void)
>  	}
>  
>  	print_vtop();
> +	init_extensions();
>  
>  	num_retry = 0;
>  retry:
> @@ -10888,8 +10909,11 @@ retry:
>  			&& !gather_filter_info())
>  		return FALSE;
>  
> -	if (!create_dump_bitmap())
> +	if (!create_dump_bitmap()) {
> +		cleanup_extensions();
>  		return FALSE;
> +	}
> +	cleanup_extensions();

If a retry happens, then all of the data related to extensions will be
cleared: including the list of extensions, the callbacks, etc.
Functionally, extensions will be disabled on the retry. Is that
intentional?

If not, then I think we'll need to move this cleanup so that it happens
when we exit the retry loop (either by an early return, or on success).

If this is intentional, then it probably ought to be documented.

Thanks,
Stephen

>  	if (info->flag_split) {
>  		if ((status = writeout_multiple_dumpfiles()) == FALSE)
> @@ -12130,6 +12154,7 @@ static struct option longopts[] = {
>  	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
>  	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
>  	{"show-stats", no_argument, NULL, OPT_SHOW_STATS},
> +	{"extension", required_argument, NULL, OPT_EXTENSION},
>  	{0, 0, 0, 0}
>  };
>  
> @@ -12317,6 +12342,9 @@ main(int argc, char *argv[])
>  		case OPT_SHOW_STATS:
>  			flag_show_stats = TRUE;
>  			break;
> +		case OPT_EXTENSION:
> +			add_extension_opts(optarg);
> +			break;
>  		case '?':
>  			MSG("Commandline parameter is invalid.\n");
>  			MSG("Try `makedumpfile --help' for more information.\n");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 0f13743..d880ae7 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -2747,6 +2747,7 @@ struct elf_prstatus {
>  #define OPT_CHECK_PARAMS        OPT_START+18
>  #define OPT_DRY_RUN             OPT_START+19
>  #define OPT_SHOW_STATS          OPT_START+20
> +#define OPT_EXTENSION           OPT_START+21
>  
>  /*
>   * Function Prototype.
> @@ -2777,5 +2778,6 @@ int write_and_check_space(int fd, void *buf, size_t buf_size,
>  int open_dump_file(void);
>  int dump_lockless_dmesg(void);
>  unsigned long long memparse(char *ptr, char **retptr);
> +void add_extension_opts(char *opt);
>  
>  #endif /* MAKEDUMPFILE_H */
> -- 
> 2.47.0

