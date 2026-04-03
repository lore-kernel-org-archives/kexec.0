Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB6E85388
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wMeLQBZKy4sps8YJSiIzqwgUjEuMbwQdZCrWlbiwi7k=; b=h9z4NwGIwfhr6hV47GAveyUrFX
	I6q0neGsGpeQGXn1z1M+D4G7jIKsCfCVrp/X6hshLEWYWRJ+ZSkLnEnxSQaSKg54f3GKKryank27S
	C8L5tvQ6Cn4393roPj02grb8sYpglH8a1pHqUIObqe5aw39xj5X9bsw8uDMQlALqfwmdJ3DJJ+rsu
	dLpxUpmIHLrUnpFqxWd+BrD6pIPBbexJnfFiCNoFCjFK6/oEOG37UpQQJzraEcBDpeJ/SbLMcgcDQ
	pDznZUDAtBcQVRnmWWM4HR4L+dWy5hNu9z7uVGHVXrAIEEwYAy5i3h5KvD0m+ol4hmQSxtrCDRg6d
	xetp/NpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8jEe-00000002QbJ-0iJ0;
	Fri, 03 Apr 2026 18:27:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8jEZ-00000002Qab-25d2
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 18:27:10 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6335c1rN536316;
	Fri, 3 Apr 2026 18:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wMeLQBZKy4sps8YJSi
	IzqwgUjEuMbwQdZCrWlbiwi7k=; b=Hp84nGXbHjancSieo8MPCUzjEyRGhmxmhm
	e7ez+fBfSZT1BBE5oyRqMtzLB/XHATtv9s0U2Z0H8+t0EsLklGTk1EDP6ebg9pf2
	0t/FZ5s9hIxpdT2DkoWM3XFdnfCmflPqvdva6+Xa9kzk3MHkT6Lvjq0ksXCKs1WW
	QwKm/1blDrj0XV2HjIUpvN+sDIJW1DfXQF7IRnux0S2wrLFz1lrhv4QfcEN1+OeN
	zr7tKdFmswYAOLKhBLnaXtUeyCsVMPfz08rZB6FHf1+ZSXynqhzzT0gqZtr7JP07
	ZBO7Uh1EcdLGEnFwT737uH3sBz5gzS4Otv+6SIluTbKAFqZL8Fpg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65s12gdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 18:27:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 633IP1aI020225;
	Fri, 3 Apr 2026 18:27:04 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65emsur0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 18:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUzPdBQOX2qAU/8yubW21mi3U2uAvxIF2tTgPdSMeQ/14aSXJYsBb8q54PZOzJK30UIwRuAskAy4iwQSIueRN36r4ev0diWLgJro9qSNScO+88mXvvYKF66eJoL0a5BjgxYmGvYe8E6ManapovDCKaACwRMojlOGUZ+hnqFRUV/k+JX63EEsUGwzKfMQjQXOCMIViiMtAak3H503gC+KGjvIG/RocgGQ+uJwy3ufjJwXZCe7Zctdn0Zm26G6Ezsd0MjP/Rq2uBXH0mS2azdnrDSSP7rscDNs/BL5fQo7WYFkjTj0ajfTj6lWRQFeJYk+XSnWmYQifMmvqZvziw2gIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMeLQBZKy4sps8YJSiIzqwgUjEuMbwQdZCrWlbiwi7k=;
 b=DvdSr100y0awRlTUCIhHyUK5lpCA3ZeKOVRQzCEwIPJoQXzty2SQcdA/VFPdCtU+Jd7gy8IINfU7C+MhuoMbE5pY51McohpgC0uLw0UJqbSH+9rAtjMVYrKk2PEw4Bu0OPQxX5icS4moRPTALdI1MI1a+wJtheA5hkcSENjv0lob24mdyxI5L6u+5CxLhWjWyzrr5PNBtf6HYszume5jVwIy2Ql+6hMtSfXenlQ04HkgIB7TcBaOzJ/VpRW7+EOAtWcuNmS9MxTSa8C+zqO03gAyD1iIMQDol8bOXvUMlh8wFIWIXlpTAxAP3jzLkuU3skPcwIL517fulnnM61WO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMeLQBZKy4sps8YJSiIzqwgUjEuMbwQdZCrWlbiwi7k=;
 b=Imu7g2Ko5RSYrhowXMo60PmnVfDxl7NmEYIOBkjWLhgly4T8VLGLhvwQi8GKQDBplFs41iAhR/7NkrpKqUG/JfyJYa3mFlOW1yftRFnQes5D+Cin/9V4zwAk/I8Nh5EUsMe6wqXZUTYXJDnN7Ler3EPwl6aP9nIB4TwztrWJFks=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CH0PR10MB4938.namprd10.prod.outlook.com (2603:10b6:610:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 18:27:00 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 18:27:00 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 0/7] btf/kallsyms based makedumpfile
 extension for mm page filtering
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
Date: Fri, 03 Apr 2026 11:26:59 -0700
Message-ID: <87ldf3ew7g.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CH0PR10MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 443a1cc7-96ed-4c18-7a6d-08de91ae98be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|56012099003|17002099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q+0jbBGpHoThBtOUJkoe047RMbYTLKgx0DnT7/q9h1xdNzBKE990KkCSH9TPrB8k0GjF7zTBXsRe9Fq1f9cyc5B4YeFsrslzQjkI6hPyiH6XbwtPNy+zWXZNhMytFAZWF+bw0vCY4hRzha2Q9UEhjYYyCpb9wC6IjcQcv7Cw/Ds/AnFhs1/Nkrtw8kMWSX+hcWb2SF3QnY7hEffwUI9z1O1L3Zt5XGQfO1laC2PrqVADlDGSaPoaDKgyf6rCtfU/+PEWXGHrtb62/7ZVLMYtBvyjfnEGT/fuz1sNZOrQZWn7/0lw3Eor7IgD2ywKXnkPdDI2YcVapNm5oSKavVLVEj68QSzzuGUcwpmvShjD4rf03Nv5GZia3x0QPh8Osx7JcXO2kibcJiBWfx0qvh9X9LknJ+orSQxTrKXGLnZcUC+b/8iVd2eNv7+eghfhTgA6A11q98fjfG54MdwBAUIBk6FfI8dz47mg105wl1MGwp5k5aIJwg14gPRNezau327B+q3VzSYsKVN54qqlHAIXTSG8OSO7/E0z2SDRMpQFg0DEnayIbydkAV+TjGvZg2pBuWOnfKC1btrjttH1yf7yAgeyiZL5vyy5Kx0KqvzHYWEQTiGAAE3UE+bg7Glc3k9rf0liOBEGPov3GMkoA9ItNZFNFUKe00B9skOXm22SfdvzPKL+SOTPD6AGYsuq96ME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(56012099003)(17002099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?omwmukQN1KB2gBEeI5cxi8Pwzbb932P6cppNEsTCQ3bqVU83GcnZF66JRRUG?=
 =?us-ascii?Q?KfWszBu9jLX2Fl55fNtvMpTSn4uAFWeqUvrc/IqZFVaMGYLbXDAUp26X0ZDx?=
 =?us-ascii?Q?lY60NCKkc5wkK6agCYzNwsTk13Qx3UO4nHZdTTQja1yby1Gfm+DUyupAwNOb?=
 =?us-ascii?Q?C7coK+XSfwe8O6I6HS9nSEBSh0yGPfp3IfrliFQg3O8UAIYzsIelg1vjnw/k?=
 =?us-ascii?Q?Eo0SkGq6LszeEQiNhEkkaks42lCcEqxDd73mRT8yWTuM4V6RB6k1ygUBDciX?=
 =?us-ascii?Q?IUGrzdg4xYyRaNzWL+DHrPnQmJRuXwrdoDwFUeCEZN1jsgs1wAjXyMy9ZURZ?=
 =?us-ascii?Q?Hpwg45JdyvknvlFwGaq67ZH+sa5UM0lCKbcrYZkQHSui0GbaHqGNvcHPgzHa?=
 =?us-ascii?Q?zi5dzP73uOczypar0vkEkhOD6BMEGeEhJEc5Tl4h7+9HxdS9s0YLlzDBuEIK?=
 =?us-ascii?Q?2FpZjFjHsmS0ZNWSuJQcgN1yzoWVsuDAQKU6M2Q9FFayzD9+xksb7zoPT1Me?=
 =?us-ascii?Q?vghnesbP0L8NpI8ReaPl9rs9rjZJHUZHzyb5H4buAvxIbcQahy28oQm1Glf5?=
 =?us-ascii?Q?oq+2PvQHpLZ6jwHPE0wU83Xb92RD/uQIXqgjTXY+O31X33G2IcWl3EXgA2fl?=
 =?us-ascii?Q?XAS5CaGfGlKEyXxIkxWqxZsY4QKwOVJijUKa+RbLOn9G1cyDqab2ryZbGqx6?=
 =?us-ascii?Q?pYdKgVGhtIPDgb1MKXUWFK1L3WwWHLfyFh6VKsejWJNbppg7Z/ARgg6scr1d?=
 =?us-ascii?Q?Ga/WmDTJNdgufLEnAGuTyeYuifYZvpV0YXsdIOGQrZZsE7nNznsArh5Cfqqi?=
 =?us-ascii?Q?0VbpZjQPPVEMl7zAmgSoOmMr/JyKUwWAx0o+qtPeCXOEIwrIvJ/G6nxDHmJL?=
 =?us-ascii?Q?lhZkGavo8XxTocFVRVSDLBzQuIYGnmjKS4gIKDmWqowqwct7/0U25GTGygtG?=
 =?us-ascii?Q?Zehm8vLnG46gzExNsH1UGMemr7FXwRhZtfseiO4UEYYthU9FjD7PqtCyQCfw?=
 =?us-ascii?Q?zhoeG/s6e3SKcyI/YrxvTcAyuONEAPSctyr1q0ygZZPgDoZaVh+azE6Uu/kO?=
 =?us-ascii?Q?rwKAabcvXdwx6DTmY1r/JPLPQif1AtqsYcHTD7M1wWWE3JWa6ucaG/gQvokY?=
 =?us-ascii?Q?fnXd6+bJPmCfhXn/TvbuU4wdVFSLXZI7gDFMlik6hvdNCfDDbBSpmhdwWWf9?=
 =?us-ascii?Q?0qc39L5xknWOLyRLaJdP9MZKFcAkNrXks1+2YnWD3idKGqrJfOrSuNXxMa8X?=
 =?us-ascii?Q?HE1NpCsgmz7Xpj1qWWsN+SEZRhtUwTt7NHyKqyL0AXDWZzzoErpDGKkVaobT?=
 =?us-ascii?Q?hwDxxij5Mu08Qxqh3ibETtTfQm7f6YeM3V4t25WUmDH0BzwbHe1VjtldKBRo?=
 =?us-ascii?Q?Tfz0S+Lz6GcSAqWV5R+SD3JuQY/q4LvJ6mp49qtG5awonrJKnPBxsGOjG5h7?=
 =?us-ascii?Q?oTxt9KVRUwWG80LCB4H4ig1BQ7FVSEwI7SXYAnk9opMzmrdu3JfkHg30OnS/?=
 =?us-ascii?Q?uw9VZwvZdp8TufBYOIO9n0FeFJZk1WOR6ikz41YuWKfuN20ctoAsheog9dGq?=
 =?us-ascii?Q?1sOg3vB7StdrKAOfffclRfOVRILecVl+Um3/FlcxwLo/0ik6jtVM5rPaXgXr?=
 =?us-ascii?Q?w7yeD6UpZ6auwRWgbtTKS/hgs7cG7LdHBqtQwn5Pbp2MSsZa35kSx9HhS/je?=
 =?us-ascii?Q?enmyeyFlBn0B+9xmgUYGTCglN51r1gSzmXp1kjy9+L7Eu3ISgzK775YLa46r?=
 =?us-ascii?Q?ErwQ8pCuXk7dJoInoEgOWzJk1raUZK0=3D?=
X-Exchange-RoutingPolicyChecked: exxCLPD5AOXAh+uFTGZ9INbwD5LphpxO6DXGO/siijrse/tKmUfXkE4no5HCoTCCynjLaD6Rl93H58O99ohgta+pOLaEtDgtfsdeLJ/+laaITsSxzqu5wX8A8GXbDJvGmxaYHL62EqLLpQQ0UlhF/fYRYuTWwuc/KHFFUxhUjVcvpR0/rZrJ+Jg9jSSYURA6clHl8ofWafhjRNEiB03vH6KVt8sixAH2Ehywbw44x0RtOO5sBgnLa2W0D06CxuCmGizzKEa814YJx7rznxUDCw3aWxCmhQ/RMp4yuiPmdiEibRgK9y2mHFmgbWtv7ct4JoodrmlTBehtkCELHBjUPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NQvNlKbERrZjUFd/0QlY8DrLTGwGLqc4/06o6Mk+bODsQm1oJbH2GeEl31RKUaGBAXkHZc3ITVd8nwHxUqzfZ4O4RCWX9edVUnNiaH9GB7WNVeHEcr6oqCV67ZsX9+L7lowRt/3mKXRMkZlXkFFBk3taUWtJXcyh6igr0OOhmKrCE6j3usGqd1SSPDnUbMxmagcHSOsiVHUsQbo9M0wSHqK69GbGrUdVjUGRqtamzVMaFXR7lq2zcLsdLIfTAsTall1Gecvl4wyqjCayP9uS5Rs3JAyW5ogcDIiESyNHArbrCOPyNmJE8D4cvyGoS72XxefqeLC4JFDL6+auE+NXDVZMGf1u7m3OTnb2FJXVhzLrjBmQzRZL6dIp7NjKn8XU0wPCAXaX3nd/ZOGgxKL7+IE0Q740lFyjyRr1VZg4TWNUrVRs7xuG9Ltf3u0Sjs4JlHJEmDa6vuArMrWnVGrs95dgvzO42bUYF8D9XacEmL+0SrH1rXrMBUYPEB3HpOA8Jw9rCpalNZkXDJJ0kDnO6Ban9hThMWeVYmdkzK3aaF18ERcBKaJvobrYujCKKRpdI1H/LWQPyPqKkytrnkXKKAwx0PLc+5czlN0NSGvCoGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443a1cc7-96ed-4c18-7a6d-08de91ae98be
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 18:27:00.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i+rxjK/XzHpRb2xcMqUYV8hkjZQPz3poiNwrAyrDSG/lPx0jA8U0LWFx5rcDpDAOg+blcHoh5QhcqDO8iGqNgVD4ampg2O9qFdK6CzJowY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604030164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE2NCBTYWx0ZWRfX7TjqOyCg1liz
 ALAh7IKp/ZL68EHj0SsMMy5/RLfWqxaF3FLXWJeD2NzQB/nWsUn7Iqm1MqqKFwF11392K+yL3XR
 CxGQxKR7QVrr9ZBDOS65QRxRzCCT7JN4TIguMgBw23YubNi7a+Rg/p6j52drXpWNE+IK0UszcgW
 mczMINOLxUzbbGti0azHhOtDsUCtV1VqjbahPloZ/niImJYK9n8K4U73BkwKfn0aaNLxDoGw5NP
 S9ETtYZSsuivSxu6oaqxRWVqClikoSXYrF4fCQefW1pDzUx2ySzC+sHNIrkV6IUOai/+qnrmftW
 tODsoaXlVq5GZYiu8XWSdoQ1J3S3NCmTTLeboilSMA3aJGnQvRUDohcWdjMLJey8Hwrw1Up8o4z
 2xu2BNtTvMjTJaVeZhODDMrh+9+a+EityjM2YBymBEBcsK7MSkyNZjkMESW6rMyRHKKw7kjs+Wh
 VEWoptF6u/PasuaSEhUuEAZfMUqrXzpNpaNpBaQo=
X-Proofpoint-ORIG-GUID: 9BOdCYSms6X5jWaCB7nfnhq4Mp1mnjKC
X-Authority-Analysis: v=2.4 cv=BvOQAIX5 c=1 sm=1 tr=0 ts=69d00678 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=lsgxeHaoomOF7BIXuqcA:9 cc=ntf awl=host:13825
X-Proofpoint-GUID: 9BOdCYSms6X5jWaCB7nfnhq4Mp1mnjKC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_112708_120297_6C05A4B4 
X-CRM114-Status: UNSURE (   9.11  )
X-CRM114-Notice: Please train this message.
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

Hello,

My testing of the patch series involves my own extension, userstack.so,
which I've implemented here[1] on top of this branch:

[1]: https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_upstream_v4/

To test, I have a vmcore created at dump-level 23, and I'm using
makedumpfile to re-filter the vmcore at dump-level 31, either including
the userspace stacks, or not using an extension at all:

$ /usr/bin/time ./makedumpfile -z -d31 --extension userstack.so ./dump.withuser.img ./extension.img
...
9.66user 0.86system 0:10.56elapsed 99%CPU (0avgtext+0avgdata 15108maxresident)k
0inputs+1133800outputs (0major+2184minor)pagefaults 0swaps

$ /usr/bin/time ./makedumpfile -z -d31 ./dump.withuser.img ./baseline.img
...
9.28user 0.84system 0:10.17elapsed 99%CPU (0avgtext+0avgdata 3336maxresident)k
0inputs+1132120outputs (0major+236minor)pagefaults 0swaps

$ ls -l *.img
-rw------- 1 stepbren stepbren  577384093 Apr  3 10:55 baseline.img
-rw------- 1 stepbren stepbren 1746475073 Apr  2 15:21 dump.withuser.img
-rw------- 1 stepbren stepbren  578253346 Apr  3 10:54 extension.img


With drgn's contrib/pstack.py, we can dump a stack trace for an example
process in the vmcore. I'll show it here three times: first with the
original vmcore containing all userspace pages: it works, but the vmcore
is 1.7 GiB, more than 3x larger than a dump-level 31 vmcore. Second with
the baseline, which is at dump-level 31: the userspace stack cannot be
retrieved. Third, with the userstack.so extension: despite being less
than 1 MiB larger than the prior core, it contains the necessary stack
pages and thus the stack trace is the same as the original.


$ drgn -c dump.withuser.img /usr/share/drgn/contrib/pstack.py pstack -p 19284
[PID: 19284 COMM: bash]
  Thread 0 TID=19284 [S] CPU=18 ('bash')
    #0  context_switch (kernel/sched/core.c:5367:2)
    #1  __schedule (kernel/sched/core.c:6752:8)
    #2  __schedule_loop (kernel/sched/core.c:6829:3)
    #3  schedule (kernel/sched/core.c:6844:2)
    #4  do_wait (kernel/exit.c:1698:3)
    #5  kernel_wait4 (kernel/exit.c:1852:8)
    #6  __do_sys_wait4 (kernel/exit.c:1880:13)
    #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
    #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
    #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
    #10 0x7f46e82b63d7
    ------ userspace ---------
    #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)
    #1  waitchld.isra.0+0x102/0xc42 (from /usr/bin/bash +0x10bd52)
    #2  wait_for+0x15a/0xda6 (from /usr/bin/bash +0x5b54a)
    #3  execute_command_internal+0x3186/0x3877 (from /usr/bin/bash +0x3e976)
    #4  execute_command+0xcc/0x1c8 (from /usr/bin/bash +0x3f13c)
    #5  reader_loop+0x1ea/0x39a (from /usr/bin/bash +0x311da)
    #6  main+0xe2a/0x1a94 (from /usr/bin/bash +0x2548a)
    #7  __libc_start_call_main+0x7e/0xac (from /usr/lib64/libc.so.6 +0x2d39e)
    #8  __libc_start_main@@GLIBC_2.34+0x89/0x14c (from /usr/lib64/libc.so.6 +0x2d459)
    #9  _start+0x25/0x26 (from /usr/bin/bash +0x26125)
    #10 ???


$ drgn -c baseline.img /usr/share/drgn/contrib/pstack.py pstack -p 19284
[PID: 19284 COMM: bash]
  Thread 0 TID=19284 [S] CPU=18 ('bash')
    #0  context_switch (kernel/sched/core.c:5367:2)
    #1  __schedule (kernel/sched/core.c:6752:8)
    #2  __schedule_loop (kernel/sched/core.c:6829:3)
    #3  schedule (kernel/sched/core.c:6844:2)
    #4  do_wait (kernel/exit.c:1698:3)
    #5  kernel_wait4 (kernel/exit.c:1852:8)
    #6  __do_sys_wait4 (kernel/exit.c:1880:13)
    #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
    #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
    #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
    #10 0x7f46e82b63d7
    ------ userspace ---------
    #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)


$ drgn -c extension.img /usr/share/drgn/contrib/pstack.py pstack -p 19284
[PID: 19284 COMM: bash]
  Thread 0 TID=19284 [S] CPU=18 ('bash')
    #0  context_switch (kernel/sched/core.c:5367:2)
    #1  __schedule (kernel/sched/core.c:6752:8)
    #2  __schedule_loop (kernel/sched/core.c:6829:3)
    #3  schedule (kernel/sched/core.c:6844:2)
    #4  do_wait (kernel/exit.c:1698:3)
    #5  kernel_wait4 (kernel/exit.c:1852:8)
    #6  __do_sys_wait4 (kernel/exit.c:1880:13)
    #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
    #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
    #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
    #10 0x7f46e82b63d7
    ------ userspace ---------
    #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)
    #1  waitchld.isra.0+0x102/0xc42 (from /usr/bin/bash +0x10bd52)
    #2  wait_for+0x15a/0xda6 (from /usr/bin/bash +0x5b54a)
    #3  execute_command_internal+0x3186/0x3877 (from /usr/bin/bash +0x3e976)
    #4  execute_command+0xcc/0x1c8 (from /usr/bin/bash +0x3f13c)
    #5  reader_loop+0x1ea/0x39a (from /usr/bin/bash +0x311da)
    #6  main+0xe2a/0x1a94 (from /usr/bin/bash +0x2548a)
    #7  __libc_start_call_main+0x7e/0xac (from /usr/lib64/libc.so.6 +0x2d39e)
    #8  __libc_start_main@@GLIBC_2.34+0x89/0x14c (from /usr/lib64/libc.so.6 +0x2d459)
    #9  _start+0x25/0x26 (from /usr/bin/bash +0x26125)
    #10 ???

Beyond my testing / use case, the only other feedback I wanted to share
on this patch series, is that I think it would be good to have the
amdgpu and userstack extensions contributed upstream, rather than kept
as external customizations.

Given that there's not a defined extension API or ABI, I don't think
extensions yet make sense to be indpendent: they depend heavily on the
internals of makedumpfile. There's probably not going to be a
"makedumpfile-devel" package any time soon which allows building
and maintaining external extensions for your system makedumpfile. So the
only way make use of the system would be either (a) the Linux distro
bundles their own extension, or (b) the user builds and manually
installs a custom version of makedumpfile & extensions.

The main purpose of the extension API is to provide these specific
functionalities which are impossible with page-based filtering. Ideally,
I think makedumpfile should provide the real, useful capability and not
just the framework for a motivated developer to make it happen.

That said, I know it's a maintenance overhead and there may not be a
clear test strategy for every extension.

Thanks,
Stephen

Tao Liu <ltao@redhat.com> writes:
> A) This patchset will introduce the following features to makedumpfile:
>
>   1) Add .so extension support to makedumpfile
>   2) Enable btf and kallsyms for symbol type and address resolving.
>
> B) The purpose of the features are:
>
>   1) Currently makedumpfile filters mm pages based on page flags, because flags
>      can help to determine one page's usage. But this page-flag-checking method
>      lacks of flexibility in certain cases, e.g. if we want to filter those mm
>      pages occupied by GPU during vmcore dumping due to:
>
>      a) GPU may be taking a large memory and contains sensitive data;
>      b) GPU mm pages have no relations to kernel crash and useless for vmcore
>         analysis.
>
>      But there is no GPU mm page specific flags, and apparently we don't need
>      to create one just for kdump use. A programmable filtering tool is more
>      suitable for such cases. In addition, different GPU vendors may use
>      different ways for mm pages allocating, programmable filtering is better
>      than hard coding these GPU specific logics into makedumpfile in this case.
>
>   2) Currently makedumpfile already contains a programmable filtering tool, aka
>      eppic script, which allows user to write customized code for data erasing.
>      However it has the following drawbacks:
>
>      a) cannot do mm page filtering.
>      b) need to access to debuginfo of both kernel and modules, which is not
>         applicable in the 2nd kernel.
>      c) eppic library has memory leaks which are not all resolved [1]. This
>         is not acceptable in 2nd kernel.
>
>      makedumpfile need to resolve the dwarf data from debuginfo, to get symbols
>      types and addresses. In recent kernel there are dwarf alternatives such
>      as btf/kallsyms which can be used for this purpose. And btf/kallsyms info
>      are already packed within vmcore, so we can use it directly.
>
>   With these, this patchset introduces makedumpfile extensions, which is based
>   on btf/kallsyms symbol resolving, and is programmable for mm page filtering.
>   The following section shows its usage and performance, please note the tests
>   are performed in 1st kernel.
>
>   3) Compile and run makedumpfile extensions:
>
>   $ make LINKTYPE=dynamic USELZO=on USESNAPPY=on USEZSTD=on
>   $ make extensions
>   
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
>     /tmp/extension.out --extension amdgpu_filter.so
>     Loaded extension: ./extensions/amdgpu_filter.so
>     makedumpfile Completed.
> 	User time (seconds): 5.08
> 	System time (seconds): 0.84
> 	Percent of CPU this job got: 99%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
>         Maximum resident set size (kbytes): 17360
>         ...
>  
>      To contrast with eppic script of v2 [2]:
>
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
>     /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c   
>     makedumpfile Completed.
>         User time (seconds): 8.23
>         System time (seconds): 0.88
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
>         Maximum resident set size (kbytes): 57128
>         ...
>
>   -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
>   -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
>   -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025-06-10-18:03:12/vmcore
>
> C) Discussion:
>
>   1) GPU types: Currently only tested with amdgpu's mm page filtering, others
>      are not tested.
>   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc64.
>      Others are not tested.
>
> D) Testing:
>
>      If you don't want to create your vmcore, you can find a vmcore which I
>      created with amdgpu mm pages unfiltered [3], the amdgpu mm pages are
>      allocated by program [4]. You can use the vmcore in 1st kernel to filter
>      the amdgpu mm pages by the previous performance testing cmdline. To
>      verify the pages are filtered in crash:
>
>      Unfiltered:
>      crash> search -c "!QAZXSW@#EDC"
>      ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>      ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>      crash> rd ffff96b7fa800000
>      ffff96b7fa800000:  405753585a415121                    !QAZXSW@
>      crash> rd ffff96b87c800000
>      ffff96b87c800000:  405753585a415121                    !QAZXSW@
>
>      Filtered:
>      crash> search -c "!QAZXSW@#EDC"
>      crash> rd ffff96b7fa800000
>      rd: page excluded: kernel virtual address: ffff96b7fa800000  type: "64-bit KVADDR"
>      crash> rd ffff96b87c800000
>      rd: page excluded: kernel virtual address: ffff96b87c800000  type: "64-bit KVADDR"
>
> [1]: https://github.com/lucchouina/eppic/pull/32
> [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
> [3]: https://people.redhat.com/~ltao/core/vmcore
> [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
>
> v4 -> v3:
>
> 1) Get rid of all hash table usage. So only required syms/types info
>    will be stored, rather than install all kernel's syms/types. To do this,
>    special elf sections as .init_ksyms/ktypes are used for the required info
>    declaration/storage.
>
> 2) Support extension callback for makedumpfile, so during mm page
>    filtering, extension can help to decide if keep/discard the page. 
>
> 3) The patches are organized as follows:
>
>     --- <only for test purpose, don't merge> ---
>     7. Filter amdgpu mm pages
>
>     --- <code should be merged> ---
>     6. Add makedumpfile extensions support
>     5. Implement kernel module's btf resolving
>     4. Implement kernel module's kallsyms resolving
>     3. Implement kernel btf resolving
>     2. Implement kernel kallsyms resolving
>     1. Reserve sections for makedumpfile and extenions
>
>     Patch 7 is customization specific, which can be maintained separately.  
>     Patch 1 ~ 6 are common code which should be integrate with makedumpfile.
>
> Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@redhat.com/
> Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
> Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/
>
> Tao Liu (7):
>   Reserve sections for makedumpfile and extenions
>   Implement kernel kallsyms resolving
>   Implement kernel btf resolving
>   Implement kernel module's kallsyms resolving
>   Implement kernel module's btf resolving
>   Add makedumpfile extensions support
>   Filter amdgpu mm pages
>
>  Makefile                   |  11 +-
>  btf_info.c                 | 345 +++++++++++++++++++++++++++
>  btf_info.h                 |  92 ++++++++
>  extension.c                | 300 +++++++++++++++++++++++
>  extension.h                |  12 +
>  extensions/Makefile        |  12 +
>  extensions/amdgpu_filter.c | 190 +++++++++++++++
>  extensions/maple_tree.c    | 307 ++++++++++++++++++++++++
>  extensions/maple_tree.h    |   6 +
>  kallsyms.c                 | 473 +++++++++++++++++++++++++++++++++++++
>  kallsyms.h                 |  94 ++++++++
>  makedumpfile.c             |  41 +++-
>  makedumpfile.h             |  13 +
>  makedumpfile.ld            |  15 ++
>  14 files changed, 1903 insertions(+), 8 deletions(-)
>  create mode 100644 btf_info.c
>  create mode 100644 btf_info.h
>  create mode 100644 extension.c
>  create mode 100644 extension.h
>  create mode 100644 extensions/Makefile
>  create mode 100644 extensions/amdgpu_filter.c
>  create mode 100644 extensions/maple_tree.c
>  create mode 100644 extensions/maple_tree.h
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>  create mode 100644 makedumpfile.ld
>
> -- 
> 2.47.0

