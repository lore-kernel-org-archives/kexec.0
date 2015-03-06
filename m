Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YToIG-0005ao-Fu
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 09:11:41 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 6 Mar 2015 09:11:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B15517D8068
 for <kexec@lists.infradead.org>; Fri,  6 Mar 2015 09:11:35 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t269BEaU8388958
 for <kexec@lists.infradead.org>; Fri, 6 Mar 2015 09:11:14 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t269BEgC005361
 for <kexec@lists.infradead.org>; Fri, 6 Mar 2015 04:11:14 -0500
Date: Fri, 6 Mar 2015 10:11:12 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150306101112.34756de7@holzheu>
In-Reply-To: <20150305223005.07c552d8@hananiah.suse.cz>
References: <20150227131409.33dd14a4@hananiah.suse.cz>
 <20150303101543.416b5cb4@holzheu>
 <20150303110750.3feed6ec@hananiah.suse.cz>
 <20150304134418.4d1f0cbf@holzheu>
 <20150305223005.07c552d8@hananiah.suse.cz>
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
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

On Thu, 5 Mar 2015 22:30:05 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Wed, 4 Mar 2015 13:44:18 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 

[snip]

> > What do you think?
> 
> I'm not sure. Clearly, we should get rid of the temporary buffer. OTOH
> this slow-down should be observed on all architectures, not just s390.
> 
> Now, mmap should have been implemented in the cache code, not above it.
> Since I wrote the cache, this task is probably up to me.

Sounds good, thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
