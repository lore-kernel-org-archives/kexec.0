Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0ECF94CA7
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e+kACXubQVychG3T3bFYkuF43LW1APPB/RYMm5S0V84=; b=O7mh3erRTcq/TigGMTxz/Sdwdw
	WP57w9q11fm2Z/yg8AkwkdP3BSbtQIplxYekzPz33eDRAYnQ6GzyffVh9IEX2KZocGKrre8KkZn6u
	P9X6tLqpd6ehZy0epRs2lrzUPSpuglwmrZ67p6uYQB++TMaNcnTrHDihM1NEJMpiS4MAFdBV4trMT
	/ekFBd1UJMCEmYRLJceWak9TvELGLK5GwWsBZuxru14L6597+U8z6dE5YZNI88GrM3Lw1Jw/H5UsC
	xBm07UE/dbfUdk9F8iopmydblqD2FY8KzQszssIgzu7c+3LmOeek5PEqV6AsslKQyh3srvXRexw4c
	/yPo/wsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFG5f-000000093Pv-2QIi;
	Tue, 21 Apr 2026 18:44:55 +0000
Received: from mail-westusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFG5c-000000093PW-34nR
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 18:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQuDURL32lkBDBTlrYzjLcXiU7LVc4oFnje2nBOo4yupq0ewCHcTlxOfdwjdJb+7vu0DUYJ4FOZQw3e5GFHmKmVmlZ9+nR9fihi79Ro6guRHweuOw93tLX7CALiB9IWTBB64LI/LGyMQXSiQgASU8ku+0uTQ+J8sQMErSJ3eOTKbp86Sz4fZHzDqyOs6e8XgflQ0umMkTmotOVQy1mupsRwNxLGyYOudd4JP7U7O/SmDdV+021SUcS/U6XnILcQu1fjiZmCdx6mOpCOJpl+WOGWRg2HjNixEIxgV//SM5IC3WHlb2BJ8+9suNwikxVI6o+ZwM+Nm+3ZnVPF/3qH3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+kACXubQVychG3T3bFYkuF43LW1APPB/RYMm5S0V84=;
 b=gBITsIyTW3Pa6a4bg5W1WrUPwwm3UnS1JIZvW94soi6TX7ExyvPLGHODbkGYpQXx2Y6KhK5gSQDNLzfmGMOcSuo9fmbNGRzNbjf4XoiyAUgeOguX9tRqeDjq/teiLxDzqkeBkV1x5UgmpG/Y7raLMzLLia2Bg1FfABPFF2m+TBSt3ZhmIBVmRf3YJVFIOSnQ7FQAW6MtYsNya/g5U3ugsCknmo3kDFrnM8kJaFJCxfbx6Sz6xz24XRYdnjDVN13XPxaWgmtE1O1bymf/H788Ld3s965atO8wR5HYezYyR9oDtTFrfnkVjaWJNJBlGJnBCncDEb5ETpIrkcMe2gle6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+kACXubQVychG3T3bFYkuF43LW1APPB/RYMm5S0V84=;
 b=IDPxN0f9ISxOOLeascsjtndScu3b7giRZirIsn5KIfWR/3snqn1ODC4lo+TrPExg8Fjut21ow3mdJfvrRQDHm9NU0UtJ0no32xUdip+89gmwU0QmbO/3u51a7fx0v0gPuMvE/sQLBcakvXY1uVImlFf4bcazMmH65LX3a9vxUMtGczEMZfmlLBUvHSQt4N6/OELBB80C8NjN1LzCCo1oM9F0TYC1fvchgXjhk25qZXEsYd+xFEhdWo/7lnVrafw3e1C69z66hadjAMXrJcVnNs36+Mm/STl0U2GWPLzOghr+EV8Rq4dLAiX2ecMbLNWOU8Ui144a3VzPhpULAg6BXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:44:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 18:44:35 +0000
