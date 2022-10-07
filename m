Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3FBC433F5
	for <kexec@archiver.kernel.org>; Fri,  7 Oct 2022 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W35Wc9uyRd3m2GHnhuR6hL1oddpHw1/iXbBOgPH5GlA=; b=NRsd2YTn7mvIWy5OxAh6U0wA7D
	rt24sO/zdBiIse3+XHAuNofW2DzEMyGAJMqYv+MbHoovJWKQyVwUbzJs9bqGzZZmIreND+jRPvW7m
	QAwQ28RQq+TMEwwndzy2LTuzwWTG8HmjamS1F/UMNR+QU8BScdTuDl+NLdmNFjco4sOPyvsiO9FFP
	2db6EPcyMrrmi6I0gcCXaC6RpNvY4aEjX/QljmrREt5JgAjPj/x5RjuO+iy7FUgyuePNoFlizjtx/
	ckGHZGafI+jczFKEYHqtZ6Y9cpwJCSXzu+4AWWj0nCssYP3dRnQhFXES2yJaUDrWulHvSQRxfv5FH
	4q6ifY4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogt6g-00AE34-G2; Fri, 07 Oct 2022 19:34:02 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogt6d-00AE2W-1v
	for kexec@lists.infradead.org; Fri, 07 Oct 2022 19:34:00 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HrBaZ023296;
	Fri, 7 Oct 2022 19:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=QRodZ/wDgeKFIZPmqZDiCfaxx4zcm+ttgFyRwDfwgYlnH8lrRpFybCi1VCmGgpzfhq/2
 aEZUI296jyX5YaApbuoDdNfYWanvU1KeGHxmbtJkG2fXK1H6zu2XfGmGeaxcAptHPfwf
 eBfUCRE460WGZ7/MQjyA9hCLD9i7z8UGOUvUHDItm+TmGYJ+UNL3w3/n9ByWSbIfBF/T
 RYltf/8ZxrpD5XE4Z5oVyt7PG7zMy3/Asdlg5ueRU1XL8TvOBDIzkk1J1aZGE6cXIuvc
 5HFSQErt8uczoJvFM7jywKYuEBZYR5hvR4LB3XjlmNv+SEBNZ87PI4N4pkQARP4M1VAn vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0dfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 19:33:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297JHQkD028324;
	Fri, 7 Oct 2022 19:33:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc07kbxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 19:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBbsvu72aBeZiZZn3qAixk1Y9Q4zLlpRlRLIsWpyFMd2wC7qyVNcz8M/2WadDvrKSHO18PNqR9H2Od0cf1UaAa9jftXJQqKJiQbBYm9+Wd+98nEbZaJC4CeXGZUl29LesvFqekSWjdEN/gVrd+C3R2on7buIhUwA5i9G5XHo4airDg/AgJMshh4tWqfiBpxyLaOtmVUrPPyr4BLBz3hP/ieDD1JJsNc9pYxKde4cuMI/i5gvn3+2GnqtplXRmIXnjmAk1qrqYOMn4HNp7ZFRWv6MfzoPm9lUY1D5hYG8cOFJceBu5FRgwFgj6XKdRoAfUxUUCGLyOF7FybGTKjATiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=YMZN2TsZCithUrpxXRW6lUfsflLhfUZTe1hEu0VS4wHU6Yv3A+THmph7pKQM1i/eiYc3F7YKqqNePA1vVenqU0HXfvIYtriuHSQgf49f7SkQFfNmjt/uIOhfqlUjWo4A9KieBoMm3AnUSs1ASzfCEXyLZ60zGhmegQz64jok0jpWrj2h17oPdyZJ0u2yHkq0joj1CrFcaY6k5UJo3OzV9Q6eETpkQKlRErMQA2D1V8/J1sw73jsp7pt5I4km1noWujBP/3oMyg9lCWsaCT/4M6DZdX+Cz0u0hTcN/8dV6gfiGTO39dFvG9rdkYuBctL55touSR8BLsW34CEo8mDDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=KvPqz5/18UExYlVLibI/oyrwZZcwbIcwmO7OIJK9eM9hWKUrkcht015Vi6QWi61AtMdI58DsMUXqSFAFPKx4nXMUxn7Ik8Q+zOXF1R0l7bfnepwa9H9j5j0lOlVytETLf8kt3VlhLavD4m3WEIMP83/y2HBwKplfeF73LZNSr84=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 7 Oct
 2022 19:33:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:33:25 +0000
