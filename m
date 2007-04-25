Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv1.oss.ntt.co.jp ([222.151.198.98])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgh5Y-0000Wx-4v
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:59:17 -0400
Subject: Re: [PATCH 1/10] safe_apic_wait_icr_idle - i386
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <15716.1177505701@ocs3.ocs.com.au>
References: <15716.1177505701@ocs3.ocs.com.au>
Date: Wed, 25 Apr 2007 21:59:14 +0900
Message-Id: <1177505954.19745.22.camel@sebastian.intellilink.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Keith Owens <kaos@ocs.com.au>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, akpm@linux-foundation.org

On Wed, 2007-04-25 at 22:55 +1000, Keith Owens wrote:
> Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Wed, 25 Apr 2007 20:13:28 +0900) wrote:
> >+static __inline__ unsigned long safe_apic_wait_icr_idle(void)
> >+{
> >+	unsigned long send_status;
> >+	int timeout;
> >+
> >+	timeout = 0;
> >+	do {
> >+		udelay(100);
> >+		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
> >+	} while (send_status && (timeout++ < 1000));
> >+
> >+	return send_status;
> >+}
> >+
> 
> safe_apic_wait_icr_idle() as coded guarantees a minimum 100 usec delay
> before sending the IPI, this extra delay is unnecessary.  Change it to
Hi Keith,

Thank you for the feedback!

> 	do {
> 		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
> 		if (send_status)
> 			break;
> 		udelay(100);
> 	} while (timeout++ < 1000);
Oops, that is a good point. I will resend this patch either tonight or
tomorrow morning.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
