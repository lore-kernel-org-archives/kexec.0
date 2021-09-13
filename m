Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoi5-002MKi-W5
 for kexec@lists.infradead.org; Mon, 13 Sep 2021 16:21:35 +0000
Subject: Re: [PATCH v2 00/12] x86/sev: KEXEC/KDUMP support for SEV-ES guests
References: <20210913155603.28383-1-joro@8bytes.org>
 <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com> <YT941raolZvGTVR/@suse.de>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9aa5c10b-56ee-8b26-56d5-870c44e6fbcc@intel.com>
Date: Mon, 13 Sep 2021 09:21:27 -0700
MIME-Version: 1.0
In-Reply-To: <YT941raolZvGTVR/@suse.de>
Content-Language: en-US
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
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On 9/13/21 9:14 AM, Joerg Roedel wrote:
> On Mon, Sep 13, 2021 at 09:02:38AM -0700, Dave Hansen wrote:
>> On 9/13/21 8:55 AM, Joerg Roedel wrote:
>>> This does not work under SEV-ES, because the hypervisor has no access
>>> to the vCPU registers and can't make modifications to them. So an
>>> SEV-ES guest needs to reset the vCPU itself and park it using the
>>> AP-reset-hold protocol. Upon wakeup the guest needs to jump to
>>> real-mode and to the reset-vector configured in the AP-Jump-Table.
>> How does this end up looking to an end user that tries to kexec() from a
>> an SEV-ES kernel?  Does it just hang?
> Yes, the kexec will just hang. This patch-set contains code to disable
> the kexec syscalls in situations where it would not work for that
> reason.

Got it.  The end-user-visible symptom just wasn't obvious.  If you
revise these, it might be nice to add that so that folks who cherry-pick
stable patches or update to new stable kernels have an idea what this
might fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
