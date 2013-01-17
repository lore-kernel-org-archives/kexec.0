Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvndc-0005DX-4o
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 11:28:04 +0000
Date: Thu, 17 Jan 2013 12:27:43 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [RFC PATCH 0/3] Improve kexec support in Xen hypervisor
Message-ID: <20130117112743.GB2871@host-192-168-1-59.local.net-space.pl>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, xen-devel@lists.xen.org

On Wed, Jan 16, 2013 at 04:29:03PM +0000, David Vrabel wrote:
> This series of patches improves the kexec hypercall in the Xen
> hypervisor.  It is an incomplete prototype but I posting it early for
> comments on the proposed ABI/API.
>
> This allows a privileged Xen guest to load kexec images into the
> hypervisor from a userspace tool without using the Linux kernel's
> kexec subsystem.  It is the first step to supporting kexec of crash
> kernels from a pv-ops dom0 kernel (the required kernel and kexec-tools
> patches will be posted later).
>
> The kernel will require a kexec hypercall somewhere in the
> crash_kexec() path to actually exec the loaded image.  Any preferences
> on how the hook for this should be implemented?  Note that the kernel

This should be implemented as stub which be called by machine_kexec()
and later it would call relevant hypercall.

> won't be aware that an image as been loaded as it is loaded directly
> into the hypervisor and not via the kernel's kexec_load system call.

Maybe we should have sepcial kexec hypercall function which allow us
to ask hypervisor that image is loaded or not.

> Since the kexec hypercall is for use by dom0 I have removed the
> implementation of the old load/unload ops and thus guests will require
> updated kexec-tools to load images.  Is this acceptable?

Not yet. I think that old interface should stay as long as Xen Linux Kernel
could run on latest versions of hypervisor.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
