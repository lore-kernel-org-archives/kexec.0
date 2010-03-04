Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nn9hO-00089u-E9
	for kexec@lists.infradead.org; Thu, 04 Mar 2010 11:58:44 +0000
Received: by gyd12 with SMTP id 12so1217346gyd.36
	for <kexec@lists.infradead.org>; Thu, 04 Mar 2010 03:58:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
References: <20100303110527.11233.20400.stgit@muvarov>
	<e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
Date: Thu, 4 Mar 2010 14:58:34 +0300
Message-ID: <572af9171003040358n25bc2462yc8c16a9acdac70db@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "wilbur.chan" <wilbur512@gmail.com>
Cc: linux-mips@linux-mips.org, horms@verge.net.au, kexec@lists.infradead.org, ralf@linux-mips.org

2010/3/3 wilbur.chan <wilbur512@gmail.com>:
> 2010/3/3 Maxim Uvarov <muvarov@gmail.com>:
>> Hello folks,
>>
>> Please find here MIPS crash and kdump patches.
>> This is patch set of 3 patches:
>> 1. generic MIPS changes (kernel);
>> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
>> 3. Kexec user space MIPS changes.
>>
>> Patches were tested on the latest linux-mips@ git kernel and the latest
>> kexec-tools git on Cavium Octeon 50xx board.
>>
>> I also made the same code working on RMI XLR/XLS boards for both
>> mips32 and mips64 kernels.
>>
>> Best regards,
>> Maxim Uvarov.
>>
>
>> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>>
>>
>>
>
> Hi, Maxim
>
> In XLR series ,
>
> 1)How to protect =A0boardinfo and pass it to second kernel ?
>
It is very simple. I just looked at physical addresses  where
boardinfo is and protect this
region.  For xls simple add additional exclude region to setup.c
static struct boot_mem_map_exclude_region static_exclude_regions[] =3D {
+	[1] =3D {0xc000000, 0xd000000 }, /*Bootloader stuctures*/

To pass it to second kernel copy pointer to original psb_info to
static variable in beginning of prom_init() and provide this pointer
as kexec_args[3].

kexec_args[0]  is argc on XLS
kexec_args[1] is argv on XLS

> 2)If all cpus jumped to same entry point , did you change head.s, if so ,=
 how ?
>
Please take a look how other platforms do this. You need write .macro
kernel_entry_setup which should be located in somewhere is
include/asm-mips/mach-rmi. Then you write this macro it will be
executed before kernel_entry. So after kexec all cpus jump to this
entry point and after they you can do all things what you want:
- make cpu0 boot new kernel and other cpus go to boot slaves procedure;
- take first cpu and make it boot, and all others go to boot slaves procedu=
re;
- boot only cpu0 and infinite loop others  cpus (you might want to do
this for kdump)
>
>
> Thank you!
>

-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
