Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UReJM-0003Uz-H8
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 07:58:49 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 269B044DD82
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 16:58:42 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0A34845DEBC
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 16:58:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E3D1C45DEB5
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 16:58:41 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D1CA61DB8046
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 16:58:41 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8261A1DB803E
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 16:58:41 +0900 (JST)
Message-ID: <516BB310.20209@jp.fujitsu.com>
Date: Mon, 15 Apr 2013 16:58:08 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
 <5166D18A.7090800@zytor.com> <20130412143104.GA4301@redhat.com>
 <5168208B.7050107@zytor.com> <51688803.8020401@sr71.net>
 <516B87A6.9080708@jp.fujitsu.com> <516B9714.80007@sr71.net>
In-Reply-To: <516B9714.80007@sr71.net>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Cliff Wickman <cpw@sgi.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Thomas Renninger <trenn@suse.de>, Vivek Goyal <vgoyal@redhat.com>

(2013/04/15 14:58), Dave Hansen wrote:
> On 04/14/2013 09:52 PM, HATAYAMA Daisuke wrote:
>> This sounds like there's no such issue on x86 cache mechanism. Is it
>> correct? If so, what is the difference between ia64 and x86 cache
>> mechanisms?
>
> I'm just going by the code comments:
>
> drivers/char/mem.c
>>                  /*
>>                   * On ia64 if a page has been mapped somewhere as uncached, then
>>                   * it must also be accessed uncached by the kernel or data
>>                   * corruption may occur.
>>                   */

I think it reasonable, in complexity of design, to decide cache or 
uncache according to whether target memory is RAM or some device. If 
we're concerned about page levels, things are to be complicated further 
since memory typing is done per pages. How large does such table become 
to represent memory types for all the target pages, how do we create it 
and when? (I don't know ia64 but I guess caching on ia64 is also done in 
per pages just like x86...)

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
