Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB444CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqAmemG+iPV9V/n8h+jYkf4vQmqACTkxoOrTbQ94G+s=; b=ZUZnbZP9UsXXZ5Jp1lGZkdd12t
	nw01c+j2ZoL+9cd9tuvhFeUV0YrlnL8XCl+1rzIArbeJ2rHG4UEToSAteqIhqvbUYDk3kei8KovGZ
	OEBmDGVDH8KvwlaCNuTmKPMYjTWlyxdQJG/RngTWbGztnTKTpBCVos5qckpQloizs7uv3Ugt7eoqf
	pxAWZJJu0fvw0+FTApgUMU+AEIOoT1ZWS0SoxLXOsJMi2tLV4hk/sYzoBq/UcMQIKwKz996cqIs6n
	c1qyqraLW9cLxGuuqK++gZIwok8ACa0gqV5Al3J1r+QAlckb5tXCakTaTCx4lx5E1dMdl7rijsiif
	UaWk1P7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVjG-00000007wGQ-2jut;
	Tue, 16 Sep 2025 13:28:18 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVjE-00000007wFe-2Pc4
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 13:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db/G7OGnoAGS6XEnc/slMF5v0IM/uWOq1Pz/eZiEZVBboSphGZAll13R7VGzreVXzrGuHkvV+pHF7XNiLd3UI0OHBTuzRmSbKu8bVi+Vjf4tloeMlGtgRnYW3PKVdkS0flZgLdbGrQOi8TTHxx4JB9GTkMaYJnIIjtaUndcAiYRYyhl7ZTStxtzjFm9j+lsCrU46lW8s+NU3htTi6e2iKocfsmTaFXluTp9invM1h+XJFeb9QkuNVKxW9uR75uWiTsuleZEjPYj8iHQ9ClFeRrg4UBMh3ujxv+T1Lgia9nBDSBspv+qiLZ88g5ik3jfvgR8YsnXQzUsHQRIOIVFNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqAmemG+iPV9V/n8h+jYkf4vQmqACTkxoOrTbQ94G+s=;
 b=VqZqNJbrvceUpgmN2xJQ7ExvR3FlDiL47s6aBP+niPAiCNqPB/QiL91KFh+PhyFA0ufhvi5KwDyFcG4Kpk+TSXZBkOijRnZBpOHkeyqXYC9cEwwZWWvQiajdxm5lRvVEXRAB355ivHf3OZtl2LHsdu+7E8QgmhOOGVRXWIi3kOZ6ctGoDSELwNO5lLDPpGZtIIQXNtdnlv2REPPSRN3sTwuXpNJhMUCTCF8n6f/XR0Uw9qhs+gzoQKjqmh8ungMjXllwO1+mze/S1DeWzc9RlaQsQls/Nq+6FzBzTVnxQJEmqVJm8O+SBzQkJCzJa0/xEbYl1qO1OrwxYHUw8AicQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAmemG+iPV9V/n8h+jYkf4vQmqACTkxoOrTbQ94G+s=;
 b=UPGxjoFWv5VxBDr8Daa5Fcm9USfTNSrtCcmEHnTgMKKNbIBIphYacLhdWCNbcK6VSxiywB812hZpkkVIbhUS16fXGtiz1VoHI5GdjsmoskJb2bItc5vlBoS7GRDFAvjNnHxDL69jdFU6nzpplIA9YRAZFmyiQ6lm1/uFdOZzLHHgZwxWFi7A7+jzzHnSGw6IFKPgOmEBfNr+tMgDClsVJFCnDWsAN+Tfm9JJgC7HCNHm8j1AsOWH8pAnMwwWgVCgg3pBHaYMmjpTYDwLBemmopXmxrgf5GrMVsKOpBUGTXnOlzRWUNKRNi79OtEtBz0btRasc0zjk1HQ/MfxePFskw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 13:28:02 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 13:28:01 +0000
