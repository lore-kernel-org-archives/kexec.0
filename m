Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFzcD-0005Sw-0A
 for kexec@lists.infradead.org; Wed, 31 May 2017 09:08:30 +0000
Date: Wed, 31 May 2017 11:07:50 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: makedumpfile PATCH] Fix the use of Xen physical and machine
 addresses
Message-ID: <20170531090750.GA19333@olila.local.net-space.pl>
References: <20170523093452.GQ30364@olila.local.net-space.pl>
 <b1e80585-7a71-b1d1-7d09-f52da8a82b7e@oracle.com>
 <20170530232815.5233981e@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170530232815.5233981e@hananiah.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: ats-kumagai@wm.jp.nec.com, Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Tue, May 30, 2017 at 11:28:15PM +0200, Petr Tesarik wrote:
> On Tue, 30 May 2017 14:30:43 -0500
> Eric DeVolder <eric.devolder@oracle.com> wrote:
>
> > Hi,
> > Testing is underway. Generally working but I do have a couple of fails
> > I'm looking into:
> >
> >  > FAIL xen-4.1.2-rc3-pre_domU-pv_xl_linux-2.6.39-x86_64.tar.bz2
>                             ^^^^^^^
>
> Is this a PV DomU xc_core style dump? If so, then it has never been
> supported by makedumpfile, because the file format is very different,
> with no program headers, but a special section called ".xen_pages". In
> fact, the file format itself does not cover this type of dump.

Ahhh... IIRC, you are right. Thanks for pointing this out. Eric, please
double check it and if PV __GUESTS__ are not supported by makedumpfile
skip tests for them. Just test dom0 and Xen hypervisor stuff.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
