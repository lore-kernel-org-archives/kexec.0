Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQd29-0002KD-7l
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 12:24:49 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
Date: Fri, 12 Apr 2013 14:24:43 +0200
Message-ID: <1461590.iEg3524C4m@skinner.arch.suse.de>
In-Reply-To: <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Cliff Wickman <cpw@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On Thursday, April 11, 2013 07:55:57 AM Yinghai Lu wrote:
> On Thu, Apr 11, 2013 at 5:26 AM, Thomas Renninger <trenn@suse.de> wrote:
> > Currently ranges are passed via kernel boot parameters:
> > memmap=exactmap memmap=X#Y memmap=
> > 
> > Pass them via e820 table directly instead.
> 
> how to address "saved_max_pfn" referring in kernel?
Yes, this patch won't work as I miss out the previously usable memory
totally.
I have to re-work this one and also pass these ranges as discussed
via a KDUMP_RESERVED or even better a KDUMP_MEMORY e820 type.
KDUMP_RESERVED could get used for reserved memory inside the crash
kernel range at some point of time if it is useful.

Can the other patches get applied already if they are fine?
 
> kernel need to use saved_max_pfn from old e820 in
> drivers/char/mem.c::read_oldmem()
> 
> mips and powerpc they are passing that from command line "savemaxmem="
> 
> x86 should use that too?
I could add that.
But things cannot get cleaned up because things have to be
compatible to old kexec tools not passing this param at least for
quite some time.

      Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
