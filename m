Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGNAs-00055a-Ma
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 05:27:28 +0000
Date: Fri, 15 Mar 2013 14:16:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/3] makedumpfile, elf: distinguish ELF note types by
 ELF note names
Message-Id: <20130315141640.b19dcb7c86289e6fe3da6ce3@mxc.nes.nec.co.jp>
In-Reply-To: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
References: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Mon, 04 Mar 2013 13:18:24 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> In ELF, the same integers for two note type represent different
> meanings if the names they belong to are different. However,
> get_pt_note_info() doesn't distinguish note types by name space, due
> to which, for example, any new note type in "VMCOREINFO" name space is
> wrongly interpretted as NT_PRSTATUS or the unique note type in
> "VMCOREINFO" name space.
> 
> This patch series makes get_pt_note_info() distinguish ELF note types
> by ELF note names along with cleanups related to this change.

Reviewed and applied.


Thanks
Atsushi Kumagai.

> 
> For reference:
> 
>   Note Section
>   http://www.sco.com/developers/gabi/latest/ch5.pheader.html#note_section
> 
> type
> 
>     This word gives the interpretation of the descriptor. Each
>     originator controls its own types; multiple interpretations of a
>     single type value may exist. Thus, a program must recognize both
>     the name and the type to recognize a descriptor. Types currently
>     must be non-negative. The ABI does not define what descriptors
>     mean.
> 
> ---
> 
> HATAYAMA Daisuke (3):
>       elf: distinguish ELF note types by ELF note name space
>       elf: swap checking order of VMCOREINFO and VMCOREINFO_XEN
>       elf, sadump: move KEXEC macros from sadump_info.c to elf_info.h
> 
> 
>  elf_info.c    |   83 ++++++++++++++++++++++++++++++++++++++-------------------
>  elf_info.h    |    3 ++
>  sadump_info.c |    4 +--
>  3 files changed, 59 insertions(+), 31 deletions(-)
> 
> -- 
> 
> Thanks.
> HATAYAMA, Daisuke
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
