Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMo1Y-0003j6-PM
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 23:52:42 +0000
Date: Thu, 19 Sep 2013 13:54:14 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] .gitignore: Only ignore generated autotools files in
 the top directory
Message-ID: <20130919205414.GC2918@verge.net.au>
References: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
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

On Tue, Sep 17, 2013 at 10:37:08AM +0200, Geert Uytterhoeven wrote:
> E.g. all other Makefiles are handmade, but git complains when adding a
> new kexec/arch/*/Makefile file.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
