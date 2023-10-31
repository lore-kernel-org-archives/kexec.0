Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6339C4332F
	for <kexec@archiver.kernel.org>; Tue, 31 Oct 2023 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNXLL+U9MoQWn8ZYqLTwXPClqpMKvj/T5MFOhNe0V2M=; b=NUnPp6SDlnbPqFIcOTouCNzpOO
	OO9fL/2JQr3v3EmjF4sJEXgac4JXmKv2WK+Nu1/XFfeDQxTYf6w1N+W4zwdjGLdv1ctoWpCj5atxl
	oFHuDHuGYik35NQLTCulu6Pd5hfopnClO6DAxt9hN4wTUa2OKO5e4tdDpQhycuuIQg3+7BZY/RYCn
	RSTcznG757BKWG9OSUQ821ujmv9e70Fyecnu/YG2AbPCJeyib3TOW/yoV7iDJzaLmC+feKZfUWFlH
	aVDDEAG9qdZxrMjz4DfnCoahq/tkqSHbG5iygbRbTXBvKqknu3rzasFPgITTbgAVEQDlcDejug/vC
	FBAyOE0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxwRR-006B8M-0e;
	Tue, 31 Oct 2023 21:38:29 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxwRN-006B7W-1p
	for kexec@lists.infradead.org;
	Tue, 31 Oct 2023 21:38:27 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWO6h001602;
	Tue, 31 Oct 2023 21:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cq8F23OzgQ/QL3J1RA09+xWEmFwFiuuG6IpSIrA3cj0=;
 b=VfT9vYPVWGDAIZ4CzNZ1gp6G+JLTskCIeME0VpAkvzfza75kyjJTuqxFjqPQ2wdrbL45
 hJkw/qOc7No4Y66pmwN8+UsDLZ5iakzjbdUhWZlOPxdKG+DdpW93J652L0BDMWUw2hra
 UlVKN7EOj0Iyee8he1M53oZVmUDZndvgD0sAUUw60d1qFGJFUvt42N1M4gzaJH4Ne1HZ
 Q9mAXA8phliFc4uy2CPAdgtD2PzNcIY3yldv8XzvcHaNpXscGaf1Lh+DJqPaNTqj0t0j
 oLHM26FSjHGH8qfMFH3FcQ4vURb2Hwp849fdAS2aQsNY1H3o+EV0ZyRf+5th6lSoutBx pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtp93j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Oct 2023 21:37:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJeF65020069;
	Tue, 31 Oct 2023 21:37:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr6bf1m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Oct 2023 21:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb2ZAjnAbkxLBDL5il157uugeiHAf/+O/w0VS7+EjlFQ43JZc+q13t5Ww9sYzdBlraPmZI4+fuDFCG8vklWN1gMwP0QGfnFNJeOl7CutUyBfi8Otz7lGISdkylt/0AjUhPhWn8qXQmM0MNu4KIaQR6OrpHwvG27cuOBz9n9EfAbpgJQhYZzGZS6hs0Iv2O85H8bSiKdX4rcVKOnggzivsL7WjQvZWSHxKws15yymElIBKbqZ0vuDSC+uTTcJBYoGlaiwUQDRfsZC4gEqWP1GordZmns0UEr7StZXKlIiFP+DEHmGKz/AcMlD+XrxHFz7obyyoelnBhdS+KOcmuvEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq8F23OzgQ/QL3J1RA09+xWEmFwFiuuG6IpSIrA3cj0=;
 b=FHsUMKi8XJGjxzVBf9FB00wdsM9xsbntCcDrgccZD2EGfGg5sRWRYHR87h9umyFdwzio/xouFh1VzELyQai0BUgBYYaqlqL/eYoC6N3gfYXtLk5vblff7S/iyrlpU0AQWaz6jJjG2N3CjcDxImbXkuAA2o0sNxx06sjPqal1/zAsmxOY2IGX6FapXCPbIEJxzW4BAoEP9WiVdOhU+SgliQ4w6dXSg3uhpt1hcUbcZIUifK7/jExsEr3c8r9Dtix7o30pSjieV3UkfXHnt8m6zw0vLc2mPlybHpUlvnkw3GmbvWnjtQmHvzJeog1/lelZhimQYJK+TKvJtGuDUVhE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq8F23OzgQ/QL3J1RA09+xWEmFwFiuuG6IpSIrA3cj0=;
 b=WcKvecn8NEuV3tXBi4RBZG97YVyuMMtUFfy8ReTsQNzeN3jjTo3nScAakxiJTiOl0TYban9Nb9GxmuSkmDSS4BeMkkTpLi3KpspACvN5zTXX5lo55rxoFhc68y1GXJ50kfgSiELiOcdi7+kostBcbVvuNroNNgVyHLG6LMChMcM=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 31 Oct
 2023 21:37:54 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f%3]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 21:37:54 +0000
