Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A5C4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 03:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S3yrsnRA2RfwgaYvO8bYocMna+sg2cMT+T3yGFLN9NU=; b=EmJEF6+qk074uiom+lzmGHvpSV
	xlsl0gok91AQpnn4plm3jHsvHTlFgr3qGcIbX2cg0ApfKq5zRb2kVzPPyW7r+iH/7OJuSNIHSyjMm
	7uVor/gMbFKdQA0pztFHp5k/m5YTKNbnhk4Cqo28lCmLgm8VcdXX12TEq0YyPOqxXrPhkGn/GANuw
	HmzcGybOnEGynTcRlLu7X+qfCXeSJ/xOjm3OByoGIQxN/xnrmGtpTes3Qyd2dmUnUEG7fxyrfEZmD
	37LWVKYw8hVDUrBJIKzKIyUFHaI62jGsj4onOlIr57vxLSCRAcr97wMvO7weCSLDaUMbaeC3qeoLt
	yc1Wf2pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7SNZ-001Eb7-0J;
	Mon, 27 Nov 2023 03:33:49 +0000
Received: from mail-mw2nam12on20713.outbound.protection.outlook.com ([2a01:111:f400:fe5a::713] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7SNW-001Ead-0C
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 03:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dluHFEe55y72Or6nzF2XKXZ0fXXGbMKkmwvPGDXo9e/AlKpmd4vGwCyBhhwV5cO+wENN1dvPh9RVCj5K7q7JQpW9rH6m5RmTGT9CEid6tmlWffjaM4Kn5jjRAlJz08Biv2coKuNSVHOR/fqWJ3lTbbn5ew5N/VqQwU0lTWnCVu5ETrfFsU5qzXr97v3jZdgmtgnqUhwI3sPq0wktsuyYPN1w6xUR6rmY+kaLmC1VVjO+mCFqseQBEIXsx4lmgdKcJRVh1S16dacOpia7ILGTo+2bWGTr+CrkMITCnmHYKsQ+cDj6JhRTfDjdQOdS3WLSaigxdclibU3MdL2TRqicYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oVf8Xoi1MeZkZ5tEksIAnZJ80pxGxaBu7w1/Y4JoYQ=;
 b=KBKCRR5bmlwi5GD00ribxNO5sTfOnHY3Q0fv5REJVHF4kLVMNcHdYRJRWrs+YMf0AcgdLvoxPNWtBBuQ2x5QMuMoJe9WTaMDPqVQF6sQ3z/uDnhQyNZtRuY6bChUaDtetu3EN/w5nCWVc2Mfa3uLnp0K+XOaGKrLFkLfjAAhbLBAVlOzb5bnlcCzCZEUjyUaAyCgwqdLTurlzd+ssPj+TDCxzhfVK3JsYXe2fRQOVV6idagV79SjTb97evpbrm0qcRUdTp4L5NbjgCJjHmRCB4v1jjNudQ+A1z2U2QjzNTc3KrOh61vtk2cB+UAeOuicZpPx0kxE5qDjji7/w7kPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oVf8Xoi1MeZkZ5tEksIAnZJ80pxGxaBu7w1/Y4JoYQ=;
 b=lF1GkQMLJMSVBySuEAVvvBw9uHA6+NSZ8S8Dz6D35aPKhJM295nZPokei57KY6aasK4MX916N20jyt4RarizX32jDRyG1FsQ5Ip3G9v8zL0CFNPuAKKRM6t4xeUOxb5Z8C/mJ9UbEh3VUUwiWyZtPrOzJb04p+znYwwvUuoCZ1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8370.prod.exchangelabs.com (2603:10b6:a03:540::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 03:18:35 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Mon, 27 Nov 2023
 03:18:35 +0000
Message-ID: <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
Date: Mon, 27 Nov 2023 11:18:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To: Baoquan He <bhe@redhat.com>, Huang Shijie <shijie@os.amperecomputing.com>
Cc: k-hagio-ab@nec.com, lijiang@redhat.com, akpm@linux-foundation.org,
 vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
X-ClientProxiedBy: PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::14) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 463c7504-3622-479d-189d-08dbeef78a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29eWMchkudghPEU8ugv+D99KbzRPACwgjePN0oJFz5uXNgI1OmuXkygIdIFqKor0PXhGwNesAQ1RI2QbB90lImnt8Uu6BkTaO92+VnTj2MyDslpHzosD6iB1unaq6nbNmUyIXnOQOHUrbjHVpq9rvLPa4azX03BMYRRK+oFxmGSyOEmqdj1d6nLASpFscTT/1JtPlgLk+V9KMb12HpRosfUxUiEBH2sQ1A33Z+R2Q45vPqUcJ+QMbSF84ZkaQtLl4PrtwtowmtQds5hHsXHHvPfwjzRvym3NKQewj2b0TD8C8w83QtgMex1Hq10aV4L/krtmk//TeyJujsDanJHUmSIbS3eYOeiCm9cttWAA0GG+eVTy5qQdzkpRM3RdBij/KZkQJtlfMOz8rhXxoFwNi8xete4bq41rRPHvTXh48mzkmmcEg3dxPHAZFKXX3y2ZCZmc0rI3v+ZWRgm8/pzWh63Hn5uOeQmaW7xXOrwC16lMPp0C7QHd6+nSn2R3C1L5DzOfTUtRxknqdloufCuFEAICbhbBn+LPJ+93V23zxwe7e71g0muMx33i3QVo/1TM0VLiiXy7HH4UcDkd5/pgUIgumW7kVYxaEMpMWkmUtqxXjHauqOBuVFeLrxE78uzS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(6486002)(2616005)(6506007)(107886003)(6666004)(478600001)(6512007)(83170400001)(38100700002)(31696002)(5660300002)(41300700001)(2906002)(66946007)(42882007)(110136005)(66556008)(316002)(66476007)(4326008)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9YNkFBSktGUzRRWmdkSis1eW9VQTlZRVhxRlpnZkY2cUlKM3M4REk2eUdr?=
 =?utf-8?B?RXFkV2o1dTRPNGpDcXE3Q1M3ZDdCamdYVWphdkpaUjl3bGV3WWdIbllnY1ZX?=
 =?utf-8?B?cWdRazU2bmE1TWJhNmhqb3h1R0VzbHlXTk41WHRhaDhxV3BhemtxZUErdTdk?=
 =?utf-8?B?SGMrU3lKeEJBMlhqRzFDaWV4ampYell0Q0hJMytaWlVxdUUzc1hkc1pmQzFP?=
 =?utf-8?B?VUFoR3lEVmNReFkwaE4vOW15MlhSa0xORUd0clZUUTkyNjBjbVB5QzBDOW9H?=
 =?utf-8?B?bk1lRDJnUWtLVE5mTFVxckdqQmh6MDFPb1YrTnA1Y0tqZjJJdHRVS1grUjlL?=
 =?utf-8?B?NWNXYkRybHhjWFUxbHZEdGpFZHVCSmVQWlFYVTgzeHVyQXMrcFB5Nk9IcUEy?=
 =?utf-8?B?VzlpWGJ0MkY2YVdvWWxiQkJ2Qys0NHJVRHFtS3o0Q00zZisrVThMT25Ia2N3?=
 =?utf-8?B?dVBaaFlaOWJUdGdIMTEweFFrVzExQzhMZXZ3eFRGS3ZZQjlRRG1KclpvVTZC?=
 =?utf-8?B?RUhUbUJpa0xMWU5uRlpvTklyZXVzS3MwV3U3UVNIQ3RicXRqZUFiSDR3a1pK?=
 =?utf-8?B?aEgwMlVzQ2VSbHFCQjY5UGpLYW90SE9rQ2ljSDAzUEN5MDBMT3NDbEE0OHlN?=
 =?utf-8?B?K29ENUlaaG5FRGw2b2lGeTBPcnRqOFJnMlhObnAyZ1RnajE0cEpsZTN4RVl5?=
 =?utf-8?B?UVZIQ3R0NFhHSG9uSUhEOEJ5c1BDdi9yY2RMcVNVcUlycFk1d0xmOG5aWk9R?=
 =?utf-8?B?RDVVSzVZcVI2R0NiNDVxQ2wzbVR4emE3MEUwdUtoT0ZNbnpETmYwQ1BQRUp0?=
 =?utf-8?B?Y2NaZklwdXBYT21lS25yb1cxQ0t3QmxrOVlLT2xEYjMyaDBwSnA1aXRzM09X?=
 =?utf-8?B?R3RNSDR4WkttajVoQ0ZXSWFvSmUxRkRGemk2bjV4UzFSR01vYVJ3NEZLOS9x?=
 =?utf-8?B?LzZDVVYralNnUVNMcTVObml5bk9vMm4wM25pQ2QzODA0TjJhTGY5M1c2WjZH?=
 =?utf-8?B?MVhiUTdRdXNBOVFURWo5b1pjbzBVd0ZkNy9zUk1reUlkY3hFU3g3SzNybDZu?=
 =?utf-8?B?TlgzVjVKNW9XOXVxcWpZVlJqa0pIWDdEcE1kQ0hwNUhrSVlHUlJkZlFKMzMz?=
 =?utf-8?B?QWtDR1A4bzAwWVZURFZIZHBlbWYwaTBESzJYVGZBaWphdWRGdUFNdklDQXZB?=
 =?utf-8?B?RTFrQjZGRzYvWS8xRUdlZjFYcmFXbXducXJzL0w4K0hic3Z4SmhtR1ZCVTFE?=
 =?utf-8?B?R3VoRjRValNsTW5aSTIra3I3RUNFdjZabWJpR0owMzlJUWYyUFpUcHl4aEw2?=
 =?utf-8?B?UnhhN0tkd2lSbm0xVE4wTHFIMjV4K3pETCtVRlpHbWVad1BXTmxpOFhyZ3pn?=
 =?utf-8?B?WWZpSlNrSEk4S3gvV0lzT2RIaWRwTkR0UWhyMHcwdmxrVFJ2SDByU0NsV0NZ?=
 =?utf-8?B?SGt3QlZmYjRISHBVekZxM0dzbWQ3b0ZFaTRsUmhvYmdCdlZIQStXb3ZLWjhh?=
 =?utf-8?B?bTlXVnU4UTFFUVpHU09LTnJhaFp3Vjh2TjQ3a2VFN1A2VEc3Uk9RRjZjVW5S?=
 =?utf-8?B?WU9OWGdvRUEzOStDMFJ4WGlWUnoyS1VFY1Q1L2JMU0FVTEg4ZjJ2WlV3NFpn?=
 =?utf-8?B?Y1dmb203VFZZcGhVbXBnTlpab01QeTBRSlhocCs3M2swS0NTbFdSUVlUcTZq?=
 =?utf-8?B?MEpuR1R2RTdKSGo2cXZjNU1hNE5DMUVTbTR4NXJjQnBPdHNIVEZ5SytRYzNH?=
 =?utf-8?B?Y3oxc1ByLzdxTStRU3pqdUhsRFVzLzJBeldwVWZhWi9qR2dtUTVJbW9ERkFB?=
 =?utf-8?B?bDdISUx2WnIzWTgrenluN25lbUw1SWhDdktCUzNZdkx2WklONWJVTUt1dXV1?=
 =?utf-8?B?dmVTamtHVFh1eno5K1ZpYnYxNHI0dWNXUC91SkI2REZ1RXhoUWorOGJ4ck8r?=
 =?utf-8?B?Q3VoaWJhcnJFYzh0N1N3QmQwemNzcGNvUENQY3Arb3Zld1ZFWnZxM05jZFRr?=
 =?utf-8?B?QW5ob3Q4bERZR3A1VTV2Tlh2S1RDSDhHRGdtZFhDbW5kNlErU3ZiL2xJY2lx?=
 =?utf-8?B?NGJybTVRQU10N0ZqMk1kYTU3VkFtMXZTKzU3TnRYckJXUVRaVzVVTkliVjRI?=
 =?utf-8?B?b2U0UndBalU5SjBNVVlQRGxSeC9uRVIzOHJwbTZ2L3ROVTZkUWVDaGRpZ0Iv?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c7504-3622-479d-189d-08dbeef78a4a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 03:18:35.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7QEc3/P18E/akTgACmpIpSm+HIRagQYjUnVRRbuW4rmoDOAe0fFZzMGfc7I7hDra0ky3zR6l5w8NWTkNVloSkvdNXp76tbEYUf2U5pPZ+QbP9oMRcIQjRvhrcxMN6Tc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8370
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_193346_235434_18495C45 
X-CRM114-Status: GOOD (  13.74  )
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

CuWcqCAyMDIzLzExLzI3IDEwOjUxLCBCYW9xdWFuIEhlIOWGmemBkzoKPiBIaSwKPgo+IE9uIDEx
LzI3LzIzIGF0IDEwOjA3YW0sIEh1YW5nIFNoaWppZSB3cm90ZToKPj4gSW4gbWVtb3J5X21vZGVs
LmgsIGlmIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCBpcyBjb25maWdlZCwKPj4ga2VybmVsIHdp
bGwgdXNlIHZtZW1tYXAgdG8gZG8gdGhlIF9fcGZuX3RvX3BhZ2UvcGFnZV90b19wZm4sCj4+IGFu
ZCBrZXJuZWwgd2lsbCBub3QgdXNlIHRoZSAiY2xhc3NpYyBzcGFyc2UiIHRvIGRvIHRoZQo+PiBf
X3Bmbl90b19wYWdlL3BhZ2VfdG9fcGZuLgo+Pgo+PiBTbyBleHBvcnQgdGhlIHZtZW1tYXAgd2hl
biBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgY29uZmlnZWQuCj4+IFRoaXMgbWFrZXMgdGhl
IHVzZXIgYXBwbGljYXRpb25zIChjcmFzaCwgZXRjKSBnZXQgZmFzdGVyCj4+IHBmbl90b19wYWdl
L3BhZ2VfdG9fcGZuIG9wZXJhdGlvbnMgdG9vLgo+IEFyZSB0aGVyZSBDcmFzaCBvciBtYWtlZHVw
ZmlsZSBwYXRjaGVzIHBvc3RlZCB5ZXQgdG8gbWFrZSB1c2Ugb2YgdGhpcz8KCkkgaGF2ZSBwYXRj
aGVzIGZvciBDcmFzaCB0byB1c2UgdGhlICd2bWVtbWFwJywgYnV0IGFmdGVyIHRoaXMgcGF0Y2gg
aXMgCm1lcmdlZCwgSSB3aWxsIHNlbmQgaXQgb3V0LgoKKEkgdGhpbmsgS2F6dSB3aWxsIG5vdCBt
ZXJnZSBhIGNyYXNoIHBhdGNoIHdoaWNoIGRlcGVuZHMgb24gYSBrZXJuZWwgCnBhdGNoIHdoaWNo
IGlzIG5vdCBtZXJnZWQuKQoKClRoYW5rcwoKSHVhbmcgU2hpamllCgoKPj4gU2lnbmVkLW9mZi1i
eTogSHVhbmcgU2hpamllIDxzaGlqaWVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4KPj4gLS0tCj4+
ICAga2VybmVsL2NyYXNoX2NvcmUuYyB8IDMgKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5l
bC9jcmFzaF9jb3JlLmMKPj4gaW5kZXggZWZlODdkNTAxYzhjLi45NjUzYzQxNzcxOTEgMTAwNjQ0
Cj4+IC0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUu
Ywo+PiBAQCAtNzY1LDYgKzc2NSw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGNyYXNoX3NhdmVfdm1j
b3JlaW5mb19pbml0KHZvaWQpCj4+ICAgCVZNQ09SRUlORk9fU1lNQk9MKG1lbV9tYXApOwo+PiAg
IAlWTUNPUkVJTkZPX1NZTUJPTChjb250aWdfcGFnZV9kYXRhKTsKPj4gICAjZW5kaWYKPj4gKyNp
ZmRlZiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAKPj4gKwlWTUNPUkVJTkZPX1NZTUJPTF9BUlJB
WSh2bWVtbWFwKTsKPj4gKyNlbmRpZgo+PiAgICNpZmRlZiBDT05GSUdfU1BBUlNFTUVNCj4+ICAg
CVZNQ09SRUlORk9fU1lNQk9MX0FSUkFZKG1lbV9zZWN0aW9uKTsKPj4gICAJVk1DT1JFSU5GT19M
RU5HVEgobWVtX3NlY3Rpb24sIE5SX1NFQ1RJT05fUk9PVFMpOwo+PiAtLSAKPj4gMi40MC4xCj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
