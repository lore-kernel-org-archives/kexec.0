Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D01D609C1
	for <kexec@archiver.kernel.org>; Wed, 27 Nov 2024 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	In-Reply-To:Content-Type:References:Message-ID:Subject:CC:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaTZcNgjVpnlvi7ycnJW+VaezI4KbEwKoz411nEoP0U=; b=WNlSwxxQ0PBS4vlhkVSnGVfOA7
	ccz2oXdb8CTUimLzeurRzpi0ccIwpOawclckQnqMWYMSBmdObsYLsT4jUPuBhroUXgdEsC9fmfeUh
	0VYxCXbaq9L438quuKEkGQKwucs/tw6J1NldTACfiQ+pnbpHOsbxR8DwskgCvhLRN13eKSIZWrIFx
	7aYLcQIWATB1jLK3i6oz5RHCaWz7R8EsWtp52r/FieKEeQ181leWwM2zONtjk4TBaEsBknBJoAWCs
	n4QtlW3AFwuPe9EXcGMANqMi7iHtMQm6UgmNcCiZ48f69soKuTYHds1krKLylDAd4cD43kKzN29nE
	X3BHvB2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGF0E-0000000CnJu-0Xfs;
	Wed, 27 Nov 2024 10:10:34 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGEtj-0000000CmA0-07vY
	for kexec@lists.infradead.org;
	Wed, 27 Nov 2024 10:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732701831; x=1764237831;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=QYJxnbinFYIQx3eLf7fKCOuXp9z4GQ3oqNLN3Nvbq9A=;
  b=EQEtnu2db7NtD3J6vKLtkanB69qUm6NkOF+ydblRD0772DWYaCEczJHw
   opUgtmChe4UawumAUSrzUt6GIJ6Iruv+BjEzs9vWETUk0/W36AViNRl7X
   X2l6wWghJp+SnTntUytqpSU7P9OlFr6EF6uwYpfuGutQvOg11gulakk9C
   vox+UmtSyXNkH1nM/0cj71507Ly0yOE3FzkqtncP2od5WjhF+G+qoXt96
   wq1elUkJUZt7oty9ozIH/eMszxDxDchwpva7fRRrTZZ8baWH3gwvzI+BT
   9m1BhhUu2T1zlUqqFjO8XXvWkQrjCxnrWa3p9lVBZ5m6QFrqBmmyzPLi0
   A==;
X-CSE-ConnectionGUID: N1IipjJ2Rk2510RpUrNshA==
X-CSE-MsgGUID: NS+7l8JxSbeh/4I0FhkxIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="33148237"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="33148237"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:03:50 -0800
X-CSE-ConnectionGUID: nT3oAauwQw6gIY6B5pU5Tg==
X-CSE-MsgGUID: b+LFYolbTGWAy9lFuryC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92044615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 02:03:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 02:03:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 02:03:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 02:03:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqzTMWF2F3xCHzqy2Xbdy7E6D5M7o8+3PQ1H05T2JRXKLFsBRVgpGYdL5fquSs1HRTc8XI45x/6P7yxpsTTq3e7kZXLbQISgsAJBDrkhcL8BS8fFTlBzTKIlL63e6sjewMr5+NTwn1B/59M/z6ZEs9klG9R+pmhKI4YE8v/8rC13JAkBTgSQavQRUOsFaUUqJp3nM+J0NIV6puDVW1WlpXIyiD2COhiPiYzw3TTi2oVHSO90CDxAqp5YViG7mORB/d9i8AG9JlSDEpdj4VruuIafsVruZiZPvdW3XZpTnXGbbQG8cUZvjmTlaE4/tB13xXi8qfxcDyGHk2G1nesQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaTZcNgjVpnlvi7ycnJW+VaezI4KbEwKoz411nEoP0U=;
 b=xyoABFR+2Y/A0cA1W+6m+WAqQT16A/CMk6yPJK90VWRa7wnazrZLW+ntPxb4JtNBnamnEi4PdslpAMqGmlccgf8YsKavicWyYDZ9XaYWl/z7r18aa0zU208ik6C36sMOmKNhW6JQlBP1QCV1H/LvDresrKJu9tUx9yc7TDSFg7lLjmLB8pEEryhm3VnrRrfD3RK3A9usCe0AsfPFi7h3thZheqvI3SwnRDbek2YUW/1J84gSTSSthf7DgH1KD3T3wylvtTKF/X9LrvdmqbBbO05LkmAqVtZWKpjOam4tqCrwnKX9wni9B8QxPgAfuKaDmyi1TJOdyg/CyFVq5j/xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Wed, 27 Nov 2024 10:03:47 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 10:03:47 +0000