Message-ID: <b32913fd-3b86-cebf-8240-4e0bc05f883d@oracle.com>
Date: Tue, 31 Oct 2023 17:37:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
Content-Language: en-US
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
 <20230512110003.GC14461@srcf.ucam.org>
 <2f7689e0-b79a-c642-815f-a487c1b9e700@oracle.com>
From: ross.philipson@oracle.com
In-Reply-To: <2f7689e0-b79a-c642-815f-a487c1b9e700@oracle.com>
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|IA0PR10MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 69152d7c-2c60-4cc8-0e1b-08dbda59a3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMJwvEGtuHGZoNb+FMFtYNSdPXgj8EkRMJ0kHQVHozPdHBIDWKWbh+uA0PrBPbSFMC1ysg8IYZH+RaDsbevFpNs4Hgp+lUYmEv8njGwq+lnBvaSgpHgt60BqSXO9HoxygGD9EoF31JgcRenDI8/LrHuFJ/hsXuGvJ7G/CNtICI/Z1iQ0FVMAZOjm9h4owcNceqojlBRQ+e0jwnNZJP7iDl6UwhcESeO5KMr3u7JNFthivRLibvRl1077yD5xjA8PyecxuC9FZFiInVJR29iiXsnGRprjNLOkuMu9Hh7oHfykrnvy9b4rp9EwwFlUD+P5SH2B2rUDpdc0dRdDRS4ubY5OXR/yS7QgXrNeOGcJVlgyeYYBRZZ+OHdNPQwbdmWJyBu0FD1LXpruD5O8/B9Hnq0GOL4tayHLJ2o9QVSgc+Khh6oY6lLOtdgjnM76MMKUB0V7OTYX9QG06yhLy66GTyd7I4kyAYXbutyv01eBeAkdCJpSplyjVlCOV+QLH8RN9zrsJKAtHHrg/NssSlqLALsls5Hg4fn/xC+nEZAJSPqveecWPEJXo1pnF0vB71aSymEKHDxziRvgCbHqipOfCj4SpBMvq64ZZmSUHo8sWyWN+rlwWUB5oT0sEMAR0gXM+zUp3FQI3doR31NBbahkzMql6qxr3+z5Tps9EOgXxRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(6506007)(6512007)(86362001)(9686003)(6666004)(83380400001)(41300700001)(8676002)(6486002)(8936002)(4326008)(6916009)(316002)(5660300002)(7416002)(26005)(66946007)(478600001)(31696002)(2616005)(38100700002)(36756003)(66556008)(31686004)(66476007)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9VemRXano2b01sZHlEYllHUDZkeU1COTZxaHNsY2hKZGdaSGZhSlJPUjB1?=
 =?utf-8?B?ZndiVU5NK1NXSzhwa1FpYlFVSkJ3UmVlcEQ2MDVhVlc2eWNWZFBvWkdWR0RF?=
 =?utf-8?B?RWUzZmZ0cTZ0dFZZQVBPTUpmRGZXOUhaZG16M2VBTzZzdE1OZmhTZmY4VE5J?=
 =?utf-8?B?NURreUMrREdWWUp4UmRtUFAySWE1c3dDRndhMEQ4eVdPa251cGJ3V2NyQkRh?=
 =?utf-8?B?eEZpNUZHS25tV1FZMjg0QmZtR2hLcU5CdHlabUpsOGQvbk1kNFhJaEcrd01r?=
 =?utf-8?B?aFNxbi9GYzJSN0owbFZzK29Xa1dUQ0VsTS9GenJ1V1dtZm44YktxaTJUNnlj?=
 =?utf-8?B?MmtUOWh4KzgzVTNBUVRPNmlDbUxWcERqSW9VdGJNTU5sdmxqeEZFQ0hmb2Vl?=
 =?utf-8?B?WG04YlpmclBnemkvc1RvNlNQOFhVb09nODZJVmU1ODlYUWxScjNMODdFNEVu?=
 =?utf-8?B?aVZzNXZDZEtpWVd6NTdVWXNYYm9RalJTeUdSemdSa0QxNHpUV0puUitZK2Vs?=
 =?utf-8?B?U2N5NTlNbDJubTFwRnltWUdSOXEzZW9Xbk1QMGNpZzhpYzFBbmE5TlEwUXRw?=
 =?utf-8?B?U2puTUVIUTJpUCtyVmNPRmJPTEt3RG0wY2pjZjJKUWdWWTZtaHJhKzhlV1cy?=
 =?utf-8?B?Ui85eFE2QkVNUWJBR3kvZVB6M2t0RjVDblU1WTBQNmJONVFSYnZITEdLM3o1?=
 =?utf-8?B?dlpndFdIWDFkMDlrTkEyUnJvVFMyL2RkYVcwRXQwdkxjZC9aOTR4R3ovWWcz?=
 =?utf-8?B?ZGtPMkdGbXRJZXhGbEppQUxUZEhCRVZNRDdha21BUldtaGxMOUdoUzJzbGhH?=
 =?utf-8?B?d1YvVGhZYyt3YnFWV3BSckdpaEcrT1pEVjVLYW9xeGRPQnhoV2N6TzJyei9X?=
 =?utf-8?B?S00xcExsVUdFcjNVaEpKQUZWRkdGekNiMlB1MG5Ha0dBZjU3OERQUEhvSGpS?=
 =?utf-8?B?Tld4K3V3WTlZQ1VLWTdQb3B2SVBROGl3QkYyaW43dkUvaTBVTVd2czRjc1Nn?=
 =?utf-8?B?ZExGU2g3NXhqTXFFT0lEK0cxSEtLaU5FaXhpbUtGOVZSYVNtSUhZYVRmOExi?=
 =?utf-8?B?cS9YVHoreDVhb1JzSmo3MnNaNUpEbkhTVzVhdTJnK0Npa3ZpeVZLNlFJemJi?=
 =?utf-8?B?QkNhdi9YdHNGaXlMa3lxcGhURFdvWlZtQ3lqcmNLazlQaEVVVFJZeDgzRXM0?=
 =?utf-8?B?c3A2eVQxaWN5Q1pBRlZUVlFkZmcxdTRzTmRiUldYVUFubytwU1R1SHFvSUpU?=
 =?utf-8?B?dnlaaXh3b1htWEZqVFY0NXlwVFJwSTJvVVV0V3U1d0gzelE1aWVwS05PcVhr?=
 =?utf-8?B?LzZMUVF6RjNyRFZ0bzRjMXYrVjM2amttYWZheWcwZmczVmJpNXpBMDFTZXln?=
 =?utf-8?B?STl3eS9FL2pyWmo4VU0xRWVIRFZFOVZ6UmlSSXFZWnM3cm9oWFFVaEtveU83?=
 =?utf-8?B?K1RMWHkwM05OY2RiaDRNVTZiMFhEZU9QdVRwRmRncWdKeldKRGZwYUJ3S0Y1?=
 =?utf-8?B?NGNMM0ttY3pSVXF0a1VqcHIwYUJHYml2R2l3cEk3RzZZZU1tRG8xUnE3S1dy?=
 =?utf-8?B?OEo5TlNLV2xZdlY3OHIvL3U1VGU0aFo2TXZqYWU3N0lVV2xPTGduaFZKekZ4?=
 =?utf-8?B?eDNWd21NS1ZvWnlEbitpRG96ZGNmckJtYUs1TFNJV0hrMDM1QjYzdFI5L1ZS?=
 =?utf-8?B?cTcxS2xtczE4d3NnajNFbEZFY0lmV29vbXFPd1p0MDl6R0hhWURLbXg1ck9H?=
 =?utf-8?B?WkxuWHIrVU10S2FJTDhMSm4vVDJCYmZTMk9leXhzc0tGVVlxelFJdHRPUTNx?=
 =?utf-8?B?WlltZlVoSEJhMlNwcDh6WTBKSVNxVWQ4UzRsNVFZcHlKb1FydVZRV0hkNnhH?=
 =?utf-8?B?dUdwK01kTWM4Mlk4QnlITTR3TldWZWtMVmFMbEdhMkdnL2Nkc3lXdDRhRlJO?=
 =?utf-8?B?QUxnZ0VmeGt4RVNBd1dXN2tLTnZSRHRORXNWR0xpRE5BSnlnUlJGUkJrQ1Rj?=
 =?utf-8?B?NzlMa2lFVFFWQkFpdEpUc09kQ2JVQnNiS0R2WmE4YVluZkFrUlBTblpPMVVn?=
 =?utf-8?B?T05PWi9WVGszREZ3eG5HZHR3Q0p4OFpTN0JaQm5JV2w2Qk9UbDdoVEEyOWdI?=
 =?utf-8?B?UnExSmIyKzlqR3ZNS0hkK0Z3eXdwWWtqRDluVWJRaUNIZ2tURis2SkVjOUdt?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UlBlOHRXZFFJdFpTeW9LVWVwY0FxZVZ5RkhNS2pNUTYxMUZlVUhBVG5WWnFx?=
 =?utf-8?B?bWwzTGVRbTlnRStvVG5sUUVoYUg4dEk3UkRzN3luYWs4ME5NNnZFRjg1TzBT?=
 =?utf-8?B?a3JyUll0YVN0SEZtdjNmSThCUHNrQlFyd294eit3U1oyd1lpOTMrQ2NoRWhF?=
 =?utf-8?B?eFJHQU05ZjhqSUsvY2NTMnRHMWJoUzdSZ1pCcmJsQlhEalc3VUlmRWtvUU80?=
 =?utf-8?B?MUkydHpjMkM4VWJIT2doWG56K3l0YUdXNzVKaUhQOWFSajNFcktrR29vWU5B?=
 =?utf-8?B?VlhMUVZJNzdBYnhrQVMrSzVGZVZMNjk5cVhQSE1xaHFyMzlTaTJhQUlCVnAr?=
 =?utf-8?B?YS93SDlzdlZEanJOd1E2RFFiZmRZdFEwNXNEbVkzY2cvRFkzb3p1bldxRTc2?=
 =?utf-8?B?MnFvMHRkVGloNlZSU3ZmWmNrRWovdWNuRzhIbFoyVjVnY2tTNmVEWTRuM1RW?=
 =?utf-8?B?YVVRZE5TeWkvK2VhbWNHUXA1WHJmV0JEcG8zVkx2aXlabDlBV1VidXhIUkZk?=
 =?utf-8?B?NUJGcE1vLzVNWEZOOURhNmxmaERGdkhySytGRnplcXcxbmY4NmNqeS81NjYr?=
 =?utf-8?B?aVNVYU1zdHZOWmlrMDlKeFNrY2hVZS91YWFmSjJ4Y2VoWmU4eGl4YmRjK0wz?=
 =?utf-8?B?Z1hBMGNtc1dKb1VBQWlXWTFpV1l3cG53eWd4czd4VFhUMWRMRk1JSUZYd1hk?=
 =?utf-8?B?ZjVNKzhlNmRud243L0JQbDRGWWd2RllwMWhXdm1wVEtRNy9JOXU5K2p6bnRp?=
 =?utf-8?B?MmE4Sm1tNTE3eXY0cTFNUmlvdmtoZTFTZE5GejhIVlNWdDZ5YVplenk1cGlK?=
 =?utf-8?B?dS9zQ0xxSmdpWjBZSTdGdW15Yk12Qzkremx5TkErVVUrN0xuRWRwWlFielhN?=
 =?utf-8?B?Y0dFMit2RCs5Nm5xNUc5Ulo4NzZseklVRCtIek9Nbmk4eHhld0F4clZEL2R4?=
 =?utf-8?B?bFdJOFRjKzdzeDFOUWRlNklUME9zalJLcHhoMFUzamNpUUcwMXRQeGw3NWtS?=
 =?utf-8?B?WEVwalJlTHowZGs3Vk5VT1pHbzZKanpCRWUvTlZNeWQ3VFBiYXNzclBvRkNN?=
 =?utf-8?B?Lzc3cGQvSmo3RzFhTXN3TDl3SVlxUVZDb0J1M0c3SGlxYjVNYmliUjM5Y2pC?=
 =?utf-8?B?ajF3QWJBR3RHT1hFenlYcW5zTVpNZ0ZZUFVIYkgzUklSMkVQVXVjU1VYb2Jp?=
 =?utf-8?B?Z1lWOElDZDF0U0tpb25weDF2RW1jdjU0UVFkbGsvVE5EVkVieGl6eXYyOFlG?=
 =?utf-8?B?M240QWtEb2FEaWpQQnJ2SjVNM2xBVlpqUzFWOEt5ZUQ1bVJERHFmdkMxeTVz?=
 =?utf-8?B?U3BWcW5KSC9SV3R3RXpwQVFOZGt4WUpEVnJRNTBzQ29Ca0VFdFRZckJ1ZUNG?=
 =?utf-8?B?bVVUSUR1eU9aZStFb1VmbDlJNFVpUVZYMzZLUmY0RjdGYmhGQzZVRElxakJh?=
 =?utf-8?B?bmQ1c0R1MzBCTW95SFJ6TDQxdkhNZVZML1E0N1hLcHZxM1VFSnkyaFRaQVZL?=
 =?utf-8?B?OFRxRUM5Q25DUTJybEtQanZ3YWUyaEhtYUlWVzFWb1FCMldVOXRpb3ZZZzhL?=
 =?utf-8?B?Zk5vVHZFU3BHcVg1b0RzQTlPUmdBUG5EeXduVjBUZnBQQzJmRndkV2k1aVQw?=
 =?utf-8?B?NEV5bStnTUxGZzR5RUxuVTR3b1RUT3RZaDMwZFkrMERWdldWYVNlRWgzemdM?=
 =?utf-8?B?bElhNExKdGl6TFQ1TlAwVVNaL2xBZWs5VWk4SkZpeUYzWjhPOWxsNnRMdnl5?=
 =?utf-8?Q?HIOStTIjs+ak3aISjQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69152d7c-2c60-4cc8-0e1b-08dbda59a3b2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 21:37:53.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDmyqRjuxBgvSw12gUvhc8z7tmsQkA1nLtpi0iaL77SITcEVZOnvSLDyEUx2ghLmd5S15F437naD/4l6g5f1hzTMpnDWSLPJHv0IfxRSe98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_08,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310177
