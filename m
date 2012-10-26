Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRoEv-0004eF-TW
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 18:02:39 +0000
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 26 Oct 2012 12:02:33 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 43C2D19D803F
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 12:02:30 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9QI2MAS175506
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 12:02:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9QI2Ln3023076
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 12:02:22 -0600
Message-ID: <1351274374.18115.205.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 26 Oct 2012 13:59:34 -0400
In-Reply-To: <20121026023916.GA16762@srcf.ucam.org>
References: <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com> <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com> <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor> <20121025141048.GD9377@redhat.com>
 <1351190421.18115.92.camel@falcor> <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor> <20121026023916.GA16762@srcf.ucam.org>
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
To: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@polito.it>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Fri, 2012-10-26 at 03:39 +0100, Matthew Garrett wrote:
> On Thu, Oct 25, 2012 at 09:15:58PM -0400, Mimi Zohar wrote:
> 
> > On a running system, the package installer, after verifying the package
> > integrity, would install each file with the associated 'security.ima'
> > extended attribute.  The 'security.evm' digital signature would be
> > installed with an HMAC, calculated using a system unique key. 
> 
> The idea isn't to prevent /sbin/kexec from being modified after 
> installation - it's to prevent it from being possible to install a 
> system that has a modified /sbin/kexec.

Understood.

>  Leaving any part of this up to 
> the package installer means that it doesn't solve the problem we're 
> trying to solve here. It must be impossible for the kernel to launch any 
> /sbin/kexec that hasn't been signed by a trusted key that's been built 
> into the kernel, 

With Dmitry's patch "5e0d1a4 ima: added policy support for security.ima
type", or something similar, we can force 'security.ima' to a specific
type, in this case, a digital signature.  With that patch, this
shouldn't be a problem.

> and it must be impossible for anything other than 
> /sbin/kexec to make the kexec system call.

Permission is a MAC issue. :)

thanks,

Mimi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
