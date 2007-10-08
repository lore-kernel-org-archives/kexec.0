Return-path: <kexec-bounces@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IehV5-0001YV-Ld
	for kexec@lists.infradead.org; Mon, 08 Oct 2007 02:33:44 +0100
Received: from natsuko.shinjuku.tokyo.vergenet.net
	(91.13.168.202.dial.dynamic.acc11-kent-syd.comindico.com.au
	[202.168.13.91])
	by koto.vergenet.net (Postfix) with ESMTP id E137934077
	for <kexec@lists.infradead.org>; Mon,  8 Oct 2007 10:11:26 +0900 (JST)
Date: Mon, 8 Oct 2007 11:11:19 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Use fclose() to close the file pointer
Message-ID: <20071008011104.GI2497@verge.net.au>
References: <20071006184138.GA16948@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071006184138.GA16948@suse.de>
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
Errors-To: kexec-bounces@lists.infradead.org
To: kexec@lists.infradead.org

On Sat, Oct 06, 2007 at 08:41:38PM +0200, Bernhard Walle wrote:
> Just use fclose() instead of close() to close a pointer of type FILE *.
> That fixes the compile warning
> 
> kexec/kexec.c: In function 'check_reuse_initrd':
> kexec/kexec.c:793: warning: passing argument 1 of 'close' makes integer from pointer without a cast

Thanks Bernhard, I have applied this change.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
