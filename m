Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhyM4-002erH-QC
 for kexec@lists.infradead.org; Tue, 02 Nov 2021 18:17:54 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-2-joro@8bytes.org> <YYARccITlowHABg1@zn.tnic>
 <87pmrjbmy9.fsf@disp2133> <YYFupTJjUljpuZgL@suse.de>
Date: Tue, 02 Nov 2021 13:17:26 -0500
In-Reply-To: <YYFupTJjUljpuZgL@suse.de> (Joerg Roedel's message of "Tue, 2 Nov
 2021 18:00:21 +0100")
Message-ID: <87k0hq777t.fsf@disp2133>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/12] kexec: Allow architecture code to opt-out at
 runtime
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
To: Joerg Roedel <jroedel@suse.de>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kexec@lists.infradead.org, stable@vger.kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Joerg Roedel <jroedel@suse.de> writes:

> Hi again,
>
> On Mon, Nov 01, 2021 at 04:11:42PM -0500, Eric W. Biederman wrote:
>> I seem to remember the consensus when this was reviewed that it was
>> unnecessary and there is already support for doing something like
>> this at a more fine grained level so we don't need a new kexec hook.
>
> Forgot to state to problem again which these patches solve:
>
> Currently a Linux kernel running as an SEV-ES guest has no way to
> successfully kexec into a new kernel. The normal SIPI sequence to reset
> the non-boot VCPUs does not work in SEV-ES guests and special code is
> needed in Linux to safely hand over the VCPUs from one kernel to the
> next. What happens currently is that the kexec'ed kernel will just hang.
>
> The code which implements the VCPU hand-over is also included in this
> patch-set, but it requires a certain level of Hypervisor support which
> is not available everywhere.
>
> To make it clear to the user that kexec will not work in their
> environment, it is best to disable the respected syscalls. This is what
> the hook is needed for.

Note this is environmental.  This is the equivalent of a driver for a
device without some feature.

The kernel already has machine_kexec_prepare, which is perfectly capable
of detecting this is a problem and causing kexec_load to fail.  Which
is all that is required.

We don't need a new hook and a new code path to test for one
architecture.

So when we can reliably cause the system call to fail with a specific
error code I don't think it makes sense to make clutter up generic code
because of one architecture's design mistakes.


My honest preference would be to go farther and have a
firmware/hypervisor/platform independent rendezvous for the cpus so we
don't have to worry about what bugs the code under has implemented for
this special case.  Because frankly there when there are layers of
software if a bug can slip through it always seems to and causes
problems.


But definitely there is no reason to add another generic hook when the
existing hook is quite good enough.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
