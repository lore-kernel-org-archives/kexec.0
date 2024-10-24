Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA4D0BB4A
	for <kexec@archiver.kernel.org>; Thu, 24 Oct 2024 00:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:Message-ID:Subject:CC:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EZHiUm+JPr1n6+k3ij4EW+v4BAZYYbVh80Dvz6kZX+4=; b=d9pbt7lVBxLPCB
	7vSJ0YWO23vVvl5NXvnYMxni2rNUZLhZ+Rz8G1TVYjch70jCh+vFVzOa8+RluExB2RAmYqiBGS2ST
	p+LtZc8q988+X9goxXufQ8sD71YrlYfiC4KXXbCjvKuSXxgNV6wLioYk8Btq4VO7nyY8XMKLjtjYE
	EG+F750in9OJbtytrUJlnre6f2sSEd5kX30Zmz4A/m7VVLDhoIuk30gO4e0FGL8UbiDIQDYHGryo1
	LhVPFHf19Nw59AqozKdRt8fJGI7g3HiEofCp5VTfLi89PQn0n23UtYGbQoC8HOHRCjpBHQ5IBn8k2
	4MFu4ohFEBkaBt+N6tyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3lY6-0000000GIuy-1QWm;
	Thu, 24 Oct 2024 00:17:58 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3lY3-0000000GIuL-0oj9
	for kexec@lists.infradead.org;
	Thu, 24 Oct 2024 00:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729729075; x=1761265075;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=xgKqCpO9TXLE0yus9gr31waIgr7AewcUEtBN3o+xqrM=;
  b=QoBRiGbJ2kqS+FhkJL4b518v0HJjyAVF1WCTXpu/jezM+MnkjsnGpdOZ
   mRqfmX6IGr96b5HueCRdwFvOTYnKHhDGEgJKDaE0at7GiPvXdAO0jpA2V
   Th2yEua/svUdyOI7ThHqS0kWWvp+Uvzmy9RwAWpgTh8tkSTdbRabhFLP2
   nyDlzMXc7nrMnfuvRRflcWWXQTaAR4rPoZEsROZSjCfrC6No642TJJyIH
   rvzpZHcNQfZdeynSbVeGHTe9rvAFiCDmZPvRRybL09hx888pk1Ra0RBTk
   LjUtcehe5XqU7QxMB1tdCYX9kZuZ/gDE42fUY2ZDJFiKWLgwd+JrhBlPc
   g==;
X-CSE-ConnectionGUID: T5MAbhp1TU61Q2cwu9DhRQ==
X-CSE-MsgGUID: HMGAyJKPSb+nAlEuy3Xy/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29447108"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29447108"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 17:17:52 -0700
X-CSE-ConnectionGUID: +qbNoW2oScS7lir6rsNbug==
X-CSE-MsgGUID: XFRKN4TPRhij0ZskBecLuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="111232419"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 17:17:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 17:17:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 17:17:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EODRxsgCRC6OILxkCnjM0kLduE4RKwVAP6Y7tmRxpDFgZf7a9RhuOP0hJcj2OdeOi4InMBlmsXlzBqD2MWlD6LNy8rsu5P+frT5jxA49QjgHAAuFjuQ5yhJasNdvPmydDi05kMCk73KryM2GViLMgYP96K7RiS40pWK7kmXhywlwfzjs47tGV2BfZRnKBxg4qbsiq9XekOvCqLox3+rFyMqp7qDotOQR+Vp9/nUgDX8Tr/VB0pizfwCA82i/dv73YjUqUXUo6CwU4mFt1YkL9CNvePwMNb2OZIh/ImNsiClvppaMSoY5JFtvRslKiVHW5OGHSYfwb5Q/ayJzIHp1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WBOBUDQsTuPpCLNTV0nOXTUnzqcD3sOJScnGSgePoQ=;
 b=ILt7w1EjMHa9zqO/w2jv2icUoFb4VYGbxSUggA6HWlZUOjm7u21ao2unDlSI4iwixE7uMx2plwQFuCUMRigKgZVmPrcFJTMB98H0z2yg1M6vnKOq64CligwNfglfgvBMziLU75tNM0ITbpG7/730uYCEx2fmxo9q653G2UuFf3+omRZHdrEPnfKBGCsFvgZytftTdahnlOKSyZUvuvYob514EJbwKFun9YMMIBCMQIxmg0Yf+WhfiXYVEJLV+fpZ3zQNhdAqlEELEKLCCxZXRO9DRaWYMF3wvRlgpgzHqJx9h8FZyvb/tHWv/RCIiCgZ7ynt++dQ0xwq3FX+MjF0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Thu, 24 Oct 2024 00:17:41 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 00:17:41 +0000
