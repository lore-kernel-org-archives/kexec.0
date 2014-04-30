Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WfT74-0002r1-W3
 for kexec@lists.infradead.org; Wed, 30 Apr 2014 11:55:47 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DC0F53EE0BB
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:55:21 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CD10645DE6A
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:55:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C11645DE67
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:55:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 779EB1DB8037
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:55:21 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 244F91DB8032
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:55:21 +0900 (JST)
Date: Wed, 30 Apr 2014 20:55:10 +0900 (JST)
Message-Id: <20140430.205510.528575789.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 3/4] makedumpfile: add -D_GNU_SOURCE to CFLAGS
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1398485229-43295-4-git-send-email-wangnan0@huawei.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
 <1398485229-43295-4-git-send-email-wangnan0@huawei.com>
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
To: wangnan0@huawei.com
Cc: ptesarik@suse.cz, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, sdu.liu@huawei.com, hui.geng@huawei.com

From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/4] makedumpfile: add -D_GNU_SOURCE to CFLAGS
Date: Sat, 26 Apr 2014 12:07:08 +0800

> This patch is preparation for introduce pread/pwrite.
> 

Do you explain more about _GNU_SOURCE? Did you need to define this on
your environment to build makedumpfile with pread/pwrite?

I tried to build a very simple test program using pread like

int main(void)
{
   printf("%p\n", pread);
}

on RHEL5.4, RHEL6.5 and fc20, and all were done successfully without
_GNU_SOURCE. They are all on x86_64.

I checked man pread and man pwrite on each environments for
_GNU_SOURCE but I didn't find it. What I found was _XOPEN_SOURCE
description only. For example this is man pread on RHEL6.5.

$ LANG=C man pread
PREAD(2)                   Linux Programmer's Manual                  PREAD(2)

NAME
       pread, pwrite - read from or write to a file descriptor at a given offset

SYNOPSIS
       #define _XOPEN_SOURCE 500

       #include <unistd.h>

       ssize_t pread(int fd, void *buf, size_t count, off_t offset);

       ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset);

Note that just as I said the above, building was successfully done on
this environment.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
