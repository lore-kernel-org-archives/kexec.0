Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZL5pU-0003gS-Uf
 for kexec@lists.infradead.org; Fri, 31 Jul 2015 08:38:13 +0000
Date: Fri, 31 Jul 2015 16:37:49 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150731083749.GB13148@dhcp-128-28.nay.redhat.com>
References: <1438225679-13052-1-git-send-email-bhe@redhat.com>
 <20150730051553.GB27915@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150730051553.GB27915@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, tatsu@ab.jp.nec.com, seiji.aguchi.tr@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

On 07/30/15 at 01:15pm, Minfei Huang wrote:
> On 07/30/15 at 11:07am, Baoquan He wrote:
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index a785c10..1740c42 100644
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
> > +	align = 1<< order;
> > +
> > +	WARN_ON(size > PAGE_SIZE);
> 
> It is fine without this warning, since percpu will fail to allocate the
> memory larger than PAGE_SIZE.

Thanks for your comment.

percpu will fail if align is larger than PAGE_SIZE. I will adjust it
as align = min(1<<order, PAGE_SIZE). But adding WARN_ON makes sense
in case sizeof(note_buf_t) is bigger than PAGE_SIZE in the future,
then we need consider changing  the design of storing crash_notes.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
