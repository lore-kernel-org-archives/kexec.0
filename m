Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RSxxd-00077m-Ms
 for kexec@lists.infradead.org; Tue, 22 Nov 2011 21:33:03 +0000
Date: Tue, 22 Nov 2011 16:32:57 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] block: initialize request_queue's numa node during
 allocation
Message-ID: <20111122213257.GF5663@redhat.com>
References: <4ECB5C80.8080609@redhat.com>
 <alpine.DEB.2.00.1111220140470.4306@chino.kir.corp.google.com>
 <20111122152739.GA5663@redhat.com>
 <20111122211954.GA17120@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111122211954.GA17120@redhat.com>
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
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Dave Young <dyoung@redhat.com>

On Tue, Nov 22, 2011 at 04:19:58PM -0500, Mike Snitzer wrote:

[..]
> > Storing q->node info at queue allocation time makes sense to me. In fact
> > it might make sense to clean it up from blk_init_allocated_queue_node
> > and assume that passed queue has queue->node set at the allocation time.
> >
> > CCing Mike Snitzer who introduced blk_init_allocated_queue_node(). Mike
> > what do you think. I am not sure it makes sense to pass in nodeid, both
> > at queue allocation and queue initialization time. To me, it should make
> > more sense to allocate the queue at one node and that becomes the default
> > node for reset of the initialization.
> 
> Yeah, that makes sense to me too:
> 
> From: Mike Snitzer <snitzer@redhat.com>
> Subject: block: initialize request_queue's numa node during allocation
> 
> Set request_queue's node in blk_alloc_queue_node() rather than
> blk_init_allocated_queue_node().  This avoids blk_throtl_init() using
> q->node before it is initialized.
> 
> Rename blk_init_allocated_queue_node() to blk_init_allocated_queue().
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Thanks Mike. Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
