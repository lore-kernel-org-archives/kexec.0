Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oo40W-00087L-1H
	for kexec@lists.infradead.org; Wed, 25 Aug 2010 00:38:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20100825002258.GD28360@kryten>
Date: Tue, 24 Aug 2010 17:37:57 -0700
In-Reply-To: <20100825002258.GD28360@kryten> (Anton Blanchard's message of
	"Wed, 25 Aug 2010 10:22:58 +1000")
Message-ID: <m139u37cii.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Anton Blanchard <anton@samba.org>
Cc: benh@kernel.crashing.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Anton Blanchard <anton@samba.org> writes:

> On ppc64 the crashkernel region almost always overlaps an area of firmware.
> This works fine except when using the sysfs interface to reduce the kdump
> region. If we free the firmware area we are guaranteed to crash.

That is ppc64 bug.  firmware should not be in the reserved region.  Any
random kernel like thing can be put in to that region at any valid
address and the fact that shrinking the region frees your firmware means
that using that region could also stomp your firmware (which I assume
would be a bad thing).

So please fix the ppc64 reservation.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
