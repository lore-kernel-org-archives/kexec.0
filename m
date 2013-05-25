Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgNmR-00077T-Hu
 for kexec@lists.infradead.org; Sat, 25 May 2013 23:21:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <51A02E50.5020507@gmail.com> <51A02F59.8000103@gmail.com>
Date: Sat, 25 May 2013 16:20:31 -0700
In-Reply-To: <51A02F59.8000103@gmail.com> (Zhang Yanfei's message of "Sat, 25
 May 2013 11:26:17 +0800")
Message-ID: <87vc668x4w.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] Documentation/devices.txt: Remove /dev/oldmem
 description
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, davej@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:

> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Won't we want to keep this reservation around to so that this number
doesn't get reused, and cause people confusion when
upgrading/downgrading kernels?

> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Cc: Dave Jones <davej@redhat.com>
> ---
>  Documentation/devices.txt |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
> index 08f01e7..4f85739 100644
> --- a/Documentation/devices.txt
> +++ b/Documentation/devices.txt
> @@ -100,8 +100,6 @@ Your cooperation is appreciated.
>  		 10 = /dev/aio		Asynchronous I/O notification interface
>  		 11 = /dev/kmsg		Writes to this come out as printk's, reads
>  					export the buffered printk records.
> -		 12 = /dev/oldmem	Used by crashdump kernels to access
> -					the memory of the kernel that crashed.
>  
>    1 block	RAM disk
>  		  0 = /dev/ram0		First RAM disk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
