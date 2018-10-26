Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG55e-0005tZ-4N
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 16:36:03 +0000
Date: Fri, 26 Oct 2018 18:35:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181026163554.GA26331@nazgul.tnic>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On Fri, Oct 26, 2018 at 08:32:11PM +0800, lijiang wrote:
> If SME is enabled in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
> contains the memory encryption mask, so i have to remove the sme mask to obtain the
> true physical address when dump vmcore.

Sorry, I have no clue what makedumpfile does exactly so you'd have to
be more detailed (or wait until I look at it :)). Which kernel accesses
which kernel's pagetable?

/me goes and looks at the makedumpfile's manpage...

Ok, it uses vmcoreinfo to exclude pages which would mean, it accesses
the first kernel's pagetable and traverses it.

Am I close?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
