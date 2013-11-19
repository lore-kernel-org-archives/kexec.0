Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViZ97-0002aU-Ft
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 00:26:26 +0000
Date: Tue, 19 Nov 2013 09:26:00 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND] kexec/ppc64: use common architecture fs2dt.c file
Message-ID: <20131119002600.GA16257@verge.net.au>
References: <20131115145533.24527.87606.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131115145533.24527.87606.stgit@nimbus>
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

On Fri, Nov 15, 2013 at 03:55:33PM +0100, Laurent Dufour wrote:
> Following the commit 'b3c2962 fs2dt: Add a generic copy of fs2dt' which
> introduced a generic fs2dt file, this patch is removing the ppc64
> architecture's one.
> 
> Tests have been done successfully on Power 7 plateform.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
