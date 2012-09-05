Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9Esl-0005C9-0b
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 12:39:00 +0000
Date: Wed, 5 Sep 2012 21:38:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Message-ID: <20120905123850.GA11453@verge.net.au>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew Leach <matthew.leach@arm.com>
Cc: will.deacon@arm.com, kexec@lists.infradead.org

On Wed, Sep 05, 2012 at 12:43:59PM +0100, Matthew Leach wrote:
> Hi all,
> 
> Running a kexec() on newer ARM platforms has become an issue as
> information about the platform that is presented via device-tree is
> required to boot a new kernel.
> 
> The ATAGs kernel code is re-used, replacing the ATAGs with a
> device-tree blob so that only kexec-tools needs to be changed. There
> are two options for generating a dtb to be passed to the kernel from
> kexec-tools: 1) Read in the device-tree that is exposed in
> /proc/device-tree and flatten this out into a dtb.  2) Allow the user
> to specify a dtb file on the command line.  These blobs are then
> loaded into memory before the kernel image and the address passed
> through to r2, as stated in the ARM booting documentation.

Hi Matt,

are you aware that I posted patches to add ARM DT support
to kexec-tools a few weeks ago?

I'm not particularly concerned which version goes in,
but perhaps we can learn from each others efforts.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
