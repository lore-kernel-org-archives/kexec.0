Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECB2C77B7C
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ztr4jPtRl+FYmBQMI2QQPu/B76Zcx+zebS3LUMk940I=; b=yX+eid2H9BrukM
	WGN8WbiWsHA1fRAsR4or97+ODhAsIP9yqpFry9f/bloScUMkyToKqL+Kx/OeXppzjyEwH68SZSTbR
	3oH/aMI76xqa24q2D3OwzNaP9vMkCAMbFbKUMMEHkvyjhjERbdN5cpapwiDvW0/AzOyItzhNPYCt1
	5D5MbVnNmIzX5EnOOBoEXpQxfppUjixetcRbrYpxQBx7JClPBAlDVPSohSxjGMKjchQ+sWj8ZVs/s
	CB+qWf3uIakgI53hnL6SHYxEldUq5DY/7Eng1sEoxB42ztDA5TbdqEY6UHvS0xhJD/gdQgKArQCyM
	VGylFUU5rBR2nJCb5n8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwhGg-005olS-1D;
	Wed, 10 May 2023 10:41:58 +0000
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwhGY-005oeV-30
	for kexec@lists.infradead.org;
	Wed, 10 May 2023 10:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1683715311; x=1715251311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ax8Od0amGnP5TPEdVUVnCaa/50f5VRqGXtjyp9G6OEw=;
  b=GyiNiNdYJ3/JDNtYCkY+e0j7F7b1J5SYAiT6Fbvt00c03u4SHxDqQzHy
   Ajfr/zEBaWei+qHxSt2kl0c/mMkaaGgKbF3EQ37lrwWFG4LM/q/zgvaqh
   +ScHFbX+9hjDtSY/hG94h9GrceHYyDclXsooEreyIFm4S0A4xZR/R2ydW
   TPXgtzCGsl07SQ1qqY0eSZS/02Q8bAcKSEk8yJf5eEyroUapRwHUY+27j
   729O3kRdw25py73/oWeSCMYDmlYo1geqaxnuPPbSIxQvEOHp9sWN0hZjW
   5pl3m0YkVQ4FPgmE06MlnMjKgA/edy7Z1BXGaJRsfMkshqLL+jVc1zbh8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="86529473"
