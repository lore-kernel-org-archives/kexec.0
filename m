Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363CCD70E1A
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	In-Reply-To:Content-Type:References:Message-ID:Subject:CC:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzmCuP3vswbM16dRSXqjyYb0y7BYF4+uauzdC5l4xpU=; b=evwCVeg2bipmtB85y26EZbiLbh
	MkRCGZGu28lg3SxjPCvmwGMN4JGvsaTB9LO+FkRaW3oG29rN6Hgd4rcZN3VHbObUP9hJ/MpaYOOXa
	uxzo8T6UGrWv2yi8KOszaoypwcYcHj7Pwd7DmRhysyPTRzdtKqrNyh4mTbuoRuqIt0V6JNF+xe29H
	G2L3415V0XFeruFWIl7aiNI60NafVc3EwkmMMWKtCfVJunKc0YVSRsIDkEISRZIFpJtFoMsFieQC2
	Y7DKFoFF5FviCM59c+tLSZ7BxGEsYyA0X0KI/UJM38hrX3IqJ0u8stqcU1Jo+e/8ct7warRQm8AqJ
	fdCkT1uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtyH-0000000GxJc-2zcO;
	Fri, 29 Nov 2024 05:55:17 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtyE-0000000GxIW-2zAd
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 05:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732859714; x=1764395714;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=jxLYJNAcc8WYqGimt11o3Rop1T6xrJN02xGYPdCmJOQ=;
  b=U6iq9cM1P2IUQjSXfu12P9nEU+6fz3BlDDNIzpOGNbiBLgqX5rmOsMKW
   CAtKVbQkns9MqbdXWO7D+on7s4ws4LG7QtTwo6Dh/7OJyOEZiUhhJkg9e
   pVtt6VDIoq0fn8vUTM0ow1Z2zc+mwiKIjhT14TXznYF2R+5MteuTqzMPL
   goJ6YtXFxIhgkq71eVCP1I52PHDJeyvG84nibInDqGDKJL3m4Ff1wMXQC
   NydvUb+OXrI7cv/DZb94Fxz5k+wBl4Z3pCfufhE13XAt7RaS9NC0YSpXx
   +enrhIOfLXzQu3oHviGmaMZAtRqb8ANpo7vL6e1eSOi1sCka/MHs+C/PM
   A==;
X-CSE-ConnectionGUID: hSZpDH3tTDS8T22MdVq17A==
X-CSE-MsgGUID: ugALhODaSTe1q4wZfBZOwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43758993"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="43758993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 21:55:11 -0800
X-CSE-ConnectionGUID: c6KanYUdRdiO3oa321694g==
X-CSE-MsgGUID: AFeFMRt+QTaLRr7CDWWNIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92206941"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 21:55:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 21:55:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 21:55:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 21:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqg508srfcTAmFbsW6JHhhRALLq0fY0a0pkROfcIrGu4YEpqpXcrY/qWMO60d7abeMnV97EHwYrnWBdsiqTpgV08jiZRiXJ6XP0t1/gYQ7Ixf9kTnoShtZW1LiG6Es/kpWXzSbrEpxs3G2XuvOb4yuAyRhkfFy9eMQgILFvDcc819lAaLlLqXX7uZgv/195q6BK6L0OUtOm61gJOMzZ77v8Z5KjbtcaH3pER8kavuHQ5X465p+jvy8T8tlXIyJF34XU1FuncD/ld2dKypLw7Ksgj0xpskSHLeEIUERRjc736rYXRxQCIPrjZ8tlpcFuKzka0Mpz7T4LMcxWopfl3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzmCuP3vswbM16dRSXqjyYb0y7BYF4+uauzdC5l4xpU=;
 b=v8RAm6wNbhb7FI9yUlXWP+kRyd5fv6hd+B4tsiKHo5NuGa4BMF6idf/4aLIA01Vj04YknRKBX3XUOG1KaDJsP5+Mc4E0clsC0ciM3pWSO2SV6na/PZOoyC9JuJKgZ0UfVr1kBx6N03OYY2UQGXnzT8b6vJvYk2RjtzjfqNJ4f056feckN3u0c7wK7GnpxSBkgE1beILc1PweWBH+xmHyHxjdtOb0BCT/wLKli5bqFRM6oeeSGMq0eTOui08RrMQXuQtx2m9lNlg+s1E1BlnPUrl1RtavRiIoAtyx4ACPpOrSqkIgmnq19/PEnAaIHVGsLFHkRIGQl9MJd31Z+C3hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 05:55:02 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 05:55:02 +0000
