Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI4m8-0000d7-Pq
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 22:12:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040200.15064.86851.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 15:12:48 -0700
In-Reply-To: <20130316040200.15064.86851.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:02:00 +0900")
Message-ID: <871ubbm42n.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 13/21] kexec: allocate vmcoreinfo note buffer on
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

> To satisfy mmap()'s page-size boundary requirement, specify aligned
> attribute to vmcoreinfo_note objects to allocate it on page-size
> boundary.

Those requirements don't exist.  Making this patch wasteful and wrong.

Eric

> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  include/linux/kexec.h |    6 ++++--
>  kernel/kexec.c        |    2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d2e6927..5113570 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -185,8 +185,10 @@ extern struct kimage *kexec_crash_image;
>  #define VMCOREINFO_BYTES           (4096)
>  #define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
>  #define VMCOREINFO_NOTE_NAME_BYTES ALIGN(sizeof(VMCOREINFO_NOTE_NAME), 4)
> -#define VMCOREINFO_NOTE_SIZE       (KEXEC_NOTE_HEAD_BYTES*2 + VMCOREINFO_BYTES \
> -				    + VMCOREINFO_NOTE_NAME_BYTES)
> +#define VMCOREINFO_NOTE_SIZE       ALIGN(KEXEC_NOTE_HEAD_BYTES*2	\
> +					 +VMCOREINFO_BYTES		\
> +					 +VMCOREINFO_NOTE_NAME_BYTES,	\
> +					 PAGE_SIZE)
>  
>  /* Location of a reserved region to hold the crash kernel.
>   */
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index d1f365e..195de6d 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -43,7 +43,7 @@ note_buf_t __percpu *crash_notes;
>  
>  /* vmcoreinfo stuff */
>  static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
> -u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
> +u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4] __aligned(PAGE_SIZE);
>  size_t vmcoreinfo_size;
>  size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
