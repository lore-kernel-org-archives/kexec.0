Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001C4C46CD3
	for <kexec@archiver.kernel.org>; Mon, 25 Dec 2023 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GdCp6iVcGgvrvISK0JH6hPVoxy4dM64kQninLWVrIb0=; b=F8kE3f5XyNPD88
	Blbm3uEKI3cyyxUqXD8zs7eT4CjabMwB19NRCgI2EtYzrFGiCckvcJOrattlC0iwo0LNyI6PrgYHC
	ec4cnkyki3rUtNMQK4LQi/HFSrPlMR0kTZQnEjxMkDMbjc1IhVQjCwM7osx0jHcPeOGCVyJ38UPvS
	JyNkThkM2qpLbHwbBikYZhWCMStqUh6+CzBamvYVj8mUSLLlWD4qhQooJ5X7NHlazbZMpRg8gg3KS
	ilY07ZAkBkjfezcw/YqSa/slJIWazJRvOko7Hi6Ktqb3WfdTbs1Qdo+JGrxQbG4WgbWT4JBYxngXL
	Xqlco0EFLL9iTaN6g8Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHZoj-00A4lm-1T;
	Mon, 25 Dec 2023 01:31:41 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHZoc-00A4kc-2f
	for kexec@lists.infradead.org;
	Mon, 25 Dec 2023 01:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGn31Ggfyk43hNuGAaCrM5bZUsGaRnDKqQvGnaU1FEpVZEgiG0RoA1SqGYyZ07btxRFllLndoCuPDw0n7b59dAW1qd/SaEKFGyktGRJZ+efary/X37CNAxfLszen724Nhy9M6hhaurHZ3byQykeWrrXEHuCpRfcBcFGv0qyyyrUKO+e/zNMzUIoJe1/eOiuvSHlMtkjjKUV57fwxxWyFmsDjqgO/j1kz97AQY1FElAVm6B4Q0NRoe5PdhwhadZSx5+YQqb8NyiqjeXb5aiDNeSjcUpgVkoxHBtajvByXhiIAo3ffKTEvIlJaztweVvQuQ9IbYzf59cKhdJMo24Rctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aveOI34RRPzQQsFnC8Sb4qX5jJCVsKqIN+tVsNiTHhQ=;
 b=f/dDib9+lOKcceAoDqU2aoTDWrD212hrN5pE2XlgDi6H8wYVTNuroGHZHBDsKJf4Sb6k17AIrrm1jiyFTKZEZf7f4ty9Pr3ghFI847MokA+VkVNImDBWnH4vTT/SH+yQZNSwkQdSfnBEIAaLRuRbCT3J4PT1uWXQiVoMy+TPO3MJRxfI7j7cvkhxNem7OQbEkK3jSY0+pnnTZwsJm77fHeTg2pdBK61D+YEpQYeM6IupiUx/KUHBxIcJaHLlyV1b/B7kI+NGsdfcpPKZtubFVmQCKOIqKDMV6qitZ7ff5EcTcIH7mRqtDkivTqsHj6Ws0HbJ2c/MkappwCRNddGPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aveOI34RRPzQQsFnC8Sb4qX5jJCVsKqIN+tVsNiTHhQ=;
 b=WuXLoNQIsYqN5k4FiaTIZ3D9Cgy+6FZrnUIrGFbixFUWTK+j41LTgq62b2cGwLTcMZ1kiVRAbmjpzLPjrjzpi4k92QDqQ/DFbLbZqZbKZ36ZeQzL9ZDn26ysQo4PbUluWv+EmciaDivYC5U5juOrppXm82JqAdYuI0z+WYIC41ka0WCdTs48a1m3TQTwPSbwntMnB2tiksD+xCgIm2Pw+xY1cWybi7GhPOpndcWNF0VETSbGnyR8PjtjV2ydzLYaXnu+O0DcUOQWOqcAD6x/ap9luqw1NCoEYTISXnFxCEnD2lyXP3Iz5KKQrfGJWH1l2OHpahCbGZyPoMoSRdtm/Q==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by OSZPR01MB8385.jpnprd01.prod.outlook.com (2603:1096:604:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.16; Mon, 25 Dec
 2023 01:31:12 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d%7]) with mapi id 15.20.7135.016; Mon, 25 Dec 2023
 01:31:12 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Edward Chron <echron@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "colona@arista.com" <colona@arista.com>
