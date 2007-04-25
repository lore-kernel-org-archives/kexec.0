Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hggh4-0008Ur-4e
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:34:02 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 10/10] Use safe_apic_wait_icr_idle in
	__send_IPI_dest_field - x86_64
Date: Wed, 25 Apr 2007 14:33:40 +0200
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
	<1177501872.17974.56.camel@sebastian.intellilink.co.jp>
In-Reply-To: <1177501872.17974.56.camel@sebastian.intellilink.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704251433.40302.ak@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?iso-8859-15?q?V=E1zquez_Cao?= <fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org

On Wednesday 25 April 2007 13:51:12 Fernando Luis V=E1zquez Cao wrote:
> Use safe_apic_wait_icr_idle to check ICR idle bit if the vector is
> NMI_VECTOR to avoid potential hangups in the event of crash when kdump
> tries to stop the other CPUs.

But what happens then when this fails? Won't this give another hang?
Have you tested this?

I applied the patches for now.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
