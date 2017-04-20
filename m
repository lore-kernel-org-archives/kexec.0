Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d1D18-0001WR-3X
 for kexec@lists.infradead.org; Thu, 20 Apr 2017 14:25:08 +0000
Subject: Re: [PATCH v4 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
References: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <325a8a1b-8f52-b05d-3b7f-440f365dfbbc@suse.com>
Date: Thu, 20 Apr 2017 16:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

On 20/04/17 13:39, Xunlei Pang wrote:
> As Eric said,
> "what we need to do is move the variable vmcoreinfo_note out
> of the kernel's .bss section.  And modify the code to regenerate
> and keep this information in something like the control page.
> 
> Definitely something like this needs a page all to itself, and ideally
> far away from any other kernel data structures.  I clearly was not
> watching closely the data someone decided to keep this silly thing
> in the kernel's .bss section."
> 
> This patch allocates extra pages for these vmcoreinfo_XXX variables,
> one advantage is that it enhances some safety of vmcoreinfo, because
> vmcoreinfo now is kept far away from other kernel data structures.
> 
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>

Xen parts: Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
