Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3013EC61DD3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wbMc/zI13jW+FneKTyhqqMck0xlNBC64iaADhleB8g=; b=NHptV0N4nZyzyHMUPcHTu6jDAP
	+18rC2vk7ubFtK9TgkaAQsp3h1WCiqXd56pnNsOl4ILqq8ZQ5bE+iCFzh7ADHNS6wyb5AT1+BUw+V
	EjOjXopBs7aSE3ac+YhDLwJSJ0n3esBCp9NrvYFe5FVg+3lE/k7FIFhfVubuOyL+cxbWdTFbvGDn6
	c5/zTSdAGWUWbhvkirzRJs+VUYiMebXz4U+yBe3EMd8H3rVguGMr3gImSiIZZwIzwNv0mcD6lhVXF
	7bvR3xoxYkhzwEu6Ux7Muw6G4LfRD2PynINO6EWY08NPAjCc6UMoOOxOwI0/nFBRyFIJMCBn4MoBR
	ZAv5HMaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1If6-0000000B5wi-1ALc;
	Tue, 01 Sep 2026 07:12:04 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1If3-0000000B5vB-1uSL
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 07:12:02 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68178NHk1563154;
	Tue, 1 Sep 2026 00:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2wbMc/zI13jW+FneKTyhqqMck0xlNBC64iaADhleB8g=; b=
	a2iofWah62qXqjvEB2QlyZuM2/XZkoPgZp4pMKF2SBoklhxS1eb4YaBNKr8jsh+M
	5EJYwezFiRMbxEJ1sqvAkK7/UeX85wcZinVZLoD0UeCxVWUV1gSjpEinoOC+lTO+
	UMm3IFUULz7stuRUJlOoc6dH+nGOoT3w/hsxn/AI6DGiN9lf8JA9xbW2thrA2PWC
	+JC29eZeRRcdxUNaJkzJae7cxHY+/FQ0w9jmVKZR6H5juDR+YODzxEn+d6HhimZI
	AoLfln/rhHeBroQlmU0qcz7cjRJrtKbWEDX01qdQKX46vQPL/lHQ9ib4bdqaXCfz
	U3BiKzoDzX+WQMLME8Wcig==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022073.outbound.protection.outlook.com [40.107.209.73])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gbxxebp38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 00:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgvYlZzGvc4dskUzan+gzYUyMwUgYjoLskRx7Ls6qNfd/gthZ7BOks3z1+SRtrdDnEfHH+JWg9RIr5Tqq2DJK1EQ9R1QhqrXf7qGphkQwpbu6f3R74A/L1FKDeR/3nOmLw9E3YomQN5O+YP/CmsqrccsGawatMmMAoCmyMMYw49DPvBmDkC051seI3xUr9lNbS63zImLi3dce/wbkK86nI3rTmus5yPanlMX/s6Pg3hLc8owg8hOOfXOrksGD6aZYKEVcEChyUmBB+fk7oMsI1UF2zTUjB2tJUtVdx/cwd08OCOr5bcBAOzBMlFx1EX37h7O4eAzVS/X6o6vR8o0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wbMc/zI13jW+FneKTyhqqMck0xlNBC64iaADhleB8g=;
 b=eI+W7XtTIwsMVWDvtFrv6BxSeu+3WRGMW8LPPjn2BJNkP1trd8x1+NQVhbkkTnEeBMpiL0FoCYYxWDRpxP4psjOifQqvSPM8iE36/UQKm0+XPsZtnCXczGtBtQNv7udT3ec+6LSXlbbfmvUhQDoxtSX2FLikZqgcYIPTxOdRgR6yp8KAvtuDk8TV3EMtRmpa+80FkkpWbaGZUF73t0NhxzxFMpjizup8HvcCYM/TrmOSgmpuaZKsomiMWE1ihdZKVCeQ+vdE1vKKbl1aYe1QkcVWnl6fB6CNRkMY0T0U1GVbH8OuI8FI89XbRHkOya/F/LIieddSSKrRq0Nk860J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:11:25 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:11:25 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, brads@mainlining.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing docs
