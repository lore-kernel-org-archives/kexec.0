Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kua0s-00028s-6U
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 21:52:38 +0000
Date: Mon, 27 Oct 2008 22:52:33 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [WATCHDOG] Fix kdump when using hpwdt
Message-ID: <20081027225233.34758cda@kopernikus.site>
In-Reply-To: <20081027193053.GA2659@infomag.infomag.iguana.be>
References: <1225033177-5311-1-git-send-email-bwalle@suse.de>
	<20081027193053.GA2659@infomag.infomag.iguana.be>
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
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Thomas Mingarelli <thomas.mingarelli@hp.com>

Hi Wim,

* Wim Van Sebroeck [2008-10-27 20:30]:

> > -module_param(allow_kdump, int, 0);
> > +module_param(allow_kdump, int, 1);
> >  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
> 
> the syntax is: #define module_param(name, type, perm)
> perm sets the visibility in sysfs: 000 means it's not there,
> read bits mean it's readable, write bits mean it's writable.
> 
> perm is not the default value for the integer but a file permission attribute.

Yeah, thanks for spotting that. I was a bit in hurry while creating the
patch ...

I'll come up with an updated patch with the suggestions from Vivek.
Probably tomorrow.


Regards,
Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
