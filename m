Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B28C02183
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSdvkL+inYfkLAVOsjYSGNxVk0V4c0udVhxvjEcsZNc=; b=cDnZT5+2KwXPfrlPNxmSZJCJpF
	vrT+BrwYmUarKY4wZ9vf7SF/Rf1cyENp/Ntxc6M+xblxEm+7wjWNs8sROsWabrqE96QNnpsVQDGnn
	GX1NO+YbktOHyhZP5yZ3y3k32vAMDczcfDXS0rC/mKg9iTLpr9weCbY764Y1qQOpSs9DeYTL4V681
	4h1jd9XtPFp59VH0Tg7JL8PKiNcxBAv78YfgoHehSrnYbKkp8tQIW+b/8ibxODUcKxGhNpFUUBs+N
	2b+YdNxKPdrHDHm5r+q6tBOCR2XrwlTmW52tPUMrwDTvQJ6AporA0rSLpMQaYs6oEJc2KcILqQOnQ
	1CDNok0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXXZV-00000007KnD-1pBx;
	Tue, 14 Jan 2025 03:26:29 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXXZS-00000007KlJ-2l4F
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 03:26:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736825186; x=1768361186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DSdvkL+inYfkLAVOsjYSGNxVk0V4c0udVhxvjEcsZNc=;
  b=XXgkpxnNaYKBCIG3GF7GHw112LOolrxS5qWv40i8b3Bn0Lk86iMxXal9
   9bXrbTlHEL7F3mXLiR9iVIfS8/+QpO3QeG6pUvmIiGGlk3QzthUynRxNp
   7WMYX9iaa1hm5Tdoir4RSShnxIU+LvKDDeVdNROm/1S/S020M1PO3mG6U
   9B5mOVpSU0UGyeWk0odM/bP6h6Oef5c/3RbeOoFVhh4m9cot7ggv+Of7+
   BnxEvVgkVAM/xR9gyx2YkGXV2jjRlSrBK37NaAheGLkLaZ9lp61x34G4M
   0EiAoSG4fOXM4Hoag7dL+OratG0+linFfMXswGaX2ZwrMIRTH0QTu6YZI
   Q==;
X-CSE-ConnectionGUID: c7vLZPCLSUyyUjpFAZSWdQ==
X-CSE-MsgGUID: MVNkN+RiTD6CNelWE/CSHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36998879"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="36998879"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 19:26:22 -0800
X-CSE-ConnectionGUID: U03TzFx0Qsi1Tu0tFq8foA==
X-CSE-MsgGUID: Qrq6mEjzQVul8WPpWXMfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="135507450"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 19:26:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 19:26:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 19:26:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 19:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egQtTLY4V3R3TyLgVb3G2ZRpJD1CMpglboA8Ld1fGwxaAl1Q7Px8d6u/DkGXfRkgE10LGilPUYQxgQzpi7Ts0+zTjmidPQ9T75QeRCnlSD3FOdfKfmfCpkGAwSs+N1+k9W2p574KUqMtcFaj9xI21UabC6gFQWeFOsop4i/CF2jWgYrnfwtmI2MwRNjXlLMmwCJQrOxw6HUl8NtXNV/FqLfgAlKk1fCHFXnQ13sIA9Xf3sW7JSNI8QdHSKQGCdzmluYkDiR92I9ZEDG5IMHkv6xBRUfPUl5YwIWHSH1axjL5tf79nVDRUzKVVqmriuaGn5HqMxwJrxzqAZTOnqDUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSdvkL+inYfkLAVOsjYSGNxVk0V4c0udVhxvjEcsZNc=;
 b=M5egOFsH6w+B2bb738fSL1dsfcGrUpkuL7bcK4Wu0PV+/vf+PZOMqMIG52DTxl6hfx5frAND2df0AMc+z6RJ+tzv6f7wAP7t2qlukaFwMggi3JiW3lkXKy7TYr0eseA8ibvFucB/e6Q/H2HrUpFCmpzXDN6JdSG6CmGSxse0VN0h7aDJ8yMnIq1Hx95bZEEmU+bxvDK5YVnvRQCV/DQsr9BW5/XAqhBMaB6uMkpfXtRFNQncmGgQycq1jcKkMO5tLMdThaqK6yIo6WL+oIXVzesL035QrN9uRgFBKikW3paNY8wjtx+DUD7mj9TcOCoMk9hGRGhAGGrfXvyh9TYuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 03:26:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 03:26:19 +0000
