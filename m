Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3BDD1715D
	for <kexec@archiver.kernel.org>; Tue, 22 Oct 2024 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:Message-ID:Subject:CC:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=necwzUbAxCPuj2M8eac+xCsn3BNcpeu2qqftJrQRsYo=; b=fEQ/kCRd86lLf5
	bVGuNiUtqDt29ysjoOO6CTtVnRzocObwkxcYmO2iZJsTQNc8WprrDqresBCEB0kDGllQiTEPafcu0
	PFwfTFvmzuRa/xU1zu/HHyuJBMu6nSrxz9NpyVI+gh5i0ysclzLlMSvTlD/B8SZecwESgff3AHJV2
	78uDJyWJvYgYzlL0Cf6YwRAKlNK52hZalpRCxfWpVyida+2R/yL5D7Xugsgt9SiwtY/g8dEJRPZHs
	/uEBK1C8M+zhpp45k2NaYZAeTdsZblSbTrTpyvhNDmJ0z0gfJYxV1NT3voOSS0XDPSk7PeKeP9D65
	1vDs9xcZEXFLBWmQHjtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t35Ng-00000009PP9-1HkG;
	Tue, 22 Oct 2024 03:16:24 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t35MC-00000009OmF-21sG
	for kexec@lists.infradead.org;
	Tue, 22 Oct 2024 03:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729566892; x=1761102892;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=2KPeyVkcbjMi2JnRxZc/sjwHbeoV+skhL+elCOurKX4=;
  b=LCvJF4+rUSXDvOAAd1zUXuE22FLGQIqB6uaw824dUlamwRIDRXqXzjVr
   txPBrmhmZDTyLlVzTeL7X3P4ydD++gART+C8BHUi76qM+Z/oUW/9adMAh
   Z1pUeuVn1OMk2t7QIiz48+mZeNMAe4oXhsjyeGBiNZSwhVVC7MUb/GTAz
   uiTL9IF5CmokOHifF7UMH2PEwi14OQ9N0aWS5UuWZf2/VAHwZ1NXDBA11
   ci/CCSqa6hBURmjbSMS26FRi4iGoANf6VKGS3oLYuQHIntyXo92q6t0rg
   dc1YzBTRXsGoYG/gSU8KrPEgjm+W+kJQvhJ300Ud0yFeLcPUMEEr4i9ks
   g==;
X-CSE-ConnectionGUID: pz4BPlO3Q+GuPdtUXrFhLw==
X-CSE-MsgGUID: VsRorWk7Rpms99SR8S5LbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40199267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40199267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 20:14:49 -0700
X-CSE-ConnectionGUID: 80mIzERzRmGFYHZjfZ4dAA==
X-CSE-MsgGUID: rCnIgjgLToaDnPoq2NpfRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="110545271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 20:14:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 20:14:48 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 20:14:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 20:14:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 20:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYTyFplR1AmA0rwAdwPlLytwVTph17KhvsMQdTeZ6jCPZAA1q/ZJBHgqCcDjxqHLIk3p1E/ax0S6VdDc1vpNWKTqBmMAUj4rgmMVM+G0gDGLaebxPnEwONEALS4e6DHMK0/OL0PCRtaNewBQ9HrpME2oc22Tt4HqPxDGfn2gsKJxE+801A65rsD5R4vFMh923lkOkaGFMA26FfIlTfTHs0WNOCDLi7YF6qnaSZ0i7DcOCGTpUZP0nGEWfPZCKxokIW6zDVUO1rmD9GSnqmL628vbXeX+5h/GlmlnHooTiJj9Hk8CQ9UTS0O3I4b4x/l0+KLyI30BQr7/cOVLORuXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ow1C/nFPOO51ioE5nwttB3LotTRBCx0JWBPcnvgVmc=;
 b=ATYouBv/Ik+bNh4bl0Hgay99bPTWzXcL1dDfvF3hSCvg19g/vy9+la5Jllelm2MVSJbiXQMka6DbwRq1oBZPAylZd9piXuvPOtZW/PU+C6iBe48R36ZseCKeh4UxpC8f4H5HnWfwwmKoqQOX2kiMphTUnaIo+ParteW0I+udygaWvA/jC19+J9Dskc0lPKy/Nf6hO5rq221QLBMhYTaRO4+SUR7WWQpsGdHRnEcQGPDBvgwl5ZyqJrqTKXpv0cjH3uaCMK4S+/kHF0gOHkmvLkOCR/CVUgQodwAnwmuX54dt4wMyzjYrpLzHFd+QMir0C/g9ptu3xTZQDxXBwWYkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 03:14:45 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 03:14:44 +0000
