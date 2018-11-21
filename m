Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPN5p-0005AA-Jc
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 07:38:39 +0000
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so3898646ljh.13
 for <kexec@lists.infradead.org>; Tue, 20 Nov 2018 23:38:27 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 21 Nov 2018 13:07:57 +0530
Message-ID: <CACi5LpPestnsByi29X9uOaP04J3LgG4BSj_ODKEDG8S9sLkEsg@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: James Morse <james.morse@arm.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>, Dave Anderson <anderson@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Kazu,

On Tue, Nov 20, 2018 at 2:47 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 11/15/2018 4:47 PM, Bhupesh Sharma wrote:
> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
>
> I agree.
>
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> > details), whose live debugging feature is broken with newer kernels
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
>
> Actually, the KCORE_REMAP segments were already removed from kcore by
> commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
> and kcore's program headers got back to the previous ones, but this
> fact shows that they are changeable.
>
> So I think that if we have this NUMBER(page_offset_base) in vmcoreinfo
> for x86_64, user-space tools (especially makedumpfile) would become
> more stable against changes in kcore and vmcore, rather than depending
> on their PT_LOAD values.

Thanks a lot for your review.

Hi x86 maintainers,

Ping, any comments on this patch. Since it is a useful addition to the
kernel-userspace ABI (as suggested by the user-space utility
maintainer as well), can we consider including this in the kernel?

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
