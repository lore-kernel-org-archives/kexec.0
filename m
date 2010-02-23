Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw0-f49.google.com ([74.125.83.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nk0si-0003lG-TU
	for kexec@lists.infradead.org; Tue, 23 Feb 2010 19:57:24 +0000
Received: by gwj21 with SMTP id 21so1185627gwj.36
	for <kexec@lists.infradead.org>; Tue, 23 Feb 2010 11:57:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100221224825.GI5712@verge.net.au>
References: <4d358c531001280506p2169fad8gdde3c23d989870e1@mail.gmail.com>
	<20100221224825.GI5712@verge.net.au>
Date: Tue, 23 Feb 2010 22:57:19 +0300
Message-ID: <572af9171002231157u72e6524aqed6375855b998e82@mail.gmail.com>
Subject: Re: mip64: kexec: Probem in allocating resevr mem
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
To: Simon Horman <horms@verge.net.au>
Cc: Vishnu Yadav <vishnuyadav@gmail.com>, kexec@lists.infradead.org

 Vishnu Yadav,

If you don't see reserved memory region on mips in /proc/iomem than it
is definitely kernel issue. You can check:
1. you have continuous memory segment, which is enough for booting new
kernel in low 512M. (In general you can reserve memory at any address
but kernel can be booted if it is in lower 512M),
2. you specified right crashkernel=3D option. And it points to real
memory segment.
3. crashkernel was  parsed right in the kernel.

dmesg |grep mem - will print existence memory segments in format
X(memory size) @(at) Y(memory address).
cat /proc/iomem - should show  that memory is really reserved. If you
don't see reserved segments then you have to debug how kernel reserves
area for crashkernel (BOOT_MEM_RESERVED).

Best regards,
Maxim Uvarov.

2010/2/22 Simon Horman <horms@verge.net.au>:
> On Thu, Jan 28, 2010 at 06:36:07PM +0530, Vishnu Yadav wrote:
>> Hi
>> I am =A0not able to reserve the memory in mips 64 plateform for "crash k=
ernel"
>>
>> in below function of arch/mips/kernel/setup.c file of kernel code
>> reserve_bootmem(start, size , flags)
>> if i put flags=3D BOOTMEM_DEFAULT then this function succeeds but doesnt
>> reserve =A0mem of crash kernel .. i verified it by seeing /proc/iomem
>>
>> but if i put flags=3D BOOTMEM_EXCLUSIVE .. this function itself fails and
>> again no memry is reseved.
>>
>>
>> Pls suggest me how to resevre mem regio for "crash kernel" in mips 64. N=
OTE-
>> I have applied kernel as well as user spaces patches for running kexec on
>> mips64.
>
> Does Maxim Uvarov's recent patch help you at all?
>
> http://lists.infradead.org/pipermail/kexec/2010-February/003816.html
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
