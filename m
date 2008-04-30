Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jr01A-0005rf-Ov
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 00:17:53 +0000
Date: Tue, 29 Apr 2008 20:17:38 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec/ kdump setup problem
Message-ID: <20080430001738.GA28606@hmsendeavour.rdu.redhat.com>
References: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
	<481702DA.3000009@in.ibm.com>
	<c62583fb0804291540o25e4b865j35c4e9b87aa016ea@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c62583fb0804291540o25e4b865j35c4e9b87aa016ea@mail.gmail.com>
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
To: Mrunal Gawade <mrunal.gawade@gmail.com>
Cc: kexec@lists.infradead.org, "Sachin P. Sant" <sachinp@in.ibm.com>

On Tue, Apr 29, 2008 at 03:40:13PM -0700, Mrunal Gawade wrote:
> Thanks Sachin.
> 
> The value over there is a "0" which means I have a failure. How do I
> diagnose what is the problem? I was able to load a normal kernel and then
> use "e" option to reboot into it. But crash dump kernel seemed to be giving
> problem always.
> 
> 
> Thank you,
> Mrunal
> 

check /var/log/messages, to see if there is any message there.  It wouldn't hurt
to enable debugging in the kexec binary either, although if the load is actually
failing, I would think you would get something on stderr.  First guess would be
that you don't have a crashkernel area specified on your command line (or you
do, and its reservation failed, which also will show up in the logs most likely)

Neil

> On Tue, Apr 29, 2008 at 4:13 AM, Sachin P. Sant <sachinp@in.ibm.com> wrote:
> 
> > Mrunal Gawade wrote:
> >
> > > After I execute this command. Should I expect any prompt that kernel
> > > loaded successfully?
> > >
> > Check the /sys/kernel/kexec_crash_loaded file. Value "1" means success.
> >
> > Thanks
> > -Sachin
> >
> >

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
