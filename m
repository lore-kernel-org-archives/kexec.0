Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bonJ1-0005L4-R0
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 08:00:01 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4189FAB9F
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 07:59:37 +0000 (UTC)
Date: Tue, 27 Sep 2016 09:59:36 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: Limitations/gotchas of kexec?
Message-ID: <20160927095936.1a395912@hananiah.suse.cz>
In-Reply-To: <fb9324e7-61a9-a22f-b6f4-250336f6092c@clifhouck.com>
References: <fb9324e7-61a9-a22f-b6f4-250336f6092c@clifhouck.com>
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

On Mon, 26 Sep 2016 15:19:50 -0500
Clif Houck <me@clifhouck.com> wrote:

> Hi all,
> 
> I was wondering if there's a known list of limitations of kexec?
> 
> For example, is there anything fundamentally wrong with trying to kexec
> from kernel version X to kernel version Y where:
> 1) version Y > version X
> 2) X < Y
> 3) X == Y
> 
> I wouldn't expect to have an issue in case 1 or 3. But maybe if the
> distance between two kernel versions is too great then I would have a
> problem? Is there any concept of explicit incompatibility between
> different kernels coupled with kexec or is it just 'try-and-see'?
> 
> Are there other important things to look out for?

On x86, I can think of one problematic point, and that's limitations of
the boot protocol, which may prevent booting an older kernel from a
high physical memory location. This can be solved if you load the kexec
kernel low enough. For real old kernels you may have to go through
32-bit code, or even 16-bit real-mode code.

Mostly, it's not a matter of inherent incompatibilities between the
kernels, but rather finding a combination of options that work for the
target kernel.

I don't have exact kernel versions and their requirements,
unfortunately.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
