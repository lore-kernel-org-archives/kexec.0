Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED98C54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=blDHy61fYp+37M/yDcjgPdcatXcP7TNfHero26dnNN0=; b=whrzqWcdteswXI
	NbCVcjDTDB+qzbXPKXNhLfRaj89GvxBmgeZnZgMqc8+SGIvEVETSWx/ebMUMub8UQ9s1m/ZKD7RhX
	B4fDkQpmN/5COuh+lF16V5lMZENkUwLjfTmRKEWQOwyHYrQoKzkAqwP6Y12vZDoHuddGmB2b717Cd
	EmcA/PPzrY83/M6wZ8pB6G2nrefviEP8VVakkO5uLFhozaMldMonrgHd525N0uTolclGdwAzNP3MV
	k0tOOLghmWG2dSTw55qW44hdSbonk00kRfs+oyVbN/SodizLSCV73B0WsmWhqy/hu2e24hyjMP88H
	HB7WcFiv1GbEb1eK/z3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCNP-000000026Ps-3txc;
	Thu, 21 Mar 2024 06:58:11 +0000
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCNL-000000026NX-0zBt
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 06:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711004287; x=1742540287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WTSGiqdq45LBF8lw6wMpbWfskzb5Bb4oRiGSpZxt9HA=;
  b=dLAQQLYYfS1awX+XqKKBZAMc8hjkcmSgPSYAjtePHV1Cv1peLWod7TsR
   JZoLkWkZOhxzCBiWw7v7Cut37rF0Il6OfXJxd7ISVxam2bdJcJwHbGIWK
   7nj7J3VPvAra9sEEPhiSmJip48inFOk5HGH30Cb4IvLjQEa39b5+wNSnl
   tmbHo7LoQkozDqlBYfXAdl/L9shvHDUPFQdYD+/A7agCx0Azp4Q7dbU4w
   GWjCFhmkX7S+c0fJ45n6/bDfQuQ/2hySXB4U3BVU3IYtzTRs0SsRFuRqv
   vd6d+Gpa/dYlsE7zS/AG+bAVZeJd0thpAOX4eOcGiG8fA2F7APYJuKsuO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="114697045"
