Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TVSbj-00049n-1y
 for kexec@lists.infradead.org; Mon, 05 Nov 2012 19:45:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com>
 <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com> <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com> <87boffd727.fsf@xmission.com>
 <20121105180353.GC28720@redhat.com>
Date: Mon, 05 Nov 2012 11:44:48 -0800
In-Reply-To: <20121105180353.GC28720@redhat.com> (Vivek Goyal's message of
 "Mon, 5 Nov 2012 13:03:53 -0500")
Message-ID: <87mwyv96mn.fsf@xmission.com>
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

> On Fri, Nov 02, 2012 at 02:32:48PM -0700, Eric W. Biederman wrote:
>> 
>> It needs to be checked but /sbin/kexec should not use any functions that
>> trigger nss switch.  No user or password or host name lookup should be
>> happening.
>
> I also think that we don't call routines which trigger nss switch but
> be probably can't rely on that as somebody might introduce it in
> future. So we need more robust mechanism to prevent it than just code
> inspection.

The fact that we shouldn't use those routines is enough to let us
walk down a path where they are not used.  Either with a static glibc
linked told to use no nss modules (--enable-static-nss ?), or with
another more restricted libc.

>> This is one part in hardening /sbin/kexec to deal with hostile root
>> users.  We need to check crazy things like do the files we open on /proc
>> actually point to /proc after we have opened them.
>
> Can you please explain it more. How can one fiddle with /proc. Also
> what's the solution then.

The solution is to just fstat the files and verify the filesystem from
which they came after the files have been opened.

The issue is that an evil root user may have mounted something else on /proc.

>> I believe glibc has some code which triggers for suid root applications
>> that we should ensure gets triggered that avoid trusting things like
>> LD_LIBRARY_PATH and company.
>
> I guess linking statically with uClibc or klibc (as hpa said), might turn
> out to be better option to avoid all the issues w.r.t shared objects
> and all the tricky environment variables.

Linking with a more restricted libc will solve most if not all shared
object issues.

We still need to audit our environment variable issue.  How we interpret
them and how our restricted libc automatically interprets them.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
