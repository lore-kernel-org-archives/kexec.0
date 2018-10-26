Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG4uu-000125-G2
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 16:25:26 +0000
Date: Fri, 26 Oct 2018 18:24:40 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181026182440.20a4b107@ezekiel.suse.cz>
In-Reply-To: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
MIME-Version: 1.0
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Boris Petkov <bp@alien8.de>, tglx@linutronix.de, dyoung@redhat.com

On Fri, 26 Oct 2018 20:32:11 +0800
lijiang <lijiang@redhat.com> wrote:

>[...]
> For AMD machine with the SME feature, the msr 'MSR_K8_SYSCFG' can examine
> whether SME is enabled in kernel, but the kexec is also userspace tool,
> it has no permission to access the msr.

But we need the MSR value from the panic kernel environment, not while
the production kernel is still running, right?

If so, then this reminds me that I have wanted for a long time to store
more of the hardware state in a vmcore NOTE after a kernel crash ...
control registers, MSRs and whatnot. Of course, this would be a
long-term project, but I wonder what other people think about it in
general.

Just my 2 cents,
Petr T

> Furthermore, i also tried to read the "/dev/cpu/cpu[number]/msr", but
> the value depends on BIOS's configuration. That is to say, if SME is
> set in BIOS, the value of msr is always 0xF40000 whatever the kernel
> commandline parameter is "mem_encrypt=on" or "mem_encrypt=off".
> 
> If i made a mistake, please help to point it out.
> 
> Thanks.
> Lianbo
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
