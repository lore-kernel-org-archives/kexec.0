Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvnn6-0001F5-5r
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 11:37:54 +0000
Message-ID: <50F7E28C.4090003@citrix.com>
Date: Thu, 17 Jan 2013 11:37:48 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <20130117112743.GB2871@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130117112743.GB2871@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Vrabel <david.vrabel@citrix.com>, Eric Biederman <ebiederm@xmission.com>

On 17/01/13 11:27, Daniel Kiper wrote:
> On Wed, Jan 16, 2013 at 04:29:03PM +0000, David Vrabel wrote:
>> This series of patches improves the kexec hypercall in the Xen
>> hypervisor.  It is an incomplete prototype but I posting it early for
>> comments on the proposed ABI/API.
>>
>> This allows a privileged Xen guest to load kexec images into the
>> hypervisor from a userspace tool without using the Linux kernel's
>> kexec subsystem.  It is the first step to supporting kexec of crash
>> kernels from a pv-ops dom0 kernel (the required kernel and kexec-tools
>> patches will be posted later).
>>
>> The kernel will require a kexec hypercall somewhere in the
>> crash_kexec() path to actually exec the loaded image.  Any preferences
>> on how the hook for this should be implemented?  Note that the kernel
> This should be implemented as stub which be called by machine_kexec()
> and later it would call relevant hypercall.
>
>> won't be aware that an image as been loaded as it is loaded directly
>> into the hypervisor and not via the kernel's kexec_load system call.
> Maybe we should have sepcial kexec hypercall function which allow us
> to ask hypervisor that image is loaded or not.

But we already have this information.  If the kexec crash hypercall
returns back to dom0 then a crash kernel is not loaded.

One could certainly argue that even if a crash kernel is not loaded, a
kexec crash hypercall means that dom0 is in bad state and Xen should
panic() anyway, which is the case on any other form of dom0 crash.

~Andrew

>
>> Since the kexec hypercall is for use by dom0 I have removed the
>> implementation of the old load/unload ops and thus guests will require
>> updated kexec-tools to load images.  Is this acceptable?
> Not yet. I think that old interface should stay as long as Xen Linux Kernel
> could run on latest versions of hypervisor.
>
> Daniel
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
