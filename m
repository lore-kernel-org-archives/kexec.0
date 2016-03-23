Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aiZX8-0008Eh-5P
 for kexec@lists.infradead.org; Wed, 23 Mar 2016 03:32:34 +0000
Subject: Re: [PATCH V2 0/2] kexec: Make a pair of map/unmap reserved pages in
 error path
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
 <56D56684.9000908@redhat.com> <20160323024836.GC2567@x1.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <56F20E34.5040303@redhat.com>
Date: Wed, 23 Mar 2016 11:32:04 +0800
MIME-Version: 1.0
In-Reply-To: <20160323024836.GC2567@x1.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, akpm@linux-foundation.org, ebiederm@xmission.com

On 2016/03/23 at 10:48, Baoquan He wrote:
> On 03/01/16 at 05:53pm, Xunlei Pang wrote:
>> This is a bug fix.
>>
>> After this, I will try to do a cleanup for crash_unmap/map_reserved_pages()
>> (only used by S390) to consolidate it with arch_kexec_unprotect/protect_crashkres().
> Hi Xunlei, Minfei,
>
> I think you need discuss together about how to do clean up codes in this
> place. From my point of view, arch_map/unmap_reserved_pages and
> arch_kexec_protect/unprotect_crashkres() are for the same goal but by
> different ways on different arch. So for Xunlei's patchset, you might
> need to rethink your implementation, the name of function. I personally
> think you just implement a x86 specific arch_map/unmap_reserved_pages.
> It may need a more generic name, and then add your x86 arch specific
> implementation. Sorry I can't see your patches on my mail client,

Like what you said, I think arch_kexec_unprotect/protect_crashkres() are
generic enough, but any other better name is welcome :-)

It also covered the newly-added kexec file path, and we can easily transfer
arch_map/unmap_reserved_pages into this new interface.

I was planning doing that, but sick recently, I will try to send a patch
doing that later.

Regards,
Xunlei

> Xunlei. Since Andrew asked, I just checked these.
>
> I am fine with Minfei's patch 1/2. But for patch 2/2, it's a little
> comfortable to me. Is it really necessary to abstract code block from
> kexec_load, then wrap them into a newly added function do_kexec_load()?
> Without this wrapping is there a way to do your bug fix? Is there
> possibility that do_kexec_load will be called in other places? What's
> the benefit to wrap it into do_kexec_load against not wrapping?
>
> Thanks
> Baoquan
>
>> Regards,
>> Xunlei
>>
>> On 03/01/2016 at 04:02 PM, Minfei Huang wrote:
>>> v1:
>>> - Bisect the patch according to Andrew Morton's suggestion
>>>
>>> Minfei Huang (2):
>>>   kexec: Make a pair of map/unmap reserved pages in error path
>>>   kexec: Do a cleanup for function kexec_load
>>>
>>>  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
>>>  1 file changed, 63 insertions(+), 49 deletions(-)
>>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