X-IronPort-AV: E=Sophos;i="6.07,142,1708354800"; 
   d="scan'208";a="114697045"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:57:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aaveq2HWiCqXYTeLusxon9D5DkUeHR5FY2Cp5CC2KnkP+OGLquFyXsWryOLf57ePofHShhI/vOHMimexqIp6sBM4VD4RbmLSdWF8EQv7Ddbs3GXFrxHRKAd2hk8c9a4MYlSZM5wQtwbUqLAJbzGWSnJr9gHkFiAw4xT23GQWq9RZQPSQ6UgfbtWUrcakcYhcWhvPv3AfrYjtjvdurdeYKUJdTMae/AFvHHYkixgsIln/rSIOVulek18273S05rIyeTGIDlsBmLfBn4KmpmfBf6k10LJOrIyJztU+FdOaSbxyQFV5nFPrAtGcW5Xbzd3Yqpp8ttjJxMeET3hNxOsdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTSGiqdq45LBF8lw6wMpbWfskzb5Bb4oRiGSpZxt9HA=;
 b=jsxFKWWukWnkYHEsgXyplkBuv0+VANxzDh4J6dUjkHTTjdIQQaTpePQXYwZ91YHmjGv9Rjm8xLjXEcLZKpGuH9WzK7soCbqjTcZiwrXb0M5zHIuW+365n1ZqrbuGs59i77Fkys89cvPcvy/VanCT9U2TWzFDqIr/2QtCJDv5A6hurCexwrS2hCF07gLAC9cwYHF26Glt/46MmzK1weMKCIzcaAheh6Lw3RBRHN9vHLcwj4aI7xZgEPTN3HHj3yRBFAIpqIy2pHhbqTXDdrWD8KqbNScEog3foWx5nvxTI070AI9reGysg0eWviavVFFez+6rjfOkA4hArwfm+GlRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS7PR01MB12114.jpnprd01.prod.outlook.com
 (2603:1096:604:262::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 06:57:55 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 06:57:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Baoquan He <bhe@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "hpa@zytor.com" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vishal Verma <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Topic: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Index: AQHab7EiTzrhxogi+kGW9pFQmlxZOrFBxRcAgAAKTQCAAAtQgA==
Date: Thu, 21 Mar 2024 06:57:54 +0000
Message-ID: <db1e0dbb-1949-4fc0-b0d9-9c55ec6cba99@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
 <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
 <ZfvQ3qbRWCZeSb62@MiWiFi-R3L-srv>
In-Reply-To: <ZfvQ3qbRWCZeSb62@MiWiFi-R3L-srv>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS7PR01MB12114:EE_
x-ms-office365-filtering-correlation-id: 8aa5173b-b39b-4e94-24fc-08dc49743bde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WveOgOVGFeaFedOKvPuV+bKNX/5z9Fq/kRRvDr6eYlStBgtOAQoWbZk8Uvtuq9q9KbjRt02aIHaNZgh0bnSjaQmjM1llqiDcNy+mfswpVvOnSVvlzh5ycAhRgSwQIicO5+rQi3SGc9PmAfM4k1vIZnkhXSrJMy1uIYQqv14b8wFXGYLYPkneF79xwax2UBbBBjbxrhUtmgshIEorV3goi4B642L6QpVkuqcwoEOSHlXng56qcyPRbS2JxfAHrKZ3AcVezG+HtuIathBPqyDQSxHWW1Rhl30L+ON0GqX7dpVAnpdadAO/TAYEr3DslBoSVLaBn7VcN1jU669sNVffZ9zM/RfLYhHE9WnDFL2dQ8gzoUPo0lXAbyFI/MZnqBKR7C1c7shtBHXxcHKbaQ63eoJ7IVDFutVtBfjqeT+KGS6vKhd4iewVFJTZwra6iEjysmsKpItrtrqdb9lhB6q8CeH0h1AKcDeL7eqAbHpLMaQ2Q0eDpaeG2n2gf2L/KYM819kceQYpawFjYac1o70fio5nirmlRXf6Xokqvz7rCx8LYgcS/ERj74c6eoGEq5QMILw/KaqPHmVwgtnW+iXkZV3ULIT7neaXwFAEE8dsDUZ3G8sXk2ed1oCDqbkslSlABhYEBc911NkjynHlfB7/IBl7YgCs32MNv9VK+gTUSbxZL1jILvlJVgLcmHOUp4k+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjZIeUp2Mk45bW80dS80THhiUHhocWxTa096aFFxL1dOWlhJQlVtTitmYmZv?=
 =?utf-8?B?ZURvYnFOSHJQMmExY21lUDBRTTVXZFlIUmhXYzhJNGNxZnlRY0VLNXlZODlT?=
 =?utf-8?B?aDMxclhvWG5OZzdYYWlxMDh4MkNIczhVaGxiY0E5Y2pYMjBvbEdUWmVXYURl?=
 =?utf-8?B?NlBwbWdoNWlRTU1SUWJwV2Z0UGZmZWgreEJ5RnhvQTZmNFNVL1o5YkxvSkc2?=
 =?utf-8?B?Nis1TGdLcWFpd01BSmhxdUxFN3NJaHZCWTBUMlZXNHVsdktZN0hxUVpjcStt?=
 =?utf-8?B?amRsUEFnZSt5aVYxWEpyaDZhSGhNSlhVbFlvNlJGdkVKRlExQ0xXMHlSRGlT?=
 =?utf-8?B?MWVlYkx2dlBpeTlkdjFRdG82dlA4QWxGYmtLZGlNcXEyNGFHM0pQVGdqaEtE?=
 =?utf-8?B?ajZ6V0taYXZIVVdnWVB1SHh0bXRkUWd5d3cyVDY0SjQ0RE1leU5GdEhEeEF5?=
 =?utf-8?B?MzVxTTUrdGVYQW9zdFY3K1grbW5TSWlLdGhGaWs4YmcrK3kxTE1sUldxb1lV?=
 =?utf-8?B?TmdKOEU2UzlJa05pdWhYcDBtR0J1UWIzN2M0T2xkRGZpSVE5ZjR0bElxaUU5?=
 =?utf-8?B?U1A3VGdGL3JHSVJlYUZKQkk3TkVOcTFzWEV0YllvSmFVV1NqMHlzZ0ptYkpQ?=
 =?utf-8?B?ays0RUZiQkN5K3hsb29rR0YxdEt2QU13ZWZPUEVacTJFZzdWZmVWaldGYUt3?=
 =?utf-8?B?Q244NW9id1hzU0MrN2NLZ3d1M1RlSURLUjJydzEwL3g2SGZ2Mk5wb0JYajIr?=
 =?utf-8?B?SkJvSHQ4MHl0c1lWRHJYSDdJaGJQQ0tnckg2VE9pQWVlUldScHkyQUc4S01K?=
 =?utf-8?B?eEpvdUNCLzhvTGRGWHpSRUVtbU53eTZRZ1dnbHdPbm9yWllDYVdZaTVMWWVK?=
 =?utf-8?B?Z2FFN0U1VG9hUEdSL2Z1SVhLWW04TXRqR3YvMnFrNlVpWFFVb0gzbnpBUWR5?=
 =?utf-8?B?b3BPTGJpMTY2MVEraDNIdUFKZC9DMDZIYVR1ODhXS0pMblY3c3NJb3Z1Q1lD?=
 =?utf-8?B?czJ6bDRYRVg3UEZWbWRXZFZjNzlzM3NJaUh2cUNzNzBXVHBlVVFnSU9ZT05V?=
 =?utf-8?B?VDlNUUpMZXliWUFHNzJnWWZKWnphWVk2OVc2WWZ1Zmx1ejNrcFZyUlNCZE5p?=
 =?utf-8?B?eVNDVnQ5KzRsQjlDVU9zaHZiTU9DWXo1WmJBVlQ0bzZOMjdvQnZ5eGo0Vjdt?=
 =?utf-8?B?bnVIWVhreGtJYkc1NndMR2xRM2d3MjM0eXFQdmlvTTlDaHpxcUdEV0pldEc2?=
 =?utf-8?B?SDhsdFVjV0ZCTERCVUNnYldITklDWTFVRnZEY0orMm5ucHZqdTR0djQvZmJs?=
 =?utf-8?B?T2U4c09hSHFnYmh3VjBEcXY5SmZJL2FXSWJxLzV4VlhZMS9wbWd6Y1c1Z1Bi?=
 =?utf-8?B?L1dMWTNkWGpNaW5iaHUxMGxubEVlSHd2b0dWeWFUUGN3a0tPZk9TOTZ5WENM?=
 =?utf-8?B?bisrWFJLU1VKZW5EZ2VYWjllaER5QmMrdjRGRWVBZFZSZTZ0TjBqcEgrRGxX?=
 =?utf-8?B?dHdRUVQ0MjZsRTNqZXBLMWs1ZldmUFExdDlYQmd0blVhSmJVRUNyY3dSRzJy?=
 =?utf-8?B?ZmFuK2lKRFhjVmtmSkoyK1BIK0pSQlhYb2U3aExhemlRV29sTUNMWS8zdytm?=
 =?utf-8?B?MVIyUjc4OVdQSG5BQXNmNEZNM09kblUxdWVKeGdFdEVmUWRMQVluUDlTa0Zj?=
 =?utf-8?B?VGVvaE1acFRaelh3VkhyejE4U2hreVBIMTJjYXc1bUdZK0tjV2tvTnc4bWx6?=
 =?utf-8?B?bXFlSytZTm9VSXppNjlaeTlyVnUwN3ZrZE9mOXZ6UFo4ZEtWZC9PWkhZRFZx?=
 =?utf-8?B?b01IdGwwSnZZQXVnM1VKWnBzOFJwa3cvNTVFQU9JSytKQkpJekc3aTRDYk50?=
 =?utf-8?B?K1BnTWJDa3RNZUFEUG45ODFYYVNRSWY4UjFQd1dkdVU3RGQ5eElLSmhRQU52?=
 =?utf-8?B?TWVPTlJITkJScDlKTjdFRjcrK3E3VjJURnltdXVKNnlsVmdhTEJYSnE3UzRz?=
 =?utf-8?B?amkzZ09BSngxeFBpejQ2WUJXQndJUzBIWDNRQUdGcmVPUGhiMFl0dTVqZ1NO?=
 =?utf-8?B?WGFhckZEUDJJSkVhUURXeVlhVEJHMko1UkprM3gxNzNrSjVrRndKVG1hbm01?=
 =?utf-8?B?V01YSVJnbVpUMnROV1VNNFVic2Uwa3FnSjZLbzBPNGJaMGV1S3Q4QkNQT3hM?=
 =?utf-8?B?TUE9PQ==?=
Content-ID: <52DF31C145404C48BDBD5B68051AD0B3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5M57jUn7oR+OSYK66x+GIuHmA2OVidxVRueHXPAeVZiFokNc2T1Xe5KBiJrNzFoxcNpWOecdqe/L5Sr92YEG3LtKPLaTJ/SsPJP4bXptLCZd+zJwPBUt4YIgmM5H7zOE/OnW4Ixx04LhL+x2HLBA3jw5v9WdzRgWHbGpGJ8eF+cVNfAZezMloyfXifkv7uB7w/A0Y9BMjJiZDZ3bCJz/Ihx9YCd1R1GuGGvQl/CJKO9oHF11vgsHl1dIqPh2tXv6OtGwFtWTn9hB0Pup0waFfKE0gm6FoM93JPy41QqbWXnMFs1Dfw36RiVUgyRdvgAba2JRAKYPFKXdzsc3RvPQmc6w+zYuosrU9FYtsXJTMgtpT7juwBjIliX51OUw+ICUk4wfuJLIYxCZoy6VUejv+gIhGEnJEK+j0/5EM8NMmEsSj176KCagP9+gWUDt2AcPwdACzRcGf8L2ZjEWsQhOS0stZhfkHxl5ObAIhhrG8f8O0+X+pPnsHXuYgPJzmztqqHdbCD1OZcMq+GLaGhF79u7YhxOii794T1qUsvHnVDoh54Z+7inbprDbpBe+i/rcccGOtTL5MtBG63phGgvUzqkZTGS7IjGp5T/dYbAamyj61k3SIvRZYcHDNB/IBhfN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa5173b-b39b-4e94-24fc-08dc49743bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 06:57:54.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8Q4PDABSwaYpdi+zToskn7YJ/+YlPkFhUrHV5PO8veMMCE1kV8p+vXX5quF5aewC04DO93aYRLYUq4zvbU+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_235807_823443_A45A9406 
X-CRM114-Status: GOOD (  24.47  )
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

Baoquan,



On 21/03/2024 14:17, Baoquan He wrote:
> On 03/21/24 at 05:40am, Zhijian Li (Fujitsu) wrote:
>> ping
>>
>>
>> Any comment is welcome.
> 
> I will have a look at this from kdump side. How do you test your code?

Thanks for your support.

- nothing change is required for makedumpfile and crash-utils
- nothing change is required for kexe-utils if you are using kexec_file_load(2)
- kexec-tool needs apply below patch if you are using kexec_load(2),


After the coredump is collected, crash-utils is able to inspect the device backed vmemmap memory.


 From 4a2f0f91cdd8b084bb4ebafdc4f71b8e2a333720 Mon Sep 17 00:00:00 2001
From: Li Zhijian <lizhijian@fujitsu.com>
Date: Fri, 1 Mar 2024 13:44:36 +0800
Subject: [PATCH] consider device_backed_vmemmap dumpable
                                                          
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
  kexec/arch/i386/crashdump-x86.c    | 2 ++
  kexec/arch/i386/kexec-x86-common.c | 3 +++
  kexec/crashdump-elf.c              | 2 +-
  kexec/kexec.h                      | 1 +
  4 files changed, 7 insertions(+), 1 deletion(-)
                                                          
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a01031e570aa..757922dc3a57 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -284,6 +284,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
                         type = RANGE_PRAM;
                 } else if(memcmp(str,"Persistent Memory\n",18) == 0 ) {
                         type = RANGE_PMEM;
+               } else if (memcmp(str, "Device Backed Vmemmap\n", 22)) {
+                       type = RANGE_DEVICE_BACKED_VMEMMAP;
                 } else if(memcmp(str,"reserved\n",9) == 0 ) {
                         type = RANGE_RESERVED;
                 } else if (memcmp(str, "Reserved\n", 9) == 0) {
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index ffc95a9e43f8..0dd76903e7fc 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -111,6 +111,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
                 else if (memcmp(str, "Persistent Memory\n", 18) == 0) {
                         type = RANGE_PMEM;
                 }
+               else if (memcmp(str, "Device Backed Vmemmap\n", 22)) {
+                       type = RANGE_DEVICE_BACKED_VMEMMAP;
+               }
                 else {
                         continue;
                 }
diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index b8bb686a17ca..98ad854e3f8d 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -199,7 +199,7 @@ int FUNC(struct kexec_info *info,
          * A seprate program header for Backup Region*/
         for (i = 0; i < ranges; i++, range++) {
                 unsigned long long mstart, mend;
-               if (range->type != RANGE_RAM)
+               if (range->type != RANGE_RAM || range->type != RANGE_DEVICE_BACKED_VMEMMAP)
                         continue;
                 mstart = range->start;
                 mend = range->end;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 1004aff15945..c0481bb2727d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -139,6 +139,7 @@ struct memory_range {
  #define RANGE_UNCACHED 4
  #define RANGE_PMEM             6
  #define RANGE_PRAM             11
+#define RANGE_DEVICE_BACKED_VMEMMAP 12
  };
   
  struct memory_ranges {
-- 
2.29.2



> 
> By the way, there's issue reported by test robot.


I see, i have fixed it locally which doesn't matter for this feature(it fails in !ZONE_DEVICE)


Thanks
Zhijian

> 
> Thanks
> Baoquan
> 
>>
>>
>> On 06/03/2024 18:28, Li Zhijian wrote:
>>> Hello folks,
>>>
>>> Compared with the V2[1] I posted a long time ago, this time it is a
>>> completely new proposal design.
>>>
>>> ### Background and motivate overview ###
>>> ---
>>> Crash dump is an important feature for troubleshooting the kernel. It is the
>>> final way to chase what happened at the kernel panic, slowdown, and so on. It
>>> is one of the most important tools for customer support.
>>>
>>> Currently, there are 2 syscalls(kexec_file_load(2) and kexec_load(2)) to
>>> configure the dumpable regions. Generally, (A)iomem resources registered with
>>> flags (IORESOURCE_SYSTEM_RAM | IORESOUCE_BUSY) for kexec_file_load(2) or
>>> (B)iomem resources registered with "System RAM" name prefix for kexec_load(2)
>>> are dumpable.
>>>
>>> The pmem use cases including fsdax and devdax, could map their vmemmap to
>>> their own devices. In this case, these part of vmemmap will not be dumped when
>>> crash happened since these regions are satisfied with neither the above (A)
>>> nor (B).
>>>
>>> In fsdax, the vmemmap(struct page array) becomes very important, it is one of
>>> the key data to find status of reverse map. Lacking of the information may
>>> cause difficulty to analyze trouble around pmem (especially Filesystem-DAX).
>>> That means troubleshooters are unable to check more details about pmem from
>>> the dumpfile.
>>>
>>> ### Proposal ###
>>> ---
>>> In this proposal, register the device backed vmemmap as a separate resource.
>>> This resource has its own new flag and name, and then teaches kexec_file_load(2)
>>> and kexec_load(2) to mark it as dumpable.
>>>
>>> Proposed flag: IORESOURCE_DEVICE_BACKED_VMEMMAP
>>> Proposed name: "Device Backed Vmemmap"
>>>
>>> NOTE: crash-utils also needs to adapt to this new name for kexec_load()
>>>
>>> With current proposal, the /proc/iomem should show as following for device
>>> backed vmemmap
>>> # cat /proc/iomem
>>> ...
>>> fffc0000-ffffffff : Reserved
>>> 100000000-13fffffff : Persistent Memory
>>>     100000000-10fffffff : namespace0.0
>>>       100000000-1005fffff : Device Backed Vmemmap  # fsdax
>>> a80000000-b7fffffff : CXL Window 0
>>>     a80000000-affffffff : Persistent Memory
>>>       a80000000-affffffff : region1
>>>         a80000000-a811fffff : namespace1.0
>>>           a80000000-a811fffff : Device Backed Vmemmap # devdax
>>>         a81200000-abfffffff : dax1.0
>>> b80000000-c7fffffff : CXL Window 1
>>> c80000000-147fffffff : PCI Bus 0000:00
>>>     c80000000-c801fffff : PCI Bus 0000:01
>>> ...
>>>
>>> ### Kdump service reloading ###
>>> ---
>>> Once the kdump service is loaded, if changes to CPUs or memory occur,
>>> either by hot un/plug or off/onlining, the crash elfcorehdr should also
>>> be updated. There are 2 approaches to make the reloading more efficient.
>>> 1) Use udev rules to watch CPU and memory events, then reload kdump
>>> 2) Enable kernel crash hotplug to automatically reload elfcorehdr (>= 6.5)
>>>
>>> This reloading also needed when device backed vmemmap layouts change, Similar
>>> to what 1) does now, one could add the following as the first lines to the
>>> RHEL udev rule file /usr/lib/udev/rules.d/98-kexec.rules:
>>>
>>> # namespace updated: watch daxX.Y(devdax) and pfnX.Y(fsdax) of nd
>>> SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="bind", GOTO="kdump_reload"
>>> SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="unbind", GOTO="kdump_reload"
>>> # devdax <-> system-ram updated: watch daxX.Y of dax
>>> SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="bind", GOTO="kdump_reload"
>>> SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="unbind", GOTO="kdump_reload"
>>>
>>> Regarding 2), my idea is that it would need to call the memory_notify() in
>>> devm_memremap_pages_release() and devm_memremap_pages() to trigger the crash
>>> hotplug. This part is not yet mature, but it does not affect the whole feature
>>> because we can still use method 1) alternatively.
>>>
>>> [1] https://lore.kernel.org/lkml/02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com/T/
>>> --------------------------------------------
>>> changes from V2[1]
>>> - new proposal design
>>>
>>> CC: Alison Schofield <alison.schofield@intel.com>
>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>> CC: Baoquan He <bhe@redhat.com>
>>> CC: Borislav Petkov <bp@alien8.de>
>>> CC: Dan Williams <dan.j.williams@intel.com>
>>> CC: Dave Hansen <dave.hansen@linux.intel.com>
>>> CC: Dave Jiang <dave.jiang@intel.com>
>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> CC: "H. Peter Anvin" <hpa@zytor.com>
>>> CC: Ingo Molnar <mingo@redhat.com>
>>> CC: Ira Weiny <ira.weiny@intel.com>
>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>> CC: Vishal Verma <vishal.l.verma@intel.com>
>>> CC: linux-cxl@vger.kernel.org
>>> CC: linux-mm@kvack.org
>>> CC: nvdimm@lists.linux.dev
>>> CC: x86@kernel.org
>>>
>>> Li Zhijian (7):
>>>     mm: memremap: register/unregister altmap region to a separate resource
>>>     mm: memremap: add pgmap_parent_resource() helper
>>>     nvdimm: pmem: assign a parent resource for vmemmap region for the
>>>       fsdax
>>>     dax: pmem: assign a parent resource for vmemmap region for the devdax
>>>     resource: Introduce walk device_backed_vmemmap res() helper
>>>     x86/crash: make device backed vmemmap dumpable for kexec_file_load
>>>     nvdimm: set force_raw=1 in kdump kernel
>>>
>>>    arch/x86/kernel/crash.c         |  5 +++++
>>>    drivers/dax/pmem.c              |  8 ++++++--
>>>    drivers/nvdimm/namespace_devs.c |  3 +++
>>>    drivers/nvdimm/pmem.c           |  9 ++++++---
>>>    include/linux/ioport.h          |  4 ++++
>>>    include/linux/memremap.h        |  4 ++++
>>>    kernel/resource.c               | 13 +++++++++++++
>>>    mm/memremap.c                   | 30 +++++++++++++++++++++++++++++-
>>>    8 files changed, 70 insertions(+), 6 deletions(-)
>>>
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
