Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09579C36002
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=; b=XWxpgdvXbyc9ScSiRvwXkNoPsS
	uF1Mka5xAdGINDgtsdmamx3hjSccIrugjIC8lejh+gEZwzw/TpGYlkJgPW4zUDiGAY/CcwVG+K+yM
	i3AI7iwjggaZ2Ut7/Axp6eMH8nRNXh46riNtTQ8V9hMd8/QE6VubM2ZSOPoU9eRZ/BCuckexYQjfl
	wfUVO8JOQKkySFIyQZ13BQkAsNvgXBSUD15cepdU5G+XJ6RZi5dW05ieEL3eCFv2P+I3XkMPIuvu5
	/oQYr9LJadFAXyQ3K3FRsCYYRY58IKYIXNzmStjpZQRvEV3OniWuOxyyyefIW4ySg42r7GhQqM219
	RKRR8UPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvdDi-0000000F4u9-2YMz;
	Fri, 21 Mar 2025 14:19:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvckD-0000000EyZn-2uwB;
	Fri, 21 Mar 2025 13:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=; b=BMFVo0tktmGhHfAwrxlVXxQ+mD
	W+KbENgzvnHf3YT1o8z2f2DLOqMTI/twR06bexB3VScCG/U4CWLkY07PR+mybLv3kNnCBlFdD1Bjw
	i1QQ3MYr/cqZPcNkvpZmpMvbQ2ouz+2FGZg/D9OczfLDApgkvanf6PeCCztf6swPR7spjjOQjaYJ1
	StSP/x1/Ms9hjTbs8mCoAqtYCyL+YtLPJ51WerIQL6HOi26dVviw0pRZrV/jgZChJws0h/vjvpU4y
	6tB0yQK3pTbyQVFtrYigaAfEjZ/OnK94ZmgSjpsiLSKjCG/7uEyoMomEov1qg88ItybesG7MU0OuY
	41N/JEBA==;
