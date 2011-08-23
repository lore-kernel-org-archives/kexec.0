Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qvkyr-000360-MI
	for kexec@lists.infradead.org; Tue, 23 Aug 2011 07:01:02 +0000
Date: Tue, 23 Aug 2011 15:59:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec:ppc: Fix compilation failure
Message-ID: <20110823065947.GA26169@verge.net.au>
References: <20110823061020.14928.83952.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110823061020.14928.83952.stgit@suzukikp.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Josh Boyer <jwboyer@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Aug 23, 2011 at 11:40:40AM +0530, Suzuki K. Poulose wrote:
> commit 1ea7cfd435aba0e095886db367e9616271f56c28 broke the ppc build as it removes
> the declaration for two variables in use by the elf_ppc_load(). This patch reverts
> the particular hunk.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Reported-by: Josh Boyer <jwboyer@gmail.com>

Sorry about that, I have pushed your change.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
