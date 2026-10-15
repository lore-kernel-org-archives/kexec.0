Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59982CCA462
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abqK7JjMuXHkA5JRXJKdFjjat/qPQ3psYGWo6Y8Bdsw=; b=4pOCPLYxJs73nUMwW5HK7lkj4R
	BhPD1f9/aPrS9zTp1x+Qxvn/obY/KHnmOQLdLpYWWzJIOsgf2LIvMNCmEvRys0R/YSsPPjPHpTgUc
	DdFo+updi+ITfjh8WGEsp1+HLHqUzMxfrS/h4SLW1nKPK427udSXaMwAOt98JO7Ew5eFtiqvlPWoo
	Ddtkmu+rnZ8E4OeJZ6au4D4nD//nS2RZ9HLhQ327uNd33WmMl85KP75AOETJaJGSM+G5rP4sTlwBo
	CIKJ05Cn0yg/Ub+OsIenpRDj73YWhR3XctE7X5rVbtq8IrZ4Ajf+FYBC+g+gbf77dg+sT+/iTOTjI
	gcmoOZRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHT5c-00000001Rcs-40pL;
	Thu, 15 Oct 2026 21:34:16 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHT5a-00000001RcS-3pPN
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 21:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792100054; x=1823636054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/pHOygyuGfSThcZERlpw6akYH/UxO6pbzym2kfgGufI=;
  b=SB5pa6IWw94ialA40G+m92uJNPUdoqra5h5IG7XJQI6Z9mRlCMz1v9gP
   slA8puPtXzYk66iDikPBxkgbTCjVd3OidQYir6p7Lflu8xLhcsiITWsx+
   rZHf18jmT5NgCuheRkTA23DwkrS6luv7sQ0apl8vZXbideOPcg6Xe/BkP
   QjkpS6e8ej2ZaVau5UYFY0RaTIxc9naZ/DRtfqkaxlPk0NsZOEhSIedRG
   ciQ/AoZwPtJyFqhrF4TaDFr+orK5rZbBFHUC0dxOOKb99CvkB6qeOU1Jh
   jUccA69YliAGWyTW2x/XITY2B9Ogal+dYAbyfJ1+LYXy8HKly67XGATuG
   Q==;