Message-ID: <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
Date: Fri, 7 Oct 2022 14:33:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
X-ClientProxiedBy: DS7PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:8:54::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: e8392cbc-b315-4812-9a1a-08daa89acd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	LjTzQNiGuYwPC1Wqlj1sM6+u4P6KvQN8dQu/y6Q4CSRzMH9mwfo3kZpkT6Mi3dy5y7hw6rg+6TiyyNNpqKkdzzaqjjsDKZeoQHLqJuC9yvnh0T/ag6UXo5R3V6tgOG5MqG+vlcRUkqgHUbYp6Zg0Ac5v/+KKivd4AJvGV5ntAD0/FIlTLxv4bpOpiPC1X4WMKF9Wl1A2zOO7fsR+uIlPEvzkrkapHinKuZt430XNK9Xl2buaUgEQTG24aBqlEjsNIR33kcAHGPov6eZ3sSmNKPsK9LdKhoU2h96JzuIGrSxWoPDZ4unTEIaoLpIWP/cadY9Df1UEER3jo8+/p3ZVTHTVDOuqByjgawUX3v1PSIlJIcS0SsNNtqWpDhMy8QHF1oh2Yabx2cQPRjzMkJWGWpDdgwfxuM6GChjPDq4lZZal4DpTw2c3N5erLZ1O68nDm/9HKyYpnk2TuCM2DIRZZ+PVKAWxyQ1YEySS2zYyKeJwB5QpT9Ceot6JdTujzNAGKYewcCy21Un4MzkundWPbAP0LytbTFoldab7vvGBV4nXtNbipX8RpkR399EFewQ4T2p7CbmlcXepBV3fKIKpgn+jFXZfUn0BnmeM2rAtdCap0Z292RJcmXZN5+SwoRFx0DReIc1BMjXNAb4fnnSs2N3WtwKqzTZF7A7mVX5mVi1LChdd4+pxygpNg1AjOqlOgzugVhOdZRlc8sM+7CsZ9L1ke95F2iMcvs0Klp1yyBje9AZmzfEnk132G2bASIpZmhGJEive2M0ksl8MKJy2sds9QgE+9H/obt6PpQh6iXI=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(6512007)(5660300002)(31686004)(7416002)(31696002)(8936002)(6486002)(83380400001)(36756003)(478600001)(53546011)(186003)(66556008)(38100700002)(2906002)(86362001)(316002)(6506007)(8676002)(107886003)(41300700001)(2616005)(4326008)(66476007)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QkpwSVM0K01UMUQzdHh2VVpxZ21aZEdCbzdZQVhjcU1nUTh3TUwwVm1MUFdP?=
 =?utf-8?B?ZCtScHc4OXR1Zm5Yamh2WFVNVG0zcjNoSHdsVm5pZXJtNTVWSURRRjhlOFB1?=
 =?utf-8?B?SCtvNU1XNkxoeDAvNUtReUhqZHlNM0ZRcHZTY1Z0ampsaDIrOG1QdHFqRmNq?=
 =?utf-8?B?a1RCOU1ETnFlcXBXQmJlNDFjN2dKS0MxNEZQdzFJUG9wUDFDM1dQb25COGxw?=
 =?utf-8?B?dnJ1cCtCckJvRDVFTlMwRkFGcVd0QjJHMWF2Q1hWanVjMTVoRko3aUtsQzNs?=
 =?utf-8?B?dExEb3JiTDFDOGJnS0NIRnZUNzVYNUlFbUY3NHZmUE1rU1oxbjNlQjF0NURh?=
 =?utf-8?B?U09FaFZVZ0FYSWxxUEpFekJoSzRFcVdrNXBpR2lhMWJZcDM4UG1ja0taNm0y?=
 =?utf-8?B?a3UrMi9laCsvblVGMTl6a3JCaWVrZEFiVFkxVDk5SGdSRUtQWEhvVmIyZzBB?=
 =?utf-8?B?ZEVzVlBURENPYXhYUjQ1OUR3V0dDWDBYS0h4cmJjTkhCR3ZGcXpHY1NiMDlw?=
 =?utf-8?B?cEJ0ZVJjcWQyQWtDNkxURmtEZGFuYWUzZDI3RHlvRUZJeEdaOFhtUFkwRVNE?=
 =?utf-8?B?RElzamt2aFg5V2hsTFRJaFhYNkxXeUJXRXpSMzVZbWdkZEM5WDVua25lcVkr?=
 =?utf-8?B?UDZQLzk0NlZFUXZIaEh5LzBCZXFBTktnTzdWUVM0eE9EMUpXTVRyNUtQdUhX?=
 =?utf-8?B?V3RFY1BNVlhMR2tERzNja2FRSjRGcmFNS29veFBqMHE1WHBOck5xODZiaWVj?=
 =?utf-8?B?NXN0MERIcUlXUG5CeTFRekNXVTBBOEhvb0E1d3EwL2Y2SjQ2THh2NGg4UjNB?=
 =?utf-8?B?RGt6NlFLa295eGVWT0Y3VGFkWWNUQXJMYVNDUWdDbGZVbjNlSXlXWm1lYUNn?=
 =?utf-8?B?NmU2a1E1eFdJemI2ekN0VW9uL3lqS2oySzArUzhYeFVrU2pXUjY0ckZOUHRm?=
 =?utf-8?B?bFNNZGpRN1prUTZHTitNdHg0WXpWMEtmSG5zb0xMU0l3cjFzRStHdFFuVDN5?=
 =?utf-8?B?MEpVSTZzbUN3VE54UnBrSzFpbDF3b2RBNm5PcktKUXkrZXdVM0Jud3NqTk12?=
 =?utf-8?B?R0Zic1I4N0EvVE9zWXdBeHA4VlNyT080S25QOFhjMFZlc2JuNmlzamkrWEZJ?=
 =?utf-8?B?NGwweXdQRXJQb0FZMGhhVUhIUmEwQWEyRDhjZ3FPeTBxNkdhS2xOKzVpQndq?=
 =?utf-8?B?aEhtSlNLcDdNbzMxMytWeWNzNXlLdXdveUs5MHZ3cGRGRHkwMnRIdC9DVlUr?=
 =?utf-8?B?TzhQdmlHWmprN0J2dXVmSkNFRVhQdnpiSllEalY2dzVOVU1ndmZyWis1NDBX?=
 =?utf-8?B?ZEpoaXpaaHBNOStpbWpSVENhLzBKdGlHbFNxdUpEblZuY3BuNCtrTUxJcEpT?=
 =?utf-8?B?UmpJUEZIR0dNb3ViWGFKMnNHLyt1Y2NINUhpN055WE9ENFZHM3RqWmJmNEEv?=
 =?utf-8?B?RHpqSUZZb21xbnlyb25qTk0zTWRzVTlubUEzbDB1YmxWU2Q2cSs5TndQTDFS?=
 =?utf-8?B?ckUwR09IRFgzQ1cvcnI0dWNZUDFXUTRReE9VSmxNZU9Xenc5MzNBREcyZktJ?=
 =?utf-8?B?SUJOMzMxOFpabUNYMlVrQkZrY2VVMlBjQXlIdlhjOTdIekFPMUsxUzU2eDF6?=
 =?utf-8?B?TWQway9DVEhURHRKNVk4c0pKc21teER3c0VXYTdPbTJlWmFrdHJ5MEtHbzJy?=
 =?utf-8?B?dFlkNlo1YUZVZGJ5blBCZG9XMzFFeklEanhQL3BHb1VBR1hMeTV4OXQvN0J0?=
 =?utf-8?B?OTZrTkpxNzdNYTI3cWVENzArVUd4eVNSb0tsUGt0MTlRdk8xT2IweEYxbk9R?=
 =?utf-8?B?M2dMbDd5VE9aQ2tMazF2QkxvSkZqRGVNZk9BWCtkdVoyTmFaUjNGK1c5YkVz?=
 =?utf-8?B?RWMwbUtsMWVlcnBpaFdvZnJXb0VJZW9tUVV3NFo3clZiczZVbGtMOGo0MTR6?=
 =?utf-8?B?Yi9Zb0txek00ZTJzbmNtaWhWaEFOSzBPSDVoZjc1SldDOEhXT0tOOEd2b2t4?=
 =?utf-8?B?TE51TVB1VEFuazN1TWVOaDk3cmhBSzk2MDJncnQwMkpoK0cyY3huMU9EUC8v?=
 =?utf-8?B?cmhRMHdCU2ozWDFOajFYTzVQM0FpaHhUcUhXRzNhbG9FeXBySnVQcnBMWnJU?=
 =?utf-8?B?U21TZXdlWnFlRjBwUk5HTzNxejQvQWc5eWNMemxmaU43akZEemtzVnRYc3Nh?=
 =?utf-8?Q?X9RLYNjdQxrTpkaZWr2Fbjo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8392cbc-b315-4812-9a1a-08daa89acd40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:33:25.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDQwHwUNdh6hZgko8CW6LmMOiPxgoanvL/0CMWon2VmaN5PWevfHRH+wLXWIuJk6o8d9kQBoqt4ymHQqseoTtXYgYuMPhgsHdxY5Wf0MNJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070115
