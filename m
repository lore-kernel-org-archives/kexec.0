Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x22c.google.com ([2607:f8b0:4001:c05::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z7enm-0005TW-EY
 for kexec@lists.infradead.org; Wed, 24 Jun 2015 07:08:57 +0000
Received: by igin14 with SMTP id n14so28034184igi.1
 for <kexec@lists.infradead.org>; Wed, 24 Jun 2015 00:08:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG+qjJ-s-4HVUOrzcJehw5sAB_XvwnLVe-7O8kc9q_QgPwd89A@mail.gmail.com>
References: <CAG+qjJ-s-4HVUOrzcJehw5sAB_XvwnLVe-7O8kc9q_QgPwd89A@mail.gmail.com>
Date: Wed, 24 Jun 2015 15:08:32 +0800
Message-ID: <CAG+qjJ8oxD9GVQBkD8J40OPaYVyA2tqE9duhoMTgYzvCWvdEKA@mail.gmail.com>
Subject: Re: kexec works well with "dash l" but not working with "dash p"
From: os user <gnusercn@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, ebiederm@xmission.com, albert_herranz@yahoo.es
Cc: Simon Horman <horms@verge.net.au>

Add several experts known from Google.

-- begin resent body --

Hi experts,

I have a problem when using kexec-tools on freescale powerpc P1014E(ppc32).

I have 256MB memory and reserved 78MB for crashkernel.
The cmdline for production kernel is,

bver=0.0.10 root=/dev/ram rw console=ttyS0,115200 crashkernel=78M


I used below command to load crash kernel into memory.
/mnt/uspace/abc/kexec -d -l /mnt/uspace/abc/vmlinux.z.img \
--initrd=/mnt/uspace/abc/ramdisk.img.gz \
--append="root=/dev/ram1 rw console=ttyS0,115200 1 maxcpus=1
noirqdistrib reset_devices"

Then I used "kexec -e" to execute the crash kernel.
The crash kernel works *well* and I can enter busybox after the crash
kernel is up.


But when I used below command to load crash kernel into memory for
panic catching,
/mnt/uspace/abc/kexec -d -p /mnt/uspace/abc/vmlinux.z.img \
--initrd=/mnt/uspace/abc/ramdisk.img.gz \
--append="root=/dev/ram1 rw console=ttyS0,115200 1 maxcpus=1
noirqdistrib reset_devices"

and tried to trigger panic by "echo c > /proc/sysrq",

system hung after "Bye!" was printed to console.

I attached the debug output of "kexec -d -l" and "kexec -d -p".

Can someone please help here or point me a correct place to post the question?

Thanks.

BR

On Thu, Jun 11, 2015 at 9:22 PM, os user <gnusercn@gmail.com> wrote:
> Hi experts,
>
> I have a problem when using kexec-tools on freescale powerpc P1014E.
>
> I have 256MB memory and reserved 78MB for crashkernel.
> The cmdline for production kernel is,
>
> bver=0.0.10 root=/dev/ram rw console=ttyS0,115200 crashkernel=78M
>
>
> I used below command to load crash kernel into memory.
> /mnt/uspace/abc/kexec -d -l /mnt/uspace/abc/vmlinux.z.img \
> --initrd=/mnt/uspace/abc/ramdisk.img.gz \
> --append="root=/dev/ram1 rw console=ttyS0,115200 1 maxcpus=1
> noirqdistrib reset_devices"
>
> Then I used "kexec -e" to execute the crash kernel.
> The crash kernel works *well* and I can enter busybox after the crash
> kernel is up.
>
>
> But when I used below command to load crash kernel into memory for
> panic catching,
> /mnt/uspace/abc/kexec -d -p /mnt/uspace/abc/vmlinux.z.img \
> --initrd=/mnt/uspace/abc/ramdisk.img.gz \
> --append="root=/dev/ram1 rw console=ttyS0,115200 1 maxcpus=1
> noirqdistrib reset_devices"
>
> and tried to trigger panic by "echo c > /proc/sysrq",
>
> system hung after "Bye!" was printed to console.
>
> I attached the debug output of "kexec -d -l" and "kexec -d -p".
>
> Can someone please help here or point me a correct place to post the question?
>
> Thanks.
>
> BR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
