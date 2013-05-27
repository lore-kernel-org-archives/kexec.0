Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgmWZ-0004r4-O8
 for kexec@lists.infradead.org; Mon, 27 May 2013 01:47:01 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7560C3EE0C3
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:46:34 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 65D7845DD78
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:46:34 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3A55145DE50
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:46:34 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2ACFB1DB803E
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:46:34 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CD4751DB8038
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:46:33 +0900 (JST)
Message-ID: <51A2BAE9.40307@jp.fujitsu.com>
Date: Mon, 27 May 2013 10:46:17 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <51A1AC4A.60506@gmail.com> <51A1AD67.4030800@gmail.com>
In-Reply-To: <51A1AD67.4030800@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

(2013/05/26 15:36), Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Cc: Dave Jones <davej@redhat.com>
> ---
>   Documentation/devices.txt |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
> index 08f01e7..c8e4002 100644
> --- a/Documentation/devices.txt
> +++ b/Documentation/devices.txt
> @@ -100,8 +100,7 @@ Your cooperation is appreciated.
>   		 10 = /dev/aio		Asynchronous I/O notification interface
>   		 11 = /dev/kmsg		Writes to this come out as printk's, reads
>   					export the buffered printk records.
> -		 12 = /dev/oldmem	Used by crashdump kernels to access
> -					the memory of the kernel that crashed.
> +		 12 = /dev/oldmem	OBSOLETE
>
>     1 block	RAM disk
>   		  0 = /dev/ram0		First RAM disk
>

This is the new patch. Looking at other parts of devices.txt, obsolete is
sometimes used together with unused. I guess obsolete means this is old interface so
don't use it as much as possible and unused means this is not used at all now.
You remove old memory interface completely in this patch set, so is it better to add
unused, too?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
