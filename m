Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IXUh9-0006WW-4H
	for kexec@lists.infradead.org; Tue, 18 Sep 2007 05:28:23 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8I4S3kX026957
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:28:03 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8I4S3is505854
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:28:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8I4S2jH021244
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:28:03 -0400
Date: Tue, 18 Sep 2007 09:58:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: My position on general ``RAS'' tool support infrastructure
Message-ID: <20070918042822.GA4842@in.ibm.com>
References: <46E8B06D.9080006@bluelane.com>
	<m1abrq7lbt.fsf@ebiederm.dsl.xmission.com>
	<20070917183853.42f29393.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070917183853.42f29393.randy.dunlap@oracle.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: kdb@oss.sgi.com, jlan@sgi.com, Amit Kale <amitkale@linsyssoft.com>, Jason Wessel <jason.wessel@windriver.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Matt Mackall <mpm@selenic.com>, pete@bluelane.com, Andrew Morton <akpm@linux-foundation.org>

On Mon, Sep 17, 2007 at 06:38:53PM -0700, Randy Dunlap wrote:
> On Thu, 13 Sep 2007 07:21:10 -0600 Eric W. Biederman wrote:
> 
> > Pete/Piet Delaney <pete@bluelane.com> writes:
> > 
> > > Jason, Eric:
> > >
> > > Did you read Keith Owens suggestion on RAS tools from:
> 
> 
> Yes.  and I re-read it.
> 
> There are several things in Keith's email that make sense:
> 
> a.  all RAS tools should use a common interface
> b.  it's not the kernel's job to decide which RAS tool runs first
> 
> 
> Eric makes some good points too.  I'm mostly similar to Eric:
> paranoid about trusting software/hardware after a panic (or oops).
> 
> So if someone wants to use multiple RAS tools on a panic event,
> enabling an admin to set priorities is OK with me, but I'll only
> trust the first one that is used, and even that one may have
> problems.  IOW, I don't see a big need to support multiple RAS
> tools at one time.  (speaking for myself)
> 

I would be nice to have a kernel debugger co-exist with crash dumping.

I like Eric's idea of debugger putting a break point on panic(). This
would mean that rest of the post panic() actions have to be performed
by second kernel which can perform those actions much more reliably.

But this also brings in the additional requirement of passing all the
required context to second kernel. For example, in the past somebody wanted
to send a message to a remote node that sytem crashed so that standby can
take over.  If the same job has to be done in second kernel, it requires all
the relavant information like remote host IP, port etc passed to the second
kernel which I think makes the job little harder. May be one can pre-configure
these parameters in user space and let the job be done either from initrd
or user space scripts in second kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
