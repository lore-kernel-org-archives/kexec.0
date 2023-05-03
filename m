Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DEDC7EE25
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LgMc1QRZKCXUL8DO91TNSQ+r0E0X7s79VzWUplh6SdE=; b=qwRuxOCirATEDb
	TJ8m9WI/Y+vAalC3TdJIoKEYbId+F2+PKc4mJg0QgUOheV8Fo5dpNHc/B3k6Zc0osXKbO94u9ulrD
	km618v5pTAHN50LObh7A5oFzFsb02GxijXhPcvJLnl3568fnAvqQnwlcElRYJwbkU6p2RD5RKs95/
	kcWOqRKAnw4tXxPm6dhxYCN9Dwhr2l8EuelZ7Dg8PalvA/9NW9/iXE7OOS4GlAqMU1WOQ4c5+kC+S
	mwBDGov3wx7cRYalmI8dKmG/6rkfFbiLTU9J9s7OdmgwWYT23yrAUZ606wEGpbQBBmabNfXX5F2Wn
	HPO9GmPAdjZ9x6G3eODg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm0-005xJ5-2A;
	Wed, 03 May 2023 22:16:32 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlu-005xGg-1x
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:30 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HolDG024371
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=aVX+mmZ+zpc//Pus46m0/n9EpEBHLNuCgalyx5P8AG4=;
 b=hM1J52JA8EZVx4GjHPvXFp3BjnqkqIpCWWTeVC3J4dHxLTZu3jMqzkhFtSigqREv3X+R
 6IBmXz7hFwjq9aWwsc2FgV59jd4n5zQ0c1mJjl1Q1//dgWabkP1ACNh1Nuh57ThzF+c6
 cxdAurRavozYwr4MWpaKxkkbs+5sjJJVsn+0NV0p7jJjAwL1F2cabWz+QlRM82MrUZnq
 4oZ3+MNuWoLz5Jow+bJTQtGBao2usP/kbHpTF53vC6sHd4Tt1FUU+U/GtNssR6CvG4vF
 wGLefAsJO2JKTtjct2QROMzN6yrY8uCXz+wp5EoDSKqPqcy7OgVLFg0lb7Wzw1nOP1zS Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1rh7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LA5lu027419
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spe0gv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFwzgMhh8FdpHJsPTdqE+xCfyywhuJt3RG7YCbfCh1VthIJ4/OH1YUlQUWZGmqQruJx9451Zb6dm40xoaKeBTAQbW63uy7jgwVSope7ZIO2n5nnZWaaVi39S5DKMox9pxIU3EnHANzE0hYc8FVdmxiKkDHJpz+OB3+258rAGL+AJjEkV6lP9Hi4DyGBa5N1Yc4qM/jkhTGRfTBXfDZGFSeFImauQrBixn6PpJ3e6HcZH+4yB6UwS2apuMcMRu3XZyKzft3phWUhEINj14iOzK4ds6oWbG+IdAZ/ujMtUiHfZVGgN7F5Mvkpn1NGIrH0WAnvWqW9y4YFx1WmGBk0A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVX+mmZ+zpc//Pus46m0/n9EpEBHLNuCgalyx5P8AG4=;
 b=jAi7HrZAk4TY74uVO1ykDSVMSTKC1HNVz+MDeFL++3e3EcgvldGcFoupq28OSd+IxFD5nB/Ew9ODtCUjvNWL3gLVJ2jz52XzF43E4IbHVm2hnuXmJsqdzZPKZdeg8VSkhfF3XWaHC1eHm6YK6g0Bll1KCk7l42mKOwgeqIknBva4gZNmF/IUTwdanf9xmRv3Z3OgOuqxGrTBqrUH4Zh8HVD9+qZPcYhK+Lfu0uZ2G/rvyePNzvRbqbzUtFSRnz0a/W+zLxF0SBU7gCI+6jQZa6Xav1f4rlvyQXbIBwTkWh73eAduASKjJrKchhBbDEHE2VrpS3LkOXwzx2yYJUY/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVX+mmZ+zpc//Pus46m0/n9EpEBHLNuCgalyx5P8AG4=;
 b=HO0z1c5FpU2rl5i0efLo/oX5v9PSdZ/qka1P8m1dEzkcMw43Jz3kYR6+IaGrr4UeB0YHZNZU9bF2nSsYQJ3X4+3MxOmZ8McvD14dPoKweTD35Wr/tHtii0bQRj698l+JwnAumMz5BFXj9u4B3BCDipZSFLbGRXxtpuclLiicui0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:17 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 0/6] crashdump: Kernel handling of CPU and memory hot un/plug
