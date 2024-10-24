Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3CBD0BB46
	for <kexec@archiver.kernel.org>; Thu, 24 Oct 2024 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:Message-ID:Subject:To:From:Date:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=44HHKgPnwut3R2sPzHcu1X6L7xdtkzC7+0RqzeblgxA=; b=ZWBPXASf39zmBj
	7dI6jnIQtyhleudSsqEH5az5hvIXwueGiBOlsKSnrkDpur09gfetfMd6G4uVuxdUepozepvzrcrgS
	cY/rRS8RUerCHxt3peteAgK67VhG6Oj+END6ZhzWz74s+1SrEMANonPbAYdGJBjSx6DVs3dbl3Bu0
	XAcOn8pBAHcn6s3EuPZdAJtjxPVTN6D/vykibuFIcP9NHO26kXgWjUzDGwXiwYFEIUd/X+10+O5FL
	CYhroCtYtyR2L/BBSGnMeG8wN4zNLpZAtuvrn1uefMIKAUsxa9p3iXCmht7bQl9GvB3wRqrJvi6vR
	5Nkie4fxVq0hLU/G8jMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ljI-0000000GK1c-27mY;
	Thu, 24 Oct 2024 00:29:32 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ljG-0000000GK1D-01Om
	for kexec@lists.infradead.org;
	Thu, 24 Oct 2024 00:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729729770; x=1761265770;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=OPsgXG69ctatyL9n/bg/Mge/pe/+95fQit4ZReyg/NE=;
  b=QU+CVy4za7SqITlHReHN3LWgTEqrr+a5JpRPXQmmbaf6lwpPuFsux9m7
   Wz1usX/ws6puADESnsULmkDl/81O7EhdYiAQ6bfW/gPvsMZ90hP32mAKl
   A2ktpU4DPWRyQv5ZUnJCQCl6LGm6BXMfFiCT0G8rIhvHPLa5MIbJRw5kA
   b2njQDBwHXnjC3fXTfD7Evhcv2aPKgUaaSDEA4hM+ja7c+HCn7owZbwXz
   cLs0X23gsc10KBBvC8KK8ga1bBJ9X8yMwtA2NiDpqfDiGADLKScjW7WT9
   3x9ch4HoYfwNSonY/Kkl6Lhq0+HbqlgF9SY+Mcxp9MogVjcGYVhRsHtO4
   Q==;
X-CSE-ConnectionGUID: +ZvCE7mcSVyvFdDJ/wnwsg==
X-CSE-MsgGUID: 1xZA/YbIRzCOk6ue9WSP/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39927624"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="39927624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 17:29:25 -0700
X-CSE-ConnectionGUID: 6+RYJlGcQhOGOH5E7lUkaA==
X-CSE-MsgGUID: KByEDgiSSkKkl3j9aXsJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85211431"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 17:29:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 17:29:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 17:29:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H80t0fBxHs2h1lj1UFHJ4dlidvgClNhz45/OcKwaWIYZl+EpplUG7sIYa4r4JekKAyhYXNT4oJ9QGE++X6cFiqJ0Z4oMw3CWlk8ATwgHBgEKOjSd98N7jtNonM6bhmChoqh/pMKuMXxiLuDEFduoh2/EWv9FNSgcjWxP2ou+VLDN0yIK/4gA/FxdWI2ZXewWYs21edUJnvAtnnqXAsp5NtoR6iBOSq4Y6c4veTmQihH661pIxiIuQGo0bz4yY70KR+XU0xhCJZo/y+gj/LAns5bNx6GuHjn87r5VUzg7g0lJ8VCzIobJGG5Rp0RuQcy3ICZs1vBrjPXUGI7xNCkkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkNWE+O0CoBTvBHM/k6vCnLeDpJ9P2nCkTzT9VbJyuc=;
 b=oMchEWjKsDOjbIeywqCOCXNY83pDxCLDa+7UAxUDRGE37FhL/8RE892qjO5nIISOa/9VU6Z68zAqGqXf3SO8gLgjsoA+h7geo2pagW5JcMtmQfTnKDydGtFn3RqZgPYTUlCXrWwn7dQgYC7+nXoj9jT7Td1/9RD2JXAL7GwzyGOtvGXUAw94G5y1cUomXb64cbomrJ0+zaWxkqWyaFWRnQltxXgTHynta8wxRoum37f2sc0e3eVs6lqnOCeNRft3vgPpZ73i90QUSWFMkOGaKvMteQ5/nafHRS0MIEa4AO3SkG8Cmt9zsXMHo+PT2J3/bSApWXkcigMP/Q2XMA2ymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 00:29:21 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 00:29:21 +0000
