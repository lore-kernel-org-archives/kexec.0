Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRadI-0004qa-TL
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 03:30:54 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <871ugqb4gj.fsf@xmission.com> <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com>
 <20121024173651.GE1821@redhat.com> <1351145401.18115.78.camel@falcor>
 <20121025141048.GD9377@redhat.com> <1351190421.18115.92.camel@falcor>
 <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org>
Date: Thu, 25 Oct 2012 20:30:37 -0700
In-Reply-To: <20121026023916.GA16762@srcf.ucam.org> (Matthew Garrett's message
 of "Fri, 26 Oct 2012 03:39:16 +0100")
Message-ID: <87625xq59e.fsf@xmission.com>
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
To: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@polito.it>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

Matthew Garrett <mjg@redhat.com> writes:

> On Thu, Oct 25, 2012 at 09:15:58PM -0400, Mimi Zohar wrote:
>
>> On a running system, the package installer, after verifying the package
>> integrity, would install each file with the associated 'security.ima'
>> extended attribute.  The 'security.evm' digital signature would be
>> installed with an HMAC, calculated using a system unique key. 
>
> The idea isn't to prevent /sbin/kexec from being modified after 
> installation - it's to prevent it from being possible to install a 
> system that has a modified /sbin/kexec. Leaving any part of this up to 
> the package installer means that it doesn't solve the problem we're 
> trying to solve here. It must be impossible for the kernel to launch any 
> /sbin/kexec that hasn't been signed by a trusted key that's been built 
> into the kernel, and it must be impossible for anything other than 
> /sbin/kexec to make the kexec system call.

The 'security.capability' attribute modulo weirdness with the security
bounding set gives us the necessary tools to allow /sbin/kexec to make
the system call.

The primary trick with this is to limit the installer in such as way
that we can trust the installer even on a system on which root has been
compromised.

Trusting the installer is the same class of problem as trusting
/sbin/kexec, and to me a much more interesting problem as it keeps
critical system files from being tampered with.

It sounds like there are some tricky details to work through but this
direction of system integrity looks like it is worth pursuing,
regardless of how we handle a signed /sbin/kexec.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
