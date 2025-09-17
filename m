Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3EBCAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07f6H1t7ApqFDQgAvGWdfSPK4tO9+C1E3U0BMX8346M=; b=2JAFdOBznzGXovkSwz5lz6XvlG
	Wey8AnbNU9yJ82raTB6HLRgfIASykMTcMK9WjAjsKc9Xdq/RmVh7VG8dT94FXp13mpmdi7bljvKNm
	db3QfPU7jWs7cG45G+zZ7fP3mSapPG2lKKaz+at2n6/94wFhgpmKS7B1+/VELXjkRWe3rmSO0gpAL
	9ryvNCk3P75Z+///NSBWCBqFGoHdeHDGDzBEeytzcQHcGxQKnTp88lZ1ljRczKscuOhAKZXxh6qoT
	IwqLBl+jCo8uTL7vx20yOKOUYR3MiUlPR1AEWvUDWNZysGGOcLsqA+tLFeKtVOKaXlYcUa7UkSPkX
	iGnGylWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzbH-0000000Es8g-0ueg;
	Wed, 17 Sep 2025 21:22:03 +0000
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzb5-0000000ErvY-0oCs
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 21:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1eVVxJ0Sx31qI7NpFUfVCD3Ajk1hPTp25EPWksfkWz8F9dWFH5dfI6fjxXHpPUWWPkBy06waaSnBuSo5Pkj643HhjPi4whmupkH76nt83y3Bz+Fj7nON3Epn9xGHaSwuOE8f5IlIyRXWushUEAcSGUGgUU3HZzZExzCCtUhu0jGmGpmAGEAgvC1VOQUcEDwNQj53mXRx2exIVaGUfD7vJu5lbeYdxhjlZwUYxe8c5f9GaGTbMBUJSLn4KKpPWBBjKsStHs4Bnowx0xA16sbubAHHn5y0i09KSjFefwCKn5fRtY1z36njKdJrWaUQhYdqKTppossd5lAvEzObAK7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07f6H1t7ApqFDQgAvGWdfSPK4tO9+C1E3U0BMX8346M=;
 b=kTqVFGAvkrVKE+F7wbtpoTDKjOHnnB8KeaktBqtVxbr0YVCM6qglPd4xu9cWrH2CKraee+7OZq4jrbDMI6/nYAvGs8KP2AqTX8diJnrjtIUqCZYxxVtJNy0cqOSFQOAVep1d90KNY9GN6DEVxUFZtMHXvjSxxRi2tmoymG54dJ3A/nZ9g4PharkS7zSonPQmCSXr9YiOzvere2RoB7F60H9uhUku/MeAjY72XUCWFpCCY6XrV0Gp+JQ2f1xBbYBfqJr+STBVPEnvg2WM8fme0YidQ/pgodrnMNGsIdJLmUtYk0cMFiZEXY/jLvH7Vu85ETy2lAsyrtSSnAXnGIYZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07f6H1t7ApqFDQgAvGWdfSPK4tO9+C1E3U0BMX8346M=;
 b=Xvgb35TFC1IJwSVR1/3+cPXtrP9PQwwB5ZV+P2bzXIpob7S27GtYKOl3F6/l1sIQ9BPsTJRtGpjV3ZWfcksuWtC3V8/gWvvrvIAeBjLDNDhR5e6tHHAYXB7RRxlGiRvH/hUf6cbypkRi3eQCbdEuM1DZOfb8MQuucv6ixdhif+vEO6iLPb+ON5IaNgT6+O2OoH/fZRmZU7oWLzAeglM7j6b5qhFc+dTml8yhVYPhJksN7he67XahQdYYkG9t0PEZ2eKaiKcG25r8TeylfVjpxDj0p+baH/TzMa8S7P4nrpncoXemcDVuIVreNKe8BbEGL6vCy5ySXZ/GbKHZ2BKpuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 21:21:40 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:21:39 +0000
