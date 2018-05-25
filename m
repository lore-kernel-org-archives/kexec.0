Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fM9YL-00010i-Qd
 for kexec@lists.infradead.org; Fri, 25 May 2018 10:03:13 +0000
Date: Fri, 25 May 2018 12:02:14 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] Remove obsolete kdump tool
Message-ID: <20180525100214.apb3zsk2mbw3tnjc@verge.net.au>
References: <1527147483-11139-1-git-send-email-bhsharma@redhat.com>
 <20180525080033.GA5310@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180525080033.GA5310@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, bhupesh.linux@gmail.com, Russell King <rmk@arm.linux.org.uk>

On Fri, May 25, 2018 at 04:00:33PM +0800, Dave Young wrote:
> On 05/24/18 at 01:08pm, Bhupesh Sharma wrote:
> > The kdump tool presently allows one to generate an ELF file containing
> > the ELF header, PT_NOTE and PT_LOAD segments (which can be analyzed
> > later by tools like 'readelf') of the crashdump read from memory, when
> > passed with an appropriate 'elfcorehdr' value(which represents the
> > physical address of the start of the ELF header).
> > 
> > With the availability of tools like crash/gdb the analysis of the
> > crashdump core has become rather easy, and it makes the kdump tool
> > obsolete. Also the same naming convention (man page) causes confusion
> > when compared to similarly named distribution specific kdump
> > service/utilities.
> > 
> > Also most distributions (like Fedora for e.g.) now support more
> > enhanced kdump service and utilities which can be used to analyze the
> > crashdump core contents better. Taking an example of the Fedora
> > specific kdump service and utilities, the following sequence of steps
> > happen when the primary kernel crashes:
> > 
> > 1. If the crashkernel is loaded, then the system starts executing the
> > same.
> > 
> > 2. When the boot process gets to the point when kdump service is
> > started, the crashdump core is usually copied out to disk (for e.g.
> > inside '/var/crash') using 'cp' command from '/proc/vmcore':
> >    # cp /proc/vmcore <dump-file>
> > 
> > 3. Thereafter the system is rebooted back into the normal kernel.
> > 
> > 4. Once back to your normal kernel, one can use the crashdump core
> > available on hard disk in conjunction with the previously installed
> > kernel (with debuginfo) to perform postmortem analysis with tools like
> > gdb/crash:
> >    # gdb vmlinux <dump-file>
> > 
> > Accordingly, this patch removes the obsolete kdump tool from
> > 'kexec-tools'.
> 
> The main issue for me is the manpage kdump.8 cause confusion to people
> The kdump tools is not a main problem to exist or not, but I think
> removing the kdump tool along with the man page looks a good cleanup :)
> 
> Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