Date: Tue, 22 Oct 2024 11:12:24 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ZxcYGIHjFhppy+oA@yzhao56-desk.sh.intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
Content-Disposition: inline
In-Reply-To: <87frop8r0y.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: d74111c8-6978-444e-4597-08dcf247ad62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86sSMHFwK0Z+rZJnkgrW36AbG6H7DRVDKxecC9qEsforIYspNQbEn823mGan?=
 =?us-ascii?Q?p/QjSEZ1qQRzYgJARGx7Uq7pbTLZCCUySg6fEOIJIR5nXorgANOqsyOoFv/3?=
 =?us-ascii?Q?WyXTEqARfcnpSnvT9smGRDfS2blnZNkEDGm0b/UsVgiEvulQwNdsHd4KxmMs?=
 =?us-ascii?Q?MattCzhHJpSys40d0bMGo+6Q+mecF2cU5CEPD40kbpC4/aaKUEpLh+4Spu+2?=
 =?us-ascii?Q?YDc4OICRXU9eyWwnwHz3DY0OCaPk5Bkiue7Ax9muq/KM4ISToLBtgSF9ati4?=
 =?us-ascii?Q?Q4A8axnJeP9xK2U2EltIFgIRcNSG7Z8LtVfR1BMQIkDuWHCVzHRvVIkPizRA?=
 =?us-ascii?Q?fe43At1avPINmB6ciPacNii+xwn9mfUF3ClcnEvz6A9/GRndVdIlLTZ/1KKS?=
 =?us-ascii?Q?lLF7pL5HeyfgbJm1ZwFf/ZBOas4oJ/031rPlimMu0TjEdSB1AmQFfHTw3IgY?=
 =?us-ascii?Q?we6ve8ZqNoD/hjNP2PyB1HYLmezoZ7koO47o/1pr8bAe3u6cRkzhG2bbYVX7?=
 =?us-ascii?Q?OPScod7PHOHwvVtgmmXJDmyp+c/fjGmIKiKnAJ5B7Tt2MzDOdTIwjlN4rrVb?=
 =?us-ascii?Q?T+Y9n4ad3LC9rfn4qx9T5DwiBPqhY7BjyP+5xBGAsaoLEVBGQ/clQYsRJ1pZ?=
 =?us-ascii?Q?P6osorTyHBFZNlcN/guQhJ3Uk8gwpE8lbqCqI6vfKsspOPKbHml2wdZdWZEw?=
 =?us-ascii?Q?HEKOkECSJj/NQJy9AnyEH0tLc9Go9Bb82GTcz4Agqp+Jnuq92StTVdHjjXg0?=
 =?us-ascii?Q?0ZjqY6qTyYeSgbO0zk22db4F7LAHtd01Ewu5u1jRUvrznhJwJ6sSsMgtbUE4?=
 =?us-ascii?Q?Mv3wwbtNtcyWYZiWU96+g8s4JcPs8hNSuVsT3K5H8St7lpczwpxJN/wHMhNG?=
 =?us-ascii?Q?MXhdbCvsvwlMULjF2F57HloE1/40XpWlv1XyFimN8xglL1Exr+hPEyEG/KCp?=
 =?us-ascii?Q?bnQkafjkkq4TscyRya/3EKagMAndIGI7EGk4j3dK4uAU6A+YVSlHhwsMcz6k?=
 =?us-ascii?Q?bxIv4qKhz3/b+bGHgjEGmX9+rET6HSKDIxYrlyZ4Th04byJJicUW9Qb+hk2T?=
 =?us-ascii?Q?ZGxPXNlaEzNzOxyOnos2WCn5n37hJcsRFgqUPC0wcjjTkR0gOHo7XJSGt6M1?=
 =?us-ascii?Q?6lVQPKqkhNItR1Q0JjUjabj7bYUACAQ2wTFsyYhtxpuoJ3KE02+iigM9xmgQ?=
 =?us-ascii?Q?jMVke14bPKy1/qQoAGZFocn8zeoaX7pCEKOamqUOm/6kJQrfv0u8u67CRJC+?=
 =?us-ascii?Q?qogb7OcqcGLo6YAWIojQqWWy440Spd5us7B40lRVcWbIF7/eqQiO7STn8mNd?=
 =?us-ascii?Q?FQbd1g3izZzvsdTN6yqhK8j8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8j9QBO6U1ceT10jhsIAnGw1oEWLTZzR2tOKyk/c1rqSOsqmlvyK30EZIL1/L?=
 =?us-ascii?Q?bjhTZKFP75YvfyitcUxYXzp7veRt7cfTa3ZbYpUoimi94rwcr3UC+hAigAZD?=
 =?us-ascii?Q?Y0VhIjQFYJd2OObkvoX/exwB/2Y0Lo6Ou+eWVp1kQdBJWtkNwJRr4g6dH8wa?=
 =?us-ascii?Q?Oi27kdRV/QrzJiKz2XSK44lyAPDCR9XH2thjcIkQeBPKMlzg2ccrHhm/sABg?=
 =?us-ascii?Q?iROZJ1Q+YvsEg0dAycjQ/jSN2Pc9O/PFDu9Pr7DIhF/z1Cs9DFwNCcyL8UcJ?=
 =?us-ascii?Q?G+Kp+7lXvWJofZRgcxgZzoScYcg6q9hpu3+V22T83tobSJjFwETBMMAjM3W9?=
 =?us-ascii?Q?X+kyYmKYM8q56RI2a3HDkqb82T/ljt9vzWUTvoFfRdHarU9owCVBRfHe0txi?=
 =?us-ascii?Q?0xWsLizyeuMSOmwyjRrHmwuNM2gmk0rfziE3vVbxxgplOrmQj6Bq0nzud86V?=
 =?us-ascii?Q?qP4Bbet10DqE6oTG0vM51PkxG1d/BRTlvVY81zxSH7ntpjDCHRCDzMkHlTbk?=
 =?us-ascii?Q?fVZV3eg4ysc09lJizA6TaOrc8ao574st6O8TD63ckdXio0ik4yUq/Pu2Lvte?=
 =?us-ascii?Q?+tvlb47aSqg2AptkNoAvozMzS80qHcA3G8xSAQ49TsEy1UHG9qc41Ed9vJFV?=
 =?us-ascii?Q?8jQBD9exeQTmC9H54/Z6trU8bajrqO4uB6pFQDOMPPrP/DdErNpSkqSlg4An?=
 =?us-ascii?Q?AlCL24sIL+7NtXzbHRyiq1kTrFxCVf1nIjKBzhcj2+hsZrBv/a/5ZzYn+n4t?=
 =?us-ascii?Q?bdrFy1vR421SwmVaVxYz0A4CdQSq7oW3mSihe2Bo8xAmgD/BngboOx/R+W2e?=
 =?us-ascii?Q?yAQ8vnIY48cowA8Z6QD2EE8IeJRWEard78ag0Tk8ohkVtXh/3bUwHe3TLyUX?=
 =?us-ascii?Q?lu8Fy6u1mpZMEzEnnpdkuakNFP4HOXNLOmdSt7xWk/9aw5GPqLdeYWAj/54z?=
 =?us-ascii?Q?RuYZVDUG+h33oOqvNb1QUR+cQaTycfc//e9qeWXHd0uzHb6lwfz5POWIeNsM?=
 =?us-ascii?Q?gokPcmce1QImepFN7nk6MaUYQoj+xJqORpg91/hDPkBOJo/rBk/V6YqSkeds?=
 =?us-ascii?Q?NAsiFL6ymORc7kdtH4OWjGebsziSuy1ucQ+UalQ2ykbIwAv3wWm7u0difWXb?=
 =?us-ascii?Q?2hfDu05T+L9obQLFR4D+wXI9Wkndf9PcJR9mLylNSvBRIxsYQZAczT68h1Hl?=
 =?us-ascii?Q?s5ThCT88llXxyzpplZW5sjYtIZzgogV7HhHwCTrau85I072Kzq1mQHUlrS0H?=
 =?us-ascii?Q?kG9UTHBgAdc7E0ocn7Q8ChYYdnUhvpFu5cyHVFV62LeIzGVMUblM9AhUEbAr?=
 =?us-ascii?Q?tt99MDPiJrYTyMQkHVl1LUbnHmeMHd3UfIG5xTgW+tTvfm0zoXed7dhbE7MU?=
 =?us-ascii?Q?VJovvN1SWRTdv0ZIcdTFGA2QpqUGfL7XqiguaRuiQUcJ9+NXebUK0RueD0PM?=
 =?us-ascii?Q?JSn8nP6B4kz5XNQxQ+cB9RBdLbXi2TLM6tt0NHS/wzxVQz9oJZDv8uHd0Isw?=
 =?us-ascii?Q?BZd7uRHjumasteKhnjKI/9O34wPbzzkzTx3WJadT9N9dc6jPbH0UNey95/NH?=
 =?us-ascii?Q?LCEtwQlnyhSrBTfXYGZeJKkDlZPmE8zJHlnpI9kV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d74111c8-6978-444e-4597-08dcf247ad62
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:14:44.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4FZHiC0mpwVNDnpReOZpXQfpMT2U27KQp9t7hkEtIS/Bn+8dLOsOegXE4SbKG7xelGydOvyIu/k0Gl4wLPZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_201452_628871_97D8A89D 
X-CRM114-Status: GOOD (  44.17  )
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

