Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBC1C4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 02:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pLb3aT0lP1GxFS54dJT1cx2dmkXDeG0PhtobTBQwYpw=; b=ZsYlJ+a9QUR662
	ufbtugk26sdCb/4RKhjCiDUe65QRTCHJotxxFrpTRe1EQV6I2PtMcpbrX6l3KqfqgwTW5IfUEKTDC
	/j4WMgCClPWzbcEZtMF9As6tNuoYun3ZZVi4ebbckr6vtK4rvIlPu3c2Cj0cafOQwVsowN3m22iTG
	t7H2FAiSzv/wCIu/KGjRBAFDOGY4UtvGhgu+14VHG1e+vcX1KIBUjbTag6unvF45uz6i8zJ/kv06J
	w0gGVNyyo03qUN5Jz3gZZBWOdWaI2VxogllniBoUPSCIR81kxi9FMiU2HxzCbojOMMu3eRJ3z6+o1
	iaLw1ow6kriO+sp+IGfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhb4-004Naj-KA; Fri, 21 Oct 2022 02:17:18 +0000
Received: from mail-os0jpn01on2067.outbound.protection.outlook.com ([40.107.113.67] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhaz-004NYJ-70; Fri, 21 Oct 2022 02:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGQLgi9m5BdegdgtPc9hnTILlz0WQ2uU24rYRbNdjyAGZ44uBJjr6ASbnKZ6XyEQ704i9X8t/U2ji3z8i3N2Fee0jVUkL+obIq3/HxmcfhX6EXcfVKv2vloswNZpMEElaG2w6ygzY1J7vh7vwWnzcecKaO1qmOUl/D5lryCZ7f4PUSUwq9GmkJMKNOsZXwmplLHK/4RSVeqPojYQU2YMR4PIUaGWMJGD9rDn5ioqOQA5+aXcLa1fj1ooiehMXg+WBdzgHQKBCIxX9TsNsoOk2CYmQTdOEx3nFHjrtBqhyb92tvahZtVyYIPjIVzQqXfv7ayHLWa6HGLsKWEy851JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKKr4nUg6tu5K77nmZwqZjPh9bGx3xtR1+GCdoBDHUc=;
 b=AfslAtfaO06LGRK1sNs6fUyduN9uhN2TtOspSzvEcKtkYfuzW9HNVlSWlRDwIjC0iCKYS2ERvjclLFa4zLwA2jOK+XF7Ehr2zAs0DrZoENllyln3MDk44AbsDMNxIIe2EvqsMawxqzc4jtsdm/puLhaWIsHdnhADIx2kHIkmBzF4oz/AdG8vH5FGgwME6S7bxrvvwacaFXnoTYlXKCYBKZnqFiY0QgDT6b55JYQ6eEHMOZ1BXsGP1Gte0QjX9WR7eLINdKGF0qB/IV0QhcQzDc+rHOhXOpRCUGkH9dwQJ7pNBnPDCvZeGVLxzJIXJgYzQUuB6dJRWgbDdCag/AKpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKKr4nUg6tu5K77nmZwqZjPh9bGx3xtR1+GCdoBDHUc=;
 b=kak8Xz4DhilcELHZXY0AeldpeHCYsgqdfr/JTkeDCLw1Q/UnbfEvgvTPfDdqNnvmsOz+WD1+16k62QEL4oaodnZ+83LO0Dk7vQNLHW70HMFdxlJtOMXm7YjUF95MeHdpoJsCDYmWUXUqsyD6TKCQntIRW8CYcYzYNkhdnU3hMcQ=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYBPR01MB5439.jpnprd01.prod.outlook.com (2603:1096:404:8029::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 02:17:03 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%6]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 02:17:03 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
	"lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>, "mick@ics.forth.gr"
	<mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>, "lijiang@redhat.com"
	<lijiang@redhat.com>
Subject: Re: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Topic: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Index: AQHY5CZdVCBWrb7lWkSZ0txIm6wOBK4YHhwA
Date: Fri, 21 Oct 2022 02:17:02 +0000
Message-ID: <4022d4a1-8967-3d09-e158-5a6f78f73655@nec.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
 <20221020015014.46085-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221020015014.46085-2-xianting.tian@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYBPR01MB5439:EE_
x-ms-office365-filtering-correlation-id: 302202b6-02cd-4667-6c64-08dab30a57cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  acWt8vCtbMbyXAayDTWudM145HblGiWHC3e5qdly/cqFQqYVLgS8p8mznYzwCOBe1dK6USi31YpcYxj17EFfJaX/oG+xyd0uv82YkF3ipoVkVeXN0JTwRJKkLcQhzrpIJ8/62/LRiA26v+gtkvLRRNIzxyEoM4wNGPM5YYJe50FhyL7oRx68zFGIEiB8QbGwv0HDxWpyz8Zeq/iqb6+dI5Zn3hEQp5f7gk6bl/4d601k9W3SbF56sGxW3kmYY2vCLmoAJ6L6TSw7wbbG0dqrgnz0nQPW/ibpOminxiJNy52bUky4m84BIm9+An65r6+JN/gQHx+6Fg9Xz4AwbkylELELsaZz+/yzGCuQlJPdj5TWsU+e/aW8j/ABNw690EzT5tL0JyT31uY/CBgw3f+kktRkGbyxRnenoiLFoWWjsmzTnRaiacL5VYyORKwBW6cBmPgzH1j9pgW74Q0NbZD02RlEaS2jH334NoJreoGT1DOm2++dg/B359/svgrNM8SxiDBHTiZ5lomQEe70N3qzSSxhA7JExQMac32ytTIvDUrBR2cRtyzWDbeDjjWGybBK0PKafNmxar8MJJqTpNlTmlOvRywm9w1GQfgl4fezSJDlgGyeBD3WS7PVzvy1CiHzJOsTr7hdTGqscpFntsj8Dh+WL0oaiMbP8mJMExulzb5+5ipT1cfSFR5IFQsTE6JyR0KOaX5GKvocW3OwxAqqvWEww0dPrSdG13IlM+ys0sen4HTTazO8KvfWjs9E9RZFMM77l8B0foN0BNAwQY5A6x0y/WT8SzR7iOi/PZzvCv8=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(31696002)(2906002)(41300700001)(36756003)(86362001)(71200400001)(478600001)(8936002)(85182001)(64756008)(76116006)(4326008)(6916009)(7416002)(8676002)(66556008)(5660300002)(66476007)(6486002)(66446008)(66946007)(55236004)(53546011)(2616005)(38070700005)(26005)(38100700002)(122000001)(6512007)(54906003)(82960400001)(6506007)(186003)(31686004)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Z0tiZFRlaTZMT1JGejB3eVVqRWRxWjdoQjZTV0lGTlZzV0xOZ1NwRVlRVE1V?=
 =?utf-8?B?eUlqRU9tM1RaaDBocjhWWVFBeXNnWTNDWnl3WW9BUStVZmhBaWw0RDZmbUFW?=
 =?utf-8?B?V1BqNUVsaU5YNTFnSVNmQnpZMXZ1Z2tVeXN5QndSL3dTbnVEMU5YS2tQc2ZC?=
 =?utf-8?B?alF4WFlFWDY0RDQxcWRiZmtUaVRMbkcrMDZyL0Q1M1JvamRYU1ZTbEVUVC96?=
 =?utf-8?B?SDlpRzdYTlNPMk9sRGFjV3lSRWYySi82Q0xsVnlxUmZMTjJKNll1RjZCdklG?=
 =?utf-8?B?QXNQZkt5NHlRQWFjTWFIYnpLekQ0NjR4Yi9TVFdXTVNDeFN4Njl3TENyQm9a?=
 =?utf-8?B?dUVHSmQxTDl3cStlSUJXUVdmMElGV05aOUprUldSbTZjemtJdmJzVTlFTzdv?=
 =?utf-8?B?RmdmL3RPRmRoM3BsYkRCd2JNbVBhR3M2elUzYXFDb3BLNTgxRXB4aE1iNHFz?=
 =?utf-8?B?UllEcVpUSXZKYmU5cEVVcTdPQTh4cnhFQnJvNmhkTkNHc0lKTEFvL0p5MXJC?=
 =?utf-8?B?Zko3ekQzOGlsTHJBUVBqdFFRbUo2cWlMb2N4ZWpoQnlvNmNYOEE5cXlvQXNj?=
 =?utf-8?B?NlRETk90RUllM0FuMFA2STFUaFpGWVFSSENmbXBvZ0RLaU8wMlB6TW1iUVJV?=
 =?utf-8?B?T2ZpdEVZUlA2eEljSGprVFNkSWpqL1FVR3BIVzV0cXJuZzBFY2JBSjQyaS9X?=
 =?utf-8?B?UU1vOUtCVzFka2R5bzZjbk9qRmVVSGRHb0VHSkhNM2pMb2JBYXptME5CLzVi?=
 =?utf-8?B?U2JPZDJpSXpGeEc1NU5rRVRidy91aFc3KzFYbW1lZzU2VG9PMWhFWDhQY3BF?=
 =?utf-8?B?S0pMWkhidDdUblhjWkpITHRwQlJ5ZnI5bDU0WXMvd2xNcVlZMDA1ZTVuNUQ3?=
 =?utf-8?B?UENyTHI0TGRXZ3o3NGQ0dW1zd3l6RzhDcVovNWtRM1MyMU5BUCtnTDRDWjNn?=
 =?utf-8?B?Y2h3OU9UYW54MUFOaHlJSkdxeTM0LzZiMVh0M3VOSmZpWk1RNE9abjNtd2k4?=
 =?utf-8?B?VFMwU1YzM09PeXVzSXNMc1pkZFVkeEJaQjhNN1JQTGxZRVZ1VXFOaVpuY3Yz?=
 =?utf-8?B?VUdlOGgxNEdrTGFhQk5wTVVUbS83bDNYbEFtNU9TRHpvVE9lWUFzVDU2VGVT?=
 =?utf-8?B?WVgrUzQyVGtnSXNsZ1dveWlhcGVwbHdUaUgrakFjcnBRY2kwNFFFWHRJaVY2?=
 =?utf-8?B?VVUxWmwydUkvMTRjVys5VnJkV3ZxNTB2TTV0Y3ZCdThkRCs4OUlidlQwSEkw?=
 =?utf-8?B?d0cxd1hnNU5KMlpIMVp0TG1jMjZOL2JSVDZ5K3hsYlBmYmJHaGp1TWdBenQ5?=
 =?utf-8?B?Y25BMUZFcjcrdEJ1SG03ekdqQUdqQlVFZlhzWnVDaG9uUWJpclhLSE9YUEtC?=
 =?utf-8?B?NTdOa094a1pZSmUwWVo0V0grTWJrZFl5bVlBTXpxZG5oTXp3MTh0a1JQdWlC?=
 =?utf-8?B?Y1kxSkhPS2NmRWVlOEs3UzJMbkZaT0dUREQxTEtjb1pCZ3ZxOUhHWGhHVGkx?=
 =?utf-8?B?S25rQmhBb09qK2RCbWZrNjJuMG8xQzBxM0xBYkN2bDBNS0R2a2k0RFlJL3c5?=
 =?utf-8?B?WUdwVDIya1RBcGVidHFjM2lCeVFmRHYvOEplcVJLSDZpeG01TU1UV1hiVTVx?=
 =?utf-8?B?VytiMnhRa1ZuZXhEN0Q0YXYvVTEyREorR3VBMkppMmNGYUFSNytPZUxxQ1ZS?=
 =?utf-8?B?K3c2UkgrMmIwK0NRZm1GZ3hmY2xiQWM1bVlqejNMSmZJUGYrRnJocE05S2xo?=
 =?utf-8?B?ZFk3RlU0ekYrVDdWT2VIdnEveURRakczRGU5RXFOWHNoNDRQNlVlcXpHNnh4?=
 =?utf-8?B?QitUektnVHY3eERvVHh1TFZXTWIyZXphODdkYTM3dkJweGZMOTJWSFZwVkhK?=
 =?utf-8?B?L2V5QmdtZDU2dllkR0NQMTVLdlhaQzdUbjNQdTg3S1p1b2xDNUZQYWNodWsx?=
 =?utf-8?B?VFE5NmVxL1hncjhEajR4QWJFa2NybmlpdmJHRnMxUWZzMXIrbXNvcDRMTkpU?=
 =?utf-8?B?NWdzUUVRUE5lMUsveThpNzZBalRpQTE1RkloQUxnZ1d0alBhSVlLRXFyQTFH?=
 =?utf-8?B?NS9ISkl3b0FrWVVLVmN2dXduMHZ3NU5lbExvTUNqeFU2Y0Ftam1CRWN4elJH?=
 =?utf-8?Q?UA/wxATuXpfnqBtxrEFjq3Gdq?=
Content-ID: <6C3F18ADBC70F8429587FB826412120E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302202b6-02cd-4667-6c64-08dab30a57cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:17:03.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpQq1CReDjjRx38WQUZiGVfShXgQ6SYB2GDiiVlqlmYSHVPIHlILAo9WMxhvR38Klohcfdg+jlOLH0j9y6ZZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5439
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_191713_725471_EEEEDCA6 
X-CRM114-Status: GOOD (  13.90  )
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

On 2022/10/20 10:50, Xianting Tian wrote:

> diff --git a/README b/README
> index 5abbce1..d589e72 100644
> --- a/README
> +++ b/README
> @@ -37,7 +37,7 @@
>     These are the current prerequisites:
>   
>     o  At this point, x86, ia64, x86_64, ppc64, ppc, arm, arm64, alpha, mips,
> -     mips64, s390 and s390x-based kernels are supported.  Other architectures
> +     mips64, riscv64, s390 and s390x-based kernels are supported.  Other architectures
>        may be addressed in the future.

Sentences in the README are wrapped within 80 characters, I will change
this to:

+     mips64, riscv64, s390 and s390x-based kernels are supported.  Other
+     architectures may be addressed in the future.

>   
>     o  One size fits all -- the utility can be run on any Linux kernel version
> @@ -98,6 +98,8 @@
>        arm64 dumpfiles may be built by typing "make target=ARM64".
>     o  On an x86_64 host, an x86_64 binary that can be used to analyze
>        ppc64le dumpfiles may be built by typing "make target=PPC64".
> +  o  On an x86_64 host, an x86_64 binary that can be used to analyze
> +     riscv64 dumpfiles may be built by typing "make target=RISCV64".
>   
>     Traditionally when vmcores are compressed via the makedumpfile(8) facility
>     the libz compression library is used, and by default the crash utility


> diff --git a/help.c b/help.c
> index 99214c1..253c71b 100644
> --- a/help.c
> +++ b/help.c
> @@ -9512,7 +9512,7 @@ char *README[] = {
>   "  These are the current prerequisites: ",
>   "",
>   "  o  At this point, x86, ia64, x86_64, ppc64, ppc, arm, arm64, alpha, mips,",
> -"     mips64, s390 and s390x-based kernels are supported.  Other architectures",
> +"     mips64, riscv64, s390 and s390x-based kernels are supported.  Other architectures",
>   "     may be addressed in the future.",
>   "",
>   "  o  One size fits all -- the utility can be run on any Linux kernel version",

Same as above.

And help.c lacks this part, will add:

@@ -9572,6 +9572,8 @@ README_ENTER_DIRECTORY,
  "     arm64 dumpfiles may be built by typing \"make target=ARM64\".",
  "  o  On an x86_64 host, an x86_64 binary that can be used to analyze",
  "     ppc64le dumpfiles may be built by typing \"make target=PPC64\".",
+"  o  On an x86_64 host, an x86_64 binary that can be used to analyze",
+"     riscv64 dumpfiles may be built by typing \"make target=RISCV64\".",
  "",
  "  Traditionally when vmcores are compressed via the makedumpfile(8) facility",
  "  the libz compression library is used, and by default the crash utility",


With these, the v4 crash patch set looks good to me.

Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
