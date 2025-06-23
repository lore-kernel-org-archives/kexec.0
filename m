Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9769AC7115C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 01:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdaXgu9OcbC3ONlNjf7aSbumx9WjxRNNoOdAcLn9awY=; b=2KFq0ys0B+PHn+SaepwXWAk67N
	s3nl5KI4s1k/h8bKjzqg9o+GUKVNK2p0/3pGl/7XMkdW/jcKnE3RP+C59MGUWbomSASp3LVzyf9Rj
	sr+MvjVOBUaioaFVmIoPpfPXVfjjJ4RXqvFUUuScLmIMR4iMfbvwKhg+pg3Fi3jiN0iJBsylxt7HI
	frDr/oykrgG+UYxyiiNjPlmGH6zgAYDK+JldzB80jaaOuZBWylzvLk/k7yNQT+tHhiVdEWbVVBdC1
	NJYgP0hvKxdll8TTpmG0D+EtAzSp4dhS2Neinaj+A3Qd76IX8zEoU8ULWaYvFpiOYiaGYcTnpapZl
	LVertjIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTWMW-00000001Pmb-2FVT;
	Mon, 23 Jun 2025 01:52:44 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTWMT-00000001PmF-0KXy
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 01:52:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750643561; x=1782179561;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sIySZSPAzuQaOL8oCYRQqzMLzLsCWPqPf1MK4h7Ju/Q=;
  b=VVltHym3gdsroJ5ae6C/5edX7XI7GeEMoEAerWfFeNarOzz0ZVvh0Z4k
   f6rkK7BClLLXnKx+x11ggzVdZDsj80EBWtg+KAfLRsvkEYg33Ov3kcrg3
   tmhSVgeYNEf4j9EMhcLN006gJ/nEqcoKMo5KToUlCtmqkWOOGs1sTtR/D
   g5gfg9zvz0xezBge5fYjpnyUpdx9JU2NWlrfvZVEBvzsn6xiMllxgLisB
   x307omAIS/vG4/vM2pIYYlLxSoqfwZMa4BoOXOEuJ2NKQCfUgFA8T+wKs
   EjuNEhd477naZs9A2qvt0tTSrF84stfxyHHNwp3Xu1UjeOQfFQTa9j5iH
   g==;
X-CSE-ConnectionGUID: rhVUkWdJTJmEnXDwQGw0Ww==
X-CSE-MsgGUID: CdUEUAALTYubNCuCXXbwjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56644953"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="56644953"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:52:39 -0700
X-CSE-ConnectionGUID: fZah9L0TQX2rqJ151Ob7TQ==
X-CSE-MsgGUID: eFWOK+NOSkWRNb3gS3Fmcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="150869478"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:52:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 18:52:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 18:52:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 18:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDsNi7/VmjeAxrOH/TjNthoQsNkV8mKvViSF/ACzRXaNrCuGZYaE2NSKo3FxbOfE+Tr51YI96gjU+cHffonStmxp744X2Zcm3CAIgjCgP8Twb6d4+iAoPq/dDw9dU+AyLM3tnlWV4eOEzLXOYl3+GbUcQUSd9V1yWruYU8pc9386YvX98gztkzCmX5PHsOGpZFPbjornPjqLknKKRBUmoEQQlKIFf11HGvJBrPjbjAfyVymG/lWZa/hpFhgHTaqc0EV7VqUywvQHPUA8nlZxE0dGrD+Zsiusjq8Uv8OalM2yBljkSdUXDQU3I7DhWqr1vPEkZZrMC+RLpRR/5qMplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdaXgu9OcbC3ONlNjf7aSbumx9WjxRNNoOdAcLn9awY=;
 b=aLn+MRq07lrHSl8HM8Ynkw99sSFmYQh5Rav2XTmSN9rm/WwTbRovh0e5zGXPxHXNmdMeGfqZI6Pn/Zs3yylXsvVRrzz1FD7sXyV/zb/XBbcNcNBZWez+JtqV5iZSE79v+9cMDmaH0NtDe6slM1I3ZAPGzlpwS4jXk8ya6fnVjT9+6G/qx+ARm5Mf45z16osS4FWNM5wPUZX+5dI9Ds3w+VBFQn4Fm1Q5IMUwD51zcPImb51qS7FOL7mO1RXxR9OgtO/HylWnap8sglXGWsfV+yAm5XdU/fcTqb9ppuLCfmT4vqlimeI8T4mouuYHgXvFF8GoWMwmS9JYgQ3s2NiJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 01:52:21 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 01:52:21 +0000
