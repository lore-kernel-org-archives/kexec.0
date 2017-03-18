Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpJ1C-0003kW-4O
 for kexec@lists.infradead.org; Sat, 18 Mar 2017 18:24:00 +0000
Date: Sat, 18 Mar 2017 19:23:28 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] kexec: Update vmcoreinfo after crash happened
Message-ID: <20170318192328.31dc1fde@hananiah.suse.cz>
In-Reply-To: <58CA95EA.1040807@redhat.com>
References: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
 <20170316122730.GB23625@x1> <58CA86D2.70800@redhat.com>
 <20170316131809.GC23625@x1> <58CA95EA.1040807@redhat.com>
MIME-Version: 1.0
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
To: Xunlei Pang <xpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Thu, 16 Mar 2017 21:40:58 +0800
Xunlei Pang <xpang@redhat.com> wrote:

> On 03/16/2017 at 09:18 PM, Baoquan He wrote:
> > On 03/16/17 at 08:36pm, Xunlei Pang wrote:
> >> On 03/16/2017 at 08:27 PM, Baoquan He wrote:
> >>> Hi Xunlei,
> >>>
> >>> Did you really see this ever happened? Because the vmcore size estimate
> >>> feature, namely --mem-usage option of makedumpfile, depends on the
> >>> vmcoreinfo in 1st kernel, your change will break it.
> >> Hi Baoquan,
> >>
> >> I can reproduce it using a kernel module which modifies the vmcoreinfo,
> >> so it's a problem can actually happen.
> >>
> >>> If not, it could be not good to change that.
> >> That's a good point, then I guess we can keep the crash_save_vmcoreinfo_init(),
> >> and store again all the vmcoreinfo after crash. What do you think?
> > Well, then it will make makedumpfile segfault happen too when execute
> > below command in 1st kernel if it existed:
> > 	makedumpfile --mem-usage /proc/kcore
> 
> Yes, if the initial vmcoreinfo data was modified before "makedumpfile --mem-usage", it might happen,
> after all the system is going something wrong. And that's why we deploy kdump service at the very
> beginning when the system has a low possibility of going wrong.
> 
> But we have to guarantee kdump vmcore can be generated correctly as possible as it can.
> 
> >
> > So we still need to face that problem and need fix it. vmcoreinfo_note
> > is in kernel data area, how does module intrude into this area? And can
> > we fix the module code?
> >
> 
> Bugs always exist in products, we can't know what will happen and fix all the errors,
> that's why we need kdump.
> 
> I think the following update should guarantee the correct vmcoreinfo for kdump.

I'm still not convinced. I would probably have more trust in a clean
kernel (after boot) than a kernel that has already crashed (presumably
because of a serious bug). How can be reliability improved by running
more code in unsafe environment?

If some code overwrites reserved areas (such as vmcoreinfo), then it's
seriously buggy. And in my opinion, it is more difficult to identify
such bugs if they are masked by re-initializing vmcoreinfo after crash.
In fact, if makedumpfile in the kexec'ed kernel complains that it
didn't find valid VMCOREINFO content, that's already a hint.

As a side note, if you're debugging a vmcoreinfo corruption, it's
possible to use a standalone VMCOREINFO file with makedumpfile, so you
can pre-generate it and save it in the kdump initrd.

In short, I don't see a compelling case for this change.

Just my two cents,
Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
