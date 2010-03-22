Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NtdSR-00072G-56
	for kexec@lists.infradead.org; Mon, 22 Mar 2010 08:58:03 +0000
Subject: Re: [PATCH 6/6] kexec-tools: Use default rpmbuild definations
From: Ameya Palande <ameya.palande@nokia.com>
In-Reply-To: <4BA498D5.8020803@bwalle.de>
References: <cover.1268942234.git.ameya.palande@nokia.com>
	<cover.1268942234.git.ameya.palande@nokia.com>
	<fd9d828f07e6cb070f73872d4427c865e52c5127.1268942234.git.ameya.palande@nokia.com>
	<m1634s9hep.fsf@fess.ebiederm.org>  <4BA498D5.8020803@bwalle.de>
Date: Mon, 22 Mar 2010 10:56:31 +0200
Message-ID: <1269248191.2119.2.camel@sanganak>
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
To: ext Bernhard Walle <bernhard@bwalle.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sat, 2010-03-20 at 10:43 +0100, ext Bernhard Walle wrote:
> Am 19.03.2010 21:37, schrieb Eric W. Biederman:
> > Ameya Palande <2ameya@gmail.com> writes:
> > 
> >> Since current mechanism for building rpm into custom directory is not working,
> >> remove it and switch to system defaults for rpmbuild.
> > 
> > Does RPM really bit rot that quickly?
> > 
> > I know at the time I added the code it was the only way I could
> > get rpm to build an rpm without being root.  Something that seems
> > desirable.

I can build rpm on ubuntu 9.10 as a normal user without having this
custom "rpm" directory.

> It works here on openSUSE 11.1 when I change
> 
> -RPMDIR=rpm
> +RPMDIR=$(shell pwd)/rpm

On Ubuntu 9.10 when I removed RPMDIR stuff, rpmbuild command takes
system defaults and builds rpm in $HOME/rpmbuild directory.

Cheers,
Ameya.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
