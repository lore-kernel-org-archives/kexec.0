Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXLxR-0006MD-1s
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 02:40:18 +0000
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s382brZI004187
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Tue, 8 Apr 2014 11:37:53 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: inhibit predefined macros when cross
 building
Date: Tue, 8 Apr 2014 02:30:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FEF51@BPXM01GP.gisp.nec.co.jp>
References: <1396326520-42618-1-git-send-email-wangnan0@huawei.com>
 <533A42ED.3070604@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971FE492@BPXM01GP.gisp.nec.co.jp>
 <533E4791.8060405@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971FE66B@BPXM01GP.gisp.nec.co.jp>
 <533E74A3.5090402@huawei.com>
In-Reply-To: <533E74A3.5090402@huawei.com>
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
Cc: "suzuki@in.ibm.com" <suzuki@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

>>> I'm working on cross analysising arm vmcore on x86. I know that crash support
>>> cross analysing (at least for analysing little endian arm vmcore on x86). I also notice
>>> that makedumpfile has been designed for cross analysing (see commit 96f24dc77dc48e4c8f4c3527f4f5b4d27845393c
>>> by Suzuki K. Poulose <suzuki@in.ibm.com>), but it doesn't work correctly for arm vmcore.
>>
>> You may misunderstand, makedumpfile doesn't support cross analyzing.
>> According to the patch, I'm sure that Suzuki sent the patch to enable
>> *cross compile* (e.g. building arm binary on x86 machine) by setting
>> a cross compiler to CC variable:
>>
>>   (README)
>>     5.Build for a different architecture than the host :
>>       # make TARGET=<arch> ; make install
>>       where <arch> is the 'uname -m' of the target architecture.
>>       The user has to set the environment variable CC to appropriate
>>       compiler for the target architecture.
>>
>> When CC is the appropriate compiler for the target architecture,
>> the mismatch predefining macros will not happen.
>> So I think there is no problem in the current code.
>>
>>> What I'm trying to do is to enable the whole kdump analysing stuff crossly (I know it is hard).
>>> It is useful in some special cases, for example, for some boards with strictly limited memory
>>> and storage space.
>>
>> It sounds reasonable if you mentioned crash.
>>
>> The mission of makedumpfile is reducing dump size, so it's best to work
>> during capturing dump. Otherwise, you have to save full dump on the
>> *limited storage space*.
>
>I think I didn't explain my case very clearly.
>
>Our situation is that, our device has very short storage space which can hold busybox only
>(but with large memory). Most of its work is done in kernel (so kdump is important). When crash
>happens, What it can do is only scp /proc/vmcore to a x86 machine via network.
>Although using crash on the full vmcore on a x86 machine is affordable, makedumpfile is also useful
>because we want to backup those vmcore files for furture use, so its size must be reduced.

OK, I understand your case.
"makedumpfile -F" can resolve the byte-order issue if you can use it
to transport vmcore, but it seems impossible in your case.

Again, this patch doesn't introduce the cross analyzing feature legally,
but I accept it since it will not affect other features.


Thanks
Atsushi Kumagai

>> As for makedumpfile, I don't have any ideas about the advantage of the
>> cross analyzing you said.
>>
>>> With this patch, at least makedumpfile can be compiled to x86_64 binary, and can extract
>>> symbol information correctly for a vmcore file dumpped from a qemu virtual machine (little
>>> endian).
>>
>> Your patch sounds inconsistent to me since makedumpfile doesn't support
>> cross analyzing. The case you said will go well, but that's just a lucky
>> situation.
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>>>>>> This patch changes Makefile: if host arch and target arch are different,
>>>>>> passes "-U__$(HOST_ARCH)__" to gcc.
>>>>>>
>>>>>> I have tested by running following command on x86_64 machine:
>>>>>>
>>>>>> make ARCH=arm
>>>>>
>>>>> Sorry, should be TARGET=arm. I have tested and build okay.
>>>>>>
>>>>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>>>>> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>>>>>> Cc: kexec@lists.infradead.org
>>>>>> Cc: Geng Hui <hui.geng@huawei.com>
>>>>>> ---
>>>>>>  Makefile | 12 +++++++++---
>>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/Makefile b/Makefile
>>>>>> index 2f4845c..f85cc21 100644
>>>>>> --- a/Makefile
>>>>>> +++ b/Makefile
>>>>>> @@ -15,10 +15,11 @@ CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>>>>>>  		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
>>>>>>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
>>>>>>
>>>>>> +HOST_ARCH := $(shell uname -m)
>>>>>>  # Use TARGET as the target architecture if specified.
>>>>>>  # Defaults to uname -m
>>>>>>  ifeq ($(strip($TARGET)),)
>>>>>> -TARGET := $(shell uname -m)
>>>>>> +TARGET := $(HOST_ARCH)
>>>>>>  endif
>>>>>>
>>>>>>  ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>>>>>> @@ -26,8 +27,13 @@ ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>>>>>>  			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
>>>>>>  			       -e s/ppc64/powerpc64/ -e s/ppc/powerpc32/)
>>>>>>
>>>>>> -CFLAGS += -D__$(ARCH)__
>>>>>> -CFLAGS_ARCH += -D__$(ARCH)__
>>>>>> +CROSS :=
>>>>>> +ifneq ($(TARGET), $(HOST_ARCH))
>>>>>> +CROSS := -U__$(HOST_ARCH)__
>>>>>> +endif
>>>>>> +
>>>>>> +CFLAGS += -D__$(ARCH)__ $(CROSS)
>>>>>> +CFLAGS_ARCH += -D__$(ARCH)__ $(CROSS)
>>>>>>
>>>>>>  ifeq ($(ARCH), powerpc64)
>>>>>>  CFLAGS += -m64
>>>>>>
>>>>>
>>>
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
