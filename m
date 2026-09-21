Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C65BC982E6
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dv3xH2vDzFdoqjECjxDHtmNHC6nK0SVP+RwkJFB1L8=; b=iqBLiiYRW4kCnK3hNBZZI/F20c
	j9CHeqn5306asxGtI67bhKyKeQ+5PApT5FGmNTBru3L/KQstP6LxdEi+4LwLJeTj6VtWxowVJHmet
	0wTeI/aTjxyGllDsnS9KJIU61bybyTRfY8BevmXnLZtYjBO/A49BMXid5/reY92GSXQWC5S2SY88q
	pG1UGp1LgK8Q/jmXUxMbVVCK2j7AXpQG5iKX18lAhVIp7WSgWx/E/wk8ImIzEoy/sjBZWZg3/X5BN
	JT/Da0i42sGMdRM3OaMggj8dE/NUlYRiwXUbnfOJvUv6thnQP3iL+rjc7L7wQJYLCS5apLzQjKvB2
	MzTpjrzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8g4O-00000002dof-3hF4;
	Mon, 21 Sep 2026 15:36:40 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8g4M-00000002dnX-0aUr
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 15:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m72I2LjVLiA/yzb3hQ6SImsNTZ4QRxcXuXyHG7ddXGxcTKJZLEjHtGNMQNHN7xTwhHKxNs4cEFT1sfkndovYoTs9SMv4hCa1vZ2tXXLN8gn5/TbXRIndkHxPjNS+7/Ai+h9NtNWCqW6bB22j0RtiStTsj+8m7Jt8Sf6nrguL+kDPnwMkNTUEDRr5sUWTRQo9//MuthJah9/XPaN2silAWkgMmqJPlbfSXvP1/LX53wRgUxlH/rdfoeobE+HiAQKpHeIGtQUwAlJGlKqN2xh1ePfjeUVz0EIJfB7ITjajrkMso0n2Q9eqLb2aLjKzX5zUjPG/vqQ+6F1Yf9OdcfYtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dv3xH2vDzFdoqjECjxDHtmNHC6nK0SVP+RwkJFB1L8=;
 b=n25+RbiVf95IAO6qN8v5kcuXSurVDoZxAxtn2yQhcFTrQaADRRUIgCMivNEVXO9KqgyYxZMVcrgtSJe/f6vxUzhGoBMRXy+cT29R4cGrvNSxMJ8UrciWWCu48t4+NFCuYe1S2MDgfir+o6kzENq94/vv9JaDSPaHiM8iHtM/AUqYddE7DlUQHUXsHTgbss9/vAyAFRAl7O/UEXKLACduYKL5E2V8Ll+Uqq9M46LXLm9if7C8bhbKFhRyT3Rf7XQn+EvwxWLqvPmzWTtk9dMDZ6XS54Bs+cBb1/SlUjdUr9uHd6dgvqvEbwHYuiXaZmGdNtGQAPj9uhL3IxDenHfa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dv3xH2vDzFdoqjECjxDHtmNHC6nK0SVP+RwkJFB1L8=;
 b=blenGkJauq83IJxAd/yHYDnyE0h8L3S2TQJWVMv5Zpp5tLQ307wipJqpFqBrh4K2/cow72hWgKKgcu24SGZnK/veOeFctBkeLKVOoGzd9ENJCmrHGU9t+gQuaHfQmoHjJjXeLmTzALsD/fGDW5q4EEpfI3m7jxg3+9EEtJNGDXDcM3C1TD5HeCjvl+Jwk06yWKiUauGPD9NIMZVEaQBOfCbxJ0+BaWeUh1Y9dHmaVM3Wif678WQoIogUnZ4SHFP4mDBywPWWwPimBu6Jygyi0AHc/c2nt/dWb24QpoYTRoC10ISBmn1fk60dUxqab787ZoctXmLA08A+F2oE9nGi3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LVUPR12MB999186.namprd12.prod.outlook.com (2603:10b6:408:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:36:30 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:36:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>,
 Nico Pache <nico.pache@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Gregory Price <gourry@gourry.net>, Kairui Song <kasong@tencent.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vlastimil Babka <vbabka@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Qi Zheng <qi.zheng@linux.dev>, Dev Jain <dev.jain@arm.com>,
 Ying Huang <ying.huang@linux.alibaba.com>, Usama Arif <usama.arif@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Jan Kara <jack@suse.cz>,
 Jonathan Corbet <corbet@lwn.net>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 linux-mm@kvack.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kexec@lists.infradead.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Baoquan He <baoquan.he@linux.dev>,
 linux-kernel@vger.kernel.org, Dave Young <ruirui.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] mm/page-flags: remove PG_private
