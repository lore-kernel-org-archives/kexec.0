Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG8tk-0005C3-QL
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 20:40:02 +0000
Received: by mail-lf1-f66.google.com with SMTP id h192so1896813lfg.3
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2018 13:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <4AE2DC15AC0B8543882A74EA0D43DBEC0355E7D3@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0355E7D3@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sat, 27 Oct 2018 02:09:35 +0530
Message-ID: <CACi5LpNOjykaVpHT6N28xf_mkXcB9uQDHG0GX9oP8Q9rXs+FQw@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile/x86_64: Fix calculation of page_offset for
 kernel 4.19
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
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Hi Kazu,

On Sat, Oct 27, 2018 at 12:34 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> Hi Bhupesh, Baoquan,
>
> As for x86_64, I'm going to merge the patch below for fixing the
> --mem-usage issue with kernel 4.19, if there is no objection.
> I think the same approach will also work on arm64 with regard to
> page_offset for the time being..
>

I am sorry for holding on to my reply on the patch (sent by me) which
we were discussing past week, but it has not been easy for me to have
access to different type of arm64 boards (so that we can cover a broad
spectrum of the boards) and my x86_64 virtual machine is also giving
me several weird setup issues this week.

Anyways, I think for now I would suggest that you hold on applying
this patch, as although it works on my x86_64 vm and one type of arm64
boards, it fails on a few other arm64 setups.

I think I have a cleaner approach in mind for x86_64 (which I am just
thrashing out on my x86_64 vm) and along with the earlier patch I
shared for arm64 it should fix issues with live debugging (i.e.
--mem-usage use case) with makedumpfile. But for that I need to send a
x86_64 kernel patch and see their opinions on the same (as Bao
captured in this earlier email, it might be that the x86_64
maintainers may not like this approach, but I think we can try and
start a discussion at-least as I see that the arm64 kernel maintainers
are willing to accept only this approach further).

I would suggest that since we are looking to support newer kernels, we
better shift to a uniform approach for all the archs (which is the
intent behind the kernel patchset which enabled VMCOREINFO PT_NOTE in
'proc/kcore'). I know that you and Bao have some apprehensions with
the same, so let me try and put out the solution which should fix the
x86_64 part as well and then we can thrash out a solution that
probably fits all archs.

I will also come back with my comments on the review comments on the
patch I posted last week in a day or two.

Thanks for your patience.
Regards,
Bhupesh


> --
> From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Date: Fri, 26 Oct 2018 14:43:22 -0400
> Subject: [PATCH] x86_64: Fix calculation of page_offset for kernel 4.19
>
> * Required for kernel 4.19
>
> Kernel commit 6855dc41b24619c3d1de3dbd27dd0546b0e45272 ("x86: Add
> entry trampolines to kcore") added program headers for PTI entry
> trampoline pages to /proc/kcore.
>
> This caused the failure of makedumpfile --mem-usage due to wrong
> calculation of page_offset.
>
>   # makedumpfile --mem-usage /proc/kcore
>   [...]
>   set_kcore_vmcoreinfo: Can't get the offset of VMCOREINFO(/proc/kcore). Success
>
>   makedumpfile Failed.
>
> Since program headers for linear maps are located after ones for
> kernel text and so on in /proc/vmcore and /proc/kcore, with this
> patch, we use the last valid one to set page_offset.
>
> Also, this patch adds a few debug messages for better debugging.
>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> ---
>  arch/x86_64.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index 2b3c0bb..ed2a970 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -95,10 +95,17 @@ get_page_offset_x86_64(void)
>                          ERRMSG("Can't read page_offset_base.\n");
>                          return FALSE;
>                 }
> +               DEBUG_MSG("page_offset  : %lx (from page_offset_base)\n",
> +                       info->page_offset);
>                 return TRUE;
>         }
>
>         if (get_num_pt_loads()) {
> +               /*
> +                * Since program headers for linear maps are located after
> +                * ones for kernel text and so on in /proc/vmcore and
> +                * /proc/kcore, we use the last valid one to set page_offset.
> +                */
>                 for (i = 0;
>                         get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>                         i++) {
> @@ -106,9 +113,13 @@ get_page_offset_x86_64(void)
>                                         && virt_start < __START_KERNEL_map
>                                         && phys_start != NOT_PADDR) {
>                                 info->page_offset = virt_start - phys_start;
> -                               return TRUE;
>                         }
>                 }
> +               if (info->page_offset) {
> +                       DEBUG_MSG("page_offset  : %lx (from pt_load)\n",
> +                               info->page_offset);
> +                       return TRUE;
> +               }
>         }
>
>         if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
> @@ -119,6 +130,7 @@ get_page_offset_x86_64(void)
>                 info->page_offset = __PAGE_OFFSET_2_6_27;
>         }
>
> +       DEBUG_MSG("page_offset  : %lx (from constant)\n", info->page_offset);
>         return TRUE;
>  }
>
> --
> 1.8.3.1
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
