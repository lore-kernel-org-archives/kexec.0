Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66130EE49A6
	for <kexec@archiver.kernel.org>; Sun, 20 Aug 2023 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbntMytU+FSDaTbLfHei46QEgCqSWnQt9EWbA1OdLJA=; b=YJhkw4Y1i4+WALLC8fMTYYM0RZ
	/f1PTcTXTgzrvLeGXQ/tcoOZHL/VPGd7RqI/lkfH9VJKaZOqypRrUnjLA1Ttxy8rLF8M4zdv+L+MX
	NOy4d9lMC1cZBtT5MYvUTIp1jY8MhPqnpuU0qeysvy/niTedq+T17u0n3GtBeluu8yckC5XiRZ3zV
	MaJrvMJ9VmDfvZFcZ4OX8yJAA0zX/pl3NnAOvHTXkDHVTTRJqk09Fg1eo+wfMyQoKgqNZa8PdM8bW
	UMAfa+dXXkTLrvC26KV7HMDcRBV4Eu96+ucfFhq5eEur4QkgOOrB9OaU1L4ypAfXpXeVazUkbfj9Z
	O7LrhVGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXqQa-00CYSt-13;
	Sun, 20 Aug 2023 21:57:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXqQV-00CYSH-1r
	for kexec@lists.infradead.org;
	Sun, 20 Aug 2023 21:57:41 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KIj3mU029154;
	Sun, 20 Aug 2023 21:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/xTCBE3/OpFLa6Xm+uzbANgUnX34U6iwhgROaSMmMnE=;
 b=Yw46w7EA9TYB0cO6VEHVxAbdFvITQ7yKmYeHF1FSkVCoJ7s0vRygPuF6l6Fp1j3iLzum
 YGVXyK2mFCtDeXBvyn1FEgbhr6d1dn7DKlJKcLbJB1oxiU975W3HCn6j02VLV2VVOUy5
 pGaOpHRWHtoVQ76jLqb1t3z59Lq1QK9qEt75XmUyMgIxZcWYSI/tiZSZPk0f0FnUiMyk
 wt1UPZ4fjnnjYiAyjzazl/kXTKCkzLFi594IvSjQJbfCOpSWZFnvv7EazNAv9HGXj6UN
 dY8LogpOdF7kentz09HJUWZ/1qxO3SPTUxhqMKtwAJp4hIkZ81bE/OqsWpz7odhHBlyO hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9u9ks6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Aug 2023 21:56:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37KGTUWg007708;
	Sun, 20 Aug 2023 21:56:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm62ry0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Aug 2023 21:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiHKHDzWNzF4bgrnsqG2IPj4SXgf4ME0sAIPCRqj3qrkkvvyhTyNyN6OGytWuorBJR0YeLiLWADkaHoNgbPLd41zALWvLDTH4YKc8p+BInCqOS1YhcJF9qjcmU57L7yo9Z+bVVeh7b/Jo/8gXZqk2Msf71BNJ42a5dY7wvkFxvLaO6WUGIf7Frcmwllwqbd4ALJfYr0mg+t2HAtRxOfYTPcL6fqB6aZuZNBAFudwJK3liTu044BE/xoDElHALAyKfUvkUehC6BnJYkTzYpUtT+XAONtP72V+45ZM2AjGXkYPAes84Qk1D8so4h84T8ko2PETnkQUMkrRve+krxW9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xTCBE3/OpFLa6Xm+uzbANgUnX34U6iwhgROaSMmMnE=;
 b=Ia2EJy/dDcAv6J+AhOf0dpftjSPHrQXHpsKUhRkFLfDVd3ARhQHHKtMReVKM+o1Z2iHz9ZucD7bAvypVtE5UDA4Cdeq8a41zdOS0DM2YrBid1icsbC3dyML2BBLTZ4HrWwndeMLXD+GDKYhS3HJ5pxITtGJU/WWVTs0DQB8rJvJwBdGMBzp2oG7H1V3/z0c9X+XvRfq63Abj4YRR+c3GQWnKHMFmboo+ND+w89JaBenL4wWENbHpsTc5Gm9RpqOCA75NJwZKWncxdJJMEghPzsqi6tAxTFO4yzInntVRUmy4/cdEc97PHdqlMTGtWODI8qbvtmogxNatexfhTiqW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xTCBE3/OpFLa6Xm+uzbANgUnX34U6iwhgROaSMmMnE=;
 b=WZ75uz8OMpSXNz93X+mDsGPvarJxostaaQI/bbBZHlACX3d5ff0FArfTbQNhuXfvFlbOqg7wWr994aivVkngrJEmLxlEvRFIXrmrRHAzznUXxgR5voZhVfLbry16qXh74tBMHPL9jZUzaacu0Gm17Z9AOjmCJeQNIIT7AZg3QI8=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by IA0PR10MB6770.namprd10.prod.outlook.com (2603:10b6:208:43d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Sun, 20 Aug
 2023 21:56:37 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::1aac:affc:e2a8:4fd2]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::1aac:affc:e2a8:4fd2%4]) with mapi id 15.20.6699.020; Sun, 20 Aug 2023
 21:56:35 +0000
