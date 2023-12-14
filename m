Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD9C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nV9q2ltuSj82DeYKyI3fbKQQ9epdPsLaf9TaynCWMSg=; b=GeRwPcjFuP62BE
	6tnnMeuJa//4CHh1bKF63IhNHRfbP6zpVwD23aZI7C6hP6aBdhb2eyH//SYs/187p07kdhaUQ/hGL
	RXApKDGox129kSIjpiNN15IlPpZhx487+IJHl+tt+PNEYyxURsgtukH3DUnpVXWeu6rXdGOLDJ0kT
	w7jtMJvTY7xyZFGxGvFyf9H6cj/vbS5k+vJPCfC2i8wWcGWE6rmNizggWUkX6+PfTRA/2OYs5oM/q
	hVw2mE75A4xMI86WRyKnbJgS9KkKH7orUFiDqLYoCQ6/eQl8nZTZnply7VTMd7oYtL6CG5iqpSKJ9
	Vzy6VQNrOk/lRrpR4wyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDggJ-00HBpo-31;
	Thu, 14 Dec 2023 08:02:55 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDggG-00HBp4-1s
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 08:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyJ5Cfi3sixGltRlz0iykqNZtTAZkOYW3VIYa0Q5O7HT9VmA3UXOjmIq3IVudnArC0ZsCaBC10/xlAnHZDZC9fiCRFMq+c3aTMfLNLA1aTZX+vO3LtCawl6PKNKuU6GGOkc4Q91XYQPED0DZqGx7G11MWrWLmeoTGO3sHbiuw+cZbt+tQ7O357ZuFCOPWcpMVWNEpYw9+F9myMwP2yXx9IY6EALweSjzkf/l4VUolG1DbhTIZbiDn5w24H0T44gwr4+la2LMg0rPMf8H/F7P3HXdwsD590EPyPGWVMqRcuwuOkUnDqszWjhTqEhMtkD70Y1gswBUfyygvn/2zMzDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FusZUFXvsAtOZHbirJtbFaYiGchIy5wmzbajOg+QvV0=;
 b=SxaPF+/YeumiwpOPM1+6pBsIDkfTDbUrhUhmDXPVc8q7PTCsFp/EUYbzYP8WVNQy+VNNe/vHCv/6BMav1jPvEZZZWK4Z9cgDJ+OJfUrf0jPVPDKut1qTvYDjJxs0NM74diD8Zhq+gv2Dw2ygfXGxgpSxtuoZvh9yN0vdSnVTbUlQxx0Vxb1y6u/SNoHuPUWIzMRddbiT2A1N7q1CF5S9Wbn/a+BHutUCRzgnV7qEJ2rtuswH3mhVbmyp2wPtB50Vz28LTobVGzd+LPuFI+N49pB1Bjmvy6d1OqjfbIV7TvntaJv0GvcjaQ6VPFNJn9FOqZN0oU+45r8DuRmntjxO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FusZUFXvsAtOZHbirJtbFaYiGchIy5wmzbajOg+QvV0=;
 b=hXuU5E+6fJlnnxZz5Ce+PCejPNfpSak3K15xPYz4eps6UWusg4EveRPGoTfZKGPqZjBVlyvXZue0FMvdN2367LHasInwinwfjV6PGp+CGtxaM+WDZzLIBoiYhK4xHWj4k/qlv8cc1Y0lsZIccZlh/zgmv46iviNtgeUsN6u2ZsKxUWa2Mo8C340krMryLsthQ5DWUb0QOLmI8hlfEhjPvyTiVO3G7Z0ndc/RFub42UnTF+HyUZmaLx/Rywecd4J8DNoCm/u9AX3Jv6Ru9GjkQlf7OfiYAqdNYPnUDF9Ix3W38Ue9SqTjVvuj7Xq5AMLX9C0kaFLmdl4vts2h+CrXNg==
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB12074.jpnprd01.prod.outlook.com (2603:1096:400:442::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 08:02:39 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13%7]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 08:02:39 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Edward Chron <echron@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "colona@arista.com" <colona@arista.com>
Subject: Re: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Topic: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Index: AQHaLa0SM3sUSjKJ+E+bmRQiqU04BLCobHQA
Date: Thu, 14 Dec 2023 08:02:39 +0000
Message-ID: <fd16b101-0143-18bd-5434-0666215aea29@nec.com>
References: <20231213101334.25072-1-echron@arista.com>
In-Reply-To: <20231213101334.25072-1-echron@arista.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB12074:EE_
x-ms-office365-filtering-correlation-id: 5d6fd973-1961-4dd4-87eb-08dbfc7b0ac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHqyvLomWsc6LF3LIAsfuewgO20UkJs+biNxQt9ICuoZ38Twmx9iD0mXf1iU0LYozm+fGqdBABQrnIaAzz1TWHNE20qAeVQjL7g1lktjSY5hnWX2WHJOvpjRCPmWiSiGULrJl7hx0OPdCXIpA7LdSI0E2cGrNNO3XjWeBaUwnVsgzKdoomfr5iPcJdriAAbKrO1uVZWlrZ+ALtwiasF64Xj3OT4yjuMyWP/Bqgy97EmNCfy+ZLgJrweakTvo42urAPudFJ/+m8uK+hOoXb1u6P8ZAbZFsDWfs7udw9ffJ0jN/AiaK6JyhkKE7SVru2J2e5UlKX6S4Fl2WnOGVOXRkC87+F2TKWxKOgzxkAwtxvXzIdkLSWBWaYN4ssMRsRIHtEcaCguJ76t478bqeBbrK3ut1dKKhP37cDIhd0p112/SWQks/jrk/9wGVsCaYTLZQrysLQqzpLXqz/Wn/K67i6uP0IZNkKsnTJIeUXRNM7YoHshsiCn/DoiYQIf1lGw2+KexTFOG8EFODXZ53RqLM1IUMeEA4/Y/h8LSFazhHe64XYOK3RGR50yfLmk1JgGGjmPqZETJn9VT1TQHXLaWQ+naOBpLqwEHml274GliNC5AxGWXna0Q4kc+n9WSDayAciZsjg5iIp2coTuwqNRSp0buKueZ3MGKc+OGHk5iYps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(2906002)(966005)(6506007)(6512007)(53546011)(8676002)(8936002)(5660300002)(4326008)(85182001)(36756003)(82960400001)(316002)(31696002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(110136005)(83380400001)(41300700001)(38100700002)(31686004)(122000001)(38070700009)(2616005)(26005)(86362001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNaVTg4TnVseGRBTmVTdGVucnN1dWNnck8weUhncXNUQm9aek56T3pQaDlq?=
 =?utf-8?B?bmN0S2ZINFFnbm1jODRrMnMrNFJqNkQ1NEZqL1RabnBVbmZLQmRLcTllMk00?=
 =?utf-8?B?VnlSYzFRa3pDUTdLSGF5YzkzRSt6dHF5S01sTTEvUWJRd09rSElGQ2FrRmls?=
 =?utf-8?B?NlROTXFaYkdhZW1BVUViaVdBYkVvVC9IL3pBOXRqNDQybEcwUGgrNWdPNjNm?=
 =?utf-8?B?ZlAzNDBNNGxOWFgzSHRJU2Zpb0pBalJBUXBvYjl6cDVnVm5wZzg4SFhibi9I?=
 =?utf-8?B?dUFHS0Q0UFllWXNtWTNuV0U5NERYaUtSNnkrUUFUc1h5K0NhYStmbVZwRDV6?=
 =?utf-8?B?V24zZDZCS014b2o3SHkvcUtNWTVKbXRKdm5reit0L1I4VGRBU0dHUW9BVkx4?=
 =?utf-8?B?YjNYTzQyampWZzZZQ3Ewam52bGdNU056MTcwY3Q1OVYzYWpXeWlUcmM4Z2li?=
 =?utf-8?B?UHJ2Q0FFL3NPSDRZTVF2QzdOUDA1VWdwemtDSkljL3J2RWtoN3lxWm5EU3B2?=
 =?utf-8?B?U2xuUlgwWW9oRE55STlGNGV2WU0xUXVJd3ZTbzFYcnBjWmdDcWl4V3JlS1RU?=
 =?utf-8?B?VnNFNGxCU1JMdm10LzdseitPK0dWTlJIQmliMXZueFFyLzhYQ1pROUtXemZv?=
 =?utf-8?B?QUoxSFJldE4zNm9aUGwwZElhd1RZMi9OcXFKL201SGJpczdnTWxSSFk3WURI?=
 =?utf-8?B?V1JMNlFKcGJUTnpHM1RWcVBsQ3NqVUxGemRrMGdnL2tKNHV5OUdzR3c4MnRU?=
 =?utf-8?B?Q2NvWlJHeTJVdGFJVE5LdmdTV1gvTjhpZnBMYnJBZnJveEhFZDFQYTNBTmhr?=
 =?utf-8?B?ZzArVUtwb2s2ZWZPRnlFU3JicFAvWHZHb3FNQ3VzRStWcWZRZURtUTFrR2JX?=
 =?utf-8?B?NC9hclVoZlBMbTRLMVNHd2cvcjRLczF6aE1rcERVazBVL295bGNhTlNrSW8r?=
 =?utf-8?B?YmdpdUVhNlJtZDlKWVdaU2F3VkpmMHp3Nnl1RFRlektUM1R3UzR0NCtoWUlC?=
 =?utf-8?B?WFVnUzlNZmEwVTcxODlnR3RJZUZYS0twcTNDS3ljWjRWejBKL2M5M2lMMjBV?=
 =?utf-8?B?Mm1vc1lHZ3Vab3ozK3JIOStURHhvMGxqT08wd2FUeTgzM3RnNTRRaXA1Wkhj?=
 =?utf-8?B?OG9TSGt2clVPMUQ1WjZoYVJPeXl1cW1iK1VOMWhQd28zWEhiVjJ2ZE53MVh4?=
 =?utf-8?B?M2x2c2dDTjgzT0J4YkhLa0tFRXBCaXpFeHR0T3dYY29hU2tHL3J0bHNKaUox?=
 =?utf-8?B?UXlJSUJNbjJIOTE1YTBHMm5RUEh1K0c4M1pTV0tJWE1EeWs4YUNIT2JoWjVq?=
 =?utf-8?B?MExlYTltMC8wU3BydGplWkFoSEorT0xtWnpJQ1I3NXZkRWM2SVlOMFdBWkZG?=
 =?utf-8?B?emdnRzhCUDZVT3BhRjZmQUNZWit4MzFjWXhtbzEwWUw2b3p1cnJSbzhock14?=
 =?utf-8?B?TC9Lb21LdXVMS0haR0tERktHNWJTdHppQnhNQTB1d0swTFJDWUFhYVlpSllm?=
 =?utf-8?B?Q0hBNnlUblAzYVppT3Rqd1BFMmRTRzhxTnRRNk5qYXFwVG1NQ0xCWWRqcXZF?=
 =?utf-8?B?Y015akNtYTZMQjJGZGVqMTN4WklXdm0vZlhoZEJqWmFKSitJWm0yaC83UXBL?=
 =?utf-8?B?OXEyWldVbkwxaDhZNHpmdDFFNXFJUlMzQk9Ca0R4YTRvV3p2NWYwcHpTUHJM?=
 =?utf-8?B?Z1YxazdDdHAwQzBoWVRxc3RxMUdvYkRqYWwyVnVJWHpiR1RtcmhDdndMNnJL?=
 =?utf-8?B?OUt5cVB0SUQ0VWY3eW8xcTlhN3ozV3VjRVM4UVBlL0xLUkoyZ2pVRm1RNUNZ?=
 =?utf-8?B?UGkya1hUMG5LV2creGZMeGNEeHhFaGtMVUlMMGVIcm1KcnZWNkxTeTBDTzRY?=
 =?utf-8?B?a0NlL1pVaElvTmxPQjJ4eWJ0UldDVm91YVVUN3hybnZrRzJUcDIwMXhTYWdR?=
 =?utf-8?B?cTQvZElpazA4SEZRYzkxbmJ3eE9MMDdjS1Z4cVJTMU0zR253bFVCNkltdmJp?=
 =?utf-8?B?ZG1ZUy9oaFJ3TFUvS1daaHBWOVMvR2FRd250TTJGTDZPM2dFelpIY1N5K0dv?=
 =?utf-8?B?VVRHSnM2d0JabzRQcnlZQ04xalRiaUd6anpLY3B4THVwVWhrTTFxSGo5NUlo?=
 =?utf-8?Q?lWvEXkAtOeoO6LBh7g+JXq3Wa?=
Content-ID: <944DA069EEC4134FA1189C69924AFA11@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6fd973-1961-4dd4-87eb-08dbfc7b0ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 08:02:39.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7jtjm6qTlYiJHDkydyUUu2QBoWO8EGZlLSz0+OsHoE8VV3OzfnBzistvDpJGXU1oHyWoEuEXtgEE61RJ+mSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_000253_110128_11282291 
X-CRM114-Status: GOOD (  33.48  )
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

On 2023/12/13 19:13, Edward Chron wrote:
> Submission to Project: makedumpfile
> Component: dmesg
> Files: printk.c makedumpfile.c makedumpfile.h
> Code level patch applied against: 1.7.4++ - latest code pulled from
>      https://github.com/makedumpfile/makedumpfile
> makedumpfile Issue #13
>      https://github.com/makedumpfile/makedumpfile/issues/13
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

Hi Edward, thanks for the patch.

How can I try the dmesg using /dev/kmsg with the caller support?
I tried the latest one [1] and "dmesg -S" prints them but "dmesg" doesn't.

# ./dmesg -S
[11894.954745] [T59093] XFS (sdb2): Unmounting Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.572717] [T59101] XFS (sdb2): Mounting V5 Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.647821] [T59101] XFS (sdb2): Ending clean mount
# ./dmesg
[11894.954745] XFS (sdb2): Unmounting Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.572717] XFS (sdb2): Mounting V5 Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.647821] XFS (sdb2): Ending clean mount

