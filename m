Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8dE-0048Og-9g
 for kexec@lists.infradead.org; Wed, 20 Oct 2021 10:15:37 +0000
Date: Wed, 20 Oct 2021 12:15:31 +0200
From: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] crash_dump: fix boolreturn.cocci warning
Message-ID: <20211020101531.GA22371@kernel.org>
References: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
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
To: cgel.zte@gmail.com
Cc: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

On Wed, Oct 20, 2021 at 08:39:05AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./include/linux/crash_dump.h: 119: 50-51: WARNING: return of 0/1 in
> function 'is_kdump_kernel' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
