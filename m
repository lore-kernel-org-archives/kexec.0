Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD91C36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svub96CR720UBUditmH6PDdyZJD6aGA+H6izbRiE32E=; b=bM1GA1RL6ALcDQg1+4MVOOFwQs
	02qJW8WOLoZrifUe6q8qUj24lr5CbDjH8GjLwiOf/dtUjF8mPt3+ZsDs0WbZU2y4KpTaEc9iogALu
	qHZaDsMNY6pM1Y0RZPUjH4hxsv+tGWcP2OZNSwRx4kOGil7JSVU2mOHQZiEiZrCd5E65UDkJJtzyW
	Vg6mhCzKRi8ZrE6KrZt1IErVOE2WhixYo9ylY3aJ1nSfYq0V7hHXhAd2EgrWKWjhBHrAA7dmN8tMo
	uGZ6YmMqspnCquxKdhcLMj+W31cy6pzF7+KiqVUNDJnn7CW0BxySkEJxx7AGsXMMx/lllrP32OVoS
	J/JT1qZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u39ym-0000000D3x7-3i5w;
	Fri, 11 Apr 2025 08:43:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37Iq-0000000CcNu-1Hgs
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:51:50 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3i1Uv001220;
	Fri, 11 Apr 2025 05:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=svub96CR720UBUditmH6PDdyZJD6aGA+H6izbRiE32E=; b=
	d8dGzarv9chzacuDudH3dg1LKjnpFIt5tzHnkfgiZWo52f8FBaWgq9Qg+vgZlDUC
	i8Q+PLa5ldukK56pfFmpBY89sGikH/bUFpGrqmPxcQiXPvjPIOeGOb4+ClKfGlXG
	GCAjQ+KgHezdB4BWy6gFCoQvLG6BDBi66sn2iGJ9SrIFbu6mIAgB9amC/yQGr9sB
	daYaWmn/MOQtD1ybw9rq3TaisqnN+5RkyCkhxX1v3aiK3TGeSXTg68rLBPYX4gSW
	rviScVBk0RF3OpYtV4RnrZqZQPB08ewKVZWW2yJP7pFvIQpW9aqOumamLBawka3B
	mGuWyAddYP5yw9c7qq1a8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xuddg4dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 05:51:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5f63P001522;
	Fri, 11 Apr 2025 05:51:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyd87qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 05:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBdX7BcHE2eTgL1B+v/FIE4Td1EAXDs+Bw3OOpOCYIpO79HgrwG0CqRqKSY8T9fg8C1bhp8yD9MMlzpzNCPMG4NUMjZClp3f8nYAwUNNKFPSt2DCU6EWydx5a+V3TM1OfT4dSNBtEO9WjMGnSMRh1xRoKRJ1cFUQeAf9Xo/D/zrsyvc1Q3s+cHlkDduXaeFesc3u9s06rEdIs5dGJztG6zFQS5aElgfDP5HdMWpnMdXICKsZjrjuRUrIZZXq+QcSpYyHodj8X2WRRmBosZiYxsdIEu2fnxEMhwIQbbKuHFwC7lNxlGAjRZj7jhfogugfrznPCcaj7tQ/Ec5Ooh2ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svub96CR720UBUditmH6PDdyZJD6aGA+H6izbRiE32E=;
 b=X1KLz0P/T/W4gUBrgTIJ4b0ogCcyu8xBsEwQwXgU0TXMZRuBTmLN3Bl2vX/zOP+gakahDHpqQ8Zo4n4e15kIh4S5S1vA1rLV8ITDvrQO/OdjaD1+TUc/kC+6uYjLtHyhLqAcBpiTS/Ygm6EZZf/50l8bYFWhumhvcacC/SuNaqfnK1wOonygHFgPSqfuBTj3FbI9o0mvj/0AQwg3r+8OAs/ypWeDTapeOe4YPqiAN+6WV2msCiQ+o+MbGkOoCLaPUim+fnaBRlHrUYrl8Z+CsqvP8WGKMp9vWCc1/GcXu2C+xKejzUJL+TMIRbPNZ0QG6Dw3VYh6/GUzEHgG4yOv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svub96CR720UBUditmH6PDdyZJD6aGA+H6izbRiE32E=;
 b=XEgIJu6q477q3AJgWPV3Nc0Jca0JhxvqBhvcoj8s4QRKnHLr0e7dzDJgAThHHzDeMZBOPDcKanedZaFfS8uniFli5h77F9TBHsOzFJ6eqLNaV0P/EIlZg5h7LPGYjVHKV3bg1T6fekWVu+Pd8HrFTNVPWkrw2oiOm6NXvF3pFkQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA3PR10MB8369.namprd10.prod.outlook.com (2603:10b6:208:582::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 05:51:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 05:51:11 +0000
Message-ID: <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
Date: Fri, 11 Apr 2025 11:20:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel
 documentation
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250410204149.2576104-2-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:802:19::26) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA3PR10MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b09a9c8-3284-49ca-da49-08dd78bcdc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE85V3lxOEtaR0FGenVpUU5UN0trQXFmL05TdGJpNVUyVHZKT3dZS1RCNkZT?=
 =?utf-8?B?Vm1Hb0NjTkUvNWtLK2FqWGVjZDU3a0NRdExXeHNGT2txRVlqOTBDTU1Ibm9K?=
 =?utf-8?B?WEFmeENiU3MxUk84clhrcnFkMXdhaVQ4NjFHbFNnd2hUS25tS2I2c1VsVDdY?=
 =?utf-8?B?UVp4bEQvN1pUeHFOeXJGV1lwMU94OXovd1V5d3FBbEJpa2NDcGkyeVVqdWlD?=
 =?utf-8?B?RnRDTk80ZkxkS1FvRmRRTjJCb0JKUysxcjBwNVFxWEJRdzJkczYrV2NGUVR5?=
 =?utf-8?B?RjdkYTdXbVF2NnIyVGVwb2xqc2dnN1pLMkJVUDMxMHF3cDFFa0JZdlpsUnBE?=
 =?utf-8?B?bVU4U0kxT29GZnNIcGJ2cjV0WFVwdllQbU5sZ2VYQVlxTlplcDBORlJKVEJJ?=
 =?utf-8?B?SDRnODlTZ3ZJZDV4bVdTK3R4WGdVMmczWTFtRUR2SWRTZmN2ZDlsZVpGcGtu?=
 =?utf-8?B?YWpCU3dFZ1J6RS9sY21VQ0p6Uy9VeVl5ZCsvZjJUNDlWQU9mRDhFdEpXeU83?=
 =?utf-8?B?UXVtb2s0MThGaVRlQVBUbXZWK2NkRmNxYWVwWE9JR2VqTW91UlZGamUrSTkz?=
 =?utf-8?B?TGprWEtFV0lrZEorR3NVTE00NWtJRDhJTDZSeWM0c1hMWU9Xa25MVFdLbzRJ?=
 =?utf-8?B?eGJTTzNCSzdyOWl2elhFcE51TFF0RTFEbFRZampBblJtQ2hzL21wLzROcjRF?=
 =?utf-8?B?TklSdzYwYmFtYlpRWXJHT1BkSk1ORkMzSHlIeDlrN1BhUHV0QkJMdWxIaEo2?=
 =?utf-8?B?d0I5TmxTdHdxbU9KNUxzNVk4aCthMFJUWXZHTUQ4bUxpUXdCa0F1Q2FYK1Rv?=
 =?utf-8?B?YjVyaW11VDN3MndRMW9uY0JkQ0tWcWpDdlJmMzJ2cTBqZ3hyVFhnQ0hpYW1t?=
 =?utf-8?B?cWE2NU5WMFA2c05NOUdGRVdtRWRhRVFhbEFxUzZNS3hOc09yRVhJb0xncGNQ?=
 =?utf-8?B?cGRVWDRPWmlkcmhlWnJCOGNLcjczazFoSmFMY1RpaU1pL2lIdS9acnJvc2kv?=
 =?utf-8?B?Q0JhUWY4cXZkNGpjZGthcWhySk5HQ0kzaWpsdTQrMmFkaTBuRXhsa21kWmhF?=
 =?utf-8?B?REpSOTF4ZlUrNFNXd0xIN3A5Y2tiNXZPdC9oT0JBdHFOYjk1V3hueFdHTlFV?=
 =?utf-8?B?UDdQZ2RGMDc5VThPTjRLamppbmQyYkRpUHVVQVVHaUNHN281KzJocFBKZ0x3?=
 =?utf-8?B?R0U5K2kyTVFnNEJFUEdNcWhLYW11SVdPVnBTQTF5bFdDWUN5WStqamhjUDlQ?=
 =?utf-8?B?R3FIWEJrQTg1TmxnTFJ1RzJGS04xMzdjYkd2SHhpUFFYVkhTcTJoWkJrdzFI?=
 =?utf-8?B?aGY0VCtPdExlTmx4SmxJSDBJRGF5aFFUTWZRS1QwNEI3NkdFTWFyUEI5a3cx?=
 =?utf-8?B?ZSs1dXQwRXFuUUwyVFgveEtRQnAvZktnU0NCcU92RFpBZjFZVys1ZFVKcC9v?=
 =?utf-8?B?NzlmOHFNRmM4YXhCVmFYNEJhR0xtblBqRE5GR2hnbkJoNmRiM0tqeE9aVHB4?=
 =?utf-8?B?aS9nbzdCZkxwWVJzYmEvUFJZZGRPbzlibWlUSUxQNXhlc0w5V2o2YjhUbVUr?=
 =?utf-8?B?QjBlU1ByY00rQVNBRTh6dEh0M0YwSkhaS2czOVhadzl6cEl4dW80NXRZYXgx?=
 =?utf-8?B?Y3ZMaS9YNiszYXlJME1HTWtPYTdpVEJGaHFCdkEwTHgxQjk2Qk9UVm4rano4?=
 =?utf-8?B?a1JxaEFETU54a0NBdUZHZ3FFQi9WcTFSUGdCOTRUMDI2REZBODFuSmRKQ1o5?=
 =?utf-8?B?WUdPeDQ2VER4YzNBR3dBK0xFSTBhUWtYVHl2eHZhcmVPdklZS1JuZTROYUpw?=
 =?utf-8?B?VjRxMzFRR2ZjNFdmbzIzWnEzNEdpRWd0WHY2TmRSMHhXeDJOVTRhelFudHR3?=
 =?utf-8?B?L3B0N1FZQ004V2NLT2RhZEpSR2FxZGh2NTg0MlZ1N01mRkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdNU3RYNlpia3pqdDBvbzl1RWpZSGxjNFlTeXF2S21Ta2JUYThWL2ZZbUhh?=
 =?utf-8?B?RDc1ZE1vWitIWEtaYnVyc0dWWmRERDg5Z21KSW9MNlRiNzY0ZkF6N1dkanJR?=
 =?utf-8?B?cC8wMGMxVm5DcU8xckFrLzNjWkNxOWZoZGNtWW1DVlhZY2t3WlFib2JjSnc0?=
 =?utf-8?B?a1JKZThYM2txdnBJaUswdnRFN0lieU9xaUNzTVY1bm9OUElWTmcwaUgraWJT?=
 =?utf-8?B?SEVEMVp4d1g4RzEzbGtYS2RqR3FFbXRpdzA0T24zaG1JSlRFTW9NNTV3N0Zp?=
 =?utf-8?B?OHVpdXJFK3lyZFAvblRoYVRBdXJuaC9DRnVDMklLVnBPKzlWN1A3SmdtWUNs?=
 =?utf-8?B?VDFCalZ5b2gxZ0xMdVc4R3JkT09VS0FESDlIc3NnWnBodlBpY0M1RHhNQUE2?=
 =?utf-8?B?Q0FqVmY4TnVESlA5Q2NtZ1VCVDNUOFNSM1puZitLQ1g2eW9JeThBZUxIcTBi?=
 =?utf-8?B?MSt1ZEN0Ykk3dE5yZDdlSk00bTVXV0FOTm42VmlZbi95cXRvOUZZL3dWZk9O?=
 =?utf-8?B?VXdUcjhweVphc2YvcGdHL0lURFA5aS9pTGJvZUFUMkJTWU5HYm1qdUxBTnhr?=
 =?utf-8?B?UGpTRXhnWm03K1Z1MUliMDFlMEhib25JYUJlRDNiVGtwSTlRYlNPN3BTL2J6?=
 =?utf-8?B?OWhyRDhNRm5tZkhieVZvU01VWUxVbUVHZjQrNU1nSzFxU1NlaW9UaTZqVEkv?=
 =?utf-8?B?WmZiN1ZtRGU2eURPc1dlemJINXA0UkgwVXQ1TmkybXlqZ2RSbnlXcS82bVly?=
 =?utf-8?B?SStINWpQQ1VaNW9VWkpSbXEvQzRJQmJldGVWWFNWT0JTOVlGL3VHZE9BbVhL?=
 =?utf-8?B?ald4WndQTVlicWQ2TnhpdWxmQiswME9ZYTlINkhzRkpaNkxNNHdEcy9ZQU5z?=
 =?utf-8?B?M0dadWtCMmtUczVTeS95U2ttMGlCd3E3VDFHT3oybFhMWlhwL2xheWw5N2tP?=
 =?utf-8?B?WDZjZTZhSFlMMFd5ZFdmSjc0TS9GYlUyekIrdHEyWVBjcUtJMFRQU3Fsbzho?=
 =?utf-8?B?NHBtWUtzMWNsT2ppTmdQTGpJTEszbU1XNXJCTVZoQ256SDVOQ3A4eUFJUWtZ?=
 =?utf-8?B?djIyQTdBSXBhV3VZNWRKYUlJU0VGZWpCQjIycW0yRGZFUDJkMUJ3ZHJDM2VF?=
 =?utf-8?B?RVhNVWs5M0J6UmJGUmRaM2RIRDlOby91Qk5RSXFDWWsxek4xd3pqUCt2cUl3?=
 =?utf-8?B?N3orM3FkZkxRdmdSRnBsMmU5dUtjM1liTjBkZmxuaW45L0xrSzg5NTJaTDNF?=
 =?utf-8?B?ZWV1OXpoWHNnWGVVaERQdHc2SkQrUC9kUEgvTW92TjNTaXJQVklhR3IzaEJr?=
 =?utf-8?B?SHZUOE91TmNLK21wcmlMVld6d3dxd2FsUnplbU92M3cvcUdGL3BFbTVyaTZB?=
 =?utf-8?B?ZlN2MlBLQkQ2ckxxTHV2RW54UHdOUmFXNDUvZjRKdzB6OVl3MitZcUFiMnZv?=
 =?utf-8?B?Z2FKU0VLQkFUWXZrV3MwT0FYUEN5N3RTRm9hTUw0MElIbGlqUWYxYVNyTWlj?=
 =?utf-8?B?RFVHL2xYeFh0alRwb21sU2RmeEpocjV3TXZjQldGTWNCTXo3cU55MHZrSC9R?=
 =?utf-8?B?bDMvcndpang2Rk5rbVpnVkFXR0FPN2NEYjExT2hpY2pvbkh2Ym1rdFJpbnk5?=
 =?utf-8?B?bC9oK0loY3I2ZWdMWlRKV2FCSVRuVkNEMmtLUk9SUTFXeC8wcTRFb3RGanF5?=
 =?utf-8?B?NTFFY0lyR2xOV0FFaGU3NHM1YVZhTGdYTUErZUtaQ3FXeE9KUWtseUJkd0ly?=
 =?utf-8?B?T01iR2VHd0ZRZ2k5MjNFVlNSdytFMHFGZ3g4VkF2TWxRQUY5bXpMWldxam9U?=
 =?utf-8?B?YjNtcjdCb3JDcVZ2em9zcVMxUEhnSjVGU0NMK2F6K3dDZEowbGRiM05ubitx?=
 =?utf-8?B?bmFkN0ExZjBibXRtalhWWGFHaGpHSmlUWXQybGU0Z2pUcFVBT1VuUXp0SWZm?=
 =?utf-8?B?ajNBcDNNcWRVZlZJeThkOW56Tm5lNHhpNWFORk5DN0FuZjRDcTB0OUloTk5F?=
 =?utf-8?B?UEpvbldac1NpNk5FYlE4bGFJb3k3U3c2WmdDRDRmenVjcHM4STR1c3hsYVM5?=
 =?utf-8?B?eG9qMUxBMlB0cFFOd1JJalc5cEhrVGtnQU5RclVLeVowSnhDelpFa3dlOGNL?=
 =?utf-8?B?endQbFAxYjlkRzNLMnRBbDV5VTF2eS94aWowK01QNUJNWnBkRU9JdFpBYnBn?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tvibN7wi79XLyex02+caK+rAIctfXNeKXhvhYTT3Dn1yPim9fjspfkoYvpD5lR0OB/fPwZA7yJCqu79qS5hAoRI/E64MNLr+JLdDjBXUpsj4Jml36r/S/wXV6zi85RLHPt68w2+N7r3M9bjpOGbgC8iWSlULjuT9cOE3LpXF5QXC2CTHOvQYOlZEtkXaLXv5dq5XpuKFxIJEWn4JmqOZYHj050bHiJJhekUFdI0blL1S3+q4CBSO52uBcQ43CGJlFK4hjjBwKn9kj63DK4DJCfH1dyKHcs3DIEyGIijrF57Wep5323b1MP0ULkv/8G0TaWPk4gG8BW3rx2ZHByHN2lt/BYC4A9F+bboyBcFLjB7rJVFAe8MoajhkrxjIPr66BYZv9ppoxCXgWKoOuiLO8mvoyOP6ApFWwW7gIUq9eRKvd3Ntb7RCmjScxJ/t0KeHwbSNisYQFYyZwYqK6cqRDF68xzMycvajqG78eAfCkoHoiy+hmxJ9M9jZwHTcDO52OhuHB9QO/VVO9fjphvnM5pp1ZGZAniwYfnRkLrZZFXpOq9WeuSH/eiURavaVG882PtOF6LYkGHEsLQH+NiLXGFf1gUlp8x0cZXu2JhkvkwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09a9c8-3284-49ca-da49-08dd78bcdc86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:51:10.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM904KY9f6Fkd00D3/D81o5k/Y5NvZWkWP/ypSP6WS+ZPlh03YANk7TI2CcmTu32s7teVH2uUQEgOYe0aHgZ03y3j30CA5pZ66v4pw4r4ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110041
X-Proofpoint-GUID: 7ZrCLLrRVwmVmMAbn1nYiCPdb8CbFSjz
X-Proofpoint-ORIG-GUID: 7ZrCLLrRVwmVmMAbn1nYiCPdb8CbFSjz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_225148_345697_C7196FA3 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 11-04-2025 02:11, Ross Philipson wrote:
> +
> + - Entry from the dynamic launch jumps to the SL stub.
> + - SL stub fixes up the world on the BSP.
> + - For TXT, SL stub wakes the APs, fixes up their worlds.
> + - For TXT, APs are left halted using MONITOR/MWAIT intructions.

typo intructions -> instruction
> + - SL stub jumps to startup_32.
> + - SL main does validation of buffers and memory locations. It sets
> +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
> +   kernel that a Secure Launch was done.
> + - SL main locates the TPM event log and writes the measurements of

Thanks,
Alok

