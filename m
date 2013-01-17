Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvpUE-0002lo-Fh
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 13:26:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <20130117112743.GB2871@host-192-168-1-59.local.net-space.pl>
 <50F7F62C.9020705@citrix.com>
Date: Thu, 17 Jan 2013 05:25:59 -0800
In-Reply-To: <50F7F62C.9020705@citrix.com> (David Vrabel's message of "Thu, 17
 Jan 2013 13:01:32 +0000")
Message-ID: <87ip6wdjq0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/3] Improve kexec support in Xen hypervisor
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

David Vrabel <david.vrabel@citrix.com> writes:

> On 17/01/13 11:27, Daniel Kiper wrote:
>> On Wed, Jan 16, 2013 at 04:29:03PM +0000, David Vrabel wrote:

>>> The kernel will require a kexec hypercall somewhere in the
>>> crash_kexec() path to actually exec the loaded image.  Any preferences
>>> on how the hook for this should be implemented?  Note that the kernel
>> 
>> This should be implemented as stub which be called by machine_kexec()
>> and later it would call relevant hypercall.
>
> That's a complicated way of making a simple function call.  What's the
> justification for doing it this way?

Because there is no justification for a Xen to have a hack in the
crash_kexec() path.  crash_kexec comes as close as it can to doing
a simple function call.

> Because Linux doesn't allow images to be unloaded, it's not clear how we
> can get sensible behavior if the image is unloaded from Xen.  The stub
> will remain loaded in Linux but will not be able to return (easily?).

Linux allows images to be unloaded by loading an empty image.  Aka an
image with nr_segments == 0.

>>> won't be aware that an image as been loaded as it is loaded directly
>>> into the hypervisor and not via the kernel's kexec_load system call.
>> 
>> Maybe we should have sepcial kexec hypercall function which allow us
>> to ask hypervisor that image is loaded or not.
>
> It's not possible to check for an image atomically. I don't think this
> is necessary anyway, KEXEC_CMD_exec will return if no image is loaded.

If Xen supported something other than the kexec on panic path this could
be interesting.  The current linux userspace does things conditionally
if you are in the reboot runlevel and kexec is coming up.  Certainly for
the kexec on panic path it is non-interesting.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
