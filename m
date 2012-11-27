Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TdAw1-0005Cs-J0
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 02:30:06 +0000
Date: Tue, 27 Nov 2012 11:30:02 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] fs2dt: check for initrd_size != 0 when adding initrd
 entries
Message-ID: <20121127023002.GH13206@verge.net.au>
References: <1353932083-8710-1-git-send-email-zonque@gmail.com>
 <1353932083-8710-2-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353932083-8710-2-git-send-email-zonque@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: s.neumann@raumfeld.com, kexec@lists.infradead.org

On Mon, Nov 26, 2012 at 01:14:43PM +0100, Daniel Mack wrote:
> This prevents the creation of chosen/linux,initrd-{start,stop} entries
> with zero length.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
