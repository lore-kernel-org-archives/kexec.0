Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YT8fQ-0006rg-0z
 for kexec@lists.infradead.org; Wed, 04 Mar 2015 12:44:49 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 12:44:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C91017D805A
 for <kexec@lists.infradead.org>; Wed,  4 Mar 2015 12:44:40 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t24CiLuI64749762
 for <kexec@lists.infradead.org>; Wed, 4 Mar 2015 12:44:21 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t24CiKbc009610
 for <kexec@lists.infradead.org>; Wed, 4 Mar 2015 05:44:20 -0700
Date: Wed, 4 Mar 2015 13:44:18 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150304134418.4d1f0cbf@holzheu>
In-Reply-To: <20150303110750.3feed6ec@hananiah.suse.cz>
References: <20150227131409.33dd14a4@hananiah.suse.cz>
 <20150303101543.416b5cb4@holzheu>
 <20150303110750.3feed6ec@hananiah.suse.cz>
Mime-Version: 1.0
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Jan Willeke <willeke@de.ibm.com>

On Tue, 3 Mar 2015 11:07:50 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Tue, 3 Mar 2015 10:15:43 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip]

> > I did a quick test with your patch and it looks like the mmap mode
> > on my s390 system is slower than the read mode:
> 
> That's sad. OTOH I had similar results on a file mmap some time ago.
> The cost of copying data was less than the cost of handling a series of
> minor page faults.

I think we understood the problem: As for the read path, also for mmap
the memory is copied into a temporary buffer:

 static int read_with_mmap(off_t offset, void *bufptr, ...)
 {

 ...
        memcpy(bufptr, info->mmap_buf +
               (offset - info->mmap_start_offset), read_size);


Because on s390 copy_to_user() is as fast as userspace memcpy() we
don't have any benefit here. The only saving is due to less
mmap()/munmap() than read() system calls because bigger chunks
are mapped than read.

If you specify -d 31 the dump memory is fragmented and we have to
issue more mmap()/munmap() calls and therefore also the system
call overhead increases.

If we really want to speed up the mmap path on s390 we probably
have to get rid of the temporary buffer.

What do you think?
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
