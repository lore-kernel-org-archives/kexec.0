Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA2107BCD5
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qpqzFr6pBPXJ1gCCcGYqjkEUpGDoWBe7p+r7X9RzxGg=; b=jOF6buzL+oPh+RadJsve2WjkMl
	I5/IXXPEQpIS9ON+X+AiXQCae8k0n+XuFx8ACifJW3V5WyCZfjFlOGpyQtsjUbKvxxTUWOC6KtQ/e
	/meJzDs1UbB6Gp7Uz5ibrj1L14Oxvh6Uxu5oJjNUPJxlrrlOm1ukdcrj278evIwd0MALcM/rayl2g
	H2nYhxo3iyG+nEUYIumFcJiMhc9v6sSGYcTMhb/RWmhODPdIdZ00cWQqw9+VwfuzhXfKB1APLagA/
	6/dZGk9Ow0GqNJdOSLMlDFiEIUWNKb4sY2vuDCp+JLKG9q6FCRXMq/joJBciKCTU+QccxqVhC/8MA
	+gHtSfRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w16AB-00000000kjL-09MB;
	Fri, 13 Mar 2026 17:19:03 +0000
Received: from mail-northcentralusazon11010023.outbound.protection.outlook.com ([52.101.193.23] helo=CH1PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w16A9-00000000kiY-0bCB
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 17:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BklGaS6W29pfAgMSk7+jDap+WGmPEW71dX4/54SXzqjoQCHYII7TCIHGpfMwcKFQCwE58B3bF3O8AOuA1+PHSuHmsblfOgLTxdtLXHeDDm8Y0/4+Xvfa4KWP6DtZwWiPspK+TAEKXFBIvrugXw2oDaCyOjCLDBMnhErwXwSG2AagW1HAyd7K1jHeXlio9a5QD232Ii6uojLsHrioRVHzUMugDFlxBs+Ubx7c5H1WGRps1QfldFBG5MQ/A0XuOVeJJtVm+PVq98wBj+fnHDbmA1ehKO8A49y0Gy7elQG5if5SxcA7qeqNSA80chIG6B8I9FKvYEISdCGqwMasaAbcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpqzFr6pBPXJ1gCCcGYqjkEUpGDoWBe7p+r7X9RzxGg=;
 b=i6MNiNEJVms0upOqQ2bCpnNF9ioZRxJjcQp5nox0F1ZKtRdt+X2yZp1gnuk9/ebOiWssQQmk1UYi4j6LICSHWlIHW1LP+tb4+6D4c5jfUrofYsu7IkU+qHN9SyhU3J3UZECn4cNgSGIlp8gf0XN82V3Fr6mNDJZWAPNVGZJNaCsorEgjj1UqN06AjJBKWHJXiboL4aejd6T5YvU+mI3sKE0YxXpl6ij8oSyfzrr5ztLxk4kIThmD13QSAwukY2Br64SHtHVL+2WXWqp/P8VxbYABfXex4wVWdxgQhM2xDHvTfwjT1EZbIj6WpUaaXAcAADA6+QZJIqpC9RXpyCxr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpqzFr6pBPXJ1gCCcGYqjkEUpGDoWBe7p+r7X9RzxGg=;
 b=YgQL7hBlWwkDj6lxTP76dLO6eveJe83vGRS0BRAAaufHrhOqA1H0rQFxddw74TTUlQA7aMPwX8mL5W/uuoIqWi4kdlyYpZ3BFm2jzfRc1wsZPgtxSfIURGRDYQh9+5fnEarDQAsjRW7J9EW2n5J+6Ecpt3ps9tuVpERexU4XUDA+PjMwSrPzjTEyZDTNKylxZXDn1uLeFQXtC3X0FAH7FDFAp//CWCmtZRxXp8IgZrxcbkvSolMZ58/RUq4magQA8rdzX9N7Vg5n8aguozSjbVxQ5PBUw34cWuLX1yGscujlfwP7Yek5FCEPNbMqWH1LVsCCSlimRh20hDor+n7bxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 17:18:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 17:18:56 +0000
Date: Fri, 13 Mar 2026 14:18:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Brown <broonie@kernel.org>,
	Steve French <sfrench@samba.org>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <20260313171855.GA1744604@nvidia.com>
References: <20260312230817.372878-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6ee7e-8cdf-4f1e-afd3-08de81249b73
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pe8N8tX1jGPd47+xxVaZmay6G6lv2Y0EG243Fze4JrfG7IRco91jRaiS5fqaxLAOSQNQSXykXYqgIXp8t0Cv/1Pn54b7SI+GsbF8ut3NNTqQ3vyAWt1KKPGjvWT+cGtkHwnNJ8j858MlFxQiW7O2xdFp4x99sJSizSDIS/lzjeOMuTpPz+t4q3xptjtE3xKwn/f/1dZj28LstKb0JfHMtmRGWPy0Jh7s7pjYfbbsYLpOBZxLrEGXjrgSZD0NUjhE4zJV3OvmoedeSyHiD3GbiH/iijD2nmYn9UfOrGGpznT3X95ppGjjNI0gE80i+Tmr5DLuywWNofv+ul/NcUHXv615HGuTLvVGCqHLsUCMZHiYLS0jg+Ro8Ioib7vDMZdZLvxNBbtbpy+Hg+vwjLSn4ugc3Z2NT9kHabtJoOWc/5UKtySskoNqx0Cqtv6jxQz3XAc3LXA4xQfoaRQkU/VmNJF8bassg8iGtWL2M7csqVzo9IUGlyPxIC9uvHQcyQT80bxNsq/ePt5VoR+AoW6Z7ajwWak45OfxN4E6NYzV0aWkwdMs/37JDpHyrTNkt04QjdzUg2Zkx992eO6yT/inIQrjE/J6KqWVZy9r8+diV7vK/5P9e2ZIDPGcw5VfuVOV27rwluTH+nXwDzYRbJ4WGP5RrfI20E+WmUVY0t+wbTFgoNJ7uJkPTphqBEsbPoqFL4jeFK3PMpLyLD2qp2VkXdn+6GCiMFr3YjV51Fb1jr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hV5L5mWHfAqTBL0EFMGKlXddXmH3spbxcnhydP1DBbr4R5Ei9pgn+dy9gZVL?=
 =?us-ascii?Q?vUYVkNqTO1k58paYotu+IvzLYHHYdoycF5LESx2o/+qQEWsO3sB+i0rxDZTU?=
 =?us-ascii?Q?83ucvctXwZuME3khNbW2ySWzoqYuiWGwqXAllYjEO1qeG4fLsitiQLIj2iTy?=
 =?us-ascii?Q?DYOfxT92LugeFTDsxG0o1DW52XCTDwQF6fKZPqScEmuZBpyvm6Ob/jf7JLRt?=
 =?us-ascii?Q?5eTjV0TksASMdt9GhcsS2GKQHaObI310n3V/aCxwB2gj1AqczPCCTjnpHggY?=
 =?us-ascii?Q?4p+5DyDRZlVxf8VsETxK/+3dpTel1TXOOrY4hXRuU/Smg0YqcE8CS2IMQmlA?=
 =?us-ascii?Q?oqfOwV/mIFkj+VV/QSBX/DacZn93s1uiu19rMjEu37Uc3aa9U6FT1/cgDJnJ?=
 =?us-ascii?Q?XxSqYP6nXg6/L1ebhe+Lki/PSNLosNe4QJt4GwMDTqySKA9s9Q/0/sTDRKK2?=
 =?us-ascii?Q?rHLUERejTMP/aWES+H9oOfyafMQ8Cw8BbdQxKDd+M0k3NdvcI4XVkfFpjrYR?=
 =?us-ascii?Q?QUFADnNaMJEPLyaLdHwBfEXcZX0GGLL4QBtwvQhF7GrHDCHpGqm68icBMeRy?=
 =?us-ascii?Q?AaX4zCzGC51jppnqqTPGFMwD1TZLdBDi3o6SINFunEPbbeOlpoHoo6bjlr+x?=
 =?us-ascii?Q?nbPfBeNZKlexYQhk4L4rIRooUORuYGHuFWUGcJ9HAXnqj8WC++tEkl6cBaDo?=
 =?us-ascii?Q?w5upX+ps0dIyxSdw7LI4S1wj2i7Kbf/yE2ISwWkYeS4z0UTRNmdmHXxLn+VF?=
 =?us-ascii?Q?Hc8GoUnN1olzk7tBxSUSuywiegoiuF7ssNAU18jBQfU0eTJtWuNkWPxuD2Qm?=
 =?us-ascii?Q?A8LNBL326Ze3aM0/Qwfq5Xz7hNxz+ezxQhaUQHOG+j9hrV8DkpZmm0Ikq/sq?=
 =?us-ascii?Q?fuy55fPopW5GGFMixvfhW0olMfUDxchJ1615TEjb8Klwm8ng+d08VfSysc+u?=
 =?us-ascii?Q?8s0SOD6L4wIQxr1lJUS+1aZDxlbldmRQZXWcMb8KvNTLbPV/YOG5lw5Hpcux?=
 =?us-ascii?Q?xbJD3SkX9AC0ibCgBjqlNw7IDodkc085TMmCeL6cgTnENAhkc8QVwoTKrbWM?=
 =?us-ascii?Q?7BNtNdBnh/NY2zh7PAod53IOkRZji6BDkfMLiCuaLw7hG7s0sIaIY+xfsqEl?=
 =?us-ascii?Q?EDTDVWh5IzNcDlGRHJKUTtJHWc+54jFgARYgJzBhaKabnvKyBxO9tiloYKz/?=
 =?us-ascii?Q?Y0r/kHfeXW3KewheA1bQbffuhEa1smzAGyFtJH57cLtRSSe0JC3lBx7UNAa2?=
 =?us-ascii?Q?sv5zqezZHlCOs3LabH41fECZMFU66PWUPZ4tf5RXJYB0syzVFieHzh0kHSgW?=
 =?us-ascii?Q?AVH5clvWLdSedh09D8xwzjknKEdhEuFXDX5/31sUe2kSJJEWrhp12+VKaL/E?=
 =?us-ascii?Q?PWQz63nY2uewtLI6KpIESUWTBkLErtPOQ0famdT59peX/S3G00AGqsXR/sLL?=
 =?us-ascii?Q?q9D2UofyFt0YQmUbmOOeUjCqHlrB/FzuKoHrNoU4B7pBHvyWXl3pTO1hDMLV?=
 =?us-ascii?Q?JAWaKm9m4ZdwUIerzV3LaZ1oLNoY/Wqp0wzZdHU6if2F9/vu+HrVbO0ve4IV?=
 =?us-ascii?Q?rjRP0GjYhGiG2cwOTO+5mIGAgMsxRDWYANL9gmnxHph8PLl8XhdubM9Q8xW7?=
 =?us-ascii?Q?2YMDbybk+341QKgALLd4ubgOKOSqpPHfMsUM/J8EKqENkSFFkCLDhYvEAyn8?=
 =?us-ascii?Q?kEBZRlg+ZGxWV+BMbi8aUi6NICenfF2RBUAoNNrkSTv38Dwq3gDv8aUYJoqA?=
 =?us-ascii?Q?7EBeImUiBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6ee7e-8cdf-4f1e-afd3-08de81249b73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:18:56.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUo9tIVZAM686e5xdbfJ5TaQ9NMWooElACSMXeYMlCkkvqb1aej5wkB0CZ3uYobG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_101901_359568_4B028BF0 
X-CRM114-Status: UNSURE (   9.82  )
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

On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> 
> The 32-bit behaviour is inconsistent with the function description, so it
> needs to get fixed.
> 
> There are 9 individual users for the function in 6 different subsystems.
> Some arches and drivers are 64-bit only:
>  - arch/loongarch/kvm/intc/eiointc.c;
>  - drivers/hv/mshv_vtl_main.c;
>  - kernel/liveupdate/kexec_handover.c;
> 
> The others are:
>  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;

So long as 32 bit works the same as 64 bit it is correct for ib

Jason

