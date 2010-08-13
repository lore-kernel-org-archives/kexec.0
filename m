Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjrsZ-0001fs-Az
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 10:52:52 +0000
Date: Fri, 13 Aug 2010 06:48:06 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [Resend][Patch v2] kexec: increase max of kexec segments and use
	dynamic allocation
Message-ID: <20100813104806.GA6077@hmsreliant.think-freely.org>
References: <20100813054314.5564.21503.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100813054314.5564.21503.sendpatchset@localhost.localdomain>
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
To: Amerigo Wang <amwang@redhat.com>
Cc: nhorman@redhat.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, ebiederm@xmission.com, akpm@linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Aug 13, 2010 at 01:38:54AM -0400, Amerigo Wang wrote:
> 
> Currently KEXEC_SEGMENT_MAX is only 16 which is too small for machine with
> many memory ranges.  When hibernate on a machine with disjoint memory we do
> need one segment for each memory region. Increase this hard limit to 16K
> which is reasonably large.
> 
> And change ->segment from a static array to a dynamically allocated memory.
> 
> Cc: Neil Horman <nhorman@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: WANG Cong <amwang@redhat.com>
> 
Concur with Simon

Reviewed-by: Neil Horman <nhorman@tuxdriver.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
