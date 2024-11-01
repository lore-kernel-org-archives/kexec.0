Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E13E6F07F
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkykxqCLi+wlUcG10k6bmNGcXDSdNJu3OCdRqWPHyOc=; b=cU6ZRjQpDeVNod
	ZlP/ZwGwhwJ8cM14jRDnLoMEZ8HkcZVSTmKnH7OtG1DtoeAcZ8u6HNYg4dRyIbPYs/j4O/F67vhFJ
	iI0RSyyJ2Qo7/x9UhXZREr95S/34Wa5rLQPo79dyy0MVzQf7/W6TKE8yLhb5WwYK7lCZtrXgnXOaT
	mwXsm/CpixPT5f0KXIx7hSoLAO7ZQzoBmE5eAIJGV7GKGA2Xns+Vf45wmcCygetC0F0zZWweOiTb1
	jJESAW5qeXksp5otxkh89LayeH8mq/CWSqIxqHyA5m+uMtUlj7DFJS+uv03ML2aeHUzFVSi2DY7HO
	G2TC71q3P9I3AwVKi4PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6xQg-0000000899a-3ugs;
	Fri, 01 Nov 2024 19:35:30 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6xO7-000000088fg-1euq
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 19:32:52 +0000
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1I2ean007644;
	Fri, 1 Nov 2024 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Qt
	+Y0EPvFNwRXHjcSs0d6bjl8BG+UwdVbcHZRPR0Jp4=; b=QgYGcyLtYu8Q9Wl8z/
	Go3kL8iOhVOMpkzdE6N+v6eVQFTDLFcYvd7VmcPaJUC4NZAs050wGHYFmOTyZ98Q
	TnDuJWOwtHMS3JUbbgw4HiABgmPZKrVZO3jH5O1ZnU+KNyFvVwrWj2mvCKKR0nGp
	zgcw67fYZUYFLqpsqVmU5mQMRR+RYS3ZSvsKv41HKmawLlRp+bOVtdSO8Jk7wRCz
	7k6yqc+z62Kqv+tFP4y7Sc5wZYX98t40vfmIakVxfry8y/r8BkgdGWMk0NJLXcRo
	CYXobN2jEgtxl8euBiPUp20X7WPCpUUYJSc84p+J0Bo4HpxgSZgOpv6YMVmyHBSa
	IXsA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42mx053b68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:31:55 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 53DF21374A;
	Fri,  1 Nov 2024 19:31:50 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:10 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:00 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 1 Nov 2024 07:31:00 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:09 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyzhf8p46ZbgPMHDPYkvgp25hgFAWKBwfulOMS+VtYIljKy0k4ZibyndFtbDi33lhFIyjTBelVi5jioDRp1+Tl8TlHOwF33JeiGApgBxSHoY2y68O/i+JRTQGMxeHGdrq9foWKqQx1IZIrysu3HVdflxa6ZRgRhcYlkeU1cdL24064zw7sS28tvyt1uZz1f2ZKl+AQrdmWXlLG2RR667GjNvCQ+3vV0Cl7ExtgRK7wkMBn9sRtUA3zbOV8o7ObLvf2GfQav6Wr3RwzNjOikObmXB87x2e/Iaefk5w2keu/Y4EDu2UFJTHnIIsxcJQKh5+t5tNWE5QYI9cePw5lm3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt+Y0EPvFNwRXHjcSs0d6bjl8BG+UwdVbcHZRPR0Jp4=;
 b=uEaGY8xtSImCZADmhbXaIyoOnb7bbzmU94bRioNlcRez/Ddty3R33SsCPKnJoatd+YXi3cY3lFSNesIfSeKA/7Cv6CeFmHZiH/o23fNJdrdGkxW4WdNHWtWu3OS3G8neJZRR41xJUbz0iS3DyRrysUDnQr9TgygDdnr47q8TyBApidkB9ht2fUtCkQGvgD1s/SGQhcIlqpJ1e6lvY5K5clo33Q1GHeQG+RKSEplwkrnGFzXwAP9weMtXb/frOH/U7CvUx80WVjIP0mIAg6WwXDiPba4gfZ3KGG0E2df7gODSDMmkInu/CtiD5c6w12iLDJs2qQXpjfhaMhBQRsEatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:3d::17) by
 DM3PR84MB3715.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:44::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.23; Fri, 1 Nov 2024 19:31:07 +0000
