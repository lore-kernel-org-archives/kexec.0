Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvp69-00087M-IH
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 13:01:38 +0000
Message-ID: <50F7F62C.9020705@citrix.com>
Date: Thu, 17 Jan 2013 13:01:32 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/3] Improve kexec support in Xen hypervisor
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

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
> 
> This should be implemented as stub which be called by machine_kexec()
> and later it would call relevant hypercall.

That's a complicated way of making a simple function call.  What's the
justification for doing it this way?

Because Linux doesn't allow images to be unloaded, it's not clear how we
can get sensible behavior if the image is unloaded from Xen.  The stub
will remain loaded in Linux but will not be able to return (easily?).

>> won't be aware that an image as been loaded as it is loaded directly
>> into the hypervisor and not via the kernel's kexec_load system call.
> 
> Maybe we should have sepcial kexec hypercall function which allow us
> to ask hypervisor that image is loaded or not.

It's not possible to check for an image atomically. I don't think this
is necessary anyway, KEXEC_CMD_exec will return if no image is loaded.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
