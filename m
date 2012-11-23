Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbzoS-00070X-WE
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 20:25:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com>
 <20121123094516.GA2921@host-192-168-1-59.local.net-space.pl>
Date: Fri, 23 Nov 2012 12:24:51 -0800
In-Reply-To: <20121123094516.GA2921@host-192-168-1-59.local.net-space.pl>
 (Daniel Kiper's message of "Fri, 23 Nov 2012 10:47:38 +0100")
Message-ID: <877gpct6cs.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
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
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, hpa@zytor.com, tglx@linutronix.de

Daniel Kiper <daniel.kiper@oracle.com> writes:

> On Thu, Nov 22, 2012 at 04:15:48AM -0800, ebiederm@xmission.com wrote:
>>
>> Is this for when the hypervisor crashes and we want a crash dump of
>> that?
>
> dom0 at boot gets some info about kexec/kdump configuration from Xen hypervisor
> (e.g. placement of crash kernel area). Later if you call kexec syscall most
> things are done in the same way as on baremetal. However, after placing image
> in memory, HYPERVISOR_kexec_op() hypercall must be called to inform hypervisor
> that image is loaded (new hook machine_kexec_load is used for this;
> machine_kexec_unload is used for unload). Then Xen establishes fixmap for pages
> found in page_list[] and returns control to dom0. If dom0 crashes or "kexec execute"
> is used by user then dom0 calls HYPERVISOR_kexec_op() to instruct hypervisor that
> kexec/kdump image should be executed immediately. Xen calls relocate_kernel()
> and all things runs as usual.


Close

>> Successful code reuse depends upon not breaking the assumptions on which
>> the code relies, or modifying the code so that the new modified
>> assumptions are clear.  In this case you might as well define up as down
>> for all of the sense kexec_ops makes.
>
> Hmmm... Well, problem with above mentioned functions is that they work
> on physical addresses. In Xen PVOPS (currently dom0 is PVOPS) they
> are useless in kexec/kdump case. It means that physical addresses
> must be converted to/from machine addresses which has a real meaning
> in Xen PVOPS case. That is why those funtions were introduced.

Agreed operating on addresses that are relevant to the operation at hand
makes sense.

>> >> There may be a point to all of these but you are mixing and matching
>> >> things badly.
>> >
>> > Do you whish to split this kexec_ops struct to something which
>> > works with addresses and something which is reponsible for
>> > loading, unloading and executing kexec/kdump? I am able to change
>> > that but I would like to know a bit about your vision first.
>>
>> My vision is that we should have code that makes sense.
>>
>> My suspicion is that what you want is a cousin of the existing kexec
>> system call.  Perhaps what is needed is a flag to say use the firmware
>> kexec system call.
>>
>> I absolutely do not understand what Xen is trying to do.  kexec by
>> design should not require any firmware specific hooks.  kexec at this
>> level should only need to care about the processor architeture.  Clearly
>> what you are doing with Xen requires special hooks separate even from
>> the normal paravirt hooks.  So I do not understand you are trying to do.
>>
>> It needs to be clear from the code what is happening differently in the
>> Xen case.  Otherwise the code is unmaintainable as no one will be able
>> to understand it.
>
> I agree. I could remove all machine_* hooks from kexec_ops and call Xen
> specific functions from arch files. However, I need to add two new
> machine calls, machine_kexec_load and machine_kexec_unload, in the same
> manner as existing machine_* calls. In general they could be used to inform
> firmware (in this case Xen) that kexec/kdump image is loaded.
>
> kimage_alloc_pages, kimage_free_pages, page_to_pfn, pfn_to_page, virt_to_phys
> and phys_to_virt are worse. If we could not find good solution how to replace
> them then we end up with calling Xen specific version of kexec/kdump which
> would contain nearly full copy of exisiting kexec/kdump code. Not good.
>
> We could add some code to kernel/kexec.c which depends on CONFIG_XEN.
> It could contain above mentioned functions which later will be called
> by existing kexec code. This is not nice to be honest. However, I hope
> that we could find better solution for that problem.

Since in the Xen case you are not performing a normal kexec or kdump if
you are going to continue to use the kexec system call then another flag
(like the KEXEC_ON_CRASH flag) should be used.

The userspace flag should be something like KEXEC_HYPERVISOR.  From
there we can have a generic interface that feeds into whatever the Xen
infrastructure is.  And if any other hypervisors implement kexec like
functionality it could feed into them if we so choose.

When the choice is clearly between a linux-only kexec and for a hypervisor
level kexec using different functions to understand the target addresses
makes sense.

And of course /sbin/kexec can easity take an additional flag to say load
the kexec image to the hypervisor.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