Date: Tue, 16 Sep 2025 10:27:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Chris Li <chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <20250916132759.GC1086830@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
 <aMGc-ExhkqwAyY_C@casper.infradead.org>
 <mafs08qimjoez.fsf@yadavpratyush.com>
 <20250910155546.GB922064@nvidia.com>
 <mafs0zfauh6to.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0zfauh6to.fsf@kernel.org>
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b5c9d4-5a6c-45ce-9814-08ddf524dbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdOoroLaC2GizwzE2aTw+lpQcCQvdw42hj1nww01gAIl5QMSRgZAxzCv0xLe?=
 =?us-ascii?Q?GZnHQGLPK6h+9L91+2BH5Wn8itbykUugeEc/CVKvdicXlz5j1qk0ba01Ba/3?=
 =?us-ascii?Q?QztQKtogbehz+MMqBXyhfQmVqpyYp42ioiubPVtZC4VPn/LFAhT8hVLJ8NAH?=
 =?us-ascii?Q?loZQGMreuKVHS41OBCt8VH0g2Ok0jKsa+49Gstf3ZtF1/eRaKo3+F7QurBcH?=
 =?us-ascii?Q?o1iNAlvZLKmV3WF78OX7+NMx+zGIUdd/5PyfPCaj3gY0aXSEw/+UNVuj7hOp?=
 =?us-ascii?Q?WP94DDrAbktHJwceAxvXkTwzRyOFpRgSEyxCnKamosszXZa/mW6fjci2vQwo?=
 =?us-ascii?Q?rLOlXttArHdwlbI6jke1WhIL33l7xgxEatphK+McCpZMLHtEHA6C+yLH50fp?=
 =?us-ascii?Q?/O6GaQ/2u6c3h/gKrjApP1in4Llj4epLDkDxNMaJIQ11fM8FMD60/y3HHhgD?=
 =?us-ascii?Q?3zbd6W1FUKfkbgJg8I2vtMeSWUJk9fnRefltaoLL6r9Wb0Wq0FI98hQ6Sq3A?=
 =?us-ascii?Q?xAjKomzmuwAnxHrfqRIkQsreuqxmJ+6A/U7Is2rluDC00pVnFd7+HB2LVCUF?=
 =?us-ascii?Q?sGECZW+czuB/wLnA0g7adyymCgkaqRWuDi6+p7ZZGvrD6zGL2/3DM29+pwJq?=
 =?us-ascii?Q?9wNppm6ugsznb8SoOSuaFwgP6VUHJW9vCImJNb5u3GIWlEOPfd0dD2JN+NI7?=
 =?us-ascii?Q?EPBP8t14+ODepRO1wYWSQESr9yEeWTHehON9ykxYzuzNkPFFFV9Obx0cOtZ2?=
 =?us-ascii?Q?AIxREtie5DztS0gRCaHm1slgo92QDjfHV/TrZnXHiDauB7QuCh3foGAAUSal?=
 =?us-ascii?Q?1SquTs8rRDMuaA1TFgpgFvJqawKhT8YcbbhA9k+DrNig4/RaAOCmpm6mF9GB?=
 =?us-ascii?Q?2my30Dz6qcRGxtJ+bXiZ+i0MVazKBviLjwmw/GgIdbcis61TRz264ffPI90M?=
 =?us-ascii?Q?r19+CNTZxmclxLI9oN2SR/MxjTLdhOA3l+uQ3tksZtm8LbukdzH/RtVBfk7A?=
 =?us-ascii?Q?a7cscjBiQOJNJhUKMH0sC98EeCwXtho9d1lhChEkk1+onHQf+3ao2MTHN+Rz?=
 =?us-ascii?Q?oIHbynHgHayPl8V1rzil8EDNFJUmp4V3Ri7xES8Ht9v/feOLmlY45xoYw1S/?=
 =?us-ascii?Q?2Xpyialdi+Zd0z1cON/jE/wWiNhAYeE2vyKvpCSU89gZM6JY3O2++eB0uXMh?=
 =?us-ascii?Q?k54wejyteUc9tQHR/EV93/Fh3TLkOE0vIMnpXEYumEj2dGrsYQwCnmF31sYj?=
 =?us-ascii?Q?JKxFGv0yQVd7uGUrS+Ns/p4GyWSDLHMIDh4BWTblv1TLDtqLN/6syVx7AcxB?=
 =?us-ascii?Q?z91QGt9i7C3FQCzG44BAf0Oj5LtLB/E4BiBx5zD2gOJgNBWQRitXLDj+Uy6/?=
 =?us-ascii?Q?uMuBth02ra/Gz0z5X4ocaiITL76gr84gy1GDtE3Mn37uBipnLOvyBvqlCUMr?=
 =?us-ascii?Q?SPWXVjkD7Bg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sds1S2/WDkbR7TUGmEkgycUfDZ0AuKAMLukEr5muzpNStpWY2OBK4sQNHfjz?=
 =?us-ascii?Q?zlz6Ft3EbEGFiicD6lp079oe73/r8pnvSMw47lbzJv92IBZdJA+JOxgCaJDj?=
 =?us-ascii?Q?HoAhchWMr6euhsZAG1Jd6vbxLQwkz3w3vfnSE2NTDpinzN+KYO6nkDVqQAKq?=
 =?us-ascii?Q?ysVTYFpp0y8xe1ZRvdfvbQ52iW/cSb8H6cbx2gs4pFj7X+MScA2ErmkyoikM?=
 =?us-ascii?Q?DygAvmzGVxvYt9GxKZSKMrif6PPulFpEGz3LGxAgA4NsjJBK5lgMVFmKwLwy?=
 =?us-ascii?Q?znlxqYMHY0P+4pOGw+XJEukprerw6exvc4hpUtIc+LnUSatCfj/PdJKRpXMH?=
 =?us-ascii?Q?OE2F+x97hq3KoHScvDysSx6xZvdueuHUCq/3bDHTkN3N9fCFePA8Fln3w5KF?=
 =?us-ascii?Q?yRZY5uD9dTIF7BV0GEg3CHMq/nRc4uwtS+R/S6U0OHAzLwekhrDZW4oDOzsp?=
 =?us-ascii?Q?xVsBddClLz3rHsfJPHLPas6qYWnuK+M0gNWVO84oyunLPbk0CwydmRIcVNsV?=
 =?us-ascii?Q?jfhQAnKtLDTiO6kQNS0VLrxI6C/yti+gJSXw1/yd6KxFHBKT57+H/lvxFYwv?=
 =?us-ascii?Q?KfxoPo4Rvx58P7Y2tH07RzJAKWITtg8R3fq3Z0UAkTYvXoAmDU19Z7CFwlj7?=
 =?us-ascii?Q?o3ZNedqa6Do28nNq9D2a/7rUaM0M++KtYZzYgmFA87wvkc/6UpLefogMkMYo?=
 =?us-ascii?Q?MWmAic4FvUTg2lbGhDTgWpHm3aTVpSTq5DHjooQ124K1dbMKLbiZzeXPQsYp?=
 =?us-ascii?Q?xN+WS6lVyi0w/XwiKSuYDaFBUsNkXrPcjDBjEYQtB1JsmNd74vZYOYVEKbsC?=
 =?us-ascii?Q?kGqWxdNhd8wOnIUs8xBVWgmBuzCmYvyGPw9w7LHGx4y4srEbobCHV97PDhko?=
 =?us-ascii?Q?5xbb1Jnzn6JoWMu40wHvBsl/9QMVONcGIdsTQMglkQiKnB3qRbGWtRVaQPYN?=
 =?us-ascii?Q?MLm51x/Ppxy10IdqVTI510IjaRODA/LpJv6AeTzmCac0jAWq3b551Y1yGag7?=
 =?us-ascii?Q?Pqk+eXE+ChvB+gIqNFcuHXI+XJUvah15vcAkpEguL1yc7PT4evd6SfzsNkcJ?=
 =?us-ascii?Q?z0O+fsJpQ8UldcAOSuNt9dWTEruwxKqg/cMODQXyV6W3wI3qvRKsbRcwF5Ea?=
 =?us-ascii?Q?axYsjwP1p/CCvU2kTzap/anWWeiPyZu/UVaw/fTvaoXham+IU/BNt0H2pK4W?=
 =?us-ascii?Q?oUerYGDW2Vl4dygwsAtycyRvCgVhR6QqBtN12TT+acxPSncq+L7+9qVlpxy6?=
 =?us-ascii?Q?XBOQlAhNc9wstJiGZYmURdvKwMQCWqxPooLN8YlTsJHDVTRe6gZevl2PeUR1?=
 =?us-ascii?Q?z1dDL+o1RgaTKBgcjSzNfXGmgqglGp2y35nDM9PGdDA4G2WE3Ozqff9lDvB0?=
 =?us-ascii?Q?sQ4nBJcdrAt2t9PVkMf9BCfRYCKyT3XqdYf2WBi/kWk2fZ6zySWo3Dc3Ug+5?=
 =?us-ascii?Q?n2A3xP874Na6rxJd3c77Sg48oOBJ5MvtbWH9EPI2koH8RbN2o9gQoAKsoWAp?=
 =?us-ascii?Q?WlnXX0Q9Tdf0reFPfkYs7ttE4jbhPI6rplOe2jNFfleJyU7lB7ph04HyYsnE?=
 =?us-ascii?Q?sz028wSWoM2q2Ga9Z4hmw7zrE8fkBK490mlZK+aH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b5c9d4-5a6c-45ce-9814-08ddf524dbd6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:28:01.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZOqv8VAm3SO4CreXmUmuzL4tCqgS77PsEFDQ3ahABrvXYfbX2SO4MATkdYQrDxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_062816_610740_D0974334 