Date: Tue,  1 Sep 2026 10:10:41 +0300
Message-ID: <20260901071041.16311-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901071041.16311-1-ionut.nechita@windriver.com>
References: <20260901071041.16311-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0079.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6115d74a-ca99-4a1e-eef2-08df07f83bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|23010399003|52116014|1800799024|376014|7416014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2lzdCvitdaAxlUGHYIvlTk3jKwyoaJ0KN6wah+DWwR9snaIQZlQgIe1dhcV+J9m6m9s92SQ5RqmvXvm2p9CuI3moVd0VCGtlWVrAKbLcdzwR8o+cAwBRZ835m5mB2/WQRRwoSdSY1p2HjCyhT875/XE7I0WJ0AkyD60txfbtuFvFonsMcdKR8mxFUUbu8zHOA1pAli1a4Zk+ggi11Ui8626IqtPgByph3YJLYWK+CzgTo28MP0df+Csi0kmfcg/+TC1PaEcwlLuWEeaM9KJ0OG00yOQDdvXX04Ys3pYUzFbnD1SiCkEGRxZQd8LgvO6BwJtfY8d5Fwz0bC/bsu9lws9dcbmC32Oo3eW69qBNVJuePwRMxGND9Y7A4xioBiL3hWIVHwsd+wkzIy7tX0tdcBJEv8szKV6yJ8yco9tQfiygASU33A86PMMG4yxc/RcSQ3v4ACagLedsz0JQ+qyYSQitsbttKK9P8fG8x7l9966kTcAi4ob6YefN+OZo+kCRkwmmwecNIwxz9Fi+5l6ySjDRSWQA9w0i1sYaSPcKxchQpIzN227ovriJf3o0T5lyPS3ZUyGUF2zWfyfpdhDO2AwarSukDR3tCu84dgY5ffWfRXaBSLfiarl4Juelhfl3LFaP7eep75bqK1+35f8HfeGv26ImSUf6awc7Q1Y6caw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(52116014)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuTPhAL7uWsN2ZfNOl2sX8P8QrphLiHIqf/9zPjtGSLCIElDasfEsy6vC99l?=
 =?us-ascii?Q?+Tb5pYSLtgOWFAuGoV2TczUJ31Db6gIWYvidd792kDg2d6FsH5Wl2o1/MmiO?=
 =?us-ascii?Q?XBAn2QdIjuBJWBI6xSBIr4OllA/0thJCMeJYAHzTUmo0sOeOUnHOC3nxjnjy?=
 =?us-ascii?Q?2ObQgHL6Bd51PeTBluIUlbgpypNjQBcUC2iEoSRmBUdzvnWYGm/4QzeVxFSf?=
 =?us-ascii?Q?7SnAWw8U+hDlTqTT9KyRzSBhiWFYhX59tPaj6FYOUxY0obWEcaT2kRcgX+fL?=
 =?us-ascii?Q?uV+mBPC2VnbjJRAYXjT54SgVl98FuFQAefTwdCCTshdYb33VDn2y7Xcewm1L?=
 =?us-ascii?Q?ZGojZWgFH/2EvQo64hemI4sKgz/uRwJnJNfi8RE7ufqm5Q5Xi0DqVWDiFQKG?=
 =?us-ascii?Q?Lp3Y3RyV+IUrXVICBmlitD1y48ANaNUDmkc9GVb16Dl3+R28GdpWidsGxPhG?=
 =?us-ascii?Q?0Fs4JcH8oADmEuUKCRV6NZuv23tjpjO8y1zTHAb+m6p38/n/n5ETyt5O4uhl?=
 =?us-ascii?Q?CpJiKW4rcTPnPbIIOSW3DGawb1T7+rD+tBUoRZAfy8WVluGi1pMU7Gqy5d/f?=
 =?us-ascii?Q?ud73QuCmnkO20L0FUTPlO/0bZ+0Dk8Rj9bv21ipGSywJa0Bfs41ywY4PPKZv?=
 =?us-ascii?Q?24UTXfAfzlBhuITnuZBUU6BCJKKFadzCkoQ+G+afBVsXXe/xZkKei3oV51T3?=
 =?us-ascii?Q?yEr01VG6nzoMqRO5WBRfvBhRus3jJW9tuBkBLn3sJWo2ExR2I1MkrnzOIaxv?=
 =?us-ascii?Q?TEOop6xCmS/p8rU6oB01QF0uAFLvZzWCFcbfk67PYYrGP3geDYmmxPjKhb1K?=
 =?us-ascii?Q?EnG/mVFa8rANuMWW4SK8y20Uhv1ZOkbSKaJm9vdH1EfYKz/NxdJ+1gwMJMJS?=
 =?us-ascii?Q?vWr6N0p0VOOCLA1CXdW6Cq//ixHLJzYmMdkHhezymeoWcxLdH+xaTqZpQ+ft?=
 =?us-ascii?Q?WYCd1+Yq+cIUC7sQ6YWTRte2UtaEM4G8aawf3ljFE8ytNRixkFXiNAqShr49?=
 =?us-ascii?Q?N4ytHfx+GnNA8s59LzOHddoNtde1GkVf76XkQQ2C5zYLj96XsnAl3Y4ZH171?=
 =?us-ascii?Q?DUmvyU7IWfzqgI0w5nB0rF76YHBhEy57phnkSml8gxRfFyY3OSztSV9ZtIAt?=
 =?us-ascii?Q?z2cxpTT7f2rECfVn9OjKl4sKW9aFkLVDHRh0E+xILcgJUE/Cas50VWonzFTT?=
 =?us-ascii?Q?FRYh175sW4aU10s5xT7UOuYGP+XSWK9ATwrAb2XMcP9jkmHL4y357BlWQZqA?=
 =?us-ascii?Q?aoek4NCKoKyUJb7UglzfnqNE7c12b0Hk/h0HrTA21jK3DxYciN2GKgrlyANZ?=
 =?us-ascii?Q?e8Q0SPQT7WxfILythLuMhzcXefrKIz5BeCPZT5oIGWuNHKbGoHCuFxI4e88v?=
 =?us-ascii?Q?q3suxPjfDOR+4odVVHs2bqKCNDSsWG34CNR/5cuNog+j6wK/nwFkz0+XP4IG?=
 =?us-ascii?Q?uXgUNy/CrQB/vbMk3Eti0TrQLp1HraL9yYvIjs8sSEMNofz4o0CDcUQQlEiQ?=
 =?us-ascii?Q?obIy6LurQyH9KOr4+0Djo1tzNk/q+xjyXZF8mmMi4lNjnflWNKABKbweF9cb?=
 =?us-ascii?Q?iLdWimC6tcQNyMSV2oopHIPQTXIrAYdqD/zXMnqZyYqVy0KnrVbqZluzvfnC?=
 =?us-ascii?Q?uqAA3zOFyE+bqNjhiBdN7sQMfCsQ5xgKgdIeRF2bqewSM0RUo+2YPi2I1Zy0?=
 =?us-ascii?Q?3i8eTXWVlE916gOeLj+9Xpw1Dff+M0FjASSImYI24Ba20jfllFAnq/e5JoT8?=
 =?us-ascii?Q?oqIYGlJSKDj1wGqIaJNPb8jbA/7xzvntcEP+GE5W0woIV3QAp/X4ti3OtLk8?=
