Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6036CAC597
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syBWTwmt6P5aH0/i2V2dwd69o7iS75d4sP+iKdWKHDM=; b=PT7DKBqumID7KAqnmkwqeEyELy
	+MIr0Qdn2NiZnKtTi0Qh0h7m8ZA8dN7GBASkku4PgzOOI9IUDi+LlONLEOggMrHgM/ZmhBGwlHqXs
	XfjClQrIKjh9dajZBw5cAh/+v51bfmxoBYDOPTHQl2Mg1q637mIOhXUyXDsf4SpdLSKFDwMCQPq7+
	Mpwv9lI2qtzm/Io0yotC//CoLMuESCjbJqQ/AjqWcVt26lEV43dxJi9r8mvr1V8TB/17x74tOLXk3
	3KhIY7VZ9bCya0StW3u1UC3t8txRCiSmrC74vRQ7BvXFWCJJ+3Z/hxmOQ2/+QUqaw3tQ1xZEW4+1z
	3L3aR01g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyAQk-00000004l7H-27kh;
	Mon, 15 Sep 2025 14:43:46 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyAQi-00000004l6E-1DJ2
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 14:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYMilND9wxwKmIJWOIHdXlprH93w+OHyygV4YaATUaCYYrU2uXsmSEOQjtvhMxLV/TOcAUUB0F51xR8xT+sisRhL+OdBOshFlC23aPMhiTyR3LhDnukMmv5P7l5qbKc8/knZ0TQvkYtsLj3ADV4spzlnKALOMVgCQhk4dCXOOsee12QXrka3oF3sF60JsYjp/QaA+4HOBxJzBxf4lFQxkhG0FUEu3i7H7ZfnZuZ+ULWUVGvJcftX3zO2CnhGluJP7n3AAztAhGRnaNoaYY1B5oVYxOqKTVdpotFAMWi2hDx6AgX++77eL7U5tw+bZaRBN3lDiUmEL43PBi1wBX8Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syBWTwmt6P5aH0/i2V2dwd69o7iS75d4sP+iKdWKHDM=;
 b=o/CIVHDRti6IBtkcpm1v8jHoOqpSbw7pBYZnW0JkxoUWCt28bNrR/SVOS6s15kRNUF5qv1Hi4OmzwxYJRZwS75ZCTNxQVzuS4AWHv/gIH8igAcZuEaHHJkXNtTylxGWdZtPRN6dDxp58kAbtryYtjKJpoJ7ZH2Oy0Vg6d7yQw5IPWrO5NNhQkKh/cxxhQ7fZDsxfIoFQFw9vOVZiCQH1fSWIb30ZA7rcZVUl0eehxcBHXwG6je+lZITLgIFfPdV8vNgV+BYxVBXAGlTeTo9uO2vAhYo7pRnVyPash3zQKS31LM4qeg6eMkYvFfpiA0bpkth0hgJfXarbTeQUUaQKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syBWTwmt6P5aH0/i2V2dwd69o7iS75d4sP+iKdWKHDM=;
 b=uf7yejLjUz5G70RRt5DxYoOxdDWwb1grsFTdOPRnaHhfQLU9Awyr8dBtgZmgfeX1KfSQm2mVBEia6PRMnQT7xSas6+KYDYAzns3pqAw5o11RV7DHzMMpVSWZRl59xqzOyIG5teoIMt9TeGoIZYGaZt6o8yIKsq4Py1hzhu2930pjRr6YeCuiT3pe75ZWYd+6gjo4a9Bgbd2AsLb3TlntT03FcUX4pRkIDtjsMHm1zfhihX4BTOjiWSpqzO+Dv2lN9/udMuVt3WeET60wxkdDGhXpkA3Y0UPz+ZfeI+I1va5EAXji0lh2XozIiXztRoCiWOcsuzhONzsok+RfSm2q3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:43:37 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:43:37 +0000
