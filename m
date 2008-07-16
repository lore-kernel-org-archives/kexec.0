Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJ9xC-0007xc-Jw
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 16:34:10 +0000
Date: Wed, 16 Jul 2008 12:34:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
Message-ID: <20080716163404.GD711@redhat.com>
References: <487D49DC.8040209@sgi.com> <20080716151240.GB711@redhat.com>
	<20080716172601.76338aae@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080716172601.76338aae@halley.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Wed, Jul 16, 2008 at 05:26:01PM +0200, Bernhard Walle wrote:
> * Vivek Goyal [2008-07-16 11:12]:
> > 
> > You need to dive deeper to find out what is taking so much of time.
> 
> I think the main difference are the huge memory gaps usual on IA64
> systems. makedumpfile processes each PFN sequentially when creating the
> 1st bitmap.

By memory gaps you mean large amount of memory? If yes, on 128GB system
it took me 4 min and on 1TB system (10 times memory), it takes 16hrs.
Almost 240 times the duration of 128GB. That sounds horrible.

Either it is some kind of NUMA machine and memory access to remote nodes is
really slow.  I am not sure if that's the case.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
