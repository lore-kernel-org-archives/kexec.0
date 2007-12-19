Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=outbound2-wa4-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4s0Z-0000ln-4F
	for kexec@lists.infradead.org; Wed, 19 Dec 2007 06:02:26 +0000
Message-ID: <4768B3E2.8070804@am.sony.com>
Date: Tue, 18 Dec 2007 22:02:10 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] Enable building a 32 bit binary for ppc64 platforms.
References: <1197967675.855616.615518870292.1.gpush@pokey>
In-Reply-To: <1197967675.855616.615518870292.1.gpush@pokey>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On 12/18/2007 12:47 AM, Jeremy Kerr wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> 
> Based on
> http://cvs.fedora.redhat.com/viewcvs/rpms/kexec-tools/devel/kexec-tools-1.101-ppc-boots-ppc64.patch?rev=1.2&view=auto
> 
> 64 bit: OK
> 32 bit: purgatory build fails
> 
> Work-in-progress-by: Geoff Levand <geoffrey.levand@am.sony.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

I think we need to clean these commit comments up.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
