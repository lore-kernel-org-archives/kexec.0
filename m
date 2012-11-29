Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdzZC-0001zj-Rv
 for kexec@lists.infradead.org; Thu, 29 Nov 2012 08:33:57 +0000
Date: Thu, 29 Nov 2012 17:32:50 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [ANNOUNCE] makedumpfile: Postpone the release of 1.5.1
Message-Id: <20121129173250.d30ea1c1e828a4d65479301b@mxc.nes.nec.co.jp>
In-Reply-To: <20121127.213234.2280049296541396535.d.hatayama@gmail.com>
References: <20121127193727.fbb54d248b75b5106570bdef@mxc.nes.nec.co.jp>
 <20121127.213234.2280049296541396535.d.hatayama@gmail.com>
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
To: d.hatayama@gmail.com
Cc: kexec@lists.infradead.org

Hello,

On Tue, 27 Nov 2012 21:32:34 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: [ANNOUNCE] makedumpfile: Postpone the release of 1.5.1
> Date: Tue, 27 Nov 2012 19:37:27 +0900
> 
> > Hello,
> > 
> >> If there is no problem, I will release v1.5.1 GA on Nov 28.
> > 
> > I did regression test for v1.5.1 in the last weekend and found some bugs.
> > So the release date will be delayed by few weeks, sorry.
> > 
> > However, I don't think there are big issues for almost all users, because:
> >  
> >   - #1 doesn't happen unless users specify -x option, and it's unnecessary
> >     for these kernels.
> 
> I don't think so. pageflags was rewriten as enumeration on v2.6.26. So
> debuginfo of the related kernels contains correct PG_buddy value. If
> passing vmlinux with -x option, makedumpfile should work well. I think
> problematic case happens only through vmcoreinfo with -i option.

Sorry, it was my misunderstanding. You are right.

> 
> >   - As for #2, I think there are few users.
> > 
> > So, I think v1.5.1-rc is enough for almost all users.
> > 
> > 
> > BUGS:
> > 
> >   #1. Fail to exclude free pages with page_is_buddy_v2() in some cases.
> >       I mentioned this issue in the post below:
> > 
> >         http://lists.infradead.org/pipermail/kexec/2012-November/007404.html
> > 
> >       Related kernel: v2.6.27 to v2.6.37
> 
> This is a bit wrong. Correct one is: v2.6.30 to v2.6.37.

I wrote there versions as the version which has the possibility of this
issue happening. In other words, the version which uses CONFIG_PAGEFLAGS_EXTENDED.
So, "v2.6.27 to v2.6.37" was my mistake after all.

Anyway, correct one is: v2.6.26 to v2.6.37.

I'll avoid this issue by remove hard-corded values for PG_buddy.

> 
> > 
> >   #2. Fail to exclude free pages with page_is_buddy_v1() in some cases.
> >       I'm investigating this issue now.
> > 
> >       Related kernel: v2.6.15 to v2.6.17
> 
> As I noted in its patch description, I have yet to test on these
> kernel versions. Thanks for your testing.

I think the release of v1.5.1 shouldn't be delayed with this issue because
as you said below.
So, I'll just revert "[PATCH v2 09/10] Add page_is_buddy for old kernels"
to avoid this issue. This means that we always use free_list logic for
v2.6.15 to v2.6.17.

> But I don't have enough reason to support these kernels now. These
> kernels themselves have bug on handling buddy pages, so PG_buddy was
> introduced during v2.6.18-rc to fix the bug. Even if there is
> distribution based on these kerenel versions, some kind of fixing
> patch introducing PG_buddy would be backported and that must be. In
> particular, I don't think machine with huge memory uses such buggy
> kernels.
> 
> Thanks.
> HATAYAMA, Daisuke

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
