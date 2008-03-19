Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbmCC-00024d-Pb
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 00:30:21 +0000
Date: Tue, 18 Mar 2008 20:30:19 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: force a dump on a hung system?
Message-ID: <20080319003019.GA24311@hmsendeavour.rdu.redhat.com>
References: <47DFFB45.3060106@sgi.com> <frovcv$lss$1@ger.gmane.org>
	<47E01E6E.2090809@redhat.com> <47E029E3.4050101@sgi.com>
	<20080318204857.GB12533@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080318204857.GB12533@suse.de>
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
To: Jay Lan <jlan@sgi.com>, Ben Woodard <woodard@redhat.com>, kexec@lists.infradead.org

On Tue, Mar 18, 2008 at 09:48:57PM +0100, Bernhard Walle wrote:
> * Jay Lan <jlan@sgi.com> [2008-03-18 21:45]:
> > BTW, the SYSRQ_ENABLED in /etc/sysconfig/sysctl is not set
> > by default. Any bad side effect of setting it?
> 
> AFAIR security concerns.
> 
> May I ask how RedHat/Fedora handles that?
> 
> 
With defaults IIRC. We have them enabled during boot (in case of a problem on
bootup, disable them in rc.sysinit).  /proc/sysrq-trigger is always available
though, and protected via filesystem permissions
Neil

>         Bernhard
> 
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
