Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29983C7EE24
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hy7vf0ByvWLX/SSY1klO4gLHxYKLhn4rKfGao3yukQE=; b=AINjeAHeuU9dpGt3LrbvtuXWMR
	QiZ/YYSffC4iEEutdl/ihZodSq6wF6Z2X/F6LHgztsbxGjaCouuuGaokgK3WsMjWNTiuHpEdWd4fC
	8Hi40VJQzhWaXnzs6sqssambX4j6xXHftmcXIBr+mh9xGCJjINxBABoAed6n+jdLfAVt+SZy8qojF
	0n68kKaGRxR1Af1lBCcmMkZtjIC/F3hRj9+dt6T6y6tg7a+QZ8aIRqmc4XQzU8jf7C8A/+33YPw73
	WzAyaP2u4VUTL2CLBJT17vngo8woFRkBJYCg+pdFcy5Fri1QruICMMrDP0DrOOsbt3n2apbo2UIrb
	v84WC1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6N8v-00HWPS-34;
	Tue, 06 Jun 2023 03:13:57 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6N8t-00HWOc-0P
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 03:13:57 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355HioRY028821;
	Tue, 6 Jun 2023 03:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=qBsu16EdpNiQMJzyxNyYNun26FJ1cuHZgPbD12ZthVHNEK3HfISPCZGYNzY6bVOjylx2
 sKD0Dp2YarVn2F9t/tkgF8y0DeZxK/jYPa69GGGWP5h7wFG16vW8FianKoRBGxeZtOoR
 ljdTD/MHbtPXUNbszpmfs4JVENTCcLAbE9Ruys9SqWFLIWZFim21Fk8A777mRj8WXjev
 AxY1dh2zBqthYDnG3BVSt4Mc1naB2iJ7ocamn/7MBtbv6PhB+4lb620Op3lqhKPzIxa6
 /CekvWft+FncICgAM4oaiOIIfEsU9R5EpTHhf5f8Kvy9tPs9q4+FufnbsiPZleaCjrj7 vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx8s4bbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jun 2023 03:13:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35632dAE020384;
	Tue, 6 Jun 2023 03:12:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tsx1r6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jun 2023 03:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPvQrcDZn1T/5MBySZi2C8MPMkrO1dfgTTquBEokVgLv22sILAW9uuU2YnSupLgdT1KCV6CL4H5na6JfZmdKF146fMmMPy1EYKX1jVfIrZ5pct87Ej460KEjW3hjzdz0mrssusxmihh1br3zNEUM7io2B+A5DHIg+XhflhFpONzwP+lapg6cwcL8A67WYQyQsHSh86IIhz/FxQdRafo9XQW890iyJrYhzN1DZyLkIwdkEgz1Jk7Cu4hhlNFxaG5TWjCBO4mRdIH6cEoDatp3rHC+OORoLi1nUbKdmg1ZoRfMd3ASSIzpiwe8Jy9BNmKbE2INMY/gTHulGFlLdvyfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=IC8i30Gc1JFoVQvkdSiaAGGy+uaSlH7VWd0uh9+OcbVXEdr2jUcQfkFkLB1qiFGBZBQd1152HR6LgMrT6MmOJMthWm4Okn7I/1vvqaqlV/PfvH0kFEooIh5Z7cYEXokYPAlr3PcmH4IXkdwdzQmsMnBDO4tvVCXtIsV3cWF+ljqBG8D1kKfVm3ZmlAgz/+VLpKXYnaYhF/27wGH0QVSP6H3X9At3jk2eyNNi5OaC49c4wd2KQ/d7YZq0wy9uRsMXTvfI2cVE4vs61n14rSu0h3Lqq05NrncK8ZKFXjn//dxe6aRh5NxjCF1JAcKi/HGI/3xoya9/vIfq9zPRCh6Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=ONYQqrnT8cuiIKzVKiZMShbRdx623HWWklv36413xTPp5KtTNdvoVxXCafLFegUM+SX/TfYTv180+yFfDaVB2D0oiQTY4reJcMsMrVLpIu6Oblz6iS8cV0FlXYcV7Dl2K+/lA8xtWZCXP8+VUpLNMb9rvc1MK5G5KNcMsZdmts4=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 03:12:56 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f%2]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:12:56 +0000
Message-ID: <5f4f6b35-767e-0b27-555c-5e0282477eff@oracle.com>
Date: Mon, 5 Jun 2023 20:12:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
 <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
 <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
