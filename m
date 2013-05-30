Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uhvmq-0006cA-8P
 for kexec@lists.infradead.org; Thu, 30 May 2013 05:52:34 +0000
Message-ID: <51A6E85F.5000300@cn.fujitsu.com>
Date: Thu, 30 May 2013 13:49:19 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] Documentation/devices.txt: Remove /dev/oldmem
 description
References: <51A02E50.5020507@gmail.com> <51A02F59.8000103@gmail.com>
 <87vc668x4w.fsf@xmission.com> <51A15E2F.7010308@gmail.com>
 <51A2B693.7000701@jp.fujitsu.com> <51A2B68E.4060605@cn.fujitsu.com>
 <20130529152007.893940a04d95fa1e38e851d4@linux-foundation.org>
In-Reply-To: <20130529152007.893940a04d95fa1e38e851d4@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, davej@redhat.com, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On 05/30/2013 06:20 AM, Andrew Morton wrote:
> On Mon, 27 May 2013 09:27:42 +0800 Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:
> 

snip

>>
>> I've sent the v2 version and actually did what you said.
> 
> I can't find any v2 version of this patchset.
> 
> I did this:
> 
> --- a/Documentation/devices.txt~dev-oldmem-remove-the-interface-fix
> +++ a/Documentation/devices.txt
> @@ -102,6 +102,7 @@ Your cooperation is appreciated.
>  					export the buffered printk records.
>  		 12 = /dev/oldmem	Used by crashdump kernels to access
>  					the memory of the kernel that crashed.
> +					(obsolete)
>  
>    1 block	RAM disk
>  		  0 = /dev/ram0		First RAM disk
> _
> 
> 

v1 is the same with v2 except this patch. I attach it below:

-----------------------------------
From d2f7baf2aba86069f941f32669a22dbd99082614 Mon Sep 17 00:00:00 2001
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Date: Wed, 29 May 2013 15:44:09 +0800
Subject: [PATCH] Documentation/devices.txt: Mark /dev/oldmem obsolete

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 Documentation/devices.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/devices.txt b/Documentation/devices.txt
index 08f01e7..315455a 100644
--- a/Documentation/devices.txt
+++ b/Documentation/devices.txt
@@ -100,8 +100,7 @@ Your cooperation is appreciated.
 		 10 = /dev/aio		Asynchronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's, reads
 					export the buffered printk records.
-		 12 = /dev/oldmem	Used by crashdump kernels to access
-					the memory of the kernel that crashed.
+		 12 = /dev/oldmem	OBSOLETE - replaced by /proc/vmcore
 
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
