Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG5Mo-0005qZ-L1
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 10:26:39 +0000
Date: Thu, 14 Mar 2013 19:26:10 +0900 (JST)
Message-Id: <20130314.192610.502672204.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kexec: check size before trying the malloc
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130314083702.GB11196@verge.net.au>
References: <5140B469.8080308@gmail.com> <20130314083702.GB11196@verge.net.au>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, zhangyanfei.yes@gmail.com

From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: check size before trying the malloc
Date: Thu, 14 Mar 2013 09:37:03 +0100

> On Thu, Mar 14, 2013 at 01:16:25AM +0800, Zhang Yanfei wrote:
>> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>> 
>> If size is zero, it is unnecessary to do the malloc operation.
>> So checking size first is better than doing malloc first.
>> 
>> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Thanks, applied.
> 

Wait. The check should not be removed.

The behaviour when malloc() receives 0 as size is
implementation-defined. man malloc explains this:

     cannot be  allocated, a null  pointer shall be  returned. If
     the  size of  the  space  requested is  0,  the behavior  is
     implementation-defined: the value returned shall be either a
     null pointer or a unique pointer.

For example, on fedora 18 environement, malloc returns some object as
follows:

$ cat ./test.c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
        printf("%p\n", malloc(0));

        return 0;
}
$ gcc ./test.c -o test
$ ./test
0x1451010
$ rpm -qa | grep glibc
glibc-2.16-28.fc18.x86_64

Normally, object returned by allocator consists of header part plus
data part. This returned size might have header part only, I'm not
sure. The programmer usually expects the size to be positive, so this
bug typically leads to buffer overrun.

Anyway, it must be abnormal case when 0 is passed to malloc() as
size. As explained in patch description, it's best if it's possible to
check the size before calling malloc(). But it's impossible to make
sure that everyone does that; so bug happens. There's no reason to
remove the zero check.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
