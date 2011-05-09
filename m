Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJSew-0003dI-Uo
	for kexec@lists.infradead.org; Mon, 09 May 2011 15:46:11 +0000
Date: Mon, 9 May 2011 11:46:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Message-ID: <20110509154606.GE5975@redhat.com>
References: <20110506165412.GB2719@in.ibm.com>
	<20110509123902.GA5975@redhat.com> <4DC80662.9000703@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DC80662.9000703@canonical.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Bouchard Louis <louis.bouchard@canonical.com>
Cc: prasad@linux.vnet.ibm.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, May 09, 2011 at 05:21:06PM +0200, Bouchard Louis wrote:
> Hello,
> =

> Le 09/05/2011 14:39, Vivek Goyal a =E9crit :
> >
> > Prasad,
> >
> > I have never tried taking dump in MCE situation. Does kdump work on this
> > machine with normal panic()?
> >
> > Use --debug and --serial option in kexec-tools to print some debug mess=
age
> > and look for "I am in purgatory". This will tell you whether you hanged
> > in first kernel or second kernel.
> >
> > Then put "outb()" messages in the kernel to trace what happened. =

> >
> > Thanks
> > Vivek
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> I have seen numerous occurrences of MCE triggered kernel panics on both
> RHEL & SLES environment used on IA32 architecture. Both in contexts
> where kexec/kdump was being used.
> =

>  Matter of fact, MCE triggered panic are part of the reason that pushed
> me to work on crashdc : only one crash command is required to get the
> MCE trace out of the kernel ring buffer. This avoids transfering massive
> amount of vmcore file over the net.
> =

> crashdc does well on those, mcelog can be applied on the data gathered.
> =


Louis, is this "crashdc" an independent executable. Where is it packaged?
What is the significance of name "crashdc" (Crash data collecor ?) Will it
make sense to merge it with makedumpfile which does kernel filtering
already and this could be one of the additional features.

Thanks
Vivek

> HTH,
> =

> ...Louis
> =

> -- =

> Louis Bouchard
> Server Support Analyst
> Canonical Ltd
> Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
