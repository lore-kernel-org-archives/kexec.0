Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994ACCAC5A7
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1vTfFAMLPczZJ2h5FrfB+3lC7NO+P+CoJbnSEtiyxc=; b=nvZ6e8thYjVpvVZZmoXTrfvFRl
	4VJQTvmUYIjMcvBBsrXy+NZtcgRJcyDQUMkMu3Tx0/HZIznCCU74ErqF91CLTtLa1L5yaYFh8FRfW
	3l57TZj9aUMwbdB1QHQoWQBed5Sy88JGCNB8NOWi6uAhr6yqZyfrOT1x8zK4TFxA1NWTR8JzVK/3J
	UwF3NpgTYevtiAMu/94s71pE8l2VZsHjo2k5NxwBn4XXWSCSR5Lnn1NHFYFnwgjt29cp+7VUCkUNz
	DBkTxSt52ebaVrREeqOn4b3Aq6DHwXYGKza0CxD9W3rew4Dl2FvVn14aTySIFiOdGIbrIej4AEdoX
	QPtyH/Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1lAB-000000090oE-0cgf;
	Thu, 25 Sep 2025 12:33:31 +0000
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1lA8-000000090mL-3WFk
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 12:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtiTsUARaRSvoGehdp7HZNFnGNCCE4qdTq8tPC5XPf5NZoHmHYUBiADxJw1bBESHQxOLlgudsJpDVQ5F/xjWEZeZS7kakqTTQOT7o20JRZ3vDoL3OhCyrJ0bhix8XQhQSwa364Kte4t0Il73WXxR9nk/ojOKb/XmmBC8WJlwpaH6guzIpt13FmYKF0yILRVXzMaSDg2YF1M96/tyl2wUl4uKy/5u+GlekGG6VacuQYXF9mD3JUnbMpfYj7EoPMYSykPgVguJAQgmlKQAx4ovlOYKCNmS8AsdjI+WcWjYwqHXpnjptxXgebtK/xo0QdKtcRrJU6gF58TBiyT7rXYicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1vTfFAMLPczZJ2h5FrfB+3lC7NO+P+CoJbnSEtiyxc=;
 b=zUrRCq4VtKmxMduiF/9AwBVGiLyHC49o+zXRh2IWAD8ohqUgKd0krhjB09zywDzAtCycl+5cWHf+ThsOzRvGrw+u1jn5XkR/1d5r1/RBLDp4zL9gl1UQHL3V9cKf2qznECyxw3GywQrpj3sdfw2p3+knr/zAqz/skqFxQAyY7EVHY6SCp32mqkE4HVx3M6+H0/MlYK1yDrW91ueq260K7bzbLhh6wKmR46yh0v8mkqP2kkRF66DB9RXjVHzOdYfMV/ynbEIEgyCklrrhlWVFlKRZ9Ub3JtHINQ5p3uHmnJAzEEHwGr2akhJFpkIDKrBYeEe49a8jhAwpBzm59pAgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1vTfFAMLPczZJ2h5FrfB+3lC7NO+P+CoJbnSEtiyxc=;
 b=EbO1Bki1U5yrv5XMRXCa8iKy3OxntQ26Yky7ESBK02yOns+5LqT9ndIbEcEaVr/XvAOvUgi+PQvPKhn9PniMKz6LwP7VkqyEwd+MrRp8vhZwhMCMioX7hD47jPmKf8n/HUXjj4JnHsAEIERxeSz5SX4bBZQnGern1cHn7nljWdu/T2fyTa4cHSfFo64q1eIeYT1peNrLwdzZ7/FQ2hnaJj2hXOECn7nQEPmZolb87rdM3ggw687Ncs3olUyASnwcfG1AOvxMk9hyyEdwxeGMiPL7C7sOjoV4oUvgJLv2G2SMMkxzoqT4Gsagf1upl6g5+F9Cu98DzXPLDLxdWXKpuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 12:33:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 12:33:23 +0000
