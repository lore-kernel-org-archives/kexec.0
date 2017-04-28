Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3zp2-0004kO-PA
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 06:56:10 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
Date: Fri, 28 Apr 2017 06:52:56 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
References: <cover.1493272570.git.panand@redhat.com>
In-Reply-To: <cover.1493272570.git.panand@redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "bhe@redhat.com" <bhe@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>

Hello Pratyush,

Thanks for your report, I have received this.
I'm on vacation until Mar 8, I'll review it when I return from vacation.

Thanks,
Atsushi Kumagai

>Hi All,
>
>We came across another failure in makedumpfile when kaslr is enabled. This
>failure occurs when we try re-filtering. We try to erase some symbol from a
>dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.
>
>We have very limited symbol information in vmcoreinfo. So symbols to be
>erased may not be available in vmcoreinfo and we look for it in vmlinux.
>However,  symbol address from vmlinux is a static address which differs
>from run time address with KASLR_OFFSET. Therefore, reading any "virtual
>address of vmlinux" from vmcore is not possible.
>
>These patches finds runtime  KASLR offset and then calculates run time
>address of symbols read from vmlinux.
>
>Since, I am not an expert of x86, and these patches touch x86 part of
>makedumpfile, therefore I have CCed x86 experts. Please, provide your
>review comment and let me know if you think there could have been a better
>way to resolve this issue.
>
>thanks
>
>~Pratyush
>
>Pratyush Anand (2):
>  makedumpfile: add runtime kaslr offset if it exists
>  x86_64: calculate page_offset in case of re-filtering
>
> arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
> erase_info.c   |  1 +
> makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> makedumpfile.h | 15 +++++++++++++++
> 4 files changed, 103 insertions(+), 2 deletions(-)
>
>--
>2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
