Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74965E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 07:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	In-Reply-To:Content-Type:References:Message-ID:Subject:CC:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5sAG5Pr8xkR7ALvhdEsJfNMhFYPD6sc5TdW2DFG+KT0=; b=ymkXAXJk2Tc2XeHmpT0uxQBRfX
	Q3gEWbbC8ofZIKFeSt1TkPmK+gNqCFtfhlPDxa7ExEexnAvbuJzS7plIIvk9JgdFtXp0GpjswCWgD
	YJBYBt2hDGkasjZZdhj4plB1RffnOlH/d3NE1TVLg3mGCIT80Bg2yI92h95nKjh5D50jnt8SsfdTc
	npP3GnhHH8afnHoNnWlbifMNyEOnrukJlxhPGEzAQyXES+X+9J9OWguYIMTOYOpV5AORHoyp1P0wb
	PYeh//L43xOTKkqBFLzp5X20rfCV63MUouSbRByRfcnSILqEHF18auxZNhIwfbvTrvdRF76ilsRGb
	5l39PYwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXazg-00000007eN9-1mFD;
	Tue, 14 Jan 2025 07:05:44 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXazd-00000007eM1-3nzL
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 07:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736838341; x=1768374341;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=fYsLm1XKpy11Jn/slqVuowL/KedlQIuPwx0eBwMjPWE=;
  b=EvJEiVhsWzO9b2dJRYMJDCZ8+TIKKJbpK6jadkv2tm2yMQ+FB9oPgg9y
   szipb+Rw0j5ZTuEtO5aGGpDtifX5s260mdyPdN6QLmOLsl97/RNO7GNqM
   KE99y3lwWnqBgM2jk4mRjipmWBiQObXJ7Gh6QRtrFBvmMJ4PyXlt7IMwv
   WTEGeUMmJaDf2NIrkLac3zdWoF7c1pujYLtYHEl5vppa6TX8K2C7YRPMw
   j6aHLSl0MoKOE8j//LFEWpGaVrupmxCw/mKaUwC2Oo9WROUChG8jYoAFb
   hLjveBDj+MSIM3iwZ7iyVh7f7v/OT1ZhMyEhDg6kTdjtk9lUgJijw0nB8
   w==;
X-CSE-ConnectionGUID: c/Q6Lm7IS96ETSIBTVXiBA==
X-CSE-MsgGUID: Aftb6rf5QyqdAbK1i3WV+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47702449"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="47702449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 23:05:34 -0800
X-CSE-ConnectionGUID: pxI3XDcuTj+8N47cbvPm0g==
X-CSE-MsgGUID: x4vSvJS9RZSa6MaQ6m/G5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104537940"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 23:05:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 23:05:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 23:05:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 23:05:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZoBY6lALN5XPvzwtap4s9P8o5afX9PJ4jpzrk5/8xCfGoJwGfeTg8iipBknG+rhsUcz/Emu6l1KKyfbbLSUqmC/Y7Dry0BRESA/ebRxSHXteQDQFozWW0NCui+qbnLWL23F5CGJBp53y2O205KexDi5IegbvKh4uJSS1eunLsRjrGdsDaWQKtN+mLz1nNxh6XElm24Z59FGMcR+6OqPt5xDfYopCvtIKhqA0PXLoEq0oIsDy09F7Gtms3tyYcyHTUGgyL1oPSwKPgGbTnP/pIer1oVgunIJRx4vvg344sKT1ypZ9Q4FwTyJr12u+WvFzSqyVVcSLplIi8Jx4qdpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sAG5Pr8xkR7ALvhdEsJfNMhFYPD6sc5TdW2DFG+KT0=;
 b=bBDLkKu28RYKxkGa12v7xAaVKRcSBwgZrTPEbvLfwLQKMOOU8hB826r7aJiYGlPc1qR0d/qLmFDCUbQe+loxSvVH3Guub5YwcVieNeLOuGMdT7o4PiKCP1EDWN0lr2561Su5AAX+TL9e4LcYNGgo7j09wkWcjpbtlC4eU+es0nsRApNGNJCNvkG76uVHdrj80tPy0IkpnMde3+KrDKLrbV53ECt+Mwufk4/PKeZsTiw0zKAYgo9ZtYVFnHQmIzJk6vxpMhahuAf1KR+0XnjrN7n32Ai+hvEcSQ2pDugtAys5gR3qmz+8oUGHExCC0ubOZy/poRsAAbtOiH6Gia3IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Tue, 14 Jan 2025 07:05:17 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:05:16 +0000
