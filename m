Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQnDy-00067j-IV
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 23:17:44 +0000
In-Reply-To: <51688803.8020401@sr71.net>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
 <5166D18A.7090800@zytor.com> <20130412143104.GA4301@redhat.com>
 <5168208B.7050107@zytor.com> <51688803.8020401@sr71.net>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 12 Apr 2013 16:17:17 -0700
Message-ID: <a13f7af9-9272-4407-9684-4d3693b5d3f2@email.android.com>
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
To: Dave Hansen <dave@sr71.net>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Cliff Wickman <cpw@sgi.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Yinghai Lu <yinghai@kernel.org>, Thomas Renninger <trenn@suse.de>, Vivek Goyal <vgoyal@redhat.com>

Yes... That is one reason I think it is a real problem.


Dave Hansen <dave@sr71.net> wrote:

>On 04/12/2013 07:56 AM, H. Peter Anvin wrote:
>> On 04/12/2013 07:31 AM, Vivek Goyal wrote:
>>>> I also have to admit that I don't see the difference between
>/dev/mem
>>>> and /dev/oldmem, as the former allows access to memory ranges
>outside
>>>> the ones used by the current kernel, which is what the oldmem
>device
>>>> seems to be intended to od.
>
>It varies from arch to arch of course.
>
>But, /dev/mem has restrictions on it, like CONFIG_STRICT_DEVMEM or the
>ARCH_HAS_VALID_PHYS_ADDR_RANGE.  There's a lot of stuff that depends on
>it, *and* folks have tried to fix it up so that it's not _as_ blatant
>of
>a way to completely screw your system.
>
>/dev/mem also tries to be nice to arches that have restrictions like:
>
>>                         /*
>>                          * On ia64 if a page has been mapped
>somewhere as
>>                          * uncached, then it must also be accessed
>uncached
>>                          * by the kernel or data corruption may occur
>>                          */
>
>I think /dev/oldmem isn't so nice and could actually cause some real
>problems if used on ia64 where the cached/uncached accesses are mixed.

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
