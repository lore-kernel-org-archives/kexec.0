Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwpi3-0002nv-L5
	for kexec@lists.infradead.org; Fri, 16 May 2008 02:30:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<m1lk2bs970.fsf@frodo.ebiederm.org>
	<1210902114.23707.156.camel@caritas-dev.intel.com>
Date: Thu, 15 May 2008 19:25:00 -0700
In-Reply-To: <1210902114.23707.156.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Fri, 16 May 2008 09:41:54 +0800")
Message-ID: <m14p8zgf43.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec multi-stage
	load
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

"Huang, Ying" <ying.huang@intel.com> writes:

> On Thu, 2008-05-15 at 11:39 -0700, Eric W. Biederman wrote:
> [...]
>> 2) After we figure out our address read the stack pointer from
>>    a fixed location and simply set it.  (This is my preference)
>
> Just for confirmation (My English is poor).
>
> Do you mean that kernel A just read the stack top as re-entry point,
> regardless of whether it is return address or argument 1?

What I was thinking was:

In kernel A()

relocate_new_kernel:

        ...

        call	*%eax

kexec_jump_back_entry:
        /* This code should be PIC so figure out where we are */
        call	1f
1:
        popl	%edi
        subl	$(1b - relocate_kernel), %edi

        /* Setup a safe stack */
        leal    PAGE_SIZE(%edi), %esp
        ...


Then in purgatory we can read the address of kexec_jump_back_entry
by examining 0(%esp) and export it in whatever fashion is sane.

However we reach kexec_jump_back_entry we should be fine.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
