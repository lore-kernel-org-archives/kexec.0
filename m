Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdKLD-0000fI-Qn
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 12:32:44 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi1so5325005pad.36
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 04:32:42 -0800 (PST)
Date: Tue, 27 Nov 2012 21:32:34 +0900 (JST)
Message-Id: <20121127.213234.2280049296541396535.d.hatayama@gmail.com>
Subject: Re: [ANNOUNCE] makedumpfile: Postpone the release of 1.5.1
From: HATAYAMA Daisuke <d.hatayama@gmail.com>
In-Reply-To: <20121127193727.fbb54d248b75b5106570bdef@mxc.nes.nec.co.jp>
References: <20121127193727.fbb54d248b75b5106570bdef@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [ANNOUNCE] makedumpfile: Postpone the release of 1.5.1
Date: Tue, 27 Nov 2012 19:37:27 +0900

> Hello,
> 
>> If there is no problem, I will release v1.5.1 GA on Nov 28.
> 
> I did regression test for v1.5.1 in the last weekend and found some bugs.
> So the release date will be delayed by few weeks, sorry.
> 
> However, I don't think there are big issues for almost all users, because:
>  
>   - #1 doesn't happen unless users specify -x option, and it's unnecessary
>     for these kernels.

I don't think so. pageflags was rewriten as enumeration on v2.6.26. So
debuginfo of the related kernels contains correct PG_buddy value. If
passing vmlinux with -x option, makedumpfile should work well. I think
problematic case happens only through vmcoreinfo with -i option.

>   - As for #2, I think there are few users.
> 
> So, I think v1.5.1-rc is enough for almost all users.
> 
> 
> BUGS:
> 
>   #1. Fail to exclude free pages with page_is_buddy_v2() in some cases.
>       I mentioned this issue in the post below:
> 
>         http://lists.infradead.org/pipermail/kexec/2012-November/007404.html
> 
>       Related kernel: v2.6.27 to v2.6.37

This is a bit wrong. Correct one is: v2.6.30 to v2.6.37.

> 
>   #2. Fail to exclude free pages with page_is_buddy_v1() in some cases.
>       I'm investigating this issue now.
> 
>       Related kernel: v2.6.15 to v2.6.17

As I noted in its patch description, I have yet to test on these
kernel versions. Thanks for your testing.

But I don't have enough reason to support these kernels now. These
kernels themselves have bug on handling buddy pages, so PG_buddy was
introduced during v2.6.18-rc to fix the bug. Even if there is
distribution based on these kerenel versions, some kind of fixing
patch introducing PG_buddy would be backported and that must be. In
particular, I don't think machine with huge memory uses such buggy
kernels.

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
