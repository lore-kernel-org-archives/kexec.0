Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNO7K-0006e3-V0
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 17:38:39 +0000
Received: by mail-pf0-x22d.google.com with SMTP id i123so20499510pfg.0
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 10:38:18 -0700 (PDT)
Date: Thu, 14 Jul 2016 02:38:06 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713173804.GA25723@porco>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1911992.H2WpLRr2Fi@wuerfel> <20160712141810.GB30181@redhat.com>
 <293705810.hBL93OOmOz@wuerfel> <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
 <20160713093432.GB14522@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160713093432.GB14522@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Apologies for the slow response. I'm attending LinuxCon this week.

On Wed, Jul 13, 2016 at 10:34:47AM +0100, Mark Rutland wrote:
> On Wed, Jul 13, 2016 at 10:36:14AM +0800, Dave Young wrote:
> > But consider we can kexec to a different kernel and a different initrd so there
> > will be use cases to pass a total different dtb as well.
> 
> It depends on what you mean by "a different kernel", and what this
> implies for the DTB.
> 
> I expect future arm64 Linux kernels to function with today's DTBs, and
> the existing boot protocol. The kexec_file_load syscall already has
> enough information for the kernel to inject the initrd and bootargs
> properties into a DTB.
> 
> In practice on x86 today, kexec_file_load only supports booting to a
> Linux kernel, because the in-kernel purgatory only implements the x86
> Linux boot protocol. Analagously, for arm64 I think that the first
> kernel should use its internal copy of the boot DTB, with /chosen fixed
> up appropriately, assuming the next kernel is an arm64 Linux image.
> 
> If booting another OS, the only parts of the DTB I would expect to
> change are the properties under chosen, as everything else *should* be
> OS-independent. However the other OS may have a completely different
> boot protocol, might not even take a DTB, and will likely need a
> compeltely different purgatory implementation. So just allowing the DTB
> to be altered isn't sufficient for that case.
> 
> There might be cases where we want a different DTB, but as far as I can
> tell we have nothing analagous on x86 today. If we do need this, we
> should have an idea of what real case(s) were trying to solve.

What I had in my mind was:

- Kdump
  As Russel said, we definitely need to modify dtb.
  In addition to bootargs and initrd proerties (FYI, in my arm64
  implementation for arm64, eflcorehdr info is also passed as DT
  property), we may want to remove unnecessary devices and
  even add a dedicated storage device for storing a core dump image.
- Say, booting BE kernel on ACPI LE kernel
  In this case, there is no useful dtb in the kernel.

Have said that, as Mark said, we may be able to use normal kexec_load
system call if we don't need a "secure" kexec.

BTW, why doesn't the current kexec_load have ability of verifying
a signature of initramfs image? Is IMA/EVM expected to be used
at runtime?

Thanks,
-Takahiro AKASHI
> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
