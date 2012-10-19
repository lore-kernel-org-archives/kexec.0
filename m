Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TPGks-0008Mm-BQ
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 17:53:07 +0000
Date: Fri, 19 Oct 2012 13:53:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121019175301.GG27052@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877gqnnnf0.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Thu, Oct 18, 2012 at 08:36:19PM -0700, Eric W. Biederman wrote:

[..]
> > If we are ok with the idea of passing executables and initramfs to
> > kernel, then kernel can do the placement. That means fields "mem and
> > memsz fields of kexec_segment will be free. We can possibly overload
> > memsz field and pass flags to represent segment type. This will happen
> > only if user chooses kernel as bootloader functionality.
> 
> Which sounds nice initially but I don't think the notion of the kernel
> being a general purpose bootloader holds up to well.  It doesn't provide
> an easy place to put all of the weird cases.
> 
> If we are going to pass in a file it probably makes sense to do a
> variation of kexec_load that passes in a file descriptor, a filename
> could work but I don't think we want those races.

Can we use execve() style filenames. I am not sure what races are you
referring to.

> 
> But then we get how do we pass in a different kernel command line and
> an initrd.  Things that were simple start quickly becoming complex.

Can we take more than one filename arguments. Maybe an array of filename
arguements. And another array of arguments.

SYSCALL_DEFINE2(kexec2,
		const char __user *const __user *, filenamev
		const char __user *const __user *, argv)

This will allow passing filenames of both kernel and initrd and also
allow passing arguments. Arguments will also include command line.

Not asking user space to read in the file will help avoid loading
one extra copy of kernel in memory.

One difference here is though that we will have to allocate kernel memory
for full kernel image and full initd and if images are big, it can lock
down lot of kernel memory and in fact can trigger OOM on many processes.
I guess that's an issue with existing kexec() interface too, so nothing
new here.

This is like re-designing the kexec/kdump and I really wish there is
an easier way to handle the case signed kernels.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
