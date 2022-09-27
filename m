Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F09C54EE9
	for <kexec@archiver.kernel.org>; Tue, 27 Sep 2022 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TrYT6ne6HJbdNUYi6S1ALumIm3jGMlQo9nA37bfYFlk=; b=TFYE6XmgxBIqhR
	ftDENO1eXWLB512/5M5Vneu9Y1oAgr+8kfY95lKI/UpxkORVUQZdKW5cv6mdxWtaFEPWIPzu3lO1V
	WEzjvZmqQzNzqwpAY0i3TWXTqhH87LFr1gjShD232eITb4hEydjCl6glNJSCTNB7XX/X3fulLiZuc
	Di8TjV9xSwitDv8qSRhRCdONDxnofyxtvSKadf6laPsg5YDuUTEIicz42mm9JLVhgoo32KOsPf4I3
	bcjeNzY+ptZ9RzSX4qwDtRHMtviTvXXIUj3BIfkHUWa74S1qMRZ4zjhesa7acVr9TDV9eIePn5/vz
	Su7xPn2bOSnx8pJMWW0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5bc-00908v-2s; Tue, 27 Sep 2022 08:06:16 +0000
Received: from mail-tycjpn01on2088.outbound.protection.outlook.com ([40.107.114.88] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5Tq-008wEy-N5
	for kexec@lists.infradead.org; Tue, 27 Sep 2022 07:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuEwxuxA6FF+STzLTzcRxAv9OkHZN2BnOzIRG9wCUeOodORG+UMU6DlDDWLV0FiRjYFdXxySmWiGtlpyhpmcRrDsyjCX1TEuwJMbyRsDsFiD0vkHRcJNXymdtBDM1l013ReeR7XFu/yYP7Zh4+MErYsUXDLP+n35DIhzlTIItmzQw4yWDlJ0tUTXdtTiK1w/E7XPFgVK8Ly0nGxy68T8gBLtJcbG2YxuLA22N9r++uqrcOTcmeScrqdr3ECZRtzUqkRJsez5apJUGO/u65fL4wplMaktYZdBsGffWzs7OlzO/F1VPVzdZtSN2+zwM/oy0YBO5Smcqxn3p/gpSRLlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b+7hNMfNFKONn4GwNp4V7jY76OuuzldBS+i6+Ysloc=;
 b=jzbUgNPI1hSslGPaP398WmA/H9rHV4qqnEPlAO6lWPeFzcl9mFJXcWIgJZYQItwxHHXf/H2AkV7EeD7DiBOoNPHY+IGTHm3qZu58TjlQYLOIPECqvZ3ZIEsFymIbmmGEbFmzvzl+2B//91XEeE8+ddVwwHfuPGdGfviKCIkkTiApIU/XIs272OLdOryq2Lkf7RDJs2x/oUEJuAym21DG9udbBXRuWlhAJzsTTQxJVrRy+L+Vvio8hcb6aDxctw1BE5wAuobtNwcw/ExOQo2G0CThHbh3UT7eIpSf3Z07JMbaO/a+DjCPnkU4dZ3GL98ifRASN6RxFn16OUQZxvLtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b+7hNMfNFKONn4GwNp4V7jY76OuuzldBS+i6+Ysloc=;
 b=JUJZe2/UUs1wCUWNLS/j7UwtaEMjRkOMsfGVkgHvZzJgpDM0fFjShyxIraSg5q3I7w8CYN1caiTTR6xm+C4pkNovp0U7C1eP1fBiQ6+DCCkUBcDUt6iGyxJh8QHGsAthc+dyYdGaaT128+tYdMLS/366c7PehCDGXPvPm7NS90s=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSZPR01MB8546.jpnprd01.prod.outlook.com (2603:1096:604:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 07:58:05 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:58:05 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "dietmar.hahn@fujitsu.com" <dietmar.hahn@fujitsu.com>, kexec mailing list
	<kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Topic: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Index: AdjReGs1LM4LddpXRUOuXPWjEIJLGwAznPkA
Date: Tue, 27 Sep 2022 07:58:05 +0000
Message-ID: <9505bcd8-f63a-6e6c-0aaf-7ba4f3330cfc@nec.com>
References:  <FR0P281MB2123EA0E029E96579F0C6DF894529@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:  <FR0P281MB2123EA0E029E96579F0C6DF894529@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OSZPR01MB8546:EE_
x-ms-office365-filtering-correlation-id: fc729c51-e585-4649-c546-08daa05e0288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ejbJfM80xY0ntjVjQUVMWaveTDz3Euq4vQbkKPpKY2DNTir93FiUVgoCU32HVU+irMhBs6X7vMLkQyp0kIUXEq+tL+SproJaA9GV0wcVcdilfiM88ZKlUGsEXtYkUSa1Cd8wp91LPkk9slzrReswuEd6qqPzxRn040kp5k125iaJLJqtyMBQlv5WC2O6tbZhcLVevrnrfLGuU9Neq38JF/uO4fWHbS17sX3q7WgrDo75EsBH+SAaAmDahE4Nk56jZkDAWqun/DMzkDw8k/+iuRzgLDzGZXtAwaQnOLkRxZ+uvsjj02rouZIOtXYff1/AKBTnTa3Nn4ZKcvNmIG3NGzZh4rZkcBe5DbAgvXCPRT0WdaE3/PILVKDfIiPSwHvFQtfbVzZyYUW1LDXLXKeFTbR9kwGEKkSqnquAMWG5Y1ERWNky+TLK57b7hpSI2LCuyF4l73EzIfphtbqg6kLjDm1M7EAedOInsRx/+/q10HTYXJ1btEK0whITpMgV3xj8tfXVNqm7H0FBkk+oNVajNRKYHB655gV+OioqkUe1W2z0NuhzRewCqpmRwAuKXTlmzjKbFdqAFpWm8WLEvzVDN13NhoWMl//jn9IILaK2EE3s93AjPFDRPGvbnMCry4WcDCW+serK/YzGcfRgqAkLnRPLCy/tEi1tcMEz37j7JMgY0DP2HQS+eUciThPuDLfuLqVMOeuicL405ZjI++6Vvs7GIMBcLQPSMbHxkSAcBxrJcrneQw27z8SCpOd3yNa4V/OJabkaKxFSQaKGRFa6iB/k3JBJCCFdWW+CGRc1d42CY2x6erF7UrGBJYQ92rBM
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(38100700002)(41300700001)(82960400001)(122000001)(6506007)(478600001)(26005)(6512007)(186003)(36756003)(316002)(31696002)(86362001)(55236004)(2616005)(83380400001)(8936002)(71200400001)(38070700005)(53546011)(5660300002)(85182001)(31686004)(110136005)(6486002)(2906002)(66556008)(8676002)(66946007)(64756008)(66446008)(66476007)(76116006)(15583001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZndCWWJhTDhmcU8rL3BDMHFMcnk4aU5HZXFGZU5XOEgrSWhraEE3dHpSblV1?=
 =?utf-8?B?NUVpVDErd0VJcUdhMHUxelR5d2dud1ZvTlc1Rmh4VmMrTDk1Y0tuUm51bWlC?=
 =?utf-8?B?S2ZyZXJ1Y1F5TzI2dXhwUEVMU0ZvUVZGcVh0UEdwb0RralFCVithRXI4YVZW?=
 =?utf-8?B?Sm1WV3RKd3Bob01CTzE2NGpseHBpV3VkOWFsSldZczlxYUswQUxtM3VMTUNH?=
 =?utf-8?B?TGdweVlzZjVLY1cxUDlCdEE5RjlrN0lMUGczbDE4K0t2K3ZFUjNHRHZzWXNu?=
 =?utf-8?B?WjZ0RGxBR3RIYzNZSDEwanl6dG5VWnpSaEhLYWgrU0RUZUdkNEdWVGpwaGxL?=
 =?utf-8?B?ZGJsc2VBL1NiVnVsYnhXSG5QdUhpTG9oeDkyUUJkV0VxVzN1VHBpcEE0ODdj?=
 =?utf-8?B?V0xLeE85K1Jma0c3QVBSWVNsNlQwblRnOWtOMjFaZkYyK2tYWkQvWXJ3WUdO?=
 =?utf-8?B?Y2lnbzN4ajNKamdGQjRlMUZ3ZkZYNm9VeDBzbnJSSFdDa0xGMWhGV1RaVWVB?=
 =?utf-8?B?VlNEQml6WlNSTXVWazZCLzFXOURDbmp2UnBFd0pmbWx3MDBwcDdzOEZHeDQ1?=
 =?utf-8?B?aUsxajgwOWZoRUZOQ2JYZDhIRkJrQXZ2RW42OEREVk9sOE9pZFk2RVczOWlm?=
 =?utf-8?B?K3J6YzRWek9HSXNxRklGMjhkQSsvQ1l2STYwTjY5dzlyMzRPdlhYYjFwRkJ1?=
 =?utf-8?B?Y3dkVmZzOTFpem1zemdHa1ZmdUZzUVFZN0R0bm15ZWJ2ZjRPajNEZy9HazRr?=
 =?utf-8?B?aXlqL2dNRzZpaFVtbUx0bXZSQWhpdVRpUVM5di83aTlhSHZYbmVpMnFsYnhB?=
 =?utf-8?B?VUhVRUFXZDFLU2VjaU5KMWs5YTBDLzIxUDdMdUVDK25KSUFaLzduTjNFVmNl?=
 =?utf-8?B?QTdzQ2NQTkppeGNGT2VIRDB2c3NFbVQ2KzRTOUNJdXJEb3d0emk2ZXRuR3Fk?=
 =?utf-8?B?UTgveFowQUFuWHN4SXBWRHk4ZU0wRjJmWUw5QStEY2hRNk9teHRlaUE1UnAx?=
 =?utf-8?B?bHMzVHJUczhEcTlPQ2VDQnlUU1dFcUFKVFFuRUtWQzZLcWhURTlGeWcrWExZ?=
 =?utf-8?B?NU51ZzBmSzJsQlZGTlNrZnZqNjJpdklGQjJEMG1KYVRzMFFjVHh5d3JWV3RU?=
 =?utf-8?B?Y0tuZ00zUW9EMXJxQlE1Mjk4WHN5R1BaeU14T0dNR2xLZUdqUG43RlVyemx2?=
 =?utf-8?B?dDMxbmhoaW5US1haalJPSER6dVJPV3g4WkRNSHYrc2tMZjFPSUFFbCtneXVU?=
 =?utf-8?B?OU54SE15YjNYSS9ia2JRV3RtTjFUVnFlN04vY0JiSDZEYkp2OHBrZXUxVld4?=
 =?utf-8?B?VC9Zd214aXVubjJndEVhNTZOVGtOM2dvdWxsRFZrb0FCbXhUTldGbUxCVGNR?=
 =?utf-8?B?SjJxRkQvTHkvZXRCc25EaFMyWnI3UUx0dEtFblBYa1l0RHNaMTRwWFZpSzFj?=
 =?utf-8?B?emJVYU8yVEYvWUZXMHVkV2krWTdyeTNCOUUzSXNyWDN3WktUcG5kVlZ6ZUlk?=
 =?utf-8?B?N01JdmZqNE1senVCQTZFWThrZ2tScWtjSnFKbnFjam1aK0ZuN3M5LzlUbERo?=
 =?utf-8?B?Nk00aCtiZXdWUzdXd0RGeHptNmgrVHJOaFNUSWVLWlBESWlaZVg4cTNRMVlB?=
 =?utf-8?B?ZzAzUnVhSEhrY1pib0ZrUVVMWVU0L0VHR1YvaXkxcmdSTE85WlZCY05Ndk1s?=
 =?utf-8?B?Vml6c291cE9NeFJ2Njk0NlhJQUlwWHY3UUZNL1lVMmxnK2d6ZkNDR3RuRS9O?=
 =?utf-8?B?dWZvNkZvZWVIb1RrQ2FocDZwNmlTSmVmTjU4M20weUp3WE41Zkc1MExDOWx3?=
 =?utf-8?B?dm1YWTZ5SVhidFlaOTNPTUo1VWZzUHJwbUo2YlprVDNDT2tEUWk4Tk1SQTdU?=
 =?utf-8?B?d0F4WEl3TTNRcVVvQS9zclQvbU1rei84MWRxTGpxVXBFNXFLYzlGRnFoeWx0?=
 =?utf-8?B?ZkprdXhoRFFCY3ZJM0hER3gxWVhERUZuUFZsOTBvRC9qV01jMUZzdU9LcXA3?=
 =?utf-8?B?Y0NHMWNYWVVKY1YwN0xXL0FZWkVxbG90cWw0T1pDUitLV01PU0Mya1pqaURF?=
 =?utf-8?B?NjFNeFlDYlpkRWlvVjBLSGdwSi9KekpIbzBZV1B2Y0JFdzhUb2IwOGlzZzZo?=
 =?utf-8?Q?Vu1hueLSbumOoDH7il5QQcv6s?=
Content-ID: <9BFDE53B7E087641A50A27C929768D69@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc729c51-e585-4649-c546-08daa05e0288
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 07:58:05.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+CO2CIp4KQLO7WKVB97d6slBgQnJ9iJigzGnyrHDIQS52v/k2wo26jS9/LfLUUVLGxPN3d9RYmq6MOGHUi9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8546
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_005815_230174_B15720F6 
X-CRM114-Status: GOOD (  24.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2022/09/26 16:24, dietmar.hahn@fujitsu.com wrote:
> Hi,
> I have a Linux-dom0 running with Xen. The extraction of the vmcore via
> makdumpfile shows the message:
> get_xen_basic_info_x86_64: Can't get the symbol of xenheap_phys_end.
> 
> The commit 2651d571 changed the behaviour of init_xen_crash_info().
> With
> -       return TRUE;
> +       ret = TRUE;
> +
> +out_error:
> +       free(buf);
> the buffer is released but it's still used because of
> info->xen_crash_info.com = buf;
> This leads to random data in the buffer and later to the mentioned
> error.

Thank you for the report and patch, I missed that at review completely..

> 
> With the change back the memory is not released.
> But I'm not familiar enough with code to decide where to do this.

I've tweaked the patch, does this work for you?

Thanks,
Kazu

--
 From d2c336e0c1bb765675056ca942a884014c257f9a Mon Sep 17 00:00:00 2001
Subject: [PATCH] xen: Fix wrong free issue in init_xen_crash_info()

From: Dietmar Hahn <dietmar.hahn@fujitsu.com>

The commit 2651d5719a21 ("[PATCH 11/14] fix memory leak in
init_xen_crash_info()") changed the behaviour of the function and the
buf variable is always released, but it's still used later when
returning TRUE.  Without the patch, this leads to random data in the
buffer and later to the following error:

   get_xen_basic_info_x86_64: Can't get the symbol of xenheap_phys_end.

Fixes: 2651d5719a21 ("[PATCH 11/14] fix memory leak in init_xen_crash_info()")
Signed-off-by: Dietmar Hahn <dietmar.hahn@fujitsu.com>
Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
  makedumpfile.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 65d1c7c2f02c..ff821ebd3eb0 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9668,7 +9668,6 @@ init_xen_crash_info(void)
  {
  	off_t		offset_xen_crash_info;
  	unsigned long	size_xen_crash_info;
-	int		ret = FALSE;
  	void		*buf;
  
  	get_xen_crash_info(&offset_xen_crash_info, &size_xen_crash_info);
@@ -9710,11 +9709,11 @@ init_xen_crash_info(void)
  	else
  		info->xen_crash_info_v = 0;
  
-	ret = TRUE;
+	return TRUE;
  
  out_error:
  	free(buf);
-	return ret;
+	return FALSE;
  }
  
  int
@@ -12377,6 +12376,8 @@ out:
  			free(info->dump_header);
  		if (info->splitting_info != NULL)
  			free(info->splitting_info);
+		if (info->xen_crash_info.com != NULL)
+			free(info->xen_crash_info.com);
  		if (info->p2m_mfn_frame_list != NULL)
  			free(info->p2m_mfn_frame_list);
  		if (info->page_buf != NULL)
-- 
2.31.1
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
