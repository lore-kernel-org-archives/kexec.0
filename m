Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wetw8-0004No-Sn
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 22:22:11 +0000
Message-ID: <535ED454.1080902@huawei.com>
Date: Tue, 29 Apr 2014 06:21:08 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] makedumpfile: redefine numerical limitaction macros.
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>	<1398485229-43295-2-git-send-email-wangnan0@huawei.com>
 <20140428162358.2d78f390@hananiah.suse.cz>
In-Reply-To: <20140428162358.2d78f390@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org, Wang Nan <pi3orama@gmail.com>, kumagai-atsushi@mxc.nes.nec.co.jp, Liu Hua <sdu.liu@huawei.com>, Geng Hui <hui.geng@huawei.com>

On 2014/4/28 22:23, Petr Tesarik wrote:
> On Sat, 26 Apr 2014 12:07:06 +0800
> Wang Nan <wangnan0@huawei.com> wrote:
> 
>> From: Wang Nan <pi3orama@gmail.com>
>>
>> According to C standard, numerical limitations macros such as ULONG_MAX
>> should be defined in <limits.h>, and must be defined as "constant
>> expressions suitable for use in #if preprocessing directives." (see
>> "Numerical limits" section in the standard).
>>
>> Original definition in common.h breaks this rule:
>>
>>  #define LONG_MAX ((long)(~0UL>>1))
>>
>> which causes macros like following failure:
>>
>>  #if LONG_MAX == 2147483647
>>  # define LONG_BIT	32
>>  #else
>>  # define LONG_BIT	64
>>  #endif
>>
>> Unfortunately, the above code piece is taken from real glibc header
>> (/usr/include/bits/xopen_lim.h), which is happen to be included by
>> <limits.h> if _GNU_SOURCE is defined.
>>
>> This patch include <limits.h> in common.h to use C standard numerical
>> macros. For system without such macros defined by C, this patch also
>> defines L(L)ONG_MAX in a standard compatible way. By checking wich
>>
>> gcc -dM -E - <<<''
>>
>> we know that __LONG_MAX__ and __LLONG_MAX__ macros should be defined by
>> gcc by default. Definition of ULONG_MAX and ULLONG_MAX are taken from
>> gcc standard include file (include-fixed/limits.h).
>>
>> In addition, macro ULONGLONG_MAX is nonstandard, the standard way for
>> defining max ulonglong is ULLONG_MAX.
>>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> Cc: Petr Tesarik <ptesarik@suse.cz>
>> Cc: kexec@lists.infradead.org
>> Cc: Geng Hui <hui.geng@huawei.com>
>> Cc: Liu Hua <sdu.liu@huawei.com>
>>
>> ---
>>  common.h | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/common.h b/common.h
>> index 6ad3ca7..124f107 100644
>> --- a/common.h
>> +++ b/common.h
>> @@ -16,17 +16,29 @@
>>  #ifndef _COMMON_H
>>  #define _COMMON_H
>>  
>> +#include <limits.h>
>> +
>>  #define TRUE		(1)
>>  #define FALSE		(0)
>>  #define ERROR		(-1)
>>  
>>  #ifndef LONG_MAX
>> -#define LONG_MAX	((long)(~0UL>>1))
>> +# warning LONG_MAX should have been defined in <limits.h>
>> +# define LONG_MAX	__LONG_MAX__
>>  #endif
>>  #ifndef ULONG_MAX
>> -#define ULONG_MAX	(~0UL)
>> +# warning ULONG_MAX should have been defined in <limits.h>
>> +# define ULONG_MAX	(LONG_MAX * 2UL + 1UL)
>> +#endif
>> +#ifndef LLONG_MAX
>> +# warning LLONG_MAX should have been defined in <limits.h>
>> +# define LLONG_MAX __LONG_LONG_MAX__
>> +#endif
>> +#ifndef ULLONG_MAX
>> +# warning ULLONG_MAX should have been defined in <limits.h>
>> +# define ULLONG_MAX (LLONG_MAX * 2ULL + 1ULL)
>>  #endif
>> -#define ULONGLONG_MAX	(~0ULL)
>> +#define ULONGLONG_MAX	ULLONG_MAX
> 
> Hi Wang Nan,
> 
> is this actually needed on some known platform? If not, then I'd rather
> remove all these #ifndef stanzas and rely on <limits.h>. I mean, if you
> can't rely on standard C constants, then why should be the gcc-specific
> pre-defined macros (__LONG_MAX__ et al.) available?
> 

These macros exist at the first version (at makedumpfile.h), an enforced by
commit ab9c60bf (just because they conflict with limits.h ...). But I don't
think there exists a real platform without <limits.h>.

I agree with you that totally removing these macros should be better.

> It's probably better to put the burden on the person doing the
> port, because they should know what is appropriate for their compiler
> and/or libc.
> 
> Just my opinion,
> Petr T
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
