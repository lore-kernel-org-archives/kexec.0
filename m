Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ToEIO-0002Gs-Lk
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 14:18:55 +0000
Message-ID: <50DC58C4.3000307@citrix.com>
Date: Thu, 27 Dec 2012 14:18:44 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <50DBC856.6030208@zytor.com>
 <791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
In-Reply-To: <791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
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
Cc: "x86@kernel.org" <x86@kernel.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 27/12/2012 07:53, Eric W. Biederman wrote:
> The syscall ABI still has the wrong semantics.
>
> Aka totally unmaintainable and umergeable.
>
> The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.

There are two requirements pulling at this patch series, but I agree
that we need to clarify them.

When dom0 loads a crash kernel, it is loading one for Xen to use.  As a
dom0 crash causes a Xen crash, having dom0 set up a kdump kernel for
itself is completely useless.  This ability is present in "classic Xen
dom0" kernels, but the feature is currently missing in PVOPS.

Many cloud customers and service providers want the ability for a VM
administrator to be able to load a kdump/kexec kernel within a
domain[1].  This allows the VM administrator to take more proactive
steps to isolate the cause of a crash, the state of which is most likely
discarded while tearing down the domain.  The result being that as far
as Xen is concerned, the domain is still alive, while the kdump
kernel/environment can work its usual magic.  I am not aware of any
feature like this existing in the past.

~Andrew

[1] http://lists.xen.org/archives/html/xen-devel/2012-11/msg01274.html

>
> I expect a lot of decisions about what code can be shared and what code can't is going to be driven by the simple question what does the syscall mean.
>
> Sharing machine_kexec.c and relocate_kernel.S does not make much sense to me when what you are doing is effectively passing your arguments through to the Xen version of kexec.
>
> Either Xen has it's own version of those routines or I expect the Xen version of kexec is buggy.   I can't imagine what sharing that code would mean.  By the same token I can't any need to duplicate the code either.
>
> Furthermore since this is just passing data from one version of the syscall to another I expect you can share the majority of the code across all architectures that implement Xen.  The only part I can see being arch specific is the Xen syscall stub.
>
> With respect to the proposed semantics of silently giving the kexec system call different meaning when running under Xen,
> /sbin/kexec has to act somewhat differently when loading code into the Xen hypervisor so there is no point not making that explicit in the ABI.
>
> Eric
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
