Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from shell.v3.sk ([195.168.3.45])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGE2D-0000eR-HJ
 for kexec@lists.infradead.org; Sun, 01 Sep 2013 20:14:10 +0000
Date: Sun, 1 Sep 2013 22:13:26 +0200 (CEST)
From: Lubomir Rintel <lkundrak@v3.sk>
Message-ID: <1010964127.3724.1378066406795.JavaMail.zimbra@v3.sk>
In-Reply-To: <1378063070.1953.10.camel@joe-AO722>
References: <1378062731-7026-1-git-send-email-lkundrak@v3.sk>
 <1378063070.1953.10.camel@joe-AO722>
Subject: Re: [PATCH] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
MIME-Version: 1.0
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
To: Joe Perches <joe@perches.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Sunday, September 1, 2013 9:17:50 PM, Joe Perches wrote:
> On Sun, 2013-09-01 at 21:12 +0200, Lubomir Rintel wrote:
> > Symbol name changed with the following commit:
> > 62e32ac printk: rename struct log to struct printk_log
> 
> Thanks, I figured it would change/break something somewhere
> but I had no idea where.

I thought it was intentional. Other change where this broke was makedumpimage, see another patch I've sent to the list a short while ago and Cc'd to you.

In case the changes are going to be backed off please disregard those patches.

Thank you!
Lubo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