Date: Wed,  3 May 2023 18:16:05 -0400
Message-Id: <20230503221611.2119-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: SA9PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:806:a7::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: d77366f8-5fa9-46f2-4616-08db4c2403dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Pb+mPni/qtHYv4lUkOq1K40ik0Ul7k0lYq+wgtf7+88M/ArHJL/gOp0Qralk4XJC1wAmVWiTDnvCVQ1YGc8BuOALSzZVgepuOcFz0xJWpjgdGzAqSqIH+BxoggeRTM9R62hMMBmdIF6wv6C8OYthRJfA6MCOks68Q94hUgq7NSJlnKk5LsJBy9sL0tfovi6heGVeA4NLf5NzPSbqPuEy/k3ufNicXN9VkxICPDrm6Nf07BtF3Rk8EvNwfGAkcCqG3l+S9nZYurICM7PFGv/rYNMo9fu3OU9xIENiEv/8o98OPbYPRsbqs6fakJf0QrJ0UaqLgpZALs9vRwp2s3FMoY2xhWAucVDRcRgTfA9OZkN4Rm/mhFKIuJ/8pOg1NLoLmG2DVxQfz2nai2rTO16KUuEwTMRXn7EVcf6cvIwyP2QPEd8H7Cc+N1uVMtyGJIzRI0emi7pbRytkTSNbmtb7Bc9gExSy8PBznJUEHEUWFEvrSG0Ctgplri28BnHhv8MBQLZLjvKE6FkMH6wn5fsoWfHX4bu7S8qnmrMYY8QSkB0U9axQq71HvIJPXCG+CBUW5hyjlTY0aSw6dylH9uEYXg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(966005)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?0zdJTdS8oOKF9L0XFlCo1htOaI4+y70f2MvMja9959GjbdD+YADCYGbvXxc/?=
 =?us-ascii?Q?xMUmwA/bRoDbLJg7HUJxex7gGB95X4ofeShQ2/D9k2XZ4notxXSue3f5aTaG?=
 =?us-ascii?Q?WgggE3VMyM+70OyCJGOelau3zTk1jzAa6YWFzgKsXrhgAp2t0qZjfFAKYYgc?=
 =?us-ascii?Q?tvXsl9mKf7hr0UGvV4J0pkDWzRrRFnTPMhPqi7+x7Om+vOj4ax+Rko12YmjE?=
 =?us-ascii?Q?G79a6UAK7T93fcvB1hlAfsMAobbjWmp3fx5ZeFf86o0wYZZ3rEO+LJ07Yh0d?=
 =?us-ascii?Q?wEGJtyL0t3+1Ze79t2tgWWbd6feHSSS1T1QLqC5lhj5/Jv33exXQ0LJeildL?=
 =?us-ascii?Q?K8IxfhyNY4UWuGV9Ud9WWL5aJapcND+R5CEyAuEN80mOS1ErgHD2FiY/DqHL?=
 =?us-ascii?Q?k3NwqO0GmHGxWTPjMUMsPRZlQTVtlY3arRAtN91OYSC67QVz0fU3dtLuttTt?=
 =?us-ascii?Q?JSN3BZDYBpd+EXUt4iI0RH4jZzR9tRxqHl2eS7gNndxqN0IR7M3ziPTIfo4e?=
 =?us-ascii?Q?hKk6J+IOv3h3MT+UtTx1tT9qq+dEreiUhPvXEzCeW3BzvWZmwKB7vK1q7cYH?=
 =?us-ascii?Q?rzhVCHESR6d3L4FWigCE8Lzq8OojacKHhNOk5irnirENUwH893nPlCJV4RQ8?=
 =?us-ascii?Q?PGnq4yRTQXFm5ZrpjA7ciMGXMkyurFVdsbNjdP45IUdqiaVsTI1VozxVVXFE?=
 =?us-ascii?Q?fuoiuUp2aIgF+R1BUbLR6ChGIJcxgN30wHvPnqlWCtaxRWmiwirohULcfl6o?=
 =?us-ascii?Q?1Q/UgXE8dtC200NXrxIUzJ81kELj8704uSvq2fJvsU6ADG5AEYn4unZWqRw7?=
 =?us-ascii?Q?uXTa6YUyXNVtB1Cyu3EkBfU6z49hqZ+Pcd2zLvXxXHJ0H7aWM3bkGNxPEDIa?=
 =?us-ascii?Q?6YnHUTPdN58MErThAbZt2aYwGuwM07cRpKEi7JJLxk117NyCMv1ODRIQ2aFs?=
 =?us-ascii?Q?Mk3I/sI78mOD1k2mSgHhIGYUe6PRPjtkD/oTHfHVL8TdiM53OlMg9PGG+Bn5?=
 =?us-ascii?Q?UacsNlOug1J64hNFtorJykbfqmZLGvPfWfjT6grDq+F730yuYsC8RLij01Ig?=
 =?us-ascii?Q?QWwoEcjZo5Miz3OmLOxpGjHNuAzvIinxLJ/pX57x+daKGpL6YQuweZFMqZNN?=
 =?us-ascii?Q?1tGbRS1Eb0bEW7iffg2+hFPHoTkTbtPrGDBkIJZMAfHsj+n3nqwSJPq4Ylmm?=
 =?us-ascii?Q?0pb+B66dVtOIyA/8g82Ptu2yjkvg2mdIQ9GiQInaQ+CG9Ke4G/fSPAQluNd2?=
 =?us-ascii?Q?b5QZkl2Rz9k4L/fMyGIQmUzWj+l8tXUYf5HrvmOELRy9NuFXrjI+O+n7hPjF?=
 =?us-ascii?Q?v6wk/+ioDExV7AlTamT8jWbcEdgAQrgi+5xZ57AXmRIZkgHEVnIio3itsXnQ?=
 =?us-ascii?Q?DQd/gqPcwZ6Eh2pA8EeoU4m0lTV+K+r02KtO7uDmoknEfofBWZgKfok20BSE?=
 =?us-ascii?Q?JNfe34L4RkcHdWt0uK6a1o06IyYHqMBwZcFixrevdN/7fbT1NWrGNjaFRrRJ?=
 =?us-ascii?Q?Lntpz+FzB5gXbQQC9TMx5XWD4xlET+zOXyUzOpLehJpjkjtUchw19pLHnYXR?=
 =?us-ascii?Q?OuTz2OR+Tac328kbNkZ1xNjRVdwJtwDGVhGRNE4r5zmBoG/i2Xw+L6q2tXD9?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	VOzHUqNY2M5/ojJCkKxyuIDGz3fDg4ixxQPGt1CXIfMSilyroyKycoMXTbqFc3XkgxYASCUPiSl6RI0BmhbpqzDnJs6WfnyaiyI5W4vD4KjGUefwS2AD4dMF682sRogkX2W+4yALi6VEagv8Wykg4Kt7wTD9mafoPSBEqzuxR4H6onN0XwD7Zf2kNekHsTXFUSNMw/hk/m/TmrogIzv/S4FISkIZCLqw1iyFB8X1VaHO+HiUxL2bDdNGFMwmEhaHO5+eUZh2niH0dKQFePSU2QHSQ0cGBviYgtV7LDGnscUwgkAfyfqjjGALjPDnwkLkfP2gSC/7TnhbzDjH2csXyHLiq4n7neUQK7vI+nRFIPjYxQ8mBBKOmDLME9HMUJhW/TBxSqdpOki2436LixWvwqF8z7HNGerknQNbsVxAG15JtjRksY1UK5UB1gdpFyKpwVw54Tq0k6g7W33eCun2orW4XhqVWf4bwA1GjsASpn/QSUMTE9NKJyyn3Av76ZovTkXDW9EZsK/kzRJ4FSdhy0jjWxVxUxUGm0E1eLGFI2+VOIfdZvSGAfKI8ZilAQMpJJRdM+no2XxU48EYqU9JEz/7auBtYOOo8cCFAbB9JSq2lFrb8QjFs5Uk/Vt75ub+ME9+sJFrAVnDHkGtuSm6pu/OhbwAC2SjfDv0pVC5wXSYnK7+KdUN40EHvDdk77pEmI4fLBhWvTDRf222VAE/ynJobU4AQ9Z2WW9nTFPBB8aihf9GMmK5TGy4gvskJOfrouLi+uSalDhKkF2BjIBghg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77366f8-5fa9-46f2-4616-08db4c2403dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:17.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3lXNQ1/U7onrLIQPZwu7ivb71/wB0fRw4l3OHz1goh+MM6k81kXmDHKwIFqHlIvHJjdNLzt1qc4N0lwAMuwPrTOKalTrRqv/heE5XiWMgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030191
