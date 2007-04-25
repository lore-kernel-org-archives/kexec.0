Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.ocs.com.au ([203.34.248.175])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgh1c-0000T4-BK
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:55:13 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH 1/10] safe_apic_wait_icr_idle - i386 
In-reply-to: Your message of "Wed, 25 Apr 2007 20:13:28 +0900."
	<1177499608.17974.9.camel@sebastian.intellilink.co.jp> 
Mime-Version: 1.0
Date: Wed, 25 Apr 2007 22:55:01 +1000
Message-ID: <15716.1177505701@ocs3.ocs.com.au>
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
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, akpm@linux-foundation.org

Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Wed, 25 Apr 2007 20:13:28 +0900) wrote:
>+static __inline__ unsigned long safe_apic_wait_icr_idle(void)
>+{
>+	unsigned long send_status;
>+	int timeout;
>+
>+	timeout = 0;
>+	do {
>+		udelay(100);
>+		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
>+	} while (send_status && (timeout++ < 1000));
>+
>+	return send_status;
>+}
>+

safe_apic_wait_icr_idle() as coded guarantees a minimum 100 usec delay
before sending the IPI, this extra delay is unnecessary.  Change it to

	do {
		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
		if (send_status)
			break;
		udelay(100);
	} while (timeout++ < 1000);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