Subject: Re: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Topic: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Index: AQHaNGf+BlGAdnc0MEOwTSS/WC6IwrC5O0WA
Date: Mon, 25 Dec 2023 01:31:12 +0000
Message-ID: <f047513e-5264-9ef7-5168-2e7466bee664@nec.com>
References: <20231221234623.17077-1-echron@arista.com>
In-Reply-To: <20231221234623.17077-1-echron@arista.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|OSZPR01MB8385:EE_
x-ms-office365-filtering-correlation-id: ab2f5065-bf88-4197-a2f8-08dc04e92e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXuYEu+EeCl8AatWyhJ9R3bp34DnQKEjgqJtfewT49R0+8o6hOzzUmwC0sS4qlOZZuHBYaSXtVSKt8iAAXeh+DL6pFSd63WI0GeoWnUXsQvyIvSUTNap60wI8CPEPukyzhP/QLstqHzR0L1UPswMDAQAX9WsvICGHsWVTdgRmlmsQFa4oq1Km0+j31tgLRatiWJs6iXECqEq1QMu98rBL4OspcD1zLLumaGd3fb60/otHGXLe/ItZpHMR96Qc2NUNZWBec5bwhLpqa8BTOM4vOEpupYZJIHVIPHVeMIlQGcdc9x5uXpBaPMP1+WMUTywPuDJdPsMHTIyAuVfZp4fOsyM2QSkP/LgNkm1EYrIbt/jXJ2cTG07U+V0F20ROYo4t3a75Bj4avQKAcCd6OCl2Bt9oUrxoBw8pVAiTdktxbBuQh/QwwJAed4YWtoORdaDM6tPwherfaZigbOnzADNytjOffPj5RcjkXhuJToC0L/LyNPRLig6Gl4mtq5GtoOrfQLqA0JF0TK+JV6t+m7gkm54x4ITxuZp4ZZu3kNpZyCSKMi7NEb+ti8Y+mM7lCQKAnlNNDDTU9B/S443IJnZWpasWz8MyvtC7h13c8pCUUERD89n9qjW0uBm+sGPGlgRfXSf0xy904CRulFUQgYX39wkbljumTUALRm6oK4UNGIhj3+aG93l+7qA8z657C+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(85182001)(82960400001)(38100700002)(122000001)(41300700001)(83380400001)(38070700009)(31686004)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(110136005)(4326008)(8936002)(8676002)(2616005)(2906002)(5660300002)(6486002)(30864003)(86362001)(55236004)(53546011)(31696002)(26005)(71200400001)(6512007)(6506007)(966005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVN0NGt5eUZpckdCWFN4emR3TmlkRnlhaGpZeVRTTVNCNmFvSG15bnFHUkpI?=
 =?utf-8?B?L2RTRTdTbWI2UFlKcjcwMXJJL0ZCVGxFdVdoOHZXaVZ4UXpSZk02WGRxNkky?=
 =?utf-8?B?SzNwcFh4WE9rZFRrSUJyS0hBUmk0Qlp5RWFXYVkvMmF5Z2hsQndJVkpPWXB0?=
 =?utf-8?B?b0NLZHVJWkhWQkJoY0RjOFhCdmFiZWp6THdVQ3FKOERHTmhKN2RseTFKYmxr?=
 =?utf-8?B?U21SbzFJWmV1MWowZzlHN3ptSldreDArN2RWU1JkQXM2V1J1UGlKdVBHYS9E?=
 =?utf-8?B?Y2FLMGFXRE9pSFp4WHU0Y1A2QnRDb1dNRS84V3ViaERFOTF3SncvRUZCQWF1?=
 =?utf-8?B?S3FzU3NaZmNkb3hNQ0ZlMFpPOHFYU3dGYmp2bUg0OVJNb3ZiZTZxQXNONU9B?=
 =?utf-8?B?TGo4dlo3R3orTlBoM1hxZWNpT2IxWjdzSDU1QXBwNVc0U2xXQXkvNjF6VU5p?=
 =?utf-8?B?MkI4a3BYcUc2S2Qza3JoTHFzNHpKUVZiNWxGdkxnaUsvU1VDYmRWZmlPRlRS?=
 =?utf-8?B?YW91djZtZ3o4TmUrZFNYL25WUXhlYmw2UTl6d1J0SEgvem9Rb2FyQ0hnVVU2?=
 =?utf-8?B?aW01SU9FQzdHU09uTEprbys3dmdxWXpmKzdxdWt3aVE4TG1hcWI1RFY5V3Mx?=
 =?utf-8?B?S0VEelgrY0dtcWl5bFdLMHZqUVdROHB6V1pGQVptNndrRTVFdktCTWt0VEIw?=
 =?utf-8?B?UEh5OVVHalFTM1ArcWc2NlVNcERhVzJqNExYL0dnbWJJK1UvRDd6MVBnOUN3?=
 =?utf-8?B?MW01bXNpR1YrR1g4UC9pT0xrcDVPd0NMMnJPMk8zUVBsUmxhcTVxV083a1Rz?=
 =?utf-8?B?VnhlRUVIVTh3QnZNM0lXTVhLeFM2QVR1S2hTRlF1eVd5bHFLUDltYVhPSmtL?=
 =?utf-8?B?T3J0bVN4SHNUTTVOUkhza3dpQXFCRG5FRk8xdEIyYnR1enptUUlYQjRpOVdk?=
 =?utf-8?B?Q1JXcmhiOTM3NzlKODNlM1JBK2UxQ1NPZHBxTG9hblFuUFFtWUdnNjVZQWkz?=
 =?utf-8?B?ZXNORjB1d0JwVFRLRkNxNUtrR1JiN3QwemRsVXBjRlVRejZCYUt1TldPaHpM?=
 =?utf-8?B?L3Y0ZzZVV0ZkemEwMWc3NUl0ckhDb1NxVlRWODc4eXp0RUJ4NXpCQjRxbGVX?=
 =?utf-8?B?VDhNUlV1czFHempZYmJNU2VhelhlMkVTQkxCQVZYRkxkTUtoM2lkai9UMDE1?=
 =?utf-8?B?cmtJK2ZlWEVtUkltQnp5elpnakcvK1pHN1I4a2U2TC9UWmVYVjdsLzREcWhE?=
 =?utf-8?B?bWZNNVBEaUVZTE1NYnloajRhbG1ZaDFqMkVmMVhkRWlKMEhZZDhDbXFNeUho?=
 =?utf-8?B?OTZVZWpLZ1VqODVJR1Q1anN4RStxWTRGbHVkUmdhRVV4S2pMNUhwY3AvTWgy?=
 =?utf-8?B?dkIyMXBrb011bmFvWGZuaEVFUGhGOHByVWdjU1pzcUdTUHZua2Y2eGtKaG53?=
 =?utf-8?B?Z3RyMTJTYVFRS0VpTElhQndSckExZDdwYWVsU05JV05qVFVqdi9wUDg2NWdu?=
 =?utf-8?B?aTRKb3JtNEtRM0pOWWN6Y2kxR3NiWWhiV0R2MUltU1MvQTMyWDRDRHRzWFp1?=
 =?utf-8?B?Zk81eHVBcWI4OURtOHNWeWM3akowdUZuQlRrNis2Zkk4eE1LaVVVanBLWHNn?=
 =?utf-8?B?SmJUaE1id2Fhb1pNUC9mRm1tN3NzcUpSNW5lbXFCSjJrYldwRkdORnVMRGZi?=
 =?utf-8?B?REZMMG1EUUhxREdGQjQ4aHNDRUZmM3daUUlmellWaXFsVzA0WXpFL0pGL3Rz?=
 =?utf-8?B?UHg5MTBwckhxeVNyeElOOFMwK2JMRUFjeVREWGF0T1RkaXE5N2Uya0dleVVw?=
 =?utf-8?B?dnZuRStIUzMybVpldEZaTWhxNlFITEJpSFBTSWJRTkRYeXJJTDlGVU5kV3ZH?=
 =?utf-8?B?NWM2NG1pMTdBbFdYbno5aU5MSllyU2pqSDlES1A4M0xaVnlBc1NBeXJLUEtV?=
 =?utf-8?B?Q2E2bGJEc3Z4ZEFIT0hQUXhGMEZ1M0JpaWN1NllhSjc4WmdYZThvMU5PL0pz?=
 =?utf-8?B?NVRQZGtJc0hPMSsycE1aM1BDTUtwQU9HZFRwUEdPYVBJVkw4YUNKY2FWRmpm?=
 =?utf-8?B?NytDZW04dGIyV2F0cUVwYUNzd0wwVEFyV3BVUjJXQzZ0YVpzQmdrTWR0Q3U3?=
 =?utf-8?B?OFh0OE5WNFo4d0VjTEhvOGhJVUpldlJXeTMzU09SQ251MWM1anduY0ZOK2RY?=
 =?utf-8?B?UUE9PQ==?=
Content-ID: <3D95F091338CAB44850DBE7D331111CA@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2f5065-bf88-4197-a2f8-08dc04e92e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 01:31:12.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8APY4O0EpsNxZfVYoRf/laqn5bDo+PffPUyKr4VnaALkHcuPjTT0RDryYd2qflOm8MWuIPdCsOTp1TeUyyd8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8385
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231224_173135_292517_4FD6BCFE 
X-CRM114-Status: GOOD (  36.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2023/12/22 8:46, Edward Chron wrote:
> Submission to Project: makedumpfile
> Component: dmesg
> Files: printk.c makedumpfile.c makedumpfile.h
> Code level patch applied against: 1.7.4++ - latest code pulled from
>      https://github.com/makedumpfile/makedumpfile
> makedumpfile Issue #13
>      https://github.com/makedumpfile/makedumpfile/issues/13
> Project Owner: Kazuhito Hagio <k-hagio-ab@nec.com>
> Revision: #1 on 2023/12/15 per Kazu ensure spacing of dmesg output
>                             matches dmesg -S and new dmesg caller_id
>                             output format (space after timestamp)
> Revision: #2 on 2023/12/21 per Kazu use NOT_FOUND_STRUCTURE for caller_id
> Revision: #3 on 2023/12/21 streamline code for printing caller_id
> 
> Add support so that dmesg entries include the optional Linux Kernel
> debug CONFIG option PRINTK_CALLER which adds an optional dmesg field
> that contains the Thread Id or CPU Id that is issuing the printk to
> add the message to the kernel ring buffer. If enabled, this CONFIG
> option makes debugging simpler as dmesg entries for a specific
> thread or CPU can be recognized.
> 
> The dmesg command supports printing the PRINTK_CALLER field. The
> old syslog format (dmesg -S) and recently support was added for dmesg
> using /dev/kmsg interface.
> 
> The additional field provided by PRINTK_CALLER is only present
> if it was configured for the Linux kernel on the running system. The
> PRINTK_CALLER is a debug option and not configured by default so the
> dmesg output will only change for those kernels where the option was
> configured when the kernel was built. For users who went to the
> trouble to configure PRINTK_CALLER and have the extra field available
> for debugging, having dmesg print the field is very helpful and so
> it would be very useful to add makedumpfile support for it.
> 
> Size of the PRINTK_CALLER field is determined by the maximum number
> tasks that can be run on the system which is limited by the value of
> /proc/sys/kernel/pid_max as pid values are from 0 to value - 1.
> This value determines the number of id digits needed by the caller id.
> The PRINTK_CALLER field is printed as T<id> for a Task Id or C<id>
> for a CPU Id for a printk in CPU context. The values are left space
> padded and enclosed in parentheses such as:
>           [    T123]   or   [     C16]
> For dmesg command the PRINTK_CALLER field when present is the last
> field before the dmesg text so it makes sense to use the same format.
> 
> Signed-off-by: Ivan Delalande <colona@arista.com>
> Signed-off-by: Edward Chron <echron@arista.com>

Thank you for the update.

It looks like a few fixes are needed, but I can fix them when merging,
so there is no need to update.  And I will apply this when the upstream
dmesg gets the PRINTK_CALLER support.


BTW, I tried the dmesg of this version [1], its caller width is 7 and
different from makedumpfile's 8 on an environment, is this intended?

# cat /proc/sys/kernel/pid_max
4194304
# ./dmesg

[ 7971.766029] [T109202] XFS (sda2): Ending clean mount
[ 8700.508829] [T1053218] XFS (sda2): Unmounting Filesystem ...

# cat dmesg-makedumpfile

[ 7971.766029] [ T109202] XFS (sda2): Ending clean mount
[ 8700.508829] [T1053218] XFS (sda2): Unmounting Filesystem ...

personally I prefer 8 also for dmesg, because recent kernels have 7
digits (4 million) for PID_MAX_LIMIT [2] plus one for "T"|"C".

[1] https://github.com/util-linux/util-linux/pull/2647/commits/7e485b720638
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/threads.h#n34


The following comments are just my memo to be fixed when merging.

> ---
>   makedumpfile.c | 25 +++++++++++++++++++++++++
>   makedumpfile.h | 22 ++++++++++++++++++++++
>   printk.c       | 18 ++++++++++++++++++
>   3 files changed, 65 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a6ec9d4..eaa8c4d 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -28,6 +28,10 @@
>   #include <assert.h>
>   #include <zlib.h>
>   
> +#define PID_CHARS_MAX 16	/* Max Number of PID characters */
> +#define PID_CHARS_DEFAULT 8	/* Default number of PID characters */
> +
> +
>   struct symbol_table	symbol_table;
>   struct size_table	size_table;
>   struct offset_table	offset_table;
> @@ -2118,6 +2122,7 @@ module_end:
>   		SIZE_INIT(printk_info, "printk_info");
>   		OFFSET_INIT(printk_info.ts_nsec, "printk_info", "ts_nsec");
>   		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
> +		OFFSET_INIT(printk_info.caller_id, "printk_info", "caller_id");
>   
>   		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
>   
> @@ -2133,6 +2138,7 @@ module_end:
>   		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
>   		OFFSET_INIT(printk_log.len, "printk_log", "len");
>   		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
> +		OFFSET_INIT(printk_info.caller_id, "printk_log", "caller_id");

This should be "OFFSET_INIT(printk_log.caller_id,".

>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -2462,6 +2468,7 @@ write_vmcoreinfo_data(void)
>   
>   		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		WRITE_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2470,6 +2477,7 @@ write_vmcoreinfo_data(void)
>   		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		WRITE_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		/* Compatibility with pre-3.11-rc4 */
>   		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> @@ -2921,6 +2929,7 @@ read_vmcoreinfo(void)
>   		READ_STRUCTURE_SIZE("printk_info", printk_info);
>   		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		READ_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2932,6 +2941,7 @@ read_vmcoreinfo(void)
>   		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		READ_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -5604,6 +5614,21 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
>   
>   	bufp = buf;
>   	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +
> +	if (OFFSET(printk_log.caller_id) != NOT_FOUND_STRUCTURE) {
> +		const unsigned int cpuid = 0x80000000;
> +		char cidbuf[PID_CHARS_MAX];
> +		unsigned int pkc;
> +		char idtype;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(logptr + OFFSET(printk_log.caller_id));
> +		idtype = (pkc & cpuid) ? 'C' : 'T';
> +		pkc &= ~cpuid;
> +		sprintf(cidbuf, "%c%u", idtype, pkc);
> +		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
> +	}
> +
>   	indent_len = strlen(buf);
>   
>   	/* How much buffer space is needed in the worst case */
> diff --git a/makedumpfile.h b/makedumpfile.h
> index f1619c5..0a7acb5 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -2116,10 +2116,16 @@ struct offset_table {
>   		long	p_memsz;
>   	} elf64_phdr;
>   
> +	/* The caller_id was added by the Linux-5.1 Kernel to hold
> +	 * the Thread id or CPU id of the caller adding a printk
> +	 * dmesg to the ring buffer. As such older versions of the
> +	 * kernel can ignore this field as it won't be filled in.
> +	 */
>   	struct printk_log_s {
>   		long ts_nsec;
>   		long len;
>   		long text_len;
> +		long caller_id;
>   	} printk_log;
>   
>   	/*
> @@ -2671,6 +2677,22 @@ struct elf_prstatus {
>   
>   #endif
>   

> +/*
> + * Minimum size of the id portion of the PRINTK_CALLER dmesg field if it is
> + * configured in the Linux Kernel. The size is used to pad with spaces the
> + * PRINTK_CALLER field in each dmesg. For 32 bit kernels the maximum number
> + * of PIDs supported was 2^15 so pid values 0 to 32,767 while 64 bit systems
> + * support the value specified in /proc/sys/kernel/pid_max which is capped at
> + * PID_MAX_LIMIT. We can use 7 digits as that accomodates both 32 bit and
> + * current 64 bit systems as PID_MAX_LIMIT is currently 2^22 so that will
> + * fit in 7 digits and the id will add an additional byte for the id type of
> + * either thread 'T' or CPU 'C', where the Thread ids will have much larger
> + * values, so the CPU ids will easily be accomodated. When systems exceed
> + * 7 digits that won't break anything, but print statements needing more
> + * then 7 digits will not precisely align.
> + */
> +#define CALLER_ID_SIZE 7

This seems not used, will remove.

> +
>   /*
>    * Below are options which getopt_long can recognize. From OPT_START options are
>    * non-printable, just used for implementation.
> diff --git a/printk.c b/printk.c
> index 61e0b26..88ff396 100644
> --- a/printk.c
> +++ b/printk.c
> @@ -1,6 +1,9 @@
>   #include "makedumpfile.h"
>   #include <ctype.h>
>   
> +#define PID_CHARS_MAX 16        /* Max Number of PID characters */
> +#define PID_CHARS_DEFAULT 8     /* Default number of PID characters */
> +
>   /* convenience struct for passing many values to helper functions */
>   struct prb_map {
>   	char		*prb;
> @@ -114,6 +117,21 @@ dump_record(struct prb_map *m, unsigned long id)
>   
>   	bufp = buf;
>   	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +
> +	if (OFFSET(printk_info.caller_id) > NOT_FOUND_STRUCTURE) {

"!=" is better for the code consistency.

Thanks,
Kazu

> +		const unsigned int cpuid = 0x80000000;
> +		char cidbuf[PID_CHARS_MAX];
> +		unsigned int pkc;
> +		char idtype;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(inf + OFFSET(printk_info.caller_id));
> +		idtype = (pkc & cpuid) ? 'C' : 'T';
> +		pkc &= ~cpuid;
> +		sprintf(cidbuf, "%c%u", idtype, pkc);
> +		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
> +	}
> +
>   	indent_len = strlen(buf);
>   
>   	/* How much buffer space is needed in the worst case */
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
