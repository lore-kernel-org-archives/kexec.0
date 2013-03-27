Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpYl-0005mw-JO
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:34:32 +0000
Date: Wed, 27 Mar 2013 21:34:28 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.4
Message-ID: <20130327123428.GM17248@verge.net.au>
References: <20130319021145.GA4372@verge.net.au> <514AB343.40708@redhat.com>
 <20130321085141.GA30650@verge.net.au> <514ACB52.1090800@redhat.com>
 <514ACCB9.4060206@redhat.com> <514ADA3D.6070702@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <514ADA3D.6070702@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Baoquan <bhe@redhat.com>

On Thu, Mar 21, 2013 at 06:00:29PM +0800, Dave Young wrote:
> On 03/21/2013 05:02 PM, Baoquan wrote:
> > On 03/21/2013 04:56 PM, Baoquan wrote:
> > 
> >> On 03/21/2013 04:51 PM, Simon Horman wrote:
> >>
> >>> On Thu, Mar 21, 2013 at 03:14:11PM +0800, Baoquan wrote:
> >>>> Hi Simon,
> >>>>
> >>>> After "git pull", I didn't find release 2.0.4. Could you please double
> >>>> check it?
> >>>
> >>> Please try v2.0.4, it is a tag in git.
> >>
> >>
> > 
> > 
> > Hi,
> > 
> > Sorry, I just create a new dir and "git clone", v2.0.4 can be seen now.
> > But in my old clone, "git pull" can't get v2.0.4. It's a little weird.
> 
> Looks like the commit is not in master branch, the tag v2.0.4 itself is ok.
> 
> git log --oneline
> 
> b2dc426 s390: Replace clgfi with cghi
> 56af4f5 kexec: use _ALIGN* to make the logic clear
> 337d4fc kexec: ppc64: use _ALIGN* to make the logic clear
> bb3f9f5 kexec: ppc: use _ALIGN* to make the logic clear
> f36d320 kexec: x86_64: use _ALIGN* to make the logic clear
> 58a22bd kexec: sh: use _ALIGN* to make the logic clear
> 333f487 kexec: s390: remove ALIGN_UP and use _ALIGN_UP
> d41a4db kexec: mips: use _ALIGN* to make the logic clear
> e8a7f63 kexec: ia64: use _ALIGN* to make the logic clear
> cf190f6 kexec: arm: use _ALIGN* to make the logic clear
> 8388bdc kexec: i386: use _ALIGN* to make the logic clear
> 0c1b89d kexec: ppc: remove duplicated _ALIGN_* macros
> 412561a kexec: use _ALIGN() instead of align()
> 9ea6e05 kexec: add _ALIGN* marcos for align operation
> 5db7ba5 kexec: check size before trying the malloc
> ...

Strange. I have pushed again.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
