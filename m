Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB4C77B73
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9S1FmJymU/i6/FVrm8m72uhqypYpx+y0XqYQ9ofvLA=; b=iKKIrym68MxEaT0w3/2+R4nHR9
	g96CToJDYBrOX+AonQOM+IlclMnxO1WPPnR2aXweHrqB8YB84oR2+mStXAcEK7+mVdZWiAqybEOyD
	7+vnFB8Aeb9b54AHTtmGuQznZ32uOI+/ErjJSflyr4wy/h4Ya7coojV+1h6O/X7fYMQE/RzxwufRr
	/Vt/spUAPY0VFCzfZbJjQIxsIcL6S67aiRgTi+/5/xiIyprBJp5VlYXLMrt7wfacAipCaweql/9HP
	np6pzO4wBCInqWTbthxxwcqLtOmUMoOKyUKPGn9FA6Gfvn7m9sd1l/XpUBy/2PwLXu2cSMYAPRJjZ
	onGWo5NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4V2j-001RyH-0K;
	Wed, 31 May 2023 23:15:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4V2f-001Rxi-2a
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 23:15:47 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJvOwc031546;
	Wed, 31 May 2023 23:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=RhMUBpGn0pZYf/dhIaeeT89MKZ7eGwK5frYqrDkODbzYnMHec6veBOdcIJttSBa/WSNs
 SVqO+KGp1tvhFVYC6cFYnintIeyYPtr7d8IWDcnU0aVoJ38ms+0IVqeURbYZGj0iJl1n
 utq3HwAB+1qzODG/cMqUTEeGmTBDuIFowSWBx9LRRzOz4olhPlNTD/chY9V/fkacIccN
 xBFSzMyNMRq622Hn8qWWma8UQDOUXDylsDcV6puwRueJ05KhcNlDw3ej4ku5bZ154ov+
 upgMrKTxiZ0NedkG6PVHEosrJcNit9Sk7T8ZvPnZIcq1VyOa15dIXH9WM3ZRaVyZxBgH +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4y8bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 23:14:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLkEom030185;
	Wed, 31 May 2023 23:14:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a73h9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 23:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnwfDBBb7Et2jAx2RoyqyeOrRRBlhCCGHnjO6a/R/x/MxiLmRBqCtzgpYqba+eWFIdHU8mLA00qgd7FgtA7l7KFNuo4q8G4OUWP365cJGaQErkp86k6EuQ72f75tXrsqMi957psm+5U8eOHSwAufOCURjNpc+EZuzp2tJiiYUaX0faWWmxV9eNwUOqV/T4UP1YKWoCzfBzZUakhYuPKI4Ei5rgIZW5a0/Lge/ePQo3P1EP+NCAB/cJmr2ofpnu/h2AI5h6hMZEIjDBq1PDmeh/88xkKitmlMqOj4dlaQPMLq57isF0xLmv5OlgAbRHcgx5qTeDk+jv79MVMxE0b/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=mj5XQQm1pCo2AsxrxliGav5YTXN91EUS/nuekT10VDjaoaeE6MWuq0WIYVT1yQp1XFe+K+jgVFaB6ciO473q6gUhQKS3f6Ebmz1+pL5Z9NOB8HzHOwZzEJWTBr1Ga1u+to2Ll6UP5Qlr1n5Vw9VuZwlUPGS2d38Dzwj1TUUhby20dJxypKdkCivZSN+jpa3Y7RUENfy2e0fLhf1UhRffYN/0X2tRkx5mxkLIzyF+f9lC98pgU3gsXruQebml4Cm8hc7Ai+qbo/qU6IyTjKTMPYRcsS90MHUcJZj2a1xw3neGUfzpOirTxyutcg/x+16IPYqacLW5WQWm+J5LGLasOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX2PKRSRx/NhzAG+Jqa9ChMGkplIiQqRVE1XqU+1hV4=;
 b=QKS8RVyzxDarNV1ZsfSmYIoOPuBv6hMOoTDwD74tzgQDKo3uOnSVmkaPcBIMw9Nkp/rL5PMSjKYIAgj0WbJ3HGnLCr08AqZX7r5DBAJf82CxTfRUoH0X2hKj12dS3SFC+1UOEHMQHRGVLAAIdkEZyRqQNmUwebZVK2z2prrG8Yo=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 23:14:16 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::625c:3dc5:8229:d2a]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::625c:3dc5:8229:d2a%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 23:14:16 +0000
