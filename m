Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tgxc3-00048s-MM
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 13:05:08 +0000
Received: by mail-oa0-f49.google.com with SMTP id l10so370716oag.36
 for <kexec@lists.infradead.org>; Fri, 07 Dec 2012 05:05:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121206144534.23d26318.akpm@linux-foundation.org>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <20121206144534.23d26318.akpm@linux-foundation.org>
Date: Fri, 7 Dec 2012 22:05:04 +0900
Message-ID: <CAAmzW4OUivQy+KUuDMhL7Dkgdb2yGAxjUC-R5a5+RGViMJJ-fA@mail.gmail.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

Hello, Andrew.

2012/12/7 Andrew Morton <akpm@linux-foundation.org>:
> On Fri,  7 Dec 2012 01:09:27 +0900
> Joonsoo Kim <js1304@gmail.com> wrote:
>
>> This patchset remove vm_struct list management after initializing vmalloc.
>> Adding and removing an entry to vmlist is linear time complexity, so
>> it is inefficient. If we maintain this list, overall time complexity of
>> adding and removing area to vmalloc space is O(N), although we use
>> rbtree for finding vacant place and it's time complexity is just O(logN).
>>
>> And vmlist and vmlist_lock is used many places of outside of vmalloc.c.
>> It is preferable that we hide this raw data structure and provide
>> well-defined function for supporting them, because it makes that they
>> cannot mistake when manipulating theses structure and it makes us easily
>> maintain vmalloc layer.
>>
>> I'm not sure that "7/8: makes vmlist only for kexec" is fine.
>> Because it is related to userspace program.
>> As far as I know, makedumpfile use kexec's output information and it only
>> need first address of vmalloc layer. So my implementation reflect this
>> fact, but I'm not sure. And now, I don't fully test this patchset.
>> Basic operation work well, but I don't test kexec. So I send this
>> patchset with 'RFC'.
>>
>> Please let me know what I am missing.
>>
>> This series based on v3.7-rc7 and on top of submitted patchset for ARM.
>> 'introduce static_vm for ARM-specific static mapped area'
>> https://lkml.org/lkml/2012/11/27/356
>> But, running properly on x86 without ARM patchset.
>
> This all looks rather nice, but not mergeable into anything at this
> stage in the release cycle.
>
> What are the implications of "on top of submitted patchset for ARM"?
> Does it depens on the ARM patches in any way, or it it independently
> mergeable and testable?
>

Yes. It depends on ARM patches.
There is a code to manipulate a vmlist in ARM.
So without applying ARM patches, this patchset makes compile error for ARM.
But, build for x86 works fine with this patchset :)

In ARM patches, a method used for removing vmlist related code is same
as 1/8 of this patchset.
But, it includes some optimization for ARM, so I sent it separately.
If it can't be accepted, I can rework ARM patches like as 1/8 of this patchset.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
