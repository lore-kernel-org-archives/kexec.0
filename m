Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bs5qc-0001PE-8K
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 10:24:18 +0000
Date: Thu, 6 Oct 2016 18:23:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 0/3] makedumpfile: Add support of mm randomization
Message-ID: <20161006102353.GA17662@x1>
References: <1475747408-25666-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1475747408-25666-1-git-send-email-bhe@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: dyoung@redhat.com, kexec@lists.infradead.org, thgarnie@google.com, tonli@redhat.com

Oops, I just sent to Atsushi's old mail. Sorry about this!

On 10/06/16 at 05:50pm, Baoquan He wrote:
> This is v2 post.
> 
> Because of Thomas's kernel patchset, direct mapping, vmalloc and vmemmap
> could have random starting address. They need be exported to VMCOREINFO
> and let makedumpfile know this so that makedumpfile can identify these
> memory areas correctly.
> 
> Below is the kernel patchset from Thomas:
> x86/mm: memory area address KASLR 
> https://lwn.net/Articles/692289/
> 
> I have posted a new kernel patchset to export the base of direct mapping,
> vmalloc and vmemmap. The subject is:
> kexec: Export memory sections virtual addresses to vmcoreinfo
> 
> v1->v2:
>     According to Atsushi's comment, mainly change patch 3/3.
>     - Remove VMALLOC_END_ORIG, VMEMMAP_END_ORIG , VMALLOC_END_2_6_31
>       and VMEMMAP_END_2_6_31 since they are not needed anymore.
>     - Put those number table member value assignment into
>       get_versiondep_info_x86_64.
> 
> Baoquan He (3):
>   makedumpfile: Get info->kernel_version from SYMBOL(init_uts_ns)
>     earlier
>   makedumpfile: Move get_versiondep_info calling earlier
>   makedumpfile: Add support for MM randomization
> 
>  arch/x86_64.c  | 51 ++++++++++++++++++++++++++++++++++-----------------
>  makedumpfile.c | 33 ++++++++++++++++-----------------
>  makedumpfile.h |  7 +++----
>  3 files changed, 53 insertions(+), 38 deletions(-)
> 
> -- 
> 2.5.5
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
