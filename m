Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D2CD8CB2
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkbhkGkzPjl4y+cGzKbn//W9V7DQAa+9uXxpKOR+vPQ=; b=wdH9nitXMl1iyndqsbMYjBDQpR
	O1YoJwZP1sPfcqbcWSl2Nfn2vwzZE4FmQSTcg3bYgEshS52uO62/aF2H9RdKq3chF2LR4SQEsaAnp
	pyaGN2FGbcsmyHVVv/48fzGDFYMd+TszytjKAn9yl5GYmRK7UCounKev7dEUru8wAlfW2I8grIGs3
	w77gTyXhmGkhirZhg2iHuQFYgu49QS5LVNu1fWGCibL9cri8yU8LZw+5tWVmVH/Jbeo06zEVW1JsM
	cWw2DRyYVa/sX4CUaDvdJKC/Mz0VNA8Hqdq2gaZz7IZy7Mps9LTmc8vFP/6kxAwLr7ETeOo911BDT
	olj+1iOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX6TT-00000006Xrr-1ASw;
	Wed, 10 Jun 2026 00:07:15 +0000
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX6TR-00000006Xr7-2icL
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 00:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK2tStXrUTvYFBehiQIyoM5T0dsLaGCpKJin4s04A1ddO8cwZyLVeyglBOEjsj4UWtBJvJdWuyLNYp9ZcNIpzTZUiYOUNLkbXH38N+39rEYmYWNEneOVBjMWpfoqUDb4NK54OpsHiC3uNqHIYYtjY6HPulw9lZOpbGf1gU+RMBbnmUfbMHtGWGRLtCybi8TrQv0MeARjx+/PYvtk2Y5lh6S1Rz428LJock0KlfuNebNKDbzvHTNUEp30cJbf+yPQVUKr2GUnWjhei2n6vGr6NDLs7n2iBjbIm1qjsIchI+Ic5Da+kbf4LTJwP3g/AthOgZ3yl8jygkrU3f6Q1Es7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkbhkGkzPjl4y+cGzKbn//W9V7DQAa+9uXxpKOR+vPQ=;
 b=XwlZDSLXPqJUXdHfJcN9ctEmp+b6JKLkQQF7Xfbcp0x+J6pq743d8HXqMoeQrRVCApPOUOfc6iZkxQxjjHg/n2GG/rzYmjoKb8OKGVgg+XUl7R5mWipXt4NGrw6iUvnYot6wA753aLxJjv56e0sdUflKPnyIKrzCN6ypmu9LcyRTf9d3uWBIJkDs3MHvBdM1H+ONlMbiv/svPqbBGr/GPOBCmG3gBAYW4lhBVgAfgKalIBgQRt4oXNhkcUFizJTzMltXTZCePzTW99+Yst9jUwkpIJY9EG0Q2PxEr2e5DfmlWH57fURjWiZo/swhpMEjXkYRwrS7OLyrxakra6kghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkbhkGkzPjl4y+cGzKbn//W9V7DQAa+9uXxpKOR+vPQ=;
 b=NcDWOeuAq5Swn9OptVkLYienmFptO0w/8O1hAHtcBM3nM0cAT6tnOEpuYtspVwuG1WiCRxPobiE4NOeZRxp5SIPtS1Anqllwa/aK1qw6UYqzWG+aRzJk9TAaVemqYLp7OjW2UZMDipx/duXqmUPWyyzacczelHyp2wsHYH73yh9rA46ULqpVmwqzTVVv7H2hYfJrKUJX/bN6oW1OPRL3rhtcwAL2UqWxyOVwf5XMMPDutaBEW6v7XdB7loCvUuLIgwFX1sUasbbv1+1DlQmMArV+EGLH98iwqJIXyIjeAQim2PNuDeiZD636jvamdOUefzWeCyaZJAyF0QpGafFObQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 00:07:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 00:07:05 +0000