X-IronPort-AV: E=Sophos;i="5.99,264,1677510000"; 
   d="scan'208";a="86529473"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 19:41:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAQj4+r7rxrRTOVL1xaHex9zsy5DvxGrOxZiBIi+m4v+mBnmMniCtZZYkSO02wDqqGj8x71qBZJiZtHbNhI0DEgNhTQhAeO48RJqTYJVcqdNy5/eBKtkQBCJYQGrR/8DBWTPLVINxIWtQ1mzcK07EDvzxbfw8GHV5EV1DjW1tZxHe2ZH2wNxxCfGApIE9AfqlfZUsJeViLwKdu4mdde62k8d94JMK/gahTyjtNnRzD2tHwXrZ2k+J14N1B0AQNqTuTc8Ht+cfAOWmOGyjK5Zt6n3id5mRCqGkKrxW0GEUx5TtAQAvE0VeRqdiaFqK4IpyYT1GGY1dS1W3iMdl9mUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax8Od0amGnP5TPEdVUVnCaa/50f5VRqGXtjyp9G6OEw=;
 b=DKLo6AVa3RTeXwQ25ZMkFdOXIpmkLuCMDX0nJIVAbmQeoeCw2MTntKkfiB5XGoNEzcFWwnq4yRZeyN5JB2Gy9zO2DqWzfu41mo0jj8+RnyOKG7auq6Jf8nV8u+YVtGNLfrSpGipRrR3lQ/4Q8cWBCTQ7WxXpxY4SpWGyF3XC6jX9euMgPa/besJ5HU4mzGI9FvpVb1fK5q9MxAz/fDGfiVzAkVepMZ/Clx8ZkOeybN9KBTQrBSKXx3hoJ5yNIRLFP59stEAaQrBlf2FuoiPPMaUI39HiAoGbaUC2zCynLWdNNvMAGXAGjOeGUs9BpjphD5CyZeYow69uyXBSEeidlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11656.jpnprd01.prod.outlook.com (2603:1096:400:37a::6)
 by OS3PR01MB10388.jpnprd01.prod.outlook.com (2603:1096:604:1f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 10:41:39 +0000
Received: from TYCPR01MB11656.jpnprd01.prod.outlook.com
 ([fe80::d9a:a858:c1d:1aa2]) by TYCPR01MB11656.jpnprd01.prod.outlook.com
 ([fe80::d9a:a858:c1d:1aa2%8]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 10:41:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, "Xiao Yang (Fujitsu)"
	<yangx.jy@fujitsu.com>, "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Topic: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Index: AQHZePGyDbRSw7SlpU2xnWSJHHhjFK9BFSkAgA8cuQCAAzQ4gA==
Date: Wed, 10 May 2023 10:41:39 +0000
Message-ID: <0fe0d69e-e33b-cf45-c957-68a8159d29ab@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
 <774fd596-5481-aeff-aace-8785158728ea@fujitsu.com>
In-Reply-To: <774fd596-5481-aeff-aace-8785158728ea@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11656:EE_|OS3PR01MB10388:EE_
x-ms-office365-filtering-correlation-id: 852386d5-f562-4e6b-3305-08db514322e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  k8Exq2VzPCsid7/IJYCWpAhfeF74l7nVsfyg6A8KvtDZ7oTcih8IuZbMrE/BTWGw3JC74l/rHYkjIrazo/AHtCz+l33ucwoqLK0MChgOvNmSUjIB131a24HbIGFGBgfteKE5jIKvkhB47f+oIida0/H8TEQA15SzedcW9npnCzyI7kzFNT0bdnj/Q5KwDmpfEJAAMeqDXZ9yw8Xzi28eqb+J4wiLy7X9fxLpTwksHDcr14TygC/EjYjUDPDPv9r9NW1Ef4993TaUf55NPaCBUopZ6XlUxoW9giJF0OVzUunSLUREPdS7XNcBBgFjrqHSYS6uQ7AvawJ7uDSldm4FAKzfADXrHWpHLfyrokm54LVEIK+w3Bk7YzfWLDnkWDibDwB9W7hcf6oo4t0CsC2YN9S5j/LsRWf5mo3HFZTzoSyepTbW9qjTGcc+QI2pDf6VYfPwVWTMLYAcmgiQsLvh9E9/pxcTIGnjxrsygO0HSsJDpFgj3npkOXh9Rpuy5kwgkF9bot3OSnmaAgnZeBSVQ+Fj8UreWb63LzgcBKpnzP/VlpKWuaEdPhRPn9R/JqluVbuB3+wlpeREPLKFjeR+6mM7fk0W5AJtGPzE+wvu0m7r+Pk+80bckxvH5DURgrYNSZK6GNP2FH9So5OY1t4fcrKmEjTVLfCykXHko708oGsyUsN2o3UWAsVo0jpEVxGDiYFGZRZUKrzzxjeDwMTZGp9+HQX/b21LXdm9h3VxV6c=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11656.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(1590799018)(451199021)(83380400001)(54906003)(85182001)(2906002)(5660300002)(110136005)(122000001)(82960400001)(31686004)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(91956017)(316002)(4326008)(41300700001)(1580799015)(6486002)(38100700002)(86362001)(966005)(2616005)(26005)(53546011)(6512007)(6506007)(8936002)(8676002)(71200400001)(107886003)(186003)(36756003)(38070700005)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RURXTEY0NFpsSFFFaUd6bGtwcFhnKzNoMHdiZHBSZ2hRMkN1U1NOV0dodHlX?=
 =?utf-8?B?UnlWM0hCUlFMcEhVODBpbjNBbDVZbzUxMUJucWdQR29kYkNkZDQwdnliK1No?=
 =?utf-8?B?UVJqYTM1R09aMVk1Zk1JUVkrRzFJVHVmY3ZaUUc5MjhPQTZ3b2IvMHRKOEFD?=
 =?utf-8?B?MldacmVjYUJPK25OaExNQjhwSHI2YlJhcjFJK25lenpjQnpnZVdJV0NCVTUz?=
 =?utf-8?B?UDBQaFVZUFdkcFNPNk9MdW8ycUx6dXlxbVdmYzc3c091d3M2VEwrSnNVeVF4?=
 =?utf-8?B?cFB1Y0x0aG91VFYxOFNndW9sTEw2UEtwUEFlUGdFV09tdmRHMmhZbWc1cEZW?=
 =?utf-8?B?bWhjNmlBNWVKREZ4cjBJUmFGVEJ4eEdYMEJBVVVOZUwrek1tR1lsSDd1VmxK?=
 =?utf-8?B?bGJYUTNRZ2ZmWWZXSHY2TWtrL1BxdGJ6OEVqTno0UCtMWE9tSzNrWk9XTkU1?=
 =?utf-8?B?NzY5c1VveFdTTXdhcGQvTWZjRERkRkVBSmZtbFUrVEgwUjYvR016YXpWcUNH?=
 =?utf-8?B?NkgxUVJDMUFNeWtDM0tPVi9XQnlvRVVTZjkwUjdpaW1mNVVwV0hreGhwK2tZ?=
 =?utf-8?B?YWFEWDlqZ0M0RkpxeVhvcFhxZVlCK0NjVHc0NjBSb2lieFFvTU1kNytIa1RH?=
 =?utf-8?B?TUp4MTN0bkZrN0lkWWV4WkNrdFRRb3poNDA3cjYvbjN1SlEwb2RPOHF1eXNy?=
 =?utf-8?B?WVVGQS8reUQ3VWtISzdCRHBvOE9FWkdXcFlid01mUzZad09saFZhbGFmTmY5?=
 =?utf-8?B?aFp6L0dqUGhIY0pnNnRlZTdhZXVyMHlVNjFjL0crdndZcXovZ0dMUFoycEJl?=
 =?utf-8?B?allDUk5adHV0cHZZNFlDc29ocXBFbThzZ21vRVYrZDJ6OXBFOXlzUEJVVk05?=
 =?utf-8?B?V2ZsMzVpTXNpbDVwekZBNXpaQlBBakx4SytpRGNkNTQ2V3doa0svem8vVTN0?=
 =?utf-8?B?QUJsUG5mSnQ1M2N3OUlFVTdTeFpYTG05ejBqYXkzUWpwRUtaSWJTTUR5bUJ4?=
 =?utf-8?B?QzVQT1FPUDQvd1diOEE5cTY0ZlY2ZFlEaVdROXBUZTg1MDE0N3ZOamZFYzUz?=
 =?utf-8?B?RUYrLzdvbTVsZ1RMZ3lWSmpmUUlaMkNBU2pNRWdwckx2cnVxVGpaMXVMVzNi?=
 =?utf-8?B?ZkpDTTdET0VPRUoxd0ljSE5hUWl6V2tMZzBxUG9GdEtRNm5KWnpUMVBEcWdI?=
 =?utf-8?B?UkVnaXF2am5DbzN3TDlkYjRqeE1lN0RYVGlmTlpjN2xwbjMrTTRBTmxFQ1lt?=
 =?utf-8?B?YkZBZ3NDQ2dwYnVaeXJFYURMLzN6a3htODVnZVhEeEZ5Rm5yNUc5aVNrTmVR?=
 =?utf-8?B?Ui9lQm8yNUFhVTVrNzZBY2RnVy9JdzZGQ3o4VUk1UDNUOCtPQUk3a3RMQ1py?=
 =?utf-8?B?V0tFOEhoL3Mwdy95V0hrVlErS2ZZaFk5VjJPMWFtQzBlSFY3ZW1EZTJ4dVBx?=
 =?utf-8?B?NjZmMis2VGEzZXhvVnJjeGxSNG9jK1Q0SVR1bHN2VWIvenAxNS9aQ05wNmtm?=
 =?utf-8?B?ZHRzbHNndkdGUnQ1ZlNrNzc5NFlhYk84Tlozb0prWjFCcXJ6aFRlVkpkL2Za?=
 =?utf-8?B?ZzdYbXlCZjd3djZsSmZ3SEJscGxrMStoSlhPZEJWY1dIbi9oaXJpbWV1RCsy?=
 =?utf-8?B?a0hNcW1WN2N2aEFseExNZUNuVVNBTWlFQmhPaEtIckVucExhWVk5Y0M2WUU1?=
 =?utf-8?B?dTBzZjVXOHdPNFhwMlhFVXc5MmE0ZzNRVEE2bURVYXVyWitTVTZKaUxaMmth?=
 =?utf-8?B?TzI3eC94d2kzTXZMdWhrNnlVVFN0YU02ZnNjMTlFclNVdFlON1lybDVjRzV1?=
 =?utf-8?B?WGpzZExCZkdmWW8rc2luZzFoMmRsWlZ4UVhHUG5iQnZnS0dKcklYdkV6QjNt?=
 =?utf-8?B?Mjg5dWRRbDhGQlFmYzhPNnIzWWNLRnNMWVoycFdaZWdkRUxJRDhEQzJHcUVW?=
 =?utf-8?B?RmxJZGFZaSs3eDF2VEZWWnY3NGNpR25uN2NHdXgyUER1VFdoMG9BRW0vOFpO?=
 =?utf-8?B?eW94Mllvb1BsZStRajU2T1BFNkIzd3BtVVA5bDl5NlFZU1g0ZlFiNEZGRllN?=
 =?utf-8?B?TmNmMVMwMnpubXVqeGlTNlpid3BpdHAwQnN4YVhteEVCeUdTQkk4Y0U0c1Vs?=
 =?utf-8?B?T3NISkZqTlk0YVB0dGY4NWluTE5GVjRydDZnNGRYSlBieWtQUlBJYTNJMGFG?=
 =?utf-8?B?Ync9PQ==?=
Content-ID: <3B2960B62FF1284F8832A77EA8AB73E7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	cpgqWZvl/1iq+5sgNoBhL+aFerSFhUcY9ulTfq03FBtI/7qZxCiHXVn2p8UpUY6Mv+qe431nT1p8kdaFu7FUb/oHjGVqMDNKJWNai9G4tjzeejE5rGJHLb4/BHPk5H+FJo4X5yMLJ5aOE+9mqJSO7NSMHhlBWQNDC9Iht0L0yj1dMe6SvMbwcL72VeHGImCBLJadgjjKomkLMZThfG34fdl7zy2LHsBdejNft/GjaMbJIsuow+fpj5EsGMCuStNgDLDcD08Kcepo18eQdM6x4aipIoliSKrCOVwQRf0MUEzn7dSGQvkmNp7iQlJjWoLaiP/nY+ZydJhjDyVqjfrhBdLAgsy6eYcPocpjBPxA5A3s3odSZNE7kBh0rUD3TmJE6hh13lIvYbOp6eZXNVjIXt2Ki5gWc6rJ+EMj4Ii6yCRvYnMCX1prujK1A+vZGDhio/8X7Oi9FdeLy0LzSmsAXMF6yt4sb2bo+w0R6nng+x1f2651bXeGbz8NCNRn/V8NBuUKCO5tZ5gK2xk5l95Zaofahv+g7dhqawhyt7ta3tIx4RS+Nq9ikgjNe0igfh6MPJmpMO8MldGCh9Xlsa+1fLHsA206clHf5OTTB673HbnsIhhX9NVXtcwYmKnswkoBVCpfCQiGG3Qjp1kwnqMCkOwRpC/NkwFbzNFca5rzRbnrfDKTOtJRt7w0/0bwqbkvpEOYOs7afH/OOhTqkV5Drki3HZ3yW5UgtYRrBn2GClQPiEu+EuoVuOFN+n+al0wvcA8XPT4xlq7wXRZWV7ANTaUKN9+h5qSSSiXy8qO4Ag6gg52aN3ZOqqZqrcJda4mRNHNmaLaZmANIYNi7RGPAmUm1gPre+P7xyFHRkRtdx48+o9dzZjvS0c9LWpgwLfZ/57Zdiwjb1ZvMXOp7hY6D1uGP/O18HGHsChzqjcHMDCo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11656.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852386d5-f562-4e6b-3305-08db514322e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 10:41:39.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkQqax9oHlIS1atiY0zUmeGJioUgtR1/NOiWB0ZeoxnV69fAEXRQ8i/a/QfEttl70drYO63mALYFOUtdLz82aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10388
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_034151_802036_A3447FF0 
X-CRM114-Status: GOOD (  20.65  )
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

Hi Dan


on 5/8/2023 5:45 PM, Zhijian Li (Fujitsu) wrote:
> Dan,
>
>
> On 29/04/2023 02:59, Dan Williams wrote:
>> Li Zhijian wrote:
>>> Hello folks,
>>>
>>> About 2 months ago, we posted our first RFC[3] and received your kindly feedback. Thank you :)
>>> Now, I'm back with the code.
>>>
>>> Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
>>> deliberately in makedumpfile. It includes changes in 3 source code as below:
>> I think the reason this patchkit is difficult to follow is that it
>> spends a lot of time describing a chosen solution, but not enough time
>> describing the problem and the tradeoffs.
>>
>> For example why is updating /proc/vmcore with pmem metadata the chosen
>> solution? Why not leave the kernel out of it and have makedumpfile
>> tooling aware of how to parse persistent memory namespace info-blocks
>> and retrieve that dump itself? This is what I proposed here:
>>
>> http://lore.kernel.org/r/641484f7ef780_a52e2940@dwillia2-mobl3.amr.corp.intel.com.notmuch
> Sorry for the late reply. I'm just back from the vacation.
> And sorry again for missing your previous *important* information in V1.
>
> Your proposal also sounds to me with less kernel changes, but more ndctl coupling with makedumpfile tools.
> In my current understanding, it will includes following source changes.

The kernel and makedumpfile has updated. It's still in a early stage, but in order to make sure I'm following your proposal.
i want to share the changes with you early. Alternatively, you are able to refer to my github for the full details.
https://github.com/zhijianli88/makedumpfile/commit/8ebfe38c015cfca0545cb3b1d7a6cc9a58fc9bb3

If I'm going the wrong way, fee free to let me know :)


>
> -----------+-------------------------------------------------------------------+
> Source     |                      changes                                      |
> -----------+-------------------------------------------------------------------+
> I.         | 1. enter force_raw in kdump kernel automatically(avoid metadata being updated again)|

kernel should adapt it so that the metadata of pmem will be updated again in the kdump kernel:

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c60ec0b373c5..2e59be8b9c78 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -8,6 +8,7 @@
  #include <linux/slab.h>
  #include <linux/list.h>
  #include <linux/nd.h>
+#include <linux/crash_dump.h>
  #include "nd-core.h"
  #include "pmem.h"
  #include "pfn.h"
@@ -1504,6 +1505,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
                         return ERR_PTR(-ENODEV);
         }
  
