Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R8nq4-0001VQ-0B
	for kexec@lists.infradead.org; Wed, 28 Sep 2011 06:41:53 +0000
Date: Wed, 28 Sep 2011 15:26:44 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: rhel5.6 kdump initrd problem?
Message-Id: <20110928152644.979fc6b0.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E822623.4000906@sgi.com>
References: <4E821824.7090900@sgi.com>
	<4E822623.4000906@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org


Hi Jay,

On Tue, 27 Sep 2011 12:38:11 -0700
Jay Lan <jlan@sgi.com> wrote:
> >
> > I have a system running 2.6.18-238.12.1.el5 kernel.
> > The kexec version is kexec-tools-1.102pre-126.el5_6.6.
> >
> > The kernel was booted OK. Then it ran /etc/init.d/kdump
> > and a new kdump initrd image was created.
> > A kernel crash was triggered. The kdump kernel was booted
> > alright. However, it failed to boot when it tried to boot
> > back the regular kernel (now with the kdump initrd image
> > specified in the menu.lst.)
> 
> I forgot to mention the failure message:
> ...
> Saving to the local filesystem LABEL=xxxroot
> findfs: Unable to resolve 'LABEL=xxxroot'

If specifying a dev name (ex. /dev/sda3) instead of "LABEL"
in /etc/kdump.conf, what happens ?
findfs command doesn't run in the kdump initrd if specifying
a dev name.

In addition, can you try `findfs LABEL=xxxroot` while the regular
kernel runs ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
