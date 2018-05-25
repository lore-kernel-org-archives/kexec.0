Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fM7ee-00030M-Rs
 for kexec@lists.infradead.org; Fri, 25 May 2018 08:01:05 +0000
Date: Fri, 25 May 2018 16:00:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] Remove obsolete kdump tool
Message-ID: <20180525080033.GA5310@dhcp-128-65.nay.redhat.com>
References: <1527147483-11139-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527147483-11139-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, bhupesh.linux@gmail.com, Russell King <rmk@arm.linux.org.uk>

On 05/24/18 at 01:08pm, Bhupesh Sharma wrote:
> The kdump tool presently allows one to generate an ELF file containing
> the ELF header, PT_NOTE and PT_LOAD segments (which can be analyzed
> later by tools like 'readelf') of the crashdump read from memory, when
> passed with an appropriate 'elfcorehdr' value(which represents the
> physical address of the start of the ELF header).
> 
> With the availability of tools like crash/gdb the analysis of the
> crashdump core has become rather easy, and it makes the kdump tool
> obsolete. Also the same naming convention (man page) causes confusion
> when compared to similarly named distribution specific kdump
> service/utilities.
> 
> Also most distributions (like Fedora for e.g.) now support more
> enhanced kdump service and utilities which can be used to analyze the
> crashdump core contents better. Taking an example of the Fedora
> specific kdump service and utilities, the following sequence of steps
> happen when the primary kernel crashes:
> 
> 1. If the crashkernel is loaded, then the system starts executing the
> same.
> 
> 2. When the boot process gets to the point when kdump service is
> started, the crashdump core is usually copied out to disk (for e.g.
> inside '/var/crash') using 'cp' command from '/proc/vmcore':
>    # cp /proc/vmcore <dump-file>
> 
> 3. Thereafter the system is rebooted back into the normal kernel.
> 
> 4. Once back to your normal kernel, one can use the crashdump core
> available on hard disk in conjunction with the previously installed
> kernel (with debuginfo) to perform postmortem analysis with tools like
> gdb/crash:
>    # gdb vmlinux <dump-file>
> 
> Accordingly, this patch removes the obsolete kdump tool from
> 'kexec-tools'.

The main issue for me is the manpage kdump.8 cause confusion to people
The kdump tools is not a main problem to exist or not, but I think
removing the kdump tool along with the man page looks a good cleanup :)

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
