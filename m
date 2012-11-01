Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TTxk7-0001Aq-Eq
 for kexec@lists.infradead.org; Thu, 01 Nov 2012 16:35:43 +0000
Date: Thu, 1 Nov 2012 16:23:15 +0000
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121101162315.GA13132@srcf.ucam.org>
References: <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com>
 <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com>
 <1351780159.15708.17.camel@falcor>
 <20121101145149.GB15821@redhat.com>
 <20121101145731.GB10662@srcf.ucam.org>
 <1351782656.3782.58.camel@rhapsody>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1351782656.3782.58.camel@rhapsody>
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
To: Khalid Aziz <khalid@gonehiking.org>
Cc: Kees Cook <keescook@chromium.org>, horms@verge.net.au, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@polito.it>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Nov 01, 2012 at 09:10:56AM -0600, Khalid Aziz wrote:
> On Thu, 2012-11-01 at 14:57 +0000, Matthew Garrett wrote:
> > On Thu, Nov 01, 2012 at 10:51:49AM -0400, Vivek Goyal wrote:
> > 
> > > And if one wants only /sbin/kexec to call it, then just sign that
> > > one so no other executable will be able to call kexec_load(). Though
> > > I don't think that's the requirement here. Requirement is that only
> > > trusted executables should be able to call kexec_load().
> > 
> > Where "trusted executables" means "signed by a key that's present in the 
> > system firmware or in the kernel that's signed with a key that's present 
> > in the system firmware", sure.
> > 
> 
> This is starting to sound too restrictive (even though I understand the
> rationale behind the restrictions). Does this allow for a custom
> userspace application that among other things also can kexec_load() a
> new kernel and boot it, for example a customer unique health monitoring
> app that reboots the system if things are not looking right on the
> running system?

Only if it's signed with a key that the kernel trusts.

> How would a customer go about getting that userspace binary signed and 
> re-signed every time they update their app? There is the option of 
> turning the whole SecureBoot thing off for a system like that but let 
> us assume customer wants to leave that on or does not have the option 
> to turn it off?

There's ongoing work for providing mechanisms for trusting user keys. If 
you want Secure Boot turned on, you don't want any untrusted code 
running in your kernel. If you're happy with untrusted code in your 
kernel, why are you using Secure Boot?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
