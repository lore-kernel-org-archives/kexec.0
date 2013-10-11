Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUZhj-0002w5-It
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 10:12:21 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl> (Daniel
 Kiper's message of "Fri, 11 Oct 2013 11:28:37 +0200")
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
Date: Fri, 11 Oct 2013 03:08:43 -0700
Message-ID: <877gdkce6s.fsf@tw-ebiederman.twitter.com>
MIME-Version: 1.0
Subject: Re: kexec: Clearing registers just before jumping into purgatory
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, hbabu@us.ibm.com, david.vrabel@citrix.com, jbeulich@suse.com, hpa@linux.intel.com, vgoyal@redhat.com

Daniel Kiper <daniel.kiper@oracle.com> writes:

> Hi,
>
> Could you explain why do you clear all registers just before jumping
> into purgatory (please look into arch/x86/kernel/relocate_kernel_64.S
> for more details)? There is no any single word about that. I do not
> count comment which states what is going on. purgatory on entry does
> not assume any value in registers. Are you going to use that feature
> for something in the future (e.g. to differentiate between callers
> and/or Linux versions if it be needed)?

It has been a long time now, but as I recall the reason was to just
have things well defined and to make certain that we were not
accidentially exporting anything except the stack pointer for
applications to depend upon.

0/NULL is a good choice because if you are expecting pointer for some
strange reason interesting things happen.

purgatory is definitely not the only target and the C version of
purgatory was actually written well after kexec came into existence.

Is there any particular reason why you are asking?

> By the way, interestingly it is not done if preserve_context is in
> force.

Something different is done, and all of the registers should be
preserved from the when the return to Linux.

In theory you can swap between to kernels with the preserve_context
case.  Technically I like the ability but I don't know that it has ever
achieved much uptake.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