Received: from mail-mw2nam12on2061d.outbound.protection.outlook.com ([2a01:111:f403:200a::61d] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvckA-00000004Maz-2yYB;
	Fri, 21 Mar 2025 13:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEjh7COA/1809GnU7EfEzTThZ0zmb3kKNtUvR9kRAQcmeP2Fd5wempH9lFde3Q7XVKk0yjTjiU5QMOF9u4x7px6fUt4DodsB9JpIJn7oocCDZY/i8tExAmPTSwQF172glbMhmD6oHyT+cqaH5GMAALSxRRaAT8ePBXaOM1UCyHLtBQr+/62y63hf8J1+69bTQ2ptE+OQ3rE6xedn57NuhMmhxct8PS9pfbeB/dMRoh7z3fspXGlvYuPDOf5yBr2cyq1BPI68m/LXLXIIfDkWRUPh6rcyF9JD15W8rYAKkf0l9+zIaBNmElSnyVuDvQKBBEqrOwKON8LVYiZXbzf0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=;
 b=BHnt+XsEjKIJGRQK3/WXP95LCdAuGNNS7zW2y6pZNXZbizEcaiuL/8I3dAi4JQVm5GxDZ4UGNjaaORJEB3IdugkGgGH+g4XEh4WrngIw9fP+PjYwsKJsCTrG7Q9A+0BXB9qGbDIsQwbK0NXmeTgGL8SyxrjLbenviHLHrOjATs0WKSwMBfEMi3jh3xtKm3VVTrmohdbxJ/reXClicAy8SPRKVxBDF7qkfb4j7NC9cGFTZkhEFYVxlXPFINTObuw7Wy+msdhWKkC6QlbNV17SobhM0ZLd2YPN3eNQb53q9EvF8Uph9MSh8JuG43BZZkPG0hQlYtQ/D8JyvQlqBzEZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=;
 b=Q06rafH6gvAUQYH5/D8TLDr4eEj347PN/85247aMGLmhvJVxhm/4D5OtW/IRoyzFBRrcBjcjy2mRKF5t8jkuc62a9kQm2wZUcNsQPrQibkSaEv2FxAHth3DmM/YQlp6CnapbpvUhHl/T1nf81+UJzH6MRDt2NSUSZnYbn4rKklz3AmNMUdmC1nJXvQkRlF4I0cFwpLUZdCYEYnu6/FDoEcoO2WLm/H4s4scOfe4Fj9CKgVWC/22eOsT0ddw7F4OBBxV5vCUs/jTuAFLjjAJ3QNsJuvsVyG6svbXkIcjwj+gtuaJNoq4p1vq7MSop3YyvEmo40tPafuE9z6XKNajekw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:48:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:48:55 +0000
Date: Fri, 21 Mar 2025 10:48:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 10/16] kexec: add KHO support to kexec file loads
Message-ID: <20250321134854.GB252045@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-11-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320015551.2157511-11-changyuanl@google.com>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d9b702-4ef1-49d3-06ff-08dd687f1f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grXFAbXaL4vuNaRoFd60tc3iLmGrf9Cl9Yp+NuMkp2TTCBNmRRPTALIVR6Aq?=
 =?us-ascii?Q?F5nvy51Iow9kaNKu2QJrLMPF+7/80hjP6dDU92Acsc+h9Jyyroc8Q1FhrOhD?=
 =?us-ascii?Q?mYjKmPP9JlRai7Kgr/cJa6TBUihE3abLiKUTJkVX4l8yQUHtgd1s/SF+OT/O?=
 =?us-ascii?Q?+8a2lS1X5+RB+PxsJccu1khH8/GScB1HFqhEgWUmTvTuAKrF2XUmFGs37Hxr?=
 =?us-ascii?Q?N3Q6YE68FVSNo4BspV3CJuHuL3C2k++pjljPuWdq+nGVsCVn7Fc6KJHpg+io?=
 =?us-ascii?Q?Ynr3k7m3n0QHl5NjagqzrzF71NAuQm4qxaoLGaH76antAjSdjZXoGsjEYgmi?=
 =?us-ascii?Q?1L9foMh5Me3m48Ol+aE6B/eFZaa8x7pS8ws9LtyeI5LYCsMUoFBx0qps4BLT?=
 =?us-ascii?Q?irhae02byk5kddh1Xo1ASCO8liCqfCGkwAgdKD2NLgbEjNGnJceYFTp0NVz7?=
 =?us-ascii?Q?zS5kHSUHJLKC0Eun+ggyENF3zyUxcviZKdQYm5wlZig287t8SC5JHFibKveU?=
 =?us-ascii?Q?f/+QoEDPnLxr+1e0wxcutPxkoqlPQggX/iAlh3T2BK7iZ/i6dHmbppjbU7nu?=
 =?us-ascii?Q?DJJfzreS1EGqOZQLR07dB8eKXCC48CR7rhDw0fQ4hyqWOLBONc9u3LQwP4BQ?=
 =?us-ascii?Q?V3W8nWPlS5YT9dotoNh3jdGlSRXXf3AGGTf4SQfv5aeDCp3Fovpe8qe2pxZ9?=
 =?us-ascii?Q?zPFRgAICZ4o0J0pHLbIPsZqUyu9S4suWwYfv3AmbrL+Qt1exIKCfF7rduhta?=
 =?us-ascii?Q?rXOwfVihxFQbbvue0q55ZEH2B7oojNZMPmxypTQ37d3kgElI0eCQZ0xSmQr0?=
 =?us-ascii?Q?nA8fTVJOdu4a0f3Ic+ocRva0uqgzXmXMyK3BGzYMtF5ovP/8A+svGhE2gkxj?=
 =?us-ascii?Q?GaE2XJr1+00ep18pxJJzZ3MIxi7jCjpuOij0MFtktR5fRVmDKMYS8KT4gbT9?=
 =?us-ascii?Q?+JAcMz42wHHMvn2WhswENSD4kCP3Xq7c/TUlStJrV5+yMDKRRkw/wVfvzId1?=
 =?us-ascii?Q?k+4kDJXUjziQ4JoNzVhoatWv0U4vVczTnPd0+QSQe5tvHP/s1dFIVAEo+Rhj?=
 =?us-ascii?Q?vAxYIIHjNBmbxZq+RQeM0ohaiwhpCGEZKsFGsWDlW4N6yMKxXcozIxr5f46n?=
 =?us-ascii?Q?FZojzzRGoeQxR8qgbvhJ3XqCTvUghQ51tenLs6tpwS38QvOOJAWn4ys1L6g9?=
 =?us-ascii?Q?CT4C9aBtao4MOizVfjWfCkEC66rdHLvrYaizEelVe7t8+MepUeeyDP5ILBCy?=
 =?us-ascii?Q?MAxrlWLK1OkYC6APPcprrzKPLxnA+QZxuWpsbU8e9JQ6+6Jawv5k7SckZIgM?=
 =?us-ascii?Q?xMVTp/1+j11fzHgt/kFIK0J64qyIZnbdEnIvHQ4Uuuj6/EARN1G8HsArbag5?=
 =?us-ascii?Q?zCFWROExfpZn4ooMJXshO+8AeAZk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpGZxSSlucsgvPEu8Gs953DLLhRl2nqqN7cB8Z+FBN10vDs46FVe5bcKk5YK?=
 =?us-ascii?Q?fX1p5Xkz5GDAtKinI93clv8nt3eMFCkmVHzNCaYTqd+/N/O9LK6/k5stZ7M/?=
 =?us-ascii?Q?hnizBzViL/BxR3nJlmGFlb096nl1ddBPMA/cVdTTwDLEn/Pv1NQVhDhOOG/x?=
 =?us-ascii?Q?TPXtbro7KvO0yu3rlvDfR77nPZdWDaz04dGNJXD8wNlT5yJfxAnO4F32dnai?=
 =?us-ascii?Q?34pASWIzC7up0wSGNG0m/FnnMsyZwZozzemUJeylCoML/w24IonmREBLjmtq?=
 =?us-ascii?Q?BYH7Bgje1V1gCfImifwZeJr7DBGZB2ROQDV3xlsqvXQbJO2UHK3UfY4xDD0S?=
 =?us-ascii?Q?GXM89e7bUCC84P8unmCAN1hDC2IWt+ShCeVnJmTZs2TbJaTIq1aJIpWDPO8j?=
 =?us-ascii?Q?1LHJDIPhON6JJ1PaSa8c5mdMyVUICHHn9PBz1rZKo8GNpfv4gmKZTFJma73w?=
 =?us-ascii?Q?ULgUCTUK3ls7/CjDq/nxo0fQ9Vz2kp0Vc+z5OF/dHljIHm7MSrNT1CI95Bx9?=
 =?us-ascii?Q?Cvk2Hz/F2NvXns/cXyaoe1xW7ZfctfGmTDOW0Ukze1rNGWWGOdrq841ui2qo?=
 =?us-ascii?Q?Psxvtsgf9AbgaPOrKP7tV8wFpz7lsD58LH/2KHcaRerZM/EST5xuIJ6MGY9j?=
 =?us-ascii?Q?VeS7djU6MUfeKHNK+h83KFrDP5nyMPD9+KqwAE7KaI8fGsyDjpYvDEuQaYeo?=
 =?us-ascii?Q?+YDIp6eIivEmNakbYFNiYW4tJhm72AtdoOUm6aYVZmCjymNbvmcexd22pvim?=
 =?us-ascii?Q?MY+VhTCi7Smxdl69aje0lj44QmfBmw/+qHVVzF7HLvNNPUItsABEs5zt0OZC?=
 =?us-ascii?Q?BcGgu5eGD7lcEWqkWyi6GML9tGUSFh7iCUOr0BPi1k/DQ7y3+6aqaEK24zZ0?=
 =?us-ascii?Q?AOsHQUG2ycYARfpu4++tSnsD5rEV5POhnF2y1xKBpJzhPKg/xFmUFDeAeg2Y?=
 =?us-ascii?Q?tiQMqnbmoiLV5wYcFWp5b5SOygm6/Ish86r7UZ0PYWbbmBl7/cishzD2WJ66?=
 =?us-ascii?Q?nzBCvsyWYSOSdLL8ExRGbT2l8EpSIZMAsNwgH2uG3hkbVHt4p9oVebhWgcP1?=
 =?us-ascii?Q?hHxe97Jwo/pxjeoQ5L3i8pDhS3FGsKUz33XKT4PqGiX7XItrvHO3T6mY2ZnX?=
 =?us-ascii?Q?uW8Ka58eCaAZPXqFqvWtCsWw5oCw97qJ6OR3iL3x6CGIOFEpXlIyyqGT2FRT?=
 =?us-ascii?Q?O8q/DNIrCi3imt2039e2K2AciO6UJjnMpc4jTWCMLqfgWJIdRAs8AqnGU1zr?=
 =?us-ascii?Q?UCsNf2TyXWDnCPS+pWdgWxpO4PqGVGc+Nfns81vWzHz+2glGuEHvNyP/CNWA?=
 =?us-ascii?Q?HXmuxbednVEQGz0Lk8VVfhbAQxotB82GgdHjsTTUNZAnucD2nONJDsmHZfav?=
 =?us-ascii?Q?VbKqFWNsEjBiZNz8DRF+zSi0/yVkCcKvxcO94LGRZDAWX//fYrBBfJNdcOfi?=
 =?us-ascii?Q?BLYKZg6/kJnzqRI2g5tqTOVDgT9fe/Jlmo1b7T7M0jKRZEhus1ezhVViyD7T?=
 =?us-ascii?Q?OVFAv/Ly941IxBQ4o/0oaF+YApT0S7UdNLPwibriQr4PKGWqvl16BJa2KCR1?=
 =?us-ascii?Q?XTb30yqDMf0xQlH+KfVKZ7jNxI+Hjmwumz79uwZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d9b702-4ef1-49d3-06ff-08dd687f1f46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:48:55.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p7fh1lOdxHo68l5yu8gKDJXRWdiCWZZERG6SN8E/9Fl9Pvb8b3Lw6WZwvhTO4yJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_134902_929196_4CF85F8D 
