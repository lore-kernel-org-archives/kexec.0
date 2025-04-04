Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAE5C369B8
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62C1OFm4clwGJVzpTWBmH4YWFo9pxn+RrTNZpZF1Zas=; b=4jP2UxqxQg3KkbH0mNUd81zhwI
	ldKUlXGu+7sWP9857o5rBaOUt9rqiaGyoqRiJLu0hkqNiyoYmhGBP9Yz6ytt2amrR7PYslQtlPjUN
	vj/dgjB1KVY2jq/L4IUURBHtYyWwPMBzlANKRvI+/1B8KI2lrfOytFUuieZ6K77mUkVazJy48SCAP
	x2m30VeCeiDp9sgP6ub4B6sliO7TKuj8KbVZ5y5CR9PnPoIippPUSDfvh8zsUc/ZBU9hZdDBjzn9W
	V6a3OMHixAloxKYDsvz7iWgpUIW0D+pYgBZ8CHEV759rHQydX1JPihB1hYDNRAEPlIzn/wQ7SPYFG
	T5F6G+bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJN-000000017Mw-0Zsg;
	Mon, 14 Apr 2025 08:37:01 +0000
Received: from mail-bn7nam10on20616.outbound.protection.outlook.com ([2a01:111:f403:2009::616] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ktR-0000000CPXV-32VE;
	Fri, 04 Apr 2025 17:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrFCaiA5gS9ojErl+ZWEa3CZ0OcRRMU22vMYms+QMXch+95OSJH/5r9VLzFNnbTmFobFCZe/ts2Nzhb7tbyxX6e9PGw74GwCNXKgE05A2YUIGA4L57AnfsLlwhxY5++NcdD/QBZIHnrSU9q+LXhEIgizis0/VAElK+H3Rx1YTkcXMaKUKYgNnnrn4/I6oZdb69d7wwyIiWebdLG9JLKyjoILDQfPlB/nxK9pyut1UbqIOtPE25nPhuO49J3nDPWzFRgCLBNREHp4LUecfN3gKPE6MYb1Di40SKtJl788okVFf2pImwmCQajUZ7ddn/U99E0intzQtcJI9rj+jWNkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62C1OFm4clwGJVzpTWBmH4YWFo9pxn+RrTNZpZF1Zas=;
 b=JYzObRrVvgGKZYUJ+fHqOpD+yxRl52RVT8eMMDfrMMn+O37edd1lt2jNZhK0iiyxHv4ELgE6cLaqT7pRa7nFqQzccNmck2DjG6Ng2kVOqd1BJAMRlxYOFhg6dwi28GXQuxjxN+MV131qi95BehaNw39Q3VNgNEgjG1J4Pz6j1Dsxxlj7MIM9UAvwSy1TS/C+PCc8ICTKgBRT677C250fabodmzwdDSeGz3atk/lJX3ECAqr8jeLWfji2HX+sbC+ygmRgvkO37N2wkeoveJQKKs/DXq04r1zN/PqDMXoseNZoo07IEN34pTCUAvdIamSpeNliNSVX7I+NewQhcCI/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62C1OFm4clwGJVzpTWBmH4YWFo9pxn+RrTNZpZF1Zas=;
 b=dqxELYIsmOLaj5U92vfZLFEMEQvAxlPHYV7//cF5ajX5oTa590CIxoMd1QcyhhHevigTBek1EhdT6DcpjBjS/7nYbKmEM+IHZC6ejTbo5DRpPbOVB7owffEbLFni92XzqrPY449s2JXDFuRayb900zz7gC3lJBkDpnJGqk5OPaaTlJt7LCHJPUeaea++eCqebxFZ9wQsuVFad8hE/P9VN+LHe6E/GzmXKmdGC6WTDdgddIPzla9n853pZzsmlDIvVEMELfZeIRmkwTXNy0lX77TnApw7ZYPzvB4XV2+eVQhq428nY/fGvhDe8/H5d4cULHwiRPgrVRuTdkFMESCXrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 17:31:41 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 17:31:41 +0000
Date: Fri, 4 Apr 2025 14:31:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>,
	linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <20250404173139.GD1336818@nvidia.com>
References: <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <mafs08qofq4h5.fsf@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs08qofq4h5.fsf@amazon.de>
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c57837-b98e-4232-5440-08dd739e8fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AMaq29uJlYjMoB7IcGgiWL6pKK1bxjhQMgMkviLtBoLHrhRL0rPMw8CqdzTz?=
 =?us-ascii?Q?MgSPcIotT4oN1uZ84+nkJG56kc+Q7Km0nf0v5alZsJY9d17AnVyQbMjXObGV?=
 =?us-ascii?Q?6f1Eya9+lgxyETlfapktjWgJojgaMEkETgo66ce3xs7e2dNkTREhObNoOlqe?=
 =?us-ascii?Q?QfaZicOYdlqXOn3T72Ndg34SqXDfrFLgUcWa769Q9CbMwHeZoIXHfxAIZ/Re?=
 =?us-ascii?Q?vr1j6zu/tpUq1uHGM+ihGQU3tJpRSB7QMksurcBNVY+qvWVQTaZaUnE/SAmp?=
 =?us-ascii?Q?h1RHusLawyB1Ye2M2LJ6kz9XEttkGw0+c3RvpH4wR/w40c7CP7AQS5aZbxw/?=
 =?us-ascii?Q?jtpp2EC89B0MvXPwx/py7vosOZmM7gKBzzddj7sz3ibg9r/AyFQWL5YAgFJE?=
 =?us-ascii?Q?jI0kMbce3Vov1wgqbA7xSzIzXOk21inrqC5XHY8E/EfR729Nld99ZKu76fca?=
 =?us-ascii?Q?Td8b6Pt464GwrYsx3dDzl0UNn56+h5dBdyjby8s+Tys8TSfP+YRNlXQ1/6Z4?=
 =?us-ascii?Q?vG5m21s9hK53Ee1V6rPwPxV5Z4WyERK6RiQUpLnvtk21sIJmboGnTN2hV9YN?=
 =?us-ascii?Q?fwZgQv5PA3CurCRBTV2pFs51mF/t5wNce9aK2uJ+um3h2gWb50JnuiqypVPW?=
 =?us-ascii?Q?nkiJUsZEEwc2VnOU5SppY2P6+JrhIq24duLwSEwMsyWA/+0qccCmINjqHyaY?=
 =?us-ascii?Q?Eik0wUcKfS18wM9AWT+Wvn6Em8fDYwqCtcygGNKdY2HW+JBUqMbG7ASieymu?=
 =?us-ascii?Q?DUOBkyOik+PQewsIlU7IFy9e2LIp7en9mZ4okwVGGILNhfCnei4Oev5hOLC1?=
 =?us-ascii?Q?ImsYGwIYB5Meqw8kcFaWYtObn3AeoCHKLt8TLwW0IFi/ko6jBVSrl2xV5Y65?=
 =?us-ascii?Q?dhUoSzXOFHmApKHW7SzRHqD1Z/SRKQRO/tqn4BAoBUBXcCoAvXxsx2X92JK8?=
 =?us-ascii?Q?79fztMoRL0KosjQgrmGrSkGN6aROz0YNiosn9QJ2NgmXY6P7HTfRUxTOG5Js?=
 =?us-ascii?Q?Vh65WdAF1LDtk8k5WS8hlRtkxN60qBvtVFABbjF04Y57r7q85xs9Io+ZlpNO?=
 =?us-ascii?Q?Ptu0NJHfCXsYB2qXJFs7MBv3PH2cNye8MGRQ50s+0IxDN8Ol1FkThK6Y7AMA?=
 =?us-ascii?Q?3P48c9KyXiI2auVctdzzxo9Ud+NJ9fQc4uldAFunRZig/bm/LEqZ4/rrrYIz?=
 =?us-ascii?Q?XcCQgjjyxFSf6Oi2Mnjlmiy6lmH+0PbLKRwb1c2im46Mb93WAQ9cySVoDlQ2?=
 =?us-ascii?Q?zOxUvxuurN/dlGxZNDNqP2R6VB3gt49+KyYEmbbT4F7l9X6k6Gi/QB6bgTnu?=
 =?us-ascii?Q?sr2pSZ79BrZyo03acMSUtI1IOLFG7sf+IRU2HGy19Ybynh8G9XxSDqFTFgC1?=
 =?us-ascii?Q?jZCWAO7vvShTQbbGehyI6+kDkl4yUXh/PS3twsEj3uwZSEwtRfEdToDczAwH?=
 =?us-ascii?Q?TyaRYzqZTZ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wObBtHaNHwTrlomuXvOmuK6Q0Y0iJEZ1eI6TcWLjwSDxch79aYHA43XoUcqo?=
 =?us-ascii?Q?WeeaHv+KIUewfDNIx/9hAQ0+A15qqAvkKS2n16GvrHzHgQS69v9tvkKacHvz?=
 =?us-ascii?Q?Cv37/72OYKtZLWZ/luGfvOMw21VjhGw1lWeYqw1LoQlK4MdB1ta8SUkr46Kk?=
 =?us-ascii?Q?Hm3wiF+OTDHft1XcNPBizLK4/Vl10/1hu48vb/1HWOq8fbd5Sd5tCJeoutms?=
 =?us-ascii?Q?xhtHy/5lt++JdFatvf9saURYgkeYMkaQSKis9agS3UWphebSQk93vx/VWK5w?=
 =?us-ascii?Q?+yFHl1Zszl9r11Mklf2Ps+WT3l0opQAwMNKkmw1Bmvhga9foBvZaTMd0SCcs?=
 =?us-ascii?Q?jWz/PNlsJ29q7fgYspkQUIdfB3URrL3EBLryFx18wJYXy6K1jGE6dVHt43/9?=
 =?us-ascii?Q?j0pky77DMQ0drtItOLMm1M5FzngmfItAVmq7MUCYMLG62yzUPzlvCgHdVgSj?=
 =?us-ascii?Q?mIJy0bpp+BcczQokTF5SPXf8huWMqnCrWOd1JhvGZhk8vQgdy1fGs6KNM8Wf?=
 =?us-ascii?Q?HlWOYiMSQKuMhjaLKGIX8k2MGmisRgE3j8gpCz5sT+AQKGqVm4/pqn7wQdWc?=
 =?us-ascii?Q?Llmluf/ghZnczh+NfmnSsPDu90DLhYJYJTQss50ItCMkX69MaKp0iwJ8aC5i?=
 =?us-ascii?Q?NPiQMPJ0QxKG4ffMcEvo5V5mMr1cgINKxpUaCc2BvMKEZrIi5tVFpcHNa7nY?=
 =?us-ascii?Q?hXsYwKN09a2vba/dPtgkeTmASQEUZrQ1i4e8hjkCZ1xvf3XlKY4Uiqk1k9Ez?=
 =?us-ascii?Q?R2uog7O5CxCQ5GGivad8f4bwnjNfpQ8/X5RnB35hDX7iHFTLuJJsvBYXJ9RV?=
 =?us-ascii?Q?uKYj0BFKZ9YAybcek4SXDU5wuGNisKaEPxIyoJ8eg0OmfSlZ8s7LIhPf01w/?=
 =?us-ascii?Q?hOuF7/cs4eEFLemAkoCoEmGrU6tG3t7lqm1yoFAotRm9t8E+4g62EgKtDRuu?=
 =?us-ascii?Q?WL+QsEbEifnCCkxlEbzDAM8Dqdbf+NufR/5F2qdlHey5REWYci/RFccFyoPV?=
 =?us-ascii?Q?oVYKQY2+OT7mmQ9OLAmgyJuNyZ9zJvJonjvxsQ5avyr0laUirY2qpCCGStWp?=
 =?us-ascii?Q?a7mM8AKfROtRT/yuJuvk9iwnH8gdcZ9VHCC7tcYR63ykb7Sh8TARolFamXZV?=
 =?us-ascii?Q?upBe8032L9ihdar0qsAbSlXRaACRqV4Vu9FhNtfsSfvlT8cEwos+aJVgwcq7?=
 =?us-ascii?Q?Klaj4pvPyWpAh6/epQt3eNkutZjOp5zm860DmjO02nMPgqGe40FT4UeiOxyJ?=
 =?us-ascii?Q?ZLyX0hxT33tUTPE25oioj6GXMpNYQ5uosAL60tmVwrhN86sbfrtcA5TA0wpN?=
 =?us-ascii?Q?lfd0iH49He/TPxfk4FzgXo2TD2wscXKY/cGbp3Icafq1D+LL4mB6knIWPgRu?=
 =?us-ascii?Q?1Nw5VxXDCoUZF+FhLn2s3joRok2UovGiCGmjneXhjuL9tR6OXT2mPEAzu2wk?=
 =?us-ascii?Q?one+cs4mSFX1O52ep46z8nobZUPpNcpJDATYwVfHyNilkgb3DndUbvcrl88o?=
 =?us-ascii?Q?iUU+FdLlJ+ZyfFvVgcOIsPua5yeJ7dnQ7G/vxxQ+IjK2SOAkBXFsP4SrlGTo?=
 =?us-ascii?Q?zy3aS+Tp8H2gqLMdZTnBmk2Pa3McdJn6tzOnhoEz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c57837-b98e-4232-5440-08dd739e8fef
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 17:31:41.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvg2YxpLb4HeQyZEiL7H3zcB3slu5YXhkd4xDxZfLTTX5e3Xpn73Vx6B+7VJWpKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_103149_757004_E5D6F5C3 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Fri, Apr 04, 2025 at 04:24:54PM +0000, Pratyush Yadav wrote:
> Only if the objects in the slab cache are of a format that doesn't
> change, and I am not sure if that is the case anywhere. Maybe a driver
> written with KHO in mind would find it useful, but that's way down the
> line.

Things like iommu STE/CD entires are HW specified and currently
allocated from slab, so there may be something interesting there.

They could also possibly be converted to page allocations..

But I think we will come up with cases where maybe a kmemcache
specifically for KHO objects makes some sense. Need to get further
along.

Jason