+       if (is_kdump_kernel())
+               ndns->force_raw = true;
         return ndns;
  }
  EXPORT_SYMBOL(nvdimm_namespace_common_probe);

> kernel     |                                                                   |
>              | 2. mark the whole pmem's PT_LOAD for kexec_file_load(2) syscall   |
> -----------+-------------------------------------------------------------------+
> II. kexec- | 1. mark the whole pmem's PT_LOAD for kexe_load(2) syscall         |
> tool       |                                                                   |
> -----------+-------------------------------------------------------------------+
> III.       | 1. parse the infoblock and calculate the boundaries of userdata and metadata   |
> makedump-  | 2. skip pmem userdata region                                      |
> file       | 3. exclude pmem metadata region if needed                         |
> -----------+-------------------------------------------------------------------+
>
> I will try rewrite it with your proposal ASAP

inspect_pmem_namespace() will walk the namespaces and the read its resource.start and infoblock. With this
information, we can calculate the boundaries of userdata and metadata easily. But currently this changes are
strongly coupling with the ndctl/pmem which looks a bit messy and ugly.

============makedumpfile=======

diff --git a/Makefile b/Makefile
index a289e41ef44d..4b4ded639cfd 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,7 @@ OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
  
-LIBS = -ldw -lbz2 -ldl -lelf -lz
+LIBS = -ldw -lbz2 -ldl -lelf -lz -lndctl
  ifneq ($(LINKTYPE), dynamic)
  LIBS := -static $(LIBS) -llzma
  endif
