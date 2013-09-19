Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMo1Y-0003j3-K0
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 23:52:42 +0000
Date: Thu, 19 Sep 2013 13:56:40 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] kexec/kexec.c: Prefix hex numbers by 0x
Message-ID: <20130919205640.GF2918@verge.net.au>
References: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
 <1379407031-5466-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379407031-5466-4-git-send-email-geert@linux-m68k.org>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kexec@lists.infradead.org

On Tue, Sep 17, 2013 at 10:37:11AM +0200, Geert Uytterhoeven wrote:
> It's confusing that some pointers are printed as hex numbers prefixed with
> 0x, while some other values are printed as hex numbers without prefixes.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
