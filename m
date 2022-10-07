Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB891C433FE
	for <kexec@archiver.kernel.org>; Fri,  7 Oct 2022 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XK0a4SZdV1YyCRU4rFZHBeZvZSLsDstfP/QTPl8Ot/I=; b=f4naVJcDz932fIM7HLflX4qxcg
	7BsciISWTAFsTj31sPSQ5Q5YBR9VWBIqeag3JcHeuzWLwkdR705r5WJnCk6u7Ebfnu01DA+GWJphs
	Vg1m2c+ACpjeLMIGi9TpfVQQd3t+JbD3DBnfeEic2jf0j5/RXJ6+R0ABRdz8GCpKfyGwh/8CFduT8
	1/V32WDutL/hxm2RvjfCjyD+GMW8CweSwHrV05OQZ3MEVMdrb6b/OD8Cr8EN7DAscvzt7VsOB1/C2
	jBe8/9Kw87TL76zUqIHns2JTX7jVvsI0ftZLkNtYZcJXZirgTymyyED2DbIvLdEpvVsX9BTQ0km+F
	tfv++5/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogtXC-00AIbJ-Ah; Fri, 07 Oct 2022 20:01:26 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogtX8-00AIaS-S1
	for kexec@lists.infradead.org; Fri, 07 Oct 2022 20:01:25 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HsUP4023379;
	Fri, 7 Oct 2022 20:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=guFjcVgKntg/5oqJwosGHu6mk2H35Gf6Ywr/Ddh2ca44bSjtEPh/gZdbfxUjb4ZWrugl
 wyJwOn7anHrlOgiJTky0PncuR3Wd6NSZFTqfrPyNoWYtexCeiRBf76zNYxE29Za4mnUp
 6ghpu5eT+/e2RbCa/j150kTedLgg6yqF1Ghi57l89YV4aejx6/vslsCa9S4lCXWcTRHH
 OafxZXbI0yMgLSrmLs4seyAxWPBmlqylr+U00s67aWQDYfrqPz6AG/1yPL3RzlsaITy1
 qpOZgbfAQuK9apBcNmQtpN0al5oFqMvEmAGkx6xwCaBzBa+QWqhU3M+hcXGepJ2p0Q1u YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0fbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 20:01:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297H0SsJ000896;
	Fri, 7 Oct 2022 20:01:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc074ru4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 20:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUh+0MO7fpedtMbRvENvSpEo4NwTQY2MQeIxzdTzqigjUoq/g2YJ9+Qcq/2uvtgdNxdgoRi72agGXAlsX5q1KiNHOWmDLjy6FKtU+dTkOGFh6GMDx0Pklp1/dxmYqjKiSzxeY61iO42nC3XDeuMLIQl5kRoKlf4RRN2oePV9OGekjurlhL1XDIo94rfz9P6B+Vc4r6sAote+M8Z7XcPdTpcrmb9grbLkQgv+qZ8tHqjTZ66z+MJ1aF87NdtHujrEHKk5+EssyqANiWAdxVVYa0Q0pw4XitN7/4pR66yz0e3l5S+icfQndWGGguJAf8wS0Y8fduy3V2/AXVDNTxbqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=oDwc715gwnJSJ2qsIabrd05v/YTGODO/aDKMgdKVXeR/36OvDL0d1oTFInMLcp9TbHFSsDPX9N6kOGm/5VbTKPjTBCsAaERIqvsggPsZLO7zvy3V0G0hcxzSIlbu5w/KbYnwycC5EkI+KcaaQGP+WRYaVY2fL8FLM3nkBRvU+JmQdAucU60ZR2Pj8+F/gyXUCnJpxo347+mzCJkdNcEadrWDxtst+dBDleN38mfblHoCxEjcaqvft9AqKb00vkzl55rDy7jS/tboQQtqFSGv7+GxQ0Qa89ElpfFW67/5k3cAn+8Hei7wYPUXbygEHeHs7TGiwQs7MmPv0BEDWlbh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=jodJyFv/Q3CIyNPmJsZy7cuhezWC6NaShoF0Y3Sq0MOVbBS6Zat0z7o51VqnyYQ/FqD3lI8zqlpbmaT8WHOThMjFnSw7xBq6h8uiAp0z9TrhkJEbShN1sBkluBhoK9HGru76S2IVDTT3ZDea3WSiHLjbng+/0TqrMRct52QOQVE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 20:01:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 20:01:00 +0000
