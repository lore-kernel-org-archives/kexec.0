Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFBDC25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 02:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EWiX0HEmYE/GvKGxehHZi+ocF7Tx7hWva1dftOQpaYY=; b=s3pRc7oQGOQRUFdKtj8FNKe8ZW
	V5xszDEejnHDXfsLsh6VZbQgNmzCD598HRTwW3rw4UVc5kMjujoexK2BXofp/Lg57Ud7LZSXI61QB
	LhvvQr2TERbi1zim7paEEUUufCdjra05UYl9Igwq6LSIPPARwvyw9AgbuY5YM3xYekBP2IGRv8Tfm
	eOzDThY07WdMzj65MbGMEnJglpDwtb67ZZWFs2BhiSCWZQ921UpFTSAJfbTTstMwl3jzXlE0qleTt
	I4UnGBnxgd0QaPVnHHE+39ONIiX7mvPjE8tl9TdF4rlRA/fJB5I9Cn1BhvCsxLYo3i0q4tciTHvEv
	LeUGT/EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEg5V-00000004QQJ-2C0h;
	Wed, 05 Jun 2024 02:09:17 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEg5S-00000004QP2-2bY7
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 02:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZv/vMkN51k4/Pi7fe/HRK8cH6Mvtfz7igaUYx4HluKKjjSwRAgIFaVxsOBBgGAyzSVZZKZxiyljC4vAjVWDM4U0NvHZSeUZ3ObrJvlAOUCTI1fNpLgi/bdl76IuNdNn9Hv1KFrZV1E+gVjrbkC9ZXimOmeDe9EEdv8dZiw69qDprGU+22WVfVl1cd6sV0BoA03THkgwk8kA0NHn+Z+D430yYOk+flNnUfZWtayR6LV7BPHEu5tnVWWe9zL9DtoWbFOL8rZasVHzX5fQxFumCCoGqTcKl7UJEgoDo6Hrz/IHc/zvWSFgOz6DIHN2B3cCF3vg7pE+kcadMg+gpVGlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob9gAOuutnCeYllyKUeCK/29WaTblNIF41MU75wv5fQ=;
 b=a+tXMnahhFaOslSzBmW9SStdRJl1WG32VWpJBXai1IS59YhNf6c5OX4R33eNVR+A+0YVD0aruL4SMPDglk5XkL6bPSGQAW/coueWqYjfqAilVubQ7treAHctJjCoVp/kcD2d/qKrHPTihI65sbWylAmM+4sYaZAvAvADqvhowc9xHIfWkJDRUbDRlqnb2FDk5MZWhz3OMewC3GjtL7apmevw6ZXTsiHeaspIsbVm/VTywaijbHmw2Q8D+uZRy1wgse/Ucz6pqutie2CSLDUhwczZy1ZoQuihoCm9dqoUOGpYI+RGT4qu24btRzoR4CxAX0hcAusnryS0oo5G91Sk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob9gAOuutnCeYllyKUeCK/29WaTblNIF41MU75wv5fQ=;
 b=wpUDorH1g1Z0rnKgCx1tRrr+KExxyJ2P8A757BVOMVBlbhYldya/4mgU5pOKq945ct1n9IooR3rcsxb1dwvvtTYnkN+M3ifzAn9BYgkPl/S8hupCLeOzZ66krFGadbcXlLmJVj/GRgS5ZjtnnU4KW/C3i+Z02ypuSNTdyXmjCcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 02:09:00 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 02:08:59 +0000
Message-ID: <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
Date: Tue, 4 Jun 2024 21:08:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 dan.j.williams@intel.com
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
 <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
