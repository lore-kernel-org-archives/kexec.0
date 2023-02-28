Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25826C64ED6
	for <kexec@archiver.kernel.org>; Tue, 28 Feb 2023 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQ1EtOKhgZ+WpTLtOhDH6HUtNXs3ojOpQNpIteW6nyA=; b=oe2vjoiv3R5a4g69SuH10nI2Df
	sl0QauM8PzPNnAcopgBMGZreejs49zlPT39QiboLhWAdiK9Cymkqy8zM1dsF5WuqcF76lK7u4caIy
	YsctiRO62uciwEj024KXoUmI6Hzy8URFWjSswv5zMnFClyic2gh5oW8J07TTFaUYlaZMtSw6p/kvN
	yRmCG2xmec2T0f2pDteYeG2+Asaw0KJTsxuSOhYiXce1o0z7gHeq5vUm+3/VYf40HdXnO33yRPjwy
	FXv2bjrel/mkzL3iP9BzX5jUdYbtz8prsLi5G0+uk/MsNn0jfajzqI01iFBu/0FZdhOlLHkHOhYOB
	WVUTmMHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX56f-00E1ah-69; Tue, 28 Feb 2023 18:53:45 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX56b-00E1aB-Tm
	for kexec@lists.infradead.org; Tue, 28 Feb 2023 18:53:44 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SGwjo8000338;
	Tue, 28 Feb 2023 18:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=b+XA7TvHZ2PCiAFSw/V9KskXuxBA0at3Lkfvm0t5y4sLh1vis6q7yRTms0dJ8wLYF6+o
 zPMsrhXD9lN7cbVxwnNlF6NFplU9x+0gBbwHgzR5wTLleWuf8/Xko5dIpXuYaXu7FXXH
 glxPlW5XLb4YOmf0zqUFfLQaxA7F2l1z8XfFWx1QW28SA/vd1VoakeLvtwGvrChT46XO
 lIFLHVnzp729qbvsQcv/09Fdx+wqr7CazwztneGB7bWr35lbSSjk7QPLY8rf0sl8nckW
 jbYdOnJafJgGDRUBfuPZmoRAPO/ZIAHuE3WeoaBYtICs7+kjXUFYVm81d5XfkkaHAl9A zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakq5sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Feb 2023 18:53:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SI7Mkc015880;
	Tue, 28 Feb 2023 18:53:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7hk83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Feb 2023 18:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzGk98NZP/CyJcM6usnY4EeyAkf2Znaenee5ucLtSrGd4+dq7rO20MGtit2vk/lTB9FexK4novZc5Olxaf1+/MwgPW9HNdzFMgvDsY7hVbCr97glFD5GQvndOZjli+7gNYFfy2bMaqA8OKWPF7BxJTB1wVhMO+G9IE/31balZ1jITy4a85xQhaY96MSbeUM53HM5/a1kSBDDHxQvmyGMRO2VKpFtHQIpEdxRpTVCnDcug7kfifxPd3G/oAnyVQ8MgSj9Ffxm7vGq3tCWPj0d6O++l91lXzxvmSdxsbh5EIVcW66WvBqhSX8TbYFUqFh1H0eNt8glGdBd5fCKymby5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=fmGxMBawzr0lOS/WCA6IcAXfJqPd5pVpbMVqY5XqLg2hJdLl9MNe1Qhrv4Z6OZm77TFBZ3vtfc80nJN0XzOb4A0VTz4Ca8V70aQ6zJHilQyVWmQMK/8xIP/n/WJqvmEatnV+O/wwo/EQ0oCoe+tCn5gBOOVPUncndc6wfjrxXkDGqz+uUFZa0P0bqML8pyg63MHX3aMeBuk/wGeRjjr5g9H706pjDbgeqVixlKQRYJF5fZzC8OD9iXm43ADSNnMk8pfx+eMwvdAHGoEuDfCP/w96NnC1NTIgzmhBerNT4QltAgVjFHgvUT7+0VFonNajbmIkjC+1pF9rsas5EijHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=zLy0cNb2K+qg3WK0sWtuR4oxExbMTxPbTpKbFJ422Im+UV9V40/PjmvfCHYV305QkbI2w/joCdO30HdXPVLk72N9knGJs9ZISAQAYY0JcXI5vX+8JFIVPh6N4hMrqUwuU7qePkLSHVt24a2hp0H9+uYFAv7tR3TjQ5eI8ORy2CQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 18:53:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 18:53:08 +0000
