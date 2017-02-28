Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cijLg-0002Dw-W8
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 15:05:59 +0000
Received: by mail-pg0-f45.google.com with SMTP id 25so6179089pgy.0
 for <kexec@lists.infradead.org>; Tue, 28 Feb 2017 07:05:36 -0800 (PST)
Subject: Re: [Makedumpfile Patch v2 0/7] Fix --mem-usage /proc/kcore
References: <cover.1488260510.git.panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <83f4e5aa-1376-e387-a986-98c4306ff0a7@redhat.com>
Date: Tue, 28 Feb 2017 20:35:32 +0530
MIME-Version: 1.0
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com



On Tuesday 28 February 2017 11:22 AM, Pratyush Anand wrote:
> `makedumpfile --mem-usage /proc/kcore` has been broken after kaslr specific
> modifications. A kernel patch has been ACKed by Andrew Morton and has been
> sent to Linus now [0]. This kernel patch helps to fix the issue for both
> the case of kaslr enabled and disabled.
>
> [0] http://marc.info/?l=linux-mm-commits&m=148823497215968&w=2

Just FYI,patch is in upstream now.

commit 464920104bf7adac12722035bfefb3d772eb04d8
Author: Pratyush Anand <panand@redhat.com>
Date:   Mon Feb 27 14:27:31 2017 -0800

     /proc/kcore: update physical address for kcore ram and text


>
> Changes since v1:
>  - One more patch..Now mem-usage with older kernel (< 4.11) will only work
>    when that has been rightly patched and -f has been used in makedumpfile
>    command line.
>
> Baoquan He (2):
>   makedumpfile: Correct the calculation of kvaddr in
>     set_kcore_vmcoreinfo
>   makedumpfile: Discard process_dump_load
>
> Pratyush Anand (5):
>   show_mem_usage(): calculate page offset after elf load
>   initial(): call cach_init() a bit early
>   x86_64: check physical address in PT_LOAD for none direct mapped
>     regions
>   elf_info: kcore: check for invalid physical address
>   mem-usage: allow to work only with -f for kernel version < 4.11
>
>  arch/x86_64.c  |  6 ++++--
>  elf_info.c     | 25 +++++--------------------
>  makedumpfile.c | 18 ++++++++++++------
>  3 files changed, 21 insertions(+), 28 deletions(-)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