Received: from DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8f56:e2a9:32b0:75bd]) by DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8f56:e2a9:32b0:75bd%2]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 19:31:07 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Ross Philipson <ross.philipson@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>,
        "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>,
        "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca"
	<jgg@ziepe.ca>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "corbet@lwn.net"
	<corbet@lwn.net>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>,
        "kanth.ghatraju@oracle.com"
	<kanth.ghatraju@oracle.com>,
        "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>,
        "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>
Subject: RE: [PATCH v11 01/20] Documentation/x86: Secure Launch kernel
 documentation
Thread-Topic: [PATCH v11 01/20] Documentation/x86: Secure Launch kernel
 documentation
Thread-Index: AQHbBhk1cjmy5f0J5UyAHliCaIVLyrKjDwew
Date: Fri, 1 Nov 2024 19:31:06 +0000
Message-ID: <DM3PR84MB3714A4632C4C7B6B50D7A0F4AB562@DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-2-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-2-ross.philipson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR84MB3714:EE_|DM3PR84MB3715:EE_
x-ms-office365-filtering-correlation-id: 8c74005e-14c2-4a6e-4381-08dcfaabbb60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0J2Q0NUR2N4UWI2Q2dudUgyci8wU1JVTFpRbDlHR3Y4dWZNYVFwNTh3NHpa?=
 =?utf-8?B?UFVrMEU2ZUNCSVJQUlFnakNUVkdhaGNEZmVqd1luNC9QWmh5WnljSzIwN1lI?=
 =?utf-8?B?cXYrMEhKcVllQzZnZDRJdzFDZ2VHa2NBci9Xc2RoRTlIeDZ2alhGM092Um4y?=
 =?utf-8?B?MW5xTGxMOFRlbW9Da2hpZXVpZ2JraXdkeEpqREZyb1VacGN6L2dmSTlRNWha?=
 =?utf-8?B?OFpMWVplY3p6elprcWRJQlJkakpsWUEzY1NXRTh3aE15bXNMSWd0SzFiQjR2?=
 =?utf-8?B?YmRDSnMrMmMrNHFEWEhwTlAxQUpFMEhmenpiMmJRZFhZN3Zpa0NHTVpiQ2ZL?=
 =?utf-8?B?UDVEek1Cd0NlSkhDV1ZRZXVnd2paWnhsUnE5QmRHV0t0dlNLYUlIKzBQZW9n?=
 =?utf-8?B?SS9LVnhPTUdvakxyd3liL05pREtGK0NUZkZZaS9BbUtVNHMrVzdRSURxK09l?=
 =?utf-8?B?YU5uVFBMY1FuUmZGb0pmNnhXRmEyR0pwbHFId0hLbEtrck1GTGpVN3AyRUhL?=
 =?utf-8?B?cHZvRTJVVlczd3FLRzQyUmtQY2tMek9tZjNZak9DVmJuajRsN2ZpendnU1ox?=
 =?utf-8?B?MXoxQ04vSmF2VnJMQzVxTVNZdE9VT0VnMWhPR3JLZlowZmc1VHdJRlVnTGMy?=
 =?utf-8?B?SDg5aVYwWVpQQzNJT0hxUHpYRlllTU4rZ3A0bVhlLzgwT0VZQmhGdUI1anBk?=
 =?utf-8?B?OEVzNHdzREMvRXg5RWpvd1VFN2dFZkF0Q0dXeGUrTm8wQjBBUGNTU2RHcWZR?=
 =?utf-8?B?RS9ZcnVHTmhzYWp6SnMyZStLUnBBQ2Nyc0txbEQ1djNHU2xEbFp1ZFRpeVI2?=
 =?utf-8?B?RTVVbExqKytpV2prU3piV1d0aGJvUmR3RWlyNVRNY0RPbTV3QWdxVStmL0w5?=
 =?utf-8?B?K3FlcG9nalpsY2NaYVo5UXFtckQxeThiM3ZYYUZjVWszcXhQaWk3dmJpcGZk?=
 =?utf-8?B?ZlNlZkdHN01td2tzRWM3VmdySTBITjdmWVRPSmpaWmZwSXRWT1BVMGJuQU40?=
 =?utf-8?B?SDNpUjZjNEFCaXpXWjRXS2FJeWcxWlFWa0gyb3l4SjBkTWdGTXF0NWNIc3Zk?=
 =?utf-8?B?S2Yvbk5JZ1pvNjh4UUluVkpXdG5hNU0vdXZ4QmVzTlI0VGo1d3oraFNiNS9p?=
 =?utf-8?B?OVNGTXJiZnJmOFJrOE9QZWY0WXR4NVZNZzlyWVM1L3VNeW1CVHZybjJrMWNS?=
 =?utf-8?B?SldWOXhlVUJVcWUrRFJsZnMvU09lblRwQ1g4QTg0dEw1UFk3NzcrbE5WNUc4?=
 =?utf-8?B?OFBHZ2xWeEM1ZlFETXorMHR2YVhWMlYxM3U2d05iKzRPWjM2alYvczVVL3Bo?=
 =?utf-8?B?a0xsOEo2Vmw4M1daSGNKaGlxSWI5ZlVmSTNiN2JUdHF2R0ZLRUJjZU9TdHFL?=
 =?utf-8?B?V2VRd0pNVlVsNkZZc1J1aUl0QlhSZjdvbEN6bGF1VGVnQWFXZ1NHQnJnYlFm?=
 =?utf-8?B?bld3TmhJM1FKK3ViTHRid21NQ0RWeE5kaWYwNlVkV0ZJa3lDN1JsOHhOY3NV?=
 =?utf-8?B?OE5tMzJQekZPUmJoalVFOVpiYWExZzFRQUR1MzlYajJHdDRWZFRGNzhMMStY?=
 =?utf-8?B?ZXJXSDVTQ2VYLy9peU1xNlZRZ1U0SDQrK2JjNFlHaE1ubGNJM2ViYUpjR1Z4?=
 =?utf-8?B?dDFmWW1vU1hYd0x2SStYdjJ6NlVySHhZM3RPNzV3SHc1QU9pM2ZPU3A5dE9E?=
 =?utf-8?B?ZUh2U2RqaVRab2htREM0d3N2dy9qbHdzc2pmbTVCWUp0bVZFMnVlcnJjUVBP?=
 =?utf-8?Q?DoApppq37f/FZVwJV9wYFYFCTM6nqUUqdkrk3C6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blBiMGpXaDFLaHROSTNKOEZhVXRRNks1RXUxejBYZkxCR3VET3VIempBOUV3?=
 =?utf-8?B?TnMvUGZBNWxESGhlc2szbFN2M2hQSEkxWEdqMUJ4akFvQUlUcFhjbXN4YW5V?=
 =?utf-8?B?QnJyV25taFVXbjVEaVg3ZFZmbkVlditQaU9IalRBa2hVZlFCbGJqdDJCRU9h?=
 =?utf-8?B?dzlzTUdWSjhBSGlFRy95TlZaUHpzUEtQYUpZMEhCVGd0VDd4dmJJY3NLbExK?=
 =?utf-8?B?UEoyUCthQUwvS1gyZVkzd2FxZW5yODVyMXpyejVMdktmN3hmRUNIdmtNYTlH?=
 =?utf-8?B?Y2FUSmRZV21lRFFVSXBQRHRkZjk5djk5OEtqeGJNTHlzTlRKOHBTanBHakUv?=
 =?utf-8?B?TWZhL1NmSXV1dGdmTDU0SEhFUWh3WUF3VDVnRnJsWmlZeTFlc3BmM0RhcE5P?=
 =?utf-8?B?K01Nb1RRNEkvVUcvblpmVUtPcm5rRzFWT1ZrSlpLdUlhWE5RUnZHNHAwRkhV?=
 =?utf-8?B?ZkNkQjZkSTdwUkQ0MmZiaXc5NTdwTWZyZ0tlT3BVb0V5VGw0cW10MTBJL1Br?=
 =?utf-8?B?YkJZTzNEZEI1SlNvT3Q1MFlXT2l5RHFaTnBEcXdUMS83UWI2TFRITzlEZU1B?=
 =?utf-8?B?eW5yMFcrbVM5d2U5WG5XOEtjQW9DR2RHVGFtbSticWprWkluVHZRS2FBeFp4?=
 =?utf-8?B?RXJLOWF4S1NpaS9yenE3OHJ2dnd1clU3QVQ5ZmNWalhwOVlNNlNvT3c4dld0?=
 =?utf-8?B?cXpZNEdaZGxMUUpaeElsOEYvQks5Y2J3N3VhVlg5RGhzV0pDaTRnQ2dUcERq?=
 =?utf-8?B?elRoZkg5WXVJMkJ0YVJHUXdHRVRmY2hTM0lSdC9oUm9lSmhQSG5qY0dNOW5J?=
 =?utf-8?B?ZmN4dHdRYmpjUzVSLzA5cXlRTTl4VzAwdnNxUUYxTHhFcTRpa3NDS1lKN3cr?=
 =?utf-8?B?UFZEQVZqZkhlWVZOeEprTm5pL0FTcllaOXd5OFB2bUh2NVlxeXdUdzN0OHEr?=
 =?utf-8?B?SEZsbE4wTUFSMGJWUk5xR2pLSVNlZ0ZKMUprUitjM0pZRHJKM2trN0hHb2xv?=
 =?utf-8?B?dHhXVG8vdnpBcW00NC9jc280U1k2bmJiNVN6Z0dJNHJzRDdWMzBIYzNoZUV4?=
 =?utf-8?B?dVJuanV5RzZqZ2hyaHZnNFFBWGQ0am9scjFJVDdHczFoUTdQRkFZUTNCSS93?=
 =?utf-8?B?bGhSTVFxMGx2SzR0YnIxYXk4aEM5b1VGcXdWQVdiV1lBbVVHR003NlI0cTla?=
 =?utf-8?B?enZLT3dCTzlZNFVRM2JEMnZ6YjFiT3hSRmFMWmFIWGlnLzBIaDhQejhZRHNU?=
 =?utf-8?B?UFJabGZNQTRpWW9vR3BPZ1Bzb3NDWEV5UFlXLzZoTTRWMkFRVWsxSk54dklr?=
 =?utf-8?B?YVFjU2trdnZvc3lmRk5RVlk0dVBwUjcxV0xRK0l0ZitwK296Z0dtaGJPNS9X?=
 =?utf-8?B?UU5qMjBWdlFKVUFlTG1adFJybXlKRnBEMW9OdU5SVUZWYzFyalQ0ZVZrU1NY?=
 =?utf-8?B?ZDJTSTNDSC9Cc2U3bFZzRjNsaVFSZTh1bEJYQXNIaEdiMTUwUFAxYU9la1A5?=
 =?utf-8?B?SjJIUU4xWHV4Rmc5alVvd3FQaVd2WUxnd3R6RW03MENZMnlnR25wajFSV3l2?=
 =?utf-8?B?ODZ5SXJSaHZqblZsSXNrTFB3cHFadUpaTGNZQjVFQjdkL1VEdTBUb2d5OXli?=
 =?utf-8?B?cHppMEZRVGx4UGVVeGdWM0s3RDhSNlVLdTgzSUd0YitmVjRCaDJzbDVkZGF2?=
 =?utf-8?B?WXpBbXZmcFUwM2p4Yy82UGRXdWZMRGFjeG5ITGZJU0RKYlVrWU5RcHdkUGdU?=
 =?utf-8?B?RCt4OGl2OHM2b0RRT0tEWE9OSlp0Y2NYVnBEYkNKdVh1QTgzVmJyRDJHanVx?=
 =?utf-8?B?aXorcXZxRmVlTXc2aWJnUWN3WFN5emVqdVRoVE11WHFVYU5rQU00T1J5YTZs?=
 =?utf-8?B?aU5XWWNUenBYcVZPaU05eWE0WmtLUitoVTIvcjVrYmhBOUhWdlZqZ3JwRkg0?=
 =?utf-8?B?THRqT2g3RjZTY1BSSVI4bTZtbm94UitnR0NaM0FLNWVMQmhIYmdZb2VQNUFv?=
 =?utf-8?B?dzRyLzA2Wk0raWIzdEJCMGVBcU9XWFkyU3NKSG5Jd2hucDdmS0RUMmxxSTNv?=
 =?utf-8?B?bEErNExBYlgvSmhVWW4xTWEyMUkzelV4TmZWM1Y2dDdQMzBCZU1td2owWVVO?=
 =?utf-8?Q?a8Mc=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c74005e-14c2-4a6e-4381-08dcfaabbb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 19:31:06.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veYmmTpuugPgwmuTy4vyGWMW5Ea3oy8yAoqFYp8cjAcwE+AnIegBAr7pDGRk3qFJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3715
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 01FIJu-WAqlPA-E1kMpd_jY-Iedi0M1v
X-Proofpoint-ORIG-GUID: 01FIJu-WAqlPA-E1kMpd_jY-Iedi0M1v
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_123251_448907_13618067 
X-CRM114-Status: GOOD (  13.79  )
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

