Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WVvJs-0005YH-Rt
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 04:01:36 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: inhibit predefined macros when cross
 building
Date: Fri, 4 Apr 2014 03:59:28 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FE492@BPXM01GP.gisp.nec.co.jp>
References: <1396326520-42618-1-git-send-email-wangnan0@huawei.com>
 <533A42ED.3070604@huawei.com>
In-Reply-To: <533A42ED.3070604@huawei.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "wangnan0@huawei.com" <wangnan0@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

Hello Wang,

>On 2014/4/1 12:28, Wang Nan wrote:
>> When cross building makedumpfile, for example, build x86_64 exec for
>> dealing with arm vmcore, makefile passes a "-D__arm__" to gcc, but gcc
>> predefined macros still take effect, defines "__x86_64__". Which makes
>> definitions for x86_64 and arm mixed together in makedumpfile.h, causes
>> many problems.

I'm curious to know is it possible to analyze arm vmcores with
x86_64 binaries even if using the logic for arm ? 
In such cases, is it not needed to build an arm binary with a cross
compiler ? I worry about endian issues.


Thanks
Atsushi Kumagai

>> This patch changes Makefile: if host arch and target arch are different,
>> passes "-U__$(HOST_ARCH)__" to gcc.
>>
>> I have tested by running following command on x86_64 machine:
>>
>> make ARCH=arm
>
>Sorry, should be TARGET=arm. I have tested and build okay.
>>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> Cc: kexec@lists.infradead.org
>> Cc: Geng Hui <hui.geng@huawei.com>
>> ---
>>  Makefile | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 2f4845c..f85cc21 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -15,10 +15,11 @@ CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>>  		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
>>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
>>
>> +HOST_ARCH := $(shell uname -m)
>>  # Use TARGET as the target architecture if specified.
>>  # Defaults to uname -m
>>  ifeq ($(strip($TARGET)),)
>> -TARGET := $(shell uname -m)
>> +TARGET := $(HOST_ARCH)
>>  endif
>>
>>  ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>> @@ -26,8 +27,13 @@ ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>>  			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
>>  			       -e s/ppc64/powerpc64/ -e s/ppc/powerpc32/)
>>
>> -CFLAGS += -D__$(ARCH)__
>> -CFLAGS_ARCH += -D__$(ARCH)__
>> +CROSS :=
>> +ifneq ($(TARGET), $(HOST_ARCH))
>> +CROSS := -U__$(HOST_ARCH)__
>> +endif
>> +
>> +CFLAGS += -D__$(ARCH)__ $(CROSS)
>> +CFLAGS_ARCH += -D__$(ARCH)__ $(CROSS)
>>
>>  ifeq ($(ARCH), powerpc64)
>>  CFLAGS += -m64
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
