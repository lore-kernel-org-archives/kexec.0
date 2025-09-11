Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8023CAC58E
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vV+Yw2otginPKQdOK+btxtk2cE5afUBZQPUGfdyoRo=; b=nkr+NGD+aLpNKhZNxo/sVAOUYG
	UGwSd4W/dXier/gGRyPSNWT7iz4ApKekVeXcEE9/Fp2IuIlX7VHJegvTB3cQryNn+6JQfWgVW4Xik
	xYXpaUcHx1cwGV6wG8p+3svI1Jkcl0k22adDDFzkmg0q1YV9C1C5a408aocMzWHo4bX2Ric2OAjaI
	z7wVAebsgzAH6uEnBcc/xYpOZSgKy2IBz9h4fvkphq0QiCSRGsbnBSYWwJaZ7mU2Z8qUnHwircn9k
	sqCt5/ntm2H+Rt2fJDj6Wgcs0dqb5NRrDWU64y4KOLc4jnFifeTSQkcju39BMqgI6Kyn+JvHiqh+N
	1zFt5Qgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjFl-00000003uIN-1sMp;
	Thu, 11 Sep 2025 15:30:29 +0000
Received: from iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com ([34.198.218.121])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjFi-00000003uFD-2gQI
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 15:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757604626; x=1789140626;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=0vV+Yw2otginPKQdOK+btxtk2cE5afUBZQPUGfdyoRo=;
  b=nCTsBp4Jvpl+eUuKlD7d9oAyTgGqNlQuziv3QHFechdfcFztOjgOAqdu
   sXQYQp0oEUdNR9V1zG5i3ocQhYjFM8te40lKM8DW6ddAQ4ThVUWvPtsTl
   CzJ9EDCXTKSkC/cOG26L2CAljuXiZg7ce3obdrG9vsr8RyseV0QLIr2SD
   29RJ9p/Z/SH7i4NBXdlwyPQ2k+ppPxFq/Q1nd2prIbKTrC8yihXBI8OOn
   gOTxPbWg0fls7Fa7iEnPb/6lEft4tgWtYzpviR/5C+Kv7IgehSIvXqFAF
   U4SKNqTGAi1dO+jAtYaOpGRYoc54bnSw/OhbAV+WsUu9VYNIk71BfM9Xw
   w==;
X-CSE-ConnectionGUID: HWiNG+UdR+m/1Fggb96rpA==
X-CSE-MsgGUID: JfYuO8tAQvGPGhBUIKwDmg==
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="1919863"
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in segment
 loading
Thread-Topic: [PATCH] kexec_core: Remove superfluous page offset handling in segment
 loading
Received: from ip-10-4-17-41.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.17.41])
  by internal-iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:30:22 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:37406]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.38.114:2525] with esmtp (Farcaster)
 id 9ec4764d-5e51-4820-a043-238ec43845f6; Thu, 11 Sep 2025 15:30:22 +0000 (UTC)
