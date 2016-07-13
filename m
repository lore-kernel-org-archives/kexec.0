Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNPAh-00025h-5G
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 18:46:11 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DIht6G059036
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 14:45:50 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452xs89df-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 14:45:50 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 15:45:47 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 13 Jul 2016 15:45:41 -0300
In-Reply-To: <7352796.seiSnHrYPy@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713094127.GC14522@leverpostej> <7352796.seiSnHrYPy@wuerfel>
MIME-Version: 1.0
Message-Id: <2222184.ZN0KkkXgPC@hactar>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> > > - kboot/petitboot with all of the user space being part of the trusted
> > > boot> > 
> > >   chain: it would be good to allow these to modify the dtb as needed
> > >   without breaking the trust chain, just like we allow grub or u-boot
> > >   to modify the dtb before passing it to the kernel.
> > 
> > It depends on *what* we need to modify here. We can modify the bootargs
> > and initrd properties as part of the kexec_file_load syscall, so what
> > else would we want to alter?
> 
> I guess petitboot can also just use kexec_load() instead of
> kexec_file_load(), as long as the initramfs containing petitboot is
> trusted by the kernel.

For secure boot, Petitboot needs to use kexec_file_load, because of the 
following two features which the system call enables:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

Those can't be done with kexec_load.

As for what we need to modify, Petitboot does the following modifications to 
the DTB:

1. Set /chosen/linux,stdout-path based on which console is being used to 
interact with it, as Stewart mentioned in another email.
2. Set display properties on /pciex@n/.../vga@0 in machines with an 
OpenFirmware framebuffer.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