I would like to make the log format consistent with "dmesg" output.

# ./makedumpfile --dump-dmesg /proc/kcore a

The dmesg log is saved to a.

makedumpfile Completed.
[root@t110h ~]# tail -n 3 a
[11894.954745][  T59093] XFS (sdb2): Unmounting Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.572717][  T59101] XFS (sdb2): Mounting V5 Filesystem a41e38db-e035-4995-8276-763f499a33df
[11897.647821][  T59101] XFS (sdb2): Ending clean mount

[1] https://github.com/util-linux/util-linux  (top: be59729281c6)

Thanks,
Kazu

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
> ---
>   makedumpfile.c | 35 ++++++++++++++++++++++++++++++++++-
>   makedumpfile.h | 22 ++++++++++++++++++++++
>   printk.c       | 29 ++++++++++++++++++++++++++++-
>   3 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a6ec9d4..5172ee2 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2118,6 +2118,7 @@ module_end:
>   		SIZE_INIT(printk_info, "printk_info");
>   		OFFSET_INIT(printk_info.ts_nsec, "printk_info", "ts_nsec");
>   		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
> +		OFFSET_INIT(printk_info.caller_id, "printk_info", "caller_id");
>   
>   		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
>   
> @@ -2133,6 +2134,7 @@ module_end:
>   		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
>   		OFFSET_INIT(printk_log.len, "printk_log", "len");
>   		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
> +		OFFSET_INIT(printk_info.caller_id, "printk_log", "caller_id");
>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -2462,6 +2464,7 @@ write_vmcoreinfo_data(void)
>   
>   		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		WRITE_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2470,6 +2473,7 @@ write_vmcoreinfo_data(void)
>   		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		WRITE_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		/* Compatibility with pre-3.11-rc4 */
>   		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> @@ -2921,6 +2925,7 @@ read_vmcoreinfo(void)
>   		READ_STRUCTURE_SIZE("printk_info", printk_info);
>   		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		READ_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2932,6 +2937,7 @@ read_vmcoreinfo(void)
>   		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		READ_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -5603,7 +5609,34 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
>   	msg = logptr + SIZE(printk_log);
>   
>   	bufp = buf;
> -	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +	bufp += sprintf(buf, "[%5lld.%06ld]", nanos, rem/1000);
> +
> +	if (OFFSET(printk_log.caller_id) > 0) {
> +		ssize_t numspaces;
> +		unsigned int pkc;
> +		char idtype;
> +		int digits;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(logptr + OFFSET(printk_log.caller_id));
> +		idtype = (pkc & 0x80000000) ? 'C' : 'T';
> +		pkc &= ~0x80000000;
> +		/* Determine size of padding space if needed */
> +		digits = snprintf(NULL, 0, "%u", pkc);
> +		numspaces = CALLER_ID_SIZE - digits;
> +		if (numspaces > 0) {
> +			char spc[16];
> +
> +			memset(spc, 0, sizeof(spc));
> +			memset(spc, ' ', numspaces);
> +			bufp += sprintf(bufp, "[%s%c%u] ", spc, idtype, pkc);
> +		} else {
> +			bufp += sprintf(bufp, "[%c%u] ", idtype, pkc);
> +		}
> +	} else {
> +		bufp = stpcpy(bufp, " ");
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
> +
>   /*
>    * Below are options which getopt_long can recognize. From OPT_START options are
>    * non-printable, just used for implementation.
> diff --git a/printk.c b/printk.c
> index 61e0b26..5ebda45 100644
> --- a/printk.c
> +++ b/printk.c
> @@ -113,7 +113,34 @@ dump_record(struct prb_map *m, unsigned long id)
>   	rem = (ulonglong)ts_nsec % (ulonglong)1000000000;
>   
>   	bufp = buf;
> -	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +	bufp += sprintf(buf, "[%5lld.%06ld]", nanos, rem/1000);
> +
> +	if (OFFSET(printk_info.caller_id) > 0) {
> +		ssize_t numspaces;
> +		unsigned int pkc;
> +		char idtype;
> +		int digits;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(inf + OFFSET(printk_info.caller_id));
> +		idtype = (pkc & 0x80000000) ? 'C' : 'T';
> +		pkc &= ~0x80000000;
> +		/* Determine size of padding space if needed */
> +		digits = snprintf(NULL, 0, "%u", pkc);
> +		numspaces = CALLER_ID_SIZE - digits;
> +		if (numspaces > 0) {
> +			char spc[16];
> +
> +			memset(spc, 0, sizeof(spc));
> +			memset(spc, ' ', numspaces);
> +			bufp += sprintf(bufp, "[%s%c%u] ", spc, idtype, pkc);
> +		} else {
> +			bufp += sprintf(bufp, "[%c%u] ", idtype, pkc);
> +		}
> +	} else {
> +		bufp = stpcpy(bufp, " ");
> +	}
> +
>   	indent_len = strlen(buf);
>   
>   	/* How much buffer space is needed in the worst case */
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