Date: Tue, 14 Jan 2025 15:04:20 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <security@kernel.org>
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <Z4YMdKz93PI7wsEl@yzhao56-desk.sh.intel.com>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4434e962-73c4-4a29-5443-08dd3469cca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f4scEaZOANmdqCzODUoQYgAUXnw0EHlBIOE5M67cNGMN38speVEtOvYn18hv?=
 =?us-ascii?Q?n0uC977Ljx9/GMtvXzcwl4duyT6g2lG/DvP9cL+PdUbRQonmXa6w+pQ+Jec9?=
 =?us-ascii?Q?iK/WteZ0NViG6+133IlRUjDwaIKyst6HZ8Hh6CyQ6Po3PstW9qbZfZwG0XUG?=
 =?us-ascii?Q?vy+55fC8/kpnjagF/pjtVXUr6kGSqrD54h2IR7yV76XFsZi4a7wGK7P9fioM?=
 =?us-ascii?Q?Ap/+yVihuKOFlfWp9ZFLndd0REJSwhyodb9xxQiDcNPOWR5mxonCdXDyCXrM?=
 =?us-ascii?Q?eA9TRHBC35Oa/7kdJptOnpaBiZyAGKNarLuhMTVsKwjB4Vjo9WT38T77u1iO?=
 =?us-ascii?Q?xl1a4AgzWGkHAq6bYoIcv9Tv935fspZxt/SLJryMbcGY4vmrh1aF6rGer9TD?=
 =?us-ascii?Q?PDOlbzg0PWArEhE1ufEYfNY2XkzKm1fs8mJ9mCIkwYbVMvXCPB/yvx8j3Qu9?=
 =?us-ascii?Q?ixvxUY4H0Cn/mCpdlVdQvw1nw2DByYjpodVVQyQ3UTarmKc+xHdx+AF0upBu?=
 =?us-ascii?Q?oCmr7AYgUg7c4SObC8oQ07470nIVjHIwOwz3PpS3QG5urXPJdq2tRhi871zL?=
 =?us-ascii?Q?aZ5VFgaoCY13GvUSzn6D098QnTdX/rOjqeDKiAhpU0kh/DzGkxR2RhHBzNre?=
 =?us-ascii?Q?C9Wir323PozDYxhPPGqYkQRLA7RjtsfzQZQ8EIFnDspRNnARdYcfZ4VbahaT?=
 =?us-ascii?Q?1vSeB4zf4eGYKqfhvYiIa7p4Y962YP6Oec34Ne8SKID4qhNAGggyH/2vbFw/?=
 =?us-ascii?Q?5WX9vMTvuHmtQ9DCg2bTA5/luoA/fXRCWrPeiRwpm9YMF8C1eGTHs4At5UHD?=
 =?us-ascii?Q?ocB3a61Z5h91EBbqxv2a4g8Nntfg9Ufzqa2XPVpwirDwDn1DC5kSc9uA4DNU?=
 =?us-ascii?Q?NVp+/oQF4TaltINWpV0U1v85Ox92pxZ1RYs2TAF3Y3c9JnBLe1WDLOCfi987?=
 =?us-ascii?Q?Orx0h8e7eGMcJovEo+QCmfx0b29nrsHSdftLHNrnfFYal8iCI0BHO+k0wQCF?=
 =?us-ascii?Q?LUe23LE4v9B+P4sv/IO+718RwJeQmzgdDo2eZ3OTGNOoEpfHaMpvwvdVUpIg?=
 =?us-ascii?Q?uGQQLUeI7hEffTPYpSGsG3Iw7gGncXobCxupV4pDxF6X826c6PORTIu/M0Lg?=
 =?us-ascii?Q?Uit8EhzfVSmvjVsGKHBG2zeIinoYlIZ2TTLGUXD4fBgLlYGUYZBIp9VV2Bag?=
 =?us-ascii?Q?ABv31i/sQiTHyvlm8l6COXUiLklmLC6BEClL5Sc3bPuja+2jPmq/tjca8pnW?=
 =?us-ascii?Q?COuGG7lVHYK5ey8Kq/Dv0iDLnOhC4fBYfc7HBAOCnjXaxvfZZ5zMQxnYqUcp?=
 =?us-ascii?Q?nCAR/zMR+mwxBTMNpT6QAhn5iyZ6A6WTnuOFe/Cdhzq+ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAuJM63u/XtXMREsJQ+ecw9sOrHwP2sVyP16teX9x/LnUMJun3bo4/SCT7f5?=
 =?us-ascii?Q?B57tOgeClxNYQJ00UQtiM51qXE4+/Bb7/VkIHz8xyQtPGLdT62FoDLPXaVYC?=
 =?us-ascii?Q?yuQsCvur5S1r/n1GPk7XPfE0AThxZeKL23d5EsZ30BUEqJomZj7jRt40GUuO?=
 =?us-ascii?Q?buvDu5wPBEt6sve8hY4dTDOSAH9eYwm8FcSlcJfG/H4yPmRKoqKeULMnliuJ?=
 =?us-ascii?Q?7dycxk6b7r9XUPEC67NqPERUE9BpnSywNDPTb5wF76LKu7zT2EKgw/ubfzXB?=
 =?us-ascii?Q?c+AB00ybJsXFPJc0FIjRx4FVMAa1IAjeWQUEuofGW+qJ/qmnaxjCqASeMeDk?=
 =?us-ascii?Q?I93lAOBKRokX+7W9gL2M2e2YSgJI2YmTrGSTZkz0cv7+MwLegqtNM7XpLGuN?=
 =?us-ascii?Q?2IC3XXIb3SvHC+FwLpY8Z6tSwttz9bHEI4WoGnA+tAHDzDm7ga7lBTzsiis+?=
 =?us-ascii?Q?M3Xocek1SyhspqCHCVASdJC3V5SWdbvVzUTmhUyffcp2sI/e8WwdN2bs8XSc?=
 =?us-ascii?Q?p9is6riI/cwIJPL/dtSUWodu5pPEiRLEowTrsMVLnP9LDS2fJ+G4H4I0PGVS?=
 =?us-ascii?Q?2Fpvy9SOSgK2hoEDJu4ImpyxKpWUKPQWjjnpKeHGyGgT8F6iBQ1+puYv5LDs?=
 =?us-ascii?Q?DoyDewAq8ciIPxYmdObT3QeMe2ro34lCkoUiaiZlpJ8LG3ixZECfv7cJ6x4A?=
 =?us-ascii?Q?+J+tFilRVFYDcDJRwIZjcAYFlbHxMfhfNErliveRo/Y11CM4+BsuM9tD3sui?=
 =?us-ascii?Q?qhDGGhFJIgdJSvZFwll8QFi8E7hLXqvLyUKhK0FrAq9m8ntuKUO9gg8zslML?=
 =?us-ascii?Q?Ez1sStrfuk9gj1Bm94oDCd+zpKPuy+PZ4G3nIJSEYZokFH+LUOqrKy+S7+Bf?=
 =?us-ascii?Q?TFNyIDYvUXKLdBAw1dg3E6AoyqRgpqok+HN/+w0tPw+tgoGMvtaJ6zffiTMq?=
 =?us-ascii?Q?Glj8YyXxzBvttgASBtdTwZ+65pC1Fi1UJMYEWNUdA7R5/1/l3HFUkcetl1H9?=
 =?us-ascii?Q?rb+v+9fqhxIq7YEMnHgHt66xj5ZnZs4ixbrKvuc4x7E/WF9PWT0RdkiOlAhS?=
 =?us-ascii?Q?c8dME/8KITa/f67iztF2/vO3VLKDacRrVoKitI4whnKvM9dvPSCweMXNCMzh?=
 =?us-ascii?Q?blCUdKTTch1JCOctvsUeZbPCYS7gvKmQBMRB7qZH519+vLdQpz7skFMXO7wu?=
 =?us-ascii?Q?03h0pM8Lt8M4cRYA9R6COAQU2dVGSb0LTRmq2mhqpLSk5HwqA5h064mv8gOP?=
 =?us-ascii?Q?UVXdTpj61919a/ACuKUUfdfAtjlojTAQu9MEM+FWRHFL+/OPui48rT2i20Ly?=
 =?us-ascii?Q?u/mGop2kY/0MIbPuwn422trgJIeQAPx+fOQYlN6uMp/kaVuDmxUwNQ6zbs+1?=
 =?us-ascii?Q?8m05RTxKjks5ePfAEEINRAefdfRSV74v2Lsvk99T4iCeAHaUdC2DtL0slQrg?=
 =?us-ascii?Q?5fSLSBqxz4kMGkekVjpIFUlMZQwN6z8cKSMbDsGBnoSDuf6mWMsODSIiAF5X?=
 =?us-ascii?Q?APwKGe8VkfI/0MJ4SQFVfgZWYgLRNNoFG7MNGwFzCWf+Uw5OInrhlgST3TbV?=
 =?us-ascii?Q?1xIPmpKNIMISCWwud+NPj4JM/lP9+km0MV948VkD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4434e962-73c4-4a29-5443-08dd3469cca4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:05:16.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+WeOK9FrEVkJ9aqUSX0UInpQ8oxOwY96GqqXMVlY8SHojDmnrzJq036NRdSK8dl2Iwa3hkUg0RbS3Ns4sT1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_230541_970248_5079E489 