X-ClientProxiedBy: PH0PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:510:f::30) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 925e4228-83f0-451a-aea2-08db663bec72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHz+NKeArwho0s5qC4Iv6QronsFihRCvnThrNcQK8ctL689aNZYSwhpffETQ4d8swCNUgeUbNnCwqAPan7QTbXJ06ZOF6NHipao323omrcJLqM+S5HCghJ+B4rgZ6txohHD/ttCetMgL2fcDanYpty8/60qrzOfz4pmfPGq9JmZj/RjJI38KLQ5sf8NP/dk+9y8U4jn+svZw7N6FynT6dxFEhGLDjsapwSInMXwRTr9uWsPD7ah2h8taSJDBg3eNnbjbSn1JIQKsltfnzbq9c8IW0F2Ws/d1bR7SVxmfvFDtn5gCs+1AmLAzPZgbdSuQgFvIFtwkFvpV3aoUrxmSZvCzLdOwV+AUma6jjQ1IQxB9xQfFxAj6aHLhYtVpoirsQhpP/AGXY/NSduD3CcMWEkR/v0JvePnJXApk3rJb5CY5WwYI2yux9FQTAKqVVy6/7UOArfElxTquE2ujqgIiCWP9j0H3DYoRrZG8vs9qgzhD16LTTowq8xJX0zkx8/sCEXzIU2iE9tLH+5AZA13e8XeoccC6KRktUbAYpL2BAxWpsUpz0InD7If5TcsCmFACYhHaMJL9fWzMTjWU0LbwOYBFN5uYZbaPbf4qy8G3W4hGs++8aPk+rFMsw0aV20tQjfXlARvglcBPBB1X9sDNG+ox5Y8QB3dsq9KjWHaUX9VEHOA75jmuvyjKwZHafPkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(83380400001)(7416002)(966005)(44832011)(478600001)(8936002)(8676002)(41300700001)(316002)(66946007)(66476007)(66556008)(31696002)(6916009)(5660300002)(19273905006)(38100700002)(4326008)(86362001)(6486002)(6666004)(36756003)(2906002)(6512007)(26005)(186003)(6506007)(31686004)(53546011)(2616005)(45980500001)(43740500002)(563064011)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNDaHlTZnRaNjZrbXFSUVZlRk9xU1hMME1GdEtMekNmQ25hUjRhaG9HbjZ6?=
 =?utf-8?B?eDcvenFoTXA1MFVGeVBDaDlpMEJWWDVKeGtDS0ZUdWFCWVBXdUptcmE4dDh2?=
 =?utf-8?B?TWY0dzZpK1o2eW0xWHR1emQ3UTRjdTJPODkrMVFkQjE2aFNBSlUzdjhvN0lO?=
 =?utf-8?B?ZCs5UnZuekNQNEpCbVFMZTRvbDRMR2VqcXRJNVlrTUpTNC9hOER2TXlyT09N?=
 =?utf-8?B?S2YvMExEb1VBTE8yWjkza3FocFNpM0pXelIvYVI4OTdnZWFDcWxlVUxxZDlF?=
 =?utf-8?B?UGh5dVdMVlZQU0h1R3BYbkVpaS9BR2lUc2hLczJpSWtMc296REJjN0k1Tm10?=
 =?utf-8?B?NWFubTFDc1NWYkZzZk8xdGNvNktvQ3EyQ01pdlAvL09NMGQ2T2tJWUdoVTRH?=
 =?utf-8?B?SzNlTFgwVmljM1ZOLzBSTlVkbmJScktQcDlRVDlCYkhDM1FmU2pjbUI2M01w?=
 =?utf-8?B?eHFEQXlRU2dQMXlRdUZHSkUweXN5RW1NK1F2Y01oc3ZJbTUzSHhLNTd6Rito?=
 =?utf-8?B?S2RyVi96aXpad251TVBpMyt2R1N1Ui9qOWxoR0NBdE5hUkw4cVRGdWhJcWpC?=
 =?utf-8?B?aTNrMElqaytEaWtQZ0QvWUhYWmwxYjVBZ1lVMEVKV1FpeGVBcGw1dXRWVVA0?=
 =?utf-8?B?QnkxOUwwbFMyTm1ydVl2U3R5L0lFcDRPUklKZGlIVVMrSjUzR2V5RlNsZVdM?=
 =?utf-8?B?cjg5WEpmS2E4SGNJZ0Z0VGVMN05tckRqZzFZczFlUDhwczlzSzJlSXVJL1I3?=
 =?utf-8?B?cXZEWHVyS3JONVpoS2o0Q25PQkQveHZlYzA4YWcvQ0prWVJvK0tScVNXYmll?=
 =?utf-8?B?UmZKNnk4S1E2Rnh4ZDQxOFNzTmVzbUVuaGhYR3VsaTI4WlNVZm5XOG5Ia0Yv?=
 =?utf-8?B?eUZnZXVBVjFoNTdxU1FVc1AyNVBrVElDUGg2VmVzWDlyVHhEYkp2MFcwVFBa?=
 =?utf-8?B?eENlYys1SU82ZWk5L1BHNitKbkVNVjRBd3lUQUJSUGdmblh2T213azYvaGNu?=
 =?utf-8?B?Ynd1ekJCRjh0enNKcStSYU5JeitQWEFOOHJWc1VYak9ZUDVrWkdBVGNIb3Bq?=
 =?utf-8?B?L2I1RG11U0FyVTQxbCs3UEJCYzF5Uk43OXd4NDRzYW1tWmlrc1JORDBneTJB?=
 =?utf-8?B?bTIrSlphdDNQYjgrS1laLzNML2ZoMXRrYW9NMHBrbmhKenZQV3lWQThnRCtB?=
 =?utf-8?B?cnlLN0hrY3ZSSHpNYVJSd1h2OFRsWXBMeXA5V0RZOEJOZzJueHQxaFNDV3hX?=
 =?utf-8?B?Y1hWcjNpa1RGSWsxRFNnOHVCSmFiaDJ2LzJyRm9kdjBBREgvSDVSL1JrNTlj?=
 =?utf-8?B?WGhidWZPVkt5TkppcjdQN1M0OUQ5QW9BbTBqenJkZVdFOEF5SVdjUDlSeDJS?=
 =?utf-8?B?cnJvSVpmNjZCK1hRN1ZxWnVqamJiVmJmcm1GV1lLUXFoK1B3U2lpK1grS0Vm?=
 =?utf-8?B?M3FZNU1tRUhya1REUTlRNnU0RlUxRzE0SWJSelJkMi9McS9wcm12MkhlZ1hZ?=
 =?utf-8?B?V1ozT00xazNqU0RXSnpqNmt0WXJQYlYyblN3MjRDRFJmS0w4QkdmSHhZVllw?=
 =?utf-8?B?WiswWURCTmEwK3E3U1o3RXJ6OGYza0VXNWowdzhWWWM4c2dENlBDSGtMcEtH?=
 =?utf-8?B?Z1B0MTE5MVRRV0hTcGRFOHliYWZWTy8vQVByd3ZLZTE3dFBDOWZtTFlUV25o?=
 =?utf-8?B?VzhON0JaU2NLREoyQVNWaEpuTnJjbGtZekwwaWgyYnYrY0pPM1JmNDFxSyt5?=
 =?utf-8?B?djRGZHIrZGtqTWYzNWxhaWZ3bnZvb1JjQ0M3QURPOVlacHZYeVhjU3VFL3FH?=
 =?utf-8?B?UUozUDk0a2c5MmNjT29ZN1c1MURTYjN0UDdzOW9LVVBUazJJOW4wQzRBTmlQ?=
 =?utf-8?B?ZTJSQTdmWjJsTkhRSFBNWFNjUU5MOHV2SU9sUGdsanFOcndlcHNmdU1iM3Bj?=
 =?utf-8?B?NkFRbXhxTTdBV1JLcklqak40WUttRHR5TjB4bHpSOWFOK1dKajV2cjV4dmlR?=
 =?utf-8?B?b2F1akNtR21nNGg5d1FyY1d5dGtBcnZQaE54Yk5MTFZPK0NUVGg0SGJHanBJ?=
 =?utf-8?B?c3lWN2RuT3VFQUhIWTJ2aWlxd3hWUW9BcDVjWVdhRjdteGxjLzJlOE5pN2tF?=
 =?utf-8?B?dFVKang4dkVLeDZ2amhOUjY5L1VGTmliRi9PcVdXZm94V0s5YitUWlB1VnJV?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amlCUDJqZ3UvMDI4d3A1QVlwVUY5cDY5YmlLc0VNVXNYbnpqd2ZQVnhjZU5u?=
 =?utf-8?B?V1ZkUEQ0dUVJZTUyRC9PempSYkRNR0M3d2tmbzZjcGxNMDZISG5sK0Vld1Ez?=
 =?utf-8?B?TVI3VDZ6eG1VSk5mNHdoQ1NYWC9NMG1hK0hZK2NicG03dUtxUjlLZDRBek45?=
 =?utf-8?B?MjdyVFhldDZlNjI5aXNYS1dUVDdFclVvdTQ4R0VDMHhtSFoycVlNTU1oM1g2?=
 =?utf-8?B?SGlKakduYjR6eGxOd1ZWMzE2SmtXem5GNG5Pc0xVUS9ITU9QbVpsbmdVNGMz?=
 =?utf-8?B?YndKd1VGQmYyNWZYKzdGVHVzUmRyZFBjdFFhN0pyMkNvUWtmU3owbmpJaE9o?=
 =?utf-8?B?U3F0Rk9ObE93ekk5eHFrYlJYR0pLeWhXdnNLZk1lcUpKU2Q0ZDNrK1JWN1ZZ?=
 =?utf-8?B?T1VxeG0rWGxkQXdCSCtzWG1zUUxkV2dIZTRvVGFUYTcxSkNBcGtqWDRFMG9z?=
 =?utf-8?B?d0JNa2tPSnZUT3BreVp3T2M2bm5aaForVDc1OTA3M2MrZzN6YURzMTRERzhy?=
 =?utf-8?B?ajRwbzk3bFVvODZBUzM4UTVzZnUveTNyVTJTVnQrcC9UK0l2aUxEb3FPUFhI?=
 =?utf-8?B?NXpuTUcrKy85UDhqK09zV0VqbHdsdXJ4STNmVjV2cllGc0NCUjRKcGoyK2ZB?=
 =?utf-8?B?NWRiMGY0b3l3WTZIQ245cnJJWVFmMlV3RnVxU1VnaXdzTEF1dDBFRkJzQnBt?=
 =?utf-8?B?dkFWUngxRis5Vkkvby9JRFNya0NkbnZuTDRDclZXYU9BNkF0OEdnQXIyZzBW?=
 =?utf-8?B?bVZHbDQ4SmhMaTB0MTdCam1GTTN1WEpiaXFkVm9IdE9BSkYzN2xZTmVaVkRx?=
 =?utf-8?B?cDJ5THppL3pLbzNwWVF6QnNNRWs0elp3UTBmOEdmVjhaeGVPSzBpNlI2ZW1P?=
 =?utf-8?B?UmpSc2xDVmNidXJwNk1DajJTNDN1d00yTlppVDNJc1p4NXdXWjR2bEFjVGFm?=
 =?utf-8?B?cnl3Z2w1M0hEaUFGOXdpVTlKWjlDYWxiL2pBQzVROG4yeDE5cWZZY1dHYU9V?=
 =?utf-8?B?b1JmSUNUYTFCOTZ5VXc5Y0krUDlpWXFvUzZCTFBBUGRWaWhXLzFjUksrU1NF?=
 =?utf-8?B?R1pFTDV2bnhTK3hEYjNkTDlncXhoRVpCaU1xZFFpbjV1M3NCYnZpdlN1VWFz?=
 =?utf-8?B?aG9SZ3d6dUgxOEN3WmJqUUx4UUgxWk9tZ1VPWWMvS1JGKzJ4VnI0SC9HajQ3?=
 =?utf-8?B?SnpmOEwzK1VZRzJzbzcyNy9jbzFSNndQN3hMNkMySWRPanFLeTVRTUhoeUNu?=
 =?utf-8?B?Uk5kek9lZ242MUdrcEg2bmRaalVnMFg5MHdCYlFzRlp3WGNqRWNaRFJyazdp?=
 =?utf-8?B?N0dXSVFwS3VhS2hCdWxVcno0T2trVmpKSFVzL2VqTnFUWjlNbThiOFdiaVZ6?=
 =?utf-8?B?OTB5NFlWUUM5T1h0RFYybjcwN3Rqck9wWU9jN3Roa2RJUVBRRUdWdENNamYv?=
 =?utf-8?B?VkRNUnhxVkpsSXBxY2Y4cUFhRnRvckpWeHdwVjVLQzNZUUMyblcvTTJOeGN0?=
 =?utf-8?B?akR2QXBmNEJMUTRjdWFBVFFyajhRNWVzNzQrZnVQSC9WcHE4Z3FUMFJ5em1T?=
 =?utf-8?B?VE1wbTRHN1BaWnR5Ym5UektSeHgvSkxRVHlnd3R4U1lnb3d6Y1hFNnJ5QzdS?=
 =?utf-8?B?cy84a1p6TUhxVXc5UmpaRUdVRGJwRXdodC9PNmlvcVc4bDMrVjMyYnlaekZt?=
 =?utf-8?B?RWF5YzhwdjVzWFhjVmV0cWdsTCtjeHQyRFNWSFpOWkpRMisybTFLUG55Qkg0?=
 =?utf-8?Q?SDmSnEipWi1JOxbT9Lwqf9ezPqfkorvZwpGISyz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e4228-83f0-451a-aea2-08db663bec72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 03:12:56.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2DqbSv0WOs9KXCjMvd7UmZJJ+UkJ3InyMDkMgAc1FNKOSbruD+OVGUEKP+lKx8hDJvN4g5noJVX+nX4HSWBowRgkzPhzVmGYxIsHEtM9ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060027
