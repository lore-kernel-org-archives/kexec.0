Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BD9C61DA4
	for <kexec@archiver.kernel.org>; Thu, 23 Feb 2023 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmtvVipJ1U+KKSKfdcalcQzOyQzRFRUwGcgyR17Uj7g=; b=IH/LhIezQ6WcvT9r4TOEaIrpME
	Rn93sehPAFaAZqKV3IookdLaiDKVX4hFG5ggQFLV4u2WOEkRcArjeWRGuaO5avJxPCgKFIf+zhAzx
	azpugskgEZRQh2sTVJX0olH91UP+AcTS9RMg03FyXQrhbAorOYMS2YoyFQQOVHWvHxcnUFPyNj9Vz
	M6ppsQquvuEuwbn6UYHTQperSPr4jVcrS4OLbBdGv7JE52VMMFW6c7iY8n6udvS/IP5kVgrnmOxLP
	FDrQu5MXby56UasYyGrAHSXecEVV/cjP3hnaBz1IrGq+xtGm+A8H4x8rrGpLNgh3EpQIpK6Z7pGAn
	3Iy0zpPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVIJ1-000Hqw-2t; Thu, 23 Feb 2023 20:35:07 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVIIw-000Hp5-EZ
	for kexec@lists.infradead.org; Thu, 23 Feb 2023 20:35:04 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHsxea029272;
	Thu, 23 Feb 2023 20:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=Kp1tsRAdjr90PokaGQpBM1E8Psyi13T9ZIEWcsf1s3g6n0x8/i7vn4zPsjY3XtaD+Wvh
 DNUN89CZzZ9SjRAlWOfxB/Oz2lGML1LAR6mItBLqM3+JHeK0mmLUUbBOq4oCFQ8n6zxT
 upC2+FoeS1PaVQCivYt7QqmOjRH6ytS5kZol39/tuqnpd5RRVlv20PKDXOIogy9L5ymR
 DQGd0jFgBhFLueKPlj7iMVu2BrJUiRbBvdEE6u5foAomIUfkdDJFj1pnwsDEIEktBEcI
 j5Afjh+OBvJh6zOSrmB1dEfum108bCxi2Ej/pO866r0rbYuBYGCgO3zrJNs+FYMZ6JG8 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbug21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Feb 2023 20:34:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NKBBs0013497;
	Thu, 23 Feb 2023 20:34:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4f5u11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Feb 2023 20:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzu5yYL+Xe4GmnfgwzcAFOCxZf0NKtqWCP+ET9mfF2PPJNEpql0IJdvES6AgZq8fNC4U50dZ20GbIk17Bs7ZXTBg2jsW7jWZsXqqXeC25cFtpGzloSNOQurFpcF+e/OALoY+9406vAUte7muNIWJvljO+9nN9X81eYaDmX9DnqQmz1HdrrCJx3LON+M51/meqNNwm1nPkJC1v72rwkfHOvi3B1MOvVkhEw/EDk+3JLNyxW8oY3Z/p4Gq6zrTo9P6eC91/r1GB/MN46EL/IkoRuCHLr9UxIQwaEWpAAWMJm7sF4QEj8g83x7EpLYSWpPcBs4d9N5hDLt8Kn6vOc49iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=azFU5mPQFXtvfSWyKH/v2Fj51iHcTTAbdkYAA8lqWqAwmJzcomda2OYk6RYaUm8gTXrUTroTnggcd8tYtSO6hEgHR3sVd2wxNCFhsOFZ5FZPR39LWvZrO68dav/jBLtO4ZnJDFv7cnNJRG3gcE4nUFc/HUeJfD/2GDssfQKCm4ZssMlpG34djlAONa6sI0WFXMbVgavdlrQTfuC3I12Xf6rhU+sMXSOz23I7PQO2cDswoN3QjnxMlTKC44cmvxaQosdjMHaDvTHf6J4j8O2au4GA/nAVxADYXYReD8sdJqVil/5MD7anQK6IQyGjrxEPOtJVxHlt46Lzx7XNTcMvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=pUSTJ1tCby5p9mDPRGRYi6PtNp8FWYRQVA6zuUvZYzuGlZR5xlmUVIv5Z0+V47E9LGXBl4e1yT70WIfv7FdMBnPIzNOjwuULLcGiRItc35SiFCHWBB/ERTgZZeYg/vKOj3fhRpIh9W4ILtOX2msx0QQDCLxxzWjNUcAYcMsjrSE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Thu, 23 Feb 2023 20:34:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 20:34:39 +0000
