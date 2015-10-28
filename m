Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp08.uk.ibm.com ([195.75.94.104])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrNUI-0006WF-Nq
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 09:57:47 +0000
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 28 Oct 2015 09:57:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id ACC271B08067
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 09:57:33 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S9vMQV9240946
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 09:57:22 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S9vMBX021434
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 03:57:22 -0600
Date: Wed, 28 Oct 2015 10:57:21 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151028105721.4ada142d@holzheu>
In-Reply-To: <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
 <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
 <20151027133520.30653ba3@holzheu>
 <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: stefan.roscher@de.ibm.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Wed, 28 Oct 2015 14:46:23 +0800
Dave Young <dyoung@redhat.com> wrote:

> Hi, Michael
> 
> > @@ -552,11 +563,18 @@ char *slurp_file(const char *filename, o
> >  		if (err < 0)
> >  			die("Can not seek to the begin of file %s: %s\n",
> >  					filename, strerror(errno));
> > +		buf = slurp_fd(fd, filename, size, &nread, use_mmap);
> >  	} else {
> >  		size = stats.st_size;
> > +		if (use_mmap) {
> > +			buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
> > +				   MAP_PRIVATE, fd, 0);
> > +			nread = stats.st_size;
> > +		} else {
> > +			buf = slurp_fd(fd, filename, size, &nread, 0);
> > +		}
> >  	}
> 
> Drop above changes and replace below lines with an extra use_mmap argument
> should be enough?
> 
> -	buf = slurp_fd(fd, filename, size, &nread);
> [snip]

Hmm, I don't think so.

In case of non-character devices I either mmap the file directly (use_mmap=true)
or use "slurp_fd()" (use_mmap=false). So I can't unconditionaly use slurp_fd().

The change in slurp_fd() to use anonymous mmap in case of use_mmap=true is
not really necessary. I did it nevertheless for consistency. This ensures
that the slrup_file_mmap() functions *always* returns mmaped memory.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
