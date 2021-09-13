Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoQH-002GyE-Bg
 for kexec@lists.infradead.org; Mon, 13 Sep 2021 16:03:10 +0000
Subject: Re: [PATCH v2 00/12] x86/sev: KEXEC/KDUMP support for SEV-ES guests
References: <20210913155603.28383-1-joro@8bytes.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com>
Date: Mon, 13 Sep 2021 09:02:38 -0700
MIME-Version: 1.0
In-Reply-To: <20210913155603.28383-1-joro@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On 9/13/21 8:55 AM, Joerg Roedel wrote:
> This does not work under SEV-ES, because the hypervisor has no access
> to the vCPU registers and can't make modifications to them. So an
> SEV-ES guest needs to reset the vCPU itself and park it using the
> AP-reset-hold protocol. Upon wakeup the guest needs to jump to
> real-mode and to the reset-vector configured in the AP-Jump-Table.

How does this end up looking to an end user that tries to kexec() from a
an SEV-ES kernel?  Does it just hang?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
