Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPob6-002K2p-9P
 for kexec@lists.infradead.org; Mon, 13 Sep 2021 16:14:21 +0000
Date: Mon, 13 Sep 2021 18:14:14 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 00/12] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Message-ID: <YT941raolZvGTVR/@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On Mon, Sep 13, 2021 at 09:02:38AM -0700, Dave Hansen wrote:
> On 9/13/21 8:55 AM, Joerg Roedel wrote:
> > This does not work under SEV-ES, because the hypervisor has no access
> > to the vCPU registers and can't make modifications to them. So an
> > SEV-ES guest needs to reset the vCPU itself and park it using the
> > AP-reset-hold protocol. Upon wakeup the guest needs to jump to
> > real-mode and to the reset-vector configured in the AP-Jump-Table.
> 
> How does this end up looking to an end user that tries to kexec() from a
> an SEV-ES kernel?  Does it just hang?

Yes, the kexec will just hang. This patch-set contains code to disable
the kexec syscalls in situations where it would not work for that
reason.

Actually with the changes to the decompressor in this patch-set the
kexec'ed kernel could boot, but would fail to bring up all the APs.

Regards,

	Joerg

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
