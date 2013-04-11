Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ia0-x230.google.com ([2607:f8b0:4001:c02::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQIuu-0003CT-2f
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 14:56:00 +0000
Received: by mail-ia0-f176.google.com with SMTP id o25so218421iad.7
 for <kexec@lists.infradead.org>; Thu, 11 Apr 2013 07:55:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365683207-42425-6-git-send-email-trenn@suse.de>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
Date: Thu, 11 Apr 2013 07:55:57 -0700
Message-ID: <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
From: Yinghai Lu <yinghai@kernel.org>
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
To: Thomas Renninger <trenn@suse.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Cliff Wickman <cpw@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Apr 11, 2013 at 5:26 AM, Thomas Renninger <trenn@suse.de> wrote:
> Currently ranges are passed via kernel boot parameters:
> memmap=exactmap memmap=X#Y memmap=
>
> Pass them via e820 table directly instead.

how to address "saved_max_pfn" referring in kernel?

kernel need to use saved_max_pfn from old e820 in
drivers/char/mem.c::read_oldmem()

mips and powerpc they are passing that from command line "savemaxmem="

x86 should use that too?

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
