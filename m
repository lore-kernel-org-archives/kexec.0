Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0NmK-0006N4-Rp
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 01:15:13 +0000
Received: by yxk8 with SMTP id 8so2150785yxk.36
	for <kexec@lists.infradead.org>; Sun, 04 Sep 2011 18:15:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110905085627.149add04.oomichi@mxs.nes.nec.co.jp>
References: <1315152159-15362-1-git-send-email-leiwen@marvell.com>
	<20110905085627.149add04.oomichi@mxs.nes.nec.co.jp>
Date: Mon, 5 Sep 2011 09:15:04 +0800
Message-ID: <CALZhoSQyzXtG6CPQmAjRRcCc1mwhiJts5bvMB1KGZFdwN4xUvw@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile: omit those section has 0 size
From: Lei Wen <adrian.wenl@gmail.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Lei Wen <leiwen@marvell.com>, kexec@lists.infradead.org

Hi Ken'ichi,

On Mon, Sep 5, 2011 at 7:56 AM, Ken'ichi Ohmichi
<oomichi@mxs.nes.nec.co.jp> wrote:
>
> Hi Lei,
>
> Thank you for the patch.
>
> The almost same patch has been merged into the devel git-tree,
> does the following patch fix the prblem you said ?
>
> http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=commit;h=63f720a7784debce82c8942970d5c0d8412f209f
>

Yes, that fix my issue.

Thanks,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
