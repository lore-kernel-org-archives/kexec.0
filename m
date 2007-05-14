Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.179])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hne6r-0007Qq-Ii
	for kexec@lists.infradead.org; Mon, 14 May 2007 13:13:24 -0400
Received: by py-out-1112.google.com with SMTP id p76so1830445pyb
	for <kexec@lists.infradead.org>; Mon, 14 May 2007 10:13:20 -0700 (PDT)
Message-ID: <741eae780705141013p5ada9005q289eb44022c3b382@mail.gmail.com>
Date: Mon, 14 May 2007 13:13:19 -0400
From: TuskenTower <tuskentower@gmail.com>
Subject: Re: Does kexec on IA64 work?
In-Reply-To: <20070511220514.GA1625@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1178917927.10349.210.camel@ustr-shaha1-linux2.na.uis.unisys.com>
	<20070511220514.GA1625@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On 5/11/07, Bernhard Walle <bwalle@suse.de> wrote:
> * Amul Shah <amul.shah@unisys.com> [2007-05-11 23:12]:
> > I am using a redhat derived 2.6.18 linux kernel and I am experiencing a
> > panic when the second kernel boots.  I can't find the exact set of
> > emails that I want to tell me that kexec on IA64 isn't ready yet.
>
> Well, it basically works ...
>
> > Horms said this a month ago:
> > https://lists.linux-foundation.org/pipermail/fastboot/2007-March/013286.html
> >         My recommendation is that 2.6.21rc3 is a farily good release for
> >         kexec,
> >         and if you aren't worried about ia64 then 2.6.20 is probably
> >         good too.
> >         If you really need something against 2.6.9, then I guess you
> >         will have
> >         to try to pull the patches out of git, but that is going to be
> >         really hard work given that 2.6.9 is quite old now.
> >
> > For the curious, the panic log is below.  I did a cursory inspection of
> > the kernel sources and found that the function start_secondary is called
> > from head.S.  I don't know much about IA64 arch and assembly, so I
> > thought I would ask first if the IA64 implementation works.
>
> Did you try the 'maxpus=1' option for the panic kernel?
>
>
> Thanks,
>    Bernhard

I'll give the maxcpus option a try.  However, I used a kexec since the
kdump failed and the people testing the functionality weren't sure
what else to do.

thanks,
Amul (yes the same as the thread initiator)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
