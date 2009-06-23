Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIyyq-0000HQ-92
	for kexec@lists.infradead.org; Tue, 23 Jun 2009 05:55:46 +0000
Date: Tue, 23 Jun 2009 00:55:36 -0500
From: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
Message-ID: <20090623055536.GE6865@sgi.com>
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com> <4A4022EA.1020506@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A4022EA.1020506@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Robin Holt <holt@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jun 23, 2009 at 09:33:46AM +0900, Hidetoshi Seto wrote:
> Robin Holt wrote:
...
> Do you mean that the 2nd kernel should be able to handle MCA/INIT from its
> boot up?  I guess the word PROM is nearly equal to PAL/SAL firmware, if so
> then I don't think there are good generic interface/procedure could be
> useful here.  Do you have any concrete idea?

No concrete ideas.  Just a really uneasy feeling whenever the INIT
is disabled.

On SGI's ia64 servers, when the INIT is first received, our PROM (PAL/SAL)
records the processors state.  This record remains for the next reset
or for salinfo to transfer to disk.  We can dump all the records in a
format somewhat similar to the output in /var/log/salinfo/decoded.

On more occasions than I could even begin to describe, those records
have helped us determine what the processor was doing despite it even
ignoring interrupts.  This includes everything except when MCA/INIT
handling is disabled or PMIs are being processed.

If you could give this some consideration, I would appreciate it.
I really don't have the time to dedicate to thinking all the way through
and therefore will not stand in the way of any patch you propose.
If I can be of help in any way, please let me know.

Thanks,
Robin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
