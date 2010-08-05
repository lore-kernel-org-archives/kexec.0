Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ogpox-0002VC-0E
	for kexec@lists.infradead.org; Thu, 05 Aug 2010 02:04:36 +0000
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile
	to filter core files properly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20100804144929.GA13970@hmsreliant.think-freely.org>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
	<20100804144929.GA13970@hmsreliant.think-freely.org>
Date: Thu, 05 Aug 2010 12:04:26 +1000
Message-ID: <1280973866.1902.168.camel@pasglop>
Mime-Version: 1.0
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, paulus@samba.org, vgoyal@redhat.com

On Wed, 2010-08-04 at 10:49 -0400, Neil Horman wrote:
> Ping yet again. Ben, This needs review/acceptance from you or Paul
> Neil 

Isn't it already in powerpc-next about to be pulled by Linus ?

In general, I recommend you check the status of your patches on
patchwork. I'm nagging Jeremy to add a feature so it emails the
submitter when the patch status changes :-)

Cheers,
Ben.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
