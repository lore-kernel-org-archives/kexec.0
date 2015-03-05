Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTdLp-0000Sf-Ew
 for kexec@lists.infradead.org; Thu, 05 Mar 2015 21:30:38 +0000
Date: Thu, 5 Mar 2015 22:30:05 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150305223005.07c552d8@hananiah.suse.cz>
In-Reply-To: <20150304134418.4d1f0cbf@holzheu>
References: <20150227131409.33dd14a4@hananiah.suse.cz>
 <20150303101543.416b5cb4@holzheu>
 <20150303110750.3feed6ec@hananiah.suse.cz>
 <20150304134418.4d1f0cbf@holzheu>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

On Wed, 4 Mar 2015 13:44:18 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Tue, 3 Mar 2015 11:07:50 +0100
> Petr Tesarik <ptesarik@suse.cz> wrote:
> 
> > On Tue, 3 Mar 2015 10:15:43 +0100
> > Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> [snip]
> 
> > > I did a quick test with your patch and it looks like the mmap mode
> > > on my s390 system is slower than the read mode:
> > 
> > That's sad. OTOH I had similar results on a file mmap some time ago.
> > The cost of copying data was less than the cost of handling a series of
> > minor page faults.
> 
> I think we understood the problem: As for the read path, also for mmap
> the memory is copied into a temporary buffer:
> 
>  static int read_with_mmap(off_t offset, void *bufptr, ...)
>  {
> 
>  ...
>         memcpy(bufptr, info->mmap_buf +
>                (offset - info->mmap_start_offset), read_size);
> 
> 
> Because on s390 copy_to_user() is as fast as userspace memcpy() we
> don't have any benefit here. The only saving is due to less
> mmap()/munmap() than read() system calls because bigger chunks
> are mapped than read.
> 
> If you specify -d 31 the dump memory is fragmented and we have to
> issue more mmap()/munmap() calls and therefore also the system
> call overhead increases.
> 
> If we really want to speed up the mmap path on s390 we probably
> have to get rid of the temporary buffer.
> 
> What do you think?

I'm not sure. Clearly, we should get rid of the temporary buffer. OTOH
this slow-down should be observed on all architectures, not just s390.

Now, mmap should have been implemented in the cache code, not above it.
Since I wrote the cache, this task is probably up to me.

Stay tuned,
Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
