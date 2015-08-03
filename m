Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMOkN-0001yW-HW
 for kexec@lists.infradead.org; Mon, 03 Aug 2015 23:02:20 +0000
Date: Tue, 4 Aug 2015 07:01:52 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v2] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150803230152.GA1718@dhcp-17-102.nay.redhat.com>
References: <1438606243-13064-1-git-send-email-bhe@redhat.com>
 <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tatsu@ab.jp.nec.com, lisa.mitchell@hp.com, seiji.aguchi.tr@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi Andrew,

Thanks a lot for your reviewing and suggestiong.

On 08/03/15 at 03:04pm, Andrew Morton wrote:
> On Mon,  3 Aug 2015 20:50:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1620,7 +1620,16 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
> >  static int __init crash_notes_memory_init(void)
> >  {
> >  	/* Allocate memory for saving cpu registers. */
> > -	crash_notes = alloc_percpu(note_buf_t);
> > +	size_t size, align;
> > +	int order;
> > +
> > +	size = sizeof(note_buf_t);
> > +	order = get_count_order(size);
> > +	align = min_t(size_t, (1<<order), PAGE_SIZE);
> > +
> > +	WARN_ON(size > PAGE_SIZE);
> > +
> > +	crash_notes = __alloc_percpu(size, align);
> 
> A code comment would be helpful - the reason for this code's existence
> is otherwise utterly unobvious.

Will add in new post.

> 
> I think it can be done this way:
> 
> 	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
> 
> 
> I never noticed get_count_order() before.  afaict it does the same as
> order_base_2(), except get_count_order() generates better code and has
> a ridiculous name.

OK, will change the code as you suggested.

> 
> And I think the WARN_ON can be replaced with a
> BUILD_BUG_ON(sizeof>PAGE_SIZE)?  That would avoid adding runtime
> overhead.

I am not sure about this. BUILD_BUG_ON will break kernel compiling.
Before we got the root cause several work around fix were introduced to
skip this kind of crash_note.

  c4082f3 vmcore: continue vmcore initialization if PT_NOTE is found empty
  38dfac8 vmcore: prevent PT_NOTE p_memsz overflow during header update

That means if (sizeof(note_buf_t)>PAGE_SIZE) really happened, normal
kernel works well, kdump kernel can work but we will lose those
crash_notes. And if on one certain ARCH sizeof(note_buf_t) is bigger
than PAGE_SIZE, the design here must be changed to avoid using percpu
variable or adjust their note_buf_t. That may take a not short time to
discuss and review. Comparing with this it may be better to tolerate the
dumping vmcore with uncomplete crash_notes for a while until new design
is taken.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
