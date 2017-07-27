Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1damgY-000344-Lk
 for kexec@lists.infradead.org; Thu, 27 Jul 2017 17:34:56 +0000
Received: by mail-oi0-x241.google.com with SMTP id e124so15214612oig.0
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 10:34:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <62566e96-4e05-1622-bf3c-bf392506e84b@amd.com>
References: <cover.1501092102.git.thomas.lendacky@amd.com>
 <28648b23b9957506069e20bd985e3d7e8af94780.1501092102.git.thomas.lendacky@amd.com>
 <20170727071717.aydwpzaji6l2o6xs@gmail.com>
 <62566e96-4e05-1622-bf3c-bf392506e84b@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Jul 2017 10:34:32 -0700
Message-ID: <CA+55aFwRykCYz0p1WTJeehcpXwqN10UGOJrMcTRB4zUxt=D5ng@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] x86/mm, kexec: Fix memory corruption with SME on
 successive kexecs
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, the arch/x86 maintainers <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Thu, Jul 27, 2017 at 7:15 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> I can #ifdef the wbinvd based on whether AMD_MEM_ENCRYPT is configured
> or not so that the wbinvd is avoided if not configured.

I suspect an ifdef will be useless, since things like distro kernels
tend to enable everything.

So it should probably be disabled dynamically, and only done if the
AMD memory encryption thing has actually been active.

[ There have also been various actual errata with wbinvd, so there
tends to be a non-performance reason to try to avoid it unless
strictly required ]

               Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
