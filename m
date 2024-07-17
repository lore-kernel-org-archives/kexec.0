Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD30FC3DA42
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 07:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8DhT2iH4SAadaUfEqhtWz6YDXodRh43ib/zTQ469sfQ=; b=PAbkgy5MN94eSP
	3aW4z222pE+dDcXxBQwtzAdPI3NXzfcvjD5WSBIpswlglhrp0v6sLBCbeo3yY2NFluztYImRI4AJQ
	6MUDm1+QnB9s3sLgZWVjLFY9QRHRBaed+Bs9w0uuxdthlXyREWmjoHej852gFbntpZaenJQy5CHI9
	3l1/G6dINs1AcpN4SAeD8uqVFD2FK5ZzQ5z25scpjRVkk2rx8ytCXpIFH3jWEy8bJWyvrXMZz+Jjj
	yf7Rc8yFY52CjPXCt9ZDUajHkt2EGrHBLVE3iL4Zqf9tCtB2lZjZPPQRN+a0qZE0HtG++NHIPHUh7
	wfjFkbRIAT9sMRuNVHzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzKx-0000000D0qr-2zlY;
	Wed, 17 Jul 2024 07:44:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzKv-0000000D0qX-3rHS
	for kexec@bombadil.infradead.org;
	Wed, 17 Jul 2024 07:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-Description;
	bh=khFbxZlzf3PqEH/pU9ymxAvSfNfOvVQmxmYDIXnQ1Rk=; b=oTXJr8gJAhkFIhnAaLO4NDfkbh
	5XhiyHC/ryKugVOuvFUiFH3jyWCDQo44RbvScFHEPPzyhKZ39QcAkWWm94mN7dYeWqO/b95opx5rD
	tUCe4UZAbElQM5rrXsZ/OdlXWg4dtWuEl6zYk/d7/H5f5ayD8b9AKUjy4u2ldQhkkc+s5806fTtUm
	iv0fPg2S+WMQG3HHtO0/QEn4NmfoGM6k+kPbsT9ilTbdXn8IwP+zb3HxQuzcNQkXJgJaxImyDr0lV
	AfQWEnmnQUXGoriziXzzBsYrxJ/ETs/d4PE8tzv9EF0kYIij42yRqim1P4G+GsSBmDe+auHky7MTd
	VbYrTmjQ==;
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzKr-00000002G3Z-40yF
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 07:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4j58MtUZH4/Jq87RHqWmthaeoKjTu8tGJjkS2TvvxIr3ew8h3UpjQdM6l2mrtBlxfpplbjgPmolqhkzfhfLg46A8SZXw+rf27AkucMDknWL4y2zaXOhjjRMH6YhW9qKYlDG2GTar9vt1K4yO/MBIoCnXCbFVN638cxqvXCJp+NaJi+HUURjaSeu3LlPRjQAhB1UXVpGoNZfbfjRkiUm1WBz/kKIbjpvJPSz5HA1YFxi6qcw+xoNiePiQESNYDRK2Y2ceQYlOki03jjxeB4zs6ZM3E8fVFL5WLuehVmB0Ls/5Vo4aWgAtrxomHRyjZfkFLj7IpkOcr1Z6TV4G+PV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khFbxZlzf3PqEH/pU9ymxAvSfNfOvVQmxmYDIXnQ1Rk=;
 b=U9c9KeZOdJYFiwkAtiOeen1h+UsbNo/TzhOHs/O7761FWizKWhrxPI5KgrwXKAcXeECpopMAS3tsmSseRXppRaxdY7TLYWSjFvYt6THwaufadoJGa0ZkICRByXAkMNWGIwMFpZbqXl7VQc7zGvZEoQfN/8b0cwW2o055E48XAGCp44R74AsqSRMOGdbO/96qtwqu5+dktItFyZuMSqGZm5j2X7WhDgTHzy37Cjczr8k1q/X6+lmRthlqDiUOIaWHrdnMg9G/RPzIsLBEjSw/tPAhgmAt/6rPdGhacgRUQVGJ6KMJmjpmFMpEfEWedIYe3ganAdRAEigfDFodR2vIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khFbxZlzf3PqEH/pU9ymxAvSfNfOvVQmxmYDIXnQ1Rk=;
 b=QxtVqumKTb6I6Whe0JT8uMgtezt10jIR2zMe5U1Lc8fDq4HrZvT3C6axKh6Ex03O3nvuI59//puK6+hGIAdCUtNv6eoCemiYXXY4KbJXky0qRB9lhdZQ8p87o3LvrJ+HrAY4FauDNDToI7/e2RPZZpgdtzFjRDM2v1/AxMTUoMIEVbU8vJfWvnGyAyXQ2CqyWyM2fwZM6F32cTWRcW52o9/qEeYD0HnFBcrGnl35vZhW09/l1sXdQroiBLfxEpyzuHVjaVGE26IDDdWj/JDBf0m6ksqH3FnX0ptbY8WDaMQrNII5sxZ+zhrmWSEsHa7uV8X8W7Q7F8Zyi44cUBpg9w==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by OSZPR01MB8273.jpnprd01.prod.outlook.com
 (2603:1096:604:187::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 07:44:00 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 07:44:00 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Lichen Liu <lichliu@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile: call initial before use cache
Thread-Topic: [PATCH] makedumpfile: call initial before use cache
Thread-Index: AQHaxqMQwxsleF2YyU2gDtYfxt0hF7H6rMAA
Date: Wed, 17 Jul 2024 07:44:00 +0000
Message-ID: <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
References: <20240625015712.3266086-1-lichliu@redhat.com>
In-Reply-To: <20240625015712.3266086-1-lichliu@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|OSZPR01MB8273:EE_
x-ms-office365-filtering-correlation-id: dc614cd1-d842-4c4b-52fc-08dca6343905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UExHeWRqWVc1ckROUlgrYnJBMnprRm1uN0FlTmRmUm95dGprakJGZGtNZWtV?=
 =?utf-8?B?cWJJeGdpaXdlZHdyNkM4cjlYaURNNDR6TzI0UHVLYXhqS0Zaa210MkdkK053?=
 =?utf-8?B?UUNNbHY2MVZZRGlDd2JXWVFiS1RYOFRxcXpzcDhXNGI5ajlmc2d2QjFQeVo2?=
 =?utf-8?B?RjZ1S25HdVlJaUNUVU8zNWhOcktubExBVlUvOFd1bDU0QklpYzdPTUo3R29p?=
 =?utf-8?B?d2EyS0tWbkJoeGlEcTZRM014LzM1bHZRQzgwOUtac2hkbnZ5amVNQWZ1UG8z?=
 =?utf-8?B?N0s0RERoZWNIbWR4VEczcDREdGR6YXVUNlVuZE5OWFJoNS9FODhnTXprNUda?=
 =?utf-8?B?ajU2MEhYZDA4SnFMTWVUMFNhZG1nZExYaVdwREhSOHh6NVU1VVBsZ2dpT0Q1?=
 =?utf-8?B?UlFYZkpWQ1NpL0dOU0piNEprV1E1Ly9zOEpkTTQrTXkrZjZFdDZHR0IwdDQv?=
 =?utf-8?B?VGhpU3BmTC9GbzFOVGdsaHNrVGlBRDNlUE5lTDJ6bjVOTmUvNXBoMSthdnJC?=
 =?utf-8?B?bUhtSC9qOWxlR0VzajBheVNqcE5SMzNqMlpwSWJwZWw1QmhOdzBROXpMV0JZ?=
 =?utf-8?B?VXJVVnV2ZnkxM1hJZjRZY2lDbWQrcHdxOUhGZzU2RndQNU1LaXhMd1pQdUt4?=
 =?utf-8?B?Q2c0c0J0b3E3bi9RTFVpa3dKa2ZqTTJTNlpxYmd3OXVTMmI2b1pPRnpDcy8y?=
 =?utf-8?B?UytJRjJkY0UxTkcvUEI3ZVo1TDJVemVPNXJRZStGaSt6MXRzdndZczcvdzFG?=
 =?utf-8?B?bTFkUXFUa24xTENiYUhITzZaeEZVaG1wQ2svbkgzVHdZSHFUc25Ua2ZtdHFY?=
 =?utf-8?B?eVBDYlkwZkJ6V2F4WnRqbzdYOTFKVWVQeUlhUXc1VGlyUzY4Q0pLSUNkVkhT?=
 =?utf-8?B?aCtYRzJibDltbXREa29LUXBCWTFmTTU5ZWFYaWlxZlQ2OUoxTEdMNld4QVFG?=
 =?utf-8?B?cFc5U0dKdmxpNmZNSkwyR1BWQzN6eVc3TjI2cHVEenFlaWtxNmo3cHF5YlRj?=
 =?utf-8?B?RlJpbEpGbEJyR3QyVm11cjR0eGkxMUtXSDZJUElmdEpCTWkycjVrM1NWQmRN?=
 =?utf-8?B?UEpYaW5wczladE5TTHpiZEdyZnRlNnRjNndsYmplUWtialpXZ3JZbVd2TUp2?=
 =?utf-8?B?MlhnVjR3b0t2dDBPeUk0VmtOYTdNNGJIVzN2YmJnUFMyUTBoR2tGTUVoRkNI?=
 =?utf-8?B?ekI3ZlFzNWw1QytneXRBS2pFTEl2UmJsUnlJOHdrYzY1SEpiVnJ1emhJeDVD?=
 =?utf-8?B?aGpFeUdPZlJCaC9oVmd5bW1wVVJWb0hTUnZra2RqOWxYWWtqM0ZzS0lQSjZ3?=
 =?utf-8?B?V3pzeitQZ2NMaWNMM0dMSkxEcExpTXE3cXorU3FxU3JSQ1VudGpSTS9QOW4r?=
 =?utf-8?B?bzc1T3JqcnJhNm9qbHZ5WEszN1BJTUR5NTA3N1pGQmhPSXFaMERGQmF3U29t?=
 =?utf-8?B?SmhTTjVWZGlRRnhvOVg5eDlxV1BOTU5uaEc4OHZhd1g5MGdKUktIdTNjbUE3?=
 =?utf-8?B?VWhLWSs0Ryt1cmRGU1NuYnIxWUlCWFByMktnVkdZQXJGRWxXU3RDUTNUL3Fy?=
 =?utf-8?B?dDJESStWcjJYeEpmUjJEblVjTlBXVUlyR0prYUlFTUhqd0Z5R1pSd0RxbUVh?=
 =?utf-8?B?dUJFRm1xbEV2Q1BkOUxCcVBJam9uajFibTJnQVRKMmFYUXI5YllXNGErYkZ3?=
 =?utf-8?B?NGRDNHdTckNZQ1BDSWNVbmdkRmRwRnJ0WlVZb3NpNDE0azFWaVJENzVnUHla?=
 =?utf-8?B?UXZsYWhZUlBRMHlhSG5qQXVxM29NM0N6QVJmMnk3akNKT2liTFA3c2E5Nk9q?=
 =?utf-8?B?U0xPWE1UYVh1NndXQmxKejIxdmExK3dkZkNDNENWSDJaZE1VTzVneFc5YUgx?=
 =?utf-8?B?YzhKVk5qU285dGVtL1JNZ2FzeFNqcEUxNkdpQlhyVEkvYnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm9MQ0ZLKzUwWDRhMDVKaFUxeWpXQ21ZeTZMNGtiNXA4Nm1yY3FFbGF0ekFQ?=
 =?utf-8?B?S21PWXZvSHpOZFVxSDlpOTU3QytBR3RpUlR4UWkyZHpCNVZNR2xZOUhraWNG?=
 =?utf-8?B?Q1FnRi9tMWdGQy9uVHdhSkdtdlpoS3NOVjY3YjYyMmlnV3JaZURSWFArc29w?=
 =?utf-8?B?dGxFdC9vNy9FRXZzd2xHVDF6OWJFeXZ4aHZ3RDNWci8vbkYveFlMOU9zeUo5?=
 =?utf-8?B?aXk5S01NL2tnUng4aG1NeVlRYzR1MTl4Q3dXOEM3eVNDMXVmM1ZqWHB5V2JX?=
 =?utf-8?B?d1Boc0p3NnhVUko4Y20wMGV0YnFIVHBHeEJNVG9GdFdIejdneGFqZXFIZmIz?=
 =?utf-8?B?RzZLRlFBeUlLWHhIcFpsbzREUVdoNnpueWRFZGhmUTZCTHBzem5ERFpOei9J?=
 =?utf-8?B?ei80VEEzRDdCNXkvZzQ3YWFaMU1iUTl6RWNTcmlMYVhqalREN0F2MlhiOFBY?=
 =?utf-8?B?T082MFVpWlVQNFZybnNvWVN3L1JGWlZGU0g1V2lOMkcyK2VoT0hMWG1kcngv?=
 =?utf-8?B?TitwWVZuNVBjRmd4RmZ4NFljdTMzYk9nWmRvOTczcDlqVnN3Y3Y4bkFlaXhP?=
 =?utf-8?B?QWkyU3l6MWRwQm15QjZtNCtoV0N3RkwrUjdxVHYzWVN5Y1RvRGRjdXhrRk82?=
 =?utf-8?B?SUxvbHRGRnU5MmNicHJIUmxRY2Y2SWpma3JQWk1iNGZyZWdETlBwdk9TTndp?=
 =?utf-8?B?QW9TODdZV01xcm9pVUNvVmFNU21VTWwxY1VZdzNOdWwvTXcydFQ5N0hHSi9P?=
 =?utf-8?B?bmdKc256WTdHRkZ6V1hTN25wZ2t6SFpyV3h6NnRnZmZQNnhMTWZydmdublVT?=
 =?utf-8?B?MHgyaVFYeVEyRUdScnRUS1NhZUxZNVRDd2hZWGN4UTBNTlA2L1pkS0lPQTFn?=
 =?utf-8?B?Z3IzT0MzQndRSTRXTG9yaEpLYW9Ia1pjOFZxbWdRNTcyRWdSUEhhL2luNWlx?=
 =?utf-8?B?TWVzVG80aVB1Uko4aXZOSGsxNDJRY2lrc05Fa2pvZSsrNXZTMnNnUi8rYmZU?=
 =?utf-8?B?U3FuYmROQXpYTzJGbHJSR3FlcnRLbVcxNy8zU3ZaSnRhOE1IUmpESjZQWjI3?=
 =?utf-8?B?eW5QcXptYzk4cXF3MlBkSVdmRmo5Tk8vOFk3bXRscXAxZlZjbGlDalNhWjlv?=
 =?utf-8?B?V2JIZ2E0S3BCRnJXVkw0ZlNqbTVZNlJzM1IwNXRKbzlSNUpGSU9UOWNnS1dl?=
 =?utf-8?B?YUxEWjdMcm5sYW1DMVIxMXpZODlTZXRBQnc1WFh3NzZHdDNoUXFRSzhjNk1M?=
 =?utf-8?B?SytGQ0pkMW9HSit0blZQRlYyTWpLM1R6NjVpTUFxK2FRcWZ3ZDlUTldkbFpN?=
 =?utf-8?B?emdhNDRoL0lnbzFWQy9FVWNKU2hFSVUzdkI3MzFoRHY2bXovRFVlOGtFWkI5?=
 =?utf-8?B?bW9YblhnOVNjNktRM2ZYVHZxOHREOFBGckZtd2lwNUx2SWZzcUtUUDZTSXlK?=
 =?utf-8?B?VjVGcXVmdnlRS3luajJpQTJPMk5pcW5oYlA2UjdaVjZvZURzVHZHNmdjc0RB?=
 =?utf-8?B?Rzh5eTd0SEJDOEVHOURwR245UGpwUjVpbjBpVjJhcnQ1N2picklqdXBiK1Zl?=
 =?utf-8?B?SWVKZnBMOHZnejR0anJjSTllSlBFMk5RQ3Vnamd4a3V4VmdsZUtyN3BQbnZR?=
 =?utf-8?B?YnBJTlh2bVVvbHVFVjMzdEUvOXNTSDBFVzVsdXIrbkY4bzRhL2dsTC9Yek9E?=
 =?utf-8?B?M2pzR2pHd01ZOE5uSzlIZ1BERkNYcm1FV1ZIVUtYa2UvUEV0dnd3STAycUds?=
 =?utf-8?B?QllCRDFrZkNKTU9iUVlvWnNIaFJGc2NYNmRLUUVoa2hYNXBWdGx0anNFbVFB?=
 =?utf-8?B?UXFXcGhmR3Z5aElzYU5SRHFaQWlhajkzWGF1RlJQN0hEZ0pPVEpGYU5Cc3Bu?=
 =?utf-8?B?azdFQVcvTzBaWDA1RVNPTmovUG1SKzNOb2pERVBKNlU0Mk1tc29iR05QUnZh?=
 =?utf-8?B?YVBSbG1QdHE1WkpWa3A4Q0xSOE0xdG5MUkxUZm9RSG1IOHJ4c083Y2M0OFhk?=
 =?utf-8?B?ajI3Y3RUWGJEN05NcnJ2RkxoZEpGalNjUTVHUk0wV28wOVhPUENKVGVaWG51?=
 =?utf-8?B?TlVNS2FrRDh0MEtDazJjVmxZcGpvZWxXK2FhN1JFZ1c4cjRMd3RlWE5GcTJ6?=
 =?utf-8?Q?95uyPV36nrqwVsXsfjgDNHi/P?=
Content-ID: <B9C13681CC1F86438F61FF32E5E510C6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc614cd1-d842-4c4b-52fc-08dca6343905
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 07:44:00.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vqnOJV1NT7eZyPBbN/p1D2RQvfwt+IbLPV6nD/jmrWuYJd34YH6aQhYzqUJzJMUaCavMcruIgOM+mhThzd7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8273
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_084426_743451_19FD52A7 
X-CRM114-Status: GOOD (  23.20  )
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

Hi Lichen,

sorry for the long delay.

On 2024/06/25 10:57, Lichen Liu wrote:
> Run 'makedumpfile --mem-usage /proc/kcore' will coredump on ppc64, it is
> because show_mem_usage()->get_page_offset()->get_versiondep_info_ppc64()
> ->readmem() use cache before it is inited by initial().
> 
> Currently only ppc64 has this issue because only
> get_versiondep_info_ppc64() call readmem().
> 
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> ---
>   makedumpfile.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 5b34712..6a42264 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -12019,6 +12019,9 @@ int show_mem_usage(void)
>   		DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", vmcoreinfo);
>   	}
>   
> +	if (!initial())
> +		return FALSE;
> +
>   	if (!get_page_offset())
>   		return FALSE;
>   
> @@ -12034,9 +12037,6 @@ int show_mem_usage(void)
>   			return FALSE;
>   	}
>   
> -	if (!initial())
> -		return FALSE;
> -
>   	if (!open_dump_bitmap())
>   		return FALSE;
>   

