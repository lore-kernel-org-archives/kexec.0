Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnhN8-0000lW-8A
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 04:14:07 +0000
Date: Tue, 3 Dec 2013 13:13:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] kexec-tools: Minor Xen fixes and cleanups
Message-ID: <20131203041340.GE1864@verge.net.au>
References: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, kexec@lists.infradead.org, david.vrabel@citrix.com, xen-devel@lists.xen.org

On Mon, Dec 02, 2013 at 08:06:23PM +0100, Daniel Kiper wrote:
> Hi,
> 
> This patch series contains following minor Xen fixes and cleanups for kexec-tools:
>   - kexec-tools/xen: Do not call xc_interface_close() if xc_interface_open() failed,
>   - kexec-tools/xen: Remove redundant include.
> 
> Please apply.

Thanks, both applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
