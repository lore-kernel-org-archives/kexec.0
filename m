Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF65C5DF92
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRCvkTazHrk95jeBNswhiMJKvGvT7Wp98DacqTG298E=; b=vC1KEGmLGUME+1G48Hd5k+2SyO
	Vzvv0xd52mT54ItTplvO+9qoT9fOxdr4JdPu8UzfNt7FQCCKxSmmqXBVMEXxC3dKzEnRofrAwykPt
	k0W93lVgW7G3SSy969TQUqLRrVXP4pFCx4CuVie85LY3N2LjvFzq5ztFx7HXA/dZJzR5rrCInaX1+
	9k7RFCKqNJxuzixnj7+w4nlnXOa/Vy6IWx+8YJFlRtwxyOuEdyroZNTWvwAgxUAkj4l2I9gvJLMk1
	9RUHI+JaS/FZNb9PMjh+srl9qxhwPF46D9n5pJz2JflFt4n3oY6U8Wut+UstfkiMLIaQaqESBodz/
	dSG/OMHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEU-0000000CLHq-1iwu;
	Thu, 20 Aug 2026 23:31:38 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCES-0000000CLEd-1Dbk
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:37 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KN6nsC4123460;
	Thu, 20 Aug 2026 23:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bRCvkTazHrk95jeBNswhiMJKvGvT7Wp98DacqTG298E=; b=
	CQbS+VrxF2KGOFw7m/v21lVCNGLBJ7LIFvsP4RDQoc202+FJlv6RRTtasKt/GgHA
	TBIJqBjpTGqOSN5uVIgBg3Hl1plUXET5FkL6Z+0r2TYIL1yr86VamKVuGIhX7NLa
	k6w57NNveDqXg2VhQANdHPS8HpJaCwmZwKUlsqCUxJwGrnxOB0OdOYQkFSA/FZCF
	5YOwvs+7CtUc+mieDRY4G+JSVdWRaPTju3iBPIQo1rG00ts6Jd6H/fpPSDvIqGdD
	UPK+c832mwf0Ef9Cbp+uT/kq4jAhbu9RzxkTsESX1DBvpE/4A2ERsU8a3ZTgu6kz
	HT+svS13LQsPcSkk88KofA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydbm78h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNU9Te034346;
	Thu, 20 Aug 2026 23:31:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfr30f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoiPpEAX07wUq/5aIEOAkQmbxo31slZnCkpyJ4WS2i7Sm8bxtWtpy9Ta7w4Yx5NtC8uyW71uF5fPSzc361C3uuo4Q8+39VUkqmyUCO7n/DJyFGHMuS31X5/7iaQznbY+Ue3yOYdem0yUnISh28DOECEy6rKC6DKJOYXtig2VPeSUWFUtYmaOCftWHJBSxpV/QHMagnUvgmNNqYi3S/t1LTSlmWDpkA9aTqa5/XCRCGts97yzl4dtMbznPRZR+q/cmuA2LxUdWwJKqEW+Im0Gcw2QQfUjPi5JCY1oEj5xxBjp0PQDhdU/X/OrPqImjS80XFsbYduGJsFRMDislFV1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRCvkTazHrk95jeBNswhiMJKvGvT7Wp98DacqTG298E=;
 b=u31KqwZt3szgB+gAUp22qwwtVli/4HXd0wSTYfjRf6XV6gg6pfAg7yOgO+g54sf+2tnB14FB2JVEtJwq8NWiCm5gjI+UwalmHib4DHqwuJS7YDG9J3jsvDIB7PARDJvk2ZrwTsswoTTHDOAS/WLw1ImzrBPPsjLkpAIu3xc6ijqS9SLDAD/ZgnltiSOWTqkUUhBajc9sNvYE/bTK5VU0C9p7y54I2aDkUIZv2FrlzLmN+Bj95dO7k9LWyGCqLn/xqgBRCPhSMgQHEHzZQW19/429mcPfWzNfzyvV5iybyf1hruzXb2nOtHORauIAsWloG3CtcNjXRfAj0ZqBF7gLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRCvkTazHrk95jeBNswhiMJKvGvT7Wp98DacqTG298E=;
 b=nruoENzaLBsxvY6cpySxtcWJrb4QI8EMslFVz/duLoxjhOyYuJR8bkHUwPb3FGxBLF3FlCyHmx+lvMnnZV+XNDcsPpIV9yL5/y2D+AP0fVh1K8kuGEzE/tdtZaNYbjAVVkrLBORfx4++f3/clv1nPED/9vxOYcYc3DpOygXb/4Q=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:30 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:30 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 7/9] Add PG_INCLUDE_HEAD extension return status
