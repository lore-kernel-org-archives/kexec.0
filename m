Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TUOre-0008Qp-3D
 for kexec@lists.infradead.org; Fri, 02 Nov 2012 21:33:21 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com>
 <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com> <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com>
Date: Fri, 02 Nov 2012 14:32:48 -0700
In-Reply-To: <20121102132318.GA3300@redhat.com> (Vivek Goyal's message of
 "Fri, 2 Nov 2012 09:23:19 -0400")
Message-ID: <87boffd727.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kdump with signed images
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
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Nov 01, 2012 at 02:52:25PM +0000, Matthew Garrett wrote:
>> On Thu, Nov 01, 2012 at 10:43:04AM -0400, Vivek Goyal wrote:
>> 
>> > So I think this does satisfy the requirement matthew specified. Isn't it?
>> > Matthew, what do you think?
>> 
>> Sure, if you can ensure that. You'll need to figure out how to get the 
>> build system to sign the userspace binaries and you'll need to ensure 
>> that they're statically linked and don't dlopen anything (including the 
>> nsswitch modules), but otherwise that should work.
>> 
>
> [ CC peter jones ]
>
> Ok, so even if we build kexec-tools statically with glibc, we have the
> issue of name service switch modules. glibc will still do dlopen on
> these modules. So what are options now.
>
> - Sign glibc and associated shared libraries. Do not allow unsigned
>   shared library to dynamically link with signed executable.
>
> - Peter mentioned that work with uClibc for kexec-tools.
>
> I personally think that however hard it is but first option sounds like
> a long term solution. We might have more user space processes which
> we might have to trust a generic solution will help with that. For example,
> we might have to sign and trust qemu at some point of time.
>
> Are there other ways of handing glibc issue?

It needs to be checked but /sbin/kexec should not use any functions that
trigger nss switch.  No user or password or host name lookup should be
happening.

This is one part in hardening /sbin/kexec to deal with hostile root
users.  We need to check crazy things like do the files we open on /proc
actually point to /proc after we have opened them.

I believe glibc has some code which triggers for suid root applications
that we should ensure gets triggered that avoid trusting things like
LD_LIBRARY_PATH and company.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