Message-ID: <915f05fd-dbbc-e012-e3d2-e40ca13d4728@oracle.com>
Date: Fri, 7 Oct 2022 15:00:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5d9b6-fe53-4d69-4a83-08daa89ea821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	qd37XgACDB80bSGeOtxAYurO6LbPUdrLNsCXpjmJHIxaI8XibOX9jLrgGdCntsxkvJxaVSr6nTLV3XaR33BV+YKiUddhfy8thnKfir/lIzMpIypZFh1mep5GyzO29tyQ7cuJh/+CXamVNORuiD3gOXWfimQYEG/4AfNNLUHMAOdHwYpXnXMU/ChpjCFYbElanZXFLiZM4WUkMT4v3DoNNkOS3sJWfe8dwErnRtU6GotZF/MbV2VelQ8wU6uKz1hR+UBXwAeoKtFhsWgjowF8wznjYfagzC3ZG87BbB5HSjAr4/rE/Zf0bLoMM7SbPFj24FIrR7oqakFnZEnNct0z/PlTmzqxGBMTElxTEjyfTFUXEG8+AHewx4KieviHFULRWBXO/jAeKCAt3gFShqg6/MSmlcibiDMoE0NQxmLjBBmup/XzLCEuPY13UMUaTV6sYVqUZlRdGipKVVTL/EiCgaHQ0rn2AmJtIo1OKd9ReEJc8c+ams4Lt4jUFYj5P9ZnymJNGg3mhYWjq7/uU92BRfcY93ps9JR4Zec7MsLQXdbHOlVJ7P7Xt5wbPM2VPf4RNPLGW08+N06Mq7qqOSbCEfd/05YAHJTanBDQN6m08pSIYcX66BJDXzaWePWudJMGf1p9/lJhXNDEZTkkti6zS0r315xPC+U1LsheXHJgsMW3LAk18wEArLQbHA2xCbygwK70QiWNniGwBaxj57wNkVRe79vuOhHN8E4RqKyKDSj8CqVwpSy9qSzMko8NixGKFNxllyYMLQ36vf0+TceQ2ZfWmkiRcfcscur5VA+uMG22T0ngfuMlYzqDAtvprWPSktRJCXffXflOotj3haffYhcUvskiu6mAyK5OZnEcZPE=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(36756003)(38100700002)(86362001)(31696002)(66946007)(66476007)(66556008)(8676002)(4326008)(316002)(2906002)(41300700001)(2616005)(5660300002)(7416002)(8936002)(186003)(83380400001)(107886003)(6666004)(6486002)(966005)(6512007)(110136005)(6506007)(31686004)(53546011)(478600001)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?bzBObVpHUG42MVBiQnVCdHVyMXNFRFU5S1YwQTJaTkhTOFhUYWdIVzk1TnpD?=
 =?utf-8?B?TWNZcXFEcXhCVE1iRXVvWUNQMEF3bGpnSFpEWUhlSVJobGIwREF1SmFBeVgz?=
 =?utf-8?B?MWZMK2x1OVEyc3ZjRU5iLzBud250UUFKdC92VUZZWlE4OWxXM0NYMEZVUWVu?=
 =?utf-8?B?LzhjRmplTHJOdTdRdVRYaEh2Uk0xMVllQnZPZEFZMkFCcXF2dE95QVlKT2U5?=
 =?utf-8?B?RENGTldpWWYyQzFnNUFjZHI4Z1pDOElKT1ZlWEFHRjVkbnlHcXZYRWZHR0tT?=
 =?utf-8?B?ZXNjcEQrTHZVa0EybXJCbkpRbXRPQWJ5NWJOcjlndDVvdFUvcGZDeFloYXRM?=
 =?utf-8?B?V3FWZmJseFVuU1h6WkFMY2NLT05TR3Jxc1E2UldkR3V4NUFrWGF3TTFzdjlI?=
 =?utf-8?B?aVg0ZW5XcThza2l1V3RhVzd1RWVGSFM0bDdabUNOY1RTdmxrMldJdGhId0s5?=
 =?utf-8?B?Y01mRDRkZHJKT3owTHpBNWZBK3JyRGRXazVUcmhoZFZLeXdMczJxNGQrWldz?=
 =?utf-8?B?Q3Uxa051cndKODBkWGVXTSthMXBVT01MenpoQUZLZjdTVmJQSDZtZWFxeDY2?=
 =?utf-8?B?L0ozd3BEWEluMWFldTBRZmFEWndURGNlZDdxTEs3ZnQ4bVVQYlY0RXVxTFV6?=
 =?utf-8?B?bFh1WXVtMnFxN3ZZRm1WQ095QUwzTG1pV1l2eEpobmg0dGpqWWVwK096bWNu?=
 =?utf-8?B?T0dIWVp2YitrejM3L1d4SVA3V3ZNUnVwajZhUnZWNCtlTXF5NTZvekJydGZK?=
 =?utf-8?B?L1d0K1pzUWZWdkpkNE8yemhJSkVzM3ZNRDgydnRmRWFtdjBoSGR6TXpnK3Bs?=
 =?utf-8?B?aVNpN1lnQjVTK1hUVE9jV3pQaXp4b09UbDRvZm4vaGxNY3RXZ1hVK2FRMVdG?=
 =?utf-8?B?NWFYT3FodEVtamo1aXZUbDVCZlVVZ2JoUlJMNDdWUDZjVW13RkxEVnkzTWZG?=
 =?utf-8?B?K3I0UzVVVEU5d2hTZ1hNU3Z2YmFTSTg4d1hyRGdObE83d0E3bE8xVzM0d1dz?=
 =?utf-8?B?R3dvb1hwUWQ3T2hlSHk4K2JvYjNnblZmYjZlOXFjSkVyeHdXVTZ4UWxyNmhT?=
 =?utf-8?B?V1NSd3lYdkxENVo3SmlMYTBKZUttaTQzejZDU3gwc1NzbEE4anQ2ajNsYnVV?=
 =?utf-8?B?QVNDMm9FdnZRV3d5RGsyRFdYQVE0OHhuUTBBOWNWNkZLdFdyOWE2Y1UwODM4?=
 =?utf-8?B?TmxmLzd4UzduMUgyUnRqTEtLYkF4Mk52YnNsc3VmWnVLUDBpU2NwVkFSOHFW?=
 =?utf-8?B?TnNrWUM4aTZEQ1FKQVN0Z2RxVkpncGJvZmpUV0xhUjZHeEJwS3hBV1U0dVFG?=
 =?utf-8?B?OEVVa1dNYmI0M3JMbkMvaldBd1JJdjM4KzFUejA4QW5PbU4wNU9jTlJVZTZp?=
 =?utf-8?B?cEt4NzUzNjI3Z0V6aEFyYXpBZVhNcjJ6RHJtVUJUa1dsQjdSTXlGcmxObC9q?=
 =?utf-8?B?a3NETWR5TGdoRzNrVXhsSmk5UkxkQWw4eE9Sc1Iwa0ZPMGloT0tpa3dyWmdl?=
 =?utf-8?B?UWZvWEtWc3BCMXltWVJDWjJIa3BPL2VVU1l1bDF2RUpWR1JhanRURzB1WVo3?=
 =?utf-8?B?aVhZZnd6NkFKdkQwVG9PZkxSYnJuSm1TK3RzdDQxQ09LRE1HUzJobXppa1do?=
 =?utf-8?B?UmhGNlVodmsvbVkrNkhvYkN0Ym01L0tqNkJicm1WZzJCYTBBdHpSVnNOMU90?=
 =?utf-8?B?eEZYazk2UlFBWm9wMVdLMDNIYzNucGVBYlVJVEJWL1J2d1F2UWpRMDlqcUI0?=
 =?utf-8?B?ZzhXRXh3UTVLRm9tVFd6Sm1NbTVLN1NHa0c2VFZPMUZHK05Wd0I3Rmdyd2pz?=
 =?utf-8?B?NEttM3h5V1MzOFBwQkhabVlPUndEZjRKblhOMjhNQzhPcUJxTkdaREFHTUdy?=
 =?utf-8?B?M0MxTG12VzJXWVU2T1VwNS9HQ2VscmtmcUJiYk5lTDZBT0NibkZQSSttcytE?=
 =?utf-8?B?SXVxdVAxQm9ibGYxOEJVcHgxRlgvSll2TmIrZlZxMzcvSW5hNkx0RnphYUtG?=
 =?utf-8?B?ZHVWaklJRlFKOFI1UmhVOHpvYXMwbjFyNFNMdjk2V2tHV3lQTWNGMzRmdWJm?=
 =?utf-8?B?NFB4S1V2SGVGRUNsTC9kMUc0R3lWNjFLYVJpZlgwQVpWZGhmK1JoUEFEQkJK?=
 =?utf-8?B?MHBmY0hQajRteloyK084RFFBcEhnR3N5WXE3WTF4SlBnY2tSdktCVFVaNXVE?=
 =?utf-8?Q?pMYtihSkOENC5C0m/oEmVHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5d9b6-fe53-4d69-4a83-08daa89ea821
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 20:01:00.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBNCkUs1Z89qq+Wl7NAXY6hq4nIgaoKywQ/bp6uUrII5x8/aPwPGndKuOuXEEy5bLJdjNxZM1hFOrJc9T/2n3WY1nQ5Bk+0wm8RelJo8GQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070118
X-Proofpoint-ORIG-GUID: pABi5KRzhEieovZwyMCWmRzVEyY_3kYq
X-Proofpoint-GUID: pABi5KRzhEieovZwyMCWmRzVEyY_3kYq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_130122_935181_621D601D 
X-CRM114-Status: GOOD (  30.43  )
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

