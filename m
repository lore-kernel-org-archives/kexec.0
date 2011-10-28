Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from linux-sh.org ([111.68.239.195])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJfa0-0001W8-6Q
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 06:06:13 +0000
Date: Fri, 28 Oct 2011 15:05:59 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: kexec: Add PHYSICAL_START
Message-ID: <20111028060559.GB32187@linux-sh.org>
References: <1316085180-4215-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316085180-4215-1-git-send-email-horms@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linux-sh@vger.kernel.org

On Thu, Sep 15, 2011 at 08:13:00PM +0900, Simon Horman wrote:
> Add PHYSICAL_START kernel configuration parameter to set the address at
> which the kernel should be loaded.
> 
> It has been observed on an sh7757lcr that simply modifying MEMORY_START
> does not achieve this goal for 32bit sh. This is due to MEMORY_OFFSET in
> arch/sh/kernel/vmlinux.lds.S bot being based on MEMORY_START on such
> systems.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

No one seems to have complained about this, so I've applied it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
