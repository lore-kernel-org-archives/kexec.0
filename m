Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYHEW-0006BG-Qx
 for kexec@lists.infradead.org; Mon, 21 Oct 2013 15:17:30 +0000
Date: Mon, 21 Oct 2013 11:16:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131021151643.GA20669@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
 <20131018123837.GB2277@redhat.com>
 <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, WANG Chao <chaowang@redhat.com>

On Fri, Oct 18, 2013 at 10:45:43PM -0700, Yinghai Lu wrote:

[..]
> > A user does not care if they get the message "memory nor reserved" or if
> > they get the message that "could not find a suitable memory hole at
> > address X".
> 
> you are asking for trouble.
> 
> Now we have two paths:
> 1. old kernel with old kexec tools. crashkernel=XM, work,
> the new kernel with old kexec tools still working with crashkernel=XM
> 2. old kernel with old kernel tools, crashkernel=XM, not working.
> as X is too big.
> then user update to new kernel AND new kexec-tools, and crashkernel=XM,high
> 
> with this patch, you will need to test new kernel all old kexec tools
> to make sure
> it will fail later instead of fail early to remind them to update kexec tools.
> Also would make user to guess and try to make new kernel to work with old
> kexec-tools

Seriously, I don't understand what are you trying to say above. You will
need to explain your concern more clearly.

IIUC, you are trying to say that with new kernel old kexec-tools will fail
at a different failure point. I don't see why that is a problem. It still
fails. 

[..]
> > You are not thinking about ease of use here for existing users.
> 
> most existing user don't need to do anything. just with new kernel and
> old kexec tools.
> 
> those system that did not work kexec before because XM is too big, they have to
> update kexec tools, and use ",high"
> 
> Make it simple, less error.

No, it is not that simple. Think from a distribution's perspective also.
We have the logic to scale reserved memory based on physical memory
present in the system. Now we are seeing bigger memory systems (which
would not have worked in the past). We still want to retain the existing
logic and not switch to crashkernel=x,high. One does not have to. It
makes life simpler.

Same logic working both with smaller memory systems as well as large memory
systems. One should not have to choose a different command line because
there is more physical RAM present in the system.

> 
> >
> >>
> >> Also boot loader should always have different entry for old kernel and
> >> new kernel.
> >
> > What does memory reservation location has to do with kernel entry point?
> > If it is a 64bit bzImage, we will use 64bit entry point by default, isn't
> > it? Does not matter whether memory is reserved above 4G or not.
> >
> > I think it makes sense that existing crashkernel=XM usres be able to
> > reserve memory in higher memory area if sufficient memory is not available
> > below 896M or below 4G. Those who always want memory reservation above 4G
> > they should use ",high" syntax and enforce memory allocation above 4G.
> 
> We already support above 4G, what is point for trying below 4G?

Because it is not *required* to reserve memory above 4G. Because we want
same command line to work with both small memory systems as well as
large memory systems and we don't care whether memory is reserved below
4G or above 4G. What does matter though that we don't have to worry about
switching command line option if it is large memory system.

> 
> You could get more bug report about new kernel with old kexec-tools, as
> old kexec-tools could work with range between 896M and 4G in some case,
> but not all.

So you are worried that if we lift the artificial cap, and old kexec-tools
start working that will be a problem. I don't think that is an issue.
People worry about something existing broken. It does not break existing
kexec-tools. If in some cases they work with memory reserved at higher
addresses, where is the problem. Even in the past one could do
crashkernel=X@Y and if Y is above 896M and if kexec-tools works with that
what's wrong. I have not seen people complaining about it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
