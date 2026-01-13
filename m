Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D350D2D0EB
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zbcl6c33EIcnVK8ECDvcLnQH18A+fxkim5B7oeY/kJ4=; b=kNjOoXkMg+3R0EnZVS2CWS70gd
	sUr0SgrQSkFOuIj7Tib/WZe76YO5qoTNG86zXLGhCXfm2pSegOYxsfHf+CGNBrhnwFB3t1CrQqvjy
	1tPmDgw+8H/AMI53YvEy3wMUO3k4mZsHb+2KZzFyf9PacBLKYZjG9QlWqIviKehfGmUrBlsxagfOK
	goQ8df2DJuAm9LZW7M8SOj6hGTgDgMgS3/Y61+iJtKKSMWws9RWAnNWdP06tUbDaCpGUiyK4C0I+B
	jYcDc+QD7egzgXuIWDcN7C8PW0teJbFGqS9DLkBtpXNZtVHPA35o7wlJXbLPN/jPMxtiuf0l+IPlU
	nkTEio/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfe5X-0000000780J-3zNR;
	Tue, 13 Jan 2026 13:05:35 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfe5V-000000077zb-0qKr
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 13:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyhAcOAycuH/qAsazswN5rSe1lSLs9I74wYxRW72R+lABxZnEwB1BZelwaCnlnJwI9hy7yZbpyFbC8y+xqwbqrqy4h0jE3/OX0ju2VNOlfveOnv0SSrMW14VwOSg1xPu79bf+aj5VYENzbT7G51ZPSR35Sx1mVp3xW6leSt5S2Lc3LQisz0zVQQIETRdqaFvpfIfe4OZxZ6emFdmS4DMr55kjrFviHNIzh7Z96qUI76dvy3AYrPRiZiCE/UVo3yB+SMdKsIjmR/qzvu6uD/z29d3H+9nNbczGs36RYf0FGqbWXg5wZEEdozkuRplimhrt+J/9uwuid7WSzQRBJgHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbcl6c33EIcnVK8ECDvcLnQH18A+fxkim5B7oeY/kJ4=;
 b=UO/aBroLYxpf0v/aGaE/U116CazJ6FNoNeyLOkBr5hDHLZBTVOhmZRyB0SO7vJtPrImcJ+R/WvUz6upTIdzhkykYA9QwZdZddZwbmz7s04YSibZBQ/mPKErolg5iqyNrCBvdRZeLzUpP/IxPPO1IMCkttp2NGw8X5gV4gxS1+sKwyQAnfEIQoDRlNSK5wabuJK9i0GmnWhlU/FN1IJTxwzNSO5DXbIWSVoOqB3wxtQkBq8fJC2EOY3h7I9y7oihJ78+mgkkuVAZyDZZZD7oaKSk3OSd5rmobpfv4Q7zLhttjUaPlX3NyBvU37Z1M5nrxigAwCnIl62kPLfprvFBFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbcl6c33EIcnVK8ECDvcLnQH18A+fxkim5B7oeY/kJ4=;
 b=b2hWmMahwA39hCohKkvFi1GINBAVK3boRVs3uEh+W9xKzH1f84Q+5w0zeNSuyGNZwgBioa1zEITLg+Cee+XuLyQRHc5UVKvA4Az2Y57bUAJaGtPLZdlknygyS9LNcdNOh3IMzK2z4tR3gcLpwIiYegfpLBVGA/yKLXoXwZSHez9feViHon9BCmqq4VqHqule9Y4HEKzR7oXwECOS6XyWSDrLT6s0LYwJSiZ63ShrtfLxTXVBRXwTOHZGc3co7ljD9uZ536mnOkoWl71GkxYdtIwdeymcYDAW+a4pdaTUxOqVzyxmqoiyykCtUzUqGc93MFd/kenzNsOWNRjNPrmM8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:05:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:05:27 +0000
Date: Tue, 13 Jan 2026 09:05:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <20260113130526.GE812923@nvidia.com>
References: <20260109001127.2596222-1-jasonmiu@google.com>
 <20260109001127.2596222-2-jasonmiu@google.com>
 <aWTJ2v9J-Aa6ykBf@kernel.org>
 <20260112143904.GA812923@nvidia.com>
 <aWYt0gBHxDCKqj9Q@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWYt0gBHxDCKqj9Q@kernel.org>
