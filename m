Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUVOM-0003Y6-Pc
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 11:31:05 +0000
Date: Wed, 5 Dec 2018 12:30:32 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181205113032.GF29510@zn.tnic>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
 <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
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
Cc: linux-doc@vger.kernel.org, bhe@redhat.com, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Tue, Dec 04, 2018 at 05:35:09PM +0800, lijiang wrote:
> There are more people to review and improve this document together, that would
> be fine.

That's basically kernel development :)

> Generating VMCOREINFO is easy in the first kernel, for example:
> # makedumpfile -g VMCOREINFO -x vmlinux

I get:

$ makedumpfile -g VMCOREINFO -x vmlinux
The kernel version is not supported.
The makedumpfile operation may be incomplete.

The vmcoreinfo is saved to VMCOREINFO.

makedumpfile Completed.

But the text file looks ok AFAICT. Please add that command to the
documentation file.

> For these two *why*, it should be easy to understand. Because user-space tools
> need to know basic information, such as the symbol values, field offset, structure
> size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
> kernel.

That's clear. The question is *why* *exactly* is every piece of export
needed.

> For the second question 'how they are used', we can get the answer
> from user-space tools, such as makedumpfile, crash tools. Therefore,
> it may not need to explain any more in kernel document. On the other
> hand, if we must put these contents into kernel document, i have to
> say, that would be a hard task.

You can put one or two sentences for each, stating what they're used
for. This way, people can go and look up makedumpfile source code for
further info and people trying to add new items to VMCOREINFO can look
in this documentation here first to figure out whether maybe the info
they need has been exported already.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
