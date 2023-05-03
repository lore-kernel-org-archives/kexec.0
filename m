Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C36C77B75
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Th4vUQeRj+Z0UtNZLxtQ+EbWGXPTm/Efp/yhh6QEuYk=; b=bMNb2qWY3oG43U
	bZhKixClSIBqTwI2w5Fy/aC964TzP91YZF9ZD1owIIQxBM666KedWeoPoLU9QkGJgX/V3/Jvx2fSa
	cVx3p/fiMMA7k2mMHyYoUZ28KhjZsaWNwbwS2Lni43SK11wF+18DI7u/ieQ81G6diLTTKcX6gKYaB
	9das43n5o2F1O4o6AkX6uaeyaQuR8XA1rdZfBkRB5hRNR1TXh8n1PNepQFlBL+j8F6OaEw7Mcni7a
	IrzpAXPA0UIQrpinuW+LLXR+aUucdnhd4HP1409v9ZiyWtztMQ1UX4RkBpmT5jjaIUxlJXdfOn3c5
	3udWhA4bXbO3s94fO2Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm1-005xJK-0c;
	Wed, 03 May 2023 22:16:33 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlx-005xHn-1X
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:30 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HorFJ003650
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=11veehZArtnE9obRcneUW0xrNr1s4Fwc086yGm/sufw=;
 b=yAGgYDssRj4BuJdFnK+ziXU0phyhRVAHQP8N9sJZJpeVxv1bGdvQSnovwwGoxJR6OXxP
 Bn5B27Gc45aYoclvax7XPmTtRZYIpU2F+5+nV8VXdqh+eTSEs/ZLzuCO5CPFwTshEu3n
 81xR5pY+soIukFN9OaC4Jk2/JwEWsNz5rzkuQdIynPvh1iSiAmPD4GLRwycEGlzb1Jvu
 WOSIwxT5Ukyhfh5QB/NSugGK8jgL/qzHvTtVIWpkmYe93WJ5jWhF0kUgwO9eAOlq+7Ib
 +Ws0frkVbrliVKSm/GT1UGWmVnqOfzT2p2Fg49XI0pdyr0gJjeAFzDm+VjSukmQINuFi Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d0n7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343Lg7Ub020736
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7q5mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BchQs15OTPsstfQ94xG0/7h9TtajQRNsrdjcohcdJMEiZkbEbV/YQJGWzeM0WqABD1nUlGpVN15+p74/QeM2XU8ISW4QZCsuqOUnom1VX0VNN0pGiyYFXWNRD4N692I5tLFCCDKlt0uBDcJKQcQRT4xXCvhRjJvVF+Mwl8CXBGWGag6cgttJX6PcWVX+RGZCLB7PkoVDqsS7ZYvrl5ZLSnL98KYvjvzQel03faRWHstSQKuy/yMVNcZJAzEB+mT1dAnGLkhMPWE7vdlP8jmRFvCtY7fXUWXSJTZrhOPT/3H9esduNWoR9+QDebY/X4WR9wHobg7WqAI6Dwhs03fJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11veehZArtnE9obRcneUW0xrNr1s4Fwc086yGm/sufw=;
 b=DSrJ2E9m/rU8rwwWCXqYDirMGULnYiKDK3f2EOdKCUyG2HUkW6mlOSWgX+/PjiQBZDp4JfJKoreApkdEG7Fkd69C1Y8kjjFBeLdjzOZ6aSYTKBHxJOTr/Odo8PnqRsLu0vxPpFNve1oiHsizxl/QY0jsCNltZdJmlnpw4GY7Q6Ti1bksfY3zbHpXd8suEEukGad7of//zvx9iky0bh9u6v5TnYFq2fgVgQsgpEiPlD8W0lgb4Locm9Aq7zNWbNAh5ce2iw/8dxVqCPNSUWLe3C/pMBc444Q/g8dK4Al8IJvy1SoOT2Y1kpW1lElcCqc2Prk9UYReHmVIDnntl9iFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11veehZArtnE9obRcneUW0xrNr1s4Fwc086yGm/sufw=;
 b=REoo9wWRCibKdBRwogVfQ0BpboDvHz459Equug7sTNhL7cVsdBe1bhl2KEAZ0pOPaOv57lhMSpkIazlF6CmG6458u5jw0AP9Jm0x+lwj4udh3LQLH6NQcME1Skv9uCTnB9G2tLtJ2Z+SwfIpb1O2vR74Pvpc5NHxJoA5pdsiHvI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:25 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 3/6] crashdump: setup hotplug support
