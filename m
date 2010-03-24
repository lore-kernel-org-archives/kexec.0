Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NuOnU-0006pm-OV
	for kexec@lists.infradead.org; Wed, 24 Mar 2010 11:30:57 +0000
Date: Wed, 24 Mar 2010 22:30:10 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/6] kexec-tools: Use default rpmbuild definations
Message-ID: <20100324113009.GH10098@verge.net.au>
References: <cover.1268942234.git.ameya.palande@nokia.com>
	<cover.1268942234.git.ameya.palande@nokia.com>
	<fd9d828f07e6cb070f73872d4427c865e52c5127.1268942234.git.ameya.palande@nokia.com>
	<m1634s9hep.fsf@fess.ebiederm.org> <4BA498D5.8020803@bwalle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BA498D5.8020803@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: kexec@lists.infradead.org

On Sat, Mar 20, 2010 at 10:43:49AM +0100, Bernhard Walle wrote:
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
> 
> It works here on openSUSE 11.1 when I change
> 
> -RPMDIR=rpm
> +RPMDIR=$(shell pwd)/rpm
> 
> Of course only after applying the other patches...

That seems reasonable to me, care to make it a proper patch?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
