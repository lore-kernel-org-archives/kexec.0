Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGAXc-0007oH-3K
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 22:25:17 +0000
Date: Sat, 27 Oct 2018 00:25:17 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181026222517.GB26927@nazgul.tnic>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181026182440.20a4b107@ezekiel.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: lijiang <lijiang@redhat.com>, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On Fri, Oct 26, 2018 at 06:24:40PM +0200, Petr Tesarik wrote:
> But we need the MSR value from the panic kernel environment, not while
> the production kernel is still running, right?

Actually, we need only the encryption bit number (and it should be 0
otherwise to denote SME wasn't enabled).

I guess something like

	VMCOREINFO_NUMBER(sme_mask);

which gets written by the kexec-ed kernel.

> If so, then this reminds me that I have wanted for a long time to store
> more of the hardware state in a vmcore NOTE after a kernel crash ...
> control registers, MSRs and whatnot. Of course, this would be a
> long-term project, but I wonder what other people think about it in
> general.

I guess that sounds like a good idea - the more relevant hw info for
debugging, the better. Determining the important MSRs to save would need
a bit of a pondering over though. For example, some MSRs are per-core,
some per-socket, etc...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
