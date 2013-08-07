Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V70ct-0002lh-Oj
 for kexec@lists.infradead.org; Wed, 07 Aug 2013 10:05:57 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 27F143EE0BC
 for <kexec@lists.infradead.org>; Wed,  7 Aug 2013 19:05:27 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 159A645DE5F
 for <kexec@lists.infradead.org>; Wed,  7 Aug 2013 19:05:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id EF17945DE5A
 for <kexec@lists.infradead.org>; Wed,  7 Aug 2013 19:05:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E0DB6E08003
 for <kexec@lists.infradead.org>; Wed,  7 Aug 2013 19:05:26 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 935821DB804C
 for <kexec@lists.infradead.org>; Wed,  7 Aug 2013 19:05:26 +0900 (JST)
Message-ID: <52021BD7.6010903@jp.fujitsu.com>
Date: Wed, 07 Aug 2013 19:05:11 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [Help Test] kdump, x86, acpi: Reproduce CPU0 SMI corruption issue
 after unsetting BSP flag
References: <5200BFB3.2050202@jp.fujitsu.com>
 <CAErSpo5O8RbL=h5jrD3NkBhH6ARhMOag9JfUzPEED0cBfDSwxQ@mail.gmail.com>
In-Reply-To: <CAErSpo5O8RbL=h5jrD3NkBhH6ARhMOag9JfUzPEED0cBfDSwxQ@mail.gmail.com>
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
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, jingbai.ma@hp.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/08/07 1:25), Bjorn Helgaas wrote:
> On Tue, Aug 6, 2013 at 3:19 AM, HATAYAMA Daisuke
> <d.hatayama@jp.fujitsu.com> wrote:
>> So, could anyone help testing the idea 2) above if you have which of
>> the following machines? (or other ones that can lead to the same bug)
>>
>> - HP Compaq 6910p
>> - HP Compaq 6710b
>> - HP Compaq 6710s
>> - HP Compaq 6510b
>> - HP Compaq 2510p
>
> Sorry, I don't have access to any of these machines any more, and I
> don't have any useful advice for you.
>

I have guessed that answer from the change of your email address...

But thanks for your record in commit and bugzilla. It's helpful to follow
details of this bug.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