> diff --git a/Documentation/security/launch-integrity/index.rst
> b/Documentation/security/launch-integrity/index.rst
> new file mode 100644
> +++ b/Documentation/security/launch-integrity/index.rst
...

> +This document serves to establish a common understanding of what a system
> +launch is, the integrity concern for system launch, and why using a Root of Trust
> +(RoT) from a Dynamic Launch may be desirable. Throughout this document,
> +terminology from the Trusted Computing Group (TCG) and National Institute for
> +Science and Technology (NIST) is used to ensure that vendor natural language is
> +used to describe and reference security-related concepts.

NIST = National Institute of Standards and Technology

> +Glossary
> +========

> +    - NIST CNSSI No. 4009 -
> https://www.cnss.gov/CNSS/issuances/Instructions.cfm

That is not a NIST publication.

CNSS = Committee on National Security Systems.
I = Instruction.
NIST is just a non-voting observer of that committee.

That web site uses a root certificate that is not recognized by most
browsers. 

The NIST glossary includes all the CNSSI 4009, NIST SP, and NIST IR
terms, and is more easily accessible (but the entries are subject
to change as the source material changes).
https://csrc.nist.gov/glossary

That currently covers all the terms except "transitive trust"
from TCG.

> +    - NIST Special Publication 800-160 (VOLUME 1 ) -
> https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf

That's been replaced by v1r1.

The NIST-recommended URL is
https://doi.org/10.6028/NIST.SP.800-160v1r1

> +    - NIST SP 800-30 Rev. 1 -
> https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-30r1.pdf

The NIST-recommended URL is:
https://doi.org/10.6028/NIST.SP.800-30r1

> +    - NIST SP 800-57 Part 1 Rev. 5 -
> https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf

The NIST-recommended URL is:
https://doi.org/10.6028/NIST.SP.800-57pt1r5

> +    - NISTIR 8320A -
> https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf

The NIST-recommended URL is:
https://doi.org/10.6028/NIST.IR.8320A


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