Date: Fri, 29 Nov 2024 13:52:18 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a1e0a2-a4e6-4e06-2eb9-08dd103a5db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ng8reehj/8B6ODbfstxPKyAQAbOIL7L8rzqhnms9XmU+6lHxdwzTUB4c5N3b?=
 =?us-ascii?Q?mWXqVSJbzlVVAh0fDodgAQwWTpfLRVAsdxJwlrzXB60JlEyC+tTbsihOaLln?=
 =?us-ascii?Q?5g6qnsDAx5vh4H5aYlMUGFd9wMHfRc8u9Vp09042Bn7hzq1NtzR1NZ3a+VMt?=
 =?us-ascii?Q?RYs1v3J/68HJf5+VM9z1ncDl86lpJd9cBqs11vmxpEDerX5Rf3oVC6S+LjI/?=
 =?us-ascii?Q?oZ2PoXjC5dsh6i00B9nWLvIcN5L9Nx6CEymr9jsH8FY/cS5GRr9AE3XyfKHD?=
 =?us-ascii?Q?DrW3v8N+A4T9wJLmeXmxtSk4NHTwS/VRInAaShmbMvqt0oqK75v66GvTWHXE?=
 =?us-ascii?Q?pk7V3DGBLrwcidhWCoEJkS1Nj09x0NdJBYan1Yp+Izs5nSO0B4d1e3Uj4zuZ?=
 =?us-ascii?Q?pvVXtheBRjjmZrq3O61kIOE8Gbg8xPyWr89sAfPtETopP0yZWSsDP/mG0jmh?=
 =?us-ascii?Q?oGf1tnm2euiDCvdnFJOeTeZb/tlvMH1J18hH+ThlDhpA8hIS6KrVW4UeoToY?=
 =?us-ascii?Q?MBQ0txIV4OeK9LfGQftA3FevIMJYsSjh+ghlwHAMBwd14gmXiZCPu/jWTGHi?=
 =?us-ascii?Q?bxDACZ8ygaQW/rKMGfODLF1DeMJSEARokY4L3YQHhWGzhFktl36oXleskxr6?=
 =?us-ascii?Q?Af3Vqd9ieNIIBNAW5JwWFz5R+LIfBrpH/OWPMU7/ZW2LbgLBp+OjRXBSQgDW?=
 =?us-ascii?Q?VqFWcfCUwCUXY5iHCK7I7QSx4USH0s6nsG/WWKaFBKMHHm6VbVPLMsaC9f3i?=
 =?us-ascii?Q?tyqXirERfpqsrj853ko/4oWLNgl2mmi1JOQ6ENI6XSrE8QDUc2aNaGInOp5Q?=
 =?us-ascii?Q?omZP2OpbdCK/4CLAD3RrEZb0jdMx4hNNwXY9F8p69lCS5jqzURXrckgnsPJm?=
 =?us-ascii?Q?rmxv4oZ8xjYIKFNl0fylPQy5NXBBi9Z9rvLLFf6fHgLOdiG5XvjEFSA0SVZF?=
 =?us-ascii?Q?8zM6J7TyixY0V25877c0mwCY9R6w12xNFpJS4tT+qeJEK84EC94NhPzPTsZB?=
 =?us-ascii?Q?aeHA8/BWz4G1hXA4z3ryzOqCCfTWURiD1OgESx0SmAxnzRXGt44lI1NUOsPw?=
 =?us-ascii?Q?frF3BAPsJbuhr0GsX+xHDq5qQ/3LcohwygQ0tfxtaQPuijg4NdTz0CYi/pFH?=
 =?us-ascii?Q?uAhcjBlvy+kVlYIjVTY8haXNUVikPJShSk5PmSt0N3RJSbVNcKy8ZiMUVYpe?=
 =?us-ascii?Q?ixgHPZ5m0bbTBs42lmAzflQh3rqbp1+JFKFyu+gstmhzUpCTnBdXdrkSYE2j?=
 =?us-ascii?Q?/L6dI4mH0XIxpR4N0lQ1+spbG5fInC9ZFPL4a/DkOnn+QRFJHzhn0GTYViV/?=
 =?us-ascii?Q?F5r3bCwbJvssv3PsATvrIIGJ3S3H5/jVJULxY1cCaqsmCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fJvNJdGVtNDZDN8lKwzaMhFYMwqlXdbuZHP5q7tcrVi39ihAvFnUt6NmCOPz?=
 =?us-ascii?Q?2LUYkpfmUOuzCnxjTY8uLeBovkTkbtwkX9OSQGTuBKq+vq3SQD8ah4t7dta3?=
 =?us-ascii?Q?yzg5vlR9Sir6Z3s8rxWCKk1r3UvLvNuDHlf3Wkf7TXDjxBuHV2UQiGykSVVw?=
 =?us-ascii?Q?pzqIWcbgsKf253xgVXyUebt5++mR4bvjHUqszyI9O5kzyRuZ+7FySMPGSjt1?=
 =?us-ascii?Q?3QCr3ZFb/0neod/0wNItVSp/ggZtr5RwAcHVrWIMqrh+NZRgXW7sqAzEfFDA?=
 =?us-ascii?Q?HZdQGhfmL/Ir3VaypsGRe/MOc2NIUNauFhKVjVaBkliHPhFpPSnXtKSpyLsu?=
 =?us-ascii?Q?TOjxfixFboIVGVOBhJJVWhFZ8iD1KdCFYCkWrBFxjrnCb0IMAk3L1W2NgRux?=
 =?us-ascii?Q?ECClvMEOITZCXnSH8CiAXQUJmc8aY23eTmmlVJTu+OaMGObDMu5t/Vel41uQ?=
 =?us-ascii?Q?veBdD39pvpjOMNacCOTdrO8IQ2WKl/l0SIZpO/pSnMuQaFH6ts/17p85ec3c?=
 =?us-ascii?Q?UsBy3C+6MDaJ9lxZPtxJJ7vvRd4s80p6J5EgU2EvF7KAUkNWwO8SI3vFWgAG?=
 =?us-ascii?Q?6usLvVQd9vfgz29Mu2/kCXFRM67k0GzV44rvax8TJULemKmqEggjPU+WKDkQ?=
 =?us-ascii?Q?rTB0Lo2DfdRtbBgrWNuFGsp3Qn8De2LO4HPTkJgDkocyjs9kQiif0TAK4Tan?=
 =?us-ascii?Q?SfjC0DT+4sJgruODZLVCqUZfX/1DH/onucZ+Cr8zlGgUiZ5eSdzVTqsceD5y?=
 =?us-ascii?Q?/EPrU7ivF4sPqpv7jAC/frUgvl6kj9M33ibCqUF9LIC/7saOdfdOcPqGxp5f?=
 =?us-ascii?Q?k0ztf4aovlgBihjOSnhj1aip/eMuegT1wHEeRcJsKAaI+iDtJFVViV7LX1eO?=
 =?us-ascii?Q?8WHJvw7NTi2w0WL5Y7yLfw49PfFeFxHzwjFQMbJpSGSDQr3SJL5FwLaBuFm3?=
 =?us-ascii?Q?iLRwq3KNP606BHBOp6kC6zKZe+AQ/RnE6Eyyits5pfbGffEfXgvyuPFz69Q0?=
 =?us-ascii?Q?SMWUFiBbO9GG8kjNn7nW5bGzCjqdfnQVcaRWOXKMHNJSz74EZl3a7ojABEeM?=
 =?us-ascii?Q?zw9o3nvgW3Nb68ow3UKXDtQ+aiiSLNTy2IOGmdJT8x/d4erYBcXc6YzZ+VRS?=
 =?us-ascii?Q?yv3jaIiho0Ljde0Il8BMm1SrFGw94dAXNUrMCaaV0VWUB9lLI2raaUxEr4DQ?=
 =?us-ascii?Q?nketYS70q2x059AHSQzi8esTxfBtZN5zlVg16TB0bq5Jc917CNcQEjVsQK6B?=
 =?us-ascii?Q?XDnm+6gNHqO4EwEzG2BaosHLDsm4VT+Aubc+lVmNiqIP/3ZEtrqvAViV55FL?=
 =?us-ascii?Q?3Y1ugZGqpvyYTbyctYoVKVafY7zdIj+7ql+f2l8Dk1wQR1vra1y3flLEV8xY?=
 =?us-ascii?Q?UpC/yavG7U+lFx4Q4yWqlZzC/nSXOp8E2xUCOlLDoWvQsEnHCtFq/55eeRIK?=
 =?us-ascii?Q?hKH7iwykzibwwZH8kVW6HmQVnHVBCugrl76JM6C195XxpVtWrWIuo/k7yysk?=
 =?us-ascii?Q?XLhBFgLqsV6mjE6dIWNeyp0RaWUGJs9cNzpalyTO194wUr8OT7nB5PdqIPav?=
 =?us-ascii?Q?y5teLXKW8NeqD1lvBr8ohQ8vcOoNWCmc7c1rkyKh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a1e0a2-a4e6-4e06-2eb9-08dd103a5db1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 05:55:02.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2cQwZmbQ9/5KG9aesfj5ByFujkJIFtqWMpu4f5+gOmNdzWm/q7ajsO+gDa9Bccr9jcxpG+DUg5IIEbfLY6SNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_215514_836720_7B365A9D 
