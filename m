Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73C1C25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5T70x0eriIQMiHo8oukyZfGJuoUdcCpXhJNeqxVewIE=; b=aGF4IliQdS9aNf
	oSATA3EMZXIDHM9T29QERTNWYeu2ZKCFGi7izyHcfNIyL433ejv8HFUpfx6UM9eS57JoECQS3QlZy
	V8Wmu/HTMFA1uAMsVKnBPDhRnkBfq2yU+bUGKKPT8kgze6nRko0Cn4DAi/4Q1CagZhe7vt7Ip4We7
	LN7Js7lLBWKwDf4SeDHTvAgWgBMvK8BKITNJGqO/fihjXM9KRdUOCJPOVNvfdZjJAOyQ4M6KfC4Ys
	yRreNZ5ZKtp4xQdl43ysSSva3Yr3Beu0oP80F1uZLjinvZLcpvuy4P6kJi4khLKIMplTGS6ugLfzp
	wRjoo4LtcoZb9gTyVfgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAQOI-00000008OeB-1Cux;
	Fri, 24 May 2024 08:35:06 +0000
Received: from mail-tycjpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:2019::601] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAQOF-00000008OdG-0QWl
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 08:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8Xwp62Yj8C+Cde1EfEfJozR0UwDRRC/jyNcxd6vwOhyXv9n5ejpLf2etn7BaBuVBUEARalyaMa0EkdVKy7ENSqIyB+Mf4SP9ZraNCj8Hk5wjh6/c0N/r/mno5phUj3G3hBJL7pY+jQLGml6JP6n00qrLEmPLccBCByT7hdWKr9cFHnZzr+7BocImSOsrw4R6/XmBtfaAOdtQYq16VcW4yyteLjde8NKlP/r3Jm7sM38FBIS1aRDmc1og2yHoC0DxefN6ju0o4Cv+6F/8qv4wSXxVdprgRHLAKARd5nNRU50MxCeKUkQRS/LG3cgWCoYqUe00pk0Fj3gXmJVyC6UDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+RwaurXreaEfNDLXyhthdYsuhAZpd4/KkuQZ0wFBi8=;
 b=iSOcibEV+3u1PsVDvmHbEORp5LW7Bq48lrumAR/iE/C33JjFRelMK+TycWqJtQMJoZbstkdV5rjVfwfz7kiZGvqowowHwIA10d5gsYAdOfVBcpjVLGr4gZ5t9oDqLBErc/Pl4QLG7xHWtod7F3VPyIggtPm7UP4eA7f0KZQUZqr/3ztkIMgn/Zl3//YCY6c54eavd8CdxQKErG8PbOCS3cXsRKqS3qfxdBC4QZFYTcCqX89h3XrkM9tXWB4QNGhn7fSw7h+JUDyqe8Sau4t0WtujdPsRq1JeAD5XDbKjubc5gduASDZ3zstKc7c/FBAtitRhoBn4xQ0DB5jXELL1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+RwaurXreaEfNDLXyhthdYsuhAZpd4/KkuQZ0wFBi8=;
 b=c9aWfrxkN9O6XRngW92tDrOiK825oVkWK+zSTn4Nj1hQPNOMLCBDWOgtmCw8iNensZnJwTIUE/tLMzltLJQFt/JV8R4I1VLldmF79d4mAnfBunUiU8FLBJZI5DZA7NVOtI2v8zqoRyrut+uz/FQwwCmLP7JU7ozi2sV/iVIqpriHXP51v4cis3i13Dpo+cyqIf5+AQq07kblT8hPR0dSag53VpFFLpJcG48ugxD6q2k6bmIzNfdnzWXPBrwTIyJGd2g4ahWDB3f7Y8A1hBuRYpHmQ1ZCDJr258mN5kCbZdHD3g8I11OjZiTz9mgojb3bUY1K/KD1gO0YTAIMQorqLg==
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com (2603:1096:604:18a::12)
 by OS9PR01MB12213.jpnprd01.prod.outlook.com (2603:1096:604:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:34:40 +0000
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce]) by OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:34:40 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Coiby Xu <coxu@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile] Make sbindir configurable
Thread-Topic: [PATCH makedumpfile] Make sbindir configurable
Thread-Index: AQHarbUzyRefM1ax8Uq9mo+kIQ+A6g==
Date: Fri, 24 May 2024 08:34:40 +0000
Message-ID: <9d160cb4-bb4f-4132-8800-ff681d5c3b87@nec.com>
References: <20240424022047.13325-1-coxu@redhat.com>
In-Reply-To: <20240424022047.13325-1-coxu@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8561:EE_|OS9PR01MB12213:EE_
x-ms-office365-filtering-correlation-id: e30fbc8b-e332-4dab-a780-08dc7bcc5a7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?djdjMzQ5N1MvYVdwMGQrOHZzQXJPMnBDdWtZTHJWZEJwdUkwWTlReXZqc2ty?=
 =?utf-8?B?eitVOEZXeFdrRGhQUzdtNzdteHV6RzQrRTFkQ29pRzFMZGsrN3ZxSStBZzZz?=
 =?utf-8?B?R05QcGoxZVZoeUNtNG9WdTcvWW5sVnBiS2Z6Yk9xclNScEd6NVIzSG9iUFBL?=
 =?utf-8?B?ckNsSTR0cXFxWElpZnYwcS94emZpWnkyUW9iOWl5di9HdzhUOEVKZ2JudVRY?=
 =?utf-8?B?Ky9oMFVxRWhOclpWT0VhcVVaSzJpcmVvQXB2cHJKSXBXQkxQa2IzZi9hQ1dT?=
 =?utf-8?B?UEtoWVoxbXoreHBuNE9XeGhMUkV4S3hqa0RnSUpmTk10ZzVPenplaWx1NW5N?=
 =?utf-8?B?c1N1RUN0V1hCWXpwNmVlN3JkTndjNzUrL2lMWlJJRnlrNVNHcHFIeEZWRmt2?=
 =?utf-8?B?UWltSDZuQTJRWmNLaTVoamJFSklpZmZKRitKekZDdzZMekYyTG93MlJhWCto?=
 =?utf-8?B?VW5QRGl1SnN5bzRKdTRVdFI1ZCttR25ncVlrcU1UbG8rVEQ1WnA3NXFrNjQr?=
 =?utf-8?B?VWtGcFJMSEpKRkpkc3A2cDE2S0IwbWJDK3h2RlMzbU8xQ1dibjVzdGRTWHNj?=
 =?utf-8?B?QzBhNUF1MHBxUlR2TXVpTS9tT0YvcE5zUlYzZTZmOWJjZzhGd0s5aHJZS0d4?=
 =?utf-8?B?ZGhZaEUyUGVHc29HQlRIY1VWYmlYNlpkY2JGdGdxUkQ1V3Fray9KUzFmbFNE?=
 =?utf-8?B?R0hrYXFsVlhCY29zZVB1SWxsUnpFVE9vUDFkOHZqY3B2Tk9pS0o2N3JLeHRu?=
 =?utf-8?B?UlpPMWVQeTF1SU1FdG5FVzBibmEwbFBqMnlIbG9MR0N0VVp0QUh4WFdNWUlZ?=
 =?utf-8?B?RVF0M2V3ak4wWnladlpNaVd3ZlNXRHZ4R0daZnl3ZmN5WG0ya21tYTlsUEVG?=
 =?utf-8?B?eVM3T1ZyaFVPREgzT1pCL3BHSkFram00UEhxYUxyeUpyRXNuNkJ1Ty8vZERs?=
 =?utf-8?B?N1pWSzJ2aXcxNjFQQUsyTjN5QUJsc3d2MmdQRzdWV2JwdHNSeHNxa3hwTzNJ?=
 =?utf-8?B?YTJtOXk0ZFNJQnZBUzRsbTA1NnBseW9IOUEzOEg2TDdjano3d0VYSXB4eWtF?=
 =?utf-8?B?ZnJiT0JFRmhRak9KNnE4SVlvM0d1N3JIYk9xWXZzSGJjOFA5K253TGRHWm1q?=
 =?utf-8?B?SXlSQmVadm41Y2poREZCU3VJQWE5NlU1YlJLeWtHMDZYWUduS2JSdTJUelp6?=
 =?utf-8?B?TTBjRU9CTkZMdWxNbTEwSytsQllTTnkxS0thOG1NUURvenJiS0VFRWQ1bFVz?=
 =?utf-8?B?enFDbXIzT3I2WERxbTAwWVdVVFpiYkgxYUFVd0t5YXQyN3RMY3dhcDJqVUJm?=
 =?utf-8?B?TkJnUmNCNEdpYzdvTmNrd2YvY05KT3hGekxDNmw4djBsYjdCdTl3c3NHNG5E?=
 =?utf-8?B?UlZ0OVlCMjZmUWt5YUhKcXVIRG1PSXZHc1ZtNE1GMEVUK1Rpa1pZdk5UajZv?=
 =?utf-8?B?eWVIQ1BvcmVnT1p0OUF5M1ZEalc2RXFQbzBzbW9aYmp4U3lpOUxONWN6eEU4?=
 =?utf-8?B?MnVValJ3WjhoTEdyak1MTXVjRzZnUU5zR3dHREs3ZkhncVY3Z0V1TnVIeHlZ?=
 =?utf-8?B?NjhXamF2SytoZWFsSHlKSFQ2c0drbk95NDNka0lyQkVJWStTTzREcnpyNG1Q?=
 =?utf-8?B?bmFycGVQT1NjVUtLbTFxWFJNUjFqaE1hVklYckdiOS81QzRobkptQ3dXTTVv?=
 =?utf-8?B?WC8yL05jQmlKNUtxelhmVjRLY0ZxQVZEZkFJSUx0VW9DWno5bGNlUkxRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8561.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlDNE1Ta09yY2pTOWNFazkwUzltelRZempETzluM2NFbUN0eVFEdTF2Z2M5?=
 =?utf-8?B?TkM4LzBMREV2T1FVQldaOWNLcG1JZUo2bm1uNUc0S0dKNFMvY1hZYi9iNHU2?=
 =?utf-8?B?TzE2ajNNeW1RVGZocW5CN2pPQWdpL0xTN2czQjIvL2g3aVl4dnFPOXo0QWpL?=
 =?utf-8?B?WmVhSnhTeTdMRnUrNlowVTdzL1lhOHYzQ09ZcEtDTzg0QnJFZ0pyaERPbFU4?=
 =?utf-8?B?YkxURFBaem84VVFFY0VWYms3Y2xUVVV3Qm1jQi90eWtZT3J5YjJCS3JHU05r?=
 =?utf-8?B?MkFhQW1wTUVOSTYvem5wcjFIL3MzbTR1UjJ0K0RQdUlCdEdvOXJWdU9heC85?=
 =?utf-8?B?di8yVTQ1UnNtY2RUeEhCMWJYY2l2eVBoajZTam0wWnJLT2Jrb0RpZlEvcURy?=
 =?utf-8?B?ZHNPZHp2dU91MVJXQmtLNGp6SlBkN0RkZEJ5a0NmM2ZXa3RsdFl0TndqYlZF?=
 =?utf-8?B?enQxRm1VVExhWnFTU1JIVEp6SFRDWnBaaVpkSlk4TTNGQzRWREhTL0dQOTds?=
 =?utf-8?B?dDFtMnlPb1pUeUFvVDRldW50R01lcVJ2Qm1OWkhUdEtVcTlsWDRndlVrbzI2?=
 =?utf-8?B?OFMrM0xwMThOd09Hd2N0dzVBbG4xanV0TGVTdnM2Yzg3bDh3aXdMV0VYOFY5?=
 =?utf-8?B?N25vOGJpZ1BjUGxOUUZSWEJIKzhoWFBRclpacUNSMGxyQzlieDh4YU0wR08r?=
 =?utf-8?B?OEtVWDVvUDV4cGxIYy9CRlhuaCtxUldxblRqM3ZGNU8zZHRzeXJaTHozRHBB?=
 =?utf-8?B?S25iby9ZNGZ2STBlWVFBcWdSVjk0QnQ0MFIzNmpoMUFGTW5ZcTNIWGU2N20w?=
 =?utf-8?B?MitYOEU2U2ZDNzFIMkpNYlQ4U0dxUlQvUUVDQXhpNG5xMDlyNjRNZWlFbVUv?=
 =?utf-8?B?WTMvU1R3VzdoZ3lqUFA4ZjhkMW9pZ1FDeVZyd05XdG1xRENlSzIvSFJORE5C?=
 =?utf-8?B?L1V5TU5hZkdlQTk2YzA5aTkrVFJLK3pFWTJsVWNLVjlnMFNyQk82RWxzVDBZ?=
 =?utf-8?B?ZnVzZ2V0M3MyLzJHZ3VMbVNuYVByb0tsUzZHQVJubVZZZ1N0TGtiaU1WVFFQ?=
 =?utf-8?B?OHYvVFFmcUpEOElJZXp6bksyVWM1U2ZERU41OTd4b2IzRWNWb3ZXOEpUSExC?=
 =?utf-8?B?M1lwamJNcTJmOWRVd2JiaXB4Mk1kT3BUWTBhMVRMYnFHWDNWUDJ0YzBWSXpX?=
 =?utf-8?B?YTI5eUtxM0ZneGdFWWJycXRoa1pvQ1NoVDkrTUhzSTNSZ3B4dWlDMmlUcjNL?=
 =?utf-8?B?R3dhZkNoMXFHMkR6aURHbHBuRVhsbUxxWVBEcXZ5UWhLaHEyMDhsdDVUZGNK?=
 =?utf-8?B?SVdsc0FCamhXVTRGdmE2cjNHNjluSjNxakU2aHc2cVFwNlNNVStJT05SVndF?=
 =?utf-8?B?SUxxcEN0QTFRUU9CRTUyeTVwMGl5Q0tSYkd3TjZGZkFzNi9UdTI5TWR5VDNI?=
 =?utf-8?B?OWpzRE9Ta0szTmZJM2VXNDhvWmczYi9qWS8wbmZrQ1BuWUFIblRnVCtPWVZa?=
 =?utf-8?B?WmZXRERkTldFTFJuYmpRbkRYTTlvckxXUXFCWFdTR1VJbFBodnhuY0hVNHBv?=
 =?utf-8?B?YVFnWW9MSkhJbFFXK0l5Q1lpK3A2N3BlT3JFTnFkQmpSdVUrcDJwcFlIVmhL?=
 =?utf-8?B?Z2ppT21qR053UTRFazVUUkpmdlVmSFdrajg2VllzeXA5aDN3R0hLSjQ4eW56?=
 =?utf-8?B?bW1OaHpNQkdHWnFIM1ZYWk5OS24yUnBFUzBackJvK011dnNwcGkrOElkTFYv?=
 =?utf-8?B?WjB2QXFZZkpoRHVDeHFyUlBPVEphRHFLMmVMeVV3SDN0N0huME1PZ3hjV0Ni?=
 =?utf-8?B?Y3ZCSGk5TkUvUGNXd0U5R2hIMjNlZ2U1eDhPYnludEt2d0J4WEx2OVBwWndH?=
 =?utf-8?B?V0lxZzVneHp1MklRTVpmbE1xaVZNWW1XQnpuNnRSR0NzSkU1SHFrK2hOV0lI?=
 =?utf-8?B?VUNiUHlhdTRlcStGTldqUVFWSTdDRWRSM0JLSTBoNGg1aXlMZElJZVJGU0Rp?=
 =?utf-8?B?ZStxc2Qyc21Ldm1zQkRaNHg3VzdkTkRFbFpSTDdRL1dUVUlIWWpUM0c3ZWQ2?=
 =?utf-8?B?d0src25aWXZrSGdMc0JUTWxGM2NYeGMxS2R6eFl6VWNIaTlMdDhLeGh6UHFu?=
 =?utf-8?B?a2NaVmRNYTRZMFRuVnRVaWxTczJSUm1ULyt0K0pxVEtvSXBZcUozekNVUWJU?=
 =?utf-8?B?Q3c9PQ==?=
