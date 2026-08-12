Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB0C5B56A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JZHqvID59cdom1y75bqP5qGW5iTGKBBKiPapJlO5+W8=; b=tdVZe39xbSvDiaJTl02C4ziGOp
	/rNlIxNUAal8vQYFO45/OOtcm3/PZdd+RH9KKr36JxLtZsfvw/Uvkcm/8ToENmvNE4F0SzUxeqZUD
	3bngNXsy0Ia7jh5LZFcvablsrYz8Lbx5rFl/j8sT4pRZ8u8bz1QUKYVFkJRGh2pVvIUUzUcLUaCQI
	YcmEceb5nPcMlWrdm6d+aol46B/83usZ0zrY0wkr/OGdz9XgC6KX/bZBmr1kIvC7pd2JmgLctRoWY
	3JDMH6gdsHhkcEdQ4IrHiIhUpuuXTy7wQZ3o3+OxyENDOOnwcK8aEBjwKmqDHWyjJsoqWB3MuIy+4
	jUJB3szg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCOz-0000000Gdqi-378X;
	Wed, 12 Aug 2026 17:06:05 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCOx-0000000Gdpa-0ewh
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 17:06:04 +0000
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH2UKa3310992;
	Wed, 12 Aug 2026 17:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=JZHqvID59
	cdom1y75bqP5qGW5iTGKBBKiPapJlO5+W8=; b=GAyasSGZ1wPRinCshMSTeyJVe
	JOmiwLjWZrgWJGqoaO7OARCmQ+2feIC56PjDwUmJJx7EmkOP6JCJ7g4e5HyTHyvt
	df89bROQIHy8bbSsE4EbkMQbBCdv/9MNOT2PrIqmYX/f7w5xVSocD5wTFcyD9CSu
	Xt0Ov1r5Tz6E1AD67wDKPQoR7NRgP8qHnfLG/HxbAgc+9DfHYirghtzOdL7SOoxk
	Ql0Uv/Ieb5JNnPwmNG0pNf+wCzeugw0JyFE0CQrZYUOjrVzCCVs49+773pPnoxkL
	YujEscxTrLlsmZ8plcKBOYPrXgJ6WmPWHiy+772lidSBk+OT0zp1w4A/GLsJA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020100.outbound.protection.outlook.com [52.101.46.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fyshwuf4k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:04:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Giaf6XoN9A3rPmyCKkN/EWK+IAqh7tv9u5KK2K2f+xZaeuQ6YWOXSpWonmHYQfG4OQo+N8Vqz6QHYdWB/NVsaDIgUHFMcPBoR25YPZBOhu/L+NtjCCopwBivW9PZiBJ6SA5V2VxzXr6QNgQLkMXG3xzI3t7zxbtq+jCFBb02aatJuksmSRMxJuQW5Vt6fQWOnNltDzx0bh26XbR7tIfT9Swciy0dME76s2nMsayVv1YSgJFHFycYj7wGXtn4xW/aoSmEtc8+QQjKHA5MQse0zmpSVgxT6RIlPe6JdXSj99+BYCep5Fnx0nycMPBcFgUaSPwCgshXigdUNjIhHNVXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZHqvID59cdom1y75bqP5qGW5iTGKBBKiPapJlO5+W8=;
 b=LGZPK1YKvKsmdnMKJ58JFAnFoIhQo8dWffWQuFTLZZoxM1RU7kxyf358AqN9nEPfoFovJ/1WlYtB9vZq6AlCakrm+59oOSApv3jvu+y1Q7HPI5Mj6HGpEFSiv0aVmaDdvAe87/WdAEdxm2yRYnAPSCgF4YtzMA43OsFaoTzP6q4ZZ/KvURV9lsXDFlu5nNra0kTxPxDwjTMUzoszptZ+r+CyLPv4PWf6xbxkWEkf6RRyZmdOHYgJ9/0yPtdoSEz0Ygj1ld5onDTFadEZIhfaU1wNWemNurBNWWn+1rN+lUT9Ak6jmmMWAtzY3VWpdyyRqS7tjkn1Btgw1L27FE2Fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 17:04:42 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 17:04:42 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, bhe@redhat.com,
        hbathini@linux.ibm.com, eric.devolder@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        ionut.nechita@windriver.com
Subject: [PATCH 0/1] x86/crash: fix kexec_file_load(2) -EINVAL on machines with many possible CPUs
Date: Wed, 12 Aug 2026 20:04:32 +0300
Message-ID: <20260812170433.533845-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:803:1::36) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 74aec348-882d-4bf6-29ad-08def893cd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|23010399003|18002099003|11063799006|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: R1qD/6RoRI09CGupZQ5pLxN14yiZtNPXYVH1V5aI5M3SPGniYJuu1GCuDtLGCT1RVdQes0efHayeesFI+R/vCOXW+xGCcUWVdRvpkrL3llcxCRI8gdODuShZ19wa4GLumEPF4IstDXXegnFz/e/ffKxH7YyrtpeDs8VJXTSyUhvzzB+E7L6iVMCpfjbx8eVM5phvsjvCu98VYo5H3BSnT0xJx2DJAwcKDuBLXy5UysVHLP+VWybS9PmhWMlCFvSsy/o0OWRvJ1Cq1vzBLfj2/6RUtFMHRhxWPFdXqR1IfPI5EOvu5U+AVHHLpHieifjlbpzjaQNiKnzhcXzPj7GCA/p8CqjzBA/h3rd+JS7P0mzM10RZvKbr+CKKsI09SvpdVjz1meMUbwz8DKU8yzMIDFXBvbnhlsazxryd75VNrseKyEvMT8t0pTfusZ6kf/GHLaLdXj64spt7ZqPp070l/RQ98aRlqZgoBVhY9KfeF/iRhXmA81KM5/N23l5mS/X4YySAMxAe3tSnAvoxrGMBfElgVCf8mu+ilQthSta39KLmgqPbkc3xjKl7SwcCmKfwxVDlhj+Qg2+BC4IiE/NYFGq45JnCTxmoIEN40uvJAuoF3Soc9qasNKKnZEafaWw3EP8Z7ICMM6rxf2L0LKUBoBklthm6GmPKq/3SxoaIWzou2K2b5ZUFpQ9FleBzEU3x8FH+iIz46yDWp1LRZQHzpkf+UecFjabE1fCmIQwX4iU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZ2meA74oGM8CAzghQnxFVBusRTJKr+Wo4M0TgI5PSmmJEi+d6hk1hML5+BT?=
 =?us-ascii?Q?eNeFHTGoC3ZIK5YRsFEFJXPM7QDtkc+ScWi9+cHBcZs7uqXfQr+eeDPmkS1/?=
 =?us-ascii?Q?3tHytCj1crRC5dsnsu5m/NZ63carhteJRq0ScBgS2mGR2FhRIJOctIXREBYU?=
 =?us-ascii?Q?KE3mHnqA/py3WDlE0kIHmpQ1OLA95fBQylnb+Yxby2JBwcMX82ArPFveGc0J?=
 =?us-ascii?Q?i67yhGxTFbBh+JD/mddh6OMmAzprHd23aZov2My6P/WW9IWVDIvHTW2x0UdO?=
 =?us-ascii?Q?Na6m56kRvnnVjTvzkXGRZgITLceZphKtaDwMmKpoXUV52V7PaBtdMNxnCJEn?=
 =?us-ascii?Q?Wg7jpq6vYBT/DotMyBg3/ZWxN/AspxjYEV59PkSRz0cRkXUQ1K42eGbOJ6b1?=
 =?us-ascii?Q?qE3TVqk0bW8RhH8sxEMflmFb61OdIxq0RtCUDNnlqzU1OX1qpycH2eV9qhJn?=
 =?us-ascii?Q?VESEdT6RO4ASddP86mjPCUwo0qcnnU3Rv4VDADhdL80/yrEq4ZAdCboDixPJ?=
 =?us-ascii?Q?fAjkNixlMyazzc7rlkfXxqwAMp8RPwCfHj4IxvS0EUMSsnfJszABqimaUgXu?=
 =?us-ascii?Q?Kj3JUGLZCLEtuElA7BjQVymPYkDKjnW+eC8JyGqSrkjRZ5mrNMCz3WVqsW8H?=
 =?us-ascii?Q?WOJkh5e0HmQXV/Bt1mmnSi6o8TlawvgsS5dx3O+ivSv7CSXqDZTe3YTgiU12?=
 =?us-ascii?Q?MODF9LkriI6jY9ladpfKuMlz2SVa69N7Elbi9gkQ05LXZ3al6aOecxJUzFgi?=
 =?us-ascii?Q?3sJsXIMhNXwe62M+QpCoCMBfN1w4oUKuEIJxAB5Ya3S0qrQo7orv67oCLP5K?=
 =?us-ascii?Q?+JMElzn7vfCwSeiPzS62G6nRsn74jWLPNYq2udbrsBORowtjw6OuLpH0enZK?=
 =?us-ascii?Q?s2uNSDW8A6FtCy7/d4wLANboGG/aaw3l3ySev+w0bBhsWJ3f1bPeFkKa3sHg?=
 =?us-ascii?Q?uItznMS2NoDWRsUjmUZBlTFG5frswF02irCGu9bnfHcUcLAnIj9EYDL8jJgk?=
 =?us-ascii?Q?GtlOkNAY1UwzEs9RrTE5aUA58+vEyUPZXpGzcJrXYyzEb1XHfodLP/REVR4r?=
 =?us-ascii?Q?G1Z0cSEEeXHY0yM5ZGsZ3pFkgDQRsV7PZBsRYSKsHKWO1ioqpCIcS3blSBP5?=
 =?us-ascii?Q?H103JTulhEgNxFALYpESprg+a2TW0dwE6D1VIqLUaYfH0eDGC2cThH7BZ0pV?=
 =?us-ascii?Q?qizhFRmz32lyNc00rhqXPdfFReOo0Zq9aPGAAuuUXMGsGL2W/ryly/lp1OeQ?=
 =?us-ascii?Q?FhRQUbhO6Vql+5j7oDw3NdQflw3NLVDriBDssu7gE6HYUJBckAUUyiSaK8Jg?=
 =?us-ascii?Q?FSnFA31BMUWLEeANY6n3k51/hB+1FMlQofqWRKncna3el3cVPHluhUoIX3Ep?=
 =?us-ascii?Q?HFAcdn/m/WC79MT2aec404FQ5BoCXHBIgwqw8BjTtvUTCBdJcIoyAMCEwKYu?=
 =?us-ascii?Q?oAF9A9v0s0WnmXP9Y0ZE8fVDvDajXJ7FJqYdBKc6BXEAOxYAc9LeirZEQ020?=
 =?us-ascii?Q?CHvAquXrpgXsaqwrxbEkzmG6u8Hqh6teLvkZHbPBJSXVBEu7MvSLoVRg/VUc?=
 =?us-ascii?Q?iZTEA4a9aSRcmzNSjNRtd7KIKaUepi7fpBxTPH6iEBwdkTJ+QFGa+Y7HuD13?=
 =?us-ascii?Q?NzSoPTFcuB4jZrFOaCoXrd19azP5DjF9SJlyrPtOThqRs8XflFLu3rbeYODe?=
 =?us-ascii?Q?I1KmhNNqllLlGWKwSMQFHZ9yFb62FGfWK56DwlK2Nc58Auy/7KE1vnzmCACG?=
 =?us-ascii?Q?+cwrQIjbeP9SIHa45m+c1AJrrqCXOFU=3D?=