From: "Chen, Yu C" <yu.c.chen@intel.com>
To: 'Dave Young' <dyoung@redhat.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@ucw.cz>
Subject: RE: [PATCH] x86/e820: update code comment about e820_table_kexec
Thread-Topic: [PATCH] x86/e820: update code comment about e820_table_kexec
Thread-Index: AQHbYykKA3JBnIsEjky6b8hq+9FrE7MVhuKA
Date: Tue, 14 Jan 2025 03:26:19 +0000
Message-ID: <DM4PR11MB6020E10A34536D3A3216248CA0182@DM4PR11MB6020.namprd11.prod.outlook.com>
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
 <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
 <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
In-Reply-To: <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6020:EE_|MN2PR11MB4758:EE_
x-ms-office365-filtering-correlation-id: 6f84c0b6-4cc1-4708-5361-08dd344b366b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0F0SHNTYWlFNHpTdHY0VGlSbHpyTFhOSnBQREN5VmUzWVB1bk1oMWpGSVMv?=
 =?utf-8?B?WEJQL1JCdDlDRTcwZFVGNWU0bVRzQ2RrWWZFRzVjOE4rTGg4aFNnaW9ycndB?=
 =?utf-8?B?SENtd0tEZG1OS082M05HbDhsZitVZVFMVVdWWkc1ZjdHeGpEMFp4bnMvVzlP?=
 =?utf-8?B?QThiYlRTS3MrSkNwU2RzMTJYeklqOUcyZXBuQldodURGTmxML25zZ2dpdkhl?=
 =?utf-8?B?aENwaS9mMU9mK0o2akxJZjMxdXBQTjZhVUFXbEZ4cnlCTmM3SWRuSEd5YUxm?=
 =?utf-8?B?NHRvS0JUNFpLc0JRbzdhc1pFNTB1WWJINldPbGZpRmttZGNMMG9sOXBKbG5N?=
 =?utf-8?B?MXdyMUFMUEl5TTRsMTM0OXhRNWIvQXhBMTQrR3NHRkhld1ZvcE1ldVgxSllQ?=
 =?utf-8?B?YnFCc2IvRjFhd2ZDNlM0U0lTcGtwUlNvUXBQeDBIdnFLRzkzVzlSZ3ZjTnBy?=
 =?utf-8?B?ZEh1bnhmcG9sQ3RISFVjUGV5TVFrUTM3ZDFEdm9uakl0K1hIdjFKK1BWeFFR?=
 =?utf-8?B?RlZhaUN1VklmTUZBbDRFNE9GUFJ0SWhlM2NLWDg3QW5xZ0FKNTUzUXczdXdq?=
 =?utf-8?B?bS80d2dGWEdEcHBjU1B6N1l5RmY2UTZWNE02N0ZZdk5NUXU3UkVCdXdvQ1Uv?=
 =?utf-8?B?R2hLeU96RmVhU3Y4em52RUtiRTVsR09oV1ZWY0RXN1F6OGtHbXpid2lmbUJE?=
 =?utf-8?B?MVFNc3gyUEczazkyQzF1cGdaY21lYlNYV3dGYnlNNTZRVmhrdm5iSzAvNGtB?=
 =?utf-8?B?ZmF0bEJhQ1EzdDJrTVpRS3ZITElWL2JFNHRkaDk4bDhoYm40cmpZRnRISzJK?=
 =?utf-8?B?QWhQME96c3ZEQlJaaDBjSHFvTDdRL3JnOHRxc3MxY3BsVXJycnVjdlZuVHlw?=
 =?utf-8?B?a2lURmdlZU4vU081VFZHa29wK3RRN2MxakZwL2JSMTdTMmVGLzIxb0pxL0lp?=
 =?utf-8?B?U0N5TGFmUkFVMEpHRFdwT3lZYTB2anBGdk41b2ppdHFkQmFZZ1dmVWNxOWlN?=
 =?utf-8?B?QWF4RzVIR2lLbmQ4VUl4a0k4RURZU2RJUnFublhMMTB5UHB2YzFoMnEyTFdi?=
 =?utf-8?B?K0JBYUpmZW5mS1pYQURCb2JBdjhVNG5pZ0JlSHBRWHV6M0FmdEJXNGxqYmF1?=
 =?utf-8?B?Q2M5ZllhQTJmRU9nZHhudFVxK1ZGYWNVVU5oSGUxQzN5Y2lDRExVWnlhOGRN?=
 =?utf-8?B?Q0RvUXIzaDRrYU1PRmp2SHVQbElYbTBpcTBaQ3Y4QlB1TS85MGxvMUt5SUdj?=
 =?utf-8?B?UHdvSHJQb0ZEYXY1eXltNkozbE1Ob0RQSFFrU3RTcUhEd2lnN2JLOWtaRmFQ?=
 =?utf-8?B?Y0tEUHdETGxSL3Q3b21EdFhaMS9penB0a0dMRzdLaisxLzIrb25NWEN4UCtC?=
 =?utf-8?B?STJicnh6ak9aR1lvWWxTaHBQMWZLZUR2MFovczF2ZGtZbmQreGpSSlhidnQ0?=
 =?utf-8?B?UmRQMmJRVGkwdnBmZjdMOHVPaGorUVRLUVR4UDBGcHVwNnd2dmdiLzlmMmtP?=
 =?utf-8?B?OG9KRXhvSFVzeEw5eGNoeXJtakNzcUJ3dGxzcDJ0OGtwN2RNQlFSZ1c0WVo4?=
 =?utf-8?B?ZVpCWjRzQmpiZy9mUmdSZThjQVFYTXp1bDJYMCttcVhxQnI2bi9IRVNUYWVS?=
 =?utf-8?B?UlhLY1F0eUVJWlRUTmVseTBaaHczam9zVEVCbDIydm9QMG42MnZhTzB5MDJ0?=
 =?utf-8?B?c0t1WW9kenYvMVVaWHQ4Sms0Ky9wVGpuaWl3ZnFEQk9MMVRFS0xxMEJxOUpz?=
 =?utf-8?B?NThKSzNKSndhSWlOWDl2cDRaM2ZtQ21wT1AwbTNFVG5hZEhaTTMyNU9RanIx?=
 =?utf-8?B?MlNJd0hLT1RlRFhRRFBQVkpsNTgraXowNm9YQW4rSjlDYWhjbmQzV2ROTFlF?=
 =?utf-8?B?UTVGTXJRZVJod3hhNy8rN0VqU3c4MGVjVG83OCtML0JXOHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGVVMW1JZjNGZE5Yb0tIMy9Tb1B1RjA1TTFJMGdCV3BhUG5yUnViWFpPeklp?=
 =?utf-8?B?RktSSHl4OWFQb1p2d0hTb3Y0aCtYNG9wU0Z4MkFsN05tS2N0d2NQQ3V0U2Na?=
 =?utf-8?B?ZmZxbkNPUktuazdFenFYNzY1THdUV0xiRmtoR2Q1OE5qQjVPb2JkaStPd2Uv?=
 =?utf-8?B?YWJCdld6TmFtc1NjSmRkMTlvaWRjK1NQekQrV2JtZGlLSzJaQllVbFExT2dC?=
 =?utf-8?B?eldzaFZrOW10WE44T04yUitMT1lob1R4NkFEN1NoRUR0T25WeXMzcXJtL05Y?=
 =?utf-8?B?UXR1K2V6Zm5NemlCbEVsRmZ3ZXpOQ1pjK3FTM1RQdmZiMEtRaW5XM215UldH?=
 =?utf-8?B?eHp2a0dTV2xjUHRqb2xWSFRFOFJTMnNNN2hDSEN1UDM3L0RSNHBEbUllVHdJ?=
 =?utf-8?B?VXM4SDd1WDBEdWhid3VkYUlHenFCUm03cENuZW9Td1ZldjRKRnZDdDc2bVMr?=
 =?utf-8?B?R3A4LzJwejRBb21XY1Q2TzhxT0JQbmRIcG1rK1lhYnk0L3lvYWtlWnBiU25o?=
 =?utf-8?B?TC9LNzhVK01MT0J6UFhoRjMvWVRuamRxQWNqUVRveVp4RXVsUkMrMWlCd1Y5?=
 =?utf-8?B?MTlmbSswSncyZFVjT0ltS0FJYmVqbDlwRk5EZ2NoQUwrS2h1YjV3Si95RHJo?=
 =?utf-8?B?VEJpTFFnVVNhck9Zc2F0VE5DVzhhRWJFRDFFb0pCMDlNVmNSb3ZFcXlLcHNW?=
 =?utf-8?B?WE9jQUJmL3FrRWRhVFFxZ2xjV2xQSnBUb3JVelFUUStnTHpVNXA3MDVWSkNJ?=
 =?utf-8?B?UFlYMWJMM09ZTVZKenViSnI3ZVpVWEZRd0t1ZUlqY1IwUVBqTUN5dlFXZ2I3?=
 =?utf-8?B?bkJOSk9CZ2l5Mno2amg0N2c0SDFmWDBSemVkbzJWYmx5bGExWkNHeVB3QWM5?=
 =?utf-8?B?NXpKOU95SGxhcHg1b0tqUUZuWFV4aW4wVVlFZHkyZEo0S1cwWHZGZ3Fnam54?=
 =?utf-8?B?QlNJVDlwK01kMmx6VitEOXRRSUlBdWhsMHk4T1A5aGdiS2JITHdvWHp5S2Ir?=
 =?utf-8?B?Q2Qzb2Y5d1dQazB3OERweE1CNFFpSzU5ek1QVHF2UUd5WVRGNUloNWJncVNi?=
 =?utf-8?B?WDZYL1FOdUVxeDVCdXMrT0RhMzJmYjhzWVRlN1dEY3V2WW1kdXNlMnJFa3pq?=
 =?utf-8?B?VWhLd2E4L21VTGtwUEtJWTFQWUEzZkdsS3FSbGFIKzYzM3RJL2xYdlBPektu?=
 =?utf-8?B?SlNOZDh5NkwrMW8zSzJUSnI1V05CWFN2aWRmMk9nT1JzMGZaeHlqZ3prOHNI?=
 =?utf-8?B?OEpmbnVwSTR1QXV0VTVEOWo0SkNPNlJCVmJRdjJSRkhCQWptSDBKRVdNT0RQ?=
 =?utf-8?B?aDZ0TzBIdXA2c3hNMmhzbkRrV1dMejJMbXMxZC9sT2tHa1Y1L2pTMEFHQ0l1?=
 =?utf-8?B?OFk1OHBFOFNjZDUybmVncnNRZUhkRjVvYVpsTlcwMlZIOEx5ZFpNTjQrTXZI?=
 =?utf-8?B?NTFsZnQxOThkTmtEZ003TXZiZlVOY1JzLzhXMlVoTGYzZG9wZXU1V2g0YlF6?=
 =?utf-8?B?OEN6M3J5aHFUTk1ZaWJPRG00SUZaTDJrQjlmbXJidzJCM1NYSnB5RkdiM1R3?=
 =?utf-8?B?NW5mSWc0QU1Na3o2N3lwNEN3T0NKT2kxai9LUzBLbUJCY25FVEg5TjhocFpR?=
 =?utf-8?B?VW9MbG5sNkpiM04rSDl5ME5SazBCWVl2MmdRUk9YbUNwVkh6cGNLRzdsZmlm?=
 =?utf-8?B?VUZpV3ptTDRsNGJIbHlGYzFubVJNODNLUVI5SHBBS0o3T3Q1emVkRmxEb0Jy?=
 =?utf-8?B?YWNaQVR0MFVLSWQzOXRldXdNQ1B0Lzh0N3hCQWhyQlRVVjFyRGlHWFBXM0NC?=
 =?utf-8?B?NVh1R0lPTmNUdDRVY2VRdnFyRElYWlpjaFdtMS9DcS9hMWQxY1JJMmpNeU1N?=
 =?utf-8?B?M3hCNjVhL3hoMFh0T0lyVzA1dE9JUTRRcWpNQmV2a2ZoRDdiWEl5MVF4L0tR?=
 =?utf-8?B?bkRXeG1jWVJNaklqNzc0MEI0QjVERUVTQ2N5OWp5NUxIejVTSElRb0x5NHlZ?=
 =?utf-8?B?ZFR2Ui9MWnBCRVBHanYvb3BaMEpTb3gzUG83OTNsNURjdDRJako4VGllejdm?=
 =?utf-8?B?VWQvK1VsRm9tOEovMU4xcXI2VEpLTWxzOXgrVEdWa3hCRExjR0VlcmlQTHNk?=
 =?utf-8?Q?KxJ9IbkOiUoYGK1FhdDDCRsNg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f84c0b6-4cc1-4708-5361-08dd344b366b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 03:26:19.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZEnFIgPC/htp9CbBWcF9BkaYgIPrbgE0sAcVVSNCJdxZpSU+cE9d59g3qZ75li5QkZF6zjD8dc+Oew/86Glgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_192626_798209_3FEFE704 
