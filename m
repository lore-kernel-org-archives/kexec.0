Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VX9Kf-0001r2-1e
 for kexec@lists.infradead.org; Fri, 18 Oct 2013 12:39:10 +0000
Date: Fri, 18 Oct 2013 08:38:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131018123837.GB2277@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
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

On Thu, Oct 17, 2013 at 08:50:07PM -0700, Yinghai Lu wrote:

[..]
> > Previously high reservation (reservation above 896M) will anyway fail. So
> > instead of failing, if we try reservation in higher memory areas why that
> > would break old kexec-tools?
> 
> If thel old kexec-tools would fail, we should let them fail early as possible,
> do not reserve at first point.

A user does not care if they get the message "memory nor reserved" or if
they get the message that "could not find a suitable memory hole at
address X".

> 
> >
> > IOW, previously anyway kexec-tools will not work as no memory will be
> > reserved in higher memory area. Now memory will be reserved but old
> > kexec-tools should fail as it can't load in that area.
> >
> > If that works, then one would use crashkernel=X,high only if he is
> > particualr that memory reservation comes from area above 4G (despite
> > the fact that same memory could have been reserved below 4G too).
> 
> My point:
> Push user to use ",high" as more as possible, so we only to handle one
> path eventually.
> for old kernel, leave them to use old grammer. do not need to change it.

I don't understand this. Why we should push users to use ",high" syntax.
That is an option. Those who want to use it, should use it.

We have been using crashkernel=XM for a long time now. And it makes sense
to extend this option to be able to reserve memory at higher addresses
if asked memory is not available at lower addresses.

You are not thinking about ease of use here for existing users.

> 
> Also boot loader should always have different entry for old kernel and
> new kernel.

What does memory reservation location has to do with kernel entry point?
If it is a 64bit bzImage, we will use 64bit entry point by default, isn't
it? Does not matter whether memory is reserved above 4G or not.

I think it makes sense that existing crashkernel=XM usres be able to
reserve memory in higher memory area if sufficient memory is not available
below 896M or below 4G. Those who always want memory reservation above 4G
they should use ",high" syntax and enforce memory allocation above 4G.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
