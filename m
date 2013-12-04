Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo7gq-0005NQ-Az
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 08:20:13 +0000
Date: Wed, 4 Dec 2013 16:19:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131204081938.GE3298@localhost.localdomain>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131204015657.GD3298@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131204015657.GD3298@localhost.localdomain>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On 12/04/13 at 09:56am, Baoquan He wrote:
> On 11/20/13 at 12:50pm, Vivek Goyal wrote:
> > + * that kexec_mutex is held.
> > + */
> 
> I think kexec_add_buffer is guaranteed to be called before allocating
> control pages, why not updating image->control_page after each time
> kexec_add_buffer is called. Then when control page is needed, effective
> address in crash_kernel region can be given. This can be a little more
> efficient.

Check again, it's not a good idea. Because buf_align is different when
kexec_add_buffer is called. Sometime the bug_align is larger than 4k.
Please ignore this comment.

> 
> > +int kexec_add_buffer(struct kimage *image, char *buffer,
> > +		unsigned long bufsz, unsigned long memsz,
> > +		unsigned long buf_align, unsigned long buf_min,
> > +		unsigned long buf_max, int top_down, unsigned long *load_addr)
> > +{
> > +
> > +	unsigned long nr_segments = image->nr_segments, new_nr_segments;
> > +	struct kexec_segment *ksegment;
> > +	struct kexec_buf *kbuf;
> > +
> > +	/* Currently adding segment this way is allowed only in file mode */
> > +	if (!image->file_mode)
> > +		return -EINVAL;
> > +
> > +	if (nr_segments >= KEXEC_SEGMENT_MAX)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Make sure we are not trying to add buffer after allocating
> > +	 * control pages. All segments need to be placed first before
> > +	 * any control pages are allocated. As control page allocation
> > +	 * logic goes through list of segments to make sure there are
> > +	 * no destination overlaps.
> > +	 */
> > +	WARN_ONCE(!list_empty(&image->control_pages), "Adding kexec buffer"
> > +			" after allocating control pages\n");
> > +
> > +	kbuf = kzalloc(sizeof(struct kexec_buf), GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