Message-ID: <2dac3bf6-dc57-4e60-ba82-f3eab73e1d5c@oracle.com>
Date: Sun, 20 Aug 2023 16:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, vgoyal@redhat.com,
        dyoung@redhat.com, lf32.dev@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230814214446.6659-1-eric.devolder@oracle.com>
 <20230814153338.79164562f1d2810a18f495dd@linux-foundation.org>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230814153338.79164562f1d2810a18f495dd@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::25) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_|IA0PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 12031ee9-09d3-49ac-ecd7-08dba1c85291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDekJs3UyFwvxqLdQXAOu6CECPaNj7qxiVN//DD5ePmVEz7rxilzvl6dtzymw/YE2XQkySO8DqHpV2L/1+8xtRRa1RIRdnCPdnNhQkFgAN3IJcANbzJyYn1oIRGANvlL1OVv2SGkm4um9Os1eYs4VsJq7fEU2DkNJJlvZ/POMZQVFbezli2VcFAFzQcDVh+Br95gYl9JjbIQI8nLWhuzQmgawTd8ZUIwNWY5iGOGmx9J9ZjcFEOzCOckHhWIKrim5Wiab1yOEPgHUhWDS03z91egEoKOuGb9yVs0AFZLYr41Ro1JeFJYP7XdNeT1RVuEfrtLQxUN8XhFraGOxLmMoE+l03vE9XTYUtU9BIJB4Ge5oB+CUHD44vu9fwRpmCCEnoZqL0v0tEVMXeF+H/zxlWDpG9AU/YgA0czpmhrwPxFzm6l/jFmWYv3FKm9olArvccIvndxCRD+r0S+nkZd8VNOhTU7JDy1xmIZEuwHEHugK2hzoxgzXwO047DiUjKTqRtT7HvKqkJ7vcZQtdCjT5Iq1CwbUtdNJtpz0QPnhn8Ty9hAapVsSXtEwAZ/Ur3SX5VSsdyYI2Yoadj/Q6n1x+SsuenvER90mVrkuuDmIZOiItuMQKHliRRMr5GT8LnTXJtvsJKApeoo3kKlJGMuHyj4R1aH591enUFgyCWgweIb6Qi9G8v6uFoUBTtEnKBBy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(186009)(1800799009)(316002)(66946007)(66556008)(66476007)(31686004)(6916009)(966005)(41300700001)(5660300002)(38100700002)(4326008)(8676002)(8936002)(26005)(2906002)(31696002)(4744005)(83380400001)(478600001)(7406005)(86362001)(6506007)(7416002)(6512007)(36756003)(53546011)(6666004)(6486002)(107886003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllSMk92cTY0c0NqNFhiWkRxbVRYekFEakRWQU9YV1I4aVpkUEJSaENwa2xi?=
 =?utf-8?B?b2Zjcy9hamdHSTFnU05aNlVxaURrK1A4MGFPZGt2aWt5TVdCTERiTlU1clZ0?=
 =?utf-8?B?emlLZ3pBOGtvSENYVCtReU5mOTJCTTdpVmNBd0huUnRrVnY4ZEZEUFZwR25V?=
 =?utf-8?B?eVQ0azFDYTBZclVXdS9tSlBvYlRuUXJIUzdnVDZSbExRRDREZ0p6M3NFNjlS?=
 =?utf-8?B?TEdkOXZNemQ4VTV6SW5NOWpLZmZsOTVkSXp5Q05RamVNamVLTTY3VUo0NTM5?=
 =?utf-8?B?U0JMUUREc0o4bnBUckVQWVVzMlczR3hxWXhXTWlJbXovSzM2MTVNMC90dk0z?=
 =?utf-8?B?S2p4WWMweGR0RzY2c3VPc2c0ZkEybEZPdEdvZWhHczZqcUZKTWdyVHF2YVg0?=
 =?utf-8?B?YjNIbDVuT25BRG5qNlhDNlJwb2FsK0g1S21Beks5bVdXNzAxeVVFRnNsclRC?=
 =?utf-8?B?TVFSMGljZ2hwSTI5Vk5GRU4zVmUzbWZ5NHR2T0kweUtmRE9mK0JnTnFDcFB2?=
 =?utf-8?B?VWlGTUZDaFpHOEJWY0FMTm5ja01uSWhKQXNJWnV1TDI5TDZlMDJEMDJ0aVAr?=
 =?utf-8?B?ZGx6a2lQM3BpSStUU25wL2taejNLN2pkbTc1bVkwQUptM010VFZBM1lhSlg1?=
 =?utf-8?B?SnhPMWhFMXhlUkh3QzB2cDNrN05WRXprTXRDdFZ1N1BjVUhOYTJtRjdmVi9s?=
 =?utf-8?B?OXpRL0hMd1c1aGN0VGVHUmtITW92bUlCKzUrQS9NeVI4U1JRZUVaazNPTE56?=
 =?utf-8?B?TkdMUzFnNFN3UHlpU1dqaDhrZHZnMFI4LzRZbmhmR2MrUy9LVGZqRC9DT3N1?=
 =?utf-8?B?VDhUeEtEa3ZuWVlDMnlRR3hmUEZuUVowcSszeVB2NmJnQ2NTdnRzZFQ1dXRT?=
 =?utf-8?B?V3NneS92VTA5bGpPRkQwSi9UdG9pcDVJWno1S3dtbElTcm5ienNDK2NiTjNk?=
 =?utf-8?B?Nk1yT0hzM2ZRRlRDZzJjaVF2aWdEWmlSVUpMZWJKWnNIKzIxUDBSNHU3Rktm?=
 =?utf-8?B?SUZHTWloVmZNR3ZpS1F0R1krUVJSdzJvS3RTOWtaOUFOcnRvRTc2RVdJL2ZT?=
 =?utf-8?B?NnE2bjVSWHZyL0JWcklzTXVBVFkzYnZTdW02VWUrbDdFNlNRYy9VallTYll1?=
 =?utf-8?B?UmIveUYrcXl0NkhZamlxdmhlTmJBZm4wb2Z6SG11T3g2TENoMCtYeEkwalJV?=
 =?utf-8?B?RFVxNnA1S0gzWDk0T21MSmVoWUZ0VjBCdlBZZE5uVXVqem9zV3NacEptNTdI?=
 =?utf-8?B?cGFMQ3U1dW4xdlh3L2N2YU0xVk93dDh0bDVlLy9NdDF3MlB0MW1XVVdrODVo?=
 =?utf-8?B?MnROYlFQSDRCSFM3NHpzdnFhaXRDcURhWkZBNjlwZ0NCZlIvOFRKeGMvcXBY?=
 =?utf-8?B?SS9HVDFzSmxlelhmcWJLbHVwWVhTY1cvdXZmVWRJZUZwSG4rT2d3R3hVRk1i?=
 =?utf-8?B?NUNBVVRLZENQNG9WOXl3OE1KT0xoSU56RUNMN0lsNnJCNXJBblhLZlJGUCsw?=
 =?utf-8?B?d1k3SERLTE1BZG9KeWtCOURtR2ZDN09ueWRrdnN6ci82UUI5clQwTkdiRUpj?=
 =?utf-8?B?SCtvUDEvZ2ViaUloVzlRdDFVNmFkRTg3QUwrMHVPcXpHRXBCaGU0dTduakRt?=
 =?utf-8?B?TnYyZGlhazYvUzZTZ3VjUnZBUjltM2lQU2huRU1aUHBEa2VwZlZkMEUrZUV3?=
 =?utf-8?B?NW5EemxuNnZWMW5GM3FrRFU5Q2x2TG1kR2NBakZ5akUrTkZTNituanFYOUlU?=
 =?utf-8?B?RzRubTBPT0JPNnVRRlhYY1JiMnJZcHhSbDdxVitqalJRK29QdnFCaUhGQnh5?=
 =?utf-8?B?TVg5UEUyY0Ixb3pITndKNjZiSlY5SjRNZ3RRdEMvVnd3RkFpYTVubkJQYVZn?=
 =?utf-8?B?Q2RraFVidXVEMWQ5ZlowaW4vT0lWdlBpcnVMMFZTTFBoa1cwK1c3MGMrekYz?=
 =?utf-8?B?US9vV3piTy9qNWxoSElBRzVKWklwRmQ3MTZneWszRC9uMlh5ekc2aHBSTkVB?=
 =?utf-8?B?emEvbDF0K0NvaERQZktIL1pSSGQzeXZWM1lQa3NLTlJlb3NJRVhxczhSQlRu?=
 =?utf-8?B?eEQwY1N6RzRIZ0ZLUldRU2kxb015NkhmanBOSXdlM0hCaDdwYkJVK1ZOeFdn?=
 =?utf-8?B?cjluckdzclIvSndIMnkvQXlmT1prc0kvTXpERTNyYVVjak9QcWJ2bzlpWkJo?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3NKK2tQbDREVDNVUlBGN3Zwa1dTM21Rb2xiNzhFbnZxbm1SWW14cVU2SHlC?=
 =?utf-8?B?dllEdXV2UURsWWJEYndORnoxQ2VTZ05ZVW11aG0zaG1PRjdJMkoraU5ZRzBI?=
 =?utf-8?B?ckFXY1RvYzhMR0twd2VBek1BMStjQmUxeHBtR3NNQjdVcUI2RHlKZzhPM284?=
 =?utf-8?B?aDhkcHU5Tm1nRG1JL0Y5bkNkbEdIb3hnTUVJRWZFdXc2Wm5hVU1ldGFic3Ux?=
 =?utf-8?B?YTF3Nng2Sk43QWRvN0F6ZEZBU2tBZ0FFRXF5dHNIRkgxVjJHd0JCQ0JWQmZ0?=
 =?utf-8?B?TSt0b0ZrUVo4VGhQaW1RUWdsb1pMUkNQQmlDdGFycVExVHhEa3BDRDVlcjZU?=
 =?utf-8?B?cWxsdzZnNHMrdjhFdEMyQ1ZZeCtSZ2Qvc3JBRURLNTU0TlQyOUMydHNLVm8y?=
 =?utf-8?B?NkdGQUZOdU15WitYVjRXWHRCV0FOZHAwSTRwc2t4TDM2TnJqSnRuWU5paXNJ?=
 =?utf-8?B?TURvVDdSa25kNE5RcFplazZDbFRwdUwveWdlMEw0TGN6Sjl5RnBHME1GRER4?=
 =?utf-8?B?MHBJZFpqOE83RG5YQk5oN1lRNUVUeGdpNk1nNFVaTng5bUR0STY2bDBnak9h?=
 =?utf-8?B?aFdxKzY1NUVBbVg2cEh1TFNudC9QdTJ5ckJzdTdmMmg5eE4zWE5FZWFwd3Rq?=
 =?utf-8?B?bzR3bE9vZldUalVibytmNC9GdThaZTRJQUdkRGdxbzJoYlJ4ZXlPSmZFYUtV?=
 =?utf-8?B?MWMrcGdReDZzRDZXM3h5RHNuY3dLeDZUd2p0bmMvVDQ4QjN6cFVGT3J6U2Q3?=
 =?utf-8?B?OE9MZW5xUzZEaXdxMTQ1N08yS2JBaGlLVlRYeWVtUm4rY3hEYVk0bjhnZHV1?=
 =?utf-8?B?RVlrUmdzSFlxelVDN0tyNGdUVkxBVFRhTGF3QzE3LzhxeGFxemFzSmcvTEM2?=
 =?utf-8?B?enhDMUpaUm51ZWFHU2c2KzNmRUYrRnVRdldHTkd5UG00alppTVZwVXJUbzhF?=
 =?utf-8?B?dkhpWm1leGs3YlROTmhLL04zWWgrTzJCTEhELzRRYlJpSDdma21qWXkxSUpK?=
 =?utf-8?B?NXpCYmlnUTFhZTQ3VlRlV0ROZzN6UWRTdXRYenB1ZzFBejBnUitybnVkeWJ3?=
 =?utf-8?B?c2pTakxGc1MvUTJ2bmhYZ1lJV0w2WklXZVZVVVU1cktmcUdKeU9YL2VGYTB2?=
 =?utf-8?B?aUVFSkQ4S2JmL1RRWXZqYm1YNUJiTll1c2F5SlRXYmxvOEJDZGRvZWc1QjhV?=
 =?utf-8?B?ZlJuZ3dhajhvekpRN2pITm1tVy9FZVcrT2d1QlpSR1VzNlJUM3l4c2xJK1N5?=
 =?utf-8?B?Zk5LNFN3cm1XRW1xcG8rNTNja3Q0VmFhaFZTMnFvRVllWU54aXdqUktIdmxy?=
 =?utf-8?B?NjUvbU94clZKWStXU1B0SnlqR1lSYlFKZ2F3eFFlRDlabWFEbDZVMWdlU2hv?=
 =?utf-8?B?ajVNczJlSkpaVUp3RzU4Z1V0NVZQeGk0ZEw3MU5CVEEvalp5RlkvTEoyWXox?=
 =?utf-8?B?QUxiYVJJbUZEUThhcjl2RWluVW1LbEE4N2NYbjdLS2ZxZHI0ZVg1K09YdG1D?=
 =?utf-8?B?RE1KZmRhQmVHUjA3V0xPRHlMR2t5WHNweSt3bDRLZlFiN25naVZBVnQ1NFpY?=
 =?utf-8?B?a3ZLRkExK3c0OWhoaFRsV1ZUZ2FjMjNyZlNGTHJUVThrdXVpakRlZGkybFdm?=
 =?utf-8?B?U2RPc3c4UVAwQUF1QS9CQlZ1bk1MN3BmbGxTZzN5bXJyelBKSDR3d085dlM5?=
 =?utf-8?B?c20xaTZxaWtjbCtsSE9EYVZIWWprZFRUaGtrbFFrRnMrK010VFdadGFHVnhZ?=
 =?utf-8?B?RlVBKzhtNXFJeXNpUU51S3BEV3VWdmhJUkx5MlRwazBPR2VpdFFERmxrUFdl?=
 =?utf-8?B?N05ZRGJGb2pKc0ptMlI1YlArNTJtNUxnckd5LzZUcXpBNjExZ01QZTRCeE9X?=
 =?utf-8?B?Q0d3UDFYU1RFSEtTTGJZbHIvcXpCWVFva2RuUzBORmVqSmlWLzFwNFd0a2tL?=
 =?utf-8?Q?Id1IjUhhQbQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12031ee9-09d3-49ac-ecd7-08dba1c85291
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 21:56:35.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJRWdlgfgsTqy7c0GvmVrbn9FwY5QDQU9Z+R8g1oS2wtU9s8uQk3Wx2Q02ZY2XoTnYiP2983MqP8du9EYI5JWsuz3Y3q5aQ0FKSeFkYTElk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308200213
X-Proofpoint-ORIG-GUID: DXJ7mR_Nj7M5EylDx6rCBnjrSMbYi8Ti
X-Proofpoint-GUID: DXJ7mR_Nj7M5EylDx6rCBnjrSMbYi8Ti
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_145739_641064_9974C682 
X-CRM114-Status: GOOD (  17.62  )
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


On 8/14/23 17:33, Andrew Morton wrote:
> On Mon, 14 Aug 2023 17:44:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:
> 
>> This series is dependent upon "refactor Kconfig to consolidate
>> KEXEC and CRASH options".
>>   https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/
>>
>> Once the kdump service is loaded, if changes to CPUs or memory occur,
>> either by hot un/plug or off/onlining, the crash elfcorehdr must also
>> be updated.
> 
> Thanks, I updated branch mm-nonmm-unstable to this version.

Andrew,
So far only one issue has popped up. I've posted the following patch to akpm to solve
that issue. Please apply this patch on-top/with this v28 series.

  [PATCH] x86/crash: correct unused function build error

The thread on this issue is here:
https://lore.kernel.org/lkml/08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop/

If you'd rather I post a v29, I'll happily do so.
Thank you!
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