Date: Thu, 20 Aug 2026 16:31:12 -0700
Message-ID: <20260820233116.3105747-8-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::14) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5129cb-d5f9-4e5b-a167-08deff1329f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BrNB08Af6J3Pc+6NniiUfQFGPGRSdpO+7XXfKFSHU4LkOo1Mv2pbHD7lhAesKpPv7QnF1ilssfl8/otHNoxR/ig9ZUsDuMH6k5pHWbgkKz/O8rOP64ClcUbdK0v0NO4EZZYC7eYrONuA0japELJyMLtESRfiBMxHxr5nXEnxfOiTA7VYCcTLDS/UxyFClWBlgAaJsDaIZOD2OlkDhHFx5xC0tYhZqAZFFkaP3dJoWAcT18JJJSZcRimfgO99aHdd1Bl8OV5Pu3j49FRREjaMSzs3rRYqX6flWez1I5x9psgy2zY2PtmUNyadR3hcJzbA0OM2MQ9JnBjhDeA7KW7fkgihyJSQEABfFsG24g2tvMKDJYvsltvT07tlG7VztOWaJ4rYFzyclV9ffGoxT9fSNdKgYorYdkM3W7qGIX0VW29U0kDO6xCDU4Rq/63f5YELAHK1KPDoO6kZCXW6X5T6YGO2WnotFmMFsiZ+A5RjRGhuAqIRzSosYMwEd9/b3dHkf3xPXfAvQu0od+o/U/PQyP+m2WBgUYwoPOpWAq/r4Xe65jKkaKwIqNLu4iAM7Mz7SLbLKlkisMrP1WGYa/7ZeLOKmOZGXk7EtHACbLze5i9QBztwGBTQWkfkPMSXicMnnRMxIHFBYvHftf6/oXnqVFFm7nJo0XnCJESZQY5du5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgDqRRPSG1d9NYX6N4C5LMh+PipY5enosoSu84tqUGAktMRJEmworw5nmMG3?=
 =?us-ascii?Q?ZrlzPiaf581v/w9kTgXaN2znswaGeCvyZLJ4lCuMauHec53VOSfYKBqzijHv?=
 =?us-ascii?Q?d2kisr7UiEMXJfNwNyk3f9NneJU7oMOBwac4LW7z2397rmJrLlqQtNdkGKoU?=
 =?us-ascii?Q?d3AByQ/ox7bbnv0xtDExEfhwPS0PuipZhXkSbN2OJbEafjbiIrc4DE7Q52TP?=
 =?us-ascii?Q?hT0P6utvSIcZRzifyeIzHHL7ft6NTHCHoA0TVhDotAe53+X6fR4zO9qUvkb2?=
 =?us-ascii?Q?Hgq3+2yoagPHmKCup/d+bbjjh1EuiqOQSHP9Q8kD9qgq6+aEs6G9X/z/rdAY?=
 =?us-ascii?Q?NhAr6HqVkG5ubwg2Yl24b5qPysD48mendkuIjzUoD94wjgurAw95ui5PtMN5?=
 =?us-ascii?Q?Qur3UBszxOgu7Dnwrsb+IPKaheI+GD4mt3b3rxqmQF/nYDk40zmgkqPq/Y7O?=
 =?us-ascii?Q?UzTq/pJorBqzkLF5UlED5/IDnzpmxpOUy6deelRT27hvqnprC+QZ6xnmVz2w?=
 =?us-ascii?Q?/1quLUuf5XqQn9pGtLCtsLHzCxs7x1rfdvTAKT6gd8960GM5MafAwrlEbsoG?=
 =?us-ascii?Q?5Nt3eCSCzmy6Mmy4BasLy0WBe4OO+20NuVLYGRj0BQlIdhiWpotG+TG/HfsD?=
 =?us-ascii?Q?Je8lEzgm3F45QnRpxB6VC9YIzfGtWqipm/Mkpo1aX3NR37qm/d+jcY6fq7vK?=
 =?us-ascii?Q?kP/zTEpiLfG6L3f5O2Q4zJnLP2tNNtWMeTKoDJ/iQF8IdoeaD/c15xymke6b?=
 =?us-ascii?Q?ZoxlFNqVFgOqZT99hNvlrIlo8uYLDIRUdIfD79H4z7C7c8tJSSdvx6u64ti+?=
 =?us-ascii?Q?Lq8KNdZt3vZPW03B6TxU5PSRGqSPGLveHhbxmYz2R6ee+m8dN9VMxOCdVUzM?=
 =?us-ascii?Q?aaHXIeY23KYBUX9CZnu1BVUTOe1qGFuO52nddf1Yrf3biITQZy7gV8TGk/z5?=
 =?us-ascii?Q?O7HxRRRi8YMItohnp/+WofnHU2+CGD3vahj9/Dt2xLXbJ0Xnrm8jTwCos+DI?=
 =?us-ascii?Q?t/NpmyiOtHDZe8d/pqstR51X6hdy3NGA52yU9+UNuxaem78gr7JL9j/cw6zC?=
 =?us-ascii?Q?Qp+iWiVgBvfDAh1cCzWbaQxEFFnhDkLGoLTJiE5MbRhUnKTpDjNQyj8/tE06?=
 =?us-ascii?Q?BFGdujAjstUneJRrJRGrDPwY7F+GhVBO1srXbLgipwoaDD890/J6eG7Zp1Pn?=
 =?us-ascii?Q?2RPC7FV10TKnx70yaYm4BfmKj/0g6cP9p14TDLlDhhEDfO6D0zReR5jDDkfm?=
 =?us-ascii?Q?KBNFup1Uvc7ExDor4VYwg+F2mpLNENG7gFFeRyjgNLfSH8EPDzcQNSg4Gylb?=
 =?us-ascii?Q?zupxKXhPWIwrlcOjk6sP4rRMy7xXzo0XsY7/8hZ1+COwdeTgprLlV9pJ75tD?=
 =?us-ascii?Q?X0qQs+lOMXCzOWLj3pTotKxkoWMzbqlFR8fDJNri6MNkwSSLYXvxhFYNlqi/?=
 =?us-ascii?Q?yoJmODckFKnk05In45XPRzwaykKCq5h5cwpmPJUt/E4tZGfUo+fskx5sXRbk?=
 =?us-ascii?Q?gHLXZ7syClVXP2zhL+Yu+Q1DnRVayeUgGF4Bby8d3UMyDCq8EYjitQNoSw5m?=
 =?us-ascii?Q?u0qD9o/CQ4h44egNHb6M5Q44Jrx9Lt0nnU+NdkEfR28QwpHvtbuFuDoFjNMq?=
 =?us-ascii?Q?B9kg++V99XwSe/BvX8Emg70ZK6MiApBjzHxczeff4PdUMOY/0uw7yGjExR7V?=
 =?us-ascii?Q?jhqLp9NURimWGRH9wmer1HGnPPXo1tQWcEOOZCAkJPAhEvJAhzV7DVpgCb0f?=
 =?us-ascii?Q?SrEzXkvUZ6PGMLwdirI411ZrIZo9F80=3D?=
