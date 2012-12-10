Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ti4XN-0003ln-Tg
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 14:40:55 +0000
Received: by mail-oa0-f49.google.com with SMTP id l10so2488815oag.36
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2012 06:40:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121207145909.GA4928@redhat.com>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <20121206145020.93fd7128.akpm@linux-foundation.org>
 <CAAmzW4N-=uXBdgjbkdL=aNVtKvvXZs-6BNgpDzi7CLkeo0-jBg@mail.gmail.com>
 <20121207145909.GA4928@redhat.com>
Date: Mon, 10 Dec 2012 23:40:47 +0900
Message-ID: <CAAmzW4NHO=y=utmK_at+JxvyYMd4O_7W_6n541GEA0aeDfukyw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] remove vm_struct list management
From: JoonSoo Kim <js1304@gmail.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dave Anderson <anderson@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Hello, Vivek.

2012/12/7 Vivek Goyal <vgoyal@redhat.com>:
> On Fri, Dec 07, 2012 at 10:16:55PM +0900, JoonSoo Kim wrote:
>> 2012/12/7 Andrew Morton <akpm@linux-foundation.org>:
>> > On Fri,  7 Dec 2012 01:09:27 +0900
>> > Joonsoo Kim <js1304@gmail.com> wrote:
>> >
>> >> I'm not sure that "7/8: makes vmlist only for kexec" is fine.
>> >> Because it is related to userspace program.
>> >> As far as I know, makedumpfile use kexec's output information and it only
>> >> need first address of vmalloc layer. So my implementation reflect this
>> >> fact, but I'm not sure. And now, I don't fully test this patchset.
>> >> Basic operation work well, but I don't test kexec. So I send this
>> >> patchset with 'RFC'.
>> >
>> > Yes, this is irritating.  Perhaps Vivek or one of the other kexec
>> > people could take a look at this please - if would obviously be much
>> > better if we can avoid merging [patch 7/8] at all.
>>
>> I'm not sure, but I almost sure that [patch 7/8] have no problem.
>> In kexec.c, they write an address of vmlist and offset of vm_struct's
>> address field.
>> It imply that user for this information doesn't have any other
>> information about vm_struct,
>> and they can't use other field of vm_struct. They can use *only* address field.
>> So, remaining just one vm_struct for vmlist which represent first area
>> of vmalloc layer
>> may be safe.
>
> I browsed through makedumpfile source quickly. So yes it does look like
> that we look at first vmlist element ->addr field to figure out where
> vmalloc area is starting.
>
> Can we get the same information from this rb-tree of vmap_area? Is
> ->va_start field communication same information as vmlist was
> communicating? What's the difference between vmap_area_root and vmlist.

Thanks for comment.

Yes. vmap_area's va_start field represent same information as vm_struct's addr.
vmap_area_root is data structure for fast searching an area.
vmap_area_list is address sorted list, so we can use it like as vmlist.

There is a little difference vmap_area_list and vmlist.
vmlist is lack of information about some areas in vmalloc address space.
For example, vm_map_ram() allocate area in vmalloc address space,
but it doesn't make a link with vmlist. To provide full information
about vmalloc address space,
using vmap_area_list is more adequate.

> So without knowing details of both the data structures, I think if vmlist
> is going away, then user space tools should be able to traverse vmap_area_root
> rb tree. I am assuming it is sorted using ->addr field and we should be
> able to get vmalloc area start from there. It will just be a matter of
> exporting right fields to user space (instead of vmlist).

There is address sorted list of vmap_area, vmap_area_list.
So we can use it for traversing vmalloc areas if it is necessary.
But, as I mentioned before, kexec write *just* address of vmlist and
offset of vm_struct's address field.
It imply that they don't traverse vmlist,
because they didn't write vm_struct's next field which is needed for traversing.
Without vm_struct's next field, they have no method for traversing.
So, IMHO, assigning dummy vm_struct to vmlist which is implemented by [7/8] is
a safe way to maintain a compatibility of userspace tool. :)

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