Date: Mon, 15 Sep 2025 11:43:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250915144335.GL1024672@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgey9qEC_XUejXm@kernel.org>
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c06a8f2-2b1e-49b8-7c0c-08ddf4664105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FPD1YizLW/OfSAISNieC+tL4qb72pMVXtetQ/rAP7BnnjTADmllXBrfBkPnL?=
 =?us-ascii?Q?2JgqiMjMR9wjEVeX/TAsgFktQ6Q3AsEtyOYHO5/V31hLUR97ncFRfAk23che?=
 =?us-ascii?Q?VMVAL0kbXTjMYjZ1kFUMH2FaJKvyBWrrgSgjI1UeTsHHxjFJsjNJu3AHX2er?=
 =?us-ascii?Q?Uml1mClKbRN06jxRj+JzPL5VJzJ7BACAa0ODjNIzYKBmoCJE+E3DTprwpOq7?=
 =?us-ascii?Q?4GNFoGhSOiazzHsbnfcKaIi9tkKKNmtUnykzNKqt4xui9fLxacg5f64Wli4S?=
 =?us-ascii?Q?tPf+4hcy9BBdjJlgfFXrQ0UFdLq4I7uCk3MTLr/B5xtUj2Yfu/BBEjDiT4/o?=
 =?us-ascii?Q?vK97L9E6md5PPqfvMnGSBpYmZ6Qjx+hYe4U6HYTJBZ78yeW3pD9WEWzCYul8?=
 =?us-ascii?Q?sDj3UzB87HdqZ6nvsTxY91L3XiBD1CaVLcwsMlr26ZnLMZou1t2D0X+a4LgV?=
 =?us-ascii?Q?j4rcljPGSVQGDnvWxFklC45hlyjvD9M9FKYG7iK37xHSf6/tQNlHkagHWIFA?=
 =?us-ascii?Q?3GaZhFCS3xBUv3V4xCfdkYXDJQA9tYckibQL3ZdrKRIQvwNyRfq76ZrCIVQa?=
 =?us-ascii?Q?WDeG4RNsCdp6rhXE56DjscD0Gku4OmS7kCimXpYz3tZtrO2Y+kyAtwV6WL4f?=
 =?us-ascii?Q?xbQ9j6YEfEcxnBDU0dlx9V3OcOxX/YVEFkkcPm781BojYNtJdOBi1Nfe9uZh?=
 =?us-ascii?Q?pnR0CF/u0QLteewekES9vXp26y2dBtDvceoAAJ9S51n1x6q4dC2jWoToo1b3?=
 =?us-ascii?Q?tA14o8Rn8gH4p3rh2DI/Pcm04rxWlzydKyI5B5t+5lkeo/LPeYP00injzG6z?=
 =?us-ascii?Q?IhWxbNKZ6798YqRI3CWVQU6P7y78uTQeZu63LCOQltCYB59y9QStwbVbkvKs?=
 =?us-ascii?Q?T43tTeMQNLjW/qpK/pKRNswlyWD/oCTGXJO1YEPPCnGmYnR6NilFz5Wh0B79?=
 =?us-ascii?Q?AOs29clFwb5HURdXi9z/96cUgzmg0qWKle1UaOkJfJonvCnnlx9m/V28LtUy?=
 =?us-ascii?Q?4izwOt3+ph0NtA6ykQaR6tuuQ0y7iXz4LZZ23FyTtWY41HH/RhWLa+8aqtsM?=
 =?us-ascii?Q?ksgZa4uibySJKhf4Ji302yYuhb5V4F1Y/dHwhfDioKvriA2hyVG8AkCewT4n?=
 =?us-ascii?Q?PZMvW/kMQMoWmBIDJy9rkXZOnl6g/JDjW9hZSfa9z+HjSiaiwxzL2jqEXmGc?=
 =?us-ascii?Q?AKH8ceGho3NhQTPauwgcsRj5zm5fUDInsuDSyKDlNRflexblzjqOQdvSIc3l?=
 =?us-ascii?Q?cZWQc3nepBSfiRpvBp52ygX7OxeTePsAioxnzv0fMdTB/Fj3Fc0qgfSiHsl2?=
 =?us-ascii?Q?7jrO18tMvINpvSCkoX2I/ykQvaDH5R8CapNU6sMGFJA13mkUFA7pBnFDqlu8?=
 =?us-ascii?Q?QwGoIsGJ8PrZfZ/L4W8n4wY6WAqcJer7PKN6maq9IpL4pWfanho5dIu3CHit?=
 =?us-ascii?Q?vn+3ZouTrio=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaeTn/ujEFBjg3uM4oV9zY2kGLP/qOee7SCI5iiiST73VG1YtsOLwtxyKVfs?=
 =?us-ascii?Q?emiG2b3iBugPz5HDuBMCDsWccnEtXR/vGyHuNfKVZv68Y8a+pfPeoTo0TSmR?=
 =?us-ascii?Q?iu5QLOL+JkpuL+rgZovKck3fX/Lsjxe3zsnmcsmCUKpBQk4sPrfgvODvZRyM?=
 =?us-ascii?Q?PYQksLWLh1Zd3VI42hzT0DDHMIM97bCOUAIsOQV/JuFYi7UKWBGzze34IOaJ?=
 =?us-ascii?Q?ngBxVKF8fPy2Ms7OAkj/JwZsQqB+4XQqmofQ+cu+RibYW5BhhLZM/ngPfcRy?=
 =?us-ascii?Q?ibkNNJo3Q5oAFF9/LerPrJ3coXDY70nkKCAdzjqwYVAwifx5Ix0obJR0Tms/?=
 =?us-ascii?Q?Esj9H9pvlf7GI06iOulT3ZYoPoaBA1zMrIVNH5Hi/uiGLs2F5ItJgKwvePbw?=
 =?us-ascii?Q?ImCSkzKXHZXzeL5OBRbJ+hJyFp5lzHFlSPPuTERvwL4YfS6OAF6gLYo8l9sl?=
 =?us-ascii?Q?yp+1zOynf2g6QHKEpduH4I2pONfljl4frjU/nXPHWgz6J4PXIl9pzGKWNquu?=
 =?us-ascii?Q?9jONS4/+D/HYgIqcsL//zK+yY+2aWkS9GX/Y27+I8gZS+W48lwZMQ1ZF4Eia?=
 =?us-ascii?Q?bA5ln0slKYKWHl0jXZOAZvupU3A0j5w8VLwqiXRpSoKj+9dz8NdWEwEZLgsn?=
 =?us-ascii?Q?cYJZAX94shuAxcEmFoB51pzlJGpwqiF2N70wwlD++o/roHBtYc186skUgW4r?=
 =?us-ascii?Q?ywqqUApU3Lg9/BUkVvEZss7t1PhFPZFdvGp9UfxO/l4FIfM/sEkwjb/2+U/6?=
 =?us-ascii?Q?hHOiprpklPZls3RTUKBVi/cSMdz6CL8rIg/tNnmMsvGQTGLcA4ja+6OZ9tYd?=
 =?us-ascii?Q?RPfj4XvkroTyHAptbUjkkB6+jCIsOWf68OykOhGxH7FOjpEN+HULCIqnE63T?=
 =?us-ascii?Q?8S9r21I+PrDcNEQ/Sd+ZEYF4+TcVzviGNWgQ/9/rj8EA+nxTVDEI9ZT0t/iA?=
 =?us-ascii?Q?sM80qSFARdNtVVNWd0sRK0wWp3lTLEDcKtGIjQyHiikhelYg25TGAYIhcVRS?=
 =?us-ascii?Q?LUf0B8LWON7uPL9WKtmgZ68I+xLNiSxEKVywkdL4EM6VfPXAcLkuKxD/Sr4n?=
 =?us-ascii?Q?4j1bmMtIlPv55mRTqcjyQqyelrWe4AFOzijFp7eP+nnP6sFlqV23V1fB8Zvb?=
 =?us-ascii?Q?0DPNViwOJ+M+oxOIas2jCRdWAN38Bhf4VKRGJvM35z8TYBt8sGbqPOUnbCxC?=
 =?us-ascii?Q?wTB2K1GjKaX+emoubXbYccGpHm2AqjMvhspgpmFijW4jEUVUYvPPGsmOXbX2?=
 =?us-ascii?Q?nJhfp5aISEVUAdusBT4wLpoDgqaN5z2hmlAxDC3mUhCl7qyVzfGG3O0zK8rO?=
 =?us-ascii?Q?IW4dYtuM2plND5feOXsSFVmH8dAHXcC7Wq81JMkCEMR/RWGvQBAbfG/GGiAn?=
 =?us-ascii?Q?2vTVWfebGPkoI+Py2JPr0HgMJ4QW5P4IT8wfjIMVw2RcKgNvaEBaGWsmx59W?=
 =?us-ascii?Q?7LMb90HzJiIlmeSffc92opiTIqVWzZsVR0PdtZ4FMjz1S7kVpi4FgOL23dHI?=
 =?us-ascii?Q?Cq2bSsFzkkD/axXkuZq6EnemLtrbW9veR1gqJ1fe/r1pNWsNLybuD0rVrBTH?=
 =?us-ascii?Q?/0iyOecSs9IRBW8DmGHxCkiyoToEYg4pQer6UtkI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c06a8f2-2b1e-49b8-7c0c-08ddf4664105
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:37.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kln8lk8ZD3phZ7dFBHCnelztB4OTfjcN/BWQqPyFxOMoBXb1XPU5yn9hCseuC1Yg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_074344_327888_C2D54F36 
X-CRM114-Status: UNSURE (   7.78  )
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

On Mon, Sep 15, 2025 at 05:12:27PM +0300, Mike Rapoport wrote:
> > I don't suppose I'd insist on it, but something to consider since you
> > are likely going to do another revision anyway.
> 
> I think vmalloc is as basic as folio.

vmalloc() ultimately calls vm_area_alloc_pages() -> alloc_pages_bulk_node_noprof()

KHO should have functions that clearly pair with the low level
allocators struct page related allocators, alloc_pages(order),
folio_alloc(), etc etc

ie if you call this allocator X then you call this kho preserve, this
kho restore, and this free function Y.

Under the covers it all uses the generic folio based code we already
have, but we should have appropriate wrappers around that code that
make clear these patterns.

Jason

