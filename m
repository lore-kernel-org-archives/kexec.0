Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5DZy-0002Aj-10
 for kexec@lists.infradead.org; Tue, 12 Feb 2013 10:59:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
 <50913011.2030900@hitachi.com>
 <20130208174944.96a3b50952e45e1219a94819@mxc.nes.nec.co.jp>
 <5119B1E1.4010405@hitachi.com>
Date: Tue, 12 Feb 2013 02:58:50 -0800
In-Reply-To: <5119B1E1.4010405@hitachi.com> (Mitsuhiro Tanino's message of
 "Tue, 12 Feb 2013 12:07:13 +0900")
Message-ID: <8738x1hk7p.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2 v2] kexec: Export PG_hwpoison flag into vmcoreinfo
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
To: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, linux-kernel@vger.kernel.org, vgoyal@redhat.com

Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com> writes:

> Re: [Patch 0/2] Exclude hwpoison page from vmcore dump
> (2012/11/01 19:40), Eric W. Biederman wrote:
>> Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com> writes:
>> I agree.  If we are performing filtering filtering out of poisoned pages
>> seems very reasonable.  So ack on the basic concept.
>> 
>> Eric
>
> Hello, Eric,
>
> Could you please push the patch to export PG_hwpoison flag into 3.9 during
> next merge window?
>
> Kumagai-san acked the patch which provides the feature to exclude hwpoison
> page and he will push the fix of makedumpfile side into makedumpfile-1.5.2.
> This kernel patch is also required to enable this feature.

If Andrew hasn't already picked this up please send send a copy of the
patch through him.  Kexec related patches have historically gone through
Andrew after review.

Right now I don't have a kexec tree in linux-next and I don't have the
time/energy to start running one right now.

But I am happy to add my acked-by to the patch.  Exporting PG_hwpoison
seems entirely reasonable.

I thought I read somewhere upthread that Andrew had already picked this
patch up though?

Eric


> Regards,
> Mitsuhiro Tanino
>
>
> (2013/02/08 17:49), Atsushi Kumagai wrote:
>> Hello,
>> 
>> On Wed, 31 Oct 2012 23:05:05 +0900
>> Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com> wrote:
>> 
>>> This patch exports a PG_hwpoison into vmcoreinfo when
>>> CONFIG_MEMORY_FAILURE is defined.
>>> "makedumpfile" needs to read information of memory, such as
>>> 'mem_section', 'zone', 'pageflags' from vmcore.
>>>
>>> We introduce a function into "makedumpfile" to exclude
>>> hwpoison page from vmcore dump.
>>> In order to introduce this function, PG_hwpoison flag have
>>> to export into vmcoreinfo.
>>>
>>> Signed-off-by: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
>> 
>> I'm curious to know the status of this patch because I'll release
>> makedumpfile-1.5.2 with the feature to exclude hwpoison page soon.
>> 
>> 
>> Thanks
>> Atsushi Kumagai
>> 
>>> ---

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>>>  kernel/kexec.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>> index 0668d58..0d5d6bc 100644
>>> --- a/kernel/kexec.c
>>> +++ b/kernel/kexec.c
>>> @@ -1513,6 +1513,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>         VMCOREINFO_NUMBER(PG_lru);
>>>         VMCOREINFO_NUMBER(PG_private);
>>>         VMCOREINFO_NUMBER(PG_swapcache);
>>> +#ifdef CONFIG_MEMORY_FAILURE
>>> +       VMCOREINFO_NUMBER(PG_hwpoison);
>>> +#endif
>>>
>>>         arch_crash_save_vmcoreinfo();
>>>         update_vmcoreinfo_note();
>>> --
>>> 1.7.10.1
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>> 
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>> .
>> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
