Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uhb7i-00071N-2x
 for kexec@lists.infradead.org; Wed, 29 May 2013 07:48:43 +0000
Message-ID: <51A5B210.6020501@cn.fujitsu.com>
Date: Wed, 29 May 2013 15:45:20 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <51A1AC4A.60506@gmail.com> <51A1AD67.4030800@gmail.com>
 <87wqqi7n73.fsf@xmission.com>
In-Reply-To: <87wqqi7n73.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On 05/29/2013 06:29 AM, Eric W. Biederman wrote:
> Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:
> 
>> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>>
>> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>> Cc: Dave Jones <davej@redhat.com>
>> ---
>>  Documentation/devices.txt |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
>> index 08f01e7..c8e4002 100644
>> --- a/Documentation/devices.txt
>> +++ b/Documentation/devices.txt
>> @@ -100,8 +100,7 @@ Your cooperation is appreciated.
>>  		 10 = /dev/aio		Asynchronous I/O notification interface
>>  		 11 = /dev/kmsg		Writes to this come out as printk's, reads
>>  					export the buffered printk records.
>> -		 12 = /dev/oldmem	Used by crashdump kernels to access
>> -					the memory of the kernel that crashed.
>> +		 12 = /dev/oldmem	OBSOLETE
> 
> Let me suggest the slightly better.
> 
>  +		12 = /dev/oldmem	OBSOLETE - replaced by /proc/vmcore
> 
> Pointing to people to /proc/vmcore should help anyone who is trying to
> understand what is going on.

Makes sense to me. Updated patch below:

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
