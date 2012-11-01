Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TTvoK-0003Lj-N2
 for kexec@lists.infradead.org; Thu, 01 Nov 2012 14:31:57 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Nov 2012 08:31:53 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2E8941FF0046
 for <kexec@lists.infradead.org>; Thu,  1 Nov 2012 08:31:48 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA1EVg0M203760
 for <kexec@lists.infradead.org>; Thu, 1 Nov 2012 08:31:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA1EVcH6029993
 for <kexec@lists.infradead.org>; Thu, 1 Nov 2012 08:31:42 -0600
Message-ID: <1351780159.15708.17.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 01 Nov 2012 10:29:19 -0400
In-Reply-To: <20121101135356.GA15659@redhat.com>
References: <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor> <20121025141048.GD9377@redhat.com>
 <1351190421.18115.92.camel@falcor> <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor> <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com> <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com> <20121101135356.GA15659@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Thu, 2012-11-01 at 09:53 -0400, Vivek Goyal wrote:
> On Thu, Nov 01, 2012 at 09:10:03AM -0400, Vivek Goyal wrote:
> 
> [..]
> > > 
> > > > - So say we can sign /sbin/kexec at build time and distros can do that.
> > > > - Verify the signature at exec time using kernel keyring and if
> > > >   verification happens successfully, say process gains extra capability.
> > > > - Use this new capability to determine whether kexec_load() will be
> > > >   successful or not.
> > > > 
> > > > Even if we can do all this, it still has the issue of being able to
> > > > stop the process in user space and replace the code at run time
> > > > and be able to launch unsigned kernel.
> > 
> > Thinking more about it. Can we just keep track whether a process was
> > ptraced or not and disallow kexec_load() syscall if it was ptraced.
> > (I am assuming that ptrace is the only way to change process code/data).
> > 
> > So binaries can be signed offline. Signature verification can take place
> > using kernel keyring at exec() time. And we can keep track of ptraced
> > processes and disallow calling kexec_load() for such processes. If this
> > is implementable, this should take care of following requirement raised
> > by matthew.
> > 
> > ************************************************************************
> > It must be impossible for the kernel to launch any /sbin/kexec that hasn't
> > been signed by a trusted key that's been built into the kernel, and it
> > must be impossible for anything other than /sbin/kexec to make the kexec
> > system call.
> > *************************************************************************
> > 
> > Thoughts?
> 
> Eric responded but my mistake he responded to only me. So I will quickly 
> put his idea here.
> 
> [start quote]
> 
> You can't ptrace a process that has a capability you don't.
> 
> That should be enforced in security/commoncap/
> 
> [end quote]
> 
> This looks like a good idea. Upon verification signed binaries will be
> assigned special capability and then no unsigned binary should be able
> to ptrace signed/verified processes

That's a good generic solution, which I'm all in favor of, but it
doesn't resolve the latter half of Matthrew's requirement "and it must
be impossible for anything other than /sbin/kexec to make the kexec
system call."

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