X-CRM114-Status: GOOD (  19.96  )
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

On Tue, Sep 16, 2025 at 03:20:51PM +0200, Pratyush Yadav wrote:
> >> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
> >> >>  struct folio *kho_restore_folio(phys_addr_t phys)
> >> >>  {
> >> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> >> >> -	unsigned long order;
> >> >> +	union kho_page_info info;
> >> >>  
> >> >>  	if (!page)
> >> >>  		return NULL;
> >> >>  
> >> >> -	order = page->private;
> >> >> -	if (order > MAX_PAGE_ORDER)
> >> >> +	info.page_private = page->private;
> >> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
> >
> > All the impossible checks shoudl be WARN_ON()
> 
> The mental model I have is that the place that introduced the
> "impossible" situation should get the WARN(). So for an incorrect phys
> address (leading to magic mismatch) or incorrect order (say preserved
> big range using kho_preserve_phys() and restoring it using
> kho_restore_folio()), the caller is responsible so it should do the
> WARN(). Does that make sense?

Callers should not pass illegal phys here, WARN at this point is
appropriate, and maybe under a debug #ifdef or something like that.

This is to make it clear that "test and fail" is not an acceptable way
to use this API.

> Actually, on another look, this patch implicitly makes sure that
> unaligned phys always fails. This is because deserialize_bitmap() only
> sets the magic on the head page which is always aligned by the order.
> For any unaligned phys, the magic will not match.

Makes sense, maybe a comment?

> Makes sense. Do you suggest the magic and order checks to also be under
> KHO_DEBUG, or should they always be done? I am of the opinion that it
> makes sense to do them always, but I can also understand the argument
> for disabling them in production for better performance.

I'm ambivalent :)

For now I'd do it always and leave some debug optimization to a future
project.

Jason

