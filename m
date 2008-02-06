Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JMrRF-0001L2-7q
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 21:04:19 +0000
Date: Wed, 6 Feb 2008 16:04:07 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH],
	issue EOI to APIC prior to calling crash_kexec in die_nmi path
Message-ID: <20080206210407.GB25183@hmsendeavour.rdu.redhat.com>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206194040.GA11886@redhat.com>
	<20080206201223.GA25183@hmsendeavour.rdu.redhat.com>
	<47AA16CA.6000003@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47AA16CA.6000003@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 06, 2008 at 12:21:30PM -0800, H. Peter Anvin wrote:
> Neil Horman wrote:
> >Can an APIC accept an NMI while already handling an NMI?  I didn't think 
> >they
> >would interrupt one another, but rather, pend until such time as the 
> >previous
> >NMI was cleared
> 
> The CPU certainly won't (there is a hidden flag that's cleared on IRET 
> which disables NMI; it's possible to re-enable NMI by executing a dummy 
> IRET inside the NMI handler.)
> 
> 	-hpa

So that would be another solution I would expect.  Would you rather I
investigate that, or is the proposed solution more reasonable?

Neil


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
