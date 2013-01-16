Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvVry-0005tj-AW
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 16:29:43 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [RFC PATCH 0/3] Improve kexec support in Xen hypervisor
Date: Wed, 16 Jan 2013 16:29:03 +0000
Message-ID: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
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
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Eric Biederman <ebiederm@xmission.com>

This series of patches improves the kexec hypercall in the Xen
hypervisor.  It is an incomplete prototype but I posting it early for
comments on the proposed ABI/API.

This allows a privileged Xen guest to load kexec images into the
hypervisor from a userspace tool without using the Linux kernel's
kexec subsystem.  It is the first step to supporting kexec of crash
kernels from a pv-ops dom0 kernel (the required kernel and kexec-tools
patches will be posted later).

The kernel will require a kexec hypercall somewhere in the
crash_kexec() path to actually exec the loaded image.  Any preferences
on how the hook for this should be implemented?  Note that the kernel
won't be aware that an image as been loaded as it is loaded directly
into the hypervisor and not via the kernel's kexec_load system call.

Since the kexec hypercall is for use by dom0 I have removed the
implementation of the old load/unload ops and thus guests will require
updated kexec-tools to load images.  Is this acceptable?

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