Message-ID: <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
Date: Tue, 28 Feb 2023 12:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx> <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx> <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: c4135e87-014c-4111-58e8-08db19bd0804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	AfBL6xS+YFJkXoKIOOtUuRANYQAs2ztA87jH+AwzNzvzAc4Lfm2JXRvEYMQRekP79vAtQqWTVSv+2GxHVtlxYwJ/t/dMSGEXZyu1vLhiXkwnyWGrRg5VSsSh09HCI+eonr+7W2m0QBhbhb+VYF52w+AZbJA/UzOyNEmImt7+fxfaJTS9139JT7Ag1TGBsZ+upIusfVzs5oNuRQiJJZEMt68vGLALIn7oWQLYsLVcUu/fTfwSIKXuQg7TXExcjBSVrjV4zYCgt1XUhO3oBhLw9MhFKGb0e28IZrv812A4PauWmc2yVGPbO+x/ZmHCQLVAUWfFjCdAVO2nUc3xFcSTa6o0mgO8y3O5aU9Suc9POYSyLmYtI6cSuK3urSBV/87dNeEdK2AFAWgoIHFiBIt0U9O8QzmahP2Ul3hWV/4z7EdXf66SatVcKq8fkDJOK+DvCYSJ5eZxJGvThzYYToB+ITIN/3FQk3fFe66P6wM7ixxFi3TB4BeE1soVv07cnpSlBF3idwUhyxDE9T+OR5SmRKeEAmdZglkNSO9i4dMkEplDPsZPO0/xNPne5oTjeej5e9b9mQY49TWzQtY4qFQjE/aLSYPCUIdbkBkjnjqdv9i8k4YtQjzYXgErAad7QWmZKKU/QQocCuuvFsYQbELWBYY56EWzxnGZzNQoNTH7T+oZhsmMmbc8TWQRdHnQaGKQuzUbY+wEQK7oF4wS9J/ThnBvNF3jhwsaGyDqHvtI4+I=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(346002)(136003)(84040400005)(451199018)(38100700002)(36756003)(31696002)(86362001)(2906002)(30864003)(7416002)(66946007)(66556008)(66476007)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2616005)(6512007)(6506007)(53546011)(186003)(83380400001)(110136005)(478600001)(316002)(107886003)(6666004)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QkluMU0rZDhNTW5DaUlXK3ZncE05RXRhNDhZd1QrQ1B5elYySzFMbTVNOTF5?=
 =?utf-8?B?dVB0K3RKd1RMY2dOblB2UFVhWlIwUS8zNEU1VUxld0ZhSzFuZ1liUUs1WGxu?=
 =?utf-8?B?NHo2NktPcXhIZGs0RmIrU0IzckFKTjNjYnUrQjBKSzdGQW9tRXNsMFdBaFhq?=
 =?utf-8?B?KzR1ZDcyZXFGczE2a01tYWwveGVZeTZIWkUzUjViQnZ1ZUEzK2hmcHZxV0xo?=
 =?utf-8?B?Q05VWU9ZeGNPanFOREhRa29WVkxhWm5KZFRuanZZUHFyV1JlYlFnZnphV1VE?=
 =?utf-8?B?cWRZN0I1VzBEMWhYQXlhZkRVTFFiMzJzWFAvWk5HcUZ1ZHROdlFJOVZLVUZE?=
 =?utf-8?B?SmtBU3VmT3o2eGQ3VXlPMVplM0c3bzJXWEhmWHY5MG0yOXQwL3lkUVFCVzhU?=
 =?utf-8?B?R1BMbDlKMXpsNnVnSFVtdzRBMzZ0b0FjbWppV2xSWlF0aVN4NDJQQkNoOHhQ?=
 =?utf-8?B?TFFFSHp1VGQ3bThnd3oxYTYyNHVoYVIwTGdCRTBteVFDL2FsaTBqR3RodGVI?=
 =?utf-8?B?Ni9mNkh2SG53c25rUHlXZk9tYkpHVWpGQnVyS1p3V2Q4aXJ3bHkyU2xXNWVH?=
 =?utf-8?B?SzFGelQ2RklsU2Fnd2gwNUQyaFRPa0tzSkdrQk9CbnhpL255a2QxUFlBOFhq?=
 =?utf-8?B?MWFsU21UbmdRRzdzbTVXcjdsNnVRWUJvZjZybUtJV3ZiVUpld21QbHZlTkNS?=
 =?utf-8?B?QWdaRitjTHNiaXV1VllRQTNMSmFOZGl5eGl1aXhnUnZLSXdaZkIwbU43ZE5q?=
 =?utf-8?B?N2Z0eFZvK1k5L2R5blFUeHBmekZEK09IYmhxN1VJcldBaGttallCWXkyMk53?=
 =?utf-8?B?Y1NMM2dqZzV4VGpuOVV4SWp1YUVlTml4MWJMWGJNZjRjM1hEdS8rbW5iK3pE?=
 =?utf-8?B?ZmhjTHoyUi9DSE9jbzNZb2F0QUdaQlZNYlJQYkNkUk1PR1ZVemFvU21CWkJ3?=
 =?utf-8?B?UHErVHk3cFlJOG1Qb3VyaE1hdHBKRUE2cXFySGIyM00vV25yaEhFeEVZOHBI?=
 =?utf-8?B?a3E1aVVtZ3ZSVWxBMGZzZ1M0eDZDWWw4blk4N3JONUJiL05qVG5TVjV6Y2Ru?=
 =?utf-8?B?VXlqSmRqR0tWUTVST25MTGg0cU9yaEpSRkduRjV2eXNNaVlZSDFVKzF6SkJZ?=
 =?utf-8?B?dmpEZFBWWHc2UXl1UnNQcGVWcGN1QytMVmp6Z2x0eGJWd3AxeTU2OWphUUFs?=
 =?utf-8?B?T3lxcjA3WG1pOFVsdnZiVWFRbDBMTG9kdVdJSVoyLzg4TlJIbklHL2hJZzVW?=
 =?utf-8?B?VE9yRXRyck5TWWc2ZHlOY1ZJMlNTWnJjMUxxYmM3R1FHNGhybURTelNuRTNL?=
 =?utf-8?B?cm9MK3ZnbVVDTE1kelNEbmlvQ1VFVC9pcEZnRlBLQkVTVG5OTlJYVXhLNGVY?=
 =?utf-8?B?KysyN0RnRmppRGdHaU4xblNUWFhja2FVa0YvMVhQeTg4M1Vudkd1QjEvT1Uy?=
 =?utf-8?B?dzBlM2dvdVVIQ2NTeHRMbDUzR21KbGJzaVk1SlhTbE5PODh3cUN4SUR3R1Ay?=
 =?utf-8?B?ODlyWUxjWUZjZ3ZnaHdlQU5xbERkV0ttWmN1K2JJTWorZnRJa0pRbnY1MXRh?=
 =?utf-8?B?MjNPdFZqM0pJQmtDRVFoVU9STXN3UmhETXR2NmNJU1JLTjc5Y0wrclBXS0hP?=
 =?utf-8?B?cUx1RHE4dzNxV1ZuYzIvUzlSV1E1NlYzekhYcEtEaG5KNnNzeW11LzJKMUpr?=
 =?utf-8?B?MnF4NXFSbEU3UEkrZ2x2elRZeUxiT1Y0TW9PZkJ1ZkVWVHloOWI1WG5NVm13?=
 =?utf-8?B?VytrYWMyVzNRaldrZElqNmhEcG1Na3ovcDhCKzZWOEVncGU2U2hZWkpTNFFN?=
 =?utf-8?B?Slp0Y2drQ3pzM1BYZmF4ZVR6Um16T2FubEtQQUZadXZJOVZocDBZSFFGYUFD?=
 =?utf-8?B?eEY2MEhFaHpzY05hMVAzM1hRbTNJa2ZBdUV1V0s5dmlNZXYzcHdqYkVxS2tq?=
 =?utf-8?B?K1NXYkVQQWpZNFZLdURzTmRsYjVEWVJWRkdaOGVVQUpQSWwzQTE5Z0xNN1dN?=
 =?utf-8?B?UkJKVWRGM1k1b3JHWTJrZVZ4VE4yUTY2R04wMHh0SEp4QWcwazJUeW9JNm9Y?=
 =?utf-8?B?SVAzTFN6TmdKMlJUMmtWQWg0bDRVK294dkdNdldBRHlXcmJqRko0VUcwVEw0?=
 =?utf-8?B?Q0tqZUxNSUhPQkJNSWR0MENGUjRhbTJUUkg2TEcxR1BOa3hLL09uYzdSOThZ?=
 =?utf-8?Q?lCt68hXBCzouLORdTsrp110=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?eUhQTDlOUitUbUlYSGdBYXF6d2twTUdwbWRiSFF2ZTFhMlNDdjBLU0h3M0h0?=
 =?utf-8?B?a2dpVEJCZU96dWYzQlNjZy9oM3ZRVjlKNmdSVExzVHFjWWppQWk0d1YySElE?=
 =?utf-8?B?YU1lTGdFZDJTVDYvdXhlVytGT1dPSTZqV1NjZ211YmRyQnRNdm1nQTZKSTVr?=
 =?utf-8?B?ckRoN0JXdUZZc0RGWFJsRzZNYkFEdGlPMEppY3l1WlpFekh0S09VWTdNNmJj?=
 =?utf-8?B?akNuTTBrQWlsUmliTTVsVCtybEFmMi9BUWxDSEd5a2Fsb3p0dEtuVXlQSmty?=
 =?utf-8?B?NFlMZ1dYTU4va0VEdVV1UWR4cHZPOEs2ZWhwamd4dUpRcGs4ZzNESFRoZXBa?=
 =?utf-8?B?eVJWVGIrVVMxUDc3YWVUWjZGMmhhaGNDVnNvbis3SnNBS0RZZDZhOEVBZVNJ?=
 =?utf-8?B?bzVTMlBpUmt3L0d6ODJzQnk4aDdwdXVCZVB2NE9wQVIrcXEyYk1VZTJIRFZH?=
 =?utf-8?B?bTJJeWsxcm9qdlhabmduVzdjTDY5RExtdTdQNXFtQ3FHR0o3VGQ1SCt6cmxF?=
 =?utf-8?B?UFlHdlJyUjhNbHByS29SaW9UdW8zS0tOOXBXb2k4VUZNd2ZhK2x4UnZOYVZM?=
 =?utf-8?B?SU1HMVZEbCtwdDh0azdQUzIwK1ZTM3RiSC9KSW5xN20yTXJvRTdtWGRFUGNn?=
 =?utf-8?B?eEZERDRBcmtvcTVZbVlpMFdzS0JSUzJ2UnVIQWxJU2ZwVnRSWlRvdFYxQWtO?=
 =?utf-8?B?QklGbnlzYzkzSHd4ejgwSmgzUVdnM2F5MytQT2p3bzZBbXFqMWFRQUJ2ZVB4?=
 =?utf-8?B?djl0UkZpd3hjSjlzTWVqZDVTMzQ2Tm5xV2hiWkRxeEJ2UjR0ZzdWR0FKaUZI?=
 =?utf-8?B?MU9zNGxjWnVJTTc3N25TNS9GdjUvN3dUODFFOGdua0FyTzRXTU1rNWE2K01D?=
 =?utf-8?B?dU5DVlFXUDFhWGpSVDEwRjRMTWllLzZ1SUdLY2hZOFdlUnU2R1hOWTYzeERB?=
 =?utf-8?B?ZVdZTytpVTk5dzVKcWpRK2MrN3drMTFRT1NTVktmUC9RK1pvQnpvcjBaSHNy?=
 =?utf-8?B?VGRwL1hMSDdjaVd4SWxxdHRqeis0ZllkekJRY3QzaWpTci8vUFQ4eDNrSklU?=
 =?utf-8?B?Y1d3dWNDYlluZ1JTdDNKK05IUHlDcEhMaEdmRXphWThvekVKcHo5cW9FWExP?=
 =?utf-8?B?V1F2YWtJK29RL1VxTTMwMWRVRTE3V3FBOGR0Q05ZSVJJcUJHL1FkdnY1cHkz?=
 =?utf-8?B?RGFqWnJmSjdDSFhmTlMvUS93aXE4V3pUUE1QcXIwSHBJVVdmcXMyditxTnlQ?=
 =?utf-8?B?Skx1bnRlTHdCSmZkVCtkcXVaaGk1bHA2RXBIMEsxb2d3Q3JQRU5YSGhwK2J1?=
 =?utf-8?B?aUtONlRYSFBxaWZ0NUZlNjlJV3lnd0JwSnhpd2NrR0U2VDNPK1VKNDVjdUVD?=
 =?utf-8?B?WVVmcXU3ZHFOSEdkbHFVTDYwdzAyeXpHMWxsU1YzQjUweFJSR1BQVFJMTUVZ?=
 =?utf-8?B?ZXNVcWw5MjloaHJ3YzhHOEhLMUQ1eXpqYUNTOE5ZOXhMQnQzMU9QeUZoRUND?=
 =?utf-8?B?QjJWT251SWRuVmlpVlUvcksrQjY0Rmh6SVZ1MWtNeWlOcE5xZFFEclgwUzZn?=
 =?utf-8?Q?LG4GVlI8wXhZGoKYtdN6NhyKk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4135e87-014c-4111-58e8-08db19bd0804
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 18:53:08.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9jEJF26wtr94SUDG0C4xKNLOKopVNUlx7jl7LVJOVDrDsQDKJdonoAMEKOB2glXmeLtMdH8mypHheiAIdTcc86vyDPLAE3sSYgIS+JrIlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_16,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280157
X-Proofpoint-GUID: gKqZUecDUUM3Ceng7Kl860NVmG5nXqYg
X-Proofpoint-ORIG-GUID: gKqZUecDUUM3Ceng7Kl860NVmG5nXqYg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_105342_117160_1D0B6201 
X-CRM114-Status: GOOD (  14.99  )
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

