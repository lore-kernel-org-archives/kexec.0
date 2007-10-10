Return-path: <kexec-bounces@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.184])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IfTf2-0002E4-FL
	for kexec@lists.infradead.org; Wed, 10 Oct 2007 05:59:10 +0100
Received: by rv-out-0910.google.com with SMTP id c24so88804rvf
	for <kexec@lists.infradead.org>; Tue, 09 Oct 2007 21:58:47 -0700 (PDT)
Message-ID: <2ea3fae10710092158l72241a04w28e1207dc26c3ed1@mail.gmail.com>
Date: Tue, 9 Oct 2007 21:58:46 -0700
From: yhlu <yinghailu@gmail.com>
Subject: Re: using bios after linux
In-Reply-To: <20071001064309.GC4933@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <5bf40e35adf3a20c89b5976850af992a@sundius.com>
	<20071001064309.GC4933@in.ibm.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: C Michael Sundius <msundius@sundius.com>, kexec@lists.infradead.org

On 9/30/07, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, Sep 27, 2007 at 06:57:30AM -0700, C Michael Sundius wrote:
> >
> > Hi,
> >
> >   I've been working on a project where we are using linux as an
> > operating environment for some
> >   setup work prior to booting windows. our control flow looks like this
> >
> >   reset => (1)linux & linux aplication =>
> >   (2)kexec => (3)proprietery 16bit real code (uses bios) =>
> >   (4)ntloader => (5)Windows
> >
>
> Interesting. Just curious to know that how above setup is useful?

is it possible to use some emulator under linux and at some point to
exit the emulator and jump the entry..

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
