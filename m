Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63199C43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u83Y60wpRj1cSGN71uI9GJRbd3fzCldytfElA0YxqGI=; b=1aVY1zz7kURRr3hGirUrTKOS2B
	FmWKTPp9fg/PLzBfSOkx23Rkac0aA1n9Kxw/U7g6QXy2A7VdjFoo024yGkOfzq3bMR1ynThZCEo8o
	YpWLov2H5/K/A0PEBVAMh+XR1kuXTaMNi/uG45cwdUUxK/wOLzMHEA30u5xWmZmeVZQ7zdyQcCAGO
	uPg1DKLm7g6I7lgQpAu4NeDVl8Ri1X5rJeBwFDiq7yDdA2BmCitN60gS1/rDd+ACBP/NWw0zRN4qu
	lq67GC3jQKDa8PY7nU2F1uQfmW1DYQYHfwZq4St2QRHw85jmj4aC+tr7aQwAYQNHQa+MlDcPSm7Us
	cb+3k82w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9vCy-005wXw-Hg; Fri, 08 Jul 2022 21:08:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9vCv-005wVe-UJ
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 21:08:15 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268JSpo8028248;
	Fri, 8 Jul 2022 21:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=juJ7cRdl9GYJ3x+tPC7Rfkkv+tkBA9dIEHjIfFCS8eYs/QuBMhXJHjACI6xrAUOYMkRC
 bhbFjoJmVfdo2UoZIkAvZ1ZWfkaLg0aN0+IM8zrGT99YNTPXlejjIxhKjUgbK/UZroWk
 gGDEtN93RYtZYxKIi0Kxo7R7bVhsAQwZN9VU5dVGoQJy7sumMlP0dAN3y0zxDkYYvedd
 hbMgSl+owZlFcD4d2gIsWMGeWy0RwhduPBCGDhrE6LHxQqXmcNRUX4SUIS+/DvuCuN1A
 mfdHdfX5AGF7IsdqjN/RMVWsBEjwNwn59tPEACNlq3wVaBQc6i+UHSwQ8+MWF7BsA4DW oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubys6k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Jul 2022 21:07:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268L6qmS029497;
	Fri, 8 Jul 2022 21:07:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4udaec9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Jul 2022 21:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUSvQmV2N+Ixm6F7mrN+VSdAVvRq7N+qHOtLWgUUbdXDnCmyQro+00VqWttaupS6bHb/s3Hk6J+8Qotj/cIc5FKdBiQaSZnKMqd0RRHx3amhiWSpDQ/DW8C5nuZS/wsqLIjqTfxdFXfgXvdLaubSdkIwtu1YsmQTmJtbAYyNxeB9kbjHAkiAfsWUVhGrYdXXqsBzEMc6az2GJMDH1cqK+HP5i1qlSZKIOiO8lNQAqWvE1kFoDdvN+5xaX55xWjMdZvZ958keXlf467+d7e7FAYnhH3DVRrWO0JOYW5XVE0ZQLyJd5H8Tj20L5x3cIwH3aOuxGOgYkUumY9Pibkk7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=YOrfPZ2mL4BN4OhPyXC97KcnmH1zG2mL3zjzUm+ZriqgDb0e7hGBpzvw+7P77ou0wfmeX8T3qSzg6ZEGhDgUVnTejpwcR/NzfElgKnXhwtxGjpT4zkaJNyq/mnG3d4zCjaT+mpDY4nX1VTonl4KDCMcpz8fqcq3E32J4dMS3yQSFK3U5QRPGg0EdMKZRPeElzYsbmJs5hP6a1v1vIAx9oq3rA4re8mjG5x6VsjKv3sBj941sJuDQB1vTdxVknNXnuFz1mRG8CSqNpGDNDNu9zsf0/wSucan9OM+4/OJqnKfmkn6voLV7KPsbpIH+Jzwc1FGxmEzXwj2iRC3Vg8LpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=ClCwZZxdnmTWqTLR9oNKdlGTl1SbjWPuP5ijHIRQrut90lg8cB+MqrarKZO2/RtZ5WbiIlcsAftyUXOYWHQaa6GYsugMkcW1uYAoqdwZ8avhpcREdohVeAZjLmuqwn3jmfrPAIMwkCuyrTp0vqaI9suJ+Wl+K9W5vlJ5lBCPPqk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5585.namprd10.prod.outlook.com (2603:10b6:303:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 21:07:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 21:07:28 +0000
Message-ID: <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
Date: Fri, 8 Jul 2022 16:07:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
        bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <2843978.e9J7NaK4W3@opensuse>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2843978.e9J7NaK4W3@opensuse>
X-ClientProxiedBy: SA1PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0408f5b2-44d9-43e6-fe5a-08da6125dd70
X-MS-TrafficTypeDiagnostic: CO6PR10MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3mJIdLedknesTkLdr11l9iVPvafOEfI0/8bi+9yJnEgD1gfeW+dQl5fN34lnDp2TmKGo+i9pQAupdMgN2R9DEJ4R5eIU1FdWEaQxidBXer9qabZd8I8/ajNw5GoKqkAf3DkBJCDP5QjP39JOgvrcJmZ7oGKlSwxwRGoEqWqdZ3S3hDXUXqgzfI2caO7mLwXpdeIu545FJqjplhQRCJbk9NLR9oq5MLgcxPJRBDymlg/9aqxtcZf1FUMHN8QaSWRMUcR/1V0iYLr/S7bhR3m/PMa3+BwvUY5FqodMEWQ70Q/BB5F5ee6FsUAo81mwwZdF/ihR50Aw74dsrfOdDBYnL/2uiOYJTDafzQDuXwYSQtRiKyTvOCtJl7oCrZgp8lsmEDDDhuD8G7McWATWRam8VSLB5KHHIi8kNLm5eyZhBHAvbYxaD0UTm3jX86Dakr6h9HUcBsGOQex5ZxpaW/eZAm6rg1kpAJptDeNDJQSrc0Gxt0q/j59jTXWPrS242TEH9RRxJuxl7CC81uokK23U9Liw6rPn2u2rFYOFHsM9562qqq9ZI1S3DYKw9PLYWr8BHkzHhZbcO6RTNOAfC/cRQAkNCKvBM+ddFyNJHNTrK4A4ahHB8bLhm0f7bSRo5rbCwsZUlCogR4vSgpkjjucSyuUU6CubOv2BqwHd6z0W3WDwq3H2p+VazqblqgzAXfqfxqy0F/nO72Jb0Lwao8jT/speWVxRZsa7xO48If7dTsz/Uc8+46QUJivPT7foto8W78f7uOv+RH1OVCZDVBHXtsy6fJH51HvDaY3XfYNAgUOoF0YpTMmniCsHxzARiuEZ6IsNmhqQhBqP22BvzaT8lO3+8TDHU8JpnZCTohuYOLg=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(136003)(346002)(366004)(41300700001)(5660300002)(7416002)(6666004)(478600001)(31696002)(8936002)(6486002)(86362001)(316002)(2906002)(38100700002)(31686004)(186003)(2616005)(66556008)(107886003)(8676002)(66476007)(83380400001)(6512007)(6506007)(53546011)(36756003)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?MHArVHVNaEpKSWJkMUNWWG1oNHNHUzFZZm5QZk5HK1puZW9RMFJ6L21DSUZ1?=
 =?utf-8?B?Rk1KQ3dpZjlkVi9iNDVXOFp6T1g0ampTV1BzQU90Nk8wbjg5N2ppOW5hakcw?=
 =?utf-8?B?TjNiK3RQV0pteFVBeHZzOElhRUVsWjJEMFljQXh4WDgyRE45emdEMkdrWnFB?=
 =?utf-8?B?dzIwN1RkTUxqem5qelFmQkNPNFpMZDcrcE9wbkdHM3haOUdHOXFFUDJ6U2p6?=
 =?utf-8?B?cE1oWG9HY2c4cXJkZ1VtT2dtZ3RuNHFMZ3hCWGVjdVhTeFJBR1kyS1RISDJz?=
 =?utf-8?B?WFlaVHV3dXJWODdFZG1BVmhKZi83ZUUrcVk0dkdpZjFvcTFDTnlQRy9XaVJZ?=
 =?utf-8?B?Nll0cFRoSDFQdVZEdUFvNGJKUExqWTJzQTdqU3o4UlAyT29GT3JSS01uWElN?=
 =?utf-8?B?bE1EZVYvdlN4eWwySVRKWWlXWmNMd21ESXVQcDdLWUFmazRmb2JQVjJEZmxu?=
 =?utf-8?B?UlUydXBxL2pGN3pYWU5Qc0xYRS84L3FsUXhCeFI1bHBlclE3eGc3eVNLYkpC?=
 =?utf-8?B?a09hSGN4QWN4TUNwbG9BeE05SWlsOElQam8wWVVrcEM2U1QzR3ZHSFFRNEwv?=
 =?utf-8?B?T0Ird0JNdnJVUkhodzNhaG1sQVdVQzFyK1Bpd2xSaWpyTzg5cy9WcUp0aTBW?=
 =?utf-8?B?dkI1S0dFKzlFdG0zNW1JMmh1OXRBQzUvaWEwT1llY2p0QkNXOXRCTE9Cd3Y2?=
 =?utf-8?B?MGlCT2FaQlRrMmRMNnQzMGdNN3E0Y2Z2UFU0YjI2SnlRUmRUQmg4Y2JOUWd3?=
 =?utf-8?B?emRRVG9QRk5KMkpFWGtoRk9OTTlqenVhN1MrOXdVMU5zVUpXRTU3ZEFmaE5J?=
 =?utf-8?B?UWluc1JmRFVWOFBjMHR2d0t2a2k0QkhqY3JWa3JJWlR4K0x0dEZXZEVUZ1NF?=
 =?utf-8?B?bFFWMUo4OEN3VUw2RXR4U1JLZVBWTzc0eDZpNzV2WitvaVNPcC9obWFwdCsv?=
 =?utf-8?B?K2o2Z0VlOE8xVk1WVUdyNW0rTGhtaHU4L2I3aXptTnBNV1BQcU95b3Q2SHBw?=
 =?utf-8?B?cWRFMjF0cmVaMUE3cVpvOGpFU2NOWjNZSE5GMHU5STlad2JJMmlmOG5JMCs0?=
 =?utf-8?B?TmtZMVB6UG9QZlZpdCtpTUpJZFJ2dGlCODkzeUZ6UDY4TlZVUVVnaFc3Tnp3?=
 =?utf-8?B?QkwzNkRzWSsxalNrUjlOMmptVXpSc0FyeHY4ZDJ4Tm1WdU9xSU8rSy8xNjd4?=
 =?utf-8?B?OWxKK3hJMU5pNnR1WnZaUW1JRGRyRlRvVExadmJFZFJuOWRndUx3YmxkWE9u?=
 =?utf-8?B?RVNmSWlCMFM5dWZpOEs0Mm0wR0M5eUhoVjNFbXZsdm9OVUtoaFQzOE5xZXpS?=
 =?utf-8?B?OUxCcWVlMHhHMVJOaVExckV6Rkh6QVhYYVRHRUZIVUNheXZKRFdTaVREOWtS?=
 =?utf-8?B?NDE2NW8yUHo2Q1RYQW5WaCtic0VLK2NUVGNWK3JpUjMvb2ZSTDZpcE1RbVln?=
 =?utf-8?B?Wk1kWTFObGlNQkMzc09LbXJnOG9PSU1pRzFkU1d5Q0JTQUN1SUlpb2hZK0Ft?=
 =?utf-8?B?aDFaaDVQbFVVK3RMc1VrWElUSnZTWjhacFN0SmtKWVpkZ1VOemNCVnlQQ21M?=
 =?utf-8?B?OXBCbW9PcEwxRWdsRTBnM0ZleU84cjJUOWNvZ3dkSmxTbmRsaTIvNHVMemFh?=
 =?utf-8?B?SXNQNkN4Um81Q2JYcG1VVmhOdmlnVmFDTW1vZ1QzNkl4UDhtNjdIMnlSSHJz?=
 =?utf-8?B?dEtxTXFVdXJCL0VWdHJFTVF2bXJJS0c1M2xiV1RoYVIxdHYxYXFqUmllano1?=
 =?utf-8?B?cnJPTW5DSzExSmdMMTNwOURIWFRBU3RROGdxSWNqbmhzdWZXR3NBRXptcEg0?=
 =?utf-8?B?SWhjck4rckxHWE1lUjd1RDdwU2ppZWtrTnkzUjlGVEtGL0NKK003VEJQcnEz?=
 =?utf-8?B?SzN4eUVMU2dBRWZ3MzZaZENKdTJjbEhubFhBRG1sdlpmZkVUQVloWm5Nd1B2?=
 =?utf-8?B?YzN0UlRmQVMzNFllaVlYQnZabC94L1VFdVd6YTJwNGY0OUxJbGZpOFUrNVJC?=
 =?utf-8?B?M1A3UkFlejN6eUdYNXlqZktmSlU4bDhoYlVKc2l1b3pyNGkzaG8wUWYxWi9F?=
 =?utf-8?B?RWdGUHdlc3VCY3FNU1l3MjV4dW92SEFpL01CVFViLy8zTW5OWmRPNzNIOHh2?=
 =?utf-8?B?alZRTndQMmttZ3hiTWJaaElWcW8zb04vVURKZXNZQnMyODRPK2xhWGNhNytX?=
 =?utf-8?Q?o0qQ2Wa1qRvu6x2ox2b8bvM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0408f5b2-44d9-43e6-fe5a-08da6125dd70
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 21:07:28.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VoTbSjfd+uGk6qAgcfSKXdZASHXRb5HFBPxSpGTnGkx/YZJDP20r7S4JVLYDOUhvNNaMbFpbb06mFOeKJWlS4TV1V0CRk8/awxJ+cqkZCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_18:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080083
X-Proofpoint-GUID: cz6adxlhrxEbQl9Xbyz_sbwdR63Cleut
X-Proofpoint-ORIG-GUID: cz6adxlhrxEbQl9Xbyz_sbwdR63Cleut
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_140814_000447_867F1512 
X-CRM114-Status: GOOD (  31.30  )
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

CgpPbiA3LzgvMjIgMTQ6MzgsIEZhYmlvIE0uIERlIEZyYW5jZXNjbyB3cm90ZToKPiBPbiBtYXJ0
ZWTDrCAxNCBnaXVnbm8gMjAyMiAwMDo0Mjo0MCBDRVNUIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+
IEZvciB4ODZfNjQsIHdoZW4gQ1BVIG9yIG1lbW9yeSBpcyBob3QgdW4vcGx1Z2dlZCwgdGhlIGNy
YXNoCj4+IGVsZmNvcmVoZHIsIHdoaWNoIGRlc2NyaWJlcyB0aGUgQ1BVcyBhbmQgbWVtb3J5IGlu
IHRoZSBzeXN0ZW0sCj4+IG11c3QgYWxzbyBiZSB1cGRhdGVkLgo+Pgo+PiBXaGVuIGxvYWRpbmcg
dGhlIGNyYXNoIGtlcm5lbCB2aWEga2V4ZWNfbG9hZCBvciBrZXhlY19maWxlX2xvYWQsCj4+IHRo
ZSBlbGZjb3JlaGRyIGlzIGlkZW50aWZpZWQgYXQgcnVuIHRpbWUgaW4KPj4gY3Jhc2hfY29yZTpo
YW5kbGVfaG90cGx1Z19ldmVudCgpLgo+Pgo+PiBUbyB1cGRhdGUgdGhlIGVsZmNvcmVoZHIgZm9y
IHg4Nl82NCwgYSBuZXcgZWxmY29yZWhkciBtdXN0IGJlCj4+IGdlbmVyYXRlZCBmcm9tIHRoZSBh
dmFpbGFibGUgQ1BVcyBhbmQgbWVtb3J5LiBUaGUgbmV3IGVsZmNvcmVoZHIKPj4gaXMgcHJlcGFy
ZWQgaW50byBhIGJ1ZmZlciwgYW5kIHRoZW4gaW5zdGFsbGVkIG92ZXIgdGhlIHRvcCBvZgo+PiB0
aGUgZXhpc3RpbmcgZWxmY29yZWhkci4KPj4KPj4gSW4gdGhlIHBhdGNoICdrZXhlYzogZXhjbHVk
ZSBlbGZjb3JlaGRyIGZyb20gdGhlIHNlZ21lbnQgZGlnZXN0Jwo+PiB0aGUgbmVlZCB0byB1cGRh
dGUgcHVyZ2F0b3J5IGR1ZSB0byB0aGUgY2hhbmdlIGluIGVsZmNvcmVoZHIgd2FzCj4+IGVsaW1p
bmF0ZWQuICBBcyBhIHJlc3VsdCwgbm8gY2hhbmdlcyB0byBwdXJnYXRvcnkgb3IgYm9vdF9wYXJh
bXMKPj4gKGFzIHRoZSBlbGZjb3JlaGRyPSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlciBw
b2ludGVyCj4+IHJlbWFpbnMgdW5jaGFuZ2VkIGFuZCBjb3JyZWN0KSBhcmUgbmVlZGVkLCBqdXN0
IGVsZmNvcmVoZHIuCj4+Cj4+IFRvIGFjY29tbW9kYXRlIGEgZ3Jvd2luZyBudW1iZXIgb2YgcmVz
b3VyY2VzIHZpYSBob3RwbHVnLCB0aGUKPj4gZWxmY29yZWhkciBzZWdtZW50IG11c3QgYmUgc3Vm
ZmljaWVudGx5IGxhcmdlIGVub3VnaCB0byBhY2NvbW1vZGF0ZQo+PiBjaGFuZ2VzLCBzZWUgdGhl
IENSQVNIX01BWF9NRU1PUllfUkFOR0VTIGNvbmZpZ3VyZSBpdGVtLgo+Pgo+PiBXaXRoIHRoaXMg
Y2hhbmdlLCBjcmFzaCBob3RwbHVnIGZvciBrZXhlY19maWxlX2xvYWQgc3lzY2FsbAo+PiBpcyBz
dXBwb3J0ZWQuIFRoZSBrZXhlY19sb2FkIGlzIGFsc28gc3VwcG9ydGVkLCBidXQgYWxzbwo+PiBy
ZXF1aXJlcyBhIGNvcnJlc3BvbmRpbmcgY2hhbmdlIHRvIHVzZXJzcGFjZSBrZXhlYy10b29scy4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBEZVZvbGRlciA8ZXJpYy5kZXZvbGRlckBvcmFjbGUu
Y29tPgo+PiAtLS0KPj4gICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICB8ICAxMSArKysrCj4+ICAg
YXJjaC94ODYva2VybmVsL2NyYXNoLmMgfCAxMTYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKykKPj4K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnCj4+IGlu
ZGV4IDc2MmEwYjZhYjhiNi4uZTllZWNmZjNiOTdkIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9L
Y29uZmlnCj4+ICsrKyBiL2FyY2gveDg2L0tjb25maWcKPj4gQEAgLTIwODIsNiArMjA4MiwxNyBA
QCBjb25maWcgQ1JBU0hfRFVNUAo+PiAgIAkgIChDT05GSUdfUkVMT0NBVEFCTEU9eSkuCj4+ICAg
CSAgRm9yIG1vcmUgZGV0YWlscyBzZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9r
ZHVtcC5yc3QKPj4gICAKPj4gK2NvbmZpZyBDUkFTSF9NQVhfTUVNT1JZX1JBTkdFUwo+PiArCWRl
cGVuZHMgb24gQ1JBU0hfRFVNUCAmJiBLRVhFQ19GSUxFICYmIChIT1RQTFVHX0NQVSB8fAo+IE1F
TU9SWV9IT1RQTFVHKQo+PiArCWludAo+PiArCWRlZmF1bHQgMzI3NjgKPj4gKwloZWxwCj4+ICsJ
ICBGb3IgdGhlIGtleGVjX2ZpbGVfbG9hZCBwYXRoLCBzcGVjaWZ5IHRoZSBtYXhpbXVtIG51bWJl
ciBvZgo+PiArCSAgbWVtb3J5IHJlZ2lvbnMsIGVnLiBhcyByZXByZXNlbnRlZCBieSB0aGUgJ1N5
c3RlbSBSQU0nIGVudHJpZXMKPj4gKwkgIGluIC9wcm9jL2lvbWVtLCB0aGF0IHRoZSBlbGZjb3Jl
aGRyIGJ1ZmZlci9zZWdtZW50IGNhbgo+IGFjY29tbW9kYXRlLgo+PiArCSAgVGhpcyB2YWx1ZSBp
cyBjb21iaW5lZCB3aXRoIE5SX0NQVVMgYW5kIG11bHRpcGxpZWQgYnkKPiBFbGY2NF9QaGRyCj4+
ICsJICBzaXplIHRvIGRldGVybWluZSB0aGUgZmluYWwgYnVmZmVyIHNpemUuCj4+ICsKPj4gICBj
b25maWcgS0VYRUNfSlVNUAo+PiAgIAlib29sICJrZXhlYyBqdW1wIgo+PiAgIAlkZXBlbmRzIG9u
IEtFWEVDICYmIEhJQkVSTkFUSU9OCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+IGluZGV4IDlkYjQxY2NlOGQ5Ny4uYjlj
ZGY3YTBkODY4IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiBAQCAtMjUsNiArMjUsNyBAQAo+PiAgICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4KPj4gICAj
aW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+
Cj4+ICAgCj4+ICAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4gICAjaW5jbHVkZSA8YXNt
L2hhcmRpcnEuaD4KPj4gQEAgLTM5OCw3ICszOTksMTcgQEAgaW50IGNyYXNoX2xvYWRfc2VnbWVu
dHMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+ICAgCWltYWdlLT5lbGZfaGVhZGVycyA9IGtidWYu
YnVmZmVyOwo+PiAgIAlpbWFnZS0+ZWxmX2hlYWRlcnNfc3ogPSBrYnVmLmJ1ZnN6Owo+PiAgIAo+
PiArI2lmIGRlZmluZWQoQ09ORklHX0hPVFBMVUdfQ1BVKSB8fCBkZWZpbmVkKENPTkZJR19NRU1P
UllfSE9UUExVRykKPj4gKwkvKiBFbnN1cmUgZWxmY29yZWhkciBzZWdtZW50IGxhcmdlIGVub3Vn
aCBmb3IgaG90cGx1ZyBjaGFuZ2VzICovCj4+ICsJa2J1Zi5tZW1zeiA9IChDT05GSUdfTlJfQ1BV
U19ERUZBVUxUICsKPiBDT05GSUdfQ1JBU0hfTUFYX01FTU9SWV9SQU5HRVMpICogc2l6ZW9mKEVs
ZjY0X1BoZHIpOwo+PiArCS8qIEZvciBtYXJraW5nIGFzIHVzYWJsZSB0byBjcmFzaCBrZXJuZWwg
Ki8KPj4gKwlpbWFnZS0+ZWxmX2hlYWRlcnNfc3ogPSBrYnVmLm1lbXN6Owo+PiArCS8qIFJlY29y
ZCB0aGUgaW5kZXggb2YgdGhlIGVsZmNvcmVoZHIgc2VnbWVudCAqLwo+PiArCWltYWdlLT5lbGZj
b3JlaGRyX2luZGV4ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+PiArCWltYWdlLT5lbGZjb3JlaGRy
X2luZGV4X3ZhbGlkID0gdHJ1ZTsKPj4gKyNlbHNlCj4+ICAgCWtidWYubWVtc3ogPSBrYnVmLmJ1
ZnN6Owo+PiArI2VuZGlmCj4+ICAgCWtidWYuYnVmX2FsaWduID0gRUxGX0NPUkVfSEVBREVSX0FM
SUdOOwo+PiAgIAlrYnVmLm1lbSA9IEtFWEVDX0JVRl9NRU1fVU5LTk9XTjsKPj4gICAJcmV0ID0g
a2V4ZWNfYWRkX2J1ZmZlcigma2J1Zik7Cj4+IEBAIC00MTMsMyArNDI0LDEwOCBAQCBpbnQgY3Jh
c2hfbG9hZF9zZWdtZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4gICAJcmV0dXJuIHJldDsK
Pj4gICB9Cj4+ICAgI2VuZGlmIC8qIENPTkZJR19LRVhFQ19GSUxFICovCj4+ICsKPj4gKyNpZiBk
ZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBM
VUcpCj4+ICtpbnQgY3Jhc2hfaG90cGx1Z19zdXBwb3J0KHZvaWQpIHsgcmV0dXJuIDE7IH0KPj4g
K3ZvaWQgKmFyY2hfbWFwX2NyYXNoX3BhZ2VzKHVuc2lnbmVkIGxvbmcgcGFkZHIsIHVuc2lnbmVk
IGxvbmcgc2l6ZSkKPj4gK3sKPj4gKwkvKgo+PiArCSAqIE5PVEU6IFRoZSBhZGRyZXNzZXMgYW5k
IHNpemVzIHBhc3NlZCB0byB0aGlzIHJvdXRpbmUgaGF2ZQo+PiArCSAqIGFscmVhZHkgYmVlbiBm
dWxseSBhbGlnbmVkIG9uIHBhZ2UgYm91bmRhcmllcy4gVGhlcmUgaXMgbm8KPj4gKwkgKiBuZWVk
IGZvciBtYXNzYWdpbmcgdGhlIGFkZHJlc3Mgb3Igc2l6ZS4KPj4gKwkgKi8KPj4gKwl2b2lkICpw
dHIgPSBOVUxMOwo+PiArCj4+ICsJLyogTk9URTogcmVxdWlyZXMgYXJjaF9rZXhlY19bdW5dcHJv
dGVjdF9jcmFzaGtyZXMoKSBmb3Igd3JpdGUKPiBhY2Nlc3MgKi8KPj4gKwlpZiAoc2l6ZSA+IDAp
IHsKPj4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBwZm5fdG9fcGFnZShwYWRkciA+PiBQQUdFX1NI
SUZUKTsKPj4gKwo+PiArCQlwdHIgPSBrbWFwKHBhZ2UpOwo+PiArCX0KPiAKPiBrbWFwX2xvY2Fs
X3BhZ2UoKSBpcyBwcmVmZXJyZWQgb3ZlciBrbWFwKCkgd2hpY2ggc2hvdWxkIGJlIGF2b2lkZWQg
aW4gbmV3Cj4gY29kZSAocGxlYXNlIHRha2UgYSBsb29rIGF0IGhpZ2htZW0ucnN0IHdoaWNoIEkg
cmVjZW50bHkgdXBkYXRlZCkuCj4gCj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgeW91IGNhbiBl
YXNpbHkgYXZvaWQgdXNpbmcga21hcCgpPyBPdGhlcndpc2UsIHRoaXMKPiBjb2RlIHdpbGwgYmUg
YWRkZWQgdG8gbXkgKGxvbmcpIHF1ZXVlIGFuZCBjaGFuZ2VkIG9uZSBkYXkgb3IgdGhlIG90aGVy
IDotKQo+IAo+IFRoYW5rcywKPiAKPiBGYWJpbwpGYWJpbywKSSBjb252ZXJ0ZWQgdGhpcyB0byBr
bWFwX2xvY2FsX3BhZ2UoKSEKVGhhbmtzIQplcmljCgo+IAo+PiArCj4+ICsJcmV0dXJuIHB0cjsK
Pj4gK30KPj4gKwo+PiArdm9pZCBhcmNoX3VubWFwX2NyYXNoX3BhZ2VzKHZvaWQgKipwdHIpCj4+
ICt7Cj4+ICsJaWYgKHB0cikgewo+PiArCQlpZiAoKnB0cikKPj4gKwkJCWt1bm1hcCgqcHRyKTsK
Pj4gKwkJKnB0ciA9IE5VTEw7Cj4+ICsJfQo+PiArfQo+PiArCj4+ICsvKioKPj4gKyAqIGFyY2hf
Y3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKSAtIEhhbmRsZSBob3RwbHVnIGVsZmNvcmVoZHIg
Y2hhbmdlcwo+PiArICogQGltYWdlOiB0aGUgYWN0aXZlIHN0cnVjdCBraW1hZ2UKPj4gKyAqIEBo
cF9hY3Rpb246IHRoZSBob3QgdW4vcGx1ZyBhY3Rpb24gYmVpbmcgaGFuZGxlZAo+PiArICogQGNw
dTogd2hlbiBLRVhFQ19DUkFTSF9IUF9BREQvUkVNT1ZFX0NQVSwgdGhlIGNwdSBhZmZlY3RlZAo+
PiArICoKPj4gKyAqIFRvIGFjY3VyYXRlbHkgcmVmbGVjdCBob3QgdW4vcGx1ZyBjaGFuZ2VzLCB0
aGUgZWxmY29yZWhkciAod2hpY2gKPj4gKyAqIGlzIHBhc3NlZCB0byB0aGUgY3Jhc2gga2VybmVs
IHZpYSB0aGUgZWxmY29yZWhkcj0gcGFyYW1ldGVyKQo+PiArICogbXVzdCBiZSB1cGRhdGVkIHdp
dGggdGhlIG5ldyBsaXN0IG9mIENQVXMgYW5kIG1lbW9yaWVzLiBUaGUgbmV3Cj4+ICsgKiBlbGZj
b3JlaGRyIGlzIHByZXBhcmVkIGluIGEga2VybmVsIGJ1ZmZlciwgYW5kIHRoZW4gaXQgaXMKPj4g
KyAqIHdyaXR0ZW4gb24gdG9wIG9mIHRoZSBleGlzdGluZy9vbGQgZWxmY29yZWhkci4KPj4gKyAq
Cj4+ICsgKiBGb3IgaG90cGx1ZyBjaGFuZ2VzIHRvIGVsZmNvcmVoZHIgdG8gd29yaywgdHdvIGNv
bmRpdGlvbnMgYXJlCj4+ICsgKiBuZWVkZWQ6Cj4+ICsgKiBGaXJzdCwgdGhlIHNlZ21lbnQgY29u
dGFpbmluZyB0aGUgZWxmY29yZWhkciBtdXN0IGJlIGxhcmdlIGVub3VnaAo+PiArICogdG8gcGVy
bWl0IGEgZ3Jvd2luZyBudW1iZXIgb2YgcmVzb3VyY2VzLiBTZWUgdGhlCj4+ICsgKiBDT05GSUdf
Q1JBU0hfTUFYX01FTU9SWV9SQU5HRVMgZGVzY3JpcHRpb24uCj4+ICsgKiBTZWNvbmQsIHB1cmdh
dG9yeSBtdXN0IGV4cGxpY2l0bHkgZXhjbHVkZSB0aGUgZWxmY29yZWhkciBmcm9tIHRoZQo+PiAr
ICogbGlzdCBvZiBzZWdtZW50cyBpdCBjaGVja3MgKHNpbmNlIHRoZSBlbGZjb3JlaGRyIGNoYW5n
ZXMgYW5kIHRodXMKPj4gKyAqIHdvdWxkIHJlcXVpcmUgYW4gdXBkYXRlIHRvIHB1cmdhdG9yeSBp
dHNlbGYgdG8gdXBkYXRlIHRoZSBkaWdlc3QpLgo+PiArICoKPj4gKyAqLwo+PiArdm9pZCBhcmNo
X2NyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KHN0cnVjdCBraW1hZ2UgKmltYWdlLAo+PiArCXVu
c2lnbmVkIGludCBocF9hY3Rpb24sIHVuc2lnbmVkIGludCBjcHUpCj4+ICt7Cj4+ICsJc3RydWN0
IGtleGVjX3NlZ21lbnQgKmtzZWdtZW50Owo+PiArCXVuc2lnbmVkIGNoYXIgKnB0ciA9IE5VTEw7
Cj4+ICsJdW5zaWduZWQgbG9uZyBlbGZzeiA9IDA7Cj4+ICsJdm9pZCAqZWxmYnVmID0gTlVMTDsK
Pj4gKwl1bnNpZ25lZCBsb25nIG1lbSwgbWVtc3o7Cj4+ICsKPj4gKwkvKgo+PiArCSAqIEVsZmNv
cmVoZHJfaW5kZXhfdmFsaWQgY2hlY2tlZCBpbgo+IGNyYXNoX2NvcmU6aGFuZGxlX2hvdHBsdWdf
ZXZlbnQoKQo+PiArCSAqLwo+PiArCWtzZWdtZW50ID0gJmltYWdlLT5zZWdtZW50W2ltYWdlLT5l
bGZjb3JlaGRyX2luZGV4XTsKPj4gKwltZW0gPSBrc2VnbWVudC0+bWVtOwo+PiArCW1lbXN6ID0g
a3NlZ21lbnQtPm1lbXN6Owo+PiArCj4+ICsJLyoKPj4gKwkgKiBDcmVhdGUgdGhlIG5ldyBlbGZj
b3JlaGRyIHJlZmxlY3RpbmcgdGhlIGNoYW5nZXMgdG8gQ1BVIGFuZC9vcgo+PiArCSAqIG1lbW9y
eSByZXNvdXJjZXMuCj4+ICsJICovCj4+ICsJaWYgKHByZXBhcmVfZWxmX2hlYWRlcnMoaW1hZ2Us
ICZlbGZidWYsICZlbGZzeikpIHsKPj4gKwkJcHJfZXJyKCJjcmFzaCBocDogdW5hYmxlIHRvIHBy
ZXBhcmUgZWxmY29yZSBoZWFkZXJzIik7Cj4+ICsJCWdvdG8gb3V0Owo+PiArCX0KPj4gKwlpZiAo
ZWxmc3ogPiBtZW1zeikgewo+PiArCQlwcl9lcnIoImNyYXNoIGhwOiB1cGRhdGUgZWxmY29yZWhk
ciBlbGZzeiAlbHUgPiBtZW1zego+ICVsdSIsCj4+ICsJCQllbGZzeiwgbWVtc3opOwo+PiArCQln
b3RvIG91dDsKPj4gKwl9Cj4+ICsKPj4gKwkvKgo+PiArCSAqIEF0IHRoaXMgcG9pbnQsIHdlIGFy
ZSBhbGwgYnV0IGFzc3VyZWQgb2Ygc3VjY2Vzcy4KPj4gKwkgKiBDb3B5IG5ldyBlbGZjb3JlaGRy
IGludG8gZGVzdGluYXRpb24uCj4+ICsJICovCj4+ICsJcHRyID0gYXJjaF9tYXBfY3Jhc2hfcGFn
ZXMobWVtLCBtZW1zeik7Cj4+ICsJaWYgKHB0cikgewo+PiArCQkvKgo+PiArCQkgKiBUZW1wb3Jh
cmlseSBpbnZhbGlkYXRlIHRoZSBjcmFzaCBpbWFnZSB3aGlsZSB0aGUKPj4gKwkJICogZWxmY29y
ZWhkciBpcyB1cGRhdGVkLgo+PiArCQkgKi8KPj4gKwkJeGNoZygma2V4ZWNfY3Jhc2hfaW1hZ2Us
IE5VTEwpOwo+PiArCQltZW1jcHlfZmx1c2hjYWNoZSgodm9pZCAqKXB0ciwgZWxmYnVmLCBlbGZz
eik7Cj4+ICsJCXhjaGcoJmtleGVjX2NyYXNoX2ltYWdlLCBpbWFnZSk7Cj4+ICsJfQo+PiArCWFy
Y2hfdW5tYXBfY3Jhc2hfcGFnZXMoKHZvaWQgKiopJnB0cik7Cj4+ICsJcHJfZGVidWcoImNyYXNo
IGhwOiByZS1sb2FkZWQgZWxmY29yZWhkciBhdCAweCVseFxuIiwgbWVtKTsKPj4gKwo+PiArb3V0
Ogo+PiArCWlmIChlbGZidWYpCj4+ICsJCXZmcmVlKGVsZmJ1Zik7Cj4+ICt9Cj4+ICsjZW5kaWYK
Pj4gLS0gCj4+IDIuMzEuMQo+Pgo+Pgo+IAo+IAo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
