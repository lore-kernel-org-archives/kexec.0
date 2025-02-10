Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51C4C0219D
	for <kexec@archiver.kernel.org>; Mon, 10 Feb 2025 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQVpb9OTZmhraa+kfIuJy5NEAVfUhEect9/mWkie7vU=; b=xkA4JEDC857Iu0F9kyA35BxbtJ
	pNRCePXpW99awkW6m8R5aC80Br563YczuCINq/sT0bdu7PuJqC6S5+np0myMl+MSroGxOcbzawGpL
	esOEeOKoRmW18tAO7h0ogU/1u1rtpJus5waBMS+yR40npNJxWpGURB81Cz4RsRFSFggTMYBWg/bH/
	QKwZDv/19x+rbrxCLeGWh8IJdYLF/W926NDRsGuLf+OfM+00N/EAC44dV4IyeN8khMTd5Xj8yn9MZ
	EIZdoFlEnWF95lD5yrbtQWsNTyLmky5a5N3L4F7cRvryepummEnmfXU1nSKuJUVj1L65yusPHvF0H
	y+2p/xvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thajV-00000001PDt-0sCU;
	Mon, 10 Feb 2025 20:50:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thajT-00000001PDP-2FbI;
	Mon, 10 Feb 2025 20:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XQVpb9OTZmhraa+kfIuJy5NEAVfUhEect9/mWkie7vU=; b=JA1hxdZ4ef1F5D/sNLDijbODXl
	Y53poe/YRLINj033kvKBuDwREULfB0n79veLVG53JE22x4Zh9L898sc05q2h716haeiGfG/jRGYvB
	u0X55UIjDM1+sW1BYxWV0VXi2KCNl6iu+Qdw3yMz84M37OKXVVvQE2UoaBRsrWVcSIieZLkJ4Tydt
	zZyuno0xGz81JlljeyQbj/YcVOELE6OO40NWJLO8gD9DMwnpXJZ149HJm/d7L3mgWQMXv/btM9VVU
	gTu+zOzoRV0qSDJp4cET6thIndyNhndzKANtAv1srLRLjOYdquGHvPobewtFcrTQvFfU2D+4nBZh7
	AvM7e+pA==;
