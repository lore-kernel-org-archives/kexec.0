Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W96YA-0006bh-HS
 for kexec@lists.infradead.org; Fri, 31 Jan 2014 05:21:58 +0000
Date: Fri, 31 Jan 2014 14:21:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RESEND PATCH] ppc64/kexec/purgatory Fix RTAS calls in Little
 Endian mode.
Message-ID: <20140131052136.GB25099@verge.net.au>
References: <20140130153203.12678.25147.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140130153203.12678.25147.stgit@nimbus>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Thu, Jan 30, 2014 at 04:32:03PM +0100, Laurent Dufour wrote:
> RTAS is expecting parameters in Big Endian order so we have to byte swap
> them in LE mode.
> 
> In the purgatory RTAS calls are only made for debug output.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