X-Proofpoint-ORIG-GUID: qfteWWESaB-HRxVFy9-Cvi8lt-akjpLX
X-Proofpoint-GUID: qfteWWESaB-HRxVFy9-Cvi8lt-akjpLX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_201355_174685_336C974C 
X-CRM114-Status: GOOD (  27.47  )
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

Ck9uIDYvNS8yMyA3OjU1IFBNLCBDb2lieSBYdSB3cm90ZToKPiBPbiBNb24sIEp1biAwNSwgMjAy
MyBhdCAwNzowMTo1NlBNIC0wNzAwLCBBbnRob255IFl6bmFnYSB3cm90ZToKPj4gSGkgQ29pYnks
Cj4+Cj4+IE9uIDYvNC8yMyA3OjQwIFBNLCBDb2lieSBYdSB3cm90ZToKPj4+IEhpIEFudGhvbnks
Cj4+Pgo+Pj4gT24gV2VkLCBBcHIgMjYsIDIwMjMgYXQgMDU6MDg6NDNQTSAtMDcwMCwgQW50aG9u
eSBZem5hZ2Egd3JvdGU6Cj4+Pj4gVGhlIFBLUkFNIHN1cGVyIGJsb2NrIGlzIHRoZSBzdGFydGlu
ZyBwb2ludCBmb3IgcmVzdG9yaW5nIHByZXNlcnZlZAo+Pj4+IG1lbW9yeS4gQnkgcHJvdmlkaW5n
IHRoZSBzdXBlciBibG9jayB0byB0aGUgbmV3IGtlcm5lbCBhdCBib290IHRpbWUsCj4+Pj4gcHJl
c2VydmVkIG1lbW9yeSBjYW4gYmUgcmVzZXJ2ZWQgYW5kIG1hZGUgYXZhaWxhYmxlIHRvIGJlIHJl
c3RvcmVkLgo+Pj4+IFRvIHBvaW50IHRoZSBrZXJuZWwgdG8gdGhlIGxvY2F0aW9uIG9mIHRoZSBz
dXBlciBibG9jaywgb25lIHBhc3Nlcwo+Pj4+IGl0cyBwZm4gdmlhIHRoZSAncGtyYW0nIGJvb3Qg
cGFyYW0uCj4+Pgo+Pj4gSSdtIGN1cmlvdXMgdG8gYXNrIGhvdyB3aWxsIHRoZSAncGtyYW0nIGJv
b3QgcGFyYW0gYmUgcGFzc2VkLiBJdCAKPj4+IHNlZW1zIEkKPj4+IGNhbid0IGZpbmQgdGhlIGFu
c3dlciBpbiB0aGlzIHBhdGNoIHNldC4KPj4KPj4gVGhlIHBmbiBvZiB0aGUgc3VwZXIgYmxvY2sg
cmVhZCBmcm9tIC9zeXMva2VybmVsL3BrcmFtIGlzIHBhc3NlZCB0bwo+Pgo+PiB0aGUgbmV4dCBr
ZXJuZWwgYnkgYWRkaW5nIHRoZSBib290IHBhcmFtZXRlciwgcGtyYW09PHN1cGVyIGJsb2NrIHBm
bj4uCj4+Cj4+IFRoZSBuZXh0IGtlcm5lbCBwaWNrcyBpdCB1cCB0aHJvdWdoIHRoZSBlYXJseV9w
YXJhbSgicGtyYW0iLCAKPj4gcGFyc2VfcGtyYW1fc2JfcGZuKQo+Pgo+PiBpbiB0aGlzIHBhdGNo
IGJlbG93Lgo+Cj4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24hIFNvcnJ5IEkgZGlkbid0IG1h
a2UgbXkgcXVlc3Rpb24gY2xlYXIuIEkKPiBzaG91bGQgaGF2ZSBhc2tlZCB3aG8gaXMgZ29pbmcg
dG8gcmVhZCAvc3lzL2tlcm5lbC9wa3JhbSBob3cgdGhpcyBwa3JhbQo+IGJvb3QgcGFyYW1ldGVy
IHdpbGwgYmUgYWRkZWQgZm9yIHRoZSBuZXh0IGtlcm5lbC4KCkkgaGF2ZSBub3Qgc3BlY2lmaWVk
IHRoaXMgaW4gdGhlIHBhdGNoZXMuIE9uZSB3YXkgd291bGQgYmUgdG8gd3JpdGUgYSBzY3JpcHQK
CmFzIHdyYXBwZXIgYXJvdW5kIGtleGVjIHRoYXQgZGV0ZXJtaW5lcyBhbmQgYXBwZW5kcyB0aGUg
YXBwcm9wcmlhdGUgYm9vdAoKcGFyYW1ldGVyLgoKCkFudGhvbnkKCj4KPj4KPj4KPj4gQW50aG9u
eQo+Pgo+Pgo+Pj4KPj4+Cj4+Pj4gRm9yIHRoYXQgcHVycG9zZSwgdGhlIHBrcmFtIHN1cGVyCj4+
Pj4gYmxvY2sgcGZuIGlzIGV4cG9ydGVkIHZpYSAvc3lzL2tlcm5lbC9wa3JhbS4gSWYgbm9uZSBp
cyBwYXNzZWQsIGFueQo+Pj4+IHByZXNlcnZlZCBtZW1vcnkgd2lsbCBub3QgYmUga2VwdCwgYW5k
IGEgbmV3IHN1cGVyIGJsb2NrIHdpbGwgYmUKPj4+PiBhbGxvY2F0ZWQuCj4+Pj4KPj4+PiBPcmln
aW5hbGx5LWJ5OiBWbGFkaW1pciBEYXZ5ZG92IDx2ZGF2eWRvdi5kZXZAZ21haWwuY29tPgo+Pj4+
IFNpZ25lZC1vZmYtYnk6IEFudGhvbnkgWXpuYWdhIDxhbnRob255Lnl6bmFnYUBvcmFjbGUuY29t
Pgo+Pj4+IC0tLQo+Pj4+IG1tL3BrcmFtLmMgfCAxMDIgCj4+Pj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+Pj4+IDEgZmlsZSBj
aGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYg
LS1naXQgYS9tbS9wa3JhbS5jIGIvbW0vcGtyYW0uYwo+Pj4+IGluZGV4IGRhMTY2Y2I2YWZiNy4u
YzY2YjJhZTRkNTIwIDEwMDY0NAo+Pj4+IC0tLSBhL21tL3BrcmFtLmMKPj4+PiArKysgYi9tbS9w
a3JhbS5jCj4+Pj4gQEAgLTUsMTUgKzUsMTggQEAKPj4+PiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
Pgo+Pj4+ICNpbmNsdWRlIDxsaW51eC9pby5oPgo+Pj4+ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L2tvYmplY3QuaD4KPj4+PiAjaW5jbHVkZSA8bGludXgv
bGlzdC5oPgo+Pj4+ICNpbmNsdWRlIDxsaW51eC9tbS5oPgo+Pj4+ICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KPj4+PiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KPj4+PiAjaW5jbHVkZSA8bGlu
dXgvbm90aWZpZXIuaD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3Bmbi5oPgo+Pj4+ICNpbmNsdWRl
IDxsaW51eC9wa3JhbS5oPgo+Pj4+ICNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4KPj4+PiAjaW5j
bHVkZSA8bGludXgvc2NoZWQuaD4KPj4+PiAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+Cj4+Pj4g
KyNpbmNsdWRlIDxsaW51eC9zeXNmcy5oPgo+Pj4+ICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgo+
Pj4+Cj4+Pj4gI2luY2x1ZGUgImludGVybmFsLmgiCj4+Pj4gQEAgLTgyLDEyICs4NSwzOCBAQCBz
dHJ1Y3QgcGtyYW1fbm9kZSB7Cj4+Pj4gI2RlZmluZSBQS1JBTV9BQ0NNT0RFX01BU0vCoMKgwqAg
Mwo+Pj4+Cj4+Pj4gLyoKPj4+PiArICogVGhlIFBLUkFNIHN1cGVyIGJsb2NrIGNvbnRhaW5zIGRh
dGEgbmVlZGVkIHRvIHJlc3RvcmUgdGhlIAo+Pj4+IHByZXNlcnZlZCBtZW1vcnkKPj4+PiArICog
c3RydWN0dXJlIG9uIGJvb3QuIFRoZSBwb2ludGVyIHRvIGl0IChwZm4pIHNob3VsZCBiZSBwYXNz
ZWQgdmlhIAo+Pj4+IHRoZSAncGtyYW0nCj4+Pj4gKyAqIGJvb3QgcGFyYW0gaWYgb25lIHdhbnRz
IHRvIHJlc3RvcmUgcHJlc2VydmVkIGRhdGEgc2F2ZWQgYnkgdGhlIAo+Pj4+IHByZXZpb3VzbHkK
Pj4+PiArICogZXhlY3V0aW5nIGtlcm5lbC4gRm9yIHRoYXQgcHVycG9zZSB0aGUga2VybmVsIGV4
cG9ydHMgdGhlIHBmbiB2aWEKPj4+PiArICogL3N5cy9rZXJuZWwvcGtyYW0uIElmIG5vbmUgaXMg
cGFzc2VkLCBwcmVzZXJ2ZWQgbWVtb3J5IGlmIGFueSAKPj4+PiB3aWxsIG5vdCBiZQo+Pj4+ICsg
KiBwcmVzZXJ2ZWQgYW5kIGEgbmV3IGNsZWFuIHBhZ2Ugd2lsbCBiZSBhbGxvY2F0ZWQgZm9yIHRo
ZSBzdXBlciAKPj4+PiBibG9jay4KPj4+PiArICoKPj4+PiArICogVGhlIHN0cnVjdHVyZSBvY2N1
cGllcyBhIG1lbW9yeSBwYWdlLgo+Pj4+ICsgKi8KPj4+PiArc3RydWN0IHBrcmFtX3N1cGVyX2Js
b2NrIHsKPj4+PiArwqDCoMKgIF9fdTY0wqDCoMKgIG5vZGVfcGZuO8KgwqDCoMKgwqDCoMKgIC8q
IGZpcnN0IGVsZW1lbnQgb2YgdGhlIG5vZGUgbGlzdCAqLwo+Pj4+ICt9Owo+Pj4+ICsKPj4+PiAr
c3RhdGljIHVuc2lnbmVkIGxvbmcgcGtyYW1fc2JfcGZuIF9faW5pdGRhdGE7Cj4+Pj4gK3N0YXRp
YyBzdHJ1Y3QgcGtyYW1fc3VwZXJfYmxvY2sgKnBrcmFtX3NiOwo+Pj4+ICsKPj4+PiArLyoKPj4+
PiDCoCogRm9yIGNvbnZlbmllbmNlIHNha2UgUEtSQU0gbm9kZXMgYXJlIGtlcHQgaW4gYW4gYXV4
aWxpYXJ5IAo+Pj4+IGRvdWJseS1saW5rZWQgbGlzdAo+Pj4+IMKgKiBjb25uZWN0ZWQgdGhyb3Vn
aCB0aGUgbHJ1IGZpZWxkIG9mIHRoZSBwYWdlIHN0cnVjdC4KPj4+PiDCoCovCj4+Pj4gc3RhdGlj
IExJU1RfSEVBRChwa3JhbV9ub2Rlcyk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBsaW5rZWQg
dGhyb3VnaCAKPj4+PiBwYWdlOjpscnUgKi8KPj4+PiBzdGF0aWMgREVGSU5FX01VVEVYKHBrcmFt
X211dGV4KTvCoMKgwqDCoMKgwqDCoCAvKiBzZXJpYWxpemVzIG9wZW4vY2xvc2UgKi8KPj4+Pgo+
Pj4+ICsvKgo+Pj4+ICsgKiBUaGUgUEtSQU0gc3VwZXIgYmxvY2sgcGZuLCBzZWUgYWJvdmUuCj4+
Pj4gKyAqLwo+Pj4+ICtzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9wa3JhbV9zYl9wZm4oY2hhciAq
YXJnKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCByZXR1cm4ga3N0cnRvdWwoYXJnLCAxNiwgJnBrcmFt
X3NiX3Bmbik7Cj4+Pj4gK30KPj4+PiArZWFybHlfcGFyYW0oInBrcmFtIiwgcGFyc2VfcGtyYW1f
c2JfcGZuKTsKPj4+PiArCj4+Pj4gc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqcGtyYW1fYWxs
b2NfcGFnZShnZnBfdCBnZnBfbWFzaykKPj4+PiB7Cj4+Pj4gwqDCoMKgwqByZXR1cm4gYWxsb2Nf
cGFnZShnZnBfbWFzayk7Cj4+Pj4gQEAgLTI3MCw2ICsyOTksNyBAQCBzdGF0aWMgdm9pZCBwa3Jh
bV9zdHJlYW1faW5pdChzdHJ1Y3QgCj4+Pj4gcGtyYW1fc3RyZWFtICpwcywKPj4+PiDCoCogQGdm
cF9tYXNrIHNwZWNpZmllcyB0aGUgbWVtb3J5IGFsbG9jYXRpb24gbWFzayB0byBiZSB1c2VkIHdo
ZW4gCj4+Pj4gc2F2aW5nIGRhdGEuCj4+Pj4gwqAqCj4+Pj4gwqAqIEVycm9yIHZhbHVlczoKPj4+
PiArICrCoMKgwqAgJUVOT0RFVjogUEtSQU0gbm90IGF2YWlsYWJsZQo+Pj4+IMKgKsKgwqDCoCAl
RU5BTUVUT09MT05HOiBuYW1lIGxlbiA+PSBQS1JBTV9OQU1FX01BWAo+Pj4+IMKgKsKgwqDCoCAl
RU5PTUVNOiBpbnN1ZmZpY2llbnQgbWVtb3J5IGF2YWlsYWJsZQo+Pj4+IMKgKsKgwqDCoCAlRUVY
SVNUOiBub2RlIHdpdGggc3BlY2lmaWVkIG5hbWUgYWxyZWFkeSBleGlzdHMKPj4+PiBAQCAtMjg1
LDYgKzMxNSw5IEBAIGludCBwa3JhbV9wcmVwYXJlX3NhdmUoc3RydWN0IHBrcmFtX3N0cmVhbSAq
cHMsIAo+Pj4+IGNvbnN0IGNoYXIgKm5hbWUsIGdmcF90IGdmcF9tYXNrCj4+Pj4gwqDCoMKgwqBz
dHJ1Y3QgcGtyYW1fbm9kZSAqbm9kZTsKPj4+PiDCoMKgwqDCoGludCBlcnIgPSAwOwo+Pj4+Cj4+
Pj4gK8KgwqDCoCBpZiAoIXBrcmFtX3NiKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVO
T0RFVjsKPj4+PiArCj4+Pj4gwqDCoMKgwqBpZiAoc3RybGVuKG5hbWUpID49IFBLUkFNX05BTUVf
TUFYKQo+Pj4+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5BTUVUT09MT05HOwo+Pj4+Cj4+Pj4g
QEAgLTQwNCw2ICs0MzcsNyBAQCB2b2lkIHBrcmFtX2Rpc2NhcmRfc2F2ZShzdHJ1Y3QgcGtyYW1f
c3RyZWFtICpwcykKPj4+PiDCoCogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvbiBmYWls
dXJlLgo+Pj4+IMKgKgo+Pj4+IMKgKiBFcnJvciB2YWx1ZXM6Cj4+Pj4gKyAqwqDCoMKgICVFTk9E
RVY6IFBLUkFNIG5vdCBhdmFpbGFibGUKPj4+PiDCoCrCoMKgwqAgJUVOT0VOVDogbm9kZSB3aXRo
IHNwZWNpZmllZCBuYW1lIGRvZXMgbm90IGV4aXN0Cj4+Pj4gwqAqwqDCoMKgICVFQlVTWTogc2F2
ZSB0byByZXF1aXJlZCBub2RlIGhhcyBub3QgZmluaXNoZWQgeWV0Cj4+Pj4gwqAqCj4+Pj4gQEAg
LTQxNCw2ICs0NDgsOSBAQCBpbnQgcGtyYW1fcHJlcGFyZV9sb2FkKHN0cnVjdCBwa3JhbV9zdHJl
YW0gKnBzLCAKPj4+PiBjb25zdCBjaGFyICpuYW1lKQo+Pj4+IMKgwqDCoMKgc3RydWN0IHBrcmFt
X25vZGUgKm5vZGU7Cj4+Pj4gwqDCoMKgwqBpbnQgZXJyID0gMDsKPj4+Pgo+Pj4+ICvCoMKgwqAg
aWYgKCFwa3JhbV9zYikKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4g
Kwo+Pj4+IMKgwqDCoMKgbXV0ZXhfbG9jaygmcGtyYW1fbXV0ZXgpOwo+Pj4+IMKgwqDCoMKgbm9k
ZSA9IHBrcmFtX2ZpbmRfbm9kZShuYW1lKTsKPj4+PiDCoMKgwqDCoGlmICghbm9kZSkgewo+Pj4+
IEBAIC04MjUsNiArODYyLDEzIEBAIHN0YXRpYyB2b2lkIF9fcGtyYW1fcmVib290KHZvaWQpCj4+
Pj4gwqDCoMKgwqDCoMKgwqAgbm9kZS0+bm9kZV9wZm4gPSBub2RlX3BmbjsKPj4+PiDCoMKgwqDC
oMKgwqDCoCBub2RlX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2UpOwo+Pj4+IMKgwqDCoMKgfQo+Pj4+
ICsKPj4+PiArwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgICogWmVybyBvdXQgcGtyYW1fc2IgY29t
cGxldGVseSBzaW5jZSBpdCBtYXkgaGF2ZSBiZWVuIHBhc3NlZCAKPj4+PiBmcm9tCj4+Pj4gK8Kg
wqDCoMKgICogdGhlIHByZXZpb3VzIGJvb3QuCj4+Pj4gK8KgwqDCoMKgICovCj4+Pj4gK8KgwqDC
oCBtZW1zZXQocGtyYW1fc2IsIDAsIFBBR0VfU0laRSk7Cj4+Pj4gK8KgwqDCoCBwa3JhbV9zYi0+
bm9kZV9wZm4gPSBub2RlX3BmbjsKPj4+PiB9Cj4+Pj4KPj4+PiBzdGF0aWMgaW50IHBrcmFtX3Jl
Ym9vdChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5vdGlmaWVyLAo+Pj4+IEBAIC04MzIsNyArODc2
LDggQEAgc3RhdGljIGludCBwa3JhbV9yZWJvb3Qoc3RydWN0IG5vdGlmaWVyX2Jsb2NrIAo+Pj4+
ICpub3RpZmllciwKPj4+PiB7Cj4+Pj4gwqDCoMKgwqBpZiAodmFsICE9IFNZU19SRVNUQVJUKQo+
Pj4+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBOT1RJRllfRE9ORTsKPj4+PiAtwqDCoMKgIF9fcGty
YW1fcmVib290KCk7Cj4+Pj4gK8KgwqDCoCBpZiAocGtyYW1fc2IpCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIF9fcGtyYW1fcmVib290KCk7Cj4+Pj4gwqDCoMKgwqByZXR1cm4gTk9USUZZX09LOwo+Pj4+
IH0KPj4+Pgo+Pj4+IEBAIC04NDAsOSArODg1LDYyIEBAIHN0YXRpYyBpbnQgcGtyYW1fcmVib290
KHN0cnVjdCBub3RpZmllcl9ibG9jayAKPj4+PiAqbm90aWZpZXIsCj4+Pj4gwqDCoMKgwqAubm90
aWZpZXJfY2FsbCA9IHBrcmFtX3JlYm9vdCwKPj4+PiB9Owo+Pj4+Cj4+Pj4gK3N0YXRpYyBzc2l6
ZV90IHNob3dfcGtyYW1fc2JfcGZuKHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKPj4+PiArewo+
Pj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBwZm4gPSBwa3JhbV9zYiA/IFBGTl9ET1dOKF9fcGEo
cGtyYW1fc2IpKSA6IDA7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAi
JWx4XG4iLCBwZm4pOwo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+ICtzdGF0aWMgc3RydWN0IGtvYmpfYXR0
cmlidXRlIHBrcmFtX3NiX3Bmbl9hdHRyID0KPj4+PiArwqDCoMKgIF9fQVRUUihwa3JhbSwgMDQ0
NCwgc2hvd19wa3JhbV9zYl9wZm4sIE5VTEwpOwo+Pj4+ICsKPj4+PiArc3RhdGljIHN0cnVjdCBh
dHRyaWJ1dGUgKnBrcmFtX2F0dHJzW10gPSB7Cj4+Pj4gK8KgwqDCoCAmcGtyYW1fc2JfcGZuX2F0
dHIuYXR0ciwKPj4+PiArwqDCoMKgIE5VTEwsCj4+Pj4gK307Cj4+Pj4gKwo+Pj4+ICtzdGF0aWMg
c3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwa3JhbV9hdHRyX2dyb3VwID0gewo+Pj4+ICvCoMKgwqAg
LmF0dHJzID0gcGtyYW1fYXR0cnMsCj4+Pj4gK307Cj4+Pj4gKwo+Pj4+ICsvKiByZXR1cm5zIG5v
bi16ZXJvIG9uIHN1Y2Nlc3MgKi8KPj4+PiArc3RhdGljIGludCBfX2luaXQgcGtyYW1faW5pdF9z
Yih2b2lkKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIHBmbjsKPj4+PiArwqDC
oMKgIHN0cnVjdCBwa3JhbV9ub2RlICpub2RlOwo+Pj4+ICsKPj4+PiArwqDCoMKgIGlmICghcGty
YW1fc2IpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4+Pj4gKwo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBwYWdlID0gcGtyYW1fYWxsb2NfcGFnZShHRlBfS0VSTkVMIHwg
X19HRlBfWkVSTyk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcGFnZSkgewo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiUEtSQU06IEZhaWxlZCB0byBhbGxvY2F0ZSBzdXBl
ciBibG9ja1xuIik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4+PiArwqDCoMKgwqDCoMKgwqAgcGtyYW1fc2IgPSBwYWdlX2Fk
ZHJlc3MocGFnZSk7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgLyoKPj4+PiAr
wqDCoMKgwqAgKiBCdWlsZCBhdXhpbGlhcnkgZG91Ymx5LWxpbmtlZCBsaXN0IG9mIG5vZGVzIGNv
bm5lY3RlZCB0aHJvdWdoCj4+Pj4gK8KgwqDCoMKgICogcGFnZTo6bHJ1IGZvciBjb252ZW5pZW5j
ZSBzYWtlLgo+Pj4+ICvCoMKgwqDCoCAqLwo+Pj4+ICvCoMKgwqAgcGZuID0gcGtyYW1fc2ItPm5v
ZGVfcGZuOwo+Pj4+ICvCoMKgwqAgd2hpbGUgKHBmbikgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBu
b2RlID0gcGZuX3RvX2thZGRyKHBmbik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHBrcmFtX2luc2Vy
dF9ub2RlKG5vZGUpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwZm4gPSBub2RlLT5ub2RlX3BmbjsK
Pj4+PiArwqDCoMKgIH0KPj4+PiArwqDCoMKgIHJldHVybiAxOwo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+
IHN0YXRpYyBpbnQgX19pbml0IHBrcmFtX2luaXQodm9pZCkKPj4+PiB7Cj4+Pj4gLcKgwqDCoCBy
ZWdpc3Rlcl9yZWJvb3Rfbm90aWZpZXIoJnBrcmFtX3JlYm9vdF9ub3RpZmllcik7Cj4+Pj4gK8Kg
wqDCoCBpZiAocGtyYW1faW5pdF9zYigpKSB7Cj4+Pj4gKyByZWdpc3Rlcl9yZWJvb3Rfbm90aWZp
ZXIoJnBrcmFtX3JlYm9vdF9ub3RpZmllcik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN5c2ZzX3Vw
ZGF0ZV9ncm91cChrZXJuZWxfa29iaiwgJnBrcmFtX2F0dHJfZ3JvdXApOwo+Pj4+ICvCoMKgwqAg
fQo+Pj4+IMKgwqDCoMKgcmV0dXJuIDA7Cj4+Pj4gfQo+Pj4+IG1vZHVsZV9pbml0KHBrcmFtX2lu
aXQpOwo+Pj4+IC0tIAo+Pj4+IDEuOS40Cj4+Pj4KPj4+Pgo+Pj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4+
Pj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+Pj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKPj4+Pgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