Content-ID: <F99AD130E591C442B5374443E3A43E4F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8561.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30fbc8b-e332-4dab-a780-08dc7bcc5a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:34:40.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjZjO0LctFr1ciUZHjcgZ8fZ5MOeVnfvTLeGeBkILF6lpak3Nxw3oWUnDLiFJvnIzLIHcm+NxX8pv79MvWQjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_013503_410189_11398680 
X-CRM114-Status: GOOD (  13.23  )
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


On 2024/04/24 11:20, Coiby Xu wrote:
> Fedora is going unify bin and sbin and /usr/sbin directory will become a
> symlink to bin [1]. So make sbindir configurable to support this case.
>
> [1] https://fedoraproject.org/wiki/Changes/Unify_bin_and_sbin
>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   Makefile | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 55c9c7a..0cd2b03 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -101,6 +101,8 @@ LINK_TEST_PROG="int main() { return 0; }"
>   LIBS := $(LIBS) $(call try-run,\
>   	echo $(LINK_TEST_PROG) | $(CC) -o "$$TMP" -x c - -lebl,-lebl,)
>   
> +sbindir ?= /usr/sbin
> +
>   all: makedumpfile
>   
>   $(OBJ_PART): $(SRC_PART)
> @@ -126,8 +128,8 @@ clean:
>   	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
>   
>   install:
> -	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
> -	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
> +	install -m 755 -d ${DESTDIR}/${sbindir} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
> +	install -m 755 -t ${DESTDIR}/${sbindir} makedumpfile $(VPATH)makedumpfile-R.pl
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
>   	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
>   	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
Thank you, Coiby, for the patch. Sorry for the late apply the patch.

The sbindir variable should be all capital letter, such as SBINDIR.
So, the patch is fixed as below.

https://github.com/makedumpfile/makedumpfile/commit/354fbdd01ccb15e405093f9a631ab8b2bd084830

Thanks,
Masa
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
