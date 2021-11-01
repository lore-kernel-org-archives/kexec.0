Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhebf-00HKdS-TR
 for kexec@lists.infradead.org; Mon, 01 Nov 2021 21:12:41 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-2-joro@8bytes.org> <YYARccITlowHABg1@zn.tnic>
Date: Mon, 01 Nov 2021 16:11:42 -0500
In-Reply-To: <YYARccITlowHABg1@zn.tnic> (Borislav Petkov's message of "Mon, 1
 Nov 2021 17:10:25 +0100")
Message-ID: <87pmrjbmy9.fsf@disp2133>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Borislav Petkov <bp@alien8.de> writes:

> On Mon, Sep 13, 2021 at 05:55:52PM +0200, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>> 
>> Allow a runtime opt-out of kexec support for architecture code in case
>> the kernel is running in an environment where kexec is not properly
>> supported yet.
>> 
>> This will be used on x86 when the kernel is running as an SEV-ES
>> guest. SEV-ES guests need special handling for kexec to hand over all
>> CPUs to the new kernel. This requires special hypervisor support and
>> handling code in the guest which is not yet implemented.
>> 
>> Cc: stable@vger.kernel.org # v5.10+
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>>  include/linux/kexec.h |  1 +
>>  kernel/kexec.c        | 14 ++++++++++++++
>>  kernel/kexec_file.c   |  9 +++++++++
>>  3 files changed, 24 insertions(+)
>
> I guess I can take this through the tip tree along with the next one.

I seem to remember the consensus when this was reviewed that it was
unnecessary and there is already support for doing something like
this at a more fine grained level so we don't need a new kexec hook.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
