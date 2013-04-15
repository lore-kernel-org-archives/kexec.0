Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URbQB-0000QS-CL
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 04:53:40 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E19523EE0C0
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 13:53:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C291A45DDCF
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 13:53:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A45E745DE55
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 13:53:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7992E1DB8047
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 13:53:26 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C003CE0800F
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 13:53:25 +0900 (JST)
Message-ID: <516B87A6.9080708@jp.fujitsu.com>
Date: Mon, 15 Apr 2013 13:52:54 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
 <5166D18A.7090800@zytor.com> <20130412143104.GA4301@redhat.com>
 <5168208B.7050107@zytor.com> <51688803.8020401@sr71.net>
In-Reply-To: <51688803.8020401@sr71.net>
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
To: Dave Hansen <dave@sr71.net>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Cliff Wickman <cpw@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/04/13 7:17), Dave Hansen wrote:
> On 04/12/2013 07:56 AM, H. Peter Anvin wrote:
>> On 04/12/2013 07:31 AM, Vivek Goyal wrote:
>>>> I also have to admit that I don't see the difference between /dev/mem
>>>> and /dev/oldmem, as the former allows access to memory ranges outside
>>>> the ones used by the current kernel, which is what the oldmem device
>>>> seems to be intended to od.
>
> It varies from arch to arch of course.
>
> But, /dev/mem has restrictions on it, like CONFIG_STRICT_DEVMEM or the
> ARCH_HAS_VALID_PHYS_ADDR_RANGE.  There's a lot of stuff that depends on
> it, *and* folks have tried to fix it up so that it's not _as_ blatant of
> a way to completely screw your system.
>
> /dev/mem also tries to be nice to arches that have restrictions like:
>
>>                          /*
>>                           * On ia64 if a page has been mapped somewhere as
>>                           * uncached, then it must also be accessed uncached
>>                           * by the kernel or data corruption may occur
>>                           */
>
> I think /dev/oldmem isn't so nice and could actually cause some real
> problems if used on ia64 where the cached/uncached accesses are mixed.

This sounds like there's no such issue on x86 cache mechanism. Is it 
correct? If so, what is the difference between ia64 and x86 cache 
mechanisms?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
