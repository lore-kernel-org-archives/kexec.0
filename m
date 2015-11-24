Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a17di-0000tp-M7
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 07:03:47 +0000
Date: Tue, 24 Nov 2015 16:03:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] kexec/fs2dt: check for /chosen/stdout-path first
Message-ID: <20151124070324.GF2632@verge.net.au>
References: <1448040714-19841-1-git-send-email-drjones@redhat.com>
 <1448040714-19841-5-git-send-email-drjones@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448040714-19841-5-git-send-email-drjones@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Jones <drjones@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Nov 20, 2015 at 12:31:54PM -0500, Andrew Jones wrote:
> Check /chosen/stdout-path first, as linux,stdout-path is deprecated.
> I don't know how the ppc64:my_debug thing works, but on arm the warning
> "Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
> from purgatory is diabled" is output when loading a kexec kernel. This
> patch at least suppresses that when /chosen/stdout-path exists, and
> maybe it even enables printing from purgatory?
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
