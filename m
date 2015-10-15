Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmhhV-0006fF-Np
 for kexec@lists.infradead.org; Thu, 15 Oct 2015 12:32:06 +0000
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 13:31:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 93370219005C
 for <kexec@lists.infradead.org>; Thu, 15 Oct 2015 13:31:38 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9FCVec229425690
 for <kexec@lists.infradead.org>; Thu, 15 Oct 2015 12:31:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FBVeDC005513
 for <kexec@lists.infradead.org>; Thu, 15 Oct 2015 05:31:40 -0600
Date: Thu, 15 Oct 2015 14:31:38 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20151015143138.1287fd6f@holzheu>
In-Reply-To: <1444867552.3929.7.camel@infradead.org>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20150902010721.GE30886@verge.net.au>
 <20150902104839.17674456@holzheu>
 <20150904094541.GA30724@verge.net.au>
 <20150904141159.182c2f08@holzheu>
 <1444867552.3929.7.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: stefan.roscher@de.ibm.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Wed, 14 Oct 2015 17:05:52 -0700
Geoff Levand <geoff@infradead.org> wrote:

[snip]

> >  		if (err < 0)
> >  > 	> 	> 	> die("Can not seek to the begin of file %s: %s\n",
> >  > 	> 	> 	> 	> 	> filename, strerror(errno));
> > +> 	> 	> buf = slurp_fd(fd, filename, size, &nread);
> >  > 	> } else {
> > -> 	> 	> size = stats.st_size;
> > +> 	> 	> size = nread = stats.st_size;
> > +> 	> 	> buf = mmap(NULL, size,
> 
> With this change the caller can't tell if buf was malloc'ed or mmaped.  The
> only safe thing it can do is to not call free() on the returned buf, this will
> lead to memory leakage for malloc'ed buffers.

I have read the code and have not found any free call. Therefore I assumed
that the kexec approach is to not free the buffer *explicitly* and leave to
the kernel to free it *automatically* at process exit.

@Simon: Was this assumption wrong?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
