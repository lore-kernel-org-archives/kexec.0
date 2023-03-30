Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78938C6FD18
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 02:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rNp70hRM2llPsSaGHjiTVMFRHnsiuNmKttSErzWAgxk=; b=h2x7rNMYl3+QJV
	q3aYbjv8nSw0qqs1txK2iCvma9LEOPuJYebFuTU9iQMLEpCCarrj0ClNRc1EiCmWZPnksOAl1sUBq
	hR5A3w5ZN26z65GyFTVAkuG2ME+iCZVRccAzH8JWRB9yio441DKxnse+B1AVA2uPoPL1MYY/MiW2M
	6is/Sjg8TUVO2Rkawaqt609xr4mak+OTXr/gLzUQ4Dpq39dpl7eDhwHDJMyfAVDoBvf2MCEKdB+ty
	PX9NHxdnuDy0ZRdDh0c6oY/64EAznasroeT3kZAx9h4cTG7ERvOBHfR+VCxLJvKgRtf3CsgLyrUaI
	lw6GxlWxWDJ8rONg3bAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phhzD-002LS5-2f;
	Thu, 30 Mar 2023 02:25:59 +0000
Received: from mail-tycjpn01on20604.outbound.protection.outlook.com ([2a01:111:f403:7010::604] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phhzA-002LPx-0y
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 02:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS/eOtcHQvOP/CayYIJFV9nHNX73SeZBEhA8l079XvorJSuvZZOWlGvUF5EQEtCvlJw4YF33O7LB5H/hMAxoMh+LcMXY9Roz0UAuMzDB+WSL2/A5VN09O7eoKA3ej5nVyvp0bO6Y8bnrgC6qd4gRbpVUIfNwzMaj0+H4k34TOpRaFSa3St9KOx7wuz2IQEzVIu/BgYKbiU2dbX+Tx8Z/nnxCBGWHu6U4N8wbGAvZyvzGoqDUhhD9y/W8gicNhholQz1r7fweLuhEFOsXQp4uTgrnEzmrmTkfRj6kh5hH5PYg4SX33M69VD9Y5hg1XH4N4Her+3sbbfa9Hi+Qf08XXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhgOCYq2Tnhr3r5v7alYaVFItfwzMCSWsUjQxjMtj6c=;
 b=ZVa54ZOLfru6ajY37qMH7LvOn1gQ5FRrB7ho4gPm9RoCDMkdnpf7ztxt9fpVT254pd21C9bGwsDpqnjjUWdhs8OzwLNH1ErXGzYaL81F4O7CZN7ueVKk5bjxtckGqmIxrsXTs36n7fWgwP9vqVA35YJ8vYRxGGd7kJWT3GvwdQ7H7fZOmE88t4Q35WIk+H+mcFqb/syqhA8vndqROhwGRilM26zawyOzmrR13cZnpOMZdfRrQ03q8lE9k8YavRMePu086/b2KxhDout2zRwFbIRi48G1zZ8VHE3G8BRX/m5w4Y6QQaNOBZb9YPz6OqhNt1fLbRuwBci5mcJ9b62NGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhgOCYq2Tnhr3r5v7alYaVFItfwzMCSWsUjQxjMtj6c=;
 b=Q1DRGQb0JXXYfNEYa9uU8Y2lluJalccI/d1YBmdpxju7LAs03xTS1Olorf6bJAkzXrYU+Jfgk96V9Id5L6heZ7bnBcF6lp2wik9aLsUGwNmryP1+JqA6n8/lquyMsCBHNafxkNPC9kcPnxBiWGzj2Gruq9OhSZ9OLPIwcnW6wi0=
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com (2603:1096:604:126::6)
 by OS3PR01MB5576.jpnprd01.prod.outlook.com (2603:1096:604:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 02:25:43 +0000
Received: from OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::4e16:a79a:b364:7da1]) by OS3PR01MB6776.jpnprd01.prod.outlook.com
 ([fe80::4e16:a79a:b364:7da1%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 02:25:43 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "Daisuke Hatayama (Fujitsu)" <d.hatayama@fujitsu.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Topic: [PATCH] makedumpfile, sadump: fix failure of reading memory when
 5-level paging is enabled
Thread-Index: AQHZYjujRAxvHo5Cwk2zeTnUkMOGSa8SmWIA
Date: Thu, 30 Mar 2023 02:25:43 +0000
Message-ID: <5f31e4eb-5768-bfda-3e3a-289d5944e014@nec.com>
References:  <TYAPR01MB6507807A942C53AB8BBE834395899@TYAPR01MB6507.jpnprd01.prod.outlook.com>
In-Reply-To:  <TYAPR01MB6507807A942C53AB8BBE834395899@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6776:EE_|OS3PR01MB5576:EE_
x-ms-office365-filtering-correlation-id: abece199-bea8-47be-67ab-08db30c6102e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LlEqIVvTfcaiLYRZg4hn5VRNksLw7CCDzMgZosN+Gj79a8Ci1QENTZKUYsbnQQfN/F7lJv5Ko8Uyk27yXRsskwF3WXM/Q0CznwWtpZH/NfTegludAK/l0zvSS0txXoR9/sS4qOnNmiL1ykAllnOwNxX0mGd9oMDHuYVDq7xRZb54LG2hIbD/xd02td0mwZou+aF0MRprxhuCNNZc3MFPguGzbVbzCrOI45q0JsILhO1sp7BdllF00l6HcMD6RKGRkUfa6EUMLu4J1FiOgu2y761mJ5gncPTIdBTSf3q5TCPcfYUCVf4enJPbuUnD1UtE1FyjfSQaKbeE3OzLu/D+ienhq8uXiVbf/O/YRht/8GeiYQ12ux0qqYxOszXQLfG4ueBiiwzT/lWIYhiGteI6dguLRh29l1OELyusu/gfDUDQJXMemZ/N540MIL7vAjqEhGSBKA/ZHtk6DXXzJezXldE86xR9pq51DvYqE/ne9dbiXGKX5oEh7MYoRDMzo9wsiGdpR4AulXC4t5WGaf12ZUxeELCpXFO4VKE07E72V5Oo1l/LzboanuvdVZwhLkPBETJpksE1OSmFHYgNhHiygFfNGNpY3Wge3UQDtPG8uM9w8icxl8t4rr0TYFpO/iXD
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6776.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(6486002)(966005)(478600001)(6506007)(26005)(6512007)(8936002)(83380400001)(5660300002)(71200400001)(110136005)(316002)(55236004)(53546011)(186003)(31686004)(91956017)(8676002)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(41300700001)(122000001)(82960400001)(2616005)(36756003)(2906002)(85182001)(31696002)(38070700005)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WDNMSXc5eXZlaTd5c0xRSkd2MkpDUFhnNjZYNk5KOGgyWnNUSjZVd3R6WnlC?=
 =?utf-8?B?dDVEMkx6aDFaenhqK25JdWVxT21CQ0J4d2VBT3c0SnBoT2tvWDRBSTBkYVdk?=
 =?utf-8?B?RnpQSjFTcWg1aDNYRStiTUtrMTlqYlViREdmbVJnb2ZrNWJINGFhNmU3aU1K?=
 =?utf-8?B?eXdLczFyeml6dVErcUtNY0RDUmtRNlA4NkVJY1JDbEVjbmJhdy9CbjNWSlZy?=
 =?utf-8?B?UTFweVNRbG9sSlcxMWc5WksvZjhCQ3U1d0tPTjNqZ0hieUhPWG1TMi9qL2lj?=
 =?utf-8?B?cjRxbldnWWp1bnl5RnVDUGZ6NHRUekcvczFEWExhaC9FS2JqM2htV3Z1ODl4?=
 =?utf-8?B?dklMODVuaElFSTB6MUVHQWc2d2lHd01Cd2d6QzIwVkVud0J5bVFoVGRHYksv?=
 =?utf-8?B?ejdHY0w4S081bGxVMEtHYWJKTGNCUlhON05ETWQzSlhPU25KaFlOR0pGLzBM?=
 =?utf-8?B?TStsYUdScm1TQzI3dzhCdGVzSktHNlkrWmJmVDRVRXdUMm9LbG9vMVM5TmJT?=
 =?utf-8?B?MEgveElaN21ybUF3bmY1UkJJbFVJQzQvTzRYMGo4cVNTWTZTZy80dGhnT25Y?=
 =?utf-8?B?SHFRekQzbjcySy9wTHdBMXltSW54QUowOU9pTUJEQWZjY2Z3czR1WXRRSWRa?=
 =?utf-8?B?OE0wZ3U1V3lLYTI1VzczclV4b2tzU0orNEFDaUc0MUd3NEE5MU5ocEE0RW1Z?=
 =?utf-8?B?YjBZZmVpZEpTMU5TeFM5YzJ3aE9VSHdTOTUyNlBDUGQzM1ErNmlOZEF3VkVO?=
 =?utf-8?B?RlJoemhnMFBEUkhibHQ5anNYRjlVQTNVR1BBUTFYMlBCTzlMU0J4RkNweHJF?=
 =?utf-8?B?dnEreDFYQzU1QVo2ZTZoaWNNUG9kenlhZnRKV2tPSTJCdlU0NDR2L05HQkxj?=
 =?utf-8?B?WmNJb2tpelI3MzdjWTBHREFKLytQZUk3QjQrWFJTYkR6K1dRZ0xBVVcvNEdD?=
 =?utf-8?B?S25ZMCtSNDFQc3UxQjZMNTdETHlyY2NlL2o4MHlSYyt1Vm9vVVhWbkNsR0NS?=
 =?utf-8?B?S3Jmc2NQUTg3Q1p3RUkwaWl6K0lsYUdMSXdWOXBWUHRaSEJNUDMwNGJiOGpE?=
 =?utf-8?B?REFCendnbzFtUVh1UXVidlp0cUdoa0x0RmpwdlRHbTVqQjVRVTlyU0FjdGlJ?=
 =?utf-8?B?ZEo2YU5RWjNZOER4c2VkWEhTTk5PS0ZWOUpZZGNacjREQkdoaFZaSGdlemN2?=
 =?utf-8?B?YjRna2R2Sk5yVVJ3VE9raVBvQ3I4ZXBNOWNJbTBmMHVNN3NnRDZaa2xiUkRV?=
 =?utf-8?B?OFRlY3RITkFRYWQ2WEU0TE9LcFMvMWhlZlNqYkNqZnAzSmFqS3NDMkdjdkRI?=
 =?utf-8?B?TUJHaVNvY1E3cndtajZGc1hnVExFbVV0S3AvSG5DWllCZGpqTTFCU0Q4V29I?=
 =?utf-8?B?ckJHcE9PeVVTYWlkQzVHQURwY3RJVm1WTFFTWDM1TXQybkFuMUY1TEt3N0lh?=
 =?utf-8?B?RGdWWThnYWk1dEFvOGZrZHVpUGEvekcrQWd2ZXpPbTNyenJDSlFuWk1QMFUx?=
 =?utf-8?B?aFhvU2pTWmEvSkpNQ01nMzdhcitpbDVFWWtBcm1Hd243SUJ2VXk1TXpJOGlq?=
 =?utf-8?B?aXo3YXlZRlE2UUJ4dkhUY2c1eENyUys3ZENrN203K294aXNkbElnM2RVZjdP?=
 =?utf-8?B?RmVEQm1EaFJYNnQ4QlM3bzVxRWRqc1U2ZjhOZ3crTjNVT2E0RWgwMDJtYWs2?=
 =?utf-8?B?TGt2THc4UWRBWFJrZUNSbHZuZyt1SUtpelRIeHdzQ3BGMkRHeTJFTXBoVDEz?=
 =?utf-8?B?ZWs0YzM0aHljQ0l3WXlPZzNEWDV2U0pmOGJ2Y2wxUDBUYzBxWnRQN2FDTlh4?=
 =?utf-8?B?c3dnK2hQNmNVa1IxOW9KSlhLY2taTnJtcjhjVjJITmVUaldZaXFkRE5QdzZH?=
 =?utf-8?B?NExIMDVSUWNSNTJNL3BpZmIyZTI2bkZLYm5DQU1UUGtsdmw5bkZ2OFhCM01D?=
 =?utf-8?B?eS9vVllYVWQ1d2s4SVdTRkQrcHpwa2JnUFo5QmQ3Vm9IRzFwSlZ3dVRQQ1Vj?=
 =?utf-8?B?WWpHS3o5MnY5cmd0azcxRnJFRVhBWm5rVzc2Q3p3VDRUNzlyejduOXd5c1Yy?=
 =?utf-8?B?Snl4TUNnUmUvUldqUUhybWdjM2wwNjBDanZtUklqM3E5bkpyQW53SE1reHAx?=
 =?utf-8?Q?JBrMLrbrQ7btQGd9CvOQy0SqV?=
Content-ID: <16FACF97788F5C4B9670EEE4570DD186@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6776.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abece199-bea8-47be-67ab-08db30c6102e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 02:25:43.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E6RIxTSfOYwUTFOuEMlO/gMjETP51FRMG03+XBg763hkmT+Y6lcK7A6HnLjqJzTeYJRz00CRkCwWCsZIWKkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5576
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_192556_857847_2445774B 
X-CRM114-Status: GOOD (  21.72  )
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

On 2023/03/29 21:44, Daisuke Hatayama (Fujitsu) wrote:
> makedumpfile fails as follows for memory dumps collected by sadump
> when 5-level paging is enabled on the corresponding systems:
> 
>      # makedumpfile -l -d 31 -x ./vmlinux ./dump.sadump dump.sadump-ld31
>      __vtop4_x86_64: Can't get a valid pgd.
>      ...snip...
>      __vtop4_x86_64: Can't get a valid pgd.
>      calc_kaslr_offset: failed to calculate kaslr_offset and phys_base; default to 0
>      __vtop4_x86_64: Can't get a valid pgd.
>      readmem: Can't convert a virtual address(ffffffff82fce960) to physical address.
>      readmem: type_addr: 0, addr:ffffffff82fce960, size:1024
>      cpu_online_mask_init: Can't read cpu_online_mask memory.
> 
>      makedumpfile Failed.
> 
> This is because 5-level paging support has not been done yet for
> sadump; the work of the 5-level paging support was done by the commit
> 30a3214a7193e94c551c0cebda5918a72a35c589 (PATCH 4/4 arch/x86_64: Add
> 5-level paging support) but that was focused on the core part only.
> 
> Having said that, most of things has already been finished in the
> commit. What needs to be newly added for sadump is just how to check
> if 5-level paging is enabled for a given memory dump.
> 
> For that purpose, let's refer to CR4.LA57, bit 12 of CR4, representing
> whether 5-level paging is enabled or not. We can do this because
> memory dumps collected by sadump have SMRAM as note information and
> they include CR4 together with the other control registers.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
> ---
>   sadump_info.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sadump_info.c b/sadump_info.c
> index adfa8dc..2c44068 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -1362,6 +1362,7 @@ static int linux_banner_sanity_check(ulong cr3)
>   #define PTI_USER_PGTABLE_BIT		(info->page_shift)
>   #define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
>   #define CR3_PCID_MASK			0xFFFull
> +#define CR4_LA57			(1 << 12)
>   int
>   calc_kaslr_offset(void)
>   {
> @@ -1397,6 +1398,8 @@ calc_kaslr_offset(void)
>   		else
>   			cr3 = smram.Cr3 & ~CR3_PCID_MASK;
>   
> +		NUMBER(pgtable_l5_enabled) = !!(smram.Cr4 & CR4_LA57);
> +
>   		/* Convert virtual address of IDT table to physical address */
>   		idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3);
>   		if (idtr_paddr == NOT_PADDR) {
> @@ -1417,6 +1420,7 @@ calc_kaslr_offset(void)
>   
>   		DEBUG_MSG("sadump: idtr=%" PRIx64 "\n", idtr);
>   		DEBUG_MSG("sadump: cr3=%" PRIx64 "\n", cr3);
> +		DEBUG_MSG("sadump: cr4=%" PRIx32 "\n", smram.Cr4);
>   		DEBUG_MSG("sadump: idtr(phys)=%" PRIx64 "\n", idtr_paddr);
>   		DEBUG_MSG("sadump: devide_error(vmlinux)=%lx\n",
>   			  divide_error_vmlinux);

Thanks, applied.
https://github.com/makedumpfile/makedumpfile/commit/58553ad03187f0cf208d6c4a0dc026c6338e5edd

(oh, "devide" is there..)

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
