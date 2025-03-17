Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00DDC35FF3
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gomLnJhmOALU2V50CEj1wsMxBsXkPcpvd+BmS0FnMH0=; b=YMoxtPgYPb/2PCF63B/iCs68v4
	g3QNWSLs5ysqWklF/Fu8i8SVhoS4/O8nLfK+ySLEYk/wtyNKcn0O171b75dlDlprtUYBW0ujuRE13
	A+/sgi4EzrtqKiiJ0pjgDGuJIhPJ1Gjkd6ZVzizzCd81HCq/roYBqMHGZEpzImF3OnLZ9GB/82N3N
	0sT4rSn7TAcijA7XaAT0HtapJFqtEyQ3Ya69dCOvMfUyS3orXuD6uhZtTIw8tRWg8aVXYwaaPV+GN
	OeLjnlw4YBx256Zw4QI4VDIb9nBlUvDr18EioVwLD62sboCPNYiHfSYagvULYpRuDusmpBbpg4fl6
	wK9V+KMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDo2-00000003R2A-0niS;
	Mon, 17 Mar 2025 16:59:14 +0000
Received: from mail-mw2nam04on20614.outbound.protection.outlook.com ([2a01:111:f403:240a::614] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDnz-00000003R0z-1HIT
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 16:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcYnWDem95ZaamCsrfR3+JIyiuhrYVBye0KTjgsUwJMg7PdAXcDyH1tXtChx+lCsmV33Z2LTxHazk+WW1BImqyWUisd3t4K+ej24lplKJ8CrgIvgzAgwnjY8CTZ/znnW9JRcxQTxw50V541JhmLChPS4l4JlAr/4uotfoh+HgJBrPP3IUA12xSX3eUKNmmbHM98nxpvuznETsyVVbyP2TEiUOWa1Vu7A2GnvZdh/vGZBMIg11HM0/mspxIf304sBSc58C5jLJs4xCaiQKo7gK6/AyqoiChnVoadyI9Y6YPGc3lkNqFJ8WMegGp5iZdDDO46mWEA8QNYIsMjHypxYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gomLnJhmOALU2V50CEj1wsMxBsXkPcpvd+BmS0FnMH0=;
 b=Yicpny+RY4Aq4pxDX1RJ4Vlde4459i5H4+HbIErJ/noQa5nnifWEleKAM4Pdnn6XtqFXwxf1nTS3rtDVK3Ez3byiu4xk6uY1KAqVTdYujpxI5ADmkviKnPDrbKbt8WwQQG/aOpUZxWDtma/W+jumeCk0guMw9ihO0QZydI0K6vK8pEUNwN6eLuIq+Bkgx36/LPpjAWoZNljRtjFynWMtwvf1iNCm8SkYXfIpJ4SmsyEd/uzsZzyZ1a+CULiwxnU8oTA7OnQEpxDkPJRaC3Qcptq67FWRcC5zjIfBxOfTWc2CPU8kPkzzDZHYqdY8zstFCh+GRxngCE0S5nS4fRlT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gomLnJhmOALU2V50CEj1wsMxBsXkPcpvd+BmS0FnMH0=;
 b=nDxcRuKTSg3a3+riNTkRGwjcissHrquCrClFgN044Hp1Uo1DRW6HSnyfvWjftRvB7wKAVzLUFd+AOfxph19d6oDxMG86VXYOCEpizN7HdnLsmmwrZXFsu5QfuTz9Jsvt8f4QJa47BIPPWA2EIWMPcHzz7CY2kQAP4Q70qIkgcrEx2coCFdJauW02dW2rB47QpLmrJPiGs4K1vg95UPpWxjL70A7D32mZZRIsbiikjHI8HFbXQ9GhlGpwQNFKJMuRlsVvx/N0d5PtH1sohz7N28wfLfU6gY/aPEKWTo9J35yxg6kdBXsTbW3XmVfhM0cVGzqwvoFaLRf2xgzztzzj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:59:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:59:06 +0000
Date: Mon, 17 Mar 2025 13:59:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
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
Message-ID: <20250317165905.GN9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: bb96db42-79b6-4138-e327-08dd65750733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xGJY+kcizrzkNI1KvDrCGyJ3YkLEFcUDvuDd/5XocIY4Qf+ZWdErHi1Emv2g?=
 =?us-ascii?Q?PMA9c2jaBOAghH3POju5wi0YsuTx3X8IXJLyFH7rR6oU+bLAQwdKiTL7NzHH?=
 =?us-ascii?Q?LxZ5U9lGqOptT7cMBtcUfTtcc7c52rCMRNa+O8QbCurRm8wl/nxzzyM7jGdw?=
 =?us-ascii?Q?6rKzZmJDInynIWgJpcj7BB0yr5YyV87C3cNBVTsHgsKAiIwy4Vnb4A4hXosv?=
 =?us-ascii?Q?mk4Q/eq7IA2XPeDh5Fsebjfa1u4D7lVwLI529tLW1/EYP9+9+j+C8pAe6QX5?=
 =?us-ascii?Q?7Ev5GTkML+McVJfD3CqRrmZaBn4EffwdOir5c2IjkHvhaxVMvj0XkzDjs1VD?=
 =?us-ascii?Q?83+5dUZb3214Sx8fg1H+K289R92ZVoFU4Qi3k+MtFgGVqvnzYDoTPtN/gc54?=
 =?us-ascii?Q?g9yfRVQUDeq2SBIAP2Vh5nkquH+9jVyaiBNuBxsBykf0zLbdfd6z9dmUsgog?=
 =?us-ascii?Q?cQSidPtcIn20w9QVDx9BqwFlSivurg0JH42xHKk+R33b5gLE2/jYQjsdF+vT?=
 =?us-ascii?Q?4c2zX7Im0bWj0dgdyHQLnPtr++0I1F3UkIBaT5jMFdIAsiUZrioPg0piiwgm?=
 =?us-ascii?Q?sG45T0qrUrdgn7AhhtJHHf+58EzdaGuFkfGxj10xgO+jwZCkb5p75j6qzhh5?=
 =?us-ascii?Q?Mkx/B2KMzQN8k7BzrYZ3Ux7AiYP3HeGEjOZ1x35zd15ejvxN+iSiIXp4zcuO?=
 =?us-ascii?Q?8v5d12iOWriQ7X6NIaQXjgMFOsFSeegPuX1H58iJ1WFrZcU1+1bCJjZs9SYk?=
 =?us-ascii?Q?oeuumebeQ23VcOOdHFR6bztYbqkz9UGiie99KEdy5x6EGn2iQ6qZ988Yh6va?=
 =?us-ascii?Q?V+VcjHe8FmZQmwIPm52b3F7WCv6bYWDLJlAYewmdO962Rcprre+hqB+hciag?=
 =?us-ascii?Q?CK9IIhgbn8Ts3P9IYmqydtg6uCFHZlJHZY4Xybj2nqrtueHitV9/zfQJCqru?=
 =?us-ascii?Q?IXlBo6jjw/mYdFAUEeTzcOQHa+Ij4dUrjfrHa9b13Dvo/ohPCU4SRfA3wvZx?=
 =?us-ascii?Q?HkIEiXMz3N2ZH2uFxUNS30Wvyvn4lab/3isy/rX9/2MLXPx3UftLJjI/hPQL?=
 =?us-ascii?Q?YLMsCnHpIRtPiwtEZcrLxdc7yUHblIXWONpVekkOSzrKATU7SxRv6GwqfEJv?=
 =?us-ascii?Q?VGEPcnuN9cByF5ProybfNmh3qm+geRKD4sB36nhZr0fU2PWKvwIGfXdMSeQu?=
 =?us-ascii?Q?4QLmkgO1P4e6wqHmdg7NiOTFmXg6c+04FF2aN6q3dHIzLafd6cOd7/DveBcQ?=
 =?us-ascii?Q?R/yfrxVxhOTvfMSa+YgovZXrzcRzau4xg5wd1uxE19h5r4j2qbjbUpNgA92P?=
 =?us-ascii?Q?5Ij53bjn9XokfIXHMvdiMBKX0mTa+fKL08f0KbzHRnXpPC6CU+qowFWbi+4k?=
 =?us-ascii?Q?vAW3HYk949iIaKc5hxiIY0+T4vA/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yDMFyB1YhPkCwDJ6oRQ+LHdXlb4ZF734djUYrgzH0BxxNRAWh39pzgBBbcY?=
 =?us-ascii?Q?iThlosd1zS6LfItM5D58RTggc91tnq5HjVbksp65Zo9RmS5Ol3nzUAJJwBr/?=
 =?us-ascii?Q?j9VdKjcu7goIOYxM3/gyIR0PylFvk6y+vgIWyeBC2FCwQIg3sTqWToGmpgJ2?=
 =?us-ascii?Q?pt+KTq29F6buQMHqtu/K+h+PJtZ/Wmlv8Coa0AypgrpfQYLiIPxBQc1WpU6A?=
 =?us-ascii?Q?sCKRxf5rz7f6Pllysz/YCCLItU7cHPFRRVxUjYxzFeyqMVbVhj8K1lPcA3yj?=
 =?us-ascii?Q?fxzl+F7/L5HD8sa3/ss3z94NoUaMOknHq/3keMn51Gu9AEMPM2iVce5jifRz?=
 =?us-ascii?Q?iEJ+hB13DccZcd4SeP39qacUfp6OLM9V9Cr04py74x2/+Lbdf1elk66kk1cf?=
 =?us-ascii?Q?hoIddEMUc8/VTy3TsCdHI1XJI50hOPY0sSuL68xgLdFuqFYoGpV3DXFkc1pn?=
 =?us-ascii?Q?dU6NJtOG+wQSzTqLzw88aM0zjW3SQZ2b6vj7AB9vRvuXGWK7lqeG4kCXmP/h?=
 =?us-ascii?Q?mlxcEDboJpI0PVmPKJyhCUP6mC8oor/79bEixeR/7akRHhhpExvp3p7oPPl7?=
 =?us-ascii?Q?9FKaqumAZsS7NHmgu5vW88iJSZtC9lyjOcsj3Vk488hrKMNNNMaso5LvnDZP?=
 =?us-ascii?Q?osW48vyIlrimA1tJrXWyjtaN5mJ7N4O0OBRvlnV3GFOj5mbnOL8hz1csRM2H?=
 =?us-ascii?Q?9YhfZkHYp7w5GloJHdOIQC5sk8uBcw48Bl4wgkwMaKNm8ZOdba/5YEt6Uolf?=
 =?us-ascii?Q?TjVFjdx+BEw2+fOqDvdAON8qsiGQ5lA0MqxLga7Rwo58RiwW4hKcfAVx2C/N?=
 =?us-ascii?Q?6lWMNkBGIntabFEW12aymFpWvRdHgz3RVV/ZCbVx/jmGS/ByHZECH8QQ6rTy?=
 =?us-ascii?Q?5An8bY71/HA6vi6qxPLT7N0D0k2kkoIbLoEensxxpcTM60eBIdA4bJYeyGAl?=
 =?us-ascii?Q?WSCaVr8WJs+b0npI6xNbPOwjPAma/hvXFMSZLqXBaWMdQbHIJnIDMh3mJWb0?=
 =?us-ascii?Q?v+lj4z5sePoY2U8lDj54igf+fNRXaqVD/YUXG8d68C2g2His1bdo4HTbixvk?=
 =?us-ascii?Q?rftSEeb0odvfUWp579JoS+Yp1dArqy2tGxsnOMo3CrI0lLAKOXVinxwGnNZU?=
 =?us-ascii?Q?cFgOLxQ1u5mfDriFnlwxpZTRIZpUhRguJ7DpWJVLzrHhlDkgjNufU77HW1ku?=
 =?us-ascii?Q?6sdAVNkGhg/Rq6DRkIhHrn6S74Lo7LJgKQec2CXqvWUzRTQ6R4g8JmKdnJNs?=
 =?us-ascii?Q?W1z1zDSNjIKTnv//5MxZfCM83qds2ctl8VHQVevyCVqRI6IbFapYGclVjE5j?=
 =?us-ascii?Q?MqxrNpPyBwQIzO0X2p3P9pGscxynRIsnPa6W25NXUhe6xuOFLiCasUC1GzCX?=
 =?us-ascii?Q?PnuQv+WRv2sOxYQzl2gL+IdXgli0Yi16m7Bvj1IIib2AX1oECkoC9Ffp1wiJ?=
 =?us-ascii?Q?tvXFc2E5pUjtrTefjeIAFFjC149d2WPdPM4Cm61ofQC5k9U7d4ZrblARZvm2?=
 =?us-ascii?Q?4HbXs/zBgZ2kkvYzra2Ew6aMEc7V4fXfdvvYvBIo11utGXTogVzH2wu+2fdS?=
 =?us-ascii?Q?6bn9WmbT+Nj0cWxajAy+CuQCrf2di3Momt/bhXb4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb96db42-79b6-4138-e327-08dd65750733
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:59:06.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+S5IKVuwEzilPz1lMBiYtLFhJErpj/ZA/I97WicbD9jLw0oOsgYg7FDRnBi+vE9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_095911_337998_B43CE224 
X-CRM114-Status: GOOD (  19.15  )
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

On Sun, Mar 09, 2025 at 01:03:31PM +0100, Christian Brauner wrote:

> So either that work is done right from the start or that stashing files
> goes out the window and instead that KHO part is implemented in a way
> where during a KHO dump relevant userspace is notified that they must
> now serialize their state into the serialization stash. And no files are
> actually kept in there at all.

Let's ignore memfd/shmem for a moment..

It is not userspace state that is being serialized, it is *kernel*
state inside device drivers like VFIO/iommufd/kvm/etc that is being
serialized to the KHO.

The file descriptor is simply the handle to the kernel state. It is
not a "file" in any normal filesystem sense, it is just an uAPI handle
for a char dev that is used with IOCTL.

When KHO is triggered triggered whatever is contained inside the FD is
serialized into the KHO.

So we need:
 1) A way to register FDs to be serialized. For instance, not every
    VFIO FD should be retained.
 2) A way for the kexecing kernel to make callbacks to the char dev
    owner (probably via struct file operations) to perform the
    serialization
 3) A way for the new kernel to ask the char dev owner to create a new
    struct file out of the serialized data. Probably allowed to happen
    only once, ie you can't clone these things. This is not the same
    as just opening an empty char device, it would also fill the char
    device with whatever data was serialized.
 4) A way to get the struct file into a process fd number so userspace
    can route it to the right place.

It is not really a stash, it is not keeping files, it is hardwired to
KHO to drive it's serialize/deserialize mechanism around char devs in
a very limited way.

If you have that then feeding an anonymous memfd/guestmemfd through
the same machinery is a fairly small and logical step.

Jason

