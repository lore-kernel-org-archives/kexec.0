Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vkns8-0004FS-Uy
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 04:34:10 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8C8BA3EE0C1
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 13:33:39 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 801A645DE55
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 13:33:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6AD5045DE53
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 13:33:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5BDDF1DB804B
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 13:33:39 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 07D77E18002
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 13:33:39 +0900 (JST)
Message-ID: <5292D30E.5070003@jp.fujitsu.com>
Date: Mon, 25 Nov 2013 13:33:18 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
In-Reply-To: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com

(2013/11/25 11:31), Baoquan He wrote:
> Hi HATAYAMA and Atsushi,
>
> I think v2 is better than v1, since update_cyclic_region can be used
> with a more flexible calling.
>
> What's your opinion about this?
>
> On 11/23/13 at 05:29pm, Baoquan He wrote:

Thanks for your patch. The bug is caused by my patch set for creating a
whole part of 1st bitmap before entering cyclic process.

I think v1 is better than v2. The update_cyclic_range() call relevant
to this regression is somewhat special compared to other calls; it is
the almost only call that doesn't need to perform filtering processing.
To fix this bug, please make the patch so as not to affect the other calls,
in order to keep change as small as possible.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
