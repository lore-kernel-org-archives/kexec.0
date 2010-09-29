Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE009.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0z5b-0008GU-Qs
	for kexec@lists.infradead.org; Wed, 29 Sep 2010 16:01:04 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4CA2FAE9.3010109@miraclelinux.com>
Date: Wed, 29 Sep 2010 10:58:19 -0500
Message-ID: <1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
Cc: kexec@lists.infradead.org


On Sep 29, 2010, at 3:38 AM, Makito SHIOKAWA wrote:

> [cf82fe30] [cf8ed800] 0xcf8ed800 (unreliable)
> [cf82fe40] [c00fbb5c] read_from_oldmem+0x7c/0xe0
> [cf82fe70] [c03c400c] parse_crash_elf32_headers+0x1a4/0x470
> [cf82ff30] [c03c4834] vmcore_init+0x310/0x44c
> [cf82ffb0] [c0001dcc] do_one_initcall+0x3c/0x1f0
> [cf82ffe0] [c03b31e4] kernel_init+0xc4/0x168
> [cf82fff0] [c000ffec] kernel_thread+0x4c/0x68
> Instruction dump:
> 38c60001 4200fff0 4e800020 7c032040 418100a0 54a7e8ff 38c3fffc 3884fffc
> 41820028 70c00003 7ce903a6 40820054 <80e40004> 85040008 90e60004 95060008
> ---[ end trace 5e5d343531be722e ]---

There are some other patches I sent upstream after 2.6.35 that fix these issues...

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git&a=search&h=HEAD&st=commit&s=Matthew+McClintock

I think the one that fixes this issue is the third one....

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
