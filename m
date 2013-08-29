Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFC1o-00063I-2f
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 23:53:29 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 278BA3EE0BC
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 08:53:01 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1730245DE52
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 08:53:01 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F273045DE50
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 08:53:00 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E5B8D1DB8041
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 08:53:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9A6D31DB803F
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 08:53:00 +0900 (JST)
Message-ID: <521FDE8D.4040807@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 08:51:41 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <521F5297.4070906@linux.intel.com>
In-Reply-To: <521F5297.4070906@linux.intel.com>
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
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org, jingbai.ma@hp.com

(2013/08/29 22:54), H. Peter Anvin wrote:
> On 08/29/2013 02:27 AM, HATAYAMA Daisuke wrote:
>> This is the patch series to address the issue that kdump 2nd kernel
>> now fails to wake up multiple CPUs.
>
> Please explain the "now" in the above sentence.  Is this a regression?
> If so, what is its impact?  Is this something that needs to go into 3.11
> as a post-rc7 change, which means it better be hyper-critical?
>
> 	-hpa
>
>

This is not a regression just as Eric explains.

There is also my explanation in the description of the 2nd patch. I should have described so here explicitly.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
