Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HghMh-0000go-SY
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 09:17:01 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/10] safe_apic_wait_icr_idle - i386
Date: Wed, 25 Apr 2007 15:16:56 +0200
References: <15716.1177505701@ocs3.ocs.com.au>
In-Reply-To: <15716.1177505701@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704251516.56333.ak@suse.de>
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
Cc: Fernando Luis =?iso-8859-1?q?V=E1zquez_Cao?= <fernando@oss.ntt.co.jp>, vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, akpm@linux-foundation.org


> 
> 	do {
> 		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
> 		if (send_status)

Surely if (!send_status)

> 			break;
> 		udelay(100);
> 	} while (timeout++ < 1000);

-Andi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