Date: Tue, 9 Jun 2026 21:07:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <20260610000704.GR1962447@nvidia.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
 <aihLTgs1Y49OXQaV@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihLTgs1Y49OXQaV@google.com>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b697c4-4665-4c18-4d22-08dec68434ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: zxAeXQpo4vTvQOpehrl494RudWGQm0omaXSu3I1QjkpdRcHHCBrYtTR9wBNP94hB2tO8uHUBPIZCwp4ezc0y2t/5quMETC6lJ9FLiqRfbpcnsxn8c7QllQc4x/tcjQONxAPakXcWPiM2dof1zIm1b5urC3tv7VedQ2oseVEywMpZjH/38eUYgFhU42DsVklXEaGI25RwSUMFhxAkYkUOYKb1SXvrbX3WPTaEEyxJ1tZpMI2ZCCOAHCl9qBFiqK0UH1Hb8ztkyhRUzogeChVaMXqXGAksjxmMozvCD0L/i6AcQjVvizzB8YbHAs5IP6DV/6o61p32TDhUS42RPuS6Y+RcKkAv8S1HjKTtNCund2ZT3ttf4pbgfH3eUxshTwhXG31xWR9MbfK1IJO5hKNkKe9EsxV/hzzb1VsMizRSupUvl7mh0rt+5bZJHDMGspKAJmeM6lllPQCT4zUAGA68AcFCJPgLC0AAkfb6kPJd4vzNrHRYxSSqEJGqeH37sbfhOwJjZX8xQh93p7PIIUa9U1v1IZvctWqD6XF/BCOdvSgy7hEb2/YQcHfX48I7h7d82ec0KFTIwW2pYxQ8wqtgHLCLncULUdgwoZaDzZdxebT1sf4sj/t68Y1f3c/Ul2HLvFVqilr9iaJKrK/nrg7nXzNuJ4VQc0Qt7BtTdOneVKj8YNL3sjs42eZ7PIsOnw1m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jdzs1Lf70Umdrm1JHkH5Cmz2HNoLQlkFSptgH2hElP+HQV7EcPs9IUPIpktu?=
 =?us-ascii?Q?fhqv0M/mLsZnR5pHR9VH0X6bLG8fT0a6fZb1cNv6it47KTKJpMhpcgnwJY1b?=
 =?us-ascii?Q?hyiESzk7KuT7tS54a5exZCrlxYde+oF3Jicn8Uk8WmbRgyRebI7rr+jWQb7B?=
 =?us-ascii?Q?b98PhgCDcq+YrBf7QVy9z0KJZsJ5sOoNKvKHvuzQXlDhBWgMkOJFbDsrst6r?=
 =?us-ascii?Q?FsrLs2IO+0rCAR9CeCmzxj3GOXhLQOYPAS5Sg0j1YhSdk8QFbS5Oc6o1O3ef?=
 =?us-ascii?Q?p3/R/8R9MWiW/ANyyonJnjp5wkn2q4H9LVeUY9xb0k/VM2UO2SEH2JBqaoDd?=
 =?us-ascii?Q?93QObgE+9f8SZ3wq+0Uc48/kcyuY/3BswXLzEa4qC2041WJRyinhdE4SzZsI?=
 =?us-ascii?Q?m0nEOmAw8hf/qT8dE9IKHsoN0WMccpnMlFUPWPxKshpv/om62GuN8Kwfca9j?=
 =?us-ascii?Q?+HcPnIHByM5/Eyz16yvvMoKsMQ62aeu/dm2XLUmEf7pcPtBCZTnz8HsuqAtE?=
 =?us-ascii?Q?ilK+1BCkdVGnWb2931YRdYlblo9u5NY04QWFZe8EIjv0dR6pHVv0PiqU0h8k?=
 =?us-ascii?Q?NrCtfgJo7SMzhjbOWHlB+uW0XFn1gPgO15S9+3qh5mjXZXB9+olqb8h1QFnD?=
 =?us-ascii?Q?dpxRvPc5NiEFKDZ+F0zv15AwVJKlcwIX3GZR+yE6wUvs+sVtQ8H6lnlYRPjq?=
 =?us-ascii?Q?Hv20bLlL97i2tURo4GYA3uFvfevoQWbld1+Dy1u9+qeABD7i06Uv0B7KY6Wf?=
 =?us-ascii?Q?LvBNMFlQEKxo1E9TYhjgYy8U2E88br/+CCJJ9lwpXBB+3bYg4bXcjSqnrrBm?=
 =?us-ascii?Q?g/w5rD0l698+hMSRFbsLsAzII78sQkyDhpA/TzuXtFycHVqbK0Z5vbuGJpPT?=
 =?us-ascii?Q?xxmp/mn8V60J2ie4TvB9xSiIsfa8EpgwRBOkatekNo7XUGvbp/WL8Mq0wcg2?=
 =?us-ascii?Q?LjOAP6lWyOPIEjIdb2NrlY+mj8Sxoi1BrySRQP71tD3CI+No2PV7Z2VS8eXi?=
 =?us-ascii?Q?iQNC1zrJ7crY77JQ9MeJDA6kvYOxayWme5xJF1d/afgSdvCQQRvKuNG/E2W3?=
 =?us-ascii?Q?qkBD8puG/pnVN6CkW529U7y8gB/iEGnvQIoxjdmeKfzKAXu9HH7FC1DIO7+k?=
 =?us-ascii?Q?Z9K6beQwhJfW15xHDZeHZcbwnN8UmtmXDL/NKG+heKUaZfEabbFaVL+IYVH7?=
 =?us-ascii?Q?avV+42sUL/EWS1QUULHaReHb/UXllWRD75FIzqQWjJisp1HIUFLrxNw15iUb?=
 =?us-ascii?Q?cr2ilpKQzxDsg5PBMX6+xRmyffgtBrQCVjIePgRtr18sN3VA5vbQE189lMI1?=
 =?us-ascii?Q?VQ1sKwxec4VykOXKtpLTQ6Lrt08gCnHfa2NAG56ONJxSsV5av3KtHNdJ0jIz?=
 =?us-ascii?Q?Q0Ie4tgX1kpHCHOlEDUvLAYr7wdnMjXCcT39geE+S+biBfIlhM+MmT1IWG+c?=
 =?us-ascii?Q?Sq4MInK3bCMLE9hXJYg/4ZLz7zrIhyep26JW/spusqkJ+awgXrlsKvs9aYwQ?=
 =?us-ascii?Q?CReAAWR8OTPuuzh3nBh+QTLq7uQ+WK/yb1RFnxjeF/taMju8Ad7oXyyqh2f+?=
 =?us-ascii?Q?DECSz5hvNmq4kEMMP+nHRyLkuxBgBOxybfGOcI+jHYQDDkmfFck4Gb/2wHZe?=
 =?us-ascii?Q?2RBP9KNqCWHWW8R26YnzLYKI4RpVJvSU2/YBTFVyUfn0JWh4xxkNOSkxhy2O?=
 =?us-ascii?Q?IUZ4JWZr2cLAKytmbLZgv3cIQ8sIoGdjHuRFIYL1Z7vSDq7E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b697c4-4665-4c18-4d22-08dec68434ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:07:05.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgR1ZrIUSuJEB7IPLgPrJjRoU9HRx+YnzNs8ZBBh6gUJazMNadsqY9yeCOMHWT1i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_170713_697700_B5A16225 
X-CRM114-Status: UNSURE (   6.09  )
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

On Tue, Jun 09, 2026 at 05:20:14PM +0000, Pranjal Shrivastava wrote:

> Now, the attacker has an opportunity with Liveupdate, since the devices
> are already assigned, if *somehow* it flips a bit like ACS_RR, the

If this is possible then your environment is already security broken,
no need to involve live update.

Jason

