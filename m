Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZbAdi-00085T-J3
 for kexec@lists.infradead.org; Sun, 13 Sep 2015 17:00:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com>
Date: Sun, 13 Sep 2015 11:52:41 -0500
In-Reply-To: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com> (Minfei
 Huang's message of "Sun, 13 Sep 2015 15:15:12 +0800")
Message-ID: <87fv2il0rq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Add prefix "kexec" to output message
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, linux-kernel@vger.kernel.org

Minfei Huang <mnfhuang@gmail.com> writes:

> kexec output message misses the prefix "kexec", when Dave Young split
> the kexec code. To keep the same format, add the prefix "kexec" to
> output message.

What of kexec_core? What of the messages that already have a prefix?

Eric

> Following is the format of output message now.
> [  140.290795] SYSC_kexec_load: hello, world
>
> Ideally, the format of output message likes below.
> [  140.291534] kexec: sanity_check_segment_list: hello, world
>
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
>  kernel/kexec.c      | 2 ++
>  kernel/kexec_file.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 4c5edc3..15351ba 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -6,6 +6,8 @@
>   * Version 2.  See the file COPYING for more details.
>   */
>  
> +#define pr_fmt(fmt)	"kexec: " fmt
> +
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 6a9a3f2..b1ad01b 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -9,6 +9,8 @@
>   * Version 2.  See the file COPYING for more details.
>   */
>  
> +#define pr_fmt(fmt)	"kexec: " fmt
> +
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
