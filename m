Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RcuxH-0005eN-9v
 for kexec@lists.infradead.org; Tue, 20 Dec 2011 08:21:50 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id pBK8LQsl004208
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 17:21:26 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id pBK8LQJ29458 for kexec@lists.infradead.org;
 Tue, 20 Dec 2011 17:21:26 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id pBK8LQqu003869
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 17:21:26 +0900 (JST)
Date: Tue, 20 Dec 2011 17:18:12 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 10/14] Generate and save VMCOREINFO and ELF note
 information
Message-Id: <20111220171812.874961f9.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111028094858.20940.24950.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
 <20111028094858.20940.24950.stgit@localhost6.localdomain6>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi Hatayama-san,

> [snipped]
>
> diff --git a/elf_info.c b/elf_info.c
> index 114dd05..48f8510 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -760,7 +760,7 @@ get_nr_cpus(void)
>  int
>  has_pt_note(void)
>  {
> -	if (offset_pt_note_memory && size_pt_note_memory)
> +	if (offset_pt_note_memory || size_pt_note_memory)
>  		return TRUE;
>  	return FALSE;
>  }

I have a question.
In what kind of case is only one of the offset or the size set to 0 in PT_NOTE?

Thanks.
Atsushi Kumagai


On Fri, 28 Oct 2011 18:48:58 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Retrieve VMCOREINFO from VMLINUX and ELF note information from
> VMCORE(s) and save them in generated DUMPFILE.
> 
> ELF note information is NT_PRSTATUS only. If crash_notes is NULL,
> indicating kdump has not saved register values, save SMRAM CPU STATE
> values. If crash_notes is not NULL, indicating kdump has saved
> register values at crash, then save the register values in
> crash_notes.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  elf_info.c     |    2 
>  makedumpfile.c |  103 ++++---
>  makedumpfile.h |    2 
>  sadump_info.c  |  823 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sadump_info.h  |   26 ++
>  5 files changed, 913 insertions(+), 43 deletions(-)
>
> [snipped]
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
