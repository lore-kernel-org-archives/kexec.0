Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5275FC001B0
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SeX3tvepmbKJ9KLjjLmMsiLSptEgF11t45NIyCsyND4=; b=hF3mSpZbIVXDEc
	i7no7OSkti/+NUQJJib3bAYxuXqq6rvanw9r1abrVLXTWJlhThRAGGSuKDejXsRwGE5m8bSkJfKWg
	WXoj7v/lvW+5A46ecf+HB1GtVGzhitQQPfn6+zIg7+2jLdws3FfIyj4OPE2LlUnd35disVO6QuRHr
	eEGZaLPKV4FvOjfpnCQXO0x496xLF/D7GGaQHCQ7ItyExR0cYdN+kKdHRZaNv4aGbR1xem90G3wGZ
	ljckUNA6jTaVoymBtXQF+oaCowZv+2WXRmSbsa95x9sBiVNMvqhtXkKoD3PuyMXvYXfBCBoA5Icq0
	qNHlTpm0MFm3aXFwAl6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSAl-00Aisf-2x;
	Fri, 11 Aug 2023 13:27:23 +0000
Received: from mail-co1nam11on20627.outbound.protection.outlook.com ([2a01:111:f400:7eab::627] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSAi-00Aiqi-1P
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 13:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxcIdiXG9sMsONeJfOKkxN/xXwsvSpASRbpR/iUmMDmYFnym5zqE2ezVW5eQKBBFq5bMkMntanDxipEZWPhR1z+afMDlgilZmWi7CkN65WbuvGMJRKlVtIx3OYeLGh1WJX+4qKCFyXuj6h6aIsxNkjaFZ3QfiLk83DpKClZpl+07GMhTbANrv1R7trrW0DSdklvNx3HXaOVNYe/2c8HC83Zb874w1TpfmVpI00IV4RF37/nYKA8Wg34SaEYH36rZoQTeFe+bJI0xwM7BLXf0IMQTbvHc81e9TxFfXfLAUDU45SwERA4EeRUdSSUds7QCXBin+oklytkpZxIZbysxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq4noVFPyOxhi0KqGz0QPzcGaSOXwAojFN96KQQCIrQ=;
 b=Yy7VE/RfBfXjT2zHZcDUEPBprB8t5vHQt/Fwil86N7YW5pEsOHYCMGn0wwfTCgJHGDXxrmUAEkDldkdoj3sJuHUstrAu9DylwYTSIuiAm3rtzZ+f1Dxdio+IJfbM1U6KePVSP4yllmHSpYhzgN+X/sjxOGc3e0OC6bxHxxkn1r7iED+bQJBv9JILiKtIicVUMn4bU4xSXVHj9BRyiBfyQf/D6oM4lJkL8a431l0j9m8QtoXkhrQVhqKKjj7nPz+4QAdnF8JTxIBlAlSI2mGeD1mJ75F8VHkUxzR5Eua11ScwBqO2tHdsLB+kmcOrAUvEgSSNsCm340cram7bDccRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq4noVFPyOxhi0KqGz0QPzcGaSOXwAojFN96KQQCIrQ=;
 b=iQzesu2nSx4vZVfxro33JirCec+UGWGwrH1tvvpamP5ooK9JWu52D3+GV2zI3oTHb1zhmMynOczqBvLGMeYOU4nHcI9nFk3E4jg5mEGY3qEYBYXJTo6I/Zq6c39N6Yr3+tq+NCpiGvCkdNHa+fae+UYo/Gu3WhSr97j+Hm4G6FU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:27:11 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 13:27:11 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "bhe@redhat.com" <bhe@redhat.com>, "piliu@redhat.com" <piliu@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sarangi,
 Anirudha" <anirudha.sarangi@amd.com>
Subject: RE: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Topic: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Index: AdnKK79OkD4zpG4kTFa/kOe2Uun+RAAOxmsAAHwHDeA=
Date: Fri, 11 Aug 2023 13:27:11 +0000
Message-ID: <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
In-Reply-To: <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|IA1PR12MB8240:EE_
x-ms-office365-filtering-correlation-id: a4c777dc-3ceb-4b6e-1f8f-08db9a6eab53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXF5vtcZAicql/2t8EiD6ZhLdXrOoKN0BBZhqn6SjHBfbtU5bQptOeH4DZMaw/MDF42z+q+bf8rpFDxGVW1d2HFzZkCiXlsnsBq7oN/GPahfkkLW6PjYA+jgnhaDh8+GWI4E4jwAhE/2XSUF7dNjOZaf9x5bH2TeVpEQhdvMTy21SZfqrP2q8ogyURN0LRNcDNmW9RokGFBQ2WUi0cbWTdk/Mvrm0iThlI6qBK+c/vWygKLW6IQYjaunFSah2x2m2pfa7nRh4gv69UCmCLi9vejmtZm76PUqZDsZ4/td5fPIPKmL543zgeG1Xj3688JnFuVTGhkk1jg5KY7A2vZoVk/i6gw1gme7e9r31pYE7v07RyUqpRlWqhe3eqmhn66d15FMQQccic8Gjhl4lL4+X8sI1sXLvH5dO7CejHpeklqxFkIqaZLmugCMg1bNKzJHZHNjRRoZ0f8kphtAxKV1KoK9FmyrP6+Y5pVSvFQsjaVtjdL6zHu0NGq+RNS4imiFtA27F4Uu1zTiB6HH4rf3T7CKqNbxdQsDU7B99WHffVS8XsLLANQMyPbCPtD/yDVsF6dGUOnXzE+oIBCWnPVpwAGG5h4HY/DMD+C/Ef1WTg8l5CsGn3dqFiZo+7urAYotbt8DX2TVxsZ/EC58Sj+E2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(1800799006)(186006)(316002)(122000001)(4326008)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(38100700002)(38070700005)(41300700001)(110136005)(54906003)(8676002)(8936002)(5660300002)(52536014)(83380400001)(9686003)(966005)(45080400002)(33656002)(7696005)(86362001)(6506007)(55016003)(2906002)(71200400001)(478600001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPEoLSow6oQTCWERqk6BIEUGvx1tz7XAkZOnSwWFd4scihyC+qpDjxZY7MBO?=
 =?us-ascii?Q?eAesGAK3/+VkCRAf9Ml6G2bCRzxos+whjnQuw4wJiM/jSshhJSrWsNXySmzQ?=
 =?us-ascii?Q?DGyPVqGzjEtJlAEK8h36bsrn0UYnz491H30fsbZz7iv4o3XNiTCYGl3iuO+F?=
 =?us-ascii?Q?UfVf1MRYpVtQMbNBckNXMoLz+55nTcrqcUTHQuKHVDqgDtXVxNSg+vMLjjwo?=
 =?us-ascii?Q?ZcA0XkMsXqMiPJUCouTAHXVPQBSBWrfBExFNdCUQfCkv8wj7902E0s1dWag/?=
 =?us-ascii?Q?1uTAT/9LgYjFfoO5jyihSxc3oTDVWKgs7pLlOiVPk/9eRH8ReOAxI8Ikj6O4?=
 =?us-ascii?Q?VVMgRwk0ziBcHt89/iTCWjrENLL30xvESncYPYzUX9719ZDaEvB02dhMxitI?=
 =?us-ascii?Q?K4TO7fWUxa1CtDR5q41OAfDVnWd3QOk3uR5xGvVnveqRr1MDj/nD1mUPjrOz?=
 =?us-ascii?Q?lJ0E5MKFJ7XfhSwudKzrHZ2mjDWBxQUGbDFRYyole54QV5IN1nlkcnFEQOIW?=
 =?us-ascii?Q?I3NsZjtpB2Rzm07xwywRsSLnXTCXI13vVQvG6lesEXzEYNS7wFVJz2vbMpIb?=
 =?us-ascii?Q?LVs9rY84cfHI2ZKIZgsaOLqHmsFvbKqLaGQJGvspLo7cTmEp0n2gIMBoFi+B?=
 =?us-ascii?Q?flXJ1wf2IphivTkwsTZvpcbyfO3J1vU/U/uF7OwjifoYp8Q/s3cubs3xJ7I8?=
 =?us-ascii?Q?e/TR2tzHZWxrletRW3jOt7hTKwTMt7/ijQEEIZcmFbTvXE/cyxdh9pf75qlm?=
 =?us-ascii?Q?yo2ASy3LkTnrH1i2vtXcQZ34cDB8LYg8I1RO17bAODa8b424ZhdckcfB7Xyr?=
 =?us-ascii?Q?/FkHoq+2fOsrJM/5zwMgWpROe1gIbhCzakSu9uAqVqVdA983yPmXD1oIBSqc?=
 =?us-ascii?Q?joEPRNzq3pmkQj4kQrq5HHEZQp7rC5lWg0yvPiKtyf8qlxrMcw7aaWgJJSyy?=
 =?us-ascii?Q?ceKQUlqEgIZE/Lbh6Z2uAZQRrLRPwer7LVqmbVYh5flWJjX74RKg2dVDVMLw?=
 =?us-ascii?Q?+wEKzs0RDonZMUcM199gToCtXrUSiOSAT3IOPoYEbHI/e3tKQD21Qjr9TvpK?=
 =?us-ascii?Q?Fq8R5V4pO7BHGnvef5ZrsEJXcxY4jN87CwHd8IP0zxsoNGzOTb9U8jb13ybn?=
 =?us-ascii?Q?IhY4OEOfSJxri+n8e6fR+3XiaHUxpEVB/M/qJ2dlv63tgfCPBcEa924sWE9L?=
 =?us-ascii?Q?RXohl8vvSbB30hUyffOotQi28YIDpQnXxHeqSd0nu3PykOzeEQ4JcRx2IIQD?=
 =?us-ascii?Q?v9VP2+AO9QouPRkDm8gfSO6Z1+m9WkOdI6MbknXUOW4wAFr+QzApOuMa4d/A?=
 =?us-ascii?Q?VR6HyqUDp06T6ulB1/DHHm0rEiFO4teej/MviCR/4ME+QcmfXw4sgQChmisG?=
 =?us-ascii?Q?zVAdTSk+LgduCBFoHITysI4QDrz6yeHjogR4qiAsD2McfgpDFekR8LZkU9oC?=
 =?us-ascii?Q?nu/xmIUPc6OssQqDrbQduLZyaS/JXfwEdtIGDy2x7epXI9BsZZ3b8DRQ3ePC?=
 =?us-ascii?Q?+K/D72BYj7C/Lw6KYC4VOlAJm14lwvS/2rEsmwgpwJRAZhhNPM5ZqNygFQf2?=
 =?us-ascii?Q?tm+QaRh5nWNANGF1X2+9om7CbI53adEnmbriILpNnUHAojvywNBsMnv73iZP?=
 =?us-ascii?Q?crIGZWU8IQtbA/JgOa5YUOE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c777dc-3ceb-4b6e-1f8f-08db9a6eab53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 13:27:11.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjnA8U6091/jyflQSO9x4EVKct9OiE0dMrvLGMwvcairtfhP97M9LJzhEiR7HX+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_062720_500190_869227DC 
X-CRM114-Status: GOOD (  16.55  )
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

> -----Original Message-----
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: Wednesday, August 9, 2023 7:42 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> piliu@redhat.com
> Cc: kexec@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: kexec reports "Cannot get kernel _text symbol address" on
> arm64 platform
> 
> On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> > Hi,
> >
> > I am trying to bring up kdump on arm64 platform[1]. But I get "Cannot get
> kernel _text symbol address".
> >
> > Is there some Dump-capture kernel config options that I am missing?
> >
> > FYI, copied below complete kexec debug log.
> >
> > [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html
> 
> Your description isn't clear. You saw the printing, then your kdump kernel
> loading succeeded or not?
> 
> If no, have you tried applying Pingfan's patchset and still saw the issue?
> 
> [PATCHv7 0/5] arm64: zboot support
> https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com/T/#u

I was able to proceed further with loading with crash kernel on triggering system crash.
echo c > /proc/sysrq-trigger

But when I copy /proc/vmcore it throws memory abort. Also I see size of /proc/vmcore really huge (18446603353488633856).
Any possible guess on what could be wrong?


[   80.733523] Starting crashdump kernel...
[   80.737435] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000001 [0x410fd083]
[    0.000000] Linux version 6.5.0-rc4-ge28001fb4e07 (radheys@xhdradheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #23 SMP Fri Aug 11 16:25:34 IST 2023
<snip>



xilinx-vck190-20232:/run/media/mmcblk0p1# cat /proc/meminfo | head
MemTotal:        2092876 kB
MemFree:         1219928 kB
MemAvailable:    1166004 kB
Buffers:              32 kB
Cached:           756952 kB
SwapCached:            0 kB
Active:             1480 kB
Inactive:          24164 kB
Active(anon):       1452 kB
Inactive(anon):    24160 kB
xilinx-vck190-20232:/run/media/mmcblk0p1# cp /proc/vmcore dump     
[  975.284865] Unable to handle kernel level 3 address size fault at virtual address ffff80008d7cf000
[  975.293871] Mem abort info:
[  975.296669]   ESR = 0x0000000096000003
[  975.300425]   EC = 0x25: DABT (current EL), IL = 32 bits
[  975.305738]   SET = 0, FnV = 0
[  975.308788]   EA = 0, S1PTW = 0
[  975.311925]   FSC = 0x03: level 3 address size fault
[  975.316888] Data abort info:
[  975.319763]   ISV = 0, ISS = 0x00000003, ISS2 = 0x00000000
[  975.325245]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  975.330292]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  975.335599] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000005016ef6b000
[  975.342297] [ffff80008d7cf000] pgd=10000501eddfe003, p4d=10000501eddfe003, pud=10000501eddfd003, pmd=100005017b695003, pte=00687fff84000703
[  975.354827] Internal error: Oops: 0000000096000003 [#4] SMP
[  975.360392] Modules linked in:
3  975.
63440] CBPrUo:a d0c aPID: 664 Comm: cp Tainted: G      D            6.5.0-rc4-ge28001fb4e07 #23
[  975.372822] Hardware name: Xilinx Versal vck190 Eval board revA (DT)
[  975.379165] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  975.386119] pc : __memcpy+0x110/0x230
[  975.389783] lr : _copy_to_iter+0x3d8/0x4d0
[  975.393874] sp : ffff80008dc939a0
[  975.397178] x29: ffff80008dc939a0 x28: ffff05013c1bea30 x27: 0000000000001000
[  975.404309] x26: 0000000000001000 x25: 0000000000001000 x24: ffff80008d7cf000
[  975.411440] x23: 0000040000000000 x22: ffff80008dc93ba0 x21: 0000000000001000
[  975.418570] x20: ffff000000000000 x19: 0000000000001000 x18: 0000000000000000
[  975.425699] x17: 0000000000000000 x16: 0000000000000000 x15: 0140000000000000
[  975.432829] x14: ffff8500a9919000 x13: 0040000000000001 x12: 0000fffef6831000
[  975.439958] x11: ffff80008d9cf000 x10: 0000000000000000 x9 : 0000000000000000
[  975.447088] x8 : ffff80008d7d0000 x7 : ffff0501addfd358 x6 : 0400000000000001
[  975.454217] x5 : ffff0501370e9000 x4 : ffff80008d7d0000 x3 : 0000000000000000
[  975.461346] x2 : 0000000000001000 x1 : ffff80008d7cf000 x0 : ffff0501370e8000
[  975.468476] Call trace:
[  975.470912]  __memcpy+0x110/0x230
[  975.474221]  copy_oldmem_page+0x70/0xac
[  975.478050]  read_from_oldmem.part.0+0x120/0x188
[  975.482663]  read_vmcore+0x14c/0x238
[  975.486231]  proc_reg_read_iter+0x84/0xd8
[  975.490233]  copy_splice_read+0x160/0x288
[  975.494236]  vfs_splice_read+0xac/0x10c
[  975.498063]  splice_direct_to_actor+0xa4/0x26c
[  975.502498]  do_splice_direct+0x90/0xdc
[  975.506325]  do_sendfile+0x344/0x454
[  975.509892]  __arm64_sys_sendfile64+0x134/0x140
[  975.514415]  invoke_syscall+0x54/0x124
[  975.518157]  el0_svc_common.constprop.0+0xc4/0xe4
[  975.522854]  do_el0_svc+0x38/0x98
[  975.526162]  el0_svc+0x2c/0x84
[  975.529211]  el0t_64_sync_handler+0x100/0x12c
[  975.533562]  el0t_64_sync+0x190/0x194
[  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3 (a940342c) 
[  975.543302] ---[ end trace 0000000000000000 ]---
t message from systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):

kernel[539]: [  975.354827] Internal error: Oops: 0000000096000003 [#4] SMP


Broadcast message from systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):

kernel[539]: [  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3 (a940342c)

Segmentation fault
xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lrth /proc/vmcore 
-r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lh /proc/vmcore
-r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
xilinx-vck190-20232:/run/media/mmcblk0p1# ls -l /proc/vmcore
-r--------    1 root     root     18446603353488633856 Nov  8 14:05 /proc/vmcore

Thanks,
Radhey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
