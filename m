Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDE2C74A5B
	for <kexec@archiver.kernel.org>; Fri, 17 Mar 2023 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+N1u2Hz+2jX9rYWXeT5uVGXA1P2a+A/RkQMeOFqt7U=; b=L0s1HcHxNJbr69fNex3uGAAwgr
	7iYzLXA1OGs4wimArrjqKWoqJYo9CZ2IX+ztHreoDl83BzqTMLtexbTBCQumuhuAUuEIQdaiPZLjd
	TlEjZ3RONzaks01ju0mrs6Cg+s9z/h4l9rCgp05FqingbvqGAvGvNmr7PFEqV4Kj1heaT0S35Qy5/
	p18fOfSHvhDAQtlURg9E2MGqQGmg/lWYcu1anNR4YanScNdrJsOJv7q6MHSug4RN0zzuUyHYEwjTf
	I2g70cgJF7Wtm1expUbPEB97CofPBSHRnlhVgKo8pCrlAIIRgIm7T+LcXmz0HKsp7LXo6RWhTBeke
	ne7GTCUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdF2Q-0033cm-0X;
	Fri, 17 Mar 2023 18:42:50 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdF2N-0033cO-1q
	for kexec@lists.infradead.org;
	Fri, 17 Mar 2023 18:42:49 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HI4VGF026476;
	Fri, 17 Mar 2023 18:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+MoZkXttl0/UZLb0DpD1YxQ69ZQDHMcpJmUjfsrZoIk=;
 b=ecLj1Q4bgu+ATd35HWPLbPAv7VmuR/3KK9lHfwHLsqeuj4jhim6jOK4ogvxwf7fkO9MZ
 KE8ieff7a1N+WNkCHYnb3gRmtblKPrNjblGIZoYj+b0oU/exc+WKbwJFYjZ4jsn12QvA
 sBXvhMQgvz8h9925TpPTCntZ+kRqW1urLEgImud+SjA+A95oHwO0VsB4kPsnwCzssQRj
 /GT7hXia2PMVluP6a35/QZt53ieiuZn6+s0GsE3oDwL+xNmamod2/dM1tNklQTAkZCQR
 4omtmu9nfHsHMWm8MqLUh8vlqGasij5zR1sE0kSQ44YiBz1/v+DA0vu5QwtymgQizy17 fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29ckkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 18:42:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHE67X002531;
	Fri, 17 Mar 2023 18:42:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pch08d522-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 18:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFc4IbNRNe+1GLAlKRONSPmHbS9QLTqJ+UuRJXJuf4PBH8kNQGGg1aU4/bTmk9EL6+/j1SvDnVVwnrtu4MWcfq02v54sKV87CpcQl169Wz1YxpMsTK8X4RHDapRWpMPe2FRkSDlo+ZT25aC4KEA9YaOGz/NJqniBhT4jRrBMGuO2Y7NouW1kqYoD+sBaPkhirn+eMhHzCTP2yP/rSSO/997BKW3f98YY3h4ZI6Lc6e9rIOU5fUM2y8enG3yWt82swUsuygh/z+SkeST3ISJpmIhFgqkivAoXfabDB23B/fu2CPQme4zwEzJW+NrRg3pzuv/j+3cIgmAEkPmy2wkdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MoZkXttl0/UZLb0DpD1YxQ69ZQDHMcpJmUjfsrZoIk=;
 b=ZpJMMVhjk7bQQadcFW4ggENvR2/hGsqJqsXuOFjFGy1stZv5XZAk+nf98ZG5nFRtmm/tERn8wM6uf3hDOhP0GPO7BTjEBk9UUHqQrByEsY/JJRhY6JtwvGyoUwuVoObEQ5ZDaA8HytjmF0KP20dxBZGz68O7vG8rc+BynR9oCQVWdBW6PuKNvM7Rf9IxyyVc9Zpd0hVdeWGnDGOyeO6YYpSFhIA7MfNts1fEVV2/3/GRnf8f5MUGDd2ExTO2s5LBi5D+dVWqADi2Jt+gwxBN9IWaKdCGSimvZ3C9tDpwcKJ6IvQ7VxuB+mQ9M0dPF9C5D3lHq3HzBB/6RI+PRb71mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MoZkXttl0/UZLb0DpD1YxQ69ZQDHMcpJmUjfsrZoIk=;
 b=Uce5ksHjgGNKUosGzh0kDtN7e10Tsxfth+PFwt77vrwzjqMb5mMJWZ1WcqW7dWd1x1n/nSeaOvJrvoLQvDir4hjrXLSZ2v0tFfo3rZBHyUCzqu/gbviqLu/Pbnz1tWqjz17r55l5m0rYz/4NpjcWle4E+Y7n5rYGe58cceB49rk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Fri, 17 Mar
 2023 18:42:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:42:28 +0000
