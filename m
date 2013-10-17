Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWjcT-0005U2-Lh
 for kexec@lists.infradead.org; Thu, 17 Oct 2013 09:11:50 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id B1F8C3EE0BB
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 18:11:27 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 95E2845DE53
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 18:11:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 768ED45DE51
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 18:11:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 611BA1DB8037
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 18:11:27 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 123661DB803B
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 18:11:27 +0900 (JST)
Message-ID: <525FA980.4090102@jp.fujitsu.com>
Date: Thu, 17 Oct 2013 18:10:24 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: kexec cannot find text map area if kaslr is enabled
References: <525FA702.5070805@jp.fujitsu.com>
In-Reply-To: <525FA702.5070805@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: ahonig@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, keescook@google.com, Vivek Goyal <vgoyal@redhat.com>

(2013/10/17 17:59), HATAYAMA Daisuke wrote:
> Hello,
>
> I tried to use x86/kaslr branch to check if how it works with kdump framework.
>

Sorry, it's a branch of tip repository here:

http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/kaslr

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
