Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI3k6-00072I-Rg
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:06:47 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040154.15064.35482.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 14:06:39 -0700
In-Reply-To: <20130316040154.15064.35482.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:01:54 +0900")
Message-ID: <87zjxzp09s.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 12/21] vmcore: allocate per-cpu crash_notes objects on
 page-size boundary
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> To satisfy mmap()'s page-size boundary requirement, allocate per-cpu
> crash_notes objects on page-size boundary.
>
> /proc/vmcore on the 2nd kernel checks if each note objects is
> allocated on page-size boundary. If there's some object not satisfying
> the page-size boundary requirement, /proc/vmcore doesn't provide
> mmap() interface.

Does this actually help?  My memory is that /proc/vmcore did some magic
behind the scenes to combine these multiple note sections into a single
note section.

Certainly someone has to combine them together to make a valid elf
executable.

At the same time I don't see any harm in rounding up to a page size
here, but I don't see the point either.

Eric

> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  kernel/kexec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index bddd3d7..d1f365e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1234,7 +1234,8 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
>  static int __init crash_notes_memory_init(void)
>  {
>  	/* Allocate memory for saving cpu registers. */
> -	crash_notes = alloc_percpu(note_buf_t);
> +	crash_notes = __alloc_percpu(roundup(sizeof(note_buf_t), PAGE_SIZE),
> +				     PAGE_SIZE);
>  	if (!crash_notes) {
>  		printk("Kexec: Memory allocation for saving cpu register"
>  		" states failed\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