X-MS-Exchange-AntiSpam-MessageData-1: 8WJm3++c1ajJ+eqYW6yDmOUrzVqyF6Agbus=
X-Exchange-RoutingPolicyChecked: uIA+lAD2MTg2Mo+LlHkzuPQWm4XtPoj2PeESf5I+v8FWG6eDe8360wdHK7BjN7Ts5iB0hU2Llpeo5r9BbKA6fQ30X4/5jKk16ux3JxL1LEy9v2tCvgI1lYKu1PVxN5aUfGXHTEp1mBxpmdExMeWDdQmWVBvdOdKOdbDLsSLo7RXV7C7zQhb1S3zp+GmVh42asASm8lgdMtS9ysEYFRxwF2M/3X2h6uHChs87n/A6tDSM6ghSekc/OXUTE+vVpNDyR6+kLrSqiLQW/9qGmqo7PR4+E8V+ah6g5bupVB4WVN/Sug0P3zyRLlVzBLGtTvPKRUcXfQjKMhc3N6zyIPnzOA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6115d74a-ca99-4a1e-eef2-08df07f83bed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:11:25.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xghlkGCYJ2Vrcfctc4BnPJKHjKU56gvW4y6+SZUv2I+Xr+2ht0AxMVZPujXte210Bh39lyklXVjqWEaoUtmYAU3rO9LceOOcomKThJHdamk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfX09WCWwmhchks
 kb96YqhMCUjsqP/cJQFZdNChW5HND2edTbmjCGsGM3qMlVhySggy2WfTNR7rHKY3DMoC3kb/xbK
 lJW2dbtADWuZrbYRD+ayL98W48JBQbf9FdfaSIHoPX65KZenp3SlplGGqVAOH5qskS1JMdfTEv6
 YFxjoHbqWzc0eIpbsDhC3/Xm/5uKYHNI5Eh0y+EV9BY6Z6lN15+5E1mjk40LHJsUyobZaX0stGS
 k2EhkVsrrQM6oNAGHXD0c2tZvg1lA5iUohpsQV9N4eJvorS7DBZ6tocgyAspDZF/ZmFR6yOHyTD
 xLEDdl0REeT5aegmaYHtroe66r7O3QCMxAvyUENNnEkK3wXqChgi0hNTyPPf2y//baXNHoaD3Iz
 sbD7fue4m/2mYdEYWD+s9nIJO+NTj/CvIGk4vzvurls0fIkpbH8kCOT53eslNAS6m00hPM77guz
 kACWOFieYHbxDWYze1Q==
