Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqG5U-0000hk-HY
 for kexec@lists.infradead.org; Tue, 21 Mar 2017 09:28:22 +0000
Date: Tue, 21 Mar 2017 10:27:56 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
Message-ID: <20170321102756.795fe8ae@hananiah.suse.cz>
In-Reply-To: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Mon, 20 Mar 2017 13:50:31 +0800
Xunlei Pang <xlpang@redhat.com> wrote:

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

Yes, I like this patch set very much now. Thank you!

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
