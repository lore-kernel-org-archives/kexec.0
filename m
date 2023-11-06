Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A4DC4332F
	for <kexec@archiver.kernel.org>; Mon,  6 Nov 2023 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JlVbu4/NyiQsxoR1SHZALCuAo4+hdM2QNDRRNVgTCTw=; b=rO9z5ITDK6RqrZ
	dO3iPhjFHHnvOCuGC6Bmis2zwWIo6rZa3YpZ6D/mRq11jnmxCplno+tFSBMG7oom4DNq4ouHF4qKt
	eRK1PpawYp6sYpYo22gdhDyUi1oVOVJ87puDLYUwXlncfHWUFi0eC2jPRXIHVmlCOP5NAGHSS9u2m
	076BbWPARGzfsqLNf+vfR3F/yJTYgFE/dObAXF8zXJwYKmbHANig/S9XLCDdbrVWOlZsxXpStGFM8
	060sfvdUL3ey0VZM+1uJfwBUVdTZgADu8Ejv/dcu7LMw3bSFBdaEOZWVmO+oA7kDmROr4qfN3usR1
	wHyeCZpGfW8gnEi0qA5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qznqD-00FgPa-0C;
	Mon, 06 Nov 2023 00:51:45 +0000
Received: from mail-tycjpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:2019::601] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qznq9-00FgP4-1H
	for kexec@lists.infradead.org;
	Mon, 06 Nov 2023 00:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGNe8IA16Fl15gEgwEzr4Nez08yCWlXCCpbnLtoFbUY32hoDiXaMDcDn2HRFwM4ENTjupCMgNtT1/aYFI4BXbTqAj3b8Hf5hTUmhBhNCgqCucUululXxSIhbe3VzWNsV1D5T4ffOWsPRXVfwu1oTGgfcJWDSAD4+yKdT7gpbqvBRDoW9MwpvyiaE5zllF1WdJsMPEhihKeTN8SXtZpShPCep9R/N1YE7mynXHT4aP6gYURqgkRL3zI246OszvZIDCSp7HMQeiHRsAj09t+20z4uzmy8b040Us582cF3PkZnkWdE+1NMgHb/GpL9+i+eET3KCNy0wSGZMAdMAexONFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv6HsqXnDonliGCxGYdyFjBXfKpKFe/1s7QmD5XqNSw=;
 b=f7qqOtKa6lVY/8/aq9GcN5+IMedr01GrXhyUfZg34tCPsvlDcRAZdRL8LROXQZKchjHM+HjQF68LlNaRIJSeZXk5YLgs1EOmTjpd7EtmlKAx9SSkGfAaIL0XACA3/tmoyL0soqXyJxZwi8fzlv3kYz+xZw6dVSjoha8VcIUNDvphZ8msQd0PJhsYqP4VqPJxQ4pJcfHd4h8b026Yc/AMGAapF2gwcJ0zoVVTlFxH8FimJdOLBIaI7DJgTlFlpe0DzNMY5PSoVqGwdFsKEdpBvv89EgHQe33Trq42/jnCnGR0qlQGQ2wh7qtYEgn98Ez/udEUvR3jf4F9EAhSesbobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv6HsqXnDonliGCxGYdyFjBXfKpKFe/1s7QmD5XqNSw=;
 b=k8eYKzALZVi0rpb/AfPZdtg/5KjqlbnV8+VVI8Dsjnyp0JfaUUAFrRYBccat5jWgJYM85x8eGERbPn7AgKidYwJK8nhBS6rHAqoRLtkpJvZF5X1DNcDpsogm/z1r8xEcBCU1TF1zTXthIb4lYp1t9nhw3BgNa5QmiLn9nb9diVY=
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com (2603:1096:604:126::6)
 by TY3PR01MB10207.jpnprd01.prod.outlook.com (2603:1096:400:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 00:51:18 +0000
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::3d7b:606b:99e6:134a]) by OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::3d7b:606b:99e6:134a%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 00:51:18 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.4
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.4
Thread-Index: AQHaEEtaFkyQ/kNGpk+yxfER+BW2ew==
Date: Mon, 6 Nov 2023 00:51:18 +0000
Message-ID: <957cc195-6522-582f-3455-92f92fa49036@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6776:EE_|TY3PR01MB10207:EE_
x-ms-office365-filtering-correlation-id: 3a035fad-34e2-4d95-81d5-08dbde627cb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoRiUbLGrYwvmkb9a+y9ulJVfgfcrrHW/c4CcCF3cgixVu+q0jSl8QXc/bbcXgRMpEVYGjsANqPTrPhl+8o92Yp/S3NAxVQflAyZgAEGlKTv73IjVpE/uXyo/zEDXctj+uzhfOG0OsxzTDJJx0GYcrq85I9Bb8aiuJKsS1IfDO0XmltfjRlae3oWr61ABWnPInRZeD/vjhqTOP1GWy2izDUNT1zojI0ZCRChcB9zX+p29FgfNBWKVWXqoLFXoFeHcxlPf9VgRziuI8R2QuVbBzPWDWOyRCMYE8mYNfCAPkuCOYwVAmfAfDhrPt9XOGr/Kg/TV7o/XmC9N0grpm5vOw9YwC1jcghHe6zbSell2Eza0Z9Woamp1/jEZ6VxHthMOSCRUyHUrPTYA097LEU8qmEQYxOFZ9fRiiDVZYO5f+xEc2CLr6WdU9QyvRqRnQzRlFJrOMeEodRF1vj3dl/Rd1cLINXilON2thZN9jZkjZXkbyJflwl7HK0Ymqp3Vq22Ep6lsdebQPQ9lp1S24fxSXdpvUPb1UizEBe4mFn8QovILnc44irghVxpStoIGpQasIjBhjIOQLqalzw3dns5UAx1VLbynSrF8jcStT5Du/wkp9AN/wYJ/bzNj+bSqholr1b7p/Y9ouNo81PWJGBDYdsN42hQ5kMR2sLDC8G1tpal4n+QVCviucnjg8szWFWv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6776.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(85182001)(36756003)(8936002)(83380400001)(8676002)(26005)(66476007)(66556008)(66446008)(66946007)(316002)(6916009)(64756008)(91956017)(76116006)(5660300002)(2906002)(41300700001)(478600001)(6512007)(966005)(6486002)(71200400001)(55236004)(6506007)(2616005)(31686004)(122000001)(82960400001)(86362001)(31696002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWt5czBub1ROalNMMmc5SkE2Zlg4NGhoYUpqdE5PZ20zdzl2c3ZjWmpjbEU2?=
 =?utf-8?B?bElrUTY3N1ZTTURJVnR2TFFCT29LUElEcDdVdElXRHpURkNpSk9xYlFvNXJa?=
 =?utf-8?B?ZllPT1Rva2kyUmRpSXNwTU44YXovelJnejJxR2lUSlFjampGaThGY2NmRTFX?=
 =?utf-8?B?aXVCa0ZXSkhTSXBYK2dFTlhTeHVnTmpUYjhyckp5cTlYVDk0VU5OdytOVUE4?=
 =?utf-8?B?Y1loaDdEdkRXTHlNY3F3bGdBY1h1T2IrekJVQUFxZncxRTVWU1ZBRWtOeXZt?=
 =?utf-8?B?MzhVWFU1dnJiYVE4ZjhvZWZoYW56WWFIUkd2MzFKRndXT2sra0dYbFFCRnlS?=
 =?utf-8?B?RHJHMnVVdFNqQ1FFSDBZR2IvZjEwU1dyRWFMVm8rTVdnVHVzNXJOYU1qU0Jh?=
 =?utf-8?B?akJ3SVRZTmZaS0Q1N1JSM2ZHR0lHSDlScnRXREZvckc4RjQvdW9ENm93TW52?=
 =?utf-8?B?bWFHY2dVSmpualZPMWZvK3llT1hKdWtMR3BjaWNqb3k3UFdsT0N0eStQNzFj?=
 =?utf-8?B?Mm1hVTFvUHR5Y1FBTld5ai80MnlXZFE0WldTaTZvWWl3MHFKUzg1dDhjOEtH?=
 =?utf-8?B?RHNPUHk4enE5VGJnWmx5UUNITXM2NzdKWGs5bUpVSWhBeWJUNnI5RzlDNENX?=
 =?utf-8?B?aTMrVFVKRVpHWVo4N1NNbXRhTTB2T3E5RTl2bzFpNEVka1JxcHdZVWNYS2Vp?=
 =?utf-8?B?blRZV0MwU3JMY1dFTHBlTlFEZU12TVpVZW9ja2JaaGE0SXI1K1ZmRDdOeHBL?=
 =?utf-8?B?OU5qOTAzL1NwaCtUZEp5UXpTT0ZaSVRYRkUvWGQvVnJlVUs0dm14YXJVTGc5?=
 =?utf-8?B?TnFnUFAwMGhhSHdlZDMxL3JmT2lhMTNTTlBDMllEdEs0VHI0WUk1SkV5WEx3?=
 =?utf-8?B?T3RkTDFzZWhjQW9yMzdJVU9lOEhReDNQL25pYXNIc0hiNVZDaDFvZ0FaUUhv?=
 =?utf-8?B?dERmdGhwT29Ec2lqT2NqZWxDckhRSWdrTHNOMTBQY2NmUzJUdkFSNURpcG1M?=
 =?utf-8?B?Z0lFd2JXS2xlN21BTW9WWmpzTjBGSnNLQjZlYXhHaHovRVdqWWZyekovNWd6?=
 =?utf-8?B?S0lkNDMvMlBjY0c1NnlLcWJzT3J1MU5Od3Y3NkNsTklmc1FmMzZMamdtVU5D?=
 =?utf-8?B?QkF0QS82NUxMY2xtMENhcmErVWplQXIvRGpFMlY2UnlnTmV4dnFtV1gxblY0?=
 =?utf-8?B?REUzdWVqUExKTEU0aVRJM2NVWXFKUUZSU0RIcWR5Z0h4OEF6Q0RESUJOOCt3?=
 =?utf-8?B?aGo3RU0xalJpU3JFSStpNWFNUEUydlltY0xaMkNvUDhieUdhL1RCcDZPQlNt?=
 =?utf-8?B?NnRLUmQ1b25UVXYxMUtrZ1JCcnpRbFAvS3FFcGpMa3NzTklPVHJsQ285QUVz?=
 =?utf-8?B?VmcwdzhXaW1MS1FFSERiN3B2VEdXOGVUdXlSVDJWREg2RnBxRjVtd0JxTmJ3?=
 =?utf-8?B?VitTcG93Q09EUVNGSVkrbEVOVyt6dXlYd0hoT1VLd1NRZUl4Umx5akVWaWph?=
 =?utf-8?B?WURyakNpTW42TjVzS1RwSU5hb2Z1YTRMaGloUE44c1QvTUlwRkRlV1hVbmFW?=
 =?utf-8?B?RllwZWY0YTNhVnliVkNyN0dIYlpyMU5jbmRNVE5MREMxYlV1M3cyNlBXRGNi?=
 =?utf-8?B?YnlWaWxkOTFpV00xbDBqYm9yKzgrcnltWkdza1ZvTU0vNDBSSlNXUTlybWYv?=
 =?utf-8?B?RjRhVkFZMCtBenlzbWVmaDF0STc0L3FpeVhGWXZsRS9XWnJrZWYxM0pvRldr?=
 =?utf-8?B?QXlHY0FiZUphVC9yaVlDL2N1bUxsNDVQK21KRXRMcDYxdWVJK2lNUGJIUm1N?=
 =?utf-8?B?OFBlaU5DUjlVem1ZU3dmS1plZHpqRTJjK25yK0tYRFdVNXZ0bmZVZjNiNXVx?=
 =?utf-8?B?bGVUMHJBR0tiNzA1Tml4aXJLNkc0V1dvbEtlTTlpQk1NbnBnRisrbzdKcXhL?=
 =?utf-8?B?cDZSdEVqcEJIc21GUEVuNm43SHdMYWkzWUxkZHRoTlJCcW9Ia0FWOUo3QVlY?=
 =?utf-8?B?N1Jnc1hVenFIQVFFb2hTRmYrVTNDd002aGhhQVZ3YnhPUGI5VENnMDQwejFN?=
 =?utf-8?B?YUVqMjdmdUw5ZDJjM2ZCMDdEanYxa1JvT0FXcE9TTzFvRUdWVmhya0dodGVC?=
 =?utf-8?Q?LCKybpjCYCyFWR2iz2ul17dqD?=
Content-ID: <819083E443A69B4786971FB14D3BCF62@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6776.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a035fad-34e2-4d95-81d5-08dbde627cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 00:51:18.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJj6kQhGIJsZBR7rCZG4AVdEfMndMeC9HYMNjLG2rikVuppcEOJ7pHi41WHaxmeMloz/yil+KXfhI4SKTypl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231105_165141_812115_5EE8E29E 
X-CRM114-Status: UNSURE (   8.27  )
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

I'm pleased to announce the release of makedumpfile 1.7.4.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
   https://github.com/makedumpfile/makedumpfile/releases

New features:
- Support for kernels up to v6.6
- Support for riscv64 architecture

Commits since 1.7.3:
3bc3b3e [v1.7.4] Update version (Kazuhito Hagio)
9661c1d [PATCH] Fix failure of compound page exclusion on Linux 6.6 and later (Kazuhito Hagio)
aee7f3b [PATCH 2/2] riscv64: Correct the pfn_start for flatmem (Song Shuai)
f777afb [PATCH 1/2] Add riscv64 support (Song Shuai)
a34f017 [PATCH] ppc64: do page traversal if vmemmap_list not populated (Aditya Gupta)
f23bb94 [PATCH] Support struct module_memory on Linux 6.4 and later (Kazuhito Hagio)
cad0d11 [PATCH] Add debugging information for DWARF information retrieval (Kazuhito Hagio)

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