X-Exchange-RoutingPolicyChecked: UptMOIbOFxS+CODGx/XOxF94Hgkp+fa8fHP0kIfbSE8bO6V5K8HDVR1BYRvln6CEJ5igfi4oqbFJYnVUIw/p11ZwSrx+3DqvPM4p5h4L9UzXTBzBlZR+f9O1Y6hfIL5YFCDp6E1Bl5XVdfjr8zIkon8HAOaMnEYyuviMpEGIQcbEP2fRCu1HhHo5RDsElX1VJmEYHsrATFyx1nhYMz7H8fDeiE01KPG6dmCq8F7kMP54wSGaDcTpFWljOLcYCGSrn1nJy9MtlZAa2sDilss4JFDO4Suf+6AwuuFknlpDUgKKQ9Nks1pgMwleWFNHrEgYz5sN+sCaUTTrCr9P1q1LEw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aec348-882d-4bf6-29ad-08def893cd32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 17:04:42.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr8dcYzKnqA53vElneqL6HVtPnlzgIHanx3tnS2jr9ISIRg0SzUxrlj1hm+4p5X4XFohZcUQNEyA3Gjb2BRp08v8GOBWg+E1j2xxGYZ7MgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a7ca7ae cx=c_pps
 a=S/paLKT/iz4AF9Jw9MWvpA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=-5P6dY5j84CKNNKVqFcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX2xgJOoYHIBmT
 aPt+brJBnErjsdHGQxaRrkPiyBcdkC6dW1k2GKU26ctuaBqSkY9UhR/ylBj242nvu2yRTbtkpOn
 BfBYHwAmoM206GCgqoGp8patYb3Z/8+fZivGdNXwSB5+QcJPOcHX