Date: Thu, 24 Oct 2024 08:15:13 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Kirill A. Shutemov" <kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
Content-Disposition: inline
In-Reply-To: <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 660a7b63-c13a-4e62-2f5e-08dcf3c1465b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84he+p7exQ2/73DllVeuoTcfss8AG0hIi+y3WSLRcU9+PM/7/SWkKEepMYXK?=
 =?us-ascii?Q?XUuQ/SWTIhpuT07RXtyR7SPGwme1Xo8QcCwUAaHqRyWeMXd7xUSednlmmoWU?=
 =?us-ascii?Q?pnJuUNzYoUfye9hgXPYp4/jxIePyatExggnJkrhByNwKoMYbFvAQkPPa5c/V?=
 =?us-ascii?Q?SCoNhi03gIPjtqu5mtsvieINzg6W7onFmaNQZttlTuU6CzpHlj5qw6ctGC6t?=
 =?us-ascii?Q?CxN8yVqcxvahdK2jOXiCmlbN3PhktFJ5L+vq1QF8J4Yk3htgltdVICr87aSf?=
 =?us-ascii?Q?Cb3WW3dp0Slwvpekc4YJirdJibxEexogKTDmGshv7q6i9/VEfDbvy5MRHm37?=
 =?us-ascii?Q?zsY57oTe2dFLh84+0qddPAs2DRRXqZfpyDZlFghQxIs7no3hq4M2oHh6Yndk?=
 =?us-ascii?Q?wOSzGW/5vhcAa4cFr61gmXRM6gKfwedeGy0mGtZNOmlYK9SY79fWPrqBGPvj?=
 =?us-ascii?Q?w1lLTiECDpue1r4jyspHaQE6gyP+TdOGNsDJJnhi2oDhwXQusMNbRaDaijmg?=
 =?us-ascii?Q?5xpPBEOuWdIseHADat3S6zU49oiph+VQkYsfrVZ+h5iNQf2RQIk+6RUnVYmd?=
 =?us-ascii?Q?neqwbws/RNyQqgDm6ohg+N6oeTl1eUzN7cR2C+/Ljc+G6PPY+bHesEB2Nk70?=
 =?us-ascii?Q?iXoKncJPPsRVqb4xzsr3aTi2NumsTDkqENgwf55pfkKJ2pe8nTxlBBWZQ9Cv?=
 =?us-ascii?Q?wD0iTX4to4nQT3x+9PQSiHAxluXl8hPoQxGFKInj/hF/pi0htcgPJ7QjoPnJ?=
 =?us-ascii?Q?in10m7YX128N71oPJE6Qqe704qmPbgkqn9woPb7c2jZuyqlQmLqB4eHhIk/U?=
 =?us-ascii?Q?RKC+1EpU+ib5KQL1XM1/O/K3ctpK+Kn2QNm+36Qauxtj83J2qYCJRZh+Er/7?=
 =?us-ascii?Q?CfoMls5WJS4+8L/ADsBXtCzpsUvPhSc5b2h4isf7ru3GtQiIH2J9bDg4EpfL?=
 =?us-ascii?Q?qErwggV1mMkvUL8z42/edTbTVCN0hzzrwgUbfV/HyJ1VBMQf0ygAlH/pZjYW?=
 =?us-ascii?Q?156k1DorQqptxSnFj8fPQ1rx4LUKLskbZZNSk4uFnutuZ6rVRVZN5InmDMJe?=
 =?us-ascii?Q?+uYckREdRyiG+o9ulCukkxjPVfYix8RZajYlf3EV5Oo6R1BH3ww9Qk+LUkFk?=
 =?us-ascii?Q?jUAFPRB4MO445O9zA+Ul677opRSU11pLV2Gk4MqmubM3CsFJgSRtnkITu7lW?=
 =?us-ascii?Q?mKSGSKf0krjmswB42zf34pBij9Ar7BrPdfmS8xoT98JXkX8ftWZH1DbEQJpS?=
 =?us-ascii?Q?uN6xwbqlLj0S7v4lCfu/QwKIM5QAo1E6w5IcuxIExPjSSmZXNKdqOcN/6INQ?=
 =?us-ascii?Q?E8z2+1GaDbCDFRjxSaDpnakA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DR/XJvXN5P6jmdDzouRkxk07v7Y4qfSqMI8K7t7hEGT0jEIs7ZPkTn7UIYXp?=
 =?us-ascii?Q?KpewzWd5q/+13VsNo+xedpGLijtXXFSPjttFcg/j0jeJVWoeVqddTyk0++rI?=
 =?us-ascii?Q?YmFkO7szn6vlMKQ6wfwEEL4p9y8IcWaqNDE9tc0LFLVom+EVI6x9a+Vg+v95?=
 =?us-ascii?Q?ls+XX4vbYD2ty7grWVEZ50j0tSNa5/oV63kuB/Ce6/3ZImYhSWb0e+Wz0+oE?=
 =?us-ascii?Q?gvN0WgfuJQr35M3l9AdbwT2C979p3YZVSb8AmKBtRVrxVPROQVD1uBQfOjV8?=
 =?us-ascii?Q?kBoyyE4aBcElkK1rHYlZR0JIcJGEACmwCTu3yCFb1iVKjRmIpc9cX+9ENBb+?=
 =?us-ascii?Q?bcDXmnvc+yGe5OGURUNS0Dt9K9AkmdIrqB+kP2zlJK3+OciBVz1/kX3e9h0P?=
 =?us-ascii?Q?z+0Sy4DgFzNJWaz52Star7RiEkTZJotP2XgNmbqodt/0OwwzlX+Eb6/h8oAp?=
 =?us-ascii?Q?/8lrqQ+GpXJ8sZ2isOoR/nmeQrb/0A099Fe7HQ8BeXJnky1ubmJWj+9xDcNg?=
 =?us-ascii?Q?fl1VZziUH5qWeYll3N7VEsVxYTLAWeLpVoLE2KA42bnk1n5TNjfiBV81IO3D?=
 =?us-ascii?Q?3BVuiGl//WR+DDWc5lFDa+gcG0CXv48eCCu5oCPliqFwd4sxz7RmTL4eg/fx?=
 =?us-ascii?Q?9fxcAx5Zd0qnFVQAMRIeOk7TuKlLhNhBHcAX0RE25lUoBJrh2T8gBZO+wEgs?=
 =?us-ascii?Q?u92ZUaPUGFfLktioz0XUuGkjedaYDQUBG+PPqtg1UIRcI0U4jU7mHEgUpw2f?=
 =?us-ascii?Q?JoZ5IBRDmOlZqa+iRLprz6h8PdN7YDBzaXHjPY+LnRq5qV23OMb1S8IpGDfd?=
 =?us-ascii?Q?LklkwQOA2uuKbDqe22hfX+fmqFmncGulD5Z8qablt0nUvvVVWPAWwr0d4pFq?=
 =?us-ascii?Q?qJY4wLWAwB4+8AuvZaRNrj4u0btveJ0bNwZ+i7Tk2V5fe3omxKfSusilvNQi?=
 =?us-ascii?Q?JFVT1vGglDa1+k062EMX4LCliaRIPCxvYVNSNqjF9sXmiXYM1/6yhbckc1h+?=
 =?us-ascii?Q?AQvts/MH2y+F4l/1qraVF5vWG0gku4OAhZgCVI3inlIg+KJk6FMz3imK0jM5?=
 =?us-ascii?Q?5BFX7oZz/WHGZv+nlHkStM0Lwhe27x8nP/K56jvvlIvBYVeJNRQfS4yn/zi2?=
 =?us-ascii?Q?6JTMZfitCYHqCpa4QGGibXya3yMdK1TylLLGCfJt/nVlq04vbXfhfYZCec+6?=
 =?us-ascii?Q?NMIqP8E2NIF3EBGHZPkyFLaJzu7vxsYHAPJQNShdMt8iyCv3RJr0q+TOB1SY?=
 =?us-ascii?Q?1gw2E+XgeolZ6i2Ud/x5jteepFsuvDWe2FKtCxbKmKl4uperz0KfuTi4NjT5?=
 =?us-ascii?Q?Hg6/SmnORuCX/+preNyBTQ1/uw5SCnBZoV6OP6kJad5nxXhNsIz7hCwNxO/i?=
 =?us-ascii?Q?bxZ3i3Lp+JGCa6eRJWRAWAkRHYThBIMBsqpDAZ81yTSwosVnhJYhlv4OFkgp?=
 =?us-ascii?Q?qaM1YFuSQu2lXFyAGgqdVpBUpJHJ/kEc2BBlogw+T5Dj19YG7SSk0kM4gdgF?=
 =?us-ascii?Q?d4PJcS5ggYaPnfd9R+aDrjWHaF0fhaLaogYxxYecIF/ZRUypgAP+W6sy3GIC?=
 =?us-ascii?Q?lYyzwK/nOdORF1h1djD1X49puv5m3FnVbtwy4RsT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a7b63-c13a-4e62-2f5e-08dcf3c1465b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:17:41.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzu71nvIrIzCRjmUOU0qQ35EMcdhghjDgw89clOgz98f5tkCAqLGdoQmstvUG9YiP7y0YIiD2ACfaZSMf/sCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_171755_347208_0F59EB35 
