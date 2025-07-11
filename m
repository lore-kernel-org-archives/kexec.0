Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D4DC83F1A
	for <kexec@archiver.kernel.org>; Fri, 11 Jul 2025 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Chv1Lu4oVrREPVO4KooFhDZphZpTdIPSRU+5XNB+pa8=; b=hKro4pG+2sQIZKc4FXrgMs9aWN
	o3Kc0ssHEzQ8yycJX9b0V4QYFDcfbm0SK5UVSCUlvyGuSUaHHdHuOTx/LEZK2rk6RgZ9bObYZWvF0
	6giE2L4/CQfiMQpCONxpPl3diGCmQ/Qb/z5Frg6ZXmixGLbX3Lq0HqLYLkhfJAspTy0mM0iThJxqu
	ryFez+bJ80ifuFc68Pleaw57RrNWJQANzHViU5o7w4X9WkK2zD165HeX+Ds/QfNSjRhzxw+QCvKWF
	M8Nxe/baMXZR05TZkoJH3e6pkle0BzUjOSHvxkIvxc7/mrRNFZnGrgpCA1dPhDGwsO0ffcw+mFurr
	w1bwvLMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCbl-0000000EhdF-25ob;
	Fri, 11 Jul 2025 12:12:05 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCZ5-0000000EhFP-1nnB
	for kexec@lists.infradead.org;
	Fri, 11 Jul 2025 12:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh9+2RHriRDqJHSAuPxOkKHEDykhaS/k5qUnBgBwcwiDJnoDA9aJWgd9BRrTg9s50EfRSUHpJdJ0/LrStVqYbFnnDAsIdjBPgHfH3vmOFK2SkchK5h6Ko/NX+pbcQfJU2jVB9kpWb4x1JTXAGnu0vwY2fjsekHnIQKuyA+FGKyooyNv2e3N/owOKubv0kE22GwajT2yqQ8s+CAgmlyJp7RZONlCMhaKklDKA/ZAHkAwjuAZnsbT+2Vp6Iyz2CMrzAM1b2tINKkq6V71y7fOaV+5j2rFHIYUox/akx575s6XQup/4IUOWsalpcaHfYRDA8S1bVVY84zTMTWsbXtCuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chv1Lu4oVrREPVO4KooFhDZphZpTdIPSRU+5XNB+pa8=;
 b=Qj8oZXGoU6Y/3C7/ut0XcvuHsuPhUnAqkBxdd9ct0ODyDa9qoywHCIYtSatvcjuuEsCetNKEbkT84t2/X7qOR2It9C8k+/yHLRsa7lzfCLocGSNVihVkZjTkuXlAUG+KztXp4D1ESfiTwaHYAClKMZ7CGTSybTZHYYLdZd9o1TcfiIWa1W2vSu/xqGrFcoyzJNM6tHIyiyFxY8HEYS0w1U1q/aYDdvF8SPpYk1wl+I45ufRgJGItUzbKzSAZ15ZGi30M8IdrSP525GnvhANpgKa+/zCv7yRnJMWVht+5Wt8TxNeaymkaRhyvNk3ZEL3lBPktXQJe9JS3uga/HrwOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chv1Lu4oVrREPVO4KooFhDZphZpTdIPSRU+5XNB+pa8=;
 b=Jd+jBco7hAn1m8msx+pFvsO14HTeIs9CP70uRsFmf/ymkKir25U9Ogg8GVudA8r66qZ1O2Vh4iaTRqqeDGvdPw6LDd+q3i2SK+vuC6koJ1etad1qGUb+TNDMWm3xPpfO5Ij9QE8xzw9Fj7LLnMClHX75gRrrcSpWrcCBoKy4jOqdpYq5l+QVoXzhpg+6pWsN/hP/ExqLiTBBzpUCfNi8uw3u8p+EX3JpQoSYUQEkOupbnjleLOG4deU2H5Kn/ejY8OTUF3n8TU5TEa74g7REgtV5uEcKM4dp5bWUzXOGXZxGUUEFArznYt0bQstoBV7g5tdqya21pEoW9b0J6rnMww==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by TY7PR01MB16200.jpnprd01.prod.outlook.com
 (2603:1096:405:2a6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 12:08:38 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:08:36 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
CC: Petr Tesarik <ptesarik@suse.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5Xh/Sp712ncgG0uUNhK5s+VqPrQc6zIAgAAGHYCAA5HxAIAAh1IAgACJ+gCAABFIgIAJR90AgAIAXgA=
Date: Fri, 11 Jul 2025 12:08:36 +0000
Message-ID: <004de18c-263a-405d-9d5a-e83d4c391df7@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <20250703163100.603f59f4@mordecai.tesarici.cz>
 <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
 <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com>
 <CAO7dBbWyCJzW14yh25V5xQbdd=Jv2kSzqogXcKCPzE+cp1wv2A@mail.gmail.com>
 <CAO7dBbVanh9oJT_PaMWZ7+3V5Bx2iz7CRNxyGSxfSsfZ5wFv2g@mail.gmail.com>
In-Reply-To: <CAO7dBbVanh9oJT_PaMWZ7+3V5Bx2iz7CRNxyGSxfSsfZ5wFv2g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|TY7PR01MB16200:EE_
x-ms-office365-filtering-correlation-id: 9ff657c8-5e45-4f65-6993-08ddc073aa5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0t4Y2Q1ZUEwb1dBQ3BZcmJFRnh2b2FVOEQxdTNuSVhPMGs3S1FQOElJWUUz?=
 =?utf-8?B?MUV1SjJKV2djYlVwbkltTUhkNWRhelpaSTAxc0d1YXh5ZlE3Y2ppeWRuVnFX?=
 =?utf-8?B?a21nOUNTMXNEUWJYTE9EWThYYnptb1ZCTnNPeWJvamd1Z01ZdjdRSDlrME5t?=
 =?utf-8?B?MnJOc3dNdVdxTFQ2R015eHhWOXdQWnJGaEgyN2NIaFlEbWxObTk2aHF5V3FT?=
 =?utf-8?B?Ylp5MXRicDVHVzFoLzdidk5OMU00SUFWeUF1dEE1YzIzWXdpdW1YZW0vNGV1?=
 =?utf-8?B?bklxK3Rsb211aGNUMkVLRFRjMTZKaWVTWlVhWU1qT3FXSGNTbjkzdVd1SGdF?=
 =?utf-8?B?bURvNGc0RWV4SWlPUEtpUUZ2OGZNZEkvRVFacUl5c2J5SEZQSVo2Y1Y3blhK?=
 =?utf-8?B?VEIvMFJPU3hpeVdzMEZmZWZKd1lpWG43cUo3a09CRzBwNFlTclQvbTcwUGxB?=
 =?utf-8?B?UVViTVd5M2dGQy96WnJnVFA3cEhPSHVHNWtHT1dnb09DUXh2NWNHSUh4UlIx?=
 =?utf-8?B?eDJQdVpaczZBejBTaTlBdXFBUysrUnRIaHhHSFJ0aU9ib3hxWG5DTGthK3g1?=
 =?utf-8?B?Z3VYSHBWbTloMmpOd0hEVGorRVJkZ0tnZnV1Sm1lb1lRYWR5akpEVXFwL1R5?=
 =?utf-8?B?TWwwLytOcGw4dXlrTm9vczVBY1JkeUZUY2k3SlhZMWxyTmNWamxENUdWQWZY?=
 =?utf-8?B?Q01VM1pldDdnL2tjaWgzQzRNK296czZJSnBPOStPelRBTGlDV0NoVGFGOWRa?=
 =?utf-8?B?aWdqUkY3N0kzajZ0L1NSZjVDdmdJZTMweEVuN0M3UTVZU3U0T0JhbE5Kd01o?=
 =?utf-8?B?QTRtTmR2RjVWZTBjcnRLTUtKRXJrNFBHN0wzS1VxWFU0NHgrcWpxMFJNZS8w?=
 =?utf-8?B?ODNNRkNtODZXekxrLyt0WnV3bHpaSHdMYTY4YklQRWFMa3QzN1Z3NW4yTmkx?=
 =?utf-8?B?dXpUY28wSG1CYlFFSlRSQmppVXFXZ2Myd3k2cEZSVGp6WnpBRXkybnNDYXJK?=
 =?utf-8?B?aThlZUVMRFZWQ1c4UHZieGd5WUhHQ1VrZGxNOGY3cm9lazdZcHJTUE92QmpS?=
 =?utf-8?B?K2NVZ2NyeXFBeWFXNXViSVloZ1g4VS9XVUJUdnVsQmJ6V1g0cjh3N1FmNWlo?=
 =?utf-8?B?NEpXME43MEJQa1M4elJjUjVka00wMDlERnBTcWdYb1RacmVENUVmQjRRdWEv?=
 =?utf-8?B?aC82a0ZCTFl3bUUxTWRocFIzTVRjM1dJTVNlSktOcE1tZEVWbDcyd0tJUlBp?=
 =?utf-8?B?YUwybTVjNHhpd0YvbjJwd0lwYzV2YkExUGlJQjdIbWp6a0ZoWTRnV2FkZ0VJ?=
 =?utf-8?B?aDBhdGVkRGpuaDd3VXFmb1ZvV01hZXlyTm02UEtyWEJYS1F1SUdnMFBTZHdF?=
 =?utf-8?B?NUptWERGUCs5M0lKOWhFRTRDWWhWWHFPSDBoN0JjeGFXSG5lYVpiU2F3K1BS?=
 =?utf-8?B?RXloMmgzMEdhb2l5YVkyOWQweTFHK2lVcjVmVkVhcjFmU2xSaWlSa1RZKzBT?=
 =?utf-8?B?WjNhZUtTYTR3Yys5UzBHMWg5YWV3OGVaNCtYb0JJU0lmZTlCcGEzS1cxWWpE?=
 =?utf-8?B?UnJCTmRuVEZYQ0RmR3RLcC93alZDYXlPcEkrcCt4cjV5b0tvTnB4L3hrV0Nu?=
 =?utf-8?B?bHBHM0hHU2xuQ3NqcTlWbk9WOXljblZRdTdpRnkwSzgzVHpsNFJ3QjVYbEJV?=
 =?utf-8?B?N2JFNXdFSWRGVzZKVmhwelpvemFjVVAxNzBpdW5NSHBKODZHZnFHNXozeGc0?=
 =?utf-8?B?azNxSDgxVWphaGw2enFwc0hTYk1iSUJzVUMzNDNiY1JtbU9rNEpKbkF3Q1py?=
 =?utf-8?B?Z2pGUGNjTWtvWjhBaGZMckJFQnNPdTJscEgrdVIrbnJYaTA0cDdnbWczWW5l?=
 =?utf-8?B?SFNSRVFsc1hZaThLMTZ6ekYvZGN5L2pkcGJiRnAyTVZCRGhTT0RQOHlmdS9j?=
 =?utf-8?B?TDlVT3J1b0R2WkVDTFhRa016NEFSZUNwMStrdk5CY3NkSTZpNkZlNkY3Wi83?=
 =?utf-8?B?aTN6d2RlMCtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NnMEZodkU5M1hrVzB0clppbnF2ZFo0dGtRSFE4cGZpcGVLTDZTcjNkZFA1?=
 =?utf-8?B?aFJWMStybHZ5YjFFTUQ5aXhoMG9DZzVoM29kTWNsOW9RaHZramxnd05hRlla?=
 =?utf-8?B?WWdUN2dqOXZ2NndiaFJiTkVXOVllSEZoWVl1SEs4NFEwWmE4TjVQb1ZMclM0?=
 =?utf-8?B?M1owQ2xIMVp1Y1lFN0M2NGtERzE1MkNyTloremJqaGdwaGtVYmxqQ0NvZ0Y2?=
 =?utf-8?B?SytEdENyNWpiV0xncmhFbHJWMmNpRkJXdTVxUGNwNk4zMkVDVlM2QVZRdk9w?=
 =?utf-8?B?aHZyZzIzd0RqKzliTG5aRlVhWjAvVHliMG10UnNjWjF2ZXBhZHowTndwQjFJ?=
 =?utf-8?B?TUc5RVlZZGs1bThnQjgzaEhxbEpBRkl2eUc4cVRrVzJUWE81OE5YY1BDSWlh?=
 =?utf-8?B?bm01dVdxZVNZQ3NhREJjTm5jU1dCSGd3enpGUDk0c2FOcU4wcDdRSGZrQW56?=
 =?utf-8?B?ZWhoZnpZazNaK25WK0diekZ3RUdUc1oxQnpqVllWdFJwUmtqQWQxL1hUS1dO?=
 =?utf-8?B?dEw4U2JsdFNhbUh2dmQ0d2I1aGZ3emk0UjBxKzB2eWMyNUF6Tyt4dDByR3RE?=
 =?utf-8?B?eEtRMXgvZXQzTlZqTk4vNzJRditHQ0xodnFsc1ZKTFlJQk1vYTJBaTl3UTRJ?=
 =?utf-8?B?d0UydGtJenJ4cTArcThBZkJNV2lLTUJCakZmc2lsS09hR1FpTFJXb050NzBN?=
 =?utf-8?B?SnNBVlRrNXJ6UGY2RW9SQzdVUWhBdDJTVUlIeWhTQnErbVFuV2RNeDQ3YTN5?=
 =?utf-8?B?MDdNc2FvekN6MURvQVNkSEZzV2IvUXNVYVMwbCt5VVpubmN4SFUxa2k5eHV1?=
 =?utf-8?B?VDQwbHExL1FkVWs1RW55RU1Idno0eXpBSDBVOUsrSFlZdS9Nb0ZMZVZKbkZo?=
 =?utf-8?B?YzFGdElHeEFZZ2lmYnJEU055ODNXU01CZ0FCTWQzaUdnaDNRczBQcHM3RUhQ?=
 =?utf-8?B?M0VLY3F1d2xDK1JFajB5dXhtQ1ZaQnlCMnJOV3VMMWZzbDJIYkNxTUhmdFhS?=
 =?utf-8?B?bHN0bEZOaTFLaWZvV3FRWTA5VVNoclU0QnBhbis1aURibTlhUzF6NU42UHZ0?=
 =?utf-8?B?VHg3bUo0TXlKdVovcHc2a3RlWnArNEdQNmRNRXowaFhUU3JvR3lsSks5T2xH?=
 =?utf-8?B?NUFGdnViaE5BZjdUWVFydFBZMjVsMVFYaWttakJwdlJiZUdxS0ZUM2tTOXpS?=
 =?utf-8?B?Y1RpTmh5aHNOVGVBanMwY0I5RlNMZVRoSFJkOUFmaW9yR00wOHZVNGVka010?=
 =?utf-8?B?dUZhME9ZaVp4ak1SMFlpRlUyai9FekF0aFZJc0ROUTdCdmRreklPNFF6MXRm?=
 =?utf-8?B?ZTQrS25UdEhNZXBSUE9sb1NFS0cvNTJjQXpURVovSEpwQk9wT3ExS1N2R3J1?=
 =?utf-8?B?L0hiNTZCWnhoNU43YlFsNWdGSmFIdkgwV1NpWG92ZDg5K0FHR25YV0JBYWJs?=
 =?utf-8?B?VzdIYnZpVUdxZ2xkelJBMEYwVHQwRzVxb2xIenQybUU1c2JQMmlLT244NmFn?=
 =?utf-8?B?ZEwvLzlna3ZYeTlKUktJQk9pQXF1WWF2YW9iMlIzTlNMMTVKYzhQaXZUTExS?=
 =?utf-8?B?K25DWXRCcUN2WncwR09nNTJmNGNJY1BzWXUzMXVkMThCbHlMMVlPMzhVZU9R?=
 =?utf-8?B?MG1odTJRbTdNWE45SVdra08vWHJ6cGdySWpXZGRVOUM4ZEo1bW9oOCtmNW0y?=
 =?utf-8?B?Zk1EeEZSZWNZRWRqTktHbmhVb3h2YUpHaCs0ODY0dWk4SUtZVzRHajJnNnNh?=
 =?utf-8?B?T1ZoTzg3UGV3TFVqZnd5YjlkUkRQb3oyTUtsalRvRVgraVNWbm42VlR4cjlW?=
 =?utf-8?B?dFNOMEJNTnFCRElCWHZXTHN2cWJGaHBqZVM5YWhlTkNZVTBIcHJ4ZTdobnRl?=
 =?utf-8?B?YSs4V3I1R1YwZjRsK2J3bkdFbDBDN2hKWTNScENCY2JZUlp0Tml0bjkxQW9k?=
 =?utf-8?B?SzB3S09NN2c0NjJyNHVNZ0ROUVJ0NUROS3dWdTZjWXYxRXdOdjFZYzdOV2Rq?=
 =?utf-8?B?U05yL2NuVzk3d0dsMk05RlB3ME5KWnloQWJnZlhZcitsQWFmQjlpcHoybWlZ?=
 =?utf-8?B?Y2ozQys1b0txTGV5UWc0aUNGVG5KaGhKeWRjWWcrazU0NmlaMmJzUFphSXBJ?=
 =?utf-8?B?bTFJYzc2WWtwMWJSOEUrQ0g3ZlRSSll6WjRLdkVxWS9VR2E5dWJxY1g3T1No?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A20B1E46660D08448A3FD16F0A5CB672@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff657c8-5e45-4f65-6993-08ddc073aa5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 12:08:36.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXKa9yy1XGEdWng81qhkuAr5KozQJV7yxZo50WIRSY3Mu4oFCDWOd2i2yTF4v+AjMX86TfTcViJBctj8oDrEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_050919_724073_CE048D61 
X-CRM114-Status: GOOD (  23.04  )
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

U29ycnksIEknbSBzbyByYXRlLg0KDQpJIGxvb2tlZCBpbnRvIHRoZSBmaXggYW5kIEkgdGhpbmsg
aXQgd2lsbCB3b3JrIHNhZmVseSBvbiBvdGhlcg0KYXJjaGl0ZWN0dXJlcyBhcyB3ZWxsLiBJIHRo
aW5rIGl0IHdpbGwgYWxzbyBzb2x2ZSB0aGUgcHJvYmxlbQ0Kd2l0aCBwcGM2NC4gSSBhY2NlcHQg
YW5kIG1lcmdlIHRoaXMgcGF0Y2guDQoNClRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nIHRoaXMgcHJv
YmxlbSBhbmQgcHJvdmlkaW5nIHRoZSB2ZXJ5DQpkaWZmaWN1bHQgZml4Lg0KDQpUaGFua3MsDQoN
Ck1hc2ENCg0KT24gMjAyNS8wNy8xMCAxNDozNCwgVGFvIExpdSB3cm90ZToNCj4gS2luZGx5IHBp
bmcuLi4NCj4NCj4gU29ycnkgdG8gaW50ZXJydXB0LCBjb3VsZCB5b3UgcGxlYXNlIG1lcmdlIHRo
ZSBwYXRjaCBzaW5jZSB0aGVyZSBhcmUNCj4gZmV3IGJ1Z3Mgd2hpY2ggZGVwZW5kIG9uIHRoZSBi
YWNrcG9ydGluZyBvZiB0aGlzIHBhdGNoPw0KPg0KPiBUaGFua3MsDQo+IFRhbyBMaXUNCj4NCj4N
Cj4gT24gRnJpLCBKdWwgNCwgMjAyNSBhdCA3OjUx4oCvUE0gVGFvIExpdSA8bHRhb0ByZWRoYXQu
Y29tPiB3cm90ZToNCj4+IE9uIEZyaSwgSnVsIDQsIDIwMjUgYXQgNjo0OeKAr1BNIEhBR0lPIEtB
WlVISVRPKOiQqeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6DQo+Pj4g
T24gMjAyNS8wNy8wNCA3OjM1LCBUYW8gTGl1IHdyb3RlOg0KPj4+PiBIaSBQZXRyLA0KPj4+Pg0K
Pj4+PiBPbiBGcmksIEp1bCA0LCAyMDI1IGF0IDI6MzHigK9BTSBQZXRyIFRlc2FyaWsgPHB0ZXNh
cmlrQHN1c2UuY29tPiB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgMSBKdWwgMjAyNSAxOTo1OTo1MyAr
MTIwMA0KPj4+Pj4gVGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+
Pj4gSGkgS2F6dSwNCj4+Pj4+Pg0KPj4+Pj4+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cyENCj4+
Pj4+Pg0KPj4+Pj4+IE9uIFR1ZSwgSnVsIDEsIDIwMjUgYXQgNzozOOKAr1BNIEhBR0lPIEtBWlVI
SVRPKOiQqeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+
IEhpIFRhbywNCj4+Pj4+Pj4NCj4+Pj4+Pj4gdGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IE9uIDIwMjUvMDYvMjUgMTE6MjMsIFRhbyBMaXUgd3JvdGU6DQo+Pj4+Pj4+
PiBBIHZtY29yZSBjb3JydXB0IGlzc3VlIGhhcyBiZWVuIG5vdGljZWQgaW4gcG93ZXJwYyBhcmNo
IFsxXS4gSXQgY2FuIGJlDQo+Pj4+Pj4+PiByZXByb2R1Y2VkIHdpdGggdXBzdHJlYW0gbWFrZWR1
bXBmaWxlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFdoZW4gYW5hbHl6aW5nIHRoZSBjb3JydXB0IHZt
Y29yZSB1c2luZyBjcmFzaCwgdGhlIGZvbGxvd2luZyBlcnJvcg0KPj4+Pj4+Pj4gbWVzc2FnZSB3
aWxsIG91dHB1dDoNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiAgICAgICAgY3Jhc2g6IGNvbXByZXNzZWQg
a2R1bXA6IHVuY29tcHJlc3MgZmFpbGVkOiAwDQo+Pj4+Pj4+PiAgICAgICAgY3Jhc2g6IHJlYWQg
ZXJyb3I6IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGMwMDAxZTJkMmZlNDgwMDAgIHR5cGU6DQo+
Pj4+Pj4+PiAgICAgICAgImhhcmRpcnEgdGhyZWFkX3VuaW9uIg0KPj4+Pj4+Pj4gICAgICAgIGNy
YXNoOiBjYW5ub3QgcmVhZCBoYXJkaXJxX2N0eFs5MzBdIGF0IGMwMDAxZTJkMmZlNDgwMDANCj4+
Pj4+Pj4+ICAgICAgICBjcmFzaDogY29tcHJlc3NlZCBrZHVtcDogdW5jb21wcmVzcyBmYWlsZWQ6
IDANCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJZiB0aGUgdm1jb3JlIGlzIGdlbmVyYXRlZCB3aXRob3V0
IG51bS10aHJlYWRzIG9wdGlvbiwgdGhlbiBubyBzdWNoDQo+Pj4+Pj4+PiBlcnJvcnMgYXJlIG5v
dGljZWQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gV2l0aCAtLW51bS10aHJlYWRzPU4gZW5hYmxlZCwg
dGhlcmUgd2lsbCBiZSBOIHN1Yi10aHJlYWRzIGNyZWF0ZWQuIEFsbA0KPj4+Pj4+Pj4gc3ViLXRo
cmVhZHMgYXJlIHByb2R1Y2VycyB3aGljaCByZXNwb25zaWJsZSBmb3IgbW0gcGFnZSBwcm9jZXNz
aW5nLCBlLmcuDQo+Pj4+Pj4+PiBjb21wcmVzc2lvbi4gVGhlIG1haW4gdGhyZWFkIGlzIHRoZSBj
b25zdW1lciB3aGljaCByZXNwb25zaWJsZSBmb3INCj4+Pj4+Pj4+IHdyaXRpbmcgdGhlIGNvbXBy
ZXNzZWQgZGF0YSBpbnRvIGZpbGUuIHBhZ2VfZmxhZ19idWYtPnJlYWR5IGlzIHVzZWQgdG8NCj4+
Pj4+Pj4+IHN5bmMgbWFpbiBhbmQgc3ViLXRocmVhZHMuIFdoZW4gYSBzdWItdGhyZWFkIGZpbmlz
aGVzIHBhZ2UgcHJvY2Vzc2luZywNCj4+Pj4+Pj4+IGl0IHdpbGwgc2V0IHJlYWR5IGZsYWcgdG8g
YmUgRkxBR19SRUFEWS4gSW4gdGhlIG1lYW50aW1lLCBtYWluIHRocmVhZA0KPj4+Pj4+Pj4gbG9v
cGx5IGNoZWNrIGFsbCB0aHJlYWRzIG9mIHRoZSByZWFkeSBmbGFncywgYW5kIGJyZWFrIHRoZSBs
b29wIHdoZW4NCj4+Pj4+Pj4+IGZpbmQgRkxBR19SRUFEWS4NCj4+Pj4+Pj4gSSd2ZSB0cmllZCB0
byByZXByb2R1Y2UgdGhlIGlzc3VlLCBidXQgSSBjb3VsZG4ndCBvbiB4ODZfNjQuDQo+Pj4+Pj4g
WWVzLCBJIGNhbm5vdCByZXByb2R1Y2UgaXQgb24geDg2XzY0IGVpdGhlciwgYnV0IHRoZSBpc3N1
ZSBpcyB2ZXJ5DQo+Pj4+Pj4gZWFzaWx5IHJlcHJvZHVjZWQgb24gcHBjNjQgYXJjaCwgd2hpY2gg
aXMgd2hlcmUgb3VyIFFFIHJlcG9ydGVkLg0KPj4+Pj4gWWVzLCB0aGlzIGlzIGV4cGVjdGVkLiBY
ODYgaW1wbGVtZW50cyBhIHN0cm9uZ2x5IG9yZGVyZWQgbWVtb3J5IG1vZGVsLA0KPj4+Pj4gc28g
YSAic3RvcmUtdG8tbWVtb3J5IiBpbnN0cnVjdGlvbiBlbnN1cmVzIHRoYXQgdGhlIG5ldyB2YWx1
ZSBpcw0KPj4+Pj4gaW1tZWRpYXRlbHkgb2JzZXJ2ZWQgYnkgb3RoZXIgQ1BVcy4NCj4+Pj4+DQo+
Pj4+PiBGV0lXIHRoZSBjdXJyZW50IGNvZGUgaXMgd3JvbmcgZXZlbiBvbiBYODYsIGJlY2F1c2Ug
aXQgZG9lcyBub3RoaW5nIHRvDQo+Pj4+PiBwcmV2ZW50IGNvbXBpbGVyIG9wdGltaXphdGlvbnMu
IFRoZSBjb21waWxlciBpcyB0aGVuIGFsbG93ZWQgdG8gcmVvcmRlcg0KPj4+Pj4gaW5zdHJ1Y3Rp
b25zIHNvIHRoYXQgdGhlIHdyaXRlIHRvIHBhZ2VfZmxhZ19idWYtPnJlYWR5IGhhcHBlbnMgYWZ0
ZXINCj4+Pj4+IG90aGVyIHdyaXRlczsgd2l0aCBhIGJpdCBvZiBiYWQgc2NoZWR1bGluZyBsdWNr
LCB0aGUgY29uc3VtZXIgdGhyZWFkDQo+Pj4+PiBtYXkgc2VlIGFuIGluY29uc2lzdGVudCBzdGF0
ZSAoZS5nLiByZWFkIGEgc3RhbGUgcGFnZV9mbGFnX2J1Zi0+cGZuKS4NCj4+Pj4+IE5vdGUgdGhh
dCB0aGFua3MgdG8gaG93IGNvbXBpbGVycyBhcmUgZGVzaWduZWQgKHRvZGF5KSwgdGhpcyBpc3N1
ZSBpcw0KPj4+Pj4gbW9yZSBvciBsZXNzIGh5cG90aGV0aWNhbC4gTmV2ZXJ0aGVsZXNzLCB0aGUg
dXNlIG9mIGF0b21pY3MgZml4ZXMgaXQsDQo+Pj4+PiBiZWNhdXNlIHRoZXkgYWxzbyBzZXJ2ZSBh
cyBtZW1vcnkgYmFycmllcnMuDQo+Pj4gVGhhbmsgeW91IFBldHIsIGZvciB0aGUgaW5mb3JtYXRp
b24uICBJIHdhcyB3b25kZXJpbmcgd2hldGhlciBhdG9taWMNCj4+PiBvcGVyYXRpb25zIG1pZ2h0
IGJlIG5lY2Vzc2FyeSBmb3IgdGhlIG90aGVyIG1lbWJlcnMgb2YgcGFnZV9mbGFnX2J1ZiwNCj4+
PiBidXQgaXQgbG9va3MgbGlrZSB0aGV5IHdvbid0IGJlIG5lY2Vzc2FyeSBpbiB0aGlzIGNhc2Uu
DQo+Pj4NCj4+PiBUaGVuIEkgd2FzIGNvbnZpbmNlZCB0aGF0IHRoZSBpc3N1ZSB3b3VsZCBiZSBm
aXhlZCBieSByZW1vdmluZyB0aGUNCj4+PiBpbmNvbnNpc3RlbmN5IG9mIHBhZ2VfZmxhZ19idWYt
PnJlYWR5LiAgQW5kIHRoZSBwYXRjaCB0ZXN0ZWQgb2ssIHNvIGFjay4NCj4+Pg0KPj4gVGhhbmsg
eW91IGFsbCBmb3IgdGhlIHBhdGNoIHJldmlldywgcGF0Y2ggdGVzdGluZyBhbmQgY29tbWVudHMs
IHRoZXNlDQo+PiBoYXZlIGJlZW4gc28gaGVscGZ1bCENCj4+DQo+PiBUaGFua3MsDQo+PiBUYW8g
TGl1DQo+Pg0KPj4+IFRoYW5rcywNCj4+PiBLYXp1DQo+Pj4NCj4+Pj4gVGhhbmtzIGEgbG90IGZv
ciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uLCBpdCdzIHZlcnkgaGVscGZ1bCEgSQ0KPj4+PiBo
YXZlbid0IHRob3VnaHQgb2YgdGhlIHBvc3NpYmlsaXR5IG9mIGluc3RydWN0aW9uIHJlb3JkZXJp
bmcgYW5kDQo+Pj4+IGF0b21pY19ydyBwcmV2ZW50cyB0aGUgcmVvcmRlci4NCj4+Pj4NCj4+Pj4g
VGhhbmtzLA0KPj4+PiBUYW8gTGl1DQo+Pj4+DQo+Pj4+PiBQZXRyIFQNCj4+Pj4+