X-Proofpoint-GUID: xdp9nr8IinrHpEYChouGXUtLhcQl0Vcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX2XPVFK4hezDA
 Z6oRCItnNahfdJwL7s/tvUiwythG6TFO4tCx8iViGF/S88d8yWEc/KAQfLZzDMS3HzaLNEvR1BV
 BR169IQZdmSgcQQ1oMTd5zgM6aKe4Vt1HzEqJhHtHgu9t1SV+RrVRMTO2Fdq+Wz5vSmp9WJGYdb
 +BCkUqw5z4fqy538Xwp+DcLmC2Z8tdR/yKt8cLgSpo/3mSjd6GhFCpGhT61H1K/qvGrk0y9cOaP
 o4BZCP7w2Fr8BsBAqNUFJiYJvzgeTpK0xpcMSyZNG6yXFAIOl2MSKQMDaWiO/0/choHv3g/MDFY
 SxunIiQ/qP6+vDAe+GkUajrKADlPgf3IP2sEf5KtOx9hOHvue5wFzI9CpJMRW8r+zqJS+4fgqk8
 FwZ855oabBMVZhpaQH8L69h8Yu28jANUzFkItUifVeszejL04lml9hDCDY6KrJxFzoFJ5vmJ59y
 5wM0OcEnYy8KAHUOaDQ==
