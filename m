Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBDFF94CA7
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iT8/t4hqx6YsKjv6GiyYdJPDbRUrv/SDi6uN3iMzbxM=; b=N+oKNRDqECBEJNnz6FCKp5V5l+
	d0riayWxITz4bwNbORGVjG4EO2MrA8dYfr8k7rAGUIAXCNj3GzEsN5JY5w8XLW+PN+qV9+bFyB+KS
	++2MR0Tr6gZhAhARmztQpS4y9q4JJNfJ2R3ckAI3S6roqyE8SAPQCz1gV9t2bz8EYU2DweijxY6ho
	b13Qgin//I1InoEoAElCgeJmISlYpAgdYOyHNmmvYtcLKEGS6l43eheRqKHISzxc16SMryI/b/RoI
	lhJxdkY9iwkw3dkMaghiwoqiynf+pb84gQ5fkFWHXF+MoZ0GE/Y3VeOkbjZ/vmUtdfH//7lK6fw1Z
	7BsQBz/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFGez-000000094ls-0SSn;
	Tue, 21 Apr 2026 19:21:25 +0000
Received: from mail-eastusazon11011047.outbound.protection.outlook.com ([52.101.52.47] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFGeP-000000094kU-3hwM
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 19:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB3OwNmNiLq02cV/8f2V4xseVBLLBThFVXBBiLSa/G/kTDy+i/yImomm51X8cJjq28zsxlpNhDCPf/bK8et3hhNQzAD/7JCWj0TaOz9fodvDY6wJy1aDf/dFL4cXhdmhAGAopc2p7LzZkUv13uUtaVbDmATECkGYPOn/k4o9yI9z7cCwLSOkIknkuM8Mq/BS5sJYArypysdEtScdpbm9L2BBUOHZ4JAYCmBRpGa/MOwHvVio/N9vSlry3WApxVyC31tKxm3w0BsuAKbJmaLVIjwD+l2VCkEH0OeQ3H6I3TAvzRtM5ZgtDKcV4EhDj6rpxIVmbUg/g8R80exCitxfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT8/t4hqx6YsKjv6GiyYdJPDbRUrv/SDi6uN3iMzbxM=;
 b=VTVEcQ6yT5LFgtdje7hP7EG6GRbc2jfFn0pE9iZmwbdU5tNw9XuNbqazfsG6c9OaW9s11p8deOVbyppZP8pJqF+OCT09faw/O1aY6uhlz8JyclsZ0aY6gCq5qR4WBmKdkjbaRIsXOfas2nGui1XQU6EPiPzSWXcSexJ6cSo/ahqtA+3sxQttq14tbKH1d62qAwAD+O5UouuRsggcb3NfHoJIGhrVctz5IPCrz11SO5+4mHElkbi3mSecLLBOL4BmmW2soV4ESqCBSUfUlzHYy1GZS5pwurGQrLmja2QAgklg8D0h4kMQDCxfKPmNbLoSWWsRaIWzh50/9fpAUeHb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT8/t4hqx6YsKjv6GiyYdJPDbRUrv/SDi6uN3iMzbxM=;
 b=bkgn6yz4Xveuy6enkf1zsJpS4+8123bGHpuQWNRQ8e6v/xS1YqqSA+tEtOfxHMFjdlViVkyGd5ICiiSGRpigG3lIVLZanrkwGBmvMTUdhcFrj992VYxeh+U5a/bu3ng7B01XQ8PxuA9D8azDx2p60CQuysHpUUW462QLLiszccUDQwIfWc26VsFP5EOVymrRYumK0wLU1S8VbB+cgE9Ylr73zmhJA/UgSA2rNSCzYUnVoZonOziVQOsxfwyB03+jJJUxeY1O6ejoUdot/E1KE+0sCxHpvVa71FCtG4kZJzCCn6ZtQDKG7OGQHA6wY/braERzq7CJ1+n9IxS0x3v7jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:20:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 19:20:43 +0000
Date: Tue, 21 Apr 2026 16:20:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260421192042.GH3199414@nvidia.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-8-dmatlack@google.com>
 <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
 <20260421184433.GG3199414@nvidia.com>
 <CALzav=cFarR4q7NugCxXwCW6wnyU9dJRaaTnxs7MY5ia5SDJWQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=cFarR4q7NugCxXwCW6wnyU9dJRaaTnxs7MY5ia5SDJWQ@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aca0a3f-9c7c-4b0d-b39d-08de9fdb14e3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kd8xGL6SFpML6qGGK7qRoCDdftITqEfgQfyjP+QBctPOAzLg+qIbTJuUwW6fsmjnP+yaYV1ooRguGD3Iw4v+YjtkjiGzAAEHux1hEoktfyto+3QV5dDR5veOFobyNtedtfwdyJRrmlGzxq5djEFNKUVgUr7H6Ud13ifzycrddFMrrzpijXGC1RdN6T7qzM5Hr3ygTuhXF3TNkbYcL0eM8ajLSAK16UkoX4fG9eB+KAhCGIQ09ax7ko0/6oE6ypw6Ymnx2ttTLnG+HliqjTDWrOCmeft96LDdB1li8pbPNqTJHt2xpLbQIgX0NFjRfcZiID49HKTOukygjV+59oJRdgINW2d1m+MDGdOGmOHwidxmQgv/NNEPX66cSLCstMpX6EbVF17mTlsmyrDi8XpRAPJjIzh4D0iUQStu2jfaKBCUtPiW/ztLNyD1LP1KHYYRh1/ulnpRM8OFKyBSTPGQgierQsa8pFaeOfy+2DE0NNdOyDGzBehOB8DjgFtepavMkErK7+5UxiznNPbZhTw0xw2tv9ku1P2tWkcrrzELyJMRarbwjP2V6d2yKP0TFkanGjqO7hqJFW1SH2nMBqUmZsBdG4u0QKHYDRc5dL4ZNnZv2t1OJKqux+LLaUfP03/yhVKAUJuemDc/nUCm9/YBb4koe0ikORJ/Id18rg3w+I2k/Va8pF76iOiVrVvtn0PY63JhuV7B3wncQaDTtLVZyh80o0YDWC//tz5E9mSmsoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEfjo0RKO370kJoVQowS1gGNNv2xt7J98af77o/R9gw0pSnF5VlNjQxjTbmu?=
 =?us-ascii?Q?DRbkRUmWKdU4EFlQ0/1HNY/++GMmdml4cvIXns0OIArRVJqgyRpgXn8vMISh?=
 =?us-ascii?Q?Z6QKsn23BRvEws6KOnCThapMRsi2nPGpn0yKN2uNVb4/QiP2X3L+jC0c+bLJ?=
 =?us-ascii?Q?rEcXfi/N+DpgU43MXR7EiAlgiF+VM3F881etdeYnfRQrQIc9+sCjTssCu2Jd?=
 =?us-ascii?Q?IjRfTfUH+yK66ylslRs+PZiGZVcChOJhoKLmFn1PN/5ps9PXHS9F0FT/9fxo?=
 =?us-ascii?Q?loLExhsKgCQTJix+OCCJAh1ybMnJ0lw/GpdjrkaTmlRznE8siy+80MglOyts?=
 =?us-ascii?Q?GhUWl2M+Pwfx4xVgBOtQbDvHfFSUSqjFxEjXdK5bDQWLqoc1quVyPct2kkqU?=
 =?us-ascii?Q?FErz4LCQwMSXgeS8hTa6ZUWLUSPQvH+DqewYBCXMTZiWdd94DJAikKBCwnqd?=
 =?us-ascii?Q?j/fCiegmgbz3jErhK/fx6KukvTTOgZlWMi0Dv9/pcKEo2DHRF8b/pCzJIoyH?=
 =?us-ascii?Q?2NOukZimtLtwjRRMKNdAaAr2EAkhCqMMPVvdPYzezFe9Lc8Ao5PqUsNkjHvw?=
 =?us-ascii?Q?eeiyfdx+9EUxGs3S9UOovKaSiCi1Q2v2Oo4X72U1UFtXhT/M9EIJNji0R6EI?=
 =?us-ascii?Q?IP3zwoN5pwY4tg0ByVCLqfMA+1SYbooewvtgsd0GQUyseBDlJPo+xpHEYqZ7?=
 =?us-ascii?Q?eHeYP0lphMgo+gmcKXiAz7/eeldO9XGpfr2Q1Yjj/aBDUFe45r++UajsAhhI?=
 =?us-ascii?Q?WFlFpC0jxy6b11+uK0nfa7v2Wf8rQeTaXmbjhrn/bqJsftczYAnks1v7TjlT?=
 =?us-ascii?Q?xWxD5G1htcym3/hEIoEs4yUk4ins9DJ7bHMnSj/yHicwrGMz+zCLMOucCUg0?=
 =?us-ascii?Q?GZj/wmtGuHQi58alHv6DwcqAK3G4t9Ecj9QGh6CWyZLgVoNSFeLLa/91Iki2?=
 =?us-ascii?Q?cutT70sl7g+io4HEE1VCJt/+J5xORsWQnohXy+uUYMlYdfHhdjeeCGqodA0V?=
 =?us-ascii?Q?sV2qotCXmaoi2eje+zslbxgPRrziQmdLig2Im3ael5eByhBJ7Yhp6ma+55Wu?=
 =?us-ascii?Q?P+uXPEKL5VkTQJ58D7e9fo7pYt3D1NmEbUbnt+CDI3Ts6FRUZ3Q+ps6xE01O?=
 =?us-ascii?Q?Q6MwEH8uFiusycwswyc5ciOU0KnetTumR+WDqYJI5u2KC2IsbvvLVbVSu66H?=
 =?us-ascii?Q?6/2JfsUTS06pkQss0jeSZnvzbh/COx2DxR+EoLg5Rl8L7I+wZ/YsmvIca6Vq?=
 =?us-ascii?Q?k6xvz9SVhJHoWfjgkgD34MmqxQlcGrSthynIbhR98aHi2L/HUVZq4lS8EWzI?=
 =?us-ascii?Q?Q2cbCLLgoqNGk9QUpaRjm9tKEKcx+4aq2lWaG4wQM3VnzkY7yVLFhjVeh/K1?=
 =?us-ascii?Q?ftVEccQu0sIlUz+PF5FdoOPyMKmomc0wd/FapUR5R9WqeulRsRktFnzoL6lv?=
 =?us-ascii?Q?XnKLlTuobsaTwlFRN22yC+QAbEXd+YlHYEwAHLqoZkKfgMjWUAAU1EJiQDlv?=
 =?us-ascii?Q?S/qUOWDzLzhjxIPvjc5KGfDZ6SgLPiESC0brfbA0Ic5FQQaj6aFLbogKbi55?=
 =?us-ascii?Q?SxfIDQYA1o0hwq23XjJS07lK27HpidbiS/AvS1ld8w0EcquTRkelsHSdv3K5?=
 =?us-ascii?Q?Ls2QhDG+Qrr836r5Uvpk+RZanx9ncJdUjDuARqnPU/5amoZ+gRbTEYNO7JP7?=
 =?us-ascii?Q?OzcrIPe+2vKyC3/h7QCU5i9/ItAxPRYcnrUYSXwgalZ5XjOd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca0a3f-9c7c-4b0d-b39d-08de9fdb14e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 19:20:43.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCUmHDPBTwPMLW8mmjZLB615OOiAdOwfBMHsvlWVNVTExtSxmzuJehv4Xx9UPN+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_122049_928499_089C5E23 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, Apr 21, 2026 at 12:02:51PM -0700, David Matlack wrote:
> > > I think a call to pci_clear_master() is needed here to so the device
> > > stops issuing memory transactions while VFIO is trying to resetting
> > > it.
> >
> > That doesn't sound right, reset should always work..
> 
> pcie_flr() calls pci_wait_for_pending_transaction() which times out
> and prints an error message. The reset seems to be working fine though
> after that.

Wow, that doesn't sound right in more ways :)

pci_reset_function() just calls straight down to that and it is
directly tied into the sysfs reset file.

Meaning the sysfs doesn't work if the device is actively doing DMA?
Feels wrong!

However it has been like that since 2008 so I probably wouldn't touch
it and agree that disabling busmastering appears to be an undocumented
requirement.

Jason

