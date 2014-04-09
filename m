Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WY1au-0005W3-Ei
 for kexec@lists.infradead.org; Wed, 09 Apr 2014 23:07:49 +0000
Date: Thu, 10 Apr 2014 08:07:21 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RESEND PATCH] ppc64/purgatory: Disabling GCC's stack protection
Message-ID: <20140409230721.GA2187@verge.net.au>
References: <20140325095553.17118.47384.stgit@nimbus>
 <20140408144445.3929.88414.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140408144445.3929.88414.stgit@nimbus>
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
Cc: dvaleev@suse.com, kexec@lists.infradead.org

On Tue, Apr 08, 2014 at 04:44:45PM +0200, Laurent Dufour wrote:
> Some Linux distributions, like Suse, are turning on the GCC's stack
> protection mechanism by default (-fstack-protector). When building the
> purgatory with this option, this leads to link issues that are revealed at
> runtime when the purgatory is loaded because symbols like __stack_chk_fail
> are unresolved.
> 
> This patch forces this stack protection mechanism to be turned off when
> building the purgatory on ppc64 BE and LE.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