X-Proofpoint-ORIG-GUID: 7YlG4XtHoV1Gmv4bQffotyyOaCj86ZGv
X-Proofpoint-GUID: 7YlG4XtHoV1Gmv4bQffotyyOaCj86ZGv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_143825_743830_99453425 
X-CRM114-Status: GOOD (  17.80  )
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

T24gNS8xMi8yMyA5OjEwIEFNLCBSb3NzIFBoaWxpcHNvbiB3cm90ZToKPiBPbiA1LzEyLzIzIDA3
OjAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6Cj4+IE9uIFRodSwgTWF5IDA0LCAyMDIzIGF0IDAy
OjUwOjE0UE0gKzAwMDAsIFJvc3MgUGhpbGlwc29uIHdyb3RlOgo+Pgo+Pj4gK3N0YXRpYyBpbmxp
bmUgaW50IHRwbTEyX2xvZ19ldmVudCh2b2lkICpldnRsb2dfYmFzZSwgdTMyIGV2dGxvZ19zaXpl
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGV2ZW50X3NpemUs
IHZvaWQgKmV2ZW50KQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IHRwbTEyX2V2ZW50X2xvZ19o
ZWFkZXIgKmV2dGxvZyA9Cj4+PiArwqDCoMKgwqDCoMKgwqAgKHN0cnVjdCB0cG0xMl9ldmVudF9s
b2dfaGVhZGVyICopZXZ0bG9nX2Jhc2U7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChtZW1jbXAoZXZ0
bG9nLT5zaWduYXR1cmUsIFRQTTEyX0VWVExPR19TSUdOQVRVUkUsCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2l6ZW9mKFRQTTEyX0VWVExPR19TSUdOQVRVUkUpKSkKPj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKGV2dGxvZy0+Y29udGFp
bmVyX3NpemUgPiBldnRsb2dfc2l6ZSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZB
TDsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKGV2dGxvZy0+bmV4dF9ldmVudF9vZmZzZXQgKyBldmVu
dF9zaXplID4gCj4+PiBldnRsb2ctPmNvbnRhaW5lcl9zaXplKQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiAtRTJCSUc7Cj4+PiArCj4+PiArwqDCoMKgIG1lbWNweShldnRsb2dfYmFzZSArIGV2
dGxvZy0+bmV4dF9ldmVudF9vZmZzZXQsIGV2ZW50LCBldmVudF9zaXplKTsKPj4+ICvCoMKgwqAg
ZXZ0bG9nLT5uZXh0X2V2ZW50X29mZnNldCArPSBldmVudF9zaXplOwo+Pj4gKwo+Pj4gK8KgwqDC
oCByZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIGlubGluZSBpbnQgdHBtMjBfbG9n
X2V2ZW50KHN0cnVjdCAKPj4+IHR4dF9oZWFwX2V2ZW50X2xvZ19wb2ludGVyMl8xX2VsZW1lbnQg
KmVsZW0sCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpldnRs
b2dfYmFzZSwgdTMyIGV2dGxvZ19zaXplLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdTMyIGV2ZW50X3NpemUsIHZvaWQgKmV2ZW50KQo+Pj4gK3sKPj4+ICvCoMKgwqAg
c3RydWN0IHRjZ19wY3JfZXZlbnQgKmhlYWRlciA9Cj4+PiArwqDCoMKgwqDCoMKgwqAgKHN0cnVj
dCB0Y2dfcGNyX2V2ZW50ICopZXZ0bG9nX2Jhc2U7Cj4+PiArCj4+PiArwqDCoMKgIC8qIEhhcyB0
byBiZSBhdCBsZWFzdCBiaWcgZW5vdWdoIGZvciB0aGUgc2lnbmF0dXJlICovCj4+PiArwqDCoMKg
IGlmIChoZWFkZXItPmV2ZW50X3NpemUgPCBzaXplb2YoVENHX1NQRUNJRF9TSUcpKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAobWVtY21w
KCh1OCAqKWhlYWRlciArIHNpemVvZihzdHJ1Y3QgdGNnX3Bjcl9ldmVudCksCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqAgVENHX1NQRUNJRF9TSUcsIHNpemVvZihUQ0dfU1BFQ0lEX1NJRykpKQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAo
ZWxlbS0+YWxsb2NhdGVkX2V2ZW50X2NvbnRhaW5lcl9zaXplID4gZXZ0bG9nX3NpemUpCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChlbGVt
LT5uZXh0X3JlY29yZF9vZmZzZXQgKyBldmVudF9zaXplID4KPj4+ICvCoMKgwqDCoMKgwqDCoCBl
bGVtLT5hbGxvY2F0ZWRfZXZlbnRfY29udGFpbmVyX3NpemUpCj4+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FMkJJRzsKPj4+ICsKPj4+ICvCoMKgwqAgbWVtY3B5KGV2dGxvZ19iYXNlICsgZWxl
bS0+bmV4dF9yZWNvcmRfb2Zmc2V0LCBldmVudCwgZXZlbnRfc2l6ZSk7Cj4+PiArwqDCoMKgIGVs
ZW0tPm5leHRfcmVjb3JkX29mZnNldCArPSBldmVudF9zaXplOwo+Pj4gKwo+Pj4gK8KgwqDCoCBy
ZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+Cj4+IFRoZXNlIHNlZW0gbGlrZSB0aGV5J2QgcG90ZW50
aWFsbHkgYmUgdXNlZnVsIG91dHNpZGUgdGhlIGNvbnRleHQgb2YgU0wsCj4+IG1heWJlIHB1dCB0
aGVtIGluIGEgbW9yZSBnZW5lcmljIGxvY2F0aW9uPyBWZXJ5IG11Y2ggYSBuaWNlIHRvIGhhdmUs
IG5vdAo+PiBhIGJsb2NrZXIgZnJvbSBteSBzaWRlLgo+IAo+IFllYSB3ZSBjYW4gbG9vayBpbnRv
IGZpbmRpbmcgYSBuaWNlIGhvbWUgc29tZXdoZXJlIGluIHRoZSBUUE0gZXZlbnQgbG9nIAo+IGNv
ZGUgZm9yIHRoZXNlLgoKQWZ0ZXIgbG9va2luZyBhdCBpdCwgaXQgc2VlbXMgd2Ugd291bGQgaGF2
ZSB0byBkcmFnIGEgd2hvbGUgYnVuY2ggb2YgVFhUIApyZWxhdGVkIHN0cnVjdHVyZXMgaW50byB0
aGUgVFBNIGV2ZW50IGxvZyBjb2RlLiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgCnJlYWxseSB3b3J0
aCBpdCBmb3Igd2hhdCB0aGVzZSBmdW5jdGlvbnMgZG8uCgpUaGFua3MKUm9zcwoKPiAKPj4KPj4+
ICsvKgo+Pj4gKyAqIEV4dGVybmFsIGZ1bmN0aW9ucyBhdmFsYWlsYWJsZSBpbiBtYWlubGluZSBr
ZXJuZWwuCj4+Cj4+IE5pdDogImF2YWlsYWJsZSIKPiAKPiBBY2sKPiAKPiBUaGFua3MKPiAKPj4K
PiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