X-CRM114-Status: GOOD (  49.04  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
> On 11/27/24 at 06:01pm, Yan Zhao wrote:
> > On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > > 
> > > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > > deployments. Lazy is sane default to me.
> > > > > 
> > > > > Huh?
> > > > > 
> > > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > > a serious implementation deficiency.  From all hardware I have seen
> > > > > taking minutes is absolutely ridiculous.
> > > > > 
> > > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > > a system be functional?
> > > > > 
> > > > > If you don't actually have to write to the pages and it is just some
> > > > > accounting function it is even more ridiculous.
> > > > > 
> > > > > 
> > > > > I had previously thought that accept_memory was the firmware call.
> > > > > Now that I see that it is just a wrapper for some hardware specific
> > > > > calls I am even more perplexed.
> > > > > 
> > > > > 
> > > > > Quite honestly what this looks like to me is that someone failed to
> > > > > enable write-combining or write-back caching when writing to memory
> > > > > when initializing the protected memory.  With the result that everything
> > > > > is moving dog slow, and people are introducing complexity left and write
> > > > > to avoid that bad implementation.
> > > > > 
> > > > > 
> > > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > > slow, why it has to take minutes to do it's job.
> > > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > > 
> > > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > > It will (if the guest is a TD)
> > > > (1) trigger the host to allocate the physical page on host to map the accessed
> > > >     guest page, which might be slow with wait and sleep involved, depending on
> > > >     the memory pressure on host.
> > > > (2) initializing the protected page.
> > > > 
> > > > Actually most of guest memory are not accessed by guest during the guest life
> > > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > > with the host physical page not even being able to get swapped out.
> > > 
> > > So this sounds to me more like a business requirement on cloud platform,
> > > e.g if one customer books a guest instance with 60G memory, while the
> > > customer actually always only cost 20G memory at most. Then the 40G memory
> > > can be saved to reduce pressure for host.
> > Yes.
> 
> That's very interesting, thanks for confirming.
> 
> > 
> > > I could be shallow, just a wild guess.
> > > If my guess is right, at least those cloud service providers must like this
> > > accept_memory feature very much.
> > > 
> > > > 
> > > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > > page is allocated by the kernel (in alloc_page(s)).
> > > 
> > > By the way, I have two questions, maybe very shallow.
> > > 
> > > 1) why can't we only find those already accepted memory to put kexec
> > > kernel/initrd/bootparam/purgatory?
> > 
> > Currently, the first kernel only accepts memory during the memory allocation in
> > a lazy accept mode. Besides reducing boot time, it's also good for memory
> > over-commitment as you mentioned above.
> > 
> > My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> > not allocated from the first kernel is that this memory usually needs to be
> > physically contiguous. Since this memory will not be used by the first kernel,
> > looking up from free RAM has a lower chance of failure compared to allocating it
> 
> Well, there could be misunderstanding here.The final loaded position of
> kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
Oh, by free RAM, I mean system RAM that is marked as
IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY, but not marked as
IORESOURCE_SYSRAM_DRIVER_MANAGED.


