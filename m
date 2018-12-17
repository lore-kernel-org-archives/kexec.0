Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrU4-0000GL-E9
 for kexec@lists.infradead.org; Mon, 17 Dec 2018 11:54:53 +0000
Date: Mon, 17 Dec 2018 12:54:38 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/2 v3] kdump, vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181217115438.GB12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Sun, Dec 16, 2018 at 09:16:15PM +0800, Lianbo Jiang wrote:
> This patchset did two things:
> a. add a new document for vmcoreinfo
> 
> This document lists some variables that export to vmcoreinfo, and briefly
> describles what these variables indicate. It should be instructive for
> many people who do not know the vmcoreinfo, and it would normalize the
> exported variable as a standard ABI between kernel and use-space.
> 
> b. export the value of sme mask to vmcoreinfo
> 
> For AMD machine with SME feature, makedumpfile tools need to know whether
> the crash kernel was encrypted or not. If SME is enabled in the first
> kernel, the crash kernel's page table(pgd/pud/pmd/pte) contains the
> memory encryption mask, so need to remove the sme mask to obtain the true
> physical address.
> 
> Changes since v1:
> 1. No need to export a kernel-internal mask to userspace, so copy the
> value of sme_me_mask to a local variable 'sme_mask' and write the value
> of sme_mask to vmcoreinfo.
> 2. Add comment for the code.
> 3. Improve the patch log.
> 4. Add the vmcoreinfo documentation.
> 
> Changes since v2:
> 1. Improve the vmcoreinfo document, add more descripts for these
> variables exported.
> 2. Fix spelling errors in the document.

Yes, it is starting to look better.

The last thing that's missing is a checkpatch.pl check which verifies
whether a new VMCOREINFO export is not being documented and warn if so.
But you can do that later.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
