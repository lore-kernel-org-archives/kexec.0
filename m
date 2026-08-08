Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B9C55174
	for <kexec@archiver.kernel.org>; Sat,  8 Aug 2026 04:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ly91dvhSdt2YOhRLKQhaseTRpJSujn0I1zd0nCQq+no=; b=FYnXhxZX/lJ0g6ESPVCyj1y21I
	DV1+ke1lK6r/H9GkScXJyY6kvCdanJwvXJlKHWuB3X6jK0MhE8gpXQDouLKSReWX9SDY8WFQsdnqE
	nz2qthxOEoEAQ/iBKekZNDR6+jVIJ3hDjNGguYB4pZeTeNVQtq4VPFzK2LoBjDN6LXT3GUbMHytG8
	+UrSyzn9E2DVw9Mmr0rWubxtBqQE6ZDVp59mBBFsH1Cv7aL/TcdSNXJyW7CD2V67O9ORoTz8B1gcx
	1HOyNH4XNhrTdpX31L4uXLppp9NRWAIcpto88MNkKEFyXUW9xC1eIMEm7hYOB3zGnyi/po6CoXEtg
	rk5SvV3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsYwC-000000093Lw-0wbU;
	Sat, 08 Aug 2026 04:45:36 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsYw5-000000093LS-02Fl
	for kexec@lists.infradead.org;
	Sat, 08 Aug 2026 04:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N87KlOb4GT8/eixJmubFMpgv8cy8GVGvSZLbUBhT7g1s5ZC4CUQ2W1QDJZgNo4LtQ9CrB3YP8rlhl1DawGQIoOprssfbOk6GDGAf3bsJu77EPzfvE+/sPz9SxlTym915yqJPG5L8ZpKA4fkyUUmWD0WzHvt6vfhORIDyANVYWn8a/S7ocZjj5QQuDwDagYsp5t22V8LS8EYNeJJgtQtLtAAsNYcsEcUbfk07EGYkqBeUZNGQMxX6t7KwMk6WVYhkzgfPMjAnyQtB8NmUmfEZortWAQKPgjWGSQlvoJDPtSMtHmogSxPGQdrGqTl4NtdLAgfgZTKUD5nYfSxRe8UpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly91dvhSdt2YOhRLKQhaseTRpJSujn0I1zd0nCQq+no=;
 b=YqUiXF/LK6SAIRs7uGd/VPiCKMC9DxHz1A08yNkiRaV9xbPDJGp+dxDaxlrWSnnn5hCbpjyjpo/scWRxjRNpTYGgdldW9Qi+SiFgIIF0oOHb6y7MkaeROGdgeuCkpm0d6GEeZ30zsrP+AANjHDJQ04c/wmJs1NgriIWo9xTO8Srfio4LFPoAsojKxbVR1ELAR2TjAlPJqFDT3efGds9jsNU77642hLuhiBvVldXqmwNyqgoCWg4P+tqYtaUvMlb6sd8q1yq1SiRcKuWzjjCTfkAsqT9J97goHhmXvv09z+VkYh/ZOKNjMpwbqa/7sFbjovirioq1S8lz88FhHMDa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly91dvhSdt2YOhRLKQhaseTRpJSujn0I1zd0nCQq+no=;
 b=WLarU+uEhOJEqXW3LV1nruVl2Qlf4xeuRobwceKD4+/CEdgnTgq6BuesrD/kH3CxQrSE0X1hyjDS7j3wAunq5zcd+QedQd/Sb77+JOK1eadXO1HOVnL+5yjp0UTAeekaM+nAMHjxcHP++1wOcKeTdoXFBIq3Bg9NsJoaF0xIWZS7bYX+SzlIfSfFwp5b2fJintsyxKMhdem2Y+hTPa0Urp/U/nkhJCWwqdj0PjeX+5z1KPm3J75KmVxo8Xzi01I7sU2+mqt3QNG0BYN9ItStmYzQ9lmGQUn0DarZvjX2XKjEpb+ljaqaZ4Wl93M/9sE5SXA3iF3wr1wGUBZoz0d8AQ==