Date: Wed, 27 Nov 2024 18:01:04 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0246f1aa-0eab-4a54-41c6-08dd0ecac8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3vAXnajQcpqGmSpnz1Lv/Bv8hCds9vAO8yE9DAmjPgru8RqPxmhYpbuGRsa?=
 =?us-ascii?Q?8ujCQ9bQdpoIuhsz8tgsXhBkITX8lRLOW/0wrYZpHmiOVihEWOA8lmWFGubD?=
 =?us-ascii?Q?sJpZUjIpf7bgEyU441dUluiWg6SGQksz6uq0RtoEva7mGHJH9zng/O6yAhU+?=
 =?us-ascii?Q?JCEheB8ux2Bs9bofGnGv1chMLLl3TKeAJOnZLLKAKZgK+us0fMZ0rvf+2bGy?=
 =?us-ascii?Q?VQ2HJJDe/c1Di0MOi6J3OnZDhaknqOZBF5akjMs+XGeT57I8J7Ll4H1KEb40?=
 =?us-ascii?Q?B4thOA0mFzeaRFQFl3ybtena9TxA+WwjF/pBe9ryEPcPrfZINFxZBRBTOXrL?=
 =?us-ascii?Q?L2XUKEtqrIFNBc9g76aNsAxd0hDHbrDFUcO5bq4iE/oVt7rtD/LUp7ucqyP0?=
 =?us-ascii?Q?Kyc07fwWb4y4MfIhIw2iiZS4wJtaQlJFjEWTIt1WGS1jJOI/JJq4qaHJdjkM?=
 =?us-ascii?Q?lX2DujL6VPQhFkeXDELWH98fWahPg56cBZqa6Q72APNouBvu+9G2yzRJeAwa?=
 =?us-ascii?Q?oHXzBOCX6InEFqrw/r8HGdiW4Gq3tw525o8C3qK28lRZiWUZg+Ms010ybjKK?=
 =?us-ascii?Q?WE/GsZN7m9sOgBwhi8M4XpcB6yF0Oi3C3doFS5gEk+en0O+qxTQ4664xiMWf?=
 =?us-ascii?Q?mrkNkK/bn0ed4jwD3d5nj4vC5irMEnDMMKs0S30oHv0PGlSqxvhGYOheqQQe?=
 =?us-ascii?Q?FlJHEwPnHSqSbiE9qetag/8VmTRjNwj//3UMHr8W0LuSJSGk+j0P0rO/wGMN?=
 =?us-ascii?Q?d1XJ43yKrsHERNuT9e9pFRJiHbq7tps4R7nbvMhBo0LqzZ7x4jEMmHjgCvmq?=
 =?us-ascii?Q?yHfQDtY+7jQNMGlZasNNYt2f3pIE24Rx8mxjpP64rnWzf6lbDpUKBy2JWT8l?=
 =?us-ascii?Q?HOc27G+sNjlnaKERS0BJvY2wY3Sg0cqO2QYgqDra6Cpuw/TJEX2MFtK5OVTX?=
 =?us-ascii?Q?ZA4xCD6y/lgu+grBeM6Z9mG7PKT2eykHEwuEAmmkRh5zafUmLf2p3C9iHOR3?=
 =?us-ascii?Q?auBGFVNPMwrElZ6yhqCCflGT9TNvWU9tK4OZvGKLUbwcH0VCeYczZHWm6wj3?=
 =?us-ascii?Q?dj0j8BX4hXX7l2xaq5ex9ggsCPCgw8ccCfrQjrSrXi2Mg4iyczpe5OLlpNuy?=
 =?us-ascii?Q?c2Iu+Ik0LqdUBLKdNzohWS3Myiemsb2v+CMjkgGqN9k8W9K4koFLuQEs0j+0?=
 =?us-ascii?Q?soBO1sJX51cOpVOI4aWfPKyeCWEeC/RWqbRDY7yQ3lQ37D//GULK1Aaw7d7+?=
 =?us-ascii?Q?FU0ju4xczxeBB9HSU9cpwJbmo4UeC7jfCxgPlZaVpBbW404geiITBv8E9G/l?=
 =?us-ascii?Q?23xILJmJmyZLyUdhagRSDsfRqDkefTmUuQ1M/kVSwXnpvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpC3gvRZHbbZWgbFfsUFZIvCpruf3DipeYlVafdf0KKfzjnQAu89zCHkPD1s?=
 =?us-ascii?Q?j3R8dqgMMFHJbedLaxu+ltGJrtT4pBiFVk27LGMM52vUM2i264lkac/yeZCO?=
 =?us-ascii?Q?kQh1R8LIM4iDheOtMVMgKXz2SqcNJErAUNwJO9NJjHEpwSYVAODsKaK954Kr?=
 =?us-ascii?Q?ORF9vP1ym070MgoqC9K8mTa/wR+4j7Vk+nkLws3xLHw4qtdZh5tQArpZkXYo?=
 =?us-ascii?Q?K4wcriPe9WsM6Pco6HSU0Blf/ryMI5mYFh5EUwJhVzt4GZQY+qPxuVLNLiSV?=
 =?us-ascii?Q?pvuDNyU+YXXWnQh8ygJpL5YNcuH0zgj0Tp2amBRmDjwdd1L3eiNMuTxffxCV?=
 =?us-ascii?Q?3Yyznuw5+3+DluMkNvAYZMfJLd22Z9aNLyPJBOPsKZjejzCLpks4p2GEGmQl?=
 =?us-ascii?Q?DlkgfEuPwgTbIissb54NQMKjVF+et900+beBdJFZ1RdX/Ns3591m632ezsxo?=
 =?us-ascii?Q?XpVbivs6ls9/Jk+b9LT3FZFgF08XndW646BTfm0LoMx8AkkW6CATPHPKbFH4?=
 =?us-ascii?Q?jNis7QoWCjVV2XSK36a6pIPWUNIxtATld675hbAP/VZR6eMCtNhXv0c57CKe?=
 =?us-ascii?Q?TBCX2FDp4af6M5tdLPlNFaGszdUqn7Tb9MCD1vsBXZt0qmuxuauLyB2c+dDH?=
 =?us-ascii?Q?/MfB0bHY9iUNDHPz2SkMjIYWRkDly5jGZAWkmxqPuSQ17XzeYRvfHaxVC70/?=
 =?us-ascii?Q?Xw4gta5+aL/8fWIVQA9Lbh/4E/WkW2oPDSQfePGJZf7wciZCmotc7QGySj1t?=
 =?us-ascii?Q?gEL7UfFC2OPZGHyO689yfP3igQFVdSMt3fw1sN+zz/cqiwIi3UEiJGEzvDch?=
 =?us-ascii?Q?fXdHnTtKOTzLkoFhLZf8FEy24+OwjHvYhCA2zXOTdX1hJadsqKabqI07hPHS?=
 =?us-ascii?Q?Ale1GkaBQAwc1i9QqflRkO/i9nUPNmWmocJVLe9s0hKUkBmZAUi1/tFAsIv2?=
 =?us-ascii?Q?+VAcyjJsXaARrpZ4exGpAOzbNWR5QLN10C74o5VYXzKqXDGkWXqSrfARGpn5?=
 =?us-ascii?Q?5/AjwegugqlzDD+C74FJBgVCNsU0J4N6zQPmZ7saCUvi4HrMmSL7yGpXeasH?=
 =?us-ascii?Q?fstP7WaJ4h1KhjZN8dhgaxIyoBT/FIej8FL/wvCFEbI2JpHsOC+oF0li4sAL?=
 =?us-ascii?Q?1omYTTJZbM+Tj88HASvOdNgJtb7Y7GgWoKCowTzK1nn95LNFsusELqDTmpXx?=
 =?us-ascii?Q?FzK3E6U2Z2HJ/bKUnQ5deigNDFtWZfdAdMxuICYCglfy5/qhup2KHmXp8k7R?=
 =?us-ascii?Q?0tqCnUkGSA/kuQHdJdLTC1w2H3C4yo5HC6rQk29NXieHWNJKaP57zDKjPkMA?=
 =?us-ascii?Q?dsvz9AGsNnH4tXchRNKs+5/lUj0JOEOlVAinGY2x9g7jRF1bCw0UXnF7YDWW?=
 =?us-ascii?Q?N/lZYERukhNsgNje9O/V7WRBohF/2NlBe49RmayGSHiU95yMXr7a0HVWwM4+?=
 =?us-ascii?Q?zx600LIcFr5FKeIlAovX9tPFC19bacMMrKFA9JR0yiTZIE9hxCSw8IJ7fRvy?=
 =?us-ascii?Q?gXnQXpFfWSuQ3sDufAXeH/2wWY9Uyy9AdFSnjgm7yBFms4hrk4qDbvI1Ijnw?=
 =?us-ascii?Q?dcp72MhhZKUiDO0nDsTJlBewtsB91WcRkkEWiMHX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246f1aa-0eab-4a54-41c6-08dd0ecac8b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:03:47.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubbYqOevz/8kRAAlzuio16l/srJDIkxbNrFuNpi4eaNaHawVEzzNzkpPrWRz87Oc57LPqC9YYW3CrCSRuCx//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_020351_128368_1BAB8B34 
