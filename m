Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C7E82CBB
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DumKApXJaARneetWaAFP5dGCaVut6g9Myx/er3KZDvA=; b=WFYK9i4Tn1m9mq
	gyr60YWCxqRRXnNmOBlHFU8YQ2hTbKaLo9RkeXXWmujwRpCuPMoMQXtiRgosNgdv9BDfZfTBPDodb
	jWmBIaiWv8aOKnmxsjb0nDrSIf1vB9vNWp1/NID16pWTkBlXitTMBbgGnY4OuRBrAdXw7ihl7sTdc
	01ebIYHBs25FHbs2yzVDkYWq8BpOEcgkz4Hfx6wOHNm0PNHbmLYh3ynY/aJIQzKUv3Ii7j9JAL+6h
	FJukNJT3Gbi6z1v4+bQXYPKD+y4otJhb5wqZhYUBODXSW0hyCU7HmnKbOFesJ3N3F5QAjX1lrXOlm
	yXOefDnxEoxuXmbSKHrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0w-001YZz-2l;
	Wed, 27 Sep 2023 18:11:58 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0s-001YZ6-3D
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:11:56 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGxKx6002707
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=u9/nnjo+qi15U4hQNdf6iZKFQCMim/9wNHo5gE9cWRU=;
 b=yR/UnFZZpan40e7awLj1NVqwEqv/0gwos72ePLmKFELal0+Zume8+12dCShJkEtm9/W7
 tLfVZJjVcUaIqdCa+GfeMpobAg590eZ3zhF8kiVKULfHcNTGpTUp43F/R33CNUvOpVjx
 QZoViZeYsKW6rwF0zvJ/hgNytaJkn8TnbgnHA1kqeQ1RL2CvBXZjMU6Kl/C75mwA8vPr
 0VWlNrVmukBWZwVIiwQbPI93yLiegHCzWxspWn/HAm3/clAJkvhzXeZjqJsLQmGD2GIQ
 zXvob2pSsnyqrp4Y/74H+QLQNRUP4ud89gSW5yMpBCUxVsY9Ip5WjenSXBs4iMpnodps sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3t9ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RH5IvJ039354
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfednp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvXLo0MGvwFqi78o/VdrBJtOpC571DCrHEq/mmriiWJ7Da3eFsIAENUbLkrrqO4ZbOaK90Ac3JcH+Ae4QYgIiVvjskj/gFo5Dx8bEiTroE2EfUMDcT6SORT5iLgcqxEKlN6GTe2q8M2eC7AE7q1TmsXSKsiRGo9LEoE8eIj84TEfLG369XnTiu1FssGZ+LcZo3l+DAfMaWa/RCHsw8GgL6BFHPEpndnxzfzOGD9SdzdMc1B1xPkD+sMXwib0Uro+Y+p0qe5VKB9aZJlZS6xV/7McxepxFMp9SBhH+QH0lVAaTNNVVoOhdqbkFMjre1oiJRrsjJot2shwXXmFG8A2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9/nnjo+qi15U4hQNdf6iZKFQCMim/9wNHo5gE9cWRU=;
 b=L4Ms/vTDZSHhw8CWREWHOApgtliDqiNK/GtT0PgTItAGPF9mFPbcmWOsLWjHu8RNFGSsUokA10EsDUGMwpDHvE055E4R0+uKdTo1oyDy2aa/SRUyCw11m4DcmwLj3yiWjvNXzOwTFT4TcF1piFQH930KtF8vCpiNEVQkqlbrhkogWYLVFc+QuUjb2pT5uNXXP7cQ5LdhoXMaNN/yh+g41aweYkzGuY0lOqvLCu+Q72pKJHeUId/TlFH84yAR9Rp20vWno62BWTHq9ZyiO2KT5aXPxsGVB9BmkvTw/FOMgKd9IDLPGKLiHtd99wApZOJhiPFsbMyz5Dy0Bp6yZpYgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9/nnjo+qi15U4hQNdf6iZKFQCMim/9wNHo5gE9cWRU=;
 b=ipFoszpmwbF4eFWlHB1mzyIqO5Xihk0nBBpi+/WoOSaf5JTqkttHfW1Hhno/nc165vxA9XN9Bm0UhLelrS8+ZpxfZO2aPESVEe+ro9r4ytm/sm4dLyAykGno84M2FtN9JGiYid5YmSTljtORYsr89QDByx1O88IEVyVVySy8Rc4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:11:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:11:50 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 0/6] crashdump: Kernel handling of CPU and memory hot un/plug
