Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F66EB64DD
	for <kexec@archiver.kernel.org>; Fri, 21 Jul 2023 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNR0syu5qVoysOtBLutfWGmQtDMu4vFAgi5D1GUiv3M=; b=T3IF+0E48QUHtstkSwHeH+uuFx
	GSz4ivbB+vMYR6wqOp0PLTKuphizmH5rqSX1vbjtbFs74uuBLKikCEObHk6J/65hsubmTFvLeHtXT
	/6G75snuLQ5+UbrPfJ6WBhpNKV1BOylBgdbSI+hhXSP1y2z9qJQV5uZK/zmPG0yh+Y9gmw99oxO5j
	SS2fKT4o2UGDaO3h6RA5VRhHxPeCHcrPeb8FuxX2oenyPxnFE4P1YiM6B7Cxyk82Huu+QCKE1HE5U
	6Wwe4efNqzRqa0xUDEDY9iVyO9nH0u8rzQI4yAVBWJKgy92QMyvxdiwv/SGd4qYludXuUruja8tZr
	XOAKd/bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMt3m-00EbOi-0Y;
	Fri, 21 Jul 2023 16:32:54 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMt3i-00EbNf-3B
	for kexec@lists.infradead.org;
	Fri, 21 Jul 2023 16:32:52 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEGEi2003849;
	Fri, 21 Jul 2023 16:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HWByv861nrO9TNW0942R7zYddd561p62PJx4QHCHXGg=;
 b=Pal3m49b8LQgtMDXANE3zfs9T+RuAOTTFqOoZTXp1guvu5ap9H1IRfzhrpTFwS2pQ9DZ
 SG8jYIr+Z0Ud9SnHWM6YVkBKElm3iTT0msJ3GwMBgtA5R4fHJqb4VjDD3+hZb3NMYO8c
 StVlluvA8l4tKhyZfgQf1iglJZviumCSfvx9gkRwvL3p9VdyPk09lnefbEVpPc6zcLSd
 y57l4v+757OpDvcD3WAe6j1zDL7AWxnZyUbNf77GexaMSVCwQB9TxihIMiW/wSttTlcI
 XQNZHZVkEEHYTpXJMfko6AMLd4gnn6lPw97xiPjdWhezok237pv+bT21EBKvGNlOKqTz lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a4cex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 16:32:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36LF4XQL019175;
	Fri, 21 Jul 2023 16:32:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhwap5j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 16:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUO+9VvoJDvnNjmGcMdKMKiQwkxtLLvxODQNQNY1NZr8cOWcfU07gC9aUg6reNfQlDE+JHa2a1/XVQ8YiT9s87khgpkZQRdvKe3+qjCUiSEH5qEuahwqGGjy4c30Nx5Q4i8+Khh7x+nNDTHxWrBpOTKvk3slYpphL9z+m/np9Y12xay/uKfc0OLse12R9LqVGeBoqejQRpaNH2Z77W9bApgDLKEkH6mlIh2unglfXMs+FSNPn1ivdJjNzMa8jPDvGB4OYn/D5lNiy1Uv+TWfXB78AcIHUHuzUV4D+rlq/CoTYI9r5I5LMqRlAZ6Zei7mtn0aBPn844ueD2ufOdJOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWByv861nrO9TNW0942R7zYddd561p62PJx4QHCHXGg=;
 b=HmWbHQiHqwndnVhU3DqWep3ciw9MUCN1T7qCGCgxa0Ehp61pj98VnVxaAtdcpxeWOj2dh55icqZQi3iSr+nCymom+3SmufuRbsxq8/1Rj2BKHLofcDv5s2a4IQQPCoWHQNGQ17BVVBCMoJ8ELCj4m/fgo9u+YJjxqSw6NgNIov1ep06au8NBQbDt57oHAMr4gYwJmhjNE8fny++cK/tN67MKUKGc7SN/27uHjzJKA87NQmIk0TPI3YzFAMH6XTrHJJXXArkwaAIkqu2FRyqjNFGVro5junCBbqeqgN6gT93+J0+5hlyldK0pOIOQKPSQ4jd29MnNbL/aSS2toeUJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWByv861nrO9TNW0942R7zYddd561p62PJx4QHCHXGg=;
 b=Kf7w1hol3l5moWN4spACHE9n/WdH/YS+A1/Bb0TtO2mt9vM10780ck1/F8PzUBL+U03d7Ket9RR8N2QG4WvM1c59+f8brpwEvPZ/nDdKaWcYd6+QRyiXHxke1B2j68nqs5iwNCwTN8T9RemBjqqjCHbFWhz0+lk8xlT2h0bR2YI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB5372.namprd10.prod.outlook.com (2603:10b6:610:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 16:32:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::a7b5:113e:6f8c:5028]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::a7b5:113e:6f8c:5028%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:32:19 +0000
