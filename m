Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCh2Q-0006mF-Pr
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:51:31 +0000
Date: Tue, 5 Mar 2013 10:51:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: lengthen the kernel command line image
Message-ID: <20130305015127.GA28547@verge.net.au>
References: <E1U2S71-00057C-Hj@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1U2S71-00057C-Hj@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Mon, Feb 04, 2013 at 01:53:55PM -0600, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> The crash kernel's boot command line is not long enough to contain the
> necessary memmap= options for a large memory.
> 
> The fix is simple, as long as the boot loader's command line is also long enough.
> I'm not sure about boot loader or kernel restrictions to this length.
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
