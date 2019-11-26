Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZbPw-0000Js-LH
 for kexec@lists.infradead.org; Tue, 26 Nov 2019 14:02:14 +0000
Received: by mail-io1-xd42.google.com with SMTP id x21so20681968ior.2
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2019 06:02:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
In-Reply-To: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Tue, 26 Nov 2019 19:31:59 +0530
Message-ID: <CAJ2QiJ+RhQ_XjTZ_qEkx1Wuf44oSZe1sGj2poLfk5XvbU-JX+A@mail.gmail.com>
Subject: Re: kexec-tools/vmcore-demsg: No program header covering vaddr
 0xffff000be7a00000found kexec bug?
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
To: kexec mailing list <kexec@lists.infradead.org>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Prabhakar Kushwaha <pkushwaha@marvell.com>

On Tue, Nov 26, 2019 at 1:04 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> Hi All,
>
> I am facing issue below error with latest kexec-tools/vmcore-demsg tools.
>
> $ ./build/sbin/vmcore-dmesg /proc/vmcore
> No program header covering vaddr 0xffff000be7a00000found kexec bug?
>
> I am testing on AARM64 platform with following git repos.
> A) kexec tools:
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> top commit: bd077966e2b9041c (kexec-tools: Fix conversion overflow
> when compiling on 32-bit platforms)
>
> B) Linux:git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> top commit: af42d3466bdc8f3980 (Linux 5.4-rc8)
>
> I am seeing similar issue in past also in couple of discussions. has
> it not fixed earlier or it keep arises with time to time
>

I did further analysis and with below changes kexec-tools/vmcore-demsg
working fine

diff --git a/kexec/arch/arm64/crashdump-arm64.c
b/kexec/arch/arm64/crashdump-arm64.c
index 4fd7aa8..1c28b06 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -58,6 +58,8 @@ static uint64_t get_kernel_page_offset(void)
 {
        int i;

+       return 0xffff000000000000;
        if (elf_info.kern_vaddr_start == UINT64_MAX)
                return UINT64_MAX;

After patch 14c127c957c1 ("arm64: mm: Flip kernel VA space") in Linux,
the PAGE_OFFSET address has been moved to bottom instead of middle in
kernel virtual address space. looks like existing code still assumes
PAGE_OFFSET in middle.

A proper fix is required.  Let me work on this.

--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
