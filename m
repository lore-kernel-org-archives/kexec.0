Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WglFW-0007GI-Or
 for kexec@lists.infradead.org; Sun, 04 May 2014 01:29:51 +0000
Message-ID: <536597AF.6070908@huawei.com>
Date: Sun, 4 May 2014 09:28:15 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] makedumpfile: add -D_GNU_SOURCE to CFLAGS
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>	<1398485229-43295-4-git-send-email-wangnan0@huawei.com>
 <20140430.205510.528575789.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140430.205510.528575789.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: ptesarik@suse.cz, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, sdu.liu@huawei.com, hui.geng@huawei.com

On 2014/4/30 19:55, HATAYAMA Daisuke wrote:
> From: Wang Nan <wangnan0@huawei.com>
> Subject: [PATCH 3/4] makedumpfile: add -D_GNU_SOURCE to CFLAGS
> Date: Sat, 26 Apr 2014 12:07:08 +0800
> 
>> This patch is preparation for introduce pread/pwrite.
>>
> 
> Do you explain more about _GNU_SOURCE? Did you need to define this on
> your environment to build makedumpfile with pread/pwrite?
> 
> I tried to build a very simple test program using pread like
> 
> int main(void)
> {
>    printf("%p\n", pread);
> }
> 
> on RHEL5.4, RHEL6.5 and fc20, and all were done successfully without
> _GNU_SOURCE. They are all on x86_64.
> 
> I checked man pread and man pwrite on each environments for
> _GNU_SOURCE but I didn't find it. What I found was _XOPEN_SOURCE
> description only. For example this is man pread on RHEL6.5.
> 
> $ LANG=C man pread
> PREAD(2)                   Linux Programmer's Manual                  PREAD(2)
> 
> NAME
>        pread, pwrite - read from or write to a file descriptor at a given offset
> 
> SYNOPSIS
>        #define _XOPEN_SOURCE 500

I define _GNU_SOURCE because it introduces _XOPEN_SOURCE. It also introduces others which
I thought may help further improvements.

Do you mean use only _XOPEN_SOURCE for pread/pwrite?

> 
>        #include <unistd.h>
> 
>        ssize_t pread(int fd, void *buf, size_t count, off_t offset);
> 
>        ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset);
> 
> Note that just as I said the above, building was successfully done on
> this environment.
> 
> --
> Thanks.
> HATAYAMA, Daisuke
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