diff --git a/makedumpfile.c b/makedumpfile.c
index 98c3b8c7ced9..db68d05a29f9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,8 @@
  #include <limits.h>
  #include <assert.h>
  #include <zlib.h>
+#include <sys/types.h>
+#include <ndctl/libndctl.h>

+
+#define INFOBLOCK_SZ (8192)
+#define SZ_4K (4096)
+#define PFN_SIG_LEN 16
+
+typedef uint64_t u64;
+typedef int64_t s64;
+typedef uint32_t u32;
+typedef int32_t s32;
+typedef uint16_t u16;
+typedef int16_t s16;
+typedef uint8_t u8;
+typedef int8_t s8;
+
+typedef int64_t le64;
+typedef int32_t le32;
+typedef int16_t le16;
+
+struct pfn_sb {
+       u8 signature[PFN_SIG_LEN];
+       u8 uuid[16];
+       u8 parent_uuid[16];
+       le32 flags;
+       le16 version_major;
+       le16 version_minor;
+       le64 dataoff; /* relative to namespace_base + start_pad */
+       le64 npfns;
+       le32 mode;
+       /* minor-version-1 additions for section alignment */
+       le32 start_pad;
+       le32 end_trunc;
+       /* minor-version-2 record the base alignment of the mapping */
+       le32 align;
+       /* minor-version-3 guarantee the padding and flags are zero */
+       /* minor-version-4 record the page size and struct page size */
+       le32 page_size;
+       le16 page_struct_size;
+       u8 padding[3994];
+       le64 checksum;
+};
+
+static int nd_read_infoblock_dataoff(struct ndctl_namespace *ndns)
+{
+       int fd, rc;
+       char path[50];
+       char buf[INFOBLOCK_SZ + 1];
+       struct pfn_sb *pfn_sb = (struct pfn_sb *)(buf + SZ_4K);
+
+       sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
+
+       fd = open(path, O_RDONLY|O_EXCL);
+       if (fd < 0)
+               return -1;
+
+
+       rc = read(fd, buf, INFOBLOCK_SZ);
+       if (rc < INFOBLOCK_SZ) {
+               return -1;
+       }
+
+       return pfn_sb->dataoff;
+}
+
+int inspect_pmem_namespace(void)
+{
+       struct ndctl_ctx *ctx;
+       struct ndctl_bus *bus;
+       int rc = -1;
+
+       fprintf(stderr, "\n\ninspect_pmem_namespace!!\n\n");
+       rc = ndctl_new(&ctx);
+       if (rc)
+               return -1;
+
+       ndctl_bus_foreach(ctx, bus) {
+               struct ndctl_region *region;
+
+               ndctl_region_foreach(bus, region) {
+                       struct ndctl_namespace *ndns;
+
+                       ndctl_namespace_foreach(region, ndns) {
+                               enum ndctl_namespace_mode mode;
+                               long long start, end_metadata;
+
+                               mode = ndctl_namespace_get_mode(ndns);
+                               /* kdump kernel should set force_raw, mode become *safe* */
+                               if (mode == NDCTL_NS_MODE_SAFE) {
+                                       fprintf(stderr, "Only raw can be dumpable\n");
+                                       continue;
+                               }
+
+                               start = ndctl_namespace_get_resource(ndns);
+                               end_metadata = nd_read_infoblock_dataoff(ndns);
+
+                               /* metadata really starts from 2M alignment */
+                               if (start != ULLONG_MAX && end_metadata > 2 * 1024 * 1024) // 2M
+                                       pmem_add_next(start, end_metadata);
+                       }
+               }
+       }
+
+       ndctl_unref(ctx);
+       return 0;
+}
+

Thanks
Zhijian



>
> Thanks again
>
> Thanks
> Zhijian
>
>> ...but never got an answer, or I missed the answer.
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
