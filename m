Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRYZ3-0007Tn-Eu
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 01:18:22 +0000
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 25 Oct 2012 21:18:15 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 883156E8043
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 21:18:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9Q1I9UD292290
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 21:18:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9Q1I7op001394
 for <kexec@lists.infradead.org>; Thu, 25 Oct 2012 21:18:08 -0400
Message-ID: <1351214158.18115.186.camel@falcor>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 25 Oct 2012 21:15:58 -0400
In-Reply-To: <20121025185520.GA17995@redhat.com>
References: <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com> <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com> <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor> <20121025141048.GD9377@redhat.com>
 <1351190421.18115.92.camel@falcor> <20121025185520.GA17995@redhat.com>
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

On Thu, 2012-10-25 at 14:55 -0400, Vivek Goyal wrote:
> On Thu, Oct 25, 2012 at 02:40:21PM -0400, Mimi Zohar wrote:
> > On Thu, 2012-10-25 at 10:10 -0400, Vivek Goyal wrote:
> > > On Thu, Oct 25, 2012 at 02:10:01AM -0400, Mimi Zohar wrote:
> > > 
> > > [..]
> > > > IMA-appraisal verifies the integrity of file data, while EVM verifies
> > > > the integrity of the file metadata, such as LSM and IMA-appraisal
> > > > labels.  Both 'security.ima' and 'security.evm' can contain digital
> > > > signatures.
> > > 
> > > But the private key for creating these digital signature needs to be
> > > on the target system?
> > > 
> > > Thanks
> > > Vivek
> > 
> > Absolutely not.  The public key needs to be added to the _ima or _evm
> > keyrings.  Roberto Sassu modified dracut and later made equivalent
> > changes to systemd.  Both have been upstreamed.
> 
> Putting public key in _ima or _evm keyring is not the problem. This is
> just the verification part.
> 
> > Dmitry has a package
> > that labels the filesystem called ima-evm-utils, which supports hash
> > (IMA), hmac(EVM) and digital signatures(both).
> > 
> > We're hoping that distro's would label all immutable files, not only elf
> > executables, with digital signatures and mutable files with a hash.
> 
> So this labeling (digital signing) can happen at build time?

There is nothing inherently preventing it from happening at build time.
Elana Reshetova gave a talk at LSS 2012 on modifying RPM
http://lwn.net/Articles/518265/. 

> I suspect you need labeling to happen at system install time? If yes,
> installer does not have the private key to sign anything.

The installed system needs to be labeled, but how that occurs is
dependent on your environment (eg. flash, rpm based install).  Neither
of these mechanisms would require the build private key.

On a running system, the package installer, after verifying the package
integrity, would install each file with the associated 'security.ima'
extended attribute.  The 'security.evm' digital signature would be
installed with an HMAC, calculated using a system unique key. 

> IOW, if distro sign a file, they will most likely put signatures in
> ELF header (something along the lines of signing PE/COFF binaries). 

Rusty was definitely against putting the signature in the ELF header for
kernel modules.  Why would this be any different?

> But
> I think you need digital signatures to be put in security.ima which are
> stored in xattrs and xattrs are not generated till you put file in
> question on target file system.
> 
> Thanks
> Vivek

The 'security.ima' digital signature would be created as part of the
build process and stored as an extended attribute with the file, like
other metadata.  On install, the file, extended attributes and other
metadata would be copied to the target file system.

Mimi
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