Message-ID: <b2387999-66c5-4f9f-9052-d85208fc5694@intel.com>
Date: Mon, 23 Jun 2025 10:34:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
To: <kexec@lists.infradead.org>, <k-hagio-ab@nec.com>, <yamazaki-msmt@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <20250609050244.837619-1-zhiquan1.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH7PR11MB8478.namprd11.prod.outlook.com
 (2603:10b6:510:308::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|PH7PR11MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: c6255f0e-1c8e-4177-763c-08ddb1f897d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGVhbmtST25kRlptd3RlUitQYkVvTmVrQ2FXb1p0T0RYT3BWK1E1WDEvbytN?=
 =?utf-8?B?aVJ6Sk5YeUhPcG9ZanozeXk2YVdyaDZVTmVkckhraWowTTVQZjdvMDN2T2RN?=
 =?utf-8?B?ZlZNaTJ5N0luSFBvazlwb25LSnMrQ2tTVVR6Y0NLMjlvTjBIQVZZRXduekVF?=
 =?utf-8?B?aDJVR0tDMktLUkNhZExydjVzZzQrc3hPeHBGRG1DMHYzYy8rZ3hFZ3pNMGR4?=
 =?utf-8?B?YVNRTno1S1UyTTQvd2lzZ3dQcjFKRzdodHd0WXN0UkRQZjNLMzVyWEhKejdt?=
 =?utf-8?B?YjQ2T01yUjlxUERtRDdTVWFReStKdHFBU2FtMnJzV1hHOHJQc2ZXdFd2SHN1?=
 =?utf-8?B?SG13S2lGYTNHTVAreEhTMXBUNSt6djdudW13WXpNQmVFWU5IZVFUcXlscFlo?=
 =?utf-8?B?R3BvR25EZ1NyQ3ZWajArMkZic0hmZFJNZElnM3pZNTNHdXJVMXZUSUdDSTN0?=
 =?utf-8?B?d2lEejlmUmdKMkZkQURlbjlUOGJaOFMvMnVqdnZha0NtVEdRVVRUWSt6cGph?=
 =?utf-8?B?Vnp3ZFNFc2JubWViblB2N3g5VEhrenY0UmNlRTNrdU5sOGNmaG1jT2lDLzFs?=
 =?utf-8?B?L1YyZ3dXNmV3Z3lJUTZHcG9id1NqMExCVVhXZDFkODVsa21QaHB6MXZtU2pt?=
 =?utf-8?B?ZHVQVGI2cHljYkhSK2FXYVl3YXVHUkVYdmxnVGVYdFp1bkVqZWVhaXpFK3dl?=
 =?utf-8?B?eXo2MitYcDJrWjV2QUxONEUyR0h2bHpNVE9IcCt6TUFMbnBSMWtsV2dRVG9k?=
 =?utf-8?B?TnhHWkVqLzFjV0ZybHNqdlNPV2VtRFE1emxHcFUxcXhVdFBwZDE2S0JtNzBu?=
 =?utf-8?B?NlcvSHJuWk5qTlN3SndIR2JtemloNGQwS1FFQjJrSC9oVEcwbXlobXlqY0x6?=
 =?utf-8?B?QXBORXVYRmI0bmRIU1hzM0pHTXU0UmQ3NlFJeC9DWnRQUHhYSnh2cDV5TlRi?=
 =?utf-8?B?ODl0S25NbUFqaDBwZFF5NzlTYUVkOEhsQ1JqVDdXQUpWdEs3elNOOGZQNysv?=
 =?utf-8?B?LzNaTk5BK3o5dWhiZTlNWTgvOWNnNEx0MW5md3RVOEJQVTRTR1luMk9NYmVa?=
 =?utf-8?B?WDV3ZmJ2MW5FYkRIN1JzTkF4V2xEblRhRGh2VUR5QWV5ZGMvMTR1WG5vVEZj?=
 =?utf-8?B?SFlOQWxsdHl2ZzZxWFRqWUJiaUdZNnpNUjRucGgxNVJua2tnTitSbnJ0OEhZ?=
 =?utf-8?B?em84SERJNGdQVFRCM3o5dm9iREtLYzc0eXFpdVQzeDd1T2owckdldXA0Nlgr?=
 =?utf-8?B?RTNBeGZlcHJDSVJaTU1BRWpQOG1ZTnVvNnQvYWxVUjRGVk1TN0lNU0Q3ZEpW?=
 =?utf-8?B?TCt3NW1qV0F3bW92MjVUNENzc0F2SUNVZnBiMkx1L1U3dHlmUnBkUnlKOWlr?=
 =?utf-8?B?ZmdMRWRNNzJ3QjJsQUE5cGtSUzhYQ0F3NkhuWEZ1bklaS3JFb1c3VTg5c3pm?=
 =?utf-8?B?aDFaUjJabERna1hCTDFKYTlLNFpGdkJwc0NleWl3dVJNNThwKzVTNWlJOTMx?=
 =?utf-8?B?eTlPVWFLMXBJMVRRUTRRNVprR0YxQWkvZXFiY3hYbm9TZ1o5YzNwQStDVFRI?=
 =?utf-8?B?azJTbGExYTJNN2lHTGl5U0hWbElRb2VEWEQ2eEZBTnJDM3FrR0wrakpqbk9u?=
 =?utf-8?B?ZCtjblovU0h4cCtyS3lhQjg2cmE0V1Q3ZGJVL1RYNElhZ240VHN3WCtPMlBO?=
 =?utf-8?B?cjllSlFuMTV5aUU3N215WVMyS09JMEM4TjhweGpERlhHM0JrZzJuR2E0aktn?=
 =?utf-8?B?VUtvdndpMDFhS0tybG4rbk9HK1R3UFFLdFpEaUtaZmFtdGNKeUJuVDRmM21O?=
 =?utf-8?B?ZGFwLzJ5YThZbW5zMzBUUlpVSlR1Q1JoS1c4RG0yc2l1cjdqajFpdUhNMlBU?=
 =?utf-8?B?aUdUMjhvVlU2eXNaTitrbDR1RVZ4am5aeTh3bzg3cDl3dHFXZTZ6elZSWWpQ?=
 =?utf-8?Q?cajr6HfJ6mg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRXRTlkeGZyaHo0RUFqcmNqMGxQaFFqSnZvQ09VVExlOUsyK3dFd210SzRS?=
 =?utf-8?B?Mkg1U1hkbVZmdVBvc01IYitHeENmVDNaaTJTbTl6Q1k2V004dHJNaUR4YkZw?=
 =?utf-8?B?RGNOaWlNaFJNb2k1bENFQkdHU3JPNzFKMEVVTjl3Zm1PcGpOKy9IWGk2Rit3?=
 =?utf-8?B?QnphQUx3UlBrOEJiSWd3WmM5aWpFSnVHNml2MWp3clJhaWhQcXNTajNkb1pP?=
 =?utf-8?B?Ym5vb25XR1FFL3o5b0l4dkVMRG9sejNyZmpWOFhqdlNvVkNtQWFPUGFwd2Nn?=
 =?utf-8?B?blJFL0hlMk5ZbDJRaFIveU9mLzNzVllxREtUcC9RR0xqTlU5aWRpbWJsK3Bw?=
 =?utf-8?B?WWNyVHBIcDl1MFNVS0pBSEdvWkNTb2krbUI5dW1jWU5ZTWIvM3NQckluMVRY?=
 =?utf-8?B?SGcyL0trODRHbllaekErVHorUFFtdDRTV3hDRWxyUUFyZXRtWWJRTFdJTUlM?=
 =?utf-8?B?RmQ0cVZCU2ZYS1FmNnZWRkdZTHN0NjJjOTVLRlNNVFVLamFzVzNoMndPZjM0?=
 =?utf-8?B?TVJRZlBwY0djQkN6MlhpenFVcWZrSHNYYkZiRzNScXNjdTFFUk9DT3NBR0JQ?=
 =?utf-8?B?bEhLWldqSWEwU0d1WjRtR2xQMjlpZXlyK3dpSFZLMEtYeGd6cTJyTjNnbjcy?=
 =?utf-8?B?Y2pRMVB1Vkw2MkU1ZUI4SEJzUUY1NWE4RTRqcSt2LzRXaXJaWXZodVlYa2JG?=
 =?utf-8?B?YjU3dDZ4TGRGODVTL09jRHVDU0tzWlU2ZVMrQVphdHpyVmxXWUsvUW93N1dl?=
 =?utf-8?B?RUsyeEFoM1hFS0NTNHlaYmtBU3RHMWYzS1VZWnF2dU51MDJTRkNDMi9WWmZl?=
 =?utf-8?B?YXoxWlYzd3Byc3VISlQxTkdJQnJ1VUFTZzZzUmJxdmQxdnVyWlgySmJxL3dL?=
 =?utf-8?B?TkhZbXU2c2lkUFZSRCtkNTFHS2J0U0dJQmljZHlseUUvdms5VnVWTk9zRzhR?=
 =?utf-8?B?b0hWOE1XVE9BTmxTNllSOVc0akdIUmkxdXkrM3lIaDJlWnNneXFjcWJOa1du?=
 =?utf-8?B?N1VxZmVWTlMrVnhEZklzdXRVY0s5ckdZUlc1RDZWd3V1UWJucXlkZ0xXMFFW?=
 =?utf-8?B?UkNHSUNjcndBc05Jdjc4R2s3MFQ1NWRXREY3ZFBkYjN0MkE5OFduUXhOb0pY?=
 =?utf-8?B?ZGpkYUI3SG1KSk9nVFNiTStpRld4aDBvZ1VBN2QvRnBUbGQ5TTVqSUF0R2ly?=
 =?utf-8?B?Q3cvRnk3Qjc4R1c4cThLOFhTdWhQNlJwRzJFZzU4OGhFeU5VelAzbWFCTUts?=
 =?utf-8?B?R3VKbmo5QjMrZU8ySHV3Z1hXdW1sUGhoMHhlaEtYdmE5Y0ptQjhCVFJMRTZS?=
 =?utf-8?B?Qk5IWS9yaUVvMDB4cDBKWEhnczc0MzRqM0ZjY0tmMlh2WFg1MTQwM0J0cjZZ?=
 =?utf-8?B?OTdGUFA1b2pCc1pFbmxwUUVVeUltVHJXbktJRXZzbXQ4TG1CL3lkRktDazdh?=
 =?utf-8?B?Rm5MakVmT0pyZ3J2VUtMRHF5d2JhZERzRWZkNVdiUlEvcU5HZnBvT0lFMjA4?=
 =?utf-8?B?SnBjZkI2dll3cFpZVExNZ2NQUkt4QUdqYTBJUEFHdnNEdWs0MVcvbjU1S0hv?=
 =?utf-8?B?RndoL0h6WXQrQnB5cm8xZ2hiblB0bkQ1T3JTamNhUk90OG1rOHBSKytuUklD?=
 =?utf-8?B?azVCSlZSWjZWRktVZEdobWlUUGQzQjg2d0QyZmtnWWd1Yk5wS0YzTzFvWTZv?=
 =?utf-8?B?RGtLNmpaVFlPK29VZ0ptSENkYVhkejVFYWhvYWVML3Q2dFZnTndxSXlURGk5?=
 =?utf-8?B?bFJ4RVd4OUtqQSt6U1FidWtBZUdhMjdkNkErWm81bjRXTS84Vm5GN3p6aytX?=
 =?utf-8?B?c215N2h5eUtBbnU3eXNjUmVYL09lQnZ6bzVKb2RTVHFmcnhlRVMyZXB6ajNF?=
 =?utf-8?B?RGhkdG80QTMraXF0K0F3WE9kRW5jem5XZEpaajgwaWJCZ3pFU1ZhVEFQT1Ez?=
 =?utf-8?B?TDA2VEZwZ1JWRDJSUkNNWlgrK01uN2oybTNiZXczZnRnYmdCU0VDdDdvRnIv?=
 =?utf-8?B?Q1BRUkpTMU9UT2hYWWVveXYzWUZvUHFJMmNtaS81TXVQdTFQZTdGMzh2eGUv?=
 =?utf-8?B?RzZKcGlOQ1Q2R0hRbU1CUXR0dDEwTFdzSGx3N0VRU3kvZFp6MkZwdDdFenJr?=
 =?utf-8?Q?Pa25lcAV1FNmGQ+PeDeAv7zgC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6255f0e-1c8e-4177-763c-08ddb1f897d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 01:52:21.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppGHEh71cMDPhv2ERvpmLcn3DWJ6l2/l96iEkXK5tIf5t0uhNM7Cac89LPMgYoQWvJTjZ/eRR117DiOPAR4baA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_185241_146626_3731308D 
X-CRM114-Status: GOOD (  16.75  )
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


On 2025/6/9 13:02, Zhiquan Li wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest.  Accepting happens via a protocol specific for the Virtual
> Machine platform[1].
> 
> Before unaccepted memory is accepted by guest, any access from guest
> will result in the guest failed, as well as the kexec'ed kernel.  So,
> the kexec'ed kernel will skip these pages and fill in zero data for the
> reader of vmcore.
> 
> However, it introduces a problem.  When exclude a page filled with zero,
> a pd_zero, which sizeof(page_desc_t) is 24 bytes, will be written into
> cd_header and this part is not compressed by design.  As the unaccepted
> pages are exported as zero pages, which means ~1/170 of the capacity of
> unaccepted memory will be added into vmcore additionally.  In fact, they
> should be considered as free pages and most of the time should be
> excluded.
> 
> Unaccepted memory is unusable free memory, so they are not managed by
> buddy, instead, they are added to a new list zone.unaccepted_pages only
> when the order is MAX_PAGE_ORDER each time conventionally.  The new
> page type, PGTY_unaccepted can be used to identify whether a page is
> unaccepted[2].  Therefore, add following changes to exclude them like
> free pages:
> 
> 1. Add NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) to identify a page is
>    unaccepted, a kernel patch[3] to export the value of page type
>    PAGE_UNACCEPTED_MAPCOUNT_VALUE since kernel 6.16.
> 
> 2. Add a condition to exclude these unaccepted free pages.
> 
> Dumping host kernel will not be impacted by the modification, because it
> cannot enable CONFIG_UNACCEPTED_MEMORY, so the page type
> PAGE_UNACCEPTED_MAPCOUNT_VALUE cannot be found in vmcoreinfo and skip
> the step.
> 
> Here is a vmcore size statistic of a freshly booted TD VM with different
> memory sizes:
> 
>   VM.mem | Before  After
>   -------+----------------
>   512G   | ~4.9G   ~2.0G
>   256G   | ~2.0G   ~1.1G

Kindly ping.