Received: from mail-co1nam11on20624.outbound.protection.outlook.com ([2a01:111:f403:2416::624] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thajQ-00000000FsH-0x1m;
	Mon, 10 Feb 2025 20:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk4HWCsePLQundKNroh93B56d7u8z2s9kPceEvlO6hQGv8PRCpindludVjYWtiDc4q4L7L6IIaiHzVjtzbxBKnduwP4kDZkZtuLwhKBE4OTFDReWHk0pBc5LAnz2aj9xe8OiaH14w5gBg2yv2pRiU2R5QNh6TEndGMNxi2GUv38EePgkjaptw/w28AWkIWxdZRla9rKzV/6HcCa4+kQT5Rixde5cReCv5Lexfq4Vfn7j4K1WhdiDmKq91vbWsWKAie3MLBeDSGKq5Fdi23bQdfc8gOktcDpUKF6qRY4Dr37DmXDve5IL+ykqee4Bf6Yb0joB8otgiZEKjjCKsYbalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQVpb9OTZmhraa+kfIuJy5NEAVfUhEect9/mWkie7vU=;
 b=H+HhPAsEGOzmnx4fwYJK+961Ble2Bk2tWVmQnYCZHTpNOmZ70jkjPotQbhxDixyutm0939qNAov6QlBXT1jjUCW2Yj7leVM5xyOpKgnfokIsLArnVCgmUI3iOM2NODzlxE3LjAELFPffpL7n6GeF9BRumaQtc/APdhVhxeRnxHmZ9myf4qOs8orSB3FZNL0ss9r0hXxBEHmnI9FtX/kwUxk2EzbwSZ5adBjsZaLLFJnnul85rrpCssiFdCwGzLXIvukGMi33CHjYYaDC+BA5xPhkPOSMv+q2t8qIORXIfO6UsdLqW1QP3nXqWxtFN53T4aQ+UIQP/UzhPsZ4Wyoz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQVpb9OTZmhraa+kfIuJy5NEAVfUhEect9/mWkie7vU=;
 b=N4HmCJ6EoKNwhLwlUBJsJmDPdHA7V67N7l7Q3DdZTeg2IsZkjMK3SZUKTP6WPgi1m2M7MjjeU4j/XvuVY4m4pmATb3N8EkDbAp4U9/S9WjtOBSEQMvGcqNj74u9sX9PYJ7dIzKs+dgS0z5It7+dls5XoQH8rBWZgRL3latqnqdwYdzcZ7L+GPlUM+KNwT9QR/dUOa69+zEdHoik+u9YCwjzPge0OquiWNZFR8NpWCBbZZCooNPxS3DqOjAU9ChHQ8nhOgkcqPVREZOkAt5+9qCzIUXrDY6ZQ7B8PWy5bjJ3J2WEsQSXQx7YtWPtu/H4GVK4O99b3qhUDhqMHesy5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 20:50:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 20:50:06 +0000
Date: Mon, 10 Feb 2025 16:50:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 06/14] kexec: Add KHO parsing support
Message-ID: <20250210205004.GD3765641@nvidia.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-7-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-7-rppt@kernel.org>
X-ClientProxiedBy: BN9PR03CA0723.namprd03.prod.outlook.com
 (2603:10b6:408:110::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4782e0d0-72cb-4a5f-6e8e-08dd4a147f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xF0E8eKauvv7t9NJsXK/NpYoSuoE+6pTBwZOA747IFkEU5ea4VwR1UI4fb8a?=
 =?us-ascii?Q?vxLnzlMOiuHyU02AfYHekfqhNte25s6B49F2Wln09P8JC+MNeBWrnxFPybDR?=
 =?us-ascii?Q?FhlqCRaEfAzrnLQYu1dxJLVQEX3MnViKLwlu8cv8vQoeWPZAR8+yrzemiMSi?=
 =?us-ascii?Q?jKIx9CZjvQ4F6peQT9yjEbL/cS7HLd0e7sihqynm3zay5fdo6/qanxeuKCPi?=
 =?us-ascii?Q?RbE64qK9zAKpPwTRj6ObkCFQN/VWClw7cFvMmZX5ih2C87MykiZXS2E7LBdZ?=
 =?us-ascii?Q?JyVWCHIeCKnriK/p0Q/3fq+n/t0eY0afl0UhkOLd/mnft/r7Rykgv0YbLjio?=
 =?us-ascii?Q?JOTZKlE1/N4DzMROojKcg+F8qsoyEh/JBbn4jVltffvImxtSO6nNjmgIHHvz?=
 =?us-ascii?Q?mKUqoUBmHwFBmKlkBwM31bBr4cqE3YGSOlt91a6eETHDb1TyRjc0v5VrXRTQ?=
 =?us-ascii?Q?r4Lxo07gUmHRpui1ABtYDRH3l6xUvVN4u6hGoBJT2itED9tT6n4H97O4OIfC?=
 =?us-ascii?Q?Z1vp9LhlGUcNkOgEwIwZ9UaPdVXh66dBQO5vW6A8OFf7/GRvArs9i5t7K4O8?=
 =?us-ascii?Q?zuYs7qBbRm0hAKzEgh0UpDuqsc3IsQ8qMb619rXYQPPQBRiVXCFkXcLuLUF3?=
 =?us-ascii?Q?uHF3x9tu9zw4D1jjljsSTnkyx6uub2BCYYNSNXUQjLtgetHDoi/EZipQlHMR?=
 =?us-ascii?Q?gobKWT96iuTwlK2VqEvOcRD9pdEdvoX+nXIPxPNUxrcwzJy+V89eFP8ocM4p?=
 =?us-ascii?Q?PPqsO3VuwVUZf8f6jDMFw8reG73iOiXveyidaIalRJEJaiwQptQ1tNYb+FeH?=
 =?us-ascii?Q?GI+oLJ3HIhb610IUiZZvlovKh349zCf6+Bs/FDC1WPy35OeT0qCBo9JuZw4y?=
 =?us-ascii?Q?fd28ivYRAW3zby/3wfPN5Ys9DoXnNwaR0A6kBZA4P60qFOGynHpbsD/4BWsV?=
 =?us-ascii?Q?BQQAV/1gbgGD8c0Sq9A5cq1q0aqCUQhv15Xq9t8XGBtUcYV75dwR03wLvfey?=
 =?us-ascii?Q?UMzHRdR1lKoj65ldK7tRR69aUrz89GVb/tPPIDM87wVrZO6NUuxY0WMoodtb?=
 =?us-ascii?Q?2uSgENVtg7A3xSMhito1V+YYRCTEwBdLxWyfVavickPC6YM7O5xZGb7dy0im?=
 =?us-ascii?Q?3cClPp2R5LyVj+/3QbFdEwqDvuIe0oGuVMsn+qa7LrYAHpPgpOqqQd6rMhKC?=
 =?us-ascii?Q?JsCbKRPcVvk59ePth4EszgKGlbRDcFPo1Qx/ooG9A0ixOewUDm/cxfUGxPjR?=
 =?us-ascii?Q?+IIi1koAf69s3GLMA6NFmoy8sg0xE1kH8f7DsePEAS2uOVkOK9hKbqhnTZoS?=
 =?us-ascii?Q?MkgKEq7WX29177fend4jKkhADGdo6LwPL6GDGNZ6w3sY9RjgmSA1Ypuweepp?=
 =?us-ascii?Q?kSnTVTNL/maosyj7r4nR18fDwu3e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IM2Que+n1ergSLFactrdE1/JaQLkqeeLRG4aCXi7HW12woGEKi5r5W4S9kVq?=
 =?us-ascii?Q?SC4ackgWq/PUMK5T3eaw0NqE48dMiHYlJLNo5qkjZOgTnqn6PSO8MqHrSJbk?=
 =?us-ascii?Q?Od2GaBW+mNZrQSfriSeiODqOAFWbinsApVqf04c7jINYd/9JMy83/53diH5L?=
 =?us-ascii?Q?wpsK4hIJwYc1tOJt/u0PTTi2NIWfb0asgnwX+SUuleW9ccxWlKJt4W0UxgY4?=
 =?us-ascii?Q?+CuPnSoeY9zhFKRaOtEDIfsDKbMkAX85MwKupZNNBsIBvYRitLazaSUzsENj?=
 =?us-ascii?Q?BJirZkV8R0AAowrf21iMF+yUAxxvZKMhDuTOzeK+J+dNEOSHsWbxzguIjDvD?=
 =?us-ascii?Q?e1/cgsioG7h1l6QHK7s5bD4y931euJm0OgJ+db6xfr6mjqFPIs0VUY2N7O6T?=
 =?us-ascii?Q?sbRrnM52d/wriv7Acq/Nj2b3frGXZPg4K78p0YGHJa3xpJZipsJIlPI5xgWk?=
 =?us-ascii?Q?8fPwCnfex8Ov9dBQv6ZZOcIJrbKO3U1oP2toBETueL3O+IMZiBaBMsGM+MFq?=
 =?us-ascii?Q?xlgejOzM+HOY8vnVLE3Mh7Lmd2JT76ptQT7z++cFzEKdOKNt9PZ1Y2+sJDFV?=
 =?us-ascii?Q?Rrt2qdc6mooJ/MZjTiV/MPqfxkauYncxjNL7tqmdY5Tg73QJtHmU9UAM7WHQ?=
 =?us-ascii?Q?0OCOwF4ZPu7sPeDfzT5YxX2WX6egkQsFrh9kIhfBuPUad7dCuRxQcE5FOtlQ?=
 =?us-ascii?Q?oAugAHiHXEPVyeeYl9FYbi7kUCQrDFKjHpDyK9R0r1yU1h9XA6giSOYDGUpT?=
 =?us-ascii?Q?wKRZeg7UHK511KnCE17oWBQZZz4cYCeFH0cUU6xG5upgwHiEi5GOowPUZl2h?=
 =?us-ascii?Q?3Gfnqk5t96Q7y8IlsSnwriMmC0PXJfz7+/XK4NIVrX30QUouG8BoZDswz8oV?=
 =?us-ascii?Q?g+IQOloR99wJR2ogAIk80uE6Y4FjJ2k3yZX8uq/oAEGVBtp8x5OmPLg9e8OQ?=
 =?us-ascii?Q?u+rB+Q/vFSDcpZH3j7hyOhq5D0sLGjoYqXEnuJtRlP41Ei4r3j0rJ/xSxD+H?=
 =?us-ascii?Q?yJbDUtfuk8yGNNxfgQADDS+/Lj51rFO80T9dUcBVpf4fli00KBmwDV7iENtx?=
 =?us-ascii?Q?CHo6fuzchT0NfuhO+9ETQMOKYy9t/PqF6rkrEo+NoEw2pI74aYMVcPrS0OEA?=
 =?us-ascii?Q?5e0snoCUagqt0SJoBJvjJWo6QCbWnnjgdW2b6h4+YGZ2C8GLjYq1RyEoLFrn?=
 =?us-ascii?Q?J6JYhU3+gXJrU345/XvKTS2GHvN1Anf5P2RjgaWrzo/mubjUZa/nloMrZD0C?=
 =?us-ascii?Q?iljTXSLS0tPjY3hgGFkqDylCac7eUSbgp5/m3RkuJSWONQx6ROTc6qoxhgN2?=
 =?us-ascii?Q?QMbPVzC+HQWDSrAspfDBWazCVtU8KIOu/ZnE2MupDatRBMJ98oUttZdbhE+3?=
 =?us-ascii?Q?1xWI+6hXfOPUzT/CfBsdd+LDf0iG4n8V6RMUV8glBO3fVC91Ajl4fYFbqCeb?=
 =?us-ascii?Q?rv1nSqBHOkW9vTV79E4dgkkRTzgEGYUIWe+eHZW9jHefYrgHApER5IHxqh4G?=
 =?us-ascii?Q?pxWzDLxrBQli0O8xWhL7fhXdfq7LAh96jmLpolCgO6eLfzO9iL+SxBB4HXvJ?=
 =?us-ascii?Q?5nETHD2aDkYuJFeU9zU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4782e0d0-72cb-4a5f-6e8e-08dd4a147f8a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 20:50:05.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCxLKEJNC+tXqjCwO0MEqCKHLGm+ZpscrMWOYoGj/rTIa4edl54D9yAdwCdYjptg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_205016_435674_6F4CF6E4 
X-CRM114-Status: GOOD (  21.86  )
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

On Thu, Feb 06, 2025 at 03:27:46PM +0200, Mike Rapoport wrote:

> +/**
> + * kho_claim_mem - Notify the kernel that a handed over memory range is now
> + * in use
> + * @mem: memory range that was preserved during kexec handover
> + *
> + * A kernel subsystem preserved that range during handover and it is going
> + * to reuse this range after kexec. The pages in the range are treated as
> + * allocated, but not %PG_reserved.
> + *
> + * Return: virtual address of the preserved memory range
> + */
> +void *kho_claim_mem(const struct kho_mem *mem)
> +{
> +	unsigned long start_pfn, end_pfn, pfn;
> +	void *va = __va(mem->addr);
> +
> +	start_pfn = PFN_DOWN(mem->addr);
> +	end_pfn = PFN_UP(mem->addr + mem->size);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		int err = kho_claim_pfn(pfn);
> +
> +		if (err)
> +			return NULL;
> +	}
> +
> +	return va;
> +}
> +EXPORT_SYMBOL_GPL(kho_claim_mem);

I think this is not the sort of interface toward drivers we should be
going for, I think we should be round tripping folios at their
allocated order and when restored the folio should freed with
folio_put(), just like in the normal way. Here you are breaking down
high order folios and undoing the GFP_COMP, it is not desirable for
drivers..

Eventually with some kind of support for conserving the memdesc
struct/page metadata if a driver is using it.

Following that basic primitive you'd want to have the same idea to
preserve kmalloc() memory.

And like I said elsewhere, the drivers should be working on naked
phys_addr_t's stored in their own structs in their own way, not
special kho_mem things.. It won't scale like this if the driver needs
to pass thousands of pages.

Also, how is the driver supposed to figure out what the structure is
inside the kho_mem anyhow? I would expect the FDT key/value store to
have a key/phys_addr_t structure outlining the various driver data
structures.

IMHO this links to my frist comment on how the FDT represents the
preserved memory, it seems thsat FDT format cannot effectively
preserve folios..

Jason

