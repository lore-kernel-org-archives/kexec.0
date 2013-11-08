Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeeRI-0002x4-TT
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 05:17:03 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
Date: Fri, 8 Nov 2013 05:12:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971BD6C0@BPXM01GP.gisp.nec.co.jp>
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
 <20131105202631.GC4598@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BB7A9@BPXM01GP.gisp.nec.co.jp>
 <20131106142350.GB23357@redhat.com> <527B55F0.4000301@hp.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "jingbai.ma@hp.com" <jingbai.ma@hp.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hello Jingbai,

(2013/11/07 17:58), Jingbai Ma wrote:
> On 11/06/2013 10:23 PM, Vivek Goyal wrote:
>> On Wed, Nov 06, 2013 at 02:21:39AM +0000, Atsushi Kumagai wrote:
>>> (2013/11/06 5:27), Vivek Goyal wrote:
>>>> On Tue, Nov 05, 2013 at 09:45:32PM +0800, Jingbai Ma wrote:
>>>>> This patch set intend to exclude unnecessary hugepages from vmcore dump file.
>>>>>
>>>>> This patch requires the kernel patch to export necessary data structures into
>>>>> vmcore: "kexec: export hugepage data structure into vmcoreinfo"
>>>>> http://lists.infradead.org/pipermail/kexec/2013-November/009997.html
>>>>>
>>>>> This patch introduce two new dump levels 32 and 64 to exclude all unused and
>>>>> active hugepages. The level to exclude all unnecessary pages will be 127 now.
>>>>
>>>> Interesting. Why hugepages should be treated any differentely than normal
>>>> pages?
>>>>
>>>> If user asked to filter out free page, then it should be filtered and
>>>> it should not matter whether it is a huge page or not?
>>>
>>> I'm making a RFC patch of hugepages filtering based on such policy.
>>>
>>> I attach the prototype version.
>>> It's able to filter out also THPs, and suitable for cyclic processing
>>> because it depends on mem_map and looking up it can be divided into
>>> cycles. This is the same idea as page_is_buddy().
>>>
>>> So I think it's better.
>>
>> Agreed. Being able to treat hugepages in same manner as other pages
>> sounds good.
>>
>> Jingbai, looks good to you?
>
> It looks good to me.
>
> My only concern is by this way, we only can exclude all hugepage together, but can't exclude the free hugepages only. I'm not sure if user need to dump out the activated hugepage only.
>
> Kumagai-san, please correct me, if I'm wrong.

Yes, my patch treats all allocated hugetlbfs pages as user pages,
doesn't distinguish whether the pages are actually used or not.
I made so because I guess it's enough for almost all users.

We can introduce new dump level after it's needed actually,
but I don't think now is the time. To introduce it without
demand will make this tool just more complex.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
