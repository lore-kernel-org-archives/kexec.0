Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9D8C83F05
	for <kexec@archiver.kernel.org>; Fri,  4 Jul 2025 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0gCmF3nRXRpgylkGNEYRWyo+hhIIs/d2Cl0xX2FJdA=; b=GtCFfuyiwd27GmbAreJB4fDFTJ
	QyNkpQUCMWw3KZLuSM41qKywBzwuoZJDjp2fJlzb6HR+YS2u05hTQ981siZtjaOe5NIL8iRxRJoUB
	eztx2xrLlVf+b0cjbkFjx6Z+fInTz9IZNjfNeOvla84N9DRqSC6XvTF/UB8CcG2Pkix4pNEn/ZHX5
	ppVrTqV7LWlIdU6GuiMBCa5sDrzVO4ZxiADJ0Npffn9+uTqg+4WF1PffBWFbY+gjxcnMYJjcUfJmM
	GDYWtv4Uf2avrrvHFVzsEm4LG7bsyw8ih4kYkm1xlbfNsDkjolHOfZhfefG2eyDcPViaF8N1LfGD1
	bplKgxtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXaEr-0000000DT2A-3j8f;
	Fri, 04 Jul 2025 06:49:37 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXaEo-0000000DT1V-2bR5
	for kexec@lists.infradead.org;
	Fri, 04 Jul 2025 06:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqWuCJj/iQXiYpCLEUr8FYXN25vFisPy1cpn+Nnyuugd6mYLVn/GOTjz9GtNqNxraGU9ZQmnAj52i+V3B5KBlGZMB2iOOatQmbx/peSqx/glPaiPNUznPUN3owfQvTq6DZyJ4SGWE0FNtwwQwCDbSvndDGY6eNliK8Hqi0SPFkZjIH8f4XNaa9Knvw/NpZKQARQkNUooxbftRSmYqXu5bS2dh+LJFbm+Ie4NYdsHsM2xBLKfO/LcbG+rpNoVqIhYtD0pe7D0PM/s84OQYv1y9Wjy3u4MKHuuT0x/faY5deMrBWITehgjjhL+5tz+ychQA3WRLdPYaQT8R4zqsfSmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0gCmF3nRXRpgylkGNEYRWyo+hhIIs/d2Cl0xX2FJdA=;
 b=hDUVSsE+8LO6iBjFlOqz6xvEd/UF0V/9mq92VOQ3CFp7GV1tNryha1qfyoxjMEq7sdq9vDYNskfQsIvbJR9CORPCCmvHvyblySaDmDw+7nDhpSTkLJt7GjZoZ9e/Q86n5gooGYg/wyZ8dSgqL+NHzlqO3n4Uh6N8kIDd0sDggrY46d9+6zpoODudEtFSVfD6OxWkTXKVY8ZC9fBoIXLIxpMtA4TBTgH1TivHC6GKP3AkAxJHAGLVadMj92/7Li467Zdz1gD7YRlv3zVeIH6xglcbi39lG6UbII6YiyJRYzFijXaH3tmrKDaDtuB0MMvWoj3ZloZLvBNOs6sc5f0wzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0gCmF3nRXRpgylkGNEYRWyo+hhIIs/d2Cl0xX2FJdA=;
 b=B04bKthBm/+irXtmnJqXvFkKqaFNShGbL4M+SkG75DEqbnTWcO7anblzb7hAVahIzpu5AfrSn60THTbDOeOS0lazPS1MlAZok52Q1Z103DukT6/X4euqgLilIPh95FO5XxdxJFnZh9MP3jv1dtkWEA5szxhilGWZXd8tXhEqes8+Ooz0k4LL0rSYMUOPNTDsg0ksTs59mdPI9tCArMsveROzLhqnDptgux8wWVe5w6SVWI7dfRNrm5BtYnJkR/B8yBzENB/z44zYuaGUvGEqRkc1EEn/5A/iMwQBk9N+ZdaiMrV4aDRXDqQbbCentddHnKLp+drXqweZN0fhj3uOEw==
