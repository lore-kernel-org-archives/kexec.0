Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59444E82CBE
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gqbSKAWHnn9lqqhdiA4dMtJDjYCMckXoNink2TScV3Q=; b=yDWddsOkcmznkE
	w/4o8TZaX0EupIQ+wQ8Z1oASAx/nDdy4C0RJDj52WNrqFSum/QJshcf0lScdHC/9s7NejPrgHXsnD
	X3RwgwS2/sqYbbi/ECz2oVJXQ26JZb3YlFxeYajuRuWoyeFNXc0wKuIROJYDiYKFiOLc0RBddKYdf
	BJG6miMKHp3+BD0EL/loBhz9UPbcoYDbWuxKRz97baxjRFRa+T8qR0eoQ+GcHWkmq4mlI6v0SjngG
	39cwIXvcQhbmBjArWWrDkyFdwF9q5rM58jPmz29MBXIZU8B9z7bHf/bxcn2L5wGdPjS6DPsypnWDt
	upOAG6aeQqTyP3tsa96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0z-001Yb4-2t;
	Wed, 27 Sep 2023 18:12:01 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0x-001YaL-0t
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:00 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGuKur003121
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Au5MBYRKniE7rFNB3iMlwm0vdmHXJdbYM3JNRNDxFTQ=;
 b=mWFI37diJaSm2DN4UbB1ffIQ2XYKodphcrBEjbMdjedQI2jgV2SX5dmJDtw5UIZGlnj+
 S92BT/vyKNJvkeFmy6wVOAAN0wIcQWR7rDAo18UnEjDwfn4mbU2w5EJm3ATb6zAUwlhv
 WQSGt0JTk/AMcN89eIOv4PE56NUkTyo3+8KU5VluvZhoHrtqFnKeHpZoZUipX6s7/dNf
 VS0S9dLHUEWSPcoBkR5o1hYjMP8y2Q1uMDqO1WPuQvOB2kpc+aHMkXbW3Pu2y5A+lWqX
 FsSq7CP4U1h8dgwI4+xpPDAEn8aVs0q9LKWESyvksjXRoUTBu7ZqRqhV0Q+vH90Fh9/A 7w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbj626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHStLd021229
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8n55p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Xl+2ubKA+t1iXukMRhd1HdpTqqXCcIH6+3cfXKL3JIlrTEEmIueG+nO+HI/3zfpxRSvfeQ8utomx1fi6eaixlafOySpzUxZjp7GI8+6q5R+6MfhBUyC3Xap5VfVH92KfASRy4NnA8n89jRB0P7/T0dRFd2QY9oqg28ue5oltVSdmziyPZ/kOYc31W2VyAsnWpzXqZ1o13zxRV2CdgPIbmr0KznNPcTcZhCunW7xzabMqRrgDGVdQi9nsjpM8yJe8n7B5Tc/uSO0k5nacYQC3Sg+LHR81hlOPZJr6fmO0pmZ101N90BfqeB1svJjQvgv39+V4O4SA/adCk/0+egDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au5MBYRKniE7rFNB3iMlwm0vdmHXJdbYM3JNRNDxFTQ=;
 b=PlkPvhzoA8a6QpHqFTYqg2MXNyE+KltG8YkcTKk8YNXmWu5XESOISnuaTyXlbi8au2VmtwNeeu2ebPiG42LUbKDEdaWuTK9Xx9Ty6USG4OBwBuWAgp34gBLeQEpY1ycYPjfHfyA/wk69tXwe0JzPBJ9mbxl3yPA0O/BsO4f8AbF4bbLsH7oNC2On8GigdCC0jGbKzuKeOkU2VUmMpjiLkux2BR0PR6WI7oBYz/QuqsJKBDOB5Ht0oLyw5IFdCvG4T8GTF0TQ2mXf/YzcVbYRh6/ukyzb74ItZ2LRm+yuh6PPUiudW5OAL44dQJLdARKXZ5Tm8g047knSJDRbJPmafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au5MBYRKniE7rFNB3iMlwm0vdmHXJdbYM3JNRNDxFTQ=;
 b=pHXmh9f+yqzdqUJ1kUgkAYg9pWKLhdi595HSMfJfXVg948/32+xM/kSydTK+GsUIJPewEs4QwWJ5QlqaZKpEX1tcx86trRmBegWDudBdYcrQNp5jme7C71ZZQPs4ROJlR9M3UwenZJ9vrilurthd3sAj74S9BzlTMgvZaGgF/10=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:11:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:11:56 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 2/6] crashdump: introduce the hotplug command line options
