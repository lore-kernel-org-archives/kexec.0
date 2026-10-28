Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B604606A31D
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KY4glbxl;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OSBwdzfB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:To:Cc:Subject:From:Message-Id:Date:Content-Type:
	Content-Transfer-Encoding:Reply-To:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eTxn3bz1Yv1B8vV9tbElb0teYrDoKNmx35m2CrBRaSQ=; b=KY4glbxlIypHWqlAC33dD5jfHD
	mJ5HYtWdBpOryDBkfvxyu5h4VcYd7I/Eu9cTeee+5zd1Badr3NtkwRoBqgf/S6Qu16t/x0VojG5z6
	392x5i3er0wnCR75NIku8kOG/o6XRjeorf595xw1gIntKqCW+C6XHQQkKsZRvUF/h/8AQt7PFTvj8
	nOKsbWp62I2iytCGTse0/nx1DGECOUj1ihE8aqJNZOPoUewP32k3VpZYR5rm2N8SNJx1MLkleq3oD
	BYcg5KgBpC/UHY3ArJClbIXJgI7EV+EqMS1Wmy+p1AeTREDweYBbY7ORYndQX41v6EQVeKZpXWEV1
	oKzt7T0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLt5b-000000064jM-3e85;
	Wed, 28 Oct 2026 02:08:31 +0000
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLt5Y-000000064iW-0YgH
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 02:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSMuvKPkJFJtHnZekNRko+kjsteF8xW/IzkceUgQT987UmgVxMkTGR3IHa82urwYT3MUhNKMj6/1mky3nYeW4GtP1xSyuKy+ZQrnOkS4rIu0G7bSPQYiEGae/sMWuHkJw7xlUEWjkn85OTVFUsyyA/6bPEVNH1cSSkYZlYFqJoAjP572gIdAJn5YfqINVE7YxL82OH+Ff0slH7sXKouMkpRYTK4fA4qPiI1XIXvxaQ4Rhwbt3mXAP6qA5CwQ2yfCAiwheoYBFXG1Di33eUnyA6nH/lzsiO/JXbHrAn8ki9M6ESboKCYaZHitclYEIPak5SRMF2ZNt4WHgbt2j1oUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTxn3bz1Yv1B8vV9tbElb0teYrDoKNmx35m2CrBRaSQ=;
 b=Bd5HuMl0BLIcEP84nVxwZvRPcILcdv4+W1TPSQkt7u+TfAQMmjfbCdJaPWE+is8QFHOT70DdcthZKbtVNbQM79n+BP1+93UB9A5ZJLQYFa+aWzpewI1PCpX9caFULS2sEj793KTmvnBAq6G6TijG/GATuM2gZ7JQS+qUA0qAZrC5gqg6iJznvNuTqL9RZA72o5qn4swfgr5NhjFxwfybND/+CkL76gXF3eAHLV1+HIntolps9sMykC93Q6hGrwwnWe3JVwd4+S9IdjdxAQGjf0kK89UmeRWtV3FTLtQEzdQ3c9XXaf69PRMtReU+rMmICgqtGi3e/FjlPahIXpopqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTxn3bz1Yv1B8vV9tbElb0teYrDoKNmx35m2CrBRaSQ=;
 b=OSBwdzfB50rXXmv1Al7YZtcTL6XBg0EMzx57cgaJUSLSYOIASBZ1yQc3nZ2aDw4aobTQGnZFwke/Bdc+VSeONcSi1YSm5gkwPWbspl/UO9ius38ftUJU+zI1pN1NA6Lc2R3nMF1v/aSOw6qCYJzfZAoGOqXIVAjZnfcp/jFmmScAqim8cHB6CaVLkXnyuAOgOHLpuLauDhTMsjMFvXZEQN9BwTlJgjv32oSEcjamZeEzqZwyE1TkCbH7zTiOVkkzdS2oKn45mx3JqiKlkiZD7wLyITZd7l6RRJNRrzQqHqjWdUWCg+3OyFsc1+K4LlcwgyhQ1Gz2Infij/7COq9FdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:08:14 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:08:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 22:08:10 -0400
