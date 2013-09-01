Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from perches-mx.perches.com ([206.117.179.246] helo=labridge.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGDA8-0008Lr-N9
 for kexec@lists.infradead.org; Sun, 01 Sep 2013 19:18:17 +0000
Message-ID: <1378063070.1953.10.camel@joe-AO722>
Subject: Re: [PATCH] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
From: Joe Perches <joe@perches.com>
Date: Sun, 01 Sep 2013 12:17:50 -0700
In-Reply-To: <1378062731-7026-1-git-send-email-lkundrak@v3.sk>
References: <1378062731-7026-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
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
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Sun, 2013-09-01 at 21:12 +0200, Lubomir Rintel wrote:
> Symbol name changed with the following commit:
> 62e32ac printk: rename struct log to struct printk_log

Thanks, I figured it would change/break something somewhere
but I had no idea where.

cheers, Joe



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
