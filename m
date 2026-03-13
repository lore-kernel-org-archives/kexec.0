Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B36F107BCD5
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GYXnI2vdIHNvh+pw/Lw4YXsJpxdFkolP02bUfhxYFu8=; b=N71hXfvnn8LBB5Zx3NxhbBzRKk
	IrGm4/EB3uPZiaEeAVAwki+mkiRaZxFT25ZulXTRi0h9n5mKMEpxw+FxYovQazKy/ixERF/KJye9I
	NCxvfoSfNzTf4CDry8o/IRVKd5DqH7Hx7RTLbwqCRazcz5w0NcBa3H2oG5w8dLx5MhrstEDecxuny
	hodQMrYTMcmOPeYNI+LaqTZktNyb14d3RTXe6Thn2N02Xn3tZ0X+d43G5YMRC6LjRouyTOw/Pu8BD
	yLQU7Ut1gsPi7fFuCEYVlWWovXNOE4cTczQoosss2vIorLFvZmESm4MlHt/QOlEdBJgPJnnad3FCy
	pVSJSxYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w16cn-00000000mml-2NnC;
	Fri, 13 Mar 2026 17:48:37 +0000
Received: from mail-southcentralusazon11012038.outbound.protection.outlook.com ([40.93.195.38] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w16ck-00000000mls-1uAr
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 17:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVzR94sFf8RzkXy04JZNp/SBjumFHifuTgFtAqhrnEK5W+JzAO+4McAImykfmq78bJ+K4TCaVywoSI3IDEW8CVTbK5agawJJEwMW2EP3n9CdRjf60ZHxh7wCEZcxuEA9vMy5KaB80mkAmqeOTxpWb3wt+aCJCMjHwxe95N6F1JpKdDqVJnjd3LWX1OGHK08riqGN//CGIyxOQoehtwbkj1XsaS75DPN1pqfeVIn6M0PuldPhX9PQcsUzua/+T4LOJshOmdSiuwFKKBPpShd7Uf16HauArC2MWq3rAGUD7vvowxWUUbVqrNr97FB258IHk71xIwXRspDy9QQF36iktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYXnI2vdIHNvh+pw/Lw4YXsJpxdFkolP02bUfhxYFu8=;
 b=VvS/gA5AEtk3DuEGQEo9cORAYbnbeHmCZl0nx8QKXh3CRlEYHI7uh2JigOYgPt6ciPcwQ1WZDVdWE7d2MKu2kWYQe43u1DMbUh0IaOMebjCw3y9ueKiHBk/fTHkS+NOGfHfoqWfKRWi0jNxXVX2VzCohhbrr0ZhFKtSK6ll0m1nifvmcHSg2sUEvwsqF1/X7gRIqPdm0BpVbI+zXz2x3vFnyFlt4moWgsr3bFTgw0BemSX5m1VDE6cwtaL71rydVzevbWCSumMOA+ppYkFjirgeBWPWjvXke5WbKg9uEdCV5B6AfSisPjXWL1nbAXQxdMVLerIeIIz8hkJt6hhiJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYXnI2vdIHNvh+pw/Lw4YXsJpxdFkolP02bUfhxYFu8=;
 b=I/jbwPUzsqUE9qixPc/NFJQpDdLGVt9Bq5+I+2CAZEUHuHuHDFzxSTu8M9Ynh7T5AcqkbaWrFzTMMbuOaIYmTBC4+2LQNoexkdVN3WwmX7Zy9nS4n+LDFwsspAIPRTAoUqNoUig950zxLR4+W3C/CPnowSMz1L6AEtAkmmPGok0SieJPfb8NTQ42DxkVAqLOSFJW/DAYh/K8nYSZ2DEi9xukUTNoLMKs/GW5wmP4biVqe742CbVuOEixaltonRezqY2+O4qXsnS2Nq/ZpZKw/+oRihw3sXUF/0W7t8a91cvbca6RfY55C+k9lRXD2TiRg2tnwiwmHpAe2AOXqeAGxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 17:48:25 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 17:48:25 +0000
Date: Fri, 13 Mar 2026 13:48:23 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Konstantin Ryabitsev <mricon@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abRN59ST3uRDS5-e@yury>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <abPdItJ152oMzGd6@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPdItJ152oMzGd6@ashevche-desk.local>
X-ClientProxiedBy: BN0PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:408:ed::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f056589-2632-4a80-3324-08de8128ba0b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cqw79NQ6ayA9+ltS0AGjL8jzoYbmmkaNlFnCKwH3BL4VQ4/QCfCUbUxke3fZFQb4gXRsFBL0wyBXXTT7ZWvJw5W+zqaoae6c43DjFVF/uZulwa6STBU/yAGGbUa2oJ+E0gSBzrL+c1tbm1b7/oy6FGyUm3x7DOhUSYOJs882cLI2rKBt4SP6tpumIZ6HoEWR2JU3uSpP5XZ/1f1rv2jm+e01ILR13nVicLcLA61cGPFm8V3L1JkhYpHN+d67f+1iElNHDkLpxLlIjdMbDOrRnntg29jQn+99ZmuzkCNhYvAfyUMmW8x70WTFllUiQ9SR/3NJW2HxWRPbQM0F09MsU6Fopw59il55r6V0Vi5pVHI65FCjFxbCQZPHCQ6im2aYdxavpVTY4r7HCixDkvR0CxVRUrns722bsY7qgG94BfJkp8PddTmrnFunAyiOJJ1D5M6g7U1EPs5XIJYT3AuA6DKqi5qsbk7KmR3PLGYm6zJL8knpzSdcYFBw8ycXDat/yLEqGb4Qn4FwOnJkUbMfZ87Xtwogt+LrNJLCcImtAyI0F2RIG88PDQmw5fgplcZKymqQd9jQMbzza5ATDhmYQslhMisB+n+OVueE3deQMh/PWRHKs6Q9joTBAde9tyJMmCJdcizRTmdp/xRxX8KFkVqmfZNP6AvOCa4BmGDvMIDvc+iNaQNCPz3mPgA7ffy73ZSOznrg/PtSWkmYw1bY+Krm7DiPmoNiMtbQgX1vh6wK6WBMOSV3alkpF+u1+vzg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZgn0EJZPldzZY0oAqix8rs230AbM7WQt/p7ICM4v3alDTMZebS4+OmeKtjk?=
 =?us-ascii?Q?oO370YPYhxM+emCmi1UGiNSJqPMktA5hsiZ3vGd8ZIw1KLk7Jsz9nOemL1dl?=
 =?us-ascii?Q?xVt6B0M6nsrzRNbTC/sucEtHHgNB9kuYLIiw5onf9vNg0KZotetP1Yeeyhnq?=
 =?us-ascii?Q?tykUPffSXLinzkSgczg9AwODThaH558I9JkD2/j9+mk9JKagDo6ZM8wMgtfx?=
 =?us-ascii?Q?HLayKqtzPNU8rBvtAbqwx5YlKJFdv4X0g9noh/11PJVtmDf0KemGAsU0zSbV?=
 =?us-ascii?Q?p9pNngBKn4kTtpjrUeUhXvXdmBpHC9j5OSLGSHxwvNUMMpymJpCGAzPCqUxx?=
 =?us-ascii?Q?H1654KFENQNXwyLA3xszPNuWuGcIuHJE83f+4hu4cIVRGiyF86zWSm6+4I07?=
 =?us-ascii?Q?RjuB//hStoC6kE56GoBzfavs4w/jTbxyiMtw/UYJbcU9PEfQvgXVRoyYznRw?=
 =?us-ascii?Q?HTx1fU0zkKkqZCpH0zrDbqDStre79Vn+ayRJRkUX84V8wCQ8dLyG56gVWXi9?=
 =?us-ascii?Q?bErrZqck0nxBF+vFtIPCGjdDYpcTdNwKU9TZ1aEbg7qqtOTFoKlOtXJmA70R?=
 =?us-ascii?Q?XDwkiZvDW0Dw3py6WajJfWEksYzzzK4UgWLNoWzRN+jTNzJPZYsHaLuMaeIy?=
 =?us-ascii?Q?Xrbc5P/XajkxoSrUiCwttqsdAe0J7d3b5g0QaBX7C8cJBYU+iba8JjMKfX74?=
 =?us-ascii?Q?0bdMuOiN66avRm8H8V5+OJjUACMEXlVLOVXLd5j1wtaFKqoeUPpvFpBTkV0x?=
 =?us-ascii?Q?NjYztymVClUojU1VaAcWm2vTCIpZ3xs3Y1r9XIzgnQHBan+qwoqs8L6xA6oT?=
 =?us-ascii?Q?Lb+UQphlL2wghkoYMtL1RCoPimtOvh2glmpR3vf707pgZvsoMz2IEaQc0cWW?=
 =?us-ascii?Q?FBM6/Xreb+0FQjz3RP1GYjzgDrm9wmK64jK3SBVSKJTjTlTHXMeCk7Q6UKWG?=
 =?us-ascii?Q?0xo/Sb4A9JCq2yp0oRK0Bux9XBej6FgbGPLUBpwnlnA8/JaVXnWoxY0zwP+F?=
 =?us-ascii?Q?+8dB4mgHIpuyD8g5k8sfIPPdBLRqxzHAnrz+7UvvgQhsY2m4vr4C7aWaFZp9?=
 =?us-ascii?Q?CD1vQFcMIslnXn8rH7EuYOI22hR17oQCZlKnA1Hw+H13+AshlmcObYOGL9N2?=
 =?us-ascii?Q?HV0i+y8CDyrjrLjdq+vc3nFYOy9om0/pSQccDrWxKE0uVXYzu0o8+BehkvvV?=
 =?us-ascii?Q?7Hi0Nn1yy9yqpek63Ea0vbraTx293R00BCNYhBv82FpfX+Lyo2q/3aJg2kqI?=
 =?us-ascii?Q?EZZ/7QLHH19z0ej1HGbt8zwkMvFRKcoUrgfSBlLGdj7mTooJ41Ek3m69w//p?=
 =?us-ascii?Q?1cgr+YYjM/7XO54toB8TNU3meP8eGce1PHVm6NA1uJwgkKDyfcKbgdVzSDBF?=
 =?us-ascii?Q?yY8aM0c9MuipyLpwBi+j3++l5tpmQWe7TEX6/j7H0ClqnVtAWGboBhq1b8k2?=
 =?us-ascii?Q?5EEoZjEUgqfNroT4uUwlOkpPW/ckKsINWEBrMjaYprCr49ivfCz8L/EgA4vS?=
 =?us-ascii?Q?ImXEkODRFMfP2ZCSsZpT2d+UVNffFo3qbqtskwNtF/ic4v0uKdfLb0GAP+S5?=
 =?us-ascii?Q?H9NqQYt5+s4oEDcHYiGWJ7vdQu96rMYqP00Rm9SSiPJHyxEnzjBZ9SKq6voK?=
 =?us-ascii?Q?aCQX4SWmydYXMZpi8AiO/KNpJatn8D8ardDfWA0yrtGVe/FrF0bdEk60HOEK?=
 =?us-ascii?Q?1fymkGatO9wtF76Rv4Y79bMANEnhpXwTSCrZzMqJgekFD1X+//FpgKv9Q4A5?=
 =?us-ascii?Q?NNprO88qKs8L56owxjB0bw2w4Y7QLjGkSe2rJOWdQs/lp8HHLHeI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f056589-2632-4a80-3324-08de8128ba0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:48:25.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEN286Byv1ea2oE5zDEF7ennw8tycDbCzbXwWJAaSqBPJJ5F1ok3JpcfrKJXgXoqYTAXgfE/clHAjllaCU3SdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_104834_496102_C93FA686 
X-CRM114-Status: GOOD (  27.82  )
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

On Fri, Mar 13, 2026 at 11:47:14AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> > Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> > to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> > ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> > 
> > The 32-bit behaviour is inconsistent with the function description, so it
> > needs to get fixed.
> > 
> > There are 9 individual users for the function in 6 different subsystems.
> > Some arches and drivers are 64-bit only:
> >  - arch/loongarch/kvm/intc/eiointc.c;
> >  - drivers/hv/mshv_vtl_main.c;
> >  - kernel/liveupdate/kexec_handover.c;
> > 
> > The others are:
> >  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> >  - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
> >  - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
> > 
> > None of them explicitly tweak their code for a word length, or x == 0.
> > 
> > Requesting comments from the corresponding maintainers on how to proceed
> > with this.
> > 
> > The attached patch gets rid of 32-bit explicit support, so that both
> > 32- and 64-bit versions rely on __ffs().
> 
> > CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
> > CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
> > CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
> > CC: Leon Romanovsky <leon@kernel.org> (infiniband)
> > CC: Mark Brown <broonie@kernel.org> (spi)
> > CC: Steve French <sfrench@samba.org> (smb)
> > CC: Alexander Graf <graf@amazon.com> (kexec)
> > CC: Mike Rapoport <rppt@kernel.org> (kexec)
> > CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)
> 
> Please, move the Cc: list to the...
> 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> 
> ...comments block. It will have the same effect on emails, but drastically
> reduces unneeded noise in the commit message in the Git history.

