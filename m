Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A27C636D7
	for <kexec@archiver.kernel.org>; Sat, 11 Feb 2023 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/ONopwxvw4pP8347e8SiWsDYTvkUuY78gebiFOnGPc=; b=KWqdUfrM6VR5mOJuuSaWGVmSfr
	P1C6zNAphY4Ai5y60ZJZCZP/9QU4Hg7G1vJrXk5cYGeyOtSYGqfUBqhCYQ8wYMhruMmj8hlUEXX8m
	lrGPAhmo6CSOpRGVe1fWEYChuZogRpZ8TSAbI5vcadCBCcsdtHdJmW1qVV518bTFBQ4fJHvYFsAvL
	WdeJN63I1UwjO4TwPk+9JE8cxTAfQZycZVffZgHPMj+voxgL3hQygQLfGiwdC+a9j614tMI73/zoN
	03CQIukfdWZm16wr7j6zecAAFWnHdZuO4W+0LBtZIvwD4saoRD6N0ItvYfbo6tPUSayD24hJUW2CS
	K/FyepHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQdri-00890j-Ll; Sat, 11 Feb 2023 00:35:42 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQdre-0088zS-DA
	for kexec@lists.infradead.org; Sat, 11 Feb 2023 00:35:41 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B0Nsod009021;
	Sat, 11 Feb 2023 00:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=RByIFZZUJU8dln50+GZXJRfhQxnWX5jCC9sGx/KyP6P/xrw2Wt2m7OmhQKAsHHvYG66l
 jrxw11ilYZrXYHrB6oAtlaBb2EerczIWmd/RPDJ+WLy21JnIeaceCqpmDSHAdo0zptB0
 1PsCOKItB4Lfe17gertH4EStHzGVQFjuJG0Fn12oeMoZMsbWF6woRTjKCaMhJ/j6WiyA
 qEjzRWfW4cDDnGL2mReMHytjYD234hRHgzPVZmz107FiSFF+uKrHK5wts3IZz8rNPYVb
 s2ud4OHbMVX/SxDPnYAj2iYqQFN/8lW7hAWQwn0NDu7gRxIHaOwFvPklIXwPiiv9ZX91 wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy1enpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Feb 2023 00:35:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AM66Hn002648;
	Sat, 11 Feb 2023 00:35:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdthgvs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Feb 2023 00:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0jZojyNA7Ky6kO+cKRw9359bwI34c5qkwcuMXbFagfd+N5sKZhUKQMihae0vPcHLCUYWxVq5ljuA5rrSzxShLUhOANQG/+Oop6f3hXR6CQCgAnx5j+uPlUi12DxDAv1fgHmSHHqGcbJKCzKkBNl/bR8YVNBZFdNdWtUfD98rBShS6Dg5Z5Pum0RBaZr0jv2cMwG/p7fKVqHKN/2EqKdtDc796Rp6aWFaPSie1e290ZUot0Ce2cut1CB1g/3xDI9RdKntohmR7P/TitJnsHaN8j/cE7oWBNEa4jecl9kQw/bE2qiIfNeHSd3ZFFgT6yZzd1tONj0ErF4YQe6UaKbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=OUwZW89oOxSShN7qASA1bWdPouhMwtCP7FI+l+NEzfC/MUSBi55cxqwKXPqcWhfM3/x7chZgNq1BpomMvr71KjHVPjOhdsrn/ebIDsUhJYC3s82Ox40S/Vgqkq+h3Hc3TbG2aSuJNp4XLyx1ssXN7OGpWbsGJ2v5C9tyQ/IhBuKJcg9AYFeysndeE+Jns4GvsDCXPfEXlHVom1+xjczYjDCq+Hzy5hxo4Dv87icjuIvrL1zXkpVZDASKRlN00LimSj/gOBU0P5bnkEgSXF+bGXGMD5xrQbVXlnee0VME028y9kJdb8hawxbrLZBmSqUCveo+qdwHA+wkIJokooGWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=ky3wytS4sq2IJDuZZsjI9DVCgA12sm6CVrlnuOmSY9GupdWmUTQd1FGJ36Ikq4P+mRStLCaeoY6jCiU/NtTXa2Xzr9fd3YyxwT1Up+rySoDd++FOYAY6uQjWnfkg/Nyj2hjhxWD8i1yoTn1TFN0wbpxF6sQyIXK9pIUONINsu/M=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Sat, 11 Feb
 2023 00:35:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%5]) with mapi id 15.20.6111.007; Sat, 11 Feb 2023
 00:35:16 +0000
