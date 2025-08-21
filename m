Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1121ACA0EFA
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kc6typK52E0vgDQ7EBS30CufHmvQVMfmymwdvEPC3ek=; b=v3+T1ST5WVz3VduhIqH5XDfThX
	RYDWorso4koGJcjXAms0EGmuOzWdSBQb1igJAFAIYiUtgOMOxn1DJ8osy39qOpR5qKGEQaOoCrRYX
	Rt14wPX629F6/WESOY7Or/a0S93opMSRbhfmzNeHfPT5wwLkAPD7Xz5JnmaCD1CWXZmXB2KQ3ZEnl
	+U90q1Uf/PQE7gcWf3/Thap9oLaEFmgtnuuiLwlZudXsHeDwxeYnPiLdDs9948G2A77oJbvkftwGj
	ULlpC+mj7Fbuu2Y/K+31k/cMlkKjPjC9QkPas8zg4rv3Xl9+KBO3a2IF5pcmB7l9QxfJlTpGz7oQe
	Vfr44vxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upF1q-00000000xpi-0hxO;
	Thu, 21 Aug 2025 23:49:10 +0000
Received: from mx0b-00273201.pphosted.com ([67.231.152.164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up84K-0000000HX9z-2GGS
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 16:23:17 +0000
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEPBHl011574;
	Thu, 21 Aug 2025 09:22:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=Kc6typK52E0vgDQ7EBS30CufHmvQVMfmymwdvEPC3ek=; b=1VEP
	f1Qu+wO11LxGDgwHuKAusl5tYFb5HoYUzoaAHPosAN2QHghvJNVxH1yKz2c4wrZK
	Elnp/coMnXdYSPyLHWlnkQ2218iz8AYxaV8gyAO+wpP3igclJlc4VOaW4E0ASU31
	LPdbBK/gp1PEfpUj93WXdoZzOR/qLLUbTyrwsRldbZbBNCU7I8Rl5jCcxZfIQ1py
	xBOttwaAqgZMKi8nmIWz/BYlWj8Rqg9oYMk7chOSCPMpJQ6M7X4D8Unvu5ayEjrv
	zbA+fs6rxy0i4qd7JWb43v43iJKIFL62oUgdf/PzIpccRqYpX1W3uAq/Li4gf/NE
	yYFRCvyW/WM056ULVQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022096.outbound.protection.outlook.com [40.107.209.96])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48nwwx1pb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 09:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqdLdF1Lcw+zD1zIAW86CH7CKnavW3NHN23n4AuOrW6wYeGQUDxP2Qzy0yl3ickFeF0eF8+57c1ldx/kAPsL0JF2DzFurGoBuHsqdDQxRZk96/ee69tyF1mPCH25AIMCYGZOHHu+QaLTAdKoahhv/LLeTr3cd1b2QzjqGNJo2TUFCMRJPOgJQfd+T+CQVKvKa6wao88xtxMXPsFQoypWTqlVf34n/UQCtfS+e5rpLAr92gxUEnvqn9aZpGlVT2euRFJJs5wDtJwWj7PcgYdHLxp4smzx5riTfTic4ANE+UBRTFlgCxy5Bk9smcW30bj1CVYCsFEAeMWHozSM2xFV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc6typK52E0vgDQ7EBS30CufHmvQVMfmymwdvEPC3ek=;
 b=W1sER/nnD7LCGHkjSXSymU7B97oF82CxRC/uTBRT4Koy92MyPpIVt9NNd+VduUpvYIgZwwhGzSe7mDsBrXsHfo77ih52vZLqG7vkfgVTiCrLr4VA4Hn52UY1y4ZGoQTz4ENa22WrlLrBdWOeqrO+TCjoTJp8X2bqJ4L0U+kAzKtgFkQAt/pufemvXKcpqE3pykIGWe+0Md8WHTtHnsmYqg8721ift9vpRkuU83i/3ecmF2sOULFN+Uy2kDKaG+qghtH9qV06NHWopFid67DOgWegiCLar2VvEdiixIf244E5cLafSZW6eFC0wnf11h0UlGQAqUM1cxAXygCmzfFeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc6typK52E0vgDQ7EBS30CufHmvQVMfmymwdvEPC3ek=;
 b=C2/AkQYULjyjmA9lZ+kuYbpfLcvF2RaIUJ3exYJr0kj1SDkUUJqtFRpF1shoG8qAi4qxdHMr8imZFW7QhI5hBWjZ3IQDElpXvQQyYo0vefhtR5s6dvfhqhzHxcVJpHP1U796Kzcxm+pdyH+ob3JmVpQFjOEWqzOKr8J3s84c/ak=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by BLAPR05MB7267.namprd05.prod.outlook.com (2603:10b6:208:29c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 16:22:29 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 16:22:29 +0000
From: Brian Mak <makb@juniper.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Alexander
 Graf <graf@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring
	<robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "x86@kernel.org"
	<x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Topic: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Index: AQHcBk4oB5XugUC7+EiYsQsd7ryXGrRsoOkAgADCAoA=
Date: Thu, 21 Aug 2025 16:22:29 +0000
Message-ID: <A39EA0B7-F7C3-49DE-9A35-4CF2A5E49DEE@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
In-Reply-To: <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|BLAPR05MB7267:EE_
x-ms-office365-filtering-correlation-id: fc166aef-a7a1-4154-1cf6-08dde0ceecae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?24eU/emd6SYpnsNrWQBYq81KfGLF71piW8UN/LaNW0rtqGioDtNpreoWMaZw?=
 =?us-ascii?Q?Z2A3lVqZiQn480YkusK+aA50cp/AI8quR3okKv9rw/H7nL91YR1SN6TjXmE2?=
 =?us-ascii?Q?TvJK84aD4/nV7E4mCKEnPUVQCbb4YpqtxDDVI+QasLKTlx6qSpRCVAUhCjqg?=
 =?us-ascii?Q?gATMf+O+zUKAiD9/QJG/IeZWUqR9++tJExVLQbGpqQci+8UzB13c/lQkXT2J?=
 =?us-ascii?Q?iPhWANsv81bXok7fNOtYddlL35S9Tbu7e2af2BDOWXpcIXEFLSgDdDB/WeqO?=
 =?us-ascii?Q?zTLLGPfkQyLZxEL7ssOETtKwIv14D8cZ06i4WPCUW/1ll3lKOcLupeIRBIAM?=
 =?us-ascii?Q?8YiupiBoDjOOpsxmpovmbxk4/TbtdyMmpUSjtzJq2xJRBw2OmqJHjLSAjC9B?=
 =?us-ascii?Q?lzvHzVR/wxXAT6e8mmYXl4Lm9qsPgh9+sEL9zTjs++0q6t0Y2OXB6NTD0Jaf?=
 =?us-ascii?Q?lcFpd3EVmi1fo6qQJA4PQZZ/xCf1gc3h79LOhqmrbSqF5hCEsdR5BQsBT+FG?=
 =?us-ascii?Q?A3hJwyCiMoXVSs7WBE3tPikOKu/FxzGp4mmbCYI+KCVAorZkidb74E0zBYGJ?=
 =?us-ascii?Q?Wh4hAu7/mb4+bMzUg86X4VPJgzYs92sVaFXBHeqoOjW3+D9SvT8o4FXP5JmS?=
 =?us-ascii?Q?W73qyELsWbfQ9R6kjplAuqUpv1/iWhEIJcNe6g9l8bPTQ8KbxymkTlarBcDF?=
 =?us-ascii?Q?sklL9TMt7DlFM8TgvGYqWZp4ce5XUa+07FR3eAZcQeCjb5TCwWD4ecmB4cRS?=
 =?us-ascii?Q?tcLJhDv7micQZUO5eITgjxigTZxlZnWLPhD4Ik9jT/KbeacELF1ood0NGdZt?=
 =?us-ascii?Q?hpO4Px6GUm5NNfxQtWdumnbFlw7zhmp16vw5hJHCtt+MVshrx2jyHdaN2EfW?=
 =?us-ascii?Q?jV19d9Q4JbehITQw/j0y/YVrSaMrhJ71WNowUqpI/+GRtxhR2rBBQu60SePX?=
 =?us-ascii?Q?Pq0yoDSPDGTcOFwJ4SG2ZCgyGjkeEqMivS5dfAqSCkDCvK0h+kHJui8k433T?=
 =?us-ascii?Q?uLK3CVTT+liX+viuh5OEfkKQ2hpLeq2DXb7T0fr9LbatGxJUtYEUsB7y930g?=
 =?us-ascii?Q?u1DKcEOnzdXnioZMcfgfa+FdDNMU25RtdEl1VZ7DDdt7ooJjZeCe0prXoqN1?=
 =?us-ascii?Q?vv8hgZk8/HwifMy4+KSoEkxTQuniWq+YfSkFgPH8i+ppZMs2/cA7UJhHzxul?=
 =?us-ascii?Q?nE2ZR9SbODT0Wyc+9IBMlCcS4oMl8HwlbwwIG64O0GX3itvIOthzowT4yLV9?=
 =?us-ascii?Q?OgfgDLZTdE5D/3HA6YIP5u20RuKQCJTAfZTftvBryTxeokHpJ6+kr3Q0latI?=
 =?us-ascii?Q?EQH+prvpB8bkZ5rs/A1mLaMFgRbpcIIAmZIe+GorfNsDl9x7CVM+fNUBnFPX?=
 =?us-ascii?Q?TjlxAr7gOFBjbmnjt5eMDYE4CwFC4zQ39QyDe9oQF/CuIi9IjPBlD1YD8sz4?=
 =?us-ascii?Q?KZetr4bkwZp0WIusq3l4dqxvb4nQ7hQl2yZk21Jh7Wu6ouQLGaR2Tg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u62prcj2lqBPGYMrJ0jDFGXJN0LARbDkFW8mfaDVX0nhkWzTDFK95HYlWbgF?=
 =?us-ascii?Q?K2LD1d2zwvV7VVtCWvOAltqvpKyThpNUby6OK2zQPlcyAmhIfUdXus3VThcm?=
 =?us-ascii?Q?Xo80v8C/2Y72fZfyZ0D7jyaYrTTd+WjRRzJJOuCH+OSEy8baGBFCQaklkslr?=
 =?us-ascii?Q?sy+nTCklrR12L0QBIBRXO3/beCOiwIgi2rTBHLFP1JpMaRDTWWE+jWU1kJpN?=
 =?us-ascii?Q?Y5d0ecsaX+yKrQ81SjU7yhZ1ZUsobHgMfDclCr29RN66FzBXOPvVpo9a1IJa?=
 =?us-ascii?Q?yBI6ZHtKaDQ7LtVJPTHyz46p+UNRSODgi4OjgtsGaLMevm6TNzQTKOxhPz7F?=
 =?us-ascii?Q?iybACorWipIv+zbpdjoPlP/xFDnrxbQ2Kv5RSWbt4ee42/A5OLsNCPjJz7Eo?=
 =?us-ascii?Q?FMgC46HS3J1+7vOhQZtXX9IW/A4be3LM1atloZVeQqcynqKDTCxaao5Is/FE?=
 =?us-ascii?Q?bWa2b4nex5CZCBJKh8299FFgu0oENTb0dSkY3lhdFnmxrxRwoVrmBgP0cwbW?=
 =?us-ascii?Q?/hk6x/OaFRByHN4bE/5hyqitqf5BsRT8TOlccP0K89mPgC1tNiYXnsEUbl4e?=
 =?us-ascii?Q?mwyS+YuKwU+9mAi8ky5059HuS/N0YOh/w0yIz5TCpxfGQsu1GytRYA8qf+5t?=
 =?us-ascii?Q?SMdlMj2GxfSTt7aeF/KpfCFQFS80Oa8ODCiwrSUlfonhatV0TcfN5+O7/gpd?=
 =?us-ascii?Q?ouFswISVLdcypB5fxH6rfiFOloGoOgGi284+B40lsTXrZZwSguZGEvG3n4CX?=
 =?us-ascii?Q?x3ct62EaFZ/S5tzUrWzSwHFmnMAMcjIeDmTPuWW8DLRtC27VbIDp9/qeaI1S?=
 =?us-ascii?Q?j69FWQCB77aD2TEtPmGWBCh5s8qibnKUwFlfs9iVpT+lIsML4c94M8qbAWmN?=
 =?us-ascii?Q?bY7inLjbM5KxQYCKijSVaG+h2KfCbExKVp9qabyaKPMLFHySFbQgJVVTgSq3?=
 =?us-ascii?Q?kVHYTJonRKzOK7PtWGrdVOEMA49y7/zAMIjpcU0RTSkPaq6dAXWPDkUyfw6H?=
 =?us-ascii?Q?/X8aea+R63YpZ9Am44ObTr9oksb5nabml3AT+iy/9s499UpPlZAVJNxT+qvX?=
 =?us-ascii?Q?OM7qQADXG4VlQnax4E0X+Nd9cg/S34EPLzoYX+FWNmQiK/cRgrkRH/rx6WTe?=
 =?us-ascii?Q?ZDA6X1ta24keJ7c0/8wqqHgvmtGXu3icXaaBp+8IGqEHAUAjQf9sn4EAo2Fm?=
 =?us-ascii?Q?aK6Hlw3vOO48E9eFizwTGpuCa0I/QVf6qbLCmaeSzOfU4wwJfDdc0YHrDP+G?=
 =?us-ascii?Q?RonUzUoVkTAJh7QS3EejtoUlBoQgRTBbbM7ejppLw7ILYDk2YWFfoh3996yk?=
 =?us-ascii?Q?hX4g9dRI8fQjHSReUwj76WIBjMXggAG0O9XErlP1Sv8T1fnRlHHP6Tg9k6jO?=
 =?us-ascii?Q?ceoRqbEg2IYbqti+7TTQI/n0yQt3TLYTYvovafrSFmf7sQGa5We+z8SHELSk?=
 =?us-ascii?Q?zBsdl8JHVlrV4M/+p6z5X37+Gc7lyGodDtoUmlgzh4r26dSpMaLzhD5DPKNx?=
 =?us-ascii?Q?t3EQ0a3HSR/j9PXrXqI9943foWI+/s990GIriWyX8w6ICwXN5EQVyGwW97cU?=
 =?us-ascii?Q?omYXwfbqn+BBf1OlArlGv13KIOjiw+yqEKsjiJOf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <988FDFF79C712648BB36125D7FAC0BD7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7288.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc166aef-a7a1-4154-1cf6-08dde0ceecae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 16:22:29.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJUVQNmWsaAvnhnXzd5N+I+zkNBNClW9RnM92jlOzSnSGQsVWe6hddhn2IVZyoIMkTPsgx0TK3knXD1RH/X2Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7267
X-Proofpoint-GUID: 28rpcSdzhNcb8w_4kmjwtjEcfk4rwIed
X-Authority-Analysis: v=2.4 cv=etSGDopX c=1 sm=1 tr=0 ts=68a747c9 cx=c_pps
 a=4mClSuGjSUzMkTaFIzBKqQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=Z4Rwk6OoAAAA:8 a=OUXY8nFuAAAA:8
 a=Uzno3O24zYBdlimlLAYA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22
 a=cAcMbU7R10T-QSRYIcO_:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 28rpcSdzhNcb8w_4kmjwtjEcfk4rwIed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NCBTYWx0ZWRfX6SlcqLwykueW
 wUs/Fujd8r3K5/Zcjmu33eHmOEel79YA0VEl/IM2RKCD16YHRtpYsemjlWCzXB/+GDWX2piyYkt
 g8aXLmrTCUj2d9AmAcv5S6qnqj4VbBHgfFuJd4AzWcgAIcBvZiIMS7Rn6JlptujOGREpLlTp6Wp
 /f686y7XTQQDME66sAGEFoLcUfjEY6gLWnw0PXCPUI8I8rWujUIucQlkLihU/u4YKVzooBiLOue
 3IrXs5PZoY99BV/khqA5tcmDNRwhp3D9O557ezRcAsH0Mc2fM+QWRCAjMwo+2TO7kp6yBybtJr+
 EgNyvPPiR2pkNdarLkDgynBvYj12bBvqT7Hb/ZxzyomrGJHfN3dg0RbUStemB081cqDOOisy3os
 6NXbarE3aMnfrjbcYd1+xL4umEL6KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508210044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_092316_697895_FE6BFCCE 
X-CRM114-Status: GOOD (  18.61  )
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

On Aug 20, 2025, at 9:47 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:

> On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:
>=20
>> Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
>> introduces logic to use CMA-based allocation in kexec by default. As
>> part of the changes, it introduces a kexec_file_load flag to disable the
>> use of CMA allocations from userspace. However, this flag is broken
>> since it is missing from the list of legal flags for kexec_file_load.
>> kexec_file_load returns EINVAL when attempting to use the flag.
>>=20
>> Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
>> for kexec_file_load.
>>=20
>> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
>=20
> A description of the userspace-visible runtime effects of this bug
> would be very helpful, please.  A lot more than "is broken"!

Hi Andrew,

Thanks for your comment. The userspace-visible runtime effect of this
bug is that kexec_file_load returns EINVAL when attempting to use the
KEXEC_FILE_NO_CMA flag. This is stated in the sentence following the
"this flag is broken" statement.

Is there something else that you wanted me to add here?

Thanks,
Brian

