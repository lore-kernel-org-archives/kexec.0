Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TdAvY-0005BW-Hh
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 02:29:37 +0000
Date: Tue, 27 Nov 2012 11:29:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] fs2dt: fix basename string compares
Message-ID: <20121127022934.GG13206@verge.net.au>
References: <1353932083-8710-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353932083-8710-1-git-send-email-zonque@gmail.com>
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

On Mon, Nov 26, 2012 at 01:14:42PM +0100, Daniel Mack wrote:
> basename is initialized as
> 
>   basename = strrchr(pathname,'/') + 1;
> 
> and does hence not contain the leading slash character.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
