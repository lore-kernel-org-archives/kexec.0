Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezFFq-0005rX-G0
 for kexec@lists.infradead.org; Fri, 23 Mar 2018 05:28:44 +0000
Received: by mail-qk0-x243.google.com with SMTP id o64so11776064qkl.7
 for <kexec@lists.infradead.org>; Thu, 22 Mar 2018 22:28:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 23 Mar 2018 13:28:27 +0800
Message-ID: <CAFgQCTu3NRA1vi6auftHeXBWvPWgZRRURLHB6u7ih0TnkrzXrQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/3] enable nr_cpus for powerpc
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
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, paulus@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>

Maintainers, ping? Any comment?

Thanks

On Thu, Mar 15, 2018 at 12:41 PM, Pingfan Liu <kernelfans@gmail.com> wrote:
> This topic has a very long history. It comes from Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> For v3: https://patchwork.ozlabs.org/patch/834860/
> I hope we can acquire it for "kexec -p" soon.
>
> V4->V5:
>   improve the [1/3] implementation based on Benjamin's suggestion.
>
> Mahesh Salgaonkar (1):
>   ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
>     hit.
>
> Pingfan Liu (2):
>   powerpc, cpu: partially unbind the mapping between cpu logical id and
>        its seq in dt
>   powerpc, cpu: handling the special case when boot_cpuid greater than
>     nr_cpus
>
>  arch/powerpc/include/asm/paca.h    |  3 +++
>  arch/powerpc/include/asm/smp.h     |  2 ++
>  arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
>  arch/powerpc/kernel/prom.c         | 27 ++++++++++++++++-----------
>  arch/powerpc/kernel/setup-common.c | 35 ++++++++++++++++++++++++++++++++---
>  5 files changed, 67 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