Message-ID: <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
Date: Fri, 10 Feb 2023 18:35:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
X-ClientProxiedBy: SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: b1513391-8be2-4649-4f16-08db0bc7d840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	zSIbems9TwVXgSaSXTL/x5PtLPHewXZSSPs53K2Q9HAsN7WS2GVF8igoFOmHPlVFvT/AoTPhjfRwCoF/O+50y9D1AZ+Lhvvej3CrRUvEZ5qVW8GlbD/abdsPFk6Ejzj1d0RG4lx782tq2WYFQJsDJkSkiJYxRqc2E7GwcJZ1cgXjustOSoO/epZF+VBkgoY4lvTr9l1WPdWOjS3s249DartcEFUsQ0ce+4p3aKk9ZuhbxvigyC7LXRBZ/H6jn3Qqh/Mp+BDkJIV28OTAskJpDOues7qtWcPSy8XFUCjhs75RgErIUXB8AVM8G6bx0EClMZ4VCuerbtMSXXUwDHKK4UyPSYzMDcPR3krlqQu65G1FX1e/9dRcJAPw3VQLJZIh7NJQZYmllgub0UOevBCmqW52KIKdarpvCgv2dlQHoGLIJqB4q7oPVZMmxouZOqaTDB0MwgLt8OCLEktFJgg0H2gaeis2FfwHiww/KOOwGhskVjVDwKKopiQEqWSey3tDgZZ6w0SlBLJSwP9IluiPvpylHl7vt+lWIIm0q5HSQA7/RuLX/s0avOrkopr80ccdMKbCvQgbKNxNX0F7VigEmWUDtqHLaXgR/epJIkaw/lXUXmIamblsVkG1vIdc6BMZKnmItLeBFki/zcQN4Ss8xijmAy2dFr8s24nZfVGU+hBvmq8ultSTsZ1XHztHQm0K55jJLi6I8QEiM2+NP8xG0+MSqzpvuQAIQX0Bbc+ywF0=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(376002)(346002)(396003)(84040400005)(451199018)(83380400001)(6512007)(2906002)(53546011)(6506007)(107886003)(6666004)(186003)(31686004)(6486002)(38100700002)(478600001)(4326008)(86362001)(31696002)(316002)(8936002)(2616005)(41300700001)(110136005)(36756003)(66476007)(66556008)(7416002)(66946007)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?eHljMmhaUTA0MUNKMm1JWVlaYXNCSHVpS0Z5Q0Z6ZlRocnNYcjRmV1VRSU9K?=
 =?utf-8?B?R1JpTndYV3p0bXFXS1dKM0wxdzVVQ2VTV0QzUzBtN0F3ZkNVeFU3VlJ2c1U0?=
 =?utf-8?B?OHdrTjJ3eUVXOTU3ZHdOTlFPdWhRbklzU3RzY3RXamtSQ1JQVy9WUmxJMDNB?=
 =?utf-8?B?S210N3dSZkdqVXc3MFVpYjZNUUF6aTdKTGlRdUhxWXRhSXRNdVZYWmxqWC9M?=
 =?utf-8?B?VVRpc0VYVjRlNnFObk5hUlJZamxhSS95b0I4WHF4OTZSYVdRNWFqc1R6eUFw?=
 =?utf-8?B?cHFRTnZ5QVdXZ21uU2JDaVpWd3FHT0RxZmFydFBkeTJSR3dtWjFtWDRsaG1K?=
 =?utf-8?B?czFWUS9GSkdmU3FDMGRNbnNuMEJTdE5nV0t6UHNqTTZUQ0l1SGNhSEpiN0hv?=
 =?utf-8?B?WkM3Y1VZdFM5ZEQyL0hEVkZMdzRkSFdyMnpRRVJHekRlTHdnemNYSmVkYnBB?=
 =?utf-8?B?dE9NTnJrWisxRE53ZEcxUnBiaG5ZMlNUTXU2QlMvN2cvcjgxdmZraW5HUDZo?=
 =?utf-8?B?djdhTlhKdXpPbTlQNk1ETnA4ejRBVjRBUVFtV1l1RDFSbm82Y2hIR1llcnRz?=
 =?utf-8?B?M2pXaTUvakVOZTRaMHROem5SejhDUDIrRjluSWxweGQ2STVwcW5BZVhEY2Vn?=
 =?utf-8?B?NTJiNTlXUWo2MW1kSGNvUXRNL0ZCZXdHS2VvZnRmQWpwdXNDZndydFZyTWg4?=
 =?utf-8?B?Y05WZFlzMER1a21BVk5TZWxpRWJ1S0o0SlN0WHNmNGJ5a3FxdXVSbkIxZjdm?=
 =?utf-8?B?amJ0OFpYUkY1ZmU1Rnp0bUZlYmJDdUF5V2RlSnhZOUZVUmRyc1hQbFRvVyts?=
 =?utf-8?B?Q0h4TGNRS2VYbEh5cXdWSGk3dWJ0dVJxZDFUaUZ3clJsWHFvUWczUGhIOWFM?=
 =?utf-8?B?bHZkaFIxajdjYnlnVExqR1JQQ3NtNWJiQlNaVmcvSnAzV1hUWHByYkpOanlS?=
 =?utf-8?B?S0Y5bE1YSTEzN2ltdnRZZHJmQVZIVTNTWmpBY29jYi90QjU3SjVoN0xhZFAv?=
 =?utf-8?B?eG05ZmZKeS9SUCtWY3l5NzhnMWRtdmV2dS80TitNd0xKcExYbUxLQUp5Zjd4?=
 =?utf-8?B?TTNQYUhCaFRsc3NPWTZUNjFZbHIvNm9sTVYzODJGYitjSko4YVdFRjZIZTRQ?=
 =?utf-8?B?QmQ5SnBZY3BRNVVSTFBITmZ4S2FTV2ZJRmFLV1hEaE5tdGFkV2VpSjJ2K1FC?=
 =?utf-8?B?TnJJWVlRYTc5c2NjcnhBMkFPV2EyVTNHTXJMcW9jUnZHaDlGc3FObEhWSDJj?=
 =?utf-8?B?QW1BVnI2b0QranA5Vit6SEw1WEJIS2R2YkVDWG9lK2NPVmVueVM4U01oS0E5?=
 =?utf-8?B?SHF4RWpnbUtkY2ZVU2thZnk4Vmd5UFhCZXZnODNHTFZ1ek5OaWdnazhmeDhp?=
 =?utf-8?B?NGxmOTBJc01Cb1FpeStSY0p4cytOcDN0aDJXeFZiMy9CNm8xckFzNU5FK0pi?=
 =?utf-8?B?T1lmOVN2VmM2S2FBejdoNmlvclVlWE56Si9IRGlRcXRqYTVpZTZKVUdLSkY3?=
 =?utf-8?B?VzlCaHIxVWRUN25Ed3A1N093R0l0OWJlUWVIVzFaY1pXNDI5YnAydjNpS0Ns?=
 =?utf-8?B?SXJKQ3Z2VFBSNExPQ1FMdHJFRk52eFQ2cEwzbENMYVNraUhzeHljTjNvbHN0?=
 =?utf-8?B?dk5KaFBKT0lRUmhZNUlQMDk5em5mNEM5eW94aXRZYnZwU0lQNlQxalhRaE1N?=
 =?utf-8?B?aU16Y2xIa3FQdmRpcnJydUVQMlYyQy95SWZCS1lxRGZURFZqYUJ6SktKYklX?=
 =?utf-8?B?d2o2SEs1Z3dwODdvK2lGd2FmRjJkTnZOMWJoOXhTcVRSZ2hiQU5leFBGTml1?=
 =?utf-8?B?NUk4b3RWRlZiS1ZFbmRhb2pSZFRjTmJ1c2FuOUxJODYyTUM3TWFyaDJyd2w4?=
 =?utf-8?B?U2V3VE55M3dPeHJ5K1FDV256NmJnL1Y2UlBqT1UrN0tsNmprUkM3elc3RkJk?=
 =?utf-8?B?ZndFbkQ2V2tOZVh1TXIzWTF2aXhvZkxhSTMxZlhwamc2Tm95YXgva0syYXg3?=
 =?utf-8?B?SEJTNVV4T2FpZ3BTWXJNS3RnV3pLR0cvN3JuWHBsZkpBUlEvTzFUeHYvZnZB?=
 =?utf-8?B?cytXd2FBU2ttcXhHY0UweUk5RTJoNiszV0o3Z1NsODcvcElHaUM4UjYrekJS?=
 =?utf-8?B?WUNCTndGdUd0RWpwczVvSzI3TTFlRjNEK3JXVGxON2JQSkNnZElWeGFtMlZ1?=
 =?utf-8?Q?N4Xlz5T4JTdKaAPa1lFOoQg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?TkxNNE92VnZNRGxPQWxhMG10TEVWL3VybXAyL2ZpSmJnOGVpdS8rUkp3MDdC?=
 =?utf-8?B?TERHczJjY3hzNUh0K3dWb2NVNnE2VXppcGcvTGV1VEV5QnlHdXBtbkwrZGNH?=
 =?utf-8?B?bE9paGZmZVZxOURqSVB2d0ozVm5KbzlyL05mVVkycVlxTC8wQStXbFloMHZW?=
 =?utf-8?B?S3d0VXF5WHJSSTIzLzFnUEZLQkJmWTg2aEt2SUhqSzUxWFkwMkdMdnRlVkVr?=
 =?utf-8?B?OFM5SEZTQVV3Lzdybi91VUgreDlyc3RSR1JIeFVWUFNSWFNHREgwcTZQNXNq?=
 =?utf-8?B?eFNxZ1FIMjRuZkpMTHVmOWN4L1p3Q2l6MzByUnc4YzdOVU5HVGlkSVdXZHha?=
 =?utf-8?B?YUMyTGpBZFdwMG5ZTjI3NXJ5WjUyMkpKdjU5ZGZWa0t0Mmlmc0d0bGpWakVn?=
 =?utf-8?B?byt3WDhwcGdxK0hxWGJ1dW9Ja0tzWUR4ZGxaeUpOdVBER1owUktncjFvVUpG?=
 =?utf-8?B?U2k4NFFSZC84TnF4OU1IZEtjQ25vMDhWM2NMR1l0dm1iSXlDenZPc090cW1X?=
 =?utf-8?B?Q0h2cUtTd2RWUlRNN0d5S3pxYXgxUUpBZW4vOWI1SnFiZGtld2dZQ0VuczFT?=
 =?utf-8?B?TWMvQ3ZiR3lWbFZkYTl2eUl4YWM4QzBINHA5MXZTY1BCem5MQVc2a0xqeHVl?=
 =?utf-8?B?TWRjWkRsMzhMSEJIaXVXdlhFUElyQ2s5Y2tCVmJCcEFMR2x0R3MwTDh3S1dV?=
 =?utf-8?B?K2RUanY5ME9JVk55b2JWWWtFQ3RiVWxML2J5VUNrOWY1Q0RndytMd0tWWHlX?=
 =?utf-8?B?dTdNWUdzWlZXOGF2UVlmdS9ybTcyOG5ZUkt6NTVHS3dMczVXMDRacndYaE1q?=
 =?utf-8?B?RE1UWjhnckxDYmRnUHVzQjJvaExJL1B3RzcyMGYzMjBVaDJGNmVFcElUUVBn?=
 =?utf-8?B?UmdHbzdCSExjdkhSMXRxMFVod1p0dCtwYUZrTy9iODlaTTVSRG9LNlpVSElJ?=
 =?utf-8?B?aGpCYjBCUjhsVldyNlVOL2NGZDAycnRXOHRGZGlJV0l0TUgwS01ubUxtaXpT?=
 =?utf-8?B?Ym4zbEpxdlFuMmo0N1E4Q3B4Z2xnT2NCVEo0SGpldUR2b2lQZExKV3VXNHlx?=
 =?utf-8?B?eXBwbGx4RXEzcVZMYXg3SjhORTJtMElROHZhZjUvQUl3akFPTU52QVRLMXlI?=
 =?utf-8?B?VDAzelNqNGovbGhnVDR4SzcrcEx2MHN2enBOWjdsNTFEWDJ5MjVIN0FhWHh6?=
 =?utf-8?B?OGVIei9HNnJwRHc3WSthUXJ1b2U0VVRYKzhDTkFRV2VBaGczVjdScDM4bktJ?=
 =?utf-8?B?WFpBVTRNNkFKaWg5ekhETndCd0JENkFCSFkxTnZ6bFByY21BNlR6NkpLckxX?=
 =?utf-8?B?OWtoSnNCWnppMTJrQ21NclZLdFVDUUcrYTl1MVVaWTNubHdsSXZlRlYyUHZ3?=
 =?utf-8?B?cUE4ckhwcEdQdWV4MldYT0p4QTl3SDZoMzUyNWxZdVo5NnlDNjVTWklLYWoy?=
 =?utf-8?B?Z2lRTGEwSDVNOVZ5MkVadnVHdlNRd0RrcWdoMksyNlAwSkZHVE02TWJCT2E5?=
 =?utf-8?B?ZUd0WTdFWDdRSE1qNHRzQ2hlSVMrSzk5ckFzVHpNQlc2eHNRb1lJOHREV3B2?=
 =?utf-8?Q?sgoc7W+YXBlUmFyYXzqdBNDpw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1513391-8be2-4649-4f16-08db0bc7d840
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:35:15.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl1qrY3LLCzV3q3v6p2U5pIa+FLT2va1NI9xOx60RK2JLu/sESoXLseqdtybkWsl+IxDY5/hZ2lvdKZZxwDgDfQZkIJjV0StLyY42iwYPUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110001
X-Proofpoint-GUID: 5IxrFbnT_ei1gKQzgg1YXcnVNBnmpRmv
X-Proofpoint-ORIG-GUID: 5IxrFbnT_ei1gKQzgg1YXcnVNBnmpRmv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_163539_210418_0CBBE755 
X-CRM114-Status: GOOD (  17.56  )
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

