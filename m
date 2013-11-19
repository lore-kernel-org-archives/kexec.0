Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vii2Q-0002Wh-7n
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 09:56:07 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4C6713EE0AE
 for <kexec@lists.infradead.org>; Tue, 19 Nov 2013 18:55:35 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3EBBD45DE4E
 for <kexec@lists.infradead.org>; Tue, 19 Nov 2013 18:55:35 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 20C8445DD76
 for <kexec@lists.infradead.org>; Tue, 19 Nov 2013 18:55:35 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 14C481DB8032
 for <kexec@lists.infradead.org>; Tue, 19 Nov 2013 18:55:35 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BF1EE1DB8037
 for <kexec@lists.infradead.org>; Tue, 19 Nov 2013 18:55:34 +0900 (JST)
Message-ID: <528B3585.5080606@jp.fujitsu.com>
Date: Tue, 19 Nov 2013 18:55:17 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com> <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com> <5285EC60.1060906@jp.fujitsu.com>
 <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
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
Cc: "bhe@redhat.com" <bhe@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

(2013/11/18 9:51), Atsushi Kumagai wrote:
> (2013/11/15 23:26), Vivek Goyal wrote:
>> On Fri, Nov 15, 2013 at 06:41:52PM +0900, HATAYAMA Daisuke wrote:
>>
>> [..]
>>>> Given the fact that hpa does not like fixing it in kernel. We are left
>>>> with option of fixing it in following places.
>>>>
>>>> - Drop partial pages in kexec-tools
>>>> - Drop partial pages in makeudmpfile.
>>>> - Read partial pages using read() interface in makedumpfile
>>>> - Modify /proc/vmcore to copy partial pages in second kernel's memory.
>>>>
>>>> It is not clear to me that partial pages are really useful.  So I want
>>>> to avoid modifying /proc/vmcore to deal with partial pages and increase
>>>> complexity.
>>>>
>>>> So fixing makedumpfile (either option2 or option 3) seems least risky
>>>> to me. In fact I would say let us keep it simple and truncate partial
>>>> pages in makedumpfile to keep it simple. And look at option 3 once we
>>>> have a strong use case for partial pages.
>>>>
>>>> What do you think?
>>>>
>>>
>>> As you say, it's not clear that partial pages are really useful, but on
>>> the other hand, it seems to me not clear that they are really useless.
>>> I think we should get them as long as we have access to them.
>>>
>>> It seems best to me the option 3). Switching between read and mmap would
>>> be not so complex and also it's by far flexible in makedumpfile than in
>>> kernel.
>>
>> Ok, I am fine with option 3. It is more complicated option but safe
>> option.
> 
> It sounds reasonable also to me.
> 
>> Is there any chance that you could look into fixing this. I have no
>> experience writing code for makedumpfile.
> 
> I'll send a patch to fix this soon.
> 

Thanks.

BTW, now the following patch has been applied on top of makedumpfile in
kexec-tools package on fedora in order to avoid the issue.

https://lists.fedoraproject.org/pipermail/kexec/2013-November/000254.html

I remember prototype version of mmap patch implemented a kind of --no-mmap option
and we could use it to disable mmap() use and use read() instead, I think
which is useful when we face this kind of issue.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
