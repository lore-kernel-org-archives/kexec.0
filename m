Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7OKB-0007Iy-Bg
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 17:51:24 +0000
Date: Fri, 22 Mar 2019 18:51:14 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190322175114.GL12472@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190321103309.27883-2-lijiang@redhat.com>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Thu, Mar 21, 2019 at 06:33:07PM +0800, Lianbo Jiang wrote:
> Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
> PAGE_KERNEL protection for ioremap of memory pages"),

The proper commit quotation format is done by adding this to your
.gitconfig:

[core]
        abbrev = 12
[alias]
        one = show -s --pretty='format:%h (\"%s\")'

and then doing:

$ git one <commit id>

which will give you

0e4c12b45aa8 ("x86/mm, resource: Use PAGE_KERNEL protection for ioremap of memory pages")

> here it is really checking for the 'IORES_DESC_ACPI_*' values.

Well, it is not really checking that.

> Therefore, it is necessary to change the examination condition
> to avoid confusion.

What confusion?

The justification for that change sounds really fishy.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
