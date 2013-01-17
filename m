Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TvzL5-0004xB-Vb
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 23:57:44 +0000
Date: Fri, 18 Jan 2013 08:57:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: update x86_linux_header
Message-ID: <20130117235740.GG16740@verge.net.au>
References: <1358448445-27576-1-git-send-email-olaf@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1358448445-27576-1-git-send-email-olaf@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Jan 17, 2013 at 07:47:25PM +0100, Olaf Hering wrote:
> Update struct x86_linux_header with new fields, based on
> arch/x86/include/asm/bootparam.h as included in linux-3.7.
> Upcoming changes will use the payload_offset/payload_length fields.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