CgpPbiAyLzI4LzIzIDA2OjQ0LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9uIDAyLzEzLzIzIGF0IDEw
OjEwYW0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4KPj4gT24gMTEvMDIvMjMgMDY6MDUsIEVyaWMg
RGVWb2xkZXIgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIvMTAvMjMgMDA6MjksIFNvdXJhYmggSmFp
biB3cm90ZToKPj4+Pgo+Pj4+IE9uIDEwLzAyLzIzIDAxOjA5LCBFcmljIERlVm9sZGVyIHdyb3Rl
Ogo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBPbiAyLzkvMjMgMTI6NDMsIFNvdXJhYmggSmFpbiB3cm90ZToK
Pj4+Pj4+IEhlbGxvIEVyaWMsCj4+Pj4+Pgo+Pj4+Pj4gT24gMDkvMDIvMjMgMjM6MDEsIEVyaWMg
RGVWb2xkZXIgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IE9uIDIvOC8yMyAwNzo0NCwg
VGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4+Pj4+PiBFcmljIQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBP
biBUdWUsIEZlYiAwNyAyMDIzIGF0IDExOjIzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Pj4+Pj4+
Pj4gT24gMi8xLzIzIDA1OjMzLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4gU28gbXkgbGF0ZXN0IHNvbHV0aW9uIGlzIGludHJvZHVjZSB0d28gbmV3IENQVUhQCj4+
Pj4+Pj4+PiBzdGF0ZXMsIENQVUhQX0FQX0VMRkNPUkVIRFJfT05MSU5FCj4+Pj4+Pj4+PiBmb3Ig
b25saW5pbmcgYW5kIENQVUhQX0JQX0VMRkNPUkVIRFJfT0ZGTElORSBmb3IKPj4+Pj4+Pj4+IG9m
ZmxpbmluZy4gSSdtIG9wZW4gdG8gYmV0dGVyIG5hbWVzLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRo
ZSBDUFVIUF9BUF9FTEZDT1JFSERSX09OTElORSBuZWVkcyB0byBiZQo+Pj4+Pj4+Pj4gcGxhY2Vk
IGFmdGVyIENQVUhQX0JSSU5HVVBfQ1BVLiBNeQo+Pj4+Pj4+Pj4gYXR0ZW1wdHMgYXQgbG9jYXRp
bmcgdGhpcyBzdGF0ZSBmYWlsZWQgd2hlbgo+Pj4+Pj4+Pj4gaW5zaWRlIHRoZSBTVEFSVElORyBz
ZWN0aW9uLCBzbyBJIGxvY2F0ZWQKPj4+Pj4+Pj4+IHRoaXMganVzdCBpbnNpZGUgdGhlIE9OTElO
RSBzZWN0b2luLiBUaGUgY3Jhc2gKPj4+Pj4+Pj4+IGhvdHBsdWcgaGFuZGxlciBpcyByZWdpc3Rl
cmVkIG9uCj4+Pj4+Pj4+PiB0aGlzIHN0YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC5zdGFy
dHVwIG1ldGhvZC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGUgQ1BVSFBfQlBfRUxGQ09SRUhEUl9P
RkZMSU5FIG5lZWRzIHRvIGJlCj4+Pj4+Pj4+PiBwbGFjZWQgYmVmb3JlIENQVUhQX1RFQVJET1dO
X0NQVSwgYW5kIEkKPj4+Pj4+Pj4+IHBsYWNlZCBpdCBhdCB0aGUgZW5kIG9mIHRoZSBQUkVQQVJF
IHNlY3Rpb24uCj4+Pj4+Pj4+PiBUaGlzIGNyYXNoIGhvdHBsdWcgaGFuZGxlciBpcyBhbHNvCj4+
Pj4+Pj4+PiByZWdpc3RlcmVkIG9uIHRoaXMgc3RhdGUgYXMgdGhlIGNhbGxiYWNrIGZvciB0aGUg
LnRlYXJkb3duIG1ldGhvZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVEJILCB0aGF0J3Mgc3RpbGwgb3Zl
cmVuZ2luZWVyZWQuIFNvbWV0aGluZyBsaWtlIHRoaXM6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IGJvb2wg
Y3B1X2lzX2FsaXZlKHVuc2lnbmVkIGludCBjcHUpCj4+Pj4+Pj4+IHsKPj4+Pj4+Pj4gIMKgwqDC
oMKgc3RydWN0IGNwdWhwX2NwdV9zdGF0ZSAqc3QgPSBwZXJfY3B1X3B0cigmY3B1aHBfc3RhdGUs
IGNwdSk7Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICDCoMKgwqDCoHJldHVybiBkYXRhX3JhY2Uoc3QtPnN0
YXRlKSA8PSBDUFVIUF9BUF9JRExFX0RFQUQ7Cj4+Pj4+Pj4+IH0KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
YW5kIHVzZSB0aGlzIHRvIHF1ZXJ5IHRoZSBhY3R1YWwgc3RhdGUgYXQgY3Jhc2gKPj4+Pj4+Pj4g
dGltZS4gVGhhdCBzcGFyZXMgYWxsCj4+Pj4+Pj4+IHRob3NlIGNhbGxiYWNrIGhldXJpc3RpY3Mu
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJJ20gbWFraW5nIG15IHdheSB0aG91Z2ggcGVyY3B1IGNyYXNo
X25vdGVzLAo+Pj4+Pj4+Pj4gZWxmY29yZWhkciwgdm1jb3JlaW5mbywKPj4+Pj4+Pj4+IG1ha2Vk
dW1wZmlsZSBhbmQgKHRoZSBjb25zdW1lciBvZiBpdCBhbGwpIHRoZQo+Pj4+Pj4+Pj4gdXNlcnNw
YWNlIGNyYXNoIHV0aWxpdHksCj4+Pj4+Pj4+PiBpbiBvcmRlciB0byB1bmRlcnN0YW5kIHRoZSBp
bXBhY3Qgb2YgbW92aW5nIGZyb20KPj4+Pj4+Pj4+IGZvcl9lYWNoX3ByZXNlbnRfY3B1KCkKPj4+
Pj4+Pj4+IHRvIGZvcl9lYWNoX29ubGluZV9jcHUoKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSXMgdGhl
IHBhY2tpbmcgYWN0dWFsbHkgd29ydGggdGhlIHRyb3VibGU/IFdoYXQncyB0aGUgYWN0dWFsIHdp
bj8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhhbmtzLAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgwqDCoMKgwqDC
oMKgwqDCoCB0Z2x4Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBUaG9tYXMsCj4+
Pj4+Pj4gSSd2ZSBpbnZlc3RpZ2F0ZWQgdGhlIHBhc3Npbmcgb2YgY3Jhc2ggbm90ZXMgdGhyb3Vn
aCB0aGUKPj4+Pj4+PiB2bWNvcmUuIFdoYXQgSSd2ZSBsZWFybmVkIGlzIHRoYXQ6Cj4+Pj4+Pj4K
Pj4+Pj4+PiAtIGxpbnV4L2ZzL3Byb2Mvdm1jb3JlLmMgKHdoaWNoIG1ha2VkdW1wZmlsZSByZWZl
cmVuY2VzCj4+Pj4+Pj4gdG8gZG8gaXRzIGpvYikgZG9lcwo+Pj4+Pj4+ICDCoCBub3QgY2FyZSB3
aGF0IHRoZSBjb250ZW50cyBvZiBjcHUgUFRfTk9URVMgYXJlLCBidXQgaXQKPj4+Pj4+PiBkb2Vz
IGNvYWxlc2NlIHRoZW0gdG9nZXRoZXIuCj4+Pj4+Pj4KPj4+Pj4+PiAtIG1ha2VkdW1wZmlsZSB3
aWxsIGNvdW50IHRoZSBudW1iZXIgb2YgY3B1IFBUX05PVEVTIGluCj4+Pj4+Pj4gb3JkZXIgdG8g
ZGV0ZXJtaW5lIGl0cwo+Pj4+Pj4+ICDCoCBucl9jcHVzIHZhcmlhYmxlLCB3aGljaCBpcyByZXBv
cnRlZCBpbiBhIGhlYWRlciwgYnV0Cj4+Pj4+Pj4gb3RoZXJ3aXNlIHVudXNlZCAoZXhjZXB0Cj4+
Pj4+Pj4gIMKgIGZvciBzYWR1bXAgbWV0aG9kKS4KPj4+Pj4+Pgo+Pj4+Pj4+IC0gdGhlIGNyYXNo
IHV0aWxpdHksIGZvciB0aGUgcHVycG9zZXMgb2YgZGV0ZXJtaW5pbmcgdGhlCj4+Pj4+Pj4gY3B1
cywgZG9lcyBub3QgYXBwZWFyIHRvCj4+Pj4+Pj4gIMKgIHJlZmVyZW5jZSB0aGUgZWxmY29yZWhk
ciBQVF9OT1RFcy4gSW5zdGVhZCBpdCBsb2NhdGVzIHRoZSB2YXJpb3VzCj4+Pj4+Pj4gIMKgIGNw
dV9bcG9zc2libGV8cHJlc2VudHxvbmxpbmVdX21hc2sgYW5kIGNvbXB1dGVzCj4+Pj4+Pj4gbnJf
Y3B1cyBmcm9tIHRoYXQsIGFuZCBhbHNvIG9mCj4+Pj4+Pj4gIMKgIGNvdXJzZSB3aGljaCBhcmUg
b25saW5lLiBJbiBhZGRpdGlvbiwgd2hlbiBjcmFzaCBkb2VzCj4+Pj4+Pj4gcmVmZXJlbmNlIHRo
ZSBjcHUgUFRfTk9URSwKPj4+Pj4+PiAgwqAgdG8gZ2V0IGl0cyBwcnN0YXR1cywgaXQgZG9lcyBz
byBieSB1c2luZyBhIHBlcmNwdQo+Pj4+Pj4+IHRlY2huaXF1ZSBkaXJlY3RseSBpbiB0aGUgdm1j
b3JlCj4+Pj4+Pj4gIMKgIGltYWdlIG1lbW9yeSwgbm90IHZpYSB0aGUgRUxGIHN0cnVjdHVyZS4g
U2FpZAo+Pj4+Pj4+IGRpZmZlcmVudGx5LCBpdCBhcHBlYXJzIHRvIG1lIHRoYXQKPj4+Pj4+PiAg
wqAgY3Jhc2ggdXRpbGl0eSBkb2Vzbid0IHJlbHkgb24gdGhlIEVMRiBQVF9OT1RFcyBmb3IKPj4+
Pj4+PiBjcHVzOyByYXRoZXIgaXQgb2J0YWlucyB0aGVtCj4+Pj4+Pj4gIMKgIHZpYSBrZXJuZWwg
Y3B1bWFza3MgYW5kIHRoZSBtZW1vcnkgd2l0aGluIHRoZSB2bWNvcmUuCj4+Pj4+Pj4KPj4+Pj4+
PiBXaXRoIHRoaXMgdW5kZXJzdGFuZGluZywgSSBkaWQgc29tZSB0ZXN0aW5nLiBQZXJoYXBzIHRo
ZQo+Pj4+Pj4+IG1vc3QgdGVsbGluZyB0ZXN0IHdhcyB0aGF0IEkKPj4+Pj4+PiBjaGFuZ2VkIHRo
ZSBudW1iZXIgb2YgY3B1IFBUX05PVEVzIGVtaXR0ZWQgaW4gdGhlCj4+Pj4+Pj4gY3Jhc2hfcHJl
cGFyZV9lbGY2NF9oZWFkZXJzKCkgdG8ganVzdCAxLAo+Pj4+Pj4+IGhvdCBwbHVnZ2VkIHNvbWUg
Y3B1cywgdGhlbiBhbHNvIHRvb2sgYSBmZXcgb2ZmbGluZQo+Pj4+Pj4+IHNwYXJzZWx5IHZpYSBj
aGNwdSwgdGhlbiBnZW5lcmF0ZWQgYQo+Pj4+Pj4+IHZtY29yZS4gVGhlIGNyYXNoIHV0aWxpdHkg
aGFkIG5vIHByb2JsZW0gbG9hZGluZyB0aGUKPj4+Pj4+PiB2bWNvcmUsIGl0IHJlcG9ydGVkIHRo
ZSBwcm9wZXIgbnVtYmVyCj4+Pj4+Pj4gb2YgY3B1cyBhbmQgdGhlIG51bWJlciBvZmZsaW5lIChk
ZXNwaXRlIG9ubHkgb25lIGNwdQo+Pj4+Pj4+IFBUX05PVEUpLCBhbmQgY2hhbmdpbmcgdG8gYSBk
aWZmZXJlbnQKPj4+Pj4+PiBjcHUgdmlhICdzZXQgLWMgMzAnIGFuZCB0aGUgYmFja3RyYWNlIHdh
cyBjb21wbGV0ZWx5IHZhbGlkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gTXkgdGFrZSBhd2F5IGlzIHRoYXQg
Y3Jhc2ggdXRpbGl0eSBkb2VzIG5vdCByZWx5IHVwb24KPj4+Pj4+PiBFTEYgY3B1IFBUX05PVEVz
LCBpdCBvYnRhaW5zIHRoZQo+Pj4+Pj4+IGNwdSBpbmZvcm1hdGlvbiBkaXJlY3RseSBmcm9tIGtl
cm5lbCBkYXRhIHN0cnVjdHVyZXMuCj4+Pj4+Pj4gUGVyaGFwcyBhdCBvbmUgdGltZSBjcmFzaCBy
ZWxpZWQKPj4+Pj4+PiB1cG9uIHRoZSBFTEYgaW5mb3JtYXRpb24sIGJ1dCBubyBtb3JlLiAoUGVy
aGFwcyB0aGVyZQo+Pj4+Pj4+IGFyZSBvdGhlciBjcmFzaCBkdW1wIGFuYWx5emVycwo+Pj4+Pj4+
IHRoYXQgbWlnaHQgcmVseSBvbiB0aGUgRUxGIGluZm8/KQo+Pj4+Pj4+Cj4+Pj4+Pj4gU28sIGFs
bCB0aGlzIHRvIHNheSB0aGF0IEkgc2VlIG5vIG5lZWQgdG8gY2hhbmdlCj4+Pj4+Pj4gY3Jhc2hf
cHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkuIFRoZXJlCj4+Pj4+Pj4gaXMgbm8gY29tcGVsbGluZyBy
ZWFzb24gdG8gbW92ZSBhd2F5IGZyb20KPj4+Pj4+PiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpLCBv
ciBtb2RpZnkgdGhlIGxpc3QgZm9yCj4+Pj4+Pj4gb25saW5lL29mZmxpbmUuCj4+Pj4+Pj4KPj4+
Pj4+PiBXaGljaCB0aGVuIGxlYXZlcyB0aGUgdG9waWMgb2YgdGhlIGNwdWhwIHN0YXRlIG9uIHdo
aWNoCj4+Pj4+Pj4gdG8gcmVnaXN0ZXIuIFBlcmhhcHMgcmV2ZXJ0aW5nCj4+Pj4+Pj4gYmFjayB0
byB0aGUgdXNlIG9mIENQVUhQX0JQX1BSRVBBUkVfRFlOIGlzIHRoZSByaWdodAo+Pj4+Pj4+IGFu
c3dlci4gVGhlcmUgZG9lcyBub3QgYXBwZWFyIHRvCj4+Pj4+Pj4gYmUgYSBjb21wZWxsaW5nIG5l
ZWQgdG8gYWNjdXJhdGVseSB0cmFjayB3aGV0aGVyIHRoZSBjcHUKPj4+Pj4+PiB3ZW50IG9ubGlu
ZS9vZmZsaW5lIGZvciB0aGUKPj4+Pj4+PiBwdXJwb3NlcyBvZiBjcmVhdGluZyB0aGUgZWxmY29y
ZWhkciwgYXMgdWx0aW1hdGVseSB0aGUKPj4+Pj4+PiBjcmFzaCB1dGlsaXR5IHB1bGxzIHRoYXQg
ZnJvbQo+Pj4+Pj4+IGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMsIG5vdCB0aGUgZWxmY29yZWhkci4K
Pj4+Pj4+Pgo+Pj4+Pj4+IEkgdGhpbmsgdGhpcyBpcyB3aGF0IFNvdXJhYmggaGFzIGtub3duIGFu
ZCBoYXMgYmVlbgo+Pj4+Pj4+IGFkdm9jYXRpbmcgZm9yIGFuIG9wdGltaXphdGlvbgo+Pj4+Pj4+
IHBhdGggdGhhdCBhbGxvd3Mgbm90IHJlZ2VuZXJhdGluZyB0aGUgZWxmY29yZWhkciBvbiBjcHUK
Pj4+Pj4+PiBjaGFuZ2VzIChiZWNhdXNlIGFsbCB0aGUgcGVyY3B1Cj4+Pj4+Pj4gc3RydWN0cyBh
cmUgYWxsIGxhaWQgb3V0KS4gSSBkbyB0aGluayBpdCBiZXN0IHRvIGxlYXZlCj4+Pj4+Pj4gdGhh
dCBhcyBhbiBhcmNoIGNob2ljZS4KPj4+Pj4+Cj4+Pj4+PiBTaW5jZSB0aGluZ3MgYXJlIGNsZWFy
IG9uIGhvdyB0aGUgUFRfTk9URVMgYXJlIGNvbnN1bWVkIGluCj4+Pj4+PiBrZHVtcCBrZXJuZWwg
W2ZzL3Byb2Mvdm1jb3JlLmNdLAo+Pj4+Pj4gbWFrZWR1bXBmaWxlLCBhbmQgY3Jhc2ggdG9vbCBJ
IG5lZWQgeW91ciBvcGluaW9uIG9uIHRoaXM6Cj4+Pj4+Pgo+Pj4+Pj4gRG8gd2UgcmVhbGx5IG5l
ZWQgdG8gcmVnZW5lcmF0ZSBlbGZjb3JlaGRyIGZvciBDUFUgaG90cGx1ZyBldmVudHM/Cj4+Pj4+
PiBJZiB5ZXMsIGNhbiB5b3UgcGxlYXNlIGxpc3QgdGhlIGVsZmNvcmVoZHIgY29tcG9uZW50cyB0
aGF0Cj4+Pj4+PiBjaGFuZ2VzIGR1ZSB0byBDUFUgaG90cGx1Zy4KPj4+Pj4gRHVlIHRvIHRoZSB1
c2Ugb2YgZm9yX2VhY2hfcHJlc2VudF9jcHUoKSwgaXQgaXMgcG9zc2libGUgZm9yIHRoZQo+Pj4+
PiBudW1iZXIgb2YgY3B1IFBUX05PVEVzCj4+Pj4+IHRvIGZsdWN0dWF0ZSBhcyBjcHVzIGFyZSB1
bi9wbHVnZ2VkLiBPbmxpbmluZy9vZmZsaW5pbmcgb2YgY3B1cwo+Pj4+PiBkb2VzIG5vdCBpbXBh
Y3QgdGhlCj4+Pj4+IG51bWJlciBvZiBjcHUgUFRfTk9URXMgKGFzIHRoZSBjcHVzIGFyZSBzdGls
bCBwcmVzZW50KS4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiAgwqBGcm9tIHdoYXQgSSB1bmRlcnN0b29k
LCBjcmFzaCBub3RlcyBhcmUgcHJlcGFyZWQgZm9yCj4+Pj4+PiBwb3NzaWJsZSBDUFVzIGFzIHN5
c3RlbSBib290cyBhbmQKPj4+Pj4+IGNvdWxkIGJlIHVzZWQgdG8gY3JlYXRlIGEgUFRfTk9URSBz
ZWN0aW9uIGZvciBlYWNoIHBvc3NpYmxlCj4+Pj4+PiBDUFUgd2hpbGUgZ2VuZXJhdGluZyB0aGUg
ZWxmY29yZWhkcgo+Pj4+Pj4gZHVyaW5nIHRoZSBrZHVtcCBrZXJuZWwgbG9hZC4KPj4+Pj4+Cj4+
Pj4+PiBOb3cgb25jZSB0aGUgZWxmY29yZWhkciBpcyBsb2FkZWQgd2l0aCBQVF9OT1RFcyBmb3Ig
ZXZlcnkKPj4+Pj4+IHBvc3NpYmxlIENQVSB0aGVyZSBpcyBubyBuZWVkIHRvCj4+Pj4+PiByZWdl
bmVyYXRlIGl0IGZvciBDUFUgaG90cGx1ZyBldmVudHMuIE9yIGRvIHdlPwo+Pj4+Pgo+Pj4+PiBG
b3Igb25saW5pbmcvb2ZmbGluaW5nIG9mIGNwdXMsIHRoZXJlIGlzIG5vIG5lZWQgdG8gcmVnZW5l
cmF0ZQo+Pj4+PiB0aGUgZWxmY29yZWhkci4gSG93ZXZlciwKPj4+Pj4gZm9yIGFjdHVhbCBob3Qg
dW4vcGx1ZyBvZiBjcHVzLCB0aGUgYW5zd2VyIGlzIHllcyBkdWUgdG8KPj4+Pj4gZm9yX2VhY2hf
cHJlc2VudF9jcHUoKS4gVGhlCj4+Pj4+IGNhdmVhdCBoZXJlIG9mIGNvdXJzZSBpcyB0aGF0IGlm
IGNyYXNoIHV0aWxpdHkgaXMgdGhlIG9ubHkKPj4+Pj4gY29yZWR1bXAgYW5hbHl6ZXIgb2YgY29u
Y2VybiwKPj4+Pj4gdGhlbiBpdCBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlc2UgY3B1IFBUX05PVEVz
IGFuZCB0aGVyZSB3b3VsZCBiZQo+Pj4+PiBubyBuZWVkIHRvIHJlLWdlbmVyYXRlIHRoZW0uCj4+
Pj4+Cj4+Pj4+IEFsc28sIEknbSBub3Qgc3VyZSBpZiBBUk0gY3B1IGhvdHBsdWcsIHdoaWNoIGlz
IGp1c3Qgbm93IGNvbWluZwo+Pj4+PiBpbnRvIG1haW5zdHJlYW0sIGltcGFjdHMKPj4+Pj4gYW55
IG9mIHRoaXMuCj4+Pj4+Cj4+Pj4+IFBlcmhhcHMgdGhlIG9uZSBpdGVtIHRoYXQgbWlnaHQgaGVs
cCBoZXJlIGlzIHRvIGRpc3Rpbmd1aXNoCj4+Pj4+IGJldHdlZW4gYWN0dWFsIGhvdCB1bi9wbHVn
IG9mCj4+Pj4+IGNwdXMsIHZlcnN1cyBvbmxpbmluZy9vZmZsaW5pbmcuIEF0IHRoZSBtb21lbnQs
IEkgY2FuIG5vdAo+Pj4+PiBkaXN0aW5ndWlzaCBiZXR3ZWVuIGEgaG90IHBsdWcKPj4+Pj4gZXZl
bnQgYW5kIGFuIG9ubGluZSBldmVudCAoYW5kIHVucGx1Zy9vZmZsaW5lKS4gSWYgdGhvc2Ugd2Vy
ZQo+Pj4+PiBkaXN0aW5ndWlzaGFibGUsIHRoZW4gd2UKPj4+Pj4gY291bGQgb25seSByZWdlbmVy
YXRlIG9uIHVuL3BsdWcgZXZlbnRzLgo+Pj4+Pgo+Pj4+PiBPciBwZXJoYXBzIG1vdmluZyB0byBm
b3JfZWFjaF9wb3NzaWJsZV9jcHUoKSBpcyB0aGUgYmV0dGVyIGNob2ljZT8KPj4+Pgo+Pj4+IFll
cywgYmVjYXVzZSBvbmNlIGVsZmNvcmVoZHIgaXMgYnVpbHQgd2l0aCBwb3NzaWJsZSBDUFVzIHdl
IGRvbid0Cj4+Pj4gaGF2ZSB0byB3b3JyeSBhYm91dAo+Pj4+IGhvdFt1bl1wbHVnIGNhc2UuCj4+
Pj4KPj4+PiBIZXJlIGlzIG15IHZpZXcgb24gaG93IHRoaW5ncyBzaG91bGQgYmUgaGFuZGxlZCBp
ZiBhIGNvcmUtZHVtcAo+Pj4+IGFuYWx5emVyIGlzIGRlcGVuZGVudCBvbgo+Pj4+IGVsZmNvcmVo
ZHIgUFRfTk9URXMgdG8gZmluZCBvbmxpbmUvb2ZmbGluZSBDUFVzLgo+Pj4+Cj4+Pj4gQSBQVF9O
T1RFIGluIGVsZmNvcmVoZHIgaG9sZHMgdGhlIGFkZHJlc3Mgb2YgdGhlIGNvcnJlc3BvbmRpbmcg
Y3Jhc2gKPj4+PiBub3RlcyAoa2VybmVsIGhhcwo+Pj4+IG9uZSBjcmFzaCBub3RlIHBlciBDUFUg
Zm9yIGV2ZXJ5IHBvc3NpYmxlIENQVSkuIFRob3VnaCB0aGUgY3Jhc2gKPj4+PiBub3RlcyBhcmUg
YWxsb2NhdGVkCj4+Pj4gZHVyaW5nIHRoZSBib290IHRpbWUgdGhleSBhcmUgcG9wdWxhdGVkIHdo
ZW4gdGhlIHN5c3RlbSBpcyBvbiB0aGUKPj4+PiBjcmFzaCBwYXRoLgo+Pj4+Cj4+Pj4gVGhpcyBp
cyBob3cgY3Jhc2ggbm90ZXMgYXJlIHBvcHVsYXRlZCBvbiBQb3dlclBDIGFuZCBJIGFtIGV4cGVj
dGluZwo+Pj4+IGl0IHdvdWxkIGJlIHNvbWV0aGluZwo+Pj4+IHNpbWlsYXIgb24gb3RoZXIgYXJj
aGl0ZWN0dXJlcyB0b28uCj4+Pj4KPj4+PiBUaGUgY3Jhc2hpbmcgQ1BVIHNlbmRzIElQSSB0byBl
dmVyeSBvdGhlciBvbmxpbmUgQ1BVIHdpdGggYSBjYWxsYmFjawo+Pj4+IGZ1bmN0aW9uIHRoYXQg
dXBkYXRlcyB0aGUKPj4+PiBjcmFzaCBub3RlcyBvZiB0aGF0IHNwZWNpZmljIENQVS4gT25jZSB0
aGUgSVBJIGNvbXBsZXRlcyB0aGUKPj4+PiBjcmFzaGluZyBDUFUgdXBkYXRlcyBpdHMgb3duIGNy
YXNoCj4+Pj4gbm90ZSBhbmQgcHJvY2VlZHMgZnVydGhlci4KPj4+Pgo+Pj4+IFRoZSBjcmFzaCBu
b3RlcyBvZiBDUFVzIHJlbWFpbiB1bmluaXRpYWxpemVkIGlmIHRoZSBDUFVzIHdlcmUKPj4+PiBv
ZmZsaW5lIG9yIGhvdCB1bnBsdWdnZWQgYXQgdGhlIHRpbWUKPj4+PiBzeXN0ZW0gY3Jhc2guIFRo
ZSBjb3JlLWR1bXAgYW5hbHl6ZXIgc2hvdWxkIGJlIGFibGUgdG8gaWRlbnRpZnkKPj4+PiBbdW5d
L2luaXRpYWxpemVkIGNyYXNoIG5vdGVzCj4+Pj4gYW5kIGRpc3BsYXkgdGhlIGluZm9ybWF0aW9u
IGFjY29yZGluZ2x5Lgo+Pj4+Cj4+Pj4gVGhvdWdodHM/Cj4+Pj4KPj4+PiAtIFNvdXJhYmgKPj4+
Cj4+PiBJbiBnZW5lcmFsLCBJIGFncmVlIHdpdGggeW91ciBwb2ludHMuIFlvdSd2ZSBwcmVzZW50
ZWQgYSBzdHJvbmcgY2FzZSB0bwo+Pj4gZ28gd2l0aCBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoKSBp
biBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKSBhbmQKPj4+IHRob3NlIGNyYXNoIG5vdGVz
IHdvdWxkIGFsd2F5cyBiZSBwcmVzZW50LCBhbmQgd2UgY2FuIGlnbm9yZSBjaGFuZ2VzIHRvCj4+
PiBjcHVzIHdydC8gZWxmY29yZWhkciB1cGRhdGVzLgo+Pj4KPj4+IEJ1dCB3aGF0IGRvIHdlIGRv
IGFib3V0IGtleGVjX2xvYWQoKSBzeXNjYWxsPyBUaGUgd2F5IHRoZSB1c2Vyc3BhY2UKPj4+IHV0
aWxpdHkgd29ya3MgaXMgaXQgZGV0ZXJtaW5lcyBjcHVzIGJ5Ogo+Pj4gIMKgbnJfY3B1cyA9IHN5
c2NvbmYoX1NDX05QUk9DRVNTT1JTX0NPTkYpOwo+Pj4gd2hpY2ggaXMgbm90IHRoZSBlcXVpdmFs
ZW50IG9mIHBvc3NpYmxlX2NwdXMuIFNvIHRoZSBjb21wbGV0ZSBsaXN0IG9mCj4+PiBjcHUgUFRf
Tk9URXMgaXMgbm90IGdlbmVyYXRlZCB1cCBmcm9udC4gV2Ugd291bGQgbmVlZCBhIHNvbHV0aW9u
IGZvcgo+Pj4gdGhhdD8KPj4gSGVsbG8gRXJpYywKPj4KPj4gVGhlIHN5c2NvbmYgZG9jdW1lbnQg
c2F5cyBfU0NfTlBST0NFU1NPUlNfQ09ORiBpcyBwcm9jZXNzb3JzIGNvbmZpZ3VyZWQsCj4+IGlz
bid0IHRoYXQgZXF1aXZhbGVudCB0byBwb3NzaWJsZSBDUFVzPwo+Pgo+PiBXaGF0IGV4YWN0bHkg
c3lzY29uZihfU0NfTlBST0NFU1NPUlNfQ09ORikgcmV0dXJucyBvbiB4ODY/IElJVUMsIG9uIHBv
d2VyUEMKPj4gaXQgaXMgcG9zc2libGUgQ1BVcy4KPiAKQmFvcXVhbiwKCj4gIEZyb20gc3lzY29u
ZiBtYW4gcGFnZSwgd2l0aCBteSB1bmRlcnN0YW5kaW5nLCBfU0NfTlBST0NFU1NPUlNfQ09ORiBp
cwo+IHJldHVybmluZyB0aGUgcG9zc2libGUgY3B1cywgd2hpbGUgX1NDX05QUk9DRVNTT1JTX09O
TE4gcmV0dXJucyBwcmVzZW50Cj4gY3B1cy4gSWYgdGhlc2UgYXJlIHRydWUsIHdlIGNhbiB1c2Ug
dGhlbS4KClRob21hcyBHbGVpeG5lciBoYXMgcG9pbnRlZCBvdXQgdGhhdDoKCiAgZ2xpYmMgdHJp
ZXMgdG8gZXZhbHVhdGUgdGhhdCBpbiB0aGUgZm9sbG93aW5nIG9yZGVyOgogICAxKSAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHUqCiAgICAgIFRoYXQncyBwcmVzZW50IENQVXMgbm90IHBvc3Np
YmxlIENQVXMKICAgMikgL3Byb2Mvc3RhdAogICAgICBUaGF0J3Mgb25saW5lIENQVXMKICAgMykg
c2NoZWRfZ2V0YWZmaW5pdHkoKQogICAgICBUaGF0J3Mgb25saW5lIENQVXMgYXQgYmVzdC4gSW4g
dGhlIHdvcnN0IGNhc2UgaXQncyBhbiBhZmZpbml0eSBtYXNrCiAgICAgIHdoaWNoIGlzIHNldCBv
biBhIHByb2Nlc3MgZ3JvdXAKCm1lYW5pbmcgdGhhdCBfU0NfTlBST0NFU1NPUlNfQ09ORiBpcyBu
b3QgZXF1aXZhbGVudCB0byBwb3NzaWJsZV9jcHVzKCkuIEZ1cnRoZXJtb3JlLCB0aGUgCi9zeXMv
c3lzdGVtL2RldmljZXMvY3B1cy9jcHVYWCBlbnRyaWVzIGFyZSBub3QgYXZhaWxhYmxlIGZvciBu
b3QtcHJlc2VudC1idXQtcG9zc2libGUgY3B1czsgdGh1cyAKdXNlcnNwYWNlIGtleGVjIHV0aWxp
dHkgY2FuIG5vdCB3cml0ZSBvdXQgdGhlIGVsZmNvcmVoZHIgd2l0aCBhbGwgcG9zc2libGUgY3B1
cyBsaXN0ZWQuCgo+IAo+IEJ1dCBJIGFtIHdvbmRlcmluZyB3aHkgdGhlIGV4aXN0aW5nIHByZXNl
bnQgY3B1IHdheSBpcyBnb2luZyB0byBiZQo+IGRpc2NhcmRlZC4gU29ycnksIEkgdHJpZWQgdG8g
Z28gdGhyb3VnaCB0aGlzIHRocmVhZCwgaXQncyB0b28gbG9uZywgY2FuCj4gYW55b25lIHN1bW1h
cml6ZSB0aGUgcmVhc29uIHdpdGggc2hvcnRlciBhbmQgY2xlYXIgc2VudGVuY2VzLiBTb3JyeQo+
IGFnYWluIGZvciB0aGF0LgoKQnkgdXRpbGl6aW5nIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgpIGlu
IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpLCBpbiB0aGUgY2FzZSBvZiB0aGUgCmtleGVj
X2ZpbGVfbG9hZCgpLCB0aGlzIGNoYW5nZSB3b3VsZCBzaW1wbGlmeSBzb21lIGlzc3VlcyBTb3Vy
YWJoIGhhcyBlbmNvdW50ZXJlZCBmb3IgUFBDIHN1cHBvcnQuIApJdCB3b3VsZCBhbHNvIGVuYWJs
ZSBhbiBvcHRpbWl6YXRpb24gdGhhdCBwZXJtaXRzIE5PVCByZS1nZW5lcmF0aW5nIHRoZSBlbGZj
b3JlaGRyIG9uIGNwdSBjaGFuZ2VzLCAKYXMgYWxsIHRoZSBbcG9zc2libGVdIGNwdXMgYXJlIGFs
cmVhZHkgZGVzY3JpYmVkIGluIHRoZSBlbGZjb3JlaGRyLgoKSSd2ZSBwb2ludGVkIG91dCB0aGF0
IHRoaXMgY2hhbmdlIHdvdWxkIGhhdmUga2V4ZWNfbG9hZCAoYXMga2V4ZWMtdG9vbHMgY2FuIG9u
bHkgd3JpdGUgb3V0LCAKaW5pdGlhbGx5LCB0aGUgcHJlc2VudF9jcHVzKCkpIGluaXRpYWxseSBk
ZXZpYXRlIGZyb20ga2V4ZWNfZmlsZV9sb2FkICh3aGljaCB3b3VsZCBub3cgd3JpdGUgb3V0IHRo
ZSAKcG9zc2libGVfY3B1cygpKS4gVGhpcyBkZXZpYXRpb24gd291bGQgZGlzYXBwZWFyIGFmdGVy
IHRoZSBmaXJzdCBob3RwbHVnIGV2ZW50IChkdWUgdG8gY2FsbGluZyAKY3Jhc2hfcHJlcGFyZV9l
bGY2NF9oZWFkZXJzKCkpLiBPciBJJ3ZlIHByb3ZpZGVkIGEgc2ltcGxlIHdheSBmb3Iga2V4ZWNf
bG9hZCB0byByZXdyaXRlIGl0cyAKZWxmY29yZWhkciB1cG9uIGluaXRpYWwgbG9hZCAoYnkgY2Fs
bGluZyBpbnRvIHRoZSBjcmFzaCBob3RwbHVnIGhhbmRsZXIpLgoKQ2FuIHlvdSB0aGluayBvZiBh
bnkgc2lkZSBlZmZlY3RzIG9mIGdvaW5nIHRvIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgpPwoKVGhh
bmtzLAplcmljCgoKPiAKPj4KPj4gSW4gY2FzZSBzeXNjb25mKF9TQ19OUFJPQ0VTU09SU19DT05G
KSBpcyBub3QgY29uc2lzdGVudCB0aGVuIHdlIGNhbiBnbyB3aXRoOgo+PiAvc3lzL2RldmljZXMv
c3lzdGVtL2NwdS9wb3NzaWJsZSBmb3Iga2V4ZWNfbG9hZCBjYXNlLgo+Pgo+PiBUaG91Z2h0cz8K
Pj4KPj4gLSBTb3VyYWJoIEphaW4KPj4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