X-Proofpoint-ORIG-GUID: 8wXWaYuLUIb5lFDXSafxOYE3XH5fDsxg
X-Proofpoint-GUID: 8wXWaYuLUIb5lFDXSafxOYE3XH5fDsxg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_123359_116591_8D5A512C 
X-CRM114-Status: GOOD (  22.96  )
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

CgpPbiA5LzE5LzIyIDAyOjA2LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gCj4gT24gMTAvMDkvMjIg
MDI6MzUsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+IEZvciB4ODZfNjQsIHdoZW4gQ1BVIG9yIG1l
bW9yeSBpcyBob3QgdW4vcGx1Z2dlZCwgdGhlIGNyYXNoCj4+IGVsZmNvcmVoZHIsIHdoaWNoIGRl
c2NyaWJlcyB0aGUgQ1BVcyBhbmQgbWVtb3J5IGluIHRoZSBzeXN0ZW0sCj4+IG11c3QgYWxzbyBi
ZSB1cGRhdGVkLgo+Pgo+PiBXaGVuIGxvYWRpbmcgdGhlIGNyYXNoIGtlcm5lbCB2aWEga2V4ZWNf
bG9hZCBvciBrZXhlY19maWxlX2xvYWQsCj4+IHRoZSBlbGZjb3JlaGRyIGlzIGlkZW50aWZpZWQg
YXQgcnVuIHRpbWUgaW4KPj4gY3Jhc2hfY29yZTpoYW5kbGVfaG90cGx1Z19ldmVudCgpLgo+Pgo+
PiBUbyB1cGRhdGUgdGhlIGVsZmNvcmVoZHIgZm9yIHg4Nl82NCwgYSBuZXcgZWxmY29yZWhkciBt
dXN0IGJlCj4+IGdlbmVyYXRlZCBmcm9tIHRoZSBhdmFpbGFibGUgQ1BVcyBhbmQgbWVtb3J5LiBU
aGUgbmV3IGVsZmNvcmVoZHIKPj4gaXMgcHJlcGFyZWQgaW50byBhIGJ1ZmZlciwgYW5kIHRoZW4g
aW5zdGFsbGVkIG92ZXIgdGhlIHRvcCBvZgo+PiB0aGUgZXhpc3RpbmcgZWxmY29yZWhkci4KPj4K
Pj4gSW4gdGhlIHBhdGNoICdrZXhlYzogZXhjbHVkZSBlbGZjb3JlaGRyIGZyb20gdGhlIHNlZ21l
bnQgZGlnZXN0Jwo+PiB0aGUgbmVlZCB0byB1cGRhdGUgcHVyZ2F0b3J5IGR1ZSB0byB0aGUgY2hh
bmdlIGluIGVsZmNvcmVoZHIgd2FzCj4+IGVsaW1pbmF0ZWQuwqAgQXMgYSByZXN1bHQsIG5vIGNo
YW5nZXMgdG8gcHVyZ2F0b3J5IG9yIGJvb3RfcGFyYW1zCj4+IChhcyB0aGUgZWxmY29yZWhkcj0g
a2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgcG9pbnRlcgo+PiByZW1haW5zIHVuY2hhbmdl
ZCBhbmQgY29ycmVjdCkgYXJlIG5lZWRlZCwganVzdCBlbGZjb3JlaGRyLgo+Pgo+PiBUbyBhY2Nv
bW1vZGF0ZSBhIGdyb3dpbmcgbnVtYmVyIG9mIHJlc291cmNlcyB2aWEgaG90cGx1ZywgdGhlCj4+
IGVsZmNvcmVoZHIgc2VnbWVudCBtdXN0IGJlIHN1ZmZpY2llbnRseSBsYXJnZSBlbm91Z2ggdG8g
YWNjb21tb2RhdGUKPj4gY2hhbmdlcywgc2VlIHRoZSBDUkFTSF9NQVhfTUVNT1JZX1JBTkdFUyBj
b25maWd1cmUgaXRlbS4KPj4KPj4gV2l0aCB0aGlzIGNoYW5nZSwgY3Jhc2ggaG90cGx1ZyBmb3Ig
a2V4ZWNfZmlsZV9sb2FkIHN5c2NhbGwKPj4gaXMgc3VwcG9ydGVkLiBUaGUga2V4ZWNfbG9hZCBp
cyBhbHNvIHN1cHBvcnRlZCwgYnV0IGFsc28KPj4gcmVxdWlyZXMgYSBjb3JyZXNwb25kaW5nIGNo
YW5nZSB0byB1c2Vyc3BhY2Uga2V4ZWMtdG9vbHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMg
RGVWb2xkZXIgPGVyaWMuZGV2b2xkZXJAb3JhY2xlLmNvbT4KPj4gQWNrZWQtYnk6IEJhb3F1YW4g
SGUgPGJoZUByZWRoYXQuY29tPgo+PiAtLS0KPj4gwqAgYXJjaC94ODYvS2NvbmZpZ8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMTEgKysrKwo+PiDCoCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
ZXhlYy5oIHzCoCAyMCArKysrKysrCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9jcmFzaC5jwqDCoMKg
wqDCoCB8IDEwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCAzIGZp
bGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZpZwo+PiBpbmRleCBmOTkyMGYxMzQxYzguLmNkZmM5
YjJmZGY5OCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYvS2NvbmZpZwo+PiArKysgYi9hcmNoL3g4
Ni9LY29uZmlnCj4+IEBAIC0yMDU2LDYgKzIwNTYsMTcgQEAgY29uZmlnIENSQVNIX0RVTVAKPj4g
wqDCoMKgwqDCoMKgwqAgKENPTkZJR19SRUxPQ0FUQUJMRT15KS4KPj4gwqDCoMKgwqDCoMKgwqAg
Rm9yIG1vcmUgZGV0YWlscyBzZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVt
cC5yc3QKPj4gK2NvbmZpZyBDUkFTSF9NQVhfTUVNT1JZX1JBTkdFUwo+PiArwqDCoMKgIGRlcGVu
ZHMgb24gQ1JBU0hfRFVNUCAmJiBLRVhFQ19GSUxFICYmIChIT1RQTFVHX0NQVSB8fCBNRU1PUllf
SE9UUExVRykKPj4gK8KgwqDCoCBpbnQKPj4gK8KgwqDCoCBkZWZhdWx0IDMyNzY4Cj4+ICvCoMKg
wqAgaGVscAo+PiArwqDCoMKgwqDCoCBGb3IgdGhlIGtleGVjX2ZpbGVfbG9hZCBwYXRoLCBzcGVj
aWZ5IHRoZSBtYXhpbXVtIG51bWJlciBvZgo+PiArwqDCoMKgwqDCoCBtZW1vcnkgcmVnaW9ucywg
ZWcuIGFzIHJlcHJlc2VudGVkIGJ5IHRoZSAnU3lzdGVtIFJBTScgZW50cmllcwo+PiArwqDCoMKg
wqDCoCBpbiAvcHJvYy9pb21lbSwgdGhhdCB0aGUgZWxmY29yZWhkciBidWZmZXIvc2VnbWVudCBj
YW4gYWNjb21tb2RhdGUuCj4+ICvCoMKgwqDCoMKgIFRoaXMgdmFsdWUgaXMgY29tYmluZWQgd2l0
aCBOUl9DUFVTIGFuZCBtdWx0aXBsaWVkIGJ5IEVsZjY0X1BoZHIKPj4gK8KgwqDCoMKgwqAgc2l6
ZSB0byBkZXRlcm1pbmUgdGhlIGZpbmFsIGJ1ZmZlciBzaXplLgo+PiArCj4+IMKgIGNvbmZpZyBL
RVhFQ19KVU1QCj4+IMKgwqDCoMKgwqAgYm9vbCAia2V4ZWMganVtcCIKPj4gwqDCoMKgwqDCoCBk
ZXBlbmRzIG9uIEtFWEVDICYmIEhJQkVSTkFUSU9OCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rZXhlYy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMuaAo+PiBpbmRl
eCBhMzc2MGNhNzk2YWEuLjQzMjA3MzM4NWIyZCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20va2V4ZWMuaAo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oCj4+
IEBAIC0yMTIsNiArMjEyLDI2IEBAIHR5cGVkZWYgdm9pZCBjcmFzaF92bWNsZWFyX2ZuKHZvaWQp
Owo+PiDCoCBleHRlcm4gY3Jhc2hfdm1jbGVhcl9mbiBfX3JjdSAqY3Jhc2hfdm1jbGVhcl9sb2Fk
ZWRfdm1jc3M7Cj4+IMKgIGV4dGVybiB2b2lkIGtkdW1wX25taV9zaG9vdGRvd25fY3B1cyh2b2lk
KTsKPj4gK3ZvaWQgKmFyY2hfbWFwX2NyYXNoX3BhZ2VzKHVuc2lnbmVkIGxvbmcgcGFkZHIsIHVu
c2lnbmVkIGxvbmcgc2l6ZSk7Cj4+ICsjZGVmaW5lIGFyY2hfbWFwX2NyYXNoX3BhZ2VzIGFyY2hf
bWFwX2NyYXNoX3BhZ2VzCj4+ICsKPj4gK3ZvaWQgYXJjaF91bm1hcF9jcmFzaF9wYWdlcyh2b2lk
ICoqcHRyKTsKPj4gKyNkZWZpbmUgYXJjaF91bm1hcF9jcmFzaF9wYWdlcyBhcmNoX3VubWFwX2Ny
YXNoX3BhZ2VzCj4+ICsKPj4gK3ZvaWQgYXJjaF9jcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudChz
dHJ1Y3Qga2ltYWdlICppbWFnZSwKPj4gK8KgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBocF9h
Y3Rpb24pOwo+PiArI2RlZmluZSBhcmNoX2NyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50IGFyY2hf
Y3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQKPj4gKwo+PiArI2lmZGVmIENPTkZJR19IT1RQTFVH
X0NQVQo+PiArc3RhdGljIGlubGluZSBpbnQgY3Jhc2hfaG90cGx1Z19jcHVfc3VwcG9ydCh2b2lk
KSB7IHJldHVybiAxOyB9Cj4+ICsjZGVmaW5lIGNyYXNoX2hvdHBsdWdfY3B1X3N1cHBvcnQgY3Jh
c2hfaG90cGx1Z19jcHVfc3VwcG9ydAo+PiArI2VuZGlmCj4+ICsKPj4gKyNpZmRlZiBDT05GSUdf
TUVNT1JZX0hPVFBMVUcKPj4gK3N0YXRpYyBpbmxpbmUgaW50IGNyYXNoX2hvdHBsdWdfbWVtb3J5
X3N1cHBvcnQodm9pZCkgeyByZXR1cm4gMTsgfQo+PiArI2RlZmluZSBjcmFzaF9ob3RwbHVnX21l
bW9yeV9zdXBwb3J0IGNyYXNoX2hvdHBsdWdfbWVtb3J5X3N1cHBvcnQKPj4gKyNlbmRpZgo+PiAr
Cj4+IMKgICNlbmRpZiAvKiBfX0FTU0VNQkxZX18gKi8KPj4gwqAgI2VuZGlmIC8qIF9BU01fWDg2
X0tFWEVDX0ggKi8KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jIGIvYXJj
aC94ODYva2VybmVsL2NyYXNoLmMKPj4gaW5kZXggOWNlYjkzYzE3NmE2Li44ZmM3ZDY3OGFjNzIg
MTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcmFzaC5jCj4+IEBAIC0yNSw2ICsyNSw3IEBACj4+IMKgICNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+Cj4+IMKgICNpbmNsdWRl
IDxsaW51eC9tZW1ibG9jay5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KPj4gwqAg
I2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4gwqAgI2luY2x1ZGUgPGFzbS9oYXJkaXJxLmg+
Cj4+IEBAIC0zOTcsNyArMzk4LDE4IEBAIGludCBjcmFzaF9sb2FkX3NlZ21lbnRzKHN0cnVjdCBr
aW1hZ2UgKmltYWdlKQo+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVycyA9IGtidWYuYnVm
ZmVyOwo+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYuYnVmc3o7Cj4+
ICsjaWYgZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpIHx8IGRlZmluZWQoQ09ORklHX01FTU9S
WV9IT1RQTFVHKQo+PiArwqDCoMKgIC8qIEVuc3VyZSBlbGZjb3JlaGRyIHNlZ21lbnQgbGFyZ2Ug
ZW5vdWdoIGZvciBob3RwbHVnIGNoYW5nZXMgKi8KPj4gK8KgwqDCoCBrYnVmLm1lbXN6ID0KPj4g
K8KgwqDCoMKgwqDCoMKgIChDT05GSUdfTlJfQ1BVU19ERUZBVUxUICsgQ09ORklHX0NSQVNIX01B
WF9NRU1PUllfUkFOR0VTKSAqCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihFbGY2
NF9QaGRyKTsKPj4gK8KgwqDCoCAvKiBNYXJrIGFzIHVzYWJsZSB0byBjcmFzaCBrZXJuZWwsIGVs
c2UgY3Jhc2gga2VybmVsIGZhaWxzIG9uIGJvb3QgKi8KPj4gK8KgwqDCoCBpbWFnZS0+ZWxmX2hl
YWRlcnNfc3ogPSBrYnVmLm1lbXN6Owo+PiArwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRyX2luZGV4
ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+PiArwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRyX2luZGV4
X3ZhbGlkID0gdHJ1ZTsKPj4gKyNlbHNlCj4+IMKgwqDCoMKgwqAga2J1Zi5tZW1zeiA9IGtidWYu
YnVmc3o7Cj4+ICsjZW5kaWYKPj4gwqDCoMKgwqDCoCBrYnVmLmJ1Zl9hbGlnbiA9IEVMRl9DT1JF
X0hFQURFUl9BTElHTjsKPj4gwqDCoMKgwqDCoCBrYnVmLm1lbSA9IEtFWEVDX0JVRl9NRU1fVU5L
Tk9XTjsKPj4gwqDCoMKgwqDCoCByZXQgPSBrZXhlY19hZGRfYnVmZmVyKCZrYnVmKTsKPj4gQEAg
LTQxMiwzICs0MjQsOTMgQEAgaW50IGNyYXNoX2xvYWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAq
aW1hZ2UpCj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4gwqAgfQo+PiDCoCAjZW5kaWYgLyog
Q09ORklHX0tFWEVDX0ZJTEUgKi8KPj4gKwo+PiArI2lmIGRlZmluZWQoQ09ORklHX0hPVFBMVUdf
Q1BVKSB8fCBkZWZpbmVkKENPTkZJR19NRU1PUllfSE9UUExVRykKPj4gKy8qCj4+ICsgKiBOT1RF
OiBUaGUgYWRkcmVzc2VzIGFuZCBzaXplcyBwYXNzZWQgdG8gdGhpcyByb3V0aW5lIGhhdmUKPj4g
KyAqIGFscmVhZHkgYmVlbiBmdWxseSBhbGlnbmVkIG9uIHBhZ2UgYm91bmRhcmllcy4gVGhlcmUg
aXMgbm8KPj4gKyAqIG5lZWQgZm9yIG1hc3NhZ2luZyB0aGUgYWRkcmVzcyBvciBzaXplLgo+PiAr
ICovCj4+ICt2b2lkICphcmNoX21hcF9jcmFzaF9wYWdlcyh1bnNpZ25lZCBsb25nIHBhZGRyLCB1
bnNpZ25lZCBsb25nIHNpemUpCj4+ICt7Cj4+ICvCoMKgwqAgdm9pZCAqcHRyID0gTlVMTDsKPj4g
Kwo+PiArwqDCoMKgIGlmIChzaXplID4gMCkgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBh
Z2UgKnBhZ2UgPSBwZm5fdG9fcGFnZShwYWRkciA+PiBQQUdFX1NISUZUKTsKPj4gKwo+PiArwqDC
oMKgwqDCoMKgwqAgcHRyID0ga21hcF9sb2NhbF9wYWdlKHBhZ2UpOwo+PiArwqDCoMKgIH0KPj4g
Kwo+PiArwqDCoMKgIHJldHVybiBwdHI7Cj4+ICt9Cj4+ICsKPj4gK3ZvaWQgYXJjaF91bm1hcF9j
cmFzaF9wYWdlcyh2b2lkICoqcHRyKQo+PiArewo+PiArwqDCoMKgIGlmIChwdHIpIHsKPj4gK8Kg
wqDCoMKgwqDCoMKgIGlmICgqcHRyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdW5tYXBf
bG9jYWwoKnB0cik7Cj4+ICvCoMKgwqDCoMKgwqDCoCAqcHRyID0gTlVMTDsKPj4gK8KgwqDCoCB9
Cj4+ICt9Cj4+ICsKPj4gKy8qKgo+PiArICogYXJjaF9jcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVu
dCgpIC0gSGFuZGxlIGhvdHBsdWcgZWxmY29yZWhkciBjaGFuZ2VzCj4+ICsgKiBAaW1hZ2U6IHRo
ZSBhY3RpdmUgc3RydWN0IGtpbWFnZQo+PiArICogQGhwX2FjdGlvbjogdGhlIGhvdCB1bi9wbHVn
IGFjdGlvbiBiZWluZyBoYW5kbGVkCj4+ICsgKgo+PiArICogVG8gYWNjdXJhdGVseSByZWZsZWN0
IGhvdCB1bi9wbHVnIGNoYW5nZXMsIHRoZSBuZXcgZWxmY29yZWhkcgo+PiArICogaXMgcHJlcGFy
ZWQgaW4gYSBrZXJuZWwgYnVmZmVyLCBhbmQgdGhlbiBpdCBpcyB3cml0dGVuIG9uIHRvcAo+PiAr
ICogb2YgdGhlIGV4aXN0aW5nL29sZCBlbGZjb3JlaGRyLgo+PiArICovCj4+ICt2b2lkIGFyY2hf
Y3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4+ICvCoMKg
wqAgdW5zaWduZWQgaW50IGhwX2FjdGlvbikKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3Qga2V4ZWNf
c2VnbWVudCAqa3NlZ21lbnQ7Cj4+ICvCoMKgwqAgdW5zaWduZWQgY2hhciAqcHRyID0gTlVMTDsK
Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGVsZnN6ID0gMDsKPj4gK8KgwqDCoCB2b2lkICplbGZi
dWYgPSBOVUxMOwo+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbWVtLCBtZW1zejsKPj4gKwo+PiAr
wqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIEVsZmNvcmVoZHJfaW5kZXhfdmFsaWQgY2hlY2tlZCBp
biBjcmFzaF9jb3JlOmhhbmRsZV9ob3RwbHVnX2V2ZW50KCkKPj4gK8KgwqDCoMKgICovCj4+ICvC
oMKgwqAga3NlZ21lbnQgPSAmaW1hZ2UtPnNlZ21lbnRbaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXhd
Owo+PiArwqDCoMKgIG1lbSA9IGtzZWdtZW50LT5tZW07Cj4+ICvCoMKgwqAgbWVtc3ogPSBrc2Vn
bWVudC0+bWVtc3o7Cj4+ICsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBDcmVhdGUgdGhl
IG5ldyBlbGZjb3JlaGRyIHJlZmxlY3RpbmcgdGhlIGNoYW5nZXMgdG8gQ1BVIGFuZC9vcgo+PiAr
wqDCoMKgwqAgKiBtZW1vcnkgcmVzb3VyY2VzLgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBp
ZiAocHJlcGFyZV9lbGZfaGVhZGVycyhpbWFnZSwgJmVsZmJ1ZiwgJmVsZnN6KSkgewo+PiArwqDC
oMKgwqDCoMKgwqAgcHJfZXJyKCJjcmFzaCBocDogdW5hYmxlIHRvIHByZXBhcmUgZWxmY29yZSBo
ZWFkZXJzIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPiAKPiBPbiBQb3dlclBDLCB3
aGlsZSBwcmVwYXJpbmcgdGhlIGVsZiBjb3JlIGhlYWRlciB0aGUgbWVtYmxvY2sgc3RydWN0dXJl
IGlzIHVzZWQgdG8gcHJlcGFyZSBwcm9ncmFtIAo+IGhlYWRlciBmb3IgbWVtb3J5IHJlZ2lvbnMg
b2YgZWxmY29yZWhkci4gU2luY2UgdGhlIGFib3ZlIGFyY2ggc3BlY2lmaWMgaG90cGx1ZyBoYW5k
bGVyIGdldHMgaW52b2tlZCAKPiB3aGVuIG1lbW9yeSBpcyBtYXJrZWQgb2ZmbGluZSAoTUVNX09G
RkxJTkUpIHdoaWNoIGlzIGJlZm9yZSBtZW1ibG9jayBzdHJ1Y3R1cmUgZ2V0cyB1cGRhdGVkIHNv
IG9uIAo+IFBvd2VyUEMgdGhlIGFib3ZlIGhhbmRsZXIgbWF5IG5vdCB3b3JrIGZvciBtZW1vcnkg
aG90cGx1ZyBjYXNlLgo+IAo+IEp1c3Qgd29uZGVyaW5nIHdoaWNoIGRhdGEgc3RydWN0dXJlIGlz
IHVzZWQgdG8gZ2V0IHRoZSBsaXN0IG9mIG1lbW9yeSByZWdpb25zIHdoaWxlIHByZXBhcmluZyAK
PiBwcm9ncmFtIGhlYWRlciBmb3IgbWVtb3J5IHJlZ2lvbnMgb2YgZWxmY29yZWhkciBvbiBvdGhl
ciBhcmNoaXRlY3R1cmVzPwo+IAo+IFRoYW5rcywKPiBTb3VyYWJoIEphaW4KCkkgdGhpbmsgeW91
ciByZXF1ZXN0IHRvIHJlcG9ydCB0aGUgbWVtb3J5IGJsb2NrIGFkZHJlc3MgaW4gY29tbWVudHMg
b2YgcGF0Y2ggMy83ICJjcmFzaDogYWRkIGdlbmVyaWMgCmluZnJhc3RydWN0dXJlIiBjb3ZlciB0
aGlzIHNjZW5hcmlvIG5vdy4KVGhhbmtzLAplcmljCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