initial() needs to be called after set_kcore_vmcoreinfo(), when there is 
no vmcoreinfo in /proc/kcore ELF note.

So with the patch, "makedumpfile --mem-usage" fails on kernels that do 
not have a vmcoreinfo in ELF note, e.g. RHEL7 kernel:

   # makedumpfile-dev -f --mem-usage /proc/kcore
   exclude_free_page: Can't get necessary symbols for excluding free pages.

   makedumpfile Failed.


Probably readmem() should not be called before initial() in the first 
place.  I think it's the root cause, but I'm not sure how we can fix it.

A workaround I thought of is that moving get_page_offset() and 
get_phys_base() into the !vmcoreinfo block.  These are needed by 
set_kcore_vmcoreinfo(), so we can avoid calling them if there is a 
vmcoreinfo in ELF note:

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -12019,14 +12019,14 @@ int show_mem_usage(void)
                 DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", 
vmcoreinfo);
         }

-       if (!get_page_offset())
-               return FALSE;
+       if (!vmcoreinfo) {
+               if (!get_page_offset())
+                       return FALSE;

-       /* paddr_to_vaddr() on arm64 needs phys_base. */
-       if (!get_phys_base())
-               return FALSE;
+               /* paddr_to_vaddr() on arm64 needs phys_base. */
+               if (!get_phys_base())
+                       return FALSE;

-       if (!vmcoreinfo) {
                 if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, 
&vmcoreinfo_len))
                         return FALSE;


This will work only for 4.19 and later kernels, but might reduce users 
that hit the issue.  Does this work for you?

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