Date: Wed, 27 Sep 2023 14:11:32 -0400
Message-Id: <20230927181136.2627-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 3624c01c-f963-4007-8269-08dbbf853c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzUp2sAdt8Feht9+F2ZWNT17ddffJ/+nwZx7HiGLq5cqtnqqB7BV1rUKLh9auumWCIyy5z9fJEOxoyy/aZxvRd6KVbSxgOfnmsTVkL2E5P+KCYOHt8ZV0OEIQHVGWtMp52DFWUZeLwytWu9bsUBrHq0YuAI+kA/9F6acfBs2W562fxk3twqY32RVCK1jSNhmIKJscgAY2sIM3a+ZoDdRtX6BAWYw3mmKY14t7c03YmZ1yVfH5vATeFHfGX2Bqr9Df8pkutAhdb+JbNcJYC4+Tgv28GCMw8D5YY27T0Jlcj81g2Zsc7/68I6LsCcCCSxNtShC8myuk9M53iUBUj4gN5vp0PWLuafuDmz8syhLSfUBfNVCGAdfElajFXL9eqTrJUvTwGrgLqszsKiNesh14sbJPemCWVgNe1PVRgsya+/xlXVCvfnXIaeCUFSqWJnCNz62QSXAllD4a8irmwCohgHBJP/dxzEOWF8r4Up/IYq0qLbCwdklfPlbNoRtRkTKx+KB186Cjn070MdxHTCRhgVuY1QplSYjwts7lu58npOANca/P4EpCJ8p6YOhkAJX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(6506007)(83380400001)(38100700002)(86362001)(1076003)(36756003)(2616005)(107886003)(26005)(2906002)(8936002)(8676002)(4326008)(66476007)(6916009)(66946007)(41300700001)(66556008)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z137n5DWRogEZSOObAzzR/r8pbgYzSe3kfohoX8RnXEPRnNybLV7pQZ9+zPX?=
 =?us-ascii?Q?d+xr3doVYDshUqaBk+7zMtjDMjFNsLCVw3nA/rXrUzDlohVhI/wkwad0yyyO?=
 =?us-ascii?Q?bl/LwdoMaYG7qjWBCc/z+LM5xDA0ZIDsvr8geLQLdD3MUWmyi591s6V3vMBU?=
 =?us-ascii?Q?xmCYsPJlkNm4/2K5gTKEnBkYdar02s5vfORmqwAZ4bx3duAXZfEscljJeREa?=
 =?us-ascii?Q?cAuNimVSEzuHt737X/6LKb/OICRie6Tjch0J2ofQCbue+QdpQ1Fk4tz/gz8y?=
 =?us-ascii?Q?LQGTdVAHuvRKBaMpHKlSJ92QUWegv+tO+MzZLyiIv6l8D8zn9E3X42vJnMeK?=
 =?us-ascii?Q?R8b9WQ51j4qCndr/IV3WZWLerR1LZUSx7ULBezpbMSXofo0OBsKofCVNQxal?=
 =?us-ascii?Q?oxRtNziwd4jDIodvNKiIHNsAbSNEnnL9V94v6wgAePnq0krx/2JGsRiuLS4y?=
 =?us-ascii?Q?iA+FnRWj2gUNriRNvrCNuJ5PFDzEMnh3QnEJ2OwDIcsWrF6SjGRpQXAVGKGK?=
 =?us-ascii?Q?TKGRLIQd8uFsqGLnj6qq7KyBPskdR46B3BjU0jKKOq0G6ph1WaoBkc/tt0x8?=
 =?us-ascii?Q?xuB49OG3d+r6vuqNJEtYKWRgVcPMi5xjkPKXP8SQRT3sDEKxX0N3pn+xAwZN?=
 =?us-ascii?Q?fDwiMr0H2mW1HwzbkYoZYSkWS6x2RLqPluXq9MlxgTgR/UI+PGFmiHcP8ONp?=
 =?us-ascii?Q?H1pLmrbaJoSYBud+ucJFDE9xBrahRCJuzMdwUAvWzqVyvCjxfrJichKd8mW4?=
 =?us-ascii?Q?U2IppUfLoymuNcnDrkbzaGgNH8Lh4QYa6dLXQkAVP9fFIgwL3xcdUt+K8dt3?=
 =?us-ascii?Q?T9UVjAxx+eFiUVHpGAQLM0XOpr+9Wi3OCm0lIG1qLnL+DEVgTvr67S+zXZ0D?=
 =?us-ascii?Q?H22GjRTluceTx9IrdPPnxxHcPjHih8Mj2JnNt19d0J5a7ctA2EvIw8sojUEf?=
 =?us-ascii?Q?dzki9ldH5nyhCEmm8UjhZr8ZSIHnlf+zdlIoXZUUYoc41OX4isJ0In/IlVCG?=
 =?us-ascii?Q?E349GkrgjrWhjwpdSaHcmd/+stfgmlRzm/YgEnMJGhTy3G4T5CBa77Dh69n2?=
 =?us-ascii?Q?URv+1F04vRejJ2JKxX7fo4+1Hoq4/zGeOhuvZZi4h9rkYhIkwtLrRdAEKfZs?=
 =?us-ascii?Q?im1e8wgiwbTh7roP5qX51b9r5odn+rPDoUgVEsmQ6BHqVWaIoCn0i8WdEUMn?=
 =?us-ascii?Q?N0O+zMSWf7ZddOEnZfEGERUQTnmPlf3f/sRj6saz3zdRFyHRSQb/eiJ4+FsK?=
 =?us-ascii?Q?CTyOPr5HMlshfDD68YvFDJaW42vGrMuGpb3mC3ZW4TwlI7If1QQZ4hokya9g?=
 =?us-ascii?Q?1zi85F1n2jSJKggJtO38Dg6mO8D/bHePJMYi+GpLVV9hi8ssJ+fbZ/JulDzk?=
 =?us-ascii?Q?2D5Et68QglyPv3xvkAA6ZaWgazhV/D/EV6vuFSbZGRu/19FLNlyO8cj/GTZf?=
 =?us-ascii?Q?KGb6fvRqvsrD/er10X7nNm5X2SIphinT6KyYJKWPcCyN0w+nLO+9Aw97RUUz?=
 =?us-ascii?Q?y/qhWFRbRMo3K29GzSyqMIxDX6B17UQMkf8DWNgtDRW8hVpgpk6FJI53GemT?=
 =?us-ascii?Q?G9JCnJhWEind/SVJmmDLoKQf98sn1OPbMNVV5EDFHVVVgC9IAk+mPXdQ9RtE?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VgSKBlo5UD4j6RqQ2eNd8Cv9IpPBRuXtC23G+Elsy+0gxJuzdrtWVYhcmPBbiWMuf3XX1zDQJlILJR821V254JZTD+89iMRpOnqK1WDLBTCZdQOafVS28rz/PCw8IRq+WiXTUW2GA/CqmSZnsDzvttr+q1sFqGSIG9bOO81BisXa9O/uYfXshCZ13TAJdpxxrg3+ojanWqN+1RoSWb6dV69QWccBTJGVolGf/1GMRn103WRR/sZ8KR+662u8k1ho2SKD9ZoNYzVdLpmOk4qKNzHvnfKbVmfW8G5gk/j+7T0zeDJ+iAnw7e6fh+HsC1j7Il176mhRYoU8gKvkhWBV1zxR6wyv8/5pvETFGwPeM+NHJ+i1yYYAKZ0wTDiAGv0t2ovVpzJanz3/+TMKdqL7i/ltBwfsynuB0nV12d93L8lnYsTHjZ7QXegMcfvjgb48Qqu/ANOdixqpNA/QCiFFhl42R4Tpfft8eKBYEJr/vf8f4QZr1WyTQEITEY5Llzz4fKN0KwjBgEF9k4rFwIXa5cORTdkWG5UF2cktYcBcVpzoHobWlNShdt5MHZpXZ2keL0bmOrf6WcDLQi+daBPRIkWadrSA3junuhnsppJxd8kEJpzTqO/oRNoA8P/GXWL3OqtzMSqwKIn3eW5h/LJ34WzfUqMPK4QeDk7/NbjYnI0xYodJ3xJs5+1HqStM01NUmL7qb886A3Z5ZRNgoEk5k33wTTGddQ10aN+l7yT4h/givDg9F/uWZWaUDqzbQj6lmuyCYD5Nn45a2kJ/wQ9HbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3624c01c-f963-4007-8269-08dbbf853c26
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:11:56.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM3dTJBOUnjO7i9mv3LYsu/Y0yuFBnBGVBT09Gwz7Bht0tpGiu/S6V9kpatLRlg0bL31GGnhqUcBZB6hVtVZGeriKl5ePR8M7L9MxlTkRz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-GUID: V0atTtUTXQSe9IVftlCU-QcEYUI4bgVd
X-Proofpoint-ORIG-GUID: V0atTtUTXQSe9IVftlCU-QcEYUI4bgVd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111159_321267_2568F4D9 
X-CRM114-Status: GOOD (  23.59  )
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

