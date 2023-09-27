Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C21E80A99
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=idf8wAPuvbk0RDFrmPu1yqMmpSZ1RBdKaIsj08lPh+o=; b=ja5QgLv3uNIwRk
	GQiLsZmEzOG3YnK+KgL+3F3cWoqxBy3FlXjLW6mHaMHvYsK58jlcr7hH2W/n5aZ98NYjnhDwPAq5T
	2Q3M9zFbLX0lPYQXS1lCJwt6vDCoRK5pIfyukKoHPxcq5bKR5CmYZlF+vyNf/zj7KnpB6CNGlzPRN
	/vCyHVKWVDfSa4saO0JLp1u4JyrO329k3AYEHxUFBiJiLpeeAfR7pk6MelYfKeEGtUspIpWR1nROD
	3JEK5VVu+1NWQ0GFbJzI/ZXWrs+Ui86W5V6BokLqbZ/A1cAfkPbILClptDC+JSP5dNKejGdwobrpy
	p9cPltlqUl6UcQ0GfcTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlO6l-0006PK-0d;
	Wed, 27 Sep 2023 06:33:15 +0000
Received: from mail-os0jpn01on20622.outbound.protection.outlook.com ([2a01:111:f403:700c::622] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlO6h-0006Ng-36
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 06:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPSez9IAgrrJ3ePSTveN78dKNsisCfNwio0bmagE491PfyNmPNIlGkT7RPvCZtMr8MC77So0WO5GLNFFRa+B0GXsMtRkB8CRf0Gyt+fERZZrCTFuS3snX6ZUDmHxKMOQGJWnzeuLFuTnJxO+LQOy2zH/InV2fPLN6CwT/btG33wkbqauJcU/DbLzvxDL8oRYHqeowk2OzvV8iBmurOnYgtlC8vWHurGV878SiLHWzrapTxPldNJbGk8VNf7ilFUXi1i4tX7R/8iYfIDQbSsd1DetknTTb0tvCQwFYa+394n4KL2WIiECLZuD6ri0aPkl+wfG5ZnqEkBTokFL04OQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QunUmDKBY/IA70qMXAR5j4Gp3wPhq+6Wx/AZRc3yiA=;
 b=l8J8hNRrUNK+B6EOx3g3vEI/MsYMVlsCmXdjeMhrP8GpG2XZwKTFFmHV8mzsgPe9126HgXi75RenS/33MMSzLr30B80SwMeRyyyNZIZVn9Nuaw3wOlOEDKglSbIeZ2UsSDaVmekOJI20sJ0d2poRq6h3VrXrSUch801lVEZ75MENS06qGmNs/YXZ9kgHN3C6y/98TEPtupQOFv71r1vR04kLg9O958/KWKVbH7MR5fw192tlI7W+S3ieBsQpn0DfMqD6EiCO5lxupNvp3HpsDGmrL1FD2H8Ehmgoj8HZP3Zs2BaOgRF0ekqhMbq0XUneOcVeVilDNiQ+GXCgQB594A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QunUmDKBY/IA70qMXAR5j4Gp3wPhq+6Wx/AZRc3yiA=;
 b=R2GA4sOk+nQ3wxXnKQEeSWyuCdmTmun3sEpf/cjvBwiuH1QLM+vbMAErUS3MOyWw45KhsOmaQS8J/+bB+h9epN5YuHBsK3baSCbB2wrXsmg/bIXNuTbG2Hwl4pzRRWPJhyWHcdvDuh9VPP+X2rpe6KDvZbypv2TUVfGBASCiA0o=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB10323.jpnprd01.prod.outlook.com (2603:1096:400:1d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:32:44 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ca4d:34d:1e30:b93a]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ca4d:34d:1e30:b93a%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 06:32:44 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Aditya Gupta <adityag@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Hari Bathini <hbathini@linux.ibm.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Aneesh
 Kumar K.V <aneesh.kumar@linux.ibm.com>, Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: do page traversal if vmemmap_list
 not populated
Thread-Topic: [PATCH] makedumpfile: ppc64: do page traversal if vmemmap_list
 not populated
Thread-Index: AQHZ5u0WLEeQlVOM4kO31ScHItr9arAuSvyA
Date: Wed, 27 Sep 2023 06:32:44 +0000
Message-ID: <151b8a5f-0776-4de2-7f79-8291537781e3@nec.com>
References: <20230914092223.172811-1-adityag@linux.ibm.com>
In-Reply-To: <20230914092223.172811-1-adityag@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB10323:EE_
x-ms-office365-filtering-correlation-id: fb8f1fee-ce7c-4f6f-4b4e-08dbbf238eff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMNCLFXvi/Gz3i6x8trMJ/+eQXMI3qLG786H4lX/nuURN4wTV1pAfzt9Vs5mckjg266CtsICKn4Q30MpAo5lHRSlP3f1YKRiCiCvY1hitCFvU2+2dHCaopi4/5z4F4seAGDiT9I2V2SONeIBaiJmILoLq+vDKEFc69ojAkMOJ42HEu32UmK1ar/yDTJ821LhgutJ8MIe1bOP/VM2YVp+lqcDq7m51lTMZHguseScp/su/XWialYE372K9BFu9VNikSwHfItgtT2u2VQgxRlXW/MsQnlXxe1cVVQOPo+ImhrvDqOH5SkQsMk7khLD9TlfafDzqBdRIlJRaNmfgOscep15hKC9dVi+nGE++YscRzWhxKPccdfFjS7CrvvcSCJo71OxSaewR/FovlcLfbcmbQoeKPJRH6hPBRGCw6VGiYj0uPFgoC5hXZdwl+lXM2M4xEXykBpqHvlYp7eABFwIwc/QU6k/HZPKc41yiF4eugmnE8d0t9FBKFjvlNuuMN40BY/kIxSEO3HU+z2rsaTtxNqobuvHPADlWaYfGZBdX49Et+8/NQtlHGwhEuFn5cPlll73qbpnorlaVBlIwWNDHsum5ReWhGbA2ebmvNtNiCqkTFcWyxVRLwZtn5Th1ddX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(38100700002)(38070700005)(82960400001)(122000001)(36756003)(31696002)(85182001)(86362001)(31686004)(76116006)(53546011)(66446008)(66476007)(5660300002)(6512007)(2906002)(2616005)(41300700001)(83380400001)(316002)(966005)(110136005)(66556008)(478600001)(55236004)(54906003)(64756008)(66946007)(6486002)(6506007)(71200400001)(8676002)(4326008)(8936002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dVcEtsYWxjSWlKNXByVE9wN3lBRkU1R3preHNjd0JiVHFmeGNGaExDUHFT?=
 =?utf-8?B?M0FxS3BhLytVWW4zUHFlMFBmOWlaMi9rWFpOK0hnM2oycDJtcUZRU0RYcmh6?=
 =?utf-8?B?Sjg3aHhITXN4NERzc0RsK2M2VFpPb0N6d2I1UXlLZmhoa3hWamNmcU4zdU1J?=
 =?utf-8?B?NTMzZkpTRHYxbngya2JBbU16Q3owRkd3Y211Mk5Cc3A0cDlobk9EQ0I4L1RP?=
 =?utf-8?B?YldZNHAzWUVIa3NDM0FkeUVvbk1RT0xleEpZUzN6RjFwTjYrRmtURUpaaUVM?=
 =?utf-8?B?R3Z6WlArQWIxNmtpQXhVYlBZVjlsNC9RM0tCRGhFNnExdzJNMXdQK2RYOFQ3?=
 =?utf-8?B?WjllREVhOXRVY1A3dzVqSDFCTnl1Y25lTVI0bWdZdGpWUzJaeDN2TmJBNURP?=
 =?utf-8?B?aldhamsxMUVTNi81ZHlXSXV0OW9mVW1ic0dDWWpCdUZMMUVuOWlISTFPTEl2?=
 =?utf-8?B?WkpBTVBrdVpHOTIzQWlYdCs3WlpRQ2RqWlRzRU1PLy9tamp5TnNpa1NNZG9p?=
 =?utf-8?B?RXpVbHIrNlg5cUVjOWR6aGFJTFVTcGlXSTFya2VrZzJjcGlTenJWckhpTGYz?=
 =?utf-8?B?Tkh4Nko4dW5DV21IbCtvY29WY3VsT3FiWFFaMnplT0lNOHRKMDIwQkZDSTJM?=
 =?utf-8?B?MzdnNFZaNDFxT0tDZlZxU3V6U2xnanZTVk1rTVBBTWV5MGt2a01CZEwwbTZO?=
 =?utf-8?B?R1hwS3VUN29JRVZuUUtGdVhMMnhvRm1oRk5VZ3kyNEhCUTcxNCtURmk3bFpJ?=
 =?utf-8?B?SnlBTDNWdU5GN01RaVRJazVBVDhlYlRjbVAwVFBHQ2M0TzNuSm9oT3BQdzRO?=
 =?utf-8?B?TmVJKzFBWHprUzlCbUxTQmk2WnI0cjhHbnJ1R3BsNVdrV2psSkVkcHJsd0k2?=
 =?utf-8?B?bGNnTldjSnJrb1dFWm8rS3EwUjZtQXNoaGx4aGo1b3FyTW10dEhFL1VXcDM0?=
 =?utf-8?B?T3JXOXh2QkpwcFdzUDNpUU5hbTl5Um85MjNaV2dYeFhkL3ZqU1hXZWNQMFJs?=
 =?utf-8?B?eFFzSHNPaWltakRnUFRrd0QrVGczTVBUdXpldm1ydm1tWHMrT0s3MmlVYVRy?=
 =?utf-8?B?dVJzRXVPZVRKeVNrZkFCUTc2NXNXM2JKMkE3MHdtUTF4ODFhUGxxMUhMRmZ3?=
 =?utf-8?B?MHp1a0FDdXRLRXh4YmJ0bXZNVnB0S3ZKdTgyd1dmOTNWajJSWExKQys1cnQ0?=
 =?utf-8?B?NXJxVjZ1OWJxZWVjRmUyOFBYR3FqU1FrNERTcFZhSkFlTi9yNW1vM2I3MTdF?=
 =?utf-8?B?eW1Yc1Q4bmREdjZNcUw4akxqQzZzSHJweWFacTdTUVJBRlorbW1IK1ZyS0I5?=
 =?utf-8?B?VnJTU0JuYUpra3MwTE9XMkl5L2V3L045SWRlOHl6N2VOTUNybkVaUWEreWdv?=
 =?utf-8?B?cFJiS3hiL1lTa3k2VFNzd09ZRVQ1RWVTU3V0dUVPSVpxcndQdUdxUDBqQU5t?=
 =?utf-8?B?eTByZ1Z3b01xU24relhZNGlaS2tVdGRuQlU1MnlwclNNd09OWHFOSW1QZ1JU?=
 =?utf-8?B?eXlLZFNSeXZuV3dGckNvb0RpZkFBTlJKZVQxYVlkQ0FEc213NDJFN05sZmVj?=
 =?utf-8?B?ZHlET1hJL3N5dmd1NXhiNUliNi9BVmxYMm9XZk96UTBVd0RhU1dpbi96dXRr?=
 =?utf-8?B?anlJaTM2clMrOTBYbTlNdytvNkZsL1dTdGZialVEclEwcCtTWCtMVko1QkE1?=
 =?utf-8?B?am9RczRvL2JrT0dFQ0hoRE9aczdJV2lFWG5rMVRRTm1zbEh0eUhBbUhZRjhC?=
 =?utf-8?B?WlNCc3BUVHpjQXo3YmlwZWdFS3c4VytkcHVVOFhLcWljSmxSTkdiSFlVckpM?=
 =?utf-8?B?blA5R3B2dFhFdkhqTDRkN2JUQStGRFNpOHpWOC9leFVYd3lFOWw3YWFHUjJH?=
 =?utf-8?B?KzFnNDlTeFh4WUFhb0dncjkvUzlacy9Oa05zU2NrMDc2TTNFaGFlcW5zZVFv?=
 =?utf-8?B?Yk9USUdJZUhhTFZPMG1oOE9LZ1NSemRMUDVOWHI4S3FyNU1GT3ZWWnpSVjB2?=
 =?utf-8?B?QTV2S2JuMlBOWEZlQitiV2FsL0VVT1lzSzhWeHdIY29uWWV0b1NqZTVrRGdh?=
 =?utf-8?B?MjBSNXplRXJzUFBpMHNvVHd5ZGgxQVVJQWU4bHRRbTV1NG95VlFYYldCS1ZJ?=
 =?utf-8?B?c2Z1V3g3VWxrZzdJWS85U1dXTjU0QnZrOHExdW1waE9TYnNTelFVa0RIelVj?=
 =?utf-8?B?L0E9PQ==?=
Content-ID: <B716D52F195100499F5A3178D3494961@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8f1fee-ce7c-4f6f-4b4e-08dbbf238eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:32:44.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14oANb69wQVns+Qyi35bUSfj2e0xmuk99GREN+CAAKKumv7wx4B/JjdR5QYWv8od28VrLBrS4jT4BxAC+BG7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_233312_633488_98BFA938 
X-CRM114-Status: GOOD (  31.36  )
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

On 2023/09/14 18:22, Aditya Gupta wrote:
> Currently 'makedumpfile' fails to collect vmcore on upstream kernel,
> with the errors:
> 
>      readpage_elf: Attempt to read non-existent page at 0x4000000000000000.
>      readmem: type_addr: 0, addr:0, size:8
>      get_vmemmap_list_info: Can't get vmemmap region addresses
>      get_machdep_info_ppc64: Can't get vmemmap list info.
> 
> This occurs since makedumpfile depends on 'vmemmap_list' for translating
> vmemmap addresses. But with below commit in Linux, vmemmap_list can be
> empty, in case of Radix MMU on PowerPC64
> 
>      368a0590d954: (powerpc/book3s64/vmemmap: switch radix to use a
>      different vmemmap handling function)
> 
> In case vmemmap_list is empty, then it's head is NULL, which causes
> makedumpfile to fail with above error.
> 
> Since with above commit, 'vmemmap_list' is not populated (when MMU is
> Radix MMU), kernel populates corresponding page table entries in kernel
> page table. Hence, instead of depending on 'vmemmap_list' for address
> translation for vmemmap addresses, do a kernel pagetable walk.
> 
> And since the pte can also be introduced at higher levels in the page
> table, such as at PMD level, add hugepage support, by checking for
> PAGE_PTE flag
> 
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Thank you for the patch, applied.

https://github.com/makedumpfile/makedumpfile/commit/a34f017965583e89c4cb0b00117c200a6c191e54

Sorry for the delay, exceptionally busy this month..

Thanks,
Kazu

> ---
>   arch/ppc64.c   | 111 ++++++++++++++++++++++++++++++++++---------------
>   makedumpfile.h |   6 +++
>   2 files changed, 84 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 5e70acb51aba..9456b8b570c5 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -196,6 +196,10 @@ ppc64_vmemmap_init(void)
>   	int psize, shift;
>   	ulong head;
>   
> +	/* initialise vmemmap_list in case SYMBOL(vmemmap_list) is not found */
> +	info->vmemmap_list = NULL;
> +	info->vmemmap_cnt = 0;
> +	
>   	if ((SYMBOL(vmemmap_list) == NOT_FOUND_SYMBOL)
>   	    || (SYMBOL(mmu_psize_defs) == NOT_FOUND_SYMBOL)
>   	    || (SYMBOL(mmu_vmemmap_psize) == NOT_FOUND_SYMBOL)
> @@ -216,15 +220,24 @@ ppc64_vmemmap_init(void)
>   		return FALSE;
>   	info->vmemmap_psize = 1 << shift;
>   
> -	if (!readmem(VADDR, SYMBOL(vmemmap_list), &head, sizeof(unsigned long)))
> -		return FALSE;
> -
>   	/*
> -	 * Get vmemmap list count and populate vmemmap regions info
> -	 */
> -	info->vmemmap_cnt = get_vmemmap_list_info(head);
> -	if (info->vmemmap_cnt == 0)
> -		return FALSE;
> +	 * vmemmap_list symbol can be missing or set to 0 in the kernel.
> +	 * This would imply vmemmap region is mapped in the kernel pagetable.
> +	 *
> +	 * So, read vmemmap_list anyway, and use 'vmemmap_list' if it's not empty
> +	 * (head != NULL), or we will do a kernel pagetable walk for vmemmap address
> +	 * translation later
> +	 **/
> +	readmem(VADDR, SYMBOL(vmemmap_list), &head, sizeof(unsigned long));
> +
> +	if (head) {
> +		/*
> +		 * Get vmemmap list count and populate vmemmap regions info
> +		 */
> +		info->vmemmap_cnt = get_vmemmap_list_info(head);
> +		if (info->vmemmap_cnt == 0)
> +			return FALSE;
> +	}
>   
>   	info->flag_vmemmap = TRUE;
>   	return TRUE;
> @@ -347,29 +360,6 @@ ppc64_vmalloc_init(void)
>   	return TRUE;
>   }
>   
> -/*
> - *  If the vmemmap address translation information is stored in the kernel,
> - *  make the translation.
> - */
> -static unsigned long long
> -ppc64_vmemmap_to_phys(unsigned long vaddr)
> -{
> -	int	i;
> -	ulong	offset;
> -	unsigned long long paddr = NOT_PADDR;
> -
> -	for (i = 0; i < info->vmemmap_cnt; i++) {
> -		if ((vaddr >= info->vmemmap_list[i].virt) && (vaddr <
> -		    (info->vmemmap_list[i].virt + info->vmemmap_psize))) {
> -			offset = vaddr - info->vmemmap_list[i].virt;
> -			paddr = info->vmemmap_list[i].phys + offset;
> -			break;
> -		}
> -	}
> -
> -	return paddr;
> -}
> -
>   static unsigned long long
>   ppc64_vtop_level4(unsigned long vaddr)
>   {
> @@ -379,6 +369,8 @@ ppc64_vtop_level4(unsigned long vaddr)
>   	unsigned long long pgd_pte, pud_pte;
>   	unsigned long long pmd_pte, pte;
>   	unsigned long long paddr = NOT_PADDR;
> +	uint is_hugepage = 0;
> +	uint pdshift;
>   	uint swap = 0;
>   
>   	if (info->page_buf == NULL) {
> @@ -413,6 +405,13 @@ ppc64_vtop_level4(unsigned long vaddr)
>   	if (!pgd_pte)
>   		return NOT_PADDR;
>   
> +	if (IS_HUGEPAGE(pgd_pte)) {
> +		is_hugepage = 1;
> +		pte = pgd_pte;
> +		pdshift = info->l4_shift;
> +		goto out;
> +	}
> +
>   	/*
>   	 * Sometimes we don't have level3 pagetable entries
>   	 */
> @@ -426,6 +425,13 @@ ppc64_vtop_level4(unsigned long vaddr)
>   		pud_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(page_upper))), swap);
>   		if (!pud_pte)
>   			return NOT_PADDR;
> +
> +		if (IS_HUGEPAGE(pud_pte)) {
> +			is_hugepage = 1;
> +			pte = pud_pte;
> +			pdshift = info->l3_shift;
> +			goto out;
> +		}
>   	} else {
>   		pud_pte = pgd_pte;
>   	}
> @@ -440,6 +446,13 @@ ppc64_vtop_level4(unsigned long vaddr)
>   	if (!(pmd_pte))
>   		return NOT_PADDR;
>   
> +	if (IS_HUGEPAGE(pmd_pte)) {
> +		is_hugepage = 1;
> +		pte = pmd_pte;
> +		pdshift = info->l2_shift;
> +		goto out;
> +	}
> +
>   	pmd_pte = pmd_page_vaddr_l4(pmd_pte);
>   	page_table = (ulong *)(pmd_pte)
>   			+ (BTOP(vaddr) & (info->ptrs_per_l1 - 1));
> @@ -456,8 +469,40 @@ ppc64_vtop_level4(unsigned long vaddr)
>   	if (!pte)
>   		return NOT_PADDR;
>   
> -	paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
> +out:
> +	if (is_hugepage) {
> +		paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
> +			+ (vaddr & ((1UL << pdshift) - 1));
> +	} else {
> +		paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
>   			+ PAGEOFFSET(vaddr);
> +	}
> +
> +	return paddr;
> +}
> +
> +/*
> + *  If the vmemmap address translation information is stored in the kernel,
> + *  make the translation.
> + */
> +static unsigned long long
> +ppc64_vmemmap_to_phys(unsigned long vaddr)
> +{
> +	int	i;
> +	ulong	offset;
> +	unsigned long long paddr = NOT_PADDR;
> +
> +	if (!info->vmemmap_list)
> +		return ppc64_vtop_level4(vaddr);
> +
> +	for (i = 0; i < info->vmemmap_cnt; i++) {
> +		if ((vaddr >= info->vmemmap_list[i].virt) && (vaddr <
> +		    (info->vmemmap_list[i].virt + info->vmemmap_psize))) {
> +			offset = vaddr - info->vmemmap_list[i].virt;
> +			paddr = info->vmemmap_list[i].phys + offset;
> +			break;
> +		}
> +	}
>   
>   	return paddr;
>   }
> @@ -567,8 +612,8 @@ get_machdep_info_ppc64(void)
>   		return FALSE;
>   	}
>   
> +	info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
>   	if (SYMBOL(vmemmap_list) != NOT_FOUND_SYMBOL) {
> -		info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
>   		info->vmemmap_end = info->vmemmap_start;
>   		if (ppc64_vmemmap_init() == FALSE) {
>   			ERRMSG("Can't get vmemmap list info.\n");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 85e5a4932983..056aee191519 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -678,6 +678,12 @@ unsigned long get_kvbase_arm64(void);
>   #define REGION_SHIFT            (60UL)
>   #define VMEMMAP_REGION_ID       (0xfUL)
>   
> +/*
> + * If PAGE_PTE is set, then it's a leaf PTE for hugepage
> + */
> +#define PAGE_PTE (1UL << 62)
> +#define IS_HUGEPAGE(pte) (!!((pte) & PAGE_PTE))
> +
>   /* 4-level page table support */
>   
>   /* 4K pagesize */
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
