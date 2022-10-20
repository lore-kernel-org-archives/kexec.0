Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2468DC43217
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xDroe1CYFUOeIAEkD2qcscn207zB+CmJ4o3OT2x8wJo=; b=Z/ugjzVsfQR2IF
	c7dmZ8cuLfMlObzhUYrLvs2JA8d4RTS+Iah3C3s7P4KC4HtQM/VIe18Te6hioKYgESkwyoX0oRrax
	20reylrfxUWrkNHeHKU6gqyTnX3PHxzPxrmhfuVAUlbLIOZugYdPJ9nQW7EB1xKc07WZz8KgIFYr4
	MRyZXiWVR47YYW0SMR/OyS5nnaWqK+R8vLMf+MAoSjn3nApnT5b6GEsj9EfL+Oi/56XrbeATNWUUO
	mM9nCKllJ9vtFTKwgw+D1zMGrp5nhmXH88VF/X7JZgE0SiMuWGWd8iQmwjVV57NhHrtai0qELxxVb
	BgtZ1uPOekpOCycmU6RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olJv8-008krQ-Ft; Thu, 20 Oct 2022 01:00:26 +0000
Received: from mail-os0jpn01on2061.outbound.protection.outlook.com ([40.107.113.61] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olJv4-008kpi-T9
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 01:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UprRMGFvnC/ZKc/7cZvUOfz/K0n0AKssX3RbdAMe7YHKeruch819WOgOEyj7zNTPGCEwueMYK3oNFV8SNCWd0OYas8cyQh1m1y5s9lj9q2DhQ1eczCzQw6yJf+KjgVSw1rwGaXzmQ6Pqn8+WdIxkcRZqzGsp8+vrJsnhR4yljeKvKAJVB3Y5gMQimb0pIYf28EilMeM7EenvkZqdO53IaK6B0aFkmYq9jXIpTkBApwOmRPOwbcOiW+0yMPEyKdMcUCWhQkHtl8+MLekfEd/UgFD79gMpucD+MbWGKNoPUC8CbqaE1NGho4+2Hq+TC33amEutfuHH/ioQdAuT/brYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QW2zJ7Fy+5jr4+NLSAeP5mxgXYZcJWPyEDuEBBCmW4=;
 b=oPCcKbf0Mhqo3bEY0SKpfzaHCPHkarj4PsF1QAWksqVNcgEpdzMt3gqpSKN5vqAboqQ/xrDxANych/bV9wj3POAVQ45sCDacF9aizMDmn3Zk76eyPvRTL+zYHg4hFu9vzjv05cnn4YQHSaTNp9qAT9mMpcVIXFc5FTHWbVdPON39xgFGMIf2AaCqJJsGrHPRvu3crr0IYd6UVctzeIYx/z7JGiLh1sdkpa7JXrMJ+ziAIS5gVg1yJ4TTWYjtTZ1XfDt7gzA0tnokSgKbssP/CHz6KcWTuhbCXG9WBYhLuIS+THTR4z9pN83DHW9ly9TskdsGghbwDjiflvrJ1vhgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QW2zJ7Fy+5jr4+NLSAeP5mxgXYZcJWPyEDuEBBCmW4=;
 b=REWWjNI2KPhb+pNHouJaI2ZxbW84NCSH1vWr7DC9oX3zI9/h8dmMd9eiAoARqC+CroGAdt83HcUosfmKGaInoOVgVgUaPbCkvI7VtbYbIXC7Wqf7SyRFp+ipcH36PrU5AwuTaaNR8uBZDAHZSoFa0+lrRXlJEHZYfY+KwGYamiw=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB10692.jpnprd01.prod.outlook.com (2603:1096:400:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 01:00:04 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 01:00:03 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.2
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.2
Thread-Index: AQHY5B9J4N2UOBMzbkeno9GkoSeH/w==
Date: Thu, 20 Oct 2022 01:00:03 +0000
Message-ID: <b23bf14d-67ad-dd9a-1b43-4a2fde9a7fe1@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB10692:EE_
x-ms-office365-filtering-correlation-id: ced9466b-d5ab-4b30-176f-08dab2366c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qXIfdXx1432GDahVZwOphDl8fDXaJtTu5CJ/MK/Nk2Zi72Yduj7nJL/9PNsEGqTKzX1XaPtnVUsGxoiLeEGebOuCZuuF4cNPlbzz+1uh2WaJpPjNTHz2WvQs1LS30seMYtVVIQtfSlsfffsNQq0opfJhXLt3hY8oKyXzJypisQOD/BDjanFbPM9ONmIEbl08ga9WZkAY1TYDDik6OMF1u5PHfopTGtQLjCdh/WMK//zz95oeayOT1BxBLAfXcfClW6yz4vmiU+2FwV7gElU/ScZfA/S4UfmhtjDL8HHncP/S4Jzk0rTl3EXB3NkFVJk0uYx7Ak8v1RcWxqn/6gsmabpDdRgB/Vzbl0lBIV4fwNoXrCUoiJaSklYFEOD1HmzWHbeuWuxlL1ovALjpMw+4ID/OCSZn6I3qs9D7wJ3vXYPtJhQ4fu58GVjERO05fizaB+FfLf+5+7P1GOgb2oWRqjhFaApwXJiXUoCrZlKi33+aFgVO95m/v0kpWzZ04oGEfwZyc2BLcmSbUAa4VO+5mFxkfg3lsPVImAd+f3h8LBZtjZQV0Hz8hGhW7v1jQqAd2KzdFtbnPvhHcIUIN+nzrr04+lk+xN15l9dU5NsN2hEE76Of51eG6qHQkii3LbA/adzLhiGEQ/7FJDp0Og4DqlVrAeQw+tde6F/eL5ziAZg41lAgR4DF7A96zF6ZSEWT+La5C9bowmV6lgRvERZvKbttx8eIINyiDFxD9Ln+Fn6nQfLOaSnV29J6gztgrmzQ6cDtvQYfDEp9Kr6oqbvsQfZiZI8Sqjge7qoB3xQu6UOv18KXcTHwlIw3yXlgb7uXC09Gliyoc+mgsL5fsgfQgH+JnQs/QVvaf4gNhm9ntGo=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(85182001)(82960400001)(41300700001)(36756003)(122000001)(55236004)(6506007)(38100700002)(8936002)(66946007)(76116006)(6916009)(66446008)(64756008)(71200400001)(66556008)(66476007)(8676002)(2906002)(5660300002)(316002)(38070700005)(31696002)(83380400001)(478600001)(86362001)(31686004)(26005)(6512007)(2616005)(186003)(966005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TDFRd04yL2NRdjl0djRkNEN3K2tqS0kvZEwxU3cxN2loTEsycmI5L3Bvdnhu?=
 =?utf-8?B?YkF1YVhEVmRoekl4SVQ3ZkhMMWU2bjNjaUpibUp6dnl3NU40R256ZkxjamUr?=
 =?utf-8?B?VkxGd2pYcWhmVkFZNVFYNU5VRDhzbWpZR2VSOHBjWmxpMXQ2QlhEay9Ccyt1?=
 =?utf-8?B?MkRXMlN5MkllQ1B2TFBtcm1EU3lmMWlpVEpOdC8xZ29mRzEwTVB1ckFXdjhQ?=
 =?utf-8?B?c2ZyaEdqQXhuc05TQkxGVDMvRHZSTHEzU0FzSVhQZkNYK2w2Z0tIVFhDOEt5?=
 =?utf-8?B?b1RMSzZZcWUwN1UwZGRBdkliSTdsVEViR2RiKzBJaVB4UWlHN3JsSE5DT0o5?=
 =?utf-8?B?MVRSbmVtYXlNb0hvRnFJaVZnVzJueVU3QUxCd3AyUEdXK1l2bWFqU2srajVp?=
 =?utf-8?B?L2t1K1FiZ0xLUkRyS1JmZkh2MkV1M2lubjVqUVRuSGVEMHFYQWRnaUxCZWNC?=
 =?utf-8?B?TUdpVnZrQ0EvU0NOMUtaZmxzNHU3RFlYVmR5Q3RmcGlXUkFybmFzOUFzb1JC?=
 =?utf-8?B?aFoyZXJ4U2F3L3pSeFhkNGRkZXFER2hoNUxpaW9CTlVnMDRveitEM1lkSi8w?=
 =?utf-8?B?cVJXTXpZK3dHSFFob3R2MmdJZU4xTW1YQStNRnR1aHAybk9UYm10L3dQcU1v?=
 =?utf-8?B?K3N3NThDMjN2UkVLMmR5SFI4ajF5K1FvUlgrOEpzVndZd3ZvQ1ZjaEdSSG5Y?=
 =?utf-8?B?T2RrSGZpcVhkdWpOWTVTanlWeFl5WkdsdjlNUzdXL3E2bmRLSjNiNm5lU3BE?=
 =?utf-8?B?bVozcDBJNjJoU1o0MGJ4OVJTTW82bjV5UEZ3MzdLenY3RnorYlpiU3ptcThr?=
 =?utf-8?B?dUdFSkE2amlSTUtzTy96bmhzVzMyZkdqR21RSTJUTDU3cDAyTnBKQ202RCtQ?=
 =?utf-8?B?OEl6TVVsSStpTk9EZXY3cGpmRzV4QXBJU1Z4bEQ2aGtOaUorZlBzVk5udTdq?=
 =?utf-8?B?UmZrNVRtSUFBUVNmZTVlVWI5blg3R3F0UTFOcGdYdnBVVnNyK1hLNnU5YUhv?=
 =?utf-8?B?T2ZWT2dWK1NaTkxuOGR4SitkMVVvVU9xbk41c1lJWjZxdXg3NmF2V04vSmFv?=
 =?utf-8?B?czNoNHRqam92Z1Z0TmhYQ1M0UEFOM01HWmtRSDFmbUkzVXRjSVk2a3U2ZXpV?=
 =?utf-8?B?TC8rYm5sMFZNVmYrei9GcnVzdnBaT1A2R2tydytKSStBMGV6R3JZZGhYRTFU?=
 =?utf-8?B?bjBiZmVNQldtRXRjcW14N0JXa05uelFnb0VoRVR1d3pidEwvVklRWkRhcUFp?=
 =?utf-8?B?dUVKS0R2QzNONHZmL1haSHJtNXRrVjFlQUJrNjhpbGZLUEpXaXhCWjBjbzVY?=
 =?utf-8?B?UmFHWnJ4bHRVU0tVMm1JZ2ZVc1RQS2dWOVlFT0FsNllKVTBmRm5WQWIydTZT?=
 =?utf-8?B?dkZSVlhrekZJSXBjOUlDUWszRFdKWXFHaDhIbXAybFJEQ0w3MFVaemFwUFRw?=
 =?utf-8?B?L3dIb29VdVZ5MktCdEQwR0puVC9zQlpaanUxaXVKMnh0VDJPcVhNcFVadkVW?=
 =?utf-8?B?M0hnQ25PRUVTbGdzWGw0ckFqVEhwYlpnekRvanFkdEhlS1AvMCtycC9oaWpu?=
 =?utf-8?B?SEFFRXZ3ZHBtdndOSS94NHBxZmVMZmd3bisxSFk3WnZtZWpha2o3N1p1aVdY?=
 =?utf-8?B?Wm0ySUZQQWNHbUJPRGM4YVVrZFQrTzRZd3JLMElSWkVCOHJTeU5rSjdjdWht?=
 =?utf-8?B?VjNib21JdTJXZWdZaUZQb0gwbEZQMzhjSnJGem1YMk5hemVreTNmQ2ptb25s?=
 =?utf-8?B?cFBmZUI0cFhLSU5zQ2kyQkk5T2pCdllOUXBDYkszWUtwTTV5M0hkMjMxVHNN?=
 =?utf-8?B?S1hyb2NDRFlwbCtLbHZzSHk4cVEvNHBlLzFOR01IOVlRU1Z1MldsV2J4R3lU?=
 =?utf-8?B?Y3hUT01FV3plVlVLb21zUjl2MTh0azd2LzRzK1JmSkRjR0cvc2F4UEpYY2Zi?=
 =?utf-8?B?c25mbVRobEllVUowdlBVaWxoOC9NUjcvUmYvMVhOeE1wMlpseDVZQ1Jtdzh4?=
 =?utf-8?B?ajhQYU1yT2xPZHIyKzdISUxtUzlOcG1WcXdRRVpncGVjS1NoNTJML0Ezd0w5?=
 =?utf-8?B?Sm1URm0ybzA5dGpsZWJxdXJ5a2Q2SXcvREVuNmxpamlrVkR3VFBLamd3SkV0?=
 =?utf-8?Q?UpNTLFhx/6TxlEckefQLkbj1L?=
Content-ID: <1E15893932160047ADE47D84C15070FE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced9466b-d5ab-4b30-176f-08dab2366c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 01:00:03.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mn4BTszMfIX4mwhSKre4xv9eLht6q6i0zTVmxlYqOUhbdE8T79kTuY4wTDHV9hVcN+XkiTT/hBcegCLN2qbZuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_180023_401802_1E450E92 
X-CRM114-Status: UNSURE (   8.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

I'm pleased to announce the release of makedumpfile 1.7.2.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
   https://github.com/makedumpfile/makedumpfile/releases

New features:
- LoongArch64 architecture support
- Support kernels up to v6.0 (x86_64)

Commits since 1.7.1:
9fefc68 [v1.7.2] Update version (Kazuhito Hagio)
e9ffebb [PATCH] README: Add a FAQ about public key and adjustments (Kazuhito Hagio)
a213694 [PATCH] xen: Fix wrong free issue in init_xen_crash_info() (Dietmar Hahn)
787a23e [PATCH] Add initial LoongArch64 support (Youling Tang)
36cdfd9 [PATCH] mips64: Replace hardcoded values with macros (Chetan Kankotiya)
09b5c87 [PATCH] Makefile: Avoid installing files in /etc (Guilherme G. Piccoli)
6d0d95e [PATCH] Avoid false-positive mem_section validation with vmlinux (Kazuhito Hagio)
4a4a2c2 [PATCH] Mark start of 1.7.2 development phase with version 1.7.1++ (Kazuhito Hagio)

Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, in order to shorten the size of the dumpfile and the
time of creating it.
https://github.com/makedumpfile/makedumpfile

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
