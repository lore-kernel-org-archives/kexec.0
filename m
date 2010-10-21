Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P91jO-0000Om-0T
	for kexec@lists.infradead.org; Thu, 21 Oct 2010 20:27:32 +0000
Message-ID: <4CC0A204.4060403@zytor.com>
Date: Thu, 21 Oct 2010 13:26:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] Bug during kexec...not all cpus are stopped
References: <1286570087.8769.27.camel@ank32.eng.vmware.com>	
	<1286816964.1372.2.camel@ank32.eng.vmware.com>	
	<m1lj64ppri.fsf@fess.ebiederm.org>	
	<1286826083.1372.15.camel@ank32.eng.vmware.com>	
	<20101011213901.GR12743@redhat.com>
	<m1hbgs5qkc.fsf@fess.ebiederm.org>	
	<20101012221717.GA27478@redhat.com>	
	<1286929430.15658.30.camel@ank32.eng.vmware.com>
	<1287688156.27008.13.camel@ank32.eng.vmware.com>
In-Reply-To: <1287688156.27008.13.camel@ank32.eng.vmware.com>
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
To: akataria@vmware.com
Cc: "jeremy@xensource.com" <jeremy@xensource.com>, Daniel Hecht <dhecht@vmware.com>, the arch/x86 maintainers <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On 10/21/2010 12:09 PM, Alok Kataria wrote:
> 
> I don't think this patch was picked up for tip, now that the 2.6.37
> merge window is open can you please pick this up push it upstream.
> This patch fixes a legitimate regression, which was introduced during
> 2.6.30, by commit id 4ef702c10b5df18ab04921fc252c26421d4d6c75.
> 

It probably would have helped if the patch had had a proper patch header
and so on, and *in particular* not buried in a tree with [RFC PATCH].
RFC strongly implies that the patch is intended as a base for
discussion, and is explicitly not intended to be committed.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
