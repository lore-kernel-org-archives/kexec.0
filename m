Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C21C77B73
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxMglqUDT9ujADn3iJkm3hwQGh3N6Heo4nBW6jGZ9bo=; b=ZVUP2cbpW/Aq4hiP2rZ+jxCsVP
	yJKsQ/N2kcXfJDxAgPhG7jQ6mkktrXNmj0XfizlA6yFfYzlUmTwJjVgE54cgeW+BYnMrHs1iQQnCn
	hVkFWPTsq3oPo190Y4VmUFVPt0RHlECSLKebhJIBNpfTXkXykeV/RhXforbAZw6wN1g6fIOVXz8Z1
	SwKCT+9kY/4vxqqOGaXr6gvGtz+aagVMGJ5KiwZ2A6gVqwFUU322i3ZtHYnLuJ7Vies5dB/lwpIK8
	bWBlK8TmEW/1eyK+I73Ow/85vzsVjD1wBYcMLyGVPsHGuLsS7d4EMdlFKf4bLf+kVvBC7YQOKg/pI
	LpWXnw2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptYRG-00GZAD-1z;
	Mon, 01 May 2023 18:39:54 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptYRC-00GZ8D-2P
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 18:39:52 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341HNwGt014500;
	Mon, 1 May 2023 18:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=ZxVePz72orG7CHZKIxpL8Za/AES6XtC+UNS9RORkQTj8nJCqEk93pYy2T44SwET7j3wp
 tQJJb+Vz7O7dxkVNHWkgiUBj8GTQe/8FpY8uL7mxQHtnPbGZMyHS9SUQDqAsyN/gPtqE
 RyrGZUxb0G5j88BrNWhCUYbVIQPO8L4pNu+j46ScAfP63HM1R3DeIMXNYgItigs4M2pX
 5Psp2ALSN2ytHhl1eaRZB8ceGOC47sS4YLVxyhx1ucJsCO8KdrdFPI+HOZzE336jxCOz
 2vnGQB5Q/hx7ZnoOng/Kw9XGYw3xP/XufSkmPWBcKaq48BEveJyDWqzhv5Ftppx8EEX9 mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9ctyp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 May 2023 18:34:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341Hpg4G017827;
	Mon, 1 May 2023 18:34:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4rqc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 May 2023 18:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG2NQ0uaEsNdX6Kjh8NDWkq7q3A5mFNo2wRNbdoPmOv5lk6DW3eL668jtSGlUxe1IRvKYabxZqmwAnNVVUjogByJUhmEZJGWjHRysRtjfjCmGKfQTADsEBZ5iEnWrJ/gPzXITSBtA7AX06knpxG1iixob/Gbr67pBbAm09yKSxiyahgJMmt0EDmm24eO1KmW6243yOocVMAZZNYEJ4AUOQ08KvDvoM3MB8MM23gYl96lUUEp6KZ77TZcM+bCH4r8VHmKDCdsepBqRx9moEB/vSgNajrw1p+4OUudmp0UnZwDkM8mxMfaPv4bYrV1X+6NiHuA8Qyryw5Lc7xvsxb7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=LGSZ4nM39fkWvzxM3ix47G3S8xv2uFxdaCjLV7abszI70b8ShXv/bOQ4cXWI0geCUuPHgMqgLj+Py2oSmIZr0cSwlZWZlKHZcNHQdK0k4D7RG3O00muz/czosn2+vA2ve5W/hSy+rf6TXhEZfNHQHsBcSZAx++OKCJ7SGeV3EMwGTo8iwmnisRfKPu/LtP8AAbnsoJa6+ytVoEihhyhdtdwQxBLIDs97WsivBVAlF5Bm2mQpq9YkZMNwQTeUs2aBOTBworPO8IFl1nWqfBbMzStXLhl54YRV0M+bxIJ4CYdCedqPTc44Jz3urG1ZgBK8Ipj9ARAGAAnY2jLOfs4jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUciHKk5sopbGTQXwbPpOYAfTyb6mIwDngZnNVm8zks=;
 b=XVyljraJjgyUU8+EB18xe6fzuIQy2c+SopLzlVgLpZreTVc7eT58txt2okYg5cpT8yZWS9jVg2VnrrGyYao+zgsfVSN5Yli4tQfo1sordyda9db7hd/jTcL7lIzYqYjMkQKxq6cXHeqA9FTP3rAeJObbMG8LmFORA0GoX0kPoEo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Mon, 1 May
 2023 18:34:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6340.024; Mon, 1 May 2023
 18:34:22 +0000