> just from RAM on x86. Means it possibly have been allocated and being
> used by other component of 1st kernel. Not like kdump, the 2nd kernel of
Yes, it's entirely possible that the destination address being searched out has
already been allocated and is in use by the 1st kernel. e.g. for
KEXEC_TYPE_DEFAULT, the source page for each segment is allocated from the 1st
kernel, and it is allowed to have the same address as its corresponding
destination address.

However, it's not guaranteed that the destination address must have been
allocated by the 1st kernel.

> kexec reboot doesn't care about 1st kernel's memory usage. We will copy
> them from intermediat position to the designated location when jumping.
Right. If it's not guaranteed that the destination address has been accepted
before this copying, the copying could trigger an error due to accessing an
unaccepted page, which could be fatal for a linux TDX guest.

> If we take this way, we need search unaccepted->bitmap top down or
> bottom up, according to setting. Then another suit of functions need
> be provided. That looks a little complicated.
Do you mean searching only accepted pages as destination addresses?
That might increase the chance of failure compared to accepting the addressed
being searched out.

> kexec_add_buffer()
> -->arch_kexec_locate_mem_hole()
>    -->kexec_locate_mem_hole()
>       -->kexec_walk_memblock(kbuf, locate_mem_hole_callback) -- on arm64
>       -->kexec_walk_resources(kbuf, locate_mem_hole_callback) -- on x86
>          -->walk_system_ram_res_rev()

