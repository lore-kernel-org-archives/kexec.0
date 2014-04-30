Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WfSu6-0001Tt-EW
 for kexec@lists.infradead.org; Wed, 30 Apr 2014 11:42:23 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8C0E43EE11F
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:41:56 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7820D45DE6A
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:41:56 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F60645DE67
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:41:56 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4A04E1DB8037
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:41:56 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EBB051DB8032
 for <kexec@lists.infradead.org>; Wed, 30 Apr 2014 20:41:55 +0900 (JST)
Date: Wed, 30 Apr 2014 20:41:38 +0900 (JST)
Message-Id: <20140430.204138.209328404.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Replace lseek..write/read to pwrite/pread
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
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
Subject: [PATCH 0/4] Replace lseek..write/read to pwrite/pread
Date: Sat, 26 Apr 2014 12:07:05 +0800

> In original code there are many operations read from /write to specific
> positions of a file. This series of patches replace such patterns to
> pread/pwrite calls, reduces more than 100 lines of code.
> 

I'm now writing pthread support patch set and it will naturally
include pread/pwrite like this patch set.

It sounds to me that using pread/pwrite only to reduce lseek code is
weak in motivation. Is there another visible merit? For example, any
kind of performance improvement. I guess it's small even if exists
compared to I/O.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