Message-ID: <5e6d1cc8-82b0-b854-e244-73ed00997e40@oracle.com>
Date: Fri, 17 Mar 2023 13:42:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 7/7] x86/crash: optimize cpu changes
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-8-eric.devolder@oracle.com>
 <53343c55-c59f-fee7-22f5-94de15a1d18c@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <53343c55-c59f-fee7-22f5-94de15a1d18c@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e9133f29-1667-4fe0-a483-08db27175ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ry6rd0vmLwHCbBtm7pfCEtv7iocmaj9b/4L37CL2AxShBnXopJrRQ4T57rleT7hr79xAucIwM7S+i1ADCZQxA4qkhkl43WlGhCelfIMyleV5rTcq1yVwWeCrAuz272f6jUvmD8wqIvsEyyLPZFtJs3d/gd9NYEgEf9PL6hLxAh2CIY+cLoqgmosdLljlOEZ8B4UHK0YtDYk0Hrn0TB0xq8FAlvFbs1tI4wheJQUjTRY3dpcB1lpRXhT1KMJcOprUJgHJ20RwRk/tS+zZMFEdE9Hal5sqGt141RVXhTqTeh23/mv2yNr/qDkSXMGc3JQAGPW3yBpvnigNGy9Ak9PyxJdcRduzsXATW+rYNavrJzefwTyDODH3TndAxLEFHT9xShCMpWp2n6evBAsqGvvXmWXmIHsgPr65p0gdIjWZUrTcSyM+Rms4d58mYTbyp8hgZURAx4swYfDTRcPcqkEErZvngCtBiObexbGO8hyz8RJEIxtVKtKEXspe4/SgooDLb4yIiLnMoAr0pUj1pDdR0gE8hz6LpiqP3mB2uUGlJ3ftAV1cpBBcKk7fll5Dma5RRUThLO3VXQ13Q98UC6kmW0Drw+HAWzNgAif+dkW1mXnReBcUlZKVDlZeFFHDlCUR3GaLlwqWs7qSPDZitC+cUgIKFY45ZmM40FNWmlEfA5mr6/ulJsBm0uIaM++oghA922QafRcJZGH7Qgmc7pthwK3l5X+5f5T4KjW6vg+gK58=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(31686004)(316002)(6666004)(36756003)(478600001)(83380400001)(186003)(66946007)(38100700002)(2616005)(6486002)(107886003)(31696002)(4326008)(6512007)(8676002)(66556008)(41300700001)(5660300002)(2906002)(66476007)(86362001)(53546011)(6506007)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?VHZSNzZuQ3dtcjBIU0hobm5PSU9NbzlKc3V4bEt4dDcyRklXT09SKzZ6Y2kz?=
 =?utf-8?B?YjdzeXRDencwZWw3eGdXZGZ1M2lDUHA2cGhPSStDNnJPY093WTNHcUg0NGx1?=
 =?utf-8?B?SThob1psbFVxY1cyR05GNmE1TmZQdmRKaVBTQ2Z4TWM1ZFdwemlJenZMUVR5?=
 =?utf-8?B?QWZHSnlIMWlsYUJQZHZqSkkvLzNaNnlPV0p6dno2OW1adTAreUROOFJHbURu?=
 =?utf-8?B?eTFlb1NOUFhZVXl3UVI5Wi9jYlVPaWI5NzQzcXl4ZkM3ejhGNExxV2orU2NI?=
 =?utf-8?B?NlBSZUVuenE3SmorMUZacGpiVHREM2NkVU95TGlTZDlaUEo1enBMMmhsMm1m?=
 =?utf-8?B?RlZsUThFT0Nza3hWWEpUYnZBb0E3WURNWnd5MWZvUGZ5SU0zTlcyMmxmc0Er?=
 =?utf-8?B?N2h5dTEvdktEemI0UHZLTlZVdzM4V2FXZ0ZpNDlQZTRaTTNOTXR0cVI4SHA4?=
 =?utf-8?B?ZXhFRklqQkpkeW95N2RUKzNFaFNJeXk4M0ZjNHVjNWNZUmh5bUJBSDg1VzVW?=
 =?utf-8?B?Mm5jdnh2c0xYNFR0aVhqdEVOU2pSdCtzRXY5UWpGTmUzcGl3M0hTWnBpT3BL?=
 =?utf-8?B?S1BzR1dCc2dZWFIvM3JpTjNPblkrR3lINkppMzlGdHU3YWRyTUg3UU9NTDQw?=
 =?utf-8?B?UHpvb0Z3eHBURHlXT0FFSW1qZStVOHhmNXBWaXgrekRpZDNvSytOdkptV01v?=
 =?utf-8?B?L1pLOGVrRUtuWStzSVVFZkV1OHlDbGludGJIK1lWa1JVN2dvRlkzVC9HU2ls?=
 =?utf-8?B?ZmZWTzRzeWhDczRHNUdYLytFYS9kTEZFZVljZWlLcFZ2RGptU1VGTHpZZUhX?=
 =?utf-8?B?b0RxZG0yazVtcTA1NUpsTzFSdE5RTG5QajRjMVpwTW9LdHIwSjdaeVpYMmVU?=
 =?utf-8?B?elBnbnRlQ2VVUVAxWEx3ZjFSOGtwZml4bjhYQjVQeGh5SlJmdThIdWE2SGZv?=
 =?utf-8?B?eVAwS0tUTmFlSHFSNWROMlNnZG9mQTYxZ1hzV05DVGhTTWs4NjdaRkZmTDhL?=
 =?utf-8?B?SkFFVkxoZnFTWHJFOFRneHZUTDBqNE9xZGxvTlQvMC9FMW9zOHFZbVhyRlNV?=
 =?utf-8?B?K1l1S051aldLWVg5RFZ2WXpHM3JCRVI1NU5hVFBMSVlyVkZSckc0STJuOXdm?=
 =?utf-8?B?QnJTYm1iMXp2cWFFcUkzMnN5SHYzTDdnRVBPd0x4OUU1KzZqMUJVQ0hEQ0t3?=
 =?utf-8?B?SnZPSXBwUVk2R0ZXVnJhQ2E2NzNQTDlOSHo2VGtMeGVLanA5Qzh5WTlYblcz?=
 =?utf-8?B?NjZHdGV2T0VzR1JaRDJGYUswdHNnZFFHV0pvQW5LT1JEcmdKTGNLeVluQkoz?=
 =?utf-8?B?TjRad0tpZmtrMHRtdUVnWlZZNCtXZ3Y3U2ZUeEM3RVcrK3h3K1NtcXZPRFhE?=
 =?utf-8?B?L1oxVjlDRUFDRTlkU1RIejNwYVE0MXN6RmZYaHUvdk9XZFVNTnh1QlhMQitn?=
 =?utf-8?B?YlJLNlhtb3BnS2dvNGxURXRNT0k5eFRvY2RiTDVadmtXWVRRekNHdjZtbVly?=
 =?utf-8?B?NHZ0UXc4em9YNE5oU051WlRTc2V5VXNlblozWUo2VGVUNEJhR2pMZ1Q0VzNT?=
 =?utf-8?B?S3lraDJtamhHY1Y2dy9XZTBpT05lc0NwYTJxc0RvV3BxRlpJekIwZ2tjNXRC?=
 =?utf-8?B?QVkxZlErWW5pdVdxT09VazhQLzZodDJTNkpxNE5Yem5CTFVWNXRWakRYYW5x?=
 =?utf-8?B?bDZPN04yWGhyQXFlSms5K0J6Y2p4SmtUVDJsa2c5WG5qNG5aSEoyWllTNXpX?=
 =?utf-8?B?NHBvUnZHQWZ6dmFVNHAzK2NWZFVzWkUzY3A3VHBTUEJGZmgyNFJDWXlIOE11?=
 =?utf-8?B?UWdvenJzZm43emZJczJNUHl1QUhwb29GV0QxejlwLzhvT0dvT0pMdnROUUd5?=
 =?utf-8?B?QlNZNFdlQm9CRVJ5azV5WTdLMHQ3L21MZ0lEMlR0SGl4TXIxT1RHZTdTeHR6?=
 =?utf-8?B?N05kbWFSWTZsaXp0QURiVnVxRXNiV3oyeVpXV2c4KzYwa2xjVFBCOTlwZHBW?=
 =?utf-8?B?d0RrdCsySGgxYk1GRnBiOTNpYUpHcjEyRVE1SldOQWJvUmtLcFpZcDl1NURZ?=
 =?utf-8?B?Y3VlV0l3QUxlcXdBL1IwcWNyN1lJTmphTXlOUW1BRmlZdTc0c2dhaUhDbkdQ?=
 =?utf-8?B?NzB4VlpRSi9ML045eWw4YUR3Ni9RL1NoU0w4UWtZejVxUWRxNTU2S2t3RWZx?=
 =?utf-8?Q?DEF3Boys2SP8IoexLYO1Fwk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?TTNQYUZKa1dUc21SM2tSNlFkbjUrdEw1bHBMY1Vrc3pPcnZSbmFLWXk1QVUy?=
 =?utf-8?B?R1RMaElDYi94V05FSnRBVm5yMytWelRzWjF2YlZ0Q05DdCtPQytSa3p5dE5E?=
 =?utf-8?B?eFpWbkt3L3M4ZEorL1ptRlYwa2luRk5qRm1pVERibjBRbkN1RnFCUVU1VEJw?=
 =?utf-8?B?WGlDMjBDamRpSXZCaEltT25KZ1hXdzhla0FOV0JUb3VlYWpOZEo1QkRqRmVN?=
 =?utf-8?B?S2U2MWtMM0FaYytZQkNSVERTL2xBTmkzYSt6ODRZMUtNczYrbzYwai9kbVFh?=
 =?utf-8?B?UFJMSWRWdkt4T3VFTVlBUHN0QStDZzNtd2k0VXJTT3NXMkR3YjhkSlVkWjVQ?=
 =?utf-8?B?T1liNDlBV3p6WjhORWxuTm1YZlFGeDk5aXpPMUVidkZFaWlwbTdmYnl0K2I0?=
 =?utf-8?B?cnNFTzBweS90U0xvaUovUUhKTkJYY0c4SXN5QWppQTdnZTE5a0czU2t1SUZV?=
 =?utf-8?B?QVJ3d3dNOVI1YUlaZHg5UUNvVmVKV0FWdVQyTjdQWGRUTzUrajd5UXZOQ0hK?=
 =?utf-8?B?Y1VBOGlkVW8ydjliaHdYei9ObzVzMWQ2YzRlR0o5aWd5SlptZUx0UEtTUE15?=
 =?utf-8?B?Sng2WW9OUzVFa0VlZTFpemg1N2REQk1TWHNnUWNVT3BwK2plYlYyQ3AzK1Yy?=
 =?utf-8?B?SDVGTDlkTFJNVWFLdTZ6cmNaTUU2TzdvYnJCckFtbGpQVVlzZy9xNlQrQVVn?=
 =?utf-8?B?b1JHZ2FOWmpsS2RjR1dmS2NnTXcrWW8vV1JPa2lhaDIyY3RvOFlIcmlBdEl6?=
 =?utf-8?B?VUczR0Z2U1NhK1JQNXIyVG53SmoxNUxDeWtlUnlYWkxUemFMdnBPdVRWME9m?=
 =?utf-8?B?bEVKcTdTY09LVS95eCtpbzhqOVZpT0g0VmI1WUFOcWtOVzlmdmdKdWdVRldq?=
 =?utf-8?B?cFNrZlUrY2ttQzA2QnNvM2pueTNJMTZiVlRKTEo2YUZXSXY1aUJOejJ0Z1hY?=
 =?utf-8?B?SndDZDNlUmZsa09XdnhzaTM5UWhsclVSQ3RFZ0tnWmtQUE5yUXBHb05EOFFy?=
 =?utf-8?B?NC9XeGVabUI5R1BEZnJVYSs1YnFyNkZMOGdrSTk4cUlvdW80UXROY2tUb1hx?=
 =?utf-8?B?TzFUYlo5V2QvaVlvQ1RKMjk3dXROZ1JPY2pmamRhZTE5RUx6UTZIb25OeTVG?=
 =?utf-8?B?WTRWRjg1azllTHpTa09lTXU1Q2NwWGJNYTJUYmJaNGQyb2lSeG5oenc5ZmlG?=
 =?utf-8?B?emFnanFvbXZuYTFYalkxN3pUT3JkaVBVRGJ0akNwUjFsY0JFUE5NWEw0dFR3?=
 =?utf-8?B?b2k1bjJ2c2NZSHF4citwN0NvQWt6UUdsQWhrZlNoYytKazkydXNlOWJHZEd0?=
 =?utf-8?B?SXhLQk1lb3FPQUluelV3KzFNY2NJamtJYk4zZjBWT0E4cFZrV3M4ckgwK20v?=
 =?utf-8?B?d0VaOWpFWkUxZ3pDUzBQblg1ZFJ2cXlCTnFWdXJCQ2k3VVBmSjNkZWJxS1ZG?=
 =?utf-8?B?d1dFaGJIVmtjS0REN2lLV0dRV0RHdFdRQ2M4RlZvY2VYN1lIV2k3Y2FZYkxF?=
 =?utf-8?B?N2xVQVRMdXZ2bURXWCtrMUo0Snk3RUkwZjJrcmhjdHdFQ2ozOHB1VmV2T3J3?=
 =?utf-8?Q?615QTaYxSIxDEzxz/z13URPos=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9133f29-1667-4fe0-a483-08db27175ba6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 18:42:28.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/hH3EeH1j+qx6s5/wRd7BQj2I+mWZ2rs0UTHURxLuYzI5S7EMRE1A0OwpfErDra4cjQe8k0A97TLSwwnZwJgPU1jmatlPBbEwul5CBz3C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170128