X-Proofpoint-ORIG-GUID: xdp9nr8IinrHpEYChouGXUtLhcQl0Vcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_100603_313212_D5FAFA69 
X-CRM114-Status: GOOD (  10.01  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

On x86 with CONFIG_CRASH_HOTPLUG=y, the crash elfcorehdr segment is
reserved (memsz) based on CONFIG_NR_CPUS_DEFAULT, while the header that
is actually built carries one PT_NOTE per possible CPU (bounded by
CONFIG_NR_CPUS).  When num_possible_cpus() exceeds CONFIG_NR_CPUS_DEFAULT
- which happens on configs that raise CONFIG_NR_CPUS above the arch
default without MAXSMP - the header outgrows its page-aligned
reservation and kexec_file_load(2) is rejected by
sanity_check_segment_list() with -EINVAL.  The classic kexec_load(2)
path is unaffected because user space builds the elfcorehdr without the
hotplug over-allocation.

This single patch reserves the elfcorehdr for CONFIG_NR_CPUS, the
compile-time upper bound of num_possible_cpus(), so the reservation
always covers the header that is actually generated.

Based on linux-next (next-20260811, base-commit 5e6de6a2b522f).

Verified on a single-socket Xeon 6776P running a PREEMPT_RT kernel with:

	# CONFIG_MAXSMP is not set
	CONFIG_NR_CPUS_RANGE_BEGIN=2
	CONFIG_NR_CPUS_RANGE_END=512
	CONFIG_NR_CPUS_DEFAULT=64
	CONFIG_NR_CPUS=256

- 144 possible CPUs: 'kexec -p -s' fails with
  "kexec_file_load failed: Invalid argument"
- 72 possible CPUs (reduced via firmware): succeeds

Ionut Nechita (1):
  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
    CONFIG_NR_CPUS_DEFAULT

 arch/x86/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

base-commit: 5e6de6a2b522f
-- 
2.43.0