Date: Wed,  3 May 2023 18:16:08 -0400
Message-Id: <20230503221611.2119-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SA9PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:806:23::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ee1ba7-ee49-4da0-33eb-08db4c2408b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3uIoIiLTwe4EwppqXQe1k+lJbplURd3J0hSPeSOujykieN1jDk8jxb9SJSQj2M/ZSvt0FrHCl2n4dbfBSF7OUNzF7DEJtyW0C0sNqqlC13KogBRNboTkffFt0Fuc1B+7aUIyC3GQfgIyd9L/JyhHRC6srPIhcVxmbdilsl5UJkaBcyfKzfkJbvRHpzE50TMgvUM7oo2Sa2sKT7/A6AmGy1Yy9bbnMCKuvmWRa5o1lEtNbdW0h0BsbnrnlQ8KeNaQorxCe/KMq2QqFolp+TlKfMv2U3nqkO4QecUXkq45qfsYm70QPKZDia4kMIkhY7UY3UWNCak0Xo5TOygPwwPdR3HbFSIZDlWWfHcmoxxYRGmbo/XLFnHCqnGC4QTNTrfCnkmDVIn6qWfVRW1wK6IOdM4LWZH09bA94cjt1cpSSwrVjstLhP9eUMgcDgGEHU9Cwm3IwBa61p0GTARLTZ+P+daHvLuLKwXkGFHaKUfM724eEi7vOunfB2qScf+gJRDFVvrfSbMAkNxmOd023h5F7nexMBXjTHZtus1cYMKWer38RkOxIErX0Gs662/JIlIQ
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?XhPtU6uOkXBYHIp31EBF1aNDriXahAinkQEh5KFodf1LNm/M8GujCp+m1Lbn?=
 =?us-ascii?Q?nWyGSyBbf9tjExAg0bVrEahcXBh5vhoLmCpxBZwVGZqvX0Ga9N4dJe/paHo4?=
 =?us-ascii?Q?03Q14u6OfxkJAEuHHIO5t00l3TdED0OvY+lHY2Q8pLTuOo7+jw31FrtX9KXN?=
 =?us-ascii?Q?3UzIMOnBVHX6mKkPejCSYOkGSGDIxpphg6QAt50jy7mq9ssIC9lP6wFJxIQG?=
 =?us-ascii?Q?e2lnPo9ohzFWitRWd7/nE1FezlOypyuZ5ZOq10SwSEVI92gkck4zhCxM5GDW?=
 =?us-ascii?Q?apwV/iklkMSWYlIF/YUtDd8tf0Fx2fEfPNdDVa9/1LJDComGCnxw9sKiwBez?=
 =?us-ascii?Q?r0RpGNlNuOuA97Tay6wMz3gXV99POMEmy5WfIDo884pUd2jcurw2g/UvhTkL?=
 =?us-ascii?Q?kLv48o6PrTBSAl3KwinhwUDEOmhUS4YiWLsgvPjc75TXXwXFcIO+XVHbAwA7?=
 =?us-ascii?Q?eAXcNIQM3Z+q9xjhyyEYYTAX4HIxOlEBnlDIfu0Az6+OIuJlI+Czw5HCdDJF?=
 =?us-ascii?Q?xkW9o5SItUucbG8MixpU+NP+ceKjKFWufFbKz0KXEs7Nd0hF1NV0uMLf9HHM?=
 =?us-ascii?Q?UA/mRx9fSbNL3uJFsAGnXvY14z1hzIgqW4tgVUDL/CrVGMCnNO3WZPx9qW4W?=
 =?us-ascii?Q?p/vYe6pI3I3njxQGhmkaL87sEmeFPfTYtbn6Lb+K2DVCzFIqP9l8PisDctkb?=
 =?us-ascii?Q?8AH7tpeAtDeOp1PHc3kTRb9DpFDPe/MDZkN0+/z1HGUo74/MxzqSql8ZFDyI?=
 =?us-ascii?Q?poIhTuZ+yTmlrBEOOpx3K66iq45+yAttN9SUy3k9VYAWD8GiXvYGvNasIW6J?=
 =?us-ascii?Q?/Dr36kOv/YUg6Q8gh+7F0TYEngCrkR+vCsQycPSK8S30+WTuesFlB6019+6K?=
 =?us-ascii?Q?tNXVjoDNA2DxFQ0Ok1Y0Vu9coN6LBrR3OnqjT0LBSKkShJ+bfUurCQBkcMlX?=
 =?us-ascii?Q?Xolcd1DOiTOmTSnS1EgvaWWIaUXsqsP0IuiwmF+5ntDp24ZnvRCAYFAM1WWu?=
 =?us-ascii?Q?Ztr3KpDyBqWZQTNNGJssxbSoseqyNeZ4Nd/dhC/dO7VieV8q7IqkmMMN3vaI?=
 =?us-ascii?Q?lgL/jXT5mTvA6MVtgpZO9uMH3GYKagQHt/zsT/MqNPgkkiPU2zmeeuZUvauU?=
 =?us-ascii?Q?MqTfyiToRiAsgH8dpWH5rf8e+VX4cGqMTd/SEz2+DFustnvCvqevKpu3w9Ch?=
 =?us-ascii?Q?DFxF2P8wik8ddJsdYj9XFegjmoIq2pyof5hFbWpub9DM9FzHJrIl86fzKqIb?=
 =?us-ascii?Q?nx+GnfZ/GuuCDKKUAWu1kbKCRC5tQhWNcmDlkkQL1OCVAdAfXhv/EMR/a1up?=
 =?us-ascii?Q?5Xosh5UE/2ZH8KRlQFgJ1CYneXJkTxNATczOLGvNkuT2BZCPhQJyna1RwZLE?=
 =?us-ascii?Q?6RyNlkdBYY/HBYii7N18gTbuaTt4KJrv2+4cKf9sN3hvZpvh44CXnvu9B4we?=
 =?us-ascii?Q?Wy6z6X53Gjd7pV/a9lxbT6LZIOL9PWE0/H97J390rWtUo9izX8QtfChl1IHM?=
 =?us-ascii?Q?cyvFGhp/qWLxiI8f8XWxBTwRVV5u18W2aibtnUZDDtdoEKFDX6hRJYfZAXkT?=
 =?us-ascii?Q?ZDi5z+4oUbLATBrzeuN44pPZwZUkgtBQOsh7KtQrBj7VFoC8cOG/PCORnGYb?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	g+xKUEqaxy16cmbgyu8TAiaowbb2W0TzYacVHTaprAMRbZi4zHB9cxlC42TXzJLBct44/mdreVULtEx+J+vBqJFrvm0Uta/uwA/zGnfjghDCGJYcTnDPiVF4PPecrb6/U+MCgKOIo4rwt6Zyz7JdTSsSZMlJ5tVb4EZQ/bGWEgbhtMfC2mXNKfxbDNmZUbvDlkmJuAeYEQ722y9ov5wxdyYgby+37cvFLjGv3K/1ihQiM7KVZ0Y7lDOZJbnnlwlG0zMC1+w0kW22++kPxXW4PcxcAR5oSnTDGI5DAh11Nt+OrBNBC+sSRsXBSb2tsoA+TLp9Qm4k2AwmO3ezWwUPpimb367aSnnjyEHQpI7vJAX4yZde3D6rOUUafesgAl8AyfSq2msZUJkOAmp9ZpLc//0Zq2A54WZvosOtSNJWj+9hXPU/Oap2q9z7pCz2kNDBGMFKuHw6DHPL8ADUFB0E+OG5HSjD1i/tyW0vj1H3FwvtqPGT6rm7lH3syxMz2oHf/apQqtKODYExyEwdCABKyVdFNF1wHx2fsCPdhENJVMykuUD5JBvnNas0iPgwwYDhdB9bMxHWnPlOBcYJEv0FM0PU3WqO3Aky2Xodug7tUgwKltMAuaK53YX7YdMBTat1nd+6nIMFu3trRqCiEit0RY1teoiotVqxU+bntFedBVuBb/mei0fBcqZoPzdUaT/JjXmw4Zzvwk6oxFhfTBDMHX4Scl6VQiB3+VBoBktVXH4KCt5UyNAmEzoBQnr5T7D3SywMZorn8GCJTKkVbg9q9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ee1ba7-ee49-4da0-33eb-08db4c2408b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:25.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAOLqV++XkK9B1fk3Fuq8v0EFakZo4MxthBfx977AY3k0wzHeR0YdHvmtA+duCk3bApvZSndi3hlLF3J/vNU7yV6Njueddiiv+j6ivTg1jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030191