X-CRM114-Status: GOOD (  37.18  )
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

On Mon, Jan 13, 2025 at 08:59:29AM -0600, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> >> On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> >> > Hi Eric,
> >> > 
> >> > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> >> > destination addresses" [1], rebased to v6.13-rc2.
> >> 
> >> Can we get this patch applied?
> >
> > This looks good to me. In v1, we have analyzed all other possible
> > solutions, however change in this patch seems the simplest and most
> > accepatable one.
> 
> Truly?  I will go back and look and see what I missed but I haven't seen
> anything that I addressed my original objections.
> 
> To repeat my objection.  The problem I saw was that the performance of
> the accepted memory paradigm was so terrible that they had to resort to
> lazily ``accepting'' memory, which leads to hacks in kexec.  I would not
> like to included hacks in kexec just so that other people can avoid
> fixing their bugs.
Hi Eric,
Your previous concerns in v1 [1] include:

1. "an unfiltered accept_memory may result in memory that has already been
   ``accepted'' being accepted again.
2. "target kernel won't know about about accepting memory, or might not perform
   the work early enough and try to use memory without accepting it first."
3. "this is has the potential to conflict with the accounting in
   try_to_accept_memory"

For 1/2, as we explained in [2], accept_memory() is not unfiltered. A bitmap in
       the virtual firmware maintains the accepted/unaccepted status and the
       bitmap is passed across the kernels.