Date: Thu, 24 Oct 2024 08:26:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ZxmUU9riSUYmodGU@yzhao56-desk.sh.intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
Content-Disposition: inline
In-Reply-To: <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: a00cb176-928b-4122-9604-08dcf3c2e77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U1P6S0Es33YT0va7ExRbVcMftXWW7KRYipK6/E5x6ovfekbUM7ytM4YV0OAU?=
 =?us-ascii?Q?8v3p7w8zTiCXVCsrbaLUrihUbksFmqwYaxqFNszWk0LJf8G0IQxUguWnBddL?=
 =?us-ascii?Q?GXcseS9OvA/hjvGOGzWRRia3MIxov1URD8H+xWhUcsaVHJZiR3a/sp+A2Ghd?=
 =?us-ascii?Q?P/ECtsj0bAEC+HmunKIpN2+DKyb5ikuZO5HXvBK0AH2xgxY6pTKoa/xBlRvY?=
 =?us-ascii?Q?ewH+i+tX6Af+m8i0O3iIGVq/vBtbAS8vuBDrDwFaV50BEVi6ueKCiY1ZT1WN?=
 =?us-ascii?Q?N4yE4BO/scip9oe+IqTtMehfVW+UqTNu9rttHqkm7eZynUHqm1WJbQ2F5eaY?=
 =?us-ascii?Q?VMlWPRnOyZbHaZSYyyHYfKA0F9//2ocjuQNBDGwpjmJMomM0p4zanXxZ5pcB?=
 =?us-ascii?Q?1yInsKIzgviTGGW9DVBwED/y7to8rS9RQ34ZchX+XcC4Q4mm54GR0ruEjv/2?=
 =?us-ascii?Q?uwCCFqaACn0Ky0pJ+YDWkXv+k7fiGXscxN5NRPFuo740XeNw8PVXDBXXXoIK?=
 =?us-ascii?Q?I5KV4hKjHu/6cHDeYdxxxzR6bX6mOGvvmzwu1FhIYE7Z0aO2UYgQneuk8GTm?=
 =?us-ascii?Q?YSGAVytDrjGdB7xFUEqJYaP6eEfPz9/tAeRMLtxA7+MG3LjVodi8TDXRuhjg?=
 =?us-ascii?Q?X1YjoaPHJOAsVv+40xN/7vgW9pBypEwHOaMRNmfGxLyU2FOXhXYUoOo8uOd1?=
 =?us-ascii?Q?9W/N9EOZve0yYbU/xoiYv5ZGeWWy9wPGKHiy3nnP6PtcRc9N+stxyY91lfXq?=
 =?us-ascii?Q?71bnEEq50980PGkZidEOotwJqelC7Da2Jwc+w3t1YLiFG8ZsGqZCrr4INub/?=
 =?us-ascii?Q?NtCYKvj9sbH1H9JSScRZsLcpuADR6zNpg0W1hyBAgf6yYf9prJCecdTLai1g?=
 =?us-ascii?Q?33sdwre5IM2LWcM0OQVUPbCrH+oxuXs7N+7vzk7obN72KF3C4q4EDLqswZiJ?=
 =?us-ascii?Q?jx5omel7cCYwV3lasyTNbN4noO/pk8LHlhCuEAvSYTF3hSHp+OdMeZHKRyt4?=
 =?us-ascii?Q?VMmEjjF0uu/mf7MH6yR4hGusKO3YPC8vX2kX3A67e8hL6tqXze5BiR1hW4Kk?=
 =?us-ascii?Q?L8dmQ+7sC4wo06PyNWOKAGlLXSXvcSJBy+l/3oITJSyZ308YecyJqKxBYy8W?=
 =?us-ascii?Q?OvOcOvQuHHNGMoFrp2eu7g8chEkMVTj2815XR/LH6buGQ4TsXvK4J884MdfO?=
 =?us-ascii?Q?2vCTp3Ye2XnceZ6AkehoqUrdWANADLc+9aa4HqjQxUO7c56jbqayujPkZOMD?=
 =?us-ascii?Q?CZoToPv4uJwm89eVrqeu+5VrCd37zkTki0hQSAXqG7rFHK2gUxeNK8hvr7Cu?=
 =?us-ascii?Q?+NsTWVUkDau1MksCqNRLppjG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7P7pWQJiAb8fPibXUZ1H4V+GbAfPrQ3jgV7Alf80kOOtoJt1O/XdPw92Xq9d?=
 =?us-ascii?Q?4OBGgZ9WB8T0k0viSIXCpf6C99DCDXV72P0UXzFtSx9HxwLAzKFHzAI3pfiG?=
 =?us-ascii?Q?2FKjN9DujFYIq1cqAXP/V2yU6yYeWBIPqCc/WYNccmAGHCw2206/VVzVGn1M?=
 =?us-ascii?Q?ZiVwSn46f6UL9R+t308jqA1EYIKDUYRPYi3WwfYsKrLxtvdDzEYPvzxwAB2f?=
 =?us-ascii?Q?pSG9NWxc0VYKd+acYilNdbR+DvZbma3RhEX2F5BJPyNBqjKDq2beUfY7Novv?=
 =?us-ascii?Q?md4/A8woFepNVglQcniTCWDPkzjZ4ImF1yUVakJIWENWgpX2/zlWUC/P4uvV?=
 =?us-ascii?Q?z0KiYsfYmYf9wLMfcNvp+kqM6TN0pslBNodV3oW8j36m14C/Z++tlcbkAGF5?=
 =?us-ascii?Q?OMpLhKABdGsp+JNSuOB/u9upnIyeaVHH2HH2qXlbXZytqJ4D1JAhXu9hpkmR?=
 =?us-ascii?Q?nR6E971dSPPWCNoaCgML4+dkq6H8Wp3/IfC71h+UwZTsLp0G5dwyej+7d561?=
 =?us-ascii?Q?NOGSY5Rx52EN7+WSK/VvBuhCiRhgJFrzFYBYUYPN3yqHbDaxUAaf8O3eoEre?=
 =?us-ascii?Q?PTczpZ7fjKhKcF+lPBibQhdxQ1sftKw4M7wDekDjjRBnCGJLjGI+zNtUeNBl?=
 =?us-ascii?Q?oKiGmE2KVKVceqeXOn15EWj8BKZDEik6vBumJLHvFtKEv599RNMV9HNuD7FW?=
 =?us-ascii?Q?uBFVF6/XMYAIspV/j7JvVAtBa4SBz5zy6gYYKr339tVQ+rp3ivEKpF3rPfDe?=
 =?us-ascii?Q?glG16xxLt3jeSj2io4zLJbbMR5S4Gfl6on3u4XSN1inui2SLW8iAH9trDFUB?=
 =?us-ascii?Q?/DX7AWt8gfIER1V+atQOM7iN1eWnw9RRTzJNkYBKAjNFgyphoWAUiUkvmxkY?=
 =?us-ascii?Q?sORqH9YP3UhqOc5yz79kgRvtotaZjEEyogJiNcHMh5HxJ8kyWxmx5f7L6p2U?=
 =?us-ascii?Q?VfYU19E7ONYpEG0xZ3gmViEg+fjig8DNw6kTAaIKlXrvr7VgtFy52NgyvnHW?=
 =?us-ascii?Q?svSdwLcnQTue8vXzTNlV/PH5erKUkQnAn13i29qvgK/noQamYE3Vgk6gsrDP?=
 =?us-ascii?Q?J+hQ+IG4JFfbVwPhSbEcTkMnUrF0nR6yOdssglIgLROa73DtiFeBvrsjWuX7?=
 =?us-ascii?Q?exhOUP6xo3iUunnU/mwpPEY5akUdT6179bjBoSspZr2bYqLrDGL+T1vd3seJ?=
 =?us-ascii?Q?AFUJO/DS2rAkayjdYBUn5bVpup82z9qqP/d6ftuZh9P//EaPl8yI5W85FLt5?=
 =?us-ascii?Q?xUVnz8+ItZZ3yVGnYkrDrQutlCycHaqKs/MnmzrrKfPWmaV9J7uopvcxGwWw?=
 =?us-ascii?Q?4ONlLs/waqY7KY6BwbHMIU7kmFG1qKYcMdYkfIenRtd+19WgRcpLI2k4vCLr?=
 =?us-ascii?Q?sEWOxM7841r35fxmBDkZ+c4CwvW6kwgbT5pOTAwRf7E75R/R0+8ZvXOvegLv?=
 =?us-ascii?Q?DAvxzV52rq3Jc/mS9nBSHcrUme3ke9T/8VkER4+hEKEl5N5B6UdYPO7WscVE?=
 =?us-ascii?Q?ahQrlj/5N0keuKouZduNR2xUnVj47mTvZdtbTccEpOmB+tnG6lN4eKWNG16A?=
 =?us-ascii?Q?lUgS+m5/xOkjSvUH5f/VBxyW+oUZ5AIs8L+DU9os?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a00cb176-928b-4122-9604-08dcf3c2e77d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:29:21.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6kth9Yy8eBD1XkNQvPVUmOfrSFqX5n63Aq2sjnFbg7en8jFOiXPiPFyoDSmMRshe5InryxNFSX6H+YCZQbl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_172930_069340_163D0244 