X-CRM114-Status: GOOD (  41.95  )
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

On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> On 10/24/24 at 08:15am, Yan Zhao wrote:
> > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > 
> > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > deployments. Lazy is sane default to me.
> > > 
> > > Huh?
> > > 
> > > Unless my guesses about what is happening are wrong lazy is hiding
> > > a serious implementation deficiency.  From all hardware I have seen
> > > taking minutes is absolutely ridiculous.
> > > 
> > > Does writing to all of memory at full speed take minutes?  How can such
> > > a system be functional?
> > > 
> > > If you don't actually have to write to the pages and it is just some
> > > accounting function it is even more ridiculous.
> > > 
> > > 
> > > I had previously thought that accept_memory was the firmware call.
> > > Now that I see that it is just a wrapper for some hardware specific
> > > calls I am even more perplexed.
> > > 
> > > 
> > > Quite honestly what this looks like to me is that someone failed to
> > > enable write-combining or write-back caching when writing to memory
> > > when initializing the protected memory.  With the result that everything
> > > is moving dog slow, and people are introducing complexity left and write
> > > to avoid that bad implementation.
> > > 
> > > 
> > > Can someone please explain to me why this accept_memory stuff has to be
> > > slow, why it has to take minutes to do it's job.
> > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > 
> > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > It will (if the guest is a TD)
> > (1) trigger the host to allocate the physical page on host to map the accessed
> >     guest page, which might be slow with wait and sleep involved, depending on
> >     the memory pressure on host.
> > (2) initializing the protected page.
> > 
> > Actually most of guest memory are not accessed by guest during the guest life
> > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > with the host physical page not even being able to get swapped out.
> 
> So this sounds to me more like a business requirement on cloud platform,
> e.g if one customer books a guest instance with 60G memory, while the
> customer actually always only cost 20G memory at most. Then the 40G memory
> can be saved to reduce pressure for host.
Yes.

