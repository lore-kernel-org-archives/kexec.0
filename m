Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WVx0K-0006f8-5y
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 05:49:30 +0000
Message-ID: <533E4791.8060405@huawei.com>
Date: Fri, 4 Apr 2014 13:48:01 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: inhibit predefined macros when cross
 building
References: <1396326520-42618-1-git-send-email-wangnan0@huawei.com>
 <533A42ED.3070604@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971FE492@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971FE492@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

On 2014/4/4 11:59, Atsushi Kumagai wrote:
> Hello Wang,
> 
>> On 2014/4/1 12:28, Wang Nan wrote:
>>> When cross building makedumpfile, for example, build x86_64 exec for
>>> dealing with arm vmcore, makefile passes a "-D__arm__" to gcc, but gcc
>>> predefined macros still take effect, defines "__x86_64__". Which makes
>>> definitions for x86_64 and arm mixed together in makedumpfile.h, causes
>>> many problems.
> 
> I'm curious to know is it possible to analyze arm vmcores with
> x86_64 binaries even if using the logic for arm ? 
> In such cases, is it not needed to build an arm binary with a cross
> compiler ? I worry about endian issues.
> 
> 
> Thanks
> Atsushi Kumagai
> 

I'm working on cross analysising arm vmcore on x86. I know that crash support
cross analysing (at least for analysing little endian arm vmcore on x86). I also notice
that makedumpfile has been designed for cross analysing (see commit 96f24dc77dc48e4c8f4c3527f4f5b4d27845393c
by Suzuki K. Poulose <suzuki@in.ibm.com>), but it doesn't work correctly for arm vmcore.

What I'm trying to do is to enable the whole kdump analysing stuff crossly (I know it is hard).
It is useful in some special cases, for example, for some boards with strictly limited memory
and storage space.

With this patch, at least makedumpfile can be compiled to x86_64 binary, and can extract
symbol information correctly for a vmcore file dumpped from a qemu virtual machine (little
endian).

>>> This patch changes Makefile: if host arch and target arch are different,
>>> passes "-U__$(HOST_ARCH)__" to gcc.
>>>
>>> I have tested by running following command on x86_64 machine:
>>>
>>> make ARCH=arm
>>
>> Sorry, should be TARGET=arm. I have tested and build okay.
>>>
>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>>> Cc: kexec@lists.infradead.org
>>> Cc: Geng Hui <hui.geng@huawei.com>
>>> ---
>>>  Makefile | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 2f4845c..f85cc21 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -15,10 +15,11 @@ CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>>>  		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
>>>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
>>>
>>> +HOST_ARCH := $(shell uname -m)
>>>  # Use TARGET as the target architecture if specified.
>>>  # Defaults to uname -m
>>>  ifeq ($(strip($TARGET)),)
>>> -TARGET := $(shell uname -m)
>>> +TARGET := $(HOST_ARCH)
>>>  endif
>>>
>>>  ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>>> @@ -26,8 +27,13 @@ ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>>>  			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
>>>  			       -e s/ppc64/powerpc64/ -e s/ppc/powerpc32/)
>>>
>>> -CFLAGS += -D__$(ARCH)__
>>> -CFLAGS_ARCH += -D__$(ARCH)__
>>> +CROSS :=
>>> +ifneq ($(TARGET), $(HOST_ARCH))
>>> +CROSS := -U__$(HOST_ARCH)__
>>> +endif
>>> +
>>> +CFLAGS += -D__$(ARCH)__ $(CROSS)
>>> +CFLAGS_ARCH += -D__$(ARCH)__ $(CROSS)
>>>
>>>  ifeq ($(ARCH), powerpc64)
>>>  CFLAGS += -m64
>>>
>>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
