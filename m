Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrSP-0007sz-9S
 for kexec@lists.infradead.org; Mon, 17 Dec 2018 11:53:11 +0000
Date: Mon, 17 Dec 2018 12:52:45 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181217115245.GA12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-2-lijiang@redhat.com>
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

On Sun, Dec 16, 2018 at 09:16:16PM +0800, Lianbo Jiang wrote:
> +================
> +Common variables
> +================
> +
> +init_uts_ns.name.release
> +========================
> +The number of OS release. Based on this version number, people can find
> +the source code for the corresponding version. When analyzing the vmcore,
> +people must read the source code to find the reason why the kernel crashed.
> +

> +
> +init_uts_ns
> +===========
> +This is the UTS namespace, which is used to isolate two specific elements
> +of the system that relate to the uname system call. The UTS namespace is
> +named after the data structure used to store information returned by the
> +uname system call.
> +
> +User-space tools can get the kernel name, host name, kernel release number,
> +kernel version, architecture name and OS type from the 'init_uts_ns'.

And this document already fulfills its purpose - those two vmcoreinfo
exports are redundant and the first one can be removed.

And now that we agreed that VMCOREINFO is not an ABI and is very tightly
coupled to the kernel version, init_uts_ns.name.release can be removed,
yes?

Or is there anything speaking against that?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