X-CRM114-Status: GOOD (  25.68  )
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

On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > Waiting minutes to get VM booted to shell is not feasible for most
> > deployments. Lazy is sane default to me.
> 
> Huh?
> 
> Unless my guesses about what is happening are wrong lazy is hiding
> a serious implementation deficiency.  From all hardware I have seen
> taking minutes is absolutely ridiculous.
> 
> Does writing to all of memory at full speed take minutes?  How can such
> a system be functional?
> 
> If you don't actually have to write to the pages and it is just some
> accounting function it is even more ridiculous.
> 
> 
> I had previously thought that accept_memory was the firmware call.
> Now that I see that it is just a wrapper for some hardware specific
> calls I am even more perplexed.
> 
> 
> Quite honestly what this looks like to me is that someone failed to
> enable write-combining or write-back caching when writing to memory
> when initializing the protected memory.  With the result that everything
> is moving dog slow, and people are introducing complexity left and write
> to avoid that bad implementation.
> 
> 
> Can someone please explain to me why this accept_memory stuff has to be
> slow, why it has to take minutes to do it's job.
This kexec patch is a fix to a guest(TD)'s kexce failure.

For a linux guest, the accept_memory() happens before the guest accesses a page.
It will (if the guest is a TD)
(1) trigger the host to allocate the physical page on host to map the accessed
    guest page, which might be slow with wait and sleep involved, depending on
    the memory pressure on host.
(2) initializing the protected page.

Actually most of guest memory are not accessed by guest during the guest life
cycle. accept_memory() may cause the host to commit a never-to-be-used page,
with the host physical page not even being able to get swapped out.

That's why we need a lazy accept, which does not accept_memory() until after a
page is allocated by the kernel (in alloc_page(s)).

> I would much rather spend my time figuring out how to make accept_memory
> run at a reasonable speed than to litter the kernel with more of this
> nonsense.
> 
> Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