For 3, sorry that I didn't explain clearly enough in v1, so I explained it in
       detail in the v2's cover letter (please check bullet 6 in [3]).
       The accounting in try_to_accept_memory_one() includes
       zone->unaccepted_pages,
       zone_page_state(zone, NR_FREE_PAGES),
       zone_page_state(zone, NR_UNACCEPTED),
       which are updated in try_to_accept_memory_one()-->__accept_page().

       However, the accounting will not be affected by invoking accept_memory()
       in kexec, since accept_memory() does not modify them, and it's correct to
       do so because of the way how the "accept_memory=lazy" works:
       
       (1) when to release free pages to the buddy allocator in
        memblock_free_all() during kernel boot, "accept_memory=lazy" withholds
        some pages out of the buddy allocator by recording them in the
        zone->unaccepted_pages list. The NR_FREE_PAGES, NR_UNACCEPTED are
        increased accordingly. By NR_UNACCEPTED, it just means the count of
        pages that are potentially available but currently not available to
        buddy's freelists. It does not mean alls the pages must be in
        unaccepted status.
        (see __free_pages_core() and __free_unaccepted()).
       (2) When the kernel runs out of memory, indicated by no enough
        NR_UNACCEPTED, it invokes
        cond_accept_memory()-->try_to_accept_memory_one()-->__accept_page() to
        put the pages from zone->unaccepted_pages to buddy's freelists and
        further call accept_memory() to accept those pages.
       Before (2), though accept_memory() can also accept a page, the page is
       not available to the buddy and hence not available to other kernel
       components. When accept_memory() is invoked in (2), the page will not be
       re-accepted.

