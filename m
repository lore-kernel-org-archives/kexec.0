Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R1Fiw-0004wY-JT
	for kexec@lists.infradead.org; Wed, 07 Sep 2011 10:51:19 +0000
Date: Wed, 7 Sep 2011 17:49:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Add --append option for s390
Message-ID: <20110907084904.GA3516@verge.net.au>
References: <1315384970.7763.5.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1315384970.7763.5.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 07, 2011 at 10:42:50AM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> All architectures define the "--append" option together with the
> "--command-line" option to specify kernel parameters. This option
> is also used by kdump init scripts. In order to be compatible this
> patch introduces the "--append" option also for s390. In addition
> to that the help text is adjusted so that it is now the same as on
> all other architectures.

Thanks, that looks good to me.

I have applied it to my local tree and push it once master.kernel.org
is available again.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