Received: from TY3PR01MB9997.jpnprd01.prod.outlook.com (2603:1096:400:1de::7)
 by OSZPR01MB6696.jpnprd01.prod.outlook.com (2603:1096:604:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 06:49:11 +0000
Received: from TY3PR01MB9997.jpnprd01.prod.outlook.com
 ([fe80::f4a0:426:4a25:6122]) by TY3PR01MB9997.jpnprd01.prod.outlook.com
 ([fe80::f4a0:426:4a25:6122%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 06:49:11 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>, Petr Tesarik <ptesarik@suse.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5XiBHM/FX67D1ky3gbRMCQy+FbQc6x0AgAAGMoCAA5HxAIAAh1IAgACJ04A=
Date: Fri, 4 Jul 2025 06:49:10 +0000
Message-ID: <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <20250703163100.603f59f4@mordecai.tesarici.cz>
 <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
In-Reply-To: <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9997:EE_|OSZPR01MB6696:EE_
x-ms-office365-filtering-correlation-id: b61b254f-36f1-4c1e-cd73-08ddbac6e1c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nnp3M0FDK0tUU3c2NGdkYnV3SjgrTUtjZmNIRkcrMitDbzhsTlVVSnZ2c0xu?=
 =?utf-8?B?TEMrM2pMK2pFazk3TWNwc3R3UWlKY2V0cUFobk5XaWN0TU1iQ04zLytidlhy?=
 =?utf-8?B?UTJiOE10ODcvTFRySUdNWEQwYzZrMnlPb1pwWmxGV2dsZFBXOUhGUzJVUEV4?=
 =?utf-8?B?QW9aK1JiN2V2NVh1TGd1SDIydDZkdk5qbmZQM3NBMjdjbHRxR2dOZGZ0aXJw?=
 =?utf-8?B?cDlobjllRTlEWm8ydWVFMDNMQ25YcGFoYVFWN2Z1WVBpSk9rUTJFWi93WmRa?=
 =?utf-8?B?M0M4eERMdlJDQUJNWHEzSFJyaFZIZlJrMktVbEJVaXpkVDM3STFPQldocVJn?=
 =?utf-8?B?MFZOY1JGbzZOSjA1L2NjUU5zWVlZRGFmZmorL0MyanVJUGRaZHV5ZzlSMFgw?=
 =?utf-8?B?bTlkaWR3WXgrRUZUZWQ5WGZZQktnOS92T1pleEQrS3lJVE1Ya3hsS043M1dE?=
 =?utf-8?B?ZWgwaDJWUjhOMVZqQ3NIZ3lnaE4vaUwwQnN2U2RpUW5rbGpqZnVUMjlCSzhO?=
 =?utf-8?B?T1V4WklZd1ZJaE9mVU9yb0tVZEQwM1BjVGJKckorcGRQcUhHOVd5SWdXa3RQ?=
 =?utf-8?B?SERYeG5kbmFjMktRbTUzdWZIbE5ZbDBGaDBZelFPQlVIcnorb0NuK0R5U3ZZ?=
 =?utf-8?B?R1dUcEhQYUY2ZVpkQWtFT0k1eTlDWHVnNHp2c2ZhcHN5NVhWajhsNnZsVWRP?=
 =?utf-8?B?ZEFQQlJXekdLbHZyWGU0QkJXRXB5NVYyUTg1TkFWSzFWRXJIYVR3d2xMYmVB?=
 =?utf-8?B?NUtLZ1NnYTh2b0pmTFBGcEVrZmdoZUt0ZTdIWkZCQ05ObXZISkV6dENXdUcz?=
 =?utf-8?B?UzRZNzBkWitVQkdIbE4zV0ZiT2FGVHZyeFRHYkhQVDRDeWlOME1ycC9reXJT?=
 =?utf-8?B?b1RGRzlPaXdrVjhLWW0yRlZzdjczUk9MTG03MUhrVS9KU0NyYzJQdEhFa0E0?=
 =?utf-8?B?a2k3VGhaUWVrb0VmMkVDUXZtd1hxeUkxWitkKzZybGx5eERWbmdldndsYjJm?=
 =?utf-8?B?c0hNL2Q1N1AzTmlmUGtxNlY0ME1jNGF4VnAxM2R5aHRybEhxZ2QxbytFdzhn?=
 =?utf-8?B?emd1c0t1cTVyRCtscFpqUHN6d3Iyc1p4UStVdlVnME5nbTlqbm1RTzdlNkNk?=
 =?utf-8?B?eFV3cUR1Z0JaM2tIbEJud1psZis4SzB0VFZRRlNrQXJzR2llWi8xekpHYVNV?=
 =?utf-8?B?YnU3TmpiQUlSMklPZHoxRFlEeTlwbHRhV0NlM0hRZTRWQmpWRXpvZ1JBbldU?=
 =?utf-8?B?ZXhtLzlnblE3UWJSbFFMSXIveUovV29jdHlaaWI2WUxsdVlSQVhWdEdGdmNS?=
 =?utf-8?B?YlZuUUNvekN1Yk9zOXp2QnZkVlQ1MHI4dmduYm5OeVpKV01seGFSS1VOcTlO?=
 =?utf-8?B?SkdBdGVVM0ZMcUlVQ3J2Zi9XNHhTUllRT0Vrams2UHQ5d0FMYUdDUDRYWnRs?=
 =?utf-8?B?T0JDeUxaV2djSFR2OHh6V3Mwb2FwVVBCMG9Cb2dTZXczZE9zdjNibjk1UHJq?=
 =?utf-8?B?QTlvbk9mUmQyL05aZG50dU5kNWcvclkzcGNud0k2TkRDK1lqZzhjcEhTQi9G?=
 =?utf-8?B?NG9MWUhMZ2ZvditrbjVkT1lHbG9zclFYajF4RjY0V2tNN29nUWd1OG9ndk1K?=
 =?utf-8?B?MCs2NkthOFdzZ1hrMEx6OEtBS0JoN1kwSGNRcU1wOTZBUGtVblJNTmkrMTlv?=
 =?utf-8?B?aTNOZ215cUJGVTM1L1VzeFgrVWxpV3N1cE9Cd2VjL252aE1PNUVHSE5TZi9i?=
 =?utf-8?B?cS9NYkg5VDJYOUxUQk0xQVJVMUc1ek1TVFRSUXZIUFZmWkd1WmZmQTVjZ1E4?=
 =?utf-8?B?UFgzaE5ic1FCWHBjVTVyZENrWEJhTzhTRGFJTlpGdWRlaTU0OU5Ha3RhZUxQ?=
 =?utf-8?B?S2lKcVFPV1VnWnA2WFhpSGh4UkFFZTdUVkJKSnJtMFplbXI2ZWZCNWkxMFlq?=
 =?utf-8?B?aTV6RVBLQVJpVFpRYnNpVE9MbGI1eEZwcjNMVWZXRkZpV1FkdkdIYVBZRlVs?=
 =?utf-8?Q?i6ocAdOtQNPu1JTHq1SAWr34paEEq8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9997.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5oN1hOVWtGOHAyS2RxMmxLUmNEcjI5QXdwdHU5OURrdWk5N25nSkhaT1N5?=
 =?utf-8?B?bERBR29uajEzOEpHdkxBN0hVaXJLeEhvbnI0bENUZmJCcDVzL1kyMVNFc3c3?=
 =?utf-8?B?QXE5UzZlT1h0bTdiVk1ubzR3RDRLeC9uT2ZodVdXczhZUzE2azVDTzFlYWFF?=
 =?utf-8?B?Rjc4aXc5dERraHhZL2xOYlBsNXh6Q1MyNTFpcWRyYUtkSHQ4SmxmTUdLZVZk?=
 =?utf-8?B?aVdiZUZKemJqdEdUM2Rid2t2a0RIOUJtdmlnNi9PWW43S2FML1FzK1Zrc3hz?=
 =?utf-8?B?YS8vakkrWlpLamdYdTA1bXRYT3FxS0ZpOEljOTZScEdhcWtKTENDMjdUWHQ4?=
 =?utf-8?B?V2NDaVE0NEt1cjVlWForRzFYcUJoeWN4SVdYTEpPVmgxeDZLQ3piNDl6YjBJ?=
 =?utf-8?B?b3cvL21oN3JEL0t3K2pHdEE0QlFJUml6YVlTNktnUmhKNVRId1A2VHJITGdQ?=
 =?utf-8?B?WkJhSi94b3FoQ1RIVVh6czNYckpRK0pTNnRtT3FsbEhJZVBuZTdkMHZIZkx3?=
 =?utf-8?B?cGk3SnpwNTg0eUthZ2N0czhUMG5TSXQ3RzVYNVQxaTZkTFg4S0hqUTVYelRS?=
 =?utf-8?B?cnNDNkZDRFlEVEVyNVhqNytRdnI3U2JoWnI2L29jbEhuMlVSMHVHakloWHlH?=
 =?utf-8?B?RlZZazZmNEdoNlcvb1Bxc3FTdmxZQUxjSjgyQ2Y2cEtObUI2TTBEa1duVlZG?=
 =?utf-8?B?MWtLY0dzOUVHMFlObTFvb3d0N3VJbzZiNEJVNnRSd3RUUlJSeGpPVGZvSkdS?=
 =?utf-8?B?VzlrVDZqQm04VGc3dUhrdC9TaExiVkY3OXlLbnNnUkNldTViUkMxcXB2cS9M?=
 =?utf-8?B?aGhIeUdwem5KMzF4bndObGhMVW80dkFKb1hjSjlqemlvL1ljejJyRUNlN0tR?=
 =?utf-8?B?K0drZjFjN1htY1FwK1d2dXBCV29CME9XYXFXaHY4SjdQU2pNMGhra1czNStX?=
 =?utf-8?B?QmZscUw1RC9xK2dMWmhiYWNwVUFzd3pWQm5DOFJkaU9BOGw1RFRidHlEaUdH?=
 =?utf-8?B?dmFjenpldS9mcXRkK0JkMjgvZUY1cHVSQldNbm0rYW1FZHp1NUljTEZXYlNQ?=
 =?utf-8?B?RHF2dnMrYkRkZkdrRTB1WEFoZWVNbHBQRGhwQTI2K2lDN2tDelNzTW5IejZm?=
 =?utf-8?B?K2lPVTN3S21Ta3RLM2dzUlZuaVRlSUJVY25jQXlrSllSMTdmUEN4YjNlYjln?=
 =?utf-8?B?RGRjenNibTAzWGNlTWVnRnJCdENnS0J6RFFZVTE4Vm1MdGJWbkJ3UVpWUnI2?=
 =?utf-8?B?SmZHcjBXRC9PZVNzMk1PU09lWDhUQS9vZUxHTjZJNU5RTEZuOVpXMTdPaUZX?=
 =?utf-8?B?Yzlvbjgzci94RENMK0U1emtVbDA0UHkrT0ZNNjMvRjVNZlZjbndqV2k3ekt1?=
 =?utf-8?B?S09Rdm1hZXpLNk9YREk1L0xpTGp1OTQzVXVBU05TNFcwZWl6cGJSSk1PV2Zz?=
 =?utf-8?B?Z3BVeGo2Q1F0WWQ2QkJJZUhNb2ppYVV6cFBvZ09BUlYrQzR0b1h6eDREd2hR?=
 =?utf-8?B?dlNEM0FzU1FEay8zd2Vzb0ZadndJM2ozakx3TTFYd2lYc3M4c2puQWNSVlRS?=
 =?utf-8?B?YW1QOGIxSkpMK3FLeXZ0VkptNVdROHhBbDNjbFFNNk1ZNStXZHRrWGlWZmIw?=
 =?utf-8?B?alBoa0ZlbS9iREwyN0ZhR3Z4eE5JWjBiRlNYTmJERS9xZHZ6QTdORldJQ2xi?=
 =?utf-8?B?UXAwMUpqNXpEdG83REMvOWF1SW8yMmNLdnR6UDVzVEpkY2xMek5TTVFSbTRm?=
 =?utf-8?B?ZlVQY3RCZUwxeWxqZWRzV1JqUzBGeG1kRXpCWTlHWUFXTDcrakR0N0Q0YXJL?=
 =?utf-8?B?SWg4UnhWL21SbzRkZithbVNLaXVuK0MybXYyREJpQTRjL0dzRDEzVGE4cnlN?=
 =?utf-8?B?U0hKVFJwUEJGb2ZaRUVqL0JUVVFOWDYxSW5nS2VrOTdVaVJ3dXRMc0hISHhq?=
 =?utf-8?B?WkVPS1RUVWJSN0oyT2Fqa0lhUGRXRUhnSStQdUFxWWxDNEZpS0hXT0l4UzVV?=
 =?utf-8?B?Rm5oQkVaVXBsSXQwRlpWOERaMENrYkdmVThtR1BGSzcySjVmZGh6NGcvTEVz?=
 =?utf-8?B?Nyt4VGRxakRzbWhCbGRTVU5YRjVoVHhma2RCN01VNGpJZUtBbHljakV4Y1Fl?=
 =?utf-8?Q?kVgT2U63AI+D+f3M8fBtf51Ve?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E204838E21391240AF34D45CDDA81E09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9997.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61b254f-36f1-4c1e-cd73-08ddbac6e1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 06:49:11.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV6m9Jwka7c/sl7BerbWEenRmsnndJCTcLzalui73vdcsfCtTX0GAnd4Eo5/+bTjBn9J9zQfyl9icY0b4hP4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6696
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_234934_880650_07E7FBD8 
X-CRM114-Status: GOOD (  23.95  )
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

T24gMjAyNS8wNy8wNCA3OjM1LCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBQZXRyLA0KPiANCj4gT24g
RnJpLCBKdWwgNCwgMjAyNSBhdCAyOjMx4oCvQU0gUGV0ciBUZXNhcmlrIDxwdGVzYXJpa0BzdXNl
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVHVlLCAxIEp1bCAyMDI1IDE5OjU5OjUzICsxMjAwDQo+
PiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+PiBIaSBLYXp1LA0KPj4+
DQo+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KPj4+DQo+Pj4gT24gVHVlLCBKdWwgMSwg
MjAyNSBhdCA3OjM44oCvUE0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKSA8ay1oYWdp
by1hYkBuZWMuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gSGkgVGFvLA0KPj4+Pg0KPj4+PiB0aGFu
ayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4+Pj4NCj4+Pj4gT24gMjAyNS8wNi8yNSAxMToyMywgVGFv
IExpdSB3cm90ZToNCj4+Pj4+IEEgdm1jb3JlIGNvcnJ1cHQgaXNzdWUgaGFzIGJlZW4gbm90aWNl
ZCBpbiBwb3dlcnBjIGFyY2ggWzFdLiBJdCBjYW4gYmUNCj4+Pj4+IHJlcHJvZHVjZWQgd2l0aCB1
cHN0cmVhbSBtYWtlZHVtcGZpbGUuDQo+Pj4+Pg0KPj4+Pj4gV2hlbiBhbmFseXppbmcgdGhlIGNv
cnJ1cHQgdm1jb3JlIHVzaW5nIGNyYXNoLCB0aGUgZm9sbG93aW5nIGVycm9yDQo+Pj4+PiBtZXNz
YWdlIHdpbGwgb3V0cHV0Og0KPj4+Pj4NCj4+Pj4+ICAgICAgIGNyYXNoOiBjb21wcmVzc2VkIGtk
dW1wOiB1bmNvbXByZXNzIGZhaWxlZDogMA0KPj4+Pj4gICAgICAgY3Jhc2g6IHJlYWQgZXJyb3I6
IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGMwMDAxZTJkMmZlNDgwMDAgIHR5cGU6DQo+Pj4+PiAg
ICAgICAiaGFyZGlycSB0aHJlYWRfdW5pb24iDQo+Pj4+PiAgICAgICBjcmFzaDogY2Fubm90IHJl
YWQgaGFyZGlycV9jdHhbOTMwXSBhdCBjMDAwMWUyZDJmZTQ4MDAwDQo+Pj4+PiAgICAgICBjcmFz
aDogY29tcHJlc3NlZCBrZHVtcDogdW5jb21wcmVzcyBmYWlsZWQ6IDANCj4+Pj4+DQo+Pj4+PiBJ
ZiB0aGUgdm1jb3JlIGlzIGdlbmVyYXRlZCB3aXRob3V0IG51bS10aHJlYWRzIG9wdGlvbiwgdGhl
biBubyBzdWNoDQo+Pj4+PiBlcnJvcnMgYXJlIG5vdGljZWQuDQo+Pj4+Pg0KPj4+Pj4gV2l0aCAt
LW51bS10aHJlYWRzPU4gZW5hYmxlZCwgdGhlcmUgd2lsbCBiZSBOIHN1Yi10aHJlYWRzIGNyZWF0
ZWQuIEFsbA0KPj4+Pj4gc3ViLXRocmVhZHMgYXJlIHByb2R1Y2VycyB3aGljaCByZXNwb25zaWJs
ZSBmb3IgbW0gcGFnZSBwcm9jZXNzaW5nLCBlLmcuDQo+Pj4+PiBjb21wcmVzc2lvbi4gVGhlIG1h
aW4gdGhyZWFkIGlzIHRoZSBjb25zdW1lciB3aGljaCByZXNwb25zaWJsZSBmb3INCj4+Pj4+IHdy
aXRpbmcgdGhlIGNvbXByZXNzZWQgZGF0YSBpbnRvIGZpbGUuIHBhZ2VfZmxhZ19idWYtPnJlYWR5
IGlzIHVzZWQgdG8NCj4+Pj4+IHN5bmMgbWFpbiBhbmQgc3ViLXRocmVhZHMuIFdoZW4gYSBzdWIt
dGhyZWFkIGZpbmlzaGVzIHBhZ2UgcHJvY2Vzc2luZywNCj4+Pj4+IGl0IHdpbGwgc2V0IHJlYWR5
IGZsYWcgdG8gYmUgRkxBR19SRUFEWS4gSW4gdGhlIG1lYW50aW1lLCBtYWluIHRocmVhZA0KPj4+
Pj4gbG9vcGx5IGNoZWNrIGFsbCB0aHJlYWRzIG9mIHRoZSByZWFkeSBmbGFncywgYW5kIGJyZWFr
IHRoZSBsb29wIHdoZW4NCj4+Pj4+IGZpbmQgRkxBR19SRUFEWS4NCj4+Pj4NCj4+Pj4gSSd2ZSB0
cmllZCB0byByZXByb2R1Y2UgdGhlIGlzc3VlLCBidXQgSSBjb3VsZG4ndCBvbiB4ODZfNjQuDQo+
Pj4NCj4+PiBZZXMsIEkgY2Fubm90IHJlcHJvZHVjZSBpdCBvbiB4ODZfNjQgZWl0aGVyLCBidXQg
dGhlIGlzc3VlIGlzIHZlcnkNCj4+PiBlYXNpbHkgcmVwcm9kdWNlZCBvbiBwcGM2NCBhcmNoLCB3
aGljaCBpcyB3aGVyZSBvdXIgUUUgcmVwb3J0ZWQuDQo+Pg0KPj4gWWVzLCB0aGlzIGlzIGV4cGVj
dGVkLiBYODYgaW1wbGVtZW50cyBhIHN0cm9uZ2x5IG9yZGVyZWQgbWVtb3J5IG1vZGVsLA0KPj4g
c28gYSAic3RvcmUtdG8tbWVtb3J5IiBpbnN0cnVjdGlvbiBlbnN1cmVzIHRoYXQgdGhlIG5ldyB2
YWx1ZSBpcw0KPj4gaW1tZWRpYXRlbHkgb2JzZXJ2ZWQgYnkgb3RoZXIgQ1BVcy4NCj4+DQo+PiBG
V0lXIHRoZSBjdXJyZW50IGNvZGUgaXMgd3JvbmcgZXZlbiBvbiBYODYsIGJlY2F1c2UgaXQgZG9l
cyBub3RoaW5nIHRvDQo+PiBwcmV2ZW50IGNvbXBpbGVyIG9wdGltaXphdGlvbnMuIFRoZSBjb21w
aWxlciBpcyB0aGVuIGFsbG93ZWQgdG8gcmVvcmRlcg0KPj4gaW5zdHJ1Y3Rpb25zIHNvIHRoYXQg
dGhlIHdyaXRlIHRvIHBhZ2VfZmxhZ19idWYtPnJlYWR5IGhhcHBlbnMgYWZ0ZXINCj4+IG90aGVy
IHdyaXRlczsgd2l0aCBhIGJpdCBvZiBiYWQgc2NoZWR1bGluZyBsdWNrLCB0aGUgY29uc3VtZXIg
dGhyZWFkDQo+PiBtYXkgc2VlIGFuIGluY29uc2lzdGVudCBzdGF0ZSAoZS5nLiByZWFkIGEgc3Rh
bGUgcGFnZV9mbGFnX2J1Zi0+cGZuKS4NCj4+IE5vdGUgdGhhdCB0aGFua3MgdG8gaG93IGNvbXBp
bGVycyBhcmUgZGVzaWduZWQgKHRvZGF5KSwgdGhpcyBpc3N1ZSBpcw0KPj4gbW9yZSBvciBsZXNz
IGh5cG90aGV0aWNhbC4gTmV2ZXJ0aGVsZXNzLCB0aGUgdXNlIG9mIGF0b21pY3MgZml4ZXMgaXQs
DQo+PiBiZWNhdXNlIHRoZXkgYWxzbyBzZXJ2ZSBhcyBtZW1vcnkgYmFycmllcnMuDQoNClRoYW5r
IHlvdSBQZXRyLCBmb3IgdGhlIGluZm9ybWF0aW9uLiAgSSB3YXMgd29uZGVyaW5nIHdoZXRoZXIg
YXRvbWljIA0Kb3BlcmF0aW9ucyBtaWdodCBiZSBuZWNlc3NhcnkgZm9yIHRoZSBvdGhlciBtZW1i
ZXJzIG9mIHBhZ2VfZmxhZ19idWYsIA0KYnV0IGl0IGxvb2tzIGxpa2UgdGhleSB3b24ndCBiZSBu
ZWNlc3NhcnkgaW4gdGhpcyBjYXNlLg0KDQpUaGVuIEkgd2FzIGNvbnZpbmNlZCB0aGF0IHRoZSBp
c3N1ZSB3b3VsZCBiZSBmaXhlZCBieSByZW1vdmluZyB0aGUgDQppbmNvbnNpc3RlbmN5IG9mIHBh
Z2VfZmxhZ19idWYtPnJlYWR5LiAgQW5kIHRoZSBwYXRjaCB0ZXN0ZWQgb2ssIHNvIGFjay4NCg0K
VGhhbmtzLA0KS2F6dQ0KDQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIHlvdXIgZGV0YWlsZWQgZXhw
bGFuYXRpb24sIGl0J3MgdmVyeSBoZWxwZnVsISBJDQo+IGhhdmVuJ3QgdGhvdWdodCBvZiB0aGUg
cG9zc2liaWxpdHkgb2YgaW5zdHJ1Y3Rpb24gcmVvcmRlcmluZyBhbmQNCj4gYXRvbWljX3J3IHBy
ZXZlbnRzIHRoZSByZW9yZGVyLg0KPiANCj4gVGhhbmtzLA0KPiBUYW8gTGl1DQo+IA0KPj4NCj4+
IFBldHIgVA0KPj4=

