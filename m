Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8043FDEE4D
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGllgZSTj86q79vl+Z0gA8Li+LPlxtnlpDQ+5QFNJI8=; b=mC4PBhSDuiK7FoqN+6z4GudSi+
	uyMYZeG+oI0dbFB7rbuRU1lpW8eOcbu33y9t1TJywoRObD8Qplm65sIURgdfDsv4A7yb20r6VfZYC
	Fnl7Iavdh14/mOjKxwil8XRUhWc1OIlWNflcGa5oTbVwp3lgI5FNPBX0T2/ZfhSC+sT+uk8fdLPlO
	93/UoxLR0OvG19CUunbWLDP4f5zgx9HBF9tUxaicsW2yv+H1W/fY2jo2mIyDUrDKMdZTTcvLe54nN
	UPj7w1gAWhXq0iIfMOOvb9uRqk5jis5JNXr5U6Tur7j94NLHkxM7e2WQ4meyiU+mCYmBqgCktphz6
	BXNjQojQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2v0-0000000COTU-3ZTY;
	Thu, 23 Apr 2026 22:53:10 +0000
Received: from mail-eastus2azon11010049.outbound.protection.outlook.com ([52.101.56.49] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2uy-0000000COT8-0xpY
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 22:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDBpk65ms4Q9Khnx6EqwzhLQdHWRfy94uaAh3R+jxcCz0/SUimYpfll96JdMO20lGJO5c30BF5w/nUq5b5SHwpKbBkPT2iFV1SwdvgJbBGa5wXCNqq8kW4iplY0oGj4y9Xm56ld5W3+4gVwrUKgFbq4OdqA0e8g3TtH1+AAq+iEbZGHeqZuWQ2TzAFNVuI/E4G2GQhzmwFqrkg7L+8sVGAyXSdiKj5P3iZ+HGbGAbR7E40MqMgFhCATDL+ORotBBySNMf3j1cc5kET/OP5CXrEAgO5MGrN9v2TeqrY9RENdKStdvAbvgMzVFuToi7iXbxjSEvYDji+285BIrHDTEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGllgZSTj86q79vl+Z0gA8Li+LPlxtnlpDQ+5QFNJI8=;
 b=sIqOiXT/1YjwBRF4VpAN3Ovi0uNIPQzqwzYWRbJUGEBOOtKeNIQ585jVZKhlYkuBEcehTMQtz/2Gwa72iVlL5NaDDJ8jNA2vipDfZyp2ijaIT4+JRB2MPCxIFXXjYTs5VWp/c2rRJf1jwXS7/T9p406/nsNgRhqu/jJEigBL1/piC7Kq4Lt71tF40k1tt/L/U3v2E/JYFyO08phHUJ6Y6QQgyAwbCw8AnTiTIjte1/eRL1CZL0VeOBixQXKwU01AKm+29xiS0hWarZAuzmTt/BtmjEjO383pE5Yha8izNY1w3pCxTrBclmGgI1oAwpVqA2gSv5AEnIYPZ50HFpJbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGllgZSTj86q79vl+Z0gA8Li+LPlxtnlpDQ+5QFNJI8=;
 b=R1qsp5YUH6TuCNEvpATGs3AxFDj5GKYZt4k1ycnu1wlhZReH5r1vcatUQf3hbu1ASrJ0ZTSbmARmeBocPQwodeTRP8vZU8/myo9e0SzEd7JJLI4k1ygWU5KLnLlNEAKyvz5wc3SUzgB9PgQBbsJpVilZWUBlhNdWUvUY0c6Nwnl4i2RyPglQl/LKFRumV79GJz1hiJwstwTnW1ecQPptqFHM+sjf+uetYJH3nmHQ/GIZ2JsAWxy3tOpWxieYJsrn2DspeVqH8LXeQgCquusv5UD8VFiv9PY76jfKkLtdUPjCpVqBQ+sr9qYt7JnK2xGKE+9+OfxYS2J1p0sC2WUcCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 22:52:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 22:52:56 +0000
Date: Thu, 23 Apr 2026 19:52:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <20260423225253.GA3444440@nvidia.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: e777414c-6e64-4055-c1f4-08dea18b0ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9E5nrqZ+WQxtFDiNe88eFWNuzkdZ1mqgMO4ovmVqy+2meNBKuhOKB/Z6bTyJ8w8INXHUtjVPxrQVMbFTfC6OyKl5x1WibZQYqs7SHNLtvEryunURao7rLwYTVnnvXJe3gHIiqF31OwquBta3RpnrbPDV24mSp5wSemT90y+wLZeo0N5ZG3oj7U/3MHWwXbyy7H7rZ9gLS9wah+5Coujfi+ZRj2K2itYjcQkkqRgmmeOZiB54r6bat1h3Vu8FvptY8QDFp7pifZKqNo0nHif5ikXys26HiCZOaRZke0RIikyyRxo+tBBg3avPHZuR82VhsDKTAhI7nudmIIaKM1DooDm9qtSjfnWT1IuhuUhxow8MBvesjGUQZv+9Orurduf3URLbDVlaNMCv/oJczOqygcLrM1krHKTdviPZkNT3o6CQ+oTQCkZfwLKdTtWG11tlNkd/deX9ttdPQhzXqt19P0iPgWG2kkgXupOOyxdoKhnvh7prtc+r0v5BpyVFQYHEj9qILqQX6wR2NDJQgpheS28hyUN03seQ+9id1H5+Hx7Ko1A8l/YCru+WxOBvkOwfi84XUVmekRbFPqcoekg30R7iUCtybzbLJQ2ZrHbzSWdivvxLQl/aH5oOpf2kL239lB/eX87P+w9oowKoxTl2kXKY7ypplhZH4b+pjBufPxjK/KM2vv1KvCrGHUUNP2uuXuzkTlKG+Xye69xbrqd6+FFzNK49kWot3HPlVM0ZFYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZrL2xESjF0bW1sOVloMHQ3azlnNjZqVkM4WkFNREpWRFlnWnBpeGxTWHYv?=
 =?utf-8?B?MnNNdEhvb0VRdStQcHl5Y2tNV000WXZEOC9yeGprdUdQR2gxb2IyaytSZ2oz?=
 =?utf-8?B?a2dTaFg3UjE5eTNzZWFadUl2eFhxNy9mSFE3ckxoNlY0Tlo0VnNwYndvajAz?=
 =?utf-8?B?QWlHVU9BWHIwcEhxOVJYUE9GMDVVYWhBK2xuc01XT2tnQ3FIcTVOWDdvOEI1?=
 =?utf-8?B?UHp0QWF0Y3VNU2JvYUpQclBVbkF0MDh4YW1LT2FSSGNZeWZ6clozMzBKTmNM?=
 =?utf-8?B?YjBZcjRCMUFBVmU1Smhib2swNGVsaXk2QzF4WUVWbWZsN2IxZGwxZHBxOFpW?=
 =?utf-8?B?d1Iwa2ZOcERaL1I5ZWRpMEFPNVVZVkJScnUvbVh6ekY4SjNIblhNYlpNckJi?=
 =?utf-8?B?RlVLc2hUZmtqSmhoZDc0RzhyTzhXUUpPTWtzSWV5SHlXNk5lYlYxRVhwY2VV?=
 =?utf-8?B?VVFjTExkYXJKdWs4czc2Vnlpb0tTMjVJdXJvUGZkRFM0clZibkllNndQbUZT?=
 =?utf-8?B?MkNXRTR1dUY2SDV6anEwQzN5R0R6U0UrUlN0RDloWVAxaFBQeC9BenhYUEIx?=
 =?utf-8?B?cncyMXRyRHp4Mk90OWpsMU4xZk5vWnVjQjNndHVoakhNWkpaOTZ1Q05XbVMy?=
 =?utf-8?B?bWc2bkM1QjVoZm1DWXIvTktHekRxd0szRHhmZjNJdlpUQW1nQ1dNSlNnWlN5?=
 =?utf-8?B?Q0FUTWorc2xpZktGMG5LM0had2FSbHdwWHdTZXV0Z1lndjM4ZS9XajBzWnhV?=
 =?utf-8?B?Vnp5MHFZRTJZOUxOalZMMWIrQmpKVFo3M2NuME5rNjk4M3drUGRUb2pkUnp2?=
 =?utf-8?B?MjVwNHNDbHo1T0xzTTBwK013SFNzeUtZL3hJSHloM1pMWHY4UkVpM2xQc1lk?=
 =?utf-8?B?TjVzcFZIbzFYR0pvV2gxSDcwQXZKQU9JaGx0QTFqQUtoc0liRWpnN1N0RmZi?=
 =?utf-8?B?S2dtMCtIbnZaUGxhWjJsSXU2d3RsdUNKeXQ0RmJpc1NYMG9BTDZLNW1YdEhB?=
 =?utf-8?B?Q1JRZjhsMVdnNEhkbVJyeUVRT1paT0RtSXZrekNxZmFrWUZvcWV0czFUSlNE?=
 =?utf-8?B?WUNJdmRDWFljbzdiMmkwWkRsTUk4SU1MNGpObkk5UVNwRVpucmhTSzRVd0dR?=
 =?utf-8?B?bUlvT0NtNmEwNEIzRnRTb2FRU0M1RUtMNmtTcEdJUk5lK3FNUi9iMFJoWllT?=
 =?utf-8?B?WXRVdEhHaW1adGQxbW4zZzlpcU9SR2hmNVJtaE1WeW9TelJaYlZqOWtHOXRn?=
 =?utf-8?B?VExmM29FaVRoVHlZVzdQVXBwY0NaRE9QbVFuWnV5ZmFLQ2c1RXZnanlLOWx6?=
 =?utf-8?B?MFhFWDVWOXU5MnVjYUJNS2IvdHc0NkJLOE8rbjVRL2o2b2FtZE4yb1llYTRl?=
 =?utf-8?B?K3B2M1M1WDNzMnNQZlp4MXh6TDJTYnkzaDhQMlFWY2R0OUF4M09Vb3hOcnRw?=
 =?utf-8?B?cDlJdFRJc2RzRFVqT1N5Skw0WFY1Sy9Cem5GQXRRaHFDTkt0OU9GN21wemY4?=
 =?utf-8?B?SDBsTnZ4U0VBcTdGdkV6dDI4YzdQZW5LQUIrc3FjRk10TWFQZVB4bDBjQUlp?=
 =?utf-8?B?Z3piZ3VDbGhMUmJHZ3hkMXpubkNsYU82TzEzWWdqVGlkUHFFN2ltRTQ5Z0xz?=
 =?utf-8?B?Z1M4L0xoLzFXQTRsOTV1N3orcXNsVE01NWRjdXFhRTkvblZQUEw2NjA3NHE0?=
 =?utf-8?B?WW9URFRDTERGdkVqZWt1Q2VKOWJObDRJUjlRK0s0TjZWR0lJREhrb3BqYU1U?=
 =?utf-8?B?NmFJeUUzeFVXZ0tXZ0dHTEhMRVY1NHVwcnZ3bkRaOXJqSVlzZlE1WHh1NGVu?=
 =?utf-8?B?bDZ1OUFhTW4zZmZPdEFXL1NzVnRZb2NFazBQYzZNNi9wVUY2MUV2YUkwNWtm?=
 =?utf-8?B?VDJxTGxVenptNEhyMnFqV0Z2TUd0dEJrN0dXRE1Jb1ZocEZvRXRCVXJLbzVi?=
 =?utf-8?B?MzFDZjlVQUpGUG13TXM3RXNUWmRZdVRVSkV3MGlkUEMzWk0wZ0hIVU5aYjl1?=
 =?utf-8?B?WmNwYS9RQTZuZ24zZFpYMGg2OUNwMk9MdnllRGd4L1FMZmxsTUhtV09MN2dS?=
 =?utf-8?B?eXoyT0xmYUZtR0FCbTMwUEpqY0ViOHJUNG82UTdVL2tkYS82VmY3ZzZ6YS9R?=
 =?utf-8?B?QUZGZkVRbW1Zc1RjZlNqV09QMHlkdGY5OUJndzI3NVdNOGt4WHpyblR2YkdD?=
 =?utf-8?B?TDBrdDYrOVRUNTNCMGFCRkp4VEx5T0IwZlNCNXpBOUE0V2VLUVdtSzNwN2Va?=
 =?utf-8?B?OGhUR3BIVlE1NitGenZtWm8wMVRrcyt4RUhMVWpuZlVwRXlLSWJvUjczdk40?=
 =?utf-8?Q?rXcCq8Sza/RW4unMVV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e777414c-6e64-4055-c1f4-08dea18b0ea6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 22:52:55.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKFRlQfbUZ3pXp0uvb6C62YtwriAvp4rKVzDPKSoFpdrCyNfnSQ6ljRrRPtO8iyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_155308_302464_693E29E9 
X-CRM114-Status: GOOD (  22.87  )
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

On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
> On Thu, Apr 23, 2026 at 2:23 PM David Matlack <dmatlack@google.com> wrote:
> >
> > Restrict support for preserving PCI devices across Live Update to
> > devices in immutable singleton IOMMU groups. A device's group is
> > considered immutable if all bridges upstream from the device up to the
> > root port have the required ACS features enabled.
> >
> > Since ACS flags are inherited across a Live Update for preserved devices
> > and all the way up to the root port, the preserved device should be in a
> > singleton IOMMU group after kexec in the new kernel.
> >
> > This change should still permit all the current use-cases for PCI device
> > preservation across Live Update, since it is intended to be used in
> > Cloud enviroments which should have the required ACS features enabled
> > for virtualization purposes.
> >
> > If a device is part of a multi-device IOMMU group, preserving it will
> > now fail with an error. This restriction may be lifted in the future if
> > support for preserving multi-device groups is desired.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> 
> Jason, do you think requiring singleton iommu groups is still
> necessary/useful now that this series preserves ACS flags on preserved
> devices and upstream bridges?

I have forgotten why we introduced that? There are alot of funky
things about iommu groups that might be important upon restoration..

Like if you preserve one group member but not the other what do you ?

Even if you have ACS flags there are cases where groups are still
aliasing DMA..

Frankly, multi-device iommu groups don't even work fully last time we
tried to use them in a VMM. So I think I would not expect them to ever
intersect with live update. Blocking something tricky you can't test
does seem like a reasonable thing.

Jason