Yes.


> Besides, the change in your patch has one issue. Usually we do kexec load to
> read in the kernel/initrd/bootparam/purgatory, while they are loaded to
> the destinations till kexec jumping. We could do kexec loading while 
> never trigger the jumping, your change have done the accept_memory().
> But this doesn't impact much because it always searched and found the
> same location on one system.
Right.
Do you think it's good to move the accept to machine_kexec()?
The machine_kexec() is platform specific though.

> > from the first kernel, especially when memory pressure is high in the first
> > kernel.
> > 
> >  
> > > 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> > > in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> > > Sorry, I just read accept_memory() code, haven't gone through x86 boot
> > > code flow.
> > If a page is not already accepted, invoking accept_memory() will trigger a
> > memory accept to zero-out the page content. So, for the pages passed to the
> > second kernel, they must have been accepted before page content is copied in.
> > 
> > For boot params/cmdline/initrd, perhaps we could make those pages in shared
> > memory initially and have the second kernel to accept private memory for copy.
> > However, that would be very complex and IMHO not ideal.
> 
> I asked this because I saw your reply to Eric in another thread, quote
> your saying at below. I am wondering why kernel can accept itself, why
> other parts can't do it similarly.
> =====
> Yes, the kernel actually will accept initial memory used by itself in
> extract_kernel(), as in arch/x86/boot/compressed/misc.c.
> 
> But the target kernel may not be able to accept memory for purgatory.
> And it's currently does not accept memory for boot params/cmdline,
> and initrd .
> ====
Thanks for pointing this out.
I also found that my previous reply was confusing and misleading.

The 2nd kernel will accept the addresses before it decompresses itself there.
Since these addresses are somewhere "random", the 2nd kernel (and for the 1st
kernel for itself) needs to call accept_memory() in case that they might not
have been accepted.

So, previously, I thought a workable approach might be for kexec to map the
destination addresses in shared memory, perform the copy/jump, and then have the
2nd kernel accept the addresses for decompressing and other parts.
However, aside from the complications and security concerns, this approach is
problematic because the 2nd kernel may clear the pages by accepting them if the
addresses for decompressing overlap with the ones before decompressing.

That said, would it be acceptable if I update the patch log and maybe also move
the accept call to machine_kexec()?

New patch log:
The kexec segments's destination addresses are searched from the memblock
or RAM resources. They are not allocated by the first kernel, though they
may overlap with the memory in used by the first kernel. So, it is not
guaranteed that they are accepted before kexec relocates to the second
kernel.

Accept the destination addresses before kexec relocates to the second
kernel, since kexec would access them by swapping content of source and
destination pages.