In general case, I agree. In this particular case, I want CCs to be in the
main block, and eventually got replaced with the ACKs from the proper
maintainers.
 
> You may also read this subthread (patch 18) on how to handle it locally:
> https://lore.kernel.org/linux-iio/20260123113708.416727-19-bigeasy@linutronix.de/

+ Konstantin Ryabitsev <mricon@kernel.org>

(Thanks for b4!)

Interesting thread.

So, my workflow is:

 1. git format-patch --cover-letter
 2. # Edit cover letter, add To and CC section
 3. git send-email 000* --to-cover --cc-cover
 4. b4 am 
 5. # Address nits/typos in the mbox
 6. git am 
 7. # Address substantial comments in git
 8. git format-patch -v2 --cover-letter
 9. # Edit cover letter again to restore body, To and CC sections
10. git send-email v2-000* --to-cover --cc-cover

So, yes I loose recipients on every iteration, together with the whole
cover letter. But to me it's not a big deal because I can just pull
them from my mailbox.

In the better world, I'd like to have:
git send-email -v2 000* --to-the-same-people-as-in-v1

In the perfect world, I'd prefer to keep the cover letter under the
git control, once it created, together with the recipients, once they
are added, and be able to edit them just like regular commits.

There's a 'git am -k', which is seemingly related to the matter, and
it keeps the [PATCH] prefix. But it's not what can preserve recipients
for me.

I'll try b4 prep and trailers as suggested.

Thanks,
Yury

> >  include/linux/count_zeros.h | 9 +++------
> 
> ...
> 
> > +#define COUNT_TRAILING_ZEROS_0 (-1)
> 
> Shouldn't we also saturate this to BITS_PER_LONG?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