Message-ID: <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
Date: Thu, 23 Feb 2023 14:34:29 -0600
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
X-ClientProxiedBy: SA9PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:806:24::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3612adf6-f430-4f38-5cb0-08db15dd6283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	6DSNjQ2/pZE2A9YCUbsZEaJ4eYLBpAFaH4EsN2QgMUs6HZxDnGLl8wl0fXzvRQiOAxJzcxshCms/L5OPVeyWrhXkCTNNXC9r+J+GxbHD9PPI0C9g8qoJMVVNkSr5JJAY5QQpZnFmUhGXxb+TGxG+t7RNwVYG1qpSUMOby9YyXYfLCHRrXh2k9NSBZ+6CHeA7qHc6pUv9lsgbPKGlG/Y4nz3chDFkqQaD7o6G9gKE6MuyRaGz3Znqevl6HA01vNGM1TbBvzSZjX6ZbY5yVXhq17Ib5XmC/hmCqt3+dRG4Zd1TnbPC1wi5ZN9Y9Y+4IKnZbN68JoFbtp0sfC2CefzOhVgkktLgFS8RD5TbpkFCvWc3/SZl94hFnI3fEOKQO4ekf5ngeYQ3zxAIa/ZnnLPVfXJvRXYmBBaum3HSbFLm5ocLKqr7cfEt8DayT9KziKHI1vycX5tw11ICftnOIeUNus49dWG+gGSqJjqKjn/5qB/d3JLFPWvRtWn+VWt+NjYnhbeWfY6b+JDMmHPF5l9SuPHxCRTeknpMgNvW9rMnfWYYSCkiuSwFpnFJU+6pM/IV3HkzLaw4/Zq9BlqmfTnPVweleJ9v/TscjYkp/Z4bCDot5nJzRrC67W9F03XONfqSCB6Z6kaKfxVm3TUaCJh+063YQCXJi09POqAJwqWSIrTLQvmJRztREZ5sXi+YqbJvQkys8uCFel0GeEJmoCmgyYDX+fo+Qb45neoP0A7kFms=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(84040400005)(451199018)(6512007)(316002)(31696002)(86362001)(6486002)(66476007)(110136005)(31686004)(66556008)(2616005)(4326008)(66946007)(6506007)(7416002)(5660300002)(8676002)(41300700001)(53546011)(107886003)(6666004)(478600001)(186003)(36756003)(8936002)(38100700002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?ZXZ6ZkVIYU9lWDVFZWM3TURXeloxbk5YL2Q3NjlZN24xcnNENGU4a1dyWTRv?=
 =?utf-8?B?b2dFSnFWT1ZVdGtITGNTYThlWm9LYjhTblBmcXBwRW0xQTJiNkVvWTgyMlpK?=
 =?utf-8?B?NFZnWkx2YnlFYlJlVFFXbHNiUGI5MXkyVmIrbnNmUGtCT0NuRUZsWitlUWpl?=
 =?utf-8?B?NnY4Q0UrQkdpemRsVGZWZlAyQlFhYjc5R1FYRDRoa1V4a0hnYWlGYXNwcTZX?=
 =?utf-8?B?eEdzVkJydTBaSThoQnlhYXR0UVlBRy92OTJ0ME1hKzVuUTkxdGNZYnhtanBO?=
 =?utf-8?B?Qk9BZzV6dTJndDU3cDJBMWUwbUYvQTNuMTQzTWplN1hzUUJoZHJ4cW9tRG41?=
 =?utf-8?B?SmFtVHFGSlB6dHZ0djdyMzRmMTJLcWVMTUFLK2xJY1Z5d1ZTQjZZUWtkM1pF?=
 =?utf-8?B?d2tPV2p4eXV0TmUwVkRwU001OWZYbXhTV3JpQjQxSnIzcGRXWXpaV2I3a1Br?=
 =?utf-8?B?RHJPOHRMVnEydWVsbWlMdytuZEdaUy9udUUyQklieGlQdEV2NE0wdTNVbkI2?=
 =?utf-8?B?WHpxRUhUc3NNNVMvQklkanA4L2QrV0JLUjRScEwzRnNDaTVUbkNvNE1vT0t5?=
 =?utf-8?B?dTJ4UFdPeGhiaENUbzRnelN3SXUyL1UvQTVBYzBtSHQ1MFdxVWN6Z0YzNy8y?=
 =?utf-8?B?RE01dFd4cTBRU1l2ZUVWKy85N2FieSttdnZwUmljVWZWQ2MxSU5QZmk2K0h2?=
 =?utf-8?B?Q2ZPdzJLRmpEVE8rV2hJVDluTTFBWHZ6T21BV1VjWXgrTXo3VDhCYTl1SVJQ?=
 =?utf-8?B?a2VuMTBRM3VIODA1WEJOODl1ZmZ4UFF2WTlsYnZDVDMzVVpCYXdHY3pjZTZW?=
 =?utf-8?B?cmtwWlgyWDhGY2Qza1B0YU5TY2Y0WnQvWmNsWVU3Y3RoUTNYbm5IRnpKc1J3?=
 =?utf-8?B?V1JxeXFRL2JMKzBrbUxZejNmNkdFYjVOLzYxRjJMVUdQUUV2b29yTU4vQlp5?=
 =?utf-8?B?S0JNV1ZScjdsWEV5WmlCU2o4ZUp5Ny9DWW5mbmFIZXBMWTN3UGdBTzdkY1R1?=
 =?utf-8?B?VmcwclY0L245dUcrUzBKTzZHbmcxMitlTU83b1JKSDVDQi9RelFTR0VJZjNV?=
 =?utf-8?B?V0hUaDd3QkV6ZnY4Y3hOWHEyUHA1aWNGYU9KVEFBdUppdUplYUIvQ3dxMVRw?=
 =?utf-8?B?ZmtuTjB3T3J3WG5KbE94cWcxdHFaNk9CSExQRUpOK1FOeUVTaWFuVGlvdFBU?=
 =?utf-8?B?Mmh1VWp6U0t6NVV2bmhLK01uZ0x4MWFNQ1FCbDdrM3NzTjg1Q0pGL3lES0U4?=
 =?utf-8?B?ZlZqQTMySjE5R0tSYWR2cEVqY1owZXhZUFRHREREUDlCc2JiSW5LTU1jbjJr?=
 =?utf-8?B?RWtMSlJnelpzaEo5SlBneS9SeGxPTTBLSmxWQ1o3Y3U3UWVDNjlGMGNBclAr?=
 =?utf-8?B?cmU5OTJpOXZxUkhnL3Jvc05CNkZ3L0M5UXRxalJLR2FMM1VYRlNFTjNmNFdV?=
 =?utf-8?B?aVI5aUFHRmxkM25DZ1lPZUJzcytJaUpZL2U0MnlVUVVxcUw3eC9IcittNFJ0?=
 =?utf-8?B?WDJsWEpabzcydGdSQ2Q0eXpLVml1dlFlM0hRZU4vWkpVVFMvSnRUYzF0UDJE?=
 =?utf-8?B?USs1WTV5a3AyZEVOUUxrM0NieDJHVjNra3VsL1FOVGdVVWtzMUNsV1dDMmho?=
 =?utf-8?B?dTlWQTlLTHNGTWVnWVJwVzBWdnZNSTMrNjVhOEs5V05VcDd2OW16eklnOWJq?=
 =?utf-8?B?U29UWkcrT0Y3MzVhR3lNYWFmbHp0SWRJUGh1RUdlNWU0TmxESjNVS0FmdzB1?=
 =?utf-8?B?TVlxa1EvdTcrUmowL0RLc1FGamFBZGFmSUxPdFIyWFFuZUVCOUtZMUpmRmk1?=
 =?utf-8?B?a1UvaG9zWG1XVVlHcHQyVE1jTGd4WmFWMCswdnZ4enl5YWpGc0tWNHBoZDdI?=
 =?utf-8?B?TThLSUZzWTR6TFNMZXdPZGlJT2QrS1BhMXdUdmhQeTdndm52YmRONENMOG5H?=
 =?utf-8?B?Y1BHMkZPOE45UTI4TFNDa2ppeUFyd055QWo0ZUNDSGZPdU1XV0FXZyt2Z3Bv?=
 =?utf-8?B?WFdqR0NLTDVJVHlmekRIcTVoSlplcVBsK0NyV25tWXpQSE1aRmUxVnVyMFVE?=
 =?utf-8?B?YjJaQkNOUmRNWGcvRVZjTjR1RE5DQUJIZjhSZUhXd0ZFdGZPaktERDJYNVpj?=
 =?utf-8?B?TE1pNkNNeFhVRDJkZGRMa3BtUm9abmI0ci9uVzdJekxITXJXT3J6Unlldk13?=
 =?utf-8?Q?6LnoMw61zprnx7bbDaQdezk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?UWF3WDk4Qkh2K0VubGlRZjZoS3FudG1WSlRqOHpHNzAxTWlQMy9td1ltQ0dx?=
 =?utf-8?B?S2ttVnlDVHlleUJEdndVUXM5YkYwMU4vZTIzVWVBYVc3UGpoU0dua3Y3eWpF?=
 =?utf-8?B?WS9QSnBqUExWOEFMMHdmRC8wOE1tQ2JrandadjVLQ0w1cEdYTHhzaHhMTWxq?=
 =?utf-8?B?aWxjTXFYOEI0M1RQbE50UE5aNHQ0bFZiVXptVG14bEZHS1o2Ti9talpPRDNZ?=
 =?utf-8?B?VTltL0dTT2lwTC9iMGtHNUwvbEZjWklDNmI4YThjZ01wWXNVUlJJd3RzRmh0?=
 =?utf-8?B?eUgvSTcrRUM5OG9iWlludTJub1BmM3d0MVlMR0JKd2NrTGcvbzJ0RUd0UzF6?=
 =?utf-8?B?NHVvYm0zWmpGSlVwSUwyY1RBNTNudUxSVzl4Ly9WOVVXdlVpNHhVcHdlSm5O?=
 =?utf-8?B?NW5XUDVSRm82akJTVHBSR1R0SUk0NllkTm1rTVZJdkVxQ1hGcG4wOFJzZFhy?=
 =?utf-8?B?dUk2QU1JU1YvUldPZksvQ0ZRdXZ0VHMvV3VtNkpLYW5nVFg0VEc5d1JSL1lj?=
 =?utf-8?B?eGpwUEJjMnZsL3BUdWhrNE53OGE2VHpvN0tqMS82VW1rcTVzYVNaaVhhM3VV?=
 =?utf-8?B?c294VU1ZaGhqaTgzWWRlcStoa2F2dkpBSkd1U0E0ZDRnOUl2SXVCWEwzUk40?=
 =?utf-8?B?a0hJZ2d1eWRoc3BWaWZsaEYxMHVqK3pTL3IwZEVQU2VBRkZHTjVnK2hRZy9R?=
 =?utf-8?B?dytGUGwvOFNzajNycVFqdkJZdzh2b2wxUzFQUVpaVVhVcFhwYUY4TFZ5aTRB?=
 =?utf-8?B?YkxWQ0RYclVYOExQbWtzV2p0anMycUMxT2lyTy9lY3Q0QlZsYUNaNVNrWTFy?=
 =?utf-8?B?bmZXcklUT1d0YmtoSDZEK0xNUUJ0b1JPcWpiNkxnMkFjUUQ1dVVJVlI5Mk9u?=
 =?utf-8?B?eVZGZXhPQk1VWG5FdlpGQlFoaG9tRUtwdVdWeHdveWJZdldVVXRUSzN5ZHd6?=
 =?utf-8?B?WVMwOHNqSENWZTNRd1lmTCtrckpvTmUwSmZBbkxGOWhmSmlWTGtMQzRZTWR1?=
 =?utf-8?B?WHZFRmhzVXNVUUdraFE4NE9YYWFaUjVOcjlkRExmaGRrek1pM2pSblVNYjdI?=
 =?utf-8?B?T1BGQVJKMHlBUHgxZ1dmQmkwaFVBQUNUUm5UNlU3SWMwWlVBUlpMaStGcXlp?=
 =?utf-8?B?cFFFZUJWSWdnWGxNbHk0ek4wcCtuYkU5djlIblBUdWp6YUJNRjhVcGd0dGVi?=
 =?utf-8?B?Vkx3NjVvQkRyWGJxTFNPR3R3MVU2aUtGek5qYjZ2R2VLek5TSXZaTmRXRDNX?=
 =?utf-8?B?Wno0R2VXUkJzM0d1Z2JKSGJwN0xCREZhTmQ3K1JUQzd4bjBkaHFyeHZwRDFI?=
 =?utf-8?B?cnNLK3NZeU9odWZhYmUrUEhjV1A1eThDY3kvdFltRlhDbkt5VGZCaHdZUWdm?=
 =?utf-8?B?enVGck5XUjhwMHZvNlI5Q1AvQndXRFp4MlFjbkdNYmFzQS9IT1FYdmI4Z2lE?=
 =?utf-8?B?T3Bzdy95N2dPWXZyZHZodWRIQThGU2ZYRlBrVUc2aldqOEtON1pPZUxVY0E4?=
 =?utf-8?B?WVFQU3lLNTRzd3V1aUptcmZWS3hoOTh4SUh2Qjk2RzVtaURDR29zUWVNd1N1?=
 =?utf-8?Q?tAtv/nzcRSiQv7k4MYXxeNi5E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612adf6-f430-4f38-5cb0-08db15dd6283
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 20:34:39.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38LaFpeEcBr+r0n7BeA9cDzpuF69vidJfYfw/1DGh4sUQ11KLMDpFKW4kkyHaeR3zcdedBDIGZksRG3jzPAhqV+jqIiQBTMF1nlMwV26jD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230169
X-Proofpoint-GUID: G98Qbz0QT-L8jkxDrHkM3yMdTNsxD9Xe
X-Proofpoint-ORIG-GUID: G98Qbz0QT-L8jkxDrHkM3yMdTNsxD9Xe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_123502_512086_B855B2A5 
X-CRM114-Status: GOOD (  17.19  )
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
b3JtYXRpb24gYWNjb3JkaW5nbHkuCj4gCj4gVGhvdWdodHM/Cj4gCj4gLSBTb3VyYWJoCgpJJ3Zl
IGJlZW4gZXhhbWluaW5nIHdoYXQgaXQgd291bGQgbWVhbiB0byBtb3ZlIHRvIGZvcl9lYWNoX3Bv
c3NpYmxlX2NwdSgpIGluIApjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKS4gSSB0aGluayBp
dCBtZWFuczoKCi0gQ2hhbmdpbmcgZm9yX2VhY2hfcHJlc2VudF9jcHUoKSB0byBmb3JfZWFjaF9w
b3NzaWJsZV9jcHUoKSBpbiBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKS4KLSBGb3Iga2V4
ZWNfbG9hZCgpIHN5c2NhbGwgcGF0aCwgcmV3cml0ZSB0aGUgaW5jb21pbmcvc3VwcGxpZWQgZWxm
Y29yZWhkciBpbW1lZGlhdGVseSBvbiB0aGUgbG9hZCAKd2l0aCB0aGUgZWxmY29yZWhkciBnZW5l
cmF0ZWQgYnkgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkuCi0gRWxpbWluYXRlL3JlbW92
ZSB0aGUgY3B1aHAgbWFjaGluZXJ5IGZvciBoYW5kbGluZyBjcmFzaCBob3RwbHVnIGV2ZW50cy4K
ClRoaXMgd291bGQgdGhlbiBzZXR1cCBQVF9OT1RFcyBmb3IgYWxsIHBvc3NpYmxlIGNwdXMsIHdo
aWNoIHNob3VsZCBpbiB0aGVvcnkgYWNjb21tb2RhdGUgY3Jhc2ggCmFuYWx5emVycyB0aGF0IHJl
bHkgb24gRUxGIFBUX05PVEVzIGZvciBjcmFzaF9ub3Rlcy4KCklmIHN0YXlpbmcgd2l0aCBmb3Jf
ZWFjaF9wcmVzZW50X2NwdSgpIGlzIHVsdGltYXRlbHkgZGVjaWRlZCwgdGhlbiBJIHRoaW5rIGxl
YXZpbmcgdGhlIGNwdWhwIAptYWNoaW5lcnkgaW4gcGxhY2UgYW5kIGVhY2ggYXJjaCBjb3VsZCBk
ZWNpZGUgaG93IHRvIGhhbmRsZSBjcmFzaCBjcHUgaG90cGx1ZyBldmVudHMuIFRoZSBvdmVyaGVh
ZCAKZm9yIGRvaW5nIHRoaXMgaXMgdmVyeSBtaW5pbWFsLCBhbmQgdGhlIGV2ZW50cyBhcmUgbGlr
ZWx5IHZlcnkgaW5mcmVxdWVudC4KCk5vIG1hdHRlciB3aGljaCBpcyBkZWNpZGVkLCB0byBzdXBw
b3J0IGNyYXNoIGhvdHBsdWcgZm9yIGtleGVjX2xvYWQgc3RpbGwgcmVxdWlyZXMgY2hhbmdlcyB0
byB0aGUgCnVzZXJzcGFjZSBrZXhlYy10b29scyB1dGlsaXR5IChmb3IgZXhjbHVkaW5nIHRoZSBl
bGZjb3JlaGRyIGZyb20gdGhlIHB1cmdhdG9yeSBoYXNoLCBhbmQgcHJvdmlkaW5nIAphbiBhcHBy
b3ByaWF0ZWx5IHNpemVkIGVsZmNvcmVoZHIgYnVmZmVyKS4KCkkga25vdyBTb3VyYWJoIHZvdGVz
IGZvciBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoKSwgVGhvbWFzL0JvcmlzL0Jhb3F1YW4vb3RoZXJz
LCBJJ2QgYXBwcmVjaWF0ZSB5b3VyIApvcGluaW9uL2luc2lnaHQgaGVyZSEKClRoYW5rcyEKZXJp
YwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