X-CSE-ConnectionGUID: BY6f3qR9RP2T/5mfqQG7LQ==
X-CSE-MsgGUID: qfNN0mW9S4mbWY4W7UmByA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="874051"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="874051"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:34:13 -0700
X-CSE-ConnectionGUID: fseNKWmnTc+jdD/fgStDPg==
X-CSE-MsgGUID: WVazl1W2Q+KCLuY+Li6XDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2154103"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:34:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 14:34:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 14:34:11 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 14:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiiD/srzptSSS3jL0am4PWkUqJPHtsW8ayY6502UhpGrzBTc7fgMfHMtP9MxcDJcr4KSwTwP5gTxJIyhTqV19EH5qypjok0+NvBnbz7SGIQcfTdNL1ynSBh+FliluvFWFCQg6YjIxvMLYGOtb5XX3m5WIlhBP8ylk9QneJuAgGHFbtMT5wUEjDYZ8IbRBbSKQlG1Px37Orc1iqZZq+Gwh61gWv0FWTSGS6/a8H+RJkOj2BlJMe2O0YE3GkF6z9NSW15qIfupvMKlCg7uWCmGfdmkyh6YsH2yEIVqXOX2moPZDjU/War9cacflX+EUZIXbVnp5Ha6+4Rzoqaj317wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abqK7JjMuXHkA5JRXJKdFjjat/qPQ3psYGWo6Y8Bdsw=;
 b=VszV+GSabUYF03yoa863crC7CK+aIgnnM+fQrd8N8lZnprvGalnrjr/nsnlsjiKubrrqSxwg4MbzfZQkHHLzomUgFvXBxM0dLYY5QM3m8ExXJ6DNe2WG3cWUlcRz2qj2zY/oNYnxH8oeH0Ll8dGeln0eurJGj/13SCRqyxUwoXF6wbGN16rFBZTwNlZNeV5/wYbISjPPTB98GXRyM1EeKeZg3xiFhcQKcG+r9QdEGTYOaU/xQuYXcb5wriMY/5+lq2qIDdsoJCR8oPGX32xOOf1q147B0qBLSoDByIIQ42C7IrwU94pl8cE/Cjkl2wf2xedLM0s8Wr5ppDSwzC50Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS6PR11MB139798.namprd11.prod.outlook.com (2603:10b6:8:4a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 21:34:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 21:34:01 +0000
Date: Thu, 15 Oct 2026 14:33:57 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <kees@kernel.org>, <rppt@kernel.org>, <juri.lelli@redhat.com>,
	<nik.borisov@suse.com>, <tglx@kernel.org>, <vschneid@redhat.com>,
	<kprateek.nayak@amd.com>, <vincent.guittot@linaro.org>, <bp@alien8.de>,
	<thorsten.blum@linux.dev>, <cgroups@vger.kernel.org>, <david@kernel.org>,
	<mingo@redhat.com>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<seanjc@google.com>, <ljs@kernel.org>, <zhangguopeng@kylinos.cn>,
	<dietmar.eggemann@arm.com>, <mhocko@suse.com>, <vinicius.gomes@intel.com>,
	<tj@kernel.org>, <vbabka@kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <surenb@google.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <dmatlack@google.com>, <tim.c.chen@linux.intel.com>,
	<kexec@lists.infradead.org>, <pratyush@kernel.org>,
	<dave.hansen@linux.intel.com>, <rostedt@goodmis.org>, <gmonaco@redhat.com>,
	<jgross@suse.com>, <mgorman@suse.de>, <graf@amazon.com>,
	<linux-edac@vger.kernel.org>, <liam@infradead.org>, <ridong.chen@linux.dev>,
	<longman@redhat.com>, <bsegall@google.com>
Subject: Re: [PATCH v1 0/8] x86, sched, mm: Speed up CPU hotplug on large
 systems
Message-ID: <atFGxagFo50iG6IS@agluck-desk3>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|DS6PR11MB139798:EE_
X-MS-Office365-Filtering-Correlation-Id: 315e3d05-9dc3-481b-c16b-08df2b0406d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|10067099003|18002099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vhJsuqDroBgMxvwc+k596vtvWF/QvkV2WVXjfpQ3K4jIhUB+n/YMhw5Zxnq7R+bLoexlTl/fpXIPM6AQUty08gHvkah10a6PtpQku/B7V2YJtCvXD2lUevBrA10E8w+EVtr8BHTE0u04/ZaO+eECxRVPAvWwTnuTMsvyIQijFl40rCcs3Wy38s5HeZakWJral1Xis23FI2qIZze6CpwrPGdYJF8skykQ/qzY694A8r343XJY3mg4dwm2wid+pMo342qHg5Y2T83+9t7EOGsoUVDF0zs+iGsbAeDx5stGe2wV10DOmLWWO9nU9n558vaoddlHpPT3nGcudepy+UKhIGvEVEoHxm1JVx21p6HwKd6rcDq0GJBO5A5RvB44isszVCg/vG9YSNLBQ8WOGynxThJAWf8nD3T6XU2WxBv3OrjrZzSVp3AVp808OJSNK7S1gAuLh5MbAeibgzZaVJC442oX7ZQ7HpkZSj3AQFjCMp82SQ3AkPLFWrQ0f1W1eZlCGFq26V5IxlBXT1JxNzMwSnYqjn7lKExT+L2muMawT5Y7lpA2CwWezElTIOBWaWbFWUB040idd0ph7W0bKkORI5ijV0OniGewyGdnoIGgWAfWeJI26LU0h0HiM4FR5f9is7NvSp4+ZbklO3oLy/LOqcf/+noN8cthu9izH+bidlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihk0zYJfMFn19YdCPmHlnQEI/oRc1ZGTN0WL4BXrPKfBE39g1TrEEgPzxuMo?=
 =?us-ascii?Q?f4sSzHdKeruaO5Kl/ajPU9Q/j36ZeO0QUmrnX+IjHd6jf6Gm8+UFys7qz9wc?=
 =?us-ascii?Q?19mIXT4rGsLlSxU1+XINzjqYVp+gOz0cP48mm7BBreYXINuZP/fALKAlCv9c?=
 =?us-ascii?Q?Z4sFmQYRa78DzcO1qcB3Rw3vNGDr+9JOCGFgfF8A05tcbCCIX0FX81xxs4Nf?=
 =?us-ascii?Q?uSong2BrqzdB/lywKbS0jBudJoFozRs7f+s+IKrtky+DsKvxlirFOBI/HAQR?=
 =?us-ascii?Q?NZ/gFTHOvQKF1vcUIUIuRVfLDX6iZIpAeWYZFSBptSaE5xsJj1/V2F9taYYC?=
 =?us-ascii?Q?WvomljYVE7841xx9FwabTn+jgGpBdumOSdcWfFZ+Vi7f6WLA+jAMDPj9hyVw?=
 =?us-ascii?Q?GTtKrNPdHDAiBbX7Qjb0CVZZlSBPGyWpr7r2+H3bMS2g29N73/u1JhJvDYLS?=
 =?us-ascii?Q?CpfQK8TbDBo6kG4YexOD624cG+6laoLIJeSXFhRbcR7dGe2ChTpL64apUt2X?=
 =?us-ascii?Q?eUPg8rv5FAitY8ApuJFO6a/Cu44IiKkxjL42pxh6fGt4djkgKYxjFwzG0X1N?=
 =?us-ascii?Q?AjG7J9vm+jSnH0TYs7PXaVi08S0hHCHl92kA0U30/LofLj/+seZ9oVXrQHYT?=
 =?us-ascii?Q?k5IdxWbXceTkVhFRKM8akaw6ZamOHvGnzPhMp3PGHVV9jCljXGFiEdB9XOKF?=
 =?us-ascii?Q?2hQxnHdbW+EldusmUfEPZR9Xam8wsAalZL4S4ge4AlbxrqHeQIZgDeE7secy?=
 =?us-ascii?Q?i/Zo+eJE0m1kCxzybRft2/mFI7nmdULmGww3asUqn2QahT1cUV+JUV1dKQ9e?=
 =?us-ascii?Q?le1keFDIlSbPXPBrGL8hWcGVwA31u0YUeP3pThmYzgpSjK0DPomCvWy/mORG?=
 =?us-ascii?Q?nXO1dt0JHfRvPjWONDURJyU4cCQmmC4H18+t2imVbYTui4DF3bC1IycXOl9g?=
 =?us-ascii?Q?SVJxIVykGO4D6aT0BsB8WQre69mGvMQ4tG6mykQI908bI5rOfIPtAdd7dgcT?=
 =?us-ascii?Q?RT1Xc5WyBzGNHvX6yxwFRDi630TvjLkBowgz0GTg63TPOaKEwvoHx2e1LUey?=
 =?us-ascii?Q?Y7TGt1lZ9S4RyDisMAJwN7J+iTU4GU3VXNd3/kZjqd71tiOkljrTm+TOlc/7?=
 =?us-ascii?Q?l3HRY8zhNQtCnpyNbqqIyhTCu3I2vdxwZVQFw/vVhRZJd9MyGEdaPb26j7mQ?=
 =?us-ascii?Q?sQ0Xm4kUGK9kjX8uHfpKz/k92YIXMc2cNuqp9YCT0+FNZe8v3W1Teb5wXsgB?=
 =?us-ascii?Q?YRsz5N+xrfmJbib+TolwS/a3vuZjrE8IAaAs4BF2cm86dCOp7AC3L61PayVY?=
 =?us-ascii?Q?lku6LQXLWU6KAdz621oACMTfLNRIgbovyl2+9YBLY9bJHbbmESH3ltGj7dmU?=
 =?us-ascii?Q?8brOP1ugvssE5jSI+A8kSsttC/+7DEyT+0mC6oEp5RVBlEBA20Hp1wutFV1w?=
 =?us-ascii?Q?Wd17HckYpXbAiImpag80eZNEhZF7lpRChKZQlFHBCryEEuKDbuIqCeREwEq2?=
 =?us-ascii?Q?KT7qtvvE8QMUFThtLD7SZiEhkS4bOmfpilshLTU2aqUyHZDZXh6ruemmU6D/?=
 =?us-ascii?Q?6uYkxJ54EOL5N7K5SNoQrdGPw9D+oDSA/ZHeL3D/a0XXUUoWdarTaJM9S+uH?=
 =?us-ascii?Q?/oGOH1GCQUMM5MZ38veeg9Q2xhHpcw8yVI+kWAziJYgehxaLcz1PNbP6I1qE?=
 =?us-ascii?Q?38X2sfY+AxeLjw9HuT078Yc6Ku2eQdM9d2/H5NLlsowL+/wHX1XGZ95yXMDt?=
 =?us-ascii?Q?fs4rbey6vQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: vHnxOUiy7Du0sM4YNaZzufDd6xStLhNC/TcSFnQMnArrzEamSi/QZLDGoCjPrkB/s3S4tXafFEgK/lVXQ0p8o8Q/KpPU1oYdEkYivjrYtBmeuC51crRCxbCvs+bsiF4afQy0f8/z82G5Zq9Dxfdc25gDE4HF5PjOWRHndrIhzhHEwRdXyITp5Ku9blUn12eu6zAx5gwwENlH8f/kmARX5qvfefxh6YZqKol6x2s5eCl1+OjP4zs2iUIrInvCw1oFsTPSbVoQ1PpcOZqw77vNxv/qXZaqfH2JVf1DjrOtaNbildaccIqkidfbg4cUQyiHVcLTfXM19c6gFZOlaai3eA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 315e3d05-9dc3-481b-c16b-08df2b0406d6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:34:00.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MMAdSzimFks0RRaxaf7Hby8kzcQ3wwbev7YLaqjWHBbaZvcbE1rizML+S0RBMSdEeTX1WRCCLGglU/nsMt/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB139798
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_143414_997813_48D5E586 
X-CRM114-Status: UNSURE (   9.33  )
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

On Thu, Oct 15, 2026 at 11:33:23AM -0400, Pasha Tatashin wrote:
>    - Patch 3 bounds cmci_rediscover() on CPU teardown. Currently,
>      cmci_rediscover() broadcasts an IPI via on_each_cpu() to all online
>      CPUs, serializing them on cmci_discover_lock while reading up to 32
>      MCA MSRs. Because any disabled MCA bank is shared at most with an
>      SMT sibling, L2 cluster peer, or die/package peer, probing a single
>      online topology peer via smp_call_function_single() (or returning
>      immediately when no shared banks were orphaned) reduces 479-CPU
>      offline time on Intel from 11.42 s to 9.63 s (-15.7%) and total time
>      from 22.50 s to 20.74 s (-7.8%).

I took this series for a spin on a timy 2-socket Icelake (36 cores, 72
threads per socket). My test was to just offfline/online the 72 logical
CPUs on socket 1, and I saw some good speedups:

	offline: 4.833s -> 3.17s
	online: 6.157s -> 3.796s

I noticed that your cmci_rediscover() improvements mean even better
offline performance if you work from high to low CPU numbers as the
shared banks are assigned to the lowest numbered CPU within the sharing
topology domain. So working from high to low avoids creating as many
orphan banks that then need to find new owners.

	reverse order offline: 2.984s

I haven't looked into the code yet. But the general direction seems
good.

-Tony