Date: Wed, 17 Sep 2025 18:21:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250917212138.GA2101104@nvidia.com>
References: <20250917174033.3810435-1-rppt@kernel.org>
 <20250917174033.3810435-4-rppt@kernel.org>
 <20250917141528.cd619a95a19a33d71dcc4b1c@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917141528.cd619a95a19a33d71dcc4b1c@linux-foundation.org>
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: e596736a-bd5e-480b-3761-08ddf63030f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w/g1Dx3G+/P4kmWNSdk+eCsHLXJ1L0gFdvLZcohBx0vjskv9MfwF1UdbdLuE?=
 =?us-ascii?Q?gPdKwRaEnwvduh20vHvjfjcSKxA55VMgqWf5ZQuiVCWG6mWL4tcc5fn18/Bv?=
 =?us-ascii?Q?y2VixgMmuPJy2XQKcNHu+BdSyQlWDmqxNvudZhe9z/xghYegfnI6jWFHsYUf?=
 =?us-ascii?Q?HMr8VLISPkqt4+ntBsrEN1okg+rLllylyPXpH0f8l3N5xSs/1vC7GcZ6mXxa?=
 =?us-ascii?Q?RcZ9ZIM+Gb5GybFR0HM2Mo3+XptRx9b8Fj11lDhD78AjLTFqBkhoPI50PQol?=
 =?us-ascii?Q?2XPQrcWD7o6fSS1WNDJji3WDphRA1MXdqbA5Te+sRGuN6NRap+dp85iQg6Oc?=
 =?us-ascii?Q?jVNB1ma975nvL+JUGI8q1Uvwam0SuXm6FywKC+dbE23c5s229rl02lm8MZqZ?=
 =?us-ascii?Q?ZuqJa+BOUNh/mGkOxCJkitQ+r6BjOrVvjQgd49/N0+vJeX1gzzZjqAakEGLz?=
 =?us-ascii?Q?3eFk+Z+9YGjS1amQWwR2WnvdytXNo5hX1/F54ajvokr+mNCuqixGiU+i8JKa?=
 =?us-ascii?Q?Y4g1h/udgjgynBQbLeD1hXhxMk+aab+8tWdPZAVF/Tai07v/v81Qdg2zKv9F?=
 =?us-ascii?Q?kDwYQTKTQq6F7bdkAvUe/U6mG+Pvezc+crjscamAR1ihpvB8bjqec3ErKE7q?=
 =?us-ascii?Q?/nmU4WLivDhdRO4BoyBo8uNQ8ia7hhEfLJ1/do4vgAPfH9FbRSrTrLb/BcLY?=
 =?us-ascii?Q?yT6He6dmYUxqymLiYwvLL2WtcXR8H0TL4HTNsVf/n834kshuqU2nwPKuvzir?=
 =?us-ascii?Q?7Oot/Q/7ygUQMGlE8fZOMoG4WNAS+P0wRRAhINv7/+mwPTiQHQPPaoyCf8PB?=
 =?us-ascii?Q?7qGeeFaMfzVZ39R4Lu5iUchug49y5RPHsdWG72QRQtM1kvQNVhoZ8Ye1PgpS?=
 =?us-ascii?Q?lsTeZbHLyEV07rKkLgQdd6v6dvXowcOcZOHRisjBtYot3z+TiXuGS/XDiTsg?=
 =?us-ascii?Q?ZgPfMLjyzLxp6a7W6kymM3Tmf1I2gh5c5U2k5yJuCOWVSqrELzLiKVPWeT+i?=
 =?us-ascii?Q?Elu+Cmundc7gLiPJQe9yz7WyLJBq/cuTBU2Q0zuxCA78IzO6feGpKKgA1Mn4?=
 =?us-ascii?Q?DEJhhEqO0w8+rdvndkeJvFDorjnOfFZqy9p6V5xuSy83evP1a6kTdO+QBbqB?=
 =?us-ascii?Q?Y2LvbqjyE0Lr6qtA6ayKHGh+poqkv/w2ejAP8EYcDn4/iTpc9V3mQEhsXagc?=
 =?us-ascii?Q?2VTGW2qchRMMR6T477O7736ViPqji9b7ScqJmI0tHZqkDQ+90upqyXX+Kh6g?=
 =?us-ascii?Q?nvR0a3umkAkz7X/8wb+KN+mTgz7JTLk7I/gwbM5hNATfUBbFBOg0HJlWSXyW?=
 =?us-ascii?Q?aBUY2sC7t+IGn2y8cy3Jid/41ABOwTKBymZ7rFry1Yj53RTV2BdK6Ri8CQdn?=
 =?us-ascii?Q?p65NumjCwaOvuJPrqh0z7fZ+0vWBYoDm6JrG/CcwkeH4Z5AjkBf13KXManhz?=
 =?us-ascii?Q?It07aqXI34A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OktslUyuxsCqZgXI9qY7R3H+Ijuu+MSthpqa1TkkA5jFa09a27VgyhENE8tr?=
 =?us-ascii?Q?K3ikxThFoBn2o4WOC913FmIF+vVyaLREqa3qykr5sD6K2UH9Z//+o8fjU6pX?=
 =?us-ascii?Q?GSDu046w9M35/ZfR3uM+Rg5NzXBx4ytOWEM/c+xagBlApMKtP2q595ET3UAo?=
 =?us-ascii?Q?6d6flIc7nzoJaSUMwnmvNDRr5Nkw+3KdVkgwEGbw9Pls06wT6MRkRIDXn6yf?=
 =?us-ascii?Q?Yc+itSUeHSlfc8eQkepF/pVhndl1rVUbpmbUIleFauuX0HtLhP5Hn31qWrPA?=
 =?us-ascii?Q?4vIyynqt5U3oZHbP9ERpdUb6E8OGdAU7qQfV1nNim5tYRCYNZ5qm3YgWv3rW?=
 =?us-ascii?Q?mXDgyf2P8ateoBXt/Hml0jChAet8ing39MtoU5LaOkn4XjpsC9O2U5pCoxcm?=
 =?us-ascii?Q?0FTDhgYuG1k4iN2ag16GFOZUZmrnZmadxnD8NXiRBa4CO6AQLwhLxnSNYgZ1?=
 =?us-ascii?Q?1FZiGcj0fgyj1uwjRoTIM1wjeU+VTV25HCR1V5PfoYM/Nv/IpbFZlQeH6Kfz?=
 =?us-ascii?Q?HU1ePRWeuwnL/W15Vo5EXKTa+agQNQIQyMNjrEp3Q5J4QgpQz83/VBkKr3xz?=
 =?us-ascii?Q?ra6+AW2lj9NgndgqIMKTNxTPV74oEM5xIFSgouNcAuJ6V4KDWCA05FaWg4k8?=
 =?us-ascii?Q?+aqs2/e6Hmkxb5xFUYfdHlai9BwJjhMBOKtJOblG5qJbun44/45y5IqDHcJk?=
 =?us-ascii?Q?ZwZDySXONHZsjdfq9agX4OiR6K7m5aaxNyQKw5swm6JRHgw2vLbAddNPaI7b?=
 =?us-ascii?Q?WHxGlZ/XveAmFIidF90O+vDQNXjwhWJbfwpdqfMg6vgv+CrtxVzs9TLOKlSq?=
 =?us-ascii?Q?X+r17xvdH+SY+xDl/3F1Jw8BHa8inqHpzte9sZr82TaBIMjOMvnEqIKyQZ6Z?=
 =?us-ascii?Q?kCExpXWcQdpteqhKZLmT/OEYJX3Q1dtYfD6mYe+LyE/wB/nYhyl3eoezKV6O?=
 =?us-ascii?Q?iddJvtg0JIqy/y420Adnrm1zmXhhvuXT6x0imUSEFqdRjCSJ/wVsrxhnhQnL?=
 =?us-ascii?Q?Mq6RmpLFgeBcnOIP5CM5AHuC/qwq2wgzgMo9z5vPeyuRt4LT67OiZN4t/Gry?=
 =?us-ascii?Q?nklMU2Xlug6W2zqviQ7REA97ZWPgmP/gPC4j8kJzbZ2MDNPH3BZqGAmA63r/?=
 =?us-ascii?Q?/1yz/gjcvtI48yNj1ZQE4AnZkERIYjHSsSH0XIIQ5UAmNRlk4C6SV3hCstCo?=
 =?us-ascii?Q?K79Q6VNq8qX+wjLnVr3UYiOEKAMhL1qqpP/SclOIGjNsIJRcc12cv1pbgDtt?=
 =?us-ascii?Q?ymNHW7holHaMnNFdT+kmlnohZJCcqof2cYCzEu7HUiRz+8eIUT8mm/h7eO0F?=
 =?us-ascii?Q?gDjY4Fc6l1slrUpCqeNEiKKWWQaisccQ3ptv1yUf9SS6wZ3BFlbbQTfT5rYx?=
 =?us-ascii?Q?EMWr33iDtppgGv2NysAAyJWfCy1JepzsQOHIKrsml8O0NdWpsXU/vfam9Oyg?=
 =?us-ascii?Q?nPLB+t4RaCTaQQiEO05NVokCLz/VLO4QiH2SArERtRQPNrssn85qJDaHvS5x?=
 =?us-ascii?Q?KxNTuk97yuU32xHfxG88EFCt+MQ6RjfH/k4bPELTrz9QuFrpszodGMMgnRrm?=
 =?us-ascii?Q?LMjcxKp0xgG7VLpglMw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e596736a-bd5e-480b-3761-08ddf63030f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:21:39.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRvB9JcaREWB4HO5cRY/RxUwtnsfflnIxHTDgCiF+m8LZRom+4LjcB/v0Usp60sy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_142151_356359_3A189A71 
X-CRM114-Status: GOOD (  10.29  )
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

On Wed, Sep 17, 2025 at 02:15:28PM -0700, Andrew Morton wrote:
> On Wed, 17 Sep 2025 20:40:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > +struct kho_vmalloc_chunk;
> > +struct kho_vmalloc {
> > +        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
> 
> offtopic nit: DECLARE_KHOSER_PTR() *defines* a union named "first".  It
> doesn't declare one.  A better name for this would have been DEFINE_...

It declares a *member* of the struct, in the same manner as the usual
DECLARE_* macros do.. Yes that member is an anonymous union that is
also created by the macro, but the main point is to add a member to
the struct.

Jason