> I could be shallow, just a wild guess.
> If my guess is right, at least those cloud service providers must like this
> accept_memory feature very much.
> 
> > 
> > That's why we need a lazy accept, which does not accept_memory() until after a
> > page is allocated by the kernel (in alloc_page(s)).
> 
> By the way, I have two questions, maybe very shallow.
> 
> 1) why can't we only find those already accepted memory to put kexec
> kernel/initrd/bootparam/purgatory?

Currently, the first kernel only accepts memory during the memory allocation in
a lazy accept mode. Besides reducing boot time, it's also good for memory
over-commitment as you mentioned above.

My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
not allocated from the first kernel is that this memory usually needs to be
physically contiguous. Since this memory will not be used by the first kernel,
looking up from free RAM has a lower chance of failure compared to allocating it
from the first kernel, especially when memory pressure is high in the first
kernel.

 
> 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> Sorry, I just read accept_memory() code, haven't gone through x86 boot
> code flow.
If a page is not already accepted, invoking accept_memory() will trigger a
memory accept to zero-out the page content. So, for the pages passed to the
second kernel, they must have been accepted before page content is copied in.

For boot params/cmdline/initrd, perhaps we could make those pages in shared
memory initially and have the second kernel to accept private memory for copy.
However, that would be very complex and IMHO not ideal.

