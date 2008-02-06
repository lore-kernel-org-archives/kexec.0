Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMqpn-0005Je-JZ
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 20:25:38 +0000
Message-ID: <47AA16CA.6000003@zytor.com>
Date: Wed, 06 Feb 2008 12:21:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in die_nmi
	path
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206194040.GA11886@redhat.com>
	<20080206201223.GA25183@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20080206201223.GA25183@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

Neil Horman wrote:
> Can an APIC accept an NMI while already handling an NMI?  I didn't think they
> would interrupt one another, but rather, pend until such time as the previous
> NMI was cleared

The CPU certainly won't (there is a hidden flag that's cleared on IRET 
which disables NMI; it's possible to re-enable NMI by executing a dummy 
IRET inside the NMI handler.)

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