X-Exchange-RoutingPolicyChecked: m4W01zH0UvFYlQDAlc6TusiK+Em6FxncNv1TAg0fKdd0jXelKdYpB5Oi6T+Zl/fN40ru9ZQHjJiPx51TGirv1sfcUifzw+ZQr4dU+bDHfM149nG2WcrKWk71rbwWT/m6SUoMvZ1E6u1ltFL5KxL7N9hj+FgpN3lojoKRDKGjQO5xMTugH62pDiurV5H14xG5M0Qzg5Wcb7ObWUckbi+YmHZEzcG+K0hwaAaHS9iIz07wqlZi+tOX8eZ86Hafn0kK8Vd17IqyZa34aASlc437IBVoHFQXltfCNnb+tZc44S/5zDuB9nbT6dIgtjvvxMcrQ/GpDN1O8T5iscxA8+DFHA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K4cTqN4vusE8ZL45hdI+arZSoqSR9wREeub6snL174BiuNpNCqZXQS63qEqJIuuUcNRx3BISsTazv6SzQcR0Iw9+qQtpyDSVo51AsDR76L4P5ZcAVvlRyhqBzFoIoNgynkJniXIGY6D5GFVoZ73yZOPzxjkC31vojeGbusXkIO5kjHo/PpwBY+ZNS8wgP4cY0lTHWUOyn/opNJNyX3OWKJmO+faaTFaqqOi8ztmbWg5SuITj1XLnq3kV57AT4Z2YDFuBN7TTtHakTaZG0XmubwFP0rvmvGQD9BFTkYm5OWwv3Oas1NT4fbTSZJzpCyxFtSFproTts45M4d1lMFTRwSzz7pkyVEhz4+HLqEUKOXXLE4OYIJylrLfE35Q5584oWHfMaDK2B2oXPsSgA7JU3jWe8Uy2KSCgiUrmQ9PdoDAz0099s22bnx8mQrxLSo0TRlt3PVSUxJo8/QRYYKqDtoyUnrnUOolmK+gmD2u9yEkbtKYvkxp7mQ007xKOI4hq6gIcHKc8AtIBYqhg7OAnYIfea28LL/EFmCauaYRd+w9dv1PQQV5mnc2IAXd7ECSaO95hCOP2+8QeXQPW2YuzE/PbOvzJX+iVTW+HElSIPRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5129cb-d5f9-4e5b-a167-08deff1329f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:30.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6Kqml6Wd9u6Vg64SL7mJk8uby6lPElZxb0vRrnuj1hFRu0Pv/5YjiHq0mPbu6gdsPZimdQPAGaHcVY3Gf6c5CSA2dn1lir9VPma6zRJhqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX4TBpI+amgSk7
 cA7VjJ+HIoptTaHvQmIwBZKujUqYpw4Hv9LfvGZZ5CqLVKjeuS4ezowXjKmkXs4LT/5ug/Y3DuX
 nWp0Kct8CupCosMDSzP36Jg2hGGrbYbDNyu4ZgFP9VUtT7+kR41MGAOdoIy/1pyvNWZNBs+1mR7
 3Ke6RXcQA1EDgReB1xbtFRzCkH0WnC4hnpSBDwA0nEzNDQHSHz90EQpyOHJhOfowCcc8ca03nBA
 bFLLdb5r535JdkcS/PvgPsLn9L14uPS1s66FkHwmdpClNr6xnmdK4u41FirMJpg7mzeYheedUi7
 zLXmqToYeKjXzN66KCRui6Z+C8xpOybzogMLtS8Lxf/FHJpdIu5s1A4KlDjh/QcvrJZzv0S5BTU
 rCQq9nLKxABVxUx3CL7u96zhgFdAjr+HTHKUC/G24t4PTq8AeYw4s6vurhmY30LUOaAcECZ9SCu
 K5c8i5Ko60cDeAxizVA==