Date: Tue, 21 Apr 2026 15:44:33 -0300
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
Message-ID: <20260421184433.GG3199414@nvidia.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-8-dmatlack@google.com>
 <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0424.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e3a8bb-3d72-426d-1df7-08de9fd60883
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7YqzFTMfxS7NqxKLZmF1Gingefbl4N1kf8JVwm+ANR8iVFK1DOsJsAYC/xP6nQwnc0wWAocAObBvDPTmEFm+UQEbmKBCjYOTSB/imj54BriR7L/VRiyszpMPv/bfH990k7oCItmpipeAmqIdpcdofz0uJEOlngcuYnxlmWicp7b2AUpQCNE3ioEaQ5sGmMENwLog5SyCL5OaHaw6UpzJ7oHcKdHXiTRm7apk28Djr0QNOmMOdlJJ/XlxU8omunAtpPh1kpRGkwy0TFAvQtuj6aBnlB09cVFz0l3EnsAIXY24862AqgjF2RV5zznotqOBHbVBkvomZxy9l37nwbPHs9aEf9GVNmSPUWZOKVStwZpixpCDu6sPE7XiM6teBa72XpQXntfdcPi7p50/iFnIeOobFyHvbXz9o5Zn08UwFrHUWb74QyR8QWA835IuenEwLthxq9gYTSvVZMwBc682UPuqG7Eo44VpApBevpGwPMtycpmxbiJXqFTRRISaSXY04Uj3qFVKRO6UZfaS0pKIQLzTNuYqNHdPauqprQ1G8989929K/wYeF7SQ4T8eo+es/+aGUuw6cJDrcbRLjPVZG1nGkpc/95ogaEZm3XN6XPHkAExNTj7aHGpDsiVYDh+V0WvjI03208Y7AkjqLuN2KI42d2RqZFFGgLbs22hSIiMNS2IZYN+5rlltT8tf7bUp5F4WkTK/538ek72s4LycWgfCNxCiWxrJRmlhju+u2h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVova1VtK3BlZm1rd1hjaFk1QktHd1U4MXRxZXdnRU1PemNsa2JURFBORnFW?=
 =?utf-8?B?eThiWStTd2hlSU9PM3dENFF4YUlQbkNqLzMzYTlJNjZPaE9IK29wemdqUllU?=
 =?utf-8?B?QUZaK2JoTXhuaHVaNjM0a01zdWZ4WXptcE84azk4cmFQSEdHNTE0U2g0V0Zk?=
 =?utf-8?B?UjRHVWNuS0lxNXNocFVHNVViMk15UTJ5b3NrRFVQNzZjVmhHK3NXQTRlOEdy?=
 =?utf-8?B?eDBDeURuamsrc2thVnIwZ2NMek00OUpxTDBzUVUxNXI0d1NsTGpuM3c5eWtJ?=
 =?utf-8?B?NCtEekNzdk5lN2l3ak05a0p1M0hBaWlCKzAyVjZrZ1hHNFJVcHQ1NVJiVity?=
 =?utf-8?B?RXYzVVNBeXFWT3hJcFptTkJEUmVVSEk5WTA5UUJsRUNIdXhtNFJYTENTL1p3?=
 =?utf-8?B?TkYyZEdsVXN3RThvN2I4WHcxckJvV001a0lSdHF0U0lOTW45SmVISjBlVks5?=
 =?utf-8?B?YlJmaHhhY1F2TGlVdGszcTg0MkplQlJVb1BVbjcwc0pwVlh6L0h1UjEweVlZ?=
 =?utf-8?B?WCtjdy8rNUEvdDN4TE9hNmROc0lIWkFrMHFBOTNvdjFkM3Q1dnJTZ2RSTEp0?=
 =?utf-8?B?cDBUbUZDd2dMbDZQOTh5aUgrUU5SYmhJL0pQQndOTUNGUk5UK1VDZ2RYaVA2?=
 =?utf-8?B?U1FHVXFDYkQ1RUJnRW4wdWlQc0Q1ckxNMm4yNWtpMHBHQTkrdHU0MmRDek5x?=
 =?utf-8?B?enllOUQvUWNyTTFFMGw2UXhMNDVXL0lMeUJ1YkFmUzhkZFB4bmFzcmtwNGQr?=
 =?utf-8?B?VHNlS1dFT1FrOTZQSnFrVkVIWkJ3clNJb1hYZ2ZQTFRURm1IZkY3YnhCa2l3?=
 =?utf-8?B?NVFoOWlQRXZKa2RCd3hIdGtaT3BBUnVRWnhJN1RYc3UyWDdyRFBvNzR4N2RO?=
 =?utf-8?B?Ujhxa1JkSHlBa3NMeVZ1cTBvemlPdlNiVlo4SE5JeFFvdEVmOXlmMGN3M0Jm?=
 =?utf-8?B?dEhCMDI1TW9YN1pUNzNQQXJ3VFFrd1IvRXhsZTlnZUZMNnc5c1RVb1h1cXUz?=
 =?utf-8?B?NVlEV05EV1I3VkhlV3RnMFlMRUR5d2tVTUdpWWp5ZWEvNWpHNTFXUGp2RWhw?=
 =?utf-8?B?RUJCa3JVK0NwbkcxQUFGdGlXbnlCSlBVSEZTZTRXcGhQSGhLbml4ZUxwMExa?=
 =?utf-8?B?TUVUOGtJVitlYnRzZDJDMUZ0cWJvRHhWbzJ5SEhoeTNQdWdrdEJXR3VaOUZO?=
 =?utf-8?B?bDhuTERIc1hIdHBNSEhUR1pkQ21ZbG9SVVRxdjJ5Q01JdmpzdzM1NXRMVFVO?=
 =?utf-8?B?UVV6UGJ3Y2FYRUU3NHFoRDhRWWhseTNzZTZ4RC9OVFN4dXB1V0pqQ1BZNy85?=
 =?utf-8?B?NzdkZHFkaG4yQXQ4S2w4ZUo5OGpJKzkrUmdjSTlXRWY0QzZ3a3ZSby9BYWFF?=
 =?utf-8?B?SlpDVVRHRW54QSt4dmphdDg2YnRjQ1laOXNrYnJDc3VodTcrbnNMR2hLNCtE?=
 =?utf-8?B?Ymt3UStqUS9CN2tGeDdxYnZKcThlS3d1K2xwbFREeU55QlFRa2RMVlN2TlNh?=
 =?utf-8?B?azFVTldRU0FnZVdkREoydGN1ZktDV2h3cGtQRmZrUmU2OTc2Tk9hazFXNEJy?=
 =?utf-8?B?Zm1SVEgzN0c0QVcyQW1HNVB0SXdmdTVvUXhjSTJoREhwQmpUL0UxVnBUaUlH?=
 =?utf-8?B?TXBRakd5d0lCT3RGaTRzbGdkY20yUjk3eVJTeHlvWVR2K241MHY5WG1SejBk?=
 =?utf-8?B?aEpLd2VCeXNGRnJ2WjAyTUQrTFpPdXVDTGRVOVp6Mjh0cDRKVzZkTC9tT0hS?=
 =?utf-8?B?ODFVbUtCZm55emNEVUZrVThPTlZibEdCWG92OThwSkZUYWhxOVQ0Y3ZYeU9I?=
 =?utf-8?B?cXQ4OFRMdmdmTDkwTlZKWkZPM3JqbXU1ZUVoOFRSREI0VWcyZHBzSGV4d0Ix?=
 =?utf-8?B?VnJ4VTJYYlMwK2xOMVo2bFVkbTU1dStUaE5mSGh2VyszN20yMmtOQnJTSkli?=
 =?utf-8?B?NUllMUNXUU0rZHJldGNYUDBQSm1BbjlmQ2g3czhiSTZnZjNDR0tBNFJwYWVG?=
 =?utf-8?B?VHZaSTh1b003dTk5ZGxoZEl0ekdFcVA4OUtTa2VvMDBtRFVjZTlvaUN1Z1NW?=
 =?utf-8?B?bklkbjR6U1lSVk9qR2Nwcm13K01McU5DZGhMWmVadk9QUll4Q0E5MWI3TFox?=
 =?utf-8?B?Zmw4UWg4ZzBuVnl2N3BWck9ieDgzOWRad2Evb3N2SnZOZ2xWeEJ0V0dEZHBo?=
 =?utf-8?B?Y09pWEp6V0ZJU0ZIcFBkZk82QVZrejRTNk5TRnRKRjhSTkQ5NDRNd2lFNFVY?=
 =?utf-8?B?d3dqK21xcWFBbWxUSUxKU0pOeXZCZXREdXRKWkpnZHdRSkcwa200eHlYRDVq?=
 =?utf-8?Q?CYkRHD7qYclaGzJsiL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e3a8bb-3d72-426d-1df7-08de9fd60883
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:44:34.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nmX8yTWapmJyo6vDhfmDUdWJ6dZafqHtYG90LCj07FyvzBeAaJDvD2/bD0l5JJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_114452_777378_B8C73641 
X-CRM114-Status: GOOD (  21.20  )
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