Date: Mon, 21 Sep 2026 11:36:27 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <E5E3D08D-F0C4-49E4-8763-10CC58FF4260@nvidia.com>
In-Reply-To: <20260921025520.628971F000FF@smtp.kernel.org>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-17-bb68b6a21869@nvidia.com>
 <20260921025520.628971F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0644.namprd03.prod.outlook.com
 (2603:10b6:408:13b::19) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LVUPR12MB999186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3128daf8-4bb7-4e24-32cc-08df17f61bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|6133799003|10067099003|11063799006|4143699003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 49tp2czc8S79zvrqeI5IBzR1qzO0uh0rTojWB8UnXjCGvq8a4Hs9GCxF49+8boPvJNERmL1Ie34bWY2aaGJY4AQqacrl7vBLgSkxGwnkY4j2x67W6w/04NeKCCV9+F/5qp3myyidm8P9ljdDaXZ1NjhHm+dyoFwJHaChR+RXaiOxY2XjRrkKw6RVWuU4/g0SwQgPS6/cy76NjhPvrBX01IBnr0v1S6hqoXUvkltfhChMIQw6OXUeuoWO6Zxma+XqakU+Kp8exc+OUgjuU9CqS+9XH43RPBdbjtY8RaIDD2bTJA6cIQhKggNW2hf06t2fKYgXuI8TKoe/y7H7TCjN2jgrgaf9if8a4HR+3ZznD4Z/56C0HosEgEN9YN/8kBj6Ntn3V6McGYzto8jsichmcug+SZ8khz+FkLxjhwSd931OSSzptDv/Se6sqQuVr4QFgD77yRqqrfAiyK6guFFcDPSN8NgDsNQmpiMtgNFOjhZ/rLfxXCoSTqHC3xllTWfchdcx8cCTVZYlZ67Q0HB4p9ekjAGS/CPR55VwpNuLwiZ4W8KZymDzqa4GZBJn7Mz5M/tSRUh+5GNHm8lLzqHElmZeQ7PYA004pWiRUoJU8WxmzMfoMWMmclSlJcItnkjg4jLgz01klX/2MValVYAd4kkec6eFUK0/wK64xr48zSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5xYlBGSGw5U2I4UjBZeDQyb3ltb3NTWStvMVkweXg2c3YrUXVCS05NaWEw?=
 =?utf-8?B?TWcreUN1NmdTTFZNOVJ6S1ZTQ1JBZUhWQkRubTBySHA5UUNadUxaNzFMMEJ1?=
 =?utf-8?B?NW03eUNFV01KRVBjejZ2Z0J0QUNmMVFLZ1BLM0wySEhiZ09OMms3VjZoTmZH?=
 =?utf-8?B?MHJoaHoxdG1yejMrOTdwOFhSelQ3KzNOMURvMTJPbmI2RFc5RUtwcnVpbC9l?=
 =?utf-8?B?MDBNaUE1OU94Q2xhL0hYYzYvSUNIRG8zVmJFMGVXaC83TkpRODlxZTB0ZDlJ?=
 =?utf-8?B?bE5WWDB1REpCSjFHZ1l5QmhGcTYzZ0dtNFRuaUczdFVlcE8wODk0ekd2eWVU?=
 =?utf-8?B?UUVkMWtHRVNFRjBOSnB1bktRSEMzVC9qdmVBZ1B3YU9KSGVQSzk0NGRrNHZj?=
 =?utf-8?B?Wnh2NlIyeUlTNEtxcEpSSjlsM3NXZCsvQ3M2ejYrVmdtRnNxVWdvTkJNaTl2?=
 =?utf-8?B?WVlYWVZhT0l3MlBPUDAyZFFXdWU1VlBYd0ZzSlpwQXVPZ0tkejFTamdQYm5y?=
 =?utf-8?B?Nnc4R3RXclJCS0VFdXlrY0xFZldmWDhYdlAvK3RCdlpmb2pRcyt3aXNyZ1Z3?=
 =?utf-8?B?aml3UWVxczl5YzBCMGtac2cxYk9qRzArdVdWTGxkUmdqS3puUXN5d2djLzRw?=
 =?utf-8?B?QlY1MUd5K1FVQXRaUmlhZEZpc2hNdFQyTkFaQW5PcGwrRU56S3hEL01MSWRw?=
 =?utf-8?B?QThVeXkvelZ1bEpKVlNheXhYK0ltWUx3ZTBTUlZhVFIwb3ovZmxuVlI0RnpV?=
 =?utf-8?B?WlNXYlhhVWVwdXEzV2EvN2lidEhLZ0NlRDAwaDV3RGFvRUF2YjU2OTVxZzFV?=
 =?utf-8?B?SHdscEtTNU01eDVTbXY3MWNYREd4T2JlaVFCNXNKd0RQUTlReDIweXhBYkkr?=
 =?utf-8?B?NndwdHZmV21VY2YwSjc3WmpUaHN3M0RwUnlEME5pNGwvb0pQUVhmZkRMcU55?=
 =?utf-8?B?YVRjdHFkcUhEd3BxaDJmYWZ3Lzh3MHl1azNSU3dpK0N1aEZFNUM3bmxUMHoy?=
 =?utf-8?B?TzVSVFNNODRMWkFVS0ZZQk91RWpKS0luVDYyRWtIUGphM05EdzlmV2VFYkpD?=
 =?utf-8?B?N1U4eko2QU5qT001Y0JFanFJZzQrV3EwQVlKUkR0OTlGUTZqS1pxSk5VZ0o5?=
 =?utf-8?B?dGZyN0F3cWp6SVdnRzl5aTJEczlDZEJHUEJrUHRNcCt3M3k1eTZ6OWpkNGk2?=
 =?utf-8?B?NmVYcUJLYk1ncHUzekgzSVc2Vk9lWWlnZHVkYjU5ejdMeUdyRVdWcDJ5SkND?=
 =?utf-8?B?TWxxSWVMM2lVNzRKVlNxbzhhRm8zMmNScVk2ei9FR2h2TDZxQUdNckZnazZG?=
 =?utf-8?B?c1hWNlVEVlExR29nOUNhY2htVDYyNkVPU2RGWnhqSlJCU3E2NC9YbmFRaG9M?=
 =?utf-8?B?dFRKYTY3V2s4UWw4NGtSTGxHdWtkTzViVlZnSnJwbnMrUjdGcTA0YVFTVXFj?=
 =?utf-8?B?MmZHZ2lpQ1ZGbDJOODRzemlaTnAwZWJ5ampQRWZPYWZZd1FSYzdkOHVHY0ZO?=
 =?utf-8?B?SndTbWtyNVFOdjlBbzVEblFzOURWRG1Va0RqUCtOc09vYnJrSm5DVnFETGkz?=
 =?utf-8?B?bU95VzBEUkp6UUN2SjFRbXBwaFJmUkNGakRZRWhUc2YzVVVIM1JOcG9ITkIw?=
 =?utf-8?B?M0dDNklWWlZFZzV2U044YTdvVVJLSG1FaWhiZitWbWtqbTZNTmY2b3Q5WEU0?=
 =?utf-8?B?azBQamxmU29XWGJoRUlyMHlsaWc0RTVuNkRneDJyb05vNjM4VnlVdkdqSDVM?=
 =?utf-8?B?MjRJZ09PbXg0cGhHMlg0OHFHVFhQNmkyd1Y1Z0loMEZmZkVkZFJrZ3VGTlo5?=
 =?utf-8?B?UHdhVEt3TTVrVE94S0x4UWlYaG5ITTNNbkw2K0hJRlozMFpkUldUMFZ2STJQ?=
 =?utf-8?B?a3F0cE5jdzEvdW9qTUZKOFRPc2hrT21mUnRSWEt1a0FUelJ0QWFpYm53QzlU?=
 =?utf-8?B?ZVF1VGdCVXExUXpLTjA2akFZaWh1OTRqWWxkV21MMmNuaGpHWkM3SWg4ZWIx?=
 =?utf-8?B?QmVoU2RrSmRiSHlObkUwSjJzemlYMDB6b3FlVE1BRit4VVVXY1BNSEFNVUpu?=
 =?utf-8?B?TEFBODFvSitzYXZNTm5JUFJVVm51WVMwRVovWmQ5NE5pYzl3elNaTW00ZTlY?=
 =?utf-8?B?OVZseWF3N2cyMlFZR1pYVmR5SWhVQ01XZmNXZzFnWHlFT1dDdUhueHNoNnJq?=
 =?utf-8?B?a00rV2pTZzlzQTA5QVU1STZaMVd6SlBZQ3pCMnc0endESlpHN3VWWTRDUGtX?=
 =?utf-8?B?S25KVEZVUlhsVHNiZzRhOXZiOCsyVlVpbWxhNFdadG9FN3JxOFMvdEtQMTQ0?=
 =?utf-8?B?aFZaelByMUtQMU5XZUtSVUNiL2g0Sm9kam5OMjg2VDloUUs5VWlKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3128daf8-4bb7-4e24-32cc-08df17f61bcc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:36:30.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lXwUPPExatbCOknvAinav0a6N+I3lc5/SXtlrMUZR5jjCdirVDFG7LGFFB7F4HT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_083638_180332_B238BFC3 