X-Proofpoint-GUID: KJmB2SFRwuSySehVCX2GMveziwvbFyxa
X-Proofpoint-ORIG-GUID: KJmB2SFRwuSySehVCX2GMveziwvbFyxa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151629_632908_2E0A4DD8 
X-CRM114-Status: GOOD (  22.22  )
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

To allow direct modification of the elfcorehdr by the kernel, in
response to CPU and memory hot un/plug and/or online/offline events,
the buffer containing the:
 - elfcorehdr must be excluded from the purgatory checksum/digest
   (see "crashdump: exclude elfcorehdr segment from digest for
   hotplug")
 - the elfcorehdr segment must be large enough, and
 - the kernel must be permitted to modify the elfcorehdr

For hotplug, the size of the elfcorehdr segment is obtained from the
kernel, or from the command line option.

The KEXEC_UPDATE_ELFCOREHDR flag indicates to the kernel that it can
make direct modifications to the elfcorehdr.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 4a64e53..c59e795 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1626,6 +1626,28 @@ int main(int argc, char *argv[])
 		die("--load-live-update can only be used with xen\n");
 	}
 
+    /* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
+	if (do_hotplug) {
+		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
+		if (!elfcorehdrsz) {
+			unsigned long ul;
+			char *buf;
+			off_t nread = 0;
+			buf = slurp_file_len(ces, sizeof(buf)-1, &nread);
+			if (buf) {
+			    ul = strtoul(buf, NULL, 0);
+				elfcorehdrsz = ul;
+			}
+		}
+		if (!elfcorehdrsz) {
+			die("If path %s does not exist, must specify the\n"
+				"--elfcorehdrsz= option\n", ces);
+		}
+		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
+		/* Indicate to the kernel it is ok to modify the elfcorehdr */
+		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
+	}
+
 	fileind = optind;
 	/* Reset getopt for the next pass; called in other source modules */
 	opterr = 1;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