Message-ID: <6d2811f5-a5ee-a49d-012d-b519b2c6ee26@oracle.com>
Date: Fri, 21 Jul 2023 11:32:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Content-Language: en-US
From: Eric DeVolder <eric.devolder@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de, seanjc@google.com,
        linux@weissschuh.net, vschneid@redhat.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
 <2023070342-human-spill-a62c@gregkh>
 <31c1393d-4285-0032-7675-737737d21f71@oracle.com>
In-Reply-To: <31c1393d-4285-0032-7675-737737d21f71@oracle.com>
X-ClientProxiedBy: SN4PR0501CA0014.namprd05.prod.outlook.com
 (2603:10b6:803:40::27) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d612bd-de1b-4301-0c4f-08db8a080db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TODz/Y7IhLbcGTSkFU1VVYW+SrdKOEO/9iXm4JNPb6m8XOlMycWrzw95Z4U5CwU71zjBcYObcKzYiY01mQERq5H1gkORaXQu+sehsN6FxI1vYfZp5NJnBGTfQ1/AGC6ioa1t5LrQr3s+M4TWti5tjSCF0/euoudiVmkqQeyDiH37IDAdeTXUB5PTb1oIH2wU3ziTm6781VmhLxOnhfuEjz+hRKsB65YBuIrMFQlGvO64RUda3EDkDjfI8iRLlq66oUpRNPVoMyeKY40JwVIrf9t1Ejs2BqavvZQay2LICDCRGUNvvNgrlfkS8wED81/ICW55YrrDHk+ADofR4bDbc3vNRskGV5Pfn7WR6wQh3mFmkOHihKI0WPFpM1KqU2e6tcoONF81clifsJLipxzzjDvmsDPTOKRcXzrHId3eCeg5LGQB69STqpvXT1CsBs13bR5DkEmnI5WetbrozuRzMl/Wvbv0kRxlg+5LYTptSfJ2No2iCvqv+EgWAY8V/telEMub57QLFKnIgS/oMqxOckM2kXeTCGKNg5rQyNbHdPGet5MpSh0WO9zeKrOejwYadyTUfjU46a2yh+XsF1mMDoVK+H5FQ3Mh4noiQ5cK1gcopk0IiS5tKwz4HMvBcocUKm5Ma5epEGYyqOxFNGSFh2co5kccqQGGnk5DNcScbxxRzEfpvj4kmG6pBo9SskW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(6666004)(6512007)(107886003)(6916009)(316002)(4326008)(6486002)(186003)(26005)(31686004)(53546011)(6506007)(41300700001)(478600001)(5660300002)(8936002)(7416002)(7406005)(8676002)(66946007)(66476007)(66556008)(2906002)(2616005)(83380400001)(38100700002)(31696002)(36756003)(86362001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBjTFR0T05XK1d3cG4vT0RwQUtkYlFKQWlRQnZUK1lSaE9ROWhtSk5SYVFn?=
 =?utf-8?B?RjIxamRPSjQ5ajNJaEtXdlNrd2REdENJS21WUWFMaTVQb1hnaTQvVytvOXVW?=
 =?utf-8?B?ZmN1SUZuZWZnUitsNHJCZ044RStkUjVmdy80OEVXMjNkV3A3aHZhNWcwSnU4?=
 =?utf-8?B?N1hITHkxM3JCOVA4ei9sSXN4bzdTWlhWclRmME5sbXZ2OGRNNlpNWU0zWFpD?=
 =?utf-8?B?KytqMXhvNEE0Um5heVBqSG8zZGtoVlloSlordmJ0WlNtaXR6NnBXQ0x4N3BB?=
 =?utf-8?B?ZTN2dlpObnpJT1FxN1N1OUpDa0lBSkViTXdpVFc1YjF6MjFreEFsYU5ZaE44?=
 =?utf-8?B?TmtuMytOLzZiUmZ0aVJpTFBlclBobDVDejJQdUJmU1U0Z0RpM3N1Vkp3Slp6?=
 =?utf-8?B?aGNSZEdwWUx3QWJCQjhDM01pN3FqMmxZRTdCTUFXakVUbHpYNlJyWkt1MC9K?=
 =?utf-8?B?YU96L1ZHcnVFZ3QyTmc3K3d0akVuci9BWmdKN2I4UEUxTnNGdnlZL3ZXbTE1?=
 =?utf-8?B?T3I3T0h3UllTNWQwVTNYU2tQaEpLeVprdlhIa3ZsZlhYV0lueU5RLzVoWTMx?=
 =?utf-8?B?ZHk3ZXdwL0RSaHluNUw4cy9mRE5CbXhxTHhENExpRHBOdHZQYlBFVFBjSm5m?=
 =?utf-8?B?SkZFZDJkUXRLR0JkM0NZbVB2Vit5K0lxUktSNkhETVg3MFVTaElpR3NZNEt6?=
 =?utf-8?B?VnB5bm9aTjBEL2dSdVRzSG10YTRaKzR1bzQwUm1xQkhVVFQvMzIvd0xYZ3U4?=
 =?utf-8?B?L2pwbjZDYVhVenU3L1BtUUk2ai94ZzNzM3BoYjBHVGl1ZGNtbkwrZ2xlazAy?=
 =?utf-8?B?TklWS216STI1MWFuUndOSjVrRFl6RFNVa2FmSXlYdVhQaWVBSTdwa2h1YjhO?=
 =?utf-8?B?NjlhUyt4NE9xeDBlZWtGckE4UTU0eVc0WDdVcEVhcTRDczRMbkM5d0RvdWJy?=
 =?utf-8?B?b3luU05WLzlKM21ldEpYOWlHUERhR0lTMXRpRFh0enl4L0UxOS9yVTdqdW9m?=
 =?utf-8?B?T2krWmNTaE15RGtkT3VQeW9EUEU5TzB2cU1YRzVDNlVGNEV3cWRzTXh0SDQ2?=
 =?utf-8?B?OVJtVWMxWVZnY2xONUtZU0RZTVBmWUdic1FndU54Z05oSHZVZmdidkd1SjNK?=
 =?utf-8?B?ZFRnVEFERnRHUmtQUWZqNDNqdXc5dzFHMVViY0xMNXpnVU5wNk5qMGF3Lytt?=
 =?utf-8?B?NEc1VFFxK0MyUWJWTFNGOUlLeHFRQmlwOTNFaEd6dkhGc2l3MXVGcGc0blhD?=
 =?utf-8?B?ZWIrR3NSM0M0b29nU3MyaVZHc2xtYWxuVkY1algwL2ovM2dLN1FCRTRHanVX?=
 =?utf-8?B?NXdjTS9jRmU2ekxGNExBRHZRTDc2Nmh4elFsT05IeW5nTHRQcVUxdlhjck9Z?=
 =?utf-8?B?QXFJODdFT25ubFhhazFkSkRGT2FkV3BSOENRc2pzM1Zyd0NENExtV1YwYWRr?=
 =?utf-8?B?UmZSV2hPK042ZkRleU1sWnk0T1NmcS9GSCtuZTRIeVFxcFZjTkF2WEhVMEpj?=
 =?utf-8?B?SVhIcmhvb0VCY01tOGVQakV4MlZrVU9pN0pmak8rTjd6cFZkaTAwR3JTMlcz?=
 =?utf-8?B?anRpMENrWTNBL2t0SEZ0SVBUZTJrV1dWQVlCUHl2dHVlbTEyNFdiY1VvOGUz?=
 =?utf-8?B?RTYrTnZSRVZpZWdiWkxBVjlyYWI2eTdDOVVTb0xIY0kwQU1LVkNYZEMrSzhK?=
 =?utf-8?B?MHJrU0F3QVpieGFBNE0rYXdVNS9jZlZtYVVrSVVTWUFsWGVYaG56WnpiZ2No?=
 =?utf-8?B?dnozM0h3YkpBVzRhaUlZdWZ6UG96R1JIWTQxd3VXWk1INGVzaEsxcy9WeGNr?=
 =?utf-8?B?YnVhcldCKzN0UzVUMzFucGZoT29NVFE2b2dja3lFUUc1aGVoRm5RSWx0ZjAv?=
 =?utf-8?B?UG9QRHVCOEpDL3A3dUg2OHQyeUk4Y1c3MGsrQjB1d0wrTEdvWHRTa3BtWVhr?=
 =?utf-8?B?TUoyc0hpbWtWZ0hhMmk2VXAvWTczYWJPK3o3dGwraXpGdHVEalVzYXVwYW9L?=
 =?utf-8?B?VFI1Y1VUQkJJc2lrTFJKcVZVd1N6cVRIT3piajlqdHZpUUxDVDVMK0I0OVQr?=
 =?utf-8?B?R1Q4aVdGcVlkY1FMeVJzV1lOSk1MQ1BkdXpYM2NNR0dmYUlkTVhOdTV6dm9L?=
 =?utf-8?Q?1/9K2ZqaQ+JbImu/oLP3Yj6mL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZHNEZGxBeEdidm1qVTMzYUpJaWJBdXpXd0tua1JIUXRPLzZNelB1ZFhteFpJ?=
 =?utf-8?B?ZnZMaXE2RVBnWnRJdDlMMWlBV1k2YjFvdmZjRHNITkxvQWxxTUhjeFBQamlE?=
 =?utf-8?B?bERVWXRHbWpWNmROaEhSc0ZoQVpLQjZoR0hreHA4RnZPVWRLNkR6L0tMSGxs?=
 =?utf-8?B?blBQRHNSbFZnZlFCMnF2NWxxb1BGZjIvUmpQcnozR3JKMkg3Ly9DYW9zcVNm?=
 =?utf-8?B?MXR2dmVOMXl3bTdqV3UySG0zUUc0VGtHM3E5TkJsOXl5eGM1VTd0SWNMeDA4?=
 =?utf-8?B?c2o5UnAxeENmYk9wRHBveVpyRDRVVC95M1dDRU1xU0kva2dMN05LVzl1VGRF?=
 =?utf-8?B?SUQ5bXFpYlJEdktlNWt5WVJDNkQ0Q3JwaWZteWhrb2k5NGZaRnJrc3JWeFB0?=
 =?utf-8?B?QW9YOFNKd2dCSnFwVm03VlVtU0tjVjBJWlRTWjdaVWlqNFkzb0tqa2ZyRDV6?=
 =?utf-8?B?cW9YbW14Q1hPVVFmTXFxU0E2cGZOZVd0b0gyd29tNlpKcWk3ZUxRRTBPR2JU?=
 =?utf-8?B?dmZDK2ZYWGYrM1RIMkdBaUloMGljMHNrMktyTGhpcFN4KzVmRTRyaFBZSlFj?=
 =?utf-8?B?SVFzQkdDenFYbzRjSWF6d1BEOHppUEZySWVkbTlyZ2ZlUitQN1lONjl1dERU?=
 =?utf-8?B?dDlIR1NoUFhnTTltODhDLytGcXNZemRpdEhSamZDcnNmQmE0ZEsyZytGSHZ2?=
 =?utf-8?B?T2t5TjFHQnJYbWdWakd0MUdxRTUrRll5Q016NTR4UGNUNkF2NWtiWUFsdW5v?=
 =?utf-8?B?SnVkOHdMYkpQc3gwRTVVbWFibDR2M2w4WWZrWEpsRktmWWVnUXpEKzZOVGw1?=
 =?utf-8?B?bm9MeVRSb1pPeTJlUW9BeWJOaWMrQ0RRVHUvRk1Jenhxb0VQTGVsT0kzTnN3?=
 =?utf-8?B?QzhBTzFEbFNsUUJYdXV4UXFYL05nYjZmN3RLUVMydmZiaHRDTGhQaU5FTFRO?=
 =?utf-8?B?YWdKYjMzN2ZKdmtNK0NTRXNaTnh6a293Ym5JRkNHU25pREUyWjBWWEpXcFV3?=
 =?utf-8?B?Q2dPNUxpK0IxOUVIM0VybzVwNkN6RVU1N29GT3Bkd1lma2J0UWVab2l3aTRO?=
 =?utf-8?B?UlJPUGJac01xMHdpd2JGS0d0QTNHV1VEY0Y3ZGFKUGM5MC82TjM0ZURYVHMz?=
 =?utf-8?B?NDV2VEpaNVhBZ1BLSUJ4QTArMEkxdkJTSGdjbHVXWGozUTJGUlFvY05QR1Yw?=
 =?utf-8?B?VFpVSEJTUG9UTnA4MjFiRXFSQ25mM1Rhb0ZXZk9uNGVialR2dk4vNXJPS2R5?=
 =?utf-8?B?WkV5eUlkWkVZUGI5VGtJNDBFbllnVjBncjFiK3ZQRHRPcTVqQitIVmxVYW51?=
 =?utf-8?B?ZU1kSlRjL3Q1QTM5dFR3RkRyWFpqcVRlbFU1MGQyL1RLRm5QWURHdXNUYXBy?=
 =?utf-8?B?aWhuVDRBQU1IZnNFc1VqWDJYUkQwMkhhNVpzTXdmc0JOL1pPcWo5dlhrczYz?=
 =?utf-8?B?S3JSL3p6ajJhTlZoMW84VWNlNlJiNDJGUmNkR0JWRHJJQ2lMUmtxT3B2b09E?=
 =?utf-8?B?cnQ5SW5oS3c4ejQyUU9nQVNMSUNvREE5YU5GUVVDeTVvd2ZJR2h5YmZMS1Bw?=
 =?utf-8?B?eUowVmp0TnI4WTc2bkFoSzF4RUFqeEI5SFR4VTNzU3dTVGZKZ3luR3V6eVZ4?=
 =?utf-8?B?ZlFOdXVsK2doZ0QyelhmNFpmZTUxSGlVTG1YK1VRcWRMbzBQZE9TcnZjZnpV?=
 =?utf-8?B?cmhSYS8rdDNxT3hrTlFjWGlGU0xpKzVreTFrQ2UxcjRHL0h3OXprYVFtV1Fr?=
 =?utf-8?B?VG9KQnZLbm9uc3BhdDM4bCtIc3FrN3p5UktsVW5ISEF5WlJBbUFaRUFqaWZN?=
 =?utf-8?B?VFgxci9XV0trV0Z5cW5ud3BQT1lFM3IwWFJLUXN2c2FIZ054TEwvQm1nakdk?=
 =?utf-8?B?UCsyckJmbkgrN1AzR1Axb2dvakJFbUpNQ1RLYlQ2b0dtYUdnbmhsRHFoMFFN?=
 =?utf-8?Q?s9hIgSyooKY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d612bd-de1b-4301-0c4f-08db8a080db2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:32:19.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrkqtzd8gw/+TZwoecQdOLAzxpVMT6DAdxS0xYtZH3s0fWEyU/lhlwQBbhLhKESSOx1ODAD6hhZI4W7C3XO3Pt9LyssjjODQHRC4qV7gsD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210144
X-Proofpoint-ORIG-GUID: _navfhUWneorfAxf2PDAnqus4TK6YeeJ
X-Proofpoint-GUID: _navfhUWneorfAxf2PDAnqus4TK6YeeJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_093251_036134_E4D0C13F 
X-CRM114-Status: GOOD (  33.25  )
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

CgpPbiA3LzMvMjMgMTE6NTMsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4gCj4gCj4gT24gNy8zLzIz
IDA4OjA1LCBHcmVnIEtIIHdyb3RlOgo+PiBPbiBUaHUsIEp1biAyOSwgMjAyMyBhdCAwMzoyMTox
MFBNIC0wNDAwLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Pj4gwqAgLSB0aGUgZnVuY3Rpb24gYm9k
eSBvZiB0aGUgY2FsbGJhY2sgZnVuY3Rpb25zIGFyZSBub3cgd3JhcHBlZCB3aXRoCj4+PiDCoMKg
wqAgSVNfRU5BQkxFRCgpOyBhcyB0aGUgY2FsbGJhY2sgZnVuY3Rpb24gbXVzdCBleGlzdCBub3cg
dGhhdCB0aGUKPj4+IMKgwqDCoCBhdHRyaWJ1dGUgaXMgYWx3YXlzIGNvbXBpbGVkLWluICh0aG91
Z2ggbm90IG5lY2Vzc2FyaWx5IHZpc2libGUpLgo+Pgo+PiBXaHkgZG8geW91IG5lZWQgdG8gZG8g
dGhpcyBsYXN0IHRoaW5nP8KgIElzIGl0IGEgY29kZSBzYXZpbmdzIGdvYWw/wqAgT3IKPj4gc29t
ZXRoaW5nIGVsc2U/wqAgVGhlIGZpbGUgd2lsbCBub3QgYmUgcHJlc2VudCBpbiB0aGUgc3lzdGVt
IGlmIHRoZQo+PiBvcHRpb24gaXMgbm90IGVuYWJsZWQsIHNvIGl0IHNob3VsZCBiZSBzYWZlIHRv
IG5vdCBkbyB0aGlzIHVubGVzcyB5b3UKPj4gZmVlbCBpdCdzIG5lY2Vzc2FyeSBmb3Igc29tZSBy
ZWFzb24/Cj4gCj4gVG8gYWNjb21tb2RhdGUgdGhlIHJlcXVlc3QsIGFsbCBERVZJQ0VfQVRUUigp
IG11c3QgYmUgdW5jb25kaXRpb25hbGx5IHByZXNlbnQgaW4gdGhpcyBmaWxlLiBUaGUgCj4gREVW
SUNFX0FUVFIoKSByZXF1aXJlcyB0aGUgLnNob3coKSBjYWxsYmFjay4gQXMgdGhlIGNhbGxiYWNr
IGlzIHJlZmVyZW5jZWQgZnJvbSBhIGRhdGEgc3RydWN0dXJlLCAKPiB0aGUgY2FsbGJhY2sgaGFz
IHRvIGJlIHByZXNlbnQgZm9yIGxpbmsuIEFsbCB0aGUgY2FsbGJhY2tzIGZvciB0aGVzZSBhdHRy
aWJ1dGVzIGFyZSBpbiB0aGlzIGZpbGUuCj4gCj4gSSBoYXZlIHR3byBiYXNpYyBjaG9pY2VzIGZv
ciBndXR0aW5nIHRoZSBmdW5jdGlvbiBib2R5IGlmIHRoZSBjb25maWcgZmVhdHVyZSBpcyBub3Qg
ZW5hYmxlZC4gSSBjYW4gCj4gZWl0aGVyIHVzZSAjaWZkZWYgb3IgSVNfRU5BQkxFRCgpLiBUaG9t
YXMgaGFzIG1hZGUgaXQgY2xlYXIgSSBuZWVkIHRvIHVzZSBJU19FTkFCTEVEKCkuIEkgY2FuIAo+
IGNlcnRhaW5seSB1c2UgI2lmZGVmICh3aGljaCBpcyB3aGF0IEkgZGlkIGluIHYyNCkuCj4gCj4+
Cj4+IE5vdCBkb2luZyB0aGlzIHdvdWxkIG1ha2UgdGhlIGRpZmYgZWFzaWVyIHRvIHJlYWQgOikK
PiAKPiBJIGFncmVlIHRoaXMgaXMgbWVzc3kuIEknbSBub3QgcmVhbGx5IHN1cmUgd2hhdCB0aGlz
IHJlcXVlc3QvZWZmb3J0IGFjaGlldmVzIGFzIHRoZXNlIGF0dHJpYnV0ZXMgYXJlIAo+IG5vdCBz
dHJvbmdseSByZWxhdGVkICh1bmxpa2UgY2FjaGVpbmZvKSBhbmQgdGhlIHdheSB0aGUgZmlsZSB3
YXMgYmVmb3JlIHJlc3VsdHMgaW4gbGVzcyBjb2RlLgo+IAo+IEF0IGFueSByYXRlLCBwbGVhc2Ug
aW5kaWNhdGUgaWYgeW91J2QgcmF0aGVyIEkgdXNlICNpZmRlZi4KPiBUaGFua3MgZm9yIHlvdXIg
dGltZSEKPiBlcmljCj4gCj4+Cj4+IHRoYW5rcywKPj4KPj4gZ3JlZyBrLWgKCkhpIEdyZWcsCkkg
d2FzIHdvbmRlcmluZyBpZiB5b3UgbWlnaHQgd2VpZ2gtaW4gc28gdGhhdCBJIGNhbiBwcm9jZWVk
LgoKSSB0aGluayB0aGVyZSBhcmUgdGhyZWUgb3B0aW9ucyBvbiB0aGUgdGFibGU6Ci0gdXNlICNp
ZmRlZiB0byBjb21tZW50IG91dCB0aGVzZSBmdW5jdGlvbiBib2RpZXMsIHdoaWNoIGtlZXBzIHRo
ZSBkaWZmIG11Y2ggbW9yZSByZWFkYWJsZQotIHVzZSBJU19FTkFCTEVEKCkgYXMgVGhvbWFzIGhh
cyByZXF1ZXN0ZWQgSSBkbywgYnV0IG1ha2VzIHRoZSBkaWZmIG1vcmUgZGlmZmljdWx0IHRvIHJl
YWQKLSByZW1vdmUgdGhpcyByZWZhY3RvciBhbHRvZ2V0aGVyLCBwZXJoYXBzIHBvc3QtcG9uaW5n
IHVudGlsIGFmdGVyIHRoaXMgY3Jhc2ggaG90cGx1ZyBzZXJpZXMgbWVyZ2VzLCAKYXMgdGhpcyBy
ZWZhY3RvciBpcyBsYXJnZWx5IHVucmVsYXRlZCB0byBjcmFzaCBob3RwbHVnLgoKVGhhbmsgeW91
IGZvciB5b3VyIHRpbWUgb24gdGhpcyB0b3BpYyEKZXJpYwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
