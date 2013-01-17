Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvp4u-0007vw-Ko
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 13:00:21 +0000
Date: Thu, 17 Jan 2013 13:59:56 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
Message-ID: <20130117125956.GD2871@host-192-168-1-59.local.net-space.pl>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <20130117112743.GB2871@host-192-168-1-59.local.net-space.pl>
 <50F7E28C.4090003@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50F7E28C.4090003@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Vrabel <david.vrabel@citrix.com>, Eric Biederman <ebiederm@xmission.com>

On Thu, Jan 17, 2013 at 11:37:48AM +0000, Andrew Cooper wrote:
> On 17/01/13 11:27, Daniel Kiper wrote:
> > On Wed, Jan 16, 2013 at 04:29:03PM +0000, David Vrabel wrote:
> >> This series of patches improves the kexec hypercall in the Xen
> >> hypervisor.  It is an incomplete prototype but I posting it early for
> >> comments on the proposed ABI/API.
> >>
> >> This allows a privileged Xen guest to load kexec images into the
> >> hypervisor from a userspace tool without using the Linux kernel's
> >> kexec subsystem.  It is the first step to supporting kexec of crash
> >> kernels from a pv-ops dom0 kernel (the required kernel and kexec-tools
> >> patches will be posted later).
> >>
> >> The kernel will require a kexec hypercall somewhere in the
> >> crash_kexec() path to actually exec the loaded image.  Any preferences
> >> on how the hook for this should be implemented?  Note that the kernel
> > This should be implemented as stub which be called by machine_kexec()
> > and later it would call relevant hypercall.
> >
> >> won't be aware that an image as been loaded as it is loaded directly
> >> into the hypervisor and not via the kernel's kexec_load system call.
> > Maybe we should have sepcial kexec hypercall function which allow us
> > to ask hypervisor that image is loaded or not.
> 
> But we already have this information.  If the kexec crash hypercall
> returns back to dom0 then a crash kernel is not loaded.
> 
> One could certainly argue that even if a crash kernel is not loaded, a
> kexec crash hypercall means that dom0 is in bad state and Xen should
> panic() anyway, which is the case on any other form of dom0 crash.

I thought about somthing which does not do big bang when kexec image is loaded.
Now I think that it should return what type of image is loaded
(crash and/or regular one).

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
