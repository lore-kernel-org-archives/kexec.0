Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXu0t-00024r-Rm
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 08:34:56 +0000
Date: Tue, 26 Aug 2008 10:34:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [PATCH] Move $(LIBS) on the end
Message-ID: <20080826103454.51b80a7f@halley.suse.de>
In-Reply-To: <86802c440808260121i62ec7c17m8ffd7c0a0822da35@mail.gmail.com>
References: <669d49e549978c2cd9bb.1219738609@halley.suse.de>
	<86802c440808260121i62ec7c17m8ffd7c0a0822da35@mail.gmail.com>
Mime-Version: 1.0
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: kexec@lists.infradead.org

* Yinghai Lu [2008-08-26 01:21]:
>
> On Tue, Aug 26, 2008 at 1:16 AM, Bernhard Walle <bwalle@suse.de> wrote:
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> > kexec/Makefile |    3 +--
> >
> >
> > To make static compilation work with
> >
> >    LDFLAGS=-static ./configure
> >    make
> 
> thanks. can you put that two lines into INSTALL.

Adding is not possible since there is no such file. However, I hacked a
small INSTALL file now, I hope that's ok, see the next patch mail.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
