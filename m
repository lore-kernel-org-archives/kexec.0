Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRooq-0001TP-Ew
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 18:39:45 +0000
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 26 Oct 2012 14:39:41 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AEFD36E8041
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 14:39:39 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9QIddll324410
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 14:39:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9QIdcns005625
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 14:39:39 -0400
Message-ID: <1351276649.18115.217.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 26 Oct 2012 14:37:29 -0400
In-Reply-To: <20121026170609.GB24687@redhat.com>
References: <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com> <87fw552mb4.fsf_-_@xmission.com>
 <20121024173651.GE1821@redhat.com> <1351145401.18115.78.camel@falcor>
 <20121025141048.GD9377@redhat.com> <1351190421.18115.92.camel@falcor>
 <20121025185520.GA17995@redhat.com> <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org> <20121026170609.GB24687@redhat.com>
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

On Fri, 2012-10-26 at 13:06 -0400, Vivek Goyal wrote:
> On Fri, Oct 26, 2012 at 03:39:16AM +0100, Matthew Garrett wrote:
> > On Thu, Oct 25, 2012 at 09:15:58PM -0400, Mimi Zohar wrote:
> > 
> > > On a running system, the package installer, after verifying the package
> > > integrity, would install each file with the associated 'security.ima'
> > > extended attribute.  The 'security.evm' digital signature would be
> > > installed with an HMAC, calculated using a system unique key. 
> > 
> > The idea isn't to prevent /sbin/kexec from being modified after 
> > installation - it's to prevent it from being possible to install a 
> > system that has a modified /sbin/kexec. Leaving any part of this up to 
> > the package installer means that it doesn't solve the problem we're 
> > trying to solve here. It must be impossible for the kernel to launch any 
> > /sbin/kexec that hasn't been signed by a trusted key that's been built 
> > into the kernel, and it must be impossible for anything other than 
> > /sbin/kexec to make the kexec system call.
> 
> I am kind of lost now so just trying to summarize whatever I have
> learned so far from this thread.

Thanks for summarizing.

> - So say we can sign /sbin/kexec at build time and distros can do that.
> - Verify the signature at exec time using kernel keyring and if
>   verification happens successfully, say process gains extra capability.
> - Use this new capability to determine whether kexec_load() will be
>   successful or not.
> 
> Even if we can do all this, it still has the issue of being able to
> stop the process in user space and replace the code at run time
> and be able to launch unsigned kernel.
> 
> So until and unless we have a good solution to verify application's
> integrity/authneticity at the time of kexec_load() system call we
> still have the problem. And I don't think we have come up with a
> solution for that yet (until and unless I missed something).
>   
> Thanks
> Vivek
> 

Agreed, you need a new LSM/integrity hook.

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
