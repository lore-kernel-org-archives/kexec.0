Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DCBC433FE
	for <kexec@archiver.kernel.org>; Mon, 24 Oct 2022 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q1yd5S+HJgcE05AjxcY6erw/fxhit+OmUaiAxcrouIo=; b=NwExz2O6NbOeZw
	D/nOZTnE/on2qPxhfwWt3vFG8p2HZYed1R0vZc7ioraPjpTfK7OS2lihppRwnR3RwUoY1cH59sXX3
	LBsUwOvRJanwy1gYFmm7vEQlI8l0H3CA6bdPM14altE8pBFnZEtNC8FIYDn9iKdD9berMjRUG7c5S
	bBZV96jIMedngC22i0wGQ38oYeJPouLw9PbcHU9+yUrl8uYOD7a4DZYXvTI7vGqUsOcNc6pAwxpiJ
	q2LUR7/A1DAsaI7+fHuSbI8BoIbyOmsPUCFoq3W1/dYBrG9EqtKCCUWtywK/byilu1SPknyPqEOCO
	FVpj3xG1owU8+pOFwS6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omn9Z-00GnoZ-Cx; Mon, 24 Oct 2022 02:25:25 +0000
Received: from mail-tycjpn01on2071.outbound.protection.outlook.com ([40.107.114.71] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omn9S-00GnnN-Kq
	for kexec@lists.infradead.org; Mon, 24 Oct 2022 02:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3mY95Fu7qyVLeYRvmEl/nowM3uAQQ5MY1bntxvSPMjZfoaqzxhLqdyH68uZ3wTnKhxaVt/U4HB0aug851rnij6bzSERzrIzjvyVRrbXQA3nF8KbVqKX9eh1hfFdcm1S1qS9KPczS7T0MMgfT9Zm38aPeujB+bPbYy5FcPY+Buu7luYz0Ll93f45OAIljE8mUSEgxYo/HxOufmsUB0u16wzcTVMSWqazjTHlnfcko6/2qnX0y8g1KOmkGAu6mOJ6zgirp9Wv9A1s3BOpFqSvXELeP2J8AzzRXvEmTEtGw7pCrmoeFkXMGH67eAuBumPPbHb3rMq9+ETJbhGJUpDB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29nyu8q75mEEIAREf0vPrNXxxTGetQdsAORlaQJUJso=;
 b=TauRnZ6YHse6DxzMw7aQNPBYiBvMbeOV8kI+ZokiBBhyjVBhR5hpesfEX4kwbFT6OQQ7X3ajm2ZmBaHX9DXpPnbxEa6+0MR/DhmUuNmN+HO42XU4IKRPkbaQOKikbetG83mU556ySp4/SVu/JJtbnk73TYJxQAheuJDdg2SJXS81/WgSMW+vT6pjjab5B3i+BegHSyHGlSEkzjjm6nO+QvGowyrf/KNAHQvAEjpCBULON725kdbufOfDs8elFDO0qcb51YyBssiuN07qk5rFbXD4W136vu7ijx0tBt07N8R7yvf6Ocde/943hs8+wXicJimSDBXZg+Gw+VGJGjoAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29nyu8q75mEEIAREf0vPrNXxxTGetQdsAORlaQJUJso=;
 b=m9yryqr8Yhc/arK12FPLw4zMKe0A7dyO/ECzjOl5Nl8O4mrCYeAji8VuTS4Ag+seaWNlrz0JMKxZHiK9vsdhiZP3ja6Rs99mh/WJHoZTMx7yeNjlIKwDwTeik9Pz/wXQUt6DIEoqYThuQIdsKxuPW5TEo7oZ0v5CiUVtAzgx420=
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com (2603:1096:604:126::6)
 by TYAPR01MB5916.jpnprd01.prod.outlook.com (2603:1096:404:805a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Mon, 24 Oct
 2022 02:25:09 +0000
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::ceec:27ec:a114:f630]) by OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::ceec:27ec:a114:f630%2]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 02:25:09 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Leonidas Spyropoulos <artafinde@archlinux.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] Makefile: Remove version from /usr/share/makedumpfile
Thread-Topic: [PATCH] Makefile: Remove version from /usr/share/makedumpfile
Thread-Index: AQHY5TeRi3sJqFTIh0uBMvmNJDmGUq4c1TwA
Date: Mon, 24 Oct 2022 02:25:09 +0000
Message-ID: <8952f78a-fec5-e9b2-7823-33e126aa209d@nec.com>
References: <20221021102459.28070-1-artafinde@archlinux.org>
In-Reply-To: <20221021102459.28070-1-artafinde@archlinux.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6776:EE_|TYAPR01MB5916:EE_
x-ms-office365-filtering-correlation-id: a80afc04-c890-43ad-9276-08dab566f8ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  t1PySoMCaSk4lI6nCFYfkGe3QzemND/z3tMkmJvUWVcTEqbKt608HiNG8LHbW8E7pOOxC8X5wrbyDaSXyoO784U6PrjPoFIhKqBPeDSPeOyXIqRj4cH1JePMKxJbiCYziZv2MXcntRcbaG71x3yOTOw8X9htphQJjOrcOYnjUWqjBW6XheSo1BSZDhv9F2zwFOz3fQIBfK4KEKycvIsOcxek5aieJiug/fmP0SVb3+aRUOyAcHoq9SJ5gNvLRRthGx0DoQ16jpbIyVA+h+gKGg4ojhW+NjPSOpULN5dQlIL5RK6yvp4TWyB7y/x53CCo9/RchcUr523ZN+4C9VWOFWvWajjcW5as57/T07yOgtQeakb+qbwMNCYa3Q3GFu4HmySV1r2EG8BUn4gMsfLlC9Yw/aiOgmuySSw10l39LkyECqacN/v5+Nt1hI+3TrZu8C7gTs3Bmo4iPJ30P8tso8i4nbpi979736UpvGzQ2jZnNKIh1G3BGYbXJkxC6JOAcI8UYKP7jkTz2MrJ7hkz9fzoK5dIkjlJ7+nMS34gmGhxlNtzrf96Jp7dEf4NWoIzN2w2m3pr3zhsXEWwBDgEF63lzSyrpYuCFZM4DH42OmKotEJA7GI3g0XMIHcJd03C1siCvBGrHBjoCDOHwA3f73A3cgbcjO3y6gG8giE03qOvogJtbnjT7Et/kOvlHHYYNovrn07wnSArYy8Tz8cFuqM6lxaw+VTY/3gtk0Ac9fMa2hvGJM/c5qbkEA4quTQk0QFhQmrU34qJGoPrItSRMW1jb7Rc9N4WRoUy3SIuIOTMohXQ/nYzNHpFpCR9Pbak
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6776.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(316002)(110136005)(8936002)(6512007)(26005)(2616005)(2906002)(186003)(5660300002)(66446008)(8676002)(64756008)(66556008)(66476007)(66946007)(76116006)(6506007)(36756003)(91956017)(31696002)(41300700001)(83380400001)(86362001)(53546011)(55236004)(85182001)(82960400001)(38070700005)(478600001)(71200400001)(31686004)(38100700002)(122000001)(966005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UWduamFJNi9ybHdrMjVJVmxaNCt3SGczdnNjeUdxdnFRVDI0MDgrQ3dWSXk0?=
 =?utf-8?B?TlZ4c3Q5T212MXo3S0xwaEJhanBsbThudTlsNWsyRXVLRFNqZ011M2d0aEZt?=
 =?utf-8?B?UWk2WENodERpMTI0WCtjVzRsNkRjaTg4U2hZUDhqK3JNZ25EWUJiWkRwOGwy?=
 =?utf-8?B?b0hyY0xJcGREZmExL0t5cm1ZaThSQWVsRHBXak5qdFV2cVVrZkNBNDhFMThh?=
 =?utf-8?B?VnNhTmdtOFFONzRpVXBJVUR5eDFjRTJYaHFWWTZjUDBQOWxyZHJSVjdiOHdj?=
 =?utf-8?B?WEJ3a3RFRXdUSmxFbExXVDdTN0U3SDk5SmIvMUlPMUZFZDVURDJKSUswMHEr?=
 =?utf-8?B?aWdUOTVlS2dHcVVQUHVOMG4wWnNMaFk4cFlWTkRDSDJweXI0WVl5dm1xeTJF?=
 =?utf-8?B?MHRBWHYwSGJQUU96VnV6VzdqT2pmaXNpRGQ5Z0REV3Z1dWZFQldHVGR4Nm9V?=
 =?utf-8?B?aERHaXBWMEFRcjBHNUllZlB4MS9pVHlFK0E0aDZjQU8ybDlCRUV6cE1UdFhq?=
 =?utf-8?B?clBsQ1FiM0JIS0h0eXNKTGxVTnN6eDJMNW84Ym9zSFJrR2lsZzNnKzMvZjdD?=
 =?utf-8?B?aWJKYzhwSDB0VCtEYTlEOWhBWS92NmtPSGxIc0xEM3JpS25tc09lekE5MTht?=
 =?utf-8?B?cG5hSEdxeE9HRGp2Nisxa3RTbHJJa0h2bFA2aWdlZHA2bGM4MXlza2kvN1ds?=
 =?utf-8?B?UStCOFg3RW04WlpLbitqZ2JVUStiU0U2UDE2ZXBhOUtzY3lQUk5wN3p0QjNy?=
 =?utf-8?B?alZSSzZzMVpDUVg0R3NRanJ4OFFoblpNUUJMZXhnVmpjbXU2MURIVTB5dFZI?=
 =?utf-8?B?NURCZ05IdCsyMGVia2NJSThQVkVTQUR3dG55U1ZlYUdEeHhMK09acmRJTkR0?=
 =?utf-8?B?N3MxNHdnRlM3UVA0OFJoRHdnN3NjMDhraTMySzFZWkl0YW90MDNDTE14UTlt?=
 =?utf-8?B?UTNxb1ViSXJ6ZWgrS0lKazJvS1d0S29NOERITmcyTTJJYjZ2a1ZvNlQzM0VE?=
 =?utf-8?B?TjR6NjRFTjJVRFdGMkQyc2w5OUQ0UlFGczdKRXE3Q1g2T3JzWWpBWStrVm5I?=
 =?utf-8?B?UTA5alc4TTdlRDV0c1RBRVEvNHdINTZ1NTZJazVkKzdMb2srZ0grU0cvaEQ3?=
 =?utf-8?B?eHdNYXJQWmltL0FLZVpRT05YSkRNQmpEZUlndWpaMS9manh3V2lkVjJ3dUpq?=
 =?utf-8?B?RDVGMUVTeDYxck91MEZ1cndwWnlrRnV1RG5HYlhDUDF2cXphWkNMc2RFSElr?=
 =?utf-8?B?YzJ1MUpZcTR0QTBHUHZCeWlNU3dKTlM4NWlaWnNPWGNWeXRuVkJaT2VwSEsr?=
 =?utf-8?B?VENTZDdQa0JDWWJRbjR2Q3RUb0dkbTJQVWxySW9mWXFNRDlodzdTM2pvaVF1?=
 =?utf-8?B?RGdjY1pqVWdzQTlMdVZnMGFCZW1RSnRmUUxkVi9rMERjaWttRjBSdGtTbW9R?=
 =?utf-8?B?bE5USjM4L2hLTDVEeWJ2clBIK0pIWE4yS2lJcTc4cVh3ZkQrL01WWHp2TjVT?=
 =?utf-8?B?VHJoanc5VnIrYW1zQWlCSjFCZkluYWFMamcwOTc3cEFIUDZ0U0Jwb09YbXN1?=
 =?utf-8?B?NTBKQkF5TndXZ0hNSm9yQ0JaOEdkR0lPbkRlQkt1ais3cDhtUU0rMm53V2o3?=
 =?utf-8?B?aVFhdzVvanh6SkdTUHorai9lbzVjdXlMMm0zNzAxaE9RZlhqTEdNd1I5Vmlu?=
 =?utf-8?B?T0tXeWVYRlY5czVESnRtTHFDaU40cVdKYU0ybFI4eUJ5N21naGc5N2pxcE1h?=
 =?utf-8?B?VjV0V1V4Sm9qZlFZL1ZkYkYwVnhDWVZwbC92UHB0aHNXclIrOXhLMlEwMExp?=
 =?utf-8?B?dUxQV1RneU5maFBoYlZyOXhxWTR2R2YrNzFTaGRyQm5kb0hMcm50M2VXdE1E?=
 =?utf-8?B?bDF0c1pTNThMVjJUZnhkUGw1VkRoblJNRVBFNDJNeWNXOWRIR1MzdUN6NDRP?=
 =?utf-8?B?QS85VHJCY1hWYzFCcUVZS0NsdC9RTXFTTjBPMlNkWmRKdGJyWUcvM3lwUmIz?=
 =?utf-8?B?OCt4ZkFIcFBvVWszUHRqa2Z2MkdoUlk2Z3VYbWRkVnRyK29hWmlXc2pRamw4?=
 =?utf-8?B?YUdqU1hDWGxxcUN4QTdRaitnQjJLNzhaSlNPUmR5SHU3R3Z3cGZTZmVSVXZJ?=
 =?utf-8?Q?kTJ7uvBb+oav8z5XSAiay1VOb?=
Content-ID: <D50D3B3858F1B54CA47BBD692429C9F9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6776.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80afc04-c890-43ad-9276-08dab566f8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 02:25:09.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iloJHOq9jdd86fMmhMWRcJBNEe1iDn364BRkRPaZD1VZ61nLHnTIn1XbuT6dg+CErsh4yxVsysGjnjnzoaaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_192519_177145_9C2E25C1 
X-CRM114-Status: GOOD (  16.67  )
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

On 2022/10/21 19:24, Leonidas Spyropoulos wrote:
> Version specific paths doesn't make sense at
> /usr/share/makedumpfile. This assumes you will have only one version
> installed which on a normal system it makes sense and devs can always
> specify different DESTDIR per versions.
> 
> Fixes: #10
> 
> Signed-off-by: Leonidas Spyropoulos <artafinde@archlinux.org>

Thanks for the patch.

I agree.

The patch [1] introduced the directory with ${VERSION}, but makedumpfile
has backward compatibility and the directory does not have any data that
has version restraint, so I don't see any reason.  Also I didn't find any
discussion in the list archive.

I will merge this a few days later if no objection.

Thanks,
Kazu

[1] https://github.com/makedumpfile/makedumpfile/commit/41e1ccfcd57736047a5c52d8096fbcaa255146ec


> ---
>   Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 548e5b7..f6ecbe2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -130,6 +130,6 @@ install:
>   	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
> -	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
> -	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile-${VERSION}/makedumpfile.conf.sample
> -	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
> +	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
> +	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile/makedumpfile.conf.sample
> +	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts/ $(VPATH)eppic_scripts/*
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
