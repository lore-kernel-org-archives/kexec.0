Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0SId-00080b-PI
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 06:04:52 +0000
Date: Mon, 5 Sep 2011 14:35:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: omit those section has 0 size
Message-Id: <20110905143518.f6543987.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <CALZhoSQyzXtG6CPQmAjRRcCc1mwhiJts5bvMB1KGZFdwN4xUvw@mail.gmail.com>
References: <1315152159-15362-1-git-send-email-leiwen@marvell.com>
	<20110905085627.149add04.oomichi@mxs.nes.nec.co.jp>
	<CALZhoSQyzXtG6CPQmAjRRcCc1mwhiJts5bvMB1KGZFdwN4xUvw@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <adrian.wenl@gmail.com>
Cc: Lei Wen <leiwen@marvell.com>, kexec@lists.infradead.org


On Mon, 5 Sep 2011 09:15:04 +0800
Lei Wen <adrian.wenl@gmail.com> wrote:
> >
> > The almost same patch has been merged into the devel git-tree,
> > does the following patch fix the prblem you said ?
> >
> > http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=commit;h=63f720a7784debce82c8942970d5c0d8412f209f
> >
> 
> Yes, that fix my issue.

Thank you for the check. I see.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
