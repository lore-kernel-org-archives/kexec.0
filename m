Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dE9yE-0006ZX-Vv
 for kexec@lists.infradead.org; Fri, 26 May 2017 07:47:40 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH v4 0/2] Fix refiltering when kaslr enabled
Date: Fri, 26 May 2017 07:45:16 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDB6BC@BPXM01GP.gisp.nec.co.jp>
References: <cover.1495767738.git.panand@redhat.com>
In-Reply-To: <cover.1495767738.git.panand@redhat.com>
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
Cc: "xlpang@redhat.com" <xlpang@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

I have nothing to comment anymore, thanks for your hard work.
I'll merge v4 patches into v1.6.2.

Regards,
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
>Hatayama Daisuke also found some issue [1] when he was working with a
>sadump and virsh dump of a none kaslr kernel. Patch 2/2 of this series has
>been improved to take care of those issues as well.
>
>[1]http://lists.infradead.org/pipermail/kexec/2017-May/018833.html
>
>Thanks
>
>~Pratyush
>
>v1->v2:
> - reading KERNELOFFSET from vmcoreinfo now instead of calculating it from
>   _stext
>v2->v3:
> - Fixed initialization of info->file_vmcoreinfo
> - Improved page_offset calculation logic to take care of different dump
>   scenarios.
>v3->v4:
> - Removed info->kaslr_offset write to VMCOREINFO
>
>
>
>Pratyush Anand (2):
>  makedumpfile: add runtime kaslr offset if it exists
>  x86_64: calculate page_offset in case of re-filtering/sadump/virsh
>    dump
>
> arch/x86_64.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
> erase_info.c   |  1 +
> makedumpfile.c | 46 +++++++++++++++++++++++++++++++++++++
> makedumpfile.h | 16 +++++++++++++
> 4 files changed, 128 insertions(+), 7 deletions(-)
>
>--
>2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