X-Authority-Analysis: v=2.4 cv=BJaDalQG c=1 sm=1 tr=0 ts=6a967aac cx=c_pps
 a=nTv9GYKPVLLC6uM4GBPpxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=OuZLqq7tAAAA:8 a=RxAQHiabxDEV-jkcklAA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfXwtGncIyo0QZ5
 FOWB508AZgK0lTdB2ofl8uFRmw2JXF5tLSMJto5B7aJTR3lKHCs8ek0MBlRpxfCdqX8kJmts+Ja
 lmnJeRkfAivscq9d5ikDOy44Bg2o9vSGOksjy7+UzUX4+YhpMn3b
X-Proofpoint-ORIG-GUID: qE5mbBtvxl-yUxyQtRuw75yimndemixA
X-Proofpoint-GUID: qE5mbBtvxl-yUxyQtRuw75yimndemixA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_001201_505171_AEF95CD1 
X-CRM114-Status: GOOD (  14.73  )
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

The elfcorehdr reservation is now sized with NR_CPUS, but two comments
still name NR_CPUS_DEFAULT: the one above crash_handle_hotplug_event()
and the CRASH_MAX_MEMORY_RANGES help text.

Update both.  Documentation only, no functional change.

Suggested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/Kconfig.kexec | 2 +-
 kernel/crash_core.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..a97ed9605602 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -167,7 +167,7 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory regions that the elfcorehdr buffer/segment can accommodate.
 	  These regions are obtained via walk_system_ram_res(); eg. the
 	  'System RAM' entries in /proc/iomem.
-	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  This value is combined with NR_CPUS and multiplied by
 	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
 	  segment size.
 	  The value 8192, for example, covers a (sparsely populated) 1TiB system
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..d0bd2d0cf899 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -648,7 +648,7 @@ int crash_check_hotplug_support(void)
  * new list of CPUs and memory. To make changes to the elfcorehdr, it
  * should be large enough to permit a growing number of CPU and Memory
  * resources. One can estimate the elfcorehdr memory size based on
- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
  * excluded from SHA verification by default if the architecture
  * supports crash hotplug.
  */
-- 
2.55.0