CgpPbiAxMC80LzIyIDA0OjEwLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gCj4gT24gMzAvMDkvMjIg
MjE6MDYsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDkvMjgvMjIgMTE6MDcsIEJv
cmlzbGF2IFBldGtvdiB3cm90ZToKPj4+IE9uIFR1ZSwgU2VwIDEzLCAyMDIyIGF0IDAyOjEyOjMx
UE0gLTA1MDAsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Pj4gVGhpcyB0b3BpYyB3YXMgZGlzY3Vz
c2VkIHByZXZpb3VzbHkgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjIvMy8zLzM3Mi4KPj4+Cj4+
PiBQbGVhc2UgZG8gbm90IHVzZSBsa21sLm9yZyB0byByZWZlciB0byBsa21sIG1lc3NhZ2VzLiBX
ZSBoYXZlIGEKPj4+IHBlcmZlY3RseSBmaW5lIGFyY2hpdmFsIHN5c3RlbSBhdCBsb3JlLmtlcm5l
bC5vcmcuIFlvdSBzaW1wbHkgZG8KPj4+Cj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzxN
ZXNzYWdlLUlEPgo+Pj4KPj4+IHdoZW4geW91IHdhbnQgdG8gcG9pbnQgdG8gYSBwcmV2aW91cyBt
YWlsLgo+Pgo+PiBvaywgdGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCB0byBtZS4KPj4+Cj4+
Pj4gRGF2aWQgcG9pbnRzIG91dCB0aGF0IHRlcm1pbm9sb2d5IGlzIHRyaWNreSBoZXJlIGR1ZSB0
byBkaWZmZXJpbmcgYmVoYXZpb3JzLgo+Pj4+IEFuZCBwZXJoYXBzIHRoYXQgaXMgeW91ciBwb2lu
dCBpbiBhc2tpbmcgZm9yIGd1aWRhbmNlIHRleHQuIEl0IGNhbiBiZQo+Pj4+IGNvbXBsaWNhdGVk
Cj4+Pgo+Pj4gV2hpY2ggbWVhbnMgeW91IG5lZWQgYW4gZXhwbGFuYXRpb24gaG93IHRvIHVzZSB0
aGlzIGV2ZW4gbW9yZS4KPj4+Cj4+PiBBbmQgd2h5IGlzIENPTkZJR19DUkFTSF9NQVhfTUVNT1JZ
X1JBTkdFUyBldmVuIGEgS2NvbmZpZyBpdGVtIGFuZCBub3QKPj4+IHNvbWV0aGluZyB5b3UgZGlz
Y292ZXIgZnJvbSB0aGUgaGFyZHdhcmU/Cj4+Cj4+IE5vLCBpcyB0aGUgc2hvcnQgYW5zd2VyLgo+
Pgo+Pj4KPj4+IFlvdXIgaGVscCB0ZXh0IHRhbGtzIGFib3V0IFN5c3RlbSBSQU0gZW50cmllcyBp
biAvcHJvYy9pb21lbSB3aGljaCBtZWFucwo+Pj4gdGhhdCB0aG9zZSBlbnRyaWVzIGFyZSBwcmVz
ZW50IHNvbWV3aGVyZSBpbiB0aGUga2VybmVsIGFuZCB5b3UgY2FuIHJlYWQKPj4+IHRoZW0gb3V0
IGFuZCBkbyB0aGUgcHJvcGVyIGNhbGN1bGF0aW9ucyBkeW5hbWljYWxseSBpbnN0ZWFkIG9mIGRv
aW5nIHRoZQo+Pj4gc3RhdGljIENPTkZJR19OUl9DUFVTX0RFRkFVTFQgKyBDT05GSUdfQ1JBU0hf
TUFYX01FTU9SWV9SQU5HRVMgdGhpbmcuCj4+Cj4+IFRoZSBpbnRlbnQgaXMgdG8gY29tcHV0ZSB0
aGUgbWF4IHNpemUgYnVmZmVyIG5lZWRlZCB0byBjb250YWluIGEgbWF4aW11bSBwb3B1bGF0ZWQg
ZWxmY29yZWhkciwgCj4+IHdoaWNoIGlzIHByaW1hcmlseSBiYXNlZCBvbiB0aGUgbnVtYmVyIG9m
IENQVXMgYW5kIG1lbW9yeSByZWdpb25zLiBUaHVzIGZhciBJIChhbmQgb3RoZXJzIAo+PiBpbnZv
bHZlZCkgaGF2ZSBub3QgZm91bmQgYSBrZXJuZWwgbWV0aG9kIHRvIGRldGVybWluZSB0aGUgbWF4
aW11bSBudW1iZXIgb2YgbWVtb3J5IHJlZ2lvbnMgCj4+IHBvc3NpYmxlIChpZiB5b3UgYXJlIGF3
YXJlIG9mIG9uZSwgcGxlYXNlIGxldCBtZSBrbm93ISkuIFRodXMgQ09ORklHX0NSQVNIX01BWF9N
RU1PUllfUkFOR0VTIHdhcyAKPj4gYm9ybiAocmF0aGVyIGJvcnJvd2VkIGZyb20ga2V4ZWMtdG9v
bHMpLgo+Pgo+PiBTbyBubyBkeW5hbWljIGNvbXB1dGF0aW9uIGlzIHBvc3NpYmxlLCB5ZXQuCj4+
Cj4+Pgo+Pj4+ICwgYnV0IGl0IGFsbCBjb21lcyBkb3duIHRvIFN5c3RlbSBSQU0gZW50cmllcy4K
Pj4+Pgo+Pj4+IEkgY291bGQgcGVyaGFwcyBvZmZlciBhbiBvdmVybHkgc2ltcGxpZmllZCBleGFt
cGxlIHN1Y2ggdGhhdCBmb3IgMUdpQiBibG9jawo+Pj4+IHNpemUsIGZvciBleGFtcGxlLCB0aGUg
Q1JBU0hfTUFYX01FTU9SWV9SQU5HRVMgb2YgMzI3Njggd291bGQgYWxsb3cgZm9yIDMyVGlCCj4+
Pj4gb2YgbWVtb3J5Pwo+Pj4KPj4+IFllcywgYW5kIHN0aWNrIGl0IHNvbWV3aGVyZSBpbiBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wLyBhbmQKPj4+IHJlZmVyIHRvIGl0IGluIHRoYXQg
aGVscCB0ZXh0IHNvIHRoYXQgcGVvcGxlIGNhbiBmaW5kIGl0IGFuZCByZWFkIGhvdyB0bwo+Pj4g
dXNlIHlvdXIgbmV3IG9wdGlvbi4KPj4+Cj4+IG9rCj4+Cj4+Pj4gVGhlIGtidWYuYnVmc3ogdmFs
dWUgaXMgb2J0YWluZWQgdmlhIGEgY2FsbCB0byBwcmVwYXJlX2VsZl9oZWFkZXJzKCk7IEkgY2Fu
Cj4+Pj4gbm90IGluaXRpYWxpemUgaXQgYXQgaXRzIGRlY2xhcmF0aW9uLgo+Pj4KPj4+IFNvcnJ5
LCBJIG1lYW50IHRoaXM6Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcmFz
aC5jIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPj4+IGluZGV4IDhmYzdkNjc4YWM3Mi4uZWU2
ZmQ5ZjFiMmI5IDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPj4+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+PiBAQCAtMzk1LDggKzM5NSw5IEBAIGludCBj
cmFzaF9sb2FkX3NlZ21lbnRzKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+Pj4gwqDCoMKgwqDCoCBp
ZiAocmV0KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoCAtwqDCoMKg
IGltYWdlLT5lbGZfaGVhZGVycyA9IGtidWYuYnVmZmVyOwo+Pj4gLcKgwqDCoCBpbWFnZS0+ZWxm
X2hlYWRlcnNfc3ogPSBrYnVmLmJ1ZnN6Owo+Pj4gK8KgwqDCoCBpbWFnZS0+ZWxmX2hlYWRlcnPC
oMKgwqAgPSBrYnVmLmJ1ZmZlcjsKPj4+ICvCoMKgwqAgaW1hZ2UtPmVsZl9oZWFkZXJzX3N6wqDC
oMKgID0ga2J1Zi5idWZzejsKPj4+ICvCoMKgwqAga2J1Zi5tZW1zesKgwqDCoMKgwqDCoMKgID0g
a2J1Zi5idWZzejsKPj4+IMKgIMKgICNpZiBkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwg
ZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBMVUcpCj4+PiDCoMKgwqDCoMKgIC8qIEVuc3VyZSBl
bGZjb3JlaGRyIHNlZ21lbnQgbGFyZ2UgZW5vdWdoIGZvciBob3RwbHVnIGNoYW5nZXMgKi8KPj4+
IEBAIC00MDcsOSArNDA4LDggQEAgaW50IGNyYXNoX2xvYWRfc2VnbWVudHMoc3RydWN0IGtpbWFn
ZSAqaW1hZ2UpCj4+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYubWVt
c3o7Cj4+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRyX2luZGV4ID0gaW1hZ2UtPm5yX3Nl
Z21lbnRzOwo+Pj4gwqDCoMKgwqDCoCBpbWFnZS0+ZWxmY29yZWhkcl9pbmRleF92YWxpZCA9IHRy
dWU7Cj4+PiAtI2Vsc2UKPj4+IC3CoMKgwqAga2J1Zi5tZW1zeiA9IGtidWYuYnVmc3o7Cj4+PiDC
oCAjZW5kaWYKPj4+ICsKPj4+IMKgwqDCoMKgwqAga2J1Zi5idWZfYWxpZ24gPSBFTEZfQ09SRV9I
RUFERVJfQUxJR047Cj4+PiDCoMKgwqDCoMKgIGtidWYubWVtID0gS0VYRUNfQlVGX01FTV9VTktO
T1dOOwo+Pj4gwqDCoMKgwqDCoCByZXQgPSBrZXhlY19hZGRfYnVmZmVyKCZrYnVmKTsKPj4+Cj4+
IG9rCj4+Cj4+Pj4gSSdtIGF0IGEgbG9zcyBhcyB0byB3aGF0IHRvIGRvIGRpZmZlcmVudGx5IGhl
cmUuIFlvdSd2ZSByYWlzZWQgdGhpcyBpc3N1ZQo+Pj4+IGJlZm9yZSBhbmQgSSB3ZW50IGJhY2sg
YW5kIGxvb2tlZCBhdCB0aGUgc3VnZ2VzdGlvbnMgdGhlbiBhbmQgSSBkb24ndCBzZWUKPj4+PiBo
b3cgdGhhdCBhcHBsaWVzIHRvIHRoaXMgc2l0dWF0aW9uLiBIb3cgaXMgdGhpcyBzaXR1YXRpb24g
ZGlmZmVyZW50IHRoYW4gdGhlCj4+Pj4gI2lmZGVmIENPTkZJR19LRVhFQ19GSUxFIHRoYXQgaW1t
ZWRpYXRlbHkgcHJlY2VlZHMgaXQ/Cj4+Pgo+Pj4gU2VlIHRoZSBkaWZmIGF0IHRoZSBlbmQuIEkn
bSBub3Qgc2F5aW5nIHRoaXMgaXMgaG93IHlvdSBzaG91bGQgZG8gaXQKPj4+IGJ1dCBpdCBzaG91
bGQgZ2l2ZSB5b3UgYSBiZXR0ZXIgaWRlYS4gVGhlIGxvZ2ljIGJlaW5nLCB0aGUgZnVuY3Rpb25z
Cj4+PiBpbiB0aGUgLmMgZmlsZSBkb24ndCByZWFsbHkgbmVlZCBpZmRlZmZlcnkgYXJvdW5kIHRo
ZW0gLSB5b3UncmUgYWRkaW5nCj4+PiAxLTIgZnVuY3Rpb25zIGFuZCBjcmFzaC5jIGlzIG5vdCB0
aGF0IGJpZyAtIHNvIHRoZXkgY2FuIGJlIGJ1aWx0IGluCj4+PiB1bmNvbmRpdGlvbmFsbHkuIFlv
dSdkIG5lZWQgdGhlIGlmZGVmZmVyeSAqaW4gdGhlIGhlYWRlciBvbmx5KiB3aGVuCj4+PiBjcmFz
aC5jIGlzIG5vdCBiZWluZyBidWlsdC4KPj4gb2s7IEkndmUgb3Zlcmxvb2tlZCB0aGF0IHNjZW5h
cmlvLgo+Pj4KPj4+IEJ1dCBJJ3ZlIGRvbmUgaXQgd2l0aCBpZmRlZmZlcnkgaW4gdGhlIC5jIGZp
bGUgbm93IGJlY2F1c2UgeWVzLCB0aGUKPj4+IGtleGVjIGNvZGUgaXMgYSBtaW5lZmllbGQgb2Yg
aWZkZWZmZXJ5LiBIZWxsLCB0aGVyZSdzIGlmZGVmZmVyeSBldmVuIGluCj4+PiB0aGUgaGVhZGVy
cyBmb3Igc3RydWN0cy4gSWZkZWZmZXJ5IHlvdSBkb24ndCByZWFsbHkgbmVlZC4gU29tZW9uZSBz
aG91bGQKPj4+IGNsZWFuIHRoYXQgdXAgYW5kIHNpbXBsaWZ5IHRoaXMgaW1tZW5zZWx5Lgo+Pgo+
PiBvawo+Pgo+Pj4KPj4+PiBDdXJyZW50bHkgdGhlcmUgaXMgYSBjb25jdXJyZW50IGVmZm9ydCBm
b3IgUFBDIHN1cHBvcnQgYnkgU291cmFiaAo+Pj4+IEphaW4sIGFuZCBpbiB0aGF0IGVmZm9ydCBh
cmNoX21hcF9jcmFzaF9wYWdlcygpIGlzIHVzaW5nIF9fdmEocGFkZHIpLgo+Pj4KPj4+IFdoeT8K
Pj4+Cj4+Pj4gSSBkbyBub3Qga25vdyB0aGUgbnVhbmNlcyBiZXR3ZWVuIGttYXBfbG9jYWxfcGFn
ZSgpIGFuZCBfX3ZhKCkgdG8KPj4+PiBhbnN3ZXIgdGhlIHF1ZXN0aW9uLgo+Pj4KPj4+IGttYXBf
bG9jYWxfcGFnZSgpIGlzIGEgZ2VuZXJpYyBpbnRlcmZhY2UgYW5kIGl0IHNob3VsZCB3b3JrIG9u
IGFueSBhcmNoLgo+Pj4KPj4+IEFuZCBpdCBpcyBkb2N1bWVudGVkIGV2ZW46Cj4+Pgo+Pj4gJCBn
aXQgZ3JlcCBrbWFwX2xvY2FsX3BhZ2UgRG9jdW1lbnRhdGlvbi8KPj4+Cj4+Pj4gSWYga21hcF9s
b2NhbF9wYWdlKCkgd29ya3MgZm9yIGFsbCBhcmNocywgdGhlbiBJJ20gaGFwcHkgdG8gZHJvcCB0
aGVzZQo+Pj4+IGFyY2hfIHZhcmlhbnRzIGFuZCB1c2UgaXQgZGlyZWN0bHkuCj4+Pgo+Pj4gWWVz
LCBwbHMgZG8uCj4+Cj4+IEknbGwgY2hlY2sgd2l0aCBTb3VyYWJoIHRvIHNlZSBpZiBQUEMgY2Fu
IHdvcmsgd2l0aCBrbWFwX2xvY2FsX3BhZ2UoKS4KPiBJIHRoaW5rIGttYXBfbG9jYWxfcGFnZSBk
byBzdXBwb3J0IG9uwqAgUG93ZXJQQy4gQnV0IGNhbiB5b3UgZXhwbGFpbiB3aHkgd2UgbmVlZCB0
aGlzCj4gZnVuY3Rpb24gaGVyZSwgYXJlbid0IHRoZSByZXNlcnZlIG1lbW9yeSBhbHJlYWR5IGF2
YWlsYWJsZSB0byB1c2U/CgpPbiB4ODYsIGF0dGVtcHRzIHRvIGFjY2VzcyB0aGUgZWxmY29yZWhk
ciB3aXRob3V0IG1hcHBpbmcgaXQgZGlkIG5vdCB3b3JrIChyZXN1bHRlZAppbiBhIGZhdWx0KS4K
CkxldCBtZSBrbm93IGlmIHVzaW5nIGttYXBfbG9jYWxfcGFnZSgpIGluIHBsYWNlIG9mIF9fdmEo
KSBpbiBhcmNoX21hcF9jcmFzaF9wYWdlcygpLgpJZiBpdCBkb2VzLCB0aGVuIEkgY2FuIGVsaW1p
bmF0ZSBhcmNoX3VuL21hcF9jcmFzaF9wYWdlcygpIGFuZCB1c2Uga21hcF9sb2NhbF9wYWdlKCkK
ZGlyZWN0bHkuCgpUaGFua3MsCmVyaWMKPiAKPiBUaGFua3MsCj4gU291cmFiaCBKYWluCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
