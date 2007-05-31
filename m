Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HtgUH-0006SC-1p
	for kexec@lists.infradead.org; Thu, 31 May 2007 04:58:31 -0400
Date: Thu, 31 May 2007 10:57:57 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [makedumpfile] config file -- OSRELEASE
Message-ID: <20070531085757.GA2585@suse.de>
References: <20070529193058.GA4229@suse.de>
	<20070530201328oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070530201328oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: jlan@sgi.com, kexec@lists.infradead.org

Hello,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-30 13:13]:
> 2007/05/29 21:30:58 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> >is there any reason why the kernel version saved in the configuration
> >file is the version of the running kernel and not the version for
> >which the config file is for?
> =

> The reason is that makedumpfile gets a running kernel's page_size as
> a 1st-kernel's page_size. If they are different, makedumpfile cannot
> analyze /proc/vmcore and it fails. So I think a configuration file
> should be created while 1st-kernel is running.

I also didn't find a possibility to get the page size from a kernel
image without running the executable.

> >It's a big problem because my plan was to ship the configuration files
> >with the kernel RPMs in SLES. However, we don't build the kernels on
> >systems which run the kernel that is just built -- so that's not
> >possible.
> =

> It is a good idea to ship the configuration files with the kernel RPMs. =

> I think you can do it with current implementation, because you need
> only one configuration file for one kernel image.
> =

> I think you can ship configuration files as follows:
> =

> 1. Build a kernel file and a debuginfo file.
> 2. Boot the system with the above kernel file.
> 3. Generate a configration file from a debuginfo file.
> 4. Ship the configration file with the kernel RPM.
> =

> Any problem to follow the method above ?

No, that's not possible because it would change our whole build
process. However, I just replace the OSRELEASE now after generating
the config file with the kernel that's built and change the page size
according to the .config on IA64. That works for now. I know it's not
the best solution, but the only practicable for now.


Thanks,
   Bernhard
-- =

SUSE LINUX Products GmbH          Tel. +49 (911) 74053-0
Maxfeldstr. 5                     GF: Markus Rex
90409 N=FCrnberg, Germany           HRB 16746 (AG N=FCrnberg)
OpenPGP DDAF6454: F61F 34CC 09CA FB82 C9F6  BA4B 8865 3696 DDAF 6454

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