X-ClientProxiedBy: DM6PR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:5:54::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e04e19-f1ea-411b-9f72-08dc850476ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHRiU0hhZnpSblBLU3ZtQTdIaXV2UWNQckxIR0NGc3pEQ1VyVkVpamw2NEdJ?=
 =?utf-8?B?UDRxbXZlM1p1cSswdm5HcjJqOU5ZeG9ZWXhYYXRaNG5DVFJmN2M4VEcwaWFG?=
 =?utf-8?B?b28zUFp2OXhHQ3ZiS2N1SGVDcHBsZFZPMno2ZGRyc1lKVDR5VnZBaXJKZDV6?=
 =?utf-8?B?VHArYmVCNWFVbnhDbUU5Z1phcEpRYnROazRGYm5jRlN0OUJMOC9uMXZ6ak5P?=
 =?utf-8?B?NWdNVVd6a1NGU1JLMmIzTjBEQjlBNWZHWENrazFTWXVnblhObU5LWGpLb2sw?=
 =?utf-8?B?VXB4Z0RGNXZtMVlhY1JXOEd1ODNxak9Xc1JETEFGQUJkUUUyQUhzN3ROYkhI?=
 =?utf-8?B?dHNkSytkUEVkMXkxNGE3YjZmVmM2OFc5K2FtQTNBbWRjWW1rR2RHMWdldUsy?=
 =?utf-8?B?VWJRTUdPa0VBcmd0VXc0TFpOd1V5K2FmMGNpSHBMZWZPd3Jya1l1YUpxeHlZ?=
 =?utf-8?B?VW5OQjZobXo1MW96WS80Vis5clVaTDVQbWlVbHJCY09PcXBNbG90NTk1aGFi?=
 =?utf-8?B?VEpjdDhkOFNCUlRoSjJWQ1dYUDdHdjkwdFNING9ma2pLcDdlR254andkMzMw?=
 =?utf-8?B?STZiM0RwMHRZSEM5VzdGUGJqYzJadkJUWmtmN1ZnUUZCRldDbWQvV0VVR3NZ?=
 =?utf-8?B?Szd0eUtiRVl1Tk9La3RvY3pIQ1NQU1lwQks3cEdHdG9iUkFXN3lIU3VFS3lW?=
 =?utf-8?B?djlHWVpRYWEyZytoNmN0YjVmY2JBRE1NbXlSeDgwZjBWYjVMY3VFeE1ITS93?=
 =?utf-8?B?djR6OXo0ZUZXTWNVaitWK3ZRNXdsdGNvZnJMYUJVUXVYQ3NxblF6R2JVSmNZ?=
 =?utf-8?B?OUpiemxXUE42cmFPczA4djhUU2xmZGpNQStITHNLSjdUUjlLTzkxbXd6ZlF5?=
 =?utf-8?B?K0s3ZlJWY3hBcUdFZFFLUTBoYUFFdkpHekh4YWRseWlWd3pxalRaVXpGNmtO?=
 =?utf-8?B?dG0xbk80ODNWTGVjSk5wd3JucFN6dlI0R1lUVUFUZXV1U0M3U1hyUXRjKytn?=
 =?utf-8?B?OE01bEExUFpqc1piUGFRalljdGN4M2xZOVlMczJQVURYKzBXdnlSaEVReVhp?=
 =?utf-8?B?a2ZZZkRDTTNkSGRvcEY5UVJuMFdOQnVTNmV3RG0xQUUwMHdKd01JSVJ6TnVt?=
 =?utf-8?B?aTJ1MkxVejFINkRWdm45aXhob1crNWgzbzVaMWFJS2ZXSHBuTnZuMmxHL0xz?=
 =?utf-8?B?WkhwOU9FQTV4UGFHeElEczFzZWFER3I4QnBQdnQzOGVNNk9zY3ZrdzliaWU4?=
 =?utf-8?B?TUVNejdqSXdvUm5ORjAzOEZyMkN2aVdOUnZ0UmdTTm82NzNSWE9CeGdFcmVm?=
 =?utf-8?B?YlA4VWVCZ3hNSkZQOHdOK1E5T2Z3V2xHVjRmWHJ4OWo0TkgxbFpSNTdycTk2?=
 =?utf-8?B?YnpFVnBsdDFiVGRzaVMrcXRYaDBzSXlhYitqc0srOTVvOFJZWnU3dEpzK3Rm?=
 =?utf-8?B?Z1hLMlVCTzNLZ1RqR2xydmdyK2VyNG1Xb2p2MFZJODFtYVIvZHo0ZWFTTlFy?=
 =?utf-8?B?TGFING9SK0xQRmZDMnpaWnNoVGJ0dTh5b053NUZIWk1qYWVMVWdBUGZGTzlt?=
 =?utf-8?B?Q1QrWnpIc0VENDZocUNiVEZhWkhhZTVkY0hDV25nalJiSUF6Q3pFd3had1NF?=
 =?utf-8?B?Y0lXaE16TUljeXZsWTN0RFJPYmZ1b1dIcWtDRTE4cXg5MS9kaCtRcTA2bWVo?=
 =?utf-8?B?US9QeGw0MmdocmVRdmZDUkhvUHRwK0tHTG0yZkw2Q2ZET2lRS0FUNU1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE8zUS9VZlVkL0V6ZGdOd3RPcGVOZUFaK2x6a3F5Zkk4V3NqT2pXV1NxeEJi?=
 =?utf-8?B?akwyaTU3N0ZwbUNxQzY4eWdSb0MxRlhUcklINUxEYXovelBzZGpkaXVFaFMv?=
 =?utf-8?B?amlJM1pPMXFXT2hzaXdJK1pNZ3o0akhvc0dFZU9ub3FDTmlacGdHWFBGWnV2?=
 =?utf-8?B?ejhCZ1FDZXo2aytSb3ZJOVB2cGdpc0RwaVp1ejlwVjQwakRmYXEyOFp3WUNP?=
 =?utf-8?B?elRPd0RLb2lOamNtNjdoLzQrOGlBR2ZNTFZEWE9DRGczbXRGaUVIUU5HQ1ZP?=
 =?utf-8?B?b3ZHQjEybFlqcXlIYndsV2JUWGJyVDN1UE04K296TFFLMVUvbmFQbzN4Y1Ez?=
 =?utf-8?B?Zk1uMkIycTM3WkxQQmJOdlQyR1g4Uk5rKyt0bC9oLzZsT2VrQ1B2MmpvVUhT?=
 =?utf-8?B?dHoxb0J2WUovV0hZelpScHM5Uzk0WVVDWEJ2ZWg1RExvR2daOGhjQ3F6MFhK?=
 =?utf-8?B?V0Y1VjN2VFFMOVcreFovYm9qRVVYRlRzMVdEOHh1NlVkK1BOYVhiZEp5azNL?=
 =?utf-8?B?NVAxMXZrZG9vTXBLeWtaNmpXRFlVZzdhWHhlWXZObUdZcnpvYkREWFZmZnRv?=
 =?utf-8?B?c0xadVAwVTFzMy9veGFUZkk2ZEZ3WUFKdXJuWVN1UU9wbW9aNE0xOTJmajBz?=
 =?utf-8?B?TnlwcVppMTNwdlllOU4rS3FDa3ZOOHc0QlBMOUIwUnoyVnFHNlV3Q3JZYWcy?=
 =?utf-8?B?ZkF2aSsrcU4rc0lrVHV0UGtnV3Q3eDBFUGZvQ2VLZVBObDViRjE0a2tlWnJS?=
 =?utf-8?B?KythTkRVejh5bzcxSmxRUEhaa0R3WWo3UE9URWNIVFRYYjUxTmFIcExicTAz?=
 =?utf-8?B?RVZIRjlFempxeXU2M2IwTGVtS0tPeDhhcnNRblFpdDNDelRjR3RPd3ExeUFX?=
 =?utf-8?B?MzRCV01QMkhrWkNhWndlMDZ4S1NPRU5HVXZhN0ZkaktLcGVOZ0Z0MWdaakh6?=
 =?utf-8?B?UElxUG9iT1BaTUhJMWE3R3dhbzcyMHNBckNnZGFHTjByOHhMM1dIODUzSVZC?=
 =?utf-8?B?YzQzYXRIcXFoWGdVMHRPTzRtekh6SGxzck1YV3IxNWFtWStsVFJUL3ppdGZD?=
 =?utf-8?B?RnRsalBWd05uM3MyUHpuVkNyTWVFcFYrZ0pqSkFha1diVFMxRklISFNkUUJl?=
 =?utf-8?B?UEt0dkNBZlR3K3hQTlByZWNFQllXOGxZMnE3NjdxUmQwNkF2QjNxQTU2R1Q1?=
 =?utf-8?B?L2RNazlFWVp2SERJNk5NcnZNQTczRzFYMFRGV2g2a3lhdGxZaHhSOXRmT2la?=
 =?utf-8?B?Mm5kWmNjQ0dYZEE4ait2QUZFWWZrTlJqc3VzbnhxRHh1RmVSbU9YalNrSG5K?=
 =?utf-8?B?QnViUEUzdWk2TUM0ajluZUgybTZkdlkwRGlGSmRjZmM3eFFtSFd6SU45VHBO?=
 =?utf-8?B?R1NNVmRYZzZZd0VLUE9wdElXV2NNREpCRERkMVF5YW16YmthbmEzTFdKVmE5?=
 =?utf-8?B?NE90ZitLK1cvMUJLeGpudU9nd2hxa3pBeUoyNGVVNlFZYytZbS9RdkJoVkFv?=
 =?utf-8?B?aVhDcDdjVGMxanF1blVUR0laZnM0V05tM0FzeFRzSTJ5SWlhUXhRL3hENmZZ?=
 =?utf-8?B?WjRRSTRtKzNmOE5sM3RUMTZ4SmhtRXE1UW5kdG1lSlZCUlVRQ3JDMkpPWUo4?=
 =?utf-8?B?NjlCRDFyYllJaVRVSkhNUEhMci9tYUpOaXg2ZEdkay9yd0UxazNKTWJMKzdv?=
 =?utf-8?B?NUdGb21ieEhrM0F4bE04VDNpTDZOdzgwR1hLbmkrSVdVSGEvQjhKZ3IwZlll?=
 =?utf-8?B?elFlc3F3b3diSUU5SS9sL0IvYi9NVjN6akFWZWVXelpaVEhVcEdPa0psdk1m?=
 =?utf-8?B?REFta2YrS25GNDFwUjJtMW5vb3gvTE5NWitnSFFmOXh1bFdIV0lxQi8yc2kz?=
 =?utf-8?B?VzlXYjlsWWVZcVZhRTZpVWF5L2NDNnROa2FNbG1iaWM1eDdCQmlaZiszVEdX?=
 =?utf-8?B?N0hndW9rVFpxQ05Fd3FoODhkK2dEa1g5ZmNhUnVRdnlRZWpDc2QrNTZjWVUx?=
 =?utf-8?B?THRicnBJZ0IrNkNGQ2RDMGVEV3RCQVM4REswMmJCSVpiWWI5NUtTbnh2eHJU?=
 =?utf-8?B?RGJJckR4WUV2dmVOQ0VLZ0ZERytxdEIyTlFFQld1dE55emZDVWVpdjB5S0Rx?=
 =?utf-8?Q?TWlr8ZqMxhjnoP6oL5QMxau7Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e04e19-f1ea-411b-9f72-08dc850476ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 02:08:59.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/eTeHp7VKLINsGHDqA86D/ukOnRE6Hn0fUtRRsjUyaGM7z6RJzOJTeB7i52Lzc0n8Tv1vEScnzpVz+Ay2UDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_190914_672191_5D9FA468 
