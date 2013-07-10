Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com
 ([213.199.154.248] helo=db9outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwzT4-0004ih-6J
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 18:50:22 +0000
Message-ID: <51DDACCC.7000705@genband.com>
Date: Wed, 10 Jul 2013 12:49:48 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
Subject: kexec -p and initrd
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org

Hi,

I'm trying to figure something out but the man pages seem a bit 
ambiguous.  If I specify the "--initrd" option when loading a kernel for 
use on panic, does the initrd get copied into kernel memory at that 
point or does it get loaded from the specified path after the panic when 
the new kernel is booting?

I'll take a look at the code, but I thought it'd be quicker if someone 
already knew the answer.

Thanks,
Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