Message-ID: <66d7eda2-c136-1245-b433-784264b31683@oracle.com>
Date: Wed, 31 May 2023 16:14:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
Content-Language: en-US
To: "Gowans, James" <jgowans@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jason.zeng@intel.com" <jason.zeng@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lei.l.li@intel.com" <lei.l.li@intel.com>,
        "luto@kernel.org"
 <luto@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuleixzhang@tencent.com" <yuleixzhang@tencent.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org"
 <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd37c7-5bda-41c1-d908-08db622cc14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JurhNfD+59Sn4IPMTAcYp14Euuup057joh/I4JiCRaXwJpQ4twzpR+UagAmNbNJyefUC6wxZDDDxSat9FUSL+ZeSA8L53/8irOBuURKRceRrsq5QgqUvkTaoHV3OhinUSBRWecG3NU1Y3Dyt0MQl1HQL7gV1SCO1enFQ8zzDXKYwO8lNvgsCIvDhgQOpVLSuDqD2RFC0u0/MMwYb46DhsIqO7zH1AA8l6qibrOJYWej76fAhZHOl7iFWsrJJpbyzyHDDfYAI2RlWWgyRHV7HfqCe67tAJ+8nLgVqkAZXFLoE//n39llH0+VirVEUDu8tp6vYs2wj7q25P4stv39qQgAzjiNoyRq09JqhtM4fqsYaRJOCzixkC6CmiZXQFqjW5qSrFAJWZTVl9IdUVEC0CvFM6otHFT+dHFz7f3kfDoXDyMOwvRphwwW2KeXx9ovF1pw/tynZk7+sqV3i9DZc17Y+HlSH2GsEcURIhWf0Xy74SEup5IF6jD3luXiYP4BzpfKWc8bwj6KLjI3xCivRL5RrHnfCYeHW2xVaNMlpWvghKPSomBCfjm1L0QXceMwbtsNLkZkJPV7mtCZYgA00HIr+7Zt4mTEg3stvw+xUP7t9pDwKnCvHct7Ga+UwgVu07SgXJXucJ7LA+YfWNRqsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(186003)(2906002)(31686004)(6512007)(53546011)(6506007)(2616005)(5660300002)(110136005)(54906003)(478600001)(38100700002)(8936002)(8676002)(26005)(83380400001)(966005)(6486002)(44832011)(31696002)(86362001)(41300700001)(6666004)(316002)(7416002)(36756003)(66476007)(66946007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdaaFgrNGg1aXV2Qnkyc09EZnlQM3FmSy9Ja0N0ZG04VW82bndNcWMxZU56?=
 =?utf-8?B?YU5lZ1pZcENCNTg1VFBJYm5vWTlGSzlka2JnS0lRV0xxWkJFOGNmbVZOL2lt?=
 =?utf-8?B?VzNhOVpFS3M0MUxpU2JDSEM3cmduNXBMVVlCaUdaSitHR0ZRTlVweUprS004?=
 =?utf-8?B?QlJXditVNkxhSk9RbXJzc3B0ZUdPcHVwU05tSDVuRUNwdDF5bGpaTmNDU2ZR?=
 =?utf-8?B?OVhONkw3Ukh6bDlEUldTZmx2TkliOVh4UzVFOGtMUTNYUUx4NnEwTThEd1Mx?=
 =?utf-8?B?Y3doajVYUDRVL0dmY2ZUaStObW0vOVFHMlphc2E0SVZTMDUwdDd0NnlwUk03?=
 =?utf-8?B?N1ZnT1dQU1FJQ3pGM1E3ZmlyQ2tJSnplVXBQb1BsZEgzaHEzVDdESWF0Mmhh?=
 =?utf-8?B?ZUFxVVl1aE9xcW9iOHJkYmtTdGxhMVh4RndEUFNJMUJweS96R2dNUVpuRjYw?=
 =?utf-8?B?eWZpSHlMaEhnL2dsV1JvUXBIODlmaFZCaEhMeEJmeW14OUh2ejVyOTZwK3Ro?=
 =?utf-8?B?TFZheUZ4QnVjSkxrY3NhYzRtRjdFNGNmQzUxeTZ3TVpqQ3ZqbUtwcEs1OFVw?=
 =?utf-8?B?M3VqdlNaT2ZjQURiYy9vSUZtTnlTZUVsM2pRejVBSnJSaWcxbnRUMEh4Q3BS?=
 =?utf-8?B?dUI0WmZmNnR2S0YzN2M4QTN0UWFqY0p0dHprbnVJOWJCR3ZSYkpjSWFjN0xa?=
 =?utf-8?B?MU1ScC9USHdzVy9CK0lBQkFQN0dPdzZSMGVCeGRCeVVGYU8zRzlXRUxYOEpB?=
 =?utf-8?B?Z0JBaENCUytIbCt5NVpyYzl6WG0zdk0vRU5NS0RnOW5lVitkczdjejNhSkhk?=
 =?utf-8?B?Z3JuWk5MS3A4UGVnWEVPQThabkxjUUduQkpLR0R1RGpOZFhXYktQQ3JZejJL?=
 =?utf-8?B?Qy9pYnMyYUVvRVBFa1VzSUp1czVibmMwSXlrUm9HdXV2U25LL2lQS1BsL0ls?=
 =?utf-8?B?WG5TTWxUOXpNTW1uWnMwS1o4SmlYWm5oZ1Vtd2plK01rRnJlVDFhK1I5UFlM?=
 =?utf-8?B?SFBETjhoNGhWejM4TUpGZUxaZ0M0b1MwZzNrclV1S00zeDRuU25BUEM3cWw3?=
 =?utf-8?B?MUtxUGx4OFJsL2p3SVlNN3JXdzRGcDkwenV3eTN1WDZpMVBjMW5aNUJRMEgz?=
 =?utf-8?B?VnpmaEhmV2laaklxZ1d1QllsSzIvUkNSMjMzVlVUbDhQSHFSU1o5RThzTGpz?=
 =?utf-8?B?YjNpNkdDT2E0QkU1YUFNcUQ5UnAwVThIZWZuNGFtbnI0cWpyQTZzdXZGRG5C?=
 =?utf-8?B?SnJiOHhqWXNSM21ET1QxWXJCc0gyeGw1aFhMNG5laEVXL05yRVhxWEhsdEE1?=
 =?utf-8?B?eFpGSyttOHNtaUNVRUtWRGhpK0Q2RnF1TTQwb1FrcEt0N2FTVUdqVjRsQlIw?=
 =?utf-8?B?ZGFmdHltRDlqR3BpaGlnSW1jVzVxUk5MS3N1RENZTGRyUzBkUGtRTlQ2UWxs?=
 =?utf-8?B?SU0ySDRhcXhHK3JxcEVQODNiZkdUc0hCRW9XT3lMVjRXNEZCM2piYkozekxi?=
 =?utf-8?B?cmFBdG1YN1JyY1JhQzEzNFdmV29sR1MzTXI1aVdNcmhKbDF6Y1dlSGZHTGFo?=
 =?utf-8?B?L1A2TzlNQzhPVjFSWmlUTFpFVjNoM3lnbENGQTFVWWxlNHVwWFU2RERvd3lH?=
 =?utf-8?B?QmRBMVpQb2dGTEFTVmJPK3M3NXdpL1dURDFVeFZDUlJRTHArRWtDUitvWUNY?=
 =?utf-8?B?bUU2Z0lpc3BxVFRMNy9zcGhtd1BVSmVrK1VmcGVGKzV4ckg1NVJlUlJpbm85?=
 =?utf-8?B?aXBVOUVrM1l4dzd1cE96M1NadC9rU3RoQ1lyV3UzMmgyelZZOTlSSWVpdUdW?=
 =?utf-8?B?d0dVSWg2V0NtZ2FhZmR3bDVGMGtCMEZKMFMrUVNKdnl6OFltSmdYNncvcHhM?=
 =?utf-8?B?M0ZmRzVFS2xBeFlmVlBOKzA1dW1IcjQ5V0VMNm5mb1BMTmlMVEJzWk1IcEFw?=
 =?utf-8?B?dHJCbllVN3lhd1pQejNRc05nTVBwY01BNE5XYTNEMndBRDA1YzVwTUFqS0Ev?=
 =?utf-8?B?M1htNFkxU0dXMkNNOHpIMEIzdWFLUnZzYmx3VHNkeG1GSDhSc2FFTTlJeXJm?=
 =?utf-8?B?aGNTUDR5NWI0UGc4eDU2NGRrbzVwWTdVaC93bElZSkMzc0c1N3RmaU1JNTZZ?=
 =?utf-8?B?aFRGNDV1MVVURVJtQm1uRzF1ekVzRHozcUs5L29lRFJqa3ZVS3ZKclVieEFt?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0J3MTdFUFlzbVhtNWtpQW1NNlB6dUxBZHVlcHZmSEM3NzErUXovY1UvWGJh?=
 =?utf-8?B?cDJOS2JKY3Y5K1VqZHlQbHNEdjNDcTIwRWpLdnVNa295Y1RXNXJNdU1mdUlP?=
 =?utf-8?B?amlCcXg4Q1RjajI4bElwYll3SUFZZkhMWExtMWF2K0xqWWorNGgwR2VGODJ5?=
 =?utf-8?B?OCtiS3QrL1FLMUpBMzlEV3hQTktHNWF5My9wTjlxZ2RieC90M1dLVitFVEY5?=
 =?utf-8?B?L3o5Qys4Zk5jZFl1aWNoemdiazgrYktzc2xzV1dpaU9sbjBkb2FXVjQ3RDh5?=
 =?utf-8?B?Q0tiaUlCdndtQ293anYvck12bS9CblJnNk1DUFVtOWZtRDJKQ2ViYlN0ZStY?=
 =?utf-8?B?VXVobDdXdExlWk5UZWQ5Y1RzbVE3NjM5Y2VFSXZENENuSkxybVVmYXZOc01n?=
 =?utf-8?B?N0JXNTd2QzZ2M0htM1BwMmNhWGZ4aFZIZTc2S3BWVFFRdlNENUNvZSsxOUFR?=
 =?utf-8?B?U3BxNks3QmZhbVh1T1NMdVVDMHJ3akRqN2I5WVpDeGxDbHRDVGVmejFNTnkv?=
 =?utf-8?B?VVFKandBcnZjNkJEVG4vNStDa0tlRjVkeVVVRExnTGlnRS9sQmY0Nm81T3VI?=
 =?utf-8?B?dnd5RzFJNmtVVHRpMytUS09ONTFwY0luSzRWMmk0eUdJWGF0NmFBTWFzNHBW?=
 =?utf-8?B?bEZpTndFcjZrSzRkYlJWWXd6bGhCaCt5Z0Qrd0xRUFZhSkd0V1ltRnJGSzNI?=
 =?utf-8?B?Q0VjcDlhY1hhOHMwRk00ME1GVjlJaDlHb2JFUXAxRlZCR2RHeWw0ekllTlJD?=
 =?utf-8?B?OTNGN3phckxGa3FGZ3o0OVlqVHd6bnNuK1RHY3ZpSGU0OWNQb1lzSTBGY3Nz?=
 =?utf-8?B?SEI0TWV1UDVwMlZsdzBGSEFxbEZSb0haZWhpbVVhZUt6ZTRFNjh4QnZKa004?=
 =?utf-8?B?cE1tU0RoSjhFVU83ZkZqTDhZVW4yQldzVnFGZnVyU0xscW5QSUtCdEgzOERo?=
 =?utf-8?B?bkNrQ1JvenJNb0M2RnM0L0MyaCs1MHE0UG13VWhUOTh6RXY4M1M1VXp0bTV3?=
 =?utf-8?B?WHRielV1dGxHZ2ZnRWFYZVpTdWt5QzVjYkVLUG8yeFRvNlRpanIvQTZFcW03?=
 =?utf-8?B?eXo0N2xLOXRnaXJ3K0RDRWhaSllxMEdkNzFudXFFdU9zSWJTS2xiLy9NbnVm?=
 =?utf-8?B?dGFtd0hUdG1naE9Ec3JSYUFBa0ZlYUwvVzlmNVpQOGdpWnFpVFQ2UVF6bjJ1?=
 =?utf-8?B?Y0M4ZzFEK0VjMk9HWE9oTUg0UzhRbjJDbk5ONFlEaSt1NUhBc0dneCs3S2Zu?=
 =?utf-8?B?eGJvZ0NzWGR1UUV0bFNNaS9YTGc2dW5zeXFRdEpxdnl3U2RZbG1ZSCs3VDdn?=
 =?utf-8?B?SlFTbVZIeGdZbVhONkpxcjlkSE02MFJBMUoyZDAxbzE4VzFNNk5CMjMwWGx1?=
 =?utf-8?B?bkZGNjh1SUVQM2FRa1AxUjJ6T1N5OGFkSkc4MFVTQVM2bFg0L0xrNGQvV2lY?=
 =?utf-8?B?dS9tMnFqMG9pSitnWVhTS2JmeEc0TDR0UEJOUldTaXNvTGlBOVo3emRJRThl?=
 =?utf-8?B?WDdSY1dsU0dxdFdtelFZNysyeUEwVDViRVpkWXNBWlF0aklycEZaeStiWlNU?=
 =?utf-8?B?cHVWbDhQOU51ZjJtOEpyMkVwblhVNHUyQmFvQ2hMK2NoandpQ21DeEtsR2lq?=
 =?utf-8?B?RW1qVWxMdzdTRy9yV1VhUm9vd3BOMW02ZWZqaFdlUVBMcTI1UVc1S29ENmdj?=
 =?utf-8?B?bmhRMVZZTHVLdWwzOWtzQzdBd1EzSU5NRzlOWisvSmhtUXVyTUljVjJjdGFR?=
 =?utf-8?B?NlZqVXc0UDNZbHYvTDFRRjh3TTUrQ2ZjRTNEdEMyV0R4VVovTUFPU2xmVytJ?=
 =?utf-8?B?cEtJVi9adDZCNU85ZnRkZ1BSaHlvTjc4aUN0cVJGNU1wbDNJS0JZNUJsYXVO?=
 =?utf-8?B?eFhDL0tsb1F3RS91d0IrUHpiaXBYdUdtcEdlVEhSVEp5OFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd37c7-5bda-41c1-d908-08db622cc14a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 23:14:16.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9eErIANVhetKT6MA8FxIMwxK2EkEOLJH45On0XH74Qzxz77boPcXSTAYKTnBfR1DhVFmnw4Y/LaCkKJd6eVInPdDtFrdYbx5gbeiKC2SNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_17,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310196