X-Proofpoint-GUID: weyXRW9OWJntZFxJjtm2mdIXZbOHpHzh
X-Proofpoint-ORIG-GUID: weyXRW9OWJntZFxJjtm2mdIXZbOHpHzh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151627_505906_F3128DE3 
X-CRM114-Status: GOOD (  32.51  )
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

The current solution (eg. RHEL /usr/lib/udev/rules.d/98-kexec.rules)
utilizes udev to initiate an unload-then-reload of the *entire* kdump
image (eg. kernel, initrd, boot_params, purgatory and elfcorehdr) by
the userspace kexec utility. In a previous kernel patch post I have
outlined the significant performance problems related to offloading
this activity to userspace.

As such, I've been working to provide the ability for the Linux kernel
to directly modify the elfcorehdr in response to hotplug changes.

 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/

The series listed above is v21, and the v22 contains changes that
work in concert with the v2 changes cited within. (I'm posting the
kexec-tools changes first so I can reference them in the kernel v22
posting.)

I believe this work to be nearing the finish line. As such, I'd like
to start posting the kexec-tools userspace changes for review in order
to minimize the time to adoption.

This kexec-tools patch series is for supporting the kexec_load
syscall only. The kernel patch series cited above is self-contained
for the kexec_file_load syscall, requiring no userspace help.

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
(proposed in the kernel series above)
/sys/kernel/crash_elfcorehdr_size node, or it can be specified
manually with new --elfcorehdrsz= option.