On Mon, Oct 21, 2024 at 09:33:17AM -0500, Eric W. Biederman wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > The kexec destination addresses (incluing those for purgatory, the new
> > kernel, boot params/cmdline, and initrd) are searched from the free area of
> > memblock or RAM resources. Since they are not allocated by the currently
> > running kernel, it is not guaranteed that they are accepted before
> > relocating the new kernel.
> >
> > Accept the destination addresses for the new kernel, as the new kernel may
> > not be able to or may not accept them by itself.
> >
> > Place the "accept" code immediately after the destination addresses pass
> > sanity checks, so the code can be shared by both users of the kexec_load
> > and kexec_file_load system calls.
> 
> I am not at all certain this is sufficient, and I am a bit flummoxed
> about the need to ever ``accept'' memory lazily.
> 
> In a past life I wrote bootup firmware, and as part of that was the code
> to initialize the contents of memory.  When properly tuned and setup it
> would never take more than a second to just blast initial values into
> memory.  That is because the ratio of memory per memory controller to
> memory bandwidth stayed roughly constant while I was paying attention.
> I expect that ratio to continue staying roughly constant or systems
> will quickly start developing unacceptable boot times.
> 
> As I recall Intel TDX is where the contents of memory are encrypted per
> virtual machine.  Which implies that you have the same challenge as
> bootup initializing memory, and that is what ``accepting'' memory is.
Yes, the kernel actually will accept initial memory used by itself in
extract_kernel(), as in arch/x86/boot/compressed/misc.c.