Message-Id: <DMG3SHAT8M1I.2GM35M3FY7USD@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 12/46] mm/huge_memory: fix livelock on device private
 folio
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Josef Bacik"
 <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song"
 <baohua@kernel.org>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh
 Dickins" <hughd@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Lance Yang"
 <lance.yang@linux.dev>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Alistair Popple" <apopple@nvidia.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin"
 <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Chris Li"
 <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>, "Nhat Pham"
 <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>, "Gregory
 Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.22.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::30) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: c9932488-795d-4d61-9157-08df349852a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|10067099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|4143699003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M73m3cPKgeey+opMNsq+xF7F4L0kanjFfRj4x7vNbYsDvuR2lKptU/1G11s1xebcFHVcgItKyGyO7cM4jnjEkhEA2FHioHH23In4Py7YCdLJtM0IdO4JdzGMI4cmORagby86pYEx3k68/1/Ezg+SyIudiZWnDO9H7jbEW42HO5UB7Y3UwVSjfGSbxPPWYNREUGecbqwAteXBBXACw/jASrBaoBRVe9nxJUTLTgHJHQLSS2dYSShvp5xggYjLC76IxvvbmHsV/hANQL5s8VhI4xciNK3Vi/Vf0Wp50LJUOvcmztw+4nTxZOC6WGN5I9T0KIyJ71fgDsdenV6+9l2Q1ED+ZJkJeeuwPq3DHBi56/Mhr8M0KoNCiphGsRtpS3rUI3CI27SaRVmxgnM5qWVO5SGfTh1hS79kS0M7xccY/xPyKTU1hQ7P20bniksTozu28z5zUW6T5NTnwIcl6jdErdYH/M66OM82mrkDaC6NG3nZttz6vwzLUMa8IHbvcnORCvDtPw6fetI7MeWbA/uzhvf2XxS89EIka5fqArdz0mjTVb93EJiRpB5Vs+S+mXi6y46nqSlnA8w6VMzj/3Naq31/Zpoly/KrasC+IKxfz4TrNfvDWas0c1BqHuKoxIYsOJYv5jt1JesTQuDhqnIzZn1I5FoyaQFPxadXXSU9RP1G4goEe2YoW9Ex8bFMZm5zpMyjOJl4246ehr9m98DcuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(10067099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(4143699003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T283WUhnWENoeEIwaVQ4TFoxV210WlN0V01nM1lBN0VzczU3TmljbU01SmJT?=
 =?utf-8?B?S0hnSzQ5aU8yeDlkQnRYakRsQUNSNUpSanVMY2czZ2NJSU1la29OTnRndHpP?=
 =?utf-8?B?UFg4b09wR05BVmRmVWdoeDZvakNFVGZHcWdzT3pRcWxmRm93bCt0NXdLblBV?=
 =?utf-8?B?K1BUdFhzNVlUU3RRMkM1eXFLMlhQK3IzQUpaT0FTZ3I5cmxGejBJam1YL1Nr?=
 =?utf-8?B?R1llZGNLbENaY1Vad1N3RlpzRGdhRWFhM2xXeDRIY0ZMR2pNKzJzRDlZY3Nl?=
 =?utf-8?B?RllDcldWTjN1L3pvQ0NVbXVvZ29EWTJKVUJTZHc5UjlMNDZIRThPYnNYM1RK?=
 =?utf-8?B?VWRLeVFTR0FVaGJDNjNMQ2IraHlGcjFWMURSbHZ6SHdBMnUzcGMrdkhwVlcy?=
 =?utf-8?B?alNyWm9taTZsWUd3K2FEdUoxcThJVjNqbnRhK0x6SzlkSXlNL1BBOERqejBv?=
 =?utf-8?B?ZGFnUTc3UE9SQ2djZlJ6Z3lsV1NXWkI4aDlKQlBIalN2VFZQYnh6eFZlb243?=
 =?utf-8?B?ZnNlK2VFdlF1UEdNZ3AydGE4akoyQVFCOXdRLzNmbkdRQWVSWDlINkRLVktL?=
 =?utf-8?B?Y29IbnlLNkVwZ3hRcXRlMDgraFFMSnp5Yjl1Q3l3cUtxVGtDcHRrMmRDZ0xt?=
 =?utf-8?B?ZytpM2FqS3lnUSs2S3VXaTNWNitSdEpST1RHVzdiVlZyZGFOTysxY0lPbGdC?=
 =?utf-8?B?QkZUYWozQWZBdFVMbWxWZGgvQXYybkhOaXcwQzZLSGZQTlIzK2I2OEJyMXhv?=
 =?utf-8?B?OUl4QXpWNEZPT1hqeEsxNXZGaUxKMWxYd1VzR0xhOUlFRHhrNlFVMGl4Uy91?=
 =?utf-8?B?WFVNcDRoQ0tIRFJMbjFPeitMZ1RmQURSR2dJRGRwUlRySkl4OHdyMytIUWo0?=
 =?utf-8?B?NFVEVzdFeTZna1lTZW4vcGw4WUl1ai8zNmRlMERRVElhamdiV3RIRzJUUXp3?=
 =?utf-8?B?ZEVIM1dJMlV3bENDRjc5Y05vOUxONWN6eFBZMWRVR2xFekpiTWFEa200cW9i?=
 =?utf-8?B?OWpIYWZ5YkhKVjc0bmFlc041aG1DRnhwMVA0S0VVY0hwQkxvMFdLQ2ZuYldX?=
 =?utf-8?B?bnpjWW5Ga0xSRDF3SUhtT290dnVIck4wM2hFaGN3VU9kZ01ZL0IrVU1uK0I1?=
 =?utf-8?B?cmZ3OVN3dTVZYW5iM3VVT0RQUWRrU2p4cXVjdHVuNEZqS2o1WVo2UVdRaUg5?=
 =?utf-8?B?NEtqeVFPVkFrdzYxT2VVUkNueDhsbUNNUUxhaGk4Y0tDak03Ukp0QWgzUGxH?=
 =?utf-8?B?clE5TUhmVVMwMFpsNGpnaWFGc0Y1Rmoyb2hWTnRpRlZ1Z083eEFQVzlqVXpJ?=
 =?utf-8?B?OFBkSnJkMXBvMk5qeTFnNmFrRTNXTm03STd2Ly85MFd3TXhwQWgwQWVQS0pq?=
 =?utf-8?B?K1J1YUtIeDJLZ3lZMGxqVGtSYXFITGQ2OXZkMThxZW1ZL3RUR0VCOUJadjI2?=
 =?utf-8?B?am1GMkNHYVQ4OFF2NklqWXRTcGNuR2hqaG1sZmtTb2xsai9aR1hNbW04THpS?=
 =?utf-8?B?UEpDL0x5NEFrZnV6eDcwN2QvVVRnV3FxVld5TFZaOEJBS1hZZ3VXSWFqOFNu?=
 =?utf-8?B?MjJZMlpNS080UnJEU0xkUG5WVGkvcFVRU0ZHNW91VUpNYWpTS1dkQTZRbmtw?=
 =?utf-8?B?dWVGTDZIb2xVbUZ0VVBkeTl3Z2syS1p5bDVOM1FoS3JCL051WGRhL0Rha2py?=
 =?utf-8?B?dzFrSTVmTzRpRHlacmk5R0dNSThvZDFsVmoxTHdHVlo5d01iSDBVc0xOaTJF?=
 =?utf-8?B?aU8vVFhGSysxdkhZTGI1T1oya3dGQTBTbkkyaW11VHVWa0w3RGRmWS9sU1RC?=
 =?utf-8?B?K2ZxSTZsQW9IZ3FOS1k0cXZ0a0pFOUZLRk84UDhwREkrdUZiNm9sdVViYjBs?=
 =?utf-8?B?aiszRytaSnZqUEVUSWoxODcxNWVCME1RY1g1Z0hiaEJSMlovYUpyd1dvZ0FX?=
 =?utf-8?B?TkFmQ29CaDVZVUxwdUhBOWhXQkRYeEExNU1SWVowUjU0Y0l0aGUybC9Objgw?=
 =?utf-8?B?bVIvbEtLWk5vRk56R1J2a0M0MjJwSmZ4R0NoRHRSL3h3ZWRYYXpqd1VpNVdI?=
 =?utf-8?B?UWpYSnk1K2ppRzN0dVV5YXhnZHd2WmptaEVwV0ZsSXdDUS9VT0VzZllkSnBs?=
 =?utf-8?B?RWMwUnZJQ2ZpbkNuSVJYais2L2JIN1ZrcGRlckJDRS9Nd2taWFpzU3RWTE5l?=
 =?utf-8?B?MDJRNHo5dzlLakthTCtCNEdYdkVGTFlTRm1nSVptRlRaV3BHQnpxbWJHY3ZV?=
 =?utf-8?B?a3FSK2NNV25KSUxpNmhOb3N2NkNQdUoxUEtBb0ZXZm8wdGRHV2ZDL1FHN3Mz?=
 =?utf-8?Q?BKL62Tu+WUJKOiCH7F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9932488-795d-4d61-9157-08df349852a5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:08:13.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjA7LjXwREkzB84WcCMcDAKWIoZbOTIacXtPDWh4nVZImUyCVj+K6bsDEXMLAO/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_190828_180561_21C87A51 
X-CRM114-Status: GOOD (  15.06  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 26, 2026 at 7:17 PM EDT, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> If do_huge_pmd_device_private() cannot lock the folio, it simply returns
> to try again on the next fault.
>
> Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
> livelock / starvation problem"), let's wait for the softleaf entry,
> which will drop the PTL and wait until the folio was unlocked. This is
> precisely what we do in do_swap_page() with device-private folios. This
> avoids possibly livelocking.
>
> Update softleaf_entry_wait_on_locked() documentation to clarify that
> device-private entries wait until the folio is unlocked.
>
> There seems to be no compelling reason to backport this to stable
> kernels unless we actually see problems there.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone de=
vice private pages")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify patch description, fixup softleaf_entry_wait_on_locked =
description]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/filemap.c     | 4 ++--
>  mm/huge_memory.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

It matches what do_swap_page() does. Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