X-Proofpoint-ORIG-GUID: GR20uXXP78UGVqLxyfrfn90TVqwd7Vlu
X-Proofpoint-GUID: GR20uXXP78UGVqLxyfrfn90TVqwd7Vlu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX1ts2egBvcVii
 c/11favzKFtWyEplnEe/n3G4nbf1rYN3xKaOstsXKP/f12uczaVaheZyF62gRhhLnlSA/khWdH6
 ZUMyeTzPNC8u8YL1mf7AssGwDZ3q+zjN/f9q5VinlF9rt2WTIvcV
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a878e57 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=jrSfxZCFglRS602OOsYA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163136_636347_182D9709 
X-CRM114-Status: GOOD (  16.03  )
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

Prior to patch "Do not call extensions for tail pages", extensions were
called for tail pages in many cases, yet their decisions on tail pages
were not respected when they conflicted with our decision on the head
page. Since that patch, we do not call extensions for tail pages.
Instead, we apply the decision of the head page for the entirety of the
compound page, which is consistent with how we handle compound pages in
general.

However, some extensions may want more fine-grained control. One such
policy may be to include only the head page, excluding tail pages. For
example, this is useful for an extension which includes just the first
page of ELF file headers within the page cache. Since page cache data
frequently uses larger folios, including just the head can avoid
unnecessary overhead.

So, add a new return status PG_INCLUDE_HEAD, which behaves as described,
including just the head of a compound page.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extension.c    | 2 +-
 extension.h    | 7 ++++---
 makedumpfile.c | 9 +++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/extension.c b/extension.c
index 9b29f0c..a7360d0 100644
--- a/extension.c
+++ b/extension.c
@@ -314,7 +314,7 @@ int run_extension_callback(unsigned long pfn, const void *pcache, const struct p
 	for (int i = 0; i < handle_cbs_len; i++) {
 		if (handle_cbs[i]->cb) {
 			result = handle_cbs[i]->cb(pfn, pcache, inf);
-			if (result == PG_INCLUDE) {
+			if (result == PG_INCLUDE || result == PG_INCLUDE_HEAD) {
 				ret = result;
 				goto out;
 			} else if (result == PG_EXCLUDE) {
diff --git a/extension.h b/extension.h
index 22af9a6..3edfbeb 100644
--- a/extension.h
+++ b/extension.h
@@ -4,9 +4,10 @@
 
 struct pginfo;
 enum {
-	PG_INCLUDE,	// Exntesion will keep the page
-	PG_EXCLUDE,	// Exntesion will discard the page
-	PG_UNDECID,	// Exntesion makes no decision
+	PG_INCLUDE,		// Extension will keep the full page
+	PG_INCLUDE_HEAD,	// Extension will keep just the head page
+	PG_EXCLUDE,		// Extension will discard the full page
+	PG_UNDECID,		// Extension makes no decision
 };
 int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i);
 void init_extensions(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index 6c62930..7277e42 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6666,6 +6666,15 @@ check_order:
 			 * retained by an extension. */
 			num_extension_retained += nr_pages;
 			continue;
+		} else if (filter_pg == PG_INCLUDE_HEAD) {
+			num_extension_retained += 1;
+			if (nr_pages == 1)
+				continue;
+
+			/* FALL THROUGH and exclude tail pages */
+			pfn++;
+			mem_map += SIZE(page);
+			nr_pages--;
 		}
 
 		/*
-- 
2.52.0