Date: Wed, 27 Sep 2023 14:11:30 -0400
Message-Id: <20230927181136.2627-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
X-ClientProxiedBy: DM6PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:5:bc::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f97eca7-16ce-40a3-6018-08dbbf8538ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peLAnr/pmaizTO3NwIYogeUa22ar+j52tZdoUCrYmWKEYPBfsHbbu/8+gGekB0nDNBcf0j6/91x6KeAACCoZpQ7bJz7VSUdvNE1aFNbbK7GlFtZuURhkm/nsUZgDDy83Igixz2abcNrQAysSV3P/aFET9GXoXrSc5Q5H+Yb+mMrLFyLvVhoOmWMZBd8kdDUk3b3Tqn3R0Gt3ocCXLRqMkgq26ZkM26zv1lValtKwiTjhEGVEo/vk5/cmpm19Ls54Utnp9KUObzBy79PZbkgM4BIzzb85Zd7neHve+49/X7UMDwlLWK0b3hb+cjUcB97wrdJZ9VXBK37njrB3GRUizMNEKhMKOa3YPISqRMGvc9uYEyM1C4JgNAtffnOBbtN6JZsQJO9nKFA69Anf7NWwm39Hq2gX6s7n43yzqIDLfkEz4XsBzXKy+Tfrym9h9z0m0l6c8preLgaFt7n2Xtguzb2F3oEGfuE8yNQm+mysZlUv8mdykTOWhS2oxFPCzGhCslhhcWuR06z85w3HEga4A/LYbpJt2GTMpHTPI56nIBN2D2POsjEI9Bvrc8lVF7V927fRggvup3GsCgL6pWaQWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(6506007)(83380400001)(38100700002)(86362001)(1076003)(36756003)(2616005)(107886003)(26005)(2906002)(8936002)(8676002)(4326008)(66476007)(6916009)(66946007)(41300700001)(66556008)(5660300002)(478600001)(966005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdGHV6MO+Ew81XcLY6fSH1MbuI/KHc8kL/36MqFectmxKxLBFHaKJ+hkaoga?=
 =?us-ascii?Q?f9dLOfAtR8Zaq1OpYPy0ivqLPVZSEbFloPlVsG44lRSN6HpoKe/MXLZ8G1fQ?=
 =?us-ascii?Q?1RPuutt5/UeJ53YFbKcKsTw1ZeaSMk9qjS0L1H7bEhfyqnz28D/g6YnVhDdE?=
 =?us-ascii?Q?XzfSwk83O+cwbhICdZ2HW1Cyqr4APM0XFm9LxbYkvYmxUEuK4PmSh7X6kZjp?=
 =?us-ascii?Q?hCK/KtpPSOrT2bKNO1hYRlt6pGwlp6j+YWeeW2j28ZZaaWniw/zpNrIOYO9U?=
 =?us-ascii?Q?oXboTumEVdKu5gtomG/Pz+IqzwJxI6Pb/D5FFbNyVajfdswgUB7hWISPAENr?=
 =?us-ascii?Q?+9e9se5lxfVxTYjeEjUs8Ll8UhHLo8WypDOQriGG+9n+r1zxU/izp96ciTxT?=
 =?us-ascii?Q?znaAyq9q0mZBzXKHPBHkwEktjnkmlOUYB+ew9V04H/79W1wlhTFiOGK9Zmjl?=
 =?us-ascii?Q?zuv+nO1qZRe2t2inLfmo/Rs1EYFvneMY5hrT8XHsP0NfGWqQjbCr2GV+jXi6?=
 =?us-ascii?Q?OR1XPBGMtkfttGi4cmBF9bQHEkK4mYEBM2jH9Np75XFOu3hzwgA5B8m/inp6?=
 =?us-ascii?Q?3fWxphkzqHyyk+Yq3I5sgSMEFXerbokvuenXDeK+QtW59eUHinXwrl3KhThM?=
 =?us-ascii?Q?pIQ2UgweCIy7Fkd7RFHrNruvM0LpTkJmGbagNd8+KpsTegryoUjFEiCRGG2n?=
 =?us-ascii?Q?NOc38X2zqfNdtw1xFPOVdLLSr0wlSNZN4it8xFRHoIEyLoe7S3/dHiFiycac?=
 =?us-ascii?Q?mNEEhRzHd6JFDtphu5rOY1A7tdGfV/QZWTZYCozvtZvLwSs0VdoEcNE/xRf4?=
 =?us-ascii?Q?MZnvvpqOxdHmq8LHb1Bye+E5TId9+RJAyXFBnm47xmuNNGnfkllLsGuGWwHu?=
 =?us-ascii?Q?0cu8DocQcUPfnkUq9rZkRRtKw3SLqUsRLwv1J3e7Vzm2wbJJHiTgEDDmUOEE?=
 =?us-ascii?Q?0Ic9uQiPVOrqepuqZboU0781LIN/vFt6bWHMG4XF9BeqaMjEZhMqLt/0+hg1?=
 =?us-ascii?Q?WGa0vtMB/DLeGA0+Z3oyGny3zGWq6lVyPLdCyxoFpa3c9oQ8jLB8GKaad21L?=
 =?us-ascii?Q?2y8o8I86w9EmOfWDtniyf3kvqf+m0uHpOVXt4PuNaynEPwTLU0UJ/1U0kM2T?=
 =?us-ascii?Q?fWbDppNRyBymxbtMcrW/OAqy4tM19J8GutbFuRs7s7g/yra9aDEjqRfQj8aW?=
 =?us-ascii?Q?+cLvixhKJ++xlvV9acD0WpPhUMNxtIt+Q16OnA1E8FXBDSGeTCdqDeRBKMhh?=
 =?us-ascii?Q?k8kkH21LNnWSV/XJX2bQBhfmZtVTE77uuSamsdCQGEWz56O2X+/HAGxibjnY?=
 =?us-ascii?Q?cY17IQ2w/BcfFQaul+8lTvQzcsDaZ/zs00iL8SpKGGrNmgZkLWb4S8XltoyU?=
 =?us-ascii?Q?0JS9xyh2PAumk7qrKvw9AxdXe3F2SNhsB5E+2vYp2R1YL7M4KdFP/XqF5HoM?=
 =?us-ascii?Q?3GXLME3VDnLf0BP8gFAM5wjyCXz1aCCVyPDLnH8rdgjGBsp2FYVCEe2n820P?=
 =?us-ascii?Q?yWQhJZQDR73QqJX4iTnS6z0ieuMGRw0Oj98qvoOE7c4ONa7TVzIPnaShT2RP?=
 =?us-ascii?Q?gswhXGAF0DiMMY9uvzhgQAY0ICKYoMb7FQ2TBHzKHEecT+L7oQjdK22z8ftM?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qSkKpVAWWjoXcUa16dP880AR6/s6JKW6+6+IJZ6phs3yrqUi9mTESNNf25BiLlr1sHoCXODs4BnS2E9mn/BC0hRGl47yPdCR0FXKmG/+VrXCeUn//K+X5hGQx7gfInDi529kqvjoa0oyyNlskIJf4KLGBIQnmN9r6doNs8AFfiiT4IjJIrvzMJsAtniASHOrG4M7MbgKz2RTsK2jMt97ugnPMKLN168wwt+aH3IzhHhBemVixrN8C/Tir/hrNSg92tQv9sVeKiEb8wP5GZ7tXCKQRCvM63ndHXwB6zuN0+ESLJWQfg98lvuWRtVNtnJpTdGPkeH/GhhyNF4lWRJZHXYAsB3hd76vOnoGtFHB4C932dE/TZEmehOUA9/seX5GQr6t0l8GUFJ10Km3qUa2J5nPBedM08BalCGzqmyQSyTAyU2nFt5MjIF262O1z6TJxMqk/EdbdOhN0hjI/3s1moKizbfKvPEpmqYFxjNiU1MgUQAYWyCiVKeAIMoiy5DuRJLjh/yNrhAS50USP4csKRyUvr23KdgliFfNZ29Fqh0wf6G7je2UWSonzAVQO+XPZu9OZzkzVW66PloD6YwTLB6opoBJ/IfX08X44bDN09CmmUg8dDoNrBvlF/yJ3m6kBNaPp7vEdzmYxoeVKyjUOPRLYxtjZSUUb9ZJEvEPWGvkdFmR9EyVU8+47s9H4C7TxWsYFAzFtYj8MgROd/etma8spGTd4gyoZBCLTj1x+RMNaqNiM0rbntKvEkDUn+IdfXyGoAhHl1BJtM+Tb4YpOA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f97eca7-16ce-40a3-6018-08dbbf8538ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:11:50.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YFybo7E182BxxogoeWhzk9v/5Qv4nSKYDHM4RZ9u3GFdLkXMEiOBQGiuQ5RZ6L6h03vAKFKFHUyU9Bqa3LXN45L93Tt5RHyVvkX0xugSNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270153
X-Proofpoint-ORIG-GUID: sIF236mdkt23vnQoH1gnRE4Jf6wcOvX2
X-Proofpoint-GUID: sIF236mdkt23vnQoH1gnRE4Jf6wcOvX2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111155_170680_C5933E9B 
X-CRM114-Status: GOOD (  26.33  )
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

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs and memory
in the system, must also be updated, else the resulting vmcore is
inaccurate (eg. missing either CPU context or memory regions).

The current solution utilizes udev (eg. RHEL /usr/lib/udev/rules.d/
98-kexec.rules) to initiate an unload-then-reload of the *entire* kdump
image (eg. kernel, initrd, boot_params, purgatory and elfcorehdr) by
the userspace kexec utility. This occurrs just so the elfcorehdr can
be updated with the latest list of CPUs and memory regions. In a
previous post I have outlined the significant performance problems
related to offloading this activity to userspace.

With the Linux kernel 6.6 commit below, the kernel now has the ability
to directly modify the elfcorehdr, eliminating the need to
unload-then-reload the entire kdump image when CPU or memory is hot
un/plugged or on/offlined.

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6
8b4b6f307d155475cce541f2aee938032ed22e

This kexec-tools patch series is for supporting hotplug with the
kexec_load() syscall; the kernel directly supports hotplug for the
kexec_file_load() syscall, requiring no userspace help.

There are two basic obstacles/requirements for the kexec-tools to
overcome in order to support kernel hotplug rewriting of the
elfcorehdr.

First, the buffer containing the elfcorehdr must be excluded from the
purgatory checksum/digest, which is computed at load time. Otherwise
kernel run-time changes to the elfcorehdr, as a result of hot un/plug,
would result in the checksum failing (specifically in purgatory at
panic kernel boot time), and kdump capture kernel failing to start.
To let the kernel know it is okay to modify the elfcorehdr, kexec
sets the KEXEC_UPDATE_ELFCOREHDR flag.

NOTE: The kernel specifically does *NOT* attempt to recompute the
checksum/digest as that would ultimately require patching the in-
memory purgatory image with the updated checksum. As that purgatory
image is already fully linked, it is binary blob containing no ELF
information which would allow it to be re-linked or patched. Thus
excluding the elfcorehdr from the checksum/digests avoids all these
problems.

Second, the size of the elfcorehdr buffer must be large enough
to accomodate growth of the number of CPUs and/or memory regions.

To satisfy the first requirement, this patch series introduces the
--hotplug option to indicate to kexec-tools that kexec should exclude
the elfcorehdr buffer from the purgatory checksum/digest calculation
and set the KEXEC_UPDATE_ELFCOREHDR flag.

To satisfy the second requirement, the size is obtained from the
/sys/kernel/crash_elfcorehdr_size node (new with the kernel series
cited above).

To use this feature with kexec_load() syscall, invoke kexec with:

 kexec -c --hotplug ...

Thanks!
eric

---
v3: 27sep2023
 - Cite the merged Linux 6.6 commit that supports crash hotplug.
 - Removed the --elfcorehdrsz option, instead using the the
   /sys/kernel/crash_elfcorehdr_size node from the new kernel
   crash hotplug feature.

v2: 3may2023
 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html
 - Setting KEXEC_UPDATE_ELFCOREHDR flag
 - Utilizing /sys/kernel/crash_elfcorehdr_size info.

v1: 20oct2022
 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
 - Initial patch series

RFC:
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 s/vmcoreinfo/elfcorehdr/g
---


Eric DeVolder (6):
  kexec: define KEXEC_UPDATE_ELFCOREHDR
  crashdump: introduce the hotplug command line options
  crashdump: setup general hotplug support
  crashdump: exclude elfcorehdr segment from digest for hotplug
  crashdump/x86: identify elfcorehdr segment for hotplug
  crashdump/x86: set the elfcorehdr segment size for hotplug

 kexec/arch/i386/crashdump-x86.c | 11 +++++++++++
 kexec/kexec-syscall.h           |  1 +
 kexec/kexec.8                   |  6 ++++++
 kexec/kexec.c                   | 32 ++++++++++++++++++++++++++++++++
 kexec/kexec.h                   |  8 +++++++-
 5 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