CgpPbiAyLzEwLzIzIDAwOjI5LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gCj4gT24gMTAvMDIvMjMg
MDE6MDksIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIvOS8yMyAxMjo0MywgU291
cmFiaCBKYWluIHdyb3RlOgo+Pj4gSGVsbG8gRXJpYywKPj4+Cj4+PiBPbiAwOS8wMi8yMyAyMzow
MSwgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMi84LzIzIDA3OjQ0LCBU
aG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+Pj4+IEVyaWMhCj4+Pj4+Cj4+Pj4+IE9uIFR1ZSwgRmVi
IDA3IDIwMjMgYXQgMTE6MjMsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Pj4+PiBPbiAyLzEvMjMg
MDU6MzMsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBTbyBteSBsYXRlc3Qg
c29sdXRpb24gaXMgaW50cm9kdWNlIHR3byBuZXcgQ1BVSFAgc3RhdGVzLCBDUFVIUF9BUF9FTEZD
T1JFSERSX09OTElORQo+Pj4+Pj4gZm9yIG9ubGluaW5nIGFuZCBDUFVIUF9CUF9FTEZDT1JFSERS
X09GRkxJTkUgZm9yIG9mZmxpbmluZy4gSSdtIG9wZW4gdG8gYmV0dGVyIG5hbWVzLgo+Pj4+Pj4K
Pj4+Pj4+IFRoZSBDUFVIUF9BUF9FTEZDT1JFSERSX09OTElORSBuZWVkcyB0byBiZSBwbGFjZWQg
YWZ0ZXIgQ1BVSFBfQlJJTkdVUF9DUFUuIE15Cj4+Pj4+PiBhdHRlbXB0cyBhdCBsb2NhdGluZyB0
aGlzIHN0YXRlIGZhaWxlZCB3aGVuIGluc2lkZSB0aGUgU1RBUlRJTkcgc2VjdGlvbiwgc28gSSBs
b2NhdGVkCj4+Pj4+PiB0aGlzIGp1c3QgaW5zaWRlIHRoZSBPTkxJTkUgc2VjdG9pbi4gVGhlIGNy
YXNoIGhvdHBsdWcgaGFuZGxlciBpcyByZWdpc3RlcmVkIG9uCj4+Pj4+PiB0aGlzIHN0YXRlIGFz
IHRoZSBjYWxsYmFjayBmb3IgdGhlIC5zdGFydHVwIG1ldGhvZC4KPj4+Pj4+Cj4+Pj4+PiBUaGUg
Q1BVSFBfQlBfRUxGQ09SRUhEUl9PRkZMSU5FIG5lZWRzIHRvIGJlIHBsYWNlZCBiZWZvcmUgQ1BV
SFBfVEVBUkRPV05fQ1BVLCBhbmQgSQo+Pj4+Pj4gcGxhY2VkIGl0IGF0IHRoZSBlbmQgb2YgdGhl
IFBSRVBBUkUgc2VjdGlvbi4gVGhpcyBjcmFzaCBob3RwbHVnIGhhbmRsZXIgaXMgYWxzbwo+Pj4+
Pj4gcmVnaXN0ZXJlZCBvbiB0aGlzIHN0YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC50ZWFy
ZG93biBtZXRob2QuCj4+Pj4+Cj4+Pj4+IFRCSCwgdGhhdCdzIHN0aWxsIG92ZXJlbmdpbmVlcmVk
LiBTb21ldGhpbmcgbGlrZSB0aGlzOgo+Pj4+Pgo+Pj4+PiBib29sIGNwdV9pc19hbGl2ZSh1bnNp
Z25lZCBpbnQgY3B1KQo+Pj4+PiB7Cj4+Pj4+IMKgwqDCoMKgc3RydWN0IGNwdWhwX2NwdV9zdGF0
ZSAqc3QgPSBwZXJfY3B1X3B0cigmY3B1aHBfc3RhdGUsIGNwdSk7Cj4+Pj4+Cj4+Pj4+IMKgwqDC
oMKgcmV0dXJuIGRhdGFfcmFjZShzdC0+c3RhdGUpIDw9IENQVUhQX0FQX0lETEVfREVBRDsKPj4+
Pj4gfQo+Pj4+Pgo+Pj4+PiBhbmQgdXNlIHRoaXMgdG8gcXVlcnkgdGhlIGFjdHVhbCBzdGF0ZSBh
dCBjcmFzaCB0aW1lLiBUaGF0IHNwYXJlcyBhbGwKPj4+Pj4gdGhvc2UgY2FsbGJhY2sgaGV1cmlz
dGljcy4KPj4+Pj4KPj4+Pj4+IEknbSBtYWtpbmcgbXkgd2F5IHRob3VnaCBwZXJjcHUgY3Jhc2hf
bm90ZXMsIGVsZmNvcmVoZHIsIHZtY29yZWluZm8sCj4+Pj4+PiBtYWtlZHVtcGZpbGUgYW5kICh0
aGUgY29uc3VtZXIgb2YgaXQgYWxsKSB0aGUgdXNlcnNwYWNlIGNyYXNoIHV0aWxpdHksCj4+Pj4+
PiBpbiBvcmRlciB0byB1bmRlcnN0YW5kIHRoZSBpbXBhY3Qgb2YgbW92aW5nIGZyb20gZm9yX2Vh
Y2hfcHJlc2VudF9jcHUoKQo+Pj4+Pj4gdG8gZm9yX2VhY2hfb25saW5lX2NwdSgpLgo+Pj4+Pgo+
Pj4+PiBJcyB0aGUgcGFja2luZyBhY3R1YWxseSB3b3J0aCB0aGUgdHJvdWJsZT8gV2hhdCdzIHRo
ZSBhY3R1YWwgd2luPwo+Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+Pj4+Cj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgdGdseAo+Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+Pj4gVGhvbWFzLAo+Pj4+IEkndmUgaW52ZXN0
aWdhdGVkIHRoZSBwYXNzaW5nIG9mIGNyYXNoIG5vdGVzIHRocm91Z2ggdGhlIHZtY29yZS4gV2hh
dCBJJ3ZlIGxlYXJuZWQgaXMgdGhhdDoKPj4+Pgo+Pj4+IC0gbGludXgvZnMvcHJvYy92bWNvcmUu
YyAod2hpY2ggbWFrZWR1bXBmaWxlIHJlZmVyZW5jZXMgdG8gZG8gaXRzIGpvYikgZG9lcwo+Pj4+
IMKgIG5vdCBjYXJlIHdoYXQgdGhlIGNvbnRlbnRzIG9mIGNwdSBQVF9OT1RFUyBhcmUsIGJ1dCBp
dCBkb2VzIGNvYWxlc2NlIHRoZW0gdG9nZXRoZXIuCj4+Pj4KPj4+PiAtIG1ha2VkdW1wZmlsZSB3
aWxsIGNvdW50IHRoZSBudW1iZXIgb2YgY3B1IFBUX05PVEVTIGluIG9yZGVyIHRvIGRldGVybWlu
ZSBpdHMKPj4+PiDCoCBucl9jcHVzIHZhcmlhYmxlLCB3aGljaCBpcyByZXBvcnRlZCBpbiBhIGhl
YWRlciwgYnV0IG90aGVyd2lzZSB1bnVzZWQgKGV4Y2VwdAo+Pj4+IMKgIGZvciBzYWR1bXAgbWV0
aG9kKS4KPj4+Pgo+Pj4+IC0gdGhlIGNyYXNoIHV0aWxpdHksIGZvciB0aGUgcHVycG9zZXMgb2Yg
ZGV0ZXJtaW5pbmcgdGhlIGNwdXMsIGRvZXMgbm90IGFwcGVhciB0bwo+Pj4+IMKgIHJlZmVyZW5j
ZSB0aGUgZWxmY29yZWhkciBQVF9OT1RFcy4gSW5zdGVhZCBpdCBsb2NhdGVzIHRoZSB2YXJpb3Vz
Cj4+Pj4gwqAgY3B1X1twb3NzaWJsZXxwcmVzZW50fG9ubGluZV1fbWFzayBhbmQgY29tcHV0ZXMg
bnJfY3B1cyBmcm9tIHRoYXQsIGFuZCBhbHNvIG9mCj4+Pj4gwqAgY291cnNlIHdoaWNoIGFyZSBv
bmxpbmUuIEluIGFkZGl0aW9uLCB3aGVuIGNyYXNoIGRvZXMgcmVmZXJlbmNlIHRoZSBjcHUgUFRf
Tk9URSwKPj4+PiDCoCB0byBnZXQgaXRzIHByc3RhdHVzLCBpdCBkb2VzIHNvIGJ5IHVzaW5nIGEg
cGVyY3B1IHRlY2huaXF1ZSBkaXJlY3RseSBpbiB0aGUgdm1jb3JlCj4+Pj4gwqAgaW1hZ2UgbWVt
b3J5LCBub3QgdmlhIHRoZSBFTEYgc3RydWN0dXJlLiBTYWlkIGRpZmZlcmVudGx5LCBpdCBhcHBl
YXJzIHRvIG1lIHRoYXQKPj4+PiDCoCBjcmFzaCB1dGlsaXR5IGRvZXNuJ3QgcmVseSBvbiB0aGUg
RUxGIFBUX05PVEVzIGZvciBjcHVzOyByYXRoZXIgaXQgb2J0YWlucyB0aGVtCj4+Pj4gwqAgdmlh
IGtlcm5lbCBjcHVtYXNrcyBhbmQgdGhlIG1lbW9yeSB3aXRoaW4gdGhlIHZtY29yZS4KPj4+Pgo+
Pj4+IFdpdGggdGhpcyB1bmRlcnN0YW5kaW5nLCBJIGRpZCBzb21lIHRlc3RpbmcuIFBlcmhhcHMg
dGhlIG1vc3QgdGVsbGluZyB0ZXN0IHdhcyB0aGF0IEkKPj4+PiBjaGFuZ2VkIHRoZSBudW1iZXIg
b2YgY3B1IFBUX05PVEVzIGVtaXR0ZWQgaW4gdGhlIGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVy
cygpIHRvIGp1c3QgMSwKPj4+PiBob3QgcGx1Z2dlZCBzb21lIGNwdXMsIHRoZW4gYWxzbyB0b29r
IGEgZmV3IG9mZmxpbmUgc3BhcnNlbHkgdmlhIGNoY3B1LCB0aGVuIGdlbmVyYXRlZCBhCj4+Pj4g
dm1jb3JlLiBUaGUgY3Jhc2ggdXRpbGl0eSBoYWQgbm8gcHJvYmxlbSBsb2FkaW5nIHRoZSB2bWNv
cmUsIGl0IHJlcG9ydGVkIHRoZSBwcm9wZXIgbnVtYmVyCj4+Pj4gb2YgY3B1cyBhbmQgdGhlIG51
bWJlciBvZmZsaW5lIChkZXNwaXRlIG9ubHkgb25lIGNwdSBQVF9OT1RFKSwgYW5kIGNoYW5naW5n
IHRvIGEgZGlmZmVyZW50Cj4+Pj4gY3B1IHZpYSAnc2V0IC1jIDMwJyBhbmQgdGhlIGJhY2t0cmFj
ZSB3YXMgY29tcGxldGVseSB2YWxpZC4KPj4+Pgo+Pj4+IE15IHRha2UgYXdheSBpcyB0aGF0IGNy
YXNoIHV0aWxpdHkgZG9lcyBub3QgcmVseSB1cG9uIEVMRiBjcHUgUFRfTk9URXMsIGl0IG9idGFp
bnMgdGhlCj4+Pj4gY3B1IGluZm9ybWF0aW9uIGRpcmVjdGx5IGZyb20ga2VybmVsIGRhdGEgc3Ry
dWN0dXJlcy4gUGVyaGFwcyBhdCBvbmUgdGltZSBjcmFzaCByZWxpZWQKPj4+PiB1cG9uIHRoZSBF
TEYgaW5mb3JtYXRpb24sIGJ1dCBubyBtb3JlLiAoUGVyaGFwcyB0aGVyZSBhcmUgb3RoZXIgY3Jh
c2ggZHVtcCBhbmFseXplcnMKPj4+PiB0aGF0IG1pZ2h0IHJlbHkgb24gdGhlIEVMRiBpbmZvPykK
Pj4+Pgo+Pj4+IFNvLCBhbGwgdGhpcyB0byBzYXkgdGhhdCBJIHNlZSBubyBuZWVkIHRvIGNoYW5n
ZSBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKS4gVGhlcmUKPj4+PiBpcyBubyBjb21wZWxs
aW5nIHJlYXNvbiB0byBtb3ZlIGF3YXkgZnJvbSBmb3JfZWFjaF9wcmVzZW50X2NwdSgpLCBvciBt
b2RpZnkgdGhlIGxpc3QgZm9yCj4+Pj4gb25saW5lL29mZmxpbmUuCj4+Pj4KPj4+PiBXaGljaCB0
aGVuIGxlYXZlcyB0aGUgdG9waWMgb2YgdGhlIGNwdWhwIHN0YXRlIG9uIHdoaWNoIHRvIHJlZ2lz
dGVyLiBQZXJoYXBzIHJldmVydGluZwo+Pj4+IGJhY2sgdG8gdGhlIHVzZSBvZiBDUFVIUF9CUF9Q
UkVQQVJFX0RZTiBpcyB0aGUgcmlnaHQgYW5zd2VyLiBUaGVyZSBkb2VzIG5vdCBhcHBlYXIgdG8K
Pj4+PiBiZSBhIGNvbXBlbGxpbmcgbmVlZCB0byBhY2N1cmF0ZWx5IHRyYWNrIHdoZXRoZXIgdGhl
IGNwdSB3ZW50IG9ubGluZS9vZmZsaW5lIGZvciB0aGUKPj4+PiBwdXJwb3NlcyBvZiBjcmVhdGlu
ZyB0aGUgZWxmY29yZWhkciwgYXMgdWx0aW1hdGVseSB0aGUgY3Jhc2ggdXRpbGl0eSBwdWxscyB0
aGF0IGZyb20KPj4+PiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzLCBub3QgdGhlIGVsZmNvcmVoZHIu
Cj4+Pj4KPj4+PiBJIHRoaW5rIHRoaXMgaXMgd2hhdCBTb3VyYWJoIGhhcyBrbm93biBhbmQgaGFz
IGJlZW4gYWR2b2NhdGluZyBmb3IgYW4gb3B0aW1pemF0aW9uCj4+Pj4gcGF0aCB0aGF0IGFsbG93
cyBub3QgcmVnZW5lcmF0aW5nIHRoZSBlbGZjb3JlaGRyIG9uIGNwdSBjaGFuZ2VzIChiZWNhdXNl
IGFsbCB0aGUgcGVyY3B1Cj4+Pj4gc3RydWN0cyBhcmUgYWxsIGxhaWQgb3V0KS4gSSBkbyB0aGlu
ayBpdCBiZXN0IHRvIGxlYXZlIHRoYXQgYXMgYW4gYXJjaCBjaG9pY2UuCj4+Pgo+Pj4gU2luY2Ug
dGhpbmdzIGFyZSBjbGVhciBvbiBob3cgdGhlIFBUX05PVEVTIGFyZSBjb25zdW1lZCBpbiBrZHVt
cCBrZXJuZWwgW2ZzL3Byb2Mvdm1jb3JlLmNdLAo+Pj4gbWFrZWR1bXBmaWxlLCBhbmQgY3Jhc2gg
dG9vbCBJIG5lZWQgeW91ciBvcGluaW9uIG9uIHRoaXM6Cj4+Pgo+Pj4gRG8gd2UgcmVhbGx5IG5l
ZWQgdG8gcmVnZW5lcmF0ZSBlbGZjb3JlaGRyIGZvciBDUFUgaG90cGx1ZyBldmVudHM/Cj4+PiBJ
ZiB5ZXMsIGNhbiB5b3UgcGxlYXNlIGxpc3QgdGhlIGVsZmNvcmVoZHIgY29tcG9uZW50cyB0aGF0
IGNoYW5nZXMgZHVlIHRvIENQVSBob3RwbHVnLgo+PiBEdWUgdG8gdGhlIHVzZSBvZiBmb3JfZWFj
aF9wcmVzZW50X2NwdSgpLCBpdCBpcyBwb3NzaWJsZSBmb3IgdGhlIG51bWJlciBvZiBjcHUgUFRf
Tk9URXMKPj4gdG8gZmx1Y3R1YXRlIGFzIGNwdXMgYXJlIHVuL3BsdWdnZWQuIE9ubGluaW5nL29m
ZmxpbmluZyBvZiBjcHVzIGRvZXMgbm90IGltcGFjdCB0aGUKPj4gbnVtYmVyIG9mIGNwdSBQVF9O
T1RFcyAoYXMgdGhlIGNwdXMgYXJlIHN0aWxsIHByZXNlbnQpLgo+Pgo+Pj4KPj4+IMKgRnJvbSB3
aGF0IEkgdW5kZXJzdG9vZCwgY3Jhc2ggbm90ZXMgYXJlIHByZXBhcmVkIGZvciBwb3NzaWJsZSBD
UFVzIGFzIHN5c3RlbSBib290cyBhbmQKPj4+IGNvdWxkIGJlIHVzZWQgdG8gY3JlYXRlIGEgUFRf
Tk9URSBzZWN0aW9uIGZvciBlYWNoIHBvc3NpYmxlIENQVSB3aGlsZSBnZW5lcmF0aW5nIHRoZSBl
bGZjb3JlaGRyCj4+PiBkdXJpbmcgdGhlIGtkdW1wIGtlcm5lbCBsb2FkLgo+Pj4KPj4+IE5vdyBv
bmNlIHRoZSBlbGZjb3JlaGRyIGlzIGxvYWRlZCB3aXRoIFBUX05PVEVzIGZvciBldmVyeSBwb3Nz
aWJsZSBDUFUgdGhlcmUgaXMgbm8gbmVlZCB0bwo+Pj4gcmVnZW5lcmF0ZSBpdCBmb3IgQ1BVIGhv
dHBsdWcgZXZlbnRzLiBPciBkbyB3ZT8KPj4KPj4gRm9yIG9ubGluaW5nL29mZmxpbmluZyBvZiBj
cHVzLCB0aGVyZSBpcyBubyBuZWVkIHRvIHJlZ2VuZXJhdGUgdGhlIGVsZmNvcmVoZHIuIEhvd2V2
ZXIsCj4+IGZvciBhY3R1YWwgaG90IHVuL3BsdWcgb2YgY3B1cywgdGhlIGFuc3dlciBpcyB5ZXMg
ZHVlIHRvIGZvcl9lYWNoX3ByZXNlbnRfY3B1KCkuIFRoZQo+PiBjYXZlYXQgaGVyZSBvZiBjb3Vy
c2UgaXMgdGhhdCBpZiBjcmFzaCB1dGlsaXR5IGlzIHRoZSBvbmx5IGNvcmVkdW1wIGFuYWx5emVy
IG9mIGNvbmNlcm4sCj4+IHRoZW4gaXQgZG9lc24ndCBjYXJlIGFib3V0IHRoZXNlIGNwdSBQVF9O
T1RFcyBhbmQgdGhlcmUgd291bGQgYmUgbm8gbmVlZCB0byByZS1nZW5lcmF0ZSB0aGVtLgo+Pgo+
PiBBbHNvLCBJJ20gbm90IHN1cmUgaWYgQVJNIGNwdSBob3RwbHVnLCB3aGljaCBpcyBqdXN0IG5v
dyBjb21pbmcgaW50byBtYWluc3RyZWFtLCBpbXBhY3RzCj4+IGFueSBvZiB0aGlzLgo+Pgo+PiBQ
ZXJoYXBzIHRoZSBvbmUgaXRlbSB0aGF0IG1pZ2h0IGhlbHAgaGVyZSBpcyB0byBkaXN0aW5ndWlz
aCBiZXR3ZWVuIGFjdHVhbCBob3QgdW4vcGx1ZyBvZgo+PiBjcHVzLCB2ZXJzdXMgb25saW5pbmcv
b2ZmbGluaW5nLiBBdCB0aGUgbW9tZW50LCBJIGNhbiBub3QgZGlzdGluZ3Vpc2ggYmV0d2VlbiBh
IGhvdCBwbHVnCj4+IGV2ZW50IGFuZCBhbiBvbmxpbmUgZXZlbnQgKGFuZCB1bnBsdWcvb2ZmbGlu
ZSkuIElmIHRob3NlIHdlcmUgZGlzdGluZ3Vpc2hhYmxlLCB0aGVuIHdlCj4+IGNvdWxkIG9ubHkg
cmVnZW5lcmF0ZSBvbiB1bi9wbHVnIGV2ZW50cy4KPj4KPj4gT3IgcGVyaGFwcyBtb3ZpbmcgdG8g
Zm9yX2VhY2hfcG9zc2libGVfY3B1KCkgaXMgdGhlIGJldHRlciBjaG9pY2U/Cj4gCj4gWWVzLCBi
ZWNhdXNlIG9uY2UgZWxmY29yZWhkciBpcyBidWlsdCB3aXRoIHBvc3NpYmxlIENQVXMgd2UgZG9u
J3QgaGF2ZSB0byB3b3JyeSBhYm91dAo+IGhvdFt1bl1wbHVnIGNhc2UuCj4gCj4gSGVyZSBpcyBt
eSB2aWV3IG9uIGhvdyB0aGluZ3Mgc2hvdWxkIGJlIGhhbmRsZWQgaWYgYSBjb3JlLWR1bXAgYW5h
bHl6ZXIgaXMgZGVwZW5kZW50IG9uCj4gZWxmY29yZWhkciBQVF9OT1RFcyB0byBmaW5kIG9ubGlu
ZS9vZmZsaW5lIENQVXMuCj4gCj4gQSBQVF9OT1RFIGluIGVsZmNvcmVoZHIgaG9sZHMgdGhlIGFk
ZHJlc3Mgb2YgdGhlIGNvcnJlc3BvbmRpbmcgY3Jhc2ggbm90ZXMgKGtlcm5lbCBoYXMKPiBvbmUg
Y3Jhc2ggbm90ZSBwZXIgQ1BVIGZvciBldmVyeSBwb3NzaWJsZSBDUFUpLiBUaG91Z2ggdGhlIGNy
YXNoIG5vdGVzIGFyZSBhbGxvY2F0ZWQKPiBkdXJpbmcgdGhlIGJvb3QgdGltZSB0aGV5IGFyZSBw
b3B1bGF0ZWQgd2hlbiB0aGUgc3lzdGVtIGlzIG9uIHRoZSBjcmFzaCBwYXRoLgo+IAo+IFRoaXMg
aXMgaG93IGNyYXNoIG5vdGVzIGFyZSBwb3B1bGF0ZWQgb24gUG93ZXJQQyBhbmQgSSBhbSBleHBl
Y3RpbmcgaXQgd291bGQgYmUgc29tZXRoaW5nCj4gc2ltaWxhciBvbiBvdGhlciBhcmNoaXRlY3R1
cmVzIHRvby4KPiAKPiBUaGUgY3Jhc2hpbmcgQ1BVIHNlbmRzIElQSSB0byBldmVyeSBvdGhlciBv
bmxpbmUgQ1BVIHdpdGggYSBjYWxsYmFjayBmdW5jdGlvbiB0aGF0IHVwZGF0ZXMgdGhlCj4gY3Jh
c2ggbm90ZXMgb2YgdGhhdCBzcGVjaWZpYyBDUFUuIE9uY2UgdGhlIElQSSBjb21wbGV0ZXMgdGhl
IGNyYXNoaW5nIENQVSB1cGRhdGVzIGl0cyBvd24gY3Jhc2gKPiBub3RlIGFuZCBwcm9jZWVkcyBm
dXJ0aGVyLgo+IAo+IFRoZSBjcmFzaCBub3RlcyBvZiBDUFVzIHJlbWFpbiB1bmluaXRpYWxpemVk
IGlmIHRoZSBDUFVzIHdlcmUgb2ZmbGluZSBvciBob3QgdW5wbHVnZ2VkIGF0IHRoZSB0aW1lCj4g
c3lzdGVtIGNyYXNoLiBUaGUgY29yZS1kdW1wIGFuYWx5emVyIHNob3VsZCBiZSBhYmxlIHRvIGlk
ZW50aWZ5IFt1bl0vaW5pdGlhbGl6ZWQgY3Jhc2ggbm90ZXMKPiBhbmQgZGlzcGxheSB0aGUgaW5m
b3JtYXRpb24gYWNjb3JkaW5nbHkuCj4gCj4gVGhvdWdodHM/Cj4gCj4gLSBTb3VyYWJoCgpJbiBn
ZW5lcmFsLCBJIGFncmVlIHdpdGggeW91ciBwb2ludHMuIFlvdSd2ZSBwcmVzZW50ZWQgYSBzdHJv
bmcgY2FzZSB0byBnbyB3aXRoIApmb3JfZWFjaF9wb3NzaWJsZV9jcHUoKSBpbiBjcmFzaF9wcmVw
YXJlX2VsZjY0X2hlYWRlcnMoKSBhbmQgdGhvc2UgY3Jhc2ggbm90ZXMgd291bGQgYWx3YXlzIGJl
IApwcmVzZW50LCBhbmQgd2UgY2FuIGlnbm9yZSBjaGFuZ2VzIHRvIGNwdXMgd3J0LyBlbGZjb3Jl
aGRyIHVwZGF0ZXMuCgpCdXQgd2hhdCBkbyB3ZSBkbyBhYm91dCBrZXhlY19sb2FkKCkgc3lzY2Fs
bD8gVGhlIHdheSB0aGUgdXNlcnNwYWNlIHV0aWxpdHkgd29ya3MgaXMgaXQgZGV0ZXJtaW5lcyAK
Y3B1cyBieToKICBucl9jcHVzID0gc3lzY29uZihfU0NfTlBST0NFU1NPUlNfQ09ORik7CndoaWNo
IGlzIG5vdCB0aGUgZXF1aXZhbGVudCBvZiBwb3NzaWJsZV9jcHVzLiBTbyB0aGUgY29tcGxldGUg
bGlzdCBvZiBjcHUgUFRfTk9URXMgaXMgbm90IGdlbmVyYXRlZCAKdXAgZnJvbnQuIFdlIHdvdWxk
IG5lZWQgYSBzb2x1dGlvbiBmb3IgdGhhdD8KClRoYW5rcywKZXJpYwoKUFMuIEknbGwgYmUgb24g
dmFjYXRpb24gYWxsIG9mIG5leHQgd2VlaywgcmV0dXJuaW5nIDIwZmViLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