X-Proofpoint-GUID: FDMkk4x_VLXJTgsHTtIswOq5pBIyn0uh
X-Proofpoint-ORIG-GUID: FDMkk4x_VLXJTgsHTtIswOq5pBIyn0uh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_114247_616410_6F598C9B 
X-CRM114-Status: GOOD (  27.30  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAzLzcvMjMgMDM6MDAsIFNvdXJhYmggSmFpbiB3cm90ZToKPiAKPiBPbiAwNi8wMy8yMyAy
MTo1MiwgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4gVGhpcyBwYXRjaCBpcyBkZXBlbmRlbnQgdXBv
biB0aGUgcGF0Y2ggJ2NyYXNoOiBjaGFuZ2UKPj4gY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJz
KCkgdG8gZm9yX2VhY2hfcG9zc2libGVfY3B1KCknLiBXaXRoIHRoYXQKPj4gcGF0Y2gsIGNyYXNo
X3ByZXBhcmVfZWxmNjRfaGVhZGVycygpIHdyaXRlcyBvdXQgYW4gRUxGIGNwdSBQVF9OT1RFCj4+
IGZvciBhbGwgcG9zc2libGUgY3B1cywgdGh1cyBmdXJ0aGVyIGNwdSBjaGFuZ2VzIHRvIHRoZSBl
bGZjb3JlaGRyCj4+IGFyZSBub3QgbmVlZGVkLgo+Pgo+PiBUaGlzIGNoYW5nZSB3b3JrcyBmb3Ig
a2V4ZWNfZmlsZV9sb2FkKCkgYW5kIGtleGVjX2xvYWQoKSBzeXNjYWxscy4KPj4gRm9yIGtleGVj
X2ZpbGVfbG9hZCgpLCBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKSBpcyB1dGlsaXplZAo+
PiBkaXJlY3RseSBhbmQgdGh1cyBhbGwgRUxGIGNwdSBQVF9OT1RFcyBhcmUgaW4gdGhlIGVsZmNv
cmVoZHIgYWxyZWFkeS4KPj4gVGhpcyBpcyB0aGUga2ltYWdlLT5maWxlX21vZGUgdGVybS4KPj4g
Rm9yIGtleGVjX2xvYWQoKSBzeXNjYWxsLCBvbmUgY3B1IG9yIG1lbW9yeSBjaGFuZ2Ugd2lsbCBj
YXVzZSB0aGUKPj4gZWxmY29yZWhkciB0byBiZSB1cGRhdGVkIHZpYSBjcmFzaF9wcmVwYXJlX2Vs
ZjY0X2hlYWRlcnMoKSBhbmQgYXQKPj4gdGhhdCBwb2ludCBhbGwgRUxGIGNwdSBQVF9OT1RFcyBh
cmUgaW4gdGhlIGVsZmNvcmVoZHIuIFRoaXMgaXMgdGhlCj4+IGtpbWFnZS0+ZWxmY29yZWhkcl91
cGRhdGVkIHRlcm0uCj4+Cj4+IFRoaXMgY29kZSBpcyBpbnRlbnRpb25hbGx5ICpOT1QqIGhvaXN0
ZWQgaW50bwo+PiBjcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCgpIGFzIGl0IHdvdWxkIHByZXZl
bnQgdGhlIGFyY2gtc3BlY2lmaWMKPj4gaGFuZGxlciBmcm9tIHJ1bm5pbmcgZm9yIGNwdSBjaGFu
Z2VzLiBUaGlzIHdvdWxkIGJyZWFrIFBQQywgZm9yCj4+IGV4YW1wbGUsIHdoaWNoIG5lZWRzIHRv
IHVwZGF0ZSBvdGhlciBpbmZvcm1hdGlvbiBiZXNpZGVzIHRoZQo+PiBlbGZjb3JlaGRyLCBvbiBj
cHUgY2hhbmdlcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBEZVZvbGRlciA8ZXJpYy5kZXZv
bGRlckBvcmFjbGUuY29tPgo+PiAtLS0KPj4gwqAgYXJjaC94ODYva2VybmVsL2NyYXNoLmMgfCAx
MCArKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9j
cmFzaC5jCj4+IGluZGV4IGM5YWFlYzlkZTc3NS4uODJlYTJiMWJkYzYxIDEwMDY0NAo+PiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2gu
Ywo+PiBAQCAtNDcxLDYgKzQ3MSwxNiBAQCB2b2lkIGFyY2hfY3Jhc2hfaGFuZGxlX2hvdHBsdWdf
ZXZlbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBt
ZW0sIG1lbXN6Owo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZWxmc3ogPSAwOwo+PiArwqDC
oMKgIC8qIEFzIGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpIGhhcyBhbHJlYWR5IGRlc2Ny
aWJlZCBhbGwKPj4gK8KgwqDCoMKgICogcG9zc2libGUgY3B1cywgdGhlcmUgaXMgbm8gbmVlZCB0
byB1cGRhdGUgdGhlIGVsZmNvcmVoZHIKPj4gK8KgwqDCoMKgICogZm9yIGFkZGl0aW9uYWwgY3B1
IGNoYW5nZXMuIFRoaXMgd29ya3MgZm9yIGJvdGgga2V4ZWNfbG9hZCgpCj4+ICvCoMKgwqDCoCAq
IGFuZCBrZXhlY19maWxlX2xvYWQoKSBzeXNjYWxscy4KPj4gK8KgwqDCoMKgICovCj4+ICvCoMKg
wqAgaWYgKChpbWFnZS0+ZmlsZV9tb2RlIHx8IGltYWdlLT5lbGZjb3JlaGRyX3VwZGF0ZWQpICYm
Cj4+ICvCoMKgwqDCoMKgwqDCoCAoKGltYWdlLT5ocF9hY3Rpb24gPT0gS0VYRUNfQ1JBU0hfSFBf
QUREX0NQVSkgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIChpbWFnZS0+aHBfYWN0aW9uID09IEtFWEVD
X0NSQVNIX0hQX1JFTU9WRV9DUFUpKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiAKPiBJ
IGxpa2UgdGhlIGlkZWEgb2YgaGF2aW5nIGVsZmNvcmVoZHJfdXBkYXRlZCB0byB0cmFjayBlbGZj
b3JlZGhyIHNlZ21lbnQgdXBkYXRlcy4KPiBJdCBoYW5kbGVzIHRoZSBwb3NzaWJsZSBDUFUgdGhp
bmcgZm9yIGtleGVjX2xvYWQgc3lzY2FsbCBuaWNlbHkuCj4gCj4gVGhhbmtzIGZvciBpbmNvcnBv
cmF0aW5nIHRoZSBwb3NzaWJsZSBDUFUgY2hhbmdlLgo+IAo+IFRoZSBwYXRjaCBzZXJpZXMgbG9v
a3MgZ29vZCB0byBtZS4KPiBSZXZpZXdlZC1ieTogU291cmFiaCBKYWluIDxzb3VyYWJoamFpbkBs
aW51eC5pYm0uY29tPgo+IAo+IC0gU291cmFiaCBKYWluCj4gClRoYW5rcyBmb3IgdGhlIFJCISBM
b29rIGZvciB2MjAgdmVyeSBzb29uLgplcmljCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
