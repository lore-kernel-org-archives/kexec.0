Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwzbA-0004xA-4s
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 18:58:44 +0000
Date: Wed, 10 Jul 2013 14:58:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec -p and initrd
Message-ID: <20130710185820.GM5819@redhat.com>
References: <51DDACCC.7000705@genband.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DDACCC.7000705@genband.com>
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
To: Chris Friesen <chris.friesen@genband.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org

On Wed, Jul 10, 2013 at 12:49:48PM -0600, Chris Friesen wrote:
> Hi,
> 
> I'm trying to figure something out but the man pages seem a bit
> ambiguous.  If I specify the "--initrd" option when loading a kernel
> for use on panic, does the initrd get copied into kernel memory at
> that point or does it get loaded from the specified path after the
> panic when the new kernel is booting?

Yes, it gets loaded in kernel memory once kexec -p returns successfuly.

For more internals, have a look at.

http://lse.sourceforge.net/kdump/documentation/ols2oo5-kdump-paper.pdf

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
