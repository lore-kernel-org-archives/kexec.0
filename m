Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieC9r-0007nz-FC
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 06:04:37 +0000
Subject: Re: [PATCH] makedumpfile/Makefile: remove -lebl from LIBS
References: <1574989745-5262-1-git-send-email-piliu@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359725A@BPXM09GP.gisp.nec.co.jp>
 <6dc65874-803a-10f3-dc42-d8704323ea0b@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359773A@BPXM09GP.gisp.nec.co.jp>
From: piliu <piliu@redhat.com>
Message-ID: <b5577cc9-20f9-4676-2596-b8444e3ab8d6@redhat.com>
Date: Mon, 9 Dec 2019 14:04:23 +0800
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0359773A@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On 12/07/2019 12:28 AM, Kazuhito Hagio wrote:
>> -----Original Message-----
>>
>> On 12/05/2019 06:36 AM, Kazuhito Hagio wrote:
>>> Hi Pingfan,
>>>
>>> Thank you for the patch.
>>>
>>>> -----Original Message-----
>>>> since the following commit, -lebl has been removed from elfutils.
>>>> commit b833c731359af12af9f16bcb621b3cdc170eafbc
>>>> Author: Mark Wielaard <mark@klomp.org>
>>>> Date:   Thu Aug 29 23:34:11 2019 +0200
>>>>
>>>>     libebl: Don't install libebl.a, libebl.h and remove backends from spec.
>>>>
>>>>     All archive members from libebl.a are now in libdw.a. We don't generate
>>>>     separate backend shared libraries anymore. So remove them from the
>>>>     elfutils.spec file.
>>>>
>>>>     Signed-off-by: Mark Wielaard <mark@klomp.org>
>>>>
>>>> So remove it from LIBS for makedumpfile
>>>
>>> It seems that this is ok with the latest elfutils, but with older ones?
>>> Is it possible to remove -lebl when elfutils does not have libebl.a?
>> I have no idea about it for now. The method to check version depends on
>> distribution. Is it doable by checking /usr/lib64/libebl ?
> 
> We have 'try-run' function written by Petr in the Makefile, which checks
> if clock_gettime() requies -lrt.  How about utilizing it like this?
> 
> diff --git a/Makefile b/Makefile
> index 1fdb6286e85d..d4d1fb563209 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -50,7 +50,7 @@ OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>  
> -LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
> +LIBS = -ldw -lbz2 -ldl -lelf -lz
>  ifneq ($(LINKTYPE), dynamic)
>  LIBS := -static $(LIBS)
>  endif
> @@ -79,6 +79,11 @@ LINK_TEST_PROG="int clock_gettime(); int main(){ return clock_gettime(); }"
>  LIBS := $(LIBS) $(call try-run,\
>  	echo $(LINK_TEST_PROG) | $(CC) $(CFLAGS) -o "$$TMP" -x c -,,-lrt)
>  
> +# elfutils-0.178 or later does not install libebl.a.
> +LINK_TEST_PROG="int main() { return 0; }"
> +LIBS := $(LIBS) $(call try-run,\
> +	echo $(LINK_TEST_PROG) | $(CC) -o "$$TMP" -x c - -lebl,-lebl,)
> +
>  all: makedumpfile
>  
>  $(OBJ_PART): $(SRC_PART)
> 
> 
> If libebl.a does not exist (gcc with -lebl fails), it will not append
> -lebl to LIBS.
> 
Yes, it sounds a good idea.

Should I sumbit another patch or you will do by yourself?

Thanks,
Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
