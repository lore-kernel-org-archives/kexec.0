Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0393ACD1288
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djwU/MVqMZNtkHkJ9u/uGrJkOh/gohTJ/Qcz4IVwRzk=; b=4aIbKaumF/jmAOgAmdl4UVsbdv
	hZp6Uoyn0Atb0ZmQA90pR7QYdUJQhZfdbPfVvtYd0lU/hROt1ssglrl7ZpsnqsHltthhOtdxFHK13
	QmqTADapfr+jOve72cRRxq9qUd02i6jXbpnUYKJ5SCbXWm+NbQSbtM9NCWH9Ak7Sef+oARiScLmyb
	gbAC9/xCL/lUahjxaPOmW6SJp72K19NjaVMwgDHigL9Da/a/2iyNs/acJh5I9mhLMzUsaCXkkDkZt
	o8oCsY3CogZFbXincMEqgmcomb6+1B1HtQ6ULZiibsQSoyXS940+tRFVRM3rfHftm5n38eTmu7wf+
	AaDTEgZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsF9W-00000001DAc-1y4Q;
	Thu, 04 Apr 2024 04:56:42 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsF9T-00000001DA4-2nQp
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 04:56:41 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433NOZr7027642;
	Thu, 4 Apr 2024 04:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iOXpe8tymSEon1bBs7OObxOPcJ0U7cmgiPKdZ9S327A=;
 b=MQk+EB51+SFQKCFepKhOFsUsm0KJGtfMpax7YP+8NN/rMIuW6aZ4ahxst5j2kWmuQzz6
 zgYQszkNzNHsO3rtK7t6qiQTWT10rQn/RpB3Pi3aQYFq3GX8o4Cf83+7Wp+SZk+ip/GQ
 4gOxd0gpPEA3mkb3eUu4DpjdkpAq8B3b6Ze5T2Y4tTU8bbPhKHJwy6IuOrQoHz7B5zqr
 IyINICpmg9mJKhJi4qWsdIwuIMMjdeM0cH3xsaHO80j/sHBiZtwso9Wd9ot1ILeY+dLX
 XInDxNOaYbSJWU5fSU8op+78iMG2blgnhgAzdh9SsEJq+D11zhq3iUy1fhK2yOOkYjEA 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9euy0dbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 04:55:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43429igb009246;
	Thu, 4 Apr 2024 04:55:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emk3hpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 04:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU9x7n2dc/Oms5cDbMljjSGULkTd5iftjtU89VJfsz1KDPmhSFl5UnyjhxkqokTKMv9knf+LNx/UuABjeVA39fidnWQ6npDjpJmUff1ht5E6BhWQ/DrSm/1uyRgQxztaBI5ppyOww6sHzfaWWBY5bqsZQKuliSeRhyimrHECrA4Yw1RszW2kZkRizdMbX0EKaH3Co9Lw1iCple59UOpKREB/lxmn0CKxyoxpP4ZF2jMIysLmZAxsISgdTj+A5PSZQuiyzVFqI1ZMsZLRQglctt1WWOpn0wl/YoYOfoV80oC+J8tViJDBQUYLcQBgRNE4E33JKOno/CIyvmoBOylUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOXpe8tymSEon1bBs7OObxOPcJ0U7cmgiPKdZ9S327A=;
 b=Rfg+bCq3ybyromBY2xT8GcrpqOUou/rV6nsn/Vi1m+K0pJ1OVaDqunNxqr2EKMeGY90mF4hTntcAUn8aMYiJrLZL+fxpr3czroM2xPtL3tPCI7RCXZ8hy+qpntq8aCl0OpSxrx4oqn+Nr70Se8k/GMGXYho8ksSwjYGbaRSDvPnNbo2/R2LPiHIA4MLJhpG9wdn/TMHAT+29Xveehe/pM+g3RsgsBhJuJx81BlNIUVROnBWI/7yypTPiEJ/KEdux59MF5t1ZJXGtQ//yuqGL40RyA9kvzePeswnZ2dh3919ZcoWd9LojZGvNhxskv8fipCo7DnbFcNXeApqzxbKUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOXpe8tymSEon1bBs7OObxOPcJ0U7cmgiPKdZ9S327A=;
 b=vpLwMPQpKvFp9BfTC8WeaS0MFXcTgt3EXMXjb7AlSJYjPfkrBM52+RKkRhfdVOMDYQNnNCwRnOMZAiMsHn1F+XcxdicAPATNdwqAR5FjKOCc35VaHJC4VIskDFmk6+E+ZvUk23oukLBfBryi1p05YZH+uJn5lD9pupjYnGdLbdo=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 04:55:46 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::2f49:6cae:c52a:7d8e]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::2f49:6cae:c52a:7d8e%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 04:55:46 +0000