But the target kernel may not be able to accept memory for purgatory.
And it's currently does not accept memory for boot params/cmdline,
and initrd .

> 
> I am concerned that an unfiltered accept_memory may result in memory
> that has already been ``accepted'' being accepted again.  This has
> the potential to be wasteful in the best case, and the potential to
> cause memory that is in use to be reinitialized losing the values
> that are currently stored there.
accept_memory() will not accept memory that has already been accepted.
An unaccepted->bitmap is maintained and queried before accepting.
(this is at least the implementation in
drivers/firmware/efi/unaccepted_memory.c)

If it's still a concern to you, is it better to add a check like this?

if (range_contains_unaccepted_memory(mstart, size))
	accept_memory(mstart, size);

> 
> I am concerned that the target kernel won't know about about accepting
> memory, or might not perform the work early enough and try to use memory
> without accepting it first.
The target kernel does accept memory before use it. But not including those
in kexec segments for purgatory, boot params/cmdline, and initrd.


> I would much prefer if getting into kexec_load would force the memory
> acceptance out of lazy mode (or possibly not even work in lazy mode).
> That keeps things simple for now.
> 
> Once enough people have machines requiring the use of accept_memory
> we can worry about optimizing things and pushing the accept_memory call
> down into kexec_load.
> 
> 
> Ugh.  I just noticed another issue.  Unless the memory we are talking
> about is the memory reserved for kexec on panic kernels the memory needs
> struct pages and everything setup so it can be allocated from anyway.
> 
> Which is to say I think this is has the potential to conflict with
> the accounting in try_to_accept_memory.
Then could we put the accept into machine_kexec(), given that accept_memory()
will not fail?

> 
> Please just make memory acceptance ``eager'' non-lazy when using kexec.
> Unless someone has messed their implementation badly it won't be a
> significant amount of time in human terms, and it makes the code
> so much easier to understand and think about.
> 
yes, it's also an approach if the above cannot convince you.

> 
> 
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  kernel/kexec_core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index c0caa14880c3..d97376eafc1a 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
> >  	}
> >  #endif
> >  
> > +	/*
> > +	 * The destination addresses are searched from free memory ranges rather
> > +	 * than being allocated from the current kernel, so they are not
> > +	 * guaranteed to be accepted by the current kernel.
> > +	 * Accept those initial pages for the new kernel since it may not be
> > +	 * able to accept them by itself.
> > +	 */
> > +	for (i = 0; i < nr_segments; i++)
> > +		accept_memory(image->segment[i].mem, image->segment[i].memsz);
> > +
> >  	return 0;
> >  }
> >  
> > base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
