Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRodg-000197-PS
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 18:28:13 +0000
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 26 Oct 2012 14:28:10 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 43CBCC9005E
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 14:28:05 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9QIS5DH320362
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 14:28:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9QIS4Le020102
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2012 16:28:04 -0200
Message-ID: <1351275954.18115.209.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 26 Oct 2012 14:25:54 -0400
In-Reply-To: <20121026181904.GA5770@srcf.ucam.org>
References: <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com> <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor> <20121025141048.GD9377@redhat.com>
 <1351190421.18115.92.camel@falcor> <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor> <20121026023916.GA16762@srcf.ucam.org>
 <1351274374.18115.205.camel@falcor> <20121026181904.GA5770@srcf.ucam.org>
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

On Fri, 2012-10-26 at 19:19 +0100, Matthew Garrett wrote:
> On Fri, Oct 26, 2012 at 01:59:34PM -0400, Mimi Zohar wrote:
> > On Fri, 2012-10-26 at 03:39 +0100, Matthew Garrett wrote:
> > > and it must be impossible for anything other than 
> > > /sbin/kexec to make the kexec system call.
> > 
> > Permission is a MAC issue. :)
> 
> It's a MAC issue that has to be implemented in the kernel. We can't 
> depend on userspace loading any kind of policy.

Still a MAC issue, that problably could be addressed by capabilities.  I
suggest you post this issue on the LSM mailing list.  Please cc: Serge,
as the capabilities maintainer.

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