Message-ID: <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
Date: Mon, 1 May 2023 13:33:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To: Hari Bathini <hbathini@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
 <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
 <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
 <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 297304b5-e03f-4a5d-c8bc-08db4a72aee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/eddW3MzNVjY3IMwXxqhxo1okmMoFCXljmvbYdNXndXsI9hZYlwTMa8Ypd5kObMJ70JXUueV75fPngCrYUd26XDTuSYRjLrl9MCne0OObCUdW5AbzCp2yR6EDN3LDaOH/cTh6j12TMGNMvSg58Bki59HSXblM9vFqksf2CcVvBXdeF+xkASvE9hSTQgNBDDt1nkZdHUFCpTOBUdykYPxj2KBcv1fbTQscg9x/7ZSS5Tdaz0nCKJWYdQmKIboU+94eht8zo6GQuZ92dK35NtuJssiMUtd+hHyumaddbDI3DMifecaEexnYQvyZmM18mOxz/+FOGBUw99Fx2fquV22sw1Ge231fa6m79fRztxvr7b63VelPn5HAfAixDWCZFpNPBEH2Hx8OR02zR4el4Djtf0vF6hDROLkf+ZfBotgUQBe+62Mxg9CAQQF1Qr8uivqe9RUvRkhJ/bWpKNZZvWv+OQGF8J6uX4UrwnPnLf+5VH7CknQEEEV+2052jSxcWLDcptTK7Iu+8jeuN9bqnMFMNiv8XjhRIaWSyCFI1b+kwvklcSyra/qTnCDCLwXAgZh6hL1kY4P0bMjwoiVsgy0byY+iYPGJPW1uAozdpH3zn+hTa/HzZ7js7PCWq1ty56UZYM03q73sRGvm2QBx3n2ZQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(31686004)(316002)(2616005)(53546011)(6512007)(4326008)(6506007)(8936002)(7416002)(8676002)(31696002)(86362001)(5660300002)(186003)(478600001)(66946007)(26005)(110136005)(83380400001)(41300700001)(2906002)(36756003)(107886003)(38100700002)(66556008)(6486002)(966005)(66476007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cHA5cEZpcWhxY2pTNEFteG11ZVB2NkpreDdZWnhJRFNoRUwwRVF1OFo1dnQz?=
 =?utf-8?B?K0VWN0JCZDZzRjJDWmk0SHZoVnp6dXdWSHM4MkhqbzdMRDZJczNiK1Z1Qy9r?=
 =?utf-8?B?MEQ5S211c2ZtZUI4MmZrSDR1KzJwMFJ3UTNJOGR2MmdQeDBhSzFkc2c2Zk5H?=
 =?utf-8?B?Q21uRTRhTWtSazFGMDBrQ0xjcmhqZGw4VGJnWnYxMUlNMHJmMTg4SjhBejBh?=
 =?utf-8?B?OUQ2ditDQXhodEZZTmR5UVNHYTVKWHJBTTZQYVF1b005Q3ViMll4aGNjQk1w?=
 =?utf-8?B?cDBKOWQrRmRVYjNwSjBqcGxHVkw1MWJzUklrNGVrRm1POHJFVlVELzJQelN1?=
 =?utf-8?B?WnFma0dFRVBRZ2lzQjJUcGtTUmVZN1NYNC9lM0dIaFYwcmd3TTBaRXE2V0o0?=
 =?utf-8?B?dHh0QVJRZlhvbzM4YjRGYVFGM2dGQnBDQldHMXBHdE5kZWh5SnUyb1MzZVdQ?=
 =?utf-8?B?bkhRR3Jadk5MUm9ieDh3bkRkTUdvQkJjK05aOTc5dXIxWVhFc1hYZHhMNndO?=
 =?utf-8?B?OGh0dEdVb3hmUVUvSEZscGRpRkhUZWk2TGNUQVFINlc0STNaeDdtVllGbGZQ?=
 =?utf-8?B?bzl1bHptSGtjb0JOUGRsQitvOC82MjI3QXdiMi9BS2IrTEhjUS8zSmR5eXhW?=
 =?utf-8?B?Skd5YVBlcHJZb0FYRVhTaE9WZjN5bHczejNOaUZNUVloRG8zUUFmL1NKQjVv?=
 =?utf-8?B?SnpUeHV2dmYxMUpvWW5mWFpDU2tlNW1oY3JmNzArZ0Nsc0UvOGlvblB4Ym5h?=
 =?utf-8?B?cjlPbWtPdTVUNnVibmdoS05XTTJSb1dPYUI4T1d4RG5vQnpEZUZvN2tINlRT?=
 =?utf-8?B?M3RTQ1B1V0dqOEE5RnpIQXg4STVCQWU4OGZ5VFVkaVhEZWFrVTgreDA4ZjJa?=
 =?utf-8?B?b1pISEE0a0dZb3VSYnVYeHFoU1F6YmJpcUh2dTRPM2FUR1JEN29KSlp5S1NK?=
 =?utf-8?B?M3M0RkpqS00xaE5xNVFvZ2ZwNFpRQ1pKMG5uRmdFajV0Sk5kWG53ZVU1WHdi?=
 =?utf-8?B?aXpXalpPanV0TDNhcytjWFJ3YzMwYnMrdW4zV0xrcnB0T2UvSE5qak5KeWZV?=
 =?utf-8?B?bDB0Smd0aCthZ0tONWx3d2lqazlpd3VYWldPRElDaCtaMFdSWDc4c0d4NXFM?=
 =?utf-8?B?VUs0cjJmbHFxME1xVGRlMHNlZm5wZTZiTlZHVjB6aUdTclZSMTNEY2NheXVw?=
 =?utf-8?B?aDZjcENZZGdwMTZOTHllaldYME1ZdzFmYWVhMVpVemRtcDdZM3NEVEZzcng0?=
 =?utf-8?B?VzNqdEJTdjBub1RPL2F0ZVNIU2h6QmcwWHppWVc0M1pVamkwK1VJOVpEendS?=
 =?utf-8?B?dFY5OC9UcTZoeU15akFkem9YQjlRS3l1bWRmRlllK3hlVWY0RktwU3RPU1Iz?=
 =?utf-8?B?WUpIL0ZEUjNqOG5EMVZsSEFNR2FqMGpqNG4wZk5DSTJxWjB4OFRod05iYnRm?=
 =?utf-8?B?dG1uQmRwMU9ibDNwYklYWlpPSXVoRk5kaGs2WWllUlVXUGlnMytYb2phdzE1?=
 =?utf-8?B?L24xaG91dVBBM3RyK2V2RjVyRER5UHgvU1cxTXljNkkrY20vZ3FsQ0VhNkIy?=
 =?utf-8?B?RWNMM2ZzOHhqWENzV28rMTBDclowQUtvZ1l5cHY5alFIRnJYUzhnZWJtbEM2?=
 =?utf-8?B?VnB5SlZFUy9KT1l3Y0prbFpHejU2bDFhQUkxV2Uyc2RiQ3ZwWm9Gb1l0U1p3?=
 =?utf-8?B?RHgzMzlXaWZhaXBGZ09BaGxheEFsTXp1cTRHaWZ6TURmc2luVDE4UUlqdlVG?=
 =?utf-8?B?eC9RRVlHcitxMjFTRjdRM09IdjlndjBLMmZMN2RjUHNCMjBxOGQ4dUpKT29n?=
 =?utf-8?B?RFBaaVJqNk9SZUxuQjdrZEFhd1AraXFTanlsenFHZXpvNjJQZXNQQmg1Y0F5?=
 =?utf-8?B?WUpKWU81eHFDbmRHS2xBVjJ1TG5nTnJHK3p2L1pFMkI0aHV3c2N3bEVxRkd3?=
 =?utf-8?B?VkQrRGtidUE0Q3V3dkE2OTJ6clhidUEwZ0RYTUtyeC9scWRCczlaYWZmemJY?=
 =?utf-8?B?MzhrNTlPUFhERTFMYUsremExdEx0YmtWMVVPdjRGZzdiTWhxNUxkeHpIckRU?=
 =?utf-8?B?VU9ONkU2bSszejBDZ293VWFkZHlvNXE1TFpaTDFMSG80YWlkVDRBM1NESXQ1?=
 =?utf-8?Q?ltbKd/dpsGNB0ich08ld6Pg+1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?TUJKN28xVlJFKzlwbUl3ZmhpdWlERjNOK0tQSFZOUlNoeDdXTkQwMXlSVGx6?=
 =?utf-8?B?aDYvbHcvRGxjR1YrVWhnakNtOXU4bkx5bERaZlI3VHpLT0Y1ZzJIYzBycWhv?=
 =?utf-8?B?cWh4bEZiSjNBTDIxZStTUDBUQnFVZ2ZTd21mZ1BEUmVnYzV0akh5YTRtZ0h5?=
 =?utf-8?B?SmRBYmZ3WWVJVHVsK1RiQ3dCLzQ4cWQ3TGNnM1d4SDNXRDFBSFZTekdvUTk4?=
 =?utf-8?B?dGhVZGtUSC9ZWFJXNnB1UEdpZHRsZ1F2ZVFVVGs5ZmV6dG5PU1RCeFh3Q1Vv?=
 =?utf-8?B?L2F3NFErVW9iVHQvbHk5V0JvSE1aRElRWms0SEREZXhVa1Y4aXJQSFJGSE1B?=
 =?utf-8?B?amplVmtQTnZJQjZZRGdxZjV2elFXekZaKzUyQXRKbUQ2M3crRENhdFBZVTdn?=
 =?utf-8?B?ellacXJoaVNybTQxZUh2YzErTFE5YVlKQW0wSlIrZElkN281NmNVVHJyZGty?=
 =?utf-8?B?SXZlWlJXOURid1REMXRhVTFhWFFWVnFJL0hkdTZtWlNkVXhjbVNxSVcxOXN2?=
 =?utf-8?B?dVdSNmoyN21NNXpEK2w3c3VVNndRRGlId2gzc3lUem5mNXpsM2xpYk5yUmVy?=
 =?utf-8?B?enNaN1daOVl0U0ZyelZycVF4VXhQaVltTFNLUW96THFrOUluMkhDMlZGSlNC?=
 =?utf-8?B?M28rZ2JvUWdJQlFRa2RQUEd0dUFDSUVHMGdkejNpVWY3NnB0bllOT1hJRWd5?=
 =?utf-8?B?TGFlSjRvbnA2RzBEbGFkQmlUUWRNbk9maDJiajBML3V4eG9HOGFUWkNrc05X?=
 =?utf-8?B?Z3kvalFJVWcweTYvcUYzSVlLaGVwQlRDLzN1ZnlPcUJiL21BMnRFV1BRc1d5?=
 =?utf-8?B?V2Y5WTQ3YXVPN0psWldxTFc4WjNqRGJKcktzeU1wTEhSMFVYYU9lTWRBTzBi?=
 =?utf-8?B?cWpJUnI4Rk4yMXFIeTJDbE9CSjBwT0tYRzFzNXl2SGV6ZGY0amdPQ3JkRk96?=
 =?utf-8?B?dGc4TTdFbzAvcDNMRWQvNEpPZ0VmR1Y5VW82ZWdRUnJoN3duMmRObDdWNWNx?=
 =?utf-8?B?QVBGbE1jTHhmL25FeS9KVEkvSW5YcXBrRmlvS3RMYVdBSENUTXRWcnlGUDhF?=
 =?utf-8?B?RUZTL0FVUDhlTC9vdlFJTUtwVVMvdjM0ZzVWdlVmVjMvQ0FxVGxsMkpIQkE0?=
 =?utf-8?B?ZmRuUFRvRW1KM2NlZ1Nzbm1xeEcwbERvNStMVW45cVIxVFhHTFI4UzRHOER6?=
 =?utf-8?B?NXp0QmI4ZUgxTWJoQ2JnT0JDNGRsTFlWRzB1K2U4RjhSRFdYSElJUmZUMzFH?=
 =?utf-8?B?dDdHendDTUJDcjF3T3ppczlZMUxtbXFiVGNiVVZ3UzBvUURKWDNic0hOYVgv?=
 =?utf-8?B?Z0RabW9sWms4VktuYjdTczkxR0UyaHRQTmRoWW5mUDNhcHVpckx3b2dMdFlj?=
 =?utf-8?B?NzJlQjJPQlFZY01FTlhlaGM2STZ2NGI1SWJUZkx0WEZadGYzQitQTlo1VU80?=
 =?utf-8?B?dDBOKzVzWEUzbW9XNmM2c2lDK3BKOVNOT0VGVkExSk9FZ2ViczR4OVpPeHM5?=
 =?utf-8?B?QWc4cWZranpaMGtDVUJJTzlVZEZHMEdxWVNSOTNyOG91QWd3R1JVWDVVSW9F?=
 =?utf-8?Q?xCl5I9VWT7vBkFss+POa0wA28=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297304b5-e03f-4a5d-c8bc-08db4a72aee9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:34:22.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHv7RLmPx8mPdApSSl4HHb9X1/1GQn4yBWM1QWBksijz2VFhVkP3GCqg9YJGZ8e0dQeeHLr4adjRHf53K1dA2iP8pd2C2PsuboPUGt/+4Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010152
X-Proofpoint-GUID: AAsiutRZy5QT-yVB_VmZwFivokAFNEWw
X-Proofpoint-ORIG-GUID: AAsiutRZy5QT-yVB_VmZwFivokAFNEWw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_113950_921143_6078B31F 
X-CRM114-Status: GOOD (  19.12  )
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

CgpPbiA0LzI4LzIzIDEzOjMxLCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4gCj4gT24gMjgvMDQvMjMg
Mjo1NSBwbSwgQmFvcXVhbiBIZSB3cm90ZToKPj4gT24gMDQvMjcvMjMgYXQgMTA6MjZwbSwgSGFy
aSBCYXRoaW5pIHdyb3RlOgo+Pj4gT24gMjcvMDQvMjMgMjoxOSBwbSwgQmFvcXVhbiBIZSB3cm90
ZToKPj4+PiBPbiAwNC8yNy8yMyBhdCAxMjozOXBtLCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4+Pj4+
IEhpIEVyaWMsCj4+Pj4+Cj4+Pj4+IE9uIDA0LzA0LzIzIDExOjMzIHBtLCBFcmljIERlVm9sZGVy
IHdyb3RlOgo+Pj4+Pj4gV2hlbiBDUFUgb3IgbWVtb3J5IGlzIGhvdCB1bi9wbHVnZ2VkLCBvciBv
ZmYvb25saW5lZCwgdGhlIGNyYXNoCj4+Pj4+PiBlbGZjb3JlaGRyLCB3aGljaCBkZXNjcmliZXMg
dGhlIENQVXMgYW5kIG1lbW9yeSBpbiB0aGUgc3lzdGVtLAo+Pj4+Pj4gbXVzdCBhbHNvIGJlIHVw
ZGF0ZWQuCj4+Pj4+Pgo+Pj4+Pj4gVGhlIHNlZ21lbnQgY29udGFpbmluZyB0aGUgZWxmY29yZWhk
ciBpcyBpZGVudGlmaWVkIGF0IHJ1bi10aW1lCj4+Pj4+PiBpbiBjcmFzaF9jb3JlOmNyYXNoX2hh
bmRsZV9ob3RwbHVnX2V2ZW50KCksIHdoaWNoIHdvcmtzIGZvciBib3RoCj4+Pj4+PiB0aGUga2V4
ZWNfbG9hZCgpIGFuZCBrZXhlY19maWxlX2xvYWQoKSBzeXNjYWxscy4gQSBuZXcgZWxmY29yZWhk
cgo+Pj4+Pj4gaXMgZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBDUFVzIGFuZCBtZW1vcnkg
aW50byBhIGJ1ZmZlciwKPj4+Pj4+IGFuZCB0aGVuIGluc3RhbGxlZCBvdmVyIHRoZSB0b3Agb2Yg
dGhlIGV4aXN0aW5nIGVsZmNvcmVoZHIuCj4+Pj4+Pgo+Pj4+Pj4gSW4gdGhlIHBhdGNoICdrZXhl
YzogZXhjbHVkZSBlbGZjb3JlaGRyIGZyb20gdGhlIHNlZ21lbnQgZGlnZXN0Jwo+Pj4+Pj4gdGhl
IG5lZWQgdG8gdXBkYXRlIHB1cmdhdG9yeSBkdWUgdG8gdGhlIGNoYW5nZSBpbiBlbGZjb3JlaGRy
IHdhcwo+Pj4+Pj4gZWxpbWluYXRlZC7CoCBBcyBhIHJlc3VsdCwgbm8gY2hhbmdlcyB0byBwdXJn
YXRvcnkgb3IgYm9vdF9wYXJhbXMKPj4+Pj4+IChhcyB0aGUgZWxmY29yZWhkcj0ga2VybmVsIGNv
bW1hbmQgbGluZSBwYXJhbWV0ZXIgcG9pbnRlcgo+Pj4+Pj4gcmVtYWlucyB1bmNoYW5nZWQgYW5k
IGNvcnJlY3QpIGFyZSBuZWVkZWQsIGp1c3QgZWxmY29yZWhkci4KPj4+Pj4+Cj4+Pj4+PiBUbyBh
Y2NvbW1vZGF0ZSBhIGdyb3dpbmcgbnVtYmVyIG9mIHJlc291cmNlcyB2aWEgaG90cGx1ZywgdGhl
Cj4+Pj4+PiBlbGZjb3JlaGRyIHNlZ21lbnQgbXVzdCBiZSBzdWZmaWNpZW50bHkgbGFyZ2UgZW5v
dWdoIHRvIGFjY29tbW9kYXRlCj4+Pj4+PiBjaGFuZ2VzLCBzZWUgdGhlIENSQVNIX01BWF9NRU1P
UllfUkFOR0VTIGRlc2NyaXB0aW9uLiBUaGlzIGlzIHVzZWQKPj4+Pj4+IG9ubHkgb24gdGhlIGtl
eGVjX2ZpbGVfbG9hZCgpIHN5c2NhbGw7IGZvciBrZXhlY19sb2FkKCkgdXNlcnNwYWNlCj4+Pj4+
PiB3aWxsIG5lZWQgdG8gc2l6ZSB0aGUgc2VnbWVudCBzaW1pbGFybHkuCj4+Pj4+Pgo+Pj4+Pj4g
VG8gYWNjb21tb2RhdGUga2V4ZWNfbG9hZCgpIHN5c2NhbGwgaW4gdGhlIGFic2VuY2Ugb2YKPj4+
Pj4KPj4+Pj4gRmlyc3RseSwgdGhhbmtzISBUaGlzIHNlcmllcyBpcyBhIG5pY2UgaW1wcm92ZW1l
bnQgdG8ga2R1bXAgc3VwcG9ydAo+Pj4+PiBpbiBob3RwbHVnIGVudmlyb25tZW50LgpUaGFuayB5
b3UhCgo+Pj4+Pgo+Pj4+PiBPbmUgY29uY2VybiB0aG91Z2ggaXMgdGhhdCB0aGlzIGNoYW5nZSBh
c3N1bWVzIGNvcnJlc3BvbmRpbmcgc3VwcG9ydAo+Pj4+PiBpbiBrZXhlYy10b29scy4gV2l0aG91
dCB0aGF0IHN1cHBvcnQga2V4ZWNfbG9hZCB3b3VsZCBmYWlsIHRvIGJvb3QKPj4+Pj4gd2l0aCBk
aWdlc3QgdmVyaWZpY2F0aW9uIGZhaWx1cmUsIGlpdWMuCgpZZXMsIHlvdSd2ZSBjb3JyZWN0bHkg
aWRlbnRpZmllZCB0aGF0IGlmIGEgaG90cGx1ZyBjaGFuZ2Ugb2NjdXJzIGZvbGxvd2luZyBrZXhl
Y19sb2FkCihtYWRlIHdpdGgga2V4ZWMtdG9vbHMgdW5hbHRlcmVkIGZvciBob3RwbHVnKSwgdGhl
biBhIHN1YnNlcXVlbnQgcGFuaWMgd291bGQgaW4gZmFjdApmYWlsIHRoZSBwdXJnYXRvcnkgZGln
ZXN0IHZlcmlmaWNhdGlvbiwgYW5kICBrZHVtcCB3b3VsZCBub3QgaGFwcGVuLgoKPj4+Pgo+Pj4+
IEVyaWMgaGFzIHBvc3RlZCBwYXRjaHNldCB0byBtb2RpZnkga2V4ZWNfdG9vbHMgdG8gc3VwcG9y
dCB0aGF0LCBwbGVhc2UKPj4+PiBzZWUgdGhlIGxpbmsgRXJpYyBwYXN0ZWQgaW4gdGhlIGNvdmVy
IGxldHRlci4KPj4+Pgo+Pj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9r
ZXhlYy8yMDIyLU9jdG9iZXIvMDI2MDMyLmh0bWwKPj4+Cj4+PiBSaWdodCwgQmFvcXVhbi4KPj4+
Cj4+PiBJIGRpZCBzZWUgdGhhdCBhbmQgaWYgSSByZWFkIHRoZSBjb2RlIGNvcnJlY3RseSwgd2l0
aG91dCB0aGF0IHBhdGNoc2V0Cj4+PiBrZXhlY19sb2FkIHdvdWxkIGZhaWwuIE5vdCB3aXRoIGFu
IGV4cGxpY2l0IGVycm9yIHRoYXQgaG90cGx1ZyBzdXBwb3J0Cj4+PiBpcyBtaXNzaW5nIG9yIHN1
Y2ggYnV0IGl0IHdvdWxkIHNpbXBseSBmYWlsIHRvIGJvb3QgaW50byBjYXB0dXJlIGtlcm5lbAo+
Pj4gd2l0aCBkaWdlc3QgdmVyaWZpY2F0aW9uIGZhaWx1cmUuClRoaXMgaXMgY29ycmVjdC4KCj4+
Pgo+Pj4gTXkgc3VnZ2VzdGlvbiB3YXMgdG8gYXZvaWQgdGhhdCB1c2Vyc3BhY2UgdG9vbCBicmVh
a2FnZSBmb3Igb2xkZXIKPj4+IGtleGVjLXRvb2xzIHZlcnNpb24gYnkgaW50cm9kdWNpbmcgYSBu
ZXcga2V4ZWMgZmxhZyB0aGF0IGNhbiB0ZWxsCj4+PiBrZXJuZWwgdGhhdCBrZXhlYy10b29scyBp
cyByZWFkeSB0byB1c2UgdGhpcyBpbi1rZXJuZWwgdXBkYXRlIHN1cHBvcnQuCj4+PiBTbywgaWYg
a2V4ZWNfbG9hZCBoYXBwZW5zIHdpdGhvdXQgdGhlIGZsYWcsIGF2b2lkIGRvaW5nIGFuIGluLWtl
cm5lbAo+Pj4gdXBkYXRlIG9uIGhvdHBsdWcuIEkgaG9wZSB0aGF0IGNsZWFycyB0aGUgY29uZnVz
aW9uLgo+Pgo+PiBZZWFoLCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4gSXQgbWF5IGJlIGV4dGVu
ZGVkIGluIGxhdGVyIHBhdGNoLgo+IAo+IEZpeGluZyBpdCBpbiB0aGlzIHNlcmllcyBpdHNlbGYg
d291bGQgYmUgYSBjbGVhbmVyIHdheSwgSSBndWVzcy4KCllvdSdyZSBzdWdnZXN0aW9uIG9mIHVz
aW5nIGEgZmxhZyBtYWtlcyBhbG90IG9mIHNlbnNlOyBpdCBpcyBhbiBpbmRpY2F0aW9uCnRvIHRo
ZSBrZXJuZWwgdGhhdCBpdCBpcyB2YWxpZC9va2F5IHRvIG1vZGlmeSB0aGUga2V4ZWNfbG9hZCBl
bGZjb3JlaGRyLgpPbmx5IGtleGVjLXRvb2xzIHRoYXQgdW5kZXJzdGFuZHMgdGhpcyAobWVhbmlu
ZyB0aGUgZWxmY29yZWhkciBidWZmZXIgaXMKYXBwcm9wcmlhdGVseSBzaXplZCAqYW5kKiBleGNs
dWRlcyB0aGUgZWxmY29yZWhkciBmcm9tIHRoZSBwdXJnYXRvcnkgY2hlY2spCndvdWxkIHNldCB0
aGF0IGZsYWcuCgpUaGUgcm9sbC1vdXQgb2YgdGhpcyBmZWF0dXJlIG5lZWRzIHRvIGJlIGNvb3Jk
aW5hdGVkLCBubyBkb3VidC4gVGhlcmUgYXJlIHRocmVlCnBpZWNlcyB0byB0aGlzIHB1enpsZTog
dGhpcyBrZXJuZWwgc2VyaWVzLCB0aGUgdWRldiBydWxlIGNoYW5nZXMsIGFuZCB0aGUgY2hhbmdl
cwp0byBrZXhlYy10b29scyBmb3Iga2V4ZWNfbG9hZC4KCkkgY29uc2lkZXIgdGhlIHVkZXYgcnVs
ZSBjaGFuZ2VzIGNyaXRpY2FsIHRvIG1ha2luZyB0aGlzIGZlYXR1cmUgd29yayBlZmZpY2llbnRs
eS4KSSBhbHNvIHRoaW5rIHRoYXQgZGVwbG95aW5nIHRoZSB1ZGV2IHJ1bGVzIGltbWVkaWF0ZWx5
IGlzIGRvYWJsZSBzaW5jZSBub3RoaW5nCnJlZmVyZW5jZXMgdGhlbSwgeWV0OyB0aGV5IHdvdWxk
IGJlIE5PUHMuIEFuZCB0aGV5IHdvdWxkIGJlIGluIHBsYWNlIHdoZW4gdGhlCmtlcm5lbCBhbmQv
b3Iga2V4ZWMtdG9vbCBjaGFuZ2VzIGRlcGxveS4KCkhvd2V2ZXIsIHlvdXIgcG9pbnQgYWJvdXQg
c3VwcG9ydGluZyBrZXhlY19sb2FkIHdpdGggYW5kIHdpdGhvdXQgdGhpcyBuZXcgZmxhZwptZWFu
cyB0aGUgc3lzZnMgbm9kZXMgdXBvbiB3aGljaCB0aGUgdWRldiBydWxlIGNoYW5nZSByZWx5IG5l
ZWQgdG8gYmUgYSBiaXQKc21hcnRlciBub3cuIChJJ20gYXNzdW1pbmcgdGhlc2UgdWRldiBydWxl
cyB3aWxsIGJlIGdlbmVyYWxseSBhY2NlcHRlZCBhcy1pcywKYXMgdGhleSBhcmUgc2ltcGxlIGFu
ZCBlZmZpY2llbnQuKQoKVGhlIHN5c2ZzIGNyYXNoX2hvdHBsdWcgbm9kZXMgbmVlZCB0byB0YWtl
IGludG8gYWNjb3VudCBrZXhlY19maWxlX2xvYWQgdnMKKGtleGVjX2xvYWQgJiYgbmV3X2ZsYWcp
LiBHZW5lcmFsbHkgc3BlYWtpbmcgdGhlc2UgY3Jhc2hfaG90cGx1ZyBzeXNmcyBub2RlcyB3ZQp3
YW50IHRvIGJlIDEgZ29pbmcgZm9yd2FyZCwgYnV0IHdoZXJlIGtleGVjX2xvYWQva2V4ZWMtdG9v
bHMgaXMgb2xkZXIgYW5kL29yIG5vIG5ld19mbGFnLAppdCBuZWVkcyB0byBiZSAwLiBJbiB0aGlz
IHdheSB0aGUgdWRldiBydWxlcyBjYW4gcmVtYWluIGFzIHByb3Bvc2VkIGFuZCB3b3JrIHByb3Bl
cmx5CmZvciBrZXhlY19maWxlX2xvYWQgYW5kIGJvdGggZmxhdm9ycyBvZiBrZXhlY19sb2FkLgoK
R29vZCBjYXRjaCEgSSdsbCBwb3N0IHYyMiBzb29uLgoKRXJpYwoKPiAKPiBUaGFua3MKPiBIYXJp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