X-CRM114-Status: GOOD (  17.48  )
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

On 20 Sep 2026, at 22:55, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] mm: silent memory leak masking due to PG_private removal
> --
>
> commit aee12ed3446e69cb6eee57384ca09e768dab36dd
> Author: Zi Yan <ziy@nvidia.com>
>
> mm/page-flags: remove PG_private
>
> This commit removes the PG_private page flag and replaces its usage with
> checking if folio->private !=3D NULL. The space left by PG_private is
> reserved as PG_folio for future use.
>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 7080a6a1a79e7..b0ddc652e76cc 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
> [ ... ]
>> @@ -1169,7 +1175,7 @@ static __always_inline void __ClearPageAnonExclusi=
ve(struct page *page)
>>   */
>>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
>> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
>> +	 1UL << PG_private_2	|				\
>
> [Severity: Medium]
> Since PG_private is removed from PAGE_FLAGS_CHECK_AT_FREE, does this bypa=
ss
> the safety check that ensures a page doesn't have uncleared private data?
>
> Looking at __free_pages_prepare() in mm/page_alloc.c:
>
> 	page_cpupid_reset_last(page);
> 	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
> 	page->private =3D 0;
> 	reset_page_owner(page, order);
>
> The head page's private field is silently zeroed here without any prior
> verification that it was NULL. Previously, free_page_is_bad() would catch
> and report leaked data via a bad_page() warning using
> PAGE_FLAGS_CHECK_AT_FREE.
>
> Now, if a buggy filesystem fails to detach and free folio->private data
> before freeing the page, will this result in silent memory leaks?

Answer copied from RFC:

After the conversion, folio/page should have an elevated refcount whenever
->private is set. That would help detect leaked private data. I tried to
enforce ->private needs to be NULL at page free time[1], but that might
cause trouble for certain use cases.

[1] https://lore.kernel.org/all/20260223032641.1859381-1-ziy@nvidia.com/


>
>>  	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
>>  	 1UL << PG_active 	|				\
>>  	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-p=
g_private-v5-0-bb68b6a21869@nvidia.com?part=3D17


Best Regards,
Yan, Zi