X-CRM114-Status: GOOD (  14.57  )
X-Mailman-Approved-At: Fri, 21 Mar 2025 07:02:13 -0700
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

On Wed, Mar 19, 2025 at 06:55:45PM -0700, Changyuan Lyu wrote:
> +int kho_copy_fdt(struct kimage *image)
> +{
> +	int err = 0;
> +	void *fdt;
> +
> +	if (!kho_enable || !image->file_mode)
> +		return 0;
> +
> +	if (!kho_out.fdt) {
> +		err = kho_finalize();
> +		kho_out_update_debugfs_fdt();
> +		if (err)
> +			return err;
> +	}
> +
> +	fdt = kimage_map_segment(image, image->kho.fdt->mem,
> +				 PAGE_ALIGN(kho_out.fdt_max));
> +	if (!fdt) {
> +		pr_err("failed to vmap fdt ksegment in kimage\n");
> +		return -ENOMEM;
> +	}

I continue to think this copying is kind of pointless.

I liked the point where we could get the FDT blob into userspace and
validate it ie through debugfs.

But as a way to actually do the kexec, I think you should not copy but
preserve the memory holding FDT using the new preservation mechanism
and simply put a 16 byte size/length on the image to refer to it.

This would clean up the special hard coded memblock reserve to
preserve the FDT memory too as normal preservation would take care fo
it.

Now that this is all in the kernel it seems like there is no reason to
do the copying version any more.

Jason