Date: Thu, 25 Sep 2025 09:33:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Jason Miu <jasonmiu@google.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <20250925123320.GY2617119@nvidia.com>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <aNUJIsElr5L5uxNv@kernel.org>
 <mafs05xd6d8f9.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xd6d8f9.fsf@kernel.org>
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdcec7a-5e75-42c8-e81b-08ddfc2fb76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EGx3/GtrZlziD30e8nVWzkVFpPtcIyCQLO0wlAqhDnDLtOhEE6l2yA43V60B?=
 =?us-ascii?Q?DhpI+tNFXzGZQeBf1iik9HpVWk7HYr+qXv/ImvLYt/Yh0Bw04AEvepXoUtxV?=
 =?us-ascii?Q?BGAnxne1UPtC8XXQDAl8mPwav0Dvb1FC7zpdqGeJPSHUiqc+iGi52++NWHsX?=
 =?us-ascii?Q?7xP6TuL86i4J8n1gaMTEcVI3oFL63zeurHJNyhVxMe6D62qCZT8LM1LgFnYS?=
 =?us-ascii?Q?n5sXr/7xzIlrvbLTrOV8ZWnkCBo7Vi0GwpFr6vAdBV6+kyyBn2DjTeW9s7cF?=
 =?us-ascii?Q?yO0eWLyEc0Fxa7LaiEbnhTPoHQghNgperyW/JvyZyTzzoVZoqKInxqNS1lfQ?=
 =?us-ascii?Q?rxpXXxVfqcFBKhfeBw6fviaZ9zx2E6QLBExLytXN8VYJd+4s3JhBm6Q2M+3R?=
 =?us-ascii?Q?7veoW1VmlQ2HE80EyepYIyzIbGc+4gfVIOMG2omt5QQrOgd8aaUwt4+rjumd?=
 =?us-ascii?Q?BIrBhVSyghctRBiK/ShHlooRiBxLpSf82hwF3B0lDa/xr4bV7av9tddPR7Gs?=
 =?us-ascii?Q?QlrMDsau0yq2W57ebvg56lmOholB/Ph4YFWgRlhImhh1GxY0/yah0v62/XWo?=
 =?us-ascii?Q?uEHyf+S7l8k1Oh0vxY1rDLroV543Hiwd3Qrg4zcvwMQUpQDbp79UmsF4D5dF?=
 =?us-ascii?Q?biVDorkVqU/tnk+HpoTapPNbgEKZRTXkkWV5qvfYtC9VPZz5foez+DwLd29X?=
 =?us-ascii?Q?PmK32W1yFohoxkNgACfvYJ+RMuQApJk1Sn1XbbF8DDarkm2l8138hrJ09AEb?=
 =?us-ascii?Q?r5gOs/0bmGSf/R9YvrYp/bDRlGSvVJ/1bxbvSyFwLLE7k8qL9NUd4hr0FsX/?=
 =?us-ascii?Q?ew4J8gXnz4v5p19IFBg70NtQA6TieJKHeRpRKD802YSyKM6t9jzG/6yWGAdf?=
 =?us-ascii?Q?Vkwusbjsmv2KDI/1mCtajnHl5JoLCKU/zIQtMkR86WAKlcyHOSE1cFoSM7A5?=
 =?us-ascii?Q?dXLdV4Cp4wrN1hbnyGnWwsNn0f1fqbl2MJjuVzmhTyjFWQojoAwAwLp/WgQ+?=
 =?us-ascii?Q?1Dofj3x6+uT6LDjrX+nEiXxUzdCFOiZoZcFENnUlQTDgXC3WxXm2ILfxarp9?=
 =?us-ascii?Q?XX7SiaIwwD2FCuwBdgsKWZ5wgh8yq+w9qmka5hWHgclVZe+r3SuSBh9QtfqQ?=
 =?us-ascii?Q?SqIE5Qb0qYuDxSrx6Bqhu2xEaiZXjgSfo8XIF8glv4tPWdjlzCJg5WLCzOmI?=
 =?us-ascii?Q?wGlDhujF1ptouNLe+fQrHKSR1FIocO1b0NtTGLz5AEjs4fZuoo+6fnOrmCqk?=
 =?us-ascii?Q?O1of9UCh+hlvIcj2IqApYV6xVOD1pABeHfDJXtd61ps152o/vF5UL1dM0yOk?=
 =?us-ascii?Q?gVu042ds1P6DEhE1AET2GlARsu2Y9bxKiCynYx7Hpm70mtoVx5z6YZndk4LU?=
 =?us-ascii?Q?lDGEP3bErLYZs/uxVE/PeZLLOgA4JJ/QISxYKLUAfjuAufXqieFEp51tHJzJ?=
 =?us-ascii?Q?4PwRAQI+CoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0Vh12yIXHvXgpNJZt3x7Cr+hJcMgeE1XwEPWkUlOk/RbwVpRHw696L98Mnk?=
 =?us-ascii?Q?Hlk5l9IaLsvijbQAHPUQ3qQdWsfx5p4zcP9dQQ1S/XxxJ613cpoId58q/ZEO?=
 =?us-ascii?Q?i6eQdKjWcZdMi9iegI4Pg/lfp+beBm0TbqQ8DhSaB94hmjRMdOkFtyhVB2LW?=
 =?us-ascii?Q?pFvRGvaOD8H8mIcmQvmCRBnjuMJQxPbF0ZPJK3MTEtgoQBjiTiUJRuLbWd98?=
 =?us-ascii?Q?nEkqkAlR4/pdWdWhmKj3yv+iBS5xrryrNfsazQ+jSfqBUXLuc+6ljhWmpOA+?=
 =?us-ascii?Q?lrowr4c6Suo8RckmOzUaRBue/9/7b40CVso56treO2+/mIvJ2cLKLEboJWaA?=
 =?us-ascii?Q?SYFNUGmBJu8Rgdlm1n5Pi0mYBu7rqG01mwctjIPitws/KzlrqFYiguHMLooi?=
 =?us-ascii?Q?Yo9noLJucjlxCMJPw7D8tNhckXXfzlGq+VQFehR5DJql2s7lD5zGdjlxSdOt?=
 =?us-ascii?Q?hqI5Al1eC8Q5Zf4v7Qpj6+xZBhZxb6/ge2oURRJgpBv38elecE2T7dBsXp0x?=
 =?us-ascii?Q?VD+PIhz8tgovahfl5HxCabxrTyvLYVP0JJS+y5IJ9Yghkr7G/awtNb6bejyi?=
 =?us-ascii?Q?mrXshgy1pSfrfYNmPJGhYMfSzl7+vsJ0rcjalVlF3et54IkJ0iau+gFT8Q0D?=
 =?us-ascii?Q?CvEai7nIayNBmGZmFB3/dhQHxqTW3OOe3zT1KiD1W+CLFuRbEi7z20Cjv2Gi?=
 =?us-ascii?Q?6iFyK/4hxNnt6H4nFljxIjLHpR6c0WsdO5XXJ9HrbLAFoY3cWukkec85hEWQ?=
 =?us-ascii?Q?Xio0D3DUY0qOM8CAZEMNH+vNvu+g+lCzRB/sqQxriC6KxcaXRwRNqcEnWHEB?=
 =?us-ascii?Q?5ENe1q+dm/NyGKmSqi3zEOj0aoEBlLjFjfboxb57Az7vZrv+wnklRzvoQDTW?=
 =?us-ascii?Q?KycxWrfzxE+CQjDxKUcTfCQGqhvbxg/S9yAANgAE4JpybbC56+X8iWRXe6s0?=
 =?us-ascii?Q?iHC6PnrRKmT9FZZ9tC0CQK5by96/9nCatIPBtwPiKNLTLRFzoUPB1nRCZLst?=
 =?us-ascii?Q?+gKrM5Xx4PNgiEW1Gbn22ixWS27KQDF3e9TFI0polMOyuV0+SbMMSmVX/DqX?=
 =?us-ascii?Q?Grq+dnXHk6EnTDZ4e3bc8xH6haQ3tC/dFL88O+0J86CuKWSJhJq6YLZdIZUg?=
 =?us-ascii?Q?pkRBDlUXbtOsnJFalO7AJZiu6BboSRLwBUL6VH27wIzr3+OYw7BoBqX197CZ?=
 =?us-ascii?Q?6+h1iQRUWCclC3nSaz42IU6+CZyP9bgmLwR3dfRVRE6NG1424lmyyP4e9dCa?=
 =?us-ascii?Q?y+MLnauRQ3LTjLhBmtHAbPCgryuWI6TCyax8KmFutUv8t1DZ2qTLVoYbgwyO?=
 =?us-ascii?Q?7fzD5TlBXhUltBEOqgrb1U5HzriEzSCVVJA9q8fS5gxVeuj9RmCii5tzl0Cq?=
 =?us-ascii?Q?VJug76eiuyoGiERMoWiYqpwMNjjc8U3WItyS/hjMDTonwUr1q3B8oGILpAdT?=
 =?us-ascii?Q?Hib9JbbCvpF79+n7H4T+R0zLKN+eezNY2teWTGrFX6I1uXc0vPnzNckuSowu?=
 =?us-ascii?Q?QoSfuEE4pVnOtmvmAPPa2OF4rYyQiDbtreIrKwxNLqUMDS99nw3rUXJsBjGJ?=
 =?us-ascii?Q?hyETTtJY9Ma0iuoaNQJTQvWuqmUifsJqsj/+HNmL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdcec7a-5e75-42c8-e81b-08ddfc2fb76e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:33:22.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OszxEz/0mrLpI2dI4dLjUWiUE2cWoDLZm1I7C8uMXf5b8BGEv9Owxhv2MHdYje1k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_053328_876442_A9E7F1FC 
X-CRM114-Status: UNSURE (   7.56  )
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

On Thu, Sep 25, 2025 at 02:27:06PM +0200, Pratyush Yadav wrote:
> I think the tables should be treated as the final serialized data
> structure, and should get all the same properties that other KHO
> serialization formats have like stable binary format, versioning, etc.

Right, that's how I see it too

Jason

