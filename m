Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvzt-0004Gh-LX
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 12:33:15 +0000
Date: Fri, 11 Jan 2019 13:33:00 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190111123300.GE4729@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110121944.6050-2-lijiang@redhat.com>
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
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Thu, Jan 10, 2019 at 08:19:43PM +0800, Lianbo Jiang wrote:
> +init_uts_ns.name.release
> +------------------------
> +
> +The version of the Linux kernel. Used to find the corresponding source
> +code from which the kernel has been built.
> +

...

> +
> +init_uts_ns
> +-----------
> +
> +This is the UTS namespace, which is used to isolate two specific
> +elements of the system that relate to the uname(2) system call. The UTS
> +namespace is named after the data structure used to store information
> +returned by the uname(2) system call.
> +
> +User-space tools can get the kernel name, host name, kernel release
> +number, kernel version, architecture name and OS type from it.

Already asked this but no reply so lemme paste my question again:

"And this document already fulfills its purpose - those two vmcoreinfo
exports are redundant and the first one can be removed.

And now that we agreed that VMCOREINFO is not an ABI and is very tightly
coupled to the kernel version, init_uts_ns.name.release can be removed,
yes?

Or is there anything speaking against that?"

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
