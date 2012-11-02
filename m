Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta01.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:16])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TUKZA-0005DN-0z
 for kexec@lists.infradead.org; Fri, 02 Nov 2012 16:57:56 +0000
Message-ID: <1351875469.25914.51.camel@rhapsody>
Subject: Re: Kdump with signed images
From: Khalid Aziz <khalid@gonehiking.org>
Date: Fri, 02 Nov 2012 10:57:49 -0600
In-Reply-To: <20121101162315.GA13132@srcf.ucam.org>
References: <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org> <20121026170609.GB24687@redhat.com>
 <1351276649.18115.217.camel@falcor> <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com> <1351780159.15708.17.camel@falcor>
 <20121101145149.GB15821@redhat.com> <20121101145731.GB10662@srcf.ucam.org>
 <1351782656.3782.58.camel@rhapsody> <20121101162315.GA13132@srcf.ucam.org>
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
Cc: Roberto Sassu <roberto.sassu@polito.it>, Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2012-11-01 at 16:23 +0000, Matthew Garrett wrote:
> On Thu, Nov 01, 2012 at 09:10:56AM -0600, Khalid Aziz wrote:
> > How would a customer go about getting that userspace binary signed and 
> > re-signed every time they update their app? There is the option of 
> > turning the whole SecureBoot thing off for a system like that but let 
> > us assume customer wants to leave that on or does not have the option 
> > to turn it off?
> 
> There's ongoing work for providing mechanisms for trusting user keys. If 
> you want Secure Boot turned on, you don't want any untrusted code 
> running in your kernel. If you're happy with untrusted code in your 
> kernel, why are you using Secure Boot?
> 

I would argue code written by a customer to run on their own systems is
inherently trusted code and does not invalidate need/desire for Secure
Boot. So the customer will still need some way to get their binary
signed very painlessly just so they could use their own binary on their
own system, simply because of a heavily locked down system design by
Linux community.

--
Khalid


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
