Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMW8R-0005Nq-Uj
	for kexec@lists.infradead.org; Wed, 18 May 2011 02:05:17 +0000
Received: by pzk28 with SMTP id 28so595290pzk.36
	for <kexec@lists.infradead.org>; Tue, 17 May 2011 19:05:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <iqgb8m$ruq$1@dough.gmane.org>
References: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
	<20110511150908.GG31633@redhat.com> <iqgb8m$ruq$1@dough.gmane.org>
Date: Tue, 17 May 2011 19:05:13 -0700
Message-ID: <BANLkTi=ds+qwHd5D3LiYQQf6-zqDOkZ_dw@mail.gmail.com>
Subject: Re: Kexec & Memory Zones question
From: Sujit V <sujit.linux@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

We found the root cause for this issue in the bootmem allocator.

The 96GB NUMA system has two memory nodes each with 48GB.
node 0 had zone dma, dma32 & normal
node 1 had only zone normal.

During the early boot i.e kernel/setup.c
The bootmem allocator uses the API find_free_area from the e820 map to
allocate some of its data structures.[ i.e the bitmap ]
(The bootmem bitmap is used to track free & used pages with 1bit for
4K page. The reserve_bootmem() API is used to reserve)

The amount of memory required to represent the bitmap for node 0 with
48GB is. (48GB / (4K * 8)) =3D 1.5MB

The start address of the free area of size 1.5 MB returned by e820 map was
>> bitmap starts at  PA (0xf9b000) size 1.5MB
0xf9b000 + 1.5 MB =3D 17.13MB

The bootmem bitmap used the 1.13MB section from the supposed
crashkernel reserved area.
Later when boot param parsing looks at the crashkernel=3D128M@16M and
reserves the area using the reserve_bootmem().


Later when paging_init() is called the bootmem allocator is retired.
At this point it free's the memory allocated to the bitmap & gives it
to the system page allocator.
i.e pages from 16MB to 17.13 MB are given to the system page
allocator. (Even though the page is reserved by crashkernel.  ]

So pages in this memory range were given some system resources.
When kexec loaded the kdump kernel in the 128M@16M range it corrupted
that memory & we saw the system crash.

I fixed the boot mem allocator and then things worked correctly.


Ours is a 2.6.23 kernel.
The later versions of the kernel have some other mechanism for early
memory reservation (like early_res & memblock)


Thanks





On Thu, May 12, 2011 at 3:03 AM, WANG Cong <xiyou.wangcong@gmail.com> wrote:
> On Wed, 11 May 2011 11:09:08 -0400, Vivek Goyal wrote:
>
>> We have discussed this in the past and due to various reasons the max
>> amount of RAM you can boot your kernel from seems to be 896MB for x86_64
>> and 512MB for 32bit. I shall have to open a previous thread with hpa to
>> get exact numbers. So loading kernel even higher is not the solution.
>>
>
> On the kexec-tools side, I think the limit is hard-coded,
>
> ./include/x86/x86-linux.h:250:#define DEFAULT_INITRD_ADDR_MAX 0x37FFFFFF
>
> but we have,
>
> =A0 =A0 =A0 =A0initrd_addr_max =3D DEFAULT_INITRD_ADDR_MAX;
> =A0 =A0 =A0 =A0if (real_mode->protocol_version >=3D 0x0203) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0initrd_addr_max =3D real_mode->initrd_addr=
_max;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbgprintf("initrd_addr_max is 0x%lx\n", in=
itrd_addr_max);
> =A0 =A0 =A0 =A0}
>
>
> so, from the code, initrd_addr_max can be provided by the bootloader.
>
> I remember on the kernel side there's also such a limit, but I can't
> find where it is. I am wondering what prevents us from increasing this
> limit to 4G on i386 and even higher on x86_64.
>
> Thanks.
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
