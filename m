Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CD1C3600B
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LsfHx+/+Fjb+JRgfVs26S7JoJLIyZX6I4MHMDUhxSw=; b=mRtqeHqCRkxYzGPVcCI6/av/qO
	DKeZDxpKX1mDDdq03NnETmyMYhpXlXbeNUoZP05Q1R/yMxDhMoekVvWSoRdH9xlGVi2HPwEzQRAs6
	neqcJ4M1Cdf9F2Rhd4Gt/70ZnngbsIik1J3hjNgy1v2NZ1/121g27SWzlx1Yl+2e7cxkXbC7AEXvj
	03HhitPCMw4FUBL10sWunLuP9SYlNlwaFSMx/7L6+r34JFb+vKJJtvOPUg2PzXASQnGXNresuVXc+
	Aky3GCnmhBWGeTykpQvBG2Oqp+Mnx1/11c8a8J9WFm7mh3pfl3bVwzK5RlPbi3ApkDT2+FbqNSw9B
	7rSuK8Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzHIy-00000000rum-2c48;
	Mon, 31 Mar 2025 15:44:04 +0000
Received: from mail-mw2nam12on20610.outbound.protection.outlook.com ([2a01:111:f403:200a::610] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzHDZ-00000000qGi-0aNr
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 15:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4XmrohpPPT/+FDEQkr93z8UoyXTBcXdWrYbTcabL18+eVXTz//KPSH6ImBkYOX+CvwsSQKtppPfJ+ZUp2wd6yW55xn70KxURmix9ZweyI0PQqRgkwfMXMadco0ZmDiaNZAquPlrjE8AVV7GIHMPUYQSR9TVTnNXriFiUHoUqTU2JA+Kq+i1v8oeviaRf0w3D2Elwd3yhAiEB9mi+omgXor3qTjIc+3Dnc4M25N26+wzyBrE/3tTyhrhW1G4/MqJlJEGG79CcRH/e4vkjAUqNJc25OVgc0eWm5rCCJrXNlKpBAiGTXAjZDVoP2HiL7ZYoq02GDJAdUHzjJxeXqqIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LsfHx+/+Fjb+JRgfVs26S7JoJLIyZX6I4MHMDUhxSw=;
 b=zWkSsh2omIG6THvMtN+bu7AGO3LTE2hhDIxnS/OmGkeKATaQG+Al+olTNU9NgKy4K8JKtWK3DohYe0EWoMJ5lu7CjiRbmlqWDy9oV+isQD3qwU4OSy3XcmvZBCl03DKiZYhBdP5x5yD8iNMokfx5vtYKs3oz8qg7x9Kcs6bOxzvP+mVymsKnOJB2iYR1v9oCM4noPzVYeHFs8dUaNviO7g+FHR27h0SWyIQSqRKtv2GjuKnFVHQ1qAPWIWAt3gPMdS+oWYZdO4su8y1xZ8VJeKlC3/Bjn554ndjPqjT5wQeJEblu0uLZ7GJjOGFkpSo8SXD2HtL7ybwdJJ45Fyd1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LsfHx+/+Fjb+JRgfVs26S7JoJLIyZX6I4MHMDUhxSw=;
 b=lBfnxXl/RXYdHyIsSY5MnXjNG/yrBA2gbiMvlstpj7LOXxNkKV3CcDza8U/940yfMi9I4WjLZpA2KHVoIKvSLxPr6OPGsiZnth+yzghSqSsZuglLMDfEvrLIjSp/yFG7dABSoOt2nZgY6I7zHAz0UpRTzYuS0ZOihuKYNhQNYpKxEWcsF3qU88YuJkyUpS3RTegzKsVR7lab356zsl2xP77i36gyY0idWGCallZar/F5jmEK1jtFZrOMDIviSAerNEnAiIVfE8ZAgZcIpds1duUJ4TyjSxiwf2xaZiJ8LYttcxeWDkGn/iBEnBTEZd7W2zJQIr0tQWjYy2bbm7Z/bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Mon, 31 Mar 2025 15:38:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 15:38:24 +0000
Date: Mon, 31 Mar 2025 12:38:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250331153822.GG10839@nvidia.com>
References: <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
 <20250318-toppen-elfmal-968565e93e69@brauner>
 <20250318145707.GX9311@nvidia.com>
 <mafs0a59i3ptk.fsf@amazon.de>
 <20250318232727.GF9311@nvidia.com>
 <mafs05xk53zz0.fsf@amazon.de>
 <20250320121459.GS9311@nvidia.com>
 <mafs05xjvs9eq.fsf@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xjvs9eq.fsf@amazon.de>
X-ClientProxiedBy: BN0PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:408:eb::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 79205e54-55a7-4855-8d06-08dd706a12c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1SaN0SIk9jY5IXZiv9GeGjiYUK7Lw9I5w5EAsde67UB7OB79pVURjkRG85uX?=
 =?us-ascii?Q?jwcaRR65yzwm4nIyha1rh8/EPF5zT5cVb5zzrnfBVACnRInhUakdu/vIGkpC?=
 =?us-ascii?Q?AuazILLRo/uZfUEA4CHEKalaB5aLaJns1yNnzXJ47OXeltQVUjSRSEZvMNm5?=
 =?us-ascii?Q?Xl3YspDh4V/BxuP4jR7LfV5oo3FRFQ/W8xqKo6UjJ079N8f9R/5Z4lrkGp+6?=
 =?us-ascii?Q?sPuIvP5S/4+m6kfvd9mPCan2pHGAReKpN3a72Wmk9anlZDxR64KwmLprFYM2?=
 =?us-ascii?Q?XQwoTHTLDPOTgGeIxhhcu/VaIwZIS+BiPDIwkEzgjDxjxgDuv/G8Kzhy6r/r?=
 =?us-ascii?Q?pkRff7QfvHB2I/d0hATnEsM0F0W37Ej/aTHpR/PCe10byCbZhCkmMd7hzc7z?=
 =?us-ascii?Q?3JJQ5JKh3hM27oz/bWZgtMVlMXmo7cYrYjVcvKA5RqdOl9k85Xm40CzS7P7z?=
 =?us-ascii?Q?6I61Fi3x8ckyXVlwNsYXIkHgpQEIH/0I+AFP9uOY3q8P1+2hdyobJCApG7YH?=
 =?us-ascii?Q?ke8Eqk/+wFUwnVV42VHDJ1oHFhWO1f4nQQrKuRkJN2jGI52dU8KGh0WZaZ4A?=
 =?us-ascii?Q?EdvshWwzib/huRqoeAi2PPToARy0752EjU4OA9w4fmz0a3q5VrFERIgLLVex?=
 =?us-ascii?Q?BTvKNptnmI72ZeMwVAmXNhHQSCETyaO+jh20bjiQ4I+rvM8Mg8cgZNJpwC6x?=
 =?us-ascii?Q?1QQnvQo4kvvwOJi949shYneBtgQft8X2MHCR2jpcuq8nL68k027Dycl0XQkO?=
 =?us-ascii?Q?4/Kk5/9qZi/6cdx8xpo25dkk2nGk6CImDzsUBy+N0N/4k032N06MoN22PsxW?=
 =?us-ascii?Q?6PNPxBbnRvnMB6IRFt8cNFq0E3dyaVnWMMS4C9XieNi77OkbNnezTQBA8+fX?=
 =?us-ascii?Q?1bZCNQUilxGKL86gLhHjQLlo1Ybw8ASlyiydSEm30wKChdtxJlrrCBhO1tDg?=
 =?us-ascii?Q?4GvyjSRF7W2/nPLZsh83AE0u7nFQrhLpA0nTSrpXyB//oGF2OApJ0YKWDplK?=
 =?us-ascii?Q?xV3n1e57WRA5DlzffNTzy0iY1cQS2mJ9L2eMn0rqXnvXw0BETcUJn1GV2Oi2?=
 =?us-ascii?Q?IlcJSYRIGYyvzzmkQoGMF2shMW7zsAXFb6f+Xlr4kiffTeAnWxa9kGz6SUe7?=
 =?us-ascii?Q?VN+SfgHROluAmhBRTYbyuB90s0qh8UV5tzokkyhBgpoR6PidgDDIt7ajHPap?=
 =?us-ascii?Q?KZxKoYffWTyeqok7RS2PJJMrFWYtEcKrZQqGkFfPKynveOo+oHiQWakDh5Tu?=
 =?us-ascii?Q?jSzGTVSImGg68woUL7YSczHTSeNx7nhL6ii/CJTm8eSnTj4uLxMi5WWQvaY3?=
 =?us-ascii?Q?tYvZ8ng6ILlca864QOiQb1YB+Nirm/SkvHiNw8tTd3DZutmYg4VK4hr+0/MG?=
 =?us-ascii?Q?vQgHTba9o7peUaU0JIW+1z7Ubsba?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOpFY1br5I7aLPCG3NnrkUL1C+KhIsRP5jkJ5Kq+YiKSnETEsTWIjcP8FZq3?=
 =?us-ascii?Q?dU7gPjABdnnPLtpc2POraJvWhg0lTEauYoyaqut0GfGDwVe1Vkr9zb8wsWKX?=
 =?us-ascii?Q?ZINu57ZbbSlmBFOYUicKcrTYFImMSsy4lWdsk4xh/g6vWeKdaL8WASOZDSML?=
 =?us-ascii?Q?HZXl8AUuzuIJRuexHeJ7ozoW8r7sfARcVwl35YCN37oiAorC4GIAscdqroYA?=
 =?us-ascii?Q?zL8x9AWmelEy5o2XrUXqszSIuOhzqRFCjGlE0CFms1QIwnNvdMv0HR+F5QaY?=
 =?us-ascii?Q?Kx0rW2OxekmGcQdzcfXl32XNgiD5YrCUCLj7z79PoKzXO77sgA7N809l0OwL?=
 =?us-ascii?Q?Bknc9WtBGoRNQA/ofBgRyO+QydDAo2Hqf8i2r1qf1ZSIoXH9edh1Y0wcSmiA?=
 =?us-ascii?Q?rHrnS+S9hY7D+4XJLycIu4MbAbFpTD9VsQZC3KNTKpAbzq0S2AAYDWaAoFFb?=
 =?us-ascii?Q?uxhpAxUY93wPatd4rq/Nsb4EKUxxxQwZRoG0reDoit1jv/Q03qruca9rD0rC?=
 =?us-ascii?Q?7fOJKZPAEsb8NrQNuBPcb4m+1Mz72IruUzcwmEUDQijRiFudIrGui4RXaDT8?=
 =?us-ascii?Q?YikmEjG4yPwjTuDW8WtFjzkrCDVWuEKvCmTO8h+Hnp1OEM4CgMpA/g8AtCdl?=
 =?us-ascii?Q?jyBS0KGJF1px6yADOS9y5ppAaozixqnwQANY83CZieUsSfVBicOhaCyiLQW7?=
 =?us-ascii?Q?vdWMbIK0vNASUE6/ssJDn9KxNvkdcJ4aYlby+WD8CD6NUnzd7i7fDnHN4ZFd?=
 =?us-ascii?Q?FjVU6d1LY6Hx6MJmYmxGk82ZxLMpAjTSblMXPLD7e7vAXcRYMOZRluy0CLO6?=
 =?us-ascii?Q?skxDkho/mOyB6DrNOSKAHoGHvQQesdle5XHwCCH+k0lG4TmHmI2jaV5qm6xW?=
 =?us-ascii?Q?wzrKDjXm1m8Sk/JOiUEkGw6TehcOBoqZX1+WcdNiIUrxszFaVMxvW2Z9O4F6?=
 =?us-ascii?Q?+HxeQiTxnL+SAFY0wy/ayi6VobKNx70Q8eP6Hkz7Ssc8Gp7MG1EivQMP4GKf?=
 =?us-ascii?Q?9ekDzEDtstpnKfrX11QUHhmsC9simJdxbfLG78Gt4uflS9/Z58S8y5AJ8iIq?=
 =?us-ascii?Q?ptR9m/koTfAKL1TZ8LMsDGPkfM9peAcLm9nQcwzGwfKYZyR8pLqTkh8nzHfO?=
 =?us-ascii?Q?p+oU44AG3Dq/VdmOzytIkmN5xIyOiS4aYkvlVeFxHNQfhQpkUX1MLYRhMBoh?=
 =?us-ascii?Q?2FpYVLRevwhrcizylbPvKdA/t03UK+TzKXjPW+BXLyRLaH+AIqplsr+tJ5fM?=
 =?us-ascii?Q?hEoQq956FHWRdk2phA2SqQV6dNywU0i4Z/qQGfPtXfA+zEL6laNCCdCBaNRx?=
 =?us-ascii?Q?oEkhqC9h7bxOfjUw6svhVTcHK1zT5By8DhFITC+y8yR1x6hay3ZXLIjyOX4o?=
 =?us-ascii?Q?eqRL0tEWVM8gWuh18H+sPvLHWBfsgXhTbf1X2vcpf/TeGJQVBmapa8qK02qB?=
 =?us-ascii?Q?Plpyi+rGdgrSAFxzlWf7IK9Ar20j46QyMIH6bXs/HJzrvwui9WO1lpKAvInt?=
 =?us-ascii?Q?gZtySPqydJzWK1og0qwyPLeBhM9ntbLW+7H/gaSpq/dlFYLC2PLVB/EksRc8?=
 =?us-ascii?Q?N/6VcD96gSsdHj8QMPYB9kC842YV6VM85NVnq1+1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79205e54-55a7-4855-8d06-08dd706a12c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 15:38:24.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD/3851rC2EQCjMKnz+qFONo4NmFAZkC2TG5g3fht1jS5nPFFraqBAYt4wq84Ana
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_083829_188945_6093209A 
X-CRM114-Status: GOOD (  30.33  )
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

On Wed, Mar 26, 2025 at 10:40:29PM +0000, Pratyush Yadav wrote:
> Ideally, kho_preserve_folio() should be similar to freeing the folio,
> except that it doesn't go to buddy for re-allocation. In that case,
> re-using those pages should not be a problem as long as the driver made
> sure the page was properly "freed", and there are no stale references to
> it. They should be doing that anyway since they should make sure the
> file doesn't change after it has been serialized.

I don't know if this is a good idea, it seems to make error recovery
much more complex.

> > Then you have the issue that I don't actually imagine shutting down
> > something like iommufd, I was intending to leave it frozen in place
> > with all its allocations and so on. If you try to de-serialize you
> > can't de-serialize into the thing that is frozen, you'd create a new
> > one from empty. Now you have two things pointing at the same stuff,
> > what a mess.
> 
> What do you mean by "frozen in place"? Isn't that the same as being
> serialized? 

I mean all the memory and internal state is still there, it is just
not changing. It is not the same as being serialized, as the
de-serialized versions of everything would still exist in parallel.

> Considering that we want to make sure a file is not opened by any
> process before we serialize it, what do we get by keeping the struct
> file around (assuming we can safely deserialize it without going
> through kexec)?

We do alot less work.

Having serialize reliably but the entire system into a fully
post-live-update state, including dependent things like the
iommufd/vfio attachment and iommu driver, is very hard. This stuff is
quite complex.

I imagine instead we have three data states
 - Fully operating
 - Frozen and all preserved memory logged in KHO
 - post-live-update where there are hints scattered around the drivers
   about what is in the KHO

From an error prespective going from frozen back to fully operating
should just be throwing away the KHO record and allowing use of the FD
again. That is super simply and makes error recovery during
micro-steps of the KHO simple and safe.

If you imagine that KHO is destructive then every failure point needs
to unwind the partial destruction which is a total nightmare to code :\

> Main idea is for logical grouping and dependency management. If some FDs
> have a dependency between them, grouping them in different boxes makes
> it easy to let userspace choose the order of operations, but still have
> a way to make sure all dependencies are met when the FDs are serialized.
> Similarly, on the deserialize side, this ensures that all dependent FDs
> are deserialized together.

That seems over complicated to me. Userspace should write the FDs in
the required order and that should be a topological sort of the
required dependencies. kernel should just validate this was done.

Jason

