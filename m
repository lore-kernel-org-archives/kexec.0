Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F449CAC582
	for <kexec@archiver.kernel.org>; Mon,  8 Sep 2025 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTazilRRQUgzVgW6twbcGUfVNxS0a3YnsG2oe8K77sc=; b=ZthB055himi8vH/asoxzGM//IG
	exZ42sHjTqw/fAw0MLRuAguMCJ76Gor8oWsrBTnIIXHPJIT4/TXj5kdf90E+bvNq7BA7wV2SLbrX1
	8qr5pzhH+sFhJoAertBEKmVf+iSxBaI1tAAqocIWziLTLahFvMB/8jN3kbFtISfhEQgvY8hCcgaJi
	6p18RsoG6VOJqd+sIsM1C7eYOiyPUKTIxfDTPswG5h0adSQ2WeHL5TH/AHm0YVeMB+C9qI+SLBYf4
	NJM/TM19Aj9vLZtMg6k4/68rpGGRG3shPFFw6DPujhw1WEJZpl+oVvjx57wpnhE4aR61MxvwJwGEl
	0+PEjGNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvlfX-000000034cQ-2G23;
	Mon, 08 Sep 2025 23:53:07 +0000
Received: from mail-dm6nam04on20604.outbound.protection.outlook.com ([2a01:111:f403:2409::604] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvgRg-00000001Toj-3jcI
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 18:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJWYD3hjZDW+nIO0hO0QzugoRV4eZlt6IzRuItEPScSmlFtiMW6pocxidF+yFm4DI8ZbGh9veQk01B1qUwQ+D0AM1o8537Mor/7Zu0uCP3dPmv9k6eKKLj2xRUZgaoiADjeCmp9OeuJwDmhO9OPy7bYU/0x7lguF1r/fhyZmScLR4TNqsfexCSrZ9Zx9SGXfzO6beHYNx4QRnLPquwGn8yv7Lbpo6X/6P/We3NIR+qJU6pLYuSo6Do638tbMOtxAuI1cnAMbKXoiTs4Tz7tyt9mxe9y59nU67zqU3K1LStfa97rusvbfRQL6y66p4UAa39UQsSPoE07hKYR6Lo2OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTazilRRQUgzVgW6twbcGUfVNxS0a3YnsG2oe8K77sc=;
 b=MEkjWac0KUV2zWcuYt4/2ng2FIiSk1cVSPz51LLYEZ3qYWLFYEo61yhLMYQx5JHgPe7DLIPheIzHxbTqR7XQyV2YTdFPE0xTR/JEfpBDubxITP+6Unv1JB1gpgaF/DaXecc1W8bzXZsHhkKcD38QkosnuzB0KzKkw/8XAjD1yppwBQObwGVwBY350xWEYtMi4JA4NixgS4fpWcyleJEzGIf/VfeHcf+PB1ZTj28BMLCum+DqfjkgE7nkNKk8VxhRNQmwXJk2Ujz1bY4eboXebwa2lPEvcvFe3l/NAgTRo0icC+dcoWvcmzIdcwD/JUkV6n4RDsKLvrqydD5vYaIwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTazilRRQUgzVgW6twbcGUfVNxS0a3YnsG2oe8K77sc=;
 b=acV0Sq8YdBQjyb8nHQiuPYuWav8jRbHuwHKgAdAhhr2KvFeCjAv8TP5pwswL/l9g3PsuUC/0PnftJQMknZWLFS+ckza/TP7FH7veWG/lPqf4L75N7Bcl3peceEtURgRj22HTtMhRDItYdLL6VPa8AP+WVcDdKEt8HqR3G8oyZR9iV83tVpC2Ma8jjpz1f4jfQCLk8d+H9cABUlZQZeBxDmmuwLmuRfFChjQ1nICcHD6BiRH8tdMBbmt8nE2bLyF6aERZkhCcQt+JcqXiwZMTDOWESAdOIG6ExtVHJL8KrAIInMvKJqwlEnjcwlI6OpA1NGnQKal0YbigHvc1D+K2nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 18:18:18 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 18:18:18 +0000
Date: Mon, 8 Sep 2025 15:18:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250908181817.GG789684@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmon784.fsf@kernel.org>
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: c329a428-55df-406e-c63e-08ddef0415d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UtcEGsRI7GuAuR2NxPDzEu/lg+pSk5oHtRkV18CPIjlaSYef2fAsMomQlzYa?=
 =?us-ascii?Q?ZYwo3PtHC8eg1WAqpMdb6b2TfdFoten8siZ+CxQ+/x7loEahmuepX9N5OZi3?=
 =?us-ascii?Q?X9SxbbfxYNWymJejtL4gUUC08z9IrWFlU9s3oKsWTKyJ5E3mVq/HA9RQfDBU?=
 =?us-ascii?Q?6F6HeM6OTOweJ+wdeZ++dWCOVrnGzgJb0jUJUy2lmogP4V3QvxtI9V7m4Hx3?=
 =?us-ascii?Q?+0o4js0+jfMGYz9IH9MIZAntlN0NpmBexjkj2tDUGYkhVyQSwYVLmq8XCBF/?=
 =?us-ascii?Q?xlW34JKLPWmihJQJcDKsyW2BtgtDMbyLFbYYLYUlKnFdbJCLz0APr5auGz5l?=
 =?us-ascii?Q?gLASidoK4mgdYJa09d4qF2Xja3UJIzJpkSXRK86HI0gbSzLT3aWmM+ww/+vC?=
 =?us-ascii?Q?CgfgpdIcplAok39RTFsufIktqHy1HFWUNED7xAx5/4uV6/R+hFf/+wd8/ezN?=
 =?us-ascii?Q?vrf/Q1E0Ckry7VzUXzcfh/53I5+P4LDPqLAeb4JePLA/zW9j5TI4ttM2LuMO?=
 =?us-ascii?Q?4ttdqghHHbWu8d2KfvdflUee1qSJNzlOoYI6NjFxcOi5SEmyGoN8P/xb/zb+?=
 =?us-ascii?Q?iKW5Zx7aE68FenzNnAG50uddFIaSl42WmKpYK9b8zZEUNLWgKjACNsBET+9d?=
 =?us-ascii?Q?6zoiGXp6m9lzSfdpEivJcYgUfzxcEla8wpBhEBjyvTGTdp0FSUvGEO6j4WgQ?=
 =?us-ascii?Q?d5sKJPCGNQHDFkSVDIyDdXfCMxRPdZHn5sgF5ZRv3VIdkbcD9ggwrY69jyIH?=
 =?us-ascii?Q?HJel1/3VCoVMAmHycA0P3aA0KZ1RoLX8LOPr3oTus4+MJ5QXkk9BwAx3A1Az?=
 =?us-ascii?Q?KPGnFwCpnpoHJvvPWGTlHYnaHGvgn2+aK/WbXTkecPFU4ZVfO6aQkEGL+6+h?=
 =?us-ascii?Q?iH7MLt1lkvGKN02jh5YapFi+kgMSzrVK2Cqa7XvyU+LTg1p6EwQR0Ss3QYZ+?=
 =?us-ascii?Q?PzeCUEGQDpA6XPASpu/JN1VopN6iYl9P2tKrz6VkcEJBex8MNHlMbNm0vxKb?=
 =?us-ascii?Q?+/rs3wWWrGNDwOJj6i4Yc/QRJOHkmFQYBy8wibTnlnlP0zLNgHRG2c+mhpIf?=
 =?us-ascii?Q?O7LBdybWB6kbgQlZGxvXeTuxsM84SP83IkUoT7yIuPQSBY3zjlEHZ0ISnywD?=
 =?us-ascii?Q?Ka/CVk5o/t0C4444QtEq92jDM6xpoQV8rtcczTtEWHQvj86y1CBje1hcsQ9Y?=
 =?us-ascii?Q?FCJXuqowYuD5fxB8Xj/B9LnbbopB5AgGBV0GCJ1ydaqlDURgOO8ZeLd/Bbwn?=
 =?us-ascii?Q?dRgtkZlg+4iwfDb+vcBR+My1Argnrz02qXQRAbPwW/Ti0LTiECw1BqwStVhr?=
 =?us-ascii?Q?FjjYTCef3VYeuqXu/hdGP+rv6MsZgM+31Nmp+jHYu/LKDP0t0cDoz6yJ/0di?=
 =?us-ascii?Q?IV/Rxvv0JSt3hgsYXf+2xmUcErHZmTxPlayt1XQTAP3P109WUoDp3ZV4E4B2?=
 =?us-ascii?Q?ve5cgpUtBb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5753.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2jLwsmkpKCa2vD7Tc3MicygEL4FIbDTA/H41ckRXagtav2Dk2Fmpr21Zs7M?=
 =?us-ascii?Q?G1i8uuCKG6jygjoToufAmjXoTawdMCswa+tDLrKp7tS4UhbdmVdTUjbNxWcx?=
 =?us-ascii?Q?E/cAypdiOMyZayrr9E8fDtD+mNsyOIoBkuJGHal8Emn/aywqFaLUClwpgk7H?=
 =?us-ascii?Q?5GtErHiTnSFkBzS2gZ0BDOBc6wPBIiTgV7ccfiJZFMRV4R7ZDi6WsGEPLEYj?=
 =?us-ascii?Q?DTOUqrab4RjDxVSp9mHvoXGbSTr55l3Cq6WAGJL58xfKbkmpsZ006IH77rqD?=
 =?us-ascii?Q?1Abluz7u2DsU2Ggge7+RySxG0gJaYYOZ0yRKO3v67Rf2Q1B3bGP0FRf+dK/L?=
 =?us-ascii?Q?YFwFsP7vjqgN6dbC0u0AXr6JlDpTtUK+fnyL07Lm1NWpGDArKJiuuXhK6/6c?=
 =?us-ascii?Q?ObVLpWSEatKmDn/L2h9Fy8RCBy7JNhdrZwDs8NatD2lywM1J9cjd0euXkkEC?=
 =?us-ascii?Q?3NNNNPzyFtBmW6bPNovBkfVdhOmxemm0rL62xCVIP+LL8aEe3GsutEf8AT2y?=
 =?us-ascii?Q?zjmJuwy3souq9KD3VQzXfSGBuhwvbbyKDl2H0vo93yBhzLR6E81RLXoIK02e?=
 =?us-ascii?Q?nvwOvjB3rgbJF793viGEYEVqPtWBzz9VlhJ3400yAmxBC4mVotq0cZA9KuNu?=
 =?us-ascii?Q?ABo4Icf5XwNN75D9EwUEh5AMvaFyCObVoBHykZBkRPjvQZsDpTlVIrYiDBfI?=
 =?us-ascii?Q?jktfXmcn2BCqzpNcbuEZVGiXjY213Iiisqf0izTCNhVWIbXAaNAA4LLnui3V?=
 =?us-ascii?Q?sW8uoIrpqy3boh5Dqhoh1Ci39zwYZPgwLxv+YPg/JoXLXuvVRzROVMvhCQwY?=
 =?us-ascii?Q?WbfcCbgJh+7Xu1AHJMG53HLfs2UmTCYGXfjNMsEpA+RowTmSSXSNV7YQsDt5?=
 =?us-ascii?Q?2xaOSdGSenoLobp5RcUZnQDesN+QIJ5mBTqieE2BQH+r/+LTFzSmWwbCpbXT?=
 =?us-ascii?Q?QNrDj+BsEaSyGm1jfCDDYpBHa4Zrx94MFYJldsR7XsNvGvCSYVwW5aJpxJzn?=
 =?us-ascii?Q?kPmgrnXuvRcf+X/3b1WRT6w8Lf5dyVSrFRexXQw/htebagkSaxk6dMrzF1rQ?=
 =?us-ascii?Q?Eos1ecD5koWgRco8K7OCn1vuKqR8UUMl5rV9F65utVYQ/TN44KI+l3gqAJWA?=
 =?us-ascii?Q?BClw0rCFdWvzblXfeszIkMhmOBGXi2piXrZ5NRj7xa2ussnK2gH0FrdASylY?=
 =?us-ascii?Q?W6WCW8OvAY+fwkk0POxDFMZISu9GBCvH25opzjA3+C1Jh0fbOE4xI5CsZF0s?=
 =?us-ascii?Q?JfzUH3baUMpc/OG9T2Tp8KE7qgcPH0PvBjrTlp41UjzHxf1HD1R/6sGy3a0H?=
 =?us-ascii?Q?LXV1pTgCZ2IAPEzFzeNKKM6RCkSWCjkF3OjBvI74NyWljWSgbTjJvLPd3BHX?=
 =?us-ascii?Q?P42SAadQGaCMLnQSEMzlSTlPNgadbR5iwWjilY9i0o1OK+H7X7BSqftv/AUQ?=
 =?us-ascii?Q?sg+ZPi+BZvfpCVjOyzYyAOIAXyWHanlizu5JWctiKzhO2FBBTn8zXA5zuaoM?=
 =?us-ascii?Q?vPRXC2a+xL7PbmeP+VZtgmTIDjw5ityEEUCJDUR2c3ZjAzXWC2/l4qza0YbG?=
 =?us-ascii?Q?RUqd9wZzLk3GVHSwMF4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c329a428-55df-406e-c63e-08ddef0415d5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 18:18:18.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Paa+zedHWXNKEHazkhnF89E9VgThDU9TgZMt0NqQ70So5MOJot3oXQjCDG7lMbSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_111828_931359_C0BC69A3 
X-CRM114-Status: UNSURE (   9.65  )
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

On Mon, Sep 08, 2025 at 08:12:59PM +0200, Pratyush Yadav wrote:
> > +#define KHO_VMALLOC_FLAGS_MASK	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
> 
> I don't think it is a good idea to re-use VM flags. This can make adding
> more flags later down the line ugly. I think it would be better to
> define KHO_VMALLOC_FL* instead.

+1

This kind of stuff should be avoided, it becomes a very sneaky ABI.

Jason

