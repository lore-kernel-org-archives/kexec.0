Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF8BC43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 03:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErW+6EK3mXFurUZfepSXAdiyKBP4miK50Z6tfKbk75s=; b=SpPOl6GnwTPjrV8J6XNlBNe4O0
	EiaNGo4oeTj+Kh9MTNIOxGOOLIX9PLqMH6jSY+cDjucEYBhzL/XCceNoCtzjJbSRwW62kpjJoceUk
	o6QmzrvINA/16Z/JjVAFF3myygLu2L7PIkij+PpG20a47EBtnXnVuv7e7h5nM2fnzw6th2aYl9Qxq
	OuBSzPY9vFyjOHco2CsKIxtgeewFvVfCu1muRbnVrqZL2vT2OYz71bNx5RewcPPAqdUKSIJxYOn9s
	bVpzQtgQDRbvFvG9QT758q9nARpfrnQY1zcJ/KnXv1fP0mZcf+r6msLUijNhX9QWJLNSj4JXb0gyI
	VoAbCHVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weldX-00000000aCs-2eXO;
	Wed, 01 Jul 2026 03:29:19 +0000
Received: from mail-japanwestazolkn19012061.outbound.protection.outlook.com ([52.103.66.61] helo=OS8PR02CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weldS-00000000aCJ-0HEz;
	Wed, 01 Jul 2026 03:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEfonfu+SCAluExq2r9SnW0h/9uEh7tzHIYaPWI8yumjetdcQiL/TcIwq0nwpeN8azK2wUlovlp2nsT0aRYQ+iYFhRWiojypNROrd+p7svV63pEeJhrsdBP3HIW6AoG3YNyzp0KAYI4DH2MqU2+w8916xFjP9Ln8l/ITwn0BKaqzynSM7LSSdqbCcFxXjXKWDEgawfzP3BGuauuyctMnZJbmjbxQ79Y1HkqwMqgbYRQoIzFA2ceuu6RfEACM/ZN9XjH+I48GmQKzl0a7ytF8IBF/epB83skk3hYNgVBdQBI6L1U6iWqwYOJIwxWCbkcvB2ynjJzEdXH+Xa5yTicn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErW+6EK3mXFurUZfepSXAdiyKBP4miK50Z6tfKbk75s=;
 b=ckbsSvxF+Fm+uzADvC7syGOIJHEvVY6H9W3VmKje+BlyW6KHlJjitAnFyuw71Dg/CjF9HazGDYb94XBFClXAb5EhTboaSNs5O49LOchirv5Aj2cYTVYZ6S/LAiLOGzbWolkwEW3AZ3mj0NtEKpm/aaEFH8aus0CeFwwznOQgOdxLTDUAKcYrbIW9jqrzuCDvuHkguKzo3vAlI7v/YVi8yr/1qmugA7siHm0uafEsbcnPKFqlO/1qyKuyV2CASOYvwkRN3eL2nKOP/d4SdXm8mNdoa8VX8ugfN4+Y6dT3CPGZnmy6djjQ8f/kVQUEg04rIhdAv08OWiiunMOzbML04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErW+6EK3mXFurUZfepSXAdiyKBP4miK50Z6tfKbk75s=;
 b=fxtD7ffSXbzl66NtQvWk6kURXw0ZtLjko+1vvt9T3XdmLorteyB206hiuEXv4l7uEn2rgifjdpHDP1z8tL2padoD6u5FGxEEbiEqbCsxWco2Qo22wZRU2+HnZyDIYcTEo3GqGeHdmLtIzYZ03YC8q0WEcNiZeoaiZCCwt+DMXQ9rM77WwqJIbe75SlroIyzIZKTuyAUM9kw2f3jjkUHe6mjm2RQ3cJ1SMLX+EWf/BL8TmguvMVWk7ZdLxuigBAAJ1aEsFU++FMv8iXIJTEboi50XGgF5FZEUrZIM0Jxq4IzSkWy4LvIi+wHhW5w8CrfMJS29bRzbgCoDFMJLtMqTpw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6279.apcprd04.prod.outlook.com (2603:1096:400:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:29:04 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:29:04 +0000
Message-ID: <SE3PR04MB8922E2267F05A514AD33F9D3F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 1 Jul 2026 11:28:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
To: Tao Liu <ltao@redhat.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 pratyush@kernel.org, Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
References: <20260701025732.66330-2-ltao@redhat.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260701025732.66330-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <f47ff8af-beee-48ea-ba49-95386526213e@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5055ffdf-0315-445d-9a8c-08ded720e658
X-Microsoft-Antispam: BCL:0;ARA:14566002|12121999013|19101099003|25010399006|15080799012|5072599009|4140399003|55001999006|6090799003|23021999003|8060799015|19110799012|4302099013|440099028|3412199025|10035399007|40105399003|52005399003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnVNMHdoclcwLzZzY3czOFZtL1ZqVHRFK1BYNnRFdU1GTzJCeTVZRkRSakdS?=
 =?utf-8?B?Q3M0L1hCTnFBQll5YWN6TGNsc1krV0l1Z1pib29lZ1lSQTdOOWdrU09ySTRF?=
 =?utf-8?B?MnpBZWZjUUFnSWVCZzViNWtkOG1OR2FFZkttTVdOcFY5VDlFNktvSXNUa3BM?=
 =?utf-8?B?V0V1UnJ6VHB1Nm56aHBzWWxyU2diTmtpMS83UDVpLzZLR0lMcDlkSzJQVWR5?=
 =?utf-8?B?QXBpVE9uVTdZcEEvOEZRMnRmcTBnOXhVN1pBWEdDUzVyN3FFUkZLZ29mVUY5?=
 =?utf-8?B?OWJydGV1Q0xZeUZWS3hoa2lKNFM0RjZRRVBPZnVtV3BZeXZtT1dINzdhYUNj?=
 =?utf-8?B?UGkzWjlRVnpXUEhNK1ZlMjFYNkVqdldtcUdJMlBINjFnTzk0aDVxRitlbGJT?=
 =?utf-8?B?NmFHZ3hUVm10Lzh5RllQTzB1NUhXNDdXa0J3WXNyVU1IWmZlMEovVElCZnMy?=
 =?utf-8?B?WDRDdXZhNEFXd3Bya0YyV2lpMjN6Uy9ialdsNzQwL3ljalFPdy9OMmtYclZ0?=
 =?utf-8?B?bG9VQlBobHp6ZGMrR25xYUFYcjNqZFJ2OHdEUHdXbnIxaFN2TmNkbjM2Z3Ux?=
 =?utf-8?B?cFZsVnRZSDhIRnI1VEgwZEluWWpsNWYxdWlNbU1uMnpuQm9PS1FSdklia1o1?=
 =?utf-8?B?RFd0NWIxTXJiUzg4eWtMQjZjU2Njdkg3TXJjTWRLNFlPMnFXRHg3ZHJKRW0r?=
 =?utf-8?B?OFlGblF2dkVOdW03MXJYVmRIcFZudTBsckxwN1JaaSswUUZSM1hNWDdCZXgy?=
 =?utf-8?B?V1E2dE14dURhV2tSelV2V3Y5SExiZ3JtcEFJTS9CVVJVRXc4REdXa0toY09B?=
 =?utf-8?B?NmovSit6NWpRdWU5MWNxZkprOUNlVG1BVXp1ZXQxUFBnam5GMkZPeHpYZVpV?=
 =?utf-8?B?K09EMElZMXQ4Y2N0NDRVZ3h2NDhQWkJoaVBMZDBiOTROeDJGZVNESHNxUFVp?=
 =?utf-8?B?dElDOUxPRjUvY0MvR1k0UnVTV2ZwTVhrZVRhK0ZxYlZUb3NYeG41NlNKMlNG?=
 =?utf-8?B?ckpxQzVkS2Y5YldXMllJNmNYb1p1Yjhrb1VQMlR4L2dPOVRtemJTV1FxcTFS?=
 =?utf-8?B?R0l5bnU4ZDM0OURNOVIzYllCWnJZNXVkbzZhaVZoR1MzRjZ2V2lrbVVtRERH?=
 =?utf-8?B?Z1VIUWt5dVhvOU94WVZ2Z2ZnMm80TVN3Tk85UGt1c3NiWlJYMnBzVTJoTjky?=
 =?utf-8?B?UC9tV0NhV1ZCbGR6YjJ0S2IxVDlHWjRyYlRDSzVHS1pGSm5xb3BXS0JLWUlX?=
 =?utf-8?B?WWRTdjR5dzViQkJsNjBVS1N0MG4yaUhRaGNZRHRONWtBTXdHb09lRDd1b1hB?=
 =?utf-8?B?NGlablpWaHhrSnVuT1BNVFQ5aEl3eDRSRXJ1YjBpNm1SWER4Q3JNWk5ZejVY?=
 =?utf-8?B?SlU5ZDZ3cEYxSjZlTEhFTmFta3dyWXhPT1gzOFFVMDc0aVcyWVRsakJFRXlp?=
 =?utf-8?B?THBWYmRPQUVEcVlxZWwybkV2STZsY2xWc0p1NGM0eHB3WkxlM3dsREtOMDN2?=
 =?utf-8?Q?w4DKGE3SF4+y9USupXMaVpHsxnU?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXROaXRRYUppOTZna2xDR0dpTm0zRGk0aG8zaVIwekoyZCtnUW1md2lZNXZu?=
 =?utf-8?B?UTRNMWp4WGR0d3FYbUZiWENkZUpJeVhBaHUzVDRETW94MWo1U3RURUpmUDJz?=
 =?utf-8?B?Z0lhOGdqYk5jWXhBMEUyNi9IZXZwZFFlWlA3WHhlOEMvVVduY0dpSkFndUdZ?=
 =?utf-8?B?UjM2YjlZcVVhYld6dlJvMlppZGNBRVY5L3lPTWZaTS8rZFh0UU1JRVJ6VjFR?=
 =?utf-8?B?ZTZCSTV0OG9hVFZiMkI2T0tBK096UTdxbllJUjUwbTBLYlRvd3FGQUcyZUlS?=
 =?utf-8?B?R1hmdHdOcGhJRkRVeTMySjJuRVJaMUs2Ykw0a2dLdjFDbzViZUlRcGd1eDhM?=
 =?utf-8?B?RnpzckNJMXlDNVBWU0VoTUtrTTcyaXZySnE4aHNtWE5NZmsvbDVBY0JnVTFT?=
 =?utf-8?B?SEd4YTBwMUdYZ250K1BDT0VXbUJzZjZxRytabzZtRDlmeW96d0g5TVg2ZTRW?=
 =?utf-8?B?YmRzUnM3RUhtUkx2SU5jeGNoZ1ZFZGdYOG5WSXRsWnAxWUhyZk5neHFCVkJ6?=
 =?utf-8?B?ZUpJeFgya2VSL3Y3UXJYNkNJdmVGL09tWHBGbUdaRjZsM0RxRFpteXRzMXRG?=
 =?utf-8?B?c2FtSFo3RHMyTWVNL2F4RGJnbWpBUk00RERtZ0t3bVJkbVdObXF2S2Z5akl0?=
 =?utf-8?B?dzVUejRhY2RIa2RzYU44VHpHS0NndG1RMlZhVEMxVmJsVmVUZFRyVjlZYkJQ?=
 =?utf-8?B?UzBjREpEUUQ1QjNTeEJuYzlVMWhJMmFxTm5lYWNhclJMTDBoVGo4T2hpSlE0?=
 =?utf-8?B?UmxKY29rSjVxOWl4NFpWelY0eCszeEZJQnJNUGJQZTNGckYvbThDOFN1VFVD?=
 =?utf-8?B?UHQzRXlmSnJrR2hFL3lCTWw1ZmtuKzVMdnpGK25qRktNbi8rQzlnZlVkWGRi?=
 =?utf-8?B?MFk4amZhcE92akJPL2R3V1I2TWhRQlFPb1JQUXBzVlFsZVFHVnpPbGdUVUxG?=
 =?utf-8?B?cW1YWDlnenhZOGEzSUlLaXpHR215OEVmMno3UUgwRHhtL01iWWVtQkg1cHAw?=
 =?utf-8?B?cW5NV0xXbENESXBNbEJFcXY2eWRDeWd2Y3NBd3BXNHU3VUNWTzJjWTlJK1Iv?=
 =?utf-8?B?OXhxc3U1Y2VPNytoRS9yaGNxaUNFZ090WFhTZnp1VU8xa0laWGN3SEJYdzhZ?=
 =?utf-8?B?TzVaMzhuMXVXamhLcEp6NU9STk1LWDh6aG9hMGFsU1pUS3BWcDVzOG1IQmtJ?=
 =?utf-8?B?MThiNU1ONTU0SUVQeFJhNGRPeGgxMTZCSUdIUWNtbW0wVHRYeWdmbERDRFJN?=
 =?utf-8?B?SUFrWUd5aklUczJtSFBXL0VzUW9Qc0MrRlJIT2tMRG9lVmFUakp4MVpQSU9I?=
 =?utf-8?B?UDBSU0tGMUVhQ2g3UVJWem1NVm9wSFJpWHZ3dGZWNHNWNS90VUVyZWc5bUdH?=
 =?utf-8?B?a28zZ2ZtZ3lvWXFnQXlGZkpZeWRvVThmUkRUY25PM3JBRENWMmRWR3JBTzlQ?=
 =?utf-8?B?Y2g5bUNUa3UyV1oxYWtJQlora2czc1I3WXFReUpOMjhDWE5ZQUpDdndyZG1v?=
 =?utf-8?B?TUoyOFJ6Y3dtWE9obnJQNlFqV0k5UmNiRjBLZlVxRkxQZWpnK0RhRTZYTFpm?=
 =?utf-8?B?bzJDOXhKdlBXREg1MkxDc3R6YzBjOFR0a24xbEpmSFh5UUNjZnBSWmtFLzV3?=
 =?utf-8?B?ZjJtVkJtUnR5WDVzMDQrMi9iZFNaRGp5YlhURk1KSnkyakJtc3A0Z3ZOcjFK?=
 =?utf-8?B?Lzdla3RJNXA1bENQOFk1QkRVVmU3T3B1Rml0WUY2VG4zSEF3WEFaZEJxMVhm?=
 =?utf-8?B?KzZGVi90clE4b1NPaVM5M1F1OGZab0xLQzJKU0xHMTZkTjNMQ0VjRkgvWi91?=
 =?utf-8?B?NVo1ajFIYnNBVFVVSW1IZDVYd1pMaHR5YUtPL2ZMVy9sRnAyTFRDUzN2Y1JJ?=
 =?utf-8?Q?a5jklfsrcxPlF?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055ffdf-0315-445d-9a8c-08ded720e658
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:29:04.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6279
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_202914_118125_0440A715 
X-CRM114-Status: GOOD (  16.86  )
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


On 7/1/2026 10:57 AM, Tao Liu wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
> where image->segment[i].buf might be NULL and copied unchecked.
>
> The NULL buf comes from security/integrity/ima/ima_kexec.c:
> ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> but kbuf.buffer is NULL.
>
> Fix this by simply adding a check before copy.
>
> Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tao Liu <ltao@redhat.com>
It would be better to add the log of the dereference calltrace.
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>
> v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
> link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
>
> ---
>   arch/riscv/kernel/machine_kexec.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 2306ce3e5f22..afc68f6a4aa1 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
>   		if (image->segment[i].memsz <= sizeof(fdt))
>   			continue;
>   
> +		/*
> +		 * Some segments (e.g. IMA) reserve space but have no buffer
> +		 * loaded yet. Skip them as they cannot contain an FDT.
> +		 */
> +		if (image->segment[i].buf == NULL)
> +			continue;
> +
>   		if (image->file_mode)
>   			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
>   		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))