Message-ID: <8b6285e8-bb00-4541-b054-ee01c86d367a@oracle.com>
Date: Wed, 3 Apr 2024 21:55:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
To: Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
 <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
 <20240223183004.GE1112@sol.localdomain>
 <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com>
 <20240403235635.GA24248@quark.localdomain>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20240403235635.GA24248@quark.localdomain>
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB7683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auScmtBo4sLKpB+vvrBOUpq4VjmHfGEd0ZH3oY524n6HB2vcwj85/Y5AeVKmxXBv73Hko32slmUQzpNoUL4u368wj5d0BGXnYz+pSaky9+Kf66796Mv+Xa1Dq9uP0Sn6hKQ/Itu6jex/gy0RMeGMgCdjtkkIvvZNYMUJZ1aUSHfmuOiw8PExCcEEy4NwxcXr19yhT4M8Uzapt1XgidMPPiJc5Ojz+u9Lrsnfdpeo2CbpHL/2HflSuNvTaylEZc3Og34LMeQ623ZIhGRmDPh9tAempZPXb1ms63U/CKNS1nE2OOJZs1VG0kipnfUVNs14BCBewSCctmB7iKeV7R47L9CEZwL51kZzI3iSJOqvJ6d1iwQkdGG2rhmdcwIx0sOY7bhqtHL6jLvpE4McG39XXGyFgqzxibDuKfg40oAKCgVkrxlOipGVE43jvE6PhJaKSY/FISKskg/IoRdzGWb1J3vz3uVqUTLNOaFMMUd7Wqt3SquejdaVNYQJPbtVXkQqgvYp81LQGa1bD8SvdW5fAsK6TxF0QUlw62sRUX6nlCcQZ9FtFu+UhEtHnjWCxGeguY7sYhCnwjDUHGf78NruzvpRFTlIrYqWRVosNHUi30dxrefsH6cJVRdss/JvDhuQCF66ZvZ8+2vYs3qjUXvbdGcXr/3jHndD8zMJXJMYGwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9yK0tFRUpRNkhWaVVRcjZZZHpqU2lPa250S3Y2Rk9tQ3gybGVZVHQwUHJ0?=
 =?utf-8?B?LzJHT3dPMWsxeHN4bGE5cHJXZ3Z3MkpEUml1cVlYbjA2czFLM2dDK1hHWEl5?=
 =?utf-8?B?NUFsM3NHbm9RTHVYdzBneUlZOFV1SVFHM1hiWmNoRE5PdW5DK2lPNnhJdisv?=
 =?utf-8?B?c05OeU8yRUZmdkQ1NjRya3gvQVVuQi93bmlucWJhdENReVQyMmV3Y3YwZDN6?=
 =?utf-8?B?UmFIUFpDaXVPc3Z4QlppWVJydFdqV3hRL2ZoTlVNRVJhN3lEcGdxMTRRWTlm?=
 =?utf-8?B?VzZpWExMa2hyY0twMXN5NC9TR3htQjdzM2t2b3lMdDhJVzErTWNXd1lBTmtX?=
 =?utf-8?B?TE1QQnFxdXNybC81NU83SHpmVC9qY3plSzJaSEtITGNJeHJ6NUlNWXlTQXRa?=
 =?utf-8?B?NCtTNWgyK0lPQzNycnBLZEk4Q0hoYUJoRk5Lc0FMdU43Vm40cFM0UmtDVUtV?=
 =?utf-8?B?U0RCVGxpTDFOWnhLSktoVWxVSHhIbUZLZUppRlNxRUdUeE10RnlBbmdCbUVt?=
 =?utf-8?B?VnMvaWdOQnROY1VXZURKalFDR29MN2lCSmZldTNqSnM5TjJML2MyZGFFMkxV?=
 =?utf-8?B?NGcySVorVitnMXp1R0xnNlZTK1ZKSXBVaElYSzhqMVJ1VlR3Y1NFcUlGUjBa?=
 =?utf-8?B?ZFpuNThneUQ3K3hLOGF4QVF1aCt3KzhGbEN0N3U2UUo5dkNoejF0ZnRDeGZp?=
 =?utf-8?B?YnJTdGZEdGlka0hFWFNhaXZIVFd3aGhWOHY0cmRNK2ZrK2pwaC9NZWR0djVa?=
 =?utf-8?B?eU04Z2J2UFFCdkJlSW81VTliNGNlWC9ZMUJYU01PelhNTHhvZVFUdFVHYmQ0?=
 =?utf-8?B?clhtYkpOVzVCNldmTmNaazlKVG1qZ0g5TmVXVk1RN1dSVHVKZi9SVHJEQk5K?=
 =?utf-8?B?ZTFjM3lMbEZwdzhkaGpPUjgwVitRcGNvNUdOODE4b2xNNWRVNXk4eGJ1bXlK?=
 =?utf-8?B?b00vTlZNTU1od1dPZEIwWDBzb0VuRlVZcmQySkdiT1AwSTRPNzdBUkpwMkw4?=
 =?utf-8?B?dXNpeklzMDMxOTdUN2FNS2RabnVvMWJLK1JVMHAwclREcW8zbmZvMTl1Y0xD?=
 =?utf-8?B?TEZFbDduK2pEVDUrTXhRZ29nNk9HTkszZnVSdHRmUm94WEpNL0I1Y2I5elBs?=
 =?utf-8?B?dUNIWmt6dURRR09ZQTlYNGxDemFXMmNJM0toL290cmp0M0U3TXNidWd0dFBq?=
 =?utf-8?B?TkhqTml3VlVtWExCMzdBeTZpZ0NRZG45cEFWV2w0azlVb0pLeVg1Rm1QUTUx?=
 =?utf-8?B?UmlldEVQYXF2VG5ndFNDSU1ZQTlhK2J5NlpvdW9qUDQxUTBpaERocE9FLy8r?=
 =?utf-8?B?RnNyQXl6WmF5YmxHaDZxQnRsbDNrKzh5OHFhMEFSdHJSbXJqL0lvVDhFTExO?=
 =?utf-8?B?VEhJclZGY1NTNnYyT0RxL0xmS0NvZnZGWisyUlhTK1NqTWpoVHU3QUgrRG9F?=
 =?utf-8?B?ODdFL2x4b3dTaHdFclJoZG9zeEExaU9ZMytWZ3BxY1hXZ0x6V2VqU215YzdG?=
 =?utf-8?B?M2FuTFJObmdJTDVrMW9XRFVVaURGd051OXZ5WkJpajg1a09DaXlQUkF2bWYw?=
 =?utf-8?B?WWY2cHlOVnNVKzdocmV2TS9Ta2pOY21BVWJQcVM1V1ZxU1NtOTRRb2hwVlB5?=
 =?utf-8?B?d2hBSDdWTEZkMGFiY0o3d0F5M3BFbzY5OGxZazBJRjBkM0YyeG5HVFJXQmQv?=
 =?utf-8?B?MDI2L0JZdXhOMXpFdS9KdHZ2c1d4MGdZMktTMFRRSWQybXVxY0ZCT3dFcWtC?=
 =?utf-8?B?bUVQTmR0d1ZvSkZvMGRoMyt1bUphTWxPV0tUUlB2akI0UG1XUHNSNWJ5V0J4?=
 =?utf-8?B?eXVmOVBDSHlLTkxrT3pCWUQ0NFUra21neHc4ZTNTUUorcXlxcFgxNU9aMVJE?=
 =?utf-8?B?RE15NktVU2w2YitJdmJLZ1JjU2ZhUURpZU9zNTEwNVREY0J2Y2ViZEhOVDI3?=
 =?utf-8?B?bTI2eU12Rk5Ca2t2Y0tjMlVpSnpST2Y2dk43Mk5ZdTNKQVpiZkxEQjlwejA1?=
 =?utf-8?B?WUl0VjlFUXBsazRka0pza2V0Mitmd1dYRTlUL3pEek91cEx5dm9OOWt2elRH?=
 =?utf-8?B?aUl1M0E0NEozc1BWNEhTYVVGcUhoeDNwWUUxOERCTjRmdlc2cDdycGZ5bVlo?=
 =?utf-8?B?Yy9aL0MwSmNWdzkyVFdGdThHSFJiVm5tTitPTlVmd2RDVWtkUFhIS3pSMFM1?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZhgedLelWmlsrj8M6t/eG4130W84/DkEcMrGgMlMprFPv/4AYoypFZyCAH7YDU1p3oeDgdJ73wKx9yj61koMxUFZZSWnD+uEA8Wk/Qe+w274zAkSmA6AbZ/tp9m1YDPNxYlWURMbMpoB+XM22LjATD5MeMyRPpeqL91KuTNNtJhmGhjRAemC5OkNxxU09/3TNE2HnFo4xxjedqcwjSZA0gBOnz+Kb0cUi1cKuIfx77ND079eIkngBmeQRakF3C7Zv7xsUsipQLHHfUlvUKvqUVivP64Fl+7zet6Wrx4Kq8lznkCGk3OnhG+V+cE3Lrv9pjKYpO3Fp7fR4cThNYhxVOqqiDWhcoRyTYlWrjxVl4ivOD/Jm0Oahsa08e0qPmaYZEAvfi+BTo83EAtcpi7dQ8J5/qCJAzPb9HRpM2m+x9giSFkj5UK2bnQgU/HU/PY4Mvn+M/mLfpX/o5tZhbE2a6seQpRJGfPjX8XCfyvJHjSutdmvXLKX4fcbYZCGHncMKMMNZNT2D1MQ+i8oIQ7RtOUou2UiO59sSbFCd2kiayF/DS9hfpNOku7ZppozXQYxfy/KCgwuZvWKnTjDzQvV22QcoAkHZvVYmq2NLwjMnrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c5bf59-fbac-480f-045b-08dc54637d52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 04:55:46.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jfer0S2nB0I4gX+3iQbp4MxH7k7s5kZEqTjbfmx4yDGa+D7BMT73zzGz9zGZU3i5/CO44wbdHP4LQXze6vFZo4BZd9Wh1mleku4tgMpFxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_26,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040031