X-Farcaster-Flow-ID: 9ec4764d-5e51-4820-a043-238ec43845f6
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 15:30:21 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20
 via Frontend Transport; Thu, 11 Sep 2025 15:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6TPzre0pPZkWN5D2ZojMcgOb5T/3Vz4SdmccCWL24Epz1qp45xmWDqwwIAsbvyAny7Cx8qIPcHQ3A6UM76E/LQd/SdDygSmNFFK4i5O+fud6AQZWKlGgR7a7kik+bXv0yqV1S2OCF37jTHppPZP2zdbIXY6B64hYVBZvRklw2wKG1HruNqTfIjnqoQeC9ph8uV9qp67MTr64i+tHYahofh4NgB/+uURrbJ/IosyzK+n0kNZXAuekPcgUnK4TSTJ+ySE3EwK3cfN9QsHSC9Xmh9AAGPQiXKHhmqfvgL8hdY4yZ2ivFAiYbr+7RwNdV4uVaUKhGgzVsemR1H0xwuk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vV+Yw2otginPKQdOK+btxtk2cE5afUBZQPUGfdyoRo=;
 b=JhNiVQJGvvesEMKg82M0bYhKxiURa4UfNa3Nfl4jlezIlBFalnUwqhvFwZfbGGejF7X4SjwlVRz/WyiE231Tf4WHY0zHVo8zvDPDiYq9VD/a9jRpPahWo1y0S1g9XcDQyJ/8IbI1pcLBNZaVSJTl7QpRTMouHGPj/fQM6fpa/PByB9dup0zvrLBRwfox6x98CGCUInalQVF2RfBL+fAaX1WnDU260+w+i8URzLo2KzJkI5wE715OgZRd6TFtZxJEP3hV1nMqsTr33Re7y29rNURlAzUc5Ih0EIfuR3Mz7eFWrSfz5041gLpyRh8MooWVcdLvx2y2SEkXN4mm4a3HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB5843.namprd18.prod.outlook.com (2603:10b6:806:3dc::16)
 by MN0PR18MB5976.namprd18.prod.outlook.com (2603:10b6:208:4cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:30:19 +0000
Received: from SA1PR18MB5843.namprd18.prod.outlook.com
 ([fe80::9dce:178:cd96:982e]) by SA1PR18MB5843.namprd18.prod.outlook.com
 ([fe80::9dce:178:cd96:982e%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:30:19 +0000
From: "Bouron, Justinien" <jbouron@amazon.com>
To: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Marcos Paulo de Souza
	<mpdesouza@suse.com>, "Graf (AWS), Alexander" <graf@amazon.de>, Steven Chen
	<chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kudrjavets,
 Gunnar" <gunnarku@amazon.com>
Thread-Index: AQHcInBbGGO0wcU4Zk2yg1MrzgzfP7SNu6iA///sEwA=
Date: Thu, 11 Sep 2025 15:30:19 +0000
Message-ID: <1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
References: <20250910163116.49148-1-jbouron@amazon.com>
 <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
In-Reply-To: <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-09-11T15:19:54Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=491bc37d-0223-46e4-b977-2d9a7c9f6cfb;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5843:EE_|MN0PR18MB5976:EE_
x-ms-office365-filtering-correlation-id: 978a45c4-66f6-48ca-cfac-08ddf1481d8c
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dlRTVS96TmxQSUZXQ0xDblZJSUVuYlFuSTBCR0VBM29Eb2lVLzk1MTh1NHFM?=
 =?utf-8?B?bzN2OHJvOU4rcXlWdkhSdTRDd3pDQi9oRWs2V2F2WFp1Qzk3b2dJNXlvYWxp?=
 =?utf-8?B?ZVVid21xQml5cnRsd2IrQ0x3ZHVnUFlSWEh0SkVPTXdiNk9Nc2VwdjNnUVk1?=
 =?utf-8?B?REVCZ2ozUGRRUlFYUm5VM1pNaDVKUW5zcExwTXU3cldYVnFHNC9PcVJ5Sity?=
 =?utf-8?B?bzVORXZwTFhSSkRUR2EwSFFPRDhvOUlTa09TQmFrekpSdS9sRVV1dzhVQmVY?=
 =?utf-8?B?OXFRbTZmWkhEYWZiMGE0S0lncDM3LzdkNEVBbkNOdVR2U0duOXhPQWhyNzV0?=
 =?utf-8?B?SnVMTUZDZkRGSkxscHE3cGhzSkNzb214U28vNmRtczhzcDVDeC9mcnd2NzVZ?=
 =?utf-8?B?bVJFb01sTUFabWJ5aXRnejN4NE9naFJ1S1kzVnBKZVpZM0hIeGlFRitxejBR?=
 =?utf-8?B?bURuN0JJY0pJRWZMTjFyNEhVd2tZSXd2WDBTcDZsT3JOamM0ZFRySkJhVWFt?=
 =?utf-8?B?QTlpakFmajBOdGdncDBtbS81cGZLVGhPNG02K29ZWmZyQWJoalBneFRLbDRS?=
 =?utf-8?B?ZnVxT1VWRHJLeVFWb3I4SFhmUTJZdzM4bFZtWS9PVlN5a0lkTnFTQ2tYeWdw?=
 =?utf-8?B?c1RHQmk4d3MzQ2FWVVQxYWdxWjZwR1QrNTgvZkx5TDBpVEFMRkovd2Yrckhj?=
 =?utf-8?B?RkNra1hYVVZyT3FTbVNKdTBpcm5Da0ZsWjVQelhuS0Qrc21BMUhQYWJzNlln?=
 =?utf-8?B?SEw5d2xUSFkwU0Vya0o3RXovbmQvTWJYNkRIdFlaNkc0d1pOLzRETE8rVk8v?=
 =?utf-8?B?MUsySnUya3JIY1l2d1dRZHFhV3M5RmJJS2xNa0NVMEVXVkR4QSt4ak44WGNh?=
 =?utf-8?B?U3V6VUpMMm5aa01JVEVwdmxlQUh1cUUwR1lGQk40MGpxdWJoRUhMa29hRFdo?=
 =?utf-8?B?UUYzV0NVQmUrWnVFQk9yaWxoemx2SHM3azlieXc1QzFkWk5HSXpRR0RnMVpw?=
 =?utf-8?B?NTBLelpKaUNhNzRKUlNxMUdRQ2tZUGJPakFkTDVKSVBCRXZ5RmVmZlZwUUNS?=
 =?utf-8?B?Q3JmeHVsOXBHSW5OakdpU0NXYVhoeVRuYmh6UER4WllmWnc1MHVKeDJYWDhr?=
 =?utf-8?B?RG1DUk1iNEtpdTRwOStENUVJZWY2bVVhZ1k1QU9iQjBId3RhdFR0VUZTS1JU?=
 =?utf-8?B?eEJBVERvbkRtMVh1YVA0eTBxK3FsYS9GY0FCOG9hWmx4SEczVHI5RjBZaC9T?=
 =?utf-8?B?RnNEZXVkTTYxaXAyOTlwMG5wMGcyNGlKa2lXYk5Ka2RyRHZFc1pkRUN1N1FP?=
 =?utf-8?B?V0lhZXdHZVlPRTEyUG83L2lJMmhqcERzU3BsbkZqbjJvL00vcjRRSGhHUEN4?=
 =?utf-8?B?a0p6OXZqTEhMRDJWWXZhZEIrT0NubHk3Rk9GajFnNDhxVThQaDJLNUt4RXRy?=
 =?utf-8?B?UVM2NmxkWHJZbmtGTjB0OFprRkdRMUU4WnRwUUN5R0RRU3dOVGM2OHBDVnQ1?=
 =?utf-8?B?SktueU05L3NNU2hSbE1yVmU0ZUNMcGZzTHdtUDlVcExhTFNsVnl3RlhxTDIr?=
 =?utf-8?B?eFk3bUhmV09Ed0ZvaWxSZFhwYjJJbU1Sc1lnOU5hMzRhY0c4SnQ1TUk0Q1RO?=
 =?utf-8?B?dVRMWTNJZzBrd1pqYzhhMnBQall5TEdqRC93eVB2SWhUcmhBTUdrWlFSRk5P?=
 =?utf-8?B?d0hWUHRNZDBab2hiZm5JTkFpN2hpYWxzaUJoZ2tiVTNsSGplbVRBb001QzB6?=
 =?utf-8?B?S2dRUS8yVTJUcS9pNkNobFRBdDB0NG93VlBPQk5JVnJORUFXMWZiT3BMblpl?=
 =?utf-8?B?QWRRb285aVFxUk5zMFYxbGJ1UUNQdlU4ZVRhcjZGbWlRV0dVNFFXeVdhV1dO?=
 =?utf-8?B?b2U2NlUrUlpSTlcxSVpCZFFHVkU2VjVRTjZhMUs2TDcyemJJWW5RZjZVZlY4?=
 =?utf-8?B?Y0VxZGl2WmN5QXdHQi92cVJUVmZGa2wrMjI1NjJuL3dib2E1bVB1emMzNkFy?=
 =?utf-8?B?MmFLWFUyUUpRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5843.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0tXRVNnY2x4ZnZTQVQremdZdVlpNlZnNDd1WEpiKzE3YzBYWHNySGs4WmJo?=
 =?utf-8?B?elZlbkVNb2pFN01seitlbUdyWGNjQ1R1Q0ErSkQ0dy9oenpPTXNRRi9jQUlp?=
 =?utf-8?B?TzJQZm5NTE5tYlh4RCtjc2xrMVpYVlB6Y0JpWEI4U2xOc1hrYmVXbDRXeTUx?=
 =?utf-8?B?Rm4xTU5Qa08ydzZPbzkyNUtCd2Rra2hObUl0TzR5amxBVEdOU1h1Ymtsb0xk?=
 =?utf-8?B?eS9FR3BEVzZndWJnZjNRSmo3M0VSTmRRK2VCdElGenVvcXozVXlBT2tZQWpS?=
 =?utf-8?B?RW5QMWZ5TVZOSHh5QWNleEZheTBSbFVNdFdieE1kWG8yRE1IQUlTbUNSNjh2?=
 =?utf-8?B?NUdGV09IcVMxc0ZzZ1EwRHlSSWh6Q3NxaXhGaW0ycmNpcmpJVElYYzYvdEQ5?=
 =?utf-8?B?M2IzMTJwREpLYmRWdzJpcUZsdEs3ZmVrOFhSUkU1L1Q3V0FEbm5MbjRFaEVR?=
 =?utf-8?B?dzkxdXE0YkUzL2FlMGZlWWt1dWsrOUxyK3ZrQ1JONmxoRU90SkVLcmVsTFlL?=
 =?utf-8?B?Q1N1TjFPWFNSa1A0RTVxMHNyQTRNVll5ZWxjTnJjZ3k0VTU4U1VjRmRxNGZH?=
 =?utf-8?B?UXp4cmNZaFprVVRLZzVxSXFaaDIxTVdlY1BHK1VDd1dKYkVuT0FaUmpGS254?=
 =?utf-8?B?UlE5OGtGaVVRbWprVXl1bFJYeGF5aU5ITnV6My8vMCtuK1hVRjM3VVNqRzZ0?=
 =?utf-8?B?MUM5QWdudXNudEZmRGxacmQrUTZpRjIybEhIRTk4SFMrc3FMeXR5QWVaR3Qw?=
 =?utf-8?B?MmNHTitpQURBMzJHVkwyeWFPTk05TmI0RzduUzhHa1FqTzJSdkZBRjhkZ0k5?=
 =?utf-8?B?NWVlLzJrV3BPOGlIYzM0WHVHR2tuTVlOMnFoZnk1OFJtaXcySHV0SjdsVVlu?=
 =?utf-8?B?WmZaUkJyNU0vTnpJQm9XYms3b2ZrU0xxNkI5cGJnaWtPcTA5U0EzN3Nhc3Nq?=
 =?utf-8?B?WnpLSVlsZmF0Wm0vUGpEaGxFTWNITVYyZkRzMTJyOFpZcWt0OUtyZkxuZlZG?=
 =?utf-8?B?dUNmN0VMekViU2pJeTExYndPMWd0aW40OVhxckV4Rmp3ald1N2Y1S3o1Ritq?=
 =?utf-8?B?ckw0NHNQaVpXaUF5VGdEc0FobytlalJ0K0FWVDhyditDU1REVm5QTU9QU0xL?=
 =?utf-8?B?anhyVGlmNmlQdU1DM1FWNUN1MVpodGsrRm1qazhLY0pZOEtJanMwNllOZkwv?=
 =?utf-8?B?dFV6QWd4dzhNc052V0UxVFFqdnNiNyt5ZFBHeHRUc21SOGlYeWZEY1BnYWw0?=
 =?utf-8?B?RTZBcGkvcEwvWkZBelEraVhvVi9uSzVwNVlJRDFkSFBRV0hKSmJjMHZZcVhh?=
 =?utf-8?B?SjF6S1RQelY3eDN5ZjhKSE1IaXZzYlV6RkEwbWZ0amptcWhxbk0wRE4xUHh3?=
 =?utf-8?B?K0dlNjVMMTdpV3I1dStXdkJoQ1N6NzRDVDQzdXBqNkdPb0syMHFNSFYwWjBk?=
 =?utf-8?B?cjViZzJ6ZVA5K3E1VVVIVkF0L1pZejQ1eXp2VmJHMjJuMlpxMWUxRytZc2Nw?=
 =?utf-8?B?VTEwUWVMYmdhSHErbndiZ2d1cGpvNlZsQ3g1Mi9lbVRLQ0wvNFBkNm9pQUNY?=
 =?utf-8?B?V0hyMDNLUk81bjlCc2k3dkN1U2cvcHo5WDVwZ3JtcWFTVWJnZ211U2o3WnFi?=
 =?utf-8?B?NUptbjNVcmE4NXQvRUZnU3NuV0tVUFFBYjB6VGh6bEhFRC9WNjltZXpmRmRF?=
 =?utf-8?B?NXViS0s1UmRhRjdwWHZxZGRHeTZUdC9JS3dpWXBpQjRERDJzSTJ6ajNzVERo?=
 =?utf-8?B?V0FVVlpWcENFSm9wUlByNTduNGRDM2tXS0QycDgzTnpUNGNpNHB0Z1RrWGtQ?=
 =?utf-8?B?dFUwQldhUVRnWnkzTTZVeTRkVGhRaEFFT0FHSjVqSTErdk9BOW11c012YXRD?=
 =?utf-8?B?OE1vbUxrb256NlN6dmc1YkhFMjFJRCtkRWtjcmVOc2J5QTc5THpHMkF3aUNC?=
 =?utf-8?B?S1VLTkJWUDZyQ2FiWXI4dmE2K2JDTGtMTVVsYzVmRlNhelVpeVZyZlhkelVL?=
 =?utf-8?B?bHRtRXpRc0ZBWHNhN2JNTHNCYUNJM2J2dWROTzArL1R5aHdwb2dMWnByV0k5?=
 =?utf-8?B?NGd6YmhPWU1lQmNMQlNWMzhoblFLS1ROSDFzbTF6WlJFRWpBZGxaMG11aWlP?=
 =?utf-8?Q?igF3c070/j5louqPmt6+KWBdl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D299DE72F2E3CE4B89401DB992709038@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5843.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978a45c4-66f6-48ca-cfac-08ddf1481d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 15:30:19.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJBwMd7n3ilN8bL74fyOIH3eQirz1e+6I6VMVu6y2VpaKJrP5f/a09dEwvpOwbzcZJBDpD72N45sbRrGoIFb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5976
X-OriginatorOrg: amazon.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_083026_829072_F6AEE4BD 
X-CRM114-Status: GOOD (  11.22  )
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

T24gOS8xMS8yNSwgMDI6NDIsICJCYW9xdWFuIEhlIiA8YmhlQHJlZGhhdC5jb20gPG1haWx0bzpi
aGVAcmVkaGF0LmNvbT4+IHdyb3RlOg0KPiBEbyB5b3UgbWVhbiB3ZSB3aWxsIGFkanVzdCB0aGUg
bWVtc3ogYW5kIGJ1Zl9hbGlnbiB0byBQQUdFX1NJWkUgYWxpZ25lZA0KPiBpbiBrZXhlY19hZGRf
YnVmZmVyKCk/DQpUaGF0IGFuZCBtb3N0bHkgdGhlIGZhY3QgdGhhdCBgc2FuaXR5X2NoZWNrX3Nl
Z21lbnRfbGlzdCgpYCBleHBsaWNpdGVseSByZWplY3RzDQphbnkgc2VnbWVudCB0aGF0IGVpdGhl
ciBkb2VzIG5vdCBzdGFydCBvciBlbmQgb24gYSBwYWdlIGJvdW5kYXJ5Og0KDQppbnQgc2FuaXR5
X2NoZWNrX3NlZ21lbnRfbGlzdChzdHJ1Y3Qga2ltYWdlICppbWFnZSkNCnsNCiAgICAvLyAuLi4N
CiAgICBmb3IgKGkgPSAwOyBpIDwgbnJfc2VnbWVudHM7IGkrKykgew0KICAgICAgICB1bnNpZ25l
ZCBsb25nIG1zdGFydCwgbWVuZDsNCg0KICAgICAgICBtc3RhcnQgPSBpbWFnZS0+c2VnbWVudFtp
XS5tZW07DQogICAgICAgIG1lbmQgICA9IG1zdGFydCArIGltYWdlLT5zZWdtZW50W2ldLm1lbXN6
Ow0KICAgICAgICBpZiAobXN0YXJ0ID4gbWVuZCkNCiAgICAgICAgICAgIHJldHVybiAtRUFERFJO
T1RBVkFJTDsNCiAgICAgICAgaWYgKChtc3RhcnQgJiB+UEFHRV9NQVNLKSB8fCAobWVuZCAmIH5Q
QUdFX01BU0spKQ0KICAgICAgICAgICAgcmV0dXJuIC1FQUREUk5PVEFWQUlMOw0KICAgICAgICBp
ZiAobWVuZCA+PSBLRVhFQ19ERVNUSU5BVElPTl9NRU1PUllfTElNSVQpDQogICAgICAgICAgICBy
ZXR1cm4gLUVBRERSTk9UQVZBSUw7DQogICAgfQ0KICAgIC8vIC4uLg0KfQ0KDQo+IFRoYXQgYmV0
dGVyIGJlIGV4cGxhaW5lZCBpbiBsb2cuDQpEb2VzIGl0IHdhcnJhbnQgYSBzZWNvbmQgcmV2aXNp
b24gdG8gY2hhbmdlIHRoZSBsb2c/DQoNClRoYW5rcywNCkp1c3Rpbmllbg0KDQo=

