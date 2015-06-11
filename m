Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x242.google.com ([2607:f8b0:4001:c03::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z32Rl-0008Jg-UV
 for kexec@lists.infradead.org; Thu, 11 Jun 2015 13:23:06 +0000
Received: by iebtr6 with SMTP id tr6so1598795ieb.1
 for <kexec@lists.infradead.org>; Thu, 11 Jun 2015 06:22:44 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 11 Jun 2015 21:22:43 +0800
Message-ID: <CAG+qjJ-s-4HVUOrzcJehw5sAB_XvwnLVe-7O8kc9q_QgPwd89A@mail.gmail.com>
Subject: kexec works well with "dash l" but not working with "dash p"
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Hi experts,

I have a problem when using kexec-tools on freescale powerpc P1014E.

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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
