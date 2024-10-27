Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1416D1358A
	for <kexec@archiver.kernel.org>; Sun, 27 Oct 2024 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dwF5RrxA8VziNELN1zIitcx402u1PD9RiAz4yAQ3wiw=; b=pIUSpQS3Rc/IW1
	vbF6D1XDKoTjTGIxl6jDOCUuNWhfP9/8q2lGqGlz5wFZMWdsvh+NKTo46DBNCDl7DOiFAy1Xmweak
	+YMqhD6ZPhts5ryqa8/1Em7d73HUl4wOgFav9eFInEl6uE1UJdTCwt0oWaEWIwgG3CY5LKZVZzmnQ
	5skFyx2vH29SHbzIA5+BiK6bXKmCxqx9KjXxTzqthdnhZ8+E3qSpE4D9FKNxKPZkF+/bkTJFM7JVx
	rSxFal11sgPBdRh4ago22atgwFJm6ivTQC47HWPTxztxJ69PHHTKRbd5k8hl0Wlz+Pw28m8GZHlG+
	bV5NLvY7+wn19ynb9oFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BrF-0000000919y-0vuN;
	Sun, 27 Oct 2024 22:35:37 +0000
Received: from mail-westusazolkn190100000.outbound.protection.outlook.com ([2a01:111:f403:d000::] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BrA-0000000919a-2wB8
	for kexec@lists.infradead.org;
	Sun, 27 Oct 2024 22:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrA9oWsiaKOWVq6jujhq9gm8gEyBJpId5X3CrIyn3Bb8QA+4LlwbGNt6/Me+FEfbdexsRuzUYavbuipukByIkjAVz0UsVLvQAL12cG/gmZgXQZcc3mm2LRrraa/RoL4uM4cwO7gVS9JDlRTo39CiTK2tRf9TnerUqzh7AebZ37nqmRDvd/oJTDDfrHAS0Ce2mDGgPO05cAjh007nrp7Was/0iESM9uxKf0+ZVgY6t1E//0e9HclbUUHa3zLkZjmsrXKNjs+ha3fLPsDg1QxIqCsQtNlQ2jeunt9eg7SLeZ+i0EXEUAJHL+qVNOp1D/fbLTqaqnaaK/TA9ak9naaGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FgYrzLZ3ReW90FycB+VP8wQVU6xWsDZjFo+WlWfFVY=;
 b=fJe/nqsVoKYwrqOSWAtHjX2XEkWHN+wAio5iQufdJGWpB19YqzSselN9/etxNFtwVhai81iyQvfJIYRGQrPiU4mi+64BYvSoYDHnjj3+N3DQksRBMzL2tS8OhXKarZHV8kjiX3RDcoGhOXqWd1DMyZJe7euwBK7wNDJmm6Vf0EPf7wVOXCBKRLrP9cEcXDPoHReBqFRZDZkplDcDgKV2c9/+ZJj/svqXg1HCMD1x74UtWv7wiRSsEgwwowUoJIcOu1/KUiJEZ5mFbHCbUkHOttda12oCaCESZNAqwbSu3yhqilMyQZsZvCEq4tKcn48ZQkUNxfahDQg2iB0a2omJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FgYrzLZ3ReW90FycB+VP8wQVU6xWsDZjFo+WlWfFVY=;
 b=IidyQhtUgbIua8zy80CZDHyt3mM0iG9fuYrKTNxdr66YeopUu1MReKd0fk3dD6GHqScyyhUvIKE0iDomv5xZwqFagYC0ouHOCLzUNLHgbHBCg051jhEPAqad32HrLgE5qE+yGYFZxVMRzeuIrji5PNMoeHjM3Lp7LQqwAFUYVFPrkhJSpBc74Ts3vTEDiZcQw5l5k3bXhVQqKMN2ccR263BGRydgxgsx5bnrv+DFsOSkgnlECU/nQruTmxInfits3AbqgNuYIWVRVLlWZjkk2OPI776ULCE51BtB+q+w8tdqLaZ9Sde5uY80RZ9Fgqw9nsNO22HkjLB7C6340zAuSA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9528.namprd02.prod.outlook.com (2603:10b6:8:ee::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Sun, 27 Oct 2024 22:35:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 22:35:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "bhe@redhat.com" <bhe@redhat.com>, "vgoyal@redhat.com"
	<vgoyal@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-debuggers@vger.kernel.org"
	<linux-debuggers@vger.kernel.org>, "stephen.s.brennan@oracle.com"
	<stephen.s.brennan@oracle.com>, "horms@kernel.org" <horms@kernel.org>,
	"kernel@gpiccoli.net" <kernel@gpiccoli.net>, "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers
 description
Thread-Topic: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers
 description
Thread-Index: AQHbKLC9OxyqYTqg8Emr5P3L75JltbKbLqsw
Date: Sun, 27 Oct 2024 22:35:28 +0000
Message-ID: <SN6PR02MB415728E95FEBF7CC79D45B97D4492@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241027204159.985163-1-gpiccoli@igalia.com>
In-Reply-To: <20241027204159.985163-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9528:EE_
x-ms-office365-filtering-correlation-id: deb3fb92-9623-42e7-a6ff-08dcf6d7a860
x-microsoft-antispam: BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|4302099013|3412199025|440099028|102099032|10035399004|1602099012;
x-microsoft-antispam-message-info: HJmNTbXG5PkR8LFk8T21HiNM1vI+H153OBJBwEfYUidYeG/V64nSg+wciSvbAQOCFBpxlkDQvmWMvbQK9k+Ecq3azXCK34L9CjtUmhbJN+9B2fqFHAyzAhmJzCW8ZZ7yjMau610rdw5OAl1ZyVRBKk+4q2leJqiFhtCLFAODmJbHQZIfnWh6vlhRtZKEqUvJoZ4oeYXcRvRJF7WiCs2ql/NoJKWo6zJDP9F7OZLUpXmgwnzbFmKva6LnO7iikkbp0iRzkQ5Z5Vng49KtHObqlIWDu608kC6pTcJxCGI10dbhxpWTtl5oMZ1BXW2xFyROokOVEXllz8xBQeb8d2jTbkuKOfQEJnt+rIrW17k6YfZOJ2rBGIW/Bq9aHQ1+HX8yhlAPqZ8SmusRM6XzjpA5CQZb+cUyJu4gCTcZkzWOp8kVeGGsXgF3CFJ9IcLgGTuC0Oe67nM6wx6sWUp6IzhaYLkvK702s8gjjrZ9hOEZh9Uv70jgQK50C4VGUtUybKAumg6XMps9nf3zGur61US7ph1dhdtMXD3OTzbnH4GOBkZiyGouLaCs6QqfF3vR4wgEsql22+KLgMLxO6D3VE/4TFhK118yLuP4Pjg+OcV/56l7b1OppbZXGzQ2G8b63x7GqvGxPRWSJnhvBteq+tGDaT3rHZqyzKMoYvT4Btt03ht01vvjzmUOUzFTMr6N8dQCjiXWt61NHBgahwi2mHf6moNcaJN5kEcERj1gB32iKxqNEz3+phCvtfuBsTu5c18uNK1FcLPtVTp4CJ8mihrm6hKH8H3X3T34nBGiNAX+lMRmPTNyY3uz1rADoFdeEDID+JbbJGsUY9gybq0NJQ7Bys2DA2l+maTLqoXqEkFbo5y64fNcsAnFSvU6OiwQfn03YdKI7PIyu+OuHN9nlqLteA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?deAsIhpSu5lHhu5Q/LdHfmaJRM9Gk+DakqffkD7evQqwETLxMDwZBK0rEkvo?=
 =?us-ascii?Q?3ZPjWFYvsFxJ/vn8mzWIziZdO0g1rpOROmo4g3gQ/LZUNcmechbRSOVWVKF0?=
 =?us-ascii?Q?p01QYgunWu8Jrc5RU/wH1wv+U+Xj1YjJgiiD8JNyVnU3q3wIY8qMChT+6VIU?=
 =?us-ascii?Q?fN03wQlpSzNGzfpCyl2w1kWATiMGQep5fBa+sM7Hizm+Seolxg1sSYgcf9g9?=
 =?us-ascii?Q?eLEjUwZJgI7zID9sJJcXleDm7R3itNQdTwoZNisIKxAVZgCrtizlkzyeMTIQ?=
 =?us-ascii?Q?3bLTg9DMLmPsW1uoveSqYhMkiV0lwmjLOHCxFKR6YJZh6TVHPr+5nK8Yo6rh?=
 =?us-ascii?Q?HuFzyFoCbmmMGb9XYAshLnpi9oQVXOVZiw3HTLd7VkGz3hS1PYCoQ9ocU87O?=
 =?us-ascii?Q?n9DcmJ+7/mbz0IW1Y6OFpbOccPUapwRz8XTabUxbVuJprYiGMpDmlqIumzdp?=
 =?us-ascii?Q?Nmi/nqBcE9Biwo1RyXvy1wKTNg5T95/wiS4VsuOfZm0KnhZfJrNRjEJfxRz0?=
 =?us-ascii?Q?9gBPV1I53SNos5VACjZED9QIRvKHsg6QH/ib1FBIdvVF8r/CFgkPBMJYHz68?=
 =?us-ascii?Q?QPAJnMLtMaQtlwiyXQrLPkOuYrmlZt5kYLOMGK04odx39BmUdPVwcvfXqsq4?=
 =?us-ascii?Q?NVPQo9PfHJnIItWDMSmLJvPUkeh5HJEsUbzjLVzd2w0FRLGAkvfRLmuq2ycL?=
 =?us-ascii?Q?08AGM+NNseZGxCt6Mhq7suwfOtdVK5l/KKjEqPGN8E7mDd6+dB2sFAyyG1Ko?=
 =?us-ascii?Q?i2W1UdYJsBX6/MiaDUw94h4VnTuJHg8339OgUGt8FC5TZN9hErdoKbyRt5nl?=
 =?us-ascii?Q?lP0Wbl27WGncGjCKcJi+s/pmaWXk5g9zXCBZWJJ2E314KhmW3b22Kc0v8JS/?=
 =?us-ascii?Q?/FogChV3oUU16r1MN4DjGSSSxtoNxEa4wybMkb0lXcCn01xn5197Jjj3P/g/?=
 =?us-ascii?Q?PLP30ZjQPKTfPX+mOOgfKtaFd+NyXUHsmO1Aauh0rli32wBThVfVnEG4214T?=
 =?us-ascii?Q?H2Kk110Of78n6vOEJnAe1p5JerZbBOD6lOQPcAnCF5OZGQE3hnxTatUxH8Ww?=
 =?us-ascii?Q?K1JhlmDZ9KT40M9hy/ikBaCARuhwIoZ+CRPIeQRRC68dQAf26yklj6xe0avR?=
 =?us-ascii?Q?glYi6kdRLO70IlzryzikmLVZbr0/fFj7a+acs84345BG2bts8u8TPdL1VhK7?=
 =?us-ascii?Q?MPk8t5q+OWYI4kvXNWvJxDegpAd0eB20+y5DKvKYhqhFHlsj399DKo6q9PA?=
 =?us-ascii?Q?=3D?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: deb3fb92-9623-42e7-a6ff-08dcf6d7a860
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 22:35:28.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9528
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_153533_548936_E5E33A64 
X-CRM114-Status: GOOD (  20.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Sunday, October 27, 2024 1:37 PM
> 
> The crash_kexec_post_notifiers description could be improved a bit,
> by clarifying its upsides (yes, there are some!) and be more descriptive
> about the downsides, specially mentioning code that enables the option
> unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more recently,
> AMD SEV-SNP[2].
> 
> [0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before
> running crash kernel").
> [1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore
> generated with panic").
> [2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware
> shutdown on kdump").
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> V4:
> * s/AMD SEV/AMD SEV-SNP/ for better clarity, since there are more variants
> of AMD SEV - thanks a lot Michael Kelley for the good explanation.
> 
> V3 link, including interesting clarifications about AMD SEV variants, by
> Michael: https://lore.kernel.org/all/20241025162042.905104-1-gpiccoli@igalia.com/
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 3978fb704c53..1dbd0b0df6fe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -918,12 +918,16 @@
>  			the parameter has no effect.
> 
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases
> +			the risks of a kdump failure, since some panic
> +			notifiers can make the crashed kernel more unstable.
> +			In configurations where kdump may not be reliable,
> +			running the panic notifiers could allow collecting
> +			more data on dmesg, like stack traces from other CPUS
> +			or extra data dumped by panic_print. Note that some
> +			configurations enable this option unconditionally,
> +			like Hyper-V, PowerPC (fadump) and AMD SEV-SNP.
> 
>  	crashkernel=size[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> --
> 2.46.2

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
