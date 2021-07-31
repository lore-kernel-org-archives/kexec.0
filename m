Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9jFf-00B9Mg-QF
 for kexec@lists.infradead.org; Sat, 31 Jul 2021 07:17:45 +0000
Date: Sat, 31 Jul 2021 09:17:37 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 11/12] x86/sev: Handle CLFLUSH MMIO events
Message-ID: <YQT5Ec5M6maZdFoO@suse.de>
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-12-joro@8bytes.org>
 <YQSAVo0CXUKHXdLF@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQSAVo0CXUKHXdLF@google.com>
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
To: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi Sean,

On Fri, Jul 30, 2021 at 10:42:30PM +0000, Sean Christopherson wrote:
> On Wed, Jul 21, 2021, Joerg Roedel wrote:
> This wording can be misread as "the hypervisor is responsible for _all_ cache
> management".  Maybe just:
> 
> 		/*
> 		 * Ignore CLFLUSHes - the hyperivsor is responsible for cache
> 		 * management of emulated MMIO.
> 		 */

Right, will update the comment, thanks.

> Side topic, out of curisoity, what's mapping/accessing emulated MMIO as non-UC?

The CLFLUSHes happen when the kexec'ed kernel maps the VGA framebuffer
as unencrypted. Initially it is mapped encrypted and before re-mapping
the kernel flushes the range from the caches.

I have not investigated why this doesn't happen on the first boot,
though.

Regards,

	Joerg

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