The reason for this series to have kexec to accept_memory() to kexec segments'
destination addresses is that those addresses are not necessarily allocated by
the first kernel's buddy allocator. So, before kexec accessing those pages
(which could be earlier than the second kernel), we invoke the accept_memory()
to trigger the physical page allocation in host, GFN->PFN mapping, physical page
initialization and encryption. After that, kexec can copy source pages into the
destination pages and start the transition to the second kernel.

With that, do you still think this patch is a hack ?

[1] https://lore.kernel.org/all/87frop8r0y.fsf@email.froward.int.ebiederm.org/
[2] https://lore.kernel.org/all/tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta/
[3] https://lore.kernel.org/all/20241213094930.748-1-yan.y.zhao@intel.com


> 
> I did see a coherent explanation of the bad performance that pointed the
> finger squarely at the fact that everything is happening a page at a
> time.  AKA that the design of the ACPI interface has a flaw that needs
> to be fixed.
By flaw, do you mean accepting page by page?

The accept_memory() only takes effect in a guest, demanding physical page
allocation in host OS, which is slow by nature. It's also the truth that
once a page has been accepted, it cannot be swapped out in host.

> I really don't think we should be making complicated work-arounds for
> someone else's bad software decision just because someone immortalized
> their bad decision in a standard.  Just accepting all of memory and
> letting the folks who made the bad decision deal with the consequences
> seems much more reasonable to me.
> 
> > If Eric has no objection, maybe Andrew can help pick this into his
> > tree.
> 
> I have a new objection.  I believe ``unaccepted memory'' and especially
> lazily initialized ``unaccepted memory'' is an information leak that
> could defeat the purpose of encrypted memory.  For that reason I have
Do you mean before the lazy acceptance, the host can access the page?
Or are you referring to that the host can know the GFN of a page when it
responds to the page allocation request?

For the former, the page will be regarded as private by the guest only after
it's accepted in the guest. So no data will be leaked before guest completes
accept_memory() that initializes the memory data to 0 and encrypts the memory.

For the latter, the lazy memory acceptance still happens in a bulk way, i.e.
not in response to the guest accessing of a specific memory.
So, I can't see which information is leaked.

> Cc'd the security list.  I don't know who to CC to get expertise on this
> issue, and the security list folks should.
> 
> Unless I am misunderstanding things the big idea with encrypted
> memory is that the hypervisor won't be able to figure out what you
> are doing, because it can't read your memory.
There might be some misunderstanding.
A page will only be regarded as private by the guest after the guest's explicit
acceptance of the memory.

> 
> My concern is that by making the ``acceptance'' of memory lazy, that
> there is a fairly strong indication of the function of different parts
> of memory.  I expect that signal is strong enough to defeat whatever
> elements of memory address randomization that we implement in the
> kernel.
memory randomization also invokes accept_memory() in extract_kernel().

> So not only does it appear to me that implementation of ``accepting''
> memory has a stupidly slow implementation, somewhat enshrined by a bad
> page at a time ACPI standard, but it appears to me that lazily
> ``accepting'' that memory probably defeats the purpose of having
> encrypted memory.
Not only for performance, but also for memory over-commitment.

Hope the above explanations have addressed your concerns.
Please let me know if anything still doesn't sound correct to you.

Thanks
Yan

> I think the actual solution is to remove all code except for the
> "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
> code.  At that point there are no more changes that need to be made to
> kexec.
> 
> Eric

