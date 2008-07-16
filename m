Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJ8gO-0002jt-8B
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 15:12:44 +0000
Date: Wed, 16 Jul 2008 11:12:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
Message-ID: <20080716151240.GB711@redhat.com>
References: <487D49DC.8040209@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <487D49DC.8040209@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org

On Tue, Jul 15, 2008 at 06:07:40PM -0700, Jay Lan wrote:
> Are there known problems if you boot up kdump kernel with
> multipl cpus?
> 

I had run into one issue and that was some system would get reset and 
jump to BIOS.

The reason was that kdump kernel can boot on a non-boot cpu. When it
tries to bring up other cpus it sends INIT and a non-boot cpu sending
INIT to "boot" cpu was not acceptable (as per intel documentation) and 
it re-initialized the system.

I am not sure how many systems are affected with this behavior. Hence
the reason for using maxcpus=1.

> It takes unacceptably long time to run makedumpfile in
> saving dump at a huge memory system. In my testing it
> took 16hr25min to run create_dump_bitmap() on a 1TB system.
> Pfn's are processed sequentially with single cpu. We
> certainly can use multipl cpus here ;)

This is certainly very long time. How much memory have you reserved for
kdump kernel?

I had run some tests on a x86_64 128GB RAM system and it took me 4 minutes
to filter and save the core (maximum filtering level of 31). I had
reserved 128MB of memory for kdump kernel.

I think something else is seriously wrong here. 1 TB is almost 10 times of
128GM and even if time scales linearly it should not take more than
40mins.

You need to dive deeper to find out what is taking so much of time.

CCing kenichi.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
