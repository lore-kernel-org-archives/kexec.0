Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC9E82CA1
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yhB7GqghDirEUg+D20DA1FzGZn2UPa1fNbUPZbyKoWw=; b=2aEcbTqEpstT8L
	0dxgSQ2hlyRNNw1rneOkT8tTAS3pwkz5qaWV0MHan8T/njaFCZccsweup6JSnD9qDl6USc+N0nt44
	MnPkpqnSHtYVqtPQII/IaHtuo2qXyT+1wz1n3bEtyBY1thLdx/OshSYFnegD7n9tUqbhGKxaTMmVO
	0PJugFNJnlZoPTPnUZA5VsNf4qFKMm/IQ81DhWQLRFMnjlQYXUKm606ghjeg9FzM7H0+NzoveYsZa
	2pl8Mxb7iQs24l9G2ixpDHqzaESPbvo7fg1Oi4b8bQUzPN4ZMBtR2ZOqiyci+sp+sivWN/caVNyK8
	aTQ3JAXFe0tfChhVl3RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ1D-001YgD-12;
	Wed, 27 Sep 2023 18:12:15 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ18-001YeG-3C
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:13 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGxFgX029736
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GQs/XQfTP4BVN54UBYmjEhhLkgRDjcqY67sj1CxK4F4=;
 b=3xiwEXi4YLXwR5YHzAECZNPGFv0dw7R5CldWDjLrDyG3B8QgNZhHyrKOLOytjzGOxPfP
 jJudOZwUH4Pxp061BR3yrziXmFylarwU9O10d2RdybMncu1HANama19jcZ/feOq994is
 DRtrF/5GUoHE/1nAE3jTvft0Z7zmiaYkxdYhRy1CRnQAK3zgEUnQGZ/VRc6qUR4zynsA
 VUDRu7aDHUY0s5ahWfCHUWThzbxgt2olhiNU4IHLGyvZNgFA0oLy26jGXeuEI7bTJUGU
 fk9N6WUlwXrpGXKafHL51M4QQIR/Z7GLCCoFUe7Dco27CuhEiDw5fkMbJ6qiMLyCCD0Z zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2djcw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHriUD018002
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfea3qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQVoCDeKwtqWCpf6ZMvPukrHXA1wVkTZmlCzuoEnVIxmC9XADaDyQm+vY+afBvXvVAeq+z77qw7aXFPhS2kbvx3czGINdo7qUaJUargW+1uRXKwwu5S3HwXKLbB2bR4kM4ZHbySZ6F9t0bMqXNRo6wfxk4WLhKgxJt7CKF3kEulgNFEdsyXkstvYsGhrthVn2stwQ/PnBiqHA2o0uC0WgzLFIQI0PVqe/IwroKnmhp6dnbenCCVi6cjAU7bdQogG14q2+9FcmibRBFQ02LAVYDKWZ3SD9vGyvuTB/6nQ45gKAjEQYLZ4S4E4nWJc33ai1HyhfWwwPx6+DLO4FYBcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQs/XQfTP4BVN54UBYmjEhhLkgRDjcqY67sj1CxK4F4=;
 b=QR6tvxw4cKPPGX565As4/voaq6oCE67DNzv4TyyXo6uf2qsYUE9LcwKTwYyx/J5ZUXL8K0xQ4lNl1dmZY1X5vpUTgI8lL4XuBJYc7WprJ7sdujuTA+S1Krc3Hus0lRc1Y70PXnk/VQKaG11+ODESahxVunmL9UMoTdFQqFje0UbsAPkbebC+ZI/0ZJ2uGhYNtx6NssrGQi74pCTIQ5URDornXsd06usU8W40MtBEOkdTGTN87wyNfaOjQKuELjTYkAtaOYnqnfxUTt0f336gntKmorsD88j2xx0JQwliUxfAM4zTYwTHjXlMGEy6DbBCUsYB5NsFtWPun5qUAgbehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQs/XQfTP4BVN54UBYmjEhhLkgRDjcqY67sj1CxK4F4=;
 b=E7STxRA/pfa3NwWrwCjyjR/hrWBwkcIxTc+yZXoFh+OlJhDJYAD+79lPN0BtHiCu6JpJy+l0h2mCGKvjcy++nbi55wOEMfbzco6RHIuh9q1bfUEa0d3qaN5wmQkWSxOkAaGo2Yrp2k0nL4M0JlNqZd1AfwSSaoNtqA54Lgm+v9w=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 18:12:04 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:12:03 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 5/6] crashdump/x86: identify elfcorehdr segment for hotplug