I am intentionally posting this series before the kernel changes
have been merged. I'm hoping to facilitate discussion as to how
kexec-tools wants to handle the soon-to-be new kernel feature.

Discussion items:

- It is worth noting, that deploying kexec-tools, with this series
  included, on kernels that do NOT have the kernel hotplug series
  cited above, is safe to do. The result of running a kernel without
  hotplug elfcorehdr support with kexec-tools and the --hotplug option
  simply removes the elfcorehdr buffer from the digest. This does not
  prevent kdump from operating; the only risk being a slight chance of
  corruption of the elfcorehdr, as it now not covered by the checksum.
  Using the --elfcorehdrsz option on a kernel without hotplug
  elfcorehdr support simply results in a possibly oversized buffer for
  the elfcorehdr, there is no harm in that.

- While I currently have the --hotplug as an option, the option could
  be eliminated (or reversed polarity) it would be safe to *always*
  omit the elfcorehdr from the checksum/digest for purgatory.
  If this were the case, then distros would not have to make any
  changes to kdump scripts to pass the --hotplug option. Then, when
  their kernel does include the kernel patch series cited above,
  kdump and hotplug would "just work".

- I'm unsure if these options should be kept as common/global
  kexec options, or moved to arch options.

- I'm only showing x86 support (and testing) at this time, but
  it would be straight forward to provide similar support for the
  other architectures in a future patch revision.

Thanks!
eric

---
v2: 3may2023
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
  crashdump: setup hotplug support
  crashdump: exclude elfcorehdr segment from digest for hotplug
  crashdump/x86: identify elfcorehdr segment for hotplug
  crashdump/x86: set the elfcorehdr segment size for hotplug

 kexec/arch/i386/crashdump-x86.c |  8 ++++++
 kexec/kexec-syscall.h           |  1 +
 kexec/kexec.c                   | 45 +++++++++++++++++++++++++++++++++
 kexec/kexec.h                   | 10 +++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
