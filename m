Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn3xn-0000At-CP
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 08:32:32 +0000
Message-Id: <4FF6BDFB020000780008DFEF@nat28.tlf.novell.com>
Date: Fri, 06 Jul 2012 09:29:15 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S
 during kexec boot
References: <20120705210607.GA26908@aepfle.de>
In-Reply-To: <20120705210607.GA26908@aepfle.de>
Mime-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

>>> On 05.07.12 at 23:06, Olaf Hering <olaf@aepfle.de> wrote:
> My question is: were to put additional debug to trace the copying of the
> data section to its final destination? Is this a task of kexec -l or
> does that happen during decompressing? I suspect the latter. This is the
> console output before the crash (the crash happens in 'movq %rax, %cr3'):
> 
> ...
> [   44.072548] Starting new kernel
> I'm in purgatory
> early console in decompress_kernel
> 
> Decompressing Linux... Parsing ELF... done.

According to this, I'd first of all extend the printing done on
arch/x86/boot/compressed/misc.c:parse_elf(). One possible
problem (without much looking at how the individual address
ranges get determined) could be overlapping memory ranges
in the call to memcpy() inside the loop.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