X-Proofpoint-GUID: nI8VlTFoya7Ymtab0R7xJQNTFevS5Rq-
X-Proofpoint-ORIG-GUID: nI8VlTFoya7Ymtab0R7xJQNTFevS5Rq-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_161545_968406_5AB7DE2A 
X-CRM114-Status: GOOD (  24.79  )
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

Ck9uIDUvMjYvMjMgNjo1NyBBTSwgR293YW5zLCBKYW1lcyB3cm90ZToKPiBPbiBXZWQsIDIwMjMt
MDQtMjYgYXQgMTc6MDggLTA3MDAsIEFudGhvbnkgWXpuYWdhIHdyb3RlOgo+PiBTZW5kaW5nIG91
dCB0aGlzIFJGQyBpbiBwYXJ0IHRvIGd1YWdlIGNvbW11bml0eSBpbnRlcmVzdC4KPj4gVGhpcyBw
YXRjaHNldCBpbXBsZW1lbnRzIHByZXNlcnZlZC1vdmVyLWtleGVjIG1lbW9yeSBzdG9yYWdlIG9y
IFBLUkFNIGFzIGEKPj4gbWV0aG9kIGZvciBzYXZpbmcgbWVtb3J5IHBhZ2VzIG9mIHRoZSBjdXJy
ZW50bHkgZXhlY3V0aW5nIGtlcm5lbCBzbyB0aGF0Cj4+IHRoZXkgbWF5IGJlIHJlc3RvcmVkIGFm
dGVyIGtleGVjIGludG8gYSBuZXcga2VybmVsLiBUaGUgcGF0Y2hlcyBhcmUgYWRhcHRlZAo+PiBm
cm9tIGFuIFJGQyBwYXRjaHNldCBzZW50IG91dCBpbiAyMDEzIGJ5IFZsYWRpbWlyIERhdnlkb3Yg
WzFdLiBUaGV5Cj4+IGludHJvZHVjZSB0aGUgUEtSQU0ga2VybmVsIEFQSS4KPj4KPj4gT25lIHVz
ZSBjYXNlIGZvciBQS1JBTSBpcyBwcmVzZXJ2aW5nIGd1ZXN0IG1lbW9yeSBhbmQvb3IgYXV4aWxs
YXJ5Cj4+IHN1cHBvcnRpbmcgZGF0YSAoZS5nLiBpb21tdSBkYXRhKSBhY3Jvc3Mga2V4ZWMgdG8g
c3VwcG9ydCByZWJvb3Qgb2YgdGhlCj4+IGhvc3Qgd2l0aCBtaW5pbWFsIGRpc3J1cHRpb24gdG8g
dGhlIGd1ZXN0Lgo+IEhpIEFudGhvbnksCgpIaSBKYW1lcywKCgpUaGFuayB5b3UgZm9yIGxvb2tp
bmcgYXQgdGhpcy4KCj4KPiBUaGFua3MgZm9yIHJlLXBvc3RpbmcgdGhpcyAtIEknbSBiZWVuIHdh
bnRpbmcgdG8gcmUta2luZGxlIHRoZSBkaXNjdXNzaW9uCj4gb24gcHJlc2VydmluZyBtZW1vcnkg
YWNyb3NzIGtleGVjIGZvciBhIHdoaWxlIG5vdy4KPgo+IFRoZXJlIGFyZSBhIGZldyBhc3BlY3Rz
IGF0IHBsYXkgaW4gdGhpcyBzcGFjZSBvZiBtZW1vcnkgbWFuYWdlbWVudAo+IGRlc2lnbmVkIHNw
ZWNpZmljYWxseSBmb3IgdGhlIHZpcnR1YWxpc2F0aW9uIGFuZCBsaXZlIHVwZGF0ZSAoa2V4ZWMp
IHVzZS0KPiBjYXNlIHdoaWNoIEkgdGhpbmsgd2Ugc2hvdWxkIGNvbnNpZGVyOgo+Cj4gMS4gUHJl
c2VydmluZyB1c2Vyc3BhY2UtYWNjZXNzaWJsZSBtZW1vcnkgYWNyb3NzIGtleGVjOiB0aGlzIGlz
IHdoYXQgcGtyYW0KPiBhZGRyZXNzZXMuCj4KPiAyLiBQcmVzZXJ2aW5nIGtlcm5lbCBzdGF0ZTog
VGhpcyB3b3VsZCBpbmNsdWRlIG1lbW9yeSByZXF1aXJlZCBmb3Iga2V4ZWMKPiB3aXRoIERNQSBw
YXNzdGhyb3VnaCBkZXZpY2VzLCBsaWtlIElPTU1VIHJvb3QgcGFnZSBhbmQgcGFnZSB0YWJsZXMs
IERNQS0KPiBhYmxlIGJ1ZmZlcnMgZm9yIGRyaXZlcnMsIGV0Yy4gQWxzbyBjZXJ0YWluIHN0cnVj
dHVyZXMgZm9yIGltcHJvdmVkIGtlcm5lbAo+IGJvb3QgcGVyZm9ybWFuY2UgYWZ0ZXIga2V4ZWMs
IGxpa2UgYSBQQ0kgZGV2aWNlIGNhY2hlLCBjbG9jayBMUEogYW5kCj4gcG9zc2libGUgb3RoZXJz
LCBzb3J0IG9mIHdoYXQgWGVuIGJyZWFkY3J1bWJzIFswXSBhY2hpZXZlcy4gVGhlIHBrcmFtIFJG
Qwo+IGluZGljYXRlcyB0aGF0IHRoaXMgc2hvdWxkIGJlIHBvc3NpYmxlLCB0aG91Z2ggSU1PIHRo
aXMgY291bGQgYmUgbW9yZQo+IHN0cmFpZ2h0IGZvcndhcmQgdG8gZG8gd2l0aCBhIG5ldyBmaWxl
c3lzdGVtIHdpdGggZmlyc3QtY2xhc3Mgc3VwcG9ydCBmb3IKPiBrZXJuZWwgcGVyc2lzdGVuY2Ug
dmlhIHNvbWV0aGluZyBsaWtlIGlub2RlIHR5cGVzIGZvciBrZXJuZWwgZGF0YS4KClBLUkFNIGFz
IGl0IGlzIG5vdyBjYW4gcHJlc2VydmUga2VybmVsIGRhdGEgYnkgc3RyZWFtaW5nIGJ5dGVzIHRv
IGEKUEtSQU0gb2JqZWN0LCBidXQgdGhlIGRhdGEgbXVzdCBiZSBsb2NhdGlvbiBpbmRlcGVuZGVu
dCBzaW5jZSB0aGUgZGF0YQppcyBzdG9yZWQgaW4gYWxsb2NhdGVkIDRrIHBhZ2VzIHJhdGhlciB0
aGFuIGJlaW5nIHByZXNlcnZlZCBpbiBwbGFjZQpUaGlzIHJlYWxseSBpc24ndCB1c2FibGUgZm9y
IHRoaW5ncyBsaWtlIHBhZ2UgdGFibGVzIG9yIG1lbW9yeSBleHBlY3RlZApub3QgdG8gbW92ZSBi
ZWNhdXNlIG9mIERNQSwgZXRjLgoKT25lIGlzc3VlIHdpdGggcHJlc2VydmluZyBub24tcmVsb2Nh
dGFibGUsIHJlZ3VsYXIgbWVtb3J5IHRoYXQgaXMgbm90CnBhcnRpdGlvbmVkIGZyb20gdGhlIGtl
cm5lbCBpcyB0aGUgcmlzayB0aGF0IGEga2V4ZWMga2VybmVsIGhhcyBhbHJlYWR5CmJlZW4gbG9h
ZGVkIGFuZCB0aGF0IGl0cyBwcmUtY29tcHV0ZWQgZGVzdGluYXRpb24gd2hlcmUgaXQgd2lsbCBi
ZSBjb3BpZWQKdG8gb24gcmVib290IHdpbGwgb3ZlcndyaXRlIHRoZSBwcmVzZXJ2ZWQgbWVtb3J5
LiBFaXRoZXIgc29tZSB3YXkgb2YKcmUtcHJvY2Vzc2luZyB0aGUga2V4ZWMga2VybmVsIHRvIGxv
YWQgc29tZXdoZXJlIGVsc2Ugd291bGQgYmUgbmVlZGVkLApvciBrZXhlYyBsb2FkIHdvdWxkIG5l
ZWQgdG8gYmUgcmVzdHJpY3RlZCBmcm9tIGxvYWRpbmcgd2hlcmUgbWVtb3J5CgptaWdodCBiZSBw
cmVzZXJ2ZWQuIFBsdXNzZXMgZm9yIGEgcGFydGl0aW9uaW5nIGFwcHJvYWNoLgoKCj4KPiAzLiBF
bnN1cmluZyBodWdlL2dpZ2FudGljIG1lbW9yeSBhbGxvY2F0aW9uczogdG8gaW1wcm92ZSB0aGUg
VExCIHBlcmYgb2YKPiAyLXN0YWdlIHRyYW5zbGF0aW9ucyBpdCdzIGJlbmVmaWNpYWwgdG8gYWxs
b2NhdGUgZ3Vlc3QgbWVtb3J5IGluIGxhcmdlCj4gY29udGlndW91cyBibG9ja3MsIHByZWZlcmFi
bHkgUFVELWxldmVsIGJsb2NrcyBmb3IgbXVsdGktR2lCIGd1ZXN0cy4gSWYKPiB0aGUgYnVkZHkg
YWxsb2NhdG9yIGlzIHVzZWQgdGhpcyBtYXkgYmUgYSBjaGFsbGVuZ2UgYm90aCBmcm9tIGFuCj4g
aW1wbGVtZW50YXRpb24gYW5kIGEgZnJhZ21lbnRhdGlvbiBwZXJzcGVjdGl2ZSwgYW5kIGl0IG1h
eSBiZSBkZXNpcmFibGUgdG8KPiBoYXZlIHN0cm9uZ2VyIGd1YXJhbnRlZXMgYWJvdXQgYWxsb2Nh
dGlvbiBzaXplcy4KQWdyZWVkIHRoYXQgZ3VhcmFudGVlaW5nIGxhcmdlIGJsb2NrcyBhbmQgZnJh
Z21lbnRhdGlvbiBhcmUgaXNzdWVzIGZvcgpQS1JBTS7CoCBPbmUgcG9zc2libGUgYXZlbnVlIHRv
IGFkZHJlc3MgdGhpcyBjb3VsZCBiZSB0byBzdXBwb3J0IHByZXNlcnZpbmcKCmh1Z2V0bGIgcGFn
ZXMuCgoKPgo+IDQuIFJlbW92aW5nIHN0cnVjdCBwYWdlIG92ZXJoZWFkOiBXaGVuIGRvaW5nIHRo
ZSBodWdlL2dpZ2FudGljCj4gYWxsb2NhdGlvbnMsIGluIGdlbmVyYWxseSBpdCB3b24ndCBiZSBu
ZWNlc3NhcnkgdG8gaGF2ZSA0IEtpQiBzdHJ1Y3QKPiBwYWdlcy4gVGhpcyBpcyBzb21ldGhpbmcg
d2l0aCBkbWVtZnMgWzEsIDJdIHRyaWVzIHRvIGFjaGlldmUgYnkgdXNpbmcgYQo+IGxhcmdlIGNo
dW5rIG9mIHJlc2VydmVkIG1lbW9yeSBhbmQgbWFuYWdpbmcgdGhhdCBieSBhIG5ldyBmaWxlc3lz
dGVtLgpIYXMgdXNpbmcgREFYIGJlZW4gY29uc2lkZXJlZD8gTm90IGZhbWlsaWFyIHdpdGggZG1l
bWZzIGJ1dCBpdCBzb3VuZHMKCmZ1bmN0aW9uYWxseSBzaW1pbGFyLgoKCj4KPiA1LiBNb3JlICJh
ZHZhbmNlZCIgbWVtb3J5IG1hbmFnZW1lbnQgQVBJcy9pb2N0bHMgZm9yIHZpcnR1YWxpc2F0aW9u
OiBCZWluZwo+IGFibGUgdG8gc3VwcG9ydCB0aGluZ3MgbGlrZSBETUEtZHJpdmVuIHBvc3QtY29w
eSBsaXZlIG1pZ3JhdGlvbiwgbWVtb3J5Cj4gb3ZlcnN1YnNjcmlwdGlvbiwgY2FydmluZyBvdXQg
Y2h1bmtzIG9mIG1lbW9yeSBmcm9tIGEgVk0gdG8gbGF1bmNoIHNpZGUtCj4gY2FyIFZNcywgbW9y
ZSBmaW5lLWdyYWluIGNvbnRyb2wgb2YgSU9NTVUgb3IgTU1VIHBlcm1pc3Npb25zLCBldGMuIFRo
aXMKPiBtYXkgYmUgZWFzaWVyIHRvIGFjaGlldmUgd2l0aCBhIG5ldyBmaWxlc3lzdGVtLCByYXRo
ZXIgdGhhbiBjb3VwbGluZyB0bwo+IHRlbXBmcyBzZW1hbnRpY3MgYW5kIGlvY3Rscy4KPgo+IE92
ZXJhbGwsIHdpdGggdGhlIGFib3ZlIGluIG1pbmQsIG15IHRha2UgaXMgdGhhdCB3ZSBtYXkgaGF2
ZSBhIHNtb290aGVyCj4gcGF0aCB0byBpbXBsZW1lbnQgYSBtb3JlIGNvbXByZWhlbnNpdmUgc29s
dXRpb24gYnkgZ29pbmcgdGhlIHJvdXRlIG9mIGEKPiBuZXcgcHVycG9zZS1idWlsdCBmaWxlIHN5
c3RlbSBvbiB0b3Agb2YgcmVzZXJ2ZWQgbWVtb3J5LiBTb3J0IG9mIGxpa2UKPiBkbWVtZnMgd2l0
aCBwZXJzaXN0ZW5jZSBhbmQgc3BlY2lmaWNhbGx5IHN1cHBvcnQgZm9yIGtlcm5lbCBwZXJzaXN0
ZW5jZS4KPgo+IERvZXMgbXkgdGFrZSBoZXJlIG1ha2Ugc2Vuc2U/ClllcywgSSBiZWxpZXZlIHNv
LiBUaGVyZSBhcmUgc29tZSBzZXJpb3VzIGlzc3VlcyB3aXRoIFBLUkFNIHRvIGFkZHJlc3MKYmVm
b3JlIGl0IGNvdWxkIGJlIHRydWx5IHZpYWJsZSAoZnJhZ21lbnRhdGlvbiwgcmVsb2NhdGlvbiwg
ZXRjKSwgc28KCmEgbWVtb3J5IHBhcnRpdGlvbmluZyBhcHByb2FjaCBtaWdodCBiZSB0aGUgd2F5
IHRvIGdvLgoKCj4KPiBJJ20gaG9waW5nIHRvIHB1dCB0b2dldGhlciBhbiBSRkMgZm9yIHNvbWV0
aGluZyBsaWtlIHRoZSBhYm92ZSAoZG1lbWZzCj4gd2l0aCBwZXJzaXN0ZW5jZSkgc29vbiwgZm9j
dXNpbmcgb24gaG93IHRoZSBJT01NVSBwZXJzaXN0ZW5jZSB3aWxsIHdvcmsuCj4gVGhpcyBpcyBh
biBpbXBvcnRhbnQgZGlmZmVyZW50aWF0aW5nIGZhY3RvciB0byBjb3ZlciBpbiB0aGUgUkZDLCBJ
TU8uCgpHcmVhdCEgSSdsbCBrZWVwIGFuIGV5ZSBvdXQgZm9yIGl0LgoKCkFudGhvbnkKCgo+Cj4+
IFBLUkFNIHByb3ZpZGVzIGEgZmxleGlibGUgd2F5Cj4+IGZvciBkb2luZyB0aGlzIHdpdGhvdXQg
cmVxdWlyaW5nIHRoYXQgdGhlIGFtb3VudCBvZiBtZW1vcnkgdXNlZCBieSBhIGZpeGVkCj4+IHNp
emUgY3JlYXRlZCBhIHByaW9yLgo+IEFGQUlDVCB0aGUgbWFpbiBkb3duLXNpZGUgb2Ygd2hhdCBJ
J20gc3VnZ2VzdGluZyBoZXJlIGNvbXBhcmVkIHRvIHBrcmFtLAo+IGlzIHRoYXQgYXMgeW91IHNh
eSBoZXJlOiBwa3JhbSBkb2Vzbid0IHJlcXVpcmUgdGhlIHVwLWZyb250IHJlc2VydmluZyBvZgo+
IG1lbW9yeSAtIGFsbG9jYXRpb25zIGZyb20gdGhlIGdsb2JhbCBzaGFyZWQgcG9vbCBhcmUgZHlu
YW1pYy4gSSdtIG9uIHRoZQo+IGZlbmNlIGFzIHRvIHdoZXRoZXIgdGhpcyBpcyBhY3R1YWxseSBh
IGRlc2lyYWJsZSBwcm9wZXJ0eSB0aG91Z2guIENhcnZpbmcKPiBvdXQgYSBsYXJnZSBjaHVuayBv
ZiBzeXN0ZW0gbWVtb3J5IGFzIHJlc2VydmVkIG1lbW9yeSBmb3IgYSBwZXJzaXN0ZWQKPiBmaWxl
c3lzdGVtIChhcyBJJ20gc3VnZ2VzdGluZykgaGFzIHRoZSBhZHZhbnRhZ2VzIG9mIHJlbW92aW5n
IHN0cnVjdCBwYWdlCj4gb3ZlcmhlYWQsIHByb3ZpZGluZyBiZXR0ZXIgZ3VhcmFudGVlcyBhYm91
dCBodWdlL2dpZ2FudGljIHBhZ2UKPiBhbGxvY2F0aW9ucywgYW5kIHByb2JhYmx5IG1ha2VzIHRo
ZSBrZXhlYyByZXN0b3JlIHBhdGggc2ltcGxlciBhbmQgbW9yZQo+IHNlbGYgY29udGFpbmVkLgo+
Cj4gSSB0aGluayB0aGVyZSdzIGFuIGFyZ3VtZW50IHRvIGJlIG1hZGUgdGhhdCBoYXZpbmcgYSBj
bGVhcmx5LWRlZmluZWQgbGFyZ2UKPiByYW5nZSBvZiBtZW1vcnkgd2hpY2ggaXMgcGVyc2lzdGVk
LCBhbmQgdGhlIHJlc3QgaXMgbm9ybWFsICJlcGhlbWVyYWwiCj4ga2VybmVsIG1lbW9yeSBtYXkg
YmUgcHJlZmVyYWJsZS4KPgo+IEtlZW4gdG8gaGVhciB5b3VyIChhbmQgb3RoZXJzKSB0aG91Z2h0
cyEKPgo+IEpHCj4KPiBbMF0gaHR0cDovL2RhdmlkLndvb2Rob3Uuc2UvbGl2ZS11cGRhdGUtaGFu
ZG92ZXIucGRmCj4gWzFdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy84MzkyMTYvCj4gWzJdIGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzEyLzcvMzQyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