X-CRM114-Status: GOOD (  34.74  )
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

SGkgRGF2ZSwNClRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcyB1cCwNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4NCj4g
U2VudDogRnJpZGF5LCBKYW51YXJ5IDEwLCAyMDI1IDI6MzAgUE0NCj4gVG86IENoZW4sIFl1IEMg
PHl1LmMuY2hlbkBpbnRlbC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gSW5nbyBNb2xu
YXIgPG1pbmdvQHJlZGhhdC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0geDg2L2U4MjA6IHVwZGF0ZSBjb2RlIGNvbW1lbnQgYWJvdXQN
Cj4gZTgyMF90YWJsZV9rZXhlYw0KPiANCj4gPiBCVFcsICB0aGUgY29udmVyc2F0aW9uIGJlbG93
IGRyaXZlZCBtZSB0byByZWFkIHRoZSBlODIwIGNvZGU6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL0NBTWoxa1hHMWhiaWFmS1J5QzVxTTFWajVYN3gtDQo+IGRtTG5kcXFvMkFZbkgN
Cj4gPiBNUnhEei04MHdAbWFpbC5nbWFpbC5jb20vVC8jdQ0KPiA+DQo+ID4gSXQgY291bGQgYmUg
YmV0dGVyIHRvIGNsZWFuIHVwIHRoZSBlODIwIHRhYmxlcywgYW55d2F5IHRoZSBjb21tZW50IGZp
eA0KPiA+IGluIHRoaXMgcGF0Y2ggaXRzZWxmIGlzIGdvb2QgZm9yIG5vdy4NCj4gPg0KPiA+IEJh
c2ljYWxseSBlODIwX3RhYmxlX2Zpcm13YXJlIGlzIHVzZWQgYnkga2V4ZWMtdG9vbHMga2V4ZWNf
bG9hZA0KPiA+IGltcGxlbWVudGF0aW9uLCAgZTgyMF90YWJsZV9rZXhlYyBpcyB1c2VkIGJ5IGtl
eGVjX2ZpbGVfbG9hZCBjb2RlIHRvDQo+ID4gcGFzcyB0byB0aGUgMm5kIGtlcm5lbCBpbiBib290
IHBhcmFtcy4NCj4gPg0KPiA+IFRoZSBlODIwX3RhYmxlX2Zpcm13YXJlIGlzIHNhaWQgdG8gbm90
IGJlIG1vZGlmaWVkIGJ5IHRoZSBrZXJuZWwgaW4NCj4gPiB0aGUgY29kZSBjb21tZW50LCBidXQg
dGhpcyBpcyBub3QgdHJ1ZSwgYXQgbGVhc3QgdGhlIHNldiBjb2RlIHVwZGF0ZXMNCj4gPiB0aGUg
dGFibGUuICAgIFRoZSBoaWJlcm5hdGUgY29kZSBnZW5lcmF0ZXMgY3JjMzIgY2hlY2tzdW0gYW5k
IHZlcmlmaWVzDQo+ID4gaXQsIGJ1dCBzaW5jZSBBRkFJSyBlODIwIHRhYmxlIHVwZGF0ZSBvbmx5
IGhhcHBlbnMgaW4gYm9vdCBwaGFzZSwgaXQNCj4gPiB3aWxsIGJlIHN0YWJsZSBvbiBydW50aW1l
LiAgU28gd2UgY2FuIGp1c3QgdXNlIGU4MjBfdGFibGVfZmlybXdhcmUgZm9yDQo+ID4ga2V4ZWMg
dXNlIGFuZCBkcm9wIHRoZSBlODIwX3RhYmxlX2tleGVjLiBXaXRoIHRoZSBjaGFuZ2UgdGhlDQo+
ID4ga2V4ZWNfZmlsZV9sb2FkIGFuZCBrZXhlY19sb2FkIHNlZSB0aGUgc2FtZSBtZW1vcnkgcmFu
Z2VzLg0KPiA+DQo+ID4gT3RoZXJ3aXNlIEkgdGhvdWdodCB3ZSBjYW4gdXNlIGp1c3Qgb25lIGU4
MjAgdGFibGUsIGRyb3BwaW5nDQo+ID4gZTgyMF90YWJsZV9maXJtd2FyZSBhbmQgZTgyMF90YWJs
ZV9rZXhlYywgYnV0IHRoZW4gdGhlcmUgd2lsbCBiZQ0KPiA+IGZyYWdtZW50cyBhbmQgbWVtb3J5
IHdhc3RlICBkdWUgdG8gdGhlIHNldHVwX2RhdGEgcmFuZ2VzIGFyZSByZXNlcnZlZA0KPiA+IGFu
ZCB1cGRhdGVkIGluIGU4MjBfdGFibGUsIHNvIHRoZSBlODIwX3RhYmxlX2Zpcm13YXJlIGJlaW5n
IHN0aWxsIGJlDQo+ID4gdXNlZCBmb3Iga2V4ZWMgbWFrZXMgc2Vuc2UuDQo+ID4NCj4gPiBBbnl3
YXkgSSBuZWVkIHRvIHRoaW5rIG1vcmUgYWJvdXQgaXQsICBwbGVhc2UgbGV0IG1lIGtub3cgaWYg
eW91IGhhdmUNCj4gPiBhbnkgY29uY2VybnMuDQo+IA0KPiBSZXJlYWQgdGhlIG9sZCBjb21taXQg
MTJkZjIxNmM2MWM4OWUzMWUyN2U3NDE0NjExNWE5NzI4ODgwY2E2Zg0KPiAgICAgeDg2L2Jvb3Qv
ZTgyMDogSW50cm9kdWNlIHRoZSBib290bG9hZGVyIHByb3ZpZGVkIGU4MjBfdGFibGVfZmlybXdh
cmVbXQ0KPiB0YWJsZQ0KPiANCj4gSXQgc2VlbXMgdGhlIGU4MjBfdGFibGVfZmlybXdhcmUgd2Fz
IGNoYW5nZWQgdG8gYmUgZXhwb3J0ZWQgaW4gc3lzZnMNCj4gaW5zdGVhZCBvZiBlODIwX3RhYmxl
X2tleGVjLCAgIGJ1dCBJIHN1c3BlY3QgdGhpcyBpcyB3cm9uZy4NCj4ga2V4ZWMtdG9vbHMgKGtl
eGVjX2xvYWQpIHVzZSB0aGUgZXhwb3J0ZWQgc3lzZnMgbWVtbWFwIGluZm8sICBidXQNCj4gZTgy
MF90YWJsZV9maXJtd2FyZSB3YXMgY3JlYXRlZCBieSBhYm92ZSBjb21taXQgdG8gYmUgdXNlZCBi
eSBoaWJlcm5hdGlvbg0KPiBhbmQgdGhlIHRhYmxlIHNob3VsZCBub3QgYmUgY2hhbmdlZCwgIHRo
ZSBmYWN0IGlzIHRoZXJlIGFyZSBjaGFuZ2VzIGhhcHBlbg0KPiBmcm9tIHRpbWUgdG8gdGltZS4N
Cj4gDQoNClRoaXMgaXMgbm90IGV4cGVjdGVkIGZyb20gdGhlIG9yaWdpbmFsIGludHJvZHVjaW5n
IG9mIGU4MjBfdGFibGVfZmlybXdhcmUsIGl0DQpzaG91bGQgbm90IGJlIGNoYW5nZWQgYnkgT1Mu
IEkgc3VwcG9zZSB0aGUgY2hhbmdlcyB0byBlODIwX3RhYmxlX2Zpcm13YXJlDQphcmUgYmVjYXVz
ZSBvZiB0aGUga2V4ZWMgcmVxdWlyZW1lbnRzIGZvciAvc3lzL2Zpcm13YXJlL21lbW1hcD8gIA0K
QW5vdGhlciBxdWVzdGlvbiBpcyB0aGF0LCB3aHkgZG9lcyBrZXhlY19sb2FkKCkgZ2V0IHRoZSBt
ZW1vcnkgbGF5b3V0DQpmcm9tIC9zeXMvZmlybXdhcmUvbWVtbWFwLCBidXQgIGtleGVjX2ZpbGVf
bG9hZCgpIHJlbGllcyBvbiB0aGUgaW4ta2VybmVsDQplODIwX3RhYmxlX2tleGVjPyANCg0KPiBR
dWVzdGlvbiBpcyBkb2VzIGhpYmVybmF0aW9uIHVzZSB0aGUgc3lzZnMgZW50cmllcyBmcm9tIGl0
cyB1c2Vyc3BhY2UgdG9vbHM/IA0KDQpIaWJlcm5hdGlvbiBkb2VzIG5vdCB1c2UgdGhpcyBzeXNm
cyBlbnRyaWVzIGluICB1c2Vyc3BhY2Uob3IgdXN3c3VzcCApYXMgZmFyDQphcyBJIGtub3cuDQoN
Cj4gSWYgeWVzLCB0aGVuIHdlIHNob3VsZCBoYXZlIGJvdGgga2V4ZWMgdGFibGUgYW5kIGZpcm13
YXJlIHRhYmxlIGV4cG9ydGVkDQo+IGJlY2F1c2UgdGhleSBhcmUgZm9yIGRpZmZlcmVudCBwdXJw
b3NlcyBhbmQgb25lIG1heSBjaGFuZ2UsIGFub3RoZXIgbm90Lg0KPiANCj4gSWYgaGliZXJuYXRp
b24gb25seSB1c2VzIHRoZSB0YWJsZSB3aXRoaW4gdGhlIGtlcm5lbCB0aGVuIGl0IG1ha2VzIG5v
IHNlbnNlIHRvDQo+IGV4cG9ydCBpdCB0byBzeXNmcywgd2Ugc2hvdWxkIG9ubHkgZXhwb3J0IHRo
ZSBrZXhlYyB0YWJsZSBmb3Iga2V4ZWMtdG9vbHMgdXNlLg0KPiBJbiB0aGlzIHdheSAgYm90aCBr
ZXhlY19sb2FkICh1c2Vyc3BhY2UpIGFuZCBrZXhlY19maWxlX2xvYWQgKGtlcm5lbCBsb2FkKSBj
YW4NCj4gdXNlIHNhbWUgZTgyMCB0YWJsZSwgaXQgd2lsbCByZWR1Y2UgdGhlIGJ1Z3MgYW5kIGJl
IGVhc2llciB0byBtYWludGFpbi4NCg0KSSdtIE9LIHdpdGggbm90IGV4cG9zaW5nIGU4MjBfdGFi
bGVfZmlybXdhcmUgIHRvIC9zeXMvZmlybXdhcmUvbWVtbWFwLCBpZg0Ka2V4ZWMgaXMgdGhlIG9u
bHkgdXNlciBvZiAvc3lzL2Zpcm13YXJlL21lbW1hcC4NCg0KVGhhbmtzLA0KQ2hlbnl1DQo=

