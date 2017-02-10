Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ccDMM-0003Cj-7v
 for kexec@lists.infradead.org; Fri, 10 Feb 2017 15:43:44 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A6C5BAB9D
 for <kexec@lists.infradead.org>; Fri, 10 Feb 2017 15:43:14 +0000 (UTC)
Date: Fri, 10 Feb 2017 16:43:13 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: kexec on panic
Message-ID: <20170210164313.5fe98b75@hananiah.suse.cz>
In-Reply-To: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
References: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Fri, 10 Feb 2017 10:14:02 +0200
Denys Fedoryshchenko <nuclearcat@nuclearcat.com> wrote:

> Hello,
> 
> After years of using kexec and recent unpleasant experience with modern 
> (supposed to be blazing fast to boot) hardware that need 5-10 minutes 
> just to pass POST tests,
> one question came up to me:
> Is it possible anyhow to execute regular (not special "panic" one to 
> capture crash data) kexec on panic to reduce reboot time?

No. But you can load a specially crafted panic initrd which kexec's
back to the production kernel.

HTH,
Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