Received: from OSCPR01MB13470.jpnprd01.prod.outlook.com
 (2603:1096:604:32e::10) by TY4PR01MB14234.jpnprd01.prod.outlook.com
 (2603:1096:405:207::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 04:44:53 +0000
Received: from OSCPR01MB13470.jpnprd01.prod.outlook.com
 ([fe80::907a:26d8:8ee2:3e50]) by OSCPR01MB13470.jpnprd01.prod.outlook.com
 ([fe80::907a:26d8:8ee2:3e50%6]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 04:44:52 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
Thread-Topic: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
Thread-Index: AQHdEyorXwwQdBKvLk6+FbOcta264LaR+EQAgABmUoCAAOFbAIAAeusA
Date: Sat, 8 Aug 2026 04:44:52 +0000
Message-ID: <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
 <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com>
In-Reply-To: <87tsp539pr.fsf@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13470:EE_|TY4PR01MB14234:EE_
x-ms-office365-filtering-correlation-id: 19648b03-fd42-421b-1659-08def507c98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|13003099007|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0ROmFWtxW+UpNtr/AxS0OD/91cq0zhz5qk543krfkoNqYVjnaDAStBXqNJ7kQ7/EU//PtWfEo0yuoG1v87V3SA+WmWjjS0+rFVZdu88tUILH35tag0c/8WH9aGKHmZEccbt8fhYAxpSPUUTlV4BMn6IUnR3N06XIs4AGn2GZjL5VjIXFdyOCMiGH29g/9IfLTmZ1vpb3HzTWoldBQmiY2W+OZYFmsO6AJTaSKu5nY9IdU/jodB4KKhWWq5xyu2IQO+JOY6cc0NRw6IiinzgGnA2xzDeKCrocgbLmeVE21RCOOED23dOQEvA7XucSO3/DcGTEMgtklg+gAsqP5r1fMY0G3UOFiMKFLbLX94hwhvrQ8bUUVSarkqFx7kEuZb/sMLu2ZbF9L/OhPwhBxhPggzwrUmFtdt7PguxrqavPOHsIioFrfzDQoiW8OwEgvdSrWAhzKAS+vnwBwNua++6nlYhOizcpQN66VLDj1+8oeCFqzYMdM4Ck6l1u7Ta5JLpTkxTtm1kAQTQZSoguVxIqKrkokqFxJBd2ndw/TrCMwlblXO1EFK4Jd4qDKDh3wMzpZy0qZNVq9NbS2o7/fBT4PzbKc/yGjt0KsUsV0Dv9ESRye28HvjQJX+w8x428E7kzbSU5WD1Y5QxSAIJ2SkFjgDVkA2JSPVUT5bBP8SYEolBqSACEXIYy81aiUJamDR0uzoAjU7d+a0qz+v9WHk3AuhrYyNYNzyV1wlxwAQHxZrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13470.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3VFK28vcStwNFJsSVlwVjEreUZNVDllaCtISWRoVkx2WStySUZhZkZwZ0Vt?=
 =?utf-8?B?NGZoV1RjY0F2eUpoOVhnSUFwSnArcTVkVzRPM3lsekQrZDRXODdxcFI2bytL?=
 =?utf-8?B?TllvcmhSb29pb3M3ZGExYXQ1QlpqTitkMCtGQitmdXlCYmY5b1VJWWtUMEpJ?=
 =?utf-8?B?VTJSTUNJR0tlbm1MY0IxUGI4cHIwOE9YdjRpVzRrTjl1YkNPSGowK3RPQ0Vp?=
 =?utf-8?B?SllOMWhKSWdUVm9MdmYzUHZ5UXpNNnJRRWlYL3VwUklKOWFid1duUjFrZ1JN?=
 =?utf-8?B?K0x6RFVFMzVQeitoamh2UllYaE1waTViN2xyRm5Yd21XV01ub0VxOVNmTWNW?=
 =?utf-8?B?V016T3lVbU1leUN1a1B4THZOZ095dFJ1TVhyQlBMenlBOENIelRSSm0zSE1o?=
 =?utf-8?B?TEZrLyt1TXJzMFR2QVcwdEhWcjVsT1pNQXlZQUQrTXpHSDBndXJST3E5cFlo?=
 =?utf-8?B?TWNkaTZyYmhhczZ4dlVlUFFjaWZwL2VPWlVPM1hKNDJOd3pmUGQ5eGVyeEI2?=
 =?utf-8?B?OWpNeUVad3M0OURNZWZVYTllUGpyZVBGMmRyOWVIdlhzVDhSWEtKMWR4NHl3?=
 =?utf-8?B?WUM2RUxlbjBHekFPNkVnblcyRE1sUyttV1hwVmRIZDhUOVJZTHZWeHk1bTN0?=
 =?utf-8?B?cW52dXI3c2tML0dOZkNoYlZsRzg1TGJKVGxVWkV1OXNiMUtqZ3BnUzYzZUZh?=
 =?utf-8?B?dlVrWEVzQnRvd1pSd3FxSTJYMVBlT2I5ZmNHck1pN1NOTGlQUnZ0T2kzRjZX?=
 =?utf-8?B?R0lxUHBNQnlHNGxNSmNhaVE2ZTBXWXFlLzJvVmI1VXFNV2JObVluQ3VENFlZ?=
 =?utf-8?B?UXV1NzZ3RVQxQ3ZZNjF4dGt5OXpvbWpkU3kvSWtQMjlmU2lRb1ZhUmM2VldL?=
 =?utf-8?B?TUdMZldnZlJnUU5LcGdyREVWanFObi96YnlJS2l5L1NkdDlvSDJRWm9jMFE4?=
 =?utf-8?B?aGIrbmczYzhZUnN3aEI3RFYzTU5VTGJiUFkyd1BhVCsxNkNld3Y3cklKcFJz?=
 =?utf-8?B?T04rWXNaVDlsMWs4WWlpcG9zZVdzenF1b2xqeEpaa0RTUnoxWFlma08va1N5?=
 =?utf-8?B?RGsvcDdOZ01hQ21xbTBZek9tRGpSSzdGVE1yRU5ia3VKUFUvaDJFeWdiWCtj?=
 =?utf-8?B?aVQrSFFRM2kzdENNNHBtM3FIWG1JcDZ3UnhkM05EaThPcVc0b2VYa3h5S1Yr?=
 =?utf-8?B?RWtoK0NqbGRiOHZjclRpMlA0NnhiczZGMVdPOFZQRUxMRmJrc1plK2c4OXdw?=
 =?utf-8?B?aEJCMEY4N0JvclMxYnhrK2djODQ1eXVUaHNZdFFhQVRNQ0dwVEpnc0t0cWlB?=
 =?utf-8?B?MDVoWFhhL2FHQXNDbXFCcVllY0pWaHhPeGg4K2JFSWJ3RGlQTE5GZkFwdTk0?=
 =?utf-8?B?bUsxOURzRSs2WDFOY1lKS0owWEZpOWtwNnlVbjR1alBMTyt1OUNFUktiSXl6?=
 =?utf-8?B?NlZJRjlwVFUyam1jMWMrTEZSWldaY0p0Q2VjTEZrLzY0MHUrTHNkbDNweVU1?=
 =?utf-8?B?QnM0eHFiQUJIeHIxVkJDVTVtVk9pdFBuVmJ3elZzUW1aVS9DS2x0SVF5QnVk?=
 =?utf-8?B?ZFk3UUxuSnV3TGVwYzB6VlVGTHVLakhEa0FqMmlmYnZndW5IK2tNNXFzSUVT?=
 =?utf-8?B?ZjRSalErc1BFaXFXRXZxRXQvdjE2Zy9yZkx3V3FIOXJvVExVdHNGVkJVZGRj?=
 =?utf-8?B?ZGdhRXR0UEplRTJ4ajJTKzV6WVB5U2h0dEpHR2hwOGx5V1d3Wm5DOHlhM2wz?=
 =?utf-8?B?YVltTnlYUDV4Y3FSbERLOFJMUjFQUUlxelhwQnA4RzQ1UFA5MC9UOW9yTVFC?=
 =?utf-8?B?WWZiQWVuS01BWTd5QTVXTjJRVEFBOTg1cXpTL1ZBSEdzVnFtTjJ0bEUyWjY0?=
 =?utf-8?B?M0VhYjBzaW8vK09NZmFVTnJxUlVBNXlmMElnNXltM01yK1kwQjQxbUtQRVNS?=
 =?utf-8?B?V3o5N0RoMjF6bFFTUTRUN1lDRVJxS0JKb3dWTUhkS0pjUFlXVGE4c2dSeVRs?=
 =?utf-8?B?SVpnZXE2Q3YzWlByY216MStON3pnbXM4L1JVUGN1bU80UnpWTjJQMlh3cWxz?=
 =?utf-8?B?MTBmY20zWlQxdEVIOTFWQUJoemcyR3krdEwrQzNRcCtGblE3MnRtU3ZqcHM3?=
 =?utf-8?B?aWo4eGw1WWRoZHhjVldqSnZnU1hCb0JDMkptWFpFM0FzNVJUZGwxZHVKbEd1?=
 =?utf-8?B?Q29JRFFqc1ZFUytJSnlhREFJT1FOMXZBbkVWM25wMWpMeTlVWHdBa3lpc2di?=
 =?utf-8?B?TkwreWY1OVJSbURqTDVwUGpCZElkaS9URGlOODlJN1NMUmhST3BVc3RwaVpM?=
 =?utf-8?B?cW9VQXo2N0xUbmRvb3BpV3J0UDQ1RkVnMHJZeXFNa2Q1Ni9jR2wvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <269DEC9B5E83194D8660C2BE21FDEF2E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13470.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19648b03-fd42-421b-1659-08def507c98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 04:44:52.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc/UVuUnmZYrYW1lvX1IqZ6R0F8QJ9tDki4PEAoO3Yd91PQol1yXbDLGU/40z1Bt1w1mmPOzLZHUPkmpOkkvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14234
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_214529_360844_AA70D83E 
X-CRM114-Status: GOOD (  25.39  )
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

SGkgU3RlcGhlbiwgVGFvLA0KDQpPbiAyMDI2LzA4LzA4IDY6MjQsIFN0ZXBoZW4gQnJlbm5hbiB3
cm90ZToNCg0KPj4+IEZvciB1c2VyIGFjY2VzcywgSSdtIHRoaW5raW5nIGFib3V0IGFkZGluZyBt
YWtlZHVtcGZpbGUgZXh0ZW5zaW9uIGxpc3QNCj4+PiB0byBpdHMgd2lraSBwYWdlIFsxXS4gIElm
IHlvdSBhZ3JlZSBvbiB0aGlzLCBwbGVhc2UgcHJvdmlkZSB0aGVpcg0KPj4+IGluZm9ybWF0aW9u
IChleHRlbnNpb24gbmFtZSwgYXV0aG9yLCBsaW5rLCBkZXNjcmlwdGlvbikuDQo+IA0KPiBIZXJl
IGFyZSBtaW5lOg0KPiANCj4gLSBFeHRlbnNpb24gTmFtZTogZWxmaGVhZGVyDQo+ICAgIEF1dGhv
cjogU3RlcGhlbiBCcmVubmFuIChteSBlbWFpbCkNCj4gICAgTGluazogVEJEIC0gc2VlIGJlbG93
DQo+ICAgIERlc2NyaXB0aW9uOiBJbmNsdWRlcyB0aGUgZmlyc3QgcGFnZSBvZiBhbnkgRUxGIGZp
bGUgaW4gdGhlIHBhZ2UgY2FjaGUNCj4gICAgd2hpY2ggaXMgbWFwcGVkIHRvIHVzZXJzcGFjZS4g
VGhpcyBpbnNwaXJlZCBieSBiaXQgNCBvZg0KPiAgICBjb3JlZHVtcF9maWx0ZXIgKHNlZSBjb3Jl
KDUpKSBmb3IgdXNlcnNwYWNlIGNvcmUgZHVtcHMuIEJ5IGluY2x1ZGluZw0KPiAgICB0aGUgaGVh
ZGVyIG9mIGFuIEVMRiBmaWxlLCBpdCdzIGxpa2VseSB0aGF0IGEgZGVidWdnZXIgY2FuIGlkZW50
aWZ5DQo+ICAgIGl0cyBidWlsZCBJRCBhbmQgdXNlIHRoYXQgdG8gZmluZCBkZWJ1Z2dpbmcgaW5m
b3JtYXRpb24gZm9yIGl0LiBUaGlzDQo+ICAgIGhlbHBzIHdoZW4gdXNlZCBpbiBjb21iaW5hdGlv
biB3aXRoIHRoZSB1c2Vyc3RhY2sgZXh0ZW5zaW9uLg0KPiAtIEV4dGVuc2lvbiBOYW1lOiB1c2Vy
c3RhY2sNCj4gICAgQXV0aG9yOiBTdGVwaGVuIEJyZW5uYW4gKG15IGVtYWlsKQ0KPiAgICBMaW5r
OiBUQkQgLSBzZWUgYmVsb3cNCj4gICAgRGVzY3JpcHRpb246IEF0dGVtcHRzIHRvIGluY2x1ZGUg
dGhlIG1lbW9yeSBwYWdlcyBmb3IgZWFjaCB1c2Vyc3BhY2UNCj4gICAgdGhyZWFkJ3Mgc3RhY2su
IFRoaXMgY2FuIG1ha2UgaXQgcG9zc2libGUgdG8gdW53aW5kIHVzZXJzcGFjZSBwcm9jZXNzDQo+
ICAgIHN0YWNrcyB1c2luZyBhIHZtY29yZSwgZm9yIGV4YW1wbGUgd2l0aCBkcmduJ3MgY29udHJp
Yi9wc3RhY2sucHkNCj4gICAgc2NyaXB0Lg0KDQpUaGFua3MsIEkgY29waWVkIHRoaXMgdG8gc2Vl
IGhvdyBpdCBsb29rcy4NCmh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1bXBm
aWxlL3dpa2kjZXh0ZW5zaW9ucw0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFu
eSBwb2ludHMgb2YgY29uY2Vybi4NCg0KPj4+ICogQ291bGQgeW91IGFkZCBhIGRlc2NyaXB0aW9u
IHdoeSBQR19JTkNMVURFX0hFQUQgaXMgbmVlZGVkIHRvIHRoZQ0KPj4+IHBhdGNoIDcsIGFzIHdl
IGNhbm5vdCBhZGQgdGhlIGNvdmVyIGxldHRlciBhbmQgdGhlIHBhdGNoIDkuDQo+Pj4gKFRleHQg
YWxvbmUgaXMgb2ssIG9yIHlvdSBjYW4gdXNlIHYyIGp1c3QgZm9yIHRoZSBwYXRjaCA3LikNCj4g
DQo+IERvbmUgYXMgYSB0ZXh0IHJlcGx5IHRvIHBhdGNoIDcuDQoNClRoYW5rcywgd2lsbCB1c2Ug
dGhhdC4NCg0KPj4+IGFuZCBUYW8sIHBsZWFzZSBjaGVjayBpZiB5b3VyIGV4dGVuc2lvbiBjYW4g
YmUgcmViYXNlZCBvbiB0aGlzDQo+Pj4gcGF0Y2hzZXQuICBhbmQgYWxzbyBpZiB5b3UgYWdyZWUg
dGhlIGV4dGVuc2lvbiBsaXN0LCBwbGVhc2UgcHJvdmlkZQ0KPj4+IHRoZSBpbmZvcm1hdGlvbi4N
Cj4+DQo+PiBTdXJlLCBJIHdpbGwgY2hlY2sgZm9yIHRoZSByZWJhc2UuIEluIHRoZSBtZWFudGlt
ZSwgd2lsbCB0aGUNCj4+IGV4dGVuc2lvbnMgdG8gYmUgbWFpbnRhaW5lZCBpbiBvbmUgcmVwbyAo
ZS5nLiBtYWtlZHVtcGZpbGUgZXh0ZW5zaW9ucw0KPj4gcmVwbywgc28gZXZlcnlvbmUgY2FuIFBS
IHRvIGl0KSwgb3IgdGhleSBhcmUgbWFpbnRhaW5lZCBpbiBlYWNoIG9mDQo+PiBpbmRpdmlkdWFs
IHJlcG9zLCBhbmQgbGluayB0aGVtIHVuZGVyDQo+PiBodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1
bXBmaWxlL21ha2VkdW1wZmlsZS93aWtpI2V4dGVuc2lvbnM/DQo+IA0KPiBJIGFtIG9wZW4gdG8g
ZWl0aGVyLiBJIHdvdWxkIGJlIHdpbGxpbmcgdG8gY28tbWFpbnRhaW4gYW4gZXh0ZW5zaW9ucw0K
PiByZXBvc2l0b3J5IHdpdGggVGFvLCBmb3IgZXhhbXBsZSBhdCBnaXRodWIuY29tL21ha2VkdW1w
ZmlsZS9leHRlbnNpb25zLA0KPiBzbyB0aGF0IHRoZXJlIGlzIGEgY29tbW9uIHBsYWNlIHRvIGNv
bnRyaWJ1dGUuIFRoYXQgaXMsIGlmIHRoaXMNCj4gYXJyYW5nZW1lbnQgd291bGQgd29yayBmb3Ig
YWxsPw0KPiANCj4gSWYgd2UgZGlkIGNyZWF0ZSBhIGNvbW1vbiByZXBvc2l0b3J5LCBJIHRoaW5r
IHdlJ2Qgd2FudCB0byBzZXQgdXAgc29tZQ0KPiBleHBlY3RhdGlvbnMgb24gdGhlIHF1YWxpdHkg
JiBtYWludGVuYW5jZS4gRUcsIHNvbWUgbWF5IGJlIG1hcmtlZCBhcw0KPiAibWFpbnRhaW5lZCIg
d2l0aCBhIG1haW50YWluZXIgYW5kIGEgc2NvcGUgb2YgbWFpbnRlbmFuY2UgKHN1cHBvcnRlZA0K
PiBrZXJuZWwgdmVyc2lvbnMsIHN1cHBvcnRlZCBhcmNoaXRlY3R1cmVzLCBldGMpLCBhbmQgb3Ro
ZXJzIGFzDQo+ICJ1bm1haW50YWluZWQiLCB3aGVyZSB3ZSBqdXN0IG1ha2Ugc3VyZSB0aGF0IHRo
ZXkgYnVpbGQgJiBydW4gd2l0aA0KPiBtYWtlZHVtcGZpbGUsIGJ1dCBkb24ndCB2YWxpZGF0ZSB0
aGVpciBiZWhhdmlvciBvbiBzcGVjaWZpYyBrZXJuZWxzIG9yDQo+IGFyY2hpdGVjdHVyZXMuDQo+
IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgaXQncyBwcmVmZXJhYmxlIHRvIHN0YXkgc2VwYXJh
dGUsIHRoZW4gSSdtIGhhcHB5DQo+IHRvIGZpbmQgYW5vdGhlciBwbGFjZSB0byBtYWludGFpbiB0
aGUgdXNlcnN0YWNrICYgZWxmaGVhZGVyIGV4dGVuc2lvbnMuDQoNCkkgd2FzIHRoaW5raW5nIG9m
IHNlcGFyYXRlIHJlcG9zaXRvcmllcy4gIEEgc2luZ2xlIHJlcG9zaXRvcnkgd291bGQgYmUNCmZp
bmUsIGJ1dCBmb3Igbm93IEkgaGF2ZSBubyBwbGFucyB0byBjcmVhdGUgb25lIHdpdGhpbiB0aGUg
bWFrZWR1bXBmaWxlDQpvcmdhbml6YXRpb24uDQoNCihMb29raW5nIGJhY2sgYXQgY3Jhc2ggZXh0
ZW5zaW9ucywgc29tZSBiZWNvbWUgb2Jzb2xldGUgcXVpY2tseSBvcg0KaGF2ZSB2ZXJ5IHNwZWNp
ZmljIGZ1bmN0aW9uYWxpdHksIG1ha2luZyBpdCBkaWZmaWN1bHQgZm9yIGFueW9uZQ0Kb3RoZXIg
dGhhbiB0aGUgb3JpZ2luYWwgYXV0aG9yIHRvIG1haW50YWluLiAgRm9yIHRoaXMgcmVhc29uLCBJ
IHRoaW5rDQppdCBpcyBiZXN0IGZvciB0aGUgYXV0aG9ycyB0aGVtc2VsdmVzIHRvIG1hbmFnZSB0
aGVtLikNCg0KVGhhbmtzLA0KS2F6dQ==

