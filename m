Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IY86u-00057K-IQ
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 18:33:42 -0400
Date: Wed, 19 Sep 2007 15:33:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/7] Use extended crashkernel command line on x86_64
Message-Id: <20070919153329.cfe714e3.akpm@linux-foundation.org>
In-Reply-To: <20070913161429.387888398@strauss.suse.de>
References: <20070913161428.343951643@strauss.suse.de>
	<20070913161429.387888398@strauss.suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 13 Sep 2007 18:14:31 +0200
Bernhard Walle <bwalle@suse.de> wrote:

> +#ifdef CONFIG_KEXEC
> +static inline void reserve_crashkernel(void)
> +{

The x86_64 function was made inline, so it will actually end up in
.text.init.  But the i386 equivalent function was not inlined so I'm not
sure whether it will end up in .text or in .text.init.

Could you fix all that up please?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