Introducing the --hotplug command line option, which is used to
indicate to the kernel that the kdump image is setup to permit
the kernel to directly modify the elfcorehdr in response to CPU
and memory hotplug and/or online/offline events.

This option is only meaningful for kexec_load() syscall. For the
kexec_file_load() syscall, this option is a no-op as the kernel
handles all aspects of loading the kdump image.

This is the command line processing and documentation.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.8 | 6 ++++++
 kexec/kexec.c | 6 ++++++
 kexec/kexec.h | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 3a344c5..4400baf 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -132,6 +132,12 @@ in one call.
 Open a help file for
 .BR kexec .
 .TP
+.B \-\-hotplug
+Setup for kernel modification of the elfcorehdr. This option performs
+the steps needed to support kernel updates to the elfcorehdr in the
+presence of hot un/plug and/or on/offline events. This option only
+useful for KEXEC_LOAD syscall.
+.TP
 .B \-i\ (\-\-no-checks)
 Fast reboot, no memory integrity checks.
 .TP
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1edbd34..d790748 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -58,6 +58,8 @@
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
+unsigned long elfcorehdrsz = 0;
+int do_hotplug = 0;
 static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
@@ -1069,6 +1071,7 @@ void usage(void)
 	       "                      back to the compatibility syscall when file based\n"
 	       "                      syscall is not supported or the kernel did not\n"
 	       "                      understand the image (default)\n"
+	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
@@ -1579,6 +1582,9 @@ int main(int argc, char *argv[])
 		case OPT_PRINT_CKR_SIZE:
 			print_crashkernel_region_size();
 			return 0;
+		case OPT_HOTPLUG:
+			do_hotplug = 1;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0933389..487f707 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -232,7 +232,8 @@ extern int file_types;
 #define OPT_PRINT_CKR_SIZE	262
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
-#define OPT_MAX			265
+#define OPT_HOTPLUG		        265
+#define OPT_MAX		266
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -259,6 +260,7 @@ extern int file_types;
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
+	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
@@ -297,6 +299,9 @@ extern int ifdown(void);
 extern char purgatory[];
 extern size_t purgatory_size;
 
+extern unsigned long elfcorehdrsz;
+extern int do_hotplug;
+
 #define BOOTLOADER "kexec"
 #define BOOTLOADER_VERSION PACKAGE_VERSION
 
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
