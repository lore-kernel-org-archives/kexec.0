Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRSOT-00041I-Ac
 for kexec@lists.infradead.org; Thu, 25 Oct 2012 18:43:02 +0000
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 25 Oct 2012 14:42:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1E6FDC9006E
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 14:42:41 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9PIgdOE285574
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 14:42:40 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9PIgXjb012513
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 12:42:36 -0600
Message-ID: <1351190421.18115.92.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 25 Oct 2012 14:40:21 -0400
In-Reply-To: <20121025141048.GD9377@redhat.com>
References: <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com> <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com> <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor> <20121025141048.GD9377@redhat.com>
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

On Thu, 2012-10-25 at 10:10 -0400, Vivek Goyal wrote:
> On Thu, Oct 25, 2012 at 02:10:01AM -0400, Mimi Zohar wrote:
> 
> [..]
> > IMA-appraisal verifies the integrity of file data, while EVM verifies
> > the integrity of the file metadata, such as LSM and IMA-appraisal
> > labels.  Both 'security.ima' and 'security.evm' can contain digital
> > signatures.
> 
> But the private key for creating these digital signature needs to be
> on the target system?
> 
> Thanks
> Vivek

Absolutely not.  The public key needs to be added to the _ima or _evm
keyrings.  Roberto Sassu modified dracut and later made equivalent
changes to systemd.  Both have been upstreamed.  Dmitry has a package
that labels the filesystem called ima-evm-utils, which supports hash
(IMA), hmac(EVM) and digital signatures(both).

We're hoping that distro's would label all immutable files, not only elf
executables, with digital signatures and mutable files with a hash.

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