On Tue, Apr 21, 2026 at 10:40:29AM -0700, David Matlack wrote:
> On Mon, Mar 23, 2026 at 4:58 PM David Matlack <dmatlack@google.com> wrote:
> 
> > +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> > +{
> > +       struct vfio_device *device = vfio_device_from_file(args->file);
> > +       struct vfio_pci_core_device *vdev;
> > +       struct pci_dev *pdev;
> > +       int ret;
> > +
> > +       vdev = container_of(device, struct vfio_pci_core_device, vdev);
> > +       pdev = vdev->pdev;
> > +
> > +       guard(mutex)(&device->dev_set->lock);
> > +
> > +       /*
> > +        * Userspace must disable interrupts on the device prior to freeze so
> > +        * that the device does not send any interrupts until new interrupt
> > +        * handlers have been established by the next kernel.
> > +        */
> > +       if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> > +               pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
> > +       if (ret)
> > +               return ret;
> > +
> > +       vfio_pci_core_try_reset(vdev);
> 
> I think a call to pci_clear_master() is needed here to so the device
> stops issuing memory transactions while VFIO is trying to resetting
> it.

That doesn't sound right, reset should always work..

Didn't look beyond this hunk but why is a function called 'freeze'
donig a reset anyhow?

> Sashiko also wondered if pci_clear_master() is needed to ensure that
> the device has bus mastering disabled during the kexec 

Only devices that are not being preserved..

> think that is actually an issue. vfio_pci_core_enable() makes sure
> that vdev->pci_saved_state has bus mastering disabled, so
> pci_restore_state() below here should guaranteed it is clear during
> kexec.

.. and bus mastering should not be disabled on any device expecting to
be preserved ..

Jason