X-CRM114-Status: UNSURE (   8.60  )
X-CRM114-Notice: Please train this message.
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

Hello Dave,

On 6/4/2024 8:58 PM, Dave Young wrote:
> On Wed, 5 Jun 2024 at 09:52, Dave Young <dyoung@redhat.com> wrote:
>>>>         ...
>>>>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
>>>>                 __efi_memmap_free(efi.memmap.phys_map,
>>>>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
>>>>         }
>>> From your debugging the memmap should not be freed.  This piece of
>>> code was added in below commit,  added Dan Williams in cc list:
>>> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
>>> Author: Dan Williams <dan.j.williams@intel.com>
>>> Date:   Mon Jan 13 18:22:44 2020 +0100
>>>
>>>     efi: Fix efi_memmap_alloc() leaks
>>>
>>>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
>>>     updated and replaced multiple times. When that happens a previous
>>>     dynamically allocated efi memory map can be garbage collected. Use the
>>>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
>>>     allocated memory map is being replaced.
>>>
>> Dan, probably those regions should be freed only for "fake" memmap?
> Ashish, can you comment out the __efi_memmap_free see if it works for
> you just confirm about the behavior.

Yes, i have already tried and tested that, if i avoid __efi_memmap_free(), then i don't see this memory map corruption.

Thanks, Ashish


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
