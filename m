Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhSPN-0008Ja-DP
 for kexec@lists.infradead.org; Tue, 28 May 2013 22:30:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <51A1AC4A.60506@gmail.com> <51A1AD67.4030800@gmail.com>
Date: Tue, 28 May 2013 15:29:36 -0700
In-Reply-To: <51A1AD67.4030800@gmail.com> (Zhang Yanfei's message of "Sun, 26
 May 2013 14:36:23 +0800")
Message-ID: <87wqqi7n73.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:

> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Cc: Dave Jones <davej@redhat.com>
> ---
>  Documentation/devices.txt |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
> index 08f01e7..c8e4002 100644
> --- a/Documentation/devices.txt
> +++ b/Documentation/devices.txt
> @@ -100,8 +100,7 @@ Your cooperation is appreciated.
>  		 10 = /dev/aio		Asynchronous I/O notification interface
>  		 11 = /dev/kmsg		Writes to this come out as printk's, reads
>  					export the buffered printk records.
> -		 12 = /dev/oldmem	Used by crashdump kernels to access
> -					the memory of the kernel that crashed.
> +		 12 = /dev/oldmem	OBSOLETE

Let me suggest the slightly better.

 +		12 = /dev/oldmem	OBSOLETE - replaced by /proc/vmcore

Pointing to people to /proc/vmcore should help anyone who is trying to
understand what is going on.

>    1 block	RAM disk
>  		  0 = /dev/ram0		First RAM disk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