Date: Wed, 27 Sep 2023 14:11:35 -0400
Message-Id: <20230927181136.2627-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM6PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 35744eae-3472-45df-3fdf-08dbbf854089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wKSEtlg1Afuyd4AiCm3CtMbPX//HJ5NHp9bXTwliyRp7tXQoiQ8b6lw8zjIR4cAo9Gf/WKRae/ZSKGkWQibF6Za4xkboA7DcqcscO3TukiEWIA6GTCcxqcuNmF+GKKpOGMRV6Iwp/9Ot6uSQSLxygbzXX5Rt5pLpoprLKllcbZt+NiRoCRXKT0ts0Df7S7d1vOo0FVyagUAemHKs/6T8DukDiEnvEA/7zXsOq1to+WUWpa1u83l0OyW/8s0n9paCd/emn7HSaVAUw+4LLcDFF75LFIBywNIZP0we8iD6TMIXOYt2Yvz6i7q56EFRaSWwpYGpAjfIF9EZmYGpMzuTzYsdSTNvSGS+rMS4oQOkp3fh+DKxLXFRUW1a+9UlLUrBSeQQlaNZYcvRtfwGRk8S5kDJ8UDh6EPFYj6MHMT8Xb/T4YMBClyI+9kQrglGORxvcGvRDvgxrMipvTcamSC7zochDyIAe6U74VDOj3oEHvZ3MznUQPjYTzXpNBij4+Xe7tcpaN5yivXhIvAGcbrzvxFtZIxkvIwLzRT0hAqEOkc1ufz0nOkUp4d6exSBmle
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(107886003)(1076003)(2616005)(6506007)(6512007)(6916009)(26005)(8936002)(2906002)(6666004)(5660300002)(36756003)(4326008)(316002)(8676002)(86362001)(66556008)(66946007)(41300700001)(66476007)(38100700002)(478600001)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPtnHvFYtd3vB9HXJAWHn+NJSDU6vdtJsbjVRNooGYDLiU23OvNbt8KoEnY4?=
 =?us-ascii?Q?ouvPU27QtUtdI/ovpbgBUDASFoAJEPw+fQmQvM4XGgfS0bV6tBtho95PlJLL?=
 =?us-ascii?Q?ydRrehYgtMNVlgOusEhkHMUU0s4g84tlcaKYhs8WiZpZ2HG8HT8TrG4gUeVt?=
 =?us-ascii?Q?QcdxbMsegD1eYQDiWvz45VGIwtkEdVlytdoMUA2ZpuTyoIerteNXK5khajvd?=
 =?us-ascii?Q?VIejMNNvBRXhb4DeAIZly3hWZAJrckBYoWz/2z/eZ+pHkG/94m09+VtjokmI?=
 =?us-ascii?Q?GkxDPiYTo9QzUj0ACwE4XOG8kuDr2SW5w9zKP+XxPdX/i9UTBZesy1aYI98y?=
 =?us-ascii?Q?yQyzmDQHuiDjAKEDBxCpN8VV8OZYOsqjk3Efx1Aqk1311lsDcsPKpi1cWIYb?=
 =?us-ascii?Q?CC+VxVFQmU0rXl/9dp7YemVOQUc45Azkn74eq00A2tmZiZZBv7ucLwbbwtJx?=
 =?us-ascii?Q?0kR9tQnRkiXQi12RxpjuN+ZQ8PFieKvo2HCHyKjxBTSQvheVdAS9Lfojofxt?=
 =?us-ascii?Q?H27wbSI86y3B2Rna8ni+AdoSDdDedwasz2J0uzVFUCFIgZwmbfQ/SRJFBWH3?=
 =?us-ascii?Q?93TpCDdKGWsPNY4bB4zugleWPePLNPeFKHfNJonGH/xnOq+e3qHf+TKrg3rT?=
 =?us-ascii?Q?mSJDRgR9ggGX/7VgNCjg8AS2ovA1mpmjTtTGEouArF7KLSKl1RwSFCpLRTbt?=
 =?us-ascii?Q?UaJYrRz20Ac04HUudYbl4/snAKZ08+GPmvpFBw0EGF2lTaDOmCZqcYY6jt/k?=
 =?us-ascii?Q?SQpdigijVfThKKIAelwtO71QrxUIItjJE3X9a6QRVeSGNLarrYh1Yi6mmCkv?=
 =?us-ascii?Q?3V86a8rKapBUVlad3VYbkcvw0cRhfE6uhMpYjoWTlZ1fX4JIZcerByOEACCZ?=
 =?us-ascii?Q?YCkPMLa2lfC8YHxkEzivTJLBYIrV2pLOhsIbotyGi9H+2hy8G5jfNMB5iHXL?=
 =?us-ascii?Q?mN7JtAtctzGoZl4K2gike42y0YaRB186Kv/nF0ZfsO+TkIA1fFJsnZuhKl26?=
 =?us-ascii?Q?mvdhcpyB0fBKl//JE8FTzIWxTldwc3UDpxUtdyppccZOEIVDNzPF3Py79IWq?=
 =?us-ascii?Q?C6/061pRObeA8jYFtRPkBUiUB5yF05CtoGX5ao8BTajYT51UDzIgoqz5oUlk?=
 =?us-ascii?Q?+5axpkVx20TaHw+nZH0R3P/CN8b2RmZ7mDI0EncF9JfSVIIyUdic2e3AEVmq?=
 =?us-ascii?Q?KYrm21KB2g410KHmYI1Fn6ObMms52WdE1izDlxQIX2P883PS8u748RXZeEpz?=
 =?us-ascii?Q?P4hfMR9ctz4raG5rZubtU0DsIodSBjGViudOYctITZ58oWy6FUWMdXmF4xPw?=
 =?us-ascii?Q?d53trXT5gS9IRUM6DTEZhg5hH/EzvEwCWoddBT7otCCMlqbefIHHR7HasKsz?=
 =?us-ascii?Q?qbFDLY2s/QpKvMJTs8U8zcdnjFYb7JxxvZpu0l+8ij68Wsmex658uuSZzajw?=
 =?us-ascii?Q?IWlDiFA0YIBfRtem2VATpLPSl+F3FE+VFpWQZ4KoRHrN0T1vV3MZqT2sxMTF?=
 =?us-ascii?Q?rEQliEX3KfwG/r3LOM23KJJEhdDoqcIf0NWjhDrXtG/EesF5ME0W+yl3/jmU?=
 =?us-ascii?Q?d5n7VWCX1C/c/4o4J3DodnOfxud7g64+x4sdy0NB77w+GXaAprOrVx4Sty+F?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P+0tzPlBc+SIOtxBhV3q7CIHplb97rp+3uoh/bio20fmmi8Y/O6gfH73/oBeNcnzyS6yN4GWDDHnqJzNhlgi64V965jW+PWO63cTLF3V6cnHM+4mtYpqy+Km0D8bBSlCBmdTUIcsrvFNCTWNwAJ08S8W+6BkQiYcDBA9U+uAh/Ucl4nLxX4H1acxSeKPjas6leHHFzq5JPWnrrNRjH/OweUnfZ2euBKXDoyp0tm5g3dejFkgWgtAerQhZbhDXb+GWJTuFxgNF2ttVk+NbprdPZTwVPW95Qxcz9CIIfN7V30MIKhsJ7laxR3pyaL6Fx/zw0mnwhgB7A8kEsUXQok86vSXU8bI95phmyiJxdDjn2wIkCGGVJPU9GNlJD2A4uRKjptwOHscdAr3Vxu9wZP02dDMrAHAv6jpHwfgyRqrXWDOQrQ+8NccD7of964gkBHBUQVOBQLKgPxsjxXPIOFxvVmhcq/zQoW1vSJQVWktaAYVdS7iVGzos8PNxBMTXlgvxercgo/gFt+08/wF2AaACaIDQ276FSxEvUtfPQ9FGy82MceoQj8mX1Oh7+CJycKBLrzmCDnF6xb+ch3aKLtZ0aHQ5qwxvHfuqZ2ATEg+pIvVOeqPHz9kAHgdiU9rF7hnnkTk1NJsc2yCbKz+YHlRGaEJfluz7YqpmroKZ5RtK9rjELKA76xu2/tmILzsCShLZGmsZJJqgRbTvjXUsKNCYIpRS/m6WDFImY0Daj1RkTLCrV7bQ5uznc1Xe4BmkQApY3Qyl9yc3c1U+3h+/gtv9g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35744eae-3472-45df-3fdf-08dbbf854089
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:12:03.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH4ebpu14Lz/J3av86rjNOQbzm+EKsPS/f1uVJHlVQzqhuCv0v9Xc2HnVVjXvnhidgbYApEX8suNm6mYnKB2UNF5vwKIjhUks2PCgu84GOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=884 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-GUID: SBBvYEAHkYEw-N-aa2nhbfo-HCMESyVK
X-Proofpoint-ORIG-GUID: SBBvYEAHkYEw-N-aa2nhbfo-HCMESyVK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111211_151745_C0764291 
X-CRM114-Status: GOOD (  16.23  )
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

Identify the segment containing the elfcorehdr buffer so that
it can be excluded from the purgatory checksum/digest, if hotplug
support is in effect.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index df1f24c..cb86ca7 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -956,6 +956,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	} else {
 		memsz = bufsz;
 	}
+
+	/* Record the location of the elfcorehdr for hotplug handling */
+	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