X-ClientProxiedBy: MN2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:208:23b::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 931f04d7-7b51-4c85-8aa8-08de52a46bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHMPdC4bp8vZSC1Q3rqf1/prJd7uNfqJqHdvBAJGslSy7XgmTpoOS7U9NNPV?=
 =?us-ascii?Q?fjuprZufElHWFEiHAyq4huZ+PxweoxgxWnCScq7JWz94EDExMrK1ESCHOP5y?=
 =?us-ascii?Q?WL1fFsS38PMo7Ux+SyPXlU+KKLIKVtMsR3OJR5BvjAb1QtSrIXoA6qxeMMJr?=
 =?us-ascii?Q?hiT9K4T+cLUAF+11jqddf+KhuqRvJvjfNjMhuWnkxvMo6qzs3im2ZrgyJqsI?=
 =?us-ascii?Q?t2x//40TKkJxbbuJue9L9hzL6qlawwOUWayg0LMNWnudpBY96AU6to+kdYCW?=
 =?us-ascii?Q?QOyKf53DGs8UK7C/aFxLDSvSaViIBbuxXcrx/chB8fDRkx5iryY0iIy74ERV?=
 =?us-ascii?Q?hwr0+wVWQbKddQaJy9fnILwUb/o+RLPw6R6WeSyBUUPjmm+efNb2BidCYjN2?=
 =?us-ascii?Q?9fMxtukYIGe+Gu6YJl7ZEV7gd23JasIvb5os8d0/1UkJ9QwwBjn8fukmPjxC?=
 =?us-ascii?Q?/CvkxfFUoQkJvwgXBgV97KTdJf5TadhPeB3+9ilfAH2nBXhXCFWIrDZjFPgu?=
 =?us-ascii?Q?i7qCwsqcHHSZ8H/HkkKyW3mvEqGD8dLpWoZLzLqXf4p9kTlL53Rs08JwKvzN?=
 =?us-ascii?Q?nSbzyTAUvePHRNT2q9/k6khyjtge3XCS9bc1/GsBHATHS24fU3rlXAHjeyde?=
 =?us-ascii?Q?nTowE/Q0p9t3o0WlyDRnxphQ4lZj2k7iV2IiI5vHBPBZ7SXNPP/XHTI3HiND?=
 =?us-ascii?Q?FZ3kkYMmU2fFRO6yYbJIgGCTmmUDzGy/8i6532pF1mA04U2l896nnpWwK3Iw?=
 =?us-ascii?Q?qwkEXjoplYokTgMM76YBLKPbYCYMB+uIeC9SzS/8t6mD0eD0mw3nqPk4OJbZ?=
 =?us-ascii?Q?bO9aioBf45z9tPW6gwYrZRr8DFcF0Jz4f+Q6HbSfVIRhVUoO+yi9C12vAefE?=
 =?us-ascii?Q?3WJtFpLkfvkmvlyZ5qhAkGUGwdgSRLW8c4DTnswLC0QdDbRpkHN/ebUoFxuk?=
 =?us-ascii?Q?QzcDFapa1B/uzpe1QoIjHUteuDkl5Xgn19Lr4zkY7ZEV5XNNchZ9Tb62Z1H8?=
 =?us-ascii?Q?+CfFkSU5GHnat2IY4b1BCn0rBUaYLD+2cDKDlPr8KbqCLTEeV/E7IiPMVBH7?=
 =?us-ascii?Q?o9wJbXPuJbaYG8LPmziCp7mCrcF7gZLRuEvC5T0LVE68z9BtU93fNx6M4b5e?=
 =?us-ascii?Q?yhmNqHn6PJGUF3lGMazisizYdJa4TwegBHW15mIhhmSrroUm4ayaQDfLYkrh?=
 =?us-ascii?Q?5bn/kvdCd5LaSgwOBIlx6Pxpz/M8whdGGNXnfp8cPORFKvYuPPNcMiaT2d4u?=
 =?us-ascii?Q?vEfbg+eo8/uBPyxwJQrxMBZP04nptXk5NvRSJYWC3/SEmSMnCs8UPsltqfvX?=
 =?us-ascii?Q?vOT36+ElA1kOwzkqI00wdMSIzMQ5Xb3l11qQM/4+Oc3EbPdkoaNINHJNOhKS?=
 =?us-ascii?Q?tKdTaPSsIq1XVYZ1Y9EeMmNbPWdsiuvTgVzOT0zHcGZtA1gs50hZ7ix71YfM?=
 =?us-ascii?Q?Ohqyzv9nOjN5t/vTokdspnwHcR8/cGSj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EN3X12+Hgp/0aV3YutF/RkVx+QzJ05gO2qdjI3XhWuw4Fe36Nk5LSWHidqzT?=
 =?us-ascii?Q?eJEiwdPtNpQpQ7L6eD4P54meB95Zm/Dnw0YuXpBaUzd210mcgB6X3jb1Q6Yz?=
 =?us-ascii?Q?LqJgEgMVTvwSegbxHHT5xp/geqhBf65Ce5MS+5UDAJBC4vDi4qMrqlFDs+u2?=
 =?us-ascii?Q?6Kdbp9CWDmagtUfp2u/gzuGPumlcuiMpuGu9goa+CY4D03R9UcDCBaIj5sCK?=
 =?us-ascii?Q?lJERRh6bj66woXu7cBMGOusKGKi/qA650AQVtIfHl9vPDFYoGNfd2X8+49Lx?=
 =?us-ascii?Q?Qdk6OUoC8YTsJF/BBZXa2Ji91YX4RT1vtQSubYCq72XtlXbBpFt/Y6uj//tX?=
 =?us-ascii?Q?F7Z75K7Q4X77b27E3+YZlBLmDM1tNQwQYrO3o5K0i7aCfAq2WznQ0nSJx+4A?=
 =?us-ascii?Q?yq52tjNOsiGTNhf4iqR716VWsQ6uLUtTKLkeKwveszWBMMcjWHxnJ2NhE3o/?=
 =?us-ascii?Q?LllneyM8KJqtA+eBbgCw1BeE79GDu6AofqPVZhExYGw03JrDcNJtBydn8H7g?=
 =?us-ascii?Q?lMlUsHOvwir4zxoH7wkUZa7d7STVJDCkDjtbh7aFOHtItvlYIOsgd/ycTl/0?=
 =?us-ascii?Q?YmsIcjaeDuEV2xwmISdQFdI5fW362CnJJ6L585O9vsfKWWFqRHj5ICalIl6H?=
 =?us-ascii?Q?8R1CSbcbEWR7eRtT+HLVJV+vHgR/SO8PI4hq73Wz2+UC9bmAK6DrLLplY8Q0?=
 =?us-ascii?Q?X1vSZT1HFnB5+2/1aYpBfcee622Yy73uMVickJ07BPTG1fF1h9uHFEf49ag0?=
 =?us-ascii?Q?aoR+qY8yg5+f03sTJ7bLFxdig9Gj6arzXGnOvURF6H/WcTTWwz40TkUdBF8U?=
 =?us-ascii?Q?xPqHGeTbECfs3XW3P+0N+C7ahCAqOM/skjPGkCFPiD17kB4xtwtz6j4RZelY?=
 =?us-ascii?Q?MU6xzDxr/Mcvml0iXnXJ/5sv1iihIBaiIw0TzOVdOPsLIRNlBNI3KSBJuHmV?=
 =?us-ascii?Q?YjG+chY2pSeRoRjf++6Gu7oGQgJZNBR8WUTz63SOp6MtJ1oF9UpXIDHLDkj1?=
 =?us-ascii?Q?9L34exBDxzHEeDXC2yct5D8tqZV8Jgf7J1MlqPuuTpU9QydhceA+UQSccrPt?=
 =?us-ascii?Q?sQeNaYMGDpNvIlEaugz7yEBca35dVRIbSQNakj7rj1ZG11OKcx+0HmVMlQmN?=
 =?us-ascii?Q?ct78/SRFk9FYVziNd352qm4eN6LZwjJGQUQyyNsrYGrJ1OfItbleQLn+8DL4?=
 =?us-ascii?Q?L50QpTneos60vlKWHgVPsszYPkamAfBaC/92QXOC6iSDzCARP2Xkp70syDNO?=
 =?us-ascii?Q?YS7IFwS/PuqjWm/HhDekYFGk1MHXZ6qyQkugC0hJQ1ZfWAmfrfZuL+nCp8gw?=
 =?us-ascii?Q?C0mYGyrngttTacByEu69h6IrlDQfekRxJJy8OZvwX91LHVtsYHd9yA8C6+fy?=
 =?us-ascii?Q?C6sgVuNhXdEC8ZiIxZb8VF5CdxXCxEAaArbY+UH9hcn24bAvm+xle+84dbfC?=
 =?us-ascii?Q?AK2Hjb4mrAe7cUIyTF2A8R/EcTs6fTdSexjS2gDnkny8VeJadX9eaEk+aCRE?=
 =?us-ascii?Q?0YArIQh4SCa2c325kuBKIGeE3cWGTt/i0ogep2scEm22ykzJ17F1GjlAkYhv?=
 =?us-ascii?Q?pdUiQksHDsltRhjWNv1V45tpwKkVLEoEKtkBUsUF/PCVCLdR9qnLHKa57C7O?=
 =?us-ascii?Q?7rTlbdXLfMMleJvpP9NbGetJB+JhcUyVTdZtYb4RDcJHagPuiiuvvHaSP6A1?=
 =?us-ascii?Q?Gm2oM9QhMA3IuAswx74/yOjGWmx3TMNeQycTsRUa9CfCuKlkfZ1mn7Op+v4Q?=
 =?us-ascii?Q?xCpxGN7IQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931f04d7-7b51-4c85-8aa8-08de52a46bee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:05:27.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFl3YZnORBbAVfenYooJEg9SuJ1SQrDGZfsbhBFnmqBjT8VPueN4pRguTsV5ukJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_050533_482362_86ADFB5A 
X-CRM114-Status: UNSURE (   8.57  )
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

On Tue, Jan 13, 2026 at 01:34:42PM +0200, Mike Rapoport wrote:

> For example mshv intends to use kho_radix_tree to track the hypervisor
> memory and there unpreserving will be a part of the normal flow.

I do not think this is a good idea.

Nothing should be touching KHO until a kexec sequence is started. KHO
calls should WARN_ON prior to this point. If a kexec sequence aborts
then the entire radix tree should be discarded and it should go back
to WARN_ON'ing KHO calls.

Jason

