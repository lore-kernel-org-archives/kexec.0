Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x235.google.com ([2607:f8b0:400e:c03::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuiBi-00014r-Ch
 for kexec@lists.infradead.org; Wed, 11 Jun 2014 13:03:35 +0000
Received: by mail-pa0-f53.google.com with SMTP id kx10so1877547pab.40
 for <kexec@lists.infradead.org>; Wed, 11 Jun 2014 06:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140610234518.GC20738@verge.net.au>
References: <1402428569-3669-1-git-send-email-yegorslists@googlemail.com>
 <20140610234518.GC20738@verge.net.au>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 11 Jun 2014 15:02:51 +0200
Message-ID: <CAGm1_ktCTTq_v0LK+-FqEep_0faQHRds0TYvsJGbFyXABxmUbw@mail.gmail.com>
Subject: Re: [PATCH] vmcore-dmesg: don't enforce largefile handling
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
To: Simon Horman <horms@verge.net.au>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, kexec <kexec@lists.infradead.org>

On Wed, Jun 11, 2014 at 1:45 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jun 10, 2014 at 09:29:29PM +0200, Yegor Yefremov wrote:
>> Breaks build on !largefile toolchains.
>>
>> Instead simply use whatever mode is selected by toolchain / CFLAGS.
>
> Perhaps the use of configure or something similar is in order
> to select these options if they are available. It seems
> to me that one would want them if one can have them.

Do you mean something like this:  AC_SYS_LARGEFILE
(https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/System-Services.html)?

>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  vmcore-dmesg/vmcore-dmesg.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
>> index f47ee11..9bb1cc2 100644
>> --- a/vmcore-dmesg/vmcore-dmesg.c
>> +++ b/vmcore-dmesg/vmcore-dmesg.c
>> @@ -1,6 +1,4 @@
>>  #define _XOPEN_SOURCE 600
>> -#define _LARGEFILE_SOURCE 1
>> -#define _FILE_OFFSET_BITS 64
>>  #include <endian.h>
>>  #include <byteswap.h>
>>  #include <stdio.h>
>> --
>> 1.8.3.2
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