X-Proofpoint-ORIG-GUID: HWal3hBvE-5RgHD68ArZoydWO36t-kh7
X-Proofpoint-GUID: HWal3hBvE-5RgHD68ArZoydWO36t-kh7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_215639_738972_1907E58A 
X-CRM114-Status: GOOD (  32.15  )
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

T24gNC8zLzI0IDQ6NTYgUE0sIEVyaWMgQmlnZ2VycyB3cm90ZToKPiBPbiBXZWQsIEFwciAwMywg
MjAyNCBhdCAwOTozMjowMkFNIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+IE9uIEZy
aSwgRmViIDIzLCAyMDI0LCBhdCAxMDozMCBBTSwgRXJpYyBCaWdnZXJzIHdyb3RlOgo+Pj4gT24g
RnJpLCBGZWIgMjMsIDIwMjQgYXQgMDY6MjA6MjdQTSArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90
ZToKPj4+PiBPbiAyMy8wMi8yMDI0IDU6NTQgcG0sIEVyaWMgQmlnZ2VycyB3cm90ZToKPj4+Pj4g
T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMDQ6NDI6MTFQTSArMDAwMCwgQW5kcmV3IENvb3BlciB3
cm90ZToKPj4+Pj4+IFllcywgYW5kIEkgYWdyZWUuwqAgV2UncmUgbm90IGxvb2tpbmcgdG8gdHJ5
IGFuZCBmb3JjZSB0aGlzIGluIHdpdGgKPj4+Pj4+IHVuZGVyaGFuZCB0YWN0aWNzLgo+Pj4+Pj4K
Pj4+Pj4+IEJ1dCBhIGJsaW5kICJuYWNrIHRvIGFueSBTSEEtMSIgaXMgc2ltaWxhcmx5IGRhbWFn
aW5nIGluIHRoZSBvcHBvc2l0ZQo+Pj4+Pj4gZGlyZWN0aW9uLgo+Pj4+Pj4KPj4+Pj4gV2VsbCwg
cmV2aWV3ZXJzIGhhdmUgc2FpZCB0aGV5J2QgcHJlZmVyIHRoYXQgU0hBLTEgbm90IGJlIGluY2x1
ZGVkIGFuZCBnaXZlbgo+Pj4+PiBzb21lIHRob3VnaHRmdWwgcmVhc29ucyBmb3IgdGhhdC4gIEJ1
dCBhbHNvIHRoZXkndmUgZ2l2ZW4gc3VnZ2VzdGlvbnMgb24gaG93IHRvCj4+Pj4+IG1ha2UgdGhl
IFNIQS0xIHN1cHBvcnQgbW9yZSBwYWxhdGFibGUsIHN1Y2ggYXMgc3BsaXR0aW5nIGl0IGludG8g
YSBzZXBhcmF0ZQo+Pj4+PiBwYXRjaCBhbmQgZ2l2aW5nIGl0IGEgcHJvcGVyIGp1c3RpZmljYXRp
b24uCj4+Pj4+Cj4+Pj4+IEFsbCBzdWdnZXN0aW9ucyBoYXZlIGJlZW4gaWdub3JlZC4KPj4+Pgo+
Pj4+IFRoZSBwdWJsaWMgcmVjb3JkIGRlbW9uc3RyYXRlcyBvdGhlcndpc2UuCj4+Pj4KPj4+PiBC
dXQgYXJlIHlvdSBzYXlpbmcgdGhhdCB5b3UnZCBiZSBoYXBweSBpZiB0aGUgY29tbWl0IG1lc3Nh
Z2UgcmVhZAo+Pj4+IHNvbWV0aGluZyBtb3JlIGxpa2U6Cj4+Pj4KPj4+PiAtLS04PC0tLQo+Pj4+
IEZvciBiZXR0ZXIgb3Igd29yc2UsIFNlY3VyZSBMYXVuY2ggbmVlZHMgU0hBLTEgYW5kIFNIQS0y
NTYuCj4+Pj4KPj4+PiBUaGUgY2hvaWNlIG9mIGhhc2hlcyB1c2VkIGxpZSB3aXRoIHRoZSBwbGF0
Zm9ybSBmaXJtd2FyZSwgbm90IHdpdGgKPj4+PiBzb2Z0d2FyZSwgYW5kIGlzIG9mdGVuIG91dHNp
ZGUgb2YgdGhlIHVzZXJzIGNvbnRyb2wuCj4+Pj4KPj4+PiBFdmVuIGlmIHdlJ2QgcHJlZmVyIHRv
IHVzZSBTSEEtMjU2LW9ubHksIGlmIGZpcm13YXJlIGVsZWN0ZWQgdG8gc3RhcnQgdXMKPj4+PiB3
aXRoIHRoZSBTSEEtMSBhbmQgU0hBLTI1NiBiYWNrcyBhY3RpdmUsIHdlIHN0aWxsIG5lZWQgU0hB
LTEgdG8gcGFyc2UKPj4+PiB0aGUgVFBNIGV2ZW50IGxvZyB0aHVzIGZhciwgYW5kIGRlbGliZXJh
dGVseSBjYXAgdGhlIFNIQS0xIFBDUnMgaW4gb3JkZXIKPj4+PiB0byBzYWZlbHkgdXNlIFNIQS0y
NTYgZm9yIGV2ZXJ5dGhpbmcgZWxzZS4KPj4+PiAtLS0KPj4+Cj4+PiBQbGVhc2UgdGFrZSBzb21l
IHRpbWUgdG8gcmVhZCB0aHJvdWdoIHRoZSBjb21tZW50cyB0aGF0IHJldmlld2VycyBoYXZlIGxl
ZnQgb24KPj4+IHByZXZpb3VzIHZlcnNpb25zIG9mIHRoZSBwYXRjaHNldC4KPj4KPj4gU28gSSB3
ZW50IGFuZCByZWFkIHRocm91Z2ggdGhlIG9sZCBjb21tZW50cywgYW5kIEknbSBsb3N0LiAgSW4g
YnJpZWYgc3VtbWFyeToKPj4KPj4gSWYgdGhlIGhhcmR3YXJlK2Zpcm13YXJlIG9ubHkgc3VwcG9y
dHMgU0hBLTEsIHRoZW4gc29tZSByZXZpZXdlcnMgd291bGQgcHJlZmVyCj4+IExpbnV4IG5vdCB0
byBzdXBwb3J0IERSVE0uICBJIHBlcnNvbmFsbHkgdGhpbmsgdGhpcyBpcyBhIGJpdCBzaWxseSwg
YnV0IGl0J3MKPj4gbm90IGVudGlyZWx5IHVucmVhc29uYWJsZS4gIE1heWJlIGl0IHNob3VsZCBi
ZSBhIGNvbmZpZyBvcHRpb24/Cj4+Cj4+IElmIHRoZSBoYXJkd2FyZStmaXJtd2FyZSBkb2VzIHN1
cHBvcnQgU0hBLTI1NiwgdGhlbiBpdCBzb3VuZHMgKHRvIG1lLCByZWFkaW5nCj4+IHRoaXMgLS0g
SSBoYXZlbid0IGR1ZyBpbnRvIHRoZSByaWdodCBzcGVjIHBhZ2VzKSB0aGF0LCBmb3Igb3B0aW1h
bCBzZWN1cml0eSwKPj4gc29tZXRoaW5nIHN0aWxsIG5lZWRzIHRvIGVmZmVjdGl2ZWx5IHR1cm4g
U0hBLTEgKm9mZiogYXQgcnVudGltZSBieSBjYXBwaW5nCj4+IHRoZSBldmVudCBsb2cgcHJvcGVy
bHkuICBBbmQgdGhhdCByZXF1aXJlcyBjb21wdXRpbmcgYSBTSEEtMSBoYXNoLiAgQW5kLCB0byBi
ZQo+PiBjbGVhciwgKGEpIHRoaXMgaXMgb25seSBvbiBzeXN0ZW1zIHRoYXQgYWxyZWFkeSBzdXBw
b3J0IFNIQS0yNTYgYW5kIHRoYXQgd2UKPj4gc2hvdWxkIHN1cHBvcnQgYW5kIChiKSAqbm90KiBk
b2luZyBzbyBsZWF2ZXMgdXMgcG90ZW50aWFsbHkgbW9yZSB2dWxuZXJhYmxlIHRvCj4+IFNIQS0x
IGF0dGFja3MgdGhhbiBkb2luZyBzby4gIEFuZCBubyBTSEEtMjU2LXN1cHBvcnRpbmcgdG9vbGlu
ZyB3aWxsIGFjdHVhbGx5Cj4+IGJlIGNvbXByb21pc2VkIGJ5IGEgU0hBLTEgY29tcHJvbWlzZSBp
ZiB3ZSBjYXAgdGhlIGV2ZW50IGxvZy4KPj4KPj4gU28gaXMgdGhlcmUgYSB3YXkgZm9yd2FyZD8g
IEp1c3Qgc2F5aW5nICJyZWFkIHRocm91Z2ggdGhlIGNvbW1lbnRzIiBzZWVtcyBsaWtlCj4+IGEg
ZGVhZCBlbmQuCj4+Cj4gCj4gSXQgc2VlbXMgdGhlcmUgbWF5IGJlIGEganVzdGlmaWNhdGlvbiBm
b3Igc29tZSBmb3JtIG9mIFNIQS0xIHN1cHBvcnQgaW4gdGhpcwo+IGZlYXR1cmUuICBBcyBJJ3Zl
IHNhaWQsIHRoZSBwcm9ibGVtIGlzIHRoYXQgaXQncyBub3QgZXhwbGFpbmVkIGluIHRoZSBwYXRj
aHNldAo+IGl0c2VsZi4gIFJhdGhlciwgaXQganVzdCB0YWxrcyBhYm91dCAiU0hBIiBhbmQgcHJl
dGVuZHMgbGlrZSBTSEEtMSBhbmQgU0hBLTIgYXJlCj4gYmFzaWNhbGx5IHRoZSBzYW1lLiAgSW4g
ZmFjdCwgU0hBLTEgZGlmZmVycyBkcmFzdGljYWxseSBmcm9tIFNIQS0yIGluIHRlcm1zIG9mCj4g
c2VjdXJpdHkuICBTSEEtMSBzdXBwb3J0IHNob3VsZCBiZSBhZGRlZCBpbiBhIHNlcGFyYXRlIHBh
dGNoLCB3aXRoIGEgY2xlYXJseQo+IGV4cGxhaW5lZCByYXRpb25hbGUgKmluIHRoZSBwYXRjaCBp
dHNlbGYqIGZvciB0aGUgU0hBLTEgc3VwcG9ydCAqc3BlY2lmaWNhbGx5Ki4KCkZvciB0aGUgcmVj
b3JkLCB3ZSB3ZXJlIG5ldmVyIHRyeWluZyB0byAicHJldGVuZCIgb3Igb2JmdXNjYXRlIHRoZSB1
c2UgCm9mIFNIQS0xLiBJdCB3YXMgc2ltcGx5IGV4cGVkaWVudCB0byBwdXQgdGhlIGhhc2ggYWxn
b3JpdGhtIGNoYW5nZXMgaW4gCm9uZSBwYXRjaC4gV2UgaGF2ZSBub3cgc2VwYXJhdGVkIHRoZSBw
YXRjaGVzIGZvciBjbGFyaXR5IGFuZCB3aWxsIGFkZCAKYW55IHRleHQgdGhhdCBleHBsYWlucyBv
dXIgdXNlIGFuZC9vciBleHBsYWluIHRoZSBpc3N1ZXMgd2l0aCBpdHMgdXNlLgoKV2Ugd2VudCBi
YWNrIHRocm91Z2ggdGhlIGNvbW1lbnRzIGFuZCB0cmllZCB0byBhZGRyZXNzIGV2ZXJ5dGhpbmcg
dGhhdCAKY2FtZSB1cCBhYm91dCB0aGUgdXNlIG9mIFNIQS0xLiBXZSB3aWxsIHJldmlldyBpdCBh
bGwgYWdhaW4gYmVmb3JlIApwb3N0aW5nIGFub3RoZXIgcGF0Y2ggc2V0LgoKVGhhbmsgeW91IGZv
ciB5b3VyIGZlZWRiYWNrLgpSb3NzCgo+IAo+IC0gRXJpYwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
