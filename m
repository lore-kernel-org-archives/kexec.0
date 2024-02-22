Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF799C48BF6
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jVrdzHk5fOp7jxBCwaU/RHygoyxVWa0ha8bsEAHZU0=; b=dhHhVenfCUR15XkPnVsEsU5o9m
	6LBYdMPzIGlhXKyDs7p/dis4dldk47GC0+IzEYLu2cu2Y/iQ/fi399gSf2YhF2dZDM8Nh3cygh1EL
	FHMCxSyOG5Gl2NmN5Tjik+avIG5uwSd2vy7hbJeq5c2QPEiM9o9OSas+4nPmvvCWbhlybZ4wvgQW+
	z3WT9cJRld7OXFQaF+SP/hA+X+qdkzT0prGnzMxNXxgTuW1DMiATls/ebH84Dnhx6F5JzcIWWKKem
	zQfZ3Xzrk2lpHb0uMXm2uTJCQE6/ez4A2nxhXUrHAqo3exkHf0sSKxcnUvtGE+o7VN5TYq3Uyhskd
	Yp2o22Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcyYU-00000003DYg-1xmE;
	Thu, 22 Feb 2024 02:11:22 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcyYR-00000003DXB-1K0B
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 02:11:20 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJXkVY028136;
	Thu, 22 Feb 2024 02:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1l/KHd+uPnhOUR2VaY3P0jK1dk9WA9u/BNsC/VA+V7A=;
 b=ow+MldbJlp8VOW9FgR8qqZjZ7xZtVy6IFMKlrHKOJIozxEYBsgiZmdDcvxo9hxm/8kau
 KpnVVwdHUF9ty/hlSN4V82yu+ndGzCW5WVRMGMC8rkFF6eG2B+CobwzwdQ+MgW2Rt4xx
 7b8cBo5i9YyolmCyTTpO6m4Uxh5zRRptptSA6Xql0T/L/5CuWDZzPA/c+AvDcItnT0+c
 uxasIo5X2iKe+VG9NnZ6ygFizxsDOdHZMy47CammAqJhSCq3rW/Ep+pvbwt0A4luS7Cf
 4iIey0WG1oI4yA9m7IZQMVI4jGPYuIDIc6VZ2FSdKQccbA2hKwvBJ+W2UUscsNNpzvki cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk43ev2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 02:10:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M1WioM038148;
	Thu, 22 Feb 2024 02:10:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89vvv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 02:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJV4O+O8l8b6UYaMqVN0Dn64pUF6HtfDEs9CIAohUnsW1Ahgb64qnf4cw3eiEHSKiTV96ZSoem5jWJeJ9AA/apIkhUTCft9A/aZemasBE6+JI6lc7EC3Z7D2f/twwMJh9Uxp9FMcTbswuRDY5HiDGlox3lr01PzLnUpocnKLVMJ5WHutc2Z2oJ9TFBOvpB8ruAloKjfveE7YdOYrtMzN8aiPMjBzSF9sp/N9HmnqXVd+uqEsYxakdcDvNxcoEJQRcpLbl4ga6tbABIRNozZx+vXHikvh5BumfsKbNKDTCbdJAnQmsBYLFGF+HKol06d7hKJwV5WEkc9ioHO9dawOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l/KHd+uPnhOUR2VaY3P0jK1dk9WA9u/BNsC/VA+V7A=;
 b=h0L/dSEL9PRphbJ/RsySnsfqU9FZJqyeqKIaWIAvc2M95MeklRt4pmTRwKZYdPOjUKsTZkK/AlZFxVl7F26IAMP+ZjV8o+rP5059ZKZ4DNOiUze7aGhIQeR50ADq4D8yI30SovKlVneXZKdNQW5JqOCztIRt21DKZlz8LEkyRzt5zJEtZn1wfgg4fj9B60FWXB0Jp7KcfyhKIfcadUvXbecUo2jhbyjPjWoanwrIgtdtpk116SZmkr/ZMFjlRhflJUF4jGBMpghO/2UzwHwpxCUU7lLnfiquRPpxtCNQDwXpXl020bMaTFL1CVSTyCmajtX/qCRscerxZ30JD+ueew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l/KHd+uPnhOUR2VaY3P0jK1dk9WA9u/BNsC/VA+V7A=;
 b=d0bTGDBUq05HhnQW/X6/OlGwXuDVT4PQXkwmnqO/UylJODT4xJXugJNHwoo8qwt01PlCXDOGekdUQu4bEhT0jFsSzc+yJmWgRy/JmUz8Gk7cEmyX2lxthYFNEgL/vTR+pKUC4C0jKd0PqU1MmdFPlspbssjBqDHzTpxydMgvIpw=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 MN2PR10MB4351.namprd10.prod.outlook.com (2603:10b6:208:1d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42; Thu, 22 Feb
 2024 02:10:47 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 02:10:47 +0000
Message-ID: <d250f64a-dd4b-44ca-8fb9-464bbd812c54@oracle.com>
Date: Wed, 21 Feb 2024 18:10:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
 <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
 <08ac69b4-4d12-4454-aa16-40db7e54816f@citrix.com>
From: ross.philipson@oracle.com
In-Reply-To: <08ac69b4-4d12-4454-aa16-40db7e54816f@citrix.com>
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|MN2PR10MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1e7dbc-6d84-4364-12bd-08dc334b7bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGoC+Ae9MkpPxgB6eJ+2YpSw9AVbnktxRf+rtgqHtRXfxQvXmrCsZxdBnslkRlm5RmN3XMkvJhDdhvK8kS6p76UA5D73KHjXRvo73BDzbWVhWieET7gbx3Qj2KnkOmBlrUeFHZG2QZmZ5zBILS17jAWxbvu1ZAF+rR9V9AsYznej3BPxK+BJfojPx8bD3HlRY6Y33Y2oSYRT/7GIDIfnYqgwit7EuSWsZOr5/Xedo17KBCAncIX2h6nhJarxPfgjACInbjzbgZlON6+qPgsLDe+ZAPOZ0Z/UxPJdqwleT7BQyWFzfUEO2umUqdxn+Msikca2N9ZzjnzX5sZ/gUkSVg09uCI8yleuPwTVqxN87KVbDhqESKIgjEsozXvh3CC4oAz1QEBsPTapf7lSaoLQhZXllM/VBJhl22dIiuaxBSj5p9BbcncP4WHcpneWCe7TjduTDXYFHue9obBKxRtaJ3ZSHPknEqkbanRT7VuIX6m32J6nW2S8WTPQlTJYkkcslP4jxt8tupuuFjNdNGm4zDJ9rNNRVEC0ggLu7ohV9RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExWc1ltNUVWNjlEWDJycHV4dGpEc1AxVXN6UnVEbnBIOTNMeTllMDZpWmFK?=
 =?utf-8?B?YTFvZ2tKTStlT3M1ZlNKNlNoMUFpRFNIcFpNTnVjNVVJWk44Ni90L3BkL1dt?=
 =?utf-8?B?V2xMdFFZQUkrYURqcFB3T3loczQ3aVdlbGJTeW05a1ludWR5VjJ1ckIwUDRV?=
 =?utf-8?B?bkhEeXFld3kyczFIL0RGL3ArZEx2Z2dyYk45WHFiSzBsdmtCZ1pick1BczhY?=
 =?utf-8?B?cVZ3MHFJcmlwMlNFWHJvM2FXeHFqUkhaQ1BxMUplazJ3dFQ1VFRzQTRUQ3RG?=
 =?utf-8?B?TWFHYVE5NWx4SGpCWWJ3S2kyZVYrSHlPY2tacklQRWFTc21ZU01ybDliUW9p?=
 =?utf-8?B?S2ZqRFgyT09XekZHSXExaG5YQS9VVGxUek5Ca0hjL1Z4RCtWeGdnY0tia1Ey?=
 =?utf-8?B?Qmdlb3lGSGFHUDNYZmx0R0pXc01pajAwMzZWaU4xZ2paNmw3d2ZlcVpudWpx?=
 =?utf-8?B?VDJwbFJ4cTVIS1JYN1BDN0NySWJ5YUxuTDhWSWF5RnFvZkYvb1JOc3p6OWtp?=
 =?utf-8?B?MEhNWTBOeTN1MWVRc1ZhV3IwVDZ0dmYxREMzQk5YejExUzhFZW9TM3plTnk5?=
 =?utf-8?B?UXBHdWRUOFRsUlBaWFYySUw1S2lkN1J4endTcXVLeE8yOXRZTXowV1QyTlIr?=
 =?utf-8?B?RzBMdDMzTkQ3eXFxVk4yUDFRcUFmbDBEVUdlQXZuN1ZlNUNJNlB6QmwrOWFD?=
 =?utf-8?B?NDlDV2g3UGc0S1B6ajZMb3Y1ZSs3ZmZJMG5vN3BnWXVqc1YzYUU3Z3diYWcx?=
 =?utf-8?B?YVlYRmRUbERVOTV2bUQzMkRoK0Q1UjM2Q1dra2tTQjRwYW0yRU84MUgrelR4?=
 =?utf-8?B?Zm9ic0lSUVVjWGJpZzlIVUE0U0J4OVJrN1NOR2RrSGZoM3pKVkRjRVpmY29F?=
 =?utf-8?B?NHJ1NzVBWnJlZDRkWkpFNjBKKytTSm81bmZCUS9TQjZ6QTVONDZCTno2M2NX?=
 =?utf-8?B?WUlBcWNuanl2Y3JLOWYxQ3VhVDdlWTFLYzhxWnMxdlZNZndaYkNEQkdvMkp6?=
 =?utf-8?B?aXVHbU1YSUMvOERWNFluaUtOSi9KVXhIZkV1ZEY1clMrSzZ6cTUzZHdXMlpF?=
 =?utf-8?B?L2dNYllYRGFCTk94MWFYWVFuck9YK0ZVUVlQMWNLK3MrVGhVdTJpdXorT1E3?=
 =?utf-8?B?emh3UE5ucFpGOWZqcnF0R0F5c212bWxwUGZvNy9KL09mdVBxcjFGU0JaVTVE?=
 =?utf-8?B?TmlxRkRsamN6NEh0WTIvSjJwVjNQYjkxQ2VnOFNCU1hPSGY4bWFvR2dlNEZi?=
 =?utf-8?B?ZFcxN2lqbkJ3dFFGMFBLMzM0Wm5BOXlyZkZvWHY4cGhxS3dsdmg1U0s4dUlU?=
 =?utf-8?B?RzNyc3NqRHBtNDhHTTRBMkNDMkg2TjV4MUpsb1lMMjNPdHRESmxQd3Bac0dM?=
 =?utf-8?B?dkF1YUhtMkVVYUpwTCtxeXdwd3QwdFlrK3R3am02dzd0QmZ5djNYcXVjTGpo?=
 =?utf-8?B?RFF1dEoxY1YyMnFBUXMwODZoU0ZTa1NMdUZudkxBR0U0QllNYklBZXVsYjlB?=
 =?utf-8?B?RW1RM3Q0aWNwdG5ya1BhRjRUdHhPdnlOSGdHZGVrRENSRzFHOFQ5M3NocEtU?=
 =?utf-8?B?UXJBc2FqQ2pQWXM5UnNtSnFsRzl1a0FuRTlLU3NHcGsvb0FGOTZRNDZySzJZ?=
 =?utf-8?B?aUdROGFneEVkRFFqL3NCcE42V094QmVoTTJkMnBZQWVlVGtLVHpjQ1dNN0Mv?=
 =?utf-8?B?alRDRXBra1ZyYmNBRXpmbCsraGx1TmRRaU1OekdLdktHYnNkSHJncWhLRUxD?=
 =?utf-8?B?U0FDRUpKNE40RnZhZEhIQUJ5RFhweHRNenRNaWErUjJHZkN5N29ZWk40T0xK?=
 =?utf-8?B?NzdmdmhuRGc2NmFHaEVrUzl1cTBhc2xPTFJzUzNMZ1dtWllaelE5M2tjd1Nj?=
 =?utf-8?B?N2FKK0VhS2VSYzJlV2lWOWs1WHF6WDUzZVR1cWdybXpXVW1hTHlOZDAvTEFo?=
 =?utf-8?B?bHpPQ3NHNC92WGM4Sk9mR1oraVZyNVg2aVlnZ2xLWjREZHdQSFVvWHNpaGQ2?=
 =?utf-8?B?R0tTNzYyOE1nU1ZZajR3bWdrQ0lNSWZYOVk2SFBVZ3YwSTBPbGw5L2lTTGZK?=
 =?utf-8?B?dG9kWk81QzQ0WDVPckRnVUZaNFhCWnhTSE9KNWc3UmE1TjlNSmE5c3FaVklP?=
 =?utf-8?B?dWZsZFN5NTNQU0d4MGZ0YjNwS1pUNjBIbjBsL2xyN0JuaWxsekNzR2JIY21U?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sbmyk4rFKSmSq1u5LsvTpVMaHjFgmIRrtIUgnWZQ/sTWdUhX3jvr0awCqFu8Ct7rfXen+aEtnxzZOH6Fy2Uj+bVmNjNBFQvJIVMys1/1b6UmReWhbs8UNQjHfd7DehnNJCJTHEFeRFKkIK3RAEiAYm0YFxvjHkrnCPLNOjqXPgXLRHV3/en9EluEsrCpWg5DP8CCYf6x8fsXnDPlMY8flGGIhEK1UTVSHdK7nXtQI+ooGE5v8hcuVmL2fKFbEb07tLXoFE1EgDIoHsqfLfOUpwnd7cuQHOdNzp4O3fUMlWDWVhTqxpLIE9AF5bV31Sp81cWbhPe+eGqAlnPjJE4oSjLLFFbY4MPL/4ho8rDDMVgqEMS2oGdCZV0PwVVkvI92brCL8mEm+Exx7yvgSxoznMgiLxRQdi8cu2Shk3NporXveaZuHgb19ApZrKEwibAem9rCDTYQQy1wLxHgN5Md+bQ9nz5PoRkYACVl0KQo1B5JyUavuuYZNSgC5ID5jVvJvUUKdUDvWmezZIYB60KGqznlFMLO/5lP5QkT1M6Tm5XyBxUOnJDOGUi65Z9EkYmRIbPLhTLtl8U861GePVMNFderKUVV0sg1yRs5fBacn/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1e7dbc-6d84-4364-12bd-08dc334b7bbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:10:47.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bmX5arLZds36u48hg6AEO/TXCYmeectAp25m+gMc4ID1jSvpIyzFRxtFD6a/dWzxCV6xdrC8onjfd8sr9ix2sFwjtLsZLtU7JS4fm4fnvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_10,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220015
X-Proofpoint-ORIG-GUID: Cu2DIczEwzt4BuHso0NCcFiCWrYlqHKj
X-Proofpoint-GUID: Cu2DIczEwzt4BuHso0NCcFiCWrYlqHKj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_181119_679975_675A2236 
X-CRM114-Status: GOOD (  22.37  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2/21/24 6:03 PM, 'Andrew Cooper' via trenchboot-devel wrote:
> On 15/02/2024 8:08 am, Ard Biesheuvel wrote:
>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>> +/*
>>> + * Primary SLR Table Header
> 
> I know it's just a comment, but SLR ought to be written in longhand here.

Will do, thanks. Ross.

> 
>>> + */
>>> +struct slr_table {
>>> +       u32 magic;
>>> +       u16 revision;
>>> +       u16 architecture;
>>> +       u32 size;
>>> +       u32 max_size;
>>> +       /* entries[] */
>>> +} __packed;
>> Packing this struct has no effect on the layout so better drop the
>> __packed here. If this table is part of a structure that can appear
>> misaligned in memory, better to pack the outer struct or deal with it
>> there in another way.
> 
> As you note, __packed does two things not one.
> 
> The consumer of the random integer that is expected to be a pointer to a
> struct lsr_table doesn't know whether it was invoked by a 16bit
> bootloader or a 32bit bootloader, and this really does make a difference
> for an ABI described only in C.
> 
> Then again, we're holding off on setting the spec in stone until there's
> an agreement in principle, so we could retrofit a statement about the
> expected alignment of this structure in memory.
> 
> The sane choices are either 8b alignment (there are uint64_t's in
> entires[], but I also see there are some misaligned uint64_t's too,
> which is dull), or using the good old x86 fallback or paragraph
> alignment just in case we really want to extend it with a uint128_t in
> future.
> 
> Thoughts?
> 
> ~Andrew
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
