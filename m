Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI2jv-0004US-Df
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 20:02:32 +0000
Date: Tue, 19 Mar 2013 13:02:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
Message-Id: <20130319130229.fe83c985678146980ecc6102@linux-foundation.org>
In-Reply-To: <20130316040228.15064.28019.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040228.15064.28019.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, cpw@sgi.com, vgoyal@redhat.com

On Sat, 16 Mar 2013 13:02:29 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> If there's some vmcore object that doesn't satisfy page-size boundary
> requirement, remap_pfn_range() fails to remap it to user-space.
> 
> Objects that posisbly don't satisfy the requirement are ELF note
> segments only. The memory chunks corresponding to PT_LOAD entries are
> guaranteed to satisfy page-size boundary requirement by the copy from
> old memory to buffer in 2nd kernel done in later patch.
> 
> This patch doesn't copy each note segment into the 2nd kernel since
> they amount to so large in total if there are multiple CPUs. For
> example, current maximum number of CPUs in x86_64 is 5120, where note
> segments exceed 1MB with NT_PRSTATUS only.

I don't really understand this.  Why does the number of or size of
note segments affect their alignment?

> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -38,6 +38,8 @@ static u64 vmcore_size;
>  
>  static struct proc_dir_entry *proc_vmcore = NULL;
>  
> +static bool support_mmap_vmcore;

This is quite regrettable.  It means that on some kernels/machines,
mmap(vmcore) simply won't work.  This means that people might write
code which works for them, but which will fail for others when deployed
on a small number of machines.

Can we avoid this?  Why can't we just copy the notes even if there are
a large number of them?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
