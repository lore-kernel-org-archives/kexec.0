Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53804C3DA7F
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4nWO6Nf8cqMRLHbDVgSobU9e65141cI7BTTUzldZZ0E=; b=AAf8KmCSN7ONpb
	zOCyCXpNtPy65P4NmgSs+rgH/XOUZ5+f+4dxQtanOLc2Bp5oaDbAF2rHgc2PchRtQfppHXjsnaJRV
	B0GLtkq9HjfbU+TJnMTB1iB1gym/l1NVKIj0w8hgscpADTEVLxupGfxm662WK16r3b2/CpB82cW6F
	wWkK3IDIJOsbdbtdyZe3FiVWz5JeB/WNEPDAFV/1GAHr1uZxYgmVjG64JgR+NA9RdIipv6g6/wuse
	DSKsZTo/dcp/i9ql32PHWaNXfaSUENc7h0xvoLrBONIYRm7F2c8nFjjswNEH+UYOx3NhUhaQ3nSFX
	Su6GUX7h08Rdo+7KIT9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sebIm-0000000AB8b-078g;
	Thu, 15 Aug 2024 14:18:08 +0000
Received: from mail-vi1eur02on2044.outbound.protection.outlook.com ([40.107.241.44] helo=EUR02-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sebIj-0000000AB7C-0ud3
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 14:18:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2lHH/hDsUsH8Ir2nB1lx+b/wzhB3BltRtKbyknmmnVxkxLjPN9ZFWglHwdU/Yvr0yYh4DY6bL+SuyuLaraNdqRZt/I1M3kd+twqzRC5r88/WsAlqBmcXjOq9HlH0k23yKTG3r+Yi0BNiafVf4Bf4zcq9rzrjHWs0CB2LpC0ZiYJdspiWV13aPLcFTEQAtjeWFaI/GcjDiyrgx1jV5hR3m1qHqSLXU/5R0gFbTHxDG/qqWy1jvevcw5rEdXm1Mvx6XbrOdtbwoIARCGRW/cxYcOY7HbNgJmiI3QejUpl7DSdfQ8gJ6+SQzm+R5IKt0jhfhGKWLNfTZzLR9SFXaI82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmUwD8uh6woLTM7a8QeJojrw6S0pTy3aV169NE1Yydo=;
 b=KqqbiDw5pqnj8K9s2X27GY64ZrRHwA2B0fJ1O6WfIvqob/Thfg6BkY5FAcx5p8lYlHMrOANabD91lYJDWvaIiGGvkdXHnoTm9Evjz5Pgr0yhUoDWJl/1QcNKZeLvLwy0lEVQkcaHPUtAlijI9uFNNIJgeuri2xR4W+uHGiGyYNoRyGBc8vHz7SYD05Z5arZtzPb/2a3UtDtzLoGomlegAdwxugO/CQl4uI+GpC2Y1p8LrqKGpedwI+BRqNf++xhQ2BE/Nn1yAIkJlH8qS4uirlasKT01QXvpu+tGQWw6NsE9eeUyP9QeZVcwKSwVyMu3b6F8rL1WutFfXNSL1cGmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmUwD8uh6woLTM7a8QeJojrw6S0pTy3aV169NE1Yydo=;
 b=m/8vrO7Zxe970txkAv0HWTOy0FJKV+c8D215Xh5JcwSb2tIJ4bFJa9O9VreObFcnDe2KDThEdCgAOeC8H0ASv6Q1vfvp57iIPBH2gAjW8+YfoU0P2KUzmjgXaRMhfZc7mF+8GlJbIT9rClxrHDAAHJH3fd5wDwNJuJ0IOEeUVCdScb+gmj8E3UAeGgItbnPY3mZYfEVN0OQAInold0JMBsgAzGVDZHU+aiPMGBR2tw89EOPLPlURNcxM62AJU0guqKnSFvDdOdA0sJAB5KmDXQf2IFnBNniiDz1tNLlwFDk6PK9RT7xxVrwfYthIsEvgOH0MTlx7xmeEwoFn/xtEow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6543.eurprd07.prod.outlook.com (2603:10a6:800:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 14:17:58 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.7849.024; Thu, 15 Aug 2024
 14:17:58 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
	Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: kexec@lists.infradead.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH 1/2] makedumpfile: Add ftruncate error handling
Date: Thu, 15 Aug 2024 16:17:33 +0200
Message-ID: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: e7af9c8a-493c-4e87-c4d7-08dcbd351077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3R4c3N2YWprYk0rN3Vwd0xBZjVwYlY4SXhXNUlZLzhMRWNZU0JPNWcwSEI4?=
 =?utf-8?B?SURKcGkzYkhFMTNZOXdwb1gwTjZMVkp4MVlsaFlBY3Z3dFFuYmdNWEdYb29Z?=
 =?utf-8?B?TjBwbEw4UzFpZ0tkdUJlNy9NdWZDa1A3eWVrT3VHQitJMkNiWWRYUE5JUndI?=
 =?utf-8?B?eURIK0pKbU1jcTVWa3I3ZEhYSTYwbUUvSldXMTh1dCt3MnVhZm9Lc3d1cUs2?=
 =?utf-8?B?OFZDUTgrZGxPRXFHRHBoQWdsNTRYZzNmMlUvTVExQXAwYXpRZUdMaEFxZkRC?=
 =?utf-8?B?SnUxeXR1clRhY0lFUXpNQ2tTSFNmVytRaUt4TUNQeUU1dDBLaFVCdTNPbm9W?=
 =?utf-8?B?eThCRTZLKzh1WWtWeVI0LzlYVUVrOENsWFRiUTc0SE1YWng3WlZSeGRCd3U3?=
 =?utf-8?B?ZERMMDhqK2RHSm5JRzBhWExNZVF2OWx6aUg3L3huMGgzOWl1UzVDUUZpTVJG?=
 =?utf-8?B?dlBmM25PS3ZhVnJRbzNBbk5nUWFIT092V0l3ZzBWejZpWEsvRHlpbDRveFVn?=
 =?utf-8?B?SitESTZkTTZIcTY1Q21CcGthSERrUlJTbnpSem4vR0FISHFrdEpXNmJPZ3h1?=
 =?utf-8?B?SmNybk1SSy9kdnJNTkljeE1UVXlHVElrWGd2NGtaclZlN1VYOXRjWmtmcmQr?=
 =?utf-8?B?NnFzczJuQldFK3ZGK1FGV1ppZk9Cbm85czBmZFc3bmc1VTVVSzVXRlk4SGtQ?=
 =?utf-8?B?OCtTckI0YlY5YWJoK2daVk5hek1KbGxFV29tUnJWWm84ZTFnalpGOHl4SXJE?=
 =?utf-8?B?ajNUbnJOMHkxVWcrcG9oa1RKUndOd3h1eUdST05Qb2ZKZU0xM2NjNGMyMk0x?=
 =?utf-8?B?SmtZTnZiR0hGQUlUN1REenJWcTFLKzl6a3JLL3ltRWNNVGdrSGxkeTdmSk53?=
 =?utf-8?B?VUFjT1NNSldVYUFMaW55ZU1jNFdOb3pDSEEyYUR6eVFiQWFXdzFyNHIyYnZS?=
 =?utf-8?B?T3NZZU42WnFqY2VmNytveVI3aE05Y1pPb3NzMW5VVXRQa0x4dEJzZ0l0YXpq?=
 =?utf-8?B?YmJ4OTVHT0kzUU1TYTl4blNuRVpXMEFaUW9YdTRaRVU4VjVETENVWTVRQ3R0?=
 =?utf-8?B?Y2R1Ykp3Szh2RVZCbDhmSDRkcEZGNEdDSFJGYmhJR21LVDZhWU16RXpOSWhw?=
 =?utf-8?B?a2F0WDZDeFVoQ0x3eUZvbGtjSVlFR3ZLNUUrZU5NL2hoc3poRGFDYnBqVmh2?=
 =?utf-8?B?L1pSVTF3aHo2d2tEQjVhaldQNUZqcW1oYUZLdFc1cUhGT1UrMFU2L3hpRVVy?=
 =?utf-8?B?NVVFMnE2QWlBSXZoMUxJM0RaOEovdlpBL1RKK2ZBSHFtR3VGRCs0RE9tSnhY?=
 =?utf-8?B?QXFmRHNnT0dUak16N1ErcmErTDQ5TDl2bjNUcm5vcU4xU283UjBkU3owSVJp?=
 =?utf-8?B?TzBpMkhoZFdsVEZtRWQ0TTV6aWRCTkFnbHJlWE55RFYvekRqaE0rOFdSR3NH?=
 =?utf-8?B?d3BWRFdXejhVdXVsajcwUGV3ckRBN040dGtqRG9GNmFLVllsOXl1SnpyTERR?=
 =?utf-8?B?ZkdzcHg4SVdiWFhzVnNCaTFud0QycnY2QnAwQ3lHbHRaY1NKQmMwZkJzcTN4?=
 =?utf-8?B?QU9TOTkxU2haaHMybENXeFdoVjYwL1htMlFTd2JrWUxBNHFvTjZmUTZoWmJq?=
 =?utf-8?B?dkQ2NWczOTI0bjU4eGM2TFpCZ0xMbXJNdUd1SEVNM2dJU0VIejBaaUFWT3pq?=
 =?utf-8?B?dmlRL2ZZdk14VGc2ZVVUa2w3empQZDRnRzlsRUFEYnhUdGdpME15amZFWk40?=
 =?utf-8?B?ME42TnlwcXg0TWVnZlU5T2dBdlRVUWI3U3krL0tvSmpxN1k5bHpMNVVzWnU3?=
 =?utf-8?B?YWdCMGdjREVaWEFRRW1yV2psWFluZmpFaWRGMnZxYTJBRFJvTW01Z0xDUHdM?=
 =?utf-8?B?Si8vaE4wbVYvcThLMDBYUllrZk4vSFNNcUw0Y1haclQ2cVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGU5ZkJUQ1JyQiswU25xY0RHRVFBQmpPODkvRXhFSEpXSVk0VVBEeVV6S1I0?=
 =?utf-8?B?VEFvbGhVaE1xRHFEU1pZTmdhVEpFdkNKbHdhV0RuTVhLa0RkdGZOVk1BbWNu?=
 =?utf-8?B?d0IvcHk2a25TNFlqcDFDSVNSTk1CWURNYk52UkJSelozL1Y3ZzAvZ3hZY3dl?=
 =?utf-8?B?MEdSQkk0Q1cwdGF0SDdneDc0Y2FiUjlIYWpHUm9YV1dRemFMV3RnM1BwU2xJ?=
 =?utf-8?B?eGYxQk1xSnkvT0ZlS3p4d2pxSFBnU3NlWWpoTVRNWWl3U2VzTCtzSTVhck5s?=
 =?utf-8?B?bnZqcHYrbjduMDlOUmVKckFNR2dzMEtOZmZnbmpkeGtTRWorWW45a2ZTRHB0?=
 =?utf-8?B?aXR4ajVVb085T2YraCs0aUJkazJRcEx6SVpNT1o5SjlyZG9PcEZqSExlN3o1?=
 =?utf-8?B?dEpMVDB3dmd0KzFYM3d1YmY4Q0ZSTy85RWJrSlRITWpUU1JiN0ltd1RuUkZO?=
 =?utf-8?B?TEV3UUpPUEpTbkhKY3dmcUk4RWpQR3NEY2xYaWxac29HRlFxT1NGemM0aHVN?=
 =?utf-8?B?dzNQaXRVR3NVc3BkYnJrTnlRWmdIc2hzYWhLYmR3NFg5ZnRSMVVaWlhIZC9S?=
 =?utf-8?B?NTFoUWZuZmJuQjhyYXRzd2pBa2hxTjdoRzZnUnNKaGNESzgrVEhWZWFLaWgy?=
 =?utf-8?B?dXBoL1M5RzVtdXhrMnBnUVNOOG9LRUR3L1NXTzc2OWVVQjVJVE83K2wvVE8x?=
 =?utf-8?B?Z3p3aEU1amtqU3JZb2pwLytLYitIOUdyZHNtMlNYUm5YR0RHT2k4TFY5emtV?=
 =?utf-8?B?c05TNWRZTWFjdkdoclZaN2k5bExTRy9pZUZXNllFcTR6NTQwdFBEYlJubTBY?=
 =?utf-8?B?dEZHU01pU2xWdWNndzRkYnhxdEpMTUdNVmZsYlhLSlpGSjM0ZHNXblJGc1N5?=
 =?utf-8?B?ZE8zMlhPb2ZIWTl5SEx0MDN0Q2VCOWR2R2ZycnBsekN3aGhhWTJtSzZUVDZ0?=
 =?utf-8?B?RUhnQnRiSFdwaFpRdzFmbGY0djI0eVkzR3VnTFVmR1F3U0RsajdIblBZR1F2?=
 =?utf-8?B?RFI0SzJMcG04bU9PVjVBYUoxbDl5R01WWllHeU9XYlgrYjVmbkd1V3FVN1Nr?=
 =?utf-8?B?bS8xWGJYWFpyZWtiTTIrUXlyN3U3YXB4TDIreGZzbTg2eE04em1LNUVQMUg1?=
 =?utf-8?B?UlBaNktNRVFEcEdXZnlPcmc0WlBzRlRVNUh4VjJabWcxRXNKTFFCSnZPcGFh?=
 =?utf-8?B?aGs2T3pWTDlveHp4TzcrVE5jZlorcmRHWHhydXQrdTFISG53U2hVRE9GUFly?=
 =?utf-8?B?bjJjanNjeE5Hck1QTXdqWXZCM3RhaENQS1JuRHFnTXloOXN4MjhxbjlBUTNk?=
 =?utf-8?B?dStSNWR1TVBqa212dnJucmlOQ1NxUmdSNDI2MmpWakdtaDIxTDRFdEorZThB?=
 =?utf-8?B?bXNqRzVKNjMyR09hbEdrcnF6OXowMWxKY29LOXZiN0ZXNTFzYXJMY2FXd1Ba?=
 =?utf-8?B?cG15V2dZSmFJYmZKTk5VNDVpVExidXdtejMyaGR6MGFRMWpob0dRdDYwLzFp?=
 =?utf-8?B?ZG5KYjUwZ25aN01XSnpQdzV5cDVaaGxxODkxc24rQUlqQW5JcitKWXRTN3Fu?=
 =?utf-8?B?YVJxTlZlU05TNlF3eFdVVXhVWDBtVmhBMXp4cWhtcVZaUit1UnVUZjFDOE5o?=
 =?utf-8?B?L1NydEVLajNXY2FuQWpoZlN2Uzc1WnZCL3pOd0FUMGY4MFp6aE96TDRTVmk1?=
 =?utf-8?B?RiszQjZWM2tyalR2cVpuSVdRc0owQ210UXBCVWovYm5TNHRTWVQvc2RLS3lW?=
 =?utf-8?B?TW5yZ0cxUCtkb3JmOEdQVnNuejF5MENSeVBGaFpCMEd0SGpDSWdxRVhDZE5E?=
 =?utf-8?B?TTJkMWg4SHJoRHhEVFNuQjVkWE9nVDJjS2hKbGhHSUhobnBKanZzZm4yaFJi?=
 =?utf-8?B?eHlTZlpUUFNTeHhOU3dVdWl6WUl6NXM2TnVIYmhlYnhGSUV2ek1ydUpWRTc1?=
 =?utf-8?B?MGg0aTdEMGE2aVZGU2NTT0YxMll5OTBwVkRuSlNWUUw2c0hYVFFqbWtOdGlw?=
 =?utf-8?B?Wlk4bCs0ZThhTndpVDljSndPNmQvM2xsVGVOZDNUMUNWSnBQL1AxdjdwOG9U?=
 =?utf-8?B?ZktmR24ydXUzV0NCSi9OdnNRZFgybGhVTzdvTWJ0S2RONGxZWlI1K2pTOFpo?=
 =?utf-8?B?VWJaTXdDdmtnYWZZM0Y2Uzk2aW4zYkkzcGlDU3JROTh3NG9ueHI3YlBtWmht?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7af9c8a-493c-4e87-c4d7-08dcbd351077
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:17:58.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJqvgE8+3liSyBLlzDeYsLL5viki7JJw4BHS2RVqOSo3pYSedtIK+Ez1g+K4Pc2sAH5dcbbJbLmthf+JwT3winjyxF8qxaMoWf5+IoPhTZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6543
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_071805_343159_35585D49 
X-CRM114-Status: GOOD (  11.36  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Rm91bmQgdmlhIC1XZXJyb3I6CgogIG1ha2VkdW1wZmlsZS5jOiBJbiBmdW5jdGlvbiDigJhkdW1w
X2RtZXNn4oCZOgogIG1ha2VkdW1wZmlsZS5jOjU4ODQ6MzM6IGVycm9yOiBpZ25vcmluZyByZXR1
cm4gdmFsdWUgb2Yg4oCYZnRydW5jYXRl4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdh
cm5fdW51c2VkX3Jlc3VsdOKAmSBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQogICA1ODg0IHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmdHJ1bmNhdGUoaW5mby0+ZmRfZHVtcGZpbGUs
IDApOwogICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gV2llaGxlciA8c3Rl
ZmFuLndpZWhsZXJAbm9raWEuY29tPgotLS0KIG1ha2VkdW1wZmlsZS5jIHwgNiArKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jCmluZGV4IGNlMGQ0MGUuLmM2ZjcwZmYg
MTAwNjQ0Ci0tLSBhL21ha2VkdW1wZmlsZS5jCisrKyBiL21ha2VkdW1wZmlsZS5jCkBAIC01ODgx
LDcgKzU4ODEsMTEgQEAgZHVtcF9kbWVzZygpCiAJCQkJY2hhciAqZmlyc3Q7CiAKIAkJCQkvKiBD
bGVhciBldmVyeXRoaW5nIHdlIGhhdmUgYWxyZWFkeSB3cml0dGVuLi4uICovCi0JCQkJZnRydW5j
YXRlKGluZm8tPmZkX2R1bXBmaWxlLCAwKTsKKwkJCQlpZiAoZnRydW5jYXRlKGluZm8tPmZkX2R1
bXBmaWxlLCAwKSAhPSAwKSB7CisJCQkJCUVSUk1TRygiQ2FuJ3QgdHJ1bmNhdGUgZmlsZSglcyku
ICVzXG4iLAorCQkJCQkgICAgICAgaW5mby0+bmFtZV9kdW1wZmlsZSwgc3RyZXJyb3IoZXJybm8p
KTsKKwkJCQkJZ290byBvdXQ7CisJCQkJfQogCQkJCWxzZWVrKGluZm8tPmZkX2R1bXBmaWxlLCAw
LCBTRUVLX1NFVCk7CiAKIAkJCQkvKiAuLi5hbmQgb25seSB3cml0ZSB1cCB0byB0aGUgY29ycnVw
dGlvbi4gKi8KLS0gCjIuNDIuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
