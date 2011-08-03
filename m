Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob6.rzone.de ([2a01:238:20a:202:53f0::1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QofSV-000558-6B
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 17:42:19 +0000
Received: from probook.site
	(dslb-084-057-077-220.pools.arcor-ip.net [84.57.77.220])
	by smtp.strato.de (cohen mo36) (RZmta 26.2)
	with (DHE-RSA-AES256-SHA encrypted) ESMTPA id x00abfn73GFMtu
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 19:41:59 +0200 (MEST)
Date: Wed, 3 Aug 2011 19:41:59 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] fix Xen detection for xenfs in pv_ops kernel
Message-ID: <20110803174158.GA21782@aepfle.de>
References: <20110803171923.GA21404@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110803171923.GA21404@aepfle.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Wed, Aug 03, Olaf Hering wrote:

> +	"push "R(a)"; push "R(b)"; push "R(c)"; push "R(d)"\n\t"

That deserves a proper #ifdef, sorry for that.

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