X-CRM114-Status: GOOD (  30.66  )
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Oct 24, 2024 at 08:15:13AM +0800, Yan Zhao wrote:
> On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > 
> > > Waiting minutes to get VM booted to shell is not feasible for most
> > > deployments. Lazy is sane default to me.
> > 
> > Huh?
> > 
> > Unless my guesses about what is happening are wrong lazy is hiding
> > a serious implementation deficiency.  From all hardware I have seen
> > taking minutes is absolutely ridiculous.
> > 
> > Does writing to all of memory at full speed take minutes?  How can such
> > a system be functional?
> > 
> > If you don't actually have to write to the pages and it is just some
> > accounting function it is even more ridiculous.
> > 
> > 
> > I had previously thought that accept_memory was the firmware call.
> > Now that I see that it is just a wrapper for some hardware specific
> > calls I am even more perplexed.
> > 
> > 
> > Quite honestly what this looks like to me is that someone failed to
> > enable write-combining or write-back caching when writing to memory
> > when initializing the protected memory.  With the result that everything
> > is moving dog slow, and people are introducing complexity left and write
> > to avoid that bad implementation.
> > 
> > 
> > Can someone please explain to me why this accept_memory stuff has to be
> > slow, why it has to take minutes to do it's job.
> This kexec patch is a fix to a guest(TD)'s kexce failure.
> 
> For a linux guest, the accept_memory() happens before the guest accesses a page.
> It will (if the guest is a TD)
> (1) trigger the host to allocate the physical page on host to map the accessed
                                                                        ^^^^^^^^
s/accessed/specified

>     guest page, which might be slow with wait and sleep involved, depending on
>     the memory pressure on host.
> (2) initializing the protected page.
> 
> Actually most of guest memory are not accessed by guest during the guest life
> cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> with the host physical page not even being able to get swapped out.
> 
> That's why we need a lazy accept, which does not accept_memory() until after a
> page is allocated by the kernel (in alloc_page(s)).
> 
> > I would much rather spend my time figuring out how to make accept_memory
> > run at a reasonable speed than to litter the kernel with more of this
> > nonsense.
> > 
> > Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
